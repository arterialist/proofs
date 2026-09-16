import BuildingBlocks.FixedProfileGreenAdmissionFinite

namespace BuildingBlocks.MovingCeilingFiniteAlgebra

open Finset
open scoped BigOperators ArithmeticFunction.Moebius
open FixedProfileGreenAdmissionFinite

/-- Integer moving ceiling used by the actual tail `d*n ≥ j`. -/
def movingCeil (j d : ℕ) : ℕ := if j = 0 then 0 else (j - 1) / d + 1

/-- The ceiling is not an approximation: for positive dilation it is exactly
the multiplicative activation condition. -/
theorem movingCeil_le_iff {j d n : ℕ} (hd : 0 < d) :
    movingCeil j d ≤ n ↔ j ≤ d * n := by
  unfold movingCeil
  split_ifs with hj
  · subst j
    simp
  · constructor
    · intro h
      have hdiv : (j - 1) / d < n := by omega
      have hlt : j - 1 < n * d := (Nat.div_lt_iff_lt_mul hd).mp hdiv
      have hlt' : j - 1 < d * n := by simpa [Nat.mul_comm] using hlt
      omega
    · intro h
      have hn : 0 < n := by
        by_contra hn0
        have : n = 0 := Nat.eq_zero_of_not_pos hn0
        subst n
        simp at h
        exact hj h
      have hlt : j - 1 < n * d := by
        rw [Nat.mul_comm]
        omega
      have hdiv : (j - 1) / d < n := (Nat.div_lt_iff_lt_mul hd).mpr hlt
      omega

/-- Equality of the two literal finite tail filters. -/
theorem movingCeil_filter_eq (j d R : ℕ) (hd : 0 < d) :
    (Finset.Icc 1 R).filter (fun n => movingCeil j d ≤ n) =
      (Finset.Icc 1 R).filter (fun n => j ≤ d * n) := by
  ext n
  simp only [Finset.mem_filter, movingCeil_le_iff hd]

/-- Changing a closed moving endpoint to an open endpoint changes a finite
row by exactly its single boundary value. -/
theorem closed_tail_eq_boundary_add_open
    (f : ℕ → ℝ) {b R : ℕ} (hb : b ≤ R) :
    (∑ n ∈ Finset.Icc b R, f n) = f b + ∑ n ∈ Finset.Ioc b R, f n := by
  have heq : Finset.Icc b R = insert b (Finset.Ioc b R) := by
    ext n
    simp only [Finset.mem_Icc, Finset.mem_insert, Finset.mem_Ioc]
    omega
  rw [heq, Finset.sum_insert (by simp)]

/-- Complete signed Möbius boundary packet. -/
def boundaryPacket (N : ℕ) (active : ℕ → Bool) (w : ℕ → ℝ) : ℝ :=
  ∑ d ∈ N.divisors, μR d * if active d then w d else 0

/-- Absolute endpoint control retains every Möbius face and assumes no signed
cancellation. -/
theorem abs_boundaryPacket_le (N : ℕ) (active : ℕ → Bool) (w : ℕ → ℝ) :
    |boundaryPacket N active w| ≤
      ∑ d ∈ N.divisors, if active d then |w d| else 0 := by
  unfold boundaryPacket
  calc
    |∑ d ∈ N.divisors, μR d * if active d then w d else 0| ≤
        ∑ d ∈ N.divisors, |μR d * if active d then w d else 0| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ d ∈ N.divisors, if active d then |w d| else 0 := by
      apply Finset.sum_le_sum
      intro d hd
      split <;> simp_all [μR]
      have hm := ArithmeticFunction.abs_moebius_le_one (n := d)
      have hmR : |(ArithmeticFunction.moebius d : ℝ)| ≤ 1 := by exact_mod_cast hm
      exact (mul_le_mul_of_nonneg_right hmR (abs_nonneg _)).trans_eq (one_mul _)

#print axioms movingCeil_le_iff
#print axioms movingCeil_filter_eq
#print axioms closed_tail_eq_boundary_add_open
#print axioms abs_boundaryPacket_le

end BuildingBlocks.MovingCeilingFiniteAlgebra
