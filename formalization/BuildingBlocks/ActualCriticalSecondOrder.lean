import BuildingBlocks.ActualCriticalUpperSharpConstant

/-!
# The second-order term of `W`: the constant `8/9 - γ/3`

`ActualCriticalUpperSharpConstant.two_sided_sharp_constant` identifies the main term
`-(1/6) x^{3/2} log² x` of `W` unconditionally from both sides. This module does the same for
the next term. With `γ` Euler's constant and

  `c₁ = 8/9 - γ/3`,

for every `ε > 0` the bounds `W(x) ≤ -(1/6) x^{3/2} log² x + (c₁ - ε) x^{3/2} log x` and
`W(x) ≥ -(1/6) x^{3/2} log² x + (c₁ + ε) x^{3/2} log x` both fail for arbitrarily large `x`:

  `liminf (W(x) + (1/6) x^{3/2} log² x) / (x^{3/2} log x) ≤ c₁ ≤ limsup (…)`.

The constant comes from the Laurent expansion of the transform `M (G² - H)` at `s = 1/2`
to order `(s - 1/2)^{-2}`: with `u = s - 1/2`,

* `u M(s) = U(s + 1/2)/(s(s+1)) = 4/3 + m₀ u + o(u)` with `m₀ = 4γ/3 - 32/9`
  (`U(s) = (s-1)ζ(s)`, `U(1) = 1`, `U'(1) = γ`);
* `u² H(s) = 1/4 + o(u)`: the `1/(w-1)` coefficient of `∑ Λ(n) log n / n^w = (ζ'/ζ)'(w)` at
  `w = 1` vanishes, and `H` differs from this series at `2s` by a bounded amount;
* so `u² M (G² - H) = -(1/3)/u - m₀/4 + o(1)`, and `c₁ = -m₀/4`.

The Landau argument of `ActualCriticalSharpConstant`, run with the majorant
`-(1/6) x^{3/2} log² x + C x^{3/2} log x` and multiplied by `u²` instead of `u³`, gives
`C + m₀/4 ≥ 0` on the upper side and `-C - m₀/4 ≥ 0` on the lower side.
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalSecondOrder

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion
  ActualCriticalMajorantCriterion ActualCriticalLowerExcursion ActualCriticalLowerMajorant
  ActualCriticalLogMajorant ActualCriticalSharpConstant ActualCriticalHDoublePole
  ActualCriticalUpperSharpConstant RiemannZetaCenteredLogDeriv PrimePowerLogSeries
  SamePrimeDirichlet

/-! ### The residue function `u M(s)` and its derivative at `1/2` -/

/-- `(s - 1/2) M(s)`, filled analytically: `U(s + 1/2)/(s(s+1))`. -/
noncomputable def mA (s : ℂ) : ℂ := U (s + 1 / 2) / (s * (s + 1))

theorem mA_eq {s : ℂ} (hs : s ≠ 1 / 2) : mA s = (s - 1 / 2) * ShiftedZetaMultiplier.M s := by
  unfold mA ShiftedZetaMultiplier.M
  have h1 : s + 1 / 2 ≠ 1 := by
    intro h
    apply hs
    linear_combination h
  rw [U_eq_of_ne h1]
  have : (s + 1 / 2 - 1 : ℂ) = s - 1 / 2 := by ring
  rw [this]
  ring

theorem mA_half : mA (1 / 2) = 4 / 3 := by
  unfold mA
  rw [show ((1 : ℂ) / 2 + 1 / 2) = 1 by norm_num, U_one]
  norm_num

/-- The first Laurent coefficient `m₀ = 4γ/3 - 32/9` of `M` at `1/2` after the pole. -/
noncomputable def m₀ : ℝ := 4 / 3 * Real.eulerMascheroniConstant - 32 / 9

theorem hasDerivAt_mA : HasDerivAt mA (m₀ : ℂ) (1 / 2) := by
  have hU : HasDerivAt U (Real.eulerMascheroniConstant : ℂ) ((1 / 2 : ℂ) + 1 / 2) := by
    rw [show ((1 : ℂ) / 2 + 1 / 2) = 1 by norm_num]
    exact hasDerivAt_U_one
  have hN : HasDerivAt (fun s : ℂ => U (s + 1 / 2)) (Real.eulerMascheroniConstant : ℂ)
      (1 / 2) :=
    hU.comp_add_const (1 / 2 : ℂ) (1 / 2 : ℂ)
  have hD : HasDerivAt (fun s : ℂ => s * (s + 1)) (1 * ((1 / 2 : ℂ) + 1) + (1 / 2 : ℂ) * 1)
      (1 / 2) :=
    (hasDerivAt_id (1 / 2 : ℂ)).mul ((hasDerivAt_id (1 / 2 : ℂ)).add_const 1)
  have hD0 : ((1 / 2 : ℂ) * ((1 / 2 : ℂ) + 1)) ≠ 0 := by norm_num
  have h := hN.div hD hD0
  refine h.congr_deriv ?_
  simp only [m₀]
  rw [show ((1 : ℂ) / 2 + 1 / 2) = 1 by norm_num, U_one]
  push_cast
  ring

/-- The real embedding `σ ↦ σ` tends to the punctured neighbourhood of `1/2`. -/
theorem tendsto_ofReal_half :
    Tendsto (fun σ : ℝ => (σ : ℂ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝[≠] (1 / 2 : ℂ)) := by
  apply tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within
  · have h : Tendsto (fun σ : ℝ => (σ : ℂ)) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((((1 : ℝ) / 2 : ℝ)) : ℂ)) :=
      Complex.continuous_ofReal.continuousAt.tendsto
    rw [show ((((1 : ℝ) / 2 : ℝ)) : ℂ) = 1 / 2 by push_cast; ring] at h
    exact h.mono_left nhdsWithin_le_nhds
  · filter_upwards [self_mem_nhdsWithin] with σ hσ
    have h1 : (1 : ℝ) / 2 < σ := hσ
    show (σ : ℂ) ≠ 1 / 2
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith

/-- The slope of `m` at `1/2` along the real axis tends to `m₀`. -/
theorem tendsto_m_slope :
    Tendsto (fun σ : ℝ => ((m σ).re - 4 / 3) / (σ - 1 / 2)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 m₀) := by
  have hs := (hasDerivAt_iff_tendsto_slope.mp hasDerivAt_mA).comp tendsto_ofReal_half
  have hre := (Complex.continuous_re.tendsto _).comp hs
  simp only [Complex.ofReal_re] at hre
  refine hre.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  have h1 : (1 : ℝ) / 2 < σ := hσ
  have hne : (σ : ℂ) ≠ 1 / 2 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hu : ((σ : ℂ) - 1 / 2) = (((σ - 1 / 2 : ℝ)) : ℂ) := by push_cast; ring
  show ((((σ : ℂ) - 1 / 2)⁻¹ • (mA (σ : ℂ) - mA (1 / 2)))).re = ((m σ).re - 4 / 3) / (σ - 1 / 2)
  rw [mA_half, mA_eq hne, smul_eq_mul, hu]
  have hm : m σ = (((σ - 1 / 2 : ℝ)) : ℂ) * ShiftedZetaMultiplier.M (σ : ℂ) := rfl
  rw [← hm, ← div_eq_inv_mul, Complex.div_ofReal_re, Complex.sub_re]
  norm_num

/-! ### The second-order expansion of `H` at `1/2` -/

/-- `V = U'/U`, analytic near `1`. -/
noncomputable def V (z : ℂ) : ℂ := deriv U z / U z

