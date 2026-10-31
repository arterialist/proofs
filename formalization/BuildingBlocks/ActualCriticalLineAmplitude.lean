import BuildingBlocks.ActualCriticalSecondOrder
import BuildingBlocks.ActualCriticalSharpOscillation
import BuildingBlocks.SamePrimeContinuation

/-!
# Zeros on the critical line and the amplitude of the second-order term

`ActualCriticalSecondOrder` shows unconditionally that the second-order term of `W`,
`(W(x) + (1/6) x^{3/2} log² x)/(x^{3/2} log x)`, has lower limit `≤ c₁ ≤` upper limit with
`c₁ = 8/9 - γ/3`. This module shows that every zero `ρ = 1/2 + iγ` of `ζ` on the critical
line pushes the two limits apart by at least `|M(ρ)| = |ζ(1 + iγ)| / |ρ(ρ+1)|`:

  `liminf ≤ c₁ - |M(ρ)|`, `c₁ + |M(ρ)| ≤ limsup`

(`line_amplitude`). The proof combines three things. The analytic continuation `Hext` of the
same-prime series across the line (`SamePrimeContinuation`) makes the transform
`M (G² - Hext)` meromorphic at `ρ`, with a double pole of trailing coefficient `M(ρ) m²`,
`m` the multiplicity (`Fext_pole`). Positivity of the Laplace transform `L` of the majorant
measure gives `|L(ρ + ε)| ≤ L(1/2 + ε)`. And the second-order computation gives
`ε² L(1/2 + ε) → C - c₁` on the real axis, while `ε² L(ρ + ε) → -M(ρ) m²` along the
horizontal ray, since the majorant transforms are analytic at `ρ`. Hence
`|M(ρ)| m² ≤ C - c₁` for every `C` admissible in the upper bound, and symmetrically below.

This is the exact mechanism by which the zeros on the line (which exist, though none is
verified here) produce oscillations of `W` at the scale `x^{3/2} log x`.
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalLineAmplitude

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion
  ActualCriticalMajorantCriterion ActualCriticalLowerExcursion ActualCriticalLowerMajorant
  ActualCriticalLogMajorant ActualCriticalSecondOrder ActualCriticalSharpOscillation
  CriticalTransformContinuationRH CriticalTransformContinuationZeroFree SamePrimeContinuation
  SamePrimeDirichlet

/-! ### The multiplier on the critical line -/

theorem analyticAt_M_of {s : ℂ} (h1 : s + 1 / 2 ≠ 1) (hs0 : s ≠ 0) (hs1 : s + 1 ≠ 0) :
    AnalyticAt ℂ ShiftedZetaMultiplier.M s := by
  unfold ShiftedZetaMultiplier.M
  have hadd : AnalyticAt ℂ (fun z : ℂ => z + 1 / 2) s := analyticAt_id.add analyticAt_const
  have hζ0 : AnalyticAt ℂ riemannZeta (s + 1 / 2) := zeta_analytic_off_pole (s + 1 / 2) h1
  have hζ : AnalyticAt ℂ (fun z : ℂ => riemannZeta (z + 1 / 2)) s :=
    AnalyticAt.comp (f := fun z : ℂ => z + 1 / 2) (x := s) hζ0 hadd
  have hden : AnalyticAt ℂ (fun z : ℂ => z * (z + 1)) s :=
    analyticAt_id.mul (analyticAt_id.add analyticAt_const)
  exact hζ.div hden (mul_ne_zero hs0 hs1)

theorem M_ne_zero_of {s : ℂ} (hz : riemannZeta (s + 1 / 2) ≠ 0) (hs0 : s ≠ 0) (hs1 : s + 1 ≠ 0) :
    ShiftedZetaMultiplier.M s ≠ 0 :=
  div_ne_zero hz (mul_ne_zero hs0 hs1)

