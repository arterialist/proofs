import BuildingBlocks.FactorialFiniteRenewal

open Finset
namespace BuildingBlocks.FactorialBinaryCarry

/-- Extending complete quotient renewal retains zero quotient histories. -/
theorem quotient_response_sum_extend (N R : ℕ) (hNR : N ≤ R) (t : ℝ) :
    (∑ k ∈ Icc 1 R, response (N / k) t) = 1 - Real.exp (-(N : ℝ) * t) := by
  rw [← FactorialFiniteRenewal.response_renewal N t]
  symm
  apply Finset.sum_subset
  · intro k hk
    exact mem_Icc.mpr ⟨(mem_Icc.mp hk).1, (mem_Icc.mp hk).2.trans hNR⟩
  · intro k hk hnot
    have hkN : N < k := by
      have hk1 := (mem_Icc.mp hk).1
      simp only [mem_Icc] at hnot
      omega
    simp [Nat.div_eq_of_lt hkN, response]

/-- Complete paired quotient responses cancel, with every terminal history retained. -/
theorem paired_quotient_response_sum_zero (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 (2 * N), (response ((2 * N) / k) t - response (N / k) (2 * t))) = 0 := by
  rw [Finset.sum_sub_distrib, FactorialFiniteRenewal.response_renewal,
    quotient_response_sum_extend N (2 * N) (by omega)]
  simp only [Nat.cast_mul, Nat.cast_ofNat]
  rw [show -(2 * (N : ℝ)) * t = -(N : ℝ) * (2 * t) by ring]
  ring

/-- The complete actual carry innovations have zero paired quotient sum. -/
theorem paired_quotient_innovation_sum_zero (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 (2 * N), innovation (N / k) (carry N 0 k) t) = 0 := by
  have he : ∀ k ∈ Icc 1 (2 * N), innovation (N / k) (carry N 0 k) t =
      response ((2 * N) / k) t - response (N / k) (2 * t) := by
    intro k hk
    have hk0 : 0 < k := (mem_Icc.mp hk).1
    have hc := carry_le_one N 0 k (by omega) hk0
    have hq := quotient_eq_twice_add_carry N 0 k (by omega) hk0
    simp only [add_zero] at hq
    rw [hq, response_binary (N / k) (carry N 0 k) hc]
    ring
  rw [Finset.sum_congr rfl he]
  exact paired_quotient_response_sum_zero N t

/-- Each actual new terminal quotient contributes precisely the original unit response. -/
theorem paired_terminal_response (N k : ℕ) (hk : N < k) (hk2 : k ≤ 2 * N) (t : ℝ) :
    response ((2 * N) / k) t - response (N / k) (2 * t) = response 1 t := by
  have hk0 : 0 < k := by omega
  have hq : (2 * N) / k = 1 := by
    apply Nat.div_eq_of_lt_le <;> omega
  rw [hq, Nat.div_eq_of_lt hk]
  simp [response]

#print axioms quotient_response_sum_extend
#print axioms paired_quotient_response_sum_zero
#print axioms paired_quotient_innovation_sum_zero
#print axioms paired_terminal_response
end BuildingBlocks.FactorialBinaryCarry
