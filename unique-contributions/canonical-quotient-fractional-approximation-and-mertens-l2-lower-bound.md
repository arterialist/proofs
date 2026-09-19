# Contribution 59: Canonical Quotient Fractional Approximation and Mertens $L^2$ Lower Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FractionalApproximation.lean`](../../formalization/BuildingBlocks/FractionalApproximation.lean), [`formalization/BuildingBlocks/QuotientMass.lean`](../../formalization/BuildingBlocks/QuotientMass.lean)  
**Classification:** Analytic Number Theory / Nyman–Beurling Criterion / Báez-Duarte Approximation / Obstruction Theory

---

## 1. Executive Summary and Mathematical Statement

The Nyman–Beurling–Báez-Duarte criterion establishes that the Riemann Hypothesis is equivalent to the $L^2(0, 1)$ approximability of the constant function $1$ by linear combinations of fractional parts $\rho(1/(k x)) = \{1/(k x)\}$ ($1 \le k \le N$). A natural candidate for the approximation coefficients is the canonical sequence of arithmetic quotient coefficients:
$$
c_q(N) = \sum_{\substack{1 \le k \le N \\ \lfloor N/k \rfloor = q}} \mu(k) \quad (1 \le q \le N),
$$
arising directly from Dirichlet's hyperbola method and Möbius inversion.

This contribution proves:

1. **Exact Total Quotient Weight Equals Mertens:**  
   The sum of all quotient coefficients over $1 \le q \le N$ evaluates precisely to the Mertens function:
   $$
   \sum_{q=1}^N c_q(N) = M(N) = \sum_{k=1}^N \mu(k).
   $$
2. **Periodic Reciprocal Error Representation:**  
   In transformed reciprocal coordinates $y = 1/(N x)$, the approximation error $E_N(x) = 1 + \operatorname{dualApproximation}(N, x)$ is identically 1-periodic in $y$:
   $$
   R_N(y) = 1 + \sum_{q=1}^N c_q(N) \{q y\} - \{y\}, \quad R_N(y+1) = R_N(y).
   $$
3. **Mertens Quadratic $L^2$ Lower Bound:**  
   The $L^2(0, 1)$ mean square error:
   $$
   \operatorname{dualMeanSquareError}(N) = \int_0^1 (1 + \operatorname{dualApproximation}(N, x))^2 dx
   $$
   satisfies the unconditional quantitative lower bound:
   $$
   \operatorname{dualMeanSquareError}(N) \ge \frac{(M(N) + 1)^2}{16 N}.
   $$
4. **Necessary Condition for $L^2$ Convergence:**  
   As an immediate consequence:
   $$
   \frac{M(N)^2}{N} \le 32 \operatorname{dualMeanSquareError}(N) + \frac{2}{N}.
   $$
   Therefore, if the dual mean-square error tends to zero as $N \to \infty$, then necessarily:
   $$
   \frac{M(N)}{\sqrt{N}} \to 0.
   $$
   Since Odlyzko and te Riele (1985) proved that $\limsup M(N)/\sqrt{N} > 1.06$ and $\liminf M(N)/\sqrt{N} < -1.009$, this establishes a mathematical obstruction: **the canonical quotient coefficients cannot yield an $L^2$ convergent Báez-Duarte approximation**.

---

## 2. Mathematical Proof

### 2.1. Quotient Mass and Grouping
By partitioning indices $k \in \{1, \dots, N\}$ according to their floor quotient $q = \lfloor N/k \rfloor$:
$$
\sum_{q=1}^N c_q(N) = \sum_{q=1}^N \sum_{\substack{k \le N \\ \lfloor N/k \rfloor = q}} \mu(k) = \sum_{k=1}^N \mu(k) = M(N).
$$
Furthermore, the floor mass identity $\sum_{q=1}^N q \cdot c_q(N) = 1$ ensures that on average, $\sum_{q=1}^N c_q(N) \{q y\}$ tracks $y$.

### 2.2. Periodic Error in Reciprocal Coordinates
Let $y = 1/(N x)$. Then $\{q / (N x)\} = \{q y\}$, and:
$$
R_N(y) = 1 + \sum_{q=1}^N c_q(N) \{q y\} - \{y\}.
$$
Since $\{q(y+1)\} = \{q y + q\} = \{q y\}$ for integer $q$, $R_N(y+1) = R_N(y)$.
Using the integral of periodic functions over the unit interval, the integral of each $\{q y\}$ on $(0, 1)$ is $1/2$. Thus the mean value of $R_N$ is:
$$
\int_0^1 R_N(y) dy = 1 + \frac{1}{2} \sum_{q=1}^N c_q(N) - \frac{1}{2} = \frac{1}{2} + \frac{1}{2} M(N) = \frac{M(N) + 1}{2}.
$$

### 2.3. Window Energy and Cauchy–Schwarz
By restricting the integral to the window $(1/(2N), 1/N)$ where $N x \in (1/2, 1)$ (or $y \in (1, 2)$):
Applying the Cauchy–Schwarz inequality:
$$
\int_a^b f(x)^2 dx \ge \frac{1}{b-a} \left( \int_a^b f(x) dx \right)^2.
$$
Evaluating the integral on the localized window and scaling by $1/N$ yields:
$$
\operatorname{dualMeanSquareError}(N) \ge \int_{1/(2N)}^{1/N} (1 + \operatorname{dualApproximation}(N, x))^2 dx \ge \frac{(M(N) + 1)^2}{16 N}.
$$
Rearranging via $(M(N)+1)^2 = M(N)^2 + 2M(N) + 1 \ge \frac{1}{2} M(N)^2 - 1$ gives:
$$
\frac{M(N)^2}{N} \le 32 \operatorname{dualMeanSquareError}(N) + \frac{2}{N}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` namespace):
```lean
theorem quotient_coefficient_sum (N : ℕ) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) = (mertens N : ℝ)

theorem dualMeanSquareError_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualMeanSquareError N

theorem mertens_sq_le_dual_error {N : ℕ} (hN : 0 < N) :
    (mertens N : ℝ) ^ 2 / (N : ℝ) ≤ 32 * dualMeanSquareError N + 2 / (N : ℝ)

theorem mertens_sq_normalized_tendsto_of_dual_error
    (h : Tendsto dualMeanSquareError atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** The Nyman–Beurling–Báez-Duarte criterion relates RH to the existence of some coefficients $c_k$. Burnol proved zero-dependent lower bounds for arbitrary optimal coefficients. The failure of the natural arithmetic quotient coefficients via the explicit $(M(N)+1)^2/(16N)$ lower bound is novel.
- **Advancement:** Establishes explicit finite $L^2$ bound and formal deduction of the Mertens oscillation obstruction in Lean 4.
- **Target Venues:** *Journal of Approximation Theory* or *Acta Arithmetica*.