theorem T_eq_eventually :
    ∀ᶠ w : ℝ in 𝓝[>] (1 : ℝ), T w = (deriv V (w : ℂ)).re + 1 / (w - 1) ^ 2 := by
  obtain ⟨O, hO, hOopen, h1O⟩ := eventually_nhds_iff.mp eventually_U_ne_zero
  have hcast : Tendsto (fun w : ℝ => (w : ℂ)) (𝓝[>] (1 : ℝ)) (𝓝 ((1 : ℝ) : ℂ)) :=
    Complex.continuous_ofReal.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  have hcast' : Tendsto (fun w : ℝ => (w : ℂ)) (𝓝[>] (1 : ℝ)) (𝓝 (1 : ℂ)) := by
    simpa using hcast
  have hevO : ∀ᶠ w : ℝ in 𝓝[>] (1 : ℝ), (w : ℂ) ∈ O := hcast' (hOopen.mem_nhds h1O)
  filter_upwards [hevO, self_mem_nhdsWithin] with w hwO hw
  have hw' : (1 : ℝ) < w := hw
  have hw1 : (w : ℂ) ≠ 1 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hU : ∀ᶠ z in 𝓝 (w : ℂ), U z ≠ 0 := by
    filter_upwards [hOopen.mem_nhds hwO] with z hz
    exact hO z hz
  have h1 : ((T w : ℝ) : ℂ) = deriv V (w : ℂ) + 1 / ((w : ℂ) - 1) ^ 2 := by
    rw [T_eq_LSeries hw', LSeries_logMul_eq_deriv hw', deriv_logDeriv_zeta_eq hw1 hU]
    rfl
  have h2 := congrArg Complex.re h1
  rw [Complex.ofReal_re, Complex.add_re] at h2
  rw [h2]
  congr 1
  rw [show ((w : ℂ) - 1) = ((w - 1 : ℝ) : ℂ) by push_cast; ring, ← Complex.ofReal_pow,
    ← Complex.ofReal_one, ← Complex.ofReal_div, Complex.ofReal_re]

theorem continuousAt_deriv_V_one : ContinuousAt (deriv V) 1 := continuousAt_deriv_V

/-- `((σ-1/2)² Re H(σ) - 1/4)/(σ - 1/2) → 0`: the `1/(σ-1/2)` coefficient of `H` vanishes. -/
theorem tendsto_H_second :
    Tendsto (fun σ : ℝ => ((σ - 1 / 2) ^ 2 * (H (σ : ℂ)).re - 1 / 4) / (σ - 1 / 2))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
  have hcast2 : Tendsto (fun σ : ℝ => ((2 * σ : ℝ) : ℂ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (1 : ℂ)) := by
    have h : Tendsto (fun σ : ℝ => ((2 * σ : ℝ) : ℂ)) (𝓝 ((1 : ℝ) / 2))
        (𝓝 (((2 * ((1 : ℝ) / 2) : ℝ)) : ℂ)) :=
      (Complex.continuous_ofReal.comp (continuous_const.mul continuous_id)).continuousAt.tendsto
    rw [show (((2 * ((1 : ℝ) / 2) : ℝ)) : ℂ) = 1 by push_cast; ring] at h
    exact h.mono_left nhdsWithin_le_nhds
  have hVlim : Tendsto (fun σ : ℝ => (deriv V ((2 * σ : ℝ) : ℂ)).re) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 ((deriv V 1).re)) :=
    (Complex.continuous_re.tendsto _).comp (continuousAt_deriv_V_one.tendsto.comp hcast2)
  have hd : Tendsto (fun σ : ℝ => σ - 1 / 2) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have : Tendsto (fun σ : ℝ => σ - 1 / 2) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((1 : ℝ) / 2 - 1 / 2)) :=
      (continuous_id.sub continuous_const).continuousAt.tendsto
    rw [show ((1 : ℝ) / 2 - 1 / 2) = 0 by norm_num] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hlow : Tendsto (fun σ : ℝ => (σ - 1 / 2) * ((deriv V ((2 * σ : ℝ) : ℂ)).re - C₂))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have := hd.mul (hVlim.sub_const C₂)
    simpa using this
  have hup : Tendsto (fun σ : ℝ => (σ - 1 / 2) * ((deriv V ((2 * σ : ℝ) : ℂ)).re + C₁))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have := hd.mul (hVlim.add_const C₁)
    simpa using this
  have hT : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2),
      T (2 * σ) = (deriv V ((2 * σ : ℝ) : ℂ)).re + 1 / (2 * σ - 1) ^ 2 :=
    tendsto_two_mul.eventually T_eq_eventually
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow hup ?_ ?_
  · filter_upwards [hT, self_mem_nhdsWithin] with σ hTσ hσ
    have h1 : (1 : ℝ) / 2 < σ := hσ
    have hw : (1 : ℝ) < 2 * σ := by linarith
    have hd0 : 0 < σ - 1 / 2 := by linarith
    have hTS := (S_le_T_le hw).2
    rw [show 2 * σ / 2 = σ by ring] at hTS
    have hS := S_le_H_re h1
    unfold S at hS
    -- Re H ≥ T(2σ) - C₂
    have hH : T (2 * σ) - C₂ ≤ (H (σ : ℂ)).re := by linarith
    rw [hTσ] at hH
    rw [le_div_iff₀ hd0]
    have hsq : (σ - 1 / 2) ^ 2 * (1 / (2 * σ - 1) ^ 2) = 1 / 4 := by
      have hne : (2 * σ - 1) ≠ 0 := by linarith
      have : (σ - 1 / 2) ^ 2 * (1 / (2 * σ - 1) ^ 2) = (σ - 1 / 2) ^ 2 / (2 * σ - 1) ^ 2 := by
        ring
      rw [this, div_eq_iff (pow_ne_zero 2 hne)]
      ring
    nlinarith [hsq, mul_le_mul_of_nonneg_left hH (sq_nonneg (σ - 1 / 2))]
  · filter_upwards [hT, self_mem_nhdsWithin] with σ hTσ hσ
    have h1 : (1 : ℝ) / 2 < σ := hσ
    have hw : (1 : ℝ) < 2 * σ := by linarith
    have hd0 : 0 < σ - 1 / 2 := by linarith
    have hTS := (S_le_T_le hw).1
    rw [show 2 * σ / 2 = σ by ring] at hTS
    have hH' := H_re_le h1
    unfold S at hH'
    have hH : (H (σ : ℂ)).re ≤ T (2 * σ) + C₁ := by linarith
    rw [hTσ] at hH
    rw [div_le_iff₀ hd0]
    have hsq : (σ - 1 / 2) ^ 2 * (1 / (2 * σ - 1) ^ 2) = 1 / 4 := by
      have hne : (2 * σ - 1) ≠ 0 := by linarith
      have : (σ - 1 / 2) ^ 2 * (1 / (2 * σ - 1) ^ 2) = (σ - 1 / 2) ^ 2 / (2 * σ - 1) ^ 2 := by
        ring
      rw [this, div_eq_iff (pow_ne_zero 2 hne)]
      ring
    nlinarith [hsq, mul_le_mul_of_nonneg_left hH (sq_nonneg (σ - 1 / 2))]

/-- `(σ-1/2)² Re H(σ) → 1/4`. -/
theorem tendsto_sq_H :
    Tendsto (fun σ : ℝ => (σ - 1 / 2) ^ 2 * (H (σ : ℂ)).re) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (1 / 4)) := by
  have h := hDoublePole
  unfold HDoublePole at h
  have := h.const_mul (1 / 4)
  rw [show (1 / 4 : ℝ) * 1 = 1 / 4 by norm_num] at this
  refine this.congr' ?_
  filter_upwards with σ
  ring

/-! ### The majorant `C x^{3/2} log x` -/

