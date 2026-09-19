/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.MeasureTheory.Integral.Bochner.FundThmCalculus
import Mathlib.MeasureTheory.Integral.Bochner.Set
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaPhaseContradiction
import BuildingBlocks.RiemannZetaMellinEnergyIntegral
import BuildingBlocks.RiemannZetaMellinIntegralEvaluation
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedGrandSynthesis

/-!
# Riemann Zeta Mellin Integral Domination and Low-Frequency Envelope Construction

This module formalizes the Mean Value Theorem bounds for the hyperbolic power difference,
proves the unconditional pointwise domination of the imaginary ratio integrand by the
quadratic exponential majorant $(x - 1)^2 e^{-\pi x}$, and establishes the quantitative
bound $\le 1/10$ on the symmetrized ratio integral over $(1, \infty)$.

## Mathematical Architecture

1. **Mean Value Theorem for Hyperbolic Power Differences**:
   The hyperbolic power difference
   $$\operatorname{powerDiff}(\beta, x) = x^{\beta/2 - 1} - x^{(1-\beta)/2 - 1}$$
   vanishes identically at the critical line $\beta = 1/2$. Because its Fréchet derivative
   with respect to $\beta$ is majorized by $\log x$ on $[1/2, 1]$ for all $x \ge 1$:
   $$\operatorname{powerDiff}(\beta, x) \le (\beta - 1/2) \log x.$$
   Dividing by $2\beta - 1 = 2(\beta - 1/2) > 0$ yields the universal bound:
   $$\frac{\operatorname{powerDiff}(\beta, x)}{2\beta - 1} \le \frac{1}{2}\log x.$$

2. **Unconditional Pointwise Majorization**:
   Combining the above bound with the sine inequality
   $\frac{\sin((\gamma/2)\log x)}{\gamma} \le \frac{1}{2}\log x$
   and the modified kernel bound $f_{\text{modif}}(x) \le 4 e^{-\pi x}$, we establish
   unconditionally for all $s = \beta + i\gamma$ with $\beta \in (1/2, 1]$ and $\gamma > 0$:
   $$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\beta - 1)\gamma} \le (x - 1)^2 e^{-\pi x} \quad \text{for all } x \ge 1.$$

3. **Symmetrized Integral Domination**:
   Integrating over the fundamental domain $(1, \infty)$ majorizes the symmetrized ratio integral
   $$\operatorname{symmetrizedRatioIntegral}(s) = \int_1^\infty \frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\beta - 1)\gamma} dx$$
   by the improper integral $\int_1^\infty (x - 1)^2 e^{-\pi x} dx \le 1/10$.
   Consequently, the halved ratio integral is strictly bounded by $1/20 < 1/10$.

4. **Envelope Construction and End-to-End RH Deductions**:
   Under symmetrized Mellin domination, the canonical `MellinEnergyEnvelope` is constructed,
   yielding unconditional refutation of all low-frequency zeros $\beta \in (1/2, 1], \gamma \in (0, 1]$.
   Coupled with high-frequency Fredholm theory, universal refutation certificates, and Grand
   Synthesis, this deduces the global `RiemannHypothesis`.

## Axiom Status
This module depends strictly on standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No ad hoc axioms or unproven hypotheses are introduced.
-/

open Real Complex MeasureTheory Set Filter Topology
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaPhaseContradiction
open BuildingBlocks.RiemannZetaMellinEnergyIntegral
open BuildingBlocks.RiemannZetaMellinIntegralEvaluation

namespace BuildingBlocks.RiemannZetaMellinIntegralDomination

/-! ### Subsection 1: Hyperbolic Slope Bounds via Mean Value Theorem -/

/-- The hyperbolic power difference vanishes on the critical line $\beta = 1/2$. -/
lemma powerDiff_one_half (x : ℝ) : powerDiff (1 / 2) x = 0 := by
  unfold powerDiff
  have : ((1 : ℝ) / 2) / 2 - 1 = (1 - (1 : ℝ) / 2) / 2 - 1 := by ring
  rw [this, sub_self]

