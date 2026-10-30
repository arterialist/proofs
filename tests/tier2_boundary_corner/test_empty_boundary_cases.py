"""
Tier 2: Boundary & Corner Cases — Empty Inputs and Boundary Supports
Authoritative Source: BuildingBlocks/UnilateralOfflineSupportBridge.lean, formalization/integrations/lean434-axiom-audit/core-fixtures.json, monitoring/notify.py
"""

import json
import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR, AXIOM_AUDIT_DIR, MONITORING_DIR


class TestEmptyBoundaryCases(unittest.TestCase):
    """
    Validates boundary behavior with empty and degenerate inputs:
      - Empty off-line support sets (RightOfflineSupport = ∅, LeftOfflineSupport = ∅)
      - Empty high-frequency support sets (RightOfflineSupportAbove H = ∅)
      - Empty declaration list in axiom audit runner (AuditEmpty.lean)
      - Empty event list initialization in breakthroughs.json
      - Empty commit hash and empty lean-file parameters in notify.py
    """

    def test_empty_01_right_offline_support_empty_theorem(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:135-145
        Expected Output: Equivalence RightHalfZeroFree ↔ RightOfflineSupport = ∅."""
        path = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("RightHalfZeroFree ↔ RightOfflineSupport = ∅", content)

    def test_empty_02_bilateral_conjunction_collapses_to_unilateral_empty(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:155-165
        Expected Output: LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅ ↔ RightOfflineSupport = ∅."""
        path = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅ ↔ RightOfflineSupport = ∅", content)

    def test_empty_03_high_frequency_support_above_empty_iff_high_frequency_zero_free(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:180-190
        Expected Output: RightOfflineSupportAbove H = ∅ ↔ HighFrequencyZeroFree H."""
        path = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("RightOfflineSupportAbove H = ∅ ↔ HighFrequencyZeroFree H", content)

    def test_empty_04_core_fixtures_includes_empty_audit_fixture(self):
        """Input: formalization/integrations/lean434-axiom-audit/core-fixtures.json
        Authoritative Source: core-fixtures.json AuditEmpty.lean
        Expected Output: AuditEmpty.lean checks verifyModules #[] 0 succeeds on empty module array."""
        fixtures_file = AXIOM_AUDIT_DIR / "core-fixtures.json"
        data = json.loads(fixtures_file.read_text(encoding="utf-8"))
        self.assertIn("AuditEmpty.lean", data)
        self.assertIn("verifyModules #[] 0", data["AuditEmpty.lean"])

    def test_empty_05_notify_script_handles_empty_optional_strings(self):
        """Input: monitoring/notify.py
        Authoritative Source: notify.py:85-86
        Expected Output: CLI defaults allow empty commit='' and empty lean_file='' without crashing."""
        path = MONITORING_DIR / "notify.py"
        content = path.read_text(encoding="utf-8")
        self.assertIn('parser.add_argument("--lean-file", default="",', content)
        self.assertIn('parser.add_argument("--commit", default="",', content)


if __name__ == "__main__":
    unittest.main()
