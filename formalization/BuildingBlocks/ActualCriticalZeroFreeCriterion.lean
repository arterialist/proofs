import BuildingBlocks.ActualCriticalLowerMajorant
import BuildingBlocks.ActualCriticalLogMajorant

/-!
# Zero-free half-planes and oscillation of `W` at every level `θ ∈ [1/2, 1)`

The growth criteria of `ActualCriticalMajorantCriterion` and `ActualCriticalLowerMajorant`
are stated here at an arbitrary level `θ`: for `1/2 ≤ θ < 1`,

  `Re W(x) ≤ C x^{1+θ}` for all large `x`  ⟹  `ζ(ρ) ≠ 0` whenever `Re ρ > θ`,

and the same with `-C x^{1+θ} ≤ Re W(x)`. Read contrapositively this is the oscillation
theorem for `W`: a zero `ρ` with `Re ρ = β > 1/2` forces, for every `θ < β` and every `C`,
both `Re W(x) > C x^{1+θ}` and `Re W(x) < -C x^{1+θ}` for arbitrarily large `x`
(`oscillation_of_zero`). In particular, if RH fails then `W/(x^{3/2} log² x)` is unbounded
in both directions (`log_oscillation_of_not_RH`), and in fact unbounded at some power scale
`x^{1+θ}` with `θ > 1/2` (`power_oscillation_of_not_RH`).

Together with the unconditional two-sided sharp constant of
`ActualCriticalUpperSharpConstant` this gives the full unconditional picture of
`W/(x^{3/2} log² x)`: its lower limit is `≤ -1/6 ≤` its upper limit, and either both limits
are infinite (if RH fails) or RH holds.
-/

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualCriticalZeroFreeCriterion

open ActualCriticalGrowthCriterion ActualCriticalMajorantCriterion ActualCriticalLowerMajorant
  ActualCriticalLogMajorant

/-! ### The power majorant `C x^{1+θ}` -/

/-- The power majorant `C x^{1+θ}`. -/
noncomputable def powerMajorantAt (θ C : ℝ) (x : ℝ) : ℝ := C * x ^ (1 + θ)

theorem measurable_powerMajorantAt (θ C : ℝ) : Measurable (powerMajorantAt θ C) :=
  measurable_const.mul (measurable_id.pow_const _)

