"""
Tier 3: Cross-Feature Interactions — Coupling Support Duality and Reflection Symmetry
Authoritative Source: BuildingBlocks/UnilateralOfflineSupportBridge.lean, BuildingBlocks/RiemannZetaUpperHalfPlaneReduction.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestSupportDualitySymmetryCoupling(unittest.TestCase):
    """
    Validates cross-feature coupling between:
      Feature 2: Grand Equivalence Network
      Feature 3: Unconditional Reflection and Upper Half-Plane Reduction

    Mathematical Interaction:
      The unilateral support emptiness:
        RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅
      is coupled with the quadrant reduction:
        RiemannHypothesis ↔ (∀ s, 1/2 < s.re → 0 < s.im → riemannZeta s ≠ 0)
      via the 4-fold zero distinctness:
        Any zero s with 1/2 < s.re generates {s, conj(s), 1-s, 1-conj(s)},
        meaning upper-quadrant zero-freeness forces emptiness of both off-line supports.
    """

    @classmethod
    def setUpClass(cls):
        cls.bridge_file = BUILDING_BLOCKS_DIR / "UnilateralOfflineSupportBridge.lean"
        cls.upper_file = BUILDING_BLOCKS_DIR / "RiemannZetaUpperHalfPlaneReduction.lean"
        cls.bridge_content = cls.bridge_file.read_text(encoding="utf-8")
        cls.upper_content = cls.upper_file.read_text(encoding="utf-8")

    def test_duality_01_right_to_left_reflection_preserves_offline_support(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:90-100
        Expected Output: theorem right_offline_to_left_offline proves s ∈ RightOfflineSupport → (1 - s) ∈ LeftOfflineSupport."""
        self.assertIn("theorem right_offline_to_left_offline", self.bridge_content)
        self.assertIn("(1 - s) ∈ LeftOfflineSupport", self.bridge_content)

    def test_duality_02_left_to_right_reflection_preserves_offline_support(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:101-114
        Expected Output: theorem left_offline_to_right_offline proves s ∈ LeftOfflineSupport → (1 - s) ∈ RightOfflineSupport."""
        self.assertIn("theorem left_offline_to_right_offline", self.bridge_content)
        self.assertIn("(1 - s) ∈ RightOfflineSupport", self.bridge_content)

    def test_duality_03_spectral_confinement_iff_spectral_distance_zero(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:170-179
        Expected Output: SpectralSupportConfinement ↔ ∀ s ∈ SpectralZeroSupport, spectralDistance s = 0."""
        self.assertIn("spectralSupportConfinement_iff_spectralDistance_zero", self.bridge_content)
        self.assertIn("spectralDistance s = 0", self.bridge_content)

    def test_duality_04_spectral_confinement_iff_riemann_hypothesis(self):
        """Input: BuildingBlocks/UnilateralOfflineSupportBridge.lean
        Authoritative Source: UnilateralOfflineSupportBridge.lean:160-169
        Expected Output: SpectralSupportConfinement ↔ RiemannHypothesis."""
        self.assertIn("spectralSupportConfinement_iff_RiemannHypothesis", self.bridge_content)


if __name__ == "__main__":
    unittest.main()
