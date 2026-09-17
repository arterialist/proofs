import BuildingBlocks.FactorialKernelDictionary
import Mathlib.Order.Interval.Finset.Nat

open Finset
namespace BuildingBlocks.FactorialIntegerBirth

/-- The literal change under ordinary additive succession. -/
noncomputable def birth (N : ℕ) (t : ℝ) : ℝ :=
  FactorialBinaryCarry.response (N + 1) t - FactorialBinaryCarry.response N t

/-- Complete support may include all histories whose quotient is zero. -/
theorem response_extended (N Y : ℕ) (hNY : N ≤ Y) (t : ℝ) :
    FactorialBinaryCarry.response N t =
      ∑ d ∈ Icc 1 Y, (ArithmeticFunction.moebius d : ℝ) *
        (1 - Real.exp (-((N / d : ℕ) : ℝ) * t)) := by
  unfold FactorialBinaryCarry.response
  apply sum_subset
  · intro d hd
    exact mem_Icc.mpr ⟨(mem_Icc.mp hd).1, (mem_Icc.mp hd).2.trans hNY⟩
  · intro d hd hnot
    have hlarge : N < d := by simp only [mem_Icc] at hd hnot; omega
    simp [Nat.div_eq_of_lt hlarge]

/-- A quotient changes exactly at a divisor arrival, including the terminal divisor. -/
theorem quotient_increment (N d : ℕ) (t : ℝ) :
    (1 - Real.exp (-(((N + 1) / d : ℕ) : ℝ) * t)) -
      (1 - Real.exp (-((N / d : ℕ) : ℝ) * t)) =
      if d ∣ N + 1 then
        (1 - Real.exp (-t)) * Real.exp (-((N / d : ℕ) : ℝ) * t) else 0 := by
  have he : (N + 1) / d = N / d + (if d ∣ N + 1 then 1 else 0) := Nat.succ_div
  by_cases hd : d ∣ N + 1
  · rw [he]
    simp only [hd, if_true, Nat.cast_add, Nat.cast_one]
    have hx : -(((N / d : ℕ) : ℝ) + 1) * t =
        -((N / d : ℕ) : ℝ) * t + -t := by ring
    rw [hx, Real.exp_add]
    ring
  · simp [he, hd]

/-- Exact full-history birth formula on the common support, for every real clock. -/
theorem actual_birth (N : ℕ) (t : ℝ) :
    birth N t = (1 - Real.exp (-t)) *
      ∑ d ∈ Icc 1 (N + 1),
        if d ∣ N + 1 then
          (ArithmeticFunction.moebius d : ℝ) * Real.exp (-((N / d : ℕ) : ℝ) * t)
        else 0 := by
  unfold birth
  rw [response_extended (N + 1) (N + 1) le_rfl t,
    response_extended N (N + 1) (by omega) t, ← sum_sub_distrib]
  rw [mul_sum]
  apply sum_congr rfl
  intro d hd
  rw [← mul_sub, quotient_increment]
  by_cases h : d ∣ N + 1
  · simp only [h, if_true]
    ring
  · simp [h]

/-- The complete arrival support is exactly the positive divisors. -/
theorem arrival_support (N : ℕ) :
    (Icc 1 (N + 1)).filter (fun d => d ∣ N + 1) = (N + 1).divisors := by
  ext d
  simp only [mem_filter, mem_Icc, Nat.mem_divisors]
  constructor
  · intro h
    exact ⟨h.2, by omega⟩
  · intro h
    exact ⟨⟨Nat.one_le_iff_ne_zero.mpr (by
      intro hz
      subst d
      simpa using h.1), Nat.le_of_dvd (by omega) h.1⟩, h.1⟩

/-- The actual birth as a divisor sum; the exponent keeps its literal old quotient. -/
theorem actual_birth_divisors (N : ℕ) (t : ℝ) :
    birth N t = (1 - Real.exp (-t)) *
      ∑ d ∈ (N + 1).divisors,
        (ArithmeticFunction.moebius d : ℝ) * Real.exp (-((N / d : ℕ) : ℝ) * t) := by
  rw [actual_birth, ← arrival_support, sum_filter]

/-- Accumulated additive births recover the original response without a remainder. -/
theorem birth_telescoping (N : ℕ) (t : ℝ) :
    (∑ n ∈ range N, birth n t) = FactorialBinaryCarry.response N t := by
  induction N with
  | zero => simp [FactorialBinaryCarry.response]
  | succ N ih => rw [sum_range_succ, ih]; unfold birth; ring

/-- Exact signed work identity before taking absolute values or integrating. -/
theorem signed_work_telescoping (N : ℕ) (t : ℝ) :
    2 * (∑ n ∈ range N, FactorialBinaryCarry.response n t * birth n t) =
      (FactorialBinaryCarry.response N t) ^ 2 - ∑ n ∈ range N, (birth n t) ^ 2 := by
  induction N with
  | zero => simp [FactorialBinaryCarry.response]
  | succ N ih =>
    rw [sum_range_succ, sum_range_succ]
    have he : FactorialBinaryCarry.response (N + 1) t =
        FactorialBinaryCarry.response N t + birth N t := by unfold birth; ring
    rw [he]
    nlinarith

end BuildingBlocks.FactorialIntegerBirth
#print axioms BuildingBlocks.FactorialIntegerBirth.response_extended
#print axioms BuildingBlocks.FactorialIntegerBirth.quotient_increment
#print axioms BuildingBlocks.FactorialIntegerBirth.actual_birth

#print axioms BuildingBlocks.FactorialIntegerBirth.arrival_support
#print axioms BuildingBlocks.FactorialIntegerBirth.actual_birth_divisors
#print axioms BuildingBlocks.FactorialIntegerBirth.birth_telescoping
#print axioms BuildingBlocks.FactorialIntegerBirth.signed_work_telescoping
