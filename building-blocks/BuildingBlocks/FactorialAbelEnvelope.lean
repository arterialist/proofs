import BuildingBlocks.FactorialReciprocalPrefix
import Mathlib.Algebra.BigOperators.Module

open Finset
namespace BuildingBlocks.FactorialAbelEnvelope
open FactorialReciprocalPrefix

noncomputable def weight (a x : ℝ) : ℝ := x * (1 - Real.exp (-(a / x)))
noncomputable def unrounded (N : ℕ) (a : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * (1 - Real.exp (-(a / n)))

private noncomputable def prefixSum (c : ℕ → ℝ) (N : ℕ) : ℝ := ∑ n ∈ Icc 1 N, c n

private theorem abel_identity (c b : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Icc 1 N, c n * b n) = prefixSum c N * b N -
      ∑ n ∈ Ico 1 N, prefixSum c n * (b (n + 1) - b n) := by
  induction N with
  | zero => simp [prefixSum]
  | succ N ih =>
    by_cases hN : N = 0
    · subst N
      simp [prefixSum]
    · have hn : 1 ≤ N := by omega
      have hp : prefixSum c (N + 1) = prefixSum c N + c (N + 1) := by
        unfold prefixSum
        rw [sum_Icc_succ_top (by omega)]
      rw [sum_Icc_succ_top (by omega), sum_Ico_succ_top hn, hp, ih]
      ring

/-- The unrounded Abel weight has a nonnegative derivative on its exact positive domain. -/
theorem weight_derivative (a x : ℝ) (hx : 0 < x) :
    HasDerivAt (weight a) (1 - (1 + a / x) * Real.exp (-(a / x))) x := by
  have harg : HasDerivAt (fun y : ℝ => -(a / y)) (a / x^2) x := by
    convert ((hasDerivAt_const x a).div (hasDerivAt_id x) hx.ne').neg using 1
    simp only [id_eq]
    ring
  unfold weight
  convert (hasDerivAt_id x).mul ((hasDerivAt_const x (1 : ℝ)).sub harg.exp) using 1
  simp only [id_eq, Pi.sub_apply]
  field_simp
  ring

/-- Arithmetic Abel weights increase with the positive divisor coordinate. -/
theorem weight_monotone (a : ℝ) : MonotoneOn (weight a) (Set.Ioi 0) := by
  have hd := fun x (hx : x ∈ Set.Ioi (0 : ℝ)) => weight_derivative a x hx
  apply monotoneOn_of_hasDerivWithinAt_nonneg (convex_Ioi 0)
  · intro x hx
    exact (hd x hx).continuousAt.continuousWithinAt
  · intro x hx
    exact (hd x (by simpa only [interior_Ioi] using hx)).hasDerivWithinAt
  · intro x hx
    have h := mul_le_mul_of_nonneg_right (Real.add_one_le_exp (a / x))
      (Real.exp_pos (-(a / x))).le
    simp only [← Real.exp_add, add_neg_cancel, Real.exp_zero] at h
    change 0 ≤ 1 - (1 + a / x) * Real.exp (-(a / x))
    linarith

/-- The Abel weight is nonnegative and at most its nonnegative clock parameter. -/
theorem weight_bounds (a x : ℝ) (ha : 0 ≤ a) (hx : 0 < x) :
    0 ≤ weight a x ∧ weight a x ≤ a := by
  have h := FactorialBinaryIntegrability.exponential_increment_bounds (1 : ℝ) (a / x)
    (by norm_num) (by positivity)
  simp only [one_mul, neg_one_mul] at h
  unfold weight
  constructor
  · exact mul_nonneg hx.le h.1
  · have hm := mul_le_mul_of_nonneg_left h.2.2 hx.le
    have he : x * (a / x) = a := by field_simp
    simpa only [he] using hm

/-- Complete unrounded Möbius response, bounded by signed reciprocal prefixes. -/
theorem unrounded_bound (N : ℕ) (a : ℝ) (ha : 0 ≤ a) : |unrounded N a| ≤ 2 * a := by
  rcases Nat.eq_zero_or_pos N with rfl | hN
  · simp [unrounded]
    positivity
  let c : ℕ → ℝ := fun n => (ArithmeticFunction.moebius n : ℝ) / n
  let b : ℕ → ℝ := fun n => weight a n
  have hp : ∀ n, prefixSum c n = reciprocal n := by intro n; rfl
  have he : unrounded N a = ∑ n ∈ Icc 1 N, c n * b n := by
    unfold unrounded
    apply sum_congr rfl
    intro n hn
    have hnR : (0 : ℝ) < n := by exact_mod_cast (mem_Icc.mp hn).1
    dsimp [c, b, weight]
    field_simp
  rw [he, abel_identity, hp]
  have hb : 0 ≤ b N ∧ b N ≤ a := weight_bounds a N ha (by exact_mod_cast hN)
  have hterm : |reciprocal N * b N| ≤ b N := by
    rw [abs_mul, abs_of_nonneg hb.1]
    exact mul_le_mul_of_nonneg_right (reciprocal_abs_le_one N) hb.1 |>.trans_eq (one_mul _)
  have hsum : |∑ n ∈ Ico 1 N, prefixSum c n * (b (n + 1) - b n)| ≤
      b N - b 1 := by
    apply (abs_sum_le_sum_abs _ _).trans
    calc
      _ ≤ ∑ n ∈ Ico 1 N, (b (n + 1) - b n) := by
        apply sum_le_sum
        intro n hn
        have hnpos : (0 : ℝ) < n := by exact_mod_cast (mem_Ico.mp hn).1
        have hspos : (0 : ℝ) < ((n + 1 : ℕ) : ℝ) := by positivity
        have hm : b n ≤ b (n + 1) := by
          apply weight_monotone a hnpos hspos
          norm_cast
          omega
        rw [hp, abs_mul, abs_of_nonneg (sub_nonneg.mpr hm)]
        exact mul_le_mul_of_nonneg_right (reciprocal_abs_le_one n) (sub_nonneg.mpr hm)
          |>.trans_eq (one_mul _)
      _ = _ := sum_Ico_sub (fun n => b n) hN
  have hb1 : 0 ≤ b 1 := by
    simpa only [b, Nat.cast_one] using (weight_bounds a 1 ha (by norm_num)).1
  apply (abs_sub _ _).trans
  linarith

/-- Exponential increments are one-Lipschitz on the nonnegative real clock. -/
theorem increment_lipschitz (x y : ℝ) (hx : 0 ≤ x) (hxy : x ≤ y) :
    |(1 - Real.exp (-y)) - (1 - Real.exp (-x))| ≤ y - x := by
  have hg := FactorialBinaryIntegrability.exponential_increment_bounds (1 : ℝ) (y - x)
    (by norm_num) (sub_nonneg.mpr hxy)
  simp only [one_mul, neg_one_mul] at hg
  have he : Real.exp (-y) = Real.exp (-x) * Real.exp (-(y - x)) := by
    rw [← Real.exp_add]
    congr 1
    ring
  have hp : Real.exp (-x) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
  have hid : (1 - Real.exp (-y)) - (1 - Real.exp (-x)) =
      Real.exp (-x) * (1 - Real.exp (-(y - x))) := by rw [he]; ring
  rw [hid, abs_of_nonneg (mul_nonneg (Real.exp_pos _).le hg.1)]
  apply (mul_le_mul_of_nonneg_right hp hg.1).trans
  simpa only [one_mul] using hg.2.2

/-- Rounded actual quotient histories differ from the unrounded response by at most Nt. -/
theorem rounded_error (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t - unrounded N ((N : ℝ) * t)| ≤ (N : ℝ) * t := by
  unfold FactorialBinaryCarry.response unrounded
  rw [← sum_sub_distrib]
  apply (abs_sum_le_sum_abs _ _).trans
  calc
    _ ≤ ∑ n ∈ Icc 1 N, t := by
      apply sum_le_sum
      intro n hn
      have hf := floor_error_bounds N n (mem_Icc.mp hn).1
      have hq : (((N / n : ℕ) : ℝ) * t) ≤ ((N : ℝ) * t) / n := by
        simpa only [div_mul_eq_mul_div] using
          mul_le_mul_of_nonneg_right (Nat.cast_div_le (m := N) (n := n) (α := ℝ)) ht
      have hl := increment_lipschitz (((N / n : ℕ) : ℝ) * t) (((N : ℝ) * t) / n)
        (by positivity) hq
      have hd : ((N : ℝ) * t) / n - ((N / n : ℕ) : ℝ) * t = floorError N n * t := by
        unfold floorError
        simp only [div_eq_mul_inv]
        ring
      have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
        exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
      rw [← mul_sub, abs_mul]
      have he : |(1 - Real.exp (-((N / n : ℕ) : ℝ) * t)) -
          (1 - Real.exp (-(((N : ℝ) * t) / n)))| ≤ t := by
        rw [abs_sub_comm]
        have hx : -((N / n : ℕ) : ℝ) * t = -(((N / n : ℕ) : ℝ) * t) := by ring
        rw [hx]
        apply hl.trans
        rw [hd]
        nlinarith
      have hnon : 0 ≤ |(1 - Real.exp (-((N / n : ℕ) : ℝ) * t)) -
          (1 - Real.exp (-(((N : ℝ) * t) / n)))| := abs_nonneg _
      nlinarith
    _ = _ := by simp

/-- All-clock actual arithmetic envelope; it uses signed prefix cancellation, not RH decay. -/
theorem actual_response_linear (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤ 3 * (N : ℝ) * t := by
  have he := rounded_error N t ht
  have hu := unrounded_bound N ((N : ℝ) * t) (by positivity)
  have h := abs_add_le (FactorialBinaryCarry.response N t - unrounded N ((N : ℝ) * t))
    (unrounded N ((N : ℝ) * t))
  have hid : FactorialBinaryCarry.response N t - unrounded N ((N : ℝ) * t) +
      unrounded N ((N : ℝ) * t) = FactorialBinaryCarry.response N t := by ring
  rw [hid] at h
  linarith

end BuildingBlocks.FactorialAbelEnvelope
#print axioms BuildingBlocks.FactorialAbelEnvelope.weight_derivative
#print axioms BuildingBlocks.FactorialAbelEnvelope.weight_monotone
#print axioms BuildingBlocks.FactorialAbelEnvelope.weight_bounds
#print axioms BuildingBlocks.FactorialAbelEnvelope.unrounded_bound
#print axioms BuildingBlocks.FactorialAbelEnvelope.increment_lipschitz
#print axioms BuildingBlocks.FactorialAbelEnvelope.rounded_error
#print axioms BuildingBlocks.FactorialAbelEnvelope.actual_response_linear
