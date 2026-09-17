import BuildingBlocks.SamePrimeBlockCalibration
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Data.Nat.Prime.Int

open Finset MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks.PrimeBlockSource

open SamePrimeBirthConvolution SamePrimeBlockCalibration CoarsePrimitive

/-- The finite prime-power parametrization of the actual von Mangoldt sum. -/
theorem psi_eq_prime_power_sum (N : ℕ) :
    psi N = ∑ p ∈ Finset.Icc 2 N, if p.Prime then
      ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then Real.log p else 0 else 0 := by
  classical
  let P := (Finset.Icc 2 N ×ˢ Finset.Icc 1 N).filter (fun a => a.1.Prime ∧ a.1 ^ a.2 ≤ N)
  let Q := (Finset.Icc 1 N).filter IsPrimePow
  have hbij : (∑ a ∈ P, Real.log a.1) = ∑ n ∈ Q, ArithmeticFunction.vonMangoldt n := by
    apply Finset.sum_bij (fun a _ => a.1 ^ a.2)
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, hpow⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨pow_pos hp.pos _, hpow⟩,
        ⟨a.1, a.2, hp.prime, hj, rfl⟩⟩
    · intro a ha b hb hab
      rcases Finset.mem_filter.mp ha with ⟨ha, hpa, _⟩
      rcases Finset.mem_filter.mp hb with ⟨hb, hpb, _⟩
      have hja := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      have hjb := (Finset.mem_Icc.mp (Finset.mem_product.mp hb).2).1
      have hpa' : a.1 = b.1 := by
        have hpow : a.1 ^ ((a.2 - 1) + 1) = b.1 ^ ((b.2 - 1) + 1) := by
          simpa [Nat.sub_add_cancel hja, Nat.sub_add_cancel hjb] using hab
        exact (hpa.pow_inj hpb hpow).1
      apply Prod.ext hpa'
      apply Nat.pow_right_injective hpb.two_le
      simpa [hpa'] using hab
    · intro n hn
      rcases Finset.mem_filter.mp hn with ⟨hn, hpw⟩
      rcases hpw with ⟨p, j, hp, hj, hpow⟩
      have hp' : p.Prime := Nat.prime_iff.mpr hp
      have hnN := (Finset.mem_Icc.mp hn).2
      have hpN : p ≤ N := by
        calc
          p = p ^ 1 := by simp
          _ ≤ p ^ j := pow_le_pow_right₀ hp'.one_lt.le hj
          _ ≤ N := by simpa [hpow] using hnN
      have hjN : j ≤ N := (j.lt_pow_self hp'.one_lt).le.trans (by simpa [hpow] using hnN)
      refine ⟨(p,j), ?_, hpow⟩
      exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
        ⟨Finset.mem_Icc.mpr ⟨hp'.two_le, hpN⟩, Finset.mem_Icc.mpr ⟨hj, hjN⟩⟩,
        hp', by simpa [hpow] using hnN⟩
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, _⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega), ArithmeticFunction.vonMangoldt_apply_prime hp]
  have hQ : (∑ n ∈ Q, ArithmeticFunction.vonMangoldt n) = psi N := by
    rw [psi_eq_sum_Icc]
    apply Finset.sum_subset (Finset.filter_subset _ _)
    intro n hn hnq
    apply ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr
    exact fun h => hnq (Finset.mem_filter.mpr ⟨hn, h⟩)
  rw [← hQ, ← hbij]
  dsimp only [P]
  rw [Finset.sum_filter, Finset.sum_product]
  apply Finset.sum_congr rfl
  intro p _
  by_cases hp : p.Prime
  · simp [hp]
  · simp [hp]

/-- The indicator equivalence retains prime-power birth endpoints exactly. -/
theorem birth_activation_iff {p : ℕ} (hp : p.Prime) (j : ℕ) (v : ℝ) :
    (j : ℝ) * Real.log p ≤ v ↔ p ^ j ≤ ⌊Real.exp v⌋₊ := by
  rw [← Real.exp_le_exp, Real.exp_nat_mul, Real.exp_log (by exact_mod_cast hp.pos)]
  rw [← Nat.cast_pow]
  exact (Nat.le_floor_iff (Real.exp_pos v).le).symm

