import BuildingBlocks.ActualCriticalZeroFreeCriterion

/-!
# Sharp oscillation: a zero at `β` forces excursions of exact order `x^{1+β}`

`ActualCriticalZeroFreeCriterion.oscillation_of_zero` says that a zero `ρ` with
`Re ρ = β > 1/2` forces `W(x) > C x^{1+θ}` and `W(x) < -C x^{1+θ}` for arbitrarily large `x`,
for every `θ < β`. This module removes the loss `θ < β`:

  `ζ(ρ) = 0`, `Re ρ = β > 1/2`  ⟹  for every `C`, `W(x) > C x^{1+β}` and `W(x) < -C x^{1+β}`
  for arbitrarily large `x`.

The additional ingredient is positivity on vertical lines. Under an eventual bound
`W(x) ≤ C x^{1+β}` the measure `(C x^{1+β} - W(x)) x^{-2} dx` is positive, so its Laplace
transform `L` satisfies `|L(s)| ≤ L(Re s)`. Landau's argument (at level `β`) continues `L`
to `Re s > β` as `F + I - M_W`, where `F(s) = C A^{β-s}/(s-β)` is the transform of the
majorant and `I` is entire. Approaching the zero horizontally, `L(ρ+ε)` has size `ε^{-2}`
because `M_W` has a double pole at `ρ`, while on the real axis `L(β+ε) ≤ |C|/ε + O(1)`
because `M_W` is analytic at the real point `β ∈ (1/2, 1)`. Positivity gives
`ε^{-2} ≲ ε^{-1}`, which fails as `ε → 0⁺`. The same argument runs on the lower side.

Consequently, for `1/2 < θ < 1`, a one-sided bound `±W(x) ≤ C x^{1+θ}` for all large `x`
excludes every zero in the closed half-plane `Re ρ ≥ θ` (`zeroFree_ge_of_power_growth`),
and `limsup W(x)/x^{1+β} = +∞`, `liminf W(x)/x^{1+β} = -∞` at the real part `β` of any
off-line zero (`sharp_oscillation_of_zero`).
-/

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualCriticalSharpOscillation

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion
  ActualCriticalMajorantCriterion ActualCriticalLowerMajorant ActualCriticalZeroFreeCriterion
  CriticalTransformContinuationRH CriticalTransformContinuationZeroFree

/-! ### Positivity on vertical lines -/

/-- The Laplace transform of a positive measure is dominated by its value on the real axis. -/
theorem norm_moment_le_re_moment (μ : Measure ℝ) (s : ℂ) :
    ‖LaplaceMomentDerivatives.moment μ time 0 s‖ ≤
      (LaplaceMomentDerivatives.moment μ time 0 ((s.re : ℝ) : ℂ)).re := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand
  simp only [pow_zero, one_mul]
  have h1 : ∀ x : ℝ, ‖Complex.exp (-s * (time x : ℂ))‖ = Real.exp (-s.re * time x) := by
    intro x
    rw [Complex.norm_exp]
    congr 1
    simp [Complex.mul_re]
  have hfun : (fun x : ℝ => Complex.exp (-((s.re : ℝ) : ℂ) * (time x : ℂ))) =
      fun x : ℝ => ((Real.exp (-s.re * time x) : ℝ) : ℂ) := by
    funext x
    push_cast
    rfl
  have key : (∫ x, ((Real.exp (-s.re * time x) : ℝ) : ℂ) ∂μ) =
      ((∫ x, Real.exp (-s.re * time x) ∂μ : ℝ) : ℂ) := integral_ofReal
  rw [hfun, key, Complex.ofReal_re]
  calc ‖∫ x, Complex.exp (-s * (time x : ℂ)) ∂μ‖
      ≤ ∫ x, ‖Complex.exp (-s * (time x : ℂ))‖ ∂μ := norm_integral_le_integral_norm _
    _ = ∫ x, Real.exp (-s.re * time x) ∂μ := by simp_rw [h1]

