import BuildingBlocks.FactorialBirthLcmGhost
import BuildingBlocks.MertensArithmetic

open Finset
namespace BuildingBlocks.FactorialTerminalReserve

/-- A complete terminal LCM class inside a fixed divisor horizon. -/
noncomputable def terminalFiber (N k : ℕ) : ℤ :=
  ∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
    if Nat.lcm d e = k then ArithmeticFunction.moebius d * ArithmeticFunction.moebius e else 0

/-- Cumulative terminal LCM classes give the square of the complete divisor sum. -/
theorem terminal_fiber_divisor_sum (N m : ℕ) (hN : 0 < N) (hm : m ∣ N) :
    (∑ k ∈ m.divisors, terminalFiber N k) =
      (∑ d ∈ m.divisors, ArithmeticFunction.moebius d) ^ 2 := by
  have hmpos : 0 < m := Nat.pos_of_dvd_of_pos hm hN
  unfold terminalFiber
  rw [sum_comm]
  calc
    _ = ∑ d ∈ N.divisors, ∑ e ∈ N.divisors,
        if d ∣ m ∧ e ∣ m then ArithmeticFunction.moebius d *
          ArithmeticFunction.moebius e else 0 := by
      apply sum_congr rfl
      intro d hd
      rw [sum_comm]
      apply sum_congr rfl
      intro e he
      have hlpos : 0 < Nat.lcm d e := Nat.lcm_pos (Nat.pos_of_mem_divisors hd)
        (Nat.pos_of_mem_divisors he)
      simp only [sum_ite_eq, Nat.mem_divisors, Nat.lcm_dvd_iff]
      simp [hmpos.ne']
    _ = ∑ d ∈ m.divisors, ∑ e ∈ m.divisors,
        ArithmeticFunction.moebius d * ArithmeticFunction.moebius e := by
      rw [← FactorialBirthLcmGhost.divisor_filter N m hm hN]
      simp only [sum_filter]
      apply sum_congr rfl
      intro d hd
      by_cases hdm : d ∣ m
      · simp [hdm]
      · simp [hdm]
    _ = _ := by
      rw [pow_two, sum_mul]
      apply sum_congr rfl
      intro d _
      rw [mul_sum]

/-- Every complete terminal LCM class is the literal Möbius coefficient. -/
theorem terminal_lcm_fiber (N k : ℕ) (hN : 0 < N) (hk : k ∣ N) :
    terminalFiber N k = ArithmeticFunction.moebius k := by
  have hi := ArithmeticFunction.sum_eq_iff_sum_mul_moebius_eq_on
    (f := fun m => terminalFiber N m)
    (g := fun m => (if m = 1 then 1 else 0 : ℤ))
    {m | m ∣ N} (fun m n hmn hn => hmn.trans hn)
  have hc : ∀ m, 0 < m → m ∣ N →
      (∑ d ∈ m.divisors, terminalFiber N d) = (if m = 1 then 1 else 0 : ℤ) := by
    intro m hmpos hmN
    rw [terminal_fiber_divisor_sum N m hN hmN]
    have hs := BuildingBlocks.HyperbolaProduct.moebius_divisor_sum m
    rw [hs]
    split <;> norm_num
  have hinv := hi.mp hc
  have hkpos : 0 < k := Nat.pos_of_dvd_of_pos hk hN
  have hf := hinv k hkpos hk
  dsimp only at hf
  rw [← hf]
  calc
    (∑ x ∈ k.divisorsAntidiagonal,
        ArithmeticFunction.moebius x.1 * if x.2 = 1 then 1 else 0) =
        ∑ d ∈ k.divisors,
          ArithmeticFunction.moebius d * if k / d = 1 then 1 else 0 :=
      Nat.sum_divisorsAntidiagonal (fun d q =>
        ArithmeticFunction.moebius d * if q = 1 then 1 else 0)
    _ = ∑ d ∈ k.divisors,
        if k / d = 1 then ArithmeticFunction.moebius d else 0 := by
      simp only [mul_ite, mul_one, mul_zero]
    _ =
        ∑ d ∈ k.divisors,
          if d = k then ArithmeticFunction.moebius k else 0 := by
      apply sum_congr rfl
      intro d hd
      by_cases he : k / d = 1
      · have hdk := Nat.eq_of_dvd_of_div_eq_one (Nat.mem_divisors.mp hd).1 he
        subst d
        simp [he]
      · have hne : d ≠ k := by
          intro h
          subst d
          exact he (Nat.div_self hkpos)
        simp [he, hne]
    _ = _ := by simp [Nat.mem_divisors, hkpos.ne']

/-- The terminal LCM class in the actual integer rectangle. -/
noncomputable def terminalRectangleFiber (N k : ℕ) : ℤ :=
  ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
    if Nat.lcm d e = k then ArithmeticFunction.moebius d * ArithmeticFunction.moebius e else 0

/-- Every interior terminal class is complete. -/
theorem terminal_rectangle_interior (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    terminalRectangleFiber N k = terminalFiber k k := by
  have hsub : k.divisors ⊆ Icc 1 N := by
    intro d hd
    exact mem_Icc.mpr ⟨Nat.pos_of_mem_divisors hd,
      (Nat.le_of_dvd hk (Nat.mem_divisors.mp hd).1).trans hkN⟩
  unfold terminalRectangleFiber terminalFiber
  symm
  calc
    _ = ∑ d ∈ k.divisors, ∑ e ∈ Icc 1 N,
        if Nat.lcm d e = k then ArithmeticFunction.moebius d *
          ArithmeticFunction.moebius e else 0 := by
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

/-- The complete terminal interior is exactly the Mertens prefix. -/
theorem terminal_interior_sum (N : ℕ) :
    (∑ k ∈ Icc 1 N, terminalRectangleFiber N k) =
      BuildingBlocks.MertensTransfer.mertens N := by
  calc
    _ = ∑ k ∈ Icc 1 N, ArithmeticFunction.moebius k := by
      apply sum_congr rfl
      intro k hk
      rw [terminal_rectangle_interior N k (mem_Icc.mp hk).1 (mem_Icc.mp hk).2,
        terminal_lcm_fiber k k (mem_Icc.mp hk).1 (dvd_refl k)]
    _ = _ := by
      have h := BuildingBlocks.MertensTransfer.mertens_eq_sum_Icc N
      exact_mod_cast h.symm

/-- Every escaping ordered terminal pair is retained with its Möbius sign. -/
noncomputable def terminalBoundary (N : ℕ) : ℤ :=
  ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
    if N < Nat.lcm d e then ArithmeticFunction.moebius d * ArithmeticFunction.moebius e else 0

/-- Exact terminal reserve: full square minus the complete interior Mertens row. -/
theorem terminal_boundary_eq (N : ℕ) :
    terminalBoundary N =
      BuildingBlocks.MertensTransfer.mertens N *
        (BuildingBlocks.MertensTransfer.mertens N - 1) := by
  have hp : (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
      ArithmeticFunction.moebius d * ArithmeticFunction.moebius e) =
      (BuildingBlocks.MertensTransfer.mertens N) ^ 2 := by
    simp_rw [← mul_sum]
    rw [← sum_mul]
    have hm : (∑ d ∈ Icc 1 N, ArithmeticFunction.moebius d) =
        BuildingBlocks.MertensTransfer.mertens N := by
      have h := BuildingBlocks.MertensTransfer.mertens_eq_sum_Icc N
      exact_mod_cast h.symm
    rw [hm, pow_two]
  have hi : (∑ k ∈ Icc 1 N, terminalRectangleFiber N k) =
      ∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        if Nat.lcm d e ≤ N then ArithmeticFunction.moebius d *
          ArithmeticFunction.moebius e else 0 := by
    unfold terminalRectangleFiber
    rw [sum_comm]
    apply sum_congr rfl
    intro d hd
    rw [sum_comm]
    apply sum_congr rfl
    intro e he
    have hl : 1 ≤ Nat.lcm d e := Nat.lcm_pos (mem_Icc.mp hd).1 (mem_Icc.mp he).1
    simp only [sum_ite_eq, mem_Icc]
    simp [hl]
  have hsplit :
      (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        ArithmeticFunction.moebius d * ArithmeticFunction.moebius e) =
      (∑ k ∈ Icc 1 N, terminalRectangleFiber N k) + terminalBoundary N := by
    rw [hi]
    unfold terminalBoundary
    rw [← sum_add_distrib]
    apply sum_congr rfl
    intro d hd
    rw [← sum_add_distrib]
    apply sum_congr rfl
    intro e he
    by_cases h : Nat.lcm d e ≤ N
    · simp [h, not_lt.mpr h]
    · simp [h, lt_of_not_ge h]
  rw [hp, terminal_interior_sum] at hsplit
  calc
    terminalBoundary N = (BuildingBlocks.MertensTransfer.mertens N) ^ 2 -
        BuildingBlocks.MertensTransfer.mertens N := by linarith
    _ = _ := by ring

/-- The integer terminal reserve is always nonnegative. -/
theorem terminal_boundary_nonneg (N : ℕ) : 0 ≤ terminalBoundary N := by
  rw [terminal_boundary_eq]
  by_cases h : BuildingBlocks.MertensTransfer.mertens N ≤ 0
  · exact mul_nonneg_of_nonpos_of_nonpos h (by omega)
  · have h1 : 1 ≤ BuildingBlocks.MertensTransfer.mertens N := by omega
    exact Int.mul_nonneg (by omega) (by omega)

#print axioms terminal_fiber_divisor_sum
#print axioms terminal_lcm_fiber
#print axioms terminal_rectangle_interior
#print axioms terminal_interior_sum
#print axioms terminal_boundary_eq
#print axioms terminal_boundary_nonneg

end BuildingBlocks.FactorialTerminalReserve
