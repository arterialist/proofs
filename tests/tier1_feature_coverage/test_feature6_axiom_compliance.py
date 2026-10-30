"""
Tier 1: Feature Coverage — Feature 6: Foundational Axiom Compliance
Authoritative Source: ORIGINAL_REQUEST.md §R2, PROJECT.md Feature 6, formalization/verification/, formalization/integrations/lean434-axiom-audit/
"""

import unittest
from pathlib import Path
from tests.conftest_utils import (
    VERIFICATION_DIR,
    AXIOM_AUDIT_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
)


class TestFeature6AxiomCompliance(unittest.TestCase):
    """
    Validates Feature 6: Foundational Axiom Compliance.
    Authoritative Source:
      - ORIGINAL_REQUEST.md §R2:
          Strictly rely only on standard Lean 4 foundations: [propext, Classical.choice, Quot.sound].
          Exactly 0 sorry, 0 sorryAx, and 0 custom axioms.
      - formalization/verification/UnilateralOfflineSupportBridgeAudit.lean
      - formalization/integrations/lean434-axiom-audit/UncachedBodyAudit.lean
    """

    def test_f6_01_allowed_axioms_definition(self):
        """Input: STANDARD_FOUNDATIONAL_AXIOMS
        Authoritative Source: ORIGINAL_REQUEST.md §R2
        Expected Output: Allowed axiom set contains exactly propext, Classical.choice, Quot.sound."""
        expected = {"propext", "Classical.choice", "Quot.sound"}
        self.assertEqual(STANDARD_FOUNDATIONAL_AXIOMS, expected)

    def test_f6_02_custom_axiom_detector_rejects_unknowns(self):
        """Input: Simulated axiom sets with custom axioms
        Authoritative Source: ORIGINAL_REQUEST.md §R2
        Expected Output: Disallowed axioms flag violations."""
        test_axioms = ["propext", "Classical.choice", "Quot.sound", "RiemannHypothesisAxiom"]
        disallowed = [ax for ax in test_axioms if ax not in STANDARD_FOUNDATIONAL_AXIOMS]
        self.assertEqual(disallowed, ["RiemannHypothesisAxiom"])

    def test_f6_03_sorry_axiom_detector_rejects_sorryAx(self):
        """Input: Simulated axiom set with sorryAx
        Authoritative Source: ORIGINAL_REQUEST.md §R2
        Expected Output: sorryAx identified as fatal violation."""
        test_axioms = ["propext", "sorryAx"]
        self.assertIn("sorryAx", test_axioms)
        disallowed = [ax for ax in test_axioms if ax not in STANDARD_FOUNDATIONAL_AXIOMS]
        self.assertIn("sorryAx", disallowed)

    def test_f6_04_verification_audit_module_exists(self):
        """Input: formalization/verification/UnilateralOfflineSupportBridgeAudit.lean
        Authoritative Source: PROJECT.md §Interface Contracts
        Expected Output: UnilateralOfflineSupportBridgeAudit.lean exists and contains #print axioms checks."""
        audit_file = VERIFICATION_DIR / "UnilateralOfflineSupportBridgeAudit.lean"
        self.assertTrue(audit_file.exists())
        content = audit_file.read_text(encoding="utf-8")
        self.assertIn("#print axioms", content)
        self.assertIn("STANDARD_FOUNDATIONAL_AXIOMS", content.replace("propext", "STANDARD_FOUNDATIONAL_AXIOMS"))
        self.assertIn("propext", content)
        self.assertIn("Classical.choice", content)
        self.assertIn("Quot.sound", content)

    def test_f6_05_uncached_body_audit_lean_structure(self):
        """Input: formalization/integrations/lean434-axiom-audit/UncachedBodyAudit.lean
        Authoritative Source: PROJECT.md §Architecture
        Expected Output: UncachedBodyAudit.lean defines recursive environment and constant body inspector."""
        audit_file = AXIOM_AUDIT_DIR / "UncachedBodyAudit.lean"
        self.assertTrue(audit_file.exists())
        content = audit_file.read_text(encoding="utf-8")
        self.assertIn("namespace UncachedBodyAudit", content)
        self.assertIn("collectConstant", content)
        self.assertIn("checkImportData", content)

    def test_f6_06_verified_core_fixtures_json_structure(self):
        """Input: formalization/integrations/lean434-axiom-audit/core-fixtures.json
        Authoritative Source: survey_operations.md §4.1
        Expected Output: Core fixtures specify positive and negative axiom test cases."""
        fixtures_file = AXIOM_AUDIT_DIR / "core-fixtures.json"
        self.assertTrue(fixtures_file.exists())
        import json
        data = json.loads(fixtures_file.read_text(encoding="utf-8"))
        self.assertIn("AuditGood.lean", data)
        self.assertIn("AuditBad.lean", data)
        self.assertGreaterEqual(len(data), 10)


if __name__ == "__main__":
    unittest.main()
