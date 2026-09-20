/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Exact history count at the mixed semiprime endpoint of the K = 3
Möbius decomposition.  This file proves only the finite arithmetic
identities.  It contains no analytic estimate.
-/
import BuildingBlocks.ActualMobiusConvolution

namespace BuildingBlocks.ActualMobiusK3SemiprimeHistory

open scoped ArithmeticFunction

/-- The two free factors in the cubic term are counted by `sigma 0`. -/
noncomputable def divisorCount : ArithmeticFunction ℤ :=
  ArithmeticFunction.sigma 0

/-- The coefficient supplied by the all-unit histories in
`-3 a₀² * 1 + a₀³ * 1²`. -/
noncomputable def allUnitCoefficient (n : ℕ) : ℤ :=
  divisorCount n - 3

/-- After the two one-unit free splittings are combined with the three
quadratic copies, the single-free packet has coefficient `-1`.  The
remaining term counts ordered nontrivial free-factor splittings. -/
theorem allUnitCoefficient_eq_single_add_nontrivial (n : ℕ) :
    allUnitCoefficient n = -1 + (divisorCount n - 2) := by
  unfold allUnitCoefficient
  ring

theorem divisorCount_apply_prime {p : ℕ} (hp : p.Prime) :
    divisorCount p = 2 := by
  have ht : (ArithmeticFunction.sigma 0) p = 2 := by
    rw [show p = p ^ 1 by simp,
      ArithmeticFunction.sigma_zero_apply_prime_pow hp]
  simp [divisorCount, ht]

theorem divisorCount_isMultiplicative : divisorCount.IsMultiplicative := by
  exact ArithmeticFunction.isMultiplicative_sigma.natCast

/-- A product of two distinct primes has four ordered free-factor
splittings. -/
theorem divisorCount_apply_distinct_prime_mul {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    divisorCount (p * q) = 4 := by
  have hcop : p.Coprime q := (Nat.coprime_primes hp hq).2 hpq
  rw [divisorCount_isMultiplicative.map_mul_of_coprime hcop,
    divisorCount_apply_prime hp, divisorCount_apply_prime hq]
  norm_num

/-- In `-3 a₀² * 1 + a₀³ * 1²`, the histories with exactly one
nonunit short-prime factor cancel: there are two positions in the
quadratic term and three positions times two free splittings in the
cubic term. -/
theorem one_nonunit_short_prime_histories_cancel {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) :
    (-3 : ℤ) * (2 * ArithmeticFunction.moebius p) +
        (3 * divisorCount q) * ArithmeticFunction.moebius p = 0 := by
  rw [divisorCount_apply_prime hq,
    ArithmeticFunction.moebius_apply_prime hp]
  norm_num

/-- The all-unit histories leave coefficient one at a mixed semiprime:
the quadratic term contributes `-3`, while the cubic term contributes
the four ordered free-factor splittings. -/
theorem all_unit_histories_leave_one {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    (-3 : ℤ) + divisorCount (p * q) = 1 := by
  rw [divisorCount_apply_distinct_prime_mul hp hq hpq]
  norm_num

/-- At a prime, the all-unit coefficient is the negative single-free
packet; there is no nontrivial free-factor splitting. -/
theorem allUnitCoefficient_apply_prime {p : ℕ} (hp : p.Prime) :
    allUnitCoefficient p = -1 := by
  rw [allUnitCoefficient, divisorCount_apply_prime hp]
  norm_num

/-- A mixed semiprime has exactly two ordered nontrivial free-factor
splittings, `(p,q)` and `(q,p)`. -/
theorem nontrivial_free_splits_distinct_prime_mul {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    divisorCount (p * q) - 2 = 2 := by
  rw [divisorCount_apply_distinct_prime_mul hp hq hpq]
  norm_num

/-- The surviving semiprime coefficient is `-1 + 2 = 1`: a negative
single-free packet plus the two positive ordered nontrivial splits. -/
theorem allUnitCoefficient_apply_distinct_prime_mul {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    allUnitCoefficient (p * q) = -1 + 2 := by
  rw [allUnitCoefficient_eq_single_add_nontrivial,
    nontrivial_free_splits_distinct_prime_mul hp hq hpq]

theorem moebius_apply_distinct_prime_mul {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    ArithmeticFunction.moebius (p * q) = 1 := by
  have hcop : p.Coprime q := (Nat.coprime_primes hp hq).2 hpq
  rw [ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime hcop,
    ArithmeticFunction.moebius_apply_prime hp,
    ArithmeticFunction.moebius_apply_prime hq]
  norm_num

/-- Exact provenance identity for the mixed semiprime coefficient.  The
one-nonunit packet is zero; the surviving coefficient is entirely the
all-unit packet and equals the actual Möbius value. -/
theorem k3_mixed_semiprime_history_provenance {p q : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) :
    ((-3 : ℤ) + divisorCount (p * q)) +
        ((-3 : ℤ) * (2 * ArithmeticFunction.moebius p) +
          (3 * divisorCount q) * ArithmeticFunction.moebius p) =
      ArithmeticFunction.moebius (p * q) := by
  rw [all_unit_histories_leave_one hp hq hpq,
    one_nonunit_short_prime_histories_cancel hp hq,
    moebius_apply_distinct_prime_mul hp hq hpq]
  norm_num

#print axioms divisorCount_apply_distinct_prime_mul
#print axioms one_nonunit_short_prime_histories_cancel
#print axioms all_unit_histories_leave_one
#print axioms allUnitCoefficient_apply_prime
#print axioms nontrivial_free_splits_distinct_prime_mul
#print axioms allUnitCoefficient_apply_distinct_prime_mul
#print axioms k3_mixed_semiprime_history_provenance

end BuildingBlocks.ActualMobiusK3SemiprimeHistory