theorem line_facts {ρ : ℂ} (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ρ + 1 / 2 ≠ 1 ∧ ρ ≠ 0 ∧ ρ + 1 ≠ 0 ∧ ρ ≠ 1 ∧ ρ ≠ 1 / 2 ∧
      riemannZeta (ρ + 1 / 2) ≠ 0 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro h
    have := congrArg Complex.im h
    simp at this
    exact hρim this
  · intro h
    rw [h] at hρim
    simp at hρim
  · intro h
    have := congrArg Complex.im h
    simp at this
    exact hρim this
  · intro h
    rw [h] at hρim
    simp at hρim
  · intro h
    rw [h] at hρim
    simp at hρim
  · apply riemannZeta_ne_zero_of_one_le_re
    simp only [Complex.add_re, hρ]
    norm_num

theorem analyticAt_M_line {ρ : ℂ} (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    AnalyticAt ℂ ShiftedZetaMultiplier.M ρ :=
  analyticAt_M_of (line_facts hρ hρim).1 (line_facts hρ hρim).2.1 (line_facts hρ hρim).2.2.1

theorem M_ne_zero_line {ρ : ℂ} (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ShiftedZetaMultiplier.M ρ ≠ 0 :=
  M_ne_zero_of (line_facts hρ hρim).2.2.2.2.2 (line_facts hρ hρim).2.1 (line_facts hρ hρim).2.2.1

/-! ### The continued transform and its pole on the line -/

/-- The transform with the continued same-prime series. -/
noncomputable def Fext (s : ℂ) : ℂ :=
  ShiftedZetaMultiplier.M s * ((-logDeriv riemannZeta s - s / (s - 1)) ^ 2 - Hext s)

theorem Fext_eq_filledTransform {s : ℂ} (hs : 1 / 2 < s.re) (hs1 : s ≠ 1) :
    Fext s = CriticalTransformPoles.filledTransform s := by
  rw [CriticalTransformPoles.filledTransform_eq_of_ne hs1]
  unfold Fext
  rw [Hext_eq_H hs]
  rfl

/-- The double pole of the continued transform at a zero on the line. -/
theorem Fext_pole {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧ meromorphicOrderAt Fext ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt Fext ρ = ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 := by
  have hρ1 : ρ ≠ 1 := (line_facts hρ hρim).2.2.2.1
  obtain ⟨m, hm, horder⟩ := LogDerivativePole.zeta_zero_finite_order hρ1 hz
  have hJ : AnalyticAt ℂ (fun s : ℂ => s / (s - 1)) ρ :=
    analyticAt_id.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hρ1)
  have hpole := LogDerivativePole.logDeriv_square_sub_pole (zeta_analytic_off_pole ρ hρ1) horder
    hm hJ (Hext_analyticAt_line hρ hρim) (analyticAt_M_line hρ hρim) (M_ne_zero_line hρ hρim)
  exact ⟨m, hm, horder, hpole.1, hpole.2⟩

/-- The horizontal approach to a point. -/
theorem tendsto_add_ofReal (ρ : ℂ) :
    Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝[>] 0) (𝓝 ρ) := by
  have : Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝 0) (𝓝 (ρ + ((0 : ℝ) : ℂ))) :=
    (continuous_const.add Complex.continuous_ofReal).tendsto 0
  simpa using this.mono_left nhdsWithin_le_nhds

theorem tendsto_add_ofReal_punctured (ρ : ℂ) :
    Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝[>] 0) (𝓝[≠] ρ) := by
  rw [tendsto_nhdsWithin_iff]
  refine ⟨tendsto_add_ofReal ρ, ?_⟩
  filter_upwards [self_mem_nhdsWithin] with ε hε
  show ρ + (ε : ℂ) ≠ ρ
  intro h
  have h' : (ε : ℂ) = 0 := by linear_combination h
  have : ε = 0 := by exact_mod_cast h'
  exact (show (0 : ℝ) < ε from hε).ne' this