/-! ### The power transform on and near the boundary line -/

theorem norm_powerTransformAt_le {θ C A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : θ ≤ s.re) :
    ‖powerTransformAt θ C A s‖ ≤ |C| / ‖s - θ‖ := by
  unfold powerTransformAt
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hden : (-s - 1 + (θ : ℂ) + 1) = -(s - θ) := by ring
  rw [hden, norm_mul, Complex.norm_real, Real.norm_eq_abs, norm_div, norm_neg, norm_neg,
    Complex.norm_cpow_eq_rpow_re_of_pos hA0]
  have hre : (-(s - (θ : ℂ))).re = -(s.re - θ) := by simp
  rw [hre]
  have hle : A ^ (-(s.re - θ)) ≤ 1 :=
    Real.rpow_le_one_of_one_le_of_nonpos hA (by linarith)
  have hpos : 0 ≤ ‖s - (θ : ℂ)‖ := norm_nonneg _
  rw [← mul_div_assoc]
  exact div_le_div_of_nonneg_right (mul_le_of_le_one_right (abs_nonneg C) hle) hpos

/-! ### A convex domain through the real segment `(β, 1)` -/

/-- `{Re s > β, Re s - Im s < 1}`: convex, avoids `1`, contains `(β, 1)` and reaches `Re s > 1`. -/
def tilted (β : ℝ) : Set ℂ := {s : ℂ | β < s.re} ∩ {s : ℂ | s.re - s.im < 1}

theorem tilted_convex (β : ℝ) : Convex ℝ (tilted β) := by
  apply (convex_halfSpace_re_gt β).inter
  apply convex_halfSpace_lt (𝕜 := ℝ) (f := fun s : ℂ => s.re - s.im) (r := 1)
  exact IsLinearMap.mk
    (by intro x y; simp only [Complex.add_re, Complex.add_im]; ring)
    (by intro r x; simp only [Complex.smul_re, Complex.smul_im, smul_eq_mul]; ring)

theorem tilted_subset (β : ℝ) : tilted β ⊆ upperDomain β := by
  rintro s ⟨h1, h2⟩
  refine ⟨h1, ?_⟩
  rintro rfl
  simp at h2

/-! ### The abstract contradiction -/

