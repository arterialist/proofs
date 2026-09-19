# First Formalization: Exact Same-Prime and Distinct-Prime Convolution Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergDistinctPrimes.lean`](../../formalization/BuildingBlocks/SelbergDistinctPrimes.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact orthogonal decomposition of the Dirichlet auto-convolution $(\Lambda * \Lambda)(n)$ into a same-prime component supported purely on proper prime powers $p^k$ ($k \ge 2$) and a distinct-prime component represented by an exact coprime divisor sum in Lean 4:

1. **Orthogonal Convolution Splitting:**
   Formal proof of $(\Lambda * \Lambda)(n) = W_{\text{same}}(n) + W_{\text{distinct}}(n)$ (`vonMangoldt_convolution_same_distinct`).
2. **Proper Power Support and Evaluation:**
   Formal proof that $W_{\text{same}}(p^k) = (k-1)\log^2 p$ (`samePrimePairWeight_prime_pow`) and that $W_{\text{same}}(n) = 0$ unless $n = p^k$ with $k \ge 2$ (`samePrimePairWeight_eq_zero_unless_proper_power`).
3. **Coprime Divisor Representation of Distinct-Prime Weight:**
   Formal proof that $W_{\text{distinct}}(n) = \sum_{d \mid n, \, \gcd(d, n/d)=1} \Lambda(d) \Lambda(n/d)$ (`distinctPrimePairWeight_eq_coprime_sum`) and $W_{\text{distinct}}(n) \ge 0$ (`distinctPrimePairWeight_nonneg`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Same-prime weight on prime powers
theorem samePrimePairWeight_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k) :
    samePrimePairWeight (p ^ k) = ((k : ℝ) - 1) * Real.log (p : ℝ) ^ 2

-- Vanishing unless n is a proper prime power p^k with k ≥ 2
theorem samePrimePairWeight_eq_zero_unless_proper_power {n : ℕ}
    (hn : ¬∃ p k : ℕ, p.Prime ∧ 2 ≤ k ∧ p ^ k = n) :
    samePrimePairWeight n = 0

-- Auto-convolution of von Mangoldt on prime powers
theorem vonMangoldt_convolution_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k) :
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) (p ^ k) =
      ((k : ℝ) - 1) * Real.log (p : ℝ) ^ 2

-- Coprime divisor representation of distinct-prime weight
theorem distinctPrimePairWeight_eq_coprime_sum (n : ℕ) :
    distinctPrimePairWeight n =
      ∑ d ∈ n.divisors,
        if d.Coprime (n / d) then
          ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d)
        else 0

-- Non-negativity of distinct-prime weight
theorem distinctPrimePairWeight_nonneg (n : ℕ) : 0 ≤ distinctPrimePairWeight n

-- Exact orthogonal splitting of von Mangoldt auto-convolution
theorem vonMangoldt_convolution_same_distinct (n : ℕ) :
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n =
      samePrimePairWeight n + distinctPrimePairWeight n
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact orthogonal decomposition of $\Lambda * \Lambda$ into proper-power same-prime weights and coprime distinct-prime sums without asymptotic error terms.
