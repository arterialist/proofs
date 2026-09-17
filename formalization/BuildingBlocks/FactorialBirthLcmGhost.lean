import BuildingBlocks.FactorialBirthDivisorGhost

open Finset
namespace BuildingBlocks.FactorialBirthLcmGhost
open FactorialBirthDivisorGhost

/-- A complete LCM class inside a fixed divisor horizon. -/
noncomputable def fiber (N k : ℕ) (t : ℝ) : ℝ :=
  ∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
    if Nat.lcm d e = k then arrival d t * arrival e t else 0

theorem divisor_filter (N m : ℕ) (hm : m ∣ N) (hN : 0 < N) :
    N.divisors.filter (fun d => d ∣ m) = m.divisors := by
  have hm0 : m ≠ 0 := by
    intro hz
    subst m
    have hzN : N = 0 := by simpa using hm
    omega
  ext d
  simp only [mem_filter, Nat.mem_divisors]
  constructor
  · intro h
    exact ⟨h.2, hm0⟩
  · intro h
    exact ⟨⟨h.1.trans hm, by omega⟩, h.1⟩

/-- Summing complete LCM classes over divisors retains exactly the complete pair ghost. -/
theorem fiber_divisor_sum (N m : ℕ) (hN : 0 < N) (hm : m ∣ N) (t : ℝ) :
    (∑ k ∈ m.divisors, fiber N k t) = (ghost m t) ^ 2 := by
  have hmpos : 0 < m := Nat.pos_of_dvd_of_pos hm hN
  unfold fiber
  rw [sum_comm]
  calc
    _ = ∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
        if d ∣ m ∧ e ∣ m then arrival d t * arrival e t else 0 := by
      apply sum_congr rfl
      intro d hd
      rw [sum_comm]
      apply sum_congr rfl
      intro e he
      have hlpos : 0 < Nat.lcm d e := Nat.lcm_pos (Nat.pos_of_mem_divisors hd)
        (Nat.pos_of_mem_divisors he)
      simp only [sum_ite_eq, Nat.mem_divisors, Nat.lcm_dvd_iff]
      simp [hmpos.ne']
    _ = ∑ d ∈ m.divisors, ∑ e ∈ m.divisors, arrival d t * arrival e t := by
      rw [← divisor_filter N m hm hN]
      simp only [sum_filter]
      apply sum_congr rfl
      intro d hd
      by_cases hdm : d ∣ m
      · simp [hdm]
      · simp [hdm]
    _ = _ := actual_pair_ghost m hmpos t

/-- Exact LCM-class cancellation, for every complete interior class and every real clock. -/
theorem actual_lcm_ghost (N k : ℕ) (hN : 0 < N) (hk : k ∣ N) (t : ℝ) :
    fiber N k t = ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) * arrival k (2 * t) := by
  have hi := ArithmeticFunction.sum_eq_iff_sum_mul_moebius_eq_on
    (f := fun m => fiber N m t) (g := fun m => (ghost m t) ^ 2)
    {m | m ∣ N} (fun m n hmn hn => hmn.trans hn)
  have hinv := hi.mp (fun m hm hmem => fiber_divisor_sum N m hN hmem t)
  have hkpos : 0 < k := Nat.pos_of_dvd_of_pos hk hN
  have hf := hinv k hkpos hk
  dsimp only at hf
  rw [← hf]
  simp_rw [ghost_double_clock]
  calc
    _ = ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) *
        ∑ x ∈ k.divisorsAntidiagonal,
          (ArithmeticFunction.moebius x.1 : ℝ) * ghost x.2 (2 * t) := by
      rw [mul_sum]
      apply sum_congr rfl
      intro x hx
      ring
    _ = _ := by rw [arrival_inversion k hkpos (2 * t)]

/-- The LCM class in the actual integer rectangle, without dividing into sign sectors. -/
noncomputable def rectangleFiber (N k : ℕ) (t : ℝ) : ℝ :=
  ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
    if Nat.lcm d e = k then arrival d t * arrival e t else 0

