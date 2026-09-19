# First Formalization: Exact Same-Prime History Activation Threshold and Cell Monotonicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeFirstSquare.lean`](../../formalization/BuildingBlocks/SamePrimeFirstSquare.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact dead-time inactivity of the same-prime history function $s(v)$ on $[0, \log 4]$, the exact activation dichotomy $s(v) > 0 \iff v > \log 4$, and the cell-by-cell strict monotonicity of the renewal profile $H(x)$ on $[k, k+1]$ in Lean 4:

1. **Proper-Power Floor:**
   Formal proof that $4 \le p^m$ for any prime $p$ and exponent $m \ge 2$ (`four_le_prime_power`).
2. **Dead-Time Inactivity:**
   Formal proof that $s(v) = 0$ for all $v \le \log 4$ (`s_eq_zero_of_le_log_four`).
3. **Activation Criterion:**
   Formal proof that $s(v) > 0 \iff v > \log 4$ (`s_pos_iff`).
4. **Strict Cell Monotonicity:**
   Formal proof that $H(x)$ is strictly monotone increasing on every integer cell $[k, k+1]$ ($k \ge 1$) (`H_strictMonoOn_cell`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Proper-power lower bound
theorem four_le_prime_power {p m : ℕ} (hp : p.Prime) (hm : 2 ≤ m) : 4 ≤ p ^ m

-- Dead-time support vanishing
theorem s_eq_zero_of_le_log_four {v : ℝ} (hv : v ≤ Real.log 4) : s v = 0

-- Strict activation immediately after log 4
theorem s_pos_of_log_four_lt {v : ℝ} (hv : Real.log 4 < v) : 0 < s v

-- Exact activation equivalence
theorem s_pos_iff (v : ℝ) : 0 < s v ↔ Real.log 4 < v

-- Strict monotonicity on integer cells
theorem H_strictMonoOn_cell {k : ℕ} (hk : 1 ≤ k) :
    StrictMonoOn H (Set.Icc (k : ℝ) ((k : ℝ) + 1))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the proper prime-power history function remains identically zero until the exact threshold $\log 4$, and demonstrating strict positivity thereafter alongside cell-by-cell strict monotonicity of renewal profiles.
