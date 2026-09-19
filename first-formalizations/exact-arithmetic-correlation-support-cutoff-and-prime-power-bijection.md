# First Formalization: Exact Arithmetic Correlation Support Cutoff and Prime-Power Bijection

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean`](../../formalization/BuildingBlocks/CompleteArithmeticCorrelation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the constructive bijection between von Mangoldt sums and prime powers, proves cross-correlation support vanishing, and proves the exact finitary collapse of arithmetic correlation rows in Lean 4:

1. **Von Mangoldt Prime-Power Bijection:**
   Formal proof of `weighted_von_mangoldt_prime_powers`: Machine bijection between $\sum_{n=1}^N \Lambda(n) w(n)$ and $\sum_{p \le N, j \ge 1} (\log p) w(p^j)$.
2. **Correlation Support Width Vanishing:**
   Formal proof of `correlation_zero_of_width`: $\text{correlation}(f, g)(x) = 0$ for $x \ge b - a$.
3. **Finitary Collapse of Arithmetic Series:**
   Formal proof of `arithmetic_row_eq_cutoff`: $\text{arithmeticRow}(f, g) = \text{arithmeticCutoff}(N, f, g)$ for $N + 1 \ge e^{b - a}$.
4. **Finite Prime-Power Cutoff Identity:**
   Formal proof of `arithmetic_cutoff_eq_prime_powers`: $\text{arithmeticCutoff}(N, f, g) = \text{primePowerCutoff}(N, f, g)$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact constructive bijection between von Mangoldt sums and prime powers
theorem weighted_von_mangoldt_prime_powers (N : ℕ) (w : ℕ → ℂ) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * w n) =
      ∑ p ∈ Finset.Icc 2 N, if p.Prime then
        ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then (Real.log (p : ℝ) : ℂ) * w (p ^ j) else 0 else 0

-- Identical vanishing of cross-correlations outside the combined support width
theorem correlation_zero_of_width {f g : ℝ → ℂ} {a b x : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (hx : b - a ≤ x) :
    correlation f g x = 0

-- Finite truncation equivalence for compactly supported test functions
theorem arithmetic_row_eq_cutoff {f g : ℝ → ℂ} {a b : ℝ}
    (hf : ∀ v, f v ≠ 0 → a < v ∧ v < b)
    (hg : ∀ v, g v ≠ 0 → a < v ∧ v < b) (N : ℕ)
    (hN : Real.exp (b - a) ≤ (N : ℝ) + 1) :
    arithmeticRow f g = arithmeticCutoff N f g

-- Identity between arithmetic cutoff and prime power sum
theorem arithmetic_cutoff_eq_prime_powers (N : ℕ) (f g : ℝ → ℂ) :
    arithmeticCutoff N f g = primePowerCutoff N f g
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact constructive prime-power bijection for general weighted von Mangoldt sums and the finitary collapse of arithmetic cross-correlation rows for compactly supported wave packets.
