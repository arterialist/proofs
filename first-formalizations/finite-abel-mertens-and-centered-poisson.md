# Exact Finite Abel Summation for Möbius Generating Functions and Nonnegative Centered Poisson Kernels

**Authors:** Arterialist Formalization Team  
**Date:** September 2026  
**Lean 4 Version:** 4.24.0  
**Mathlib Commit:** 2026-09-15  
**Target Modules:** `BuildingBlocks.ActualFiniteAbelMertens`, `BuildingBlocks.ActualCenteredPoissonKernel`  
**Foundational Axioms:** Standard Lean 4 foundations (`[propext, Classical.choice, Quot.sound]`), zero custom axioms, zero `sorry` placeholders.

---

## 1. Mathematical Overview

The analytical investigation of prime distributions and the Mertens function $M(N) = \sum_{n=1}^N \mu(n)$ at finite scales often relies on Abel summation, exponential generating functions, and Poisson kernels. Classical treatments invoke infinite series and complex contour integration, obscuring finite-cutoff boundary tracking.

This formalization provides exact, non-asymptotic discrete identities for both the truncated Möbius exponential sum and the centered Poisson covariance kernel:

1. **Exact Finite Abel Summation with Retained Terminal Mertens Term:**
   For any $N \in \mathbb{N}$ and parameter $q \in \mathbb{R}$:
   \[
    \sum_{n=1}^N \mu(n) q^n = M(N) q^N + (1 - q) \sum_{k=0}^{N-1} M(k) q^k.
   \]
   This retains the boundary term $M(N) q^N$ exactly without any asymptotic remainder.

2. **Differentiability and Finite Derivative Bounds:**
   For the truncated exponential sum $E_N(t) := \sum_{n=1}^N \mu(n) e^{-nt}$, Mathlib's differential calculus (`HasDerivAt`) is deployed to establish exact termwise differentiation at all $t \in \mathbb{R}$:
   \[
    \frac{d}{dt} E_N(t) = -\sum_{n=1}^N \mu(n) n e^{-nt},
   \]
   together with the unconditional finite derivative bound:
   \[
    |E_N'(t)| \le \sum_{n=1}^N n e^{-nt},
   \]
   valid for all $N$ without requiring infinite series convergence or analytic continuation.

3. **Centered Poisson Covariance Kernel Nonnegativity:**
   For the discrete Poisson kernel with discount parameter $q \in [0, 1]$, the centered covariance between horizons $n$ and $m$ factors into an exact geometric sum:
   \[
    q^{\max(n, m)} - q^{n+m} = (1 - q) \sum_{k=0}^{\min(n, m) - 1} q^{\max(n, m) + k} \ge 0.
   \]
   This proves that the centered Poisson covariance is unconditionally non-negative across all pairs $(n, m)$.

4. **Consecutive Grid Gap Identity:**
   For consecutive integer sampling rates $2/X$, the gap is explicitly:
   \[
    \frac{2}{X} - \frac{2}{X+1} = \frac{2}{X(X+1)} > 0 \qquad (X \ge 1).
   \]

---

## 2. Formalization Details and Verified Signatures

### 2.1 Truncated Abel Summation and Derivatives (`ActualFiniteAbelMertens.lean`)

```lean
/-- Exact finite Abel summation with retained terminal Mertens term. -/
theorem truncated_mobius_abel (N : ℕ) (q : ℝ) :
    truncatedMobiusPower N q =
      finiteMertens N * q ^ N +
        (1 - q) * ∑ k ∈ range N, finiteMertens k * q ^ k

/-- Absolute value of actual Möbius coefficient is at most 1. -/
theorem abs_mobiusReal_le_one (n : ℕ) : |mobiusReal n| ≤ 1

/-- Truncated exponential Möbius sum has exact finite derivative. -/
theorem hasDerivAt_truncatedMobiusExp (N : ℕ) (t : ℝ) :
    HasDerivAt (truncatedMobiusExp N) (truncatedMobiusDerivative N t) t

/-- Finite truncation derivative bound. -/
theorem abs_truncatedMobiusDerivative_le (N : ℕ) (t : ℝ) :
    |truncatedMobiusDerivative N t| ≤
      ∑ k ∈ range N, ((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t)

/-- Exact integer grid gap. -/
theorem integer_grid_gap (X : ℕ) (hX : 1 ≤ X) :
    (2 : ℝ) / X - 2 / (X + 1) = 2 / (X * (X + 1))
```

### 2.2 Centered Poisson Covariance Kernel (`ActualCenteredPoissonKernel.lean`)

```lean
/-- Centered Poisson kernel factors as an exact positive geometric tail. -/
theorem centeredKernel_eq_tail (q : ℝ) (n m : ℕ) :
    q ^ max n m - q ^ (n + m) =
      (1 - q) * ∑ k ∈ range (min n m), q ^ (max n m + k)

/-- Nonnegativity of the centered Poisson kernel for 0 ≤ q ≤ 1. -/
theorem centeredKernel_nonneg {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1)
    (n m : ℕ) : 0 ≤ q ^ max n m - q ^ (n + m)
```

---

## 3. Axiomatic Foundations and Verification

Verification performed via `lake env lean`:
```bash
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualFiniteAbelMertens.lean
```
Axiom check output:
```
'BuildingBlocks.ActualCenteredPoissonKernel.centeredKernel_eq_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCenteredPoissonKernel.centeredKernel_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.truncated_mobius_abel' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.abs_mobiusReal_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.hasDerivAt_truncatedMobiusExp' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.abs_truncatedMobiusDerivative_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.integer_grid_gap' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualFiniteAbelMertens.integer_grid_gap_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry` placeholders.

---

## 4. Comparison with Formalized Literature

1. **Mathlib:** Mathlib includes `moebius` in `NumberTheory.ArithmeticFunction` and basic summation by parts (`Finset.sum_range_by_parts`), but lacks the exact terminal-retained Abel identity specialized to the Mertens state function, the termwise `HasDerivAt` proof for truncated exponential Möbius sums, and the centered Poisson covariance kernel decomposition into geometric tails.
2. **AFP / Coq:** Existing formalizations of the Prime Number Theorem (e.g. Harrison in HOL Light, Eberl in Isabelle/AFP) work primarily with asymptotic $O$-bounds and complex integrals rather than exact finite discrete operator identities.
3. **Novelty:** This is the first machine-verified proof of exact finite Abel summation for the physical Möbius sequence with retained boundary term and exact geometric tail factoring for centered Poisson covariance.
