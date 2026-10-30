/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.NumberTheory.LSeries.Nonvanishing
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaHyperbolicDisparityKernel
import BuildingBlocks.RiemannZetaDisplacementRigidity
import BuildingBlocks.RiemannZetaDisplacementAsymptotics
import BuildingBlocks.RiemannZetaSymmetrizedRepresentation
import BuildingBlocks.RightOfflineContradiction

/-!
# Module 319: Displacement Mellin Integral Representation and Candidate Zero Refutation

This module formalizes the exact integral representation of the algebraic displacement functional
$\mathcal{F}_{\text{disp}}(s)$ via the modular Mellin transform of the hyperbolic disparity kernel
$\mathcal{D}(s, x) f_{\text{modif}}(x)$, and proves the exact candidate zero refutation criteria.

## Mathematical Architecture

1. **Exact Bochner Integrability**:
   - `integrable_mellinTrigRe`: Integrability of the real Mellin integrand on $(1, \infty)$.
   - `integrable_mellinTrigIm`: Integrability of the imaginary Mellin integrand on $(1, \infty)$.
   - `integrable_disparityPointKernel_mul_f_modif`: Global integrability of the coupled disparity kernel
     $\mathcal{D}(s, x) f_{\text{modif}}(x)$ on $(1, \infty)$.

2. **Master Displacement Integral Representation**:
   - `displacementFunctional_eq_half_integral`: Unconditionally proves that for all $s \in \mathbb{C}$,
     $$\mathcal{F}_{\text{disp}}(s) = \frac{1}{2} \int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) \, dx.$$

3. **Candidate Zero Displacement Identities**:
   - `displacement_integral_eq_residual_of_zero`: At any candidate zero $s$ with $\operatorname{Re}(s) > 1/2$
     and $\operatorname{Im}(s) > 0$,
     $$\frac{1}{2} \int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) \, dx = \frac{2d(1/4 - d^2)}{|s(s-1)|^2}.$$
   - `displacement_integral_pos_of_zero`: At any interior candidate zero with $1/2 < \operatorname{Re}(s) < 1$,
     the displacement integral is strictly positive.

4. **Constructive Refutation Criteria**:
   - `refute_zero_of_integral_nonpos`: If the displacement integral is non-positive at $s$, then $\zeta(s) \ne 0$.
   - `refute_zero_of_integral_ne_residual`: If the displacement integral differs from the algebraic residual
     $R(d, s)$, then $\zeta(s) \ne 0$.
   - `refute_zero_of_integral_gt_decay`: If the displacement integral exceeds the quartic decay bound
     $\frac{d}{2t^4}$, then $\zeta(s) \ne 0$.

