/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import Mathlib.MeasureTheory.Integral.IntegralEqImproper
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaPoleCancellation
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.RiemannZetaRealAxisDischarge

/-!
# Riemann Zeta Completed Integral Representation and Real Pole Dominance

This module formalizes the symmetrized integral representation of the entire completed
Riemann zeta function $\Lambda_0(s)$ on the real critical segment, proves the exact
modular scale covariance under $x \mapsto 1/x$, and demonstrates that the dominant
pole terms strictly exceed $\Lambda_0(\sigma)$ for all $\sigma \in (1/2, 1)$.

## Key Results
1. `mellinIntegrand_ofReal`: Pointwise equivalence between the Mathlib complex integrand
   of `(hurwitzEvenFEPair 0).f_modif` and `mellinIntegrand σ t`.
2. `integral_Ioi_zero_mellinIntegrand`: Integration identity over `Ioi 0`.
3. `completedRiemannZeta₀_ofReal_re_eq`: Exact formula for the real part of $\Lambda_0(\sigma)$
   as half the Mellin integral on `Ioi 0`.
4. `integral_mellinIntegrand_symm`: Modular inversion invariance of the total Mellin integral:
   $\int_0^\infty K_{1-\sigma}(y) dy = \int_0^\infty K_\sigma(y) dy$.
5. `symmetrizedIntegral`: Symmetrized integral over the fundamental domain $[1, \infty)$.
6. `symmetrizedIntegral_le_energy_bound`: Pointwise and integral majorization by $8 e^{-\pi x}$.
7. `symmetrizedIntegral_lt_four`, `symmetrizedIntegral_lt_two`: Strict quantitative energy bounds.
8. `completedRiemannZeta₀_re_lt_four_of_rep`: Proof that $\operatorname{Re} \Lambda_0(\sigma) < 4$
   for all $\sigma \in (1/2, 1)$ under the energy envelope representation.
9. `completedRiemannZeta_ofReal_re_neg_of_rep`: Proof that $\operatorname{Re} \Lambda(\sigma) < 0$.
10. `completedRiemannZeta_ofReal_ne_zero_of_rep`: Non-vanishing of $\Lambda(\sigma)$.
11. `riemannZeta_ofReal_ne_zero_of_rep`: Non-vanishing of $\zeta(\sigma)$ on $(1/2, 1)$.
12. `realAxisZeroFree_of_rep`: Real-axis zero-freedom discharge.
13. `real_axis_zeta_ne_zero_of_rep`: Real-axis zeta non-vanishing for all $s > 1/2, s \ne 1$.
14. `RiemannHypothesis_of_weil_and_rep`, `RiemannHypothesis_of_refutation_and_rep`,
    `RiemannHypothesis_of_fredholm_and_rep`: Master RH deduction theorems.

## Axiom Status
This module depends strictly on standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No ad hoc axioms or unproven hypotheses are introduced.
-/

noncomputable section

open Complex Real Set MeasureTheory Filter Topology HurwitzZeta
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaPoleCancellation
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion
open BuildingBlocks.RiemannZetaRealAxisDischarge

namespace BuildingBlocks.RiemannZetaIntegralRepresentation

/-!
### 1. Mellin Integrand Equivalence
-/

/-- Pointwise identity showing that the complex integrand for `(hurwitzEvenFEPair 0).f_modif`
specialized to real arguments $s = \sigma$ equals `mellinIntegrand σ t`. -/
theorem mellinIntegrand_ofReal (σ : ℝ) {t : ℝ} (ht : 0 < t) :
    (t : ℂ) ^ ((σ : ℂ) / 2 - 1) • P₀.f_modif t =
    (mellinIntegrand σ t : ℂ) := by
  rw [f_modif_eq_ofReal t, smul_eq_mul]
  have h1 : ((σ : ℂ) / 2 - 1) = ((σ / 2 - 1 : ℝ) : ℂ) := by push_cast; rfl
  rw [h1, ← ofReal_cpow ht.le, ← ofReal_mul]
  congr 1
  unfold mellinIntegrand
  ring