/-- Pointwise: the kernel is a single complex power. -/
theorem powerMajorantAt_kernel_eq {θ C : ℝ} {x : ℝ} (hx : 0 < x) (s : ℂ) :
    (x : ℂ) ^ (-s - 2) * (powerMajorantAt θ C x : ℂ) =
      (C : ℂ) * (x : ℂ) ^ (-s - 1 + (θ : ℂ)) := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  unfold powerMajorantAt
  rw [Complex.ofReal_mul, Complex.ofReal_cpow hx.le]
  rw [show (x : ℂ) ^ (-s - 2) * ((C : ℂ) * (x : ℂ) ^ ((1 + θ : ℝ) : ℂ)) =
      (C : ℂ) * ((x : ℂ) ^ (-s - 2) * (x : ℂ) ^ ((1 + θ : ℝ) : ℂ)) by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  push_cast
  ring

/-- The explicit tail transform `C A^{θ-s}/(s-θ)`, written in the form returned by
`integral_Ioi_cpow_of_lt`. -/
noncomputable def powerTransformAt (θ C A : ℝ) (s : ℂ) : ℂ :=
  (C : ℂ) * (-(A : ℂ) ^ (-s - 1 + (θ : ℂ) + 1) / (-s - 1 + (θ : ℂ) + 1))

theorem exponent_re_lt {θ : ℝ} {s : ℂ} (hs : θ < s.re) : (-s - 1 + (θ : ℂ)).re < -1 := by
  simp only [Complex.add_re, Complex.sub_re, Complex.neg_re, Complex.one_re, Complex.ofReal_re]
  linarith

theorem integrableOn_powerMajorantAt_kernel {θ C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : θ < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * (powerMajorantAt θ C x : ℂ)) (Ioi A) := by
  have hi : IntegrableOn (fun x : ℝ => (C : ℂ) * (x : ℂ) ^ (-s - 1 + (θ : ℂ))) (Ioi A) :=
    (integrableOn_Ioi_cpow_of_lt (exponent_re_lt hs) hA).const_mul (C : ℂ)
  refine hi.congr_fun ?_ measurableSet_Ioi
  intro x hx
  exact (powerMajorantAt_kernel_eq (lt_trans hA (mem_Ioi.mp hx)) s).symm

theorem integral_powerMajorantAt_kernel {θ C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : θ < s.re) :
    (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * (powerMajorantAt θ C x : ℂ)) =
      powerTransformAt θ C A s := by
  have hcongr : (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * (powerMajorantAt θ C x : ℂ)) =
      ∫ x : ℝ in Ioi A, (C : ℂ) * (x : ℂ) ^ (-s - 1 + (θ : ℂ)) := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    exact powerMajorantAt_kernel_eq (lt_trans hA (mem_Ioi.mp hx)) s
  rw [hcongr, integral_const_mul, integral_Ioi_cpow_of_lt (exponent_re_lt hs) hA]
  rfl

theorem powerTransformAt_analyticAt {θ C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : s ≠ θ) :
    AnalyticAt ℂ (powerTransformAt θ C A) s := by
  unfold powerTransformAt
  have hbase : AnalyticAt ℂ (fun _ : ℂ => (A : ℂ)) s := analyticAt_const
  have hexp : AnalyticAt ℂ (fun z : ℂ => -z - 1 + (θ : ℂ) + 1) s :=
    (((analyticAt_id.neg).sub analyticAt_const).add analyticAt_const).add analyticAt_const
  have hpow : AnalyticAt ℂ (fun z : ℂ => (A : ℂ) ^ (-z - 1 + (θ : ℂ) + 1)) s :=
    hbase.cpow hexp (Complex.ofReal_mem_slitPlane.mpr hA)
  have hden : (-s - 1 + (θ : ℂ) + 1 : ℂ) ≠ 0 := by
    intro h
    apply hs
    linear_combination -h
  exact analyticAt_const.mul (hpow.neg.div hexp hden)

/-- The majorant datum of `C x^{1+θ}` at level `θ ∈ [1/2, 1)`. -/
noncomputable def powerDataAt (θ C : ℝ) (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1) {A : ℝ}
    (hA : 0 < A) : MajorantData θ A where
  g := powerMajorantAt θ C
  measurable_g := measurable_powerMajorantAt θ C
  F := powerTransformAt θ C A
  half_le := hθ
  analytic_F := by
    intro s hs
    have hne : s ≠ θ := by
      intro h
      rw [h] at hs
      simp at hs
    exact powerTransformAt_analyticAt hA hne
  integrable_kernel := fun s hs => integrableOn_powerMajorantAt_kernel hA (hθ1.trans hs)
  integral_kernel := fun s hs => integral_powerMajorantAt_kernel hA (hθ1.trans hs)

/-! ### Zero-free half-planes from one-sided power bounds -/

/-- **Upper zero-free criterion at level `θ`.** `Re W(x) ≤ C x^{1+θ}` for all `x > A` excludes
every zero with `Re ρ > θ`. -/
theorem zeroFree_of_power_growth {θ C A : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + θ)) :
    ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 :=
  zeroFree_of_majorant (powerDataAt θ C hθ hθ1 (lt_of_lt_of_le zero_lt_one hA)) hA hgrow

/-- **Lower zero-free criterion at level `θ`.** `-C x^{1+θ} ≤ Re W(x)` for all `x > A` excludes
every zero with `Re ρ > θ`. -/
theorem zeroFree_of_power_lower_growth {θ C A : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1)
    (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ (1 + θ)) ≤ (ActualCriticalMellin.W x).re) :
    ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 :=
  zeroFree_of_lower_majorant (powerDataAt θ C hθ hθ1 (lt_of_lt_of_le zero_lt_one hA)) hA hlow

theorem zeroFree_of_eventually_power_growth {θ C : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1)
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + θ)) :
    ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hgrow
  exact zeroFree_of_power_growth hθ hθ1 (A := max 1 B) (le_max_left _ _)
    (fun x hx => hB x (le_of_lt (lt_of_le_of_lt (le_max_right _ _) hx)))

theorem zeroFree_of_eventually_power_lower_growth {θ C : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1)
    (hlow : ∀ᶠ x : ℝ in atTop, -(C * x ^ (1 + θ)) ≤ (ActualCriticalMellin.W x).re) :
    ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hlow
  exact zeroFree_of_power_lower_growth hθ hθ1 (A := max 1 B) (le_max_left _ _)
    (fun x hx => hB x (le_of_lt (lt_of_le_of_lt (le_max_right _ _) hx)))

/-! ### Oscillation -/

/-- Zeros of `ζ` have real part `< 1`. -/
theorem re_lt_one_of_zero {ρ : ℂ} (hz : riemannZeta ρ = 0) : ρ.re < 1 := by
  by_contra h
  exact riemannZeta_ne_zero_of_one_le_re (le_of_not_gt h) hz

