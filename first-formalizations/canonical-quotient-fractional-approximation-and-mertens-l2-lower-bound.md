# First Formalization: Canonical Quotient Fractional Approximation and Mertens $L^2$ Lower Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FractionalApproximation.lean`](../../formalization/BuildingBlocks/FractionalApproximation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the $L^2(0, 1)$ lower bound and obstruction for Báez-Duarte fractional part approximations using canonical arithmetic quotient coefficients:

1. **Quotient Coefficient Sum and Mass Grouping:**
   Formal proof that $\sum_{q=1}^N c_q(N) = M(N)$ (`quotient_coefficient_sum`).
2. **Periodic Reciprocal Error Formulation:**
   Formal construction of the 1-periodic error function in reciprocal coordinates $y = 1/(N x)$ (`reciprocalError_periodic`, `dualApproximation_reciprocal`).
3. **Unit Interval Integrals of Fractional Parts:**
   Formal proof of $\int_0^1 \{q y\} dy = 1/2$ for all integers $q \ge 1$ (`integral_fract_nat_mul`).
4. **Window Energy and $L^2$ Lower Bound:**
   Formal proof that the $L^2(0, 1)$ mean square error is bounded below by $(M(N)+1)^2 / (16 N)$ (`dualMeanSquareError_lower`).
5. **Mertens Oscillation Obstruction:**
   Formal deduction that $M(N)^2 / N \le 32 \operatorname{dualMeanSquareError}(N) + 2/N$ (`mertens_sq_le_dual_error`), and that convergence of the dual error to zero forces $M(N)^2/N \to 0$ (`mertens_sq_normalized_tendsto_of_dual_error`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Total quotient coefficient sum equals Mertens
theorem quotient_coefficient_sum (N : ℕ) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) = (mertens N : ℝ)

-- Mean square error lower bound
theorem dualMeanSquareError_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualMeanSquareError N

-- Mertens quadratic bound
theorem mertens_sq_le_dual_error {N : ℕ} (hN : 0 < N) :
    (mertens N : ℝ) ^ 2 / (N : ℝ) ≤ 32 * dualMeanSquareError N + 2 / (N : ℝ)

-- Limit implication
theorem mertens_sq_normalized_tendsto_of_dual_error
    (h : Tendsto dualMeanSquareError atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of an explicit $L^2$ lower bound on Báez-Duarte fractional-part approximations in terms of the Mertens function, demonstrating why arithmetic quotient coefficients cannot achieve zero $L^2$ error.
