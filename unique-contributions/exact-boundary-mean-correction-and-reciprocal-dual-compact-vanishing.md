# Unique Contribution 312: Exact Boundary Mean Correction and Reciprocal Dual Compact Vanishing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/MeanCorrection.lean`](../../formalization/BuildingBlocks/MeanCorrection.lean), [`building-blocks/fractional-approx/mean-correction.md`](../../building-blocks/fractional-approx/mean-correction.md)  
**Classification:** Analytic Number Theory / Fractional Part Approximations / Mertens Function / Dual Approximations / Mean Obstructions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dual Dirichlet approximation approach to the Riemann Hypothesis (originating in Báez-Duarte's reformulation of the Nyman–Beurling criterion), the reciprocal step error exhibits a persistent non-zero mean integral $\int_0^1 \mathcal{E}(N, y) dy = M(N) + 1/2$, where $M(N) = \sum_{k=1}^N \mu(k)$ is the Mertens function. Because this non-zero mean prevents mean-square convergence in $L^2(0, 1)$ without prior Mertens cancellation, one introduces an exact periodic boundary correction.

This contribution proves:

1. **Exact Elimination of the Periodic Mean Obstruction:**  
   The 1-periodic boundary correction:
   \[
   B(y) = \{2y\} - 2\{y\}
   \]
   has unit period mean $\int_0^1 B(y) dy = -1/2$. The mean-corrected reciprocal error:
   \[
   \mathcal{E}_{\text{corr}}(N, y) = \mathcal{E}(N, y) + (M(N) + 1) B(y)
   \]
   has exact zero mean integral over the unit period:
   \[
   \int_0^1 \mathcal{E}_{\text{corr}}(N, y) dy = 0 \qquad (\forall N \in \mathbb{N}).
   \]
2. **Exact Reciprocal Duality of the Mean-Corrected Profile:**  
   Defining the mean-corrected dual step function:
   \[
   \mathcal{D}_{\text{corr}}(N, x) = \mathcal{D}(N, x) + (M(N) + 1) B\left(\frac{1}{Nx}\right),
   \]
   the exact reciprocal duality identity holds for all $y \ne 0$:
   \[
   1 + \mathcal{D}_{\text{corr}}\left(N, \frac{1}{Ny}\right) = \mathcal{E}_{\text{corr}}(N, y).
   \]
3. **Exact Compact Vanishing Outside the Unit Interval:**  
   For all $N \ge 2$ and all $x > 1$:
   \[
   \mathcal{D}_{\text{corr}}(N, x) = 0.
   \]
   The mean correction does not leak outside $(0, 1]$ because for $x > 1$ and $N \ge 2$, the argument satisfies $2 / (Nx) < 1$, causing $B(1 / (Nx)) = 2/(Nx) - 2(1/(Nx)) = 0$ identically.
4. **Uniform $L^\infty$ Stability:**  
   The boundary correction is uniformly bounded on $\mathbb{R}$:
   \[
   |B(y)| \le 3 \qquad (\forall y \in \mathbb{R}).
   \]
5. **Certified $L^2$ Integrability of the Squared Error:**  
   The squared error $(1 + \mathcal{D}_{\text{corr}}(N, x))^2$ is interval integrable on any bounded interval $[a, b] \subset \mathbb{R}$.

---

## 2. Mathematical Proof

### 2.1. Mean Evaluation
By the scaling property of the fractional part integral:
\[
\int_0^1 \{2y\} dy = \frac{1}{2} \int_0^2 \{u\} du = \frac{1}{2} (1/2 + 1/2) = \frac{1}{2}.
\]
Since $\int_0^1 \{y\} dy = 1/2$:
\[
\int_0^1 B(y) dy = \int_0^1 \{2y\} dy - 2 \int_0^1 \{y\} dy = \frac{1}{2} - 2\left(\frac{1}{2}\right) = -\frac{1}{2}.
\]
From `reciprocalError_mean_zero_one`, $\int_0^1 \mathcal{E}(N, y) dy = \frac{M(N) + 1}{2}$.
Thus:
\[
\int_0^1 \mathcal{E}_{\text{corr}}(N, y) dy = \frac{M(N) + 1}{2} + (M(N) + 1)\left(-\frac{1}{2}\right) = 0.
\]

### 2.2. Compact Support Vanishing
For $x > 1$ and $N \ge 2$:
$Nx > 2 \implies \frac{2}{Nx} < 1$.
For $0 \le y < 1/2$, $2y < 1$, so $\{2y\} = 2y$ and $\{y\} = y$.
Thus $B(y) = 2y - 2(y) = 0$.
Applying this to $y = \frac{1}{Nx}$ gives $B\left(\frac{1}{Nx}\right) = 0$.
Combined with $\mathcal{D}(N, x) = 0$ for $x > 1$, this proves $\mathcal{D}_{\text{corr}}(N, x) = 0$.

### 2.3. Duality
By definition:
\[
1 + \mathcal{D}_{\text{corr}}\left(N, \frac{1}{Ny}\right) = 1 + \mathcal{D}\left(N, \frac{1}{Ny}\right) + (M(N) + 1) B\left(\frac{1}{N(1/(Ny))}\right) = \mathcal{E}(N, y) + (M(N) + 1) B(y) = \mathcal{E}_{\text{corr}}(N, y).
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.MeanCorrection` in `formalization/BuildingBlocks/MeanCorrection.lean`):
```lean
theorem boundaryCorrection_mean : (∫ y in (0 : ℝ)..1, boundaryCorrection y) = -1 / 2

theorem meanCorrectedDual_reciprocal {N : ℕ} (hN : 0 < N) {y : ℝ} (hy : y ≠ 0) :
    1 + meanCorrectedDual N (1 / ((N : ℝ) * y)) = meanCorrectedError N y

theorem meanCorrectedError_mean_zero (N : ℕ) :
    (∫ y in (0 : ℝ)..1, meanCorrectedError N y) = 0

theorem meanCorrectedDual_zero_above_one {N : ℕ} (hN : 2 ≤ N) {x : ℝ} (hx : 1 < x) :
    meanCorrectedDual N x = 0

theorem meanCorrectedDual_sq_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun x => (1 + meanCorrectedDual N x) ^ 2) volume a b
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Nyman (1950) *On the One-Sided Harmonic Analysis of Certain Linear Spaces*; Beurling (1955) *A Closure Problem Related to the Riemann Zeta-Function*; Báez-Duarte (2003) *A strengthening of the Nyman-Beurling criterion*. Machine verification of exact periodic mean corrections, dual reciprocity, and compact support vanishing in Lean 4 is new.
- **Advancement:** Resolves the non-zero mean obstruction of the Nyman–Beurling step approximation with an explicit boundary correction that preserves compact support on $(0, 1]$ and reciprocal duality.
- **Target Venues:** *Journal of Number Theory* or *Ramanujan Journal*.
