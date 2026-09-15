import BuildingBlocks.FactorialBinaryCarry
import Mathlib.Data.Finset.Max

open Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialQuotientConstraints

/-- Nested integer quotient histories commute, including zero divisors. -/
theorem quotient_commute (N n k : ℕ) : N / n / k = N / k / n := by
  simp only [Nat.div_div_eq_div_mul, Nat.mul_comm n k]

/-- The entire quotient-constraint family for the actual Möbius vector. -/
theorem quotient_mass (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    (∑ n ∈ Icc 1 N, ArithmeticFunction.moebius n *
      ((N / n / k : ℕ) : ℤ)) = 1 := by
  simp_rw [quotient_commute N]
  rw [BuildingBlocks.FactorialBinaryCarry.floor_mass_extend (N / k) N
    (Nat.div_le_self N k)]
  exact BuildingBlocks.MertensTransfer.moebius_floor_mass
    ((Nat.one_le_div_iff hk).mpr hkN)

/-- Constraints beyond the cutoff vanish; no terminal quotient is discarded. -/
theorem quotient_mass_above (N k : ℕ) (hNk : N < k) :
    (∑ n ∈ Icc 1 N, ArithmeticFunction.moebius n *
      ((N / n / k : ℕ) : ℤ)) = 0 := by
  simp_rw [quotient_commute N, Nat.div_eq_of_lt hNk]
  simp

/-- The same complete family in the real coefficient field of the energy. -/
theorem quotient_mass_real (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    (∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      ((N / n / k : ℕ) : ℝ)) = 1 := by
  have h := congrArg (fun z : ℤ => (z : ℝ)) (quotient_mass N k hk hkN)
  simpa only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] using h

/-- The grouped coefficient is the actual sum over a quotient fiber. -/
noncomputable def groupedMass (N q : ℕ) : ℤ :=
  ∑ n ∈ (Icc 1 N).filter (fun n => N / n = q), ArithmeticFunction.moebius n

/-- Grouping preserves every constraint, with exactly the occurring quotients. -/
theorem grouped_quotient_mass (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    (∑ q ∈ (Icc 1 N).image (fun n => N / n),
      groupedMass N q * ((q / k : ℕ) : ℤ)) = 1 := by
  classical
  have hgroup := Finset.sum_fiberwise_of_maps_to
    (fun n hn => Finset.mem_image.mpr ⟨n, hn, rfl⟩ :
      ∀ n ∈ Icc 1 N, N / n ∈ (Icc 1 N).image (fun n => N / n))
    (fun n => ArithmeticFunction.moebius n * ((N / n / k : ℕ) : ℤ))
  calc
    _ = ∑ q ∈ (Icc 1 N).image (fun n => N / n),
        ∑ n ∈ (Icc 1 N).filter (fun n => N / n = q),
          ArithmeticFunction.moebius n * ((N / n / k : ℕ) : ℤ) := by
      apply Finset.sum_congr rfl
      intro q _
      unfold groupedMass
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro n hn
      rw [(Finset.mem_filter.mp hn).2]
    _ = _ := hgroup
    _ = 1 := quotient_mass N k hk hkN

/-- The quotient transform has trivial kernel on any finite positive support. -/
theorem quotient_kernel_zero (s : Finset ℕ) :
    ∀ (c : ℕ → ℝ), (∀ q ∈ s, 0 < q) →
      (∀ k ∈ s, (∑ q ∈ s, c q * ((q / k : ℕ) : ℝ)) = 0) →
      ∀ q ∈ s, c q = 0 := by
  classical
  induction s using Finset.induction_on_max with
  | h0 => simp
  | @step a s hmax ih =>
    have ha : a ∉ s := by
      intro h
      have hlt := hmax a h
      omega
    intro c hpos hmass
    have ha0 := hpos a (Finset.mem_insert_self a s)
    have hca : c a = 0 := by
      have h := hmass a (Finset.mem_insert_self a s)
      rw [Finset.sum_insert ha] at h
      have hz : (∑ q ∈ s, c q * ((q / a : ℕ) : ℝ)) = 0 := by
        apply Finset.sum_eq_zero
        intro q hq
        simp [Nat.div_eq_of_lt (hmax q hq)]
      simpa [hz, Nat.div_self ha0] using h
    have hs : ∀ q ∈ s, c q = 0 := by
      apply ih c
      · intro q hq
        exact hpos q (Finset.mem_insert_of_mem hq)
      · intro k hk
        have h := hmass k (Finset.mem_insert_of_mem hk)
        simpa [Finset.sum_insert ha, hca] using h
    intro q hq
    rcases Finset.mem_insert.mp hq with rfl | hq
    · exact hca
    · exact hs q hq

/-- All quotient rows together determine every coefficient on the support. -/
theorem quotient_transform_injective (s : Finset ℕ) (A B : ℕ → ℝ)
    (hpos : ∀ q ∈ s, 0 < q)
    (hrows : ∀ k ∈ s,
      (∑ q ∈ s, A q * ((q / k : ℕ) : ℝ)) =
      ∑ q ∈ s, B q * ((q / k : ℕ) : ℝ)) :
    ∀ q ∈ s, A q = B q := by
  have hz := quotient_kernel_zero s (fun q => A q - B q) hpos
    (by intro k hk; simp_rw [sub_mul]; rw [Finset.sum_sub_distrib, hrows k hk]; simp)
  intro q hq
  exact sub_eq_zero.mp (hz q hq)

/-- Any real vector satisfying all rows is the actual grouped Möbius vector. -/
theorem actual_grouped_unique (N : ℕ) (A : ℕ → ℝ)
    (hrows : ∀ k, 0 < k → k ≤ N →
      (∑ q ∈ (Icc 1 N).image (fun n => N / n),
        A q * ((q / k : ℕ) : ℝ)) = 1) :
    ∀ q ∈ (Icc 1 N).image (fun n => N / n),
      A q = (groupedMass N q : ℝ) := by
  classical
  have hb : ∀ q ∈ (Icc 1 N).image (fun n => N / n), 0 < q ∧ q ≤ N := by
    intro q hq
    rcases Finset.mem_image.mp hq with ⟨n, hn, rfl⟩
    have hn0 : 0 < n := (Finset.mem_Icc.mp hn).1
    exact ⟨(Nat.one_le_div_iff hn0).mpr (Finset.mem_Icc.mp hn).2,
      Nat.div_le_self N n⟩
  apply quotient_transform_injective _ A (fun q => (groupedMass N q : ℝ))
    (fun q hq => (hb q hq).1)
  intro k hk
  rw [hrows k (hb k hk).1 (hb k hk).2]
  have h := congrArg (fun z : ℤ => (z : ℝ))
    (grouped_quotient_mass N k (hb k hk).1 (hb k hk).2)
  symm
  simpa only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] using h

#print axioms actual_grouped_unique
#print axioms quotient_kernel_zero
#print axioms quotient_transform_injective
#print axioms quotient_commute
#print axioms quotient_mass
#print axioms quotient_mass_above
#print axioms quotient_mass_real
#print axioms grouped_quotient_mass

end BuildingBlocks.FactorialQuotientConstraints