/-- **Positive Laplace transforms exclude zeros on the boundary line.** Let `L` be a function
dominated on vertical lines by its real-axis values, and suppose
`L = F + η (I - J)` where `F = C A^{β-s}/(s-β)`, `I` is the entire initial part, `|η| = 1`,
and `J` is analytic on `Re s > β` and equals the filled transform on `Re s > 1`. Then `ζ` has
no zero with `Re ρ = β`. -/
theorem no_zero_on_boundary {β C A : ℝ} (hβ : (1 : ℝ) / 2 < β) (hβ1 : β < 1) (hA : 1 ≤ A)
    (η : ℂ) (hη : ‖η‖ = 1) (L J : ℂ → ℂ)
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | β < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s)
    (hL : ∀ s : ℂ, L s = powerTransformAt β C A s +
      η * (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) - J s))
    (hpos : ∀ s : ℂ, ‖L s‖ ≤ (L ((s.re : ℝ) : ℂ)).re) :
    ∀ ρ : ℂ, ρ.re = β → riemannZeta ρ ≠ 0 := by
  intro ρ hρβ hz
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  set fT := CriticalTransformPoles.filledTransform with hfT
  have hρre : (1 : ℝ) / 2 < ρ.re := hρβ ▸ hβ
  have hρ1 : ρ ≠ 1 := by
    intro h
    rw [h] at hρβ
    simp at hρβ
    linarith
  have hρim : ρ.im ≠ 0 := by
    intro h0
    have hρ : ρ = (β : ℂ) := Complex.ext (by simpa using hρβ) (by simp [h0])
    have hz' : riemannZeta (β : ℂ) = 0 := by rw [← hρ]; exact hz
    exact RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional hβ hβ1 hz'
  -- the real-axis identity `J = fT` on `(β, 1)`
  have hreal : ∀ σ : ℝ, β < σ → σ < 1 → J (σ : ℂ) = fT (σ : ℂ) := by
    intro σ h1 h2
    have hzero := cleared_eqOn_zero hβ.le hJ heq (tilted_convex β) (tilted_subset β)
      (z₀ := ((β + 2 : ℝ) : ℂ) + 2 * Complex.I) ⟨?_, ?_⟩ ?_
    · have hσ1 : (σ : ℂ) ≠ 1 := by
        intro h
        have := congrArg Complex.re h
        simp at this
        linarith
      have hzs : riemannZeta (σ : ℂ) ≠ 0 :=
        RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional
          (hβ.trans h1) h2
      have hmem : (σ : ℂ) ∈ tilted β := by
        refine ⟨by simpa using h1, ?_⟩
        show (σ : ℂ).re - (σ : ℂ).im < 1
        simp only [Complex.ofReal_re, Complex.ofReal_im, sub_zero]
        exact h2
      have h0 := hzero (σ : ℂ) hmem
      rw [cleared_eq hσ1 hzs] at h0
      exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hzs))
    · show β < (((β + 2 : ℝ) : ℂ) + 2 * Complex.I).re
      simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.I_im,
        Complex.re_ofNat, Complex.im_ofNat]
      linarith
    · show (((β + 2 : ℝ) : ℂ) + 2 * Complex.I).re - (((β + 2 : ℝ) : ℂ) + 2 * Complex.I).im < 1
      simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.re_ofNat,
        Complex.im_ofNat]
      linarith
    · show 1 < (((β + 2 : ℝ) : ℂ) + 2 * Complex.I).re
      simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.I_im,
        Complex.re_ofNat, Complex.im_ofNat]
      linarith
  -- the quarter-plane identity `J = fT` on the horizontal ray `ρ + ε`
  obtain ⟨U, hUc, hU, hρU, z₀, hz₀, hz₀re⟩ : ∃ U : Set ℂ, Convex ℝ U ∧ U ⊆ upperDomain β ∧
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
  have hzeroU := cleared_eqOn_zero hβ.le hJ heq hUc hU hz₀ hz₀re
  -- the horizontal approach `ε ↦ ρ + ε`
  have htend0 : Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝[>] 0) (𝓝 ρ) := by
    have : Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝 0) (𝓝 (ρ + ((0 : ℝ) : ℂ))) :=
      (continuous_const.add Complex.continuous_ofReal).tendsto 0
    simpa using this.mono_left nhdsWithin_le_nhds
  have htend : Tendsto (fun ε : ℝ => ρ + (ε : ℂ)) (𝓝[>] 0) (𝓝[≠] ρ) := by
    rw [tendsto_nhdsWithin_iff]
    refine ⟨htend0, ?_⟩
    filter_upwards [self_mem_nhdsWithin] with ε hε
    show ρ + (ε : ℂ) ≠ ρ
    intro h
    have h' : (ε : ℂ) = 0 := by linear_combination h
    have : ε = 0 := by exact_mod_cast h'
    exact (show (0 : ℝ) < ε from hε).ne' this
  have htendβ : Tendsto (fun ε : ℝ => ((β + ε : ℝ) : ℂ)) (𝓝[>] 0) (𝓝 (β : ℂ)) := by
    have : Tendsto (fun ε : ℝ => ((β + ε : ℝ) : ℂ)) (𝓝 0) (𝓝 ((β + 0 : ℝ) : ℂ)) :=
      (Complex.continuous_ofReal.comp (continuous_const.add continuous_id)).tendsto 0
    simpa using this.mono_left nhdsWithin_le_nhds
  -- the zeros of `ζ` are isolated
  have hne : ∀ᶠ z in 𝓝[≠] ρ, riemannZeta z ≠ 0 :=
    (zeta_analytic_off_pole ρ hρ1).eventually_eq_zero_or_eventually_ne_zero
      |>.resolve_left (zeta_not_locally_zero hρ1)
  -- the double pole of the transform at `ρ`
  obtain ⟨m, -, -, hpole, -, -⟩ :=
    CriticalTransformPoles.filled_pole_at_zeta_zero hρre hρ1 hz
  have hmer : MeromorphicAt fT ρ := by
    by_contra h
    rw [meromorphicOrderAt_of_not_meromorphicAt h] at hpole
    exact absurd hpole (by decide)
  obtain ⟨g, hg, hg0, hrep⟩ := (meromorphicOrderAt_eq_int_iff hmer).mp hpole
  have hgpos : 0 < ‖g ρ‖ := norm_pos_iff.mpr hg0
  -- continuity bounds
  have hIcont : Continuous I := (MellinCompactCorrection.differentiable_W_initialPart A).continuous
  have hfTβ : ContinuousAt fT (β : ℂ) :=
    (CriticalTransformRealAxis.analyticAt_filledTransform_real hβ).continuousAt
  set KI : ℝ := ‖I ρ‖ + 1 with hKI
  set KI' : ℝ := ‖I (β : ℂ)‖ + 1 with hKI'
  set Kf : ℝ := ‖fT (β : ℂ)‖ + 1 with hKf
  set c : ℝ := ‖g ρ‖ / 2 with hc
  set K : ℝ := |C| / |ρ.im| + KI + KI' + Kf with hK
  have hcpos : 0 < c := by positivity
  have hIρ : ∀ᶠ ε : ℝ in 𝓝[>] 0, ‖I (ρ + (ε : ℂ))‖ ≤ KI :=
    ((hIcont.continuousAt.tendsto.comp htend0).norm.eventually
      (gt_mem_nhds (lt_add_one _))).mono (fun ε h => h.le)
  have hIβ : ∀ᶠ ε : ℝ in 𝓝[>] 0, ‖I (((β + ε : ℝ) : ℂ))‖ ≤ KI' :=
    ((hIcont.continuousAt.tendsto.comp htendβ).norm.eventually
      (gt_mem_nhds (lt_add_one _))).mono (fun ε h => h.le)
  have hfβ : ∀ᶠ ε : ℝ in 𝓝[>] 0, ‖fT (((β + ε : ℝ) : ℂ))‖ ≤ Kf :=
    ((hfTβ.tendsto.comp htendβ).norm.eventually
      (gt_mem_nhds (lt_add_one _))).mono (fun ε h => h.le)
  have hgρ : ∀ᶠ ε : ℝ in 𝓝[>] 0, c ≤ ‖g (ρ + (ε : ℂ))‖ :=
    ((hg.continuousAt.tendsto.comp htend0).norm.eventually
      (lt_mem_nhds (half_lt_self hgpos))).mono (fun ε h => h.le)
  have hzε : ∀ᶠ ε : ℝ in 𝓝[>] 0, riemannZeta (ρ + (ε : ℂ)) ≠ 0 := htend.eventually hne
  have hrepε : ∀ᶠ ε : ℝ in 𝓝[>] 0,
      fT (ρ + (ε : ℂ)) = ((ρ + (ε : ℂ)) - ρ) ^ (-2 : ℤ) • g (ρ + (ε : ℂ)) :=
    htend.eventually hrep
  have hsmall : ∀ᶠ ε : ℝ in 𝓝[>] 0, ε ∈ Ioo (0 : ℝ) (1 - β) := Ioo_mem_nhdsGT (by linarith)
  -- the key inequality `c ≤ |C| ε + K ε²` for all small `ε > 0`
  have hineq : ∀ᶠ ε : ℝ in 𝓝[>] 0, c ≤ |C| * ε + K * ε ^ 2 := by
    filter_upwards [hIρ, hIβ, hfβ, hgρ, hzε, hrepε, hsmall] with ε hIρ hIβ hfβ hgρ hzε hrepε hsmall
    have hε : 0 < ε := hsmall.1
    have hε1 : β + ε < 1 := by linarith [hsmall.2]
    -- identity on the ray
    have hJρ : J (ρ + (ε : ℂ)) = fT (ρ + (ε : ℂ)) := by
      have h0 := hzeroU (ρ + (ε : ℂ)) (hρU ε hε)
      rw [cleared_eq (hU (hρU ε hε)).2 hzε] at h0
      exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hzε))
    -- identity on the real axis
    have hJβ : J (((β + ε : ℝ) : ℂ)) = fT (((β + ε : ℝ) : ℂ)) :=
      hreal (β + ε) (by linarith) hε1
    -- size of the transform on the ray
    have hfTρ : c / ε ^ 2 ≤ ‖fT (ρ + (ε : ℂ))‖ := by
      rw [hrepε, add_sub_cancel_left, norm_smul, norm_zpow, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos hε, zpow_neg, zpow_ofNat, ← div_eq_inv_mul]
      exact div_le_div_of_nonneg_right hgρ (by positivity)
    -- the majorant transform on the ray and on the axis
    have hFρ : ‖powerTransformAt β C A (ρ + (ε : ℂ))‖ ≤ |C| / |ρ.im| := by
      have hne' : ρ + (ε : ℂ) ≠ (β : ℂ) := by
        intro h
        have := congrArg Complex.im h
        simp at this
        exact hρim this
      refine (norm_powerTransformAt_le hA ?_).trans ?_
      · rw [Complex.add_re, Complex.ofReal_re, hρβ]
        linarith
      · apply div_le_div_of_nonneg_left (abs_nonneg C) (abs_pos.mpr hρim)
        calc |ρ.im| = |(ρ + (ε : ℂ) - (β : ℂ)).im| := by simp
          _ ≤ ‖ρ + (ε : ℂ) - (β : ℂ)‖ := Complex.abs_im_le_norm _
    have hFβ : ‖powerTransformAt β C A (((β + ε : ℝ) : ℂ))‖ ≤ |C| / ε := by
      have hne' : (((β + ε : ℝ) : ℂ)) ≠ (β : ℂ) := by
        intro h
        have := congrArg Complex.re h
        simp at this
        linarith
      refine (norm_powerTransformAt_le hA ?_).trans ?_
      · rw [Complex.ofReal_re]
        linarith
      · have : ‖(((β + ε : ℝ) : ℂ)) - (β : ℂ)‖ = ε := by
          rw [← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs, add_sub_cancel_left,
            abs_of_pos hε]
        rw [this]
    -- lower bound for `‖L(ρ+ε)‖`
    have hLρ : c / ε ^ 2 - |C| / |ρ.im| - KI ≤ ‖L (ρ + (ε : ℂ))‖ := by
      rw [hL, hJρ]
      set Fρ := powerTransformAt β C A (ρ + (ε : ℂ)) with hFρdef
      set Xρ := η * (I (ρ + (ε : ℂ)) - fT (ρ + (ε : ℂ))) with hXρdef
      have h1 : ‖fT (ρ + (ε : ℂ))‖ - ‖I (ρ + (ε : ℂ))‖ ≤ ‖Xρ‖ := by
        rw [hXρdef, norm_mul, hη, one_mul, norm_sub_rev]
        exact norm_sub_norm_le _ _
      have h2 : ‖Xρ‖ - ‖Fρ‖ ≤ ‖Fρ + Xρ‖ := by
        have h := norm_add_le (Fρ + Xρ) (-Fρ)
        rw [norm_neg, show Fρ + Xρ + -Fρ = Xρ by ring] at h
        linarith
      linarith
    -- upper bound for `‖L(β+ε)‖`
    have hLβ : ‖L (((β + ε : ℝ) : ℂ))‖ ≤ |C| / ε + KI' + Kf := by
      rw [hL, hJβ]
      calc ‖powerTransformAt β C A (((β + ε : ℝ) : ℂ)) +
            η * (I (((β + ε : ℝ) : ℂ)) - fT (((β + ε : ℝ) : ℂ)))‖
          ≤ ‖powerTransformAt β C A (((β + ε : ℝ) : ℂ))‖ +
            ‖η * (I (((β + ε : ℝ) : ℂ)) - fT (((β + ε : ℝ) : ℂ)))‖ := norm_add_le _ _
        _ ≤ |C| / ε + (‖I (((β + ε : ℝ) : ℂ))‖ + ‖fT (((β + ε : ℝ) : ℂ))‖) := by
          refine add_le_add hFβ ?_
          rw [norm_mul, hη, one_mul]
          exact norm_sub_le _ _
        _ ≤ |C| / ε + KI' + Kf := by linarith
    -- positivity links the two
    have hre : (ρ + (ε : ℂ)).re = β + ε := by rw [Complex.add_re, Complex.ofReal_re, hρβ]
    have hlink : ‖L (ρ + (ε : ℂ))‖ ≤ ‖L (((β + ε : ℝ) : ℂ))‖ := by
      have h := hpos (ρ + (ε : ℂ))
      rw [hre] at h
      exact h.trans (Complex.re_le_norm _)
    have hmain : c / ε ^ 2 ≤ |C| / ε + K := by
      have : |C| / |ρ.im| + KI + KI' + Kf = K := rfl
      linarith
    rw [div_le_iff₀ (by positivity)] at hmain
    have hε0 : ε ≠ 0 := hε.ne'
    calc c ≤ (|C| / ε + K) * ε ^ 2 := hmain
      _ = |C| * ε + K * ε ^ 2 := by field_simp
  -- but the right side tends to `0 < c`
  have hlim : Tendsto (fun ε : ℝ => |C| * ε + K * ε ^ 2) (𝓝[>] 0) (𝓝 0) := by
    have : Tendsto (fun ε : ℝ => |C| * ε + K * ε ^ 2) (𝓝 0) (𝓝 (|C| * 0 + K * 0 ^ 2)) :=
      ((continuous_const.mul continuous_id).add (continuous_const.mul (continuous_id.pow 2)))
        |>.tendsto 0
    simpa using this.mono_left nhdsWithin_le_nhds
  have hlt : ∀ᶠ ε : ℝ in 𝓝[>] 0, |C| * ε + K * ε ^ 2 < c := hlim.eventually (gt_mem_nhds hcpos)
  obtain ⟨ε, h1, h2⟩ := (hineq.and hlt).exists
  linarith

