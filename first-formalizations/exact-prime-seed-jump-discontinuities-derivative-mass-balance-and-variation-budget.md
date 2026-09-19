# First Formalization: Exact Prime Seed Jump Discontinuities, Derivative Mass Balance, and Variation Budget

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedJumps.lean`](../../formalization/BuildingBlocks/PrimeSeedJumps.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes one-sided limits and jump amplitudes across all clock points, the strict negativity of proper-power step jumps, continuous intra-cell derivatives, infinite downward jump series evaluation, derivative mass balance, and the exact total variation budget for prime successor seeds in Lean 4:

1. **One-Sided Limits and Discontinuities:**
   Formal proofs of right limits at clock values, left birth limits, and left limits at proper powers (`seed_clock_right_limit`, `seed_birth_left_limit`, `seed_power_left_limit`).
2. **Proper-Power Jump Negativity:**
   Formal evaluation of the proper-power jump amplitude and proof of its strict negativity (`seed_power_jump`, `seed_power_jump_neg`).
3. **Continuous Cell Derivatives:**
   Formal proof that $\frac{d}{dv}\text{seed}_L(v) = \frac{1}{2}\text{seed}_L(v)$ on open cells (`seed_hasDerivAt_in_cell`).
4. **Infinite Jump Summation:**
   Formal proof that $\sum_{j=0}^\infty (1 - e^{-L}) e^{-(j+2)L/2} = e^{-L} + e^{-3L/2}$ (`hasSum_seed_negative_jumps`).
5. **Derivative Mass Balance and Total Variation:**
   Formal proof of exact cancellation $\frac{1}{2}\int \text{seed}_L + e^{-3L/2} - \sum |\Delta| = 0$ (`seed_derivative_mass_balance`) and total variation budget $\text{TV} = 2 e^{-L} + 2 e^{-3L/2}$ (`seed_derivative_variation_budget`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Right limit at clock points
theorem seed_clock_right_limit {L : ℝ} (hL : 0 < L) (j : ℕ) :
    Tendsto (seed L) (𝓝[≥] ((j + 1 : ℝ) * L)) (𝓝 (exp (-((j + 3 : ℝ) * L) / 2)))

-- Negative jump amplitude formula
theorem seed_power_jump {L : ℝ} (hL : 0 < L) (j : ℕ) :
    seed L ((j + 2 : ℝ) * L) - exp (-((j + 2 : ℝ) * L) / 2) =
      -(1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)

theorem seed_power_jump_neg {L : ℝ} (hL : 0 < L) (j : ℕ) :
    seed L ((j + 2 : ℝ) * L) - exp (-((j + 2 : ℝ) * L) / 2) < 0

-- Continuous intra-cell derivative
theorem seed_hasDerivAt_in_cell {L v : ℝ} (hL : 0 < L) (j : ℕ)
    (hv : v ∈ Ioo ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) :
    HasDerivAt (seed L) (seed L v / 2) v

-- Infinite jump summation
theorem hasSum_seed_negative_jumps {L : ℝ} (hL : 0 < L) :
    HasSum (fun j : ℕ => (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2))
      (exp (-L) + exp (-3 * L / 2))

-- Derivative mass balance identity
theorem seed_derivative_mass_balance {L : ℝ} (hL : 0 < L) :
    (1 / 2) * (∫ v, seed L v) + exp (-3 * L / 2) -
      (∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) = 0

-- Total variation budget
theorem seed_derivative_variation_budget {L : ℝ} (hL : 0 < L) :
    (1 / 2) * (∫ v, seed L v) + exp (-3 * L / 2) +
      (∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) =
        2 * exp (-L) + 2 * exp (-3 * L / 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 calculating the exact jump discontinuities of prime successor seeds, proving that positive continuous growth and birth jumps balance the infinite downward proper-power jumps to zero, and determining the exact total variation budget.
