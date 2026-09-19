# Contribution 78: Successor Feedback Terminal-Strip Bound and Error-Difference Driver

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorFeedbackBoundary.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackBoundary.lean)  
**Classification:** Operator Theory / Dynamical Systems / Causal Prime Dynamics / Transfer Boundary Value Problems

---

## 1. Executive Summary and Mathematical Statement

In the discrete-time feedback system governing the evolution of the prime transfer operator across successor iterations $j \in \mathbb{N}$, the system driver $d_j$ represents the boundary defect of the $j$-th iterated source.

This contribution proves:

1. **Exponential Decay of the Terminal Strip Error:**  
   When truncating the upper integration boundary at $R \ge \log 2$, the excess integral over the boundary strip $[R, \sigma(R)]$ (where $\sigma(R) = \log(1 + e^R)$) satisfies the uniform non-asymptotic bound:
   $$
   \left| \int_R^{\sigma(R)} w(u) (T^j \mathcal{L} H)(u) \, du \right| \le 4 M e^{-R/2},
   $$
   for any profile $H$ with $|H(x)| \le M$, decaying exponentially to zero as $R \to \infty$ independently of the iteration index $j$.
2. **Infinite Relative Charge Identity:**  
   In the infinite limit $R \to \infty$, the integral of the successor difference operator exactly equals the integrated defect kernel:
   $$
   \int_0^\infty (T(T^j f)(v) - T^j f(v)) \, dv = \int_0^\infty K(v) T^j f(v) \, dv,
   $$
   relying solely on the integrability of the difference and defect, without requiring individual $L^1(0, \infty)$ integrability of the divergent source terms.
3. **Physical Error-Difference Representation of the Feedback Driver:**  
   The discrete feedback driver $d_j = \operatorname{driver}(j)$ is identically equal to the half-weight integrated difference of the physical Chebyshev error $E(x)$:
   $$
   d_j = \frac{1}{2} \int_1^\infty \frac{E(x + j + 1) - E(x + j)}{\sqrt{x}} \, dx.
   $$
4. **Significance for Feedback Stability:**  
   Expresses the feedback input entirely through finite differences $\Delta E_j(x) = E(x + j + 1) - E(x + j)$ of the Chebyshev error, proving that smooth background growth cannot drive the feedback equation; only discrete prime fluctuations activate the dynamical feedback loop.

---

## 2. Mathematical Proof

### 2.1. Strip Geometry and Weight Estimates
For $u \in [R, \sigma(R)]$, the width of the interval is $\sigma(R) - R = \log(1 + e^{-R}) \le e^{-R}$.
On this interval, $u \le \sigma(R) \le R + \log 2$, so $e^{u/2} \le e^{R/2} e^{(\log 2)/2} \le 2 e^{R/2}$.
The weight satisfies $w(u) = 1/\sqrt{1 - e^{-u}} \le 2$ for $u \ge \log 2$.
Integrating over $[R, \sigma(R)]$:
$$
\int_R^{\sigma(R)} \|w(u) (T^j \mathcal{L} H)(u)\| \, du \le 2 \cdot (2 e^{R/2} M) \cdot (\sigma(R) - R) \le 4 M e^{R/2} e^{-R} = 4 M e^{-R/2}.
$$

### 2.2. Vanishing Boundary at Infinity
As $R \to \infty$, $4 M e^{-R/2} \to 0$.
The difference between $\int_0^R (T f - f)$ and $\int_0^R K f$ is bounded by this terminal strip, so the limits as $R \to \infty$ coincide.

### 2.3. Substitution of Innovation
The innovation profile is $\operatorname{innovation}(j)(v) = T(T^j \mathcal{L} E)(v) - T^j \mathcal{L} E(v)$.
Under the change of variable $x = e^v$, the integral transforms to:
$$
\int_0^\infty \operatorname{innovation}(j)(v) \, dv = \int_1^\infty \frac{E(x + j + 1) - E(x + j)}{\sqrt{x}} \, dx.
$$
Multiplying by $1/2$ matches the definition of $\operatorname{driver}(j)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorFeedbackBoundary`):
```lean
theorem terminal_strip_bound {H : ℝ → ℝ} {M : ℝ} (hM : 0 ≤ M)
    (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    {R : ℝ} (hR : log 2 ≤ R) :
    |∫ u in R..sigma R, weight u * successor^[j] (MixedEnergy.physicalLift H) u| ≤
      4 * M * exp (-R / 2)

theorem profile_relative_charge {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    (hi : IntegrableOn (fun v => successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) =
      ∫ v in Ioi (0 : ℝ), kernel v * successor^[j] (MixedEnergy.physicalLift H) v

theorem driver_eq_difference_integral (j : ℕ) :
    driver j = (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ),
      (physicalError (x + j + 1) - physicalError (x + j)) / sqrt x
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Transfer operators with non-compact boundaries often suffer from boundary divergence. Proving exact vanishing of the terminal strip at exponential rate $e^{-R/2}$ and equating the discrete feedback driver directly to the half-weight difference integral of Chebyshev errors had not been formalized in Lean 4.
- **Advancement:** Machine-verifies the exponential strip decay and establishes the exact difference integral representation of the feedback driver.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Journal of Differential Equations*.