/-- `ε² Fext(ρ + ε) → M(ρ) m²` along the horizontal ray. -/
theorem tendsto_sq_Fext {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * Fext (ρ + ε)) (𝓝[>] 0)
        (𝓝 (ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2)) := by
  obtain ⟨m, hm, horder, hord, hcoeff⟩ := Fext_pole hz hρ hρim
  have hmer : MeromorphicAt Fext ρ := by
    by_contra h
    rw [meromorphicOrderAt_of_not_meromorphicAt h] at hord
    exact absurd hord (by decide)
  have ht := hmer.tendsto_nhds_meromorphicTrailingCoeffAt
  rw [hord, hcoeff] at ht
  refine ⟨m, hm, horder, (ht.comp (tendsto_add_ofReal_punctured ρ)).congr' ?_⟩
  filter_upwards with ε
  simp only [Function.comp_apply, Pi.pow_apply, smul_eq_mul, add_sub_cancel_left,
    WithTop.untop₀_coe, neg_neg]
  norm_num

/-! ### The quarter-plane through a non-real point -/

theorem exists_quarter {β : ℝ} (hβ : -1 < β) {ρ : ℂ} (hρβ : ρ.re = β) (hρim : ρ.im ≠ 0) :
    ∃ U : Set ℂ, Convex ℝ U ∧ U ⊆ upperDomain β ∧
      (∀ ε : ℝ, 0 < ε → ρ + (ε : ℂ) ∈ U) ∧ ∃ z₀ ∈ U, 1 < z₀.re := by
  rcases lt_or_gt_of_ne hρim with hneg | hpos'
  · refine ⟨{s : ℂ | β < s.re} ∩ {s : ℂ | s.im < 0},
      (convex_halfSpace_re_gt β).inter (convex_halfSpace_im_lt 0),
      lowerQuarter_subset β, ?_, ((β + 2 : ℝ) : ℂ) - Complex.I, ⟨?_, ?_⟩, ?_⟩
    · intro ε hε
      refine ⟨?_, ?_⟩
      · show β < (ρ + (ε : ℂ)).re
        rw [Complex.add_re, Complex.ofReal_re, hρβ]
        linarith
      · show (ρ + (ε : ℂ)).im < 0
        rw [Complex.add_im, Complex.ofReal_im, add_zero]
        exact hneg
    · show β < (((β + 2 : ℝ) : ℂ) - Complex.I).re
      rw [Complex.sub_re, Complex.ofReal_re, Complex.I_re]
      linarith
    · show (((β + 2 : ℝ) : ℂ) - Complex.I).im < 0
      rw [Complex.sub_im, Complex.ofReal_im, Complex.I_im]
      norm_num
    · show 1 < (((β + 2 : ℝ) : ℂ) - Complex.I).re
      rw [Complex.sub_re, Complex.ofReal_re, Complex.I_re]
      linarith
  · refine ⟨{s : ℂ | β < s.re} ∩ {s : ℂ | 0 < s.im},
      (convex_halfSpace_re_gt β).inter (convex_halfSpace_im_gt 0),
      upperQuarter_subset β, ?_, ((β + 2 : ℝ) : ℂ) + Complex.I, ⟨?_, ?_⟩, ?_⟩
    · intro ε hε
      refine ⟨?_, ?_⟩
      · show β < (ρ + (ε : ℂ)).re
        rw [Complex.add_re, Complex.ofReal_re, hρβ]
        linarith
      · show 0 < (ρ + (ε : ℂ)).im
        rw [Complex.add_im, Complex.ofReal_im, add_zero]
        exact hpos'
    · show β < (((β + 2 : ℝ) : ℂ) + Complex.I).re
      rw [Complex.add_re, Complex.ofReal_re, Complex.I_re]
      linarith
    · show 0 < (((β + 2 : ℝ) : ℂ) + Complex.I).im
      rw [Complex.add_im, Complex.ofReal_im, Complex.I_im]
      norm_num
    · show 1 < (((β + 2 : ℝ) : ℂ) + Complex.I).re
      rw [Complex.add_re, Complex.ofReal_re, Complex.I_re]
      linarith

