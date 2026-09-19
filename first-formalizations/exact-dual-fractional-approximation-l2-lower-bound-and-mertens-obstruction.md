# First Formalization: Exact Dual Fractional-Approximation L² Lower Bound and Mertens Obstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FractionalApproximation.lean`](../../formalization/BuildingBlocks/FractionalApproximation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact unconditional $L^2(0, 1)$ lower bound relating dual fractional-part approximations to the Mertens function, the reversible change of variables on shrinking intervals, the periodic error mean formula, and the conditional convergence exclusion in Lean 4:

1. **Quotient Coefficient Sum:**
   Formal proof of `quotient_coefficient_sum`: $\sum_{q=1}^N c_{N, q} = M(N)$.
2. **Periodic Reciprocal Error:**
   Formal proof of `reciprocalError_periodic`: $R_N(y+1) = R_N(y)$ and `reciprocalError_mean_zero_one`: $\int_0^1 R_N(y) dy = (M(N)+1)/2$.
3. **Cauchy-Schwarz Mean Square Lower Bound:**
   Formal proof of `reciprocalError_mean_square_lower`: $\int_1^2 R_N(y)^2 dy \ge (M(N)+1)^2 / 4$.
4. **Jacobian Change of Variables on Shrinking Window:**
   Formal proof of `dualWindowEnergy_eq_weighted`: $\int_{1/(2N)}^{1/N} (1 + D_N(x))^2 dx = \frac{1}{N} \int_1^2 \frac{R_N(y)^2}{y^2} dy$.
5. **Main $L^2$ Lower Bound:**
   Formal proof of `dualMeanSquareError_lower`: $\text{dualMeanSquareError}(N) \ge \frac{(M(N)+1)^2}{16 N}$.
6. **Normalized Mertens Limit and Route Exclusion:**
   Formal proof of `mertens_sq_normalized_tendsto_of_dual_error`: $E_2(N) \to 0 \implies M(N)^2 / N \to 0$, and `dual_error_not_tendsto_of_mertens_oscillation`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Sum of quotient coefficients equals the Mertens function
theorem quotient_coefficient_sum (N : ℕ) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) = (mertens N : ℝ)

-- Mean of the periodic reciprocal error
theorem reciprocalError_mean_zero_one (N : ℕ) :
    (∫ y in (0 : ℝ)..1, reciprocalError N y) = ((mertens N : ℝ) + 1) / 2

-- Jacobian transformation on shrinking window
theorem dualWindowEnergy_eq_weighted {N : ℕ} (hN : 0 < N) :
    dualWindowEnergy N = (1 / (N : ℝ)) *
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2 / y ^ 2

-- Main unconditional L² lower bound
theorem dualMeanSquareError_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualMeanSquareError N

-- Mertens square inequality
theorem mertens_sq_le_dual_error {N : ℕ} (hN : 0 < N) :
    (mertens N : ℝ) ^ 2 / (N : ℝ) ≤ 32 * dualMeanSquareError N + 2 / (N : ℝ)

-- Conditional route exclusion
theorem dual_error_not_tendsto_of_mertens_oscillation
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto dualMeanSquareError atTop (𝓝 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 connecting the Nyman-Beurling-Báez-Duarte fractional approximation error directly to the growth of the Mertens function, establishing the explicit lower bound $\ge (M(N)+1)^2/(16N)$ via 1-D Jacobian pullback.
