# First Formalization: Exact Successor-Feedback Floor Abel Kernel Holomorphy and Volterra Error

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorFeedbackFloorKernel.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackFloorKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the complex differentiability, holomorphy on $\text{Re}(z) > 0$, and exact Volterra error formula for the floor Abel kernel in Lean 4:

1. **Integrand Bounds and Integrability:**
   Formal proof of `floorWeight_norm_le_one`, `floorAbelIntegrand_measurable`, `floorAbelIntegrand_norm_le_one`, and `floorAbelIntegrand_integrable`.
2. **Parametric Complex Differentiation:**
   Formal proof of `floorAbelIntegrand_hasDerivAt`, `floorAbelParameterDerivative_measurable`, and `floorAbelParameterDerivative_bound` ($\|\partial_z\| \le \log y$).
3. **Holomorphy on the Open Half-Plane:**
   Formal proof of `floorAbelKernel_differentiableAt` and `floorAbelKernel_analyticOnNhd`: holomorphy on $\{z : 0 < z.\text{re}\}$.
4. **Interval Integral Representation:**
   Formal proof of `floorAbelKernel_initial` ($\mathcal{K}(z, 1) = 0$) and `floorAbelKernel_eq_intervalIntegral`.
5. **Exact Volterra Error Identity:**
   Formal proof of `smoothAbelIntegrand_integrable`, `floorAbelError_integrable`, and `floorAbelKernel_sub_smooth`:
   \[
   \mathcal{K}_{\text{floor}}(z, y) - \mathcal{K}_{\text{smooth}}(z, y) = \int_0^{y-1} \text{floorWeightError}(z, t) (y - t)^{-1/2} dt.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Parametric complex differentiation of the floor integrand
theorem floorAbelIntegrand_hasDerivAt (z : ℂ) (y t : ℝ) :
    HasDerivAt (fun w => floorAbelIntegrand w y t)
      (floorAbelParameterDerivative z y t) z

-- Complex differentiability of the parametric Bochner integral
theorem floorAbelKernel_differentiableAt {z : ℂ} (hz : 0 < z.re) (y : ℝ) :
    DifferentiableAt ℂ (fun w => floorAbelKernel w y) z

-- Holomorphy on the half-plane Re(z) > 0
theorem floorAbelKernel_analyticOnNhd (y : ℝ) :
    AnalyticOnNhd ℂ (fun z => floorAbelKernel z y) {z : ℂ | 0 < z.re}

-- Exact Volterra discrepancy integral formula
theorem floorAbelKernel_sub_smooth {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    floorAbelKernel z y - smoothAbelKernel z y =
      ∫ t in Icc (0 : ℝ) (y - 1), floorWeightError z t *
        ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the parametric holomorphy of floor-discretized fractional Abel kernels on $\text{Re}(z) > 0$ via dominated Bochner differentiation, and provides the exact Volterra integral discrepancy between discrete and continuous kernels.
