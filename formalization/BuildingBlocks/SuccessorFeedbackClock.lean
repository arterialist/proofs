import BuildingBlocks.SuccessorFeedbackIndexCorrection
import Mathlib.Analysis.Normed.Group.FunctionSeries
import Mathlib.Analysis.MellinTransform

/-! A bounded-error comparison for the literal Abel clock. This weaker
comparison already suffices for a Mellin remainder on `Re z > 0`; it does not
assert the sharper square-root/logarithmic error estimate. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

theorem generatingFunction_difference_bound {a b : ℝ}
    (ha : 0 ≤ a) (hab : a ≤ b) (hb : b < 1) :
    |generatingFunction b - generatingFunction a| ≤
      (2 * (4 * log 2 + 1)) * ((1 - b)⁻¹ - (1 - a)⁻¹) := by
  have hb0 := ha.trans hab
  have ha1 := hab.trans_lt hb
  have hA := driver_series_summable (by rwa [abs_of_nonneg ha])
  have hB := driver_series_summable (by rwa [abs_of_nonneg hb0])
  have hg := (hasSum_geometric_of_lt_one hb0 hb).sub (hasSum_geometric_of_lt_one ha ha1)
  have h := tsum_of_norm_bounded (hg.mul_left (2 * (4 * log 2 + 1)))
    (f := fun j : ℕ => driver j * (b ^ j - a ^ j)) (fun j => by
      rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs,
        abs_of_nonneg (sub_nonneg.mpr (pow_le_pow_left₀ ha hab j))]
      exact mul_le_mul_of_nonneg_right (driver_abs_le j)
        (sub_nonneg.mpr (pow_le_pow_left₀ ha hab j)))
  have he : generatingFunction b - generatingFunction a =
      ∑' j : ℕ, driver j * (b ^ j - a ^ j) := by
    rw [generatingFunction, generatingFunction, ← hB.tsum_sub hA]
    apply tsum_congr
    intro j
    ring
  rw [he, ← Real.norm_eq_abs]
  exact h

theorem exp_clock_reciprocal_bound {t : ℝ} (ht : 0 < t) :
    (1 - exp (-t))⁻¹ - t⁻¹ ≤ 1 := by
  have he : exp (-t) < 1 := by simpa using exp_lt_exp.mpr (neg_lt_zero.mpr ht)
  have hd : 0 < 1 - exp (-t) := by linarith
  have hh := mul_le_mul_of_nonneg_left (add_one_le_exp t) (exp_pos (-t)).le
  rw [← exp_add, neg_add_cancel, exp_zero] at hh
  apply sub_le_iff_le_add.mpr
  rw [inv_eq_one_div]
  apply (div_le_iff₀ hd).2
  apply (mul_le_mul_iff_right₀ ht).mp
  field_simp
  nlinarith

noncomputable def clockError (t : ℝ) : ℝ :=
  generatingFunction (exp (-t)) - generatingFunction (1 - t)

/-- The literal clock change has a uniform bounded error. The proof uses the
whole actual signed driver series and the exponential tangent inequality. -/
theorem clockError_bound {t : ℝ} (ht : 0 < t) (ht1 : t ≤ 1) :
    |clockError t| ≤ 2 * (4 * log 2 + 1) := by
  have he : 1 - t ≤ exp (-t) := by
    have h := add_one_le_exp (-t)
    linarith
  have heb : exp (-t) < 1 := by simpa using exp_lt_exp.mpr (neg_lt_zero.mpr ht)
  have h := generatingFunction_difference_bound (show 0 ≤ 1 - t by linarith) he heb
  rw [show 1 - (1 - t) = t by ring] at h
  exact h.trans (mul_le_of_le_one_right (by positivity) (exp_clock_reciprocal_bound ht))

