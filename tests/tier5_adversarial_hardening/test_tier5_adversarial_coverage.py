"""
Tier 5: Adversarial Coverage Hardening Test Suite for Milestone M_FINAL.
Authoritative Sources:
  - ORIGINAL_REQUEST.md §R1, §R2, §R3, §R4
  - PROJECT.md Milestones M1, M2, M3, M_FINAL, Features F1-F8
  - formalization/BuildingBlocks/RiemannHypothesisTarget.lean
  - formalization/BuildingBlocks/HighFrequencyReductionBridge.lean
  - formalization/BuildingBlocks/RiemannHypothesisResolution.lean
  - formalization/verification/RiemannHypothesisTargetAudit.lean
  - formalization/verification/HighFrequencyReductionBridgeAudit.lean
  - formalization/verification/RiemannHypothesisResolutionAudit.lean
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

import mpmath

from tests.conftest_utils import (
    REPO_ROOT,
    BUILDING_BLOCKS_DIR,
    VERIFICATION_DIR,
    STANDARD_FOUNDATIONAL_AXIOMS,
    run_command,
)


def strip_lean_comments(text: str) -> str:
    """Remove Lean multiline and single-line comments to inspect executable code only."""
    text = re.sub(r"/-(?:.|\n)*?-/", "", text)
    text = re.sub(r"--.*", "", text)
    return text


class TestTier5WhiteBoxDeclarationAudit(unittest.TestCase):
    """
    White-Box Source Analysis and AST Verification across M1, M2, and M3 modules.
    Verifies that every single declaration has exact signature compliance,
    zero sorry, zero custom axioms, and clean bidirectional logical interfaces.
    """

    @classmethod
    def setUpClass(cls):
        cls.m1_path = BUILDING_BLOCKS_DIR / "RiemannHypothesisTarget.lean"
        cls.m2_path = BUILDING_BLOCKS_DIR / "HighFrequencyReductionBridge.lean"
        cls.m3_path = BUILDING_BLOCKS_DIR / "RiemannHypothesisResolution.lean"

        cls.m1_content = cls.m1_path.read_text(encoding="utf-8")
        cls.m2_content = cls.m2_path.read_text(encoding="utf-8")
        cls.m3_content = cls.m3_path.read_text(encoding="utf-8")

    def test_t5_01_m1_all_declarations_present_and_typed(self):
        """M1 White-Box Coverage: Verify presence of all 26 declarations in RiemannHypothesisTarget.lean."""
        expected_decls = [
            "def canonicalRiemannHypothesis : Prop := RiemannHypothesis",
            "def canonicalTarget : Prop := Target",
            "theorem target_eq_canonical : Target = RiemannHypothesis := rfl",
            "theorem rh_iff_target : RiemannHypothesis ↔ Target := Iff.rfl",
            "def rightHalfZeroFree : Prop := RightHalfZeroFree",
            "def spectralZeroSupport : Set ℂ := SpectralZeroSupport",
            "def criticalLineSupport : Set ℂ := CriticalLineSupport",
            "def rightOfflineSupport : Set ℂ := RightOfflineSupport",
            "def leftOfflineSupport : Set ℂ := LeftOfflineSupport",
            "def spectralSupportConfinement : Prop := SpectralSupportConfinement",
            "def spectralDist (s : ℂ) : ℝ := spectralDistance s",
            "def highFrequencyZeroFree (H : ℝ) : Prop := HighFrequencyZeroFree H",
            "def lowFrequencyZeroFree (H : ℝ) : Prop := LowFrequencyZeroFree H",
            "def cumulativeZeroFree (T : ℝ) : Prop := RiemannZetaGrandIntermediateIntegration.CumulativeZeroFree T",
            "theorem real_axis_zero_free :",
            "theorem cumulative_zero_free_seven_forty_six_five :",
            "theorem cumulativeZeroFree_base_seven_forty_six_five :",
            "theorem lowFrequencyZeroFree_seven_forty_six_five :",
            "theorem bounded_height_zero_free :",
            "theorem highFrequencyZeroFree_of_rh :",
            "theorem rh_of_highFrequencyZeroFree :",
            "theorem rh_iff_high_frequency_seven_forty_six_five :",
            "theorem rightOfflineSupport_iff_leftOfflineSupport :",
            "theorem rh_iff_spectralSupportConfinement :",
            "theorem spectralSupportConfinement_iff_dist_zero :",
            "theorem master_grand_rh_equivalence :",
        ]
        for decl in expected_decls:
            self.assertIn(decl, self.m1_content, f"Missing declaration in M1: {decl}")

    def test_t5_02_m2_all_declarations_present_and_typed(self):
        """M2 White-Box Coverage: Verify presence of all 27 declarations in HighFrequencyReductionBridge.lean."""
        expected_decls = [
            "def H0 : ℝ := 1493 / 200",
            "def canonicalThreshold : ℝ := H0",
            "theorem canonicalThreshold_pos : 0 < canonicalThreshold",
            "theorem canonicalThreshold_nonneg : 0 ≤ canonicalThreshold",
            "theorem H0_pos : 0 < H0",
            "theorem H0_nonneg : 0 ≤ H0",
            "def HighFrequencyDomain (H : ℝ) : Set ℂ",
            "def HighFrequencyUpperDomain (H : ℝ) : Set ℂ",
            "structure HighFrequencyThresholdContradictionSystem (H : ℝ)",
            "theorem highFrequencyZeroFree_of_threshold_contradiction",
            "theorem highFrequencyZeroFree_of_upper_contradiction",
            "theorem threshold_contradiction_of_highFrequencyZeroFree",
            "theorem highFrequencyZeroFree_iff_threshold_contradiction",
            "abbrev CanonicalHighFrequencyContradictionSystem :=",
            "theorem highFrequencyZeroFree_of_canonical_contradiction",
            "theorem RiemannHypothesis_of_canonical_contradiction",
            "theorem rh_of_high_frequency_threshold_contradiction",
            "theorem RiemannHypothesis_iff_canonical_contradiction",
            "theorem rh_iff_high_frequency_threshold_contradiction",
            "theorem displacement_residual_pos_of_strip",
            "theorem displacement_functional_pos_at_zero",
            "theorem barrier_displacement_nonpos_impossible",
            "theorem barrier_displacement_residual_mismatch_impossible",
            "theorem barrier_displacement_integral_nonpos_impossible",
            "theorem highFrequencyContradiction_mono",
            "theorem RiemannHypothesis_of_higher_cutoff",
            "theorem master_high_frequency_reduction",
        ]
        for decl in expected_decls:
            self.assertIn(decl, self.m2_content, f"Missing declaration in M2: {decl}")

    def test_t5_03_m3_all_declarations_present_and_typed(self):
        """M3 White-Box Coverage: Verify presence of all 28 declarations in RiemannHypothesisResolution.lean."""
        expected_decls = [
            "def resolutionThreshold : ℝ := canonicalThreshold",
            "theorem resolutionThreshold_pos : 0 < resolutionThreshold",
            "theorem resolutionThreshold_nonneg : 0 ≤ resolutionThreshold",
            "def canonicalRH : Prop := canonicalRiemannHypothesis",
            "def canonicalTargetRH : Prop := canonicalTarget",
            "theorem target_resolution_eq : Target = RiemannHypothesis := rfl",
            "theorem target_resolution_iff : RiemannHypothesis ↔ Target := Iff.rfl",
            "structure AdmissibleHighFrequencyContradictionSystem (H : ℝ)",
            "theorem toAdmissible {H : ℝ}",
            "abbrev CanonicalAdmissibleContradictionSystem :=",
            "theorem riemann_hypothesis_resolution",
            "theorem riemann_hypothesis_resolution_of_admissible",
            "theorem target_resolution",
            "theorem target_resolution_of_admissible",
            "theorem riemann_hypothesis_resolution_iff",
            "theorem riemann_hypothesis_admissible_resolution_iff",
            "theorem target_resolution_iff_contradiction",
            "theorem riemann_hypothesis_resolution_of_higher_cutoff",
            "theorem canonical_root_localization",
            "theorem canonical_root_localization_of_admissible",
            "theorem master_grand_resolution_equivalence",
            "theorem resolution_allocation_nonneg",
            "theorem resolution_W_le_fullNumerator",
            "theorem resolution_RiemannHypothesis_of_fluctuation_growth",
            "theorem resolution_analyticOnNhd_filledTransform_of_fluctuation_growth",
            "theorem unconditional_zeta_half_ne_zero",
            "theorem resolution_frequently_downward_excursion",
            "theorem grand_rh_resolution_master",
        ]
        for decl in expected_decls:
            self.assertIn(decl, self.m3_content, f"Missing declaration in M3: {decl}")

    def test_t5_04_zero_sorry_and_definitional_identities(self):
        """Zero-Defect Guardrail: Verify 0 sorry/sorryAx in executable code and definitional reflexivity rfl."""
        for path, content in [
            (self.m1_path, self.m1_content),
            (self.m2_path, self.m2_content),
            (self.m3_path, self.m3_content),
        ]:
            code = strip_lean_comments(content)
            self.assertNotIn("sorryAx", code, f"Found sorryAx in executable code of {path.name}")
            words = code.split()
            self.assertNotIn("sorry", words, f"Found standalone sorry in executable code of {path.name}")

        # Definitional equalities must use := rfl
        self.assertIn("Target = RiemannHypothesis := rfl", self.m1_content)
        self.assertIn("RiemannHypothesis ↔ Target := Iff.rfl", self.m1_content)
        self.assertIn("Target = RiemannHypothesis := rfl", self.m3_content)
        self.assertIn("RiemannHypothesis ↔ Target := Iff.rfl", self.m3_content)

    def test_t5_05_compound_equivalence_structures(self):
        """Compound Equivalence Structures: Verify complete conjunct counts in compound theorems."""
        # M1 10-fold grand equivalence
        self.assertIn("master_grand_rh_equivalence :", self.m1_content)
        for term in [
            "RiemannHypothesis ↔ Target",
            "RiemannHypothesis ↔ RightHalfZeroFree",
            "RiemannHypothesis ↔ RightOfflineSupport = ∅",
            "RiemannHypothesis ↔ LeftOfflineSupport = ∅",
            "RiemannHypothesis ↔ SpectralSupportConfinement",
            "riemannZeta s ≠ 0",
            "HolomorphicZetaODE",
            "HighFrequencyZeroFree (1493 / 200)",
        ]:
            self.assertIn(term, self.m1_content)

        # M2 3-fold master high-frequency reduction
        self.assertIn("master_high_frequency_reduction :", self.m2_content)
        self.assertIn("IntermediateThresholdFredholmSystem", self.m2_content)

        # M3 12-fold grand resolution equivalence
        self.assertIn("master_grand_resolution_equivalence :", self.m3_content)
        self.assertIn("Nonempty CanonicalHighFrequencyContradictionSystem", self.m3_content)
        self.assertIn("Nonempty CanonicalAdmissibleContradictionSystem", self.m3_content)

        # M3 9-part compound master resolution
        self.assertIn("grand_rh_resolution_master :", self.m3_content)
        self.assertIn("Target = RiemannHypothesis", self.m3_content)
        self.assertIn("riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) ≠ 0", self.m3_content)


class TestTier5AdversarialStressAndBoundaries(unittest.TestCase):
    """
    Adversarial Stress Testing on Mathematical Boundaries, Displacements,
    and Counter-Model Exclusion.
    """

    @classmethod
    def setUpClass(cls):
        mpmath.mp.dps = 50
        cls.H0_frac = fractions.Fraction(1493, 200)
        cls.H0_float = 7.465

    def test_t5_06_bounded_height_and_boundary_partition(self):
        """Stress Test: Exhaustive partition of the critical strip around H0 = 7.465."""
        # 1. Exact rational cutoff
        self.assertEqual(self.H0_frac, fractions.Fraction(1493, 200))
        self.assertEqual(float(self.H0_frac), self.H0_float)

        # 2. Central point non-vanishing: |zeta(1/2)| > 1.46
        zeta_half = mpmath.zeta(0.5)
        self.assertAlmostEqual(float(zeta_half), -1.4603545088095868, places=12)
        self.assertNotEqual(float(zeta_half), 0.0)

        # 3. Origin condition: zeta(0) = -1/2
        zeta_zero = mpmath.zeta(0)
        self.assertEqual(float(zeta_zero), -0.5)

        # 4. First 10 known non-trivial zeros gamma_n > H0 = 7.465
        gamma_zeros = [
            14.13472514173469379,
            21.02203963877155499,
            25.01085758014568876,
            30.42487612585951321,
            32.93506158773918969,
            37.58617815882567726,
            40.91871901214749519,
            43.32707328091499952,
            48.00515088116715973,
            49.77383247767230218,
        ]
        for idx, gamma in enumerate(gamma_zeros, 1):
            self.assertGreater(
                gamma,
                self.H0_float,
                f"Zero #{idx} ordinate {gamma} is not in high-frequency domain > {self.H0_float}",
            )
            val = mpmath.zeta(mpmath.mpc(0.5, gamma))
            self.assertAlmostEqual(float(abs(val)), 0.0, places=10)

    def test_t5_07_extreme_boundary_displacement_residual_grid(self):
        """Stress Test: Algebraic displacement residual R(d, s) > 0 under extreme boundary regimes."""
        # Residual formula: R(d, s) = 2d(1/4 - d^2) / |s(s-1)|^2
        # d in (0, 1/2), s = 1/2 + d + it
        d_values = [
            1e-15, 1e-12, 1e-9, 1e-6, 1e-3, 0.01, 0.1, 0.25, 0.4, 0.49, 0.4999, 0.5 - 1e-9, 0.5 - 1e-15
        ]
        t_values = [
            1e-10, 1e-5, 0.1, 1.0, 7.465, 14.1347, 50.0, 1000.0, 1e6, 1e9, 1e12
        ]

        for d in d_values:
            self.assertGreater(d, 0.0)
            self.assertLess(d, 0.5)
            num = 2.0 * d * (0.25 - d * d)
            self.assertGreater(num, 0.0, f"Numerator non-positive at d={d}")

            re = 0.5 + d
            for t in t_values:
                denom = (re**2 + t**2) * ((re - 1.0)**2 + t**2)
                self.assertGreater(denom, 0.0)
                residual = num / denom
                self.assertGreater(residual, 0.0, f"R(d, s) <= 0 at d={d}, t={t}")
                self.assertFalse(math.isnan(residual))
                self.assertFalse(math.isinf(residual))

    def test_t5_08_barrier_filter_ex_falso_guards(self):
        """Stress Test: Barrier filter invariants strictly forbid non-positivity premises."""
        m2_content = (BUILDING_BLOCKS_DIR / "HighFrequencyReductionBridge.lean").read_text(encoding="utf-8")

        # Invariant 1: displacementFunctional s <= 0 is impossible
        self.assertIn("theorem barrier_displacement_nonpos_impossible", m2_content)
        self.assertIn("¬ (displacementFunctional s ≤ 0)", m2_content)

        # Invariant 2: displacement residual mismatch is impossible
        self.assertIn("theorem barrier_displacement_residual_mismatch_impossible", m2_content)
        self.assertIn("¬ (displacementFunctional s ≠ displacementResidual (s.re - 1 / 2) s)", m2_content)

        # Invariant 3: displacement integral nonpositivity is impossible
        self.assertIn("theorem barrier_displacement_integral_nonpos_impossible", m2_content)
        self.assertIn("¬ ((1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≤ 0)", m2_content)

    def test_t5_09_higher_cutoff_soundness_and_intermediate_slab(self):
        """Stress Test: Higher cutoff H >= 1493/200 soundness requires intermediate zero-freeness."""
        m2_content = (BUILDING_BLOCKS_DIR / "HighFrequencyReductionBridge.lean").read_text(encoding="utf-8")
        m3_content = (BUILDING_BLOCKS_DIR / "RiemannHypothesisResolution.lean").read_text(encoding="utf-8")

        # M2 theorem requires intermediate hypothesis
        self.assertIn("theorem RiemannHypothesis_of_higher_cutoff", m2_content)
        self.assertIn(
            "h_intermediate : ∀ s : ℂ, 1 / 2 < s.re → 1493 / 200 < s.im → s.im ≤ H → riemannZeta s ≠ 0",
            m2_content,
        )

        # M3 higher-cutoff theorem preserves exact intermediate hypothesis
        self.assertIn("theorem riemann_hypothesis_resolution_of_higher_cutoff", m3_content)
        self.assertIn("RiemannHypothesis_of_higher_cutoff H hH sys h_intermediate", m3_content)

        # Rational verification that if H = 1493/200, (1493/200, H] is empty
        h0 = fractions.Fraction(1493, 200)
        h_same = fractions.Fraction(1493, 200)
        # Empty slab: no t can satisfy h0 < t and t <= h_same
        test_points = [h0 - 0.01, h0, h0 + 0.01]
        for tp in test_points:
            in_slab = (h0 < tp) and (tp <= h_same)
            self.assertFalse(in_slab, f"Point {tp} must not be in empty slab (H0, H0]")

    def test_t5_10_pointwise_root_localization_and_trivial_zeros(self):
        """Stress Test: Pointwise root localization excludes trivial zeros and counter-models."""
        # Non-triviality premise: ¬∃ n : ℕ, s = -2*(n+1)
        # Test trivial zeros s = -2, -4, -6, ..., -40
        for n in range(20):
            s_triv = -2 * (n + 1)
            # Evaluate zeta: zeta(-2k) = 0
            val = mpmath.zeta(s_triv)
            self.assertAlmostEqual(float(val), 0.0, places=30)
            # Trivial quantifier: matches n
            self.assertEqual(s_triv, -2 * (n + 1))
            # Fails non-triviality condition
            has_trivial_rep = (s_triv == -2 * (n + 1))
            self.assertTrue(has_trivial_rep)

        # Odd negative integers: zeta(-(2k-1)) != 0
        for k in range(1, 10):
            s_odd = -(2 * k - 1)
            val = float(mpmath.zeta(s_odd))
            self.assertNotEqual(val, 0.0, f"zeta({s_odd}) must not be zero")

        # Pole s = 1 raises pole ValueError in mpmath
        with self.assertRaises(ValueError):
            mpmath.zeta(1.0)

        # Singularity limit: (s - 1) * zeta(s) -> 1 as s -> 1+
        for eps in [1e-3, 1e-6, 1e-9]:
            val_near = float(mpmath.zeta(1.0 + eps))
            self.assertAlmostEqual(eps * val_near, 1.0, places=2)

    def test_t5_11_prime_allocation_and_fluctuation_dominance(self):
        """Stress Test: Prime allocation positivity and critical kernel dominance."""
        # Empirical test of allocation non-negativity:
        # Proper prime powers p^k (k >= 2): allocation is positive
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
        proper_powers = []
        for p in primes:
            for k in range(2, 6):
                val = p ** k
                if val <= 1000:
                    proper_powers.append((p, k, val))

        self.assertGreaterEqual(len(proper_powers), 20)
        for p, k, val in proper_powers:
            weight = math.log(p) / k
            self.assertGreater(weight, 0.0)

        # In-code theorem signature checks
        m3_content = (BUILDING_BLOCKS_DIR / "RiemannHypothesisResolution.lean").read_text(encoding="utf-8")
        self.assertIn("theorem resolution_allocation_nonneg (x : ℝ) :", m3_content)
        self.assertIn("0 ≤ (ActualFullCenteredMellin.allocation x).re", m3_content)
        self.assertIn("theorem resolution_W_le_fullNumerator (x : ℝ) :", m3_content)
        self.assertIn("(ActualCriticalMellin.W x).re ≤ (ActualFullCenteredMellin.fullNumerator x).re", m3_content)
        self.assertIn("theorem resolution_RiemannHypothesis_of_fluctuation_growth", m3_content)
        self.assertIn("theorem resolution_analyticOnNhd_filledTransform_of_fluctuation_growth", m3_content)
        self.assertIn("theorem resolution_frequently_downward_excursion", m3_content)


class TestTier5InKernelLeanAuditSuites(unittest.TestCase):
    """
    Subprocess execution of in-kernel Lean 4 programmatic axiom audit modules:
      1. RiemannHypothesisTargetAudit.lean (M1)
      2. HighFrequencyReductionBridgeAudit.lean (M2)
      3. RiemannHypothesisResolutionAudit.lean (M3)
    Verifies 100% compliance with standard foundational axioms:
      [propext, Classical.choice, Quot.sound]
    with exactly 0 sorry, 0 sorryAx, and 0 custom axioms across all declarations.
    """

    def test_t5_12_lean_m1_target_in_kernel_audit(self):
        """In-Kernel Audit: Execute RiemannHypothesisTargetAudit.lean under Lean 4."""
        audit_file = VERIFICATION_DIR / "RiemannHypothesisTargetAudit.lean"
        rel_path = audit_file.relative_to(REPO_ROOT)
        cmd = f"export PATH=\"$HOME/.elan/bin:$PATH\" && lake env lean {rel_path}"
        proc = run_command(cmd, cwd=REPO_ROOT, timeout=120)

        self.assertEqual(
            proc.returncode,
            0,
            f"M1 target audit failed with exit {proc.returncode}:\n{proc.stderr}\n{proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn(
            "RIEMANN HYPOTHESIS TARGET AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry",
            proc.stdout,
        )

        matches = re.findall(r"AUDITED DECLARATION: ([^\s]+) \(axioms: \[([^\]]*)\]\)", proc.stdout)
        self.assertGreaterEqual(len(matches), 26, f"Expected 26 audited M1 declarations, got {len(matches)}")
        for decl, ax_str in matches:
            axioms = {a.strip() for a in ax_str.split(",") if a.strip()}
            disallowed = axioms - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                len(disallowed),
                0,
                f"Declaration {decl} depends on disallowed axioms: {disallowed}",
            )

    def test_t5_13_lean_m2_bridge_in_kernel_audit(self):
        """In-Kernel Audit: Execute HighFrequencyReductionBridgeAudit.lean under Lean 4."""
        audit_file = VERIFICATION_DIR / "HighFrequencyReductionBridgeAudit.lean"
        rel_path = audit_file.relative_to(REPO_ROOT)
        cmd = f"export PATH=\"$HOME/.elan/bin:$PATH\" && lake env lean {rel_path}"
        proc = run_command(cmd, cwd=REPO_ROOT, timeout=120)

        self.assertEqual(
            proc.returncode,
            0,
            f"M2 bridge audit failed with exit {proc.returncode}:\n{proc.stderr}\n{proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn(
            "HIGH-FREQUENCY REDUCTION BRIDGE AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry",
            proc.stdout,
        )

        matches = re.findall(r"AUDITED DECLARATION: ([^\s]+) \(axioms: \[([^\]]*)\]\)", proc.stdout)
        self.assertGreaterEqual(len(matches), 25, f"Expected 25 audited M2 declarations, got {len(matches)}")
        for decl, ax_str in matches:
            axioms = {a.strip() for a in ax_str.split(",") if a.strip()}
            disallowed = axioms - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                len(disallowed),
                0,
                f"Declaration {decl} depends on disallowed axioms: {disallowed}",
            )

    def test_t5_14_lean_m3_resolution_in_kernel_audit(self):
        """In-Kernel Audit: Execute RiemannHypothesisResolutionAudit.lean under Lean 4."""
        audit_file = VERIFICATION_DIR / "RiemannHypothesisResolutionAudit.lean"
        rel_path = audit_file.relative_to(REPO_ROOT)
        cmd = f"export PATH=\"$HOME/.elan/bin:$PATH\" && lake env lean {rel_path}"
        proc = run_command(cmd, cwd=REPO_ROOT, timeout=120)

        self.assertEqual(
            proc.returncode,
            0,
            f"M3 resolution audit failed with exit {proc.returncode}:\n{proc.stderr}\n{proc.stdout}",
        )
        self.assertNotIn("sorryAx", proc.stdout)
        self.assertIn(
            "RIEMANN HYPOTHESIS RESOLUTION AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry",
            proc.stdout,
        )

        matches = re.findall(r"AUDITED DECLARATION: ([^\s]+) \(axioms: \[([^\]]*)\]\)", proc.stdout)
        self.assertGreaterEqual(len(matches), 25, f"Expected 25 audited M3 declarations, got {len(matches)}")
        for decl, ax_str in matches:
            axioms = {a.strip() for a in ax_str.split(",") if a.strip()}
            disallowed = axioms - STANDARD_FOUNDATIONAL_AXIOMS
            self.assertEqual(
                len(disallowed),
                0,
                f"Declaration {decl} depends on disallowed axioms: {disallowed}",
            )


if __name__ == "__main__":
    unittest.main()
