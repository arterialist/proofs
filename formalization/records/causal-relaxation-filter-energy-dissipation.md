# First Formalization in Lean 4: Causal Relaxation Filter Energy Dissipation and Critical Contraction

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/CausalFilterEnergy.lean`](../../formalization/BuildingBlocks/CausalFilterEnergy.lean)  
**Dependencies:** `Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts`, `Mathlib.Analysis.Calculus.Deriv.Pow`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the causal spectral analysis of prime-history feedback, the first-order causal relaxation filter with rate parameter $\gamma \in \mathbb{R}$ is governed by the differential equation:
\[
r'(t) = f(t) - \gamma r(t), \qquad t \in [0, T], \quad r(0) = 0.
\]
In particular, when $\gamma = 1/2$, this corresponds to the critical unitary scale operator $H = 1/2 - \partial_v$ that maps physical density fluctuations to scale-invariant charges.

The quadratic energy balance of this filter balances input energy, dissipated output energy, and terminal boundary storage:
\[
\int_0^T (f(t) - r(t))^2 dt = \int_0^T f(t)^2 dt - r(T)^2 - (2\gamma - 1) \int_0^T r(t)^2 dt.
\]
From this exact identity, two profound consequences follow:
1. **Critical Energy Contraction:** Whenever the rate parameter satisfies $\gamma \ge 1/2$ (the critical threshold where $2\gamma - 1 \ge 0$), the error energy is **strictly contractive** across every finite horizon $T \ge 0$:
\[
\int_0^T (f(t) - r(t))^2 dt \le \int_0^T f(t)^2 dt.
\]
2. **Universal Gain Bound:** Whenever $\gamma > 0$, the $L^2$ response energy of the filter is uniformly bounded by the input energy scaled by $\gamma^{-2}$:
\[
\gamma^2 \int_0^T r(t)^2 dt \le \int_0^T f(t)^2 dt.
\]

This Lean 4 formalization machine-checks the exact integration-by-parts identity with one-sided right derivatives (allowing general step-function inputs $f \in L^2$), the terminal boundary square recording, and the critical energy contraction inequality.

---

## 2. Machine-Verified Theorems

### 2.1 Causal Cross-Integral and Energy Balance Identities

```lean
/-- The energy identity for the causal filter `r' = f - rate r`, with its
actual zero initial condition. Right derivatives allow step-function input. -/
theorem causalFilter_cross_integral {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    2 * (∫ t in (0 : ℝ)..T, r t * f t) =
      r T ^ 2 + 2 * rate * ∫ t in (0 : ℝ)..T, r t ^ 2

/-- Exact dissipated energy; no boundedness or arithmetic error estimate is
assumed. The terminal square records the filter's boundary contribution. -/
theorem causalFilter_energy_identity {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) =
      (∫ t in (0 : ℝ)..T, f t ^ 2) - r T ^ 2 -
        (2 * rate - 1) * ∫ t in (0 : ℝ)..T, r t ^ 2
```

### 2.2 Critical Contraction and Universal Gain Bounds

```lean
theorem causalFilter_energy_contraction {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 1 / 2 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2

/-- The same energy identity bounds the causal response itself by the input,
with squared gain `rate⁻²` when the rate is positive. -/
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

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/CausalFilterEnergy.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.causalFilter_cross_integral' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.causalFilter_energy_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.causalFilter_energy_contraction' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.causalFilter_response_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```
No custom axioms or `sorry` placeholders are utilized.