/-- A continuation of the transform analytic on `Re s > 1/2` agrees with `Fext` along the
horizontal ray from a non-real point of the critical line. -/
theorem eventually_eq_Fext_on_ray {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ) / 2 < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s)
    {ρ : ℂ} (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ∀ᶠ ε : ℝ in 𝓝[>] 0, J (ρ + ε) = Fext (ρ + ε) := by
  have hρ1 : ρ ≠ 1 := (line_facts hρ hρim).2.2.2.1
  obtain ⟨U, hUc, hU, hρU, z₀, hz₀, hz₀re⟩ := exists_quarter (by norm_num) hρ hρim
  have hzeroU := cleared_eqOn_zero (le_refl ((1 : ℝ) / 2)) hJ heq hUc hU hz₀ hz₀re
  have hne : ∀ᶠ z in 𝓝[≠] ρ, riemannZeta z ≠ 0 :=
    (zeta_analytic_off_pole ρ hρ1).eventually_eq_zero_or_eventually_ne_zero
      |>.resolve_left (zeta_not_locally_zero hρ1)
  have hzε : ∀ᶠ ε : ℝ in 𝓝[>] 0, riemannZeta (ρ + (ε : ℂ)) ≠ 0 :=
    (tendsto_add_ofReal_punctured ρ).eventually hne
  filter_upwards [hzε, self_mem_nhdsWithin] with ε hzε hε
  have hε' : (0 : ℝ) < ε := hε
  have hmem := hρU ε hε'
  have h0 := hzeroU _ hmem
  rw [cleared_eq (hU hmem).2 hzε] at h0
  have hJf : J (ρ + ε) = CriticalTransformPoles.filledTransform (ρ + ε) :=
    sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hzε))
  rw [hJf, Fext_eq_filledTransform ?_ (hU hmem).2]
  rw [Complex.add_re, Complex.ofReal_re, hρ]
  linarith

/-- The shift `ε ↦ 1/2 + ε`. -/
theorem tendsto_half_add : Tendsto (fun ε : ℝ => 1 / 2 + ε) (𝓝[>] 0) (𝓝[>] ((1 : ℝ) / 2)) := by
  apply tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within
  · have : Tendsto (fun ε : ℝ => 1 / 2 + ε) (𝓝 0) (𝓝 (1 / 2 + 0)) :=
      (continuous_const.add continuous_id).continuousAt.tendsto
    rw [add_zero] at this
    exact this.mono_left nhdsWithin_le_nhds
  · filter_upwards [self_mem_nhdsWithin] with ε hε
    have : (0 : ℝ) < ε := hε
    show (1 : ℝ) / 2 < 1 / 2 + ε
    linarith

theorem tendsto_sq_ofReal : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2) (𝓝[>] 0) (𝓝 0) := by
  have : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2) (𝓝 0) (𝓝 (((0 : ℝ) : ℂ) ^ 2)) :=
    (Complex.continuous_ofReal.pow 2).tendsto 0
  simpa using this.mono_left nhdsWithin_le_nhds

/-! ### The amplitude bounds -/

