import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

namespace BuildingBlocks

noncomputable def bernoulliDivergence (q r : ℝ) : ℝ :=
  q * Real.log (q / r) + (1 - q) * Real.log ((1 - q) / (1 - r))

theorem bernoulliDivergence_nonneg {q r : ℝ}
    (hq : 0 < q) (hq1 : q < 1) (hr : 0 < r) (hr1 : r < 1) :
    0 ≤ bernoulliDivergence q r := by
  have hq' : 0 < 1 - q := sub_pos.mpr hq1
  have hr' : 0 < 1 - r := sub_pos.mpr hr1
  have h₁ : q * Real.log (r / q) ≤ r - q := by
    calc
      _ ≤ q * (r / q - 1) := mul_le_mul_of_nonneg_left
        (Real.log_le_sub_one_of_pos (div_pos hr hq)) hq.le
      _ = _ := by field_simp
  have h₂ : (1 - q) * Real.log ((1 - r) / (1 - q)) ≤ q - r := by
    calc
      _ ≤ (1 - q) * ((1 - r) / (1 - q) - 1) := mul_le_mul_of_nonneg_left
        (Real.log_le_sub_one_of_pos (div_pos hr' hq')) hq'.le
      _ = _ := by field_simp; ring
  rw [Real.log_div hr.ne' hq.ne'] at h₁
  rw [Real.log_div hr'.ne' hq'.ne'] at h₂
  unfold bernoulliDivergence
  rw [Real.log_div hq.ne' hr.ne', Real.log_div hq'.ne' hr'.ne']
  nlinarith

/-- The energy of the real optimal exponent, with its logarithm justified. -/
theorem divisor_real_exponent_energy {p T : ℝ} (hp : 1 < p) (hT : p < T) :
    (Real.log T / Real.log p - 1) * Real.log p = Real.log (T / p) := by
  have hp0 : 0 < p := lt_trans zero_lt_one hp
  have hT0 : 0 < T := lt_trans hp0 hT
  rw [Real.log_div hT0.ne' hp0.ne']
  have hlp : Real.log p ≠ 0 := (Real.log_pos hp).ne'
  field_simp

/-- Exact loss from an actual natural exponent relative to the real optimum.
This formalizes the local scalar loss in Bell, `robin-integrality-gap`,
§6 equation `e-kappa` (substitute `x = log p`, `Y = log T`):
https://github.com/epicycloids/robin-integrality-gap/blob/main/paper/sections/integrality_gap.tex
No wider claim of that manuscript is used.
Here `q = 1 / T`, `ε = q / (1 - q)`, and the integer tail is `1 / p^(a+1)`. -/
theorem divisor_gain_kl_identity {p T : ℝ} (a : ℕ)
    (hp : 1 < p) (hT : p < T) :
    (Real.log ((1 - 1 / T) / (1 - 1 / p)) -
      ((1 / T) / (1 - 1 / T)) * Real.log (T / p)) -
    (Real.log ((1 - 1 / p ^ (a + 1)) / (1 - 1 / p)) -
      ((1 / T) / (1 - 1 / T)) * (a : ℝ) * Real.log p) =
    bernoulliDivergence (1 / T) (1 / p ^ (a + 1)) / (1 - 1 / T) := by
  have hp0 : 0 < p := lt_trans zero_lt_one hp
  have hT1 : 1 < T := lt_trans hp hT
  have hT0 : 0 < T := lt_trans zero_lt_one hT1
  have hpw : 1 < p ^ (a + 1) := one_lt_pow₀ hp (by omega)
  have hpw0 : 0 < p ^ (a + 1) := lt_trans zero_lt_one hpw
  have hq0 : 0 < 1 / T := by positivity
  have hr0 : 0 < 1 / p ^ (a + 1) := by positivity
  have hq1 : 1 / T < 1 := (div_lt_one hT0).mpr hT1
  have hr1 : 1 / p ^ (a + 1) < 1 := (div_lt_one hpw0).mpr hpw
  have hb1 : 1 / p < 1 := (div_lt_one hp0).mpr hp
  have hqc : 1 - 1 / T ≠ 0 := (sub_pos.mpr hq1).ne'
  have hrc : 1 - 1 / p ^ (a + 1) ≠ 0 := (sub_pos.mpr hr1).ne'
  have hbc : 1 - 1 / p ≠ 0 := (sub_pos.mpr hb1).ne'
  have hlr : Real.log (1 / p ^ (a + 1)) = -((a : ℝ) + 1) * Real.log p := by
    simp only [one_div, Real.log_inv, Real.log_pow, Nat.cast_add, Nat.cast_one]
    ring
  unfold bernoulliDivergence
  rw [Real.log_div hqc hbc, Real.log_div hT0.ne' hp0.ne',
    Real.log_div hrc hbc, Real.log_div hq0.ne' hr0.ne', Real.log_div hqc hrc]
  rw [hlr]
  have hlt : Real.log (1 / T) = -Real.log T := by simp
  rw [hlt]
  generalize Real.log (1 - 1 / T) = u
  generalize Real.log (1 - 1 / p ^ (a + 1)) = v
  generalize Real.log (1 - 1 / p) = w
  generalize Real.log T = t
  generalize Real.log p = l
  have hTm : T - 1 ≠ 0 := (sub_pos.mpr hT1).ne'
  field_simp [hT0.ne', hTm]
  ring

theorem divisor_gain_kl_nonneg {p T : ℝ} (a : ℕ)
    (hp : 1 < p) (hT : p < T) :
    0 ≤ (Real.log ((1 - 1 / T) / (1 - 1 / p)) -
      ((1 / T) / (1 - 1 / T)) * Real.log (T / p)) -
    (Real.log ((1 - 1 / p ^ (a + 1)) / (1 - 1 / p)) -
      ((1 / T) / (1 - 1 / T)) * (a : ℝ) * Real.log p) := by
  rw [divisor_gain_kl_identity a hp hT]
  have hT1 : 1 < T := lt_trans hp hT
  have hT0 : 0 < T := lt_trans zero_lt_one hT1
  have hpw : 1 < p ^ (a + 1) := one_lt_pow₀ hp (by omega)
  have hpw0 : 0 < p ^ (a + 1) := lt_trans zero_lt_one hpw
  have hq1 : 1 / T < 1 := (div_lt_one hT0).mpr hT1
  have hr1 : 1 / p ^ (a + 1) < 1 := (div_lt_one hpw0).mpr hpw
  exact div_nonneg (bernoulliDivergence_nonneg (by positivity) hq1
    (by positivity) hr1) (sub_nonneg.mpr hq1.le)

end BuildingBlocks
