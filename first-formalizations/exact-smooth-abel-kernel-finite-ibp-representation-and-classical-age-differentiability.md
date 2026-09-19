# First Formalization: Exact Smooth Abel Kernel Finite-IBP Representation and Classical Age Differentiability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorFeedbackSmoothAgeDerivative.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackSmoothAgeDerivative.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite-interval integration-by-parts representation of the smooth Abel kernel and proves its classical age differentiability in Lean 4 without using Beta function continuations or singular poles at $z=1$:

1. **Finite Integral Equivalence:**
   Formal proof that the root primitive convolution equals the finite integral over $(0, y-1]$ against $2(\sqrt{y-t}-1)$ (`rootPrimitiveConvolution_eq_finite`).
2. **Exact Finite-Interval IBP Formula:**
   Formal proof that $K_z^{\text{smooth}}(y) = R(y) - R * \text{smoothPowerCharge}(z)(y)$ for all $\text{Re}(z) > 0$ and $y \ge 1$ (`smoothAbelKernel_eq_rootPrimitive`).
3. **Classical Age Differentiability:**
   Formal proof of the classical derivative of the smooth Abel kernel on $(1, \infty)$ (`smoothAbelKernel_hasDerivAt`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite integral reduction of root primitive convolution
theorem rootPrimitiveConvolution_eq_finite (f : ℝ → ℂ) (y : ℝ) :
    rootPrimitiveConvolution f y = ∫ t in Ioc (0 : ℝ) (y - 1),
      f t * ((2 * (sqrt (y - t) - 1) : ℝ) : ℂ)

-- Exact finite-interval IBP identity
theorem smoothAbelKernel_eq_rootPrimitive {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    smoothAbelKernel z y = (causalRootPrimitive y : ℂ) -
      rootPrimitiveConvolution (smoothPowerCharge z) y

-- Classical age differentiability
theorem smoothAbelKernel_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y) :
    HasDerivAt (smoothAbelKernel z) (smoothRootDerivative z y) y
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 deriving the exact finite-interval IBP decomposition of the smooth Abel kernel without appealing to the Euler Beta function or meromorphic continuation across $z=1$.
