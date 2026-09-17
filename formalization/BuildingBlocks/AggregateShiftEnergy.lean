import BuildingBlocks.FiniteShiftEnergy

open Finset
open scoped BigOperators ComplexConjugate

namespace BuildingBlocks

/-- Expansion of an aggregate correlation, including every mixed outer-label term. -/
theorem aggregate_correlation_eq {ι : Type*} (s : Finset ι) (a : ι → ℂ)
    (z : ι → ℤ → ℂ) (u v : ℤ) :
    ((∑ p ∈ s, a p * z p u) * conj (∑ q ∈ s, a q * z q v)).re =
      ∑ p ∈ s, ∑ q ∈ s,
        (a p * conj (a q) * z p u * conj (z q v)).re := by
  simp only [map_sum, map_mul, Finset.sum_mul_sum, Complex.re_sum]
  apply Finset.sum_congr rfl
  intro p _
  apply Finset.sum_congr rfl
  intro q _
  apply congrArg Complex.re
  ring

/-- Apply finite shifts to the aggregate sequence itself. The complete `p,q`
correlation is retained; no outer-label Cauchy inequality is applied. -/
theorem aggregate_finite_shift_energy {ι : Type*} (s : Finset ι) (a : ι → ℂ)
    (z : ι → ℤ → ℂ) (N H : ℕ)
    (hz : ∀ p ∈ s, ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z p n = 0) :
    (H : ℝ) ^ 2 * ‖∑ p ∈ s, a p * ∑ n ∈ Finset.Ico (0 : ℤ) N, z p n‖ ^ 2 ≤
      ((N : ℝ) + H) *
        ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
          ∑ n ∈ shiftEnvelope N H, ∑ p ∈ s, ∑ q ∈ s,
            (a p * conj (a q) * z p (n + h) * conj (z q (n + j))).re := by
  have hsupport : ∀ n, n ∉ Finset.Ico (0 : ℤ) N →
      (∑ p ∈ s, a p * z p n) = 0 := by
    intro n hn
    apply Finset.sum_eq_zero
    intro p hp
    rw [hz p hp n hn, mul_zero]
  have hsum : (∑ n ∈ Finset.Ico (0 : ℤ) N, ∑ p ∈ s, a p * z p n) =
      ∑ p ∈ s, a p * ∑ n ∈ Finset.Ico (0 : ℤ) N, z p n := by
    rw [Finset.sum_comm]
    simp only [Finset.mul_sum]
  have he := finite_shift_energy (fun n => ∑ p ∈ s, a p * z p n) N H hsupport
  rw [hsum] at he
  simpa only [aggregate_correlation_eq] using he

end BuildingBlocks
