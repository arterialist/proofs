"""
Tier 2: Boundary & Corner Cases — Adversarial Empirical Challenge for Milestone 1
Authoritative Source:
  - ORIGINAL_REQUEST.md §R1, §R2
  - PROJECT.md Milestone 1 & Feature 1-4
  - formalization/verification/RiemannHypothesisTargetAdversarialAudit.lean
"""

import re
import sys
import unittest
from pathlib import Path

# Add project root to sys.path
REPO_ROOT_PATH = Path(__file__).resolve().parent.parent.parent
if str(REPO_ROOT_PATH) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT_PATH))

from tests.conftest_utils import (
    REPO_ROOT,
    BUILDING_BLOCKS_DIR,
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


class TestAdversarialM1Challenge(unittest.TestCase):
    """
    Adversarially challenges Milestone 1:
      1. Canonical RH exactness vs Mathlib (0 relaxation, definitional match).
      2. Non-vacuousness: Off-line zeros unconditionally refute all 10 grand equivalence formulations.
      3. Reduction interface tightness: Strict dichotomy at H = 1493/200 with zero gap.
      4. In-kernel transitive axiom verification: only [propext, Classical.choice, Quot.sound].
    """

    @classmethod
    def setUpClass(cls):
        cls.target_lean = BUILDING_BLOCKS_DIR / "RiemannHypothesisTarget.lean"
        cls.adversarial_lean = VERIFICATION_DIR / "RiemannHypothesisTargetAdversarialAudit.lean"
        cls.target_content = cls.target_lean.read_text(encoding="utf-8")
        cls.adversarial_content = cls.adversarial_lean.read_text(encoding="utf-8")

    def test_adv_01_canonical_rh_definitional_equality_mathlib(self):
        """Input: formalization/BuildingBlocks/RiemannHypothesisTarget.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R1, Target.lean:6
        Expected Output: def canonicalRiemannHypothesis : Prop := RiemannHypothesis exactly."""
        self.assertIn(
            "def canonicalRiemannHypothesis : Prop := RiemannHypothesis",
            self.target_content,
        )
        self.assertIn(
            "theorem target_eq_canonical : Target = RiemannHypothesis := rfl",
            self.target_content,
        )
        self.assertIn(
            "theorem rh_iff_target : RiemannHypothesis ↔ Target := Iff.rfl",
            self.target_content,
        )

    def test_adv_02_all_grand_equivalences_refute_offline_zeros(self):
        """Input: formalization/verification/RiemannHypothesisTargetAdversarialAudit.lean
        Authoritative Source: master_grand_offline_zero_refutation
        Expected Output: If an offline zero exists, ALL 10 formulations are refuted simultaneously."""
        self.assertIn("theorem master_grand_offline_zero_refutation", self.adversarial_content)
        self.assertIn("IsOfflineZero", self.adversarial_content)
        for sub in [
            "¬ Target",
            "¬ RightHalfZeroFree",
            "¬ (RightOfflineSupport = ∅)",
            "¬ (LeftOfflineSupport = ∅)",
            "¬ SpectralSupportConfinement",
            "¬ (∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0)",
            "¬ (∀ s : ℂ, 1 / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0)",
            "¬ HolomorphicZetaODE",
            "¬ HighFrequencyZeroFree (1493 / 200)",
        ]:
            self.assertIn(sub, self.adversarial_content)

    def test_adv_03_ordinate_dichotomy_zero_gap_boundary(self):
        """Input: formalization/verification/RiemannHypothesisTargetAdversarialAudit.lean
        Authoritative Source: ordinate_partition_exhaustive
        Expected Output: Complete partition |s.im| ≤ 1493 / 200 ∨ 1493 / 200 < |s.im| leaving zero gap."""
        self.assertIn("theorem ordinate_partition_exhaustive", self.adversarial_content)
        self.assertIn(
            "|s.im| ≤ 1493 / 200 ∨ 1493 / 200 < |s.im|",
            self.adversarial_content,
        )

    def test_adv_04_pointwise_closure_below_and_above_boundary(self):
        """Input: formalization/verification/RiemannHypothesisTargetAdversarialAudit.lean
        Authoritative Source: point_closure_of_m1_reduction
        Expected Output: Pointwise closure showing every s with Re(s) > 1/2, s ≠ 1 is non-vanishing."""
        self.assertIn("theorem point_closure_of_m1_reduction", self.adversarial_content)
        self.assertIn(
            "HighFrequencyZeroFree (1493 / 200)",
            self.adversarial_content,
        )

    def test_adv_05_lean_adversarial_audit_compiles_and_passes(self):
        """Input: formalization/verification/RiemannHypothesisTargetAdversarialAudit.lean
        Authoritative Source: ORIGINAL_REQUEST.md §R2
        Expected Output: Lean 4 compilation succeeds with exit code 0, 0 sorry, and standard axioms only."""
        rel_path = self.adversarial_lean.relative_to(REPO_ROOT)
        proc = run_command(f"lake env lean {rel_path}", cwd=REPO_ROOT, timeout=120)
        self.assertEqual(
            proc.returncode,
            0,
            f"Adversarial audit failed with exit {proc.returncode}:\n{proc.stderr or proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn("ADVERSARIAL EMPIRICAL CHALLENGE AUDIT PASSED", proc.stdout)

        axiom_blocks = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", proc.stdout)
        for decl, ax_str in axiom_blocks:
            axioms = {a.strip() for a in ax_str.split(",") if a.strip()}
            disallowed = axioms - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                len(disallowed),
                0,
                f"Declaration {decl} depends on disallowed axioms: {disallowed}",
            )


if __name__ == "__main__":
    unittest.main()
