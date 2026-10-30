"""
Tier 4: Workload Scenarios — Live In-Kernel Axiom Audit Execution
Authoritative Source: ORIGINAL_REQUEST.md §R2, PROJECT.md §Interface Contracts, formalization/verification/UnilateralOfflineSupportBridgeAudit.lean
"""

import re
import unittest
from tests.conftest_utils import (
    REPO_ROOT,
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


class TestKernelAxiomAuditWorkload(unittest.TestCase):
    """
    Executes live in-kernel axiom audits using Lean 4 (`lake env lean`) on verified modules.
    Verifies:
      1. Compilation succeeds with exit code 0.
      2. No custom axioms appear in the dependency graph.
      3. No sorry or sorryAx exist in any declaration.
      4. Every audited declaration depends strictly on [propext, Classical.choice, Quot.sound].
    """

    def test_workload_01_execute_unilateral_support_bridge_audit(self):
        """Input: lake env lean formalization/verification/UnilateralOfflineSupportBridgeAudit.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R2, PROJECT.md §Interface Contracts
        Expected Output: Exit code 0, standard axioms only [propext, Classical.choice, Quot.sound], zero sorry, zero custom axioms."""
        audit_file = VERIFICATION_DIR / "UnilateralOfflineSupportBridgeAudit.lean"
        self.assertTrue(audit_file.exists(), f"Missing audit file {audit_file}")

        cmd = f"lake env lean {audit_file.relative_to(REPO_ROOT)}"
        proc = run_command(cmd, cwd=REPO_ROOT, timeout=60)
        self.assertEqual(
            proc.returncode,
            0,
            f"Axiom audit failed with return code {proc.returncode}:\nStdout:\n{proc.stdout}\nStderr:\n{proc.stderr}",
        )

        stdout = proc.stdout

        # Verify completion banner
        self.assertIn("UNILATERAL OFFLINE SUPPORT BRIDGE AUDIT PASSED", stdout)
        self.assertIn("zero custom axioms, zero sorry", stdout)

        # Verify no sorryAx anywhere in output
        self.assertNotIn("sorryAx", stdout)
        self.assertNotIn("sorry", stdout.lower().replace("zero sorry", ""))

        # Parse every '#print axioms' block and verify axioms
        axiom_blocks = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", stdout)
        self.assertGreaterEqual(
            len(axiom_blocks),
            10,
            f"Expected at least 10 #print axioms declarations, found {len(axiom_blocks)}",
        )

        for decl_name, axioms_str in axiom_blocks:
            # Clean up comma/whitespace separated axiom list
            raw_axioms = [a.strip() for a in axioms_str.split(",") if a.strip()]
            axioms_set = set(raw_axioms)
            # Ensure every single axiom belongs to the standard foundational set
            disallowed = axioms_set - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                disallowed,
                set(),
                f"Declaration {decl_name} depends on disallowed axioms: {disallowed}",
            )


if __name__ == "__main__":
    unittest.main()
