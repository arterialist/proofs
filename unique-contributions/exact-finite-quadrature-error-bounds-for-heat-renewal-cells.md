# Contribution 96: Exact Finite Quadrature Error Bounds for Heat Renewal Cells

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean`](../../formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean)  
**Classification:** Numerical Analysis / Quadrature Theory / Heat Renewal Equations / Total Variation Bounds

---

## 1. Executive Summary and Mathematical Statement

In the audit of heat renewal equations and parabolic cell discretization, continuous integrals of heat kernels $\int_0^T G(t) dt$ are approximated by discrete Riemann or trapezoidal sums. Proving uniform bounds across infinite tails requires exact non-asymptotic error formulas on finite grids.

This contribution proves:

1. **Exact Right-Endpoint Rectangle Error Bound:**  
   For any function $G \in C^1([0, N\delta])$ and uniform step size $\delta \ge 0$:
   $$
   \left| \delta \sum_{m=0}^{N-1} G((m+1)\delta) - \int_0^{N\delta} G(t) dt \right| \le \delta \int_0^{N\delta} |G'(t)| dt.
   $$
   The approximation error is strictly majorized by the mesh width $\delta$ times the total variation $\int |G'|$.
2. **Mesh-Inversion Scaling Form:**  
   In terms of frequency grid scale $X > 0$ with $\delta = 1/X$:
   $$
   \left| \frac{1}{X} \sum_{m=0}^{N-1} G\left(\frac{m+1}{X}\right) - \int_0^{N/X} G(t) dt \right| \le \frac{1}{X} \int_0^{N/X} |G'(t)| dt.
   $$
3. **Exact Integration-by-Parts Identity for Trapezoid Cells:**  
   For $G \in C^2([a, b])$, with Peano kernel $w(t) = \frac{(t-a)(b-t)}{2}$:
   $$
   \frac{b-a}{2} (G(a) + G(b)) - \int_a^b G(t) dt = \int_a^b \frac{(t-a)(b-t)}{2} G''(t) dt.
   $$
4. **Second-Order Composite Trapezoid Error Majorization:**  
   For $G \in C^2([0, (N+1)\delta])$:
   $$
   \left| \frac{\delta}{2} \left(G(0) + G((N+1)\delta)\right) + \delta \sum_{m=1}^N G(m\delta) - \int_0^{(N+1)\delta} G(t) dt \right| \le \frac{\delta^2}{4} \int_0^{(N+1)\delta} |G''(t)| dt.
   $$
5. **Architectural Significance:**  
   Establishes certified, non-asymptotic total-variation error bounds for right-endpoint and trapezoidal discretizations of renewal heat cells with zero reliance on asymptotic expansions.

---

## 2. Mathematical Proof

### 2.1. Right-Endpoint Error via Fundamental Theorem
On each cell $[a, b]$, $G(b) - G(t) = \int_t^b G'(u) du$. Integrating $t \in [a, b]$:
$$
\int_a^b (G(b) - G(t)) dt = (b-a) G(b) - \int_a^b G(t) dt.
$$
By monotonicity and Fubini, $|G(b) - G(t)| \le \int_a^b |G'(u)| du$, so the integral is bounded by $(b-a) \int_a^b |G'|$.
Summing over $N$ adjacent intervals $[m\delta, (m+1)\delta]$ and applying the triangle inequality yields the global bound $\delta \int_0^{N\delta} |G'|$.

### 2.2. Trapezoid Peano Kernel
Define $F(t) = w(t) G'(t) - w'(t) G(t)$ where $w(t) = (t-a)(b-t)/2$ and $w'(t) = (a+b)/2 - t$.
Then $F'(t) = w(t) G''(t) + G(t)$.
Integrating $t$ from $a$ to $b$:
$$
\int_a^b (w(t) G''(t) + G(t)) dt = F(b) - F(a) = \frac{b-a}{2} (G(a) + G(b)).
$$
Since $0 \le w(t) \le (b-a)^2/4$ on $[a, b]$, $|(b-a)/2 (G(a)+G(b)) - \int G| \le \frac{(b-a)^2}{4} \int_a^b |G''|$.
Summing across $N$ cells gives the composite bound $\frac{\delta^2}{4} \int_0^{N\delta} |G''|$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualHeatRenewalRectangle`):
```lean
theorem finite_right_rectangle (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) * δ) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      δ * ∫ t in (0 : ℝ)..(N : ℝ) * δ, |deriv G t|

theorem finite_trapezoid_endpoints (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ / 2 * (G 0 + G (((N + 1 : ℕ) : ℝ) * δ)) +
        δ * ∑ m ∈ Ico 1 (N + 1), G ((m : ℝ) * δ) -
      ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ, G t| ≤
      δ ^ 2 / 4 * ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ,
        |deriv (deriv G) t|
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** Peano-kernel quadrature bounds are classical. The exact endpoint-retaining formalization on this page has provisional priority; this audit did not exhaust Mathlib or the broader formal literature.
- **Advancement:** Machine-checked non-asymptotic $L^1$-variation error bounds for right-endpoint and trapezoidal quadrature rules.
- **Target Venues:** *IMA Journal of Numerical Analysis* or *Mathematics of Computation*.