/-- **Oscillation theorem.** A zero `ρ` with `Re ρ > θ ≥ 1/2` forces, for every `C`, both
`Re W(x) > C x^{1+θ}` and `Re W(x) < -C x^{1+θ}` for arbitrarily large `x`. -/
theorem oscillation_of_zero {ρ : ℂ} (hz : riemannZeta ρ = 0) {θ : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ)
    (hθρ : θ < ρ.re) (C : ℝ) :
    (∃ᶠ x : ℝ in atTop, C * x ^ (1 + θ) < (ActualCriticalMellin.W x).re) ∧
    (∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ (1 + θ))) := by
  have hθ1 : θ < 1 := hθρ.trans (re_lt_one_of_zero hz)
  constructor
  · rw [Filter.frequently_atTop']
    intro B
    by_contra h
    push Not at h
    exact zeroFree_of_power_growth hθ hθ1 (A := max 1 B) (le_max_left _ _)
      (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) ρ hθρ hz
  · rw [Filter.frequently_atTop']
    intro B
    by_contra h
    push Not at h
    exact zeroFree_of_power_lower_growth hθ hθ1 (A := max 1 B) (le_max_left _ _)
      (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) ρ hθρ hz

/-- If RH fails, `ζ` has a zero with `Re ρ > 1/2`. -/
theorem exists_right_zero_of_not_RH (h : ¬ RiemannHypothesis) :
    ∃ ρ : ℂ, (1 : ℝ) / 2 < ρ.re ∧ riemannZeta ρ = 0 := by
  have h' : ¬ RightHalfZeroFree := fun hr => h (target_iff_rightHalfZeroFree.mpr hr)
  unfold RightHalfZeroFree at h'
  push Not at h'
  obtain ⟨ρ, hρ, -, hz⟩ := h'
  exact ⟨ρ, hρ, hz⟩

/-- **Dichotomy at the scale `x^{3/2} log² x`.** If RH fails then for every `C`, both
`Re W(x) > C x^{3/2} log² x` and `Re W(x) < -C x^{3/2} log² x` hold for arbitrarily large
`x`. (Conversely, by `RiemannHypothesis_of_eventually_log_growth`, if RH fails then no bound
`Re W(x) ≤ C x^{3/2} log² x` holds eventually.) -/
theorem log_oscillation_of_not_RH (h : ¬ RiemannHypothesis) (C : ℝ) :
    (∃ᶠ x : ℝ in atTop,
      C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 < (ActualCriticalMellin.W x).re) ∧
    (∃ᶠ x : ℝ in atTop,
      (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2)) := by
  constructor
  · rw [Filter.frequently_atTop']
    intro B
    by_contra hc
    push Not at hc
    exact h (RiemannHypothesis_of_log_growth_after (A := max 1 B) (le_max_left _ _)
      (fun x hx => hc x (lt_of_le_of_lt (le_max_right _ _) hx)))
  · rw [Filter.frequently_atTop']
    intro B
    by_contra hc
    push Not at hc
    exact h (RiemannHypothesis_of_lower_majorant (logData C (A := max 1 B) (le_max_left _ _))
      (le_max_left _ _) (fun x hx => hc x (lt_of_le_of_lt (le_max_right _ _) hx)))

/-- **Quantitative dichotomy.** If RH fails, there is a level `β > 1/2` such that for every
`θ ∈ [1/2, β)` and every `C`, `Re W(x)` exceeds `C x^{1+θ}` and falls below `-C x^{1+θ}` for
arbitrarily large `x`. -/
theorem power_oscillation_of_not_RH (h : ¬ RiemannHypothesis) :
    ∃ β : ℝ, (1 : ℝ) / 2 < β ∧ ∀ θ : ℝ, (1 : ℝ) / 2 ≤ θ → θ < β → ∀ C : ℝ,
      (∃ᶠ x : ℝ in atTop, C * x ^ (1 + θ) < (ActualCriticalMellin.W x).re) ∧
      (∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ (1 + θ))) := by
  obtain ⟨ρ, hρ, hz⟩ := exists_right_zero_of_not_RH h
  exact ⟨ρ.re, hρ, fun θ hθ hθρ C => oscillation_of_zero hz hθ hθρ C⟩

/-- Two-sided form: `|Re W(x)| ≤ C x^{1+θ}` for all large `x` puts every zero in `Re ρ ≤ θ`.
At the level `θ = 1/2` itself the power scale is too small (the excursions below
`-C x^{3/2}` are unconditional, `exists_lower_excursion`), and the correct scale is
`x^{3/2} log² x`: see `RiemannHypothesis_of_log_growth_after`. -/
theorem zeroFree_le_of_power_growth {θ C A : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) (hθ1 : θ < 1)
    (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → |(ActualCriticalMellin.W x).re| ≤ C * x ^ (1 + θ)) :
    ∀ ρ : ℂ, riemannZeta ρ = 0 → ρ.re ≤ θ := by
  intro ρ hz
  by_contra hlt
  exact zeroFree_of_power_growth hθ hθ1 hA
    (fun x hx => (abs_le.mp (hgrow x hx)).2) ρ (lt_of_not_ge hlt) hz

end BuildingBlocks.ActualCriticalZeroFreeCriterion
