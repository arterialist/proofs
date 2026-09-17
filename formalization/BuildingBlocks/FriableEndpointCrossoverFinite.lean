import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite crossover algebra for near-complete admission

All statements are finite.  The module identifies the truncated Möbius
zero-moment and the coherent endpoint residual without asserting an
asymptotic estimate.
-/

namespace BuildingBlocks.FriableEndpointCrossoverFinite

open scoped BigOperators

noncomputable section

/-- Ordinary finite Mertens prefix, cast to the reals. -/
def mertens (z : ℕ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 z, (ArithmeticFunction.moebius m : ℝ)

/-- Finite harmonic Möbius prefix. -/
def mobiusHarmonic (z : ℕ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 z, (ArithmeticFunction.moebius m : ℝ) / m

/-- Literal truncated zero-moment numerator occurring at `z=vY`. -/
def truncatedZeroMoment (z : ℕ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 z,
    (ArithmeticFunction.moebius m : ℝ) * ((z : ℝ) / m - 1)

/-- Exact discrete counterpart of `z * integral_1^z M(u)/u^2 du`. -/
theorem truncatedZeroMoment_eq (z : ℕ) :
    truncatedZeroMoment z = (z : ℝ) * mobiusHarmonic z - mertens z := by
  simp only [truncatedZeroMoment, mobiusHarmonic, mertens]
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  have hm1 : 1 ≤ m := (Finset.mem_Icc.mp hm).1
  have hm0 : (m : ℝ) ≠ 0 := by positivity
  field_simp

/-- Weighted Möbius prefix used in the coherent endpoint decomposition. -/
def weightedPrefix (q : ℝ) (n : ℕ) : ℝ :=
  ∑ d ∈ Finset.range (n + 1), (ArithmeticFunction.moebius d : ℝ) * q ^ d

/-- Weighted Möbius tail on the literal closed interval. -/
def weightedTail (q : ℝ) (j N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Ico j (N + 1), (ArithmeticFunction.moebius d : ℝ) * q ^ d

/-- Exact coherent-mode decomposition, retaining the integer left endpoint. -/
theorem weightedTail_eq_total_sub_prefix
    (q : ℝ) {j N : ℕ} (hj : 1 ≤ j) (hjN : j ≤ N) :
    weightedTail q j N = weightedPrefix q N - weightedPrefix q (j - 1) := by
  simp only [weightedTail, weightedPrefix]
  have hsplit := Finset.sum_range_add_sum_Ico
    (fun d : ℕ => (ArithmeticFunction.moebius d : ℝ) * q ^ d)
    (show j ≤ N + 1 by omega)
  rw [show j - 1 + 1 = j by omega]
  rw [← hsplit]
  ring

/-- After subtracting the coherent total mode, the endpoint is exactly the
negative weighted Mertens prefix. -/
theorem coherent_endpoint_residual
    (q : ℝ) {j N : ℕ} (hj : 1 ≤ j) (hjN : j ≤ N) :
    weightedTail q j N - weightedPrefix q N =
      -weightedPrefix q (j - 1) := by
  rw [weightedTail_eq_total_sub_prefix q hj hjN]
  ring

/-- Exact quadratic separation of the deterministic crossover mode and its
Mertens residual; the cross term cannot be dropped. -/
theorem coherent_residual_square (coherent residual : ℝ) :
    (coherent - residual) ^ 2 =
      coherent ^ 2 - 2 * coherent * residual + residual ^ 2 := by ring

/-- A finite weighted energy is unchanged by replacing a tail-minus-total
with the exact prefix residual. -/
theorem residual_energy_identity
    (q : ℝ) (w : ℕ → ℝ) {J N : ℕ} (hJ : 1 ≤ J) :
    (∑ j ∈ Finset.Icc J N,
      w j * (weightedTail q j N - weightedPrefix q N) ^ 2) =
    ∑ j ∈ Finset.Icc J N, w j * (weightedPrefix q (j - 1)) ^ 2 := by
  apply Finset.sum_congr rfl
  intro j hjmem
  have hj : 1 ≤ j := hJ.trans (Finset.mem_Icc.mp hjmem).1
  have hjN' : j ≤ N := (Finset.mem_Icc.mp hjmem).2
  rw [coherent_endpoint_residual q hj hjN']
  ring

end
end BuildingBlocks.FriableEndpointCrossoverFinite

#print axioms BuildingBlocks.FriableEndpointCrossoverFinite.truncatedZeroMoment_eq
#print axioms BuildingBlocks.FriableEndpointCrossoverFinite.weightedTail_eq_total_sub_prefix
#print axioms BuildingBlocks.FriableEndpointCrossoverFinite.coherent_endpoint_residual
#print axioms BuildingBlocks.FriableEndpointCrossoverFinite.coherent_residual_square
#print axioms BuildingBlocks.FriableEndpointCrossoverFinite.residual_energy_identity
