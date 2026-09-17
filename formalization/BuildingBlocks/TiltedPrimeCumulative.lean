import BuildingBlocks.PrimeSignedAverage
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Algebra.Order.Floor.Semifield

open Finset
open BuildingBlocks.MertensTransfer BuildingBlocks.CoarsePrimitive BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct
open scoped BigOperators

namespace BuildingBlocks.TiltedPrimeCumulative

/-- The closed cumulative of the actual exponentially tilted prime source. -/
noncomputable def cumulative (x : ℝ) : ℝ :=
  logarithmicPrimeMass ⌊x⌋₊ - psi ⌊x⌋₊ / x - Real.log x

/-- The real-cutoff factorial remainder keeps every actual prime-power weight. -/
theorem factorial_remainder (x : ℝ) :
    x * logarithmicPrimeMass ⌊x⌋₊ - logFactorial ⌊x⌋₊ =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        (x / n - ((⌊x⌋₊ / n : ℕ) : ℝ)) * ArithmeticFunction.vonMangoldt n := by
  rw [logarithmicPrimeMass, Finset.mul_sum, logFactorial_eq_weighted_prime_sum,
    ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n _
  ring

/-- The floor loss at a real cutoff is bounded by the full Chebyshev mass. -/
theorem factorial_remainder_le_psi (x : ℝ) :
    x * logarithmicPrimeMass ⌊x⌋₊ - logFactorial ⌊x⌋₊ ≤ psi ⌊x⌋₊ := by
  rw [factorial_remainder, psi_eq_sum_Icc]
  apply Finset.sum_le_sum
  intro n hn
  have hf := Nat.lt_floor_add_one (x / (n : ℝ))
  rw [Nat.floor_div_natCast] at hf
  have hv : 0 ≤ ArithmeticFunction.vonMangoldt n := ArithmeticFunction.vonMangoldt_nonneg
  nlinarith [mul_le_mul_of_nonneg_right
    (show x / (n : ℝ) - ((⌊x⌋₊ / n : ℕ) : ℝ) ≤ 1 by linarith) hv]

/-- The factorial bound applies on whole noninteger cells. -/
theorem cumulative_le_factorial {x : ℝ} (hx : 0 < x) :
    cumulative x ≤ logFactorial ⌊x⌋₊ / x - Real.log x := by
  have h := factorial_remainder_le_psi x
  unfold cumulative
  apply (mul_le_mul_iff_right₀ hx).mp
  field_simp
  nlinarith

private theorem logFactorial_lt_mul_log_real {x : ℝ} (hx : 1 < x) :
    logFactorial ⌊x⌋₊ < x * Real.log x := by
  have hN : 1 ≤ ⌊x⌋₊ := (Nat.one_le_floor_iff x).mpr hx.le
  have hfloor : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le (by linarith)
  have hlog : 0 < Real.log x := Real.log_pos hx
  have hs : logFactorial ⌊x⌋₊ < (⌊x⌋₊ : ℝ) * Real.log x := by
    unfold logFactorial
    calc
      (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, Real.log (n : ℝ)) <
          ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, Real.log x := by
        apply Finset.sum_lt_sum
        · intro n hn
          have hn1 : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
          have hnN : (n : ℝ) ≤ ⌊x⌋₊ := by exact_mod_cast (Finset.mem_Icc.mp hn).2
          exact Real.log_le_log hn1 (hnN.trans hfloor)
        · exact ⟨1, Finset.mem_Icc.mpr ⟨le_rfl, hN⟩, by simpa using hlog⟩
      _ = (⌊x⌋₊ : ℝ) * Real.log x := by simp
  exact hs.trans_le (mul_le_mul_of_nonneg_right hfloor hlog.le)

/-- The actual real-cutoff tilted cumulative is strictly negative past 1. -/
theorem cumulative_neg {x : ℝ} (hx : 1 < x) : cumulative x < 0 := by
  have hx0 : 0 < x := by linarith
  have hF := logFactorial_lt_mul_log_real hx
  have hdiv : logFactorial ⌊x⌋₊ / x < Real.log x := (div_lt_iff₀ hx0).mpr (by simpa [mul_comm] using hF)
  have h := cumulative_le_factorial hx0
  linarith


/-- An exact nonnegative-remainder representation, valid between integers as well. -/
theorem cumulative_factorial_identity {x : ℝ} (hx : 0 < x) :
    -x * cumulative x = x * Real.log x - logFactorial ⌊x⌋₊ +
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
        (1 - (x / n - ((⌊x⌋₊ / n : ℕ) : ℝ))) *
          ArithmeticFunction.vonMangoldt n := by
  have hs : (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      (1 - (x / n - ((⌊x⌋₊ / n : ℕ) : ℝ))) *
        ArithmeticFunction.vonMangoldt n) =
      psi ⌊x⌋₊ - (x * logarithmicPrimeMass ⌊x⌋₊ - logFactorial ⌊x⌋₊) := by
    rw [factorial_remainder, psi_eq_sum_Icc, ← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro n _
    ring
  rw [hs]
  unfold cumulative
  field_simp
  ring

/-- Each actual prime-power term of the factorial remainder is nonnegative. -/
theorem factorial_identity_term_nonneg (x : ℝ) (n : ℕ) :
    0 ≤ (1 - (x / n - ((⌊x⌋₊ / n : ℕ) : ℝ))) *
      ArithmeticFunction.vonMangoldt n := by
  have hf := Nat.lt_floor_add_one (x / (n : ℝ))
  rw [Nat.floor_div_natCast] at hf
  exact mul_nonneg (by linarith) ArithmeticFunction.vonMangoldt_nonneg

private theorem logFactorial_uniform_gap {N : ℕ} (hN : 2 ≤ N) :
    logFactorial N ≤ (N : ℝ) * (Real.log N - Real.log 2 / 2) := by
  have hlog2pos : 0 < Real.log (2 : ℝ) := Real.log_pos (by norm_num)
  have hlog2lt : Real.log (2 : ℝ) < 3 / 4 := by
    have h := Real.log_two_lt_d9
    linarith
  by_cases h2 : N = 2
  · subst N
    norm_num [logFactorial, Finset.sum_Icc_succ_top]
    ring_nf
    exact le_rfl
  by_cases h3 : N = 3
  · subst N
    have h23 := Real.log_le_log (by norm_num : (0 : ℝ) < 8) (by norm_num : (8 : ℝ) ≤ 9)
    have he8 : Real.log (8 : ℝ) = 3 * Real.log 2 := by
      convert Real.log_pow (2 : ℝ) 3 using 1 <;> norm_num
    have he9 : Real.log (9 : ℝ) = 2 * Real.log 3 := by
      convert Real.log_pow (3 : ℝ) 2 using 1 <;> norm_num
    rw [he8, he9] at h23
    norm_num [logFactorial, Finset.sum_Icc_succ_top]
    nlinarith
  have h4 : (4 : ℝ) ≤ N := by exact_mod_cast (show 4 ≤ N by omega)
  have hn0 : (0 : ℝ) < N := by linarith
  have hquot := Real.log_le_sub_one_of_pos (show (0 : ℝ) < N / 4 by positivity)
  rw [Real.log_div (ne_of_gt hn0) (by norm_num)] at hquot
  have he4 : Real.log (4 : ℝ) = 2 * Real.log 2 := by
    convert Real.log_pow (2 : ℝ) 2 using 1 <;> norm_num
  rw [he4] at hquot
  have hi := (logFactorial_integral_bounds (show 1 ≤ N by omega)).2
  have hm := mul_nonneg (show (0 : ℝ) ≤ N - 4 by linarith)
    (show 0 ≤ 3 / 4 - Real.log 2 / 2 by linarith)
  nlinarith

/-- A uniform signed bound after the first actual prime cutoff. -/
theorem cumulative_le_neg_log_two_half {x : ℝ} (hx : 2 ≤ x) :
    cumulative x ≤ -Real.log 2 / 2 := by
  have hx0 : 0 < x := by linarith
  have hN : 2 ≤ ⌊x⌋₊ := (Nat.le_floor_iff hx0.le).mpr (by exact_mod_cast hx)
  have hn0 : (0 : ℝ) < ⌊x⌋₊ := by exact_mod_cast (show 0 < ⌊x⌋₊ by omega)
  have hfloor : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le hx0.le
  have hlogN : Real.log (2 : ℝ) ≤ Real.log (⌊x⌋₊ : ℝ) :=
    Real.log_le_log (by norm_num) (by exact_mod_cast hN)
  have hlogX : Real.log (⌊x⌋₊ : ℝ) ≤ Real.log x := Real.log_le_log hn0 hfloor
  have hlog2 : 0 ≤ Real.log (2 : ℝ) := Real.log_nonneg (by norm_num)
  have hF := logFactorial_uniform_gap hN
  have hm := mul_le_mul_of_nonneg_right hfloor
    (show 0 ≤ Real.log (⌊x⌋₊ : ℝ) - Real.log 2 / 2 by linarith)
  have hm2 := mul_le_mul_of_nonneg_left hlogX hx0.le
  have hbound : logFactorial ⌊x⌋₊ / x ≤ Real.log x - Real.log 2 / 2 := by
    apply (div_le_iff₀ hx0).mpr
    nlinarith
  have h := cumulative_le_factorial hx0
  linarith

#print axioms cumulative_neg
#print axioms cumulative_factorial_identity
#print axioms cumulative_le_neg_log_two_half


end BuildingBlocks.TiltedPrimeCumulative
