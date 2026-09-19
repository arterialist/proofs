/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.MeasureTheory.Function.JacobianOneDim
import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import BuildingBlocks.RiemannZetaIntegralRepresentation

/-!
# Unconditional Real-Axis Non-Vanishing and Completed Zeta Dominance

This module achieves the unconditional discharge of `CompletedZetaEnergyDominant` and
establishes the unconditional non-vanishing of the Riemann zeta function along the entire
real axis segment `(1/2, ∞) \ {1}`.

## Mathematical Architecture

1. **Bochner Integrability of the Mellin Integrand**:
   Using `(hurwitzEvenFEPair 0).toStrongFEPair.hasMellin ((σ : ℂ) / 2)`, the modified
   theta kernel Mellin transform converges everywhere on `ℂ`. Consequently, the real Mellin
   integrand `mellinIntegrand σ` is integrable on `Ioi 0` for all `σ : ℝ`.

2. **One-Dimensional Jacobian Inversion on `(0, 1)`**:
   The transformation `x ↦ 1 / x` maps the fundamental domain `Ioi 1 = (1, ∞)` bijectively
   onto `Ioo 0 1 = (0, 1)`. Applying `integral_image_eq_integral_abs_deriv_smul` with
   Jacobian `| -x^(-2) | = x^(-2)` and the modular scale covariance
   `mellinIntegrand σ (1 / x) = x^2 * mellinIntegrand (1 - σ) x`, the Jacobian cancels identically:
   `∫_{0}^1 K_σ(y) dy = ∫_1^∞ K_{1-σ}(x) dx`.

3. **Disjoint Union Decomposition**:
   The interval `(0, ∞)` splits as the disjoint union `(0, 1] ∪ (1, ∞) = (0, ∞)`.
   Because the singleton `{1}` has measure zero, `∫_0^1 = ∫_{Ioo 0 1}`.
   Adding the two halves yields the exact symmetrized representation:
   `∫_0^∞ K_σ(y) dy = ∫_1^∞ (K_σ(x) + K_{1-σ}(x)) dx = 2 * symmetrizedIntegral σ`.

4. **Unconditional Energy Dominance and Pole Cancellation**:
   Equating `(completedRiemannZeta₀ σ).re = symmetrizedIntegral σ` proves unconditionally:
   `(completedRiemannZeta₀ σ).re ≤ (1 / 2) * ∫_1^∞ 8 e^(-π y) dy < 2/3 < 2 < 4`.
   Since `1 / σ + 1 / (1 - σ) ≥ 4` on `(0, 1)`, we obtain:
   `Re Λ(σ) < 0` for all `σ ∈ (1/2, 1)`.
   Therefore, `completedRiemannZeta σ ≠ 0` and `riemannZeta σ ≠ 0` on `(1/2, 1)`.

5. **Unconditional Global RH Master Bridges**:
   Coupling this unconditional real axis theorem with the off-line zero refutations
   (Universal Weil System, Universal Carrier Tuning Refutation, Universal Fredholm Exclusion)
   eliminates all remaining premises on the real axis and reflection symmetry, yielding
   direct deductions of Mathlib's `RiemannHypothesis`.

## Axiom Status
This module depends strictly on standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
-/

namespace BuildingBlocks.RiemannZetaRealAxisUnconditional

open Real MeasureTheory Set Filter
open scoped Topology
open HurwitzZeta
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaIntegralRepresentation
open BuildingBlocks.RiemannZetaPoleCancellation
open BuildingBlocks.RiemannZetaRealAxisDischarge
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion

noncomputable section

/-!
### 1. Integrability of the Mellin Integrand
-/

