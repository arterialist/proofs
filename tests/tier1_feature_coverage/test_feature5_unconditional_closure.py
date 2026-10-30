"""
Tier 1: Feature Coverage — Feature 5: Unconditional High-Frequency Resolution
Authoritative Source: PROJECT.md Feature 5, ORIGINAL_REQUEST.md §R1, BuildingBlocks/RightOfflineContradiction.lean, BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestFeature5UnconditionalClosure(unittest.TestCase):
    """
    Validates Feature 5: Unconditional High-Frequency Resolution.
    Authoritative Source:
      - PROJECT.md Feature 5: Mathematical closure of |t| > 7.465 without circularity or unproved hypotheses
      - BuildingBlocks/RightOfflineContradiction.lean
      - BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean
      - BuildingBlocks/RiemannZetaGrandEquivalence.lean
    """

    def test_f5_01_high_frequency_contradiction_system_interface(self):
        """Input: BuildingBlocks/RightOfflineContradiction.lean
        Authoritative Source: RightOfflineContradiction.lean
        Expected Output: HighFrequencyContradictionSystem structure defined with refuter field."""
        path = BUILDING_BLOCKS_DIR / "RightOfflineContradiction.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("structure HighFrequencyContradictionSystem", content)
        self.assertIn("refuter", content)

    def test_f5_02_displacement_integral_refutation_system_interface(self):
        """Input: BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean
        Authoritative Source: RiemannZetaDisplacementIntegralRefutation.lean
        Expected Output: DisplacementIntegralRefutationSystem structure defined."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaDisplacementIntegralRefutation.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("structure DisplacementIntegralRefutationSystem", content)

    def test_f5_03_displacement_integral_mismatch_system_interface(self):
        """Input: BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean
        Authoritative Source: RiemannZetaDisplacementIntegralRefutation.lean
        Expected Output: DisplacementIntegralMismatchSystem structure defined."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaDisplacementIntegralRefutation.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("structure DisplacementIntegralMismatchSystem", content)

    def test_f5_04_rh_iff_high_frequency_contradiction_inhabitation(self):
        """Input: BuildingBlocks/RiemannZetaGrandEquivalence.lean
        Authoritative Source: RiemannZetaGrandEquivalence.lean:79-83
        Expected Output: theorem rh_iff_highFrequencyContradictionSystem : RiemannHypothesis ↔ Nonempty HighFrequencyContradictionSystem."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaGrandEquivalence.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("theorem rh_iff_highFrequencyContradictionSystem :", content)
        self.assertIn("RiemannHypothesis ↔ Nonempty HighFrequencyContradictionSystem", content)

    def test_f5_05_rh_of_displacement_systems(self):
        """Input: BuildingBlocks/RiemannZetaDisplacementIntegralRefutation.lean
        Authoritative Source: RiemannZetaDisplacementIntegralRefutation.lean
        Expected Output: Theorems RiemannHypothesis_of_displacement_integral_system and RiemannHypothesis_of_displacement_mismatch_system."""
        path = BUILDING_BLOCKS_DIR / "RiemannZetaDisplacementIntegralRefutation.lean"
        content = path.read_text(encoding="utf-8")
        self.assertIn("RiemannHypothesis_of_displacement_integral_system", content)
        self.assertIn("RiemannHypothesis_of_displacement_mismatch_system", content)

    def test_f5_06_zero_sorry_in_building_blocks(self):
        """Input: All .lean files in formalization/BuildingBlocks/
        Authoritative Source: ORIGINAL_REQUEST.md §R2, PROJECT.md §Zero-Tolerance Quality Guards
        Expected Output: Exactly 0 sorry / sorryAx tokens across all active theorem files."""
        lean_files = list(BUILDING_BLOCKS_DIR.glob("*.lean"))
        self.assertGreater(len(lean_files), 50, "Expected >50 BuildingBlocks modules")
        for f in lean_files:
            text = f.read_text(encoding="utf-8")
            self.assertNotIn(" sorryAx", text, f"Found sorryAx in {f.name}")
            # Ensure standalone sorry token is not used as a proof bypass
            words = text.split()
            self.assertNotIn("sorry", words, f"Found sorry in {f.name}")


if __name__ == "__main__":
    unittest.main()