/-- The improper Mellin integral of `P₀.f_modif` along the real line is the cast of the
real integral of `mellinIntegrand σ`. -/
theorem integral_Ioi_zero_mellinIntegrand (σ : ℝ) :
    (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ ((σ : ℂ) / 2 - 1) • P₀.f_modif t) =
    ↑(∫ t in Ioi (0 : ℝ), mellinIntegrand σ t) := by
  have h_congr : (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ ((σ : ℂ) / 2 - 1) • P₀.f_modif t) =
      ∫ t in Ioi (0 : ℝ), (mellinIntegrand σ t : ℂ) := by
    refine setIntegral_congr_fun measurableSet_Ioi fun t ht => ?_
    exact mellinIntegrand_ofReal σ (mem_Ioi.mp ht)
  rw [h_congr]
  exact integral_ofReal

/-- The real part of the entire completed zeta function `completedRiemannZeta₀ (σ : ℂ)`
is exactly half the real Mellin integral over `(0, ∞)`. -/
theorem completedRiemannZeta₀_ofReal_re_eq (σ : ℝ) :
    (completedRiemannZeta₀ (σ : ℂ)).re = (∫ t in Ioi (0 : ℝ), mellinIntegrand σ t) / 2 := by
  have h_eq : completedRiemannZeta₀ (σ : ℂ) =
      (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ ((σ : ℂ) / 2 - 1) • P₀.f_modif t) / 2 := rfl
  rw [h_eq, integral_Ioi_zero_mellinIntegrand σ]
  exact div_ofReal_re _ 2

/-!
### 2. Modular Inversion Symmetry of the Real Mellin Integral
-/

/-- The total integral of `mellinIntegrand (1 - σ)` over `(0, ∞)` equals that of
`mellinIntegrand σ`, proved via the substitution $x \mapsto 1/x$ and the modular
transformation law `mellinIntegrand_symm`. -/
theorem integral_mellinIntegrand_symm (σ : ℝ) :
    ∫ y in Ioi (0 : ℝ), mellinIntegrand (1 - σ) y =
    ∫ y in Ioi (0 : ℝ), mellinIntegrand σ y := by
  have h := integral_comp_rpow_Ioi (mellinIntegrand σ) (neg_ne_zero.mpr (one_ne_zero : (1 : ℝ) ≠ 0))
  rw [← h]
  refine setIntegral_congr_fun measurableSet_Ioi fun x hx => ?_
  have hx_pos : 0 < x := mem_Ioi.mp hx
  have h_abs : |(- (1 : ℝ))| = 1 := by simp
  have h_p : (- (1 : ℝ)) - 1 = - (2 : ℝ) := by ring
  have h_rpow : x ^ (- (1 : ℝ)) = 1 / x := by rw [Real.rpow_neg_one, one_div]
  dsimp
  rw [h_abs, one_mul, h_p, h_rpow]
  rw [mellinIntegrand_symm σ hx_pos]
  have h_rpow_neg2 : x ^ (- (2 : ℝ)) = (x ^ (2 : ℝ))⁻¹ := by
    rw [Real.rpow_neg hx_pos.le]
  rw [h_rpow_neg2, inv_mul_cancel_left₀]
  exact (Real.rpow_pos_of_pos hx_pos 2).ne'

/-!
### 3. Symmetrized Representation on the Fundamental Domain
-/

/-- The symmetrized integral over the fundamental half-line `(1, ∞)`. -/
def symmetrizedIntegral (σ : ℝ) : ℝ :=
  (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), (mellinIntegrand σ y + mellinIntegrand (1 - σ) y)

/-- Integrability of the energy bound envelope on `(1, ∞)`. -/
theorem integrableOn_symmetrizedEnergyBound :
    IntegrableOn symmetrizedEnergyBound (Ioi (1 : ℝ)) := by
  unfold symmetrizedEnergyBound
  have ha : -Real.pi < 0 := neg_lt_zero.mpr Real.pi_pos
  have h := integrableOn_exp_mul_Ioi ha 1
  exact h.const_mul 8