/-- `L/u + 1/u²` with `u = s - 1/2`. -/
noncomputable def P₁ (s : ℂ) (L : ℂ) : ℂ := L / (s - 1 / 2) + 1 / (s - 1 / 2) ^ 2

/-- The antiderivative `-C x^{1/2-s} P₁(log x)`. -/
noncomputable def Phi₁ (C : ℝ) (s : ℂ) (x : ℝ) : ℂ :=
  -(C : ℂ) * ((x : ℂ) ^ (1 / 2 - s) * P₁ s (Real.log x : ℂ))

/-- The tail transform `C A^{1/2-s} P₁(log A)`. -/
noncomputable def log1F (C A : ℝ) (s : ℂ) : ℂ :=
  (C : ℂ) * ((A : ℂ) ^ (1 / 2 - s) * P₁ s (Real.log A : ℂ))

noncomputable def log1Majorant (C : ℝ) (x : ℝ) : ℝ := C * x ^ ((3 : ℝ) / 2) * Real.log x

noncomputable def log1Kernel (C : ℝ) (s : ℂ) (x : ℝ) : ℂ :=
  (x : ℂ) ^ (-s - 2) * (log1Majorant C x : ℂ)

theorem log1Kernel_eq {C : ℝ} {s : ℂ} {x : ℝ} (hx : 0 < x) :
    log1Kernel C s x = (C : ℂ) * ((x : ℂ) ^ (-s - 1 / 2) * (Real.log x : ℂ)) := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  unfold log1Kernel log1Majorant
  rw [Complex.ofReal_mul, Complex.ofReal_mul, Complex.ofReal_cpow hx.le]
  rw [show (x : ℂ) ^ (-s - 2) * ((C : ℂ) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ) * (Real.log x : ℂ)) =
      (C : ℂ) * (((x : ℂ) ^ (-s - 2) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ)) * (Real.log x : ℂ)) by
        ring,
    ← Complex.cpow_add _ _ hn]
  congr 3
  push_cast
  ring

theorem measurable_log1Majorant (C : ℝ) : Measurable (log1Majorant C) :=
  (measurable_const.mul (measurable_id.pow_const _)).mul Real.measurable_log

