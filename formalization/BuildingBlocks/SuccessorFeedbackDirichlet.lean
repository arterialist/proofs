import BuildingBlocks.SuccessorFeedbackDecay
import Mathlib.NumberTheory.LSeries.Deriv

/-! The actual feedback driver's absolutely convergent Dirichlet transform.
The strip continuation and the Abel clock comparison are separate statements. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def driverCoefficient (n : ℕ) : ℂ :=
  if n = 0 then 0 else (driver (n - 1) : ℂ)

noncomputable def dirichletTransform (z : ℂ) : ℂ := LSeries driverCoefficient z

theorem driverCoefficient_power_bound {ε : ℝ} (hε : 0 < ε) :
    ∃ C : ℝ, ∀ n : ℕ, n ≠ 0 →
      ‖driverCoefficient n‖ ≤ C * (n : ℝ) ^ (-(1 / 2 : ℝ) + ε) := by
  refine ⟨3 * (1 / ε + 4 * log 2 + 4), ?_⟩
  intro n hn
  have hn1 : 1 ≤ n := Nat.one_le_iff_ne_zero.mpr hn
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn1
  have hn0 : (0 : ℝ) < n := lt_of_lt_of_le (by norm_num) hnR
  have hlog := log_le_rpow_div hn0.le hε
  have hp : 1 ≤ (n : ℝ) ^ ε := one_le_rpow hnR hε.le
  have hconst := mul_le_mul_of_nonneg_left hp (show 0 ≤ 4 * log (2 : ℝ) + 4 by positivity)
  have hb := driver_decay_bound (n - 1)
  have he : ((n - 1 : ℕ) : ℝ) + 1 = (n : ℝ) := by
    exact_mod_cast Nat.sub_add_cancel hn1
  rw [he] at hb
  rw [driverCoefficient, if_neg hn, Complex.norm_real, Real.norm_eq_abs]
  calc
    _ ≤ 3 * (log (n : ℝ) + 4 * log 2 + 4) * (n : ℝ) ^ (-(1 / 2 : ℝ)) := hb
    _ ≤ 3 * ((1 / ε + 4 * log 2 + 4) * (n : ℝ) ^ ε) *
        (n : ℝ) ^ (-(1 / 2 : ℝ)) := by
      apply mul_le_mul_of_nonneg_right _ (rpow_nonneg hn0.le _)
      apply mul_le_mul_of_nonneg_left _ (by norm_num)
      calc
        _ = log (n : ℝ) + (4 * log 2 + 4) := by ring
        _ ≤ (n : ℝ) ^ ε / ε + (4 * log 2 + 4) * (n : ℝ) ^ ε :=
          add_le_add hlog (by simpa only [mul_one] using hconst)
        _ = _ := by ring
    _ = _ := by
      calc
        _ = (3 * (1 / ε + 4 * log 2 + 4)) *
            ((n : ℝ) ^ ε * (n : ℝ) ^ (-(1 / 2 : ℝ))) := by ring
        _ = _ := by rw [← rpow_add hn0, add_comm ε]

theorem driver_LSeriesSummable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    LSeriesSummable driverCoefficient z := by
  let ε : ℝ := (z.re - 1 / 2) / 2
  have hε : 0 < ε := by dsimp [ε]; linarith
  obtain ⟨C, hC⟩ := driverCoefficient_power_bound hε
  apply LSeriesSummable_of_le_const_mul_rpow (x := 1 / 2 + ε)
    (by dsimp [ε]; linarith)
  refine ⟨C, ?_⟩
  intro n hn
  convert hC n hn using 1 <;> congr 2 <;> ring

theorem driver_abscissa_le_half :
    LSeries.abscissaOfAbsConv driverCoefficient ≤ ((1 / 2 : ℝ) : EReal) := by
  apply LSeries.abscissaOfAbsConv_le_of_forall_lt_LSeriesSummable
  intro y hy
  exact driver_LSeriesSummable (by simpa using hy)

/-- Actual holomorphy on the initial half-plane, derived from arithmetic decay. -/
theorem dirichletTransform_analyticOnNhd :
    AnalyticOnNhd ℂ dirichletTransform {z : ℂ | (1 : ℝ) / 2 < z.re} := by
  apply (LSeries_analyticOnNhd driverCoefficient).mono
  intro z hz
  exact driver_abscissa_le_half.trans_lt (EReal.coe_lt_coe_iff.mpr hz)

/-- The index zero term is retained as `driver 0 / 1^z`. -/
theorem dirichletTransform_eq_series {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    dirichletTransform z = ∑' j : ℕ, (driver j : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z := by
  have h := (driver_LSeriesSummable hz).tsum_eq_zero_add
  rw [LSeries.term_zero, zero_add] at h
  exact h.trans (tsum_congr (fun j => by
    simp [LSeries.term_of_ne_zero (Nat.succ_ne_zero j), driverCoefficient]))

theorem driver_dirichlet_summable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    Summable (fun j : ℕ => (driver j : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z) := by
  have h := (driver_LSeriesSummable hz).comp_injective Nat.succ_injective
  simpa [Function.comp_def, LSeries.term_def, driverCoefficient] using h

end BuildingBlocks.SuccessorFeedback
