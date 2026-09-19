# Unique Contribution 223: Exact Coercive Lower Bound and Terminal Energy Splitting in Logarithmic Metric

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenMetric.lean), [`building-blocks/charge/charge-frozen-metric.md`](../../building-blocks/charge/charge-frozen-metric.md)  
**Classification:** Real Analysis / Analytic Number Theory / Energy Methods / Chebyshev Bounds / Coercive Inequalities / Measure Theory

---

## 1. Executive Summary and Mathematical Statement

In the quantitative analysis of the prime number theorem and the Riemann Hypothesis, a crucial question is how physical-space $L^2$ norms of causal arithmetic sources relate to the classical Chebyshev error term $|\psi(N) - N|$.

This contribution proves:

1. **Exact Terminal Asymptotics in Logarithmic Metric:**  
   For any truncation level $N \ge 2$, on the tail region $v > \log N$, the causal arithmetic source takes the exact form:
   \[
   \text{causalSource}(N, v) = (\psi(N) - N) e^{-v/2}.
   \]
2. **Exact Terminal Square Integral:**  
   The tail energy in the logarithmic coordinate $v = \log x$ evaluates exactly without approximations to:
   \[
   \int_{\log N}^\infty (\text{causalSource}(N, v))^2 \, dv = \frac{(\psi(N) - N)^2}{N}.
   \]
3. **Exact Domain Decomposition:**  
   The total positive $L^2$ energy splits into an interior prefix integral and the exact terminal boundary quotient:
   \[
   \int_0^\infty (\text{causalSource}(N, v))^2 \, dv = \int_0^{\log N} (\text{causalSource}(N, v))^2 \, dv + \frac{(\psi(N) - N)^2}{N}.
   \]
4. **Unconditional Coercive Lower Bound:**  
   The total $L^2$ energy of the causal prime source strictly and coercively bounds the normalized Chebyshev error from below:
   \[
   \frac{(\psi(N) - N)^2}{N} \le \int_0^\infty (\text{causalSource}(N, v))^2 \, dv.
   \]
   Consequently, any uniform bound $\int_0^\infty (\text{causalSource}(N, v))^2 dv \le C$ unconditionally forces the sharp Riemann-hypothesis-type prime error bound:
   \[
   |\psi(N) - N| \le C^{1/2} N^{1/2}.
   \]

---

## 2. Mathematical Proof

### 2.1. Tail Formula
For $v > \log N$, $e^v > N$.
In the definition of $\text{source}(N, v) = (\psi(\lfloor \min(e^v, N) \rfloor) - \min(e^v, N)) e^{-v/2}$, the minimum is identically $N$.
Since $N \in \mathbb{N}$, $\lfloor N \rfloor = N$, so the source reduces to:
\[
(\psi(N) - N) e^{-v/2}.
\]
Squaring this gives $(\psi(N) - N)^2 e^{-v}$.

### 2.2. Tail Integral Evaluation
The improper integral is:
\[
\int_{\log N}^\infty e^{-v} \, dv = \left[ -e^{-v} \right]_{\log N}^\infty = 0 - (-e^{-\log N}) = \frac{1}{N}.
\]
Multiplying by $(\psi(N) - N)^2$ gives exactly $\frac{(\psi(N) - N)^2}{N}$.

### 2.3. Partition and Coercive Lower Bound
The sets $(0, \log N]$ and $(\log N, \infty)$ are disjoint and their union is $(0, \infty)$.
By additivity of the Lebesgue integral:
\[
\int_0^\infty f(v)^2 \, dv = \int_0^{\log N} f(v)^2 \, dv + \int_{\log N}^\infty f(v)^2 \, dv = \int_0^{\log N} f(v)^2 \, dv + \frac{(\psi(N) - N)^2}{N}.
\]
Since $f(v)^2 \ge 0$, the prefix integral $\int_0^{\log N} f(v)^2 dv \ge 0$.
Dropping this non-negative term yields the coercive lower bound.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenMetric` in `formalization/BuildingBlocks/ChargeFrozenMetric.lean`):
```lean
theorem causalSource_terminal {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) :
    causalSource N v = (psi N - (N : ℝ)) * Real.exp (-v / 2)

theorem terminal_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (Real.log (N : ℝ)), (causalSource N v)^2) =
      (psi N - (N : ℝ))^2 / (N : ℝ)

theorem full_square_integral_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
      (∫ v in Ioc 0 (Real.log (N : ℝ)), (causalSource N v)^2) +
        (psi N - (N : ℝ))^2 / (N : ℝ)

theorem full_square_integral_lower_bound {N : ℕ} (hN : 2 ≤ N) :
    (psi N - (N : ℝ))^2 / (N : ℝ) ≤ ∫ v in Ioi (0 : ℝ), (causalSource N v)^2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime number theorem error bounds, $L^2$ mean square estimates of $\psi(x) - x$ (Cramér 1922, Goldston 1987). Machine formalization of exact tail integration and coercive lower bounding in the logarithmic metric $dv$ in Lean 4 is new.
- **Advancement:** Establishes a completely formalized coercive bridge linking physical $L^2$ source norms to pointwise $O(N^{1/2})$ prime counting errors.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Acta Arithmetica*.
