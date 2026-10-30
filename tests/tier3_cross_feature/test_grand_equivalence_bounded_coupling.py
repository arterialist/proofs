"""
Tier 3: Cross-Feature Interactions — Coupling Grand Equivalence and Bounded-Frequency Exclusion
Authoritative Source: PROJECT.md §Interface Contracts, BuildingBlocks/RiemannZetaGrandEquivalence.lean, BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean, BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestGrandEquivalenceBoundedCoupling(unittest.TestCase):
    """
    Validates the cross-feature pairwise coupling between:
      Feature 2: Grand Equivalence Network (10-fold chain)
      Feature 3: Low- & Bounded-Frequency Integration (H = 1493/200)
      Feature 4: High-Frequency Reduction Bridge

    Mathematical Interaction:
      The 10-fold grand equivalence proves:
        RiemannHypothesis ↔ RightHalfZeroFree ↔ RightOfflineSupport = ∅ ↔ HolomorphicZetaODE
      Coupled with cumulative_zero_free_base_seven_forty_six_five, the right half-plane
      is zero-free for all t ≤ 1493/200.
      Therefore, any branch of the 10-fold equivalence holds if and only if
      HighFrequencyZeroFree (1493/200) holds!
    """

    @classmethod
    def setUpClass(cls):
        cls.grand_eq_file = BUILDING_BLOCKS_DIR / "RiemannZetaGrandEquivalence.lean"
        cls.threshold_file = BUILDING_BLOCKS_DIR / "RiemannZetaThresholdFredholmBridge.lean"
        cls.integration_file = BUILDING_BLOCKS_DIR / "RiemannZetaGrandIntermediateIntegration.lean"
        cls.grand_eq_content = cls.grand_eq_file.read_text(encoding="utf-8")
        cls.threshold_content = cls.threshold_file.read_text(encoding="utf-8")
        cls.integration_content = cls.integration_file.read_text(encoding="utf-8")

    def test_coupling_01_grand_equivalence_imports_threshold_components(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:6-17
        Expected Output: Imports Target, UnilateralOfflineSupportBridge, UpperHalfPlaneReduction, HighFrequencySynthesis, LogDerivative, CriticalTransformRH."""
        self.assertIn("import BuildingBlocks.Target", self.grand_eq_content)
        self.assertIn("import BuildingBlocks.UnilateralOfflineSupportBridge", self.grand_eq_content)
        self.assertIn("import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction", self.grand_eq_content)
        self.assertIn("import BuildingBlocks.RiemannZetaHighFrequencySynthesis", self.grand_eq_content)

    def test_coupling_02_bounded_frequency_discharges_lower_slab(self):
        """Input: BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
        Authoritative Source: RiemannZetaGrandIntermediateIntegration.lean:125-135
        Expected Output: cumulative_zero_free_base_seven_forty_six_five provides CumulativeZeroFree (1493/200)."""
        self.assertIn("cumulative_zero_free_base_seven_forty_six_five", self.integration_content)

    def test_coupling_03_pairwise_bridge_rh_iff_seven_forty_six_five(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:184-190
        Expected Output: Exact bi-implication RiemannHypothesis ↔ HighFrequencyZeroFree (1493 / 200)."""
        self.assertIn(
            "theorem RiemannHypothesis_iff_high_frequency_seven_forty_six_five :",
            self.threshold_content,
        )
        self.assertIn("HighFrequencyZeroFree (1493 / 200)", self.threshold_content)

    def test_coupling_04_transitive_coupling_right_half_zero_free_to_high_frequency(self):
        """Input: Grand equivalence + Threshold bridge
        Authoritative Source: PROJECT.md §Interface Contracts
        Expected Output: RightHalfZeroFree is transitively equivalent to HighFrequencyZeroFree (1493/200) via RiemannHypothesis."""
        self.assertIn("target_iff_rightHalfZeroFree", self.grand_eq_content)
        self.assertIn("RiemannHypothesis_iff_highFrequencyZeroFree", self.threshold_content)

    def test_coupling_05_transitive_coupling_support_empty_to_high_frequency(self):
        """Input: Grand equivalence + Threshold bridge
        Authoritative Source: PROJECT.md §Interface Contracts
        Expected Output: RightOfflineSupport = ∅ is transitively equivalent to HighFrequencyZeroFree (1493/200)."""
        self.assertIn("RiemannHypothesis_iff_rightOfflineSupport_empty", self.grand_eq_content)
        self.assertIn("RiemannHypothesis_iff_highFrequencyZeroFree", self.threshold_content)


if __name__ == "__main__":
    unittest.main()
