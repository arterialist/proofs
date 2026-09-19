# First Formalization: Arcsine Charge Correction and Discrete Birth Summability

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ChargeBirthSummability.lean`](../../formalization/BuildingBlocks/ChargeBirthSummability.lean), [`formalization/BuildingBlocks/ChargeArcsinBound.lean`](../../formalization/BuildingBlocks/ChargeArcsinBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic derivative bounds on the arcsine function and verifies the absolute summability of the initial discrete prime birth steps:

1. **Monotone Derivative Bounds on Arcsine:**
   Formal mean-value theorem proof showing that for all $0 \le z$ with $z^2 \le 1/2$, the difference $\arcsin z - z$ satisfies $0 \le \arcsin z - z \le z^3/3$ (`arcsin_sub_bounds`).
2. **Scale Decay of Charge Correction:**
   Formal application to $z = 1/\sqrt{y}$ proving that for all $y \ge 2$, the correction satisfies $0 \le \operatorname{correction}(y) \le \frac{1}{3 y^{3/2}}$ (`correction_bounds`).
3. **Discrete Birth Jump Identification:**
   Formal algebraic unfolding showing that the analytic correction at natural number $n \ge 2$ identically equals the first discrete birth jump $\operatorname{discreteBirth}(n, 1) - \operatorname{discreteBirth}(n, 0)$ (`correction_eq_discrete_difference`).
4. **Weighted Absolute Summability:**
   Formal comparison test with the summable power series $\sum \Lambda(n)/n^{3/2} < \infty$, establishing the absolute summability of both the analytic correction (`weighted_correction_norm_summable`) and the discrete jump sequence (`weighted_discrete_difference_norm_summable`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-asymptotic cubic arcsine bound
theorem arcsin_sub_bounds {z : ℝ} (hz : 0 ≤ z) (hz2 : z ^ 2 ≤ 1 / 2) :
    0 ≤ Real.arcsin z - z ∧ Real.arcsin z - z ≤ z ^ 3 / 3

-- Scale decay bound on [2, \infty)
theorem correction_bounds {y : ℝ} (hy : 2 ≤ y) :
    0 ≤ correction y ∧ correction y ≤ 1 / (3 * y * Real.sqrt y)

-- Exact discrete birth jump identity
theorem correction_eq_discrete_difference {n : ℕ} (hn : 2 ≤ n) :
    correction n = discreteBirth n 1 - discreteBirth n 0

-- Absolute summability of von Mangoldt weighted discrete jumps
theorem weighted_discrete_difference_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) *
      (discreteBirth (n + 2) 1 - discreteBirth (n + 2) 0)‖)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof of the non-asymptotic $1/(3n^{3/2})$ decay of the angular charge correction and the unconditional $l^1$ convergence of discrete prime birth increments in Lean 4.
