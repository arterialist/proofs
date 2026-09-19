# Contribution 153: Exact Mertens-to-Prime-Error Hyperbola Transfer and Remainder Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/HyperbolaMertens.lean`](../../formalization/BuildingBlocks/HyperbolaMertens.lean), [`building-blocks/mertens/hyperbola-mertens.md`](../../building-blocks/mertens/hyperbola-mertens.md)  
**Classification:** Analytic Number Theory / Dirichlet Hyperbola Method / Mertens Function / Chebyshev Prime Error / Explicit Error Bounds / Discrete Abel Summation

---

## 1. Executive Summary and Mathematical Statement

Connecting bounds on the Mertens function $M(x) = \sum_{n \le x} \mu(n)$ to the Chebyshev prime-counting error $E(N) = \psi(N) - N$ is usually accomplished via contour integrals of $1/\zeta(s)$ or Tauberian arguments with implicit error terms. When using the Dirichlet hyperbola method, grouping the divisor sum by small quotients and applying discrete Abel summation yields an explicit, non-asymptotic remainder formula.

This contribution proves:

1. **Discrete Abel Summation for Centered Divisor Sequences:**  
   For any test sequence $v: \mathbb{N} \to \mathbb{R}$ and integer truncation $K \ge 1$, with centered divisor forcing $H(q) = \sum_{k \le q} c(k)$:
   $$
   \sum_{q=1}^K H(q) (v(q) - v(q+1)) = \sum_{k=1}^K c(k) v(k) - H(K) v(K+1).
   $$
2. **Exact Small-Quotient Mertens Representation:**  
   For any $K \le N$, the small-quotient signed sum evaluates to:
   $$
   S(N, K+1) = \sum_{k=1}^K c(k) M\left(\left\lfloor \frac{N}{k} \right\rfloor\right) - H(K) M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right).
   $$
3. **Certified Boundary Remainder Bound:**  
   For all integers $N, K \ge 1$:
   $$
   \left| H(K) M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right) \right| \le \frac{13 N}{\sqrt{K+1}}.
   $$
4. **Exact Explicit Mertens Transfer Theorem:**  
   For all $1 \le K \le N$:
   $$
   \left| E(N) + 2\gamma - \sum_{k=1}^K c(k) M\left(\left\lfloor \frac{N}{k} \right\rfloor\right) \right| \le \frac{39 N}{\sqrt{K+1}},
   $$
   where $\gamma$ is Euler's constant and $c(k)$ are the explicit centered divisor coefficients.

---

## 2. Mathematical Proof

### 2.1. Discrete Abel Summation Identity
By telescoping summation:
$$
\sum_{q=1}^K H(q) (v(q) - v(q+1)) = \sum_{q=1}^K H(q) v(q) - \sum_{q=2}^{K+1} H(q-1) v(q).
$$
Re-indexing and combining like terms:
$$
= H(1) v(1) + \sum_{q=2}^K (H(q) - H(q-1)) v(q) - H(K) v(K+1).
$$
Since $H(q) - H(q-1) = c(q)$ and $H(1) = c(1)$:
$$
= \sum_{k=1}^K c(k) v(k) - H(K) v(K+1).
$$

### 2.2. Evaluation on Quotient Coefficients
From `MertensCutoff.lean`, the quotient coefficients $\Delta M_N(q)$ satisfy:
$$
\Delta M_N(q) = M\left(\left\lfloor \frac{N}{q} \right\rfloor\right) - M\left(\left\lfloor \frac{N}{q+1} \right\rfloor\right).
$$
Setting $v(q) = M(\lfloor N/q \rfloor)$ in the Abel summation formula:
$$
\sum_{q=1}^K \Delta M_N(q) H(q) = \sum_{k=1}^K c(k) M\left(\left\lfloor \frac{N}{k} \right\rfloor\right) - H(K) M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right).
$$

### 2.3. Explicit Error Bounding
From `FloorCorrection.lean`, $|H(K)| \le 13 \sqrt{K+1}$.
Using the unconditional bound $|M(x)| \le x$:
$$
\left| M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right) \right| \le \frac{N}{K+1}.
$$
Multiplying the two inequalities:
$$
\left| H(K) M\left(\left\lfloor \frac{N}{K+1} \right\rfloor\right) \right| \le 13 \sqrt{K+1} \cdot \frac{N}{K+1} = \frac{13 N}{\sqrt{K+1}}.
$$
Combining this with the interior cutoff remainder bound from `MertensCutoff.lean`:
$$
|E(N) + 2\gamma - S(N, K+1)| \le \frac{26 N}{\sqrt{K+1}}.
$$
By the triangle inequality:
$$
\left| E(N) + 2\gamma - \sum_{k=1}^K c(k) M\left(\left\lfloor \frac{N}{k} \right\rfloor\right) \right| \le \frac{26 N}{\sqrt{K+1}} + \frac{13 N}{\sqrt{K+1}} = \frac{39 N}{\sqrt{K+1}}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MertensTransfer` in `formalization/BuildingBlocks/HyperbolaMertens.lean`):
```lean
theorem centered_partial_summation (v : ℕ → ℝ) (K : ℕ) :
    (∑ q ∈ Finset.Icc 1 K, centeredDivisorForcing q * (v q - v (q + 1))) =
      (∑ k ∈ Finset.Icc 1 K, centeredDivisorCoefficient k * v k) -
        centeredDivisorForcing K * v (K + 1)

theorem smallQuotientSigned_partial_summation {N K : ℕ} (hKN : K ≤ N) :
    smallQuotientSigned N (K + 1) = centeredMertensPrefix N K -
      centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)

theorem centeredMertens_boundary_bound (N K : ℕ) :
    |centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)| ≤
      13 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ)

theorem primeError_Mertens_prefix_remainder {N K : ℕ} (hN : 1 ≤ N) (hKN : K ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - centeredMertensPrefix N K| ≤
      39 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Mertens' function bounds and prime number theorem connections (Titchmarsh 1986, Tenenbaum 2015). Explicit constant versions of Mertens-to-prime transfer theorems are scarce, and none exist with fully machine-checked finite hyperbola remainder bounds.
- **Advancement:** Proves the fully explicit finite transfer theorem connecting Mertens prefix sums to the Chebyshev prime error with verified constant 39 in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