/-! ### The concrete criteria -/

/-- **Upper boundary criterion.** For `1/2 < β < 1`, `Re W(x) ≤ C x^{1+β}` for all `x > A`
excludes every zero with `Re ρ = β`. -/
theorem zeroFree_boundary_of_power_growth {β C A : ℝ} (hβ : (1 : ℝ) / 2 < β) (hβ1 : β < 1)
    (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + β)) :
    ∀ ρ : ℂ, ρ.re = β → riemannZeta ρ ≠ 0 := by
  set D : MajorantData β A := powerDataAt β C hβ.le hβ1 (lt_of_lt_of_le zero_lt_one hA) with hD
  have hgrow' : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x := hgrow
  have hF : D.F = powerTransformAt β C A := rfl
  refine no_zero_on_boundary (C := C) hβ hβ1 hA 1 (by simp)
    (LaplaceMomentDerivatives.moment (growthMeasure D) time 0)
    (ActualCriticalMajorantCriterion.continuation D)
    (continuation_analyticOnNhd D hA hgrow')
    (fun s hs => continuation_eq_filledTransform D hA hgrow' hs) ?_
    (fun s => norm_moment_le_re_moment _ s)
  intro s
  simp only [ActualCriticalMajorantCriterion.continuation, hF]
  ring

/-- **Lower boundary criterion.** For `1/2 < β < 1`, `-C x^{1+β} ≤ Re W(x)` for all `x > A`
excludes every zero with `Re ρ = β`. -/
theorem zeroFree_boundary_of_power_lower_growth {β C A : ℝ} (hβ : (1 : ℝ) / 2 < β)
    (hβ1 : β < 1) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ (1 + β)) ≤ (ActualCriticalMellin.W x).re) :
    ∀ ρ : ℂ, ρ.re = β → riemannZeta ρ ≠ 0 := by
  set D : MajorantData β A := powerDataAt β C hβ.le hβ1 (lt_of_lt_of_le zero_lt_one hA) with hD
  have hlow' : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re := hlow
  have hF : D.F = powerTransformAt β C A := rfl
  refine no_zero_on_boundary (C := C) hβ hβ1 hA (-1) (by simp)
    (LaplaceMomentDerivatives.moment (lowerMeasure D) time 0)
    (ActualCriticalLowerMajorant.lowerContinuation D)
    (lowerContinuation_analyticOnNhd D hA hlow')
    (fun s hs => lowerContinuation_eq_filledTransform D hA hlow' hs) ?_
    (fun s => norm_moment_le_re_moment _ s)
  intro s
  simp only [ActualCriticalLowerMajorant.lowerContinuation, hF]
  ring

/-- **Closed half-plane criterion.** For `1/2 < θ < 1`, `Re W(x) ≤ C x^{1+θ}` for all `x > A`
excludes every zero with `Re ρ ≥ θ`. -/
theorem zeroFree_ge_of_power_growth {θ C A : ℝ} (hθ : (1 : ℝ) / 2 < θ) (hθ1 : θ < 1)
    (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + θ)) :
    ∀ ρ : ℂ, θ ≤ ρ.re → riemannZeta ρ ≠ 0 := by
  intro ρ hρ
  rcases eq_or_lt_of_le hρ with h | h
  · exact zeroFree_boundary_of_power_growth hθ hθ1 hA hgrow ρ h.symm
  · exact zeroFree_of_power_growth hθ.le hθ1 hA hgrow ρ h

theorem zeroFree_ge_of_power_lower_growth {θ C A : ℝ} (hθ : (1 : ℝ) / 2 < θ) (hθ1 : θ < 1)
    (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ (1 + θ)) ≤ (ActualCriticalMellin.W x).re) :
    ∀ ρ : ℂ, θ ≤ ρ.re → riemannZeta ρ ≠ 0 := by
  intro ρ hρ
  rcases eq_or_lt_of_le hρ with h | h
  · exact zeroFree_boundary_of_power_lower_growth hθ hθ1 hA hlow ρ h.symm
  · exact zeroFree_of_power_lower_growth hθ.le hθ1 hA hlow ρ h

