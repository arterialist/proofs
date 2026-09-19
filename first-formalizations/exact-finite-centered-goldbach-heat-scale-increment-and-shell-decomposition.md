# First Formalization: Exact Finite Centered-Goldbach Heat Scale Increment and Shell Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact finite heat-scale increment identities and 4-way marginal shell decompositions for centered Goldbach convolutions in Lean 4:

1. **Pointwise Centering Decompositions:**
   Formal proof of `truncatedCoefficient_decomposition` and `truncatedCoefficient_le_prime_add_count`.
2. **Horizon Doubling Identity:**
   Formal proof of `finiteHeatHorizon_double_sub`:
   \[
   \mathcal{H}_Y(2T) - \mathcal{H}_Y(T) = \Delta_T \mathcal{H}_Y(T).
   \]
3. **Squared Heat Flow Integral Representation:**
   Formal proof of `finiteHeatScaleIncrement_eq_integral`:
   \[
   \Delta_T \mathcal{H}_Y(T) = \int_{e^{-2T}}^{e^{-T}} (\text{finiteHeat}(t))^2 dt.
   \]
4. **4-Way Centering Shell Decomposition:**
   Formal definitions of `primeScaleIncrement`, `leftMarginalScaleIncrement`, `rightMarginalScaleIncrement`, and `pairCountScaleIncrement`, and proof of `finiteHeatScaleIncrement_decomposition`.
5. **Parity Splitting and Component Positivity:**
   Formal proof of `finiteHeatScaleIncrement_parity`, `shellKernel_nonneg`, `primeScaleIncrement_nonneg`, `leftMarginalScaleIncrement_nonneg`, `rightMarginalScaleIncrement_nonneg`, and `pairCountScaleIncrement_nonneg`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact horizon doubling step identity
theorem finiteHeatHorizon_double_sub (Y : ℕ) (T : ℝ) :
    finiteHeatHorizon Y (2 * T) - finiteHeatHorizon Y T =
      finiteHeatScaleIncrement Y T

-- Integral representation as squared heat flow
theorem finiteHeatScaleIncrement_eq_integral (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      ∫ t in exp (-2 * T)..exp (-T),
        (finiteHeat centeredCoefficient Y t) ^ 2

-- 4-way marginal decomposition
theorem finiteHeatScaleIncrement_decomposition (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      primeScaleIncrement Y T - leftMarginalScaleIncrement Y T -
        rightMarginalScaleIncrement Y T + pairCountScaleIncrement Y T

-- Parity decomposition
theorem finiteHeatScaleIncrement_parity (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      evenScaleIncrement Y T + oddScaleIncrement Y T

-- Non-negativity of shell kernel
theorem shellKernel_nonneg {T : ℝ} (hT : 0 ≤ T) {N : ℕ} (hN : 0 < N) :
    0 ≤ shellKernel T N
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact finite heat-scale increment for centered Goldbach convolutions as an integrated squared heat flow, equipped with exact horizon-doubling formulas, 4-way marginal decompositions, and parity splits.
