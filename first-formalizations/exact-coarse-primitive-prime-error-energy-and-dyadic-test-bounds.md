# First Formalization: Exact Coarse-Primitive Prime-Error Energy and Dyadic Test Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarsePrimitive.lean`](../../formalization/BuildingBlocks/CoarsePrimitive.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the terminal mass control, discontinuous summation by parts, dyadic Mellin formula, and universal test-function estimate for the actual prime-power error in Lean 4:

1. **Terminal Mass Control:**
   Formal derivation of $X (\int_X^{2X} E(x) dx)^2 \le 2 \mathcal{E}_{\text{prim}}(X)$ (`coarse_terminal_mass_sq_le`).
2. **Exact Summation by Parts:**
   Rigorous integration by parts for the discontinuous prime error with right-derivatives (`coarsePrime_summation_by_parts`).
3. **Exact Dyadic Mellin Block Formula:**
   Formal evaluation of $\int_X^{2X} E(x) x^{-(s+1)} dx$ with boundary terminal mass (`coarsePrime_mellin_block`).
4. **Universal Test-Function Bound:**
   Formal derivation of the quantitative $L^2$ primitive energy bound for arbitrary $C^1$ test functions (`coarsePrime_test_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Terminal mass controlled by primitive energy
theorem coarse_terminal_mass_sq_le {X : ℝ} (hX : 0 ≤ X) :
    X * coarsePrefix X (2 * X) ^ 2 ≤ 2 * coarsePrimitiveSquare X

-- Exact summation by parts for prime error
theorem coarsePrime_summation_by_parts {X : ℝ} {w w' : ℝ → ℂ}
    (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X)) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x) =
      (coarsePrefix X (2 * X) : ℂ) * w (2 * X) -
      ∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x

-- Dyadic Mellin block representation
theorem coarsePrime_mellin_block {X : ℝ} (hX : 0 < X) (s : ℂ) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) =
      (coarsePrefix X (2 * X) : ℂ) * (2 * X : ℂ) ^ (-(s + 1)) +
      (s + 1) * ∫ x in X..(2 * X),
        (coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2))

-- Universal test function bound
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing rigorous summation by parts and dyadic test-function bounds for the discontinuous Chebyshev error function $\psi(\lfloor x \rfloor) - x$ controlled solely by its continuous primitive $L^2$ energy.
