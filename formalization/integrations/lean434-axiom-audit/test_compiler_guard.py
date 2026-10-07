#!/usr/bin/env python3
"""Nonexecuting regression checks for installed_compiler's recognized-shim guard.

Temporary files have inert text. No compiler, shim, installer or subprocess is run.
Accepted fake native files exercise selection only, not executable authenticity.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
import sys
import tempfile
import uuid
from datetime import datetime, timezone
from pathlib import Path
from unittest.mock import patch

sys.dont_write_bytecode = True
BASE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("fixture_runner_guard_test", BASE / "run_core_fixtures.py")
if spec is None or spec.loader is None:
    raise RuntimeError("Cannot load the fixture runner for guard testing.")
runner = importlib.util.module_from_spec(spec)
spec.loader.exec_module(runner)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=BASE / "audit-results")
    args = parser.parse_args()
    run_id = "compiler-guard-" + datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ") + "-" + uuid.uuid4().hex[:8]
    result_dir = args.output_dir.expanduser().resolve() / run_id
    result_dir.mkdir(parents=True, exist_ok=False)
    receipt_path = result_dir / "receipt.json"
    receipt: dict = {
        "schema": 1,
        "scope": "Compiler path selection only; no executables invoked.",
        "runner_sha256": hashlib.sha256((BASE / "run_core_fixtures.py").read_bytes()).hexdigest(),
        "test_source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "records": [], "all_expectations_met": False, "subprocess_execution_forbidden": True,
        "limits": "Recognized elan shim checks do not authenticate arbitrary executables or wrappers.",
    }
    try:
        with tempfile.TemporaryDirectory(prefix="inert-path-fixtures-", dir=result_dir) as temporary:
            work = Path(temporary)
            configured = work / "custom-elan-home"
            unconfigured = work / "other-home"

            def inert(path: Path) -> Path:
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text("INERT TEST FILE: NEVER EXECUTE\n", encoding="utf-8")
                return path

            def check(name: str, candidate: Path | None, *, expect: Path | None = None,
                      configured_home: Path = configured, on_path: dict[str, str] | None = None) -> None:
                record: dict = {"name": name, "expect": "reject" if expect is None else "select-native-layout",
                                "candidate": str(candidate.relative_to(work)) if candidate else "automatic"}
                try:
                    with patch.dict(os.environ, {"ELAN_HOME": str(configured_home), "PATH": ""}), \
                            patch.object(runner.shutil, "which", side_effect=lambda binary: (on_path or {}).get(binary)), \
                            patch.object(runner.subprocess, "run", side_effect=RuntimeError("BUG: executable invocation during path check")):
                        selected = runner.installed_compiler(str(candidate) if candidate else None)
                    record["actual"] = "selected"
                    record["selected"] = str(selected.relative_to(work))
                    record["expectation_met"] = expect is not None and selected == expect.resolve()
                except RuntimeError as error:
                    record["actual"] = "rejected"
                    record["diagnostic"] = str(error)
                    record["expectation_met"] = expect is None and (
                        "not an elan shim" in str(error) or "installed native Lean 4.34.1" in str(error)
                    )
                receipt["records"].append(record)
                if not record["expectation_met"]:
                    raise RuntimeError(f"Unexpected guard outcome: {name}")

            # The original reported hole: custom bin + sibling hardlink, no elan on PATH.
            elan = inert(configured / "bin/elan")
            lean = configured / "bin/lean"
            os.link(elan, lean)
            check("configured-custom-hardlink-no-path", lean)
            # A configured bin is rejected even when its lean file is a distinct inode.
            distinct = inert(configured / "bin/distinct-lean")
            check("configured-bin-distinct-file", distinct)
            # Unconfigured custom home must also reject identity with a sibling elan.
            other_elan = inert(unconfigured / "bin/elan")
            other_lean = unconfigured / "bin/lean"
            os.link(other_elan, other_lean)
            check("unconfigured-custom-sibling-hardlink-no-path", other_lean)
            exe_elan = inert(work / "exe-sibling/bin/elan.exe")
            exe_lean = exe_elan.parent / "lean"
            os.link(exe_elan, exe_lean)
            check("sibling-elan-exe-hardlink", exe_lean)
            # Cross-directory identity catches the configured elan even without a sibling.
            remote_link = work / "remote/bin/lean"
            remote_link.parent.mkdir(parents=True)
            os.link(elan, remote_link)
            check("configured-elan-cross-directory-hardlink", remote_link)
            # Symlink names and directory aliases must not hide the configured bin.
            alias = work / "aliases/lean"
            alias.parent.mkdir()
            alias.symlink_to(elan)
            check("symlink-to-elan", alias)
            directory_alias = work / "bin-alias"
            directory_alias.symlink_to(configured / "bin", target_is_directory=True)
            check("configured-bin-directory-alias", directory_alias / "distinct-lean")
            literal = inert(work / ".elan/bin/lean")
            check("literal-default-elan-bin", literal)
            # A hardlinked elan found on PATH is rejected away from either home.
            path_elan = inert(work / "discoverable/elan")
            path_lean = work / "remote-path/lean"
            path_lean.parent.mkdir()
            os.link(path_elan, path_lean)
            check("path-elan-hardlink-identity", path_lean, on_path={"elan": str(path_elan)})
            # Native-layout files remain valid; no test executes these fake objects.
            binary = "lean.exe" if os.name == "nt" else "lean"
            native = inert(configured / "toolchains/leanprover--lean4---v4.34.1/bin" / binary)
            check("explicit-native-toolchain-layout", native, expect=native)
            check("automatic-configured-native-toolchain-layout", None, expect=native)
            separate_native = inert(work / "separate-native/bin" / binary)
            check("trusted-explicit-native-outside-elan-home", separate_native, expect=separate_native)
            missing_home = work / "missing-home"
            check("automatic-path-shim-fails-closed", None, configured_home=missing_home,
                  on_path={binary: str(other_lean)})
            check("automatic-path-native-layout", None, expect=separate_native, configured_home=missing_home,
                  on_path={binary: str(separate_native)})
        receipt["all_expectations_met"] = all(row["expectation_met"] for row in receipt["records"])
        receipt["temporary_inert_files_removed_after_run"] = True
        receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
        print(f"All {len(receipt['records'])} nonexecuting compiler-guard cases passed. Receipt: {receipt_path}")
        return 0
    except Exception as error:
        receipt["failure"] = str(error)
        receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
        print(f"Compiler-guard checks failed: {error}\nReceipt: {receipt_path}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
