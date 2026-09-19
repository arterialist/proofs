# First Formalization: Exact Coarse Primitive Energy Terminal Mass and Test Function Estimates

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarsePrimitive.lean`](../../formalization/BuildingBlocks/CoarsePrimitive.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the control of terminal prime error mass, the continuous Cauchy-Schwarz primitive inequality, integration by parts for discontinuous step functions, and the master test-function energy bound in Lean 4:

1. **Terminal Mass Control:**
   Formal proof of `coarse_terminal_mass_sq_le`: $X \cdot (\int_X^{2X} (\psi - \text{id}))^2 \le 2 E(X)$.
2. **Mean-Square Primitive Bound:**
   Formal proof of `coarsePrefix_abs_integral_sq_le`: $(\int_X^{2X} |\int_X^t (\psi - \text{id})| dt)^2 \le X \cdot E(X)$.
3. **Exact Integration by Parts:**
   Formal proof of `coarsePrime_summation_by_parts`: Integration by parts against any differentiable test function with jump-discontinuous integrands.
4. **Grand Test Function Master Bound:**
   Formal proof of `coarsePrime_test_bound`: Bounding arbitrary test integrals $\int_X^{2X} (\psi - \text{id}) w$ by the primitive square root energy $\sqrt{E(X)}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Control of the terminal prime error mass by primitive energy
theorem coarse_terminal_mass_sq_le {X : ℝ} (hX : 0 ≤ X) :
    X * coarsePrefix X (2 * X) ^ 2 ≤ 2 * coarsePrimitiveSquare X

-- Cauchy-Schwarz inequality for the prime error primitive
theorem coarsePrefix_abs_integral_sq_le {X : ℝ} (hX : 0 ≤ X) :
    (∫ t in X..(2 * X), |coarsePrefix X t|) ^ 2 ≤ X * coarsePrimitiveSquare X

-- Summation by parts for discontinuous prime errors
theorem coarsePrime_summation_by_parts {X : ℝ} {w w' : ℝ → ℂ}
    (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X)) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x) =
      (coarsePrefix X (2 * X) : ℂ) * w (2 * X) -
      ∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x

-- Master test-function bound from primitive energy
theorem coarsePrime_test_bound {X K : ℝ} (hX : 0 < X) (hK : 0 ≤ K)
    {w w' : ℝ → ℂ} (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X))
    (hbound : ∀ x ∈ Ioc X (2 * X), ‖w' x‖ ≤ K) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * ‖w (2 * X)‖ +
      K * Real.sqrt (X * coarsePrimitiveSquare X)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the endpoint mass and oscillatory test integrals of the discontinuous prime counting error $\psi(\lfloor x \rfloor) - x$ are strictly bounded by an $L^2$ primitive energy without requiring pointwise prime error bounds.
