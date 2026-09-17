import Mathlib.Tactic

/-!
# Finite prime-admission energy flux

This module formalizes the Hilbert-space and summation-by-parts algebra behind
finite largest-prime packet admission. Arithmetic identification of the packet
vectors remains external.
-/

namespace BuildingBlocks.PrimeAdmissionEnergyFlux

open scoped BigOperators

variable {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]

/-- Partial sum after the first `n` packet admissions. -/
def partialSum (U : ℕ → H) (n : ℕ) : H :=
  ∑ j ∈ Finset.range n, U j

/-- Squared energy after the first `n` packet admissions. -/
def energy (U : ℕ → H) (n : ℕ) : ℝ :=
  ‖partialSum U n‖ ^ 2

/-- Exact energy increment for one admitted packet. -/
theorem admission_energy_increment (U : ℕ → H) (n : ℕ) :
    energy U (n + 1) - energy U n =
      ‖U n‖ ^ 2 + 2 * inner ℝ (partialSum U n) (U n) := by
  simp only [energy, partialSum, Finset.sum_range_succ, norm_add_sq_real]
  ring

/-- The complete unweighted flux telescopes to the final energy. -/
theorem total_flux (U : ℕ → H) (N : ℕ) :
    (∑ j ∈ Finset.range N, (energy U (j + 1) - energy U j)) = energy U N := by
  induction N with
  | zero => simp [energy, partialSum]
  | succ N ih =>
      rw [Finset.sum_range_succ, ih]
      ring

/-- Discrete weighted integration by parts, with both endpoints retained. -/
theorem weighted_flux_identity (w E : ℕ → ℝ) (N : ℕ) :
    (∑ j ∈ Finset.range (N + 1), w j * (E (j + 1) - E j)) =
      w N * E (N + 1) - w 0 * E 0 +
        ∑ j ∈ Finset.range N, (w j - w (j + 1)) * E (j + 1) := by
  induction N with
  | zero => simp; ring
  | succ N ih =>
      calc
        (∑ j ∈ Finset.range (N + 1 + 1), w j * (E (j + 1) - E j)) =
            (∑ j ∈ Finset.range (N + 1), w j * (E (j + 1) - E j)) +
              w (N + 1) * (E (N + 1 + 1) - E (N + 1)) := by
                rw [Finset.sum_range_succ]
        _ = (w N * E (N + 1) - w 0 * E 0 +
              ∑ j ∈ Finset.range N, (w j - w (j + 1)) * E (j + 1)) +
              w (N + 1) * (E (N + 1 + 1) - E (N + 1)) := by rw [ih]
        _ = w (N + 1) * E (N + 1 + 1) - w 0 * E 0 +
              ∑ j ∈ Finset.range (N + 1),
                (w j - w (j + 1)) * E (j + 1) := by
                  rw [Finset.sum_range_succ]
                  ring

/-- A nonnegative decreasing weight cannot turn nonnegative intermediate
energies into a negative averaged admission flux. -/
theorem weighted_flux_nonnegative
    (w E : ℕ → ℝ) (N : ℕ)
    (hE0 : E 0 = 0)
    (hE : ∀ j, 0 ≤ E (j + 1))
    (hwN : 0 ≤ w N)
    (hwmono : ∀ j < N, w (j + 1) ≤ w j) :
    0 ≤ ∑ j ∈ Finset.range (N + 1), w j * (E (j + 1) - E j) := by
  rw [weighted_flux_identity, hE0, mul_zero, sub_zero]
  apply add_nonneg (mul_nonneg hwN (hE N))
  apply Finset.sum_nonneg
  intro j hj
  have hjN : j < N := Finset.mem_range.mp hj
  exact mul_nonneg (sub_nonneg.mpr (hwmono j hjN)) (hE j)

/-- The weighted nonnegativity applies directly to packet partial energies. -/
theorem packet_weighted_flux_nonnegative
    (U : ℕ → H) (w : ℕ → ℝ) (N : ℕ)
    (hwN : 0 ≤ w N)
    (hwmono : ∀ j < N, w (j + 1) ≤ w j) :
    0 ≤ ∑ j ∈ Finset.range (N + 1),
      w j * (energy U (j + 1) - energy U j) := by
  apply weighted_flux_nonnegative w (energy U) N
  · simp [energy, partialSum]
  · intro j
    exact sq_nonneg _
  · exact hwN
  · exact hwmono

end BuildingBlocks.PrimeAdmissionEnergyFlux

#print axioms BuildingBlocks.PrimeAdmissionEnergyFlux.admission_energy_increment
#print axioms BuildingBlocks.PrimeAdmissionEnergyFlux.total_flux
#print axioms BuildingBlocks.PrimeAdmissionEnergyFlux.weighted_flux_identity
#print axioms BuildingBlocks.PrimeAdmissionEnergyFlux.packet_weighted_flux_nonnegative
