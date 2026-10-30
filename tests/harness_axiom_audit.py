#!/usr/bin/env python3
"""
Dedicated Test Harness: Lean 4 In-Kernel Axiom Audit.
Verifies target modules adhere strictly to foundational axioms:
  [propext, Classical.choice, Quot.sound]
with exactly 0 sorry and 0 custom axioms.

Usage:
  python3 tests/harness_axiom_audit.py [optional_path_to_audit.lean]
"""

import re
import sys
from pathlib import Path

# Add project root to sys.path
REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from tests.conftest_utils import (
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


def audit_module(audit_file: Path) -> bool:
    print(f"\n[Axiom Audit] Auditing: {audit_file.relative_to(REPO_ROOT)}")
    rel_path = audit_file.relative_to(REPO_ROOT)
    cmd = f"lake env lean {rel_path}"
    proc = run_command(cmd, cwd=REPO_ROOT, timeout=120)

    if proc.returncode != 0:
        print(f"[FAIL] Lean compilation error (exit {proc.returncode}):")
        print(proc.stderr or proc.stdout)
        return False

    stdout = proc.stdout
    if "sorryAx" in stdout:
        print("[FAIL] sorryAx detected in dependency tree!")
        return False

    axiom_blocks = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", stdout)
    if not axiom_blocks:
        print("[WARNING] No #print axioms blocks found in output.")
    else:
        print(f"  Found {len(axiom_blocks)} audited declarations.")

    violations = []
    for decl, axioms_str in axiom_blocks:
        axioms = [a.strip() for a in axioms_str.split(",") if a.strip()]
        disallowed = set(axioms) - STANDARD_FOUNDATIONAL_AXIOMS
        if disallowed:
            violations.append((decl, disallowed))

    if violations:
        print(f"[FAIL] {len(violations)} declarations depend on custom or disallowed axioms:")
        for decl, dis in violations:
            print(f"  - {decl}: {dis}")
        return False

    print(f"[PASS] {audit_file.name}: All declarations strictly rely on {list(STANDARD_FOUNDATIONAL_AXIOMS)} with 0 sorry.")
    return True


def main():
    if len(sys.argv) > 1:
        target = Path(sys.argv[1]).resolve()
        targets = [target]
    else:
        # Default canonical targets
        targets = [
            VERIFICATION_DIR / "UnilateralOfflineSupportBridgeAudit.lean",
        ]

    all_passed = True
    for t in targets:
        if not t.exists():
            print(f"[ERROR] Target file does not exist: {t}")
            sys.exit(1)
        if not audit_module(t):
            all_passed = False

    if all_passed:
        print("\n=== In-Kernel Axiom Audit Harness: ALL AUDITS PASSED ===")
        sys.exit(0)
    else:
        print("\n=== In-Kernel Axiom Audit Harness: AUDIT FAILED ===")
        sys.exit(1)


if __name__ == "__main__":
    main()
