import BuildingBlocks.FactorialBirthLcmGhost
import BuildingBlocks.FactorialPairedCovariance

open Finset MeasureTheory
namespace BuildingBlocks.FactorialBirthLcmEnergy
open FactorialBirthDivisorGhost FactorialBirthLcmGhost

/-- The literal actual predecessor difference, including the empty zero horizon. -/
theorem arrival_response (n : ℕ) (t : ℝ) :
    arrival n t = FactorialBinaryCarry.response n t -
      FactorialBinaryCarry.response (n - 1) t := by
  by_cases hn : n = 0
  · simp [hn, arrival, FactorialBinaryCarry.response]
  · simp only [arrival, hn, if_false]
    unfold FactorialIntegerBirth.birth
    rw [Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr hn)]

/-- Every ordered birth product is absolutely integrable in the full original clock. -/
theorem arrival_product_integrable (n m : ℕ) :
    IntegrableOn (fun t : ℝ => arrival n t * arrival m t *
      FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  have hi (a b : ℕ) := FactorialBinaryCarry.actual_response_product_integrable a b 1 1
  simp only [Nat.cast_one, one_mul] at hi
  have h := ((hi n m).sub (hi n (m - 1))).sub
    ((hi (n - 1) m).sub (hi (n - 1) (m - 1)))
  change Integrable _ (volume.restrict (Set.Ioi 0))
  convert h using 1
  funext t
  simp only [arrival_response, Pi.sub_apply]
  ring

/-- Any finite integer selection retains absolute integrability of its signed pair sum. -/
theorem selected_pairs_integrable (N : ℕ) (P : ℕ → ℕ → Prop) [DecidableRel P] :
    IntegrableOn (fun t : ℝ =>
      (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        if P d e then arrival d t * arrival e t else 0) *
          FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  simp_rw [sum_mul]
  apply integrable_finset_sum
  intro d hd
  apply integrable_finset_sum
  intro e he
  by_cases h : P d e
  · simpa only [h, if_true] using arrival_product_integrable d e
  · simp only [h, if_false, zero_mul]
    exact integrableOn_zero

noncomputable def interiorRow (N : ℕ) (t : ℝ) : ℝ :=
  ((1 - Real.exp (-t)) / (1 + Real.exp (-t))) *
    FactorialBinaryCarry.response N (2 * t) * FactorialBinaryEnergy.weight t

noncomputable def boundaryRow (N : ℕ) (t : ℝ) : ℝ :=
  (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
    if N < Nat.lcm d e then arrival d t * arrival e t else 0) *
      FactorialBinaryEnergy.weight t

noncomputable def interiorEnergy (N : ℕ) : ℝ := ∫ t in Set.Ioi 0, interiorRow N t
noncomputable def boundaryEnergy (N : ℕ) : ℝ := ∫ t in Set.Ioi 0, boundaryRow N t

/-- Absolute integrability of the actual complete interior, without a sign assumption. -/
theorem interior_integrable (N : ℕ) :
    IntegrableOn (interiorRow N) (Set.Ioi 0) := by
  have hi := selected_pairs_integrable N (fun d e => Nat.lcm d e ≤ N)
  have he : ∀ t : ℝ,
      (∑ d ∈ Icc 1 N, ∑ e ∈ Icc 1 N,
        if Nat.lcm d e ≤ N then arrival d t * arrival e t else 0) *
          FactorialBinaryEnergy.weight t = interiorRow N t := by
    intro t
    rw [← interior_pair_sum, actual_interior_sum]
    rfl
  simpa only [he] using hi

/-- Absolute integrability of all actual signed escaping pairs. -/
theorem boundary_integrable (N : ℕ) :
    IntegrableOn (boundaryRow N) (Set.Ioi 0) :=
  selected_pairs_integrable N (fun d e => N < Nat.lcm d e)

/-- Exact full-clock decomposition of the original integrated energy. -/
theorem actual_energy_boundary (N : ℕ) :
    FactorialBinaryIntegrability.integratedEnergy N = interiorEnergy N + boundaryEnergy N := by
  have he : ∀ t : ℝ, FactorialBinaryEnergy.energyRow N t = interiorRow N t + boundaryRow N t := by
    intro t
    unfold FactorialBinaryEnergy.energyRow interiorRow boundaryRow
    rw [actual_boundary_decomposition, add_mul]
  unfold FactorialBinaryIntegrability.integratedEnergy interiorEnergy boundaryEnergy
  simp_rw [he]
  exact integral_add (interior_integrable N) (boundary_integrable N)

end BuildingBlocks.FactorialBirthLcmEnergy
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.arrival_response
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.arrival_product_integrable
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.selected_pairs_integrable
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.interior_integrable
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.boundary_integrable
#print axioms BuildingBlocks.FactorialBirthLcmEnergy.actual_energy_boundary