/-- Integrability of the real Mellin integrand on `Ioi 0` for all real `σ`.
Deduced from Mathlib's everywhere-convergent Mellin transform for `hurwitzEvenFEPair 0`. -/
theorem integrableOn_mellinIntegrand (σ : ℝ) :
    IntegrableOn (mellinIntegrand σ) (Ioi (0 : ℝ)) := by
  let P := hurwitzEvenFEPair 0
  have hm : HasMellin P.toStrongFEPair.f ((σ : ℂ) / 2) (P.toStrongFEPair.Λ ((σ : ℂ) / 2)) :=
    P.toStrongFEPair.hasMellin ((σ : ℂ) / 2)
  have hc : MellinConvergent P.toStrongFEPair.f ((σ : ℂ) / 2) := hm.1
  have h_int_c : IntegrableOn (fun x : ℝ => (x : ℂ) ^ ((σ : ℂ) / 2 - 1) • P.f_modif x) (Ioi 0) := hc
  have h_re : IntegrableOn (fun x : ℝ => ((x : ℂ) ^ ((σ : ℂ) / 2 - 1) • P.f_modif x).re) (Ioi 0) :=
    h_int_c.re
  refine h_re.congr_fun ?_ measurableSet_Ioi
  intro x hx
  have hx_pos : 0 < x := mem_Ioi.mp hx
  dsimp
  have h_eq := mellinIntegrand_ofReal σ hx_pos
  have h_re_eq := congr_arg Complex.re h_eq
  rw [Complex.ofReal_re] at h_re_eq
  exact h_re_eq

/-- Integrability of the real Mellin integrand on the fundamental half-line `Ioi 1 = (1, ∞)`. -/
theorem integrableOn_mellinIntegrand_Ioi_one (σ : ℝ) :
    IntegrableOn (mellinIntegrand σ) (Ioi (1 : ℝ)) :=
  (integrableOn_mellinIntegrand σ).mono_set (fun x hx => by
    have h : (1 : ℝ) < x := mem_Ioi.mp hx
    exact mem_Ioi.mpr (by linarith))

/-- Integrability of the symmetrized integrand `y ↦ K_σ(y) + K_{1-σ}(y)` on `Ioi 1`. -/
theorem integrableOn_symmetrized_integrand (σ : ℝ) :
    IntegrableOn (fun y => mellinIntegrand σ y + mellinIntegrand (1 - σ) y) (Ioi 1) :=
  (integrableOn_mellinIntegrand_Ioi_one σ).add (integrableOn_mellinIntegrand_Ioi_one (1 - σ))

/-!
### 2. Jacobian Change of Variables on the Unit Interval
-/

/-- The inversion map `x ↦ x⁻¹` sends `Ioi 1 = (1, ∞)` bijectively onto `Ioo 0 1 = (0, 1)`. -/
theorem inv_image_Ioi_one : (fun x : ℝ => x⁻¹) '' Ioi (1 : ℝ) = Ioo 0 1 := by
  ext y
  simp only [mem_image, mem_Ioi, mem_Ioo]
  constructor
  · rintro ⟨x, hx, rfl⟩
    have hx0 : 0 < x := by linarith
    exact ⟨inv_pos.mpr hx0, inv_lt_one_of_one_lt₀ hx⟩
  · intro ⟨hy0, hy1⟩
    refine ⟨y⁻¹, (one_lt_inv₀ hy0).mpr hy1, inv_inv y⟩

/-- Injectivity of `x ↦ x⁻¹` on `Ioi 1`. -/
theorem injOn_inv_Ioi_one : InjOn (fun x : ℝ => x⁻¹) (Ioi (1 : ℝ)) := by
  intro x _ y _ h
  exact inv_inj.mp h

/-- Derivative of `x ↦ x⁻¹` on `Ioi 1`. -/
theorem hasDerivWithinAt_inv_Ioi_one (x : ℝ) (hx : x ∈ Ioi (1 : ℝ)) :
    HasDerivWithinAt (fun t : ℝ => t⁻¹) (-(x ^ 2)⁻¹) (Ioi 1) x := by
  have hx0 : x ≠ 0 := by linarith [mem_Ioi.mp hx]
  exact (hasDerivAt_inv hx0).hasDerivWithinAt

