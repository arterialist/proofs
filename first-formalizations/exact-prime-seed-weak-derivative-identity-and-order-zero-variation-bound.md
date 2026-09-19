# First Formalization: Exact Prime Seed Weak Derivative Identity and Order-Zero Variation Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedWeakDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedWeakDerivative.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact weak derivative pairing formula and order-zero operator norm bound for the prime renewal seed via infinite boundary-cell telescoping in Lean 4:

1. **Intra-Cell Integration by Parts:**
   Formal proof of the single-cell integration-by-parts formula equating $\int_{I_j} \text{seed}_L (\phi' + \phi/2)$ to endpoint evaluations $A_j - B_j$ (`seed_cell_weak_derivative`).
2. **Infinite Telescoping Weak Derivative Identity:**
   Formal proof that summing across all cells yields $-\frac{1}{2}\int \text{seed}_L \phi - e^{-3L/2}\phi(L) + \sum_{j=0}^\infty (1 - e^{-L})e^{-(j+2)L/2}\phi((j+2)L)$ (`seed_weak_derivative`).
3. **Order-Zero Distributional Estimate:**
   Formal proof of the quantitative bound $|\int \text{seed}_L \phi'| \le (2e^{-L} + 2e^{-3L/2}) M$ for test functions bounded by $M$ (`seed_weak_derivative_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Intra-cell integration by parts
theorem seed_cell_weak_derivative {L : ℝ} (hL : 0 < L) (j : ℕ)
    {φ φ' : ℝ → ℝ} (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ') :
    (∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L),
      seed L v * (φ' v + φ v / 2)) =
      exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) -
        exp (-((j + 3 : ℝ) * L) / 2) * φ ((j + 1 : ℝ) * L)

-- Full weak derivative pairing identity
theorem seed_weak_derivative {L : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, seed L v * φ' v) = -(1 / 2) * (∫ v, seed L v * φ v) -
      exp (-3 * L / 2) * φ L +
        ∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L)

-- Order-zero operator bound
theorem seed_weak_derivative_bound {L M : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∀ v, |φ v| ≤ M) (hb' : ∃ M', ∀ v, |φ' v| ≤ M') :
    |∫ v, seed L v * φ' v| ≤ (2 * exp (-L) + 2 * exp (-3 * L / 2)) * M
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the full weak derivative pairing formula and establishing the order-zero variation bound for prime renewal seeds through infinite cell telescoping.