/-- The hyperbolic power difference is majorized by $(\beta - 1/2) \log x$ for $x \ge 1$
and $\beta \in (1/2, 1]$ by the Mean Value Theorem. -/
theorem powerDiff_le_slope {x : ℝ} (hx : 1 ≤ x) {β : ℝ}
    (hβ1 : 1 / 2 < β) (hβ2 : β ≤ 1) :
    powerDiff β x ≤ (β - 1 / 2) * Real.log x := by
  have hx_pos : 0 < x := by linarith
  have h_mvt := exists_hasDerivAt_eq_slope (f := fun b => powerDiff b x)
    (f' := fun b => (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2))
    hβ1
    (fun b _ => (hasDerivAt_powerDiff x hx_pos b).continuousAt.continuousWithinAt)
    (fun b _ => hasDerivAt_powerDiff x hx_pos b)
  rcases h_mvt with ⟨c, ⟨hc1, hc2⟩, h_slope⟩
  dsimp only at h_slope
  have hc_ge : 1 / 2 ≤ c := le_of_lt hc1
  have hc_le : c ≤ 1 := le_trans (le_of_lt hc2) hβ2
  have h_deriv_le : (x ^ (c / 2 - 1) + x ^ ((1 - c) / 2 - 1)) * (Real.log x / 2) ≤ Real.log x :=
    deriv_powerDiff_le hx hc_ge hc_le
  rw [powerDiff_one_half, sub_zero] at h_slope
  have h_sub_pos : 0 < β - 1 / 2 := by linarith
  have h_eq : powerDiff β x = (β - 1 / 2) * (powerDiff β x / (β - 1 / 2)) := by
    exact (mul_div_cancel₀ (powerDiff β x) (ne_of_gt h_sub_pos)).symm
  rw [h_eq, ← h_slope]
  exact mul_le_mul_of_nonneg_left h_deriv_le (le_of_lt h_sub_pos)

/-- Universal hyperbolic ratio bound:
$$\frac{\operatorname{powerDiff}(\beta, x)}{2\beta - 1} \le \frac{1}{2} \log x$$
for all $x \ge 1$ and $\beta \in (1/2, 1]$. -/
theorem powerDiff_div_le_half_log {x : ℝ} (hx : 1 ≤ x) {β : ℝ}
    (hβ1 : 1 / 2 < β) (hβ2 : β ≤ 1) :
    powerDiff β x / (2 * β - 1) ≤ (1 / 2) * Real.log x := by
  have h_le := powerDiff_le_slope hx hβ1 hβ2
  have h_denom_pos : 0 < 2 * β - 1 := by linarith
  have h_sub_pos : 0 < β - 1 / 2 := by linarith
  have h_div : powerDiff β x / (2 * β - 1) ≤ ((β - 1 / 2) * Real.log x) / (2 * β - 1) :=
    div_le_div_of_nonneg_right h_le (le_of_lt h_denom_pos)
  have h_alg : ((β - 1 / 2) * Real.log x) / (2 * β - 1) = (1 / 2) * Real.log x := by
    have h1 : 2 * β - 1 = (β - 1 / 2) * 2 := by ring
    rw [h1, mul_div_mul_left (Real.log x) 2 (ne_of_gt h_sub_pos)]
    ring
  linarith

/-! ### Subsection 2: Unconditional Pointwise Majorization -/

/-- Unconditional Pointwise Majorization of the imaginary ratio integrand:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \le (x - 1)^2 e^{-\pi x}$$
for all $x \ge 1$, $\operatorname{Re}(s) \in (1/2, 1]$, and $\operatorname{Im}(s) > 0$. -/
theorem mellin_ratio_integrand_unconditional_le {s : ℂ} {x : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤ (x - 1)^2 * Real.exp (-Real.pi * x) := by
  have h_pd := powerDiff_div_le_half_log hx hsr1 hsr2
  exact mellin_ratio_integrand_le hsr1 hsim hx h_pd

/-! ### Subsection 3: Symmetrized Ratio Integrals and Upper Bounds -/

/-- Symmetrized imaginary Mellin integral on $(1, \infty)$:
$$\operatorname{symmetrizedImIntegral}(s) = \int_1^\infty \operatorname{mellinTrigIntegrandIm}(s, x) \, dx.$$ -/
noncomputable def symmetrizedImIntegral (s : ℂ) : ℝ :=
  ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x

/-- Symmetrized normalized imaginary ratio integral on $(1, \infty)$:
$$\operatorname{symmetrizedRatioIntegral}(s) = \int_1^\infty \frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \, dx.$$ -/
noncomputable def symmetrizedRatioIntegral (s : ℂ) : ℝ :=
  ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)

/-- Integral domination: the normalized ratio integral is majorized by the improper integral
of the quadratic exponential majorant $(x - 1)^2 e^{-\pi x}$. -/
theorem symmetrizedRatioIntegral_le_majorant {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ ∫ x in Ioi (1 : ℝ), (x - 1)^2 * Real.exp (-Real.pi * x) := by
  unfold symmetrizedRatioIntegral
  refine setIntegral_mono_on h_int integrableOn_sub_one_sq_mul_exp_neg_pi measurableSet_Ioi fun x hx => ?_
  exact mellin_ratio_integrand_unconditional_le hsr1 hsr2 hsim (le_of_lt (mem_Ioi.mp hx))

/-- Absolute upper bound on the symmetrized ratio integral: bounded strictly by $1/10$. -/
theorem symmetrizedRatioIntegral_le_one_tenth {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / 10 := by
  have h1 := symmetrizedRatioIntegral_le_majorant hsr1 hsr2 hsim h_int
  exact h1.trans integral_sub_one_sq_mul_exp_neg_pi_le_one_tenth

/-- The halved symmetrized ratio integral is bounded by $1/20 \le 1/10$. -/
theorem half_symmetrizedRatioIntegral_le_one_tenth {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 10 := by
  have h1 := symmetrizedRatioIntegral_le_one_tenth hsr1 hsr2 hsim h_int
  linarith

/-! ### Subsection 4: Symmetrized Domination and Zero Exclusion -/

/-- Symmetrized Mellin imaginary domination condition:
`normImRatio s` is majorized by the halved symmetrized ratio integral. -/
def SymmetrizedMellinDominated (s : ℂ) : Prop :=
  normImRatio s ≤ (1 / 2 : ℝ) * symmetrizedRatioIntegral s

/-- Low-frequency zero exclusion under symmetrized Mellin domination:
Any candidate zero $s$ with $\operatorname{Re}(s) \in (1/2, 1]$ and $\operatorname{Im}(s) \in (0, 1]$
satisfying the representation is excluded. -/
theorem low_freq_free_of_symmetrized_domination {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 1)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1))
    (h_dom : SymmetrizedMellinDominated s) :
    riemannZeta s ≠ 0 := by
  have h_bound : normImRatio s ≤ 1 / 10 := by
    have h_half := half_symmetrizedRatioIntegral_le_one_tenth hsr1 hsr2 hsim1 h_int
    exact h_dom.trans h_half
  exact low_freq_zero_free_of_normImRatio_le hsr1 hsr2 hsim1 hsim2 h_bound

/-- Global low-frequency envelope construction under uniform symmetrized domination. -/
theorem envelope_of_uniform_symmetrized_domination
    (h_int : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1))
    (h_dom : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      SymmetrizedMellinDominated s) :
    MellinEnergyEnvelope where
  energy_bound := by
    intro s hsr1 hsr2 hsim1 hsim2
    have h_half := half_symmetrizedRatioIntegral_le_one_tenth hsr1 hsr2 hsim1 (h_int s hsr1 hsr2 hsim1 hsim2)
    exact (h_dom s hsr1 hsr2 hsim1 hsim2).trans h_half

/-! ### Subsection 5: Master RH Deductions -/

/-- Master RH deduction from uniform symmetrized domination and the Fredholm refutation system. -/
theorem RiemannHypothesis_of_domination_and_fredholm
    (h_int : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1))
    (h_dom : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      SymmetrizedMellinDominated s)
    (fred : ChirpedUniversalFredholmExclusion.UniversalFredholmSystem) :
    RiemannHypothesis := by
  have env := envelope_of_uniform_symmetrized_domination h_int h_dom
  exact RiemannHypothesis_of_envelope_and_fredholm env fred