/-- **Upper amplitude bound.** Under `Re W(x) ≤ -(1/6) x^{3/2} log² x + C x^{3/2} log x` for
`x > A`, every zero `ρ` on the critical line satisfies `|M(ρ)| m² ≤ C - c₁`. -/
theorem norm_coeff_le_of_upper {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x)
    {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      ‖ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2‖ ≤ C - c₁ := by
  obtain ⟨m, hm, horder, hlim⟩ := tendsto_sq_Fext hz hρ hρim
  refine ⟨m, hm, horder, ?_⟩
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hρne : ρ ≠ 1 / 2 := (line_facts hρ hρim).2.2.2.2.1
  set D : MajorantData (1 / 2) A := addData (logData (-(1 / 6)) hA) (log1Data C hA) with hD
  have hgrow' : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x := fun x hx => hgrow x hx
  set L := LaplaceMomentDerivatives.moment (growthMeasure D) time 0 with hL
  set J := ActualCriticalMajorantCriterion.continuation D with hJdef
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  have hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ) / 2 < s.re} :=
    continuation_analyticOnNhd D hA hgrow'
  have heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s :=
    fun s hs => continuation_eq_filledTransform D hA hgrow' hs
  have hLeq : ∀ s : ℂ, L s = D.F s + I s - J s := by
    intro s
    simp only [hJdef, hL, hI, ActualCriticalMajorantCriterion.continuation]
    ring
  have hJρ := eventually_eq_Fext_on_ray hJ heq hρ hρim
  have hDF : D.F = fun s => logF (-(1 / 6)) A s + log1F C A s := rfl
  have hFcont : ContinuousAt D.F ρ := by
    rw [hDF]
    exact ((logF_analyticAt hA0 hρne).continuousAt).add (log1F_analyticAt hA0 hρne).continuousAt
  have hIcont : Continuous I := (MellinCompactCorrection.differentiable_W_initialPart A).continuous
  have h1 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * D.F (ρ + ε)) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_sq_ofReal.mul (hFcont.tendsto.comp (tendsto_add_ofReal ρ))
    simpa using this
  have h2 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * I (ρ + ε)) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_sq_ofReal.mul (hIcont.continuousAt.tendsto.comp (tendsto_add_ofReal ρ))
    simpa using this
  have h3 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * L (ρ + ε)) (𝓝[>] 0)
      (𝓝 (0 + 0 - ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2)) := by
    refine ((h1.add h2).sub hlim).congr' ?_
    filter_upwards [hJρ] with ε hJρ
    rw [hLeq, hJρ]
    ring
  have hnorm : Tendsto (fun ε : ℝ => ‖((ε : ℂ)) ^ 2 * L (ρ + ε)‖) (𝓝[>] 0)
      (𝓝 ‖ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2‖) := by
    have := h3.norm
    simpa using this
  have hreal : Tendsto (fun ε : ℝ => ε ^ 2 * (L (((1 / 2 + ε : ℝ)) : ℂ)).re) (𝓝[>] 0)
      (𝓝 (C + m₀ / 4)) := by
    have := (tendsto_sq_upper_moment hA hgrow).comp tendsto_half_add
    refine this.congr' ?_
    filter_upwards with ε
    show (1 / 2 + ε - 1 / 2) ^ 2 * _ = ε ^ 2 * _
    congr 1
    ring
  have hlink : ∀ᶠ ε : ℝ in 𝓝[>] 0,
      ‖((ε : ℂ)) ^ 2 * L (ρ + ε)‖ ≤ ε ^ 2 * (L (((1 / 2 + ε : ℝ)) : ℂ)).re := by
    filter_upwards with ε
    have hp := norm_moment_le_re_moment (growthMeasure D) (ρ + ε)
    have hre : (ρ + (ε : ℂ)).re = 1 / 2 + ε := by rw [Complex.add_re, Complex.ofReal_re, hρ]
    rw [hre] at hp
    rw [norm_mul, norm_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs]
    exact mul_le_mul_of_nonneg_left hp (sq_nonneg _)
  have := le_of_tendsto_of_tendsto hnorm hreal hlink
  rw [c₁_eq]
  linarith