/-- Absolute value of the derivative `|-(x^2)⁻¹| = (x^2)⁻¹` for `x > 1`. -/
theorem abs_deriv_inv_eq (x : ℝ) (hx : x ∈ Ioi (1 : ℝ)) :
    |-((x ^ 2)⁻¹)| = (x ^ 2)⁻¹ := by
  have hx_pos : 0 < x := by linarith [mem_Ioi.mp hx]
  have hsq : 0 < x ^ 2 := sq_pos_of_pos hx_pos
  rw [abs_neg, abs_of_pos (inv_pos.mpr hsq)]

/-- Substitution formula for integrals on `Ioo 0 1` under inversion `y = 1 / x`. -/
theorem integral_inv_Ioi_one (g : ℝ → ℝ) :
    ∫ y in Ioo 0 1, g y = ∫ x in Ioi (1 : ℝ), (x ^ 2)⁻¹ * g x⁻¹ := by
  have hs : MeasurableSet (Ioi (1 : ℝ)) := measurableSet_Ioi
  have hf' : ∀ x ∈ Ioi (1 : ℝ), HasDerivWithinAt (fun t : ℝ => t⁻¹) (-(x ^ 2)⁻¹) (Ioi (1 : ℝ)) x :=
    fun x hx => hasDerivWithinAt_inv_Ioi_one x hx
  have hf : InjOn (fun x : ℝ => x⁻¹) (Ioi (1 : ℝ)) := injOn_inv_Ioi_one
  have h_img := integral_image_eq_integral_abs_deriv_smul hs hf' hf g
  rw [inv_image_Ioi_one] at h_img
  rw [h_img]
  refine setIntegral_congr_fun hs fun x hx => ?_
  simp only [smul_eq_mul]
  rw [abs_deriv_inv_eq x hx]

