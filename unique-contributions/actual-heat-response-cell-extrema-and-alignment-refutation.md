# Unique Contribution 47: Arithmetic Heat Response Cell Extrema and Rigorous Alignment Refutation

**Date:** 19 September 2026  
**Primary Source Documents:** [`building-blocks/theta-and-heat/actual-heat-renewal-cell-trace-audit.md`](../../building-blocks/theta-and-heat/actual-heat-renewal-cell-trace-audit.md), [`formalization/verification/actual_heat_cell_interval.py`](../../formalization/verification/actual_heat_cell_interval.py)  
**Classification:** Prime Number Theory / Heat Semigroups / Certified Interval Arithmetic

---

## 1. Executive Summary and Mathematical Statement

A central hypothesis in candidate spectral and renewal proofs of the Riemann Hypothesis is that the arithmetic heat response:
\[
b(v) = \sqrt{t} \left\{ \sum_{k \ge 2} \Lambda(k) e^{-kt} - (1 + t^{-1})e^{-t} \right\}, \quad t = e^{-v}, \quad h(v) = b(v) + \frac{1+\gamma}{2}
\]
maintains a uniform sign alignment or anti-alignment with the Euler kernel $H(v) = J'(v)$ across the logarithmic integer cells $[\log n, \log(n+1)]$.

This contribution establishes by certified rational interval arithmetic (using exact atanh series, Taylor polynomials, and rigorous integer square-root bounds):
1. **Interior Extremum on the First Cell:**  
   The response derivative $h'(v) = b'(v)$ satisfies:
   \[
   h'(\log 2) \in (-0.060112, -0.060111) < 0, \quad h'(\log 3) \in (0.070492, 0.070494) > 0.
   \]
   By the Intermediate Value Theorem, $h(v)$ possesses an **interior local minimum** in $(\log 2, \log 3)$, disproving monotonicity on integer logarithmic cells.
2. **Exclusion of Same-Sign Alignment:**  
   On $[\log 2, \log 3]$, the Euler kernel $H(v) = 1 + 2^{-1/2} - \zeta(1/2) - 2e^{v/2}$ transitions from positive to negative, whereas $h'(v)$ transitions from negative to positive. This strictly excludes same-sign alignment $h'(v) H(v) \ge 0$.
3. **Exclusion of Anti-Alignment:**  
   At the interior point $v = \log(5/2)$ ($t = 2/5$), certified rational arithmetic gives:
   \[
   h'(\log(5/2)) \in (0.018173, 0.018175) > 0, \quad H(\log(5/2)) \in (0.005183, 0.005184) > 0.
   \]
   Both derivatives are strictly positive simultaneously, which strictly excludes anti-alignment $h'(v) H(v) \le 0$.
4. **Definitive Refutation:**  
   No single-sign comparison (neither $h' \ge 0$, $h' \le 0$, $h' H \ge 0$, nor $h' H \le 0$) holds across the first logarithmic cell $[\log 2, \log 3]$, demonstrating that global Lyapunov or monotonicity criteria based on simple differential inequality comparisons are topologically obstructed.

---

## 2. Certified Enclosures and Proof Methodology

All bounds are computed in [`formalization/verification/actual_heat_cell_interval.py`](../../formalization/verification/actual_heat_cell_interval.py) with zero floating-point operations:
- **Truncation:** The derivative series:
  \[
  b'(v) = \sqrt{t} \left\{ \sum_{k=2}^\infty \Lambda(k)(tk - 1/2)e^{-kt} - e^{-t}\left(t + 1/2 + \frac{1}{2t}\right) \right\}
  \]
  is split at $k = 100$. The tail $\sum_{k=101}^\infty k^2 q^k$ is enclosed by exact geometric series sums:
  \[
  \text{Tail}(r=2) < 1.11 \times 10^{-18}, \quad \text{Tail}(r=3) < 1.75 \times 10^{-11}.
  \]
- **Logarithms:** Enclosed via 24 terms of the alternating atanh series with exact rational error bounds:
  \[
  \log y = 2\sum_{j=0}^{23} \frac{x^{2j+1}}{2j+1} + \varepsilon, \quad x = \frac{y-1}{y+1}, \quad 0 \le \varepsilon \le \frac{2x^{49}}{49(1-x^2)}.
  \]
- **Exponentials:** Enclosed via degree-60 alternating Taylor polynomials.
- **Square Roots:** Enclosed via integer square roots at scale $10^{40}$.

---

## 3. Literature Context and Target Venues

- **Prior Literature:** Literature on the heat kernel of the Riemann zeta function (Biane, Pitman, Yor; Connes; Suzuki) investigates global trace formulas and smoothed positivity. The exact point-by-point local oscillation of the actual unsmoothed prime heat response and its sign obstruction against the Euler kernel on logarithmic cells have not previously been investigated or certified.
- **Advancement:** Establishes the non-existence of uniform sign alignment between arithmetic heat and Euler kernels, proving that renewal stability cannot rely on simple derivative dominance.
- **Target Venues:** *Experimental Mathematics* or *Journal of Mathematical Analysis and Applications*.
