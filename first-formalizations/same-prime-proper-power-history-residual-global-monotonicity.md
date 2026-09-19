# First Formalization: Same-Prime Proper-Power History Residual Global Monotonicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeHistoryResidual.lean`](../../formalization/BuildingBlocks/SamePrimeHistoryResidual.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-negativity, global monotonicity, and delay contraction of the same-prime proper-power history residual in Lean 4:

1. **Kernel Monotonicity:**
   Formal proof that $h(v) = 0$ for $v \le 0$ and $h$ is globally monotone non-decreasing (`h_eq_zero_of_nonpos`, `h_monotone`).
2. **Individual Term Monotonicity:**
   Formal proof that each delayed prime power term is non-negative and monotone (`term_nonneg`, `term_monotone`).
3. **Active Power Support:**
   Formal proof that non-active terms with $p^m > \lfloor e^v \rfloor$ vanish identically (`term_eq_zero_of_not_active`, `s_eq_active_sum`).
4. **Global Monotonicity:**
   Formal derivation of $u \le v \implies s(u) \le s(v)$ under simultaneous continuous time and discrete floor cutoff growth (`s_monotone`).
5. **Universal Delay Contraction:**
   Formal deduction of $s(v - r) \le s(v)$ for all $r \ge 0$ (`s_delay_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-negativity of history residual
theorem s_nonneg (v : ℝ) : 0 ≤ s v

-- Global monotonicity across continuous and discrete cutoff growth
theorem s_monotone : Monotone s

-- Universal delay contraction
theorem s_delay_le (v : ℝ) {r : ℝ} (hr : 0 ≤ r) : s (v - r) ≤ s v

-- Active prime-power support representation
theorem s_eq_active_sum (v : ℝ) :
    s v = ∑ p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, if p.Prime then
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊,
        if p ^ m ≤ ⌊Real.exp v⌋₊ then term p m v else 0 else 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof that the cumulative causal feedback of higher prime powers is globally monotone and contractive under time delays.
