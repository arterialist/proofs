"""
Tier 1: Feature Coverage — Feature 4: High-Frequency Reduction Bridge
Authoritative Source: PROJECT.md Feature 4, BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean, BuildingBlocks/UnilateralOfflineSupportBridge.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestFeature4HighFrequencyBridge(unittest.TestCase):
    """
    Validates Feature 4: High-Frequency Reduction Bridge.
    Authoritative Source:
      - PROJECT.md Feature 4: Rigorous interface reducing RH to high-frequency domain |t| > 7.465
      - BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
      - BuildingBlocks/UnilateralOfflineSupportBridge.lean
    """

    @classmethod
    def setUpClass(cls):
        cls.bridge_file = BUILDING_BLOCKS_DIR / "RiemannZetaThresholdFredholmBridge.lean"
        cls.support_file = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        cls.bridge_content = cls.bridge_file.read_text(encoding="utf-8")
        cls.support_content = cls.support_file.read_text(encoding="utf-8")

    def test_f4_01_high_frequency_zero_free_definition(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:66
        Expected Output: def HighFrequencyZeroFree (H : ℝ) : Prop := ... H < |s.im| → 1/2 < s.re → False."""
        self.assertIn("def HighFrequencyZeroFree (H : ℝ) : Prop :=", self.support_content)
        self.assertIn("H < |s.im|", self.support_content)

    def test_f4_02_high_frequency_monotonicity(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:246-250
        Expected Output: theorem highFrequencyZeroFree_mono {H₁ H₂ : ℝ} (hle : H₁ ≤ H₂) (h₁ : HighFrequencyZeroFree H₁) : HighFrequencyZeroFree H₂."""
        self.assertIn("theorem highFrequencyZeroFree_mono", self.support_content)
        self.assertIn("(h₁ : HighFrequencyZeroFree H₁) : HighFrequencyZeroFree H₂", self.support_content)

    def test_f4_03_exact_threshold_rh_equivalence_theorem(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:166-177
        Expected Output: theorem RiemannHypothesis_iff_highFrequencyZeroFree (H : ℝ) (hH : 0 ≤ H) (h_cum : CumulativeZeroFree H) : RiemannHypothesis ↔ HighFrequencyZeroFree H."""
        self.assertIn("theorem RiemannHypothesis_iff_highFrequencyZeroFree", self.bridge_content)
        self.assertIn("RiemannHypothesis ↔ HighFrequencyZeroFree H", self.bridge_content)

    def test_f4_04_seven_forty_six_five_threshold_equivalence(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:184-190
        Expected Output: theorem RiemannHypothesis_iff_high_frequency_seven_forty_six_five : RiemannHypothesis ↔ HighFrequencyZeroFree (1493 / 200)."""
        self.assertIn("theorem RiemannHypothesis_iff_high_frequency_seven_forty_six_five :", self.bridge_content)
        self.assertIn("RiemannHypothesis ↔ HighFrequencyZeroFree (1493 / 200)", self.bridge_content)

    def test_f4_05_unit_height_threshold_equivalence(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:180-183
        Expected Output: theorem RiemannHypothesis_iff_high_frequency_one : RiemannHypothesis ↔ HighFrequencyZeroFree 1."""
        self.assertIn("theorem RiemannHypothesis_iff_high_frequency_one :", self.bridge_content)
        self.assertIn("RiemannHypothesis ↔ HighFrequencyZeroFree 1", self.bridge_content)

    def test_f4_06_intermediate_threshold_fredholm_restriction(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:21-25
        Expected Output: Functorial restriction intermediate_threshold_fredholm_of_universal."""
        self.assertIn("intermediate_threshold_fredholm_of_universal", self.bridge_content)


if __name__ == "__main__":
    unittest.main()
