"""
Tier 1: Feature Coverage — Feature 1: Canonical RH Definition
Authoritative Source: ORIGINAL_REQUEST.md §R1, PROJECT.md Feature 1, Mathlib/NumberTheory/LSeries/RiemannZeta.lean:185
"""

import unittest
from pathlib import Path
from tests.conftest_utils import REPO_ROOT, BUILDING_BLOCKS_DIR


class TestFeature1CanonicalRH(unittest.TestCase):
    """
    Validates Feature 1: Canonical RH Definition.
    Authoritative Source:
      - ORIGINAL_REQUEST.md §R1:
          def RiemannHypothesis : Prop :=
            ∀ (s : ℂ) (_ : riemannZeta s = 0) (_ : ¬∃ n : ℕ, s = -2 * (n + 1)) (_ : s ≠ 1), s.re = 1 / 2
      - PROJECT.md Feature 1:
          Canonical RH Definition matching Mathlib `RiemannHypothesis`
      - Target.lean: def Target : Prop := RiemannHypothesis
    """

    def test_f1_01_target_lean_contains_canonical_definition(self):
        """Input: formalization/BuildingBlocks/Target.lean
        Authoritative Source: PROJECT.md §Feature 1, Target.lean:6
        Expected Output: def Target : Prop := RiemannHypothesis exactly present."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        self.assertTrue(target_file.exists(), f"Missing {target_file}")
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("def Target : Prop := RiemannHypothesis", content)

    def test_f1_02_target_iff_full_statement_reflexive(self):
        """Input: formalization/BuildingBlocks/Target.lean
        Authoritative Source: Target.lean:9-12
        Expected Output: Theorem target_iff_full_statement proven with Iff.rfl."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("theorem target_iff_full_statement : Target ↔", content)
        self.assertIn("s ≠ 1 → s.re = 1 / 2 := Iff.rfl", content)

    def test_f1_03_trivial_zero_predicate_negation(self):
        """Input: formalization/BuildingBlocks/Target.lean & Scope.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R1
        Expected Output: Trivial zero filter explicitly requires (¬ ∃ n : ℕ, s = -2 * (n + 1))."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("¬ ∃ n : ℕ, s = -2 * (n + 1)", content)

    def test_f1_04_pole_singularity_exclusion(self):
        """Input: formalization/BuildingBlocks/Target.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R1
        Expected Output: Pole at s = 1 is explicitly excluded with condition s ≠ 1."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("s ≠ 1", content)

    def test_f1_05_critical_line_real_part_target(self):
        """Input: formalization/BuildingBlocks/Target.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R1
        Expected Output: Real part condition is exact rational 1 / 2."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("s.re = 1 / 2", content)

    def test_f1_06_riemann_hypothesis_in_mathlib_import(self):
        """Input: formalization/BuildingBlocks/Target.lean imports
        Authoritative Source: PROJECT.md §Architecture
        Expected Output: Imports Mathlib.NumberTheory.LSeries.RiemannZeta."""
        target_file = BUILDING_BLOCKS_DIR / "Target.lean"
        content = target_file.read_text(encoding="utf-8")
        self.assertIn("import Mathlib.NumberTheory.LSeries.RiemannZeta", content)


if __name__ == "__main__":
    unittest.main()
