# Contribution 171: Exact Discrete Hyperbola Cutoff Decomposition and Chebyshev Remainder Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MertensCutoff.lean`](../../formalization/BuildingBlocks/MertensCutoff.lean), [`building-blocks/primes/mertens-cutoff.md`](../../building-blocks/primes/mertens-cutoff.md)  
**Classification:** Analytic Number Theory / Multiplicative Number Theory / Hyperbola Method / Chebyshev Error / Möbius Inversion / Explicit Remainder Bounds

---

## 1. Executive Summary and Mathematical Statement

In the discrete Dirichlet hyperbola method applied to prime sums, one must split arithmetic convolutions at a cutoff threshold $K$ and bound the tail over large quotients $N/d \ge K$.

This contribution proves:

1. **Exact Reciprocal Square Root Sum Bound:**  
   For any integer $K \ge 0$:
   $$
   \sum_{d=1}^K \frac{1}{\sqrt{d}} \le 2\sqrt{K}.
   $$
   This bound is proven constructively by induction on $K$ via the real algebraic inequality $\frac{1}{\sqrt{K+1}} \le 2\sqrt{K+1} - 2\sqrt{K}$.
2. **Exact Floor Square Root Sum Bound:**  
   For any integers $N, K \ge 0$:
   $$
   \sum_{d=1}^K \sqrt{\lfloor N/d \rfloor} \le 2\sqrt{N}\sqrt{K}.
   $$
3. **Large Quotient Absolute Remainder Bound:**  
   For the centered divisor forcing $\mathcal{D}(m) = \sum_{n \le m} (\log n - d(n) + 2\gamma)$ and any $N, K \ge 1$:
   $$
   \sum_{d=1}^{\lfloor N/K \rfloor} |\mu(d) \mathcal{D}(N/d)| \le \frac{26 N}{\sqrt{K}}.
   $$
4. **Exact Discrete Cutoff Decomposition:**  
   For any $1 \le K \le N$, the centered Chebyshev prime error decomposes exactly into large and small quotients:
   $$
   \psi(N) - N + 2\gamma = \sum_{d=1}^{\lfloor N/K \rfloor} \mu(d) \mathcal{D}(N/d) + \sum_{d=\lfloor N/K \rfloor + 1}^N \mu(d) \mathcal{D}(N/d).
   $$
5. **Exact Prime Error Remainder Bound:**  
   Subtracting the small-quotient sum $\text{smallQuotientSigned}(N, K) = \sum_{d=\lfloor N/K \rfloor + 1}^N \mu(d) \mathcal{D}(N/d)$ yields the explicit non-asymptotic bound:
   $$
   \left| (\psi(N) - N + 2\gamma) - \text{smallQuotientSigned}(N, K) \right| \le \frac{26 N}{\sqrt{K}}.
   $$

---

## 2. Mathematical Proof

### 2.1. Reciprocal Square Root Sum by Induction
For $K=0$, both sides are $0$.
Assuming $\sum_{d=1}^K \frac{1}{\sqrt{d}} \le 2\sqrt{K}$, we add $\frac{1}{\sqrt{K+1}}$:
$$
2\sqrt{K+1} - 2\sqrt{K} = \frac{2((K+1) - K)}{\sqrt{K+1} + \sqrt{K}} = \frac{2}{\sqrt{K+1} + \sqrt{K}} \ge \frac{2}{2\sqrt{K+1}} = \frac{1}{\sqrt{K+1}}.
$$
Thus $\sum_{d=1}^{K+1} \frac{1}{\sqrt{d}} \le 2\sqrt{K} + (2\sqrt{K+1} - 2\sqrt{K}) = 2\sqrt{K+1}$.

### 2.2. Floor Square Root Sum
Using $\lfloor N/d \rfloor \le N/d$:
$$
\sum_{d=1}^K \sqrt{\lfloor N/d \rfloor} \le \sum_{d=1}^K \sqrt{\frac{N}{d}} = \sqrt{N} \sum_{d=1}^K \frac{1}{\sqrt{d}} \le \sqrt{N} (2\sqrt{K}) = 2\sqrt{N}\sqrt{K}.
$$

### 2.3. Large Quotient Absolute Sum
By `centeredDivisorForcing_sqrt_bound`, $|\mathcal{D}(m)| \le 13\sqrt{m}$ for all $m \ge 1$.
Since $|\mu(d)| \le 1$:
$$
\sum_{d=1}^{\lfloor N/K \rfloor} |\mu(d) \mathcal{D}(N/d)| \le 13 \sum_{d=1}^{\lfloor N/K \rfloor} \sqrt{\lfloor N/d \rfloor} \le 13 \left( 2\sqrt{N}\sqrt{\lfloor N/K \rfloor} \right) \le 26\sqrt{N} \frac{\sqrt{N}}{\sqrt{K}} = \frac{26 N}{\sqrt{K}}.
$$

### 2.4. Decomposition and Error Bound
By `centeredDivisorForcing_inverse`, $\psi(N) - N + 2\gamma = \sum_{d=1}^N \mu(d)\mathcal{D}(N/d)$.
Splitting the sum into $d \le \lfloor N/K \rfloor$ and $d > \lfloor N/K \rfloor$:
$$
\psi(N) - N + 2\gamma - \text{smallQuotientSigned}(N, K) = \sum_{d=1}^{\lfloor N/K \rfloor} \mu(d) \mathcal{D}(N/d).
$$
Applying the triangle inequality:
$$
\left| \sum_{d=1}^{\lfloor N/K \rfloor} \mu(d) \mathcal{D}(N/d) \right| \le \sum_{d=1}^{\lfloor N/K \rfloor} |\mu(d)\mathcal{D}(N/d)| \le \frac{26 N}{\sqrt{K}}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MertensTransfer` in `formalization/BuildingBlocks/MertensCutoff.lean`):
```lean
theorem reciprocal_sqrt_sum_bound (K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, 1 / Real.sqrt (d : ℝ)) ≤ 2 * Real.sqrt K

theorem floor_sqrt_sum_bound (N K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, Real.sqrt ((N / d : ℕ) : ℝ)) ≤
      2 * Real.sqrt N * Real.sqrt K

theorem largeQuotientAbsolute_bound (N K : ℕ) :
    largeQuotientAbsolute N K ≤ 26 * (N : ℝ) / Real.sqrt K

theorem centered_inverse_cutoff_decomposition {N K : ℕ} (hN : 1 ≤ N) :
    integerError N + 2 * Real.eulerMascheroniConstant =
      (∑ d ∈ Finset.Icc 1 (N / K), (ArithmeticFunction.moebius d : ℝ) *
        centeredDivisorForcing (N / d)) + smallQuotientSigned N K

theorem primeError_cutoff_remainder_bound {N K : ℕ} (hN : 1 ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - smallQuotientSigned N K| ≤
      26 * (N : ℝ) / Real.sqrt K

theorem smallQuotient_indices_iff {N K d : ℕ} (hK : 0 < K) :
    d ∈ Finset.Ioc (N / K) N ↔ d ∈ Finset.Icc 1 N ∧ N / d < K
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet hyperbola cutoff techniques (Dirichlet 1849, Tenenbaum 2015). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact non-asymptotic remainder bound $\frac{26 N}{\sqrt{K}}$ for the Chebyshev error hyperbola cutoff decomposition in Lean 4.
- **Target Venues:** *Journal of Number Theory* or *Experimental Mathematics*.