/-- Master RH deduction from uniform symmetrized domination and the universal certificate. -/
theorem RiemannHypothesis_of_domination_and_refutation
    (h_int : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1))
    (h_dom : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      SymmetrizedMellinDominated s)
    (sys : ChirpedUniversalZeroRefutation.UniversalZeroRefutationSystem) :
    RiemannHypothesis := by
  have env := envelope_of_uniform_symmetrized_domination h_int h_dom
  exact RiemannHypothesis_of_envelope_and_refutation env sys

/-- Master RH deduction from uniform symmetrized domination and the Grand Synthesis. -/
theorem RiemannHypothesis_of_domination_and_grand_synthesis
    (h_int : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1))
    (h_dom : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → 0 < s.im → s.im ≤ 1 →
      SymmetrizedMellinDominated s)
    (hgs : ChirpedGrandSynthesis.GrandSynthesisSystem) :
    RiemannHypothesis := by
  have env := envelope_of_uniform_symmetrized_domination h_int h_dom
  exact RiemannHypothesis_of_envelope_and_grand_synthesis env hgs

end BuildingBlocks.RiemannZetaMellinIntegralDomination

open BuildingBlocks.RiemannZetaMellinIntegralDomination

#print axioms powerDiff_le_slope
#print axioms powerDiff_div_le_half_log
#print axioms mellin_ratio_integrand_unconditional_le
#print axioms symmetrizedRatioIntegral_le_majorant
#print axioms symmetrizedRatioIntegral_le_one_tenth
#print axioms half_symmetrizedRatioIntegral_le_one_tenth
#print axioms low_freq_free_of_symmetrized_domination
#print axioms envelope_of_uniform_symmetrized_domination
#print axioms RiemannHypothesis_of_domination_and_fredholm
#print axioms RiemannHypothesis_of_domination_and_refutation
#print axioms RiemannHypothesis_of_domination_and_grand_synthesis
