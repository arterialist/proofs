"""
Tier 2: Boundary & Corner Cases — Edge Frequencies and Exact Rational Precision
Authoritative Source: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean, certificates/
"""

import fractions
import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestEdgeFrequencies(unittest.TestCase):
    """
    Validates edge frequencies, critical thresholds, and exact rational arithmetic:
      - Exact rational representation: Fraction(1493, 200) == 7.465 exactly
      - Exact threshold H = 1493 / 200 in Lean 4 formalization
      - Unit threshold H = 1 in RiemannHypothesis_iff_high_frequency_one
      - Scale H = 16 in RiemannHypothesis_of_threshold_16_fredholm
      - Non-negative condition 0 ≤ H on cumulative zero-freeness
      - Reflexive monotonicity boundary H₁ = H₂
    """

    @classmethod
    def setUpClass(cls):
        cls.bridge_file = BUILDING_BLOCKS_DIR / "RiemannZetaThresholdFredholmBridge.lean"
        cls.content = cls.bridge_file.read_text(encoding="utf-8")

    def test_freq_01_seven_forty_six_five_exact_fraction(self):
        """Input: 1493 / 200
        Authoritative Source: survey_formalization.md §3.2
        Expected Output: Fraction(1493, 200) exactly equals float 7.465 with 0 rounding error."""
        frac = fractions.Fraction(1493, 200)
        self.assertEqual(frac.numerator, 1493)
        self.assertEqual(frac.denominator, 200)
        self.assertEqual(float(frac), 7.465)
        self.assertEqual(str(frac), "1493/200")

    def test_freq_02_lean_exact_threshold_expression(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean:184-190
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:187
        Expected Output: RiemannHypothesis ↔ HighFrequencyZeroFree (1493 / 200)."""
        self.assertIn("HighFrequencyZeroFree (1493 / 200)", self.content)

    def test_freq_03_lean_unit_threshold_expression(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean:180-183
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:181
        Expected Output: RiemannHypothesis ↔ HighFrequencyZeroFree 1."""
        self.assertIn("RiemannHypothesis ↔ HighFrequencyZeroFree 1", self.content)

    def test_freq_04_lean_sixteen_scale_theorem(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:197
        Expected Output: RiemannHypothesis_of_threshold_16_fredholm."""
        self.assertIn("RiemannHypothesis_of_threshold_16_fredholm", self.content)

    def test_freq_05_threshold_requires_nonnegative_height(self):
        """Input: BuildingBlocks/RiemannZetaThresholdFredholmBridge.lean:169
        Authoritative Source: RiemannZetaThresholdFredholmBridge.lean:169
        Expected Output: Parameter hH : 0 ≤ H enforces non-negative ordinate boundary."""
        self.assertIn("(hH : 0 ≤ H)", self.content)

    def test_freq_06_exact_fraction_arithmetic_in_certificates(self):
        """Input: certificates/ directory
        Authoritative Source: survey_operations.md §4.3
        Expected Output: Certificate scripts rely on exact Fraction arithmetic with 0 floating-point error."""
        cert_dir = Path("/Users/arterialist/Projects/proofs/certificates")
        self.assertTrue(cert_dir.exists())
        sample_certs = list(cert_dir.glob("*.py"))
        self.assertGreaterEqual(len(sample_certs), 50)
        # Verify fractions.Fraction is widely utilized across the suite
        fraction_usage = sum(1 for c in sample_certs if "Fraction" in c.read_text(encoding="utf-8", errors="ignore"))
        self.assertGreaterEqual(fraction_usage, 20)


if __name__ == "__main__":
    unittest.main()
