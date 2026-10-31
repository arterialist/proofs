import BuildingBlocks.ActualCriticalLowerMajorant
import BuildingBlocks.ActualCriticalLogMajorant

/-!
# The sharp constant, reduced to the double pole of `H` at `1/2`

Under RH, `W(x) = -(1/6) x^{3/2} log^2 x + O(x^{3/2} log x)`. The constant `1/6` comes from
the triple pole of the transform of `W` at `s = 1/2`, whose leading coefficient is
`-(4/3) · (1/4)`: the residue `4/3` of `(s - 1/2) M(s)` times the double-pole coefficient of
`H(s) = ∑_p (log p)^2 p^{-2s}/(1-p^{-s})^2`, namely `(2s-1)^2 H(s) → 1` as `s → 1/2⁺`.

This module proves, from that single classical asymptotic (taken as an explicit hypothesis
`hH`, not yet formalized here), that the lower bound `-C x^{3/2} log^2 x ≤ W(x)` fails
infinitely often for every `C < 1/6`. In other words

  `(2σ-1)^2 Re H(σ) → 1  ⟹  liminf W(x) / (x^{3/2} log^2 x) ≤ -1/6`,

unconditionally on RH. The argument is the abstract exclusion argument of
`ActualCriticalLowerMajorant`, with limits in place of bounds: multiply the nonnegative
Laplace transform by `(σ - 1/2)^3` and let `σ → 1/2⁺`; the `H` term tends to `-(4/3)(1/4)`,
the majorant term to `2C`, and everything else to `0`, so `2C - 1/3 ≥ 0`.

The hypothesis `hH` is a statement about primes only: `∑_p (log p)^2 p^{-2σ} ~ 1/(2σ-1)^2`.
It follows from the Laurent expansion of `ζ'/ζ` at `1` together with absolute convergence
of the prime-power corrections; formalizing it is the one missing step for the sharp
constant.
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalSharpConstant

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion
  ActualCriticalMajorantCriterion ActualCriticalLowerExcursion ActualCriticalLowerMajorant
  ActualCriticalLogMajorant

/-- The double-pole asymptotic of `H` at `1/2`, as a hypothesis on the real axis. -/
def HDoublePole : Prop :=
  Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * (SamePrimeDirichlet.H (σ : ℂ)).re)
    (𝓝[>] ((1 : ℝ) / 2)) (𝓝 1)

/-- `(σ - 1/2)^3 · logF(σ)` is real and explicit. -/
theorem cube_mul_logF {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : 1 / 2 < σ) :
    (((σ - 1 / 2 : ℝ) : ℂ)) ^ 3 * logF C A (σ : ℂ) =
      ((C * A ^ (1 / 2 - σ) *
        ((Real.log A) ^ 2 * (σ - 1 / 2) ^ 2 + 2 * Real.log A * (σ - 1 / 2) + 2) : ℝ) : ℂ) := by
  have hA0 : (0 : ℝ) ≤ A := by linarith
  have hd : (((σ - 1 / 2 : ℝ)) : ℂ) ≠ 0 := by
    have : (0 : ℝ) < σ - 1 / 2 := by linarith
    exact_mod_cast this.ne'
  have hexp : (1 / 2 - (σ : ℂ)) = (((1 / 2 - σ : ℝ)) : ℂ) := by push_cast; ring
  have hu : ((σ : ℂ) - 1 / 2) = (((σ - 1 / 2 : ℝ)) : ℂ) := by push_cast; ring
  have hd' : ((σ : ℂ) - 1 / 2) ≠ 0 := by rw [hu]; exact hd
  unfold logF P
  rw [hexp, ← Complex.ofReal_cpow hA0]
  push_cast
  set u : ℂ := (σ : ℂ) - 1 / 2 with hu'
  have hu0 : u ≠ 0 := hd'
  field_simp

