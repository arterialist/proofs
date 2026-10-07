#!/usr/bin/env python3
"""Compile and test tiny core-only fixtures using an already installed Lean 4.34.1.

No Lake, network, install, cache retrieval, Mathlib or project proof build is run.
All temporary compilation happens inside this runner's fresh result directory.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import uuid
from datetime import datetime, timezone
from pathlib import Path

BASE = Path(__file__).resolve().parent
PASS = "UNCACHED_BODY_ALLOWLIST_PASS"
VERSION = "4.34.1"
BAD_PATH = (
    "BuildingBlocks.ExportedBad.exported -> ExternalFixture.forwarded -> "
    "ExternalFixture.relay -> _private.ExternalFixture.0.ExternalFixture.hidden -> "
    "ExternalFixture.forbidden"
)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def installed_compiler(argument: str | None) -> Path:
    """Find a trusted native executable; reject recognized elan shims before invocation."""
    elan_home = Path(os.environ.get("ELAN_HOME", str(Path.home() / ".elan"))).expanduser()
    binary = "lean.exe" if os.name == "nt" else "lean"
    elan_names = ("elan", "elan.exe")
    if argument:
        candidates = [Path(argument).expanduser()]
    else:
        candidates = [elan_home / "toolchains" / "leanprover--lean4---v4.34.1" / "bin" / binary]
        on_path = shutil.which(binary)
        if on_path:
            candidates.append(Path(on_path))
    elan_on_path = []
    for name in elan_names:
        path = shutil.which(name)
        if path:
            elan_on_path.append(Path(path))
    for candidate in candidates:
        if not candidate.is_file():
            continue
        resolved = candidate.resolve()
        shim_directory = (
            candidate.parent.resolve() == (elan_home / "bin").resolve()
            or (candidate.parent.name == "bin" and candidate.parent.parent.name == ".elan")
        )
        elan_candidates = [candidate.parent / name for name in elan_names]
        elan_candidates += [elan_home / "bin" / name for name in elan_names]
        elan_candidates += elan_on_path
        same_as_elan = any(
            path.is_file() and os.path.samefile(resolved, path)
            for path in elan_candidates
        )
        if shim_directory or same_as_elan or resolved.name in elan_names:
            if argument:
                raise RuntimeError("Pass a native toolchain/bin/lean executable, not an elan shim.")
            continue
        return resolved
    raise RuntimeError("An installed native Lean 4.34.1 executable is required; use --lean PATH.")


def write_json(path: Path, value: object) -> None:
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--lean", help="Already installed native Lean 4.34.1 executable.")
    parser.add_argument("--output-dir", type=Path, default=BASE / "audit-results",
                        help="Parent directory for a fresh receipt and temporary build directory.")
    args = parser.parse_args()
    run_id = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ") + "-" + uuid.uuid4().hex[:8]
    result_dir = args.output_dir.expanduser().resolve() / run_id
    result_dir.mkdir(parents=True, exist_ok=False)
    receipt_path = result_dir / "receipt.json"
    receipt: dict = {
        "schema": 1,
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "scope": "Loaded-body traversal and policy regressions on tiny core-only fixtures.",
        "limits": ["No kernel replay", "No source/binary comparison", "No standard-axiom identity proof",
                   "No Mathlib or RH proof compilation"],
        "commands_use_placeholders": {"$LEAN": "Native compiler bound by filename/hash/version below.",
                                      "$WORKDIR": "Fresh temporary task-owned compilation directory."},
        "records": [],
        "compiled_artifacts": [],
        "all_expectations_met": False,
        "audit_case_count": 11,
        "installs_network_lake_cache_mathlib": False,
    }
    try:
        source_names = ["UncachedBodyAudit.lean", "core-fixtures.json", "run_core_fixtures.py",
                        "lean-toolchain", "lakefile.toml", "SOURCE-PROVENANCE.json", "LICENSE", "README.md", ".gitignore",
                        "test_compiler_guard.py"]
        receipt["package_sources"] = [{"path": name, "bytes": (BASE / name).stat().st_size,
                                       "sha256": sha256(BASE / name)} for name in source_names]
        lean = installed_compiler(args.lean)
        receipt["compiler"] = {"native_filename": lean.name, "sha256": sha256(lean)}
        fixture_sources = json.loads((BASE / "core-fixtures.json").read_text(encoding="utf-8"))
        if not isinstance(fixture_sources, dict) or not all(
            isinstance(name, str) and isinstance(source, str) for name, source in fixture_sources.items()
        ):
            raise RuntimeError("Fixture source map must contain string paths and sources.")
        receipt["fixture_sources"] = [{"path": name, "sha256": hashlib.sha256(source.encode()).hexdigest()}
                                      for name, source in fixture_sources.items()]
        write_json(receipt_path, receipt)
        with tempfile.TemporaryDirectory(prefix="core-build-", dir=result_dir) as temporary:
            work = Path(temporary)
            env = dict(os.environ)
            for key in ("LEAN_PATH", "LEAN_SYSROOT", "LEAN_SRC_PATH", "LEAN_TOOLCHAIN"):
                env.pop(key, None)
            env["LEAN_PATH"] = str(work)
            env["PATH"] = str(lean.parent) + os.pathsep + env.get("PATH", "")

            def normalize(text: str) -> str:
                return text.replace(str(work), "$WORKDIR").replace(str(lean), "$LEAN")

            def run(name: str, arguments: list[str], *, expected_exit: int = 0,
                    required: tuple[str, ...] = (), forbidden: tuple[str, ...] = (),
                    probe_env: dict[str, str] | None = None, version_gate: bool = False) -> None:
                record: dict = {"name": name, "argv": ["$LEAN", *arguments],
                                "cwd": "$WORKDIR", "expected_exit": expected_exit,
                                "required_markers": list(required), "forbidden_markers": list(forbidden),
                                "lean_path": normalize((probe_env or env)["LEAN_PATH"])}
                try:
                    completed = subprocess.run([str(lean), *arguments], cwd=work, env=probe_env or env,
                                               text=True, capture_output=True, timeout=60)
                    output = completed.stdout + completed.stderr
                    marker_checks = {marker: marker in output for marker in required}
                    forbidden_checks = {marker: marker not in output for marker in forbidden}
                    version_ok = not version_gate or re.search(
                        r"^Lean \(version 4\.34\.1(?:,|\))", completed.stdout, re.MULTILINE
                    ) is not None
                    record.update(exit_code=completed.returncode, stdout=normalize(completed.stdout),
                                  stderr=normalize(completed.stderr), required_markers_found=marker_checks,
                                  forbidden_markers_absent=forbidden_checks, version_gate_met=version_ok,
                                  expectation_met=completed.returncode == expected_exit and version_ok
                                  and all(marker_checks.values()) and all(forbidden_checks.values()))
                    if version_gate:
                        receipt["compiler"]["version_output"] = completed.stdout.strip()
                except subprocess.TimeoutExpired as error:
                    record.update(expectation_met=False, failure="Compiler timeout after 60 seconds.",
                                  stdout=normalize(str(error.stdout or "")), stderr=normalize(str(error.stderr or "")))
                except OSError as error:
                    record.update(expectation_met=False, failure=str(error))
                receipt["records"].append(record)
                write_json(receipt_path, receipt)
                if not record["expectation_met"]:
                    raise RuntimeError(f"Unexpected outcome for {name}; inspect receipt.json.")

            # Version must match before staging or compiling any source.
            run("runtime-version", ["--version"], version_gate=True)
            shutil.copyfile(BASE / "UncachedBodyAudit.lean", work / "UncachedBodyAudit.lean")
            for relative, source in fixture_sources.items():
                relative_path = Path(relative)
                if relative_path.is_absolute() or ".." in relative_path.parts or relative_path.suffix != ".lean":
                    raise RuntimeError(f"Unsafe fixture source path: {relative}")
                destination = work / relative_path
                destination.parent.mkdir(parents=True, exist_ok=True)
                destination.write_text(source, encoding="utf-8")

            def compile_module(module: str) -> None:
                run("compile-" + module, ["-o", module + ".olean", module + ".lean"])
                artifacts = sorted(work.glob(module + ".*"))
                receipt["compiled_artifacts"].extend(
                    {"path": str(path.relative_to(work)), "bytes": path.stat().st_size, "sha256": sha256(path)}
                    for path in artifacts if path.suffix != ".lean" and path.is_file()
                )
                write_json(receipt_path, receipt)

            # The tested collector is compiled from this package first, not reused from private artifacts.
            compile_module("UncachedBodyAudit")
            for module in ("ExternalFixture", "ExternalFixtureGood", "BuildingBlocks/ExportedBad",
                           "BuildingBlocks/ExportedGood", "OtherProof/Root"):
                compile_module(module)
            run("good", ["AuditGood.lean"], required=(
                "UNCACHED_BODY_AXIOM_UNION [propext, Classical.choice, Quot.sound]",
                "UNCACHED_ROOT_PREFIX BuildingBlocks",
                "UNCACHED_ROOT_MODULES [BuildingBlocks.ExportedGood]; ROOT_COUNT 6;",
                "BODY_VISITED BuildingBlocks.ExportedGood OutsideNamespace.extra theorem",
                "DEPENDENCY_BODY_VISITED ExternalFixtureGood ExternalFixtureGood.relay opaque",
                "DEPENDENCY_BODY_VISITED ExternalFixtureGood _private.ExternalFixtureGood.0.ExternalFixtureGood.hidden theorem",
                "DEPENDENCY_BODY_VISITED ExternalFixtureGood _private.ExternalFixtureGood.0.ExternalFixtureGood.chosen._proof_1 theorem",
                PASS))
            run("external-forbidden-through-private-and-opaque", ["AuditBad.lean"], expected_exit=1,
                required=("FORBIDDEN_AXIOM_OR_ERASED_BODY: #[ExternalFixture.forbidden]", BAD_PATH,
                          "BODY_VISITED BuildingBlocks.ExportedBad BuildingBlocks.ExportedBad.exported theorem",
                          "DEPENDENCY_BODY_VISITED ExternalFixture ExternalFixture.relay opaque",
                          "DEPENDENCY_BODY_VISITED ExternalFixture _private.ExternalFixture.0.ExternalFixture.hidden theorem"),
                forbidden=(PASS,))
            negatives = (
                ("empty", "AuditEmpty.lean", ("EMPTY_ROOT_SCOPE",)),
                ("unresolved", "AuditMissing.lean", ("UNRESOLVED_CONSTANT_OR_BODY: Missing.Body",)),
                ("module-scope-mismatch", "AuditScope.lean", ("MODULE_SCOPE_MISMATCH: expected #[BuildingBlocks.ExportTypo], got #[BuildingBlocks.ExportedGood]",)),
                ("root-count-mismatch", "AuditCount.lean", ("ROOT_COUNT_MISMATCH: expected 5, got 6", "OutsideNamespace.extra")),
                ("resource-limit", "AuditLimit.lean", ("RESOURCE_LIMIT: reached 1 constants at BuildingBlocks.ExportedGood.extensional -> Iff",)),
                ("restricted-module-view", "AuditRestricted.lean", ("RESTRICTED_MODULE_VIEW",)),
            )
            for name, filename, markers in negatives:
                run(name, [filename], expected_exit=1, required=markers, forbidden=(PASS,))
            missing = work / "missing-private-part"
            missing.mkdir()
            for suffix in (".olean", ".olean.server"):
                shutil.copyfile(work / ("ExternalFixtureGood" + suffix), missing / ("ExternalFixtureGood" + suffix))
            missing_env = dict(env)
            missing_env["LEAN_PATH"] = str(missing) + os.pathsep + str(work)
            run("missing-private-artifact", ["AuditMissingParts.lean"], expected_exit=1,
                required=("failed to open file", "ExternalFixtureGood.olean.private"),
                forbidden=(PASS,), probe_env=missing_env)
            run("custom-module-prefix", ["AuditCustomPrefix.lean"], required=(
                "UNCACHED_BODY_AXIOM_UNION []", "UNCACHED_ROOT_PREFIX OtherProof",
                "UNCACHED_ROOT_MODULES [OtherProof.Root]; ROOT_COUNT 1;",
                "BODY_VISITED OtherProof.Root UnrelatedNamespace.throughOpaque theorem",
                "DEPENDENCY_BODY_VISITED ExternalFixtureGood ExternalFixtureGood.relay opaque",
                "DEPENDENCY_BODY_VISITED ExternalFixtureGood _private.ExternalFixtureGood.0.ExternalFixtureGood.hidden theorem",
                PASS))
            run("wrong-module-prefix", ["AuditWrongPrefix.lean"], expected_exit=1,
                required=("MODULE_SCOPE_MISMATCH: expected #[OtherProof.Root], got #[]",), forbidden=(PASS,))
            receipt["all_expectations_met"] = all(record["expectation_met"] for record in receipt["records"])
            receipt["temporary_compilation_directory_removed_after_run"] = True
        write_json(receipt_path, receipt)
        print(f"All 11 core audit cases passed. Receipt: {receipt_path}")
        return 0
    except Exception as error:
        receipt["failure"] = str(error)
        receipt["all_expectations_met"] = False
        write_json(receipt_path, receipt)
        print(f"Core fixture run failed: {error}\nReceipt: {receipt_path}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