theorem generatingFunction_continuousAt {r : ℝ} (hr : |r| < 1) :
    ContinuousAt generatingFunction r := by
  let R : ℝ := (|r| + 1) / 2
  have hR0 : 0 ≤ R := by dsimp [R]; positivity
  have hR1 : R < 1 := by dsimp [R]; linarith
  have hrR : |r| < R := by dsimp [R]; linarith
  have hs := (summable_geometric_of_lt_one hR0 hR1).mul_left (2 * (4 * log 2 + 1))
  have hc : ContinuousOn generatingFunction (Metric.ball (0 : ℝ) R) := by
    apply continuousOn_tsum (fun j => (continuous_const.mul (continuous_id.pow j)).continuousOn) hs
    intro j x hx
    have hxR : |x| ≤ R := (show |x| < R by
      simpa only [Metric.mem_ball, dist_zero_right, Real.norm_eq_abs] using hx).le
    rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow]
    exact mul_le_mul (driver_abs_le j) (pow_le_pow_left₀ (abs_nonneg x) hxR j)
      (by positivity) (by positivity)
  exact hc.continuousAt (Metric.isOpen_ball.mem_nhds (by
    simpa only [Metric.mem_ball, dist_zero_right, Real.norm_eq_abs] using hrR))

theorem clockError_continuousOn : ContinuousOn clockError (Ioo (0 : ℝ) 1) := by
  intro t ht
  have he : |exp (-t)| < 1 := by
    rw [abs_of_pos (exp_pos _)]
    simpa using exp_lt_exp.mpr (neg_lt_zero.mpr ht.1)
  have hl : |1 - t| < 1 := by rw [abs_of_pos (by linarith [ht.2] : 0 < 1 - t)]; linarith [ht.1]
  exact (((generatingFunction_continuousAt he).comp (f := fun u : ℝ => exp (-u)) (x := t)
    (continuous_exp.comp continuous_neg).continuousAt).sub
    ((generatingFunction_continuousAt hl).comp (f := fun u : ℝ => 1 - u) (x := t)
      (continuous_const.sub continuous_id).continuousAt)).continuousWithinAt

/-- Zero extension is used only for the clock-comparison remainder. -/
noncomputable def clockErrorProfile (t : ℝ) : ℂ :=
  (Ioo (0 : ℝ) 1).indicator (fun u => (clockError u : ℂ)) t

theorem measurable_clockErrorProfile : Measurable clockErrorProfile := by
  classical
  have hc : ContinuousOn (fun t => (clockError t : ℂ)) (Ioo (0 : ℝ) 1) :=
    Complex.continuous_ofReal.comp_continuousOn clockError_continuousOn
  have he : clockErrorProfile = (Ioo (0 : ℝ) 1).piecewise
      (fun t => (clockError t : ℂ)) (fun _ => 0) := by
    funext t
    by_cases ht : t ∈ Ioo (0 : ℝ) 1 <;> simp [clockErrorProfile, Set.piecewise, ht]
  rw [he]
  exact hc.measurable_piecewise continuousOn_const measurableSet_Ioo

theorem clockErrorProfile_norm_bound (t : ℝ) :
    ‖clockErrorProfile t‖ ≤ 2 * (4 * log 2 + 1) := by
  by_cases ht : t ∈ Ioo (0 : ℝ) 1
  · rw [clockErrorProfile, indicator_of_mem ht, Complex.norm_real, Real.norm_eq_abs]
    exact clockError_bound ht.1 ht.2.le
  · rw [clockErrorProfile, indicator_of_notMem ht, norm_zero]
    positivity

theorem clockErrorProfile_integrable : Integrable clockErrorProfile := by
  have hi : Integrable ((Ioo (0 : ℝ) 1).indicator (fun _ : ℝ => 2 * (4 * log 2 + 1))) :=
    (integrableOn_const (by simp : volume (Ioo (0 : ℝ) 1) ≠ ⊤)).integrable_indicator measurableSet_Ioo
  apply hi.mono' measurable_clockErrorProfile.aestronglyMeasurable
  exact Eventually.of_forall (fun t => by
    by_cases ht : t ∈ Ioo (0 : ℝ) 1
    · rw [indicator_of_mem ht]
      exact clockErrorProfile_norm_bound t
    · rw [clockErrorProfile, indicator_of_notMem ht, indicator_of_notMem ht, norm_zero])