theorem tendsto_cube_logF_re {C A : ℝ} (hA : 1 ≤ A) :
    Tendsto (fun σ : ℝ => ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 3 * logF C A (σ : ℂ)).re)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (2 * C)) := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hcont : ContinuousAt (fun σ : ℝ => C * A ^ (1 / 2 - σ) *
      ((Real.log A) ^ 2 * (σ - 1 / 2) ^ 2 + 2 * Real.log A * (σ - 1 / 2) + 2)) ((1 : ℝ) / 2) := by
    have h1 : ContinuousAt (fun σ : ℝ => A ^ (1 / 2 - σ)) ((1 : ℝ) / 2) :=
      (Real.continuousAt_const_rpow hA0.ne').comp (by fun_prop : ContinuousAt (fun σ : ℝ => 1 / 2 - σ) _)
    exact (continuousAt_const.mul h1).mul (by fun_prop)
  have hval : C * A ^ (1 / 2 - (1 : ℝ) / 2) *
      ((Real.log A) ^ 2 * ((1 : ℝ) / 2 - 1 / 2) ^ 2 + 2 * Real.log A * ((1 : ℝ) / 2 - 1 / 2) + 2) = 2 * C := by
    norm_num [mul_comm]
  have ht := hcont.tendsto.mono_left (nhdsWithin_le_nhds (s := Ioi ((1 : ℝ) / 2)))
  rw [hval] at ht
  refine ht.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  rw [cube_mul_logF hA hσ, Complex.ofReal_re]

/-- **Sharp constant from the double pole of `H`.** If `(2σ-1)^2 Re H(σ) → 1` as `σ → 1/2⁺`,
then for every `C < 1/6` and `A ≥ 1` the bound `-C x^{3/2} log^2 x ≤ Re W(x)` fails for some
`x > A`. -/
theorem not_eventually_lower_log_growth_of_HDoublePole (hH : HDoublePole) {C A : ℝ}
    (hA : 1 ≤ A) (hC : C < 1 / 6) :
    ¬ (∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) ≤ (ActualCriticalMellin.W x).re) := by
  intro hlow
  set D : MajorantData (1 / 2) A := logData C hA with hD
  have hlow' : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re := hlow
  have hJ := ActualCriticalLowerMajorant.lowerContinuation_analyticOnNhd D hA hlow'
  have heq : ∀ s : ℂ, 1 < s.re →
      ActualCriticalLowerMajorant.lowerContinuation D s = CriticalTransformPoles.filledTransform s :=
    fun s hs => ActualCriticalLowerMajorant.lowerContinuation_eq_filledTransform D hA hlow' hs
  have hcl := CriticalTransformContinuationRH.cleared_zero_on_rightDomain hJ heq
  have hreal : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 →
      ActualCriticalLowerMajorant.lowerContinuation D (σ : ℂ) =
        CriticalTransformPoles.filledTransform (σ : ℂ) := by
    intro σ h1 h2
    have hσ1 : (σ : ℂ) ≠ 1 := by
      intro h
      have := congrArg Complex.re h
      simp at this
      linarith
    have hz : riemannZeta (σ : ℂ) ≠ 0 :=
      RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional h1 h2
    have hdom : (σ : ℂ) ∈ rightDomain := ⟨by simpa using h1, hσ1⟩
    have h0 := hcl (σ : ℂ) hdom
    rw [CriticalTransformContinuationRH.cleared_eq hσ1 hz] at h0
    exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hz))
  set G := LogDerivativePole.centeredZetaLogDerivative with hG
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  have hhalf : ((((1 : ℝ) / 2 : ℝ)) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  have hζ : AnalyticAt ℂ riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    zeta_analytic_off_pole _ (by rw [Set.mem_compl_singleton_iff, hhalf]; norm_num)
  have hGcont : ContinuousAt G ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
    have hd : ContinuousAt (deriv riemannZeta) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := hζ.deriv.continuousAt
    have hq : ContinuousAt (fun s => deriv riemannZeta s / riemannZeta s) ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
      hd.div hζ.continuousAt riemannZeta_half_ne_zero
    have hr : ContinuousAt (fun s : ℂ => s / (s - 1)) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
      apply continuousAt_id.div (continuousAt_id.sub continuousAt_const)
      rw [hhalf]; norm_num
    have hGe : G = fun s => -(deriv riemannZeta s / riemannZeta s) - s / (s - 1) := by
      funext s
      simp [hG, LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply]
    rw [hGe]
    exact hq.neg.sub hr
  have hIcont : ContinuousAt I ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    (MellinCompactCorrection.differentiable_W_initialPart A).continuous.continuousAt
  have hcast : Tendsto (fun σ : ℝ => (σ : ℂ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((((1 : ℝ) / 2 : ℝ)) : ℂ)) :=
    Complex.continuous_ofReal.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  set B : ℝ := ‖G ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hB
  set Dc : ℝ := ‖I ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hDc
  have hGb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖G (σ : ℂ)‖ ≤ B := by
    have ht := (hGcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hIb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖I (σ : ℂ)‖ ≤ Dc := by
    have ht := (hIcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hmnorm : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖m σ‖ ≤ 2 := by
    have ht := tendsto_m.norm
    have h43 : ‖(4 / 3 : ℂ)‖ = 4 / 3 := by
      rw [show (4 / 3 : ℂ) = (((4 / 3 : ℝ)) : ℂ) by push_cast; ring, Complex.norm_real]
      norm_num
    rw [h43] at ht
    exact (ht.eventually (gt_mem_nhds (by norm_num : (4 / 3 : ℝ) < 2))).mono (fun σ h => h.le)
  have hIoo : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), σ ∈ Ioo ((1 : ℝ) / 2) 1 :=
    Ioo_mem_nhdsGT (by norm_num)
  -- the eventual inequality, multiplied by d^2 with d = σ - 1/2
  let d : ℝ → ℝ := fun σ => σ - 1 / 2
  let T1 : ℝ → ℝ := fun σ => d σ ^ 2 * (m σ * G (σ : ℂ) ^ 2).re
  let T2 : ℝ → ℝ := fun σ => (m σ).re * (d σ ^ 2 * (SamePrimeDirichlet.H (σ : ℂ)).re)
  let T3 : ℝ → ℝ := fun σ => ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 3 * logF C A (σ : ℂ)).re
  let T4 : ℝ → ℝ := fun σ => d σ ^ 3 * (I (σ : ℂ)).re
  have hineq : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), 0 ≤ T1 σ - T2 σ + T3 σ - T4 σ := by
    filter_upwards [hIoo] with σ hσI
    have h1 : 1 / 2 < σ := hσI.1
    have h2 : σ < 1 := hσI.2
    have hσ1 : (σ : ℂ) ≠ 1 := by
      intro h
      have := congrArg Complex.re h
      simp at this
      linarith
    have hd0 : 0 < σ - 1 / 2 := by linarith
    have hmom : LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ) =
        CriticalTransformPoles.filledTransform (σ : ℂ) + D.F (σ : ℂ) - I (σ : ℂ) := by
      have := hreal σ h1 h2
      unfold ActualCriticalLowerMajorant.lowerContinuation at this
      simp only [hI]
      linear_combination this
    have hfill : CriticalTransformPoles.filledTransform (σ : ℂ) =
        ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) := by
      rw [CriticalTransformPoles.filledTransform_eq_of_ne hσ1]
      rfl
    have hnn : 0 ≤ (((σ - 1 / 2 : ℝ) : ℂ) *
        LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ)).re := by
      rw [Complex.re_ofReal_mul]
      exact mul_nonneg hd0.le (lower_moment_re_nonneg D σ)
    rw [hmom, hfill] at hnn
    have hDF : D.F = logF C A := rfl
    have hexpand : ((σ - 1 / 2 : ℝ) : ℂ) *
        (ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) +
          D.F (σ : ℂ) - I (σ : ℂ)) =
        m σ * G (σ : ℂ) ^ 2 - m σ * SamePrimeDirichlet.H (σ : ℂ) +
          ((σ - 1 / 2 : ℝ) : ℂ) * logF C A (σ : ℂ) -
          ((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ) := by
      rw [hDF]
      unfold m
      ring
    rw [hexpand] at hnn
    simp only [Complex.sub_re, Complex.add_re] at hnn
    have hmH : (m σ * SamePrimeDirichlet.H (σ : ℂ)).re =
        (m σ).re * (SamePrimeDirichlet.H (σ : ℂ)).re := by
      rw [Complex.mul_re, H_im σ h1, mul_zero, sub_zero]
    have hT3 : T3 σ = (σ - 1 / 2) ^ 2 * (((σ - 1 / 2 : ℝ) : ℂ) * logF C A (σ : ℂ)).re := by
      simp only [T3]
      rw [show ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 3 * logF C A (σ : ℂ)) =
        (((((σ - 1 / 2) ^ 2 : ℝ)) : ℂ)) * (((σ - 1 / 2 : ℝ) : ℂ) * logF C A (σ : ℂ)) by push_cast; ring,
        Complex.re_ofReal_mul]
    have hT4 : T4 σ = (σ - 1 / 2) ^ 2 * (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
      simp only [T4, d]
      rw [Complex.re_ofReal_mul]
      ring
    have hsq : 0 ≤ (σ - 1 / 2) ^ 2 := sq_nonneg _
    have := mul_nonneg hsq hnn
    simp only [T1, T2, d]
    rw [hT3, hT4, hmH] at *
    nlinarith [this, hmH]
  -- limits of the four pieces
  have hd_tendsto : Tendsto d (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have : Tendsto (fun σ : ℝ => σ - 1 / 2) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((1 : ℝ) / 2 - 1 / 2)) :=
      (continuous_id.sub continuous_const).continuousAt.tendsto
    rw [show ((1 : ℝ) / 2 - 1 / 2) = 0 by norm_num] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hT1 : Tendsto T1 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T1 σ‖ ≤ 2 * B ^ 2 * (d σ ^ 2) := by
      filter_upwards [hGb, hmnorm] with σ hGσ hmσ
      simp only [T1, Real.norm_eq_abs, abs_mul, abs_pow]
      have h1 : |(m σ * G (σ : ℂ) ^ 2).re| ≤ ‖m σ * G (σ : ℂ) ^ 2‖ := Complex.abs_re_le_norm _
      have h2 : ‖m σ * G (σ : ℂ) ^ 2‖ ≤ 2 * B ^ 2 := by
        rw [norm_mul, norm_pow]
        exact mul_le_mul hmσ (pow_le_pow_left₀ (norm_nonneg _) hGσ 2) (by positivity) (by norm_num)
      have hdsq : |d σ| ^ 2 = d σ ^ 2 := sq_abs _
      rw [hdsq]
      calc d σ ^ 2 * |(m σ * G (σ : ℂ) ^ 2).re| ≤ d σ ^ 2 * (2 * B ^ 2) :=
            mul_le_mul_of_nonneg_left (h1.trans h2) (sq_nonneg _)
        _ = 2 * B ^ 2 * d σ ^ 2 := by ring
    have hlim : Tendsto (fun σ : ℝ => 2 * B ^ 2 * (d σ ^ 2)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := (hd_tendsto.pow 2).const_mul (2 * B ^ 2)
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have hT2 : Tendsto T2 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((4 / 3) * (1 / 4))) := by
    have hre : Tendsto (fun σ => (m σ).re) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((4 / 3 : ℂ).re)) :=
      (Complex.continuous_re.tendsto _).comp tendsto_m
    have h43 : (4 / 3 : ℂ).re = 4 / 3 := by norm_num
    rw [h43] at hre
    have hH' : Tendsto (fun σ : ℝ => d σ ^ 2 * (SamePrimeDirichlet.H (σ : ℂ)).re)
        (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (1 / 4)) := by
      have := hH.const_mul (1 / 4)
      rw [mul_one] at this
      refine this.congr (fun σ => ?_)
      simp only [d]
      ring
    exact hre.mul hH'
  have hT3 : Tendsto T3 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (2 * C)) := tendsto_cube_logF_re hA
  have hT4 : Tendsto T4 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T4 σ‖ ≤ Dc * |d σ ^ 3| := by
      filter_upwards [hIb] with σ hIσ
      simp only [T4, Real.norm_eq_abs, abs_mul]
      have h1 : |(I (σ : ℂ)).re| ≤ ‖I (σ : ℂ)‖ := Complex.abs_re_le_norm _
      calc |d σ ^ 3| * |(I (σ : ℂ)).re| ≤ |d σ ^ 3| * Dc :=
            mul_le_mul_of_nonneg_left (h1.trans hIσ) (abs_nonneg _)
        _ = Dc * |d σ ^ 3| := by ring
    have hlim : Tendsto (fun σ : ℝ => Dc * |d σ ^ 3|) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := ((hd_tendsto.pow 3).abs).const_mul Dc
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have hsum : Tendsto (fun σ => T1 σ - T2 σ + T3 σ - T4 σ) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 (0 - (4 / 3) * (1 / 4) + 2 * C - 0)) :=
    ((hT1.sub hT2).add hT3).sub hT4
  have hlimit_nonneg : (0 : ℝ) ≤ 0 - (4 / 3) * (1 / 4) + 2 * C - 0 := ge_of_tendsto hsum hineq
  linarith

/-- Equivalent phrasing: under the double-pole asymptotic, for every `C < 1/6` and every `B`
there is `x > B` with `Re W(x) < -C x^{3/2} log^2 x`. -/
theorem exists_sharp_lower_excursion_of_HDoublePole (hH : HDoublePole) {C : ℝ} (hC : C < 1 / 6)
    (B : ℝ) : ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) := by
  by_contra h
  push_neg at h
  apply not_eventually_lower_log_growth_of_HDoublePole hH (A := max 1 B) (le_max_left _ _) hC
  intro x hx
  exact h x (lt_of_le_of_lt (le_max_right 1 B) hx)

end BuildingBlocks.ActualCriticalSharpConstant

#print axioms BuildingBlocks.ActualCriticalSharpConstant.not_eventually_lower_log_growth_of_HDoublePole
#print axioms BuildingBlocks.ActualCriticalSharpConstant.exists_sharp_lower_excursion_of_HDoublePole
