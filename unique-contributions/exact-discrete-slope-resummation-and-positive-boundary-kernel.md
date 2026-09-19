# Verified Unique Contribution 34: Exact Discrete-Slope Boundary Resummation and Strict Positivity of the Full-Clock Möbius–Stokes Kernel

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Primary Reference:** [`building-blocks/prime-distribution/full-kappa-slope-resummation-and-major-arc-positive-packet.md`](../../building-blocks/prime-distribution/full-kappa-slope-resummation-and-major-arc-positive-packet.md)  
**Lean Formalization:** [`formalization/BuildingBlocks/KappaCoefficientPositivity.lean`](../../formalization/BuildingBlocks/KappaCoefficientPositivity.lean), [`formalization/BuildingBlocks/FullKappaSlopeFinite.lean`](../../formalization/BuildingBlocks/FullKappaSlopeFinite.lean)  
**Target Venue:** *Journal of Combinatorial Theory, Series A* or *Advances in Applied Mathematics*

---

## 1. Executive Statement of Novelty and Core Result

In the analysis of the Möbius–Stokes boundary and bilinear divisor forms $\sum_{d, e} \mu(d)\mu(e) \mathcal{G}_X(d, e)$, previous literature approximations either truncated the affine dilation weights to leading indices $a=b=1$ or assumed that discrete summation by parts yields boundary cancellation.

This work establishes the exact closed resummation of the complete two-slope clock kernel:
\[
\kappa_m = m\log m - (2m+1)\log(m+1) + (m+1)\log(m+2) \qquad (m \in \mathbb{N}_0, 0\log 0 := 0).
\]

**Theorem (Exact Slope Factorization, Unit Mass, and Factorial-Log Boundary).**  
1. **Exact Discrete Slope Difference and Positivity:** For all $m \in \mathbb{N}_0$,
   \[
   \kappa_m = g_m - g_{m+1} > 0,
   \]
   where $g_m = m\log\frac{m}{m+1}$ (with $g_0 = 0$) is the strictly concave slope primitive.
2. **Total Probability Mass:** The coefficients sum telescopingly with partial sums:
   \[
   \sum_{m=0}^N \kappa_m = (N+1)\log\frac{N+2}{N+1},
   \]
   and their total mass over all non-negative integers is identically one:
   \[
   \sum_{m=0}^\infty \kappa_m = 1 \qquad (\text{certified in Lean 4 as } \operatorname{HasSum}\ \kappa\ 1).
   \]
3. **Closed Factorial-Logarithm Rectangular Boundary:** For any integers $A, B \ge 1$, the complete rectangular sum $K(A, B) = \sum_{a=0}^{A-1}\sum_{b=0}^{B-1} \kappa_{a+b}$ evaluates exactly to:
   \[
   K(A, B) = H(\min(A, B) - 1) + H(\max(A, B) - 1) - H(A + B - 1),
   \]
   where $H(n) = \sum_{m=1}^n g_m = \log\frac{n!}{(n+1)^n}$.
4. **Strict Positivity and Monotonicity:** Every nonempty rectangle has strictly positive mass:
   \[
   K(A, B) > 0 \qquad (\forall A, B \ge 1),
   \]
   with strictly increasing boundary steps $K(A+1, B) > K(A, B)$ and $K(A, B+1) > K(A, B)$.
5. **Non-Vanishing Möbius–Stokes Bulk:** The full-slope Möbius–Stokes kernel:
   \[
   \mathcal{G}_X(d, e) = 2\int_0^\infty e^{-2v} K\!\left(\left\lfloor\frac{Xv}{d}\right\rfloor, \left\lfloor\frac{Xv}{e}\right\rfloor\right) dv
   \]
   is unconditionally positive and does not cancel the zero-frequency Type II bulk component under discrete summation by parts.

---

## 2. Mathematical Proof Architecture