noncomputable def clockMellinError (s : ℂ) : ℂ := mellin clockErrorProfile s

/-- The bounded comparison suffices for the entire required half-plane of
Mellin parameters. Its proof uses no unproved arithmetic decay. -/
theorem clockMellinError_differentiableAt {s : ℂ} (hs : 0 < s.re) :
    DifferentiableAt ℂ clockMellinError s := by
  have ht : clockErrorProfile =O[atTop] (fun x : ℝ => x ^ (-(s.re + 1))) := by
    apply Asymptotics.IsBigO.of_bound 0
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with x hx
    rw [clockErrorProfile, indicator_of_notMem (show x ∉ Ioo (0 : ℝ) 1 by
      intro h; exact (not_lt_of_ge hx) h.2), norm_zero, zero_mul]
  have hb : clockErrorProfile =O[𝓝[>] (0 : ℝ)] (fun x : ℝ => x ^ (-(0 : ℝ))) := by
    apply Asymptotics.IsBigO.of_bound (2 * (4 * log 2 + 1))
    exact Eventually.of_forall (fun x => by simpa using clockErrorProfile_norm_bound x)
  exact mellin_differentiableAt_of_isBigO_rpow
    clockErrorProfile_integrable.integrableOn.locallyIntegrableOn ht (by linarith) hb hs

theorem clockMellinError_convergent {s : ℂ} (hs : 0 < s.re) :
    MellinConvergent clockErrorProfile s := by
  have ht : clockErrorProfile =O[atTop] (fun x : ℝ => x ^ (-(s.re + 1))) := by
    apply Asymptotics.IsBigO.of_bound 0
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with x hx
    rw [clockErrorProfile, indicator_of_notMem (show x ∉ Ioo (0 : ℝ) 1 by
      intro h; exact (not_lt_of_ge hx) h.2), norm_zero, zero_mul]
  have hb : clockErrorProfile =O[𝓝[>] (0 : ℝ)] (fun x : ℝ => x ^ (-(0 : ℝ))) := by
    apply Asymptotics.IsBigO.of_bound (2 * (4 * log 2 + 1))
    exact Eventually.of_forall (fun x => by simpa using clockErrorProfile_norm_bound x)
  exact mellinConvergent_of_isBigO_rpow
    clockErrorProfile_integrable.integrableOn.locallyIntegrableOn ht (by linarith) hb hs

/-- Exact signed Mellin remainder for the two clocks, with both endpoints
represented by the open integration interval. -/
theorem clockMellinError_eq_integral (s : ℂ) :
    clockMellinError s = ∫ t in Ioo (0 : ℝ) 1,
      (t : ℂ) ^ (s - 1) *
        ((generatingFunction (exp (-t)) - generatingFunction (1 - t) : ℝ) : ℂ) := by
  unfold clockMellinError mellin
  have he : (fun t : ℝ => (t : ℂ) ^ (s - 1) • clockErrorProfile t) =
      (Ioo (0 : ℝ) 1).indicator (fun t => (t : ℂ) ^ (s - 1) * (clockError t : ℂ)) := by
    funext t
    by_cases ht : t ∈ Ioo (0 : ℝ) 1 <;> simp [clockErrorProfile, ht, smul_eq_mul]
  rw [he, setIntegral_indicator measurableSet_Ioo,
    inter_eq_right.mpr (Ioo_subset_Ioi_self : Ioo (0 : ℝ) 1 ⊆ Ioi 0)]
  rfl

theorem clockMellinError_analyticOnNhd :
    AnalyticOnNhd ℂ clockMellinError {s : ℂ | 0 < s.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  exact fun s hs => (clockMellinError_differentiableAt hs).differentiableWithinAt

end BuildingBlocks.SuccessorFeedback