theorem primeBlock_eq_power_sum {p : ℕ} (hp : p.Prime) (v : ℝ) :
    primeBlock p v = Real.exp (-v / 2) *
      ∑ j ∈ Finset.Icc 1 ⌊Real.exp v⌋₊, if p ^ j ≤ ⌊Real.exp v⌋₊ then Real.log p else 0 := by
  unfold primeBlock block
  rw [Finset.mul_sum, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j _
  by_cases hj : p ^ j ≤ ⌊Real.exp v⌋₊
  · have hage := (birth_activation_iff hp j v).mpr hj
    simp [birth, Set.indicator_of_mem (show v ∈ Set.Ici ((j : ℝ) * Real.log p) from hage), hj, mul_comm]
  · have hage : ¬(j : ℝ) * Real.log p ≤ v := fun h => hj ((birth_activation_iff hp j v).mp h)
    simp [birth, Set.indicator_of_notMem (show v ∉ Set.Ici ((j : ℝ) * Real.log p) from hage), hj]

/-- Primes beyond the external integer cutoff have no active history. -/
theorem primeBlock_eq_zero_above_cutoff {p : ℕ} (hp : p.Prime) {v : ℝ}
    (hpN : ⌊Real.exp v⌋₊ < p) : primeBlock p v = 0 := by
  rw [primeBlock_eq_power_sum hp]
  have hz : (∑ j ∈ Finset.Icc 1 ⌊Real.exp v⌋₊,
      if p ^ j ≤ ⌊Real.exp v⌋₊ then Real.log p else 0) = 0 := by
    apply Finset.sum_eq_zero
    intro j hj
    have hj1 := (Finset.mem_Icc.mp hj).1
    have hpp : p ≤ p ^ j := by simpa using pow_le_pow_right₀ hp.one_lt.le hj1
    rw [if_neg (by omega)]
  rw [hz, mul_zero]

noncomputable def primeBlockSum (v : ℝ) : ℝ :=
  ∑ p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, if p.Prime then primeBlock p v else 0

/-- Exact all-prime, all-power history equals the existing actual Chebyshev sum. -/
theorem primeBlockSum_eq_psi (v : ℝ) :
    primeBlockSum v = Real.exp (-v / 2) * psi ⌊Real.exp v⌋₊ := by
  rw [psi_eq_prime_power_sum, Finset.mul_sum]
  unfold primeBlockSum
  apply Finset.sum_congr rfl
  intro p _
  split_ifs with hp
  · exact primeBlock_eq_power_sum hp v
  · simp

/-- Literal centered source, using the existing actual von Mangoldt partial sum. -/
noncomputable def source (v : ℝ) : ℝ :=
  if 0 ≤ v then Real.exp (-v / 2) * (psi ⌊Real.exp v⌋₊ - Real.exp v) else 0

theorem source_eq_primeBlocks {v : ℝ} (hv : 0 ≤ v) : source v = primeBlockSum v - Real.exp (v / 2) := by
  rw [primeBlockSum_eq_psi]
  unfold source
  rw [if_pos hv, mul_sub, ← Real.exp_add]
  congr 1
  congr 1
  ring

@[simp] theorem source_zero : source 0 = -1 := by
  simp [source, psi_eq_sum_Icc]

theorem source_eq_zero_of_neg {v : ℝ} (hv : v < 0) : source v = 0 := by
  simp [source, not_le.mpr hv]

/-- Both density mixed orders remain visible in the actual two-age source product. -/
theorem source_product {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) :
    source u * source v = primeBlockSum u * primeBlockSum v -
      primeBlockSum u * Real.exp (v / 2) - Real.exp (u / 2) * primeBlockSum v +
      Real.exp ((u + v) / 2) := by
  rw [source_eq_primeBlocks hu, source_eq_primeBlocks hv]
  have he : Real.exp ((u + v) / 2) = Real.exp (u / 2) * Real.exp (v / 2) := by
    rw [← Real.exp_add]
    congr 1
    ring
  rw [he]
  ring

#print axioms psi_eq_prime_power_sum
#print axioms birth_activation_iff
#print axioms primeBlock_eq_zero_above_cutoff
#print axioms primeBlockSum_eq_psi
#print axioms source_eq_primeBlocks

end BuildingBlocks.PrimeBlockSource
