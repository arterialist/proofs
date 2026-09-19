# Unique Contribution 133: Exact Dirichlet Cofactor Cutoff Transfer and Proper Future Splitting

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean`](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean), [`building-blocks/primes/actual-prime-cofactor-future-finite.md`](../../building-blocks/primes/actual-prime-cofactor-future-finite.md)  
**Classification:** Analytic Number Theory / Von Mangoldt Convolution / Dirichlet Hyperbola / Proper Cofactors / Arithmetic Transfer

---

## 1. Executive Summary and Mathematical Statement

In the dual Dirichlet cancellation approach to the Riemann Hypothesis and prime distribution, transforming sums over prime powers $\sum_{n \le N} \Lambda(n) g(n)$ into smooth logarithmic moments $\sum_{n \le N} g(n) \log n$ requires an exact transfer identity. The fundamental arithmetic relation $\log = \Lambda * 1$ states that $\log n = \sum_{d \mid n} \Lambda(d)$.

This contribution proves:

1. **Exact Weighted Dirichlet Hyperbola Identity:**  
   For any truncation $N \ge 1$ and any complex test weight $g: \mathbb{N} \to \mathbb{C}$:
   \[
   \sum_{n=1}^N g(n) \log n = \sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(d k).
   \]
2. **Proper Cofactor Splitting:**  
   For any divisor $d \le N$, the cofactor sum splits into the diagonal $k = 1$ self-term and the strictly proper ($k \ge 2$) composite cofactors:
   \[
   \sum_{k=1}^{\lfloor N/d \rfloor} g(d k) = g(d) + \sum_{k=2}^{\lfloor N/d \rfloor} g(d k).
   \]
3. **Exact Cutoff Transfer Identity:**  
   Given a hard cutoff $C \in \mathbb{N}$, if the test weight satisfies the support vanishing condition $g(d) = 0$ for all $d \le C$, then:
   \[
   \operatorname{primeRow}(N, g) = \operatorname{logRow}(N, g) - \operatorname{lowFullFuture}(N, C, g) - \operatorname{highProperFuture}(N, C, g),
   \]
   where:
   - $\operatorname{primeRow}(N, g) = \sum_{n=1}^N \Lambda(n) g(n)$,
   - $\operatorname{logRow}(N, g) = \sum_{n=1}^N g(n) \log n$,
   - $\operatorname{lowFullFuture}(N, C, g) = \sum_{d \le C} \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(d k)$,
   - $\operatorname{highProperFuture}(N, C, g) = \sum_{d > C} \Lambda(d) \sum_{k=2}^{\lfloor N/d \rfloor} g(d k)$.

---

## 2. Mathematical Proof

### 2.1. Weighted Hyperbola Product
By the divisor sum formula $\log n = \sum_{d \in \operatorname{divisors}(n)} \Lambda(d)$:
\[
\sum_{n=1}^N g(n) \log n = \sum_{n=1}^N \sum_{d \mid n} \Lambda(d) g(d \cdot (n/d)).
\]
Applying the Dirichlet hyperbola rearrangement $\sum_{n \le N} \sum_{d \mid n} = \sum_{d \le N} \sum_{k \le N/d}$ with $k = n/d$:
\[
\sum_{n=1}^N g(n) \log n = \sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(d k).
\]

### 2.2. Cutoff Transfer Splitting
Split the outer sum over $d \in [1, N]$ at the cutoff $C$:
- For $d \le C$: The vanishing condition $g(d) = 0$ means $g(d \cdot 1) = 0$. Hence the full future sum $\sum_{k=1}^{\lfloor N/d \rfloor} g(dk)$ contains no self-contribution $g(d)$, and is grouped into $\operatorname{lowFullFuture}$.
- For $d > C$: The cofactor sum splits as $g(d) + \sum_{k=2}^{\lfloor N/d \rfloor} g(dk)$.
  Summing the $g(d)$ terms gives $\sum_{d=C+1}^N \Lambda(d) g(d) = \sum_{d=1}^N \Lambda(d) g(d) = \operatorname{primeRow}(N, g)$ (since $g(d) = 0$ for $d \le C$).
  Summing the $k \ge 2$ terms gives $\operatorname{highProperFuture}(N, C, g)$.
Equating and rearranging yields the exact subtraction identity.

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

- **Prior Literature:** Dirichlet convolution and hyperbola methods (Dirichlet 1849, Montgomery-Vaughan 2007). The algebraic separation into low full futures and high proper ($k \ge 2$) cofactors with machine verification in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact arithmetic transfer from prime-power sums to logarithmic moments and proper cofactors.
- **Target Venues:** *Ramanujan Journal* or *Integers*.
