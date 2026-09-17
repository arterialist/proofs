import BuildingBlocks.FactorialTerminalReserve
import Mathlib.NumberTheory.Divisors
import Mathlib.Tactic

namespace BuildingBlocks.HardClockWeightedLcmClass

open Finset

noncomputable section

/-- Complete hard-clock weighted LCM class. -/
def weightedLcmClass (k : ℕ) : ℤ :=
  ∑ i ∈ k.divisors, ∑ j ∈ k.divisors,
    if Nat.lcm i j = k then
      ArithmeticFunction.moebius i * ArithmeticFunction.moebius j * (i : ℤ) * (j : ℤ)
    else 0

/-- The exact prime-local class factor. All four divisor pairs are retained. -/
theorem weightedLcmClass_prime {p : ℕ} (hp : p.Prime) :
    weightedLcmClass p = (p : ℤ) * ((p : ℤ) - 2) := by
  unfold weightedLcmClass
  rw [hp.divisors]
  simp [hp.ne_one.symm, ArithmeticFunction.moebius_apply_prime hp]
  ring

/-- Prime local factors are nonnegative. -/
theorem prime_local_factor_nonneg {p : ℕ} (hp : p.Prime) :
    0 ≤ (p : ℤ) * ((p : ℤ) - 2) := by
  have hp2 : 2 ≤ p := hp.two_le
  have hp2z : (2 : ℤ) ≤ (p : ℤ) := by exact_mod_cast hp2
  exact mul_nonneg (by positivity) (sub_nonneg.mpr hp2z)

/-- Each prime-local factor is bounded above by the square of that prime. -/
theorem prime_local_factor_le_square {p : ℕ} (hp : p.Prime) :
    (p : ℤ) * ((p : ℤ) - 2) ≤ (p : ℤ) ^ 2 := by
  have hp0 : (0 : ℤ) ≤ p := by positivity
  have _hp2 := hp.two_le
  nlinarith

/-- Finite squarefree product comparison. -/
theorem prime_factor_product_le_square (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) :
    (∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) ≤
      ((∏ p ∈ P, (p : ℤ)) : ℤ) ^ 2 := by
  have hnonneg : ∀ p ∈ P, (0 : ℤ) ≤ (p : ℤ) * ((p : ℤ) - 2) :=
    fun p hp => prime_local_factor_nonneg (hP p hp)
  have hsq : (∏ p ∈ P, ((p : ℤ) ^ 2)) = ((∏ p ∈ P, (p : ℤ)) : ℤ) ^ 2 := by
    rw [prod_pow]
  rw [← hsq]
  exact prod_le_prod (fun p hp => hnonneg p hp)
    (fun p hp => prime_local_factor_le_square (hP p hp))

/-- The factor product is nonnegative as well. -/
theorem prime_factor_product_nonneg (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) :
    0 ≤ ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2) := by
  exact prod_nonneg fun p hp => prime_local_factor_nonneg (hP p hp)

/-- Finite squarefree induction: any class satisfying the exact new-prime
recurrence has the complete product formula. The hypotheses expose precisely
the remaining multiplicative step for the actual weighted class. -/
theorem finite_prime_induction (W : ℕ → ℤ)
    (hW1 : W 1 = 1)
    (hstep : ∀ (P : Finset ℕ) (p : ℕ), (∀ q ∈ P, q.Prime) → p.Prime → p ∉ P →
      W ((∏ q ∈ P, q) * p) = W (∏ q ∈ P, q) * (p : ℤ) * ((p : ℤ) - 2))
    (P : Finset ℕ) (hP : ∀ p ∈ P, p.Prime) :
    W (∏ p ∈ P, p) = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2) := by
  classical
  induction P using Finset.induction_on with
  | empty => simpa using hW1
  | @insert p P hp ih =>
      have hprimeP : ∀ q ∈ P, q.Prime := fun q hq =>
        hP q (mem_insert_of_mem hq)
      have hprimep : p.Prime := hP p (mem_insert_self p P)
      rw [prod_insert hp, prod_insert hp]
      calc
        W (p * ∏ q ∈ P, q) = W ((∏ q ∈ P, q) * p) := by rw [mul_comm]
        _ = W (∏ q ∈ P, q) * (p : ℤ) * ((p : ℤ) - 2) :=
          hstep P p hprimeP hprimep hp
        _ = (p : ℤ) * ((p : ℤ) - 2) * ∏ q ∈ P, (q : ℤ) * ((q : ℤ) - 2) := by
          rw [ih hprimeP]
          ring

/-- Once the exact squarefree class product is supplied, removing the diagonal
`k²` leaves a nonpositive coefficient. -/
theorem squarefree_offDiagonal_nonpos (k : ℕ) (P : Finset ℕ)
    (hP : ∀ p ∈ P, p.Prime) (hk : k = ∏ p ∈ P, p)
    (hclass : weightedLcmClass k = ∏ p ∈ P, (p : ℤ) * ((p : ℤ) - 2)) :
    weightedLcmClass k - (k : ℤ) ^ 2 ≤ 0 := by
  rw [hclass, hk]
  have hcast : ((∏ p ∈ P, p : ℕ) : ℤ) = ∏ p ∈ P, (p : ℤ) := by
    exact Nat.cast_prod (R := ℤ) (fun p : ℕ => p) P
  rw [hcast]
  exact sub_nonpos.mpr (prime_factor_product_le_square P hP)

#print axioms weightedLcmClass_prime
#print axioms prime_local_factor_nonneg
#print axioms prime_local_factor_le_square
#print axioms prime_factor_product_le_square
#print axioms prime_factor_product_nonneg
#print axioms finite_prime_induction
#print axioms squarefree_offDiagonal_nonpos

end
end BuildingBlocks.HardClockWeightedLcmClass