/-- Interior LCM classes are complete even in the truncated integer rectangle. -/
theorem rectangle_interior (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) (t : ℝ) :
    rectangleFiber N k t = fiber k k t := by
  have hsub : k.divisors ⊆ Icc 1 N := by
    intro d hd
    exact mem_Icc.mpr ⟨Nat.pos_of_mem_divisors hd,
      (Nat.le_of_dvd hk (Nat.mem_divisors.mp hd).1).trans hkN⟩
  unfold rectangleFiber fiber
  symm
  calc
    _ = ∑ d ∈ k.divisors, ∑ e ∈ Icc 1 N,
        if Nat.lcm d e = k then arrival d t * arrival e t else 0 := by
      apply sum_congr rfl
      intro d hd
      apply sum_subset hsub
      intro e he hnot
      have hne : Nat.lcm d e ≠ k := by
        intro hEq
        apply hnot
        exact Nat.mem_divisors.mpr ⟨hEq ▸ Nat.dvd_lcm_right d e, hk.ne'⟩
      simp [hne]
    _ = _ := by
      apply sum_subset hsub
      intro d hd hnot
      apply sum_eq_zero
      intro e he
      have hne : Nat.lcm d e ≠ k := by
        intro hEq
        apply hnot
        exact Nat.mem_divisors.mpr ⟨hEq ▸ Nat.dvd_lcm_left d e, hk.ne'⟩
      simp [hne]

/-- The actual complete interior class has the doubled-clock birth value. -/
theorem actual_rectangle_ghost (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) (t : ℝ) :
    rectangleFiber N k t =
      ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) * arrival k (2 * t) := by
  rw [rectangle_interior N k hk hkN t]
  exact actual_lcm_ghost k k hk (dvd_refl k) t

/-- All positive arrivals telescope to the original response. -/
theorem arrival_telescoping (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 N, arrival k t) = FactorialBinaryCarry.response N t := by
  induction N with
  | zero => simp [FactorialBinaryCarry.response]
  | succ N ih =>
    rw [sum_Icc_succ_top (by omega : 1 ≤ N + 1), ih]
    simp only [arrival, Nat.succ_ne_zero, if_false, Nat.succ_sub_one]
    unfold FactorialIntegerBirth.birth
    ring

/-- Complete interior LCM cancellation for the actual truncated history. -/
theorem actual_interior_sum (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 N, rectangleFiber N k t) =
      ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) *
        FactorialBinaryCarry.response N (2 * t) := by
  calc
    _ = ∑ k ∈ Icc 1 N,
        ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) * arrival k (2 * t) := by
      apply sum_congr rfl
      intro k hk
      exact actual_rectangle_ghost N k (mem_Icc.mp hk).1 (mem_Icc.mp hk).2 t
    _ = _ := by rw [← mul_sum, arrival_telescoping]

/-- The interior class sum is exactly the interior part of the complete ordered rectangle. -/
theorem interior_pair_sum (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 N, rectangleFiber N k t) =
      ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        if Nat.lcm d e ≤ N then arrival d t * arrival e t else 0 := by
  unfold rectangleFiber
  rw [sum_comm]
  apply sum_congr rfl
  intro d hd
  rw [sum_comm]
  apply sum_congr rfl
  intro e he
  have hl : 1 ≤ Nat.lcm d e := Nat.lcm_pos (mem_Icc.mp hd).1 (mem_Icc.mp he).1
  simp only [sum_ite_eq, mem_Icc]
  simp [hl]

/-- Exact arithmetic boundary identity; every escaping ordered pair is retained with its sign. -/
theorem actual_boundary_decomposition (N : ℕ) (t : ℝ) :
    (FactorialBinaryCarry.response N t) ^ 2 =
      ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) *
        FactorialBinaryCarry.response N (2 * t) +
      ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        if N < Nat.lcm d e then arrival d t * arrival e t else 0 := by
  have hp : (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N, arrival d t * arrival e t) =
      (FactorialBinaryCarry.response N t) ^ 2 := by
    simp_rw [← mul_sum]
    rw [← sum_mul, arrival_telescoping, pow_two]
  rw [← actual_interior_sum N t, interior_pair_sum, ← hp, ← sum_add_distrib]
  apply sum_congr rfl
  intro d hd
  rw [← sum_add_distrib]
  apply sum_congr rfl
  intro e he
  by_cases h : Nat.lcm d e ≤ N
  · simp [h, not_lt.mpr h]
  · simp [h, lt_of_not_ge h]

end BuildingBlocks.FactorialBirthLcmGhost
#print axioms BuildingBlocks.FactorialBirthLcmGhost.divisor_filter
#print axioms BuildingBlocks.FactorialBirthLcmGhost.fiber_divisor_sum
#print axioms BuildingBlocks.FactorialBirthLcmGhost.actual_lcm_ghost

#print axioms BuildingBlocks.FactorialBirthLcmGhost.rectangle_interior
#print axioms BuildingBlocks.FactorialBirthLcmGhost.actual_rectangle_ghost
#print axioms BuildingBlocks.FactorialBirthLcmGhost.arrival_telescoping
#print axioms BuildingBlocks.FactorialBirthLcmGhost.actual_interior_sum

#print axioms BuildingBlocks.FactorialBirthLcmGhost.interior_pair_sum
#print axioms BuildingBlocks.FactorialBirthLcmGhost.actual_boundary_decomposition
