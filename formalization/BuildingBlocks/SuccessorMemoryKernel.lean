import BuildingBlocks.SuccessorCriticalLift

/-! The literal causal convolution/successor commutator, with its complete
predecessor boundary port and an actual L² column domain. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

noncomputable def causalMemory (F f : ℝ → ℝ) (v : ℝ) : ℝ :=
  ∫ u in Ioi (0 : ℝ), F (v - u) * f u

noncomputable def memoryKernel (F : ℝ → ℝ) (v u : ℝ) : ℝ :=
  amplitude v * F (sigma v - u) - predecessor (fun t => F (v - t)) u

theorem memory_successor (F f : ℝ → ℝ) (v : ℝ) :
    causalMemory F (successor f) v =
      ∫ u in Ioi (0 : ℝ), predecessor (fun t => F (v - t)) u * f u := by
  exact successor_predecessor_adjoint (fun t => F (v - t)) f

theorem successor_memory (F f : ℝ → ℝ) (v : ℝ) :
    successor (causalMemory F f) v =
      ∫ u in Ioi (0 : ℝ), (amplitude v * F (sigma v - u)) * f u := by
  rw [successor, causalMemory, ← integral_const_mul]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun u => by dsimp only; ring)

theorem memoryKernel_initial (F : ℝ → ℝ) (v : ℝ) {u : ℝ} (hu : u ≤ log 2) :
    memoryKernel F v u = amplitude v * F (sigma v - u) := by
  rw [memoryKernel, predecessor_initial _ hu, sub_zero]

theorem memoryKernel_tail (F : ℝ → ℝ) (v : ℝ) {u : ℝ} (hu : log 2 < u) :
    memoryKernel F v u = amplitude v * F (sigma v - u) -
      weight u * F (v - log (exp u - 1)) := by
  rw [memoryKernel, predecessor, if_pos hu]

theorem reflected_halfline_memLp {F : ℝ → ℝ} (hF : MemLp F 2 volume) (v : ℝ) :
    MemLp (fun u => F (v - u)) 2 (volume.restrict (Ioi (0 : ℝ))) :=
  (hF.comp_measurePreserving ((volume : Measure ℝ).measurePreserving_sub_left v)).restrict _

theorem memory_first_column_integrable {F f : ℝ → ℝ}
    (hF : MemLp F 2 volume) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    IntegrableOn (fun u => (amplitude v * F (sigma v - u)) * f u) (Ioi (0 : ℝ)) :=
  ((reflected_halfline_memLp hF (sigma v)).const_mul (amplitude v)).integrable_mul hf

theorem memory_second_column_integrable {F f : ℝ → ℝ}
    (hm : Measurable F) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    IntegrableOn (fun u => predecessor (fun t => F (v - t)) u * f u) (Ioi (0 : ℝ)) :=
  (predecessor_memLp (by fun_prop) (reflected_halfline_memLp hF v)).integrable_mul hf

/-- The full pointwise commutator is an absolutely integrable column pairing.
The complete memory profile is retained without truncating any delay. -/
theorem successor_memory_commutator {F f : ℝ → ℝ}
    (hm : Measurable F) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    successor (causalMemory F f) v - causalMemory F (successor f) v =
      ∫ u in Ioi (0 : ℝ), memoryKernel F v u * f u := by
  rw [successor_memory, memory_successor, ← integral_sub
    (memory_first_column_integrable hF hf v) (memory_second_column_integrable hm hF hf v)]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun u => by dsimp only; unfold memoryKernel; ring)

end BuildingBlocks.SuccessorCharge
