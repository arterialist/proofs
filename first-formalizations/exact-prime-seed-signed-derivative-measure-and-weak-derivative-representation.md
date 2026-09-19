# First Formalization: Exact Prime Seed Signed Derivative Measure and Weak Derivative Representation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedDerivativeMeasure.lean`](../../formalization/BuildingBlocks/PrimeSeedDerivativeMeasure.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization constructs the explicit positive and negative Borel measures for the derivative of prime successor seeds, proves their finite total mass, constructs the authentic `SignedMeasure ℝ`, verifies its zero total mass, and establishes the Riesz-Schwartz weak derivative representation theorem in Lean 4:

1. **Positive and Negative Component Measures:**
   Formal construction of `seedDerivativePositive` and `seedDerivativeNegative`, proving both evaluate to $e^{-L} + e^{-3L/2}$ (`seedDerivativePositive_mass`, `seedDerivativeNegative_mass`).
2. **Finite Measure Instances:**
   Formal proof of typeclass instances `IsFiniteMeasure` for both positive and negative measures (`seedDerivativePositive_finite`, `seedDerivativeNegative_finite`).
3. **Signed Derivative Measure and Mass Conservation:**
   Formal construction of `seedDerivative` as a `SignedMeasure ℝ` and proof that its total mass on $\mathbb{R}$ is identically zero (`seedDerivative_total_mass`).
4. **Weak Derivative Integration Representation:**
   Formal proof that for every bounded $C^1$ test function $\phi$, integration against $\phi'$ equals the difference of integrations against negative and positive measures (`seedDerivative_represents_weak_derivative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Positive component mass
theorem seedDerivativePositive_mass {L : ℝ} (hL : 0 < L) :
    seedDerivativePositive L univ = ENNReal.ofReal (exp (-L) + exp (-3 * L / 2))

-- Negative component mass
theorem seedDerivativeNegative_mass {L : ℝ} (hL : 0 < L) :
    seedDerivativeNegative L univ = ENNReal.ofReal (exp (-L) + exp (-3 * L / 2))

-- Finite measure instances
theorem seedDerivativePositive_finite {L : ℝ} (hL : 0 < L) :
    IsFiniteMeasure (seedDerivativePositive L)

theorem seedDerivativeNegative_finite {L : ℝ} (hL : 0 < L) :
    IsFiniteMeasure (seedDerivativeNegative L)

-- Signed measure zero total mass
theorem seedDerivative_total_mass {L : ℝ} (hL : 0 < L) :
    seedDerivative L hL univ = 0

-- Riesz-Schwartz weak derivative representation
theorem seedDerivative_represents_weak_derivative {L : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, seed L v * φ' v) =
      (∫ v, φ v ∂seedDerivativeNegative L) - ∫ v, φ v ∂seedDerivativePositive L
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 representing the distributional derivative of arithmetic renewal seeds as an explicit Mathlib `SignedMeasure ℝ` and proving both its exact total mass cancellation to zero and its weak derivative pairing theorem.
