import BuildingBlocks.FactorialBirthInteriorBound
import Mathlib.NumberTheory.Harmonic.Bounds

open Finset
namespace BuildingBlocks.FactorialCompensatedEnvelope

noncomputable def mixedBudget (N : ℕ) (a : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 N, min (a / n) (a ^ 2 / (2 * (n : ℝ) ^ 2))

/-- Both Taylor remainder envelopes on the exact nonnegative clock. -/
theorem remainder_min (v : ℝ) (hv : 0 ≤ v) :
    |1 - Real.exp (-v) - v| ≤ min v (v ^ 2 / 2) := by
  apply le_min
  · have he := Real.add_one_le_exp (-v)
    have he' : Real.exp (-v) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
    rw [abs_of_nonpos (by linarith)]
    linarith
  · exact FactorialOriginNeutralization.exponential_remainder_bound v hv

/-- The exact first-row arithmetic cancellation is applied before absolute values. -/
theorem actual_response_mixed (N : ℕ) (hN : 0 < N) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤ t + mixedBudget N ((N : ℝ) * t) := by
  rw [FactorialOriginNeutralization.response_linear_neutralization N hN t]
  apply (abs_add_le _ _).trans
  rw [abs_of_nonneg ht]
  apply add_le_add_left
  apply (abs_sum_le_sum_abs _ _).trans
  unfold mixedBudget
  apply sum_le_sum
  intro n hn
  have hq : (((N / n : ℕ) : ℝ) * t) ≤ ((N : ℝ) * t) / n := by
    simpa only [div_mul_eq_mul_div] using
      mul_le_mul_of_nonneg_right (Nat.cast_div_le (m := N) (n := n) (α := ℝ)) ht
  have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
    exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
  have hr := remainder_min (((N / n : ℕ) : ℝ) * t) (by positivity)
  rw [← neg_mul] at hr
  have hrem : |1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t| ≤
      min (((N : ℝ) * t) / n) (((N : ℝ) * t)^2 / (2 * (n : ℝ)^2)) := by
    apply hr.trans
    apply min_le_min hq
    have hs := pow_le_pow_left₀ (by positivity : 0 ≤ (((N / n : ℕ) : ℝ) * t)) hq 2
    apply (div_le_div_of_nonneg_right hs (by norm_num : (0 : ℝ) ≤ 2)).trans_eq
    rw [div_pow, div_div]
    ring
  rw [abs_mul]
  have ha : |(ArithmeticFunction.moebius n : ℝ)| *
      |1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t| ≤
      |1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t| := by
    nlinarith [abs_nonneg (1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t)]
  exact ha.trans hrem

/-- Quadratic budget for the small compensated parameter. -/
theorem mixed_budget_quadratic (N : ℕ) (a : ℝ) : mixedBudget N a ≤ a ^ 2 := by
  unfold mixedBudget
  calc
    _ ≤ ∑ n ∈ Icc 1 N, a ^ 2 / (2 * (n : ℝ)^2) := sum_le_sum (fun n hn => min_le_right _ _)
    _ = (a ^ 2 / 2) * ∑ n ∈ Icc 1 N, ((n : ℝ)^2)⁻¹ := by
      rw [mul_sum]
      apply sum_congr rfl
      intro n hn
      rw [div_eq_mul_inv, mul_inv_rev]
      ring
    _ ≤ (a ^ 2 / 2) * 2 := mul_le_mul_of_nonneg_left
      (FactorialOriginNeutralization.inverse_square_sum_le_two N) (by positivity)
    _ = _ := by ring

/-- Full harmonic head; no actual history is dropped before selecting a majorant. -/
theorem mixed_budget_head (N : ℕ) (hN : 0 < N) (a : ℝ) (hNa : (N : ℝ) ≤ a) :
    mixedBudget N a ≤ a * (1 + Real.log a) := by
  have ha : 0 ≤ a := (Nat.cast_nonneg N).trans hNa
  have hh := harmonic_le_one_add_log N
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast] at hh
  have hlog := Real.log_le_log (by exact_mod_cast hN : (0 : ℝ) < N) hNa
  unfold mixedBudget
  calc
    _ ≤ ∑ n ∈ Icc 1 N, a / n := sum_le_sum (fun n hn => min_le_left _ _)
    _ = a * ∑ n ∈ Icc 1 N, (n : ℝ)⁻¹ := by simp_rw [div_eq_mul_inv]; rw [mul_sum]
    _ ≤ a * (1 + Real.log (N : ℝ)) := mul_le_mul_of_nonneg_left hh ha
    _ ≤ _ := mul_le_mul_of_nonneg_left (by linarith) ha

