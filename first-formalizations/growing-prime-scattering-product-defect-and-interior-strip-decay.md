# First Formalization: Growing Prime Scattering Product Defect and Interior Strip Decay

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean`](../../formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization provides the first machine-verified proof of uniform block product defect bounds and critical strip interior tail decay for growing prime scattering multipliers:

1. **Power and Multiplier Dictionaries:**
   Formal equivalence of complex power notations and scattering multipliers (`full_power_dictionary`, `full_history_dictionary`).
2. **Paired Multiplier Exact Factorization:**
   Formal proof of multiplier factorization into rational ratios and tail defects, and their paired product identity (`multiplier_tail_factorization`, `paired_tail_factorization`).
3. **Decay Budget and Gap Inequality:**
   Formal proof of the exponential gap bound $\frac{x}{1+x} \le 1 - e^{-x}$ (`exponential_denominator_bound`) and monotonicity of the decay budget (`decay_budget_mono`).
4. **Single-Prime Uniform Tail Decay:**
   Formal proof that for $p \ge P > 1$ and $|\operatorname{Re}(z)| \le 1/2 - \delta$, the defect norm decays geometrically as $P^{-M\delta} (1 + \frac{1}{\delta \log P})$ (`actual_uniform_tail_bound`).
5. **Finite Block Product Comparison:**
   Formal proof that the product of paired multipliers across any finite prime block deviates from 1 by at most $\exp(|s|(2B + B^2)) - 1$ (`actual_uniform_block_comparison`).
6. **Weighted Infinite Sum Splitting:**
   Formal identity and bounds for splitting infinite prime-weighted series into low and high blocks (`actual_block_weighted_tsum_comparison`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Uniform tail bound in the critical strip interior
theorem actual_uniform_tail_bound (p : ℕ) (hp : 2 ≤ p) (P : ℝ)
    (hP : 1 < P) (hPp : P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    ‖originalDefect (p : ℝ) z M‖ ≤
      Real.exp (-(M : ℝ) * (delta * Real.log P)) *
        ((1 + delta * Real.log P) / (delta * Real.log P))

-- Uniform block product defect bound
theorem actual_uniform_block_comparison (s : Finset ℕ)
    (hs : ∀ p ∈ s, 2 ≤ p) (P : ℝ) (hP : 1 < P)
    (hPs : ∀ p ∈ s, P ≤ p) (z : ℂ) (M : ℕ) (delta : ℝ)
    (hd : 0 < delta) (hz : |z.re| ≤ 1 / 2 - delta) :
    let B := Real.exp (-(M : ℝ) * (delta * Real.log P)) *
      ((1 + delta * Real.log P) / (delta * Real.log P))
    ‖(∏ p ∈ s, paired p z M) - 1‖ ≤
      Real.exp ((s.card : ℝ) * (2 * B + B ^ 2)) - 1
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization establishes the first machine-verified bounds on finite prime block scattering products across the critical strip interior, establishing explicit quantitative decay in history truncation depth $M$.
