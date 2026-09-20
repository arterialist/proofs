# Contribution 124: Exact Causal-Filter Energy Identity and Passivity Contraction

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CausalFilterEnergy.lean`](../../formalization/BuildingBlocks/CausalFilterEnergy.lean), [`building-blocks/energy-methods/causal-filter-energy.md`](../../building-blocks/energy-methods/causal-filter-energy.md)  
**Classification:** Control Theory / Dissipative Systems / Differential Inequalities / Energy Methods / Passivity / Hardy Space Multipliers

---

## 1. Executive Summary and Mathematical Statement

In the smoothing of discontinuous arithmetic signals (such as prime counting and Chebyshev step functions), causal first-order filtering governs the evolution:
$$
r'(t) = f(t) - \lambda r(t), \quad r(0) = 0, \quad \lambda > 0.
$$
Because arithmetic inputs $f$ exhibit jump discontinuities, derivatives must be formulated as right derivatives $\partial_+ r(t) = f(t) - \lambda r(t)$.

This contribution proves:

1. **Exact Causal Cross-Energy Identity:**  
   For any interval-integrable input $f \in L^1([0, T])$ and continuous response $r \in C([0, T])$ with $r(0) = 0$:
   $$
   2 \int_0^T r(t) f(t) \, dt = r(T)^2 + 2\lambda \int_0^T r(t)^2 \, dt.
   $$
2. **Exact Dissipated Deficit Identity:**  
   The $L^2$ error between the raw input and filtered response decomposes with exact terminal boundary mass:
   $$
   \int_0^T (f(t) - r(t))^2 \, dt = \int_0^T f(t)^2 \, dt - r(T)^2 - (2\lambda - 1) \int_0^T r(t)^2 \, dt.
   $$
3. **Sharp Passivity Contraction Threshold:**  
   For any relaxation rate $\lambda \ge 1/2$:
   $$
   \int_0^T (f(t) - r(t))^2 \, dt \le \int_0^T f(t)^2 \, dt,
   $$
   proving unconditional $L^2$ non-expansion of the filter error for all $T \ge 0$.
4. **Exact Frequency-Independent Response Bound:**  
   For any rate $\lambda > 0$:
   $$
   \lambda^2 \int_0^T r(t)^2 \, dt \le \int_0^T f(t)^2 \, dt,
   $$
   establishing a strict gain bound of $\|r\|_{L^2} \le \frac{1}{\lambda} \|f\|_{L^2}$ on arbitrary finite horizons without boundary distortion.

---

## 2. Mathematical Proof

### 2.1. Cross-Integral
Differentiating $r(t)^2$ with respect to the right derivative:
$$
\partial_+ (r(t)^2) = 2 r(t) \partial_+ r(t) = 2 r(t)(f(t) - \lambda r(t)) = 2 r(t) f(t) - 2\lambda r(t)^2.
$$
Integrating over $t \in [0, T]$ and using the fundamental theorem of calculus for right derivatives with $r(0) = 0$:
$$
r(T)^2 - r(0)^2 = 2 \int_0^T r(t) f(t) dt - 2\lambda \int_0^T r(t)^2 dt.
$$
Since $r(0) = 0$, rearranging yields:
$$
2 \int_0^T r(t) f(t) dt = r(T)^2 + 2\lambda \int_0^T r(t)^2 dt.
$$

### 2.2. Dissipated Energy Identity
Expanding the square:
$$
\int_0^T (f(t) - r(t))^2 dt = \int_0^T f(t)^2 dt - 2 \int_0^T r(t) f(t) dt + \int_0^T r(t)^2 dt.
$$
Substituting the cross-integral:
$$
\int_0^T (f(t) - r(t))^2 dt = \int_0^T f(t)^2 dt - \left(r(T)^2 + 2\lambda \int_0^T r(t)^2 dt\right) + \int_0^T r(t)^2 dt = \int_0^T f(t)^2 dt - r(T)^2 - (2\lambda - 1) \int_0^T r(t)^2 dt.
$$

### 2.3. Contraction at $\lambda \ge 1/2$
Since $r(T)^2 \ge 0$ and for $\lambda \ge 1/2$, $2\lambda - 1 \ge 0$, while $\int_0^T r(t)^2 dt \ge 0$:
$$
r(T)^2 + (2\lambda - 1) \int_0^T r(t)^2 dt \ge 0.
$$
Hence:
$$
\int_0^T (f(t) - r(t))^2 dt \le \int_0^T f(t)^2 dt.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks`):
```lean
theorem causalFilter_cross_integral {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    2 * (∫ t in (0 : ℝ)..T, r t * f t) =
      r T ^ 2 + 2 * rate * ∫ t in (0 : ℝ)..T, r t ^ 2

theorem causalFilter_energy_identity {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) =
      (∫ t in (0 : ℝ)..T, f t ^ 2) - r T ^ 2 -
        (2 * rate - 1) * ∫ t in (0 : ℝ)..T, r t ^ 2

theorem causalFilter_energy_contraction {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 1 / 2 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2

theorem causalFilter_response_bound {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 0 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    rate ^ 2 * (∫ t in (0 : ℝ)..T, r t ^ 2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dissipative dynamical systems and passivity theorems (Willems 1972, Desoer-Vidyasagar 1975). The rigorous formalization of exact finite-horizon boundary-corrected energy identities and sharp passivity thresholds for right-differentiable filters in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact energy dissipation identity and contraction bounds for causal filters driven by discontinuous inputs.
- **Target Venues:** *IEEE Transactions on Automatic Control* or *Systems & Control Letters*.
