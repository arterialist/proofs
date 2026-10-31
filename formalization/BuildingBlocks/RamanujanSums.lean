/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Formalization of Srinivasa Ramanujan's Trigonometrical Sums (Paper 21, 1918),
the Divisor-Möbius Representation, Prime Orthogonal Evaluations,
and the Robin–Ramanujan Criterion for the Riemann Hypothesis (Section 59, 1915).
-/
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.NumberTheory.Harmonic.EulerMascheroni

open scoped BigOperators
open ArithmeticFunction

namespace BuildingBlocks.RamanujanSums

/-! ### 1. Definition of Ramanujan's Trigonometrical Sums -/

/-- Ramanujan's sum $c_q(n) = \sum_{d \mid \gcd(q, n)} d \cdot \mu(q/d)$
    introduced in Ramanujan (1918), Paper 21. -/
def ramanujanSum (q : ℕ) (n : ℕ) : ℤ :=
  ∑ d ∈ (Nat.gcd q n).divisors, (d : ℤ) * (moebius (q / d) : ℤ)

/-! ### 2. Classical Exact Evaluations -/

/-- $c_1(n) = 1$ for all integers $n$. -/
theorem ramanujanSum_one (n : ℕ) : ramanujanSum 1 n = 1 := by
  dsimp [ramanujanSum]
  have hgcd : Nat.gcd 1 n = 1 := Nat.gcd_one_left n
  rw [hgcd, Nat.divisors_one]
  simp

/-- $c_q(1) = \mu(q)$ for all moduli $q$. -/
theorem ramanujanSum_at_one (q : ℕ) : ramanujanSum q 1 = moebius q := by
  dsimp [ramanujanSum]
  have hgcd : Nat.gcd q 1 = 1 := Nat.gcd_one_right q
  rw [hgcd, Nat.divisors_one]
  simp [Nat.div_one]

/-- Whenever $\gcd(q, n) = 1$, Ramanujan's sum reduces to the Möbius function $\mu(q)$. -/
theorem ramanujanSum_of_coprime {q n : ℕ} (hcoprime : Nat.Coprime q n) :
    ramanujanSum q n = moebius q := by
  dsimp [ramanujanSum]
  rw [hcoprime, Nat.divisors_one]
  simp [Nat.div_one]

/-- Prime evaluation when $p \nmid n$: $c_p(n) = -1$. -/
theorem ramanujanSum_prime_not_dvd {p n : ℕ} (hp : Nat.Prime p) (hnd : ¬ p ∣ n) :
    ramanujanSum p n = -1 := by
  have hcoprime : Nat.Coprime p n := (Nat.Prime.coprime_iff_not_dvd hp).mpr hnd
  rw [ramanujanSum_of_coprime hcoprime]
  exact moebius_apply_prime hp

/-- Prime evaluation when $p \mid n$: $c_p(n) = p - 1$. -/
theorem ramanujanSum_prime_dvd {p n : ℕ} (hp : Nat.Prime p) (hd : p ∣ n) :
    ramanujanSum p n = (p : ℤ) - 1 := by
  dsimp [ramanujanSum]
  have hgcd : Nat.gcd p n = p := Nat.gcd_eq_left hd
  rw [hgcd, hp.divisors]
  rw [Finset.sum_pair hp.ne_one.symm]
  simp [moebius_apply_prime hp, Nat.div_self hp.pos]
  omega

/-- Prime evaluation at $n = 0$: $c_p(0) = \phi(p) = p - 1$. -/
theorem ramanujanSum_prime_zero {p : ℕ} (hp : Nat.Prime p) :
    ramanujanSum p 0 = (p : ℤ) - 1 := by
  exact ramanujanSum_prime_dvd hp (dvd_zero p)

/-! ### 3. Presieved Twin-Prime Sieve Local Factors -/

/-- The singular series local factor at prime $p \ge 5$ governing the
    presieved prime-pair matrix completion barrier in `certificates/presieved_prime_pair_sturm.py`. -/
def presievedLocalSingularFactor (p : ℕ) : ℚ :=
  (p - 2 : ℚ) / (p - 1 : ℚ)

theorem presievedLocalSingularFactor_pos {p : ℕ} (hp : 5 ≤ p) :
    0 < presievedLocalSingularFactor p := by
  dsimp [presievedLocalSingularFactor]
  have hnum : (0 : ℚ) < (p - 2 : ℚ) := by
    have : 2 < p := by omega
    exact sub_pos.mpr (Nat.cast_lt.mpr this)
  have hden : (0 : ℚ) < (p - 1 : ℚ) := by
    have : 1 < p := by omega
    exact sub_pos.mpr (Nat.cast_lt.mpr this)
  exact div_pos hnum hden

theorem presievedLocalSingularFactor_lt_one {p : ℕ} (hp : 5 ≤ p) :
    presievedLocalSingularFactor p < 1 := by
  dsimp [presievedLocalSingularFactor]
  have hden : (0 : ℚ) < (p - 1 : ℚ) := by
    have : 1 < p := by omega
    exact sub_pos.mpr (Nat.cast_lt.mpr this)
  rw [div_lt_one hden]
  have : (p - 2 : ℚ) < (p - 1 : ℚ) := by
    linarith
  exact this

/-! ### 4. Ramanujan Section 59 and the Robin RH Equivalence -/

/-- Guy Robin's arithmetic inequality predicate: $\sigma(n) < e^\gamma n \log\log n$. -/
def RobinPredicate (n : ℕ) : Prop :=
  (sigma 1 n : ℝ) < Real.exp Real.eulerMascheroniConstant * (n : ℝ) * Real.log (Real.log (n : ℝ))

/-- Guy Robin's Theorem (1984, completing Ramanujan's Section 59):
    The assertion that Robin's inequality holds for all $n > 5040$. -/
def RobinCriterion : Prop :=
  ∀ n : ℕ, 5040 < n → RobinPredicate n

/-- Ramanujan's Superior Highly Composite condition (Section 52, 1915):
    An integer $N$ maximizing $d(n) / n^\varepsilon$. -/
def SuperiorHighlyComposite (N : ℕ) (ε : ℝ) : Prop :=
  0 < ε ∧ ∀ n : ℕ, 0 < n →
    (cardFactors N : ℝ) / (N : ℝ)^ε ≥ (cardFactors n : ℝ) / (n : ℝ)^ε

/-- Ramanujan's Colossally Abundant condition (Section 56, 1915):
    An integer $N$ maximizing $\sigma(n) / n^{1+\varepsilon}$. -/
def ColossallyAbundant (N : ℕ) (ε : ℝ) : Prop :=
  0 < ε ∧ ∀ n : ℕ, 0 < n →
    (sigma 1 N : ℝ) / (N : ℝ)^(1 + ε) ≥ (sigma 1 n : ℝ) / (n : ℝ)^(1 + ε)

end BuildingBlocks.RamanujanSums

#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_one
#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_at_one
#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_of_coprime
#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_prime_not_dvd
#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_prime_dvd
#print axioms BuildingBlocks.RamanujanSums.ramanujanSum_prime_zero
#print axioms BuildingBlocks.RamanujanSums.presievedLocalSingularFactor_pos
#print axioms BuildingBlocks.RamanujanSums.presievedLocalSingularFactor_lt_one
