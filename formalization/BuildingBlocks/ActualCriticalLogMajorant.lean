import BuildingBlocks.ActualCriticalMajorantCriterion
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Analysis.Complex.RealDeriv
import Mathlib.MeasureTheory.Integral.IntegralEqImproper

/-!
# The main-term majorant `C x^{3/2} log² x`

Instance of the majorant criterion with `g(x) = C x^{3/2} (log x)^2`, the size of the main term
of `W` under RH. The tail transform

  `∫_A^∞ x^{-s-2} · C x^{3/2} (log x)^2 dx = C A^{1/2-s} ( (log A)^2/(s-1/2) + 2 log A/(s-1/2)^2 + 2/(s-1/2)^3 )`

is computed from the explicit antiderivative and continues analytically to `s ≠ 1/2`. Hence

  `(∀ x > A, Re W(x) ≤ C x^{3/2} (log x)^2) → RiemannHypothesis`

for every real `C` and `A ≥ 1`. Under RH the main term of `W` is `-(1/6) x^{3/2} log² x`, so this
premise is expected with any `C ≥ 0`; it remains an unproved premise of RH strength.
-/

open MeasureTheory Set Filter Topology Asymptotics
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalLogMajorant

open ActualCriticalMajorantCriterion

/-- The polynomial `L^2/u + 2L/u^2 + 2/u^3` with `u = s - 1/2`. -/
noncomputable def P (s : ℂ) (L : ℂ) : ℂ :=
  L * L / (s - 1 / 2) + 2 * L / (s - 1 / 2) ^ 2 + 2 / (s - 1 / 2) ^ 3

/-- The antiderivative `-C x^{1/2-s} P(log x)`. -/
noncomputable def Phi (C : ℝ) (s : ℂ) (x : ℝ) : ℂ :=
  -(C : ℂ) * ((x : ℂ) ^ (1 / 2 - s) * P s (Real.log x : ℂ))

/-- The tail transform `C A^{1/2-s} P(log A)`. -/
noncomputable def logF (C A : ℝ) (s : ℂ) : ℂ :=
  (C : ℂ) * ((A : ℂ) ^ (1 / 2 - s) * P s (Real.log A : ℂ))

/-- The majorant. -/
noncomputable def logMajorant (C : ℝ) (x : ℝ) : ℝ := C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2

/-- The Mellin kernel of the majorant. -/
noncomputable def logKernel (C : ℝ) (s : ℂ) (x : ℝ) : ℂ :=
  (x : ℂ) ^ (-s - 2) * (logMajorant C x : ℂ)

theorem logKernel_eq {C : ℝ} {s : ℂ} {x : ℝ} (hx : 0 < x) :
    logKernel C s x = (C : ℂ) * ((x : ℂ) ^ (-s - 1 / 2) * (Real.log x : ℂ) ^ 2) := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  unfold logKernel logMajorant
  rw [Complex.ofReal_mul, Complex.ofReal_mul, Complex.ofReal_cpow hx.le, Complex.ofReal_pow]
  rw [show (x : ℂ) ^ (-s - 2) * ((C : ℂ) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ) * (Real.log x : ℂ) ^ 2) =
      (C : ℂ) * (((x : ℂ) ^ (-s - 2) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ)) * (Real.log x : ℂ) ^ 2) by ring,
    ← Complex.cpow_add _ _ hn]
  congr 3
  push_cast
  ring

theorem measurable_logMajorant (C : ℝ) : Measurable (logMajorant C) :=
  (measurable_const.mul (measurable_id.pow_const _)).mul (Real.measurable_log.pow_const 2)

/-! ### The derivative of the antiderivative -/

