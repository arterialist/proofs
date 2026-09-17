import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Tactic

namespace BuildingBlocks.OddDoublingFiniteMobius

open Finset
open scoped ArithmeticFunction.Moebius

noncomputable section

/-- Actual Mathlib Möbius coefficients pair with the opposite sign under
odd doubling. -/
theorem moebius_two_mul_of_odd {m : ℕ} (hm : Odd m) :
    ArithmeticFunction.moebius (2 * m) = -ArithmeticFunction.moebius m := by
  rw [ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime
    (Nat.coprime_two_left.mpr hm), ArithmeticFunction.moebius_apply_prime Nat.prime_two]
  ring

/-- Multiples of four have zero actual Möbius coefficient. -/
theorem moebius_four_mul (k : ℕ) : ArithmeticFunction.moebius (4 * k) = 0 := by
  apply ArithmeticFunction.moebius_eq_zero_of_not_squarefree
  intro hs
  exact (Nat.squarefree_iff_prime_squarefree.mp hs 2 Nat.prime_two) ⟨k, by ring⟩

/-- Complete coefficient pairing for doubling, including nonsquarefree even
indices. -/
theorem moebius_two_mul (m : ℕ) :
    ArithmeticFunction.moebius (2 * m) =
      if Odd m then -ArithmeticFunction.moebius m else 0 := by
  by_cases hm : Odd m
  · simp [hm, moebius_two_mul_of_odd hm]
  · have he : Even m := Nat.not_odd_iff_even.mp hm
    obtain ⟨k, rfl⟩ := he
    rw [if_neg (Nat.not_odd_iff_even.mpr ⟨k, rfl⟩)]
    convert moebius_four_mul k using 1 <;> ring

/-- Finite Mertens prefix using the actual Mathlib Möbius function. -/
def mertensPrefix (N : ℕ) : ℤ :=
  ∑ n ∈ Icc 1 N, ArithmeticFunction.moebius n

/-- The closed-upper, strict-lower odd annulus from the doubling identity. -/
def oddAnnulus (N : ℕ) : ℤ :=
  ∑ m ∈ Icc (N / 2 + 1) N, if Odd m then ArithmeticFunction.moebius m else 0

/-- Splitting a finite prefix into odd indices and doubled indices. -/
theorem mertens_even_odd_split (N : ℕ) :
    mertensPrefix N =
      (∑ m ∈ Icc 1 N, if Odd m then ArithmeticFunction.moebius m else 0) +
      ∑ m ∈ Icc 1 (N / 2), ArithmeticFunction.moebius (2 * m) := by
  unfold mertensPrefix
  have heven : (∑ n ∈ Icc 1 N, if Even n then ArithmeticFunction.moebius n else 0) =
      ∑ m ∈ Icc 1 (N / 2), ArithmeticFunction.moebius (2 * m) := by
    classical
    rw [← sum_filter]
    refine (Finset.sum_bij (fun m _ => m + m) ?_ ?_ ?_ ?_).symm
    · intro m hm
      simp only [mem_filter, mem_Icc] at hm ⊢
      constructor
      · omega
      · exact ⟨m, rfl⟩
    · intro a ha b hb hab
      change a + a = b + b at hab
      omega
    · intro n hn
      simp only [mem_filter, mem_Icc] at hn
      obtain ⟨m, rfl⟩ := hn.2
      refine ⟨m, ?_, rfl⟩
      simp only [mem_Icc]
      constructor <;> omega
    · intro m hm
      simp [two_mul]
  rw [← heven, ← sum_add_distrib]
  apply sum_congr rfl
  intro n hn
  by_cases ho : Odd n
  · have hne : ¬Even n := Nat.not_even_iff_odd.mpr ho
    simp [ho, hne]
  · have he : Even n := Nat.not_odd_iff_even.mp ho
    simp [ho, he]

/-- Exact finite prefix/annulus identity. The lower endpoint is strict and
is represented by `N / 2 + 1`; the upper endpoint is closed. -/
theorem mertensPrefix_eq_oddAnnulus (N : ℕ) :
    mertensPrefix N = oddAnnulus N := by
  rw [mertens_even_odd_split]
  simp_rw [moebius_two_mul]
  unfold oddAnnulus
  rw [show (∑ m ∈ Icc 1 (N / 2), if Odd m then -ArithmeticFunction.moebius m else 0) =
      -(∑ m ∈ Icc 1 (N / 2), if Odd m then ArithmeticFunction.moebius m else 0) by
    rw [← sum_neg_distrib]
    apply sum_congr rfl
    intro m hm
    split_ifs <;> ring]
  have hsplit : (∑ m ∈ Icc 1 N, if Odd m then ArithmeticFunction.moebius m else 0) =
      (∑ m ∈ Icc 1 (N / 2), if Odd m then ArithmeticFunction.moebius m else 0) +
      ∑ m ∈ Icc (N / 2 + 1) N, if Odd m then ArithmeticFunction.moebius m else 0 := by
    simpa only [← Ico_add_one_right_eq_Icc] using
      (sum_Ico_consecutive (f := fun m => if Odd m then ArithmeticFunction.moebius m else 0)
        (show 1 ≤ N / 2 + 1 by omega) (show N / 2 + 1 ≤ N + 1 by omega)).symm
  rw [hsplit]
  ring

/-- The interval polynomial is a genuine finite geometric block. This avoids
division by `1-z` and is valid in every commutative ring. -/
theorem geometric_block {R : Type*} [CommRing R] (z : R) (m : ℕ) :
    (1 - z) * ∑ j ∈ range m, z ^ (m + j) = z ^ m - z ^ (2 * m) := by
  have hg := geom_sum_mul_neg z m
  have hp : z ^ (2 * m) = z ^ m * z ^ m := by
    rw [show 2 * m = m + m by omega, pow_add]
  have hsum : (∑ j ∈ range m, z ^ (m + j)) =
      z ^ m * ∑ j ∈ range m, z ^ j := by
    rw [mul_sum]
    apply sum_congr rfl
    intro j hj
    rw [pow_add]
  rw [hsum]
  calc
    (1 - z) * (z ^ m * ∑ j ∈ range m, z ^ j) =
        z ^ m * ((∑ j ∈ range m, z ^ j) * (1 - z)) := by ring
    _ = z ^ m * (1 - z ^ m) := by rw [hg]
    _ = z ^ m - z ^ (2 * m) := by rw [hp]; ring

/-- Equivalent interval notation, with both endpoints explicit. -/
theorem geometric_block_Ico {R : Type*} [CommRing R] (z : R) (m : ℕ) :
    (1 - z) * ∑ N ∈ Ico m (2 * m), z ^ N = z ^ m - z ^ (2 * m) := by
  rw [show (∑ N ∈ Ico m (2 * m), z ^ N) = ∑ j ∈ range m, z ^ (m + j) by
    rw [Finset.sum_Ico_eq_sum_range]
    simp only [two_mul, Nat.add_sub_cancel_left]]
  exact geometric_block z m

#print axioms moebius_two_mul_of_odd
#print axioms moebius_four_mul
#print axioms moebius_two_mul
#print axioms mertens_even_odd_split
#print axioms mertensPrefix_eq_oddAnnulus
#print axioms geometric_block
#print axioms geometric_block_Ico

end
end BuildingBlocks.OddDoublingFiniteMobius