theorem hasDerivAt_Phi₁ {C : ℝ} {s : ℂ} (hs : s ≠ 1 / 2) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (Phi₁ C s) ((C : ℂ) * ((x : ℂ) ^ (-s - 1 / 2) * (Real.log x : ℂ))) x := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  have hu : (s - 1 / 2 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  have hw : (1 / 2 - s : ℂ) ≠ 0 := by
    intro h
    apply hs
    linear_combination -h
  have hpow : HasDerivAt (fun y : ℝ => (y : ℂ) ^ (1 / 2 - s))
      ((1 / 2 - s) * (x : ℂ) ^ (1 / 2 - s - 1)) x :=
    hasDerivAt_ofReal_cpow_const hx.ne' hw
  have hL : HasDerivAt (fun y : ℝ => (Real.log y : ℂ)) ((x⁻¹ : ℝ) : ℂ) x :=
    (Real.hasDerivAt_log hx.ne').ofReal_comp
  have h1 : HasDerivAt (fun y : ℝ => (Real.log y : ℂ) / (s - 1 / 2))
      (((x⁻¹ : ℝ) : ℂ) / (s - 1 / 2)) x :=
    hL.div_const _
  have h2 : HasDerivAt (fun _ : ℝ => (1 : ℂ) / (s - 1 / 2) ^ 2) 0 x := hasDerivAt_const x _
  have hP : HasDerivAt (fun y : ℝ => P₁ s (Real.log y : ℂ))
      (((x⁻¹ : ℝ) : ℂ) / (s - 1 / 2) + 0) x :=
    h1.fun_add h2
  have hΦ := (hpow.fun_mul hP).const_mul (-(C : ℂ))
  refine hΦ.congr_deriv ?_
  have e1 : (x : ℂ) ^ (1 / 2 - s - 1) = (x : ℂ) ^ (-s - 1 / 2) := by
    congr 1
    ring
  have e2 : (x : ℂ) ^ (1 / 2 - s) = (x : ℂ) ^ (-s - 1 / 2) * (x : ℂ) := by
    rw [show (1 / 2 - s : ℂ) = (-s - 1 / 2) + 1 by ring, Complex.cpow_add _ _ hn, Complex.cpow_one]
  rw [e1, e2, Complex.ofReal_inv, show (1 / 2 - s : ℂ) = -(s - 1 / 2) by ring]
  simp only [P₁]
  set X : ℂ := (x : ℂ) ^ (-s - 1 / 2) with hX
  set u : ℂ := s - 1 / 2 with hu'
  have hu0 : u ≠ 0 := hu
  field_simp
  ring

theorem tendsto_log_mul_rpow {σ : ℝ} (hσ : 1 / 2 < σ) :
    Tendsto (fun x : ℝ => Real.log x * x ^ (1 / 2 - σ)) atTop (𝓝 0) := by
  have h := (isLittleO_log_rpow_rpow_atTop (1 : ℝ)
    (by linarith : 0 < σ - 1 / 2)).tendsto_div_nhds_zero
  refine h.congr' ?_
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  rw [Real.rpow_one, show (1 / 2 - σ : ℝ) = -(σ - 1 / 2) by ring, Real.rpow_neg hx.le,
    div_eq_mul_inv]

theorem norm_P₁_le {s : ℂ} (hs : s ≠ 1 / 2) {L : ℂ} (hL : 1 ≤ ‖L‖) :
    ‖P₁ s L‖ ≤ (1 / ‖s - 1 / 2‖ + 1 / ‖s - 1 / 2‖ ^ 2) * ‖L‖ := by
  have hu : 0 < ‖s - 1 / 2‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hs)
  unfold P₁
  calc ‖L / (s - 1 / 2) + 1 / (s - 1 / 2) ^ 2‖
      ≤ ‖L / (s - 1 / 2)‖ + ‖1 / (s - 1 / 2) ^ 2‖ := norm_add_le _ _
    _ = ‖L‖ / ‖s - 1 / 2‖ + 1 / ‖s - 1 / 2‖ ^ 2 := by
        simp only [norm_div, norm_pow, norm_one]
    _ ≤ ‖L‖ / ‖s - 1 / 2‖ + ‖L‖ / ‖s - 1 / 2‖ ^ 2 := by gcongr
    _ = (1 / ‖s - 1 / 2‖ + 1 / ‖s - 1 / 2‖ ^ 2) * ‖L‖ := by ring

theorem tendsto_Phi₁ {C : ℝ} {s : ℂ} (hs : 1 / 2 < s.re) :
    Tendsto (Phi₁ C s) atTop (𝓝 0) := by
  have hs' : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  set K : ℝ := 1 / ‖s - 1 / 2‖ + 1 / ‖s - 1 / 2‖ ^ 2 with hK
  have hK0 : 0 ≤ K := by positivity
  have hlim : Tendsto (fun x : ℝ => |C| * K * (Real.log x * x ^ (1 / 2 - s.re))) atTop (𝓝 0) := by
    have := (tendsto_log_mul_rpow hs).const_mul (|C| * K)
    simpa using this
  refine squeeze_zero_norm' ?_ hlim
  filter_upwards [eventually_ge_atTop (Real.exp 1)] with x hx
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos 1) hx
  have hlog1 : 1 ≤ Real.log x := by
    rw [← Real.log_exp 1]
    exact Real.log_le_log (Real.exp_pos 1) hx
  have hLnorm : ‖(Real.log x : ℂ)‖ = Real.log x := by
    rw [Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  unfold Phi₁
  rw [norm_mul, norm_mul, norm_neg, Complex.norm_real, Real.norm_eq_abs,
    Complex.norm_cpow_eq_rpow_re_of_pos hx0]
  have hre : (1 / 2 - s : ℂ).re = 1 / 2 - s.re := by simp
  rw [hre]
  have hP := norm_P₁_le hs' (L := (Real.log x : ℂ)) (by rw [hLnorm]; exact hlog1)
  rw [hLnorm] at hP
  calc |C| * (x ^ (1 / 2 - s.re) * ‖P₁ s (Real.log x : ℂ)‖)
      ≤ |C| * (x ^ (1 / 2 - s.re) * (K * Real.log x)) := by gcongr
    _ = |C| * K * (Real.log x * x ^ (1 / 2 - s.re)) := by ring

theorem integrableOn_log1Kernel {C A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 / 2 < s.re) :
    IntegrableOn (log1Kernel C s) (Ioi A) := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  set ε : ℝ := (s.re - 1 / 2) / 2 with hε
  have hε0 : 0 < ε := by rw [hε]; linarith
  have hexp : -s.re - 1 / 2 + ε < -1 := by rw [hε]; linarith
  have hg : IntegrableOn (fun x : ℝ => (|C| / ε) * x ^ (-s.re - 1 / 2 + ε)) (Ioi A) :=
    (integrableOn_Ioi_rpow_of_lt hexp hA0).const_mul _
  refine hg.mono' ?_ ?_
  · apply Measurable.aestronglyMeasurable
    unfold log1Kernel
    exact (Measurable.pow Complex.measurable_ofReal measurable_const).mul
      (Complex.measurable_ofReal.comp (measurable_log1Majorant C))
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    have hx1 : 1 < x := lt_of_le_of_lt hA hx
    have hx0 : 0 < x := zero_lt_one.trans hx1
    rw [log1Kernel_eq hx0, norm_mul, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      Complex.norm_cpow_eq_rpow_re_of_pos hx0, Complex.norm_real,
      Real.norm_of_nonneg (Real.log_nonneg hx1.le)]
    have hre : (-s - 1 / 2 : ℂ).re = -s.re - 1 / 2 := by simp
    rw [hre]
    have hlog : Real.log x ≤ x ^ ε / ε := log_le_rpow_div hx0 hε0
    have hsplit : x ^ (-s.re - 1 / 2 + ε) = x ^ (-s.re - 1 / 2) * x ^ ε := Real.rpow_add hx0 _ _
    rw [hsplit]
    have hxp : 0 ≤ x ^ (-s.re - 1 / 2) := Real.rpow_nonneg hx0.le _
    calc |C| * (x ^ (-s.re - 1 / 2) * Real.log x)
        ≤ |C| * (x ^ (-s.re - 1 / 2) * (x ^ ε / ε)) := by gcongr
      _ = |C| / ε * (x ^ (-s.re - 1 / 2) * x ^ ε) := by field_simp

theorem integral_log1Kernel {C A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 / 2 < s.re) :
    (∫ x : ℝ in Ioi A, log1Kernel C s x) = log1F C A s := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hs' : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  have hderiv : ∀ x ∈ Ioi A, HasDerivAt (Phi₁ C s) (log1Kernel C s x) x := by
    intro x hx
    have hx0 : 0 < x := lt_trans hA0 hx
    rw [log1Kernel_eq hx0]
    exact hasDerivAt_Phi₁ hs' hx0
  have hcont : ContinuousWithinAt (Phi₁ C s) (Ici A) A :=
    (hasDerivAt_Phi₁ hs' hA0).continuousAt.continuousWithinAt
  rw [integral_Ioi_of_hasDerivAt_of_tendsto hcont hderiv (integrableOn_log1Kernel hA hs)
    (tendsto_Phi₁ hs)]
  unfold Phi₁ log1F
  ring

theorem log1F_analyticAt {C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : s ≠ 1 / 2) :
    AnalyticAt ℂ (log1F C A) s := by
  have hu : (s - 1 / 2 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  unfold log1F P₁
  have hexp : AnalyticAt ℂ (fun z : ℂ => (1 : ℂ) / 2 - z) s := analyticAt_const.sub analyticAt_id
  have hpow : AnalyticAt ℂ (fun z : ℂ => (A : ℂ) ^ (1 / 2 - z)) s :=
    analyticAt_const.cpow hexp (Complex.ofReal_mem_slitPlane.mpr hA)
  have hden : AnalyticAt ℂ (fun z : ℂ => z - 1 / 2) s := analyticAt_id.sub analyticAt_const
  have hP : AnalyticAt ℂ (fun z : ℂ => (Real.log A : ℂ) / (z - 1 / 2) + 1 / (z - 1 / 2) ^ 2) s :=
    (analyticAt_const.div hden hu).add (analyticAt_const.div (hden.pow 2) (pow_ne_zero 2 hu))
  exact analyticAt_const.mul (hpow.mul hP)

/-- The majorant datum for `C x^{3/2} log x`. -/
noncomputable def log1Data (C : ℝ) {A : ℝ} (hA : 1 ≤ A) : MajorantData (1 / 2) A where
  g := log1Majorant C
  measurable_g := measurable_log1Majorant C
  F := log1F C A
  half_le := le_rfl
  analytic_F := by
    intro s hs
    have hne : s ≠ 1 / 2 := by
      intro h
      rw [h] at hs
      simp at hs
    exact log1F_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne
  integrable_kernel := fun s hs => integrableOn_log1Kernel hA (by linarith [hs] : 1 / 2 < s.re)
  integral_kernel := fun s hs => integral_log1Kernel hA (by linarith [hs] : 1 / 2 < s.re)

/-! ### Sums of majorant data -/

/-- The sum of two majorant data at the same level and cutoff. -/
noncomputable def addData {θ A : ℝ} (D₁ D₂ : MajorantData θ A) : MajorantData θ A where
  g := fun x => D₁.g x + D₂.g x
  measurable_g := D₁.measurable_g.add D₂.measurable_g
  F := fun s => D₁.F s + D₂.F s
  half_le := D₁.half_le
  analytic_F := fun s hs => (D₁.analytic_F s hs).add (D₂.analytic_F s hs)
  integrable_kernel := by
    intro s hs
    have h := (D₁.integrable_kernel s hs).add (D₂.integrable_kernel s hs)
    refine h.congr_fun ?_ measurableSet_Ioi
    intro x _
    simp only [Pi.add_apply]
    push_cast
    ring
  integral_kernel := by
    intro s hs
    have h1 := D₁.integral_kernel s hs
    have h2 := D₂.integral_kernel s hs
    rw [← h1, ← h2, ← integral_add (D₁.integrable_kernel s hs) (D₂.integrable_kernel s hs)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x _
    push_cast
    ring

/-! ### Asymptotics of the majorant transforms at `1/2` -/

theorem sq_mul_log1F {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : 1 / 2 < σ) :
    (((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F C A (σ : ℂ) =
      ((C * A ^ (1 / 2 - σ) * (Real.log A * (σ - 1 / 2) + 1) : ℝ) : ℂ) := by
  have hA0 : (0 : ℝ) ≤ A := by linarith
  have hd : (((σ - 1 / 2 : ℝ)) : ℂ) ≠ 0 := by
    have : (0 : ℝ) < σ - 1 / 2 := by linarith
    exact_mod_cast this.ne'
  have hexp : (1 / 2 - (σ : ℂ)) = (((1 / 2 - σ : ℝ)) : ℂ) := by push_cast; ring
  have hu : ((σ : ℂ) - 1 / 2) = (((σ - 1 / 2 : ℝ)) : ℂ) := by push_cast; ring
  have hd' : ((σ : ℂ) - 1 / 2) ≠ 0 := by rw [hu]; exact hd
  unfold log1F P₁
  rw [hexp, ← Complex.ofReal_cpow hA0]
  push_cast
  set u : ℂ := (σ : ℂ) - 1 / 2 with hu'
  have hu0 : u ≠ 0 := hd'
  field_simp

theorem tendsto_sq_log1F_re {C A : ℝ} (hA : 1 ≤ A) :
    Tendsto (fun σ : ℝ => ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F C A (σ : ℂ)).re)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 C) := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hcont : ContinuousAt (fun σ : ℝ => C * A ^ (1 / 2 - σ) * (Real.log A * (σ - 1 / 2) + 1))
      ((1 : ℝ) / 2) := by
    have h1 : ContinuousAt (fun σ : ℝ => A ^ (1 / 2 - σ)) ((1 : ℝ) / 2) :=
      (Real.continuousAt_const_rpow hA0.ne').comp
        (by fun_prop : ContinuousAt (fun σ : ℝ => 1 / 2 - σ) _)
    exact (continuousAt_const.mul h1).mul (by fun_prop)
  have hval : C * A ^ (1 / 2 - (1 : ℝ) / 2) * (Real.log A * ((1 : ℝ) / 2 - 1 / 2) + 1) = C := by
    norm_num
  have ht := hcont.tendsto.mono_left (nhdsWithin_le_nhds (s := Ioi ((1 : ℝ) / 2)))
  rw [hval] at ht
  refine ht.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  rw [sq_mul_log1F hA hσ, Complex.ofReal_re]

/-- The slope of `σ ↦ A^{1/2-σ}` at `1/2` is `-log A`. -/
theorem tendsto_rpow_slope {A : ℝ} (hA : 0 < A) :
    Tendsto (fun σ : ℝ => (A ^ (1 / 2 - σ) - 1) / (σ - 1 / 2)) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 (-Real.log A)) := by
  have hd : HasDerivAt (fun σ : ℝ => A ^ (1 / 2 - σ))
      (A ^ (1 / 2 - (1 : ℝ) / 2) * Real.log A * (-1)) ((1 : ℝ) / 2) := by
    have h := (Real.hasStrictDerivAt_const_rpow hA (1 / 2 - (1 : ℝ) / 2)).hasDerivAt
    exact h.comp ((1 : ℝ) / 2) ((hasDerivAt_id ((1 : ℝ) / 2)).const_sub (1 / 2))
  have hval : A ^ (1 / 2 - (1 : ℝ) / 2) * Real.log A * (-1) = -Real.log A := by
    norm_num
  rw [hval] at hd
  have hs := (hasDerivAt_iff_tendsto_slope.mp hd).comp
    (tendsto_id'.mpr (nhdsWithin_mono ((1 : ℝ) / 2) (fun x hx => ne_of_gt hx)) :
      Tendsto id (𝓝[>] ((1 : ℝ) / 2)) (𝓝[≠] ((1 : ℝ) / 2)))
  refine hs.congr' ?_
  filter_upwards with σ
  simp only [Function.comp_apply, id_eq, slope_def_field, sub_self, Real.rpow_zero]

/-- `(u² logF C A σ).re - 2C/u → 0`: the `log A` terms cancel to first order. -/
theorem tendsto_sq_logF_re_sub {C A : ℝ} (hA : 1 ≤ A) :
    Tendsto (fun σ : ℝ =>
      ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF C A (σ : ℂ)).re - 2 * C / (σ - 1 / 2))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  set L : ℝ := Real.log A with hL
  have hcont : ContinuousAt (fun σ : ℝ => C * A ^ (1 / 2 - σ) * (L ^ 2 * (σ - 1 / 2) + 2 * L))
      ((1 : ℝ) / 2) := by
    have h1 : ContinuousAt (fun σ : ℝ => A ^ (1 / 2 - σ)) ((1 : ℝ) / 2) :=
      (Real.continuousAt_const_rpow hA0.ne').comp
        (by fun_prop : ContinuousAt (fun σ : ℝ => 1 / 2 - σ) _)
    exact (continuousAt_const.mul h1).mul (by fun_prop)
  have hval : C * A ^ (1 / 2 - (1 : ℝ) / 2) * (L ^ 2 * ((1 : ℝ) / 2 - 1 / 2) + 2 * L) = 2 * C * L := by
    norm_num
    ring
  have ht := hcont.tendsto.mono_left (nhdsWithin_le_nhds (s := Ioi ((1 : ℝ) / 2)))
  rw [hval] at ht
  have hlim := ht.add ((tendsto_rpow_slope hA0).const_mul (2 * C))
  rw [show 2 * C * L + 2 * C * -Real.log A = 0 by rw [hL]; ring] at hlim
  refine hlim.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  have h1 : (1 : ℝ) / 2 < σ := hσ
  have hd0 : 0 < σ - 1 / 2 := by linarith
  have hd : (((σ - 1 / 2 : ℝ)) : ℂ) ≠ 0 := by exact_mod_cast hd0.ne'
  have hsq : ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF C A (σ : ℂ)).re =
      (C * A ^ (1 / 2 - σ) * (L ^ 2 * (σ - 1 / 2) ^ 2 + 2 * L * (σ - 1 / 2) + 2)) / (σ - 1 / 2) := by
    have h3 := cube_mul_logF (C := C) hA h1
    have : (((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF C A (σ : ℂ) =
        ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 3 * logF C A (σ : ℂ)) / (((σ - 1 / 2 : ℝ)) : ℂ) := by
      field_simp
    rw [this, h3, ← Complex.ofReal_div, Complex.ofReal_re]
  rw [hsq]
  have hne : σ - 1 / 2 ≠ 0 := hd0.ne'
  set Ap : ℝ := A ^ (1 / 2 - σ) with hAp
  set u : ℝ := σ - 1 / 2 with hu
  rw [div_sub_div_same, eq_div_iff hne, add_mul, mul_assoc (2 * C), div_mul_cancel₀ _ hne]
  ring

/-! ### The second-order constant -/

/-- `c₁ = 8/9 - γ/3`, the coefficient of `x^{3/2} log x` in the expansion of `W`. -/
noncomputable def c₁ : ℝ := 8 / 9 - Real.eulerMascheroniConstant / 3

theorem c₁_eq : c₁ = -m₀ / 4 := by
  unfold c₁ m₀
  ring

/-- Numerically, `2/3 < c₁ < 13/18`, from Mathlib's bounds `1/2 < γ < 2/3`. -/
theorem c₁_bounds : 2 / 3 < c₁ ∧ c₁ < 13 / 18 := by
  unfold c₁
  have h1 := Real.one_half_lt_eulerMascheroniConstant
  have h2 := Real.eulerMascheroniConstant_lt_two_thirds
  constructor <;> linarith

/-- `(Re m(σ) · (σ-1/2)² Re H(σ) - 1/3)/(σ - 1/2) → m₀/4`. -/
theorem tendsto_T2 :
    Tendsto (fun σ : ℝ => ((m σ).re * ((σ - 1 / 2) ^ 2 * (H (σ : ℂ)).re) - 1 / 3) / (σ - 1 / 2))
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (m₀ / 4)) := by
  have h1 := tendsto_m_slope.mul tendsto_sq_H
  have h2 := tendsto_H_second.const_mul (4 / 3)
  have h := h1.add h2
  rw [show m₀ * (1 / 4) + 4 / 3 * 0 = m₀ / 4 by ring] at h
  refine h.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  have h1' : (1 : ℝ) / 2 < σ := hσ
  have hne : σ - 1 / 2 ≠ 0 := (by linarith : (0 : ℝ) < σ - 1 / 2).ne'
  field_simp
  ring

/-- Under the upper bound `Re W(x) ≤ -(1/6) x^{3/2} log² x + C x^{3/2} log x` for `x > A`, the
Laplace transform `L` of the positive measure satisfies `(σ-1/2)² L(σ) → C + m₀/4`. -/
theorem tendsto_sq_upper_moment {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) :
    Tendsto (fun σ : ℝ => (σ - 1 / 2) ^ 2 * (LaplaceMomentDerivatives.moment
      (growthMeasure (addData (logData (-(1 / 6)) hA) (log1Data C hA))) time 0 (σ : ℂ)).re)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (C + m₀ / 4)) := by
  set D : MajorantData (1 / 2) A := addData (logData (-(1 / 6)) hA) (log1Data C hA) with hD
  have hgrow' : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x := fun x hx => hgrow x hx
  have hJ := ActualCriticalMajorantCriterion.continuation_analyticOnNhd D hA hgrow'
  have heq : ∀ s : ℂ, 1 < s.re →
      ActualCriticalMajorantCriterion.continuation D s = CriticalTransformPoles.filledTransform s :=
    fun s hs => ActualCriticalMajorantCriterion.continuation_eq_filledTransform D hA hgrow' hs
  have hcl := CriticalTransformContinuationRH.cleared_zero_on_rightDomain hJ heq
  have hreal : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 →
      ActualCriticalMajorantCriterion.continuation D (σ : ℂ) =
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
    have hq : ContinuousAt (fun s => deriv riemannZeta s / riemannZeta s)
        ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
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
  let d : ℝ → ℝ := fun σ => σ - 1 / 2
  let T1 : ℝ → ℝ := fun σ => d σ * (m σ * G (σ : ℂ) ^ 2).re
  let T2 : ℝ → ℝ := fun σ => ((m σ).re * (d σ ^ 2 * (H (σ : ℂ)).re) - 1 / 3) / d σ
  let T3 : ℝ → ℝ := fun σ =>
    ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF (-(1 / 6)) A (σ : ℂ)).re + 1 / 3 / d σ
  let T4 : ℝ → ℝ := fun σ => ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F C A (σ : ℂ)).re
  let T5 : ℝ → ℝ := fun σ => d σ ^ 2 * (I (σ : ℂ)).re
  have hev : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), T3 σ + T4 σ + T5 σ - T1 σ + T2 σ =
      (σ - 1 / 2) ^ 2 *
        (LaplaceMomentDerivatives.moment (growthMeasure D) time 0 (σ : ℂ)).re := by
    filter_upwards [hIoo] with σ hσI
    have h1 : 1 / 2 < σ := hσI.1
    have h2 : σ < 1 := hσI.2
    have hσ1 : (σ : ℂ) ≠ 1 := by
      intro h
      have := congrArg Complex.re h
      simp at this
      linarith
    have hd0 : 0 < σ - 1 / 2 := by linarith
    have hmom : LaplaceMomentDerivatives.moment (growthMeasure D) time 0 (σ : ℂ) =
        D.F (σ : ℂ) + I (σ : ℂ) - CriticalTransformPoles.filledTransform (σ : ℂ) := by
      have := hreal σ h1 h2
      unfold ActualCriticalMajorantCriterion.continuation at this
      simp only [hI]
      linear_combination -this
    have hfill : CriticalTransformPoles.filledTransform (σ : ℂ) =
        ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - H (σ : ℂ)) := by
      rw [CriticalTransformPoles.filledTransform_eq_of_ne hσ1]
      rfl
    have hDF : D.F = fun s => logF (-(1 / 6)) A s + log1F C A s := rfl
    have hexpand : ((σ - 1 / 2 : ℝ) : ℂ) *
        (D.F (σ : ℂ) + I (σ : ℂ) -
          ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - H (σ : ℂ))) =
        ((σ - 1 / 2 : ℝ) : ℂ) * logF (-(1 / 6)) A (σ : ℂ) +
          ((σ - 1 / 2 : ℝ) : ℂ) * log1F C A (σ : ℂ) +
          ((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ) - m σ * G (σ : ℂ) ^ 2 + m σ * H (σ : ℂ) := by
      rw [hDF]
      unfold m
      ring
    have hmH : (m σ * H (σ : ℂ)).re = (m σ).re * (H (σ : ℂ)).re := by
      rw [Complex.mul_re, H_im σ h1, mul_zero, sub_zero]
    have hL : (((σ - 1 / 2 : ℝ) : ℂ) *
        LaplaceMomentDerivatives.moment (growthMeasure D) time 0 (σ : ℂ)).re =
        (((σ - 1 / 2 : ℝ) : ℂ) * logF (-(1 / 6)) A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * log1F C A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re -
          (m σ * G (σ : ℂ) ^ 2).re + (m σ).re * (H (σ : ℂ)).re := by
      rw [hmom, hfill, hexpand]
      simp only [Complex.sub_re, Complex.add_re]
      rw [hmH]
    have hT3 : T3 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * logF (-(1 / 6)) A (σ : ℂ)).re +
        1 / 3 / (σ - 1 / 2) := by
      simp only [T3, d]
      rw [show ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF (-(1 / 6)) A (σ : ℂ)) =
        (((σ - 1 / 2 : ℝ)) : ℂ) * (((σ - 1 / 2 : ℝ) : ℂ) * logF (-(1 / 6)) A (σ : ℂ)) by ring,
        Complex.re_ofReal_mul]
    have hT4 : T4 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * log1F C A (σ : ℂ)).re := by
      simp only [T4]
      rw [show ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F C A (σ : ℂ)) =
        (((σ - 1 / 2 : ℝ)) : ℂ) * (((σ - 1 / 2 : ℝ) : ℂ) * log1F C A (σ : ℂ)) by ring,
        Complex.re_ofReal_mul]
    have hT5 : T5 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
      simp only [T5, d]
      rw [Complex.re_ofReal_mul]
      ring
    have hT2 : T2 σ = (σ - 1 / 2) * ((m σ).re * (H (σ : ℂ)).re) - 1 / 3 / (σ - 1 / 2) := by
      simp only [T2, d]
      have hne : σ - 1 / 2 ≠ 0 := hd0.ne'
      field_simp
    have hsum : T3 σ + T4 σ + T5 σ - T1 σ + T2 σ =
        (σ - 1 / 2) * ((((σ - 1 / 2 : ℝ) : ℂ) * logF (-(1 / 6)) A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * log1F C A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re -
          (m σ * G (σ : ℂ) ^ 2).re + (m σ).re * (H (σ : ℂ)).re) := by
      rw [hT3, hT4, hT5, hT2]
      simp only [T1, d]
      ring
    rw [hsum, ← hL, Complex.re_ofReal_mul]
    ring
  have hd_tendsto : Tendsto d (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have : Tendsto (fun σ : ℝ => σ - 1 / 2) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((1 : ℝ) / 2 - 1 / 2)) :=
      (continuous_id.sub continuous_const).continuousAt.tendsto
    rw [show ((1 : ℝ) / 2 - 1 / 2) = 0 by norm_num] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hT1 : Tendsto T1 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T1 σ‖ ≤ 2 * B ^ 2 * |d σ| := by
      filter_upwards [hGb, hmnorm] with σ hGσ hmσ
      simp only [T1, Real.norm_eq_abs, abs_mul]
      have h1 : |(m σ * G (σ : ℂ) ^ 2).re| ≤ ‖m σ * G (σ : ℂ) ^ 2‖ := Complex.abs_re_le_norm _
      have h2 : ‖m σ * G (σ : ℂ) ^ 2‖ ≤ 2 * B ^ 2 := by
        rw [norm_mul, norm_pow]
        exact mul_le_mul hmσ (pow_le_pow_left₀ (norm_nonneg _) hGσ 2) (by positivity)
          (by norm_num)
      calc |d σ| * |(m σ * G (σ : ℂ) ^ 2).re| ≤ |d σ| * (2 * B ^ 2) :=
            mul_le_mul_of_nonneg_left (h1.trans h2) (abs_nonneg _)
        _ = 2 * B ^ 2 * |d σ| := by ring
    have hlim : Tendsto (fun σ : ℝ => 2 * B ^ 2 * |d σ|) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := hd_tendsto.abs.const_mul (2 * B ^ 2)
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have hT2 : Tendsto T2 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (m₀ / 4)) := tendsto_T2
  have hT3 : Tendsto T3 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have h := tendsto_sq_logF_re_sub (C := -(1 / 6)) hA
    refine h.congr' ?_
    filter_upwards with σ
    simp only [T3, d]
    ring
  have hT4 : Tendsto T4 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 C) := tendsto_sq_log1F_re hA
  have hT5 : Tendsto T5 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T5 σ‖ ≤ Dc * d σ ^ 2 := by
      filter_upwards [hIb] with σ hIσ
      simp only [T5, Real.norm_eq_abs, abs_mul, abs_pow, sq_abs]
      have h1 : |(I (σ : ℂ)).re| ≤ ‖I (σ : ℂ)‖ := Complex.abs_re_le_norm _
      calc d σ ^ 2 * |(I (σ : ℂ)).re| ≤ d σ ^ 2 * Dc :=
            mul_le_mul_of_nonneg_left (h1.trans hIσ) (sq_nonneg _)
        _ = Dc * d σ ^ 2 := by ring
    have hlim : Tendsto (fun σ : ℝ => Dc * d σ ^ 2) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := (hd_tendsto.pow 2).const_mul Dc
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have htot : Tendsto (fun σ => T3 σ + T4 σ + T5 σ - T1 σ + T2 σ) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 (0 + C + 0 - 0 + m₀ / 4)) :=
    (((hT3.add hT4).add hT5).sub hT1).add hT2
  rw [show ((0 : ℝ) + C + 0 - 0 + m₀ / 4) = C + m₀ / 4 by ring] at htot
  exact htot.congr' hev

