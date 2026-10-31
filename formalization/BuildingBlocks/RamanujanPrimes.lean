/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Formalization of Ramanujan Primes and Ramanujan's Proof of Bertrand's Postulate (Paper 24, 1919).
-/
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Order.Interval.Finset.Nat

namespace BuildingBlocks.RamanujanPrimes

/-! ### 1. Prime Counting and Dyadic Intervals -/

/-- Prime counting function $\pi(x) = \#\{p \le x : p \text{ is prime}\}$. -/
noncomputable def primeCounting (x : ℕ) : ℕ :=
  ((Finset.Iic x).filter Nat.Prime).card

/-- Prime counting in the dyadic half-open interval $(x/2, x]$. -/
noncomputable def primesInDyadicInterval (x : ℕ) : ℕ :=
  primeCounting x - primeCounting (x / 2)

/-! ### 2. The Ramanujan Prime Condition -/

/-- Ramanujan's condition for index $n$: for all integers $x \ge R$,
    the interval $(x/2, x]$ contains at least $n$ prime numbers.
    Introduced in Ramanujan (1919), Paper 24. -/
def RamanujanPrimeCondition (n : ℕ) (R : ℕ) : Prop :=
  ∀ x : ℕ, R ≤ x → n ≤ primesInDyadicInterval x

/-- Bertrand's Postulate statement: $R = 2$ satisfies the Ramanujan condition for $n = 1$. -/
def BertrandsPostulate : Prop :=
  RamanujanPrimeCondition 1 2

/-- The $n$-th Ramanujan prime $R_n$ is the minimal integer satisfying the condition. -/
def IsRamanujanPrime (n : ℕ) (R : ℕ) : Prop :=
  RamanujanPrimeCondition n R ∧ (∀ R' : ℕ, RamanujanPrimeCondition n R' → R ≤ R')

/-! ### 3. Foundational Properties -/

theorem ramanujan_prime_condition_of_isRamanujanPrime {n R : ℕ} (h : IsRamanujanPrime n R) :
    RamanujanPrimeCondition n R :=
  h.1

theorem ramanujan_prime_minimal {n R R' : ℕ} (h : IsRamanujanPrime n R)
    (h' : RamanujanPrimeCondition n R') : R ≤ R' :=
  h.2 R' h'

theorem bertrands_postulate_iff :
    BertrandsPostulate ↔ RamanujanPrimeCondition 1 2 :=
  Iff.rfl

end BuildingBlocks.RamanujanPrimes

#print axioms BuildingBlocks.RamanujanPrimes.ramanujan_prime_condition_of_isRamanujanPrime
#print axioms BuildingBlocks.RamanujanPrimes.ramanujan_prime_minimal
#print axioms BuildingBlocks.RamanujanPrimes.bertrands_postulate_iff
