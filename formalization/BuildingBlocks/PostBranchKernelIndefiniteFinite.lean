import Mathlib.Tactic

/-!
# Finite sign-indefiniteness witnesses for the post-branch kernel

The exact transcendental sign checks for `q = exp (-1)` and `L = log 2` are
performed by the companion rational-interval certificate.  This module
defines the literal finite kernel and proves the witness/subspace logic.
-/

namespace BuildingBlocks.PostBranchKernelIndefiniteFinite

open scoped BigOperators

noncomputable section

def divisors6 : Fin 4 → ℕ
  | 0 => 1
  | 1 => 2
  | 2 => 3
  | 3 => 6

def sampledH (X d n : ℕ) (q : ℝ) : ℝ :=
  let m := min n (X * d)
  (q ^ (n + X * d - m) - q ^ (n + X * d) +
      (1 - q) * (n - m : ℕ) * q ^ n) / (2 * d)

def endpointG (x y : ℕ) (q : ℝ) : ℝ :=
  q ^ max x y - q ^ (x + y)

/-- The exact main mixed row plus max-based endpoint quadratic. -/
def fullKernel (p X e a : ℕ) (q L : ℝ) : ℝ :=
  2 * (L / X) * (sampledH X (p * e) a q - sampledH X (p * e) (p * a) q) +
    (L / X) ^ 2 *
      (endpointG (p * e) (p * a) q - 2 * endpointG e (p * a) q)

def quad4 (K : Fin 4 → Fin 4 → ℝ) (v : Fin 4 → ℝ) : ℝ :=
  ∑ i, ∑ j, v i * v j * K i j

def positiveWitness : Fin 4 → ℝ := ![-1, 1, 0, 0]

def negativeWitness : Fin 4 → ℝ := ![-1, 0, -1, 2]

theorem positiveWitness_zero_total : ∑ i, positiveWitness i = 0 := by
  norm_num [positiveWitness, Fin.sum_univ_succ]

theorem negativeWitness_zero_total : ∑ i, negativeWitness i = 0 := by
  norm_num [negativeWitness, Fin.sum_univ_succ]

def actualKernel : Fin 4 → Fin 4 → ℝ := fun i j =>
  fullKernel 5 2 (divisors6 i) (divisors6 j) (Real.exp (-1)) (Real.log 2)

/-- Opposite strict witness values exclude both conditional positive and
conditional negative semidefiniteness on the zero-total subspace. -/
theorem neither_conditionally_pos_nor_neg
    (hpos : 0 < quad4 actualKernel positiveWitness)
    (hneg : quad4 actualKernel negativeWitness < 0) :
    ¬(∀ v : Fin 4 → ℝ, (∑ i, v i) = 0 → 0 ≤ quad4 actualKernel v) ∧
    ¬(∀ v : Fin 4 → ℝ, (∑ i, v i) = 0 → quad4 actualKernel v ≤ 0) := by
  constructor
  · intro h
    have := h negativeWitness negativeWitness_zero_total
    linarith
  · intro h
    have := h positiveWitness positiveWitness_zero_total
    linarith

end
end BuildingBlocks.PostBranchKernelIndefiniteFinite

#print axioms BuildingBlocks.PostBranchKernelIndefiniteFinite.positiveWitness_zero_total
#print axioms BuildingBlocks.PostBranchKernelIndefiniteFinite.negativeWitness_zero_total
#print axioms BuildingBlocks.PostBranchKernelIndefiniteFinite.neither_conditionally_pos_nor_neg
