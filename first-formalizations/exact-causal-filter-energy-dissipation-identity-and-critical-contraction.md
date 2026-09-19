# First Formalization: Exact Causal Filter Energy Dissipation Identity and Critical Contraction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CausalFilterEnergy.lean`](../../formalization/BuildingBlocks/CausalFilterEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact cross-integral identity for right-differentiable causal filters, the general quadratic dissipation identity, the strict $L^2$ contraction theorem for rates $\lambda \ge 1/2$, and the sharp $H^2$ response gain bound $\lambda^{-2}$ in Lean 4:

1. **Exact Cross-Integral Formula:**
   Formal proof of $2\int_0^T r(t) f(t) dt = r(T)^2 + 2\lambda \int_0^T r(t)^2 dt$ (`causalFilter_cross_integral`).
2. **Exact Energy Dissipation Identity:**
   Formal proof of $\int_0^T (f - r)^2 dt = \int_0^T f^2 dt - r(T)^2 - (2\lambda - 1)\int_0^T r^2 dt$ (`causalFilter_energy_identity`).
3. **Critical Line Contraction:**
   Formal proof that $\lambda \ge 1/2 \implies \int_0^T (f - r)^2 dt \le \int_0^T f^2 dt$ (`causalFilter_energy_contraction`).
4. **Sharp Response Gain Bound:**
   Formal proof of $\lambda^2 \int_0^T r(t)^2 dt \le \int_0^T f(t)^2 dt$ (`causalFilter_response_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Right-differentiable cross-integral identity
theorem causalFilter_cross_integral {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    2 * (∫ t in (0 : ℝ)..T, r t * f t) =
      r T ^ 2 + 2 * rate * ∫ t in (0 : ℝ)..T, r t ^ 2

-- Exact general energy dissipation identity
theorem causalFilter_energy_identity {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) =
      (∫ t in (0 : ℝ)..T, f t ^ 2) - r T ^ 2 -
        (2 * rate - 1) * ∫ t in (0 : ℝ)..T, r t ^ 2

-- Critical contraction for rate ≥ 1/2
theorem causalFilter_energy_contraction {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 1 / 2 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2

-- Sharp input-output response bound
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

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the general energy dissipation identity and critical contraction threshold $\lambda \ge 1/2$ for causal jump filters using right-differentiable integration by parts.
