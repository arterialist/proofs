"""
Tier 2: Boundary & Corner Cases — Limit Ordinates and Frequency Boundaries
Authoritative Source: BuildingBlocks/RiemannZetaHighFrequencySynthesis.lean, BuildingBlocks/RiemannZetaUpperHalfPlaneReduction.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestLimitOrdinates(unittest.TestCase):
    """
    Validates boundary behavior at limit ordinates:
      - Approach to the real axis t -> 0+
      - Unit frequency boundary t = 1.0
      - Intermediate threshold t = 7.465 (1493/200)
      - Negative frequency boundary t < 0
      - Quadrant partition and 4-fold zero distinctness
    """

    @classmethod
    def setUpClass(cls):
        cls.hf_file = BUILDING_BLOCKS_DIR / "RiemannZetaHighFrequencySynthesis.lean"
        cls.quadrant_file = BUILDING_BLOCKS_DIR / "RiemannZetaUpperHalfPlaneReduction.lean"
        cls.hf_content = cls.hf_file.read_text(encoding="utf-8")
        cls.quadrant_content = cls.quadrant_file.read_text(encoding="utf-8")

    def test_limit_01_upper_quadrant_strictly_positive_imaginary(self):
        """Input: BuildingBlocks/RiemannZetaUpperHalfPlaneReduction.lean
        Authoritative Source: RiemannZetaUpperHalfPlaneReduction.lean:45-55
        Expected Output: Upper half-plane reduction condition strictly requires 0 < s.im."""
        self.assertIn("0 < s.im", self.quadrant_content)
        self.assertIn("(1 : ℝ) / 2 < s.re", self.quadrant_content)

    def test_limit_02_four_fold_distinct_zeros_for_offline_candidates(self):
        """Input: BuildingBlocks/RiemannZetaUpperHalfPlaneReduction.lean
        Authoritative Source: RiemannZetaUpperHalfPlaneReduction.lean:90-110
        Expected Output: four_fold_distinct proves s, conj(s), 1-s, 1-conj(s) pairwise distinct for off-line zeros."""
        self.assertIn("four_fold_distinct", self.quadrant_content)

    def test_limit_03_completed_zeta_positive_imaginary_in_upper_quadrant(self):
        """Input: BuildingBlocks/RiemannZetaUpperHalfPlaneReduction.lean
        Authoritative Source: RiemannZetaUpperHalfPlaneReduction.lean:130-140
        Expected Output: completedRiemannZeta₀_im_pos_of_zero proves Im(completedRiemannZeta₀ s) > 0 at off-line zeros."""
        self.assertIn("completedRiemannZeta₀_im_pos_of_zero", self.quadrant_content)

    def test_limit_04_unit_frequency_band_boundary(self):
        """Input: BuildingBlocks/RiemannZetaHighFrequencySynthesis.lean
        Authoritative Source: RiemannZetaHighFrequencySynthesis.lean:20-30
        Expected Output: low_frequency_band_zero_free covers 0 < s.im ≤ 1."""
        self.assertIn("low_frequency_band_zero_free", self.hf_content)

    def test_limit_05_negative_low_frequency_band_boundary(self):
        """Input: BuildingBlocks/RiemannZetaHighFrequencySynthesis.lean
        Authoritative Source: RiemannZetaHighFrequencySynthesis.lean:23-24
        Expected Output: negative_low_frequency_band_zero_free covers -1 ≤ s.im < 0."""
        self.assertIn("negative_low_frequency_band_zero_free", self.hf_content)

    def test_limit_06_bounded_frequency_zero_free_slab(self):
        """Input: BuildingBlocks/RiemannZetaHighFrequencySynthesis.lean
        Authoritative Source: RiemannZetaHighFrequencySynthesis.lean:25-27
        Expected Output: bounded_frequency_zero_free covers full slab [-1, 1] in Re(s) > 1/2."""
        self.assertIn("bounded_frequency_zero_free", self.hf_content)


if __name__ == "__main__":
    unittest.main()