/-- **Lower amplitude bound.** Under `-(1/6) x^{3/2} log² x + C x^{3/2} log x ≤ Re W(x)` for
`x > A`, every zero `ρ` on the critical line satisfies `|M(ρ)| m² ≤ c₁ - C`. -/
theorem norm_coeff_le_of_lower {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x →
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x ≤
          (ActualCriticalMellin.W x).re)
    {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) (hρim : ρ.im ≠ 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      ‖ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2‖ ≤ c₁ - C := by
  obtain ⟨m, hm, horder, hlim⟩ := tendsto_sq_Fext hz hρ hρim
  refine ⟨m, hm, horder, ?_⟩
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hρne : ρ ≠ 1 / 2 := (line_facts hρ hρim).2.2.2.2.1
  set D : MajorantData (1 / 2) A := addData (logData (1 / 6) hA) (log1Data (-C) hA) with hD
  have hlow' : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re := by
    intro x hx
    have h := hlow x hx
    show -(logMajorant (1 / 6) x + log1Majorant (-C) x) ≤ _
    unfold logMajorant log1Majorant
    linarith
  set L := LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 with hL
  set J := ActualCriticalLowerMajorant.lowerContinuation D with hJdef
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  have hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ) / 2 < s.re} :=
    lowerContinuation_analyticOnNhd D hA hlow'
  have heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s :=
    fun s hs => lowerContinuation_eq_filledTransform D hA hlow' hs
  have hLeq : ∀ s : ℂ, L s = J s + D.F s - I s := by
    intro s
    simp only [hJdef, hL, hI, ActualCriticalLowerMajorant.lowerContinuation]
    ring
  have hJρ := eventually_eq_Fext_on_ray hJ heq hρ hρim
  have hDF : D.F = fun s => logF (1 / 6) A s + log1F (-C) A s := rfl
  have hFcont : ContinuousAt D.F ρ := by
    rw [hDF]
    exact ((logF_analyticAt hA0 hρne).continuousAt).add (log1F_analyticAt hA0 hρne).continuousAt
  have hIcont : Continuous I := (MellinCompactCorrection.differentiable_W_initialPart A).continuous
  have h1 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * D.F (ρ + ε)) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_sq_ofReal.mul (hFcont.tendsto.comp (tendsto_add_ofReal ρ))
    simpa using this
  have h2 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * I (ρ + ε)) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_sq_ofReal.mul (hIcont.continuousAt.tendsto.comp (tendsto_add_ofReal ρ))
    simpa using this
  have h3 : Tendsto (fun ε : ℝ => ((ε : ℂ)) ^ 2 * L (ρ + ε)) (𝓝[>] 0)
      (𝓝 (ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 + 0 - 0)) := by
    refine ((hlim.add h1).sub h2).congr' ?_
    filter_upwards [hJρ] with ε hJρ
    rw [hLeq, hJρ]
    ring
  have hnorm : Tendsto (fun ε : ℝ => ‖((ε : ℂ)) ^ 2 * L (ρ + ε)‖) (𝓝[>] 0)
      (𝓝 ‖ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2‖) := by
    have := h3.norm
    simpa using this
  have hreal : Tendsto (fun ε : ℝ => ε ^ 2 * (L (((1 / 2 + ε : ℝ)) : ℂ)).re) (𝓝[>] 0)
      (𝓝 (-m₀ / 4 - C)) := by
    have := (tendsto_sq_lower_moment hA hlow).comp tendsto_half_add
    refine this.congr' ?_
    filter_upwards with ε
    show (1 / 2 + ε - 1 / 2) ^ 2 * _ = ε ^ 2 * _
    congr 1
    ring
  have hlink : ∀ᶠ ε : ℝ in 𝓝[>] 0,
      ‖((ε : ℂ)) ^ 2 * L (ρ + ε)‖ ≤ ε ^ 2 * (L (((1 / 2 + ε : ℝ)) : ℂ)).re := by
    filter_upwards with ε
    have hp := norm_moment_le_re_moment (lowerMeasure D) (ρ + ε)
    have hre : (ρ + (ε : ℂ)).re = 1 / 2 + ε := by rw [Complex.add_re, Complex.ofReal_re, hρ]
    rw [hre] at hp
    rw [norm_mul, norm_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs]
    exact mul_le_mul_of_nonneg_left hp (sq_nonneg _)
  have := le_of_tendsto_of_tendsto hnorm hreal hlink
  rw [c₁_eq]
  linarith

/-! ### Consequences -/

