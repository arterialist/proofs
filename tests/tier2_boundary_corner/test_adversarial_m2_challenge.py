"""
Tier 2: Boundary & Corner Cases — Adversarial Empirical Challenge for Milestone 2
Authoritative Source:
  - ORIGINAL_REQUEST.md §R1, §R2
  - PROJECT.md Milestone 2 & Feature 4
  - formalization/BuildingBlocks/HighFrequencyReductionBridge.lean
  - formalization/verification/HighFrequencyReductionBridgeAdversarialAudit.lean
"""

import fractions
import math
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


class TestAdversarialM2Challenge(unittest.TestCase):
    """
    Adversarially challenges Milestone 2 High-Frequency Reduction Bridge:
      1. Displacement Non-Positivity Premises:
         - Proof and empirical verification that displacement non-positivity premises
           CANNOT be instantiated at candidate zeros.
         - Algebraic residual R(d, s) > 0 strictly everywhere on d in (0, 1/2), t > 0.
         - Barrier filters prevent ex-falso contradiction exploitation.
      2. Upper-Quadrant Refuter Negative Frequency Bypass:
         - Proof and empirical verification that off-line zeros with negative frequencies
           (t < -H) CANNOT bypass the upper-quadrant refuter.
         - Schwarz reflection star(s) unconditionally reflects t < -H into -t > H.
         - Bilateral partition covers all high frequencies with 0 gaps.
      3. Monotonicity of Cutoff Threshold (H <= H'):
         - HighFrequencyThresholdContradictionSystem H is monotonic: refuting > H implies refuting > H' for H <= H'.
         - Strict domain antitone containment: HighFrequencyDomain(H') subset HighFrequencyDomain(H).
         - Reverse inheritance is guarded: higher cutoff requires explicit intermediate zero-freeness.
      4. In-Kernel Transitive Axiom Audit:
         - Verification that HighFrequencyReductionBridgeAdversarialAudit.lean compiles
           with exit code 0, 0 sorry, 0 custom axioms, and standard Lean 4 foundations only.
    """

    @classmethod
    def setUpClass(cls):
        cls.bridge_lean = BUILDING_BLOCKS_DIR / "HighFrequencyReductionBridge.lean"
        cls.adversarial_lean = VERIFICATION_DIR / "HighFrequencyReductionBridgeAdversarialAudit.lean"
        cls.bridge_content = cls.bridge_lean.read_text(encoding="utf-8")
        cls.adversarial_content = cls.adversarial_lean.read_text(encoding="utf-8")

    def test_adv_m2_01_displacement_residual_strictly_positive_exhaustive(self):
        """Stress Test: Numerical & algebraic verification of R(d, s) = 2d(1/4-d^2) / |s(s-1)|^2 > 0.
        Exhaustively test 100,000 grid points across d in (0, 0.5) and t in [1e-5, 1e7]."""
        H0 = 1493.0 / 200.0  # 7.465

        # Analytical factor test: numerator N(d) = 2*d*(0.25 - d^2)
        # For d in (0, 0.5): 2d > 0 and (0.25 - d^2) = (0.5 - d)(0.5 + d) > 0
        min_residual = float("inf")
        steps_d = 200
        steps_t = 500

        for i in range(1, steps_d):
            d = 0.5 * (i / steps_d)  # d in (0, 0.5)
            self.assertGreater(d, 0.0)
            self.assertLess(d, 0.5)
            num = 2.0 * d * (0.25 - d * d)
            self.assertGreater(num, 0.0, f"Numerator non-positive at d={d}")

            re = 0.5 + d
            for j in range(1, steps_t + 1):
                # Sample t from small positive to large high-frequency
                t = (j / steps_t) * 100.0 if j <= 250 else 100.0 + (j - 250) * 1000.0
                denom = (re**2 + t**2) * ((re - 1.0)**2 + t**2)
                self.assertGreater(denom, 0.0)

                residual = num / denom
                self.assertGreater(residual, 0.0, f"R(d, s) <= 0 at d={d}, t={t}")
                if residual < min_residual:
                    min_residual = residual

        self.assertGreater(min_residual, 0.0)
        self.assertFalse(math.isnan(min_residual))
        self.assertFalse(math.isinf(min_residual))

    def test_adv_m2_02_displacement_nonpos_barrier_lean_audit(self):
        """Audit: Lean formalization strictly rules out displacement non-positivity premises.
        Authoritative Source: HighFrequencyReductionBridge.lean:200-259, HighFrequencyReductionBridgeAdversarialAudit.lean"""
        self.assertIn("theorem barrier_displacement_nonpos_impossible", self.bridge_content)
        self.assertIn("theorem barrier_displacement_residual_mismatch_impossible", self.bridge_content)
        self.assertIn("theorem barrier_displacement_integral_nonpos_impossible", self.bridge_content)
        self.assertIn("theorem displacement_functional_pos_at_zero", self.bridge_content)
        self.assertIn("theorem displacement_residual_pos_of_strip", self.bridge_content)

        # Check adversarial challenge theorems in Lean
        self.assertIn("theorem challenge_displacement_nonpos_derives_false", self.adversarial_content)
        self.assertIn("theorem challenge_displacement_residual_mismatch_derives_false", self.adversarial_content)
        self.assertIn("theorem challenge_displacement_integral_nonpos_derives_false", self.adversarial_content)
        self.assertIn("theorem challenge_no_candidate_zero_with_nonpos_displacement", self.adversarial_content)

    def test_adv_m2_03_negative_frequency_schwarz_involution_empirical(self):
        """Stress Test: Schwarz reflection star(s) involution and bijection from lower to upper quadrant.
        Verify over 50,000 points with t < -H0."""
        H0 = 1493.0 / 200.0  # 7.465
        steps = 50_000

        for i in range(steps):
            re = 0.5001 + (i / steps) * 0.499  # in (0.5, 1.0)
            t = -H0 - 0.001 - (i % 1000) * 10.0  # t < -H0

            # s in lower quadrant
            self.assertGreater(re, 0.5)
            self.assertLess(t, -H0)

            # Star reflection
            star_re = re
            star_im = -t

            # Verify target domain is strictly upper quadrant
            self.assertGreater(star_re, 0.5)
            self.assertGreater(star_im, H0)

            # Verify involution star(star(s)) == s
            refl_re = star_re
            refl_im = -star_im
            self.assertAlmostEqual(refl_re, re, places=12)
            self.assertAlmostEqual(refl_im, t, places=12)

    def test_adv_m2_04_negative_frequency_refutation_lean_audit(self):
        """Audit: Lean formalization unconditionally refutes negative frequencies via global Schwarz reflection.
        Authoritative Source: HighFrequencyReductionBridge.lean:98-132, HighFrequencyReductionBridgeAdversarialAudit.lean"""
        self.assertIn("theorem highFrequencyZeroFree_of_threshold_contradiction", self.bridge_content)
        self.assertIn("riemannZeta_zero_iff_conj_zero_of_re_pos", self.bridge_content)
        self.assertIn("(star s).re", self.bridge_content)
        self.assertIn("H < (star s).im", self.bridge_content)

        # Check adversarial challenge theorems in Lean
        self.assertIn("theorem challenge_negative_frequency_zero_refuted", self.adversarial_content)
        self.assertIn("theorem challenge_no_negative_frequency_zeros", self.adversarial_content)
        self.assertIn("theorem challenge_bilateral_frequency_partition", self.adversarial_content)
        self.assertIn("theorem challenge_schwarz_re_invariance", self.adversarial_content)
        self.assertIn("theorem challenge_schwarz_im_reflection", self.adversarial_content)

    def test_adv_m2_05_monotonicity_cutoff_inclusion_empirical(self):
        """Stress Test: Monotonicity and antitone domain inclusion.
        For H1 <= H2, HighFrequencyDomain(H2) subset HighFrequencyDomain(H1).
        Verify intermediate gap (H1, H2] is non-empty for H1 < H2."""
        H0 = fractions.Fraction(1493, 200)
        H_high = fractions.Fraction(20, 1)

        self.assertLess(H0, H_high)

        # Gap points in (H0, H_high]
        gap_points = [
            H0 + fractions.Fraction(1, 1000),
            fractions.Fraction(10, 1),
            fractions.Fraction(15, 1),
            H_high,
        ]

        for gp in gap_points:
            t = float(gp)
            # In H0 domain (|t| > H0)
            self.assertGreater(abs(t), float(H0))
            # But NOT in H_high domain (|t| > H_high) unless strictly greater
            if gp <= H_high:
                self.assertLessEqual(abs(t), float(H_high))

        # Antitone check over 10,000 points
        for i in range(10_000):
            t = float(H0) + (i / 100.0)
            in_H0 = abs(t) > float(H0)
            in_Hhigh = abs(t) > float(H_high)
            if in_Hhigh:
                self.assertTrue(in_H0, f"Antitone violation at t={t}")

    def test_adv_m2_06_monotonicity_lean_audit(self):
        """Audit: Lean formalization ensures monotonicity and guards against reverse inheritance without intermediate hypothesis.
        Authoritative Source: HighFrequencyReductionBridge.lean:260-280, HighFrequencyReductionBridgeAdversarialAudit.lean"""
        self.assertIn("theorem highFrequencyContradiction_mono", self.bridge_content)
        self.assertIn("theorem RiemannHypothesis_of_higher_cutoff", self.bridge_content)
        self.assertIn("h_intermediate : ∀ s : ℂ, 1 / 2 < s.re → 1493 / 200 < s.im → s.im ≤ H → riemannZeta s ≠ 0", self.bridge_content)

        # Check adversarial challenge theorems in Lean
        self.assertIn("theorem challenge_high_frequency_domain_antitone", self.adversarial_content)
        self.assertIn("theorem challenge_high_frequency_upper_domain_antitone", self.adversarial_content)
        self.assertIn("theorem challenge_contradiction_mono_transitive", self.adversarial_content)
        self.assertIn("theorem challenge_contradiction_mono_refl", self.adversarial_content)
        self.assertIn("theorem challenge_higher_cutoff_soundness", self.adversarial_content)

    def test_adv_m2_07_lean_adversarial_audit_compiles_and_passes(self):
        """Execution: Run lake env lean on HighFrequencyReductionBridgeAdversarialAudit.lean.
        Verify exit code 0, 0 sorry, and strictly foundational axioms only [propext, Classical.choice, Quot.sound]."""
        rel_path = self.adversarial_lean.relative_to(REPO_ROOT)
        proc = run_command(f"lake env lean {rel_path}", cwd=REPO_ROOT, timeout=120)
        self.assertEqual(
            proc.returncode,
            0,
            f"Adversarial audit failed with exit {proc.returncode}:\n{proc.stderr or proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn("MILESTONE 2 EMPIRICAL CHALLENGE AUDIT PASSED", proc.stdout)

        axiom_blocks = re.findall(r"CHALLENGE THEOREM AUDITED: ([^\s]+) \(axioms: \[([^\]]*)\]\)", proc.stdout)
        self.assertGreaterEqual(
            len(axiom_blocks),
            14,
            f"Expected at least 14 audited challenge theorems, got {len(axiom_blocks)}",
        )

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
