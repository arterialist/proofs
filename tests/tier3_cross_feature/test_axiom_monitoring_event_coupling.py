"""
Tier 3: Cross-Feature Interactions — Coupling Axiom Verification and Breakthrough Telemetry
Authoritative Source: ORIGINAL_REQUEST.md §R2, §R4, monitoring/breakthroughs.json, formalization/verification/
"""

import json
import unittest
from pathlib import Path
from tests.conftest_utils import (
    MONITORING_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    VERIFICATION_DIR,
)


class TestAxiomMonitoringEventCoupling(unittest.TestCase):
    """
    Validates cross-feature coupling between:
      Feature 6: Foundational Axiom Compliance
      Feature 7: Operational Monitoring & Breakthrough Notification

    Interaction:
      The telemetry in monitoring/breakthroughs.json formal_kernel_status reflects the
      precise verified state of the Lean 4 formalization:
        - "axioms": ["propext", "Classical.choice", "Quot.sound"]
        - "custom_axioms": 0
        - "sorry_count": 0
      Any breakthrough event posted must cite a verified .lean file adhering to these exact standards.
    """

    @classmethod
    def setUpClass(cls):
        cls.db_file = MONITORING_DIR / "breakthroughs.json"
        cls.db = json.loads(cls.db_file.read_text(encoding="utf-8"))

    def test_telemetry_01_kernel_status_matches_standard_foundations(self):
        """Input: monitoring/breakthroughs.json formal_kernel_status
        Authoritative Source: ORIGINAL_REQUEST.md §R2, survey_operations.md §2.1
        Expected Output: Kernel status axioms set equals standard foundational axioms exactly."""
        recorded_axioms = set(self.db["formal_kernel_status"]["axioms"])
        self.assertEqual(recorded_axioms, STANDARD_FOUNDATIONAL_AXIOMS)

    def test_telemetry_02_zero_custom_axioms_and_zero_sorries_in_status(self):
        """Input: monitoring/breakthroughs.json formal_kernel_status
        Authoritative Source: ORIGINAL_REQUEST.md §R2
        Expected Output: custom_axioms == 0 and sorry_count == 0."""
        self.assertEqual(self.db["formal_kernel_status"]["custom_axioms"], 0)
        self.assertEqual(self.db["formal_kernel_status"]["sorry_count"], 0)

    def test_telemetry_03_events_cite_valid_lean_files(self):
        """Input: monitoring/breakthroughs.json events
        Authoritative Source: survey_operations.md §2.2
        Expected Output: Every event's lean_file exists on disk or resolves within the formalization tree."""
        from tests.conftest_utils import REPO_ROOT
        for event in self.db.get("events", []):
            lean_rel = event.get("lean_file", "")
            if lean_rel:
                lean_path = REPO_ROOT / lean_rel
                self.assertTrue(lean_path.exists(), f"Event cites non-existent file: {lean_rel}")

    def test_telemetry_04_breakthrough_thresholds_defined_across_all_bounds(self):
        """Input: monitoring/breakthroughs.json bounds
        Authoritative Source: survey_operations.md §2.1
        Expected Output: All four primary bounds define breakthrough_thresholds."""
        bounds = self.db.get("bounds", {})
        required_keys = [
            "critical_line_proportion",
            "de_bruijn_newman",
            "zero_free_region",
            "verified_critical_zeros",
        ]
        for key in required_keys:
            self.assertIn(key, bounds, f"Missing bound key: {key}")
            self.assertIn("breakthrough_threshold", bounds[key], f"Missing threshold in bound {key}")


if __name__ == "__main__":
    unittest.main()
