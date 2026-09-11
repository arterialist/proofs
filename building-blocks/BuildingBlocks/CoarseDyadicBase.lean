import BuildingBlocks.CoarsePrimitive
import Mathlib.Analysis.Complex.LocallyUniformLimit

open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

def CoarsePrimitiveBound : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ k : ℕ,
    coarsePrimitiveSquare ((2 : ℝ) ^ k) ≤ C * ((2 : ℝ) ^ k) ^ (4 + ε)

noncomputable def coarseMellinBlock (k : ℕ) (s : ℂ) : ℂ :=
  ∫ x in (2 : ℝ)^k..(2 * (2 : ℝ)^k),
    (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))

noncomputable def coarseMellinSum (s : ℂ) : ℂ := ∑' k : ℕ, coarseMellinBlock k s

end BuildingBlocks.CoarsePrimitive