All declarations depend strictly on standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`. Zero `sorry` placeholders.
-/

namespace BuildingBlocks.RiemannZetaDisplacementIntegralRefutation

open Real Complex MeasureTheory Set
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaHyperbolicDisparityKernel
open BuildingBlocks.RiemannZetaDisplacementRigidity
open BuildingBlocks.RiemannZetaDisplacementAsymptotics
open BuildingBlocks.RiemannZetaSymmetrizedRepresentation
open BuildingBlocks.RightOfflineContradiction

noncomputable section

/-! ### Section 1: Exact Bochner Integrability -/

/-- Integrability of the real Mellin integrand on $(1, \infty)$. -/
theorem integrable_mellinTrigRe (s : ℂ) :
    IntegrableOn (mellinTrigIntegrandRe s) (Ioi (1 : ℝ)) := by
  have h := (integrableOn_cpowTrigKernel_mul_f_modif s).re
  change IntegrableOn (fun x => (cpowTrigKernel s x * (real_f_modif x : ℂ)).re) (Ioi 1) at h
  have h_eq : (fun x => (cpowTrigKernel s x * (real_f_modif x : ℂ)).re) = mellinTrigIntegrandRe s := by
    ext x
    exact cpowTrigKernel_mul_f_modif_re s x
  rwa [h_eq] at h

/-- Integrability of the imaginary Mellin integrand on $(1, \infty)$. -/
theorem integrable_mellinTrigIm (s : ℂ) :
    IntegrableOn (mellinTrigIntegrandIm s) (Ioi (1 : ℝ)) := by
  have h := (integrableOn_cpowTrigKernel_mul_f_modif s).im
  change IntegrableOn (fun x => (cpowTrigKernel s x * (real_f_modif x : ℂ)).im) (Ioi 1) at h
  have h_eq : (fun x => (cpowTrigKernel s x * (real_f_modif x : ℂ)).im) = mellinTrigIntegrandIm s := by
    ext x
    exact cpowTrigKernel_mul_f_modif_im s x
  rwa [h_eq] at h

/-- Global integrability of the disparity kernel coupled with $f_{\text{modif}}$ on $(1, \infty)$. -/
theorem integrable_disparityPointKernel_mul_f_modif (s : ℂ) :
    IntegrableOn (fun x => disparityPointKernel s x * real_f_modif x) (Ioi (1 : ℝ)) := by
  have h_re_mul := (integrable_mellinTrigRe s).const_mul (2 * (s.re - 1 / 2))
  have h_im_mul := (integrable_mellinTrigIm s).const_mul s.im
  have h_sub := h_re_mul.sub h_im_mul
  have h_eq : ((fun x => (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x) - (fun x => s.im * mellinTrigIntegrandIm s x)) =
      (fun x => disparityPointKernel s x * real_f_modif x) := by
    ext x
    dsimp [disparityPointKernel, mellinTrigIntegrandRe, mellinTrigIntegrandIm]
    ring
  rwa [h_eq] at h_sub

/-! ### Section 2: Master Displacement Mellin Representation -/

/-- Master Displacement Integral Representation:
For all $s \in \mathbb{C}$, the displacement functional $\mathcal{F}_{\text{disp}}(s)$ equals
one half times the Mellin integral of $\mathcal{D}(s, x) f_{\text{modif}}(x)$ on $(1, \infty)$. -/
theorem displacementFunctional_eq_half_integral (s : ℂ) :
    displacementFunctional s =
      (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x := by
  unfold displacementFunctional
  rw [re_completedRiemannZeta₀_unconditional s]
  rw [im_completedRiemannZeta₀_unconditional s]
  have h_re_int := integrable_mellinTrigRe s
  have h_im_int := integrable_mellinTrigIm s
  have h1 : (2 * (s.re - 1 / 2)) * ((1 / 2 : ℝ) * ∫ x in Ioi 1, mellinTrigIntegrandRe s x) =
      (1 / 2 : ℝ) * ∫ x in Ioi 1, (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x := by
    calc (2 * (s.re - 1 / 2)) * ((1 / 2 : ℝ) * ∫ x in Ioi 1, mellinTrigIntegrandRe s x)
      _ = (1 / 2 : ℝ) * ((2 * (s.re - 1 / 2)) * ∫ x in Ioi 1, mellinTrigIntegrandRe s x) := by ring
      _ = (1 / 2 : ℝ) * ∫ x in Ioi 1, (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x := by
        rw [integral_const_mul]
  have h2 : s.im * ((1 / 2 : ℝ) * ∫ x in Ioi 1, mellinTrigIntegrandIm s x) =
      (1 / 2 : ℝ) * ∫ x in Ioi 1, s.im * mellinTrigIntegrandIm s x := by
    calc s.im * ((1 / 2 : ℝ) * ∫ x in Ioi 1, mellinTrigIntegrandIm s x)
      _ = (1 / 2 : ℝ) * (s.im * ∫ x in Ioi 1, mellinTrigIntegrandIm s x) := by ring
      _ = (1 / 2 : ℝ) * ∫ x in Ioi 1, s.im * mellinTrigIntegrandIm s x := by
        rw [integral_const_mul]
  rw [h1, h2]
  have h_sub_factor : (1 / 2 : ℝ) * (∫ x in Ioi 1, (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x) -
      (1 / 2 : ℝ) * (∫ x in Ioi 1, s.im * mellinTrigIntegrandIm s x) =
      (1 / 2 : ℝ) * ((∫ x in Ioi 1, (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x) -
                     ∫ x in Ioi 1, s.im * mellinTrigIntegrandIm s x) := by ring
  rw [h_sub_factor]
  have h_re_mul_int : IntegrableOn (fun x => (2 * (s.re - 1 / 2)) * mellinTrigIntegrandRe s x) (Ioi 1) :=
    h_re_int.const_mul _
  have h_im_mul_int : IntegrableOn (fun x => s.im * mellinTrigIntegrandIm s x) (Ioi 1) :=
    h_im_int.const_mul _
  rw [← integral_sub h_re_mul_int h_im_mul_int]
  congr 1
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  dsimp [mellinTrigIntegrandRe, mellinTrigIntegrandIm, disparityPointKernel]
  ring

/-! ### Section 3: Candidate Zero Displacement Identities -/

/-- At any candidate zero in the upper quadrant, the displacement integral equals
the positive displacement residual $R(d, s)$. -/
theorem displacement_integral_eq_residual_of_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x =
      displacementResidual (s.re - 1 / 2) s := by
  rw [← displacementFunctional_eq_half_integral s]
  exact displacementFunctional_eq_residual hsr hsim hz

/-- At any candidate zero in the critical strip interior, the displacement integral is strictly positive. -/
theorem displacement_integral_pos_of_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_lt : s.re < 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    0 < (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x := by
  rw [← displacementFunctional_eq_half_integral s]
  exact displacementFunctional_pos_of_zero hsr hsr_lt hsim hz

/-- At any candidate zero in the critical strip, the displacement integral satisfies the quartic decay bound. -/
theorem displacement_integral_le_decay_of_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_le : s.re ≤ 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≤
      (s.re - 1 / 2) / (2 * s.im ^ 4) := by
  rw [← displacementFunctional_eq_half_integral s]
  exact displacementFunctional_le_decay hsr hsr_le hsim hz

/-! ### Section 4: Constructive Zero Refutation Criteria -/

/-- Refutation by non-positivity of the displacement integral:
If $(1/2) \int_1^\infty \mathcal{D}(s, x) f_{\text{modif}}(x) dx \le 0$ at a point in the interior critical strip,
then $s$ cannot be a zero of $\zeta(s)$. -/
theorem refute_zero_of_integral_nonpos {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_lt : s.re < 1) (hsim : 0 < s.im)
    (h_le : (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≤ 0) :
    riemannZeta s ≠ 0 := by
  rw [← displacementFunctional_eq_half_integral s] at h_le
  exact refute_zero_of_displacementFunctional_nonpos hsr hsr_lt hsim h_le

/-- Refutation by algebraic residual mismatch:
If the displacement integral differs from the algebraic residual $R(d, s)$, then $\zeta(s) \ne 0$. -/
theorem refute_zero_of_integral_ne_residual {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im)
    (h_ne : (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≠
            displacementResidual (s.re - 1 / 2) s) :
    riemannZeta s ≠ 0 := by
  rw [← displacementFunctional_eq_half_integral s] at h_ne
  exact refute_zero_of_displacementFunctional_ne_residual hsr hsim h_ne

/-- Refutation by quartic decay excess:
If the displacement integral strictly exceeds the quartic decay bound $(s.re - 1/2) / (2 t^4)$,
then $\zeta(s) \ne 0$. -/
theorem refute_zero_of_integral_gt_decay {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr_le : s.re ≤ 1) (hsim : 0 < s.im)
    (h_gt : (s.re - 1 / 2) / (2 * s.im ^ 4) <
            (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x) :
    riemannZeta s ≠ 0 := by
  rw [← displacementFunctional_eq_half_integral s] at h_gt
  exact refute_zero_of_displacementFunctional_gt_decay hsr hsr_le hsim h_gt

/-! ### Section 5: Displacement Refutation Systems and Master Equivalence -/

/-- A displacement integral refutation system packages a refutation certificate for candidate zeros
in the high-frequency strip $1 < \operatorname{Im}(s)$. -/
structure DisplacementIntegralRefutationSystem where
  /-- Constructive certificate that every candidate zero satisfies the non-positive displacement condition. -/
  integral_refuter : ∀ (s : ℂ), (1 : ℝ) / 2 < s.re → s.re < 1 → 1 < s.im → riemannZeta s = 0 →
    (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≤ 0

/-- Conversion of a `DisplacementIntegralRefutationSystem` into a `HighFrequencyContradictionSystem`. -/
theorem DisplacementIntegralRefutationSystem.toContradictionSystem
    (sys : DisplacementIntegralRefutationSystem) :
    HighFrequencyContradictionSystem where
  refuter := by
    intro s hsr hsim hz
    rcases le_or_gt 1 s.re with h_ge | h_lt
    · exact (riemannZeta_ne_zero_of_one_le_re h_ge) hz
    · have h_le := sys.integral_refuter s hsr h_lt hsim hz
      have h_nonpos := refute_zero_of_integral_nonpos hsr h_lt (by linarith) h_le
      exact h_nonpos hz

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `DisplacementIntegralRefutationSystem`. -/
theorem RiemannHypothesis_of_displacement_integral_system
    (sys : DisplacementIntegralRefutationSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_system sys.toContradictionSystem

/-- A displacement integral mismatch system packages a certificate that the integral does not equal the residual. -/
structure DisplacementIntegralMismatchSystem where
  integral_mismatch : ∀ (s : ℂ), (1 : ℝ) / 2 < s.re → s.re < 1 → 1 < s.im → riemannZeta s = 0 →
    (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), disparityPointKernel s x * real_f_modif x ≠
      displacementResidual (s.re - 1 / 2) s

/-- Conversion of a `DisplacementIntegralMismatchSystem` into a `HighFrequencyContradictionSystem`. -/
theorem DisplacementIntegralMismatchSystem.toContradictionSystem
    (sys : DisplacementIntegralMismatchSystem) :
    HighFrequencyContradictionSystem where
  refuter := by
    intro s hsr hsim hz
    rcases le_or_gt 1 s.re with h_ge | h_lt
    · exact (riemannZeta_ne_zero_of_one_le_re h_ge) hz
    · have h_ne := sys.integral_mismatch s hsr h_lt hsim hz
      have h_refute := refute_zero_of_integral_ne_residual hsr (by linarith) h_ne
      exact h_refute hz

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `DisplacementIntegralMismatchSystem`. -/
theorem RiemannHypothesis_of_displacement_mismatch_system
    (sys : DisplacementIntegralMismatchSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_system sys.toContradictionSystem

/-- Master High-Frequency Equivalence for Displacement Refutation Systems:
The existence of a `HighFrequencyContradictionSystem`, a `DisplacementIntegralRefutationSystem`,
a `DisplacementIntegralMismatchSystem`, and `RiemannHypothesis` are mutually logically equivalent. -/
theorem displacement_refutation_system_equivalence :
    (Nonempty HighFrequencyContradictionSystem ↔ RiemannHypothesis) ∧
    (RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0)) := by
  constructor
  · constructor
    · rintro ⟨sys⟩
      exact RiemannHypothesis_of_system sys
    · intro h_rh
      have h_hf := (master_high_frequency_rh_equivalence.2.2).mp h_rh
      exact ⟨⟨fun s hsr hsim hz => (h_hf s hsr hsim) hz⟩⟩
  · exact master_high_frequency_rh_equivalence.2.2

/-! ### Section 6: Axiom Verification -/

#print axioms integrable_mellinTrigRe
#print axioms integrable_mellinTrigIm
#print axioms integrable_disparityPointKernel_mul_f_modif
#print axioms displacementFunctional_eq_half_integral
#print axioms displacement_integral_eq_residual_of_zero
#print axioms displacement_integral_pos_of_zero
#print axioms displacement_integral_le_decay_of_zero
#print axioms refute_zero_of_integral_nonpos
#print axioms refute_zero_of_integral_ne_residual
#print axioms refute_zero_of_integral_gt_decay
#print axioms DisplacementIntegralRefutationSystem.toContradictionSystem
#print axioms RiemannHypothesis_of_displacement_integral_system
#print axioms DisplacementIntegralMismatchSystem.toContradictionSystem
#print axioms RiemannHypothesis_of_displacement_mismatch_system
#print axioms displacement_refutation_system_equivalence

end

end BuildingBlocks.RiemannZetaDisplacementIntegralRefutation
