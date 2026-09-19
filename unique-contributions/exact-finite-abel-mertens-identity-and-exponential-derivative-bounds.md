# Unique Contribution 94: Exact Finite Abel-Mertens Identity and Exponential Derivative Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualFiniteAbelMertens.lean`](../../formalization/BuildingBlocks/ActualFiniteAbelMertens.lean)  
**Classification:** Analytic Number Theory / Abel Summation / Mertens Function / Exponential Sum Derivatives

---

## 1. Executive Summary and Mathematical Statement

The Mertens function $M(N) = \sum_{n=1}^N \mu(n)$ governs the reciprocal of the Riemann zeta function $1/\zeta(s) = \sum \mu(n) n^{-s}$. Connecting power series $\sum \mu(n) q^n$ and exponential sums $\sum \mu(n) e^{-nt}$ to $M(N)$ traditionally relies on continuous Abel summation by parts.

This contribution proves:

1. **Exact Finite Abel-Mertens Identity:**  
   For any $N \in \mathbb{N}$ and any $q \in \mathbb{R}$:
   \[
   \sum_{n=1}^N \mu(n) q^n = M(N) q^N + (1 - q) \sum_{k=0}^{N-1} M(k) q^k.
   \]
   This formula is exact for all $N$, preserving the explicit terminal boundary term $M(N) q^N$ without any integral approximation or asymptotic error.
2. **Exact Fréchet Derivative of Finite Exponential Möbius Sums:**  
   The finite exponential sum $E_N(t) = \sum_{n=1}^N \mu(n) e^{-nt}$ is continuously differentiable on $\mathbb{R}$, with exact derivative:
   \[
   E_N'(t) = -\sum_{k=0}^{N-1} \mu(k+1) (k+1) e^{-(k+1)t}.
   \]
3. **Non-Asymptotic Absolute Derivative Majorization:**  
   For all $N \ge 1$ and all $t \in \mathbb{R}$:
   \[
   |E_N'(t)| \le \sum_{k=0}^{N-1} (k+1) e^{-(k+1)t},
   \]
   holding unconditionally with no reliance on the Riemann Hypothesis or infinite series convergence.
4. **Consecutive Integer Sampling Gap Identity:**  
   For any integer grid scale $X \ge 1$, the spacing between consecutive inverse grid points satisfies the exact positive identity:
   \[
   \frac{2}{X} - \frac{2}{X+1} = \frac{2}{X(X+1)} > 0.
   \]
5. **Architectural Significance:**  
   Provides the exact non-asymptotic bridge transferring bounds on the discrete Mertens sequence $M(k)$ directly into analytic properties of generating functions and exponential kernels.

---

## 2. Mathematical Proof

### 2.1. Exact Finite Abel Summation
By definition, $M(0) = 0$ and $M(N+1) = M(N) + \mu(N+1)$.
We proceed by induction on $N$.
- Base case $N = 0$: both sides evaluate to $0$.
- Inductive step:
  \[
  \sum_{n=1}^{N+1} \mu(n) q^n = \sum_{n=1}^N \mu(n) q^n + \mu(N+1) q^{N+1}.
  \]
  Substituting the inductive hypothesis:
  \[
  M(N) q^N + (1-q) \sum_{k=0}^{N-1} M(k) q^k + \mu(N+1) q^{N+1}.
  \]
  Adding and subtracting $M(N) q^{N+1}$:
  \[
  (M(N) + \mu(N+1)) q^{N+1} + M(N) q^N - M(N) q^{N+1} + (1-q) \sum_{k=0}^{N-1} M(k) q^k.
  \]
  Since $M(N+1) = M(N) + \mu(N+1)$ and $M(N) q^N - M(N) q^{N+1} = (1-q) M(N) q^N$, combining terms gives:
  \[
  M(N+1) q^{N+1} + (1-q) \sum_{k=0}^N M(k) q^k.
  \]

### 2.2. Derivative Computation and Absolute Bound
Each term $t \mapsto \mu(n) e^{-nt}$ has derivative $-\mu(n) n e^{-nt}$. Summing linearly gives $E_N'(t)$.
Since $|\mu(n)| \le 1$ for all $n \in \mathbb{N}$ and $n e^{-nt} \ge 0$, applying the triangle inequality yields $|E_N'(t)| \le \sum_{n=1}^N n e^{-nt}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualFiniteAbelMertens`):
```lean
theorem truncated_mobius_abel (N : ℕ) (q : ℝ) :
    truncatedMobiusPower N q =
      finiteMertens N * q ^ N +
        (1 - q) * ∑ k ∈ range N, finiteMertens k * q ^ k

theorem hasDerivAt_truncatedMobiusExp (N : ℕ) (t : ℝ) :
    HasDerivAt (truncatedMobiusExp N) (truncatedMobiusDerivative N t) t

theorem abs_truncatedMobiusDerivative_le (N : ℕ) (t : ℝ) :
    |truncatedMobiusDerivative N t| ≤
      ∑ k ∈ range N, ((k + 1 : ℕ) : ℝ) *
        Real.exp (-((k + 1 : ℕ) : ℝ) * t)

theorem integer_grid_gap (X : ℕ) (hX : 1 ≤ X) :
    (2 : ℝ) / X - 2 / (X + 1) = 2 / (X * (X + 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Abel summation for Dirichlet series is classical (Hardy–Riesz 1915). However, the recursive machine formalization of the exact discrete Abel identity with the terminal boundary Mertens term $M(N) q^N$ and its exact exponential derivative bound had not been cataloged in Lean.
- **Advancement:** Establishes exact non-asymptotic Abel-Mertens identities and exponential derivative bounds.
- **Target Venues:** *Integers* or *Ramanujan Journal*.