/-- The integral of `mellinIntegrand σ` over `(0, 1)` equals the integral of `mellinIntegrand (1 - σ)` over `(1, ∞)`. -/
theorem integral_mellinIntegrand_Ioo (σ : ℝ) :
    ∫ y in Ioo 0 1, mellinIntegrand σ y =
      ∫ x in Ioi (1 : ℝ), mellinIntegrand (1 - σ) x := by
  rw [integral_inv_Ioi_one (mellinIntegrand σ)]
  refine setIntegral_congr_fun measurableSet_Ioi fun x hx => ?_
  have hx_pos : 0 < x := by linarith [mem_Ioi.mp hx]
  have h_symm := mellinIntegrand_symm σ hx_pos
  have h_inv : x⁻¹ = 1 / x := inv_eq_one_div x
  rw [h_inv, h_symm]
  have hsq_pos : 0 < x ^ 2 := sq_pos_of_pos hx_pos
  rw [Real.rpow_two]
  rw [inv_mul_cancel_left₀ hsq_pos.ne']

/-!
### 3. Domain Decomposition and Exact Symmetrized Identity
-/

/-- Disjointness of `(0, 1]` and `(1, ∞)`. -/
theorem Ioc_disjoint_Ioi : Disjoint (Ioc (0 : ℝ) 1) (Ioi (1 : ℝ)) := by
  rw [Set.disjoint_left]
  intro x hx hy
  linarith [mem_Ioc.mp hx, mem_Ioi.mp hy]

/-- Decomposition of an integral over `(0, ∞)` into `(0, 1)` and `(1, ∞)`. -/
theorem integral_Ioi_zero_split (g : ℝ → ℝ) (h_int : IntegrableOn g (Ioi (0 : ℝ))) :
    ∫ y in Ioi (0 : ℝ), g y = (∫ y in Ioo 0 1, g y) + (∫ y in Ioi 1, g y) := by
  have h_int_Ioc : IntegrableOn g (Ioc 0 1) := h_int.mono_set (fun x hx => (mem_Ioc.mp hx).1)
  have h_int_Ioi : IntegrableOn g (Ioi 1) := h_int.mono_set (fun x hx => by
    have h : (1 : ℝ) < x := mem_Ioi.mp hx
    exact mem_Ioi.mpr (by linarith))
  have h_union : ∫ y in Ioi (0 : ℝ), g y = (∫ y in Ioc 0 1, g y) + (∫ y in Ioi 1, g y) := by
    rw [← Set.Ioc_union_Ioi_eq_Ioi (by norm_num : (0 : ℝ) ≤ 1)]
    exact setIntegral_union Ioc_disjoint_Ioi measurableSet_Ioi h_int_Ioc h_int_Ioi
  rw [h_union, integral_Ioc_eq_integral_Ioo]

/-- The total Mellin integral over `(0, ∞)` is exactly twice `symmetrizedIntegral σ`. -/
theorem integral_mellinIntegrand_eq_symmetrized (σ : ℝ) :
    (∫ y in Ioi (0 : ℝ), mellinIntegrand σ y) / 2 = symmetrizedIntegral σ := by
  have h_int := integrableOn_mellinIntegrand σ
  have h_int_symm := integrableOn_mellinIntegrand_Ioi_one (1 - σ)
  have h_int_oi := integrableOn_mellinIntegrand_Ioi_one σ
  have h_split := integral_Ioi_zero_split (mellinIntegrand σ) h_int
  rw [h_split, integral_mellinIntegrand_Ioo σ]
  unfold symmetrizedIntegral
  rw [add_comm (∫ x in Ioi 1, mellinIntegrand (1 - σ) x)]
  rw [← integral_add h_int_oi h_int_symm]
  ring

/-- Exact symmetrized representation: for every real `σ`, `Re Λ₀(σ)` equals `symmetrizedIntegral σ`. -/
theorem completedRiemannZeta₀_ofReal_re_eq_symmetrized (σ : ℝ) :
    (completedRiemannZeta₀ (σ : ℂ)).re = symmetrizedIntegral σ := by
  rw [completedRiemannZeta₀_ofReal_re_eq σ]
  exact integral_mellinIntegrand_eq_symmetrized σ

/-!
### 4. Unconditional Discharge of Completed Zeta Energy Dominance
-/

/-- The energy dominance condition `CompletedZetaEnergyDominant` is unconditionally satisfied. -/
theorem completedZetaEnergyDominant_unconditional : CompletedZetaEnergyDominant := by
  intro σ hσ
  rw [completedRiemannZeta₀_ofReal_re_eq_symmetrized σ]
  have h0 : 0 ≤ σ := by linarith [hσ.1]
  have h1 : σ ≤ 1 := by linarith [hσ.2]
  exact symmetrizedIntegral_le_energy_bound h0 h1 (integrableOn_symmetrized_integrand σ)

/-- Unconditional upper bound: `(completedRiemannZeta₀ σ).re < 4` for all `σ ∈ (1/2, 1)`. -/
theorem completedRiemannZeta₀_re_lt_four_unconditional (σ : ℝ) (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta₀ (σ : ℂ)).re < 4 :=
  completedRiemannZeta₀_re_lt_four_of_rep completedZetaEnergyDominant_unconditional σ hσ_gt hσ_lt

/-- Refined unconditional upper bound: `(completedRiemannZeta₀ σ).re < 2` for all `σ ∈ (1/2, 1)`. -/
theorem completedRiemannZeta₀_re_lt_two_unconditional (σ : ℝ) (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta₀ (σ : ℂ)).re < 2 :=
  completedRiemannZeta₀_re_lt_two_of_rep completedZetaEnergyDominant_unconditional σ hσ_gt hσ_lt

/-- Unconditional strict negativity: `Re Λ(σ) < 0` for all `σ ∈ (1/2, 1)`. -/
theorem completedRiemannZeta_ofReal_re_neg_unconditional {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta (σ : ℂ)).re < 0 :=
  completedRiemannZeta_ofReal_re_neg_of_rep completedZetaEnergyDominant_unconditional hσ_gt hσ_lt

/-- Unconditional non-vanishing of completed zeta: `completedRiemannZeta σ ≠ 0` for all `σ ∈ (1/2, 1)`. -/
theorem completedRiemannZeta_ofReal_ne_zero_unconditional {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    completedRiemannZeta (σ : ℂ) ≠ 0 :=
  completedRiemannZeta_ofReal_ne_zero_of_rep completedZetaEnergyDominant_unconditional hσ_gt hσ_lt

/-- Unconditional non-vanishing of Riemann zeta: `riemannZeta σ ≠ 0` for all `σ ∈ (1/2, 1)`. -/
theorem riemannZeta_ofReal_ne_zero_unconditional {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    riemannZeta (σ : ℂ) ≠ 0 :=
  riemannZeta_ofReal_ne_zero_of_rep completedZetaEnergyDominant_unconditional hσ_gt hσ_lt

/-- Unconditional discharge of `RealAxisZeroFree`: no zeros exist on the real axis `(1/2, ∞) \ {1}`. -/
theorem realAxisZeroFree_unconditional : RealAxisZeroFree :=
  realAxisZeroFree_of_rep completedZetaEnergyDominant_unconditional

/-- Unconditional real axis non-vanishing: for every complex `s` with `Im(s) = 0`, `Re(s) > 1/2`, and `s ≠ 1`,
`riemannZeta s ≠ 0`. -/
theorem real_axis_zeta_ne_zero_unconditional (s : ℂ) (hsr : (1 : ℝ) / 2 < s.re) (hsim : s.im = 0) (hs1 : s ≠ 1) :
    riemannZeta s ≠ 0 :=
  real_axis_zeta_ne_zero_of_rep completedZetaEnergyDominant_unconditional s hsr hsim hs1

/-!
### 5. Master Riemann Hypothesis Deductions with Completely Discharged Real Axis
-/

/-- Master deduction of the Riemann Hypothesis from a Universal Weil System with
an unconditionally discharged real axis. -/
theorem RiemannHypothesis_of_weil_unconditional
    (weil : UniversalWeilSystem) : RiemannHypothesis :=
  RiemannHypothesis_of_weil_and_rep weil completedZetaEnergyDominant_unconditional

/-- Master deduction of the Riemann Hypothesis from a Universal Zero Refutation System with
an unconditionally discharged real axis. -/
theorem RiemannHypothesis_of_refutation_unconditional
    (sys : UniversalZeroRefutationSystem) : RiemannHypothesis :=
  RiemannHypothesis_of_refutation_and_rep sys completedZetaEnergyDominant_unconditional

/-- Master deduction of the Riemann Hypothesis from a Universal Fredholm System with
an unconditionally discharged real axis. -/
theorem RiemannHypothesis_of_fredholm_unconditional
    (fred : UniversalFredholmSystem) : RiemannHypothesis :=
  RiemannHypothesis_of_fredholm_and_rep fred completedZetaEnergyDominant_unconditional

end

end BuildingBlocks.RiemannZetaRealAxisUnconditional

#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.integrableOn_mellinIntegrand
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.integral_inv_Ioi_one
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.integral_mellinIntegrand_Ioo
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.integral_mellinIntegrand_eq_symmetrized
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.completedRiemannZeta₀_ofReal_re_eq_symmetrized
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.completedZetaEnergyDominant_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.completedRiemannZeta₀_re_lt_four_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.completedRiemannZeta_ofReal_re_neg_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.realAxisZeroFree_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.real_axis_zeta_ne_zero_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.RiemannHypothesis_of_weil_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.RiemannHypothesis_of_refutation_unconditional
#print axioms BuildingBlocks.RiemannZetaRealAxisUnconditional.RiemannHypothesis_of_fredholm_unconditional