/-- **Sharp oscillation theorem.** A zero `ρ` with `Re ρ > 1/2` forces, for every `C`, both
`Re W(x) > C x^{1+Re ρ}` and `Re W(x) < -C x^{1+Re ρ}` for arbitrarily large `x`: the upper
and lower limits of `W(x)/x^{1+Re ρ}` are `+∞` and `-∞`. -/
theorem sharp_oscillation_of_zero {ρ : ℂ} (hz : riemannZeta ρ = 0) (hρ : (1 : ℝ) / 2 < ρ.re)
    (C : ℝ) :
    (∃ᶠ x : ℝ in atTop, C * x ^ (1 + ρ.re) < (ActualCriticalMellin.W x).re) ∧
    (∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ (1 + ρ.re))) := by
  have hβ1 : ρ.re < 1 := re_lt_one_of_zero hz
  constructor
  · rw [Filter.frequently_atTop']
    intro B
    by_contra h
    push Not at h
    exact zeroFree_boundary_of_power_growth hρ hβ1 (A := max 1 B) (le_max_left _ _)
      (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) ρ rfl hz
  · rw [Filter.frequently_atTop']
    intro B
    by_contra h
    push Not at h
    exact zeroFree_boundary_of_power_lower_growth hρ hβ1 (A := max 1 B) (le_max_left _ _)
      (fun x hx => h x (lt_of_le_of_lt (le_max_right _ _) hx)) ρ rfl hz

end BuildingBlocks.ActualCriticalSharpOscillation