/-- **Upper second-order exclusion.** For `C < c₁` and `A ≥ 1`, the bound
`Re W(x) ≤ -(1/6) x^{3/2} log² x + C x^{3/2} log x` fails for some `x > A`. -/
theorem not_eventually_upper_second_order {C A : ℝ} (hA : 1 ≤ A) (hC : C < c₁) :
    ¬ (∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) := by
  intro hgrow
  have h := tendsto_sq_upper_moment hA hgrow
  have hnn : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), 0 ≤ (σ - 1 / 2) ^ 2 *
      (LaplaceMomentDerivatives.moment
        (growthMeasure (addData (logData (-(1 / 6)) hA) (log1Data C hA))) time 0 (σ : ℂ)).re :=
    Filter.Eventually.of_forall (fun σ => mul_nonneg (sq_nonneg _) (growth_moment_re_nonneg _ σ))
  have hge := ge_of_tendsto h hnn
  rw [c₁_eq] at hC
  linarith

/-- Under the lower bound `-(1/6) x^{3/2} log² x + C x^{3/2} log x ≤ Re W(x)` for `x > A`, the
Laplace transform `L` of the positive measure satisfies `(σ-1/2)² L(σ) → -m₀/4 - C`. -/
theorem tendsto_sq_lower_moment {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x →
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x ≤
          (ActualCriticalMellin.W x).re) :
    Tendsto (fun σ : ℝ => (σ - 1 / 2) ^ 2 * (LaplaceMomentDerivatives.moment
      (lowerMeasure (addData (logData (1 / 6) hA) (log1Data (-C) hA))) time 0 (σ : ℂ)).re)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (-m₀ / 4 - C)) := by
  set D : MajorantData (1 / 2) A := addData (logData (1 / 6) hA) (log1Data (-C) hA) with hD
  have hlow' : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re := by
    intro x hx
    have h := hlow x hx
    show -(logMajorant (1 / 6) x + log1Majorant (-C) x) ≤ _
    unfold logMajorant log1Majorant
    linarith
  have hJ := lowerContinuation_analyticOnNhd D hA hlow'
  have heq : ∀ s : ℂ, 1 < s.re →
      ActualCriticalLowerMajorant.lowerContinuation D s = CriticalTransformPoles.filledTransform s :=
    fun s hs => lowerContinuation_eq_filledTransform D hA hlow' hs
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
    have hq : ContinuousAt (fun s => deriv riemannZeta s / riemannZeta s)
        ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
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
  let d : ℝ → ℝ := fun σ => σ - 1 / 2
  let T1 : ℝ → ℝ := fun σ => d σ * (m σ * G (σ : ℂ) ^ 2).re
  let T2 : ℝ → ℝ := fun σ => ((m σ).re * (d σ ^ 2 * (H (σ : ℂ)).re) - 1 / 3) / d σ
  let T3 : ℝ → ℝ := fun σ =>
    ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF (1 / 6) A (σ : ℂ)).re - 1 / 3 / d σ
  let T4 : ℝ → ℝ := fun σ => ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F (-C) A (σ : ℂ)).re
  let T5 : ℝ → ℝ := fun σ => d σ ^ 2 * (I (σ : ℂ)).re
  have hev : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), T1 σ - T2 σ + T3 σ + T4 σ - T5 σ =
      (σ - 1 / 2) ^ 2 *
        (LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ)).re := by
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
        ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - H (σ : ℂ)) := by
      rw [CriticalTransformPoles.filledTransform_eq_of_ne hσ1]
      rfl
    have hDF : D.F = fun s => logF (1 / 6) A s + log1F (-C) A s := rfl
    have hexpand : ((σ - 1 / 2 : ℝ) : ℂ) *
        (ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - H (σ : ℂ)) + D.F (σ : ℂ) - I (σ : ℂ)) =
        m σ * G (σ : ℂ) ^ 2 - m σ * H (σ : ℂ) +
          ((σ - 1 / 2 : ℝ) : ℂ) * logF (1 / 6) A (σ : ℂ) +
          ((σ - 1 / 2 : ℝ) : ℂ) * log1F (-C) A (σ : ℂ) -
          ((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ) := by
      rw [hDF]
      unfold m
      ring
    have hmH : (m σ * H (σ : ℂ)).re = (m σ).re * (H (σ : ℂ)).re := by
      rw [Complex.mul_re, H_im σ h1, mul_zero, sub_zero]
    have hL : (((σ - 1 / 2 : ℝ) : ℂ) *
        LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ)).re =
        (m σ * G (σ : ℂ) ^ 2).re - (m σ).re * (H (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * logF (1 / 6) A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * log1F (-C) A (σ : ℂ)).re -
          (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
      rw [hmom, hfill, hexpand]
      simp only [Complex.sub_re, Complex.add_re]
      rw [hmH]
    have hT3 : T3 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * logF (1 / 6) A (σ : ℂ)).re -
        1 / 3 / (σ - 1 / 2) := by
      simp only [T3, d]
      rw [show ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * logF (1 / 6) A (σ : ℂ)) =
        (((σ - 1 / 2 : ℝ)) : ℂ) * (((σ - 1 / 2 : ℝ) : ℂ) * logF (1 / 6) A (σ : ℂ)) by ring,
        Complex.re_ofReal_mul]
    have hT4 : T4 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * log1F (-C) A (σ : ℂ)).re := by
      simp only [T4]
      rw [show ((((σ - 1 / 2 : ℝ) : ℂ)) ^ 2 * log1F (-C) A (σ : ℂ)) =
        (((σ - 1 / 2 : ℝ)) : ℂ) * (((σ - 1 / 2 : ℝ) : ℂ) * log1F (-C) A (σ : ℂ)) by ring,
        Complex.re_ofReal_mul]
    have hT5 : T5 σ = (σ - 1 / 2) * (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
      simp only [T5, d]
      rw [Complex.re_ofReal_mul]
      ring
    have hT2 : T2 σ = (σ - 1 / 2) * ((m σ).re * (H (σ : ℂ)).re) - 1 / 3 / (σ - 1 / 2) := by
      simp only [T2, d]
      have hne : σ - 1 / 2 ≠ 0 := hd0.ne'
      field_simp
    have hsum : T1 σ - T2 σ + T3 σ + T4 σ - T5 σ =
        (σ - 1 / 2) * ((m σ * G (σ : ℂ) ^ 2).re - (m σ).re * (H (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * logF (1 / 6) A (σ : ℂ)).re +
          (((σ - 1 / 2 : ℝ) : ℂ) * log1F (-C) A (σ : ℂ)).re -
          (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re) := by
      rw [hT3, hT4, hT5, hT2]
      simp only [T1, d]
      ring
    rw [hsum, ← hL, Complex.re_ofReal_mul]
    ring
  have hd_tendsto : Tendsto d (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have : Tendsto (fun σ : ℝ => σ - 1 / 2) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((1 : ℝ) / 2 - 1 / 2)) :=
      (continuous_id.sub continuous_const).continuousAt.tendsto
    rw [show ((1 : ℝ) / 2 - 1 / 2) = 0 by norm_num] at this
    exact this.mono_left nhdsWithin_le_nhds
  have hT1 : Tendsto T1 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T1 σ‖ ≤ 2 * B ^ 2 * |d σ| := by
      filter_upwards [hGb, hmnorm] with σ hGσ hmσ
      simp only [T1, Real.norm_eq_abs, abs_mul]
      have h1 : |(m σ * G (σ : ℂ) ^ 2).re| ≤ ‖m σ * G (σ : ℂ) ^ 2‖ := Complex.abs_re_le_norm _
      have h2 : ‖m σ * G (σ : ℂ) ^ 2‖ ≤ 2 * B ^ 2 := by
        rw [norm_mul, norm_pow]
        exact mul_le_mul hmσ (pow_le_pow_left₀ (norm_nonneg _) hGσ 2) (by positivity)
          (by norm_num)
      calc |d σ| * |(m σ * G (σ : ℂ) ^ 2).re| ≤ |d σ| * (2 * B ^ 2) :=
            mul_le_mul_of_nonneg_left (h1.trans h2) (abs_nonneg _)
        _ = 2 * B ^ 2 * |d σ| := by ring
    have hlim : Tendsto (fun σ : ℝ => 2 * B ^ 2 * |d σ|) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := hd_tendsto.abs.const_mul (2 * B ^ 2)
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have hT2 : Tendsto T2 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (m₀ / 4)) := tendsto_T2
  have hT3 : Tendsto T3 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have h := tendsto_sq_logF_re_sub (C := 1 / 6) hA
    refine h.congr' ?_
    filter_upwards with σ
    simp only [T3, d]
    ring
  have hT4 : Tendsto T4 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 (-C)) := tendsto_sq_log1F_re hA
  have hT5 : Tendsto T5 (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
    have hbound : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖T5 σ‖ ≤ Dc * d σ ^ 2 := by
      filter_upwards [hIb] with σ hIσ
      simp only [T5, Real.norm_eq_abs, abs_mul, abs_pow, sq_abs]
      have h1 : |(I (σ : ℂ)).re| ≤ ‖I (σ : ℂ)‖ := Complex.abs_re_le_norm _
      calc d σ ^ 2 * |(I (σ : ℂ)).re| ≤ d σ ^ 2 * Dc :=
            mul_le_mul_of_nonneg_left (h1.trans hIσ) (sq_nonneg _)
        _ = Dc * d σ ^ 2 := by ring
    have hlim : Tendsto (fun σ : ℝ => Dc * d σ ^ 2) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
      have := (hd_tendsto.pow 2).const_mul Dc
      simpa using this
    exact squeeze_zero_norm' hbound hlim
  have htot : Tendsto (fun σ => T1 σ - T2 σ + T3 σ + T4 σ - T5 σ) (𝓝[>] ((1 : ℝ) / 2))
      (𝓝 (0 - m₀ / 4 + 0 + -C - 0)) :=
    (((hT1.sub hT2).add hT3).add hT4).sub hT5
  rw [show ((0 : ℝ) - m₀ / 4 + 0 + -C - 0) = -m₀ / 4 - C by ring] at htot
  exact htot.congr' hev

/-- **Lower second-order exclusion.** For `c₁ < C` and `A ≥ 1`, the bound
`-(1/6) x^{3/2} log² x + C x^{3/2} log x ≤ Re W(x)` fails for some `x > A`. -/
theorem not_eventually_lower_second_order {C A : ℝ} (hA : 1 ≤ A) (hC : c₁ < C) :
    ¬ (∀ x : ℝ, A < x →
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x ≤
          (ActualCriticalMellin.W x).re) := by
  intro hlow
  have h := tendsto_sq_lower_moment hA hlow
  have hnn : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), 0 ≤ (σ - 1 / 2) ^ 2 *
      (LaplaceMomentDerivatives.moment
        (lowerMeasure (addData (logData (1 / 6) hA) (log1Data (-C) hA))) time 0 (σ : ℂ)).re :=
    Filter.Eventually.of_forall (fun σ => mul_nonneg (sq_nonneg _) (lower_moment_re_nonneg _ σ))
  have hge := ge_of_tendsto h hnn
  rw [c₁_eq] at hC
  linarith

/-! ### The two-sided theorem -/

theorem exists_upper_second_order_excursion {C : ℝ} (hC : C < c₁) (B : ℝ) :
    ∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
      C * x ^ ((3 : ℝ) / 2) * Real.log x < (ActualCriticalMellin.W x).re := by
  by_contra h
  push Not at h
  apply not_eventually_upper_second_order (A := max 1 B) (le_max_left _ _) hC
  intro x hx
  exact h x (lt_of_le_of_lt (le_max_right _ _) hx)

theorem exists_lower_second_order_excursion {C : ℝ} (hC : c₁ < C) (B : ℝ) :
    ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
      -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x := by
  by_contra h
  push Not at h
  apply not_eventually_lower_second_order (A := max 1 B) (le_max_left _ _) hC
  intro x hx
  exact h x (lt_of_le_of_lt (le_max_right _ _) hx)

/-- **The second-order constant, two-sided.** With `c₁ = 8/9 - γ/3`, for every `ε > 0` and
every `B` there are `x > B` with
`W(x) > -(1/6) x^{3/2} log² x + (c₁ - ε) x^{3/2} log x` and with
`W(x) < -(1/6) x^{3/2} log² x + (c₁ + ε) x^{3/2} log x`; so
`liminf (W + (1/6) x^{3/2} log² x)/(x^{3/2} log x) ≤ c₁ ≤ limsup (…)`. -/
theorem second_order_two_sided {ε : ℝ} (hε : 0 < ε) (B : ℝ) :
    (∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
      (c₁ - ε) * x ^ ((3 : ℝ) / 2) * Real.log x < (ActualCriticalMellin.W x).re) ∧
    (∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
      -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
        (c₁ + ε) * x ^ ((3 : ℝ) / 2) * Real.log x) :=
  ⟨exists_upper_second_order_excursion (by linarith) B,
    exists_lower_second_order_excursion (by linarith) B⟩

end BuildingBlocks.ActualCriticalSecondOrder
