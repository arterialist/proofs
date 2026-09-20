# First Formalization in Lean 4: Dyadic Factorial Deficit Recurrence and Uniform Margin

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/DivisionDyadicFactorial.lean`](../../formalization/BuildingBlocks/DivisionDyadicFactorial.lean)  
**Dependencies:** `Mathlib.NumberTheory.Harmonic.EulerMascheroni`, `Mathlib.Tactic.IntervalCases`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

The dyadic factorial deficit is defined by:
\[
A_n := n H_n - \log\left(\frac{(2n)!}{n!}\right), \qquad H_n = \sum_{j=1}^n \frac{1}{j}.
\]
This Lean 4 formalization establishes:
1. **Half-Shift Harmonic Inequality:** Proves that $H_n > 1/2 + \log(n + 1/2)$ for all $n \ge 1$, combining the monotonicity of Mathlib's `eulerMascheroniSeq` for $n \ge 6$ with certified interval Taylor bounds for $n \le 5$.
2. **Exact Increment Recurrence:** Proves algebraically that:
   \[
   A_{n+1} - A_n = H_n + 1 - \log(4n + 2).
   \]
3. **Strict Increment Margin:** Proves $A_{n+1} - A_n > \frac{3}{2} - \log 4$.
4. **Positive Deficit Margin:** Proves $\delta = \frac{3}{2} - \log 4 > 0$ using Mathlib's certified bounds on $\log 2$.
5. **Linear Deficit Growth:** By induction, establishes $A_n > n(3/2 - \log 4)$ for all $n \ge 1$.
6. **Uniform Normalized Negative Bound:** Proves $\frac{1}{n}\log\frac{(2n)!}{n!} - H_n < \log 4 - 3/2 < 0$.

---

## 2. Machine-Verified Theorems

```lean
noncomputable def dyadicFactorialDeficit (n : ℕ) : ℝ :=
  (n : ℝ) * (harmonic n : ℝ) -
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ))

theorem harmonic_gt_log_half_shift {n : ℕ} (hn : 1 ≤ n) :
    (1 : ℝ) / 2 + Real.log ((n : ℝ) + 1 / 2) < (harmonic n : ℝ)

theorem dyadicFactorialDeficit_succ (n : ℕ) :
    dyadicFactorialDeficit (n + 1) - dyadicFactorialDeficit n =
      (harmonic n : ℝ) + 1 - Real.log (4 * (n : ℝ) + 2)

theorem dyadicFactorialDeficit_increment_gt {n : ℕ} (hn : 1 ≤ n) :
    (3 : ℝ) / 2 - Real.log 4 <
      dyadicFactorialDeficit (n + 1) - dyadicFactorialDeficit n

theorem dyadicFactorialDeficit_gt {n : ℕ} (hn : 1 ≤ n) :
    (n : ℝ) * (3 / 2 - Real.log 4) < dyadicFactorialDeficit n

theorem dyadicFactorial_margin_pos : (0 : ℝ) < 3 / 2 - Real.log 4

theorem dyadicFactorial_average_lt {n : ℕ} (hn : 1 ≤ n) :
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ)) / (n : ℝ) -
      (harmonic n : ℝ) < Real.log 4 - 3 / 2

theorem dyadicFactorial_average_neg {n : ℕ} (hn : 1 ≤ n) :
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ)) / (n : ℝ) -
      (harmonic n : ℝ) < 0
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/DivisionDyadicFactorial.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.harmonic_gt_log_half_shift' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorialDeficit_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorialDeficit_increment_gt' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorialDeficit_gt' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorial_margin_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorial_average_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicFactorial_average_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All declarations depend strictly on foundational axioms with zero custom axioms.
