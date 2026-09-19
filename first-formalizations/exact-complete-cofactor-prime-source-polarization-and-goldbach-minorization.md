# First Formalization: Exact Complete Cofactor Prime Source Polarization and Goldbach Minorization

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialBinetGoldbachFinite.lean`](../../formalization/BuildingBlocks/FactorialBinetGoldbachFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact prime-composite polarization of complete multiplicative-history cofactor sources, the 47/80 rational hard wall, and the non-negative minorization of bare Goldbach convolutions in Lean 4:

1. **Prime Source Definition and Bounds:**
   Formal definition of `primeSource`, with proofs `primeSource_prefix`, `primeSource_nonneg`, `direct_prime_le_source`, and `primeSource_le_direct_add_log`.
2. **Composite Bounds and Polarization:**
   Formal proofs of `vonMangoldt_composite_le_half_log`, `primeSource_prime_eq_direct`, `primeSource_composite_le`, and `primeSource_composite_le_rational`.
3. **Exact Sharpness at Four:**
   Formal proof of `primeSource_four`.
4. **Ordered Goldbach Pairs and Minorization:**
   Formal definition of `goldbachPair`, proof of `goldbachPair_complete_expansion`, `goldbachPair_nonneg`, and `direct_goldbach_le_pair`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact prime value of complete cofactor prime source
theorem primeSource_prime_eq_direct (v : ℕ → ℝ)
    (hv : ∀ m, 0 ≤ v m) (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2)
    {p : ℕ} (hp : p.Prime) :
    primeSource v p = v 1 * Real.log (p : ℝ)

-- General composite upper bound
theorem primeSource_composite_le (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (v 1 + v 2) / 2 * Real.log (n : ℝ)

-- Rational hard wall (47/80) under Binet ratio
theorem primeSource_composite_le_rational (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (47 / 80 : ℝ) * v 1 * Real.log (n : ℝ)

-- Exact composite sharpness at n=4
theorem primeSource_four (v : ℕ → ℝ) :
    primeSource v 4 = (v 1 + v 2) * Real.log (2 : ℝ)

-- Exact minorization of bare Goldbach pairs
theorem direct_goldbach_le_pair (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (k : ℕ) :
    (v 1) ^ 2 *
        (∑ p ∈ Finset.antidiagonal k,
          ArithmeticFunction.vonMangoldt p.1 * ArithmeticFunction.vonMangoldt p.2) ≤
      goldbachPair v k
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing that complete cofactor multiplicative sources polarize strictly between primes and composites, certifying the 47/80 rational damping ratio and proving that raw Goldbach additive totals are subrows of complete cofactor pairings.