/-- Inverse-square tail beyond a positive integer cut, with its exact endpoint. -/
theorem inverse_square_tail_sum (k N : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    (∑ n ∈ Icc (k + 1) N, ((n : ℝ)^2)⁻¹) ≤ (k : ℝ)⁻¹ := by
  have he : Icc (k + 1) N = Ioc k N := by ext n; simp; omega
  rw [he]
  apply (sum_Ioc_inv_sq_le_sub (α := ℝ) hk.ne' hkN).trans
  exact sub_le_self _ (by positivity)

/-- The compensated mixed budget has logarithmic growth in its own parameter. -/
theorem mixed_budget_log (N : ℕ) (a : ℝ) (ha : 0 ≤ a) :
    mixedBudget N a ≤ a * (2 + max 0 (Real.log a)) := by
  by_cases hN : N = 0
  · simp [mixedBudget, hN]
    positivity
  have hNpos : 0 < N := by omega
  by_cases ha1 : a ≤ 1
  · apply (mixed_budget_quadratic N a).trans
    have hl : 0 ≤ max 0 (Real.log a) := le_max_left _ _
    nlinarith
  have ha1' : 1 ≤ a := by linarith
  have hlog : 0 ≤ Real.log a := Real.log_nonneg ha1'
  rw [max_eq_right hlog]
  by_cases hNa : (N : ℝ) ≤ a
  · apply (mixed_budget_head N hNpos a hNa).trans
    nlinarith
  let k := Nat.floor a
  have hk : 0 < k := Nat.floor_pos.mpr ha1'
  have hka : (k : ℝ) ≤ a := Nat.floor_le ha
  have hkN : k ≤ N := by
    have h := Nat.floor_le_of_le (le_of_not_ge hNa)
    exact h
  have hhalf : a ≤ 2 * (k : ℝ) := by
    have hlt := Nat.lt_floor_add_one a
    have hk1 : (1 : ℝ) ≤ k := by exact_mod_cast hk
    change a < (k : ℝ) + 1 at hlt
    linarith
  have hsplit : Icc 1 N = Icc 1 k ∪ Icc (k + 1) N := by
    ext n
    simp only [mem_Icc, mem_union]
    omega
  have hdisj : Disjoint (Icc 1 k) (Icc (k + 1) N) := by
    apply disjoint_left.mpr
    intro n hn hn'
    simp only [mem_Icc] at hn hn'
    omega
  have htail : (∑ n ∈ Icc (k + 1) N, min (a / n) (a^2 / (2 * (n : ℝ)^2))) ≤ a := by
    calc
      _ ≤ ∑ n ∈ Icc (k + 1) N, a^2 / (2 * (n : ℝ)^2) :=
        sum_le_sum (fun n hn => min_le_right _ _)
      _ = (a ^ 2 / 2) * ∑ n ∈ Icc (k + 1) N, ((n : ℝ)^2)⁻¹ := by
        rw [mul_sum]
        apply sum_congr rfl
        intro n hn
        rw [div_eq_mul_inv, mul_inv_rev]
        ring
      _ ≤ (a ^ 2 / 2) * (k : ℝ)⁻¹ := mul_le_mul_of_nonneg_left
        (inverse_square_tail_sum k N hk hkN) (by positivity)
      _ ≤ a := by
        rw [← div_eq_mul_inv]
        apply (div_le_iff₀ (by exact_mod_cast hk : (0 : ℝ) < k)).mpr
        nlinarith
  unfold mixedBudget at *
  rw [hsplit, sum_union hdisj]
  have hh := mixed_budget_head k hk a hka
  unfold mixedBudget at hh
  linarith

/-- Actual response bound on every nonnegative clock, after exact arithmetic compensation. -/
theorem actual_response_log (N : ℕ) (hN : 0 < N) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤
      (N : ℝ) * t * (3 + max 0 (Real.log ((N : ℝ) * t))) := by
  have h := (actual_response_mixed N hN t ht).trans
    (add_le_add_left (mixed_budget_log N ((N : ℝ) * t) (by positivity)) t)
  have hn : (1 : ℝ) ≤ N := by exact_mod_cast hN
  nlinarith

end BuildingBlocks.FactorialCompensatedEnvelope
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.remainder_min
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.actual_response_mixed
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.mixed_budget_quadratic
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.mixed_budget_head
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.inverse_square_tail_sum
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.mixed_budget_log
#print axioms BuildingBlocks.FactorialCompensatedEnvelope.actual_response_log
