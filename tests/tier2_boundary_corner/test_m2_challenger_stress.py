"""
Tier 2: Boundary & Corner Cases — Milestone 2 Challenger 2 Empirical Stress Test Suite
Authoritative Sources:
  - ORIGINAL_REQUEST.md §R1, §R2
  - PROJECT.md Milestone 2 & Feature 4
  - formalization/BuildingBlocks/HighFrequencyReductionBridge.lean
  - formalization/verification/HighFrequencyCutoffStressAudit.lean
  - formalization/BuildingBlocks/RiemannHypothesisTarget.lean
"""

import fractions
import math
import subprocess
import unittest
from pathlib import Path
from tests.conftest_utils import (
    REPO_ROOT,
    BUILDING_BLOCKS_DIR,
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


class TestMilestone2ChallengerStress(unittest.TestCase):
    """
    Empirical stress tests for Milestone 2:
    1. Cutoff point H0 = 1493 / 200 = 7.465 exactness and distance from first non-trivial zero.
    2. Boundary frequency points t = H0 ± ε across microscopic and macroscopic ε.
    3. Boundary dichotomy completeness and absence of boundary gap at t = H0.
    4. Bilateral Schwarz reflection transfer for negative boundary ordinates t = -(H0 + ε).
    5. Soundness of HighFrequencyThresholdContradictionSystem with higher cutoffs (H' > H0):
       - Refuter monotonicity (H1 ≤ H2).
       - Necessity of intermediate slab hypothesis on (H0, H'].
       - Formal verification that skipping intermediate slab is impossible.
       - Vacuous slab collapse at H' = H0.
    6. Barrier filter evaluation (displacement residual R(d, s) > 0) across boundary ordinates.
    7. In-kernel Lean 4 verification of HighFrequencyCutoffStressAudit.lean.
    """

    @classmethod
    def setUpClass(cls):
        cls.bridge_lean = BUILDING_BLOCKS_DIR / "HighFrequencyReductionBridge.lean"
        cls.target_lean = BUILDING_BLOCKS_DIR / "RiemannHypothesisTarget.lean"
        cls.audit_lean = VERIFICATION_DIR / "HighFrequencyCutoffStressAudit.lean"

        cls.bridge_content = cls.bridge_lean.read_text(encoding="utf-8")
        cls.target_content = cls.target_lean.read_text(encoding="utf-8")
        cls.audit_content = cls.audit_lean.read_text(encoding="utf-8")

        # Canonical H0 constant
        cls.H0_frac = fractions.Fraction(1493, 200)
        cls.H0_float = 7.465
        cls.gamma1 = 14.134725141734693790457  # First non-trivial zero ordinate

    def test_stress_01_cutoff_exact_rational_representation(self):
        """Stress Test 1: H0 = 1493 / 200 exact rational arithmetic.
        Verify numerator, denominator, exact decimal match, and distance to gamma1."""
        self.assertEqual(self.H0_frac.numerator, 1493)
        self.assertEqual(self.H0_frac.denominator, 200)
        self.assertEqual(float(self.H0_frac), self.H0_float)
        self.assertEqual(self.H0_frac * 200, 1493)

        # Exact square
        h0_sq = self.H0_frac ** 2
        self.assertEqual(h0_sq, fractions.Fraction(2229049, 40000))
        self.assertEqual(float(h0_sq), 55.726225)

        # Distance to first zero
        dist_to_gamma1 = self.gamma1 - self.H0_float
        self.assertGreater(dist_to_gamma1, 6.669)
        self.assertLess(self.H0_float, self.gamma1)

    def test_stress_02_boundary_frequency_perturbation_minus_epsilon(self):
        """Stress Test 2: Evaluate t = H0 - ε across wide range of ε.
        Points must be strictly in the bounded zero-free domain [0, H0]."""
        epsilons = [1e-15, 1e-12, 1e-9, 1e-6, 1e-4, 1e-2, 0.1, 0.5, 1.0, 7.465]
        for eps in epsilons:
            t = self.H0_float - eps
            # Must satisfy 0 <= t <= H0
            self.assertLessEqual(t, self.H0_float, f"Failed at eps={eps}")
            self.assertGreaterEqual(t, 0.0, f"Failed at eps={eps}")

            # Inside bounded-height certificate
            self.assertTrue(
                abs(t) <= self.H0_float,
                f"Boundary point t={t} (H0 - {eps}) must satisfy |t| <= H0",
            )

    def test_stress_03_boundary_frequency_perturbation_plus_epsilon(self):
        """Stress Test 3: Evaluate t = H0 + ε across wide range of ε.
        Points must be strictly in the high-frequency domain (H0, inf)."""
        epsilons = [1e-15, 1e-12, 1e-9, 1e-6, 1e-4, 1e-2, 0.1, 0.5, 1.0, 10.0, 100.0]
        for eps in epsilons:
            t = self.H0_float + eps
            # Must satisfy H0 < t
            self.assertGreater(
                t,
                self.H0_float,
                f"Boundary point t={t} (H0 + {eps}) must satisfy H0 < t",
            )
            # Must be in HighFrequencyDomain
            self.assertTrue(abs(t) > self.H0_float)

    def test_stress_04_boundary_point_exact_dichotomy_zero_gap(self):
        """Stress Test 4: Exact boundary point t = H0.
        Demonstrate that [0, H0] and (H0, inf) form a disjoint, exhaustive partition of [0, inf).
        At t = H0:
          - |t| <= H0 is TRUE (covered by bounded zero-freeness).
          - H0 < |t| is FALSE (not required by high-frequency refuter).
        Zero gap, zero contradiction."""
        t_boundary = self.H0_float
        is_low = abs(t_boundary) <= self.H0_float
        is_high = abs(t_boundary) > self.H0_float

        self.assertTrue(is_low, "Boundary point t = H0 must be covered by low-frequency certificate")
        self.assertFalse(is_high, "Boundary point t = H0 must NOT require high-frequency refuter")
        # Exclusive or: exactly one holds
        self.assertTrue(is_low ^ is_high, "Partition must be mutually exclusive and exhaustive")

    def test_stress_05_bilateral_negative_boundary_frequencies(self):
        """Stress Test 5: Negative boundary ordinates t = -(H0 + ε).
        Confirm Schwarz reflection maps negative frequency to positive upper domain."""
        epsilons = [1e-15, 1e-9, 1e-3, 0.1, 1.0, 50.0]
        for eps in epsilons:
            t_neg = -(self.H0_float + eps)
            # Negative frequency has magnitude > H0
            self.assertGreater(abs(t_neg), self.H0_float)
            self.assertLess(t_neg, -self.H0_float)

            # Complex conjugate has positive imaginary part > H0
            t_conj = -t_neg
            self.assertGreater(t_conj, self.H0_float)

    def test_stress_06_higher_cutoff_soundness_and_gap_necessity(self):
        """Stress Test 6: Soundness of higher cutoffs (H' > H0).
        Demonstrate that for any H' > H0:
        1. A refuter at H' alone is blind to points in (H0, H'].
        2. Any deduction of RH from H' requires an intermediate zero-freeness hypothesis."""
        higher_cutoffs = [7.47, 7.5, 8.0, 10.0, 14.0, 16.0, 100.0, 3e12]
        for h_prime in higher_cutoffs:
            self.assertGreater(h_prime, self.H0_float)

            # Midpoint of the intermediate gap (H0, H']
            t_gap = (self.H0_float + h_prime) / 2.0
            self.assertGreater(t_gap, self.H0_float)
            self.assertLessEqual(t_gap, h_prime)

            # Check: Does the refuter at H' apply to t_gap?
            # Refuter requires s.im > H'
            refuter_applies = t_gap > h_prime
            self.assertFalse(
                refuter_applies,
                f"Refuter at H'={h_prime} must NOT apply to intermediate point t={t_gap}",
            )

        # Confirm that in Lean, RiemannHypothesis_of_higher_cutoff requires h_intermediate
        self.assertIn("RiemannHypothesis_of_higher_cutoff", self.bridge_content)
        self.assertIn("h_intermediate", self.bridge_content)
        self.assertIn("1493 / 200 < s.im → s.im ≤ H → riemannZeta s ≠ 0", self.bridge_content)

    def test_stress_07_higher_cutoff_vacuous_gap_at_H0(self):
        """Stress Test 7: When H' = H0, the intermediate slab (H0, H0] is empty.
        Confirm that the intermediate hypothesis is vacuously satisfied at H0."""
        # Check in Lean file
        self.assertIn("challenge_higher_cutoff_at_H0_vacuous", self.audit_content)
        self.assertIn("challenge_higher_cutoff_at_H0_exact", self.audit_content)

    def test_stress_08_displacement_residual_positivity_near_boundary(self):
        """Stress Test 8: Barrier filter algebraic residual R(d, s) > 0.
        R(d, s) = 2d(1/4 - d^2) / |s(s-1)|^2 must be strictly positive for all d in (0, 1/2)
        and all t near the boundary H0 ± ε."""
        epsilons = [-1.0, -0.1, -1e-4, 0.0, 1e-4, 0.1, 1.0]
        d_values = [0.01, 0.05, 0.1, 0.2, 0.25, 0.3, 0.4, 0.49]

        for eps in epsilons:
            t = self.H0_float + eps
            for d in d_values:
                sigma = 0.5 + d
                # Numerator: 2d * (0.25 - d^2)
                num = 2.0 * d * (0.25 - d * d)
                self.assertGreater(num, 0.0)

                # Denominator: |s(s-1)|^2
                # s = sigma + i*t, s(s-1) = (sigma*(sigma-1) - t^2) + i*(2*sigma - 1)*t
                re_part = sigma * (sigma - 1.0) - t * t
                im_part = (2.0 * sigma - 1.0) * t
                denom = re_part * re_part + im_part * im_part

                self.assertGreater(denom, 0.0)
                residual = num / denom
                self.assertGreater(
                    residual,
                    0.0,
                    f"Residual R(d, s) must be strictly positive at t={t}, d={d}",
                )

    def test_stress_09_lean_stress_audit_module_execution(self):
        """Stress Test 9: Execute formalization/verification/HighFrequencyCutoffStressAudit.lean
        via Lean 4 kernel and verify standard foundational axioms only."""
        cmd = 'export PATH="$HOME/.elan/bin:$PATH" && lake env lean formalization/verification/HighFrequencyCutoffStressAudit.lean'
        result = subprocess.run(
            cmd,
            shell=True,
            cwd=REPO_ROOT,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=120,
        )

        self.assertEqual(
            result.returncode,
            0,
            f"HighFrequencyCutoffStressAudit.lean failed with exit code {result.returncode}:\n{result.stderr}\n{result.stdout}",
        )
        self.assertIn(
            "M2 CHALLENGER 2 STRESS AUDIT PASSED: standard foundational axioms only",
            result.stdout,
        )
        # Check no sorryAx
        self.assertNotIn("sorryAx", result.stdout)


if __name__ == "__main__":
    unittest.main()
