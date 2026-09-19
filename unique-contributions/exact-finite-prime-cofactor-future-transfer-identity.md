# Unique Contribution 93: Exact Finite Prime-Cofactor Future Transfer Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean`](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean), [`formalization/BuildingBlocks/HyperbolaProduct.lean`](../../formalization/BuildingBlocks/HyperbolaProduct.lean)  
**Classification:** Analytic Number Theory / Arithmetic Functions / Dirichlet Hyperbola / Proper Cofactor Transfer

---

## 1. Executive Summary and Mathematical Statement

The explicit formula relies on controlling prime sums $\sum_{p \le N} \log p$ or von Mangoldt sums $\sum_{n \le N} \Lambda(n) g(n)$ against test functions $g$. In the classical Dirichlet hyperbola method, the divisor sum identity $\Lambda * 1 = \log$ is used asymptotically. 

This contribution proves:

1. **Exact Weighted Logarithmic-Divisor Hyperbola Identity:**  
   For any complex-valued test sequence $g : \mathbb{N} \to \mathbb{C}$ and any truncation cutoff $N \ge 1$:
   \[
   \sum_{n=1}^N (\log n) g(n) = \sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(dk).
   \]
   This holds exactly with no error terms, retaining every prime power and every boundary endpoint.
2. **Cofactor Cutoff Decomposition:**  
   For any hard cutoff $C \in \mathbb{N}$, if the test weight vanishes on low prime powers ($g(d) = 0$ for all $d \le C$), then the prime power sum decomposes exactly into:
   \[
   \operatorname{primeRow}(N, g) = \operatorname{logRow}(N, g) - \operatorname{lowFullFuture}(N, C, g) - \operatorname{highProperFuture}(N, C, g),
   \]
   where:
   - $\operatorname{primeRow}(N, g) = \sum_{n=1}^N \Lambda(n) g(n)$,
   - $\operatorname{logRow}(N, g) = \sum_{n=1}^N (\log n) g(n)$,
   - $\operatorname{lowFullFuture}(N, C, g) = \sum_{d \le C} \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(dk)$,
   - $\operatorname{highProperFuture}(N, C, g) = \sum_{C < d \le N} \Lambda(d) \sum_{k=2}^{\lfloor N/d \rfloor} g(dk)$.
3. **Proper-Cofactor Elimination of Trivial Multipliers:**  
   Because $g(d) = 0$ for $d \le C$, the $k = 1$ term in $\operatorname{lowFullFuture}$ vanishes identically. Meanwhile, for $d > C$, the $k = 1$ term forms the left-hand side $\operatorname{primeRow}(N, g)$, leaving strictly proper cofactors $k \ge 2$ in $\operatorname{highProperFuture}$.
4. **Architectural Significance:**  
   This provides the exact algebraic skeleton for proper-cofactor transfer: the prime row is represented as a smooth logarithmic row minus strictly composite proper-cofactor futures, with zero asymptotic estimation error.

---

## 2. Mathematical Proof

### 2.1. Exact Divisor Sum Inversion
By von Mangoldt's identity, $\log n = \sum_{d | n} \Lambda(d)$.
Multiplying by $g(n)$ and summing over $n \in [1, N]$:
\[
\sum_{n=1}^N (\log n) g(n) = \sum_{n=1}^N \sum_{d | n} \Lambda(d) g\left(d \cdot \frac{n}{d}\right).
\]
Exchanging the order of summation over the hyperbola region $\{(d, k) \in \mathbb{N}^2 : 1 \le d \le N, 1 \le k \le N/d\}$ gives:
\[
\sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(dk).
\]

### 2.2. Splitting Across Cutoff $C$
Splitting the outer sum over $d \le C$ and $d > C$:
- For $d > C$, splitting $k = 1$ from $k \ge 2$:
  \[
  \sum_{k=1}^{\lfloor N/d \rfloor} g(dk) = g(d) + \sum_{k=2}^{\lfloor N/d \rfloor} g(dk).
  \]
  Summing $\Lambda(d) g(d)$ over $d > C$ (and using $g(d) = 0$ for $d \le C$) gives the entire sum $\sum_{n=1}^N \Lambda(n) g(n) = \operatorname{primeRow}(N, g)$.
- For $d \le C$, the entire sum is defined as $\operatorname{lowFullFuture}(N, C, g)$, where the $k = 1$ term $g(d) = 0$ vanishes by assumption.
- The remaining terms for $d > C$ with $k \ge 2$ form $\operatorname{highProperFuture}(N, C, g)$.
Equating and rearranging yields the transfer identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualPrimeCofactorFutureFinite`):
```lean
theorem weighted_log_eq_complete_future (N : ℕ) (g : ℕ → ℂ) :
    (∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n) =
      ∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
        ∑ k ∈ Icc 1 (N / d), g (d * k)

theorem cofactor_cutoff_transfer (N C : ℕ) (g : ℕ → ℂ)
    (hvanish : ∀ d, d ≤ C → g d = 0) :
    primeRow N g = logRow N g - lowFullFuture N C g - highProperFuture N C g
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** The hyperbola identity $\sum_{n \le N} (\log n) g(n) = \sum_{d \le N} \Lambda(d) \sum_{k \le N/d} g(dk)$ is standard in Dirichlet divisor problems. However, the exact finite algebraic splitting isolating proper cofactors $k \ge 2$ via support vanishing without asymptotic errors is a novel formulation.
- **Advancement:** Establishes the exact algebraic proper-cofactor transfer identity for arbitrary complex test weights.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