### 2.1 The Telescoping Primitive and Calculus of Variations
Define the continuous interpolation $\tau(x) = x(\log(x+1) - \log x)$ on $(0, \infty)$. Its derivative is:
\[
\tau'(x) = \log\frac{x+1}{x} - \frac{1}{x+1}.
\]
Using the strict standard logarithmic inequality $\log y < y - 1$ with $y = \frac{x}{x+1} \in (0, 1)$, we obtain $-\log y > 1 - y = \frac{1}{x+1}$, whence $\tau'(x) > 0$. Therefore, $\tau$ is strictly monotonic increasing on $(0, \infty)$.
Because $\kappa_m = \tau(m+1) - \tau(m)$ by direct algebraic expansion, and $\kappa_0 = \log 2 > 0$, strict positivity $\kappa_m > 0$ holds for all $m \in \mathbb{N}_0$.

### 2.2 Telescoping Summation and Unit Total Mass
The partial sum telescopes cleanly:
\[
\sum_{m=0}^{N-1} \kappa_m = \tau(N) - \tau(0) = N\log\frac{N+1}{N} = N\log\left(1 + \frac{1}{N}\right).
\]
By the standard calculus limit $\lim_{x \to \infty} x\log(1 + 1/x) = 1$, the partial sums converge to 1, proving $\sum_{m=0}^\infty \kappa_m = 1$.

### 2.3 Double Telescoping on Rectangles
Let $g_m = -\tau(m) = m\log\frac{m}{m+1}$. The inner row sum evaluates to:
\[
\sum_{b=0}^{B-1} \kappa_{a+b} = \sum_{b=0}^{B-1} (g_{a+b} - g_{a+b+1}) = g_a - g_{a+B}.
\]
Summing over $a \in [0, A-1]$ gives:
\[
K(A, B) = \sum_{a=0}^{A-1} g_a - \sum_{a=0}^{A-1} g_{a+B} = P(A) - [P(A+B) - P(B)] = P(A) + P(B) - P(A+B),
\]
where $P(n) = \sum_{m=0}^{n-1} g_m = \sum_{m=1}^{n-1} g_m = H(n-1)$.
Ordering $r = \min(A, B)$ and $s = \max(A, B)$ yields:
\[
K(A, B) = H(r-1) + H(s-1) - H(r+s-1).
\]
Since $H(n) = \sum_{m=1}^n m(\log m - \log(m+1)) = \sum_{m=1}^n m\log m - \sum_{m=2}^{n+1} (m-1)\log m = \log(n!) - n\log(n+1)$, this establishes the closed factorial-logarithm formula.

---

## 3. Literature Comparison

| Feature | Classical Bilinear Divisor Models | Truncated Clock Approximations | This Work |
|---|---|---|---|
| **Slope Summation** | Heuristic or omitted | Truncated to $a=b=1$ | **Exact closed resummation across all $a, b \ge 1$** |
| **Clock Coefficients** | Uncertified bounds | Unsigned estimates | **Proved $\kappa_m > 0$ for all $m$ and $\sum \kappa_m = 1$** |
| **Rectangular Sum** | Uncomputed | Asymptotic upper bounds | **Exact closed formula $H(r-1)+H(s-1)-H(r+s-1)$** |
| **Boundary Sign** | Assumed vanishing | Undetermined | **Unconditionally strictly positive: $K(A, B) > 0$** |
| **Formal Verification** | None | None | **Machine-checked in Lean 4 (`KappaCoefficientPositivity.lean`, `FullKappaSlopeFinite.lean`)** |

---

## 4. Formalization and Reproducibility

- Lean 4 formalizations:
  - [`formalization/BuildingBlocks/KappaCoefficientPositivity.lean`](../../formalization/BuildingBlocks/KappaCoefficientPositivity.lean)
  - [`formalization/BuildingBlocks/FullKappaSlopeFinite.lean`](../../formalization/BuildingBlocks/FullKappaSlopeFinite.lean)
- Machine-checked under Lean 4.24.0.
- Foundational axioms: strictly `[propext, Classical.choice, Quot.sound]`.
