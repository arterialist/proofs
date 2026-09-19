# First Formalization: Exact Hyperbola Product Grouping and Sub-Root Möbius Annihilation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/HyperbolaProduct.lean`](../../formalization/BuildingBlocks/HyperbolaProduct.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact bijection between divisor pairs and bounded factor pairs, the definition of hyperbola product coefficients $c_N(k)$, the sub-root annihilation theorem ($c_N(k) = 0$ for $2 \le k \le \sqrt{N}$), the complementary cutoff representation, and the general weighted hyperbola product identity in Lean 4:

1. **Exact Factor-Pair Bijection:**
   Formal proof of $\sum_{n \le N} \sum_{d \mid n} f(d, n/d) = \sum_{a \le N} \sum_{b \le N/a} f(a, b)$ (`sum_divisors_eq_sum_factor_pairs`).
2. **Sub-Root Annihilation:**
   Formal proof that $c_N(k) = \mathbf{1}_{k=1}$ whenever $k^2 \le N$ (`hyperbolaProductCoefficient_small`).
3. **Complementary Cutoff Formula:**
   Formal proof of $c_N(k) = -\sum_{d \mid k, Nd < k^2} \mu(d)$ for $k \ne 1$ (`hyperbolaProductCoefficient_complement`).
4. **General Weighted Hyperbola Identity:**
   Formal proof that $\sum_{k \le N} c_N(k) w(k) = \sum_{n \le N} \mu(n) \sum_{m \le \sqrt{N/n}} w(nm)$ (`hyperbolaProductCoefficient_weighted_sum`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Factor-pair hyperbola bijection
theorem sum_divisors_eq_sum_factor_pairs {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    ∑ n ∈ Finset.Icc 1 N, ∑ d ∈ n.divisors, f d (n / d) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a), f a b

-- Divisor sum of Moebius function
theorem moebius_divisor_sum (n : ℕ) :
    ∑ d ∈ n.divisors, ArithmeticFunction.moebius d = if n = 1 then 1 else 0

-- Sub-root annihilation of hyperbola product coefficients
theorem hyperbolaProductCoefficient_small {N k : ℕ} (hk : k * k ≤ N) :
    hyperbolaProductCoefficient N k = if k = 1 then 1 else 0

-- Complementary cutoff representation
theorem hyperbolaProductCoefficient_complement {N k : ℕ} (hk : k ≠ 1) :
    hyperbolaProductCoefficient N k =
      -(∑ d ∈ k.divisors, if N * d < k * k then ArithmeticFunction.moebius d else 0)

-- General weighted hyperbola product identity
theorem hyperbolaProductCoefficient_weighted_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ k ∈ Icc 1 N, (hyperbolaProductCoefficient N k : ℝ) * w k) =
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ∑ m ∈ Icc 1 (N / n).sqrt, w (n * m)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact algebra of hyperbola product coefficients, explicit factor-pair bijection, and sub-root annihilation for Dirichlet hyperbola sums.
