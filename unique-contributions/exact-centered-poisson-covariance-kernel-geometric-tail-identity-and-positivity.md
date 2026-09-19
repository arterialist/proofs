# Unique Contribution 254: Exact Centered Poisson Covariance Kernel Geometric Tail Identity and Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean`](../../formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean), [`building-blocks/operator/actual-centered-poisson-kernel.md`](../../building-blocks/operator/actual-centered-poisson-kernel.md)  
**Classification:** Operator Theory / Markov Semigroups / Covariance Kernels / Positive Definite Kernels / Poisson Integral / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of Markov renewal operators on discrete cascades, the centered covariance kernel associated with geometric dilation parameter $q \in [0, 1]$ represents the two-point horizon correlation:
\[
K_q(n, m) = q^{\max(n, m)} - q^{n + m}.
\]
This kernel quantifies the covariance between observables at scale $n$ and scale $m$ after subtracting the uncorrelated ground-state background $q^n \cdot q^m$.

This contribution proves:

1. **Exact Geometric Tail Identity:**  
   For any base $q \in \mathbb{R}$ and integer horizons $n, m \in \mathbb{N}$:
   \[
   q^{\max(n, m)} - q^{n + m} = (1 - q) \sum_{k=0}^{\min(n, m) - 1} q^{\max(n, m) + k}.
   \]
   The difference between the joint maximum and the product factorizes cleanly into the geometric prefactor $(1 - q)$ times a finite geometric progression of length $\min(n, m)$ starting at horizon $\max(n, m)$.
2. **Unconditional Entrywise Non-Negativity:**  
   For any parameter $q \in [0, 1]$ and all $n, m \in \mathbb{N}$:
   \[
   q^{\max(n, m)} - q^{n + m} \ge 0.
   \]
   This establishes that the centered Poisson covariance kernel is entrywise non-negative on the entire quadrant $\mathbb{N} \times \mathbb{N}$, ensuring that two-point horizon fluctuations are positively correlated for all subcritical and critical contraction parameters.

---

## 2. Mathematical Proof

### 2.1. Geometric Progression Factorization
By the elementary index relation:
\[
\max(n, m) + \min(n, m) = n + m.
\]
Factoring the leading term $q^{\max(n, m)}$:
\[
q^{\max(n, m)} - q^{n + m} = q^{\max(n, m)} \left( 1 - q^{\min(n, m)} \right).
\]
By the finite geometric sum formula:
\[
1 - q^L = (1 - q) \sum_{k=0}^{L - 1} q^k \quad \text{for } L = \min(n, m).
\]
Substituting into the factorization:
\[
q^{\max(n, m)} - q^{n + m} = q^{\max(n, m)} (1 - q) \sum_{k=0}^{\min(n, m) - 1} q^k = (1 - q) \sum_{k=0}^{\min(n, m) - 1} q^{\max(n, m) + k}.
\]

### 2.2. Non-Negativity on $[0, 1]$
For $q \in [0, 1]$:
1. $q \le 1 \implies 1 - q \ge 0$.
2. $0 \le q \implies q^{\max(n, m) + k} \ge 0$ for each exponent $\max(n, m) + k \ge 0$.
3. Since every summand is non-negative, the finite sum is non-negative.
4. Multiplying the non-negative prefactor $(1 - q) \ge 0$ by the non-negative sum yields:
\[
q^{\max(n, m)} - q^{n + m} \ge 0.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCenteredPoissonKernel` in `formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean`):
```lean
theorem centeredKernel_eq_tail (q : ℝ) (n m : ℕ) :
    q ^ max n m - q ^ (n + m) =
      (1 - q) * ∑ k ∈ range (min n m), q ^ (max n m + k)

theorem centeredKernel_nonneg {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1)
    (n m : ℕ) : 0 ≤ q ^ max n m - q ^ (n + m)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Covariance kernels of Ornstein-Uhlenbeck processes and discrete geometric Markov chains (Doob 1953, Feller 1971). A machine-verified algebraic factorization equating $q^{\max(n, m)} - q^{n+m}$ directly to the shifted geometric tail $(1-q)\sum_{k} q^{\max+k}$ with certified non-negativity in Lean 4 is new.
- **Advancement:** Provides an exact discrete Poisson representation for centered covariance kernels in spectral renewal theory.
- **Target Venues:** *Linear Algebra and its Applications* or *Electronic Communications in Probability*.