theorem hasDerivAt_Phi {C : ℝ} {s : ℂ} (hs : s ≠ 1 / 2) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (Phi C s) ((C : ℂ) * ((x : ℂ) ^ (-s - 1 / 2) * (Real.log x : ℂ) ^ 2)) x := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  have hu : (s - 1 / 2 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  have hw : (1 / 2 - s : ℂ) ≠ 0 := by
    intro h
    apply hs
    linear_combination -h
  -- base power
  have hpow : HasDerivAt (fun y : ℝ => (y : ℂ) ^ (1 / 2 - s))
      ((1 / 2 - s) * (x : ℂ) ^ (1 / 2 - s - 1)) x :=
    hasDerivAt_ofReal_cpow_const hx.ne' hw
  -- complex log
  have hL : HasDerivAt (fun y : ℝ => (Real.log y : ℂ)) ((x⁻¹ : ℝ) : ℂ) x :=
    (Real.hasDerivAt_log hx.ne').ofReal_comp
  -- P ∘ log
  have h1 : HasDerivAt (fun y : ℝ => (Real.log y : ℂ) * (Real.log y : ℂ) / (s - 1 / 2))
      ((((x⁻¹ : ℝ) : ℂ) * (Real.log x : ℂ) + (Real.log x : ℂ) * ((x⁻¹ : ℝ) : ℂ)) / (s - 1 / 2)) x :=
    (hL.fun_mul hL).div_const _
  have h2 : HasDerivAt (fun y : ℝ => 2 * (Real.log y : ℂ) / (s - 1 / 2) ^ 2)
      ((2 * ((x⁻¹ : ℝ) : ℂ)) / (s - 1 / 2) ^ 2) x :=
    (hL.const_mul 2).div_const _
  have h3 : HasDerivAt (fun _ : ℝ => (2 : ℂ) / (s - 1 / 2) ^ 3) 0 x := hasDerivAt_const x _
  have hP : HasDerivAt (fun y : ℝ => P s (Real.log y : ℂ))
      (((((x⁻¹ : ℝ) : ℂ) * (Real.log x : ℂ) + (Real.log x : ℂ) * ((x⁻¹ : ℝ) : ℂ)) / (s - 1 / 2)) +
        ((2 * ((x⁻¹ : ℝ) : ℂ)) / (s - 1 / 2) ^ 2) + 0) x :=
    (h1.fun_add h2).fun_add h3
  have hΦ := (hpow.fun_mul hP).const_mul (-(C : ℂ))
  refine hΦ.congr_deriv ?_
  -- algebra: x^(1/2-s-1) = x^(-s-1/2), x^(1/2-s) = x^(-s-1/2) * x
  have e1 : (x : ℂ) ^ (1 / 2 - s - 1) = (x : ℂ) ^ (-s - 1 / 2) := by
    congr 1
    ring
  have e2 : (x : ℂ) ^ (1 / 2 - s) = (x : ℂ) ^ (-s - 1 / 2) * (x : ℂ) := by
    rw [show (1 / 2 - s : ℂ) = (-s - 1 / 2) + 1 by ring, Complex.cpow_add _ _ hn, Complex.cpow_one]
  rw [e1, e2, Complex.ofReal_inv, show (1 / 2 - s : ℂ) = -(s - 1 / 2) by ring]
  simp only [P]
  set X : ℂ := (x : ℂ) ^ (-s - 1 / 2) with hX
  set u : ℂ := s - 1 / 2 with hu'
  have hu0 : u ≠ 0 := hu
  field_simp [hu0, hn]
  ring

/-! ### Decay of the antiderivative at infinity -/

theorem norm_P_le {s : ℂ} (hs : s ≠ 1 / 2) {L : ℂ} (hL : 1 ≤ ‖L‖) :
    ‖P s L‖ ≤ (1 / ‖s - 1 / 2‖ + 2 / ‖s - 1 / 2‖ ^ 2 + 2 / ‖s - 1 / 2‖ ^ 3) * ‖L‖ ^ 2 := by
  have hu : 0 < ‖s - 1 / 2‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hs)
  have hL0 : 0 ≤ ‖L‖ := norm_nonneg _
  have hL2 : 1 ≤ ‖L‖ ^ 2 := by nlinarith
  unfold P
  calc ‖L * L / (s - 1 / 2) + 2 * L / (s - 1 / 2) ^ 2 + 2 / (s - 1 / 2) ^ 3‖
      ≤ ‖L * L / (s - 1 / 2)‖ + ‖2 * L / (s - 1 / 2) ^ 2‖ + ‖2 / (s - 1 / 2) ^ 3‖ :=
        norm_add₃_le
    _ = ‖L‖ ^ 2 / ‖s - 1 / 2‖ + 2 * ‖L‖ / ‖s - 1 / 2‖ ^ 2 + 2 / ‖s - 1 / 2‖ ^ 3 := by
        simp only [norm_div, norm_mul, norm_pow]
        norm_num
        ring
    _ ≤ ‖L‖ ^ 2 / ‖s - 1 / 2‖ + 2 * ‖L‖ ^ 2 / ‖s - 1 / 2‖ ^ 2 + 2 * ‖L‖ ^ 2 / ‖s - 1 / 2‖ ^ 3 := by
        gcongr
        · nlinarith
        · linarith
    _ = (1 / ‖s - 1 / 2‖ + 2 / ‖s - 1 / 2‖ ^ 2 + 2 / ‖s - 1 / 2‖ ^ 3) * ‖L‖ ^ 2 := by ring

theorem tendsto_log_sq_mul_rpow {σ : ℝ} (hσ : 1 / 2 < σ) :
    Tendsto (fun x : ℝ => (Real.log x) ^ 2 * x ^ (1 / 2 - σ)) atTop (𝓝 0) := by
  have h := (isLittleO_log_rpow_rpow_atTop (2 : ℝ) (by linarith : 0 < σ - 1 / 2)).tendsto_div_nhds_zero
  refine h.congr' ?_
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  rw [Real.rpow_two, show (1 / 2 - σ : ℝ) = -(σ - 1 / 2) by ring, Real.rpow_neg hx.le, div_eq_mul_inv]

theorem tendsto_Phi {C : ℝ} {s : ℂ} (hs : 1 / 2 < s.re) :
    Tendsto (Phi C s) atTop (𝓝 0) := by
  have hs' : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  set K : ℝ := 1 / ‖s - 1 / 2‖ + 2 / ‖s - 1 / 2‖ ^ 2 + 2 / ‖s - 1 / 2‖ ^ 3 with hK
  have hK0 : 0 ≤ K := by positivity
  have hlim : Tendsto (fun x : ℝ => |C| * K * ((Real.log x) ^ 2 * x ^ (1 / 2 - s.re))) atTop (𝓝 0) := by
    have := (tendsto_log_sq_mul_rpow hs).const_mul (|C| * K)
    simpa using this
  refine squeeze_zero_norm' ?_ hlim
  filter_upwards [eventually_ge_atTop (Real.exp 1)] with x hx
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos 1) hx
  have hlog1 : 1 ≤ Real.log x := by
    rw [← Real.log_exp 1]
    exact Real.log_le_log (Real.exp_pos 1) hx
  have hLnorm : ‖(Real.log x : ℂ)‖ = Real.log x := by
    rw [Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  unfold Phi
  rw [norm_mul, norm_mul, norm_neg, Complex.norm_real, Real.norm_eq_abs,
    Complex.norm_cpow_eq_rpow_re_of_pos hx0]
  have hre : (1 / 2 - s : ℂ).re = 1 / 2 - s.re := by simp
  rw [hre]
  have hP := norm_P_le hs' (L := (Real.log x : ℂ)) (by rw [hLnorm]; exact hlog1)
  rw [hLnorm] at hP
  calc |C| * (x ^ (1 / 2 - s.re) * ‖P s (Real.log x : ℂ)‖)
      ≤ |C| * (x ^ (1 / 2 - s.re) * (K * (Real.log x) ^ 2)) := by
        gcongr
    _ = |C| * K * ((Real.log x) ^ 2 * x ^ (1 / 2 - s.re)) := by ring

/-! ### Integrability of the kernel -/

theorem log_le_rpow_div {x ε : ℝ} (hx : 0 < x) (hε : 0 < ε) : Real.log x ≤ x ^ ε / ε := by
  have h1 : Real.log (x ^ ε) ≤ x ^ ε - 1 := Real.log_le_sub_one_of_pos (Real.rpow_pos_of_pos hx ε)
  rw [Real.log_rpow hx] at h1
  have h2 : ε * Real.log x ≤ x ^ ε := by linarith
  rw [le_div_iff₀ hε]
  linarith

theorem integrableOn_logKernel {C A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 / 2 < s.re) :
    IntegrableOn (logKernel C s) (Ioi A) := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  set ε : ℝ := (s.re - 1 / 2) / 4 with hε
  have hε0 : 0 < ε := by rw [hε]; linarith
  have hexp : -s.re - 1 / 2 + 2 * ε < -1 := by rw [hε]; linarith
  have hg : IntegrableOn (fun x : ℝ => (|C| / ε ^ 2) * x ^ (-s.re - 1 / 2 + 2 * ε)) (Ioi A) :=
    (integrableOn_Ioi_rpow_of_lt hexp hA0).const_mul _
  refine hg.mono' ?_ ?_
  · -- measurability
    apply Measurable.aestronglyMeasurable
    unfold logKernel
    exact (Measurable.pow Complex.measurable_ofReal measurable_const).mul
      (Complex.measurable_ofReal.comp (measurable_logMajorant C))
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
    have hx1 : 1 < x := lt_of_le_of_lt hA hx
    have hx0 : 0 < x := zero_lt_one.trans hx1
    rw [logKernel_eq hx0, norm_mul, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      Complex.norm_cpow_eq_rpow_re_of_pos hx0, norm_pow, Complex.norm_real,
      Real.norm_of_nonneg (Real.log_nonneg hx1.le)]
    have hre : (-s - 1 / 2 : ℂ).re = -s.re - 1 / 2 := by simp
    rw [hre]
    have hlog : Real.log x ≤ x ^ ε / ε := log_le_rpow_div hx0 hε0
    have hlog2 : (Real.log x) ^ 2 ≤ (x ^ ε / ε) ^ 2 :=
      pow_le_pow_left₀ (Real.log_nonneg hx1.le) hlog 2
    have hsplit : x ^ (-s.re - 1 / 2 + 2 * ε) = x ^ (-s.re - 1 / 2) * (x ^ ε) ^ 2 := by
      rw [Real.rpow_add hx0, ← Real.rpow_natCast, ← Real.rpow_mul hx0.le]
      congr 2
      push_cast
      ring
    rw [hsplit]
    have hxp : 0 ≤ x ^ (-s.re - 1 / 2) := Real.rpow_nonneg hx0.le _
    calc |C| * (x ^ (-s.re - 1 / 2) * (Real.log x) ^ 2)
        ≤ |C| * (x ^ (-s.re - 1 / 2) * (x ^ ε / ε) ^ 2) := by gcongr
      _ = |C| / ε ^ 2 * (x ^ (-s.re - 1 / 2) * (x ^ ε) ^ 2) := by
          field_simp

/-! ### The tail transform -/

theorem integral_logKernel {C A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 / 2 < s.re) :
    (∫ x : ℝ in Ioi A, logKernel C s x) = logF C A s := by
  have hA0 : 0 < A := lt_of_lt_of_le zero_lt_one hA
  have hs' : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  have hderiv : ∀ x ∈ Ioi A, HasDerivAt (Phi C s) (logKernel C s x) x := by
    intro x hx
    have hx0 : 0 < x := lt_trans hA0 hx
    rw [logKernel_eq hx0]
    exact hasDerivAt_Phi hs' hx0
  have hcont : ContinuousWithinAt (Phi C s) (Ici A) A :=
    (hasDerivAt_Phi hs' hA0).continuousAt.continuousWithinAt
  rw [integral_Ioi_of_hasDerivAt_of_tendsto hcont hderiv (integrableOn_logKernel hA hs)
    (tendsto_Phi hs)]
  unfold Phi logF
  ring

theorem logF_analyticAt {C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : s ≠ 1 / 2) :
    AnalyticAt ℂ (logF C A) s := by
  have hu : (s - 1 / 2 : ℂ) ≠ 0 := sub_ne_zero.mpr hs
  unfold logF P
  have hexp : AnalyticAt ℂ (fun z : ℂ => (1 : ℂ) / 2 - z) s := analyticAt_const.sub analyticAt_id
  have hpow : AnalyticAt ℂ (fun z : ℂ => (A : ℂ) ^ (1 / 2 - z)) s :=
    analyticAt_const.cpow hexp (Complex.ofReal_mem_slitPlane.mpr hA)
  have hden : AnalyticAt ℂ (fun z : ℂ => z - 1 / 2) s := analyticAt_id.sub analyticAt_const
  have hP : AnalyticAt ℂ (fun z : ℂ =>
      (Real.log A : ℂ) * (Real.log A : ℂ) / (z - 1 / 2) + 2 * (Real.log A : ℂ) / (z - 1 / 2) ^ 2 +
        2 / (z - 1 / 2) ^ 3) s := by
    refine ((analyticAt_const.div hden hu).add (analyticAt_const.div (hden.pow 2) (pow_ne_zero 2 hu))).add
      (analyticAt_const.div (hden.pow 3) (pow_ne_zero 3 hu))
  exact analyticAt_const.mul (hpow.mul hP)

/-- The majorant datum for `C x^{3/2} log² x`. -/
noncomputable def logData (C : ℝ) {A : ℝ} (hA : 1 ≤ A) : MajorantData (1 / 2) A where
  g := logMajorant C
  measurable_g := measurable_logMajorant C
  F := logF C A
  half_le := le_rfl
  analytic_F := by
    intro s hs
    have hne : s ≠ 1 / 2 := by
      intro h
      rw [h] at hs
      simp at hs
    exact logF_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne
  integrable_kernel := fun s hs => integrableOn_logKernel hA (by linarith [hs] : 1 / 2 < s.re)
  integral_kernel := fun s hs => integral_logKernel hA (by linarith [hs] : 1 / 2 < s.re)

/-- **Main-term growth criterion.** If `Re W(x) ≤ C x^{3/2} (log x)^2` for all `x > A`, then RH. -/
theorem RiemannHypothesis_of_log_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) :
    RiemannHypothesis :=
  RiemannHypothesis_of_majorant (logData C hA) hA hgrow

theorem RiemannHypothesis_of_eventually_log_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) :
    RiemannHypothesis := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hgrow
  exact RiemannHypothesis_of_log_growth_after (A := max 1 B) (le_max_left _ _)
    (fun x hx => hB x ((le_max_right 1 B).trans hx.le))

end BuildingBlocks.ActualCriticalLogMajorant

#print axioms BuildingBlocks.ActualCriticalLogMajorant.RiemannHypothesis_of_log_growth_after
#print axioms BuildingBlocks.ActualCriticalLogMajorant.RiemannHypothesis_of_eventually_log_growth
