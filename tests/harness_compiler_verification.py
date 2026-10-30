#!/usr/bin/env python3
"""
Dedicated Test Harness: Lean 4 Compiler Guard & Fixture Verification.
Executes non-executing compiler guard checks and deep-walker AST fixtures.

Usage:
  python3 tests/harness_compiler_verification.py
"""

import sys
from pathlib import Path

# Add project root to sys.path
REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from tests.conftest_utils import (
    AXIOM_AUDIT_DIR,
    NATIVE_LEAN_BIN,
    run_command,
)


def run_guards() -> bool:
    print("\n[Compiler Verification] Running 14 non-executing compiler guard checks...")
    cmd = "python3 test_compiler_guard.py"
    proc = run_command(cmd, cwd=AXIOM_AUDIT_DIR, timeout=30)
    if proc.returncode != 0:
        print("[FAIL] Compiler guards failed:")
        print(proc.stderr or proc.stdout)
        return False
    print("  [PASS] All 14 compiler-guard checks passed cleanly.")
    return True


def run_fixtures() -> bool:
    print("\n[Compiler Verification] Running 11 core AST axiom fixtures...")
    if not NATIVE_LEAN_BIN.exists():
        print(f"[FAIL] Native Lean compiler binary not found at: {NATIVE_LEAN_BIN}")
        return False
    cmd = f"python3 run_core_fixtures.py --lean {NATIVE_LEAN_BIN}"
    proc = run_command(cmd, cwd=AXIOM_AUDIT_DIR, timeout=60)
    if proc.returncode != 0:
        print("[FAIL] Core fixtures failed:")
        print(proc.stderr or proc.stdout)
        return False
    print("  [PASS] All 11 core fixture checks passed cleanly.")
    return True


def main():
    print("=== Lean 4 Compiler Verification Harness ===")
    guards_ok = run_guards()
    fixtures_ok = run_fixtures()

    if guards_ok and fixtures_ok:
        print("\n=== Compiler Verification Harness: ALL CHECKS PASSED ===")
        sys.exit(0)
    else:
        print("\n=== Compiler Verification Harness: VERIFICATION FAILED ===")
        sys.exit(1)


if __name__ == "__main__":
    main()
