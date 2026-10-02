#!/usr/bin/env python3
"""Replay a pinned global Arb certificate and its chosen m=279 constant.

Use an existing Git checkout at the exact pin and existing CPython with
python-flint 0.9.0. This standard-library controller never installs, fetches,
or writes upstream source. It runs hashed source copies in an isolated temporary
directory. --compare-only checks a saved JSON report without replaying it.

The result trusts Python/binary64/python-flint/FLINT-Arb/OS/hardware. It is
not Lean kernel closure and supplies no full F/W/coarse/RH estimate.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time


PIN = "e2453c1cafc1387ef553fe6bee74d1f5223ba801"
TARGET = "F6 >= 382623/100000000"
MODULE_HASHES = {
    "__init__.py": "fed3f612069c72d4efac4250c6b1e63733762bf5911a973a445c1908d7b4b5d1",
    "__main__.py": "935a1c1166b0c1ea35a82256345000bf2c73ded718d77773bc27a71ecce28f7d",
    "cli.py": "2f5822eaaccfdfc508f0e60395fa0986e9a18c709bf14e42b6abb9e39e2c2888",
    "constants.py": "4dfaa4556855d9a7e18d7127a3ac4ac738cda543f017f011a7493ce859a9253d",
    "kernel.py": "e83aa966699770bc72f67d3e55079cff89c2432a05ad25abd12afc8cbf9af1dd",
    "report.py": "6305c3a072a3839aff80ad9854fc8e1e259df86078b8a20821fa778b966833fc",
    "rounding.py": "2419f77bae2fb73ccb1da4e5d2bbaf3247e7d900d53871de9011296f7de5844e",
    "verify_seven.py": "9ef7c092a3c52c06058bac434375a1c012949d86d00588c043be672f955c2772",
    "verify_three.py": "ef2b91bb3323fba459cc5e0b2be2e9408da7a39ba9c56517833c6e3c7109ab20",
}
CONSTANT_SCRIPT_HASH = "2fdab4e4eef23910357742135a0b8d79829ff9a9c53c70c3328558cfd55439f4"
EXPECTED = {
    "certificate": "seven-point", "verified": True, "target": TARGET,
    "grid": 4000, "precision_bits": 128, "initial_boxes": 729,
    "nodes": 980069, "pruned": 490399, "splits": 489670, "maximum_depth": 65,
    "kernel_table_sha256": "5a1f95f754a83ba05f37692d4bda69bf3fa5d3752af902826bfc4cffd31428b9",
    "details": {
        "interval_pruned": 285258, "pressure_pruned": 3166,
        "tangent_pruned": 201975, "subcell_tangent_pruned": 1773,
        "terminal_subcell_max_depth": 20,
        "second_derivative_table_sha256": "02589f9acbab9808a303f85cf14f5e98bcb6f30265a5542f9ccca5f9fe8c3b97",
        "surviving_gap_components_cells": "[3807,4780];[7218,9373];[10560,44945]",
        "surviving_gap_components_count": 3,
    },
}
RUNTIME_PROBE = (
    "import flint,json,platform,sys; print(json.dumps({"
    "'python':sys.version,'executable':sys.executable,'platform':platform.platform(),"
    "'implementation':platform.python_implementation(),'python_flint':flint.__version__,"
    "'assertions_enabled':__debug__}))"
)
PACKAGE_BOOTSTRAP = (
    "import runpy,sys; sys.path.insert(0,sys.argv.pop(1)); "
    "runpy.run_module('zeta_simple_zeros',run_name='__main__')"
)


def environment() -> dict[str, str]:
    result = {key: value for key, value in os.environ.items()
              if not key.startswith(("GIT_", "PYTHON"))}
    result.update(GIT_OPTIONAL_LOCKS="0", PYTHONDONTWRITEBYTECODE="1")
    return result


def source_bytes(source: Path, env: dict[str, str]) -> dict[str, bytes]:
    git = shutil.which("git")
    if git is None:
        raise RuntimeError("existing Git is required for read-only source identity")
    prefix = [git, "--no-optional-locks", "-C", str(source), "-c", "core.fsmonitor=false", "rev-parse"]
    def read_ref(*arguments: str) -> str:
        job = subprocess.run(prefix + list(arguments), env=env, capture_output=True, text=True)
        if job.returncode:
            raise RuntimeError("read-only Git identity check failed: " + job.stderr.strip())
        return job.stdout.strip()
    if Path(read_ref("--show-toplevel")).resolve() != source or read_ref("--verify", "HEAD^{commit}") != PIN:
        raise RuntimeError("source must be the Git checkout root at HEAD " + PIN)
    expected = {"src/zeta_simple_zeros/" + name: digest for name, digest in MODULE_HASHES.items()}
    expected["verify_constants.py"] = CONSTANT_SCRIPT_HASH
    contents = {}
    for relative, digest in expected.items():
        data = (source / relative).read_bytes()
        if hashlib.sha256(data).hexdigest() != digest:
            raise RuntimeError("reviewed source hash mismatch: " + relative)
        contents[relative] = data
    return contents


def unique_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError("duplicate JSON key: " + key)
        result[key] = value
    return result


def strict_equal(actual, expected, path="report") -> None:
    if type(actual) is not type(expected):
        raise ValueError("wrong JSON type at " + path)
    if isinstance(expected, dict):
        if set(actual) != set(expected):
            raise ValueError("wrong JSON fields at " + path)
        for key, value in expected.items():
            strict_equal(actual[key], value, path + "." + key)
    elif actual != expected:
        raise ValueError("frozen report mismatch at " + path)


def compare_report(text: str) -> dict:
    report = json.loads(text, object_pairs_hook=unique_keys)
    if type(report) is not dict or report.get("verified") is not True or report.get("target") != TARGET:
        raise ValueError("report did not verify the exact global target")
    elapsed = report.get("elapsed_seconds")
    if type(elapsed) not in (int, float) or not math.isfinite(elapsed) or elapsed < 0:
        raise ValueError("invalid report elapsed_seconds")
    strict_equal({key: value for key, value in report.items() if key != "elapsed_seconds"}, EXPECTED)
    return report


def run_python(python: Path, arguments: list[str], cwd: Path, env: dict[str, str], jobs: list[dict]) -> str:
    command = [str(python), "-I", "-B"] + arguments
    started = time.perf_counter()
    job = subprocess.run(command, cwd=cwd, env=env, capture_output=True, text=True)
    jobs.append({"command": command, "cwd": str(cwd), "exit_code": job.returncode,
                 "wall_seconds": time.perf_counter() - started, "stdout": job.stdout, "stderr": job.stderr})
    if job.returncode:
        raise RuntimeError("reviewed Python job exited " + str(job.returncode) + ": " + job.stderr.strip())
    return job.stdout


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", nargs="?", type=Path, help="existing Git checkout at the exact pin")
    parser.add_argument("--python", type=Path, default=Path(sys.executable), help="absolute existing CPython path")
    parser.add_argument("--compare-only", type=Path, help="check saved JSON; do not replay or claim source verification")
    args = parser.parse_args()
    jobs = []
    try:
        if not __debug__:
            raise RuntimeError("assertions must be enabled; do not use -O or PYTHONOPTIMIZE")
        if args.compare_only is not None:
            if args.source is not None:
                raise ValueError("--compare-only takes a saved report without a source argument")
            report = compare_report(args.compare_only.read_text(encoding="utf-8"))
            print(json.dumps({"mode": "compare-only", "report_matches": True,
                              "certificate_replayed": False, "source_verified": False,
                              "expected_source_pin": PIN, "saved_report": report}, indent=2, sort_keys=True))
            return 0
        if args.source is None:
            raise ValueError("a source checkout is required for replay")
        source = args.source.expanduser().resolve(strict=True)
        # Preserve the venv invocation path rather than resolving its symlink.
        python = args.python.expanduser()
        if not python.is_absolute() or not python.is_file() or not os.access(python, os.X_OK):
            raise ValueError("--python must name an existing executable by absolute path")
        env = environment()
        contents = source_bytes(source, env)
        with tempfile.TemporaryDirectory(prefix="zeta-refinement-audit-") as temporary:
            frozen = Path(temporary)
            for relative, data in contents.items():
                path = frozen / relative
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(data)
            runtime = json.loads(run_python(python, ["-c", RUNTIME_PROBE], frozen, env, jobs))
            if (type(runtime) is not dict or runtime.get("implementation") != "CPython"
                    or runtime.get("python_flint") != "0.9.0"
                    or runtime.get("assertions_enabled") is not True):
                raise RuntimeError("existing CPython/python-flint 0.9.0 with assertions enabled is required")
            constant_output = run_python(python, [str(frozen / "verify_constants.py")], frozen, env, jobs)
            constant_fields = {}
            for line in constant_output.splitlines():
                key, separator, value = line.partition("=")
                if not separator or key in constant_fields:
                    raise ValueError("unexpected constant verifier output")
                constant_fields[key] = value
            required = {"verified": "true", "local_target": "382623/100000000",
                        "block_size": "279", "precision_bits": "256", "A": "104456079/100000000"}
            if any(constant_fields.get(key) != value for key, value in required.items()):
                raise ValueError("the reviewed chosen-m constant check failed")
            report = compare_report(run_python(python, ["-c", PACKAGE_BOOTSTRAP,
                                                       str(frozen / "src"), "seven", "--json"], frozen, env, jobs))
        source_bytes(source, env)
        print(json.dumps({"mode": "replay", "verified": True, "source_pin": PIN,
                          "certificate_replayed": True, "source_verified": True,
                          "reviewed_module_hashes": MODULE_HASHES,
                          "constant_script_sha256": CONSTANT_SCRIPT_HASH,
                          "compared_deterministic_fields_including_source_hash": 20,
                          "runtime": runtime, "finite": report, "chosen_m_constant": constant_fields,
                          "jobs": jobs, "trust_boundary": "global Arb certificate; no Lean kernel closure or RH proof"},
                         indent=2, sort_keys=True, allow_nan=False))
        return 0
    except (OSError, RuntimeError, ValueError) as error:
        print(json.dumps({"verified": False, "source_pin": PIN, "error": str(error), "jobs": jobs},
                         indent=2, sort_keys=True), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
