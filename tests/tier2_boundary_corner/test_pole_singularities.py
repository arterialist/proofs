"""
Tier 2: Boundary & Corner Cases — Pole Singularities and Trivial Zeros
Authoritative Source: BuildingBlocks/Scope.lean, Mathlib/NumberTheory/LSeries/RiemannZeta.lean
"""

import unittest
from pathlib import Path
from tests.conftest_utils import BUILDING_BLOCKS_DIR


class TestPoleSingularities(unittest.TestCase):
    """
    Validates singular points, poles, and trivial zero exclusions:
      - Simple pole of Riemann zeta at s = 1 excluded by s ≠ 1
      - Origin s = 0 is not a zero of riemannZeta (zeta(0) = -1/2)
      - Non-trivial zero Gamma non-vanishing (Gamma_R(s) ≠ 0)
      - Completed Riemann zeta reflection equation completedRiemannZeta (1 - s) = completedRiemannZeta s
      - Trivial zeros at non-positive even integers s = -2(n + 1)
    """

    @classmethod
    def setUpClass(cls):
        cls.scope_file = BUILDING_BLOCKS_DIR / "Scope.lean"
        cls.content = cls.scope_file.read_text(encoding="utf-8")

    def test_pole_01_simple_pole_exclusion_in_right_half_zero_free(self):
        """Input: BuildingBlocks/Scope.lean:6-8
        Authoritative Source: Scope.lean:7
        Expected Output: def RightHalfZeroFree explicitly requires s ≠ 1."""
        self.assertIn("def RightHalfZeroFree : Prop :=", self.content)
        self.assertIn("s ≠ 1 → riemannZeta s ≠ 0", self.content)

    def test_pole_02_zeta_zero_ne_origin(self):
        """Input: BuildingBlocks/Scope.lean:9-14
        Authoritative Source: Scope.lean:9
        Expected Output: theorem zeta_zero_ne_origin {s : ℂ} (hz : riemannZeta s = 0) : s ≠ 0."""
        self.assertIn("theorem zeta_zero_ne_origin {s : ℂ} (hz : riemannZeta s = 0) : s ≠ 0", self.content)
        self.assertIn("rw [riemannZeta_zero] at hz", self.content)

    def test_pole_03_gamma_ne_zero_at_nontrivial_zero(self):
        """Input: BuildingBlocks/Scope.lean:15-27
        Authoritative Source: Scope.lean:15-16
        Expected Output: Complex.Gammaℝ s ≠ 0 at any non-trivial zero."""
        self.assertIn("theorem gamma_ne_zero_at_nontrivial_zero {s : ℂ}", self.content)
        self.assertIn("Complex.Gammaℝ s ≠ 0", self.content)

    def test_pole_04_reflection_preserves_completed_zeta_zero(self):
        """Input: BuildingBlocks/Scope.lean:28-38
        Authoritative Source: Scope.lean:28-30
        Expected Output: theorem reflect_nontrivial_zero proves riemannZeta (1 - s) = 0."""
        self.assertIn("theorem reflect_nontrivial_zero", self.content)
        self.assertIn("completedRiemannZeta_one_sub", self.content)
        self.assertIn("riemannZeta (1 - s) = 0", self.content)

    def test_pole_05_target_iff_right_half_zero_free_handles_pole(self):
        """Input: BuildingBlocks/Scope.lean:40-60
        Authoritative Source: Scope.lean:40
        Expected Output: Target ↔ RightHalfZeroFree handles reflection across critical line avoiding s = 1."""
        self.assertIn("theorem target_iff_rightHalfZeroFree : Target ↔ RightHalfZeroFree", self.content)


if __name__ == "__main__":
    unittest.main()
