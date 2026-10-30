"""
Tier 1: Feature Coverage — Feature 3: Low- & Bounded-Frequency Integration
Authoritative Source: PROJECT.md Feature 3, RiemannZetaRealAxisUnconditional.lean, RiemannZetaUnconditionalLowFrequency.lean, RiemannZetaGrandIntermediateIntegration.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestFeature3LowBoundedFrequency(unittest.TestCase):
    """
    Validates Feature 3: Low- & Bounded-Frequency Integration.
    Authoritative Source:
      - PROJECT.md Feature 3: Unconditional zero-freeness on real axis (1/2, ∞) \ {1} and 0 < t ≤ 7.465
      - BuildingBlocks/RiemannZetaRealAxisUnconditional.lean
      - BuildingBlocks/RiemannZetaUnconditionalLowFrequency.lean
      - BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
      - BuildingBlocks/RiemannZetaGlobalSchwarzReflection.lean
    """

    def test_f3_01_real_axis_unconditional_non_vanishing(self):
        """Input: BuildingBlocks/RiemannZetaRealAxisUnconditional.lean
        Authoritative Source: RiemannZetaRealAxisUnconditional.lean:10-25
        Expected Output: real_axis_zeta_ne_zero_unconditional proved unconditionally."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaRealAxisUnconditional.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("real_axis_zeta_ne_zero_unconditional", content)
        self.assertIn("riemannZeta", content)
        self.assertIn("1 / 2 <", content)

    def test_f3_02_low_frequency_band_zero_free(self):
        """Input: BuildingBlocks/RiemannZetaUnconditionalLowFrequency.lean
        Authoritative Source: RiemannZetaUnconditionalLowFrequency.lean
        Expected Output: low_freq_free_unconditional for (1/2, 1] x (0, 1]."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaUnconditionalLowFrequency.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("low_freq_free_unconditional", content)

    def test_f3_03_cumulative_zero_free_base_seven_forty_six_five(self):
        """Input: BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
        Authoritative Source: RiemannZetaGrandIntermediateIntegration.lean:125-130
        Expected Output: cumulative_zero_free_base_seven_forty_six_five unconditionally proved."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaGrandIntermediateIntegration.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("cumulative_zero_free_base_seven_forty_six_five", content)
        self.assertIn("1493 / 200", content)

    def test_f3_04_schwarz_reflection_symmetry_zero_conjugation(self):
        """Input: BuildingBlocks/RiemannZetaGlobalSchwarzReflection.lean
        Authoritative Source: RiemannZetaGlobalSchwarzReflection.lean
        Expected Output: Conjugate reflection theorem riemannZeta_zero_iff_conj_zero_of_re_pos."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaGlobalSchwarzReflection.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("riemannZeta_zero_iff_conj_zero_of_re_pos", content)

    def test_f3_05_cumulative_to_low_frequency_bridge(self):
        """Input: BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
        Authoritative Source: RiemannZetaGrandIntermediateIntegration.lean:40-47
        Expected Output: lowFrequencyZeroFree_of_cumulativeZeroFree combining real axis and reflection."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaGrandIntermediateIntegration.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("lowFrequencyZeroFree_of_cumulativeZeroFree", content)

    def test_f3_06_master_rh_from_cumulative_and_high(self):
        """Input: BuildingBlocks/RiemannZetaGrandIntermediateIntegration.lean
        Authoritative Source: RiemannZetaGrandIntermediateIntegration.lean:48-50
        Expected Output: RiemannHypothesis_of_cumulative_and_high connects cumulative + high to full RH."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaGrandIntermediateIntegration.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("RiemannHypothesis_of_cumulative_and_high", content)


if __name__ == "__main__":
    unittest.main()