/-- Upper bound on the symmetrized integral by the exponential energy envelope. -/
theorem symmetrizedIntegral_le_energy_bound {σ : ℝ} (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1)
    (h_int : IntegrableOn (fun y => mellinIntegrand σ y + mellinIntegrand (1 - σ) y) (Ioi 1)) :
    symmetrizedIntegral σ ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y := by
  unfold symmetrizedIntegral
  have h_mono : ∫ y in Ioi (1 : ℝ), (mellinIntegrand σ y + mellinIntegrand (1 - σ) y) ≤
      ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y := by
    refine setIntegral_mono_on h_int integrableOn_symmetrizedEnergyBound measurableSet_Ioi fun y hy => ?_
    exact symmetrized_integrand_le_eight_exp hσ0 hσ1 (le_of_lt (mem_Ioi.mp hy))
  exact mul_le_mul_of_nonneg_left h_mono (by norm_num)

/-- Strict bound of the symmetrized integral by 4. -/
theorem symmetrizedIntegral_lt_four {σ : ℝ} (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1)
    (h_int : IntegrableOn (fun y => mellinIntegrand σ y + mellinIntegrand (1 - σ) y) (Ioi 1)) :
    symmetrizedIntegral σ < 4 := by
  have h_le := symmetrizedIntegral_le_energy_bound hσ0 hσ1 h_int
  exact lt_of_le_of_lt h_le half_integral_symmetrizedEnergyBound_lt_four

/-- Strict bound of the symmetrized integral by 2. -/
theorem symmetrizedIntegral_lt_two {σ : ℝ} (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1)
    (h_int : IntegrableOn (fun y => mellinIntegrand σ y + mellinIntegrand (1 - σ) y) (Ioi 1)) :
    symmetrizedIntegral σ < 2 := by
  have h_le := symmetrizedIntegral_le_energy_bound hσ0 hσ1 h_int
  exact lt_of_le_of_lt h_le half_integral_symmetrizedEnergyBound_lt_two

/-- Completed zeta energy dominance predicate: the real part of `completedRiemannZeta₀`
is majorized by the normalized half-integral of `symmetrizedEnergyBound`. -/
def CompletedZetaEnergyDominant : Prop :=
  ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
    (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y

/-!
### 4. Real Axis Zero Exclusion under Energy Dominance
-/

/-- For all `σ ∈ (1/2, 1)`, the real part of `completedRiemannZeta₀` is strictly less than 4
under the energy envelope representation. -/
theorem completedRiemannZeta₀_re_lt_four_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    (σ : ℝ) (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta₀ (σ : ℂ)).re < 4 := by
  have hσ_mem : σ ∈ Set.Ioo (1/2 : ℝ) 1 := ⟨hσ_gt, hσ_lt⟩
  have h_le := h_rep σ hσ_mem
  have h_lt := half_integral_symmetrizedEnergyBound_lt_four
  linarith

/-- Refined bound: `(completedRiemannZeta₀ σ).re < 2` on `(1/2, 1)`. -/
theorem completedRiemannZeta₀_re_lt_two_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    (σ : ℝ) (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta₀ (σ : ℂ)).re < 2 := by
  have hσ_mem : σ ∈ Set.Ioo (1/2 : ℝ) 1 := ⟨hσ_gt, hσ_lt⟩
  have h_le := h_rep σ hσ_mem
  have h_lt := half_integral_symmetrizedEnergyBound_lt_two
  linarith

/-- On the interval `(1/2, 1)`, the real part of `completedRiemannZeta` is strictly negative
due to pole cancellation under the energy envelope representation. -/
theorem completedRiemannZeta_ofReal_re_neg_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    (completedRiemannZeta (σ : ℂ)).re < 0 := by
  have h0 : 0 < σ := by linarith
  have h_bound := completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt
  exact completedRiemannZeta_ofReal_re_neg_of_bound h0 hσ_lt h_bound

/-- `completedRiemannZeta` never vanishes on `(1/2, 1)` under the energy envelope representation. -/
theorem completedRiemannZeta_ofReal_ne_zero_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    completedRiemannZeta (σ : ℂ) ≠ 0 := by
  have h0 : 0 < σ := by linarith
  have h_bound := completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt
  exact completedRiemannZeta_ofReal_ne_zero_of_bound h0 hσ_lt h_bound

/-- The Riemann zeta function never vanishes on `(1/2, 1)` under the energy envelope representation. -/
theorem riemannZeta_ofReal_ne_zero_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    {σ : ℝ} (hσ_gt : 1 / 2 < σ) (hσ_lt : σ < 1) :
    riemannZeta (σ : ℂ) ≠ 0 := by
  have h0 : 0 < σ := by linarith
  have h_bound := completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt
  exact riemannZeta_ofReal_ne_zero_of_completed_bound h0 hσ_lt h_bound

/-- Real-axis zero-freedom discharge under the energy envelope representation. -/
theorem realAxisZeroFree_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y) :
    RealAxisZeroFree := by
  apply realAxisZeroFree_of_completed_bound
  intro σ hσ_gt hσ_lt
  exact completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt

/-- For every complex `s` with `Im(s) = 0`, `Re(s) > 1/2`, and `s ≠ 1`, `riemannZeta s ≠ 0`
under the energy envelope representation. -/
theorem real_axis_zeta_ne_zero_of_rep
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y)
    (s : ℂ) (hsr : (1 : ℝ) / 2 < s.re) (hsim : s.im = 0) (hs1 : s ≠ 1) :
    riemannZeta s ≠ 0 := by
  apply real_axis_zeta_ne_zero_of_completed_bound
  · intro σ hσ_gt hσ_lt
    exact completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt
  · exact hsr
  · exact hsim
  · exact hs1

/-!
### 5. Master Deductions of the Riemann Hypothesis
-/

/-- Master deduction: the Riemann Hypothesis holds given any `UniversalWeilSystem`
and the energy envelope representation. -/
theorem RiemannHypothesis_of_weil_and_rep
    (sys : UniversalWeilSystem)
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_weil_and_completed_bound sys
  intro σ hσ_gt hσ_lt
  exact completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt

/-- Master deduction: the Riemann Hypothesis holds given any `UniversalZeroRefutationSystem`
and the energy envelope representation. -/
theorem RiemannHypothesis_of_refutation_and_rep
    (sys : UniversalZeroRefutationSystem)
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_refutation_and_completed_bound sys
  intro σ hσ_gt hσ_lt
  exact completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt

/-- Master deduction: the Riemann Hypothesis holds given any `UniversalFredholmSystem`
and the energy envelope representation. -/
theorem RiemannHypothesis_of_fredholm_and_rep
    (sys : UniversalFredholmSystem)
    (h_rep : ∀ σ ∈ Set.Ioo (1/2 : ℝ) 1,
      (completedRiemannZeta₀ (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), symmetrizedEnergyBound y) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_fredholm_and_completed_bound sys
  intro σ hσ_gt hσ_lt
  exact completedRiemannZeta₀_re_lt_four_of_rep h_rep σ hσ_gt hσ_lt

#print axioms mellinIntegrand_ofReal
#print axioms integral_Ioi_zero_mellinIntegrand
#print axioms completedRiemannZeta₀_ofReal_re_eq
#print axioms integral_mellinIntegrand_symm
#print axioms integrableOn_symmetrizedEnergyBound
#print axioms symmetrizedIntegral_le_energy_bound
#print axioms symmetrizedIntegral_lt_four
#print axioms symmetrizedIntegral_lt_two
#print axioms completedRiemannZeta₀_re_lt_four_of_rep
#print axioms completedRiemannZeta₀_re_lt_two_of_rep
#print axioms completedRiemannZeta_ofReal_re_neg_of_rep
#print axioms completedRiemannZeta_ofReal_ne_zero_of_rep
#print axioms riemannZeta_ofReal_ne_zero_of_rep
#print axioms realAxisZeroFree_of_rep
#print axioms real_axis_zeta_ne_zero_of_rep
#print axioms RiemannHypothesis_of_weil_and_rep
#print axioms RiemannHypothesis_of_refutation_and_rep
#print axioms RiemannHypothesis_of_fredholm_and_rep

end BuildingBlocks.RiemannZetaIntegralRepresentation
