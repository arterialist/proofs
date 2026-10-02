"""Check the companion Lean modules against a prepared pinned Zeta23 build.

This command does not clone, download, build upstream, alter a toolchain,
or mutate the source checkout. A nondefault source-object directory must
come from the disclosed source-variant build described in README.md.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess


SOURCE_PIN = "fbdc36bbf17d20af3fd0447c6d1a8a02773c9844"
MATHLIB_PIN = "51e6992efd06126df61a496bebf8f49482a4e129"
MODULES = (
    "ShiftedJordanCount", "CommonCount", "ShiftedJordanPole", "CommonPoles",
    "CoprimePoles", "ShiftedJordanFlatDensity", "ShiftedJordanOptimizedDensity",
    "CommonDensityPoles",
)
STANDARD_AXIOMS = {"propext", "Classical.choice", "Quot.sound"}


def checked_output(command: list[str], cwd: Path) -> str:
    return subprocess.run(command, cwd=cwd, check=True, text=True,
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout


def checked_bytes(command: list[str], cwd: Path) -> bytes:
    return subprocess.run(command, cwd=cwd, check=True,
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project", type=Path, required=True,
                        help="Pinned formal-math/zeta23 directory with packages prepared")
    parser.add_argument("--lean", type=Path, required=True,
                        help="Installed Lean 4.33.0-rc2 compiler executable")
    parser.add_argument("--source-objects", type=Path,
                        help="Prepared original or disclosed import-variant Zeta23 object directory")
    parser.add_argument("--output", type=Path, required=True,
                        help="A new directory for these modules' objects, logs and audit record")
    args = parser.parse_args()
    project, lean = args.project.resolve(), args.lean.resolve()
    module_dir, output = Path(__file__).resolve().parent, args.output.resolve()
    if output.exists():
        raise RuntimeError("The output directory must be new; existing work is not overwritten")
    source_objects = (args.source_objects.resolve() if args.source_objects else
                      project / ".lake/build/lib/lean")
    source_head = checked_output(["git", "rev-parse", "HEAD"], project).strip()
    if source_head != SOURCE_PIN:
        raise RuntimeError(f"Source pin mismatch: {source_head}")
    checkout = Path(checked_output(["git", "rev-parse", "--show-toplevel"], project).strip()).resolve()
    manifest_bytes = checked_bytes(
        ["git", "show", f"{SOURCE_PIN}:zeta23/lake-manifest.json"], checkout)
    if (project / "lake-manifest.json").read_bytes() != manifest_bytes:
        raise RuntimeError("The dependency manifest differs from the source pin")
    mathlib = project / ".lake/packages/mathlib"
    mathlib_head = checked_output(["git", "rev-parse", "HEAD"], mathlib).strip()
    if mathlib_head != MATHLIB_PIN:
        raise RuntimeError(f"Mathlib pin mismatch: {mathlib_head}")
    version = checked_output([str(lean), "--version"], project).strip()
    if not re.search(r"\bversion 4\.33\.0-rc2\b", version):
        raise RuntimeError(f"Compiler version mismatch: {version}")
    endpoint = source_objects / "Zeta23/ThmD/Mult.olean"
    if not endpoint.is_file():
        raise RuntimeError(f"The prepared actual density endpoint is missing: {endpoint}")
    missing = [name for name in MODULES if not (module_dir / f"{name}.lean").is_file()]
    if missing:
        raise RuntimeError(f"Companion module sources are missing: {missing}")
    dependency_manifest = json.loads(manifest_bytes)
    package_roots = sorted(project / ".lake/packages" / row["name"]
                           for row in dependency_manifest["packages"])
    libraries = [path / ".lake/build/lib/lean" for path in package_roots
                 if path.is_dir() and (path / ".lake/build/lib/lean").is_dir()]
    for library in libraries:
        if (library / "Zeta23").exists() or (library / "Zeta23.olean").exists():
            raise RuntimeError(f"A dependency provides an additional Zeta23 namespace: {library}")
    input_roots = [checkout, source_objects.resolve(), module_dir, lean.parent.parent,
                   *(path.resolve() for path in package_roots)]
    if any(output.is_relative_to(path) for path in input_roots):
        raise RuntimeError("The output directory must be outside the source checkout, object provider and package caches")
    if {".lake", ".elan", ".cache", ".git"}.intersection(output.parts):
        raise RuntimeError("The output directory must be outside default build, toolchain and cache directories")
    output.mkdir(parents=True)
    objects, logs = output / "lib", output / "logs"
    objects.mkdir()
    logs.mkdir()
    env = os.environ.copy()
    env["LEAN_PATH"] = os.pathsep.join(str(path) for path in
                                      [objects, source_objects, *libraries])
    records: list[dict[str, object]] = []
    for module in MODULES:
        source, obj = module_dir / f"{module}.lean", objects / f"{module}.olean"
        command = [str(lean), "-o", str(obj), str(source)]
        result = subprocess.run(command, cwd=module_dir, env=env, text=True,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        log = logs / f"{module}.log"
        log.write_text(result.stdout)
        if result.returncode != 0:
            raise RuntimeError(f"Lean rejected {module}; inspect {log}")
        audits = re.findall(r"depends on axioms:\s*\[([^\]]*)\]", result.stdout)
        if not audits:
            raise RuntimeError(f"No axiom audit was printed for {module}; inspect {log}")
        for audit in audits:
            axioms = {part.strip() for part in audit.split(",") if part.strip()}
            if not axioms <= STANDARD_AXIOMS:
                raise RuntimeError(f"Unexpected axioms in {module}: {axioms}")
        records.append({"module": module, "source_sha256": digest(source),
                        "olean_sha256": digest(obj), "log_sha256": digest(log),
                        "exit_code": result.returncode, "printed_axiom_audits": len(audits)})
        print(f"PASS {module}: {len(audits)} axiom audits")
    manifest: dict[str, object] = {
        "source_pin": source_head, "mathlib_pin": mathlib_head,
        "compiler": version, "source_object_provider": str(source_objects),
        "endpoint_olean_sha256": digest(endpoint), "modules": records,
        "scope": "companion-module checks against the prepared dependency provider",
        "upstream_build_and_variant_provenance": "separate, as documented in README.md",
    }
    (output / "audit.json").write_text(json.dumps(manifest, indent=2) + "\n")


if __name__ == "__main__":
    main()
