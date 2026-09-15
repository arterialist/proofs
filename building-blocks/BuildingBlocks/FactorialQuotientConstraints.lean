import BuildingBlocks.FactorialBinaryCarry

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

#print axioms quotient_commute
#print axioms quotient_mass
#print axioms quotient_mass_above
#print axioms quotient_mass_real
#print axioms grouped_quotient_mass

end BuildingBlocks.FactorialQuotientConstraints
