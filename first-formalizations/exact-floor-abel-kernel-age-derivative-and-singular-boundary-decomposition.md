# First Formalization: Exact Floor Abel Kernel Age Derivative and Singular Boundary Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact age derivative formula for the Abel fractional kernel error between floor and smooth regularizations, retaining the moving boundary contribution and singular integral correction in Lean 4:

1. **Continuity of Weight Error:**
   Formal proof of continuity of the floor weight error $E_z(t)$ at non-integer points $t \ge 0$, $t \notin \mathbb{N}$ (`floorWeightError_continuousAt`).
2. **Exact Moving Primitive Decomposition:**
   Formal proof that $K_z^{\text{floor}} - K_z^{\text{smooth}}$ decomposes into the moving primitive $\int_0^{y-1} E_z(t) dt$ and clipped convolution (`floorAbelError_eq_primitive_add_clipped`).
3. **Leibniz Differentiation:**
   Formal proof that the moving upper limit primitive differentiates to $E_z(y-1)$ (`floorErrorPrimitive_hasDerivAt`).
4. **Exact Classical Age Derivative Formula:**
   Formal proof that away from integer shifts, the derivative equals $E_z(y-1) - \frac{1}{2} \int_0^{y-1} E_z(t) (y-t)^{-3/2} dt$ (`floorAbelError_hasDerivAt`).
5. **Almost-Everywhere Differentiability:**
   Formal proof of Lebesgue almost-everywhere differentiability on $(1, \infty)$ (`floorAbelError_hasDerivAt_ae`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Continuity of weight error away from integer points
theorem floorWeightError_continuousAt {t : ℝ} (ht : 0 ≤ t)
    (hnt : ∀ n : ℕ, t ≠ n) (z : ℂ) : ContinuousAt (floorWeightError z) t

-- Decomposition into moving primitive and clipped convolution
theorem floorAbelError_eq_primitive_add_clipped {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    floorAbelKernel z y - smoothAbelKernel z y =
      floorErrorPrimitive z y + clippedConvolution (floorWeightError z) y

-- Moving endpoint differentiation
theorem floorErrorPrimitive_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (floorErrorPrimitive z) (floorWeightError z (y - 1)) y

-- Exact classical age derivative formula
theorem floorAbelError_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
      (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
        ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
          ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y

-- Almost-everywhere differentiability on (1, ∞)
theorem floorAbelError_hasDerivAt_ae {z : ℂ} (hz : 0 < z.re) :
    ∀ᵐ y : ℝ ∂volume.restrict (Ioi 1),
      HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
        (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
          ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
            ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 deriving the exact age derivative for singular Abel fractional error kernels and capturing the moving boundary value $E_z(y-1)$ alongside the hypersingular $(y-t)^{-3/2}$ integral correction.
