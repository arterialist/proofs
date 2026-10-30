"""
Tier 1: Feature Coverage — Feature 2: Grand Equivalence Network
Authoritative Source: PROJECT.md Feature 2, BuildingBlocks/RiemannZetaGrandEquivalence.lean, BuildingBlocks/UnilateralOfflineSupportBridge.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestFeature2GrandEquivalence(unittest.TestCase):
    """
    Validates Feature 2: Grand Equivalence Network.
    Authoritative Source:
      - PROJECT.md Feature 2: Verified 10-fold equivalence
        (Target ↔ RightHalfZeroFree ↔ RightOfflineSupport = ∅ ↔ HighFrequencyZeroFree (1493/200))
      - formalization/BuildingBlocks/RiemannZetaGrandEquivalence.lean
      - formalization/BuildingBlocks/UnilateralOfflineSupportBridge.lean
    """

    @classmethod
    def setUpClass(cls):
        cls.grand_eq_file = BUILDING_BLOCKS_DIR / "RiemannZetaGrandEquivalence.lean"
        cls.bridge_file = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        cls.grand_eq_content = cls.grand_eq_file.read_text(encoding="utf-8")
        cls.bridge_content = cls.bridge_file.read_text(encoding="utf-8")

    def test_f2_01_rh_iff_target_equivalence(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:49
        Expected Output: theorem rh_iff_target : RiemannHypothesis ↔ Target := Iff.rfl."""
        self.assertIn("theorem rh_iff_target : RiemannHypothesis ↔ Target := Iff.rfl", self.grand_eq_content)

    def test_f2_02_rh_iff_right_half_zero_free(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:52-53
        Expected Output: theorem rh_iff_rightHalfZeroFree : RiemannHypothesis ↔ RightHalfZeroFree."""
        self.assertIn("theorem rh_iff_rightHalfZeroFree : RiemannHypothesis ↔ RightHalfZeroFree", self.grand_eq_content)

    def test_f2_03_rh_iff_right_offline_support_empty(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:56-57
        Expected Output: theorem rh_iff_rightOfflineSupport_empty : RiemannHypothesis ↔ RightOfflineSupport = ∅."""
        self.assertIn("theorem rh_iff_rightOfflineSupport_empty : RiemannHypothesis ↔ RightOfflineSupport = ∅", self.grand_eq_content)

    def test_f2_04_rh_iff_upper_half_plane_zero_free(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:60-62
        Expected Output: theorem rh_iff_upper_half_plane_zero_free reducing to quadrant Im(s) > 0."""
        self.assertIn("theorem rh_iff_upper_half_plane_zero_free :", self.grand_eq_content)
        self.assertIn("(1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0", self.grand_eq_content)

    def test_f2_05_rh_iff_high_frequency_zero_free(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:65-67
        Expected Output: theorem rh_iff_high_frequency_zero_free reducing to Im(s) > 1."""
        self.assertIn("theorem rh_iff_high_frequency_zero_free :", self.grand_eq_content)
        self.assertIn("(1 : ℝ) / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0", self.grand_eq_content)

    def test_f2_06_master_grand_tenfold_equivalence_theorem(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:116-135
        Expected Output: theorem grand_rh_tenfold_equivalence establishing full conjunction."""
        self.assertIn("theorem grand_rh_tenfold_equivalence :", self.grand_eq_content)
        self.assertIn("(RiemannHypothesis ↔ RightHalfZeroFree) ∧", self.grand_eq_content)
        self.assertIn("(RiemannHypothesis ↔ RightOfflineSupport = ∅) ∧", self.grand_eq_content)

    def test_f2_07_unilateral_duality_equivalence(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:115-121
        Expected Output: theorem rightOfflineSupport_empty_iff_leftOfflineSupport_empty : RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅."""
        self.assertIn("theorem rightOfflineSupport_empty_iff_leftOfflineSupport_empty :", self.bridge_content)
        self.assertIn("RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅", self.bridge_content)


if __name__ == "__main__":
    unittest.main()
