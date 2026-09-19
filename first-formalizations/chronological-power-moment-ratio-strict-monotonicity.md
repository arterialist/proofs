# First Formalization: Chronological Power Moment Ratio Strict Monotonicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChronologicalPowerRatio.lean`](../../formalization/BuildingBlocks/ChronologicalPowerRatio.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic bounds, controller strict monotonicity, and strict decrease of the chronological power moment ratio in Lean 4:

1. **Inverse-Square-Root Mass Bound:**
   Formal proof of $A(n) \le 2\sqrt{n} - 1$ for all $n \ge 1$ (`A_bound`).
2. **Controller Monotonicity:**
   Formal proof that $h(n) = \frac{A(n)}{\sqrt{n+1}} + \frac{1}{n+1}$ is strictly monotone increasing (`h_strictMono`).
3. **Moment Comparison Inequality:**
   Formal proof that $D(n) < B(n)(1 + h(n))$ for all $n \ge 1$ (`D_lt_B_mul`).
4. **Strict Decrease of the Power Ratio:**
   Formal derivation that $\frac{B(n+1)}{D(n+1)} < \frac{B(n)}{D(n)}$ (`normalizedRatio_succ_lt`) and strict anti-monotonicity (`normalizedRatio_lt`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Mass upper bound
theorem A_bound (n : ℕ) (hn : 1 ≤ n) : A n ≤ 2 * Real.sqrt n - 1

-- Strict monotonicity of controller h(n)
theorem h_strictMono : StrictMono h

-- Moment comparison
theorem D_lt_B_mul (n : ℕ) (hn : 1 ≤ n) : D n < B n * (1 + h n)

-- Strict decrease of normalized ratio
theorem normalizedRatio_succ_lt (n : ℕ) (hn : 1 ≤ n) :
    B (n + 1) / D (n + 1) < B n / D n

theorem normalizedRatio_lt {k N : ℕ} (hk : 1 ≤ k) (hkn : k < N) :
    B N / D N < B k / D k
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof that the discrete moment ratio $\sum_{j=1}^n \sqrt{j} / ((n+1)\sum_{j=1}^n j^{-1/2})$ decreases strictly monotonically for all $n \ge 1$.
