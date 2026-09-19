# First Formalization: Exact Prime Birth Discrete Correction Decay and Absolute Summability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeBirthSummability.lean`](../../formalization/BuildingBlocks/ChargeBirthSummability.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic cubic decay bound for arithmetic birth corrections and the absolute summability of von Mangoldt weighted discrete birth differences in Lean 4:

1. **Non-Asymptotic Decay Bound:**
   Formal proof of `correction_bounds`: $0 \le \text{correction}(y) \le \frac{1}{3 y \sqrt{y}}$ for all $y \ge 2$.
2. **Discrete Difference Identification:**
   Formal proof of `correction_eq_discrete_difference`: $\text{correction}(n) = \text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0)$ for all $n \ge 2$.
3. **Von Mangoldt Weighted Summability:**
   Formal proof of `weighted_correction_norm_summable`: $\sum_{n=2}^\infty \Lambda(n) |\text{correction}(n)| < \infty$.
4. **Physical Birth Difference Summability:**
   Formal proof of `weighted_discrete_difference_norm_summable`: $\sum_{n=2}^\infty \Lambda(n) \|\text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0)\| < \infty$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-asymptotic cubic decay bound for arithmetic birth correction
theorem correction_bounds {y : ℝ} (hy : 2 ≤ y) :
    0 ≤ correction y ∧ correction y ≤ 1 / (3 * y * Real.sqrt y)

-- Exact identification with the difference of successive discrete prime births
theorem correction_eq_discrete_difference {n : ℕ} (hn : 2 ≤ n) :
    correction n = discreteBirth n 1 - discreteBirth n 0

-- Unconditional absolute summability of von Mangoldt weighted corrections
theorem weighted_correction_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) * correction ((n + 2 : ℕ) : ℝ)‖)

-- Absolute summability of successive physical prime birth differences
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

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the non-asymptotic $O(y^{-3/2})$ decay rate for the arithmetic angle defect, its identification with discrete birth variations, and the absolute convergence of the prime-weighted defect series $\sum \Lambda(n) |\text{correction}(n)| < \infty$.
