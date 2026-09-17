import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace ArithmeticDynamics

noncomputable section
open scoped BigOperators

private lemma unit_phase_mul_bound (z w : ℂ) (hz : ‖z‖ = 1) :
    ‖1 - z * w‖ ≤ ‖1 - z‖ + ‖1 - w‖ := by
  calc
    ‖1 - z * w‖ = ‖(1 - z) + z * (1 - w)‖ := by congr 1 <;> ring
    _ ≤ ‖1 - z‖ + ‖z * (1 - w)‖ := norm_add_le _ _
    _ = _ := by rw [norm_mul, hz, one_mul]

private lemma unit_phase_pow_bound (z : ℂ) (hz : ‖z‖ = 1) (m : ℕ) :
    ‖1 - z ^ m‖ ≤ (m : ℝ) * ‖1 - z‖ := by
  induction m with
  | zero => simp
  | succ m ih =>
    calc
      ‖1 - z ^ (m + 1)‖ ≤ ‖1 - z‖ + ‖1 - z ^ m‖ := by
        rw [pow_succ']; exact unit_phase_mul_bound z (z ^ m) hz
      _ ≤ ‖1 - z‖ + (m : ℝ) * ‖1 - z‖ := add_le_add_left ih _
      _ = ((m + 1 : ℕ) : ℝ) * ‖1 - z‖ := by simp only [Nat.cast_add, Nat.cast_one]; ring

/-- Finite unit phases with their full natural multiplicities. -/
theorem unit_phase_product_bound {ι : Type*} (s : Finset ι)
    (z : ι → ℂ) (m : ι → ℕ) (hz : ∀ i ∈ s, ‖z i‖ = 1) :
    ‖1 - ∏ i ∈ s, z i ^ m i‖ ^ 2 ≤
      (∑ i ∈ s, (m i : ℝ)) * ∑ i ∈ s, (m i : ℝ) * ‖1 - z i‖ ^ 2 := by
  classical
  have hlin : ‖1 - ∏ i ∈ s, z i ^ m i‖ ≤
      ∑ i ∈ s, (m i : ℝ) * ‖1 - z i‖ := by
    induction s using Finset.induction_on with
    | empty => simp
    | @insert i s hi ih =>
      have hzi := hz i (Finset.mem_insert_self i s)
      have hzs : ∀ j ∈ s, ‖z j‖ = 1 := fun j hj => hz j (Finset.mem_insert_of_mem hj)
      rw [Finset.prod_insert hi, Finset.sum_insert hi]
      exact (unit_phase_mul_bound (z i ^ m i) _ (by simp [norm_pow, hzi])).trans
        (add_le_add (unit_phase_pow_bound (z i) hzi (m i)) (ih hzs))
  have hcs := Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul s
    (r := fun i => (m i : ℝ) * ‖1 - z i‖)
    (f := fun i => (m i : ℝ))
    (g := fun i => (m i : ℝ) * ‖1 - z i‖ ^ 2)
    (fun i _ => Nat.cast_nonneg (m i))
    (fun i _ => mul_nonneg (Nat.cast_nonneg _) (sq_nonneg _))
    (fun i _ => by ring)
  exact (pow_le_pow_left₀ (norm_nonneg _) hlin 2).trans hcs

/-- Multiplicative phase of an integer, retaining every prime exponent. -/
def primePhaseProduct (n : ℕ) (z : ℕ → ℂ) : ℂ :=
  ∏ p ∈ n.primeFactors, z p ^ n.factorization p

/-- The finite factorization/Cauchy bound; the first sum is Ω(n). -/
theorem primePhaseProduct_bound (n : ℕ) (z : ℕ → ℂ)
    (hz : ∀ p : ℕ, p.Prime → ‖z p‖ = 1) :
    ‖1 - primePhaseProduct n z‖ ^ 2 ≤
      (∑ p ∈ n.primeFactors, (n.factorization p : ℝ)) *
        ∑ p ∈ n.primeFactors, (n.factorization p : ℝ) * ‖1 - z p‖ ^ 2 := by
  exact unit_phase_product_bound n.primeFactors z n.factorization
    (fun p hp => hz p (Nat.prime_of_mem_primeFactors hp))

/-- The actual logarithmic arithmetic phase. -/
def logarithmicPrimePhase (t : ℝ) (n : ℕ) : ℂ :=
  Complex.exp (((t * Real.log n : ℝ) : ℂ) * Complex.I)

lemma norm_logarithmicPrimePhase (t : ℝ) (n : ℕ) :
    ‖logarithmicPrimePhase t n‖ = 1 := by
  simp [logarithmicPrimePhase, Complex.norm_exp]

/-- Actual logarithms identify the unit-phase product, including prime powers. -/
theorem logarithmicPrimePhase_eq_product (t : ℝ) (n : ℕ) :
    logarithmicPrimePhase t n = primePhaseProduct n (logarithmicPrimePhase t) := by
  have hlog : Real.log n = ∑ p ∈ n.primeFactors,
      (n.factorization p : ℝ) * Real.log p := by
    simpa [Finsupp.sum] using Real.log_nat_eq_sum_factorization n
  unfold logarithmicPrimePhase primePhaseProduct
  rw [hlog]
  have hexp : (((t * ∑ p ∈ n.primeFactors,
      (n.factorization p : ℝ) * Real.log p : ℝ) : ℂ) * Complex.I) =
      ∑ p ∈ n.primeFactors, (n.factorization p : ℂ) *
        (((t * Real.log p : ℝ) : ℂ) * Complex.I) := by
    simp only [Finset.mul_sum, Complex.ofReal_sum, Complex.ofReal_mul,
      Complex.ofReal_natCast, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro p hp
    ring
  rw [hexp, Complex.exp_sum]
  apply Finset.prod_congr rfl
  intro p hp
  exact Complex.exp_nat_mul _ _

/-- The actual arithmetic estimate used by the prime phase Laplacian. -/
theorem logarithmicPrimePhase_bound (t : ℝ) (n : ℕ) :
    ‖1 - logarithmicPrimePhase t n‖ ^ 2 ≤
      (∑ p ∈ n.primeFactors, (n.factorization p : ℝ)) *
        ∑ p ∈ n.primeFactors, (n.factorization p : ℝ) *
          ‖1 - logarithmicPrimePhase t p‖ ^ 2 := by
  rw [logarithmicPrimePhase_eq_product t n]
  exact primePhaseProduct_bound n _ (fun p _ => norm_logarithmicPrimePhase t p)

end
end ArithmeticDynamics