theorem im_ne_zero_of_zero_on_line {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) :
    ρ.im ≠ 0 := by
  intro h0
  have hρ' : ρ = ((((1 : ℝ) / 2 : ℝ)) : ℂ) := Complex.ext (by simp [hρ]) (by simp [h0])
  apply riemannZeta_half_ne_zero
  rw [← hρ']
  exact hz

theorem norm_M_le_norm_coeff {ρ : ℂ} {m : ℕ} (hm : 1 ≤ m) :
    ‖ShiftedZetaMultiplier.M ρ‖ ≤ ‖ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2‖ := by
  rw [norm_mul, norm_pow, Complex.norm_natCast]
  have h1 : (1 : ℝ) ≤ (m : ℝ) ^ 2 := by
    have : (1 : ℝ) ≤ m := by exact_mod_cast hm
    nlinarith
  exact le_mul_of_one_le_right (norm_nonneg _) h1

/-- For a zero `ρ` on the critical line and `C < c₁ + |M(ρ)|`, the upper bound
`Re W(x) ≤ -(1/6) x^{3/2} log² x + C x^{3/2} log x` fails for arbitrarily large `x`. -/
theorem exists_line_upper_excursion {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2)
    {C : ℝ} (hC : C < c₁ + ‖ShiftedZetaMultiplier.M ρ‖) (B : ℝ) :
    ∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
      C * x ^ ((3 : ℝ) / 2) * Real.log x < (ActualCriticalMellin.W x).re := by
  by_contra h
  push Not at h
  have hρim := im_ne_zero_of_zero_on_line hz hρ
  obtain ⟨m, hm, -, hle⟩ := norm_coeff_le_of_upper (A := max 1 B) (le_max_left _ _)
    (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) hz hρ hρim
  have := norm_M_le_norm_coeff (ρ := ρ) hm
  linarith

/-- For a zero `ρ` on the critical line and `c₁ - |M(ρ)| < C`, the lower bound
`-(1/6) x^{3/2} log² x + C x^{3/2} log x ≤ Re W(x)` fails for arbitrarily large `x`. -/
theorem exists_line_lower_excursion {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2)
    {C : ℝ} (hC : c₁ - ‖ShiftedZetaMultiplier.M ρ‖ < C) (B : ℝ) :
    ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
      -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x := by
  by_contra h
  push Not at h
  have hρim := im_ne_zero_of_zero_on_line hz hρ
  obtain ⟨m, hm, -, hle⟩ := norm_coeff_le_of_lower (A := max 1 B) (le_max_left _ _)
    (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) hz hρ hρim
  have := norm_M_le_norm_coeff (ρ := ρ) hm
  linarith

/-- **Amplitude of the second-order oscillation from a zero on the line.** If `ζ(ρ) = 0`
with `Re ρ = 1/2`, then for every `ε > 0` and every `B` there are `x > B` with
`W(x) > -(1/6) x^{3/2} log² x + (c₁ + |M(ρ)| - ε) x^{3/2} log x` and with
`W(x) < -(1/6) x^{3/2} log² x + (c₁ - |M(ρ)| + ε) x^{3/2} log x`, where
`M(ρ) = ζ(ρ + 1/2)/(ρ(ρ+1)) ≠ 0`. -/
theorem line_amplitude {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) {ε : ℝ} (hε : 0 < ε)
    (B : ℝ) :
    (∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
      (c₁ + ‖ShiftedZetaMultiplier.M ρ‖ - ε) * x ^ ((3 : ℝ) / 2) * Real.log x <
        (ActualCriticalMellin.W x).re) ∧
    (∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
      -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
        (c₁ - ‖ShiftedZetaMultiplier.M ρ‖ + ε) * x ^ ((3 : ℝ) / 2) * Real.log x) :=
  ⟨exists_line_upper_excursion hz hρ (by linarith) B,
    exists_line_lower_excursion hz hρ (by linarith) B⟩

theorem M_ne_zero_of_zero_on_line {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) :
    ShiftedZetaMultiplier.M ρ ≠ 0 :=
  M_ne_zero_line hρ (im_ne_zero_of_zero_on_line hz hρ)

/-- **Multiplicities on the line under the second-order premise.** If
`Re W(x) ≤ -(1/6) x^{3/2} log² x + C x^{3/2} log x` for all `x > A`, then every zero `ρ` on
the critical line has multiplicity `m` with `m² |M(ρ)| ≤ C - c₁`. -/
theorem multiplicity_bound_of_upper {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x)
    {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : ρ.re = 1 / 2) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      (m : ℝ) ^ 2 * ‖ShiftedZetaMultiplier.M ρ‖ ≤ C - c₁ := by
  obtain ⟨m, hm, horder, hle⟩ :=
    norm_coeff_le_of_upper hA hgrow hz hρ (im_ne_zero_of_zero_on_line hz hρ)
  refine ⟨m, hm, horder, ?_⟩
  rw [norm_mul, norm_pow, Complex.norm_natCast] at hle
  linarith

end BuildingBlocks.ActualCriticalLineAmplitude
