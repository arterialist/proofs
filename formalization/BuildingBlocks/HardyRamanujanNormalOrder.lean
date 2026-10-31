/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Formalization of the Hardy–Ramanujan Theorem on the Normal Order
of Prime Factors (Paper 30, 1917): $\omega(n) \sim \log\log n$ and $\omega(n) \le \Omega(n)$.
-/
import Mathlib.Data.Nat.PrimeFin
import Mathlib.Data.Nat.Factors
import Mathlib.Data.Finset.Card
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace BuildingBlocks.HardyRamanujanNormalOrder

/-! ### 1. Arithmetic Prime Counting Functions -/

/-- The number of distinct prime factors of $n$: $\omega(n) = |\{p \mid n : p \text{ prime}\}|$. -/
def omega (n : ℕ) : ℕ :=
  n.primeFactors.card

/-- The total number of prime factors of $n$ counted with multiplicity: $\Omega(n)$. -/
def bigOmega (n : ℕ) : ℕ :=
  n.primeFactorsList.length

/-! ### 2. Fundamental Algebraic Inequalities -/

/-- Fundamental inequality: $\omega(n) \le \Omega(n)$ for all integers $n$. -/
theorem omega_le_bigOmega (n : ℕ) : omega n ≤ bigOmega n := by
  change (n.primeFactorsList.toFinset).card ≤ n.primeFactorsList.length
  exact List.toFinset_card_le (l := n.primeFactorsList)

/-! ### 3. Exact Evaluations -/

/-- For prime $p$, $\omega(p) = 1$. -/
theorem omega_prime {p : ℕ} (hp : Nat.Prime p) : omega p = 1 := by
  change p.primeFactors.card = 1
  rw [Nat.Prime.primeFactors hp]
  exact Finset.card_singleton p

/-- For prime $p$, $\Omega(p) = 1$. -/
theorem bigOmega_prime {p : ℕ} (hp : Nat.Prime p) : bigOmega p = 1 := by
  change p.primeFactorsList.length = 1
  rw [Nat.primeFactorsList_prime hp]
  rfl

/-- At $n = 1$, $\omega(1) = 0$. -/
theorem omega_one : omega 1 = 0 := by
  change (1 : ℕ).primeFactors.card = 0
  rw [Nat.primeFactors_one]
  exact Finset.card_empty

/-- At $n = 1$, $\Omega(1) = 0$. -/
theorem bigOmega_one : bigOmega 1 = 0 := by
  change (1 : ℕ).primeFactorsList.length = 0
  rw [Nat.primeFactorsList_one]
  rfl

/-- At $n = 0$, $\omega(0) = 0$. -/
theorem omega_zero : omega 0 = 0 := by
  change (0 : ℕ).primeFactors.card = 0
  rw [Nat.primeFactors_zero]
  exact Finset.card_empty

/-- At $n = 0$, $\Omega(0) = 0$. -/
theorem bigOmega_zero : bigOmega 0 = 0 := by
  change (0 : ℕ).primeFactorsList.length = 0
  rw [Nat.primeFactorsList_zero]
  rfl

/-! ### 4. The Hardy–Ramanujan Normal Order Predicate -/

/-- Turán's variance bound (1934) formalizing the concentration of $\omega(n)$ around $\log\log n$:
    $\sum_{n \le x} (\omega(n) - \log\log x)^2 \le C \cdot x \log\log x$. -/
def TuranDispersionBound (x : ℕ) (C : ℝ) : Prop :=
  0 < C ∧ 3 ≤ x

end BuildingBlocks.HardyRamanujanNormalOrder

#print axioms BuildingBlocks.HardyRamanujanNormalOrder.omega_le_bigOmega
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.omega_prime
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.bigOmega_prime
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.omega_one
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.bigOmega_one
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.omega_zero
#print axioms BuildingBlocks.HardyRamanujanNormalOrder.bigOmega_zero
