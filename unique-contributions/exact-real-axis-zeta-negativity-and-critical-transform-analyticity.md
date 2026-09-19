# Unique Contribution 253: Exact Real-Axis Zeta Negativity and Critical Transform Analyticity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CriticalTransformRealAxis.lean`](../../formalization/BuildingBlocks/CriticalTransformRealAxis.lean), [`building-blocks/transform/critical-transform-real-axis.md`](../../building-blocks/transform/critical-transform-real-axis.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Real-Axis Non-Vanishing / Fractional-Part Mellin Transforms / Filled Critical Transform Analyticity / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

Proving that the Riemann zeta function $\zeta(\sigma)$ has no real zeros on $(0, 1)$ is a cornerstone of analytic number theory, confirming that no Siegel or Landau zeros can lie on the positive real axis. Integrating this non-vanishing with the filled critical transform demonstrates unconditional analyticity of the quadratic prime transform across the entire real ray $(1/2, \infty)$.

This contribution proves:

1. **Non-Negativity of Fractional-Part Mellin Transform:**  
   For any real $\sigma > 0$, the Mellin integral of the fractional-part function $\{x\} = x - \lfloor x \rfloor$ satisfies:
   \[
   \text{Re}\left( \int_1^\infty (x - \lfloor x \rfloor) x^{-(\sigma + 1)} \, dx \right) \ge 0.
   \]
2. **Strict Negativity of Riemann Zeta on $(0, 1)$:**  
   For all $\sigma \in (0, 1)$:
   \[
   \text{Re}(\zeta(\sigma)) < 0.
   \]
   The proof uses the fractional-part analytic continuation $\zeta(s) = \frac{s}{s - 1} - s \int_1^\infty \{x\} x^{-(s + 1)} dx$:
   Since $\sigma/(\sigma - 1) < 0$ and $-\sigma \int_1^\infty \{x\} x^{-(\sigma + 1)} dx \le 0$, their sum is strictly negative.
3. **Non-Vanishing of Zeta on the Positive Real Axis:**  
   For all real $\sigma > 0$ with $\sigma \ne 1$:
   \[
   \zeta(\sigma) \ne 0.
   \]
   On $(0, 1)$ this follows from $\text{Re}(\zeta(\sigma)) < 0$; on $(1, \infty)$ it follows from the non-vanishing of the Euler product.
4. **Unconditional Real-Axis Analyticity of the Filled Transform:**  
   For every real $\sigma > 1/2$:
   \[
   \text{AnalyticAt} \, \mathbb{C} \, \text{filledTransform} \, (\sigma : \mathbb{C}).
   \]
   At points $\sigma \ne 1$, analyticity follows from $\zeta(\sigma) \ne 0$; at the removable pole $\sigma = 1$, analyticity follows from the filled value $(-\gamma - 1)^2 - H(1)$.

---

## 2. Mathematical Proof

### 2.1. Fractional-Part Mellin Non-Negativity
Since $x \ge \lfloor x \rfloor$ for all $x \ge 1$ and $x^{-(\sigma + 1)} > 0$ for $\sigma \in \mathbb{R}$, the integrand $(x - \lfloor x \rfloor)x^{-(\sigma + 1)}$ is almost everywhere non-negative.
By monotonicity of the Lebesgue integral:
\[
\text{Re}\left( \int_1^\infty (x - \lfloor x \rfloor) x^{-(\sigma + 1)} \, dx \right) = \int_1^\infty (x - \lfloor x \rfloor) x^{-(\sigma + 1)} \, dx \ge 0.
\]

### 2.2. Negativity on $(0, 1)$
In the fractional-part continuation:
\[
\zeta(\sigma) = \frac{\sigma}{\sigma - 1} - \sigma \cdot \text{floorMellin}(\sigma).
\]
For $0 < \sigma < 1$:
\[
\sigma - 1 < 0 \implies \frac{\sigma}{\sigma - 1} < 0.
\]
Moreover, $\sigma > 0$ and $\text{floorMellin}(\sigma) \ge 0$, so $-\sigma \cdot \text{floorMellin}(\sigma) \le 0$.
Thus:
\[
\zeta(\sigma) < 0 + 0 = 0.
\]

### 2.3. Analyticity of the Filled Transform
The transform is given by:
\[
\text{filledTransform}(s) = M(s) \left( \left(-\frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s - 1}\right)^2 - H(s) \right) \quad (s \ne 1).
\]
Since $\zeta(\sigma) \ne 0$ for all $\sigma \in (1/2, \infty) \setminus \{1\}$, $\zeta'/ \zeta$ is analytic at each such real point $\sigma$. Since $M(s)$ and $H(s)$ are analytic on $\text{Re}(s) > 1/2$, the entire expression is analytic.
At $\sigma = 1$, the filling removes the singularity, completing the proof for all $\sigma > 1/2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CriticalTransformRealAxis` in `formalization/BuildingBlocks/CriticalTransformRealAxis.lean`):
```lean
theorem floorMellin_re_nonneg {σ : ℝ} (hσ : 0 < σ) :
    0 ≤ (floorMellin (σ : ℂ)).re

theorem riemannZeta_re_neg {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ < 1) :
    (riemannZeta (σ : ℂ)).re < 0

theorem riemannZeta_ne_zero_real {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ ≠ 1) :
    riemannZeta (σ : ℂ) ≠ 0

theorem analyticAt_filledTransform_real {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ CriticalTransformPoles.filledTransform (σ : ℂ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Negativity of $\zeta(\sigma)$ on $(0, 1)$ dates back to Riemann (1859) and Titchmarsh (1986). A machine-verified proof in Lean 4 establishing $\text{Re}(\zeta(\sigma)) < 0$, real non-vanishing $\zeta(\sigma) \ne 0$, and the unconditional analyticity of the filled quadratic prime transform along the real ray $(1/2, \infty)$ is new.
- **Advancement:** Confirms absence of real spectral singularities for the filled critical transform, ensuring that the only possible obstructions to RH are non-real zeros.
- **Target Venues:** *American Mathematical Monthly* or *Expositiones Mathematicae*.
