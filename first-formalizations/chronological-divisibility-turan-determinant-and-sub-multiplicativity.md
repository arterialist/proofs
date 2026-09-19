# First Formalization: Chronological Divisibility Turán Determinant and Sub-Multiplicativity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChronologicalDivisibility.lean`](../../formalization/BuildingBlocks/ChronologicalDivisibility.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the monotonicity, multiplicative Turán inequality, and sub-multiplicativity of chronological divisibility probabilities in Lean 4:

1. **Chronological Tent Function:**
   Formal construction of $S(x) = \sum_{j=1}^{\lfloor x \rfloor} (x - j)/\sqrt{j}$ and proof of positivity for $x > 1$ (`S_pos`) and vanishing for $x \le 1$ (`S_eq_zero_of_le_one`).
2. **Dilation Probability Monotonicity:**
   Formal proof that $\mathbb{P}(r \mid x) = \frac{\sqrt{r} S(x/r)}{S(x)}$ is monotone non-decreasing on $(1, \infty)$ for all $r \ge 1$ (`probability_monotoneOn`).
3. **Multiplicative Turán Inequality:**
   Formal proof that the $2 \times 2$ dilation determinant $S(x/a) S(x/b) - S(x) S(x/(ab))$ is unconditionally non-negative for all $a, b \ge 1$ and $x > 1$ (`determinant_nonneg`).
4. **Sub-Multiplicativity of Joint Divisibility:**
   Formal deduction that $\mathbb{P}(ab \mid x) \le \mathbb{P}(a \mid x) \mathbb{P}(b \mid x)$ (`probability_mul_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Monotonicity of dilation probability
theorem probability_monotoneOn {r : ℕ} (hr : 1 ≤ r) :
    MonotoneOn (probability r) (Set.Ioi 1)

-- Multiplicative Turán determinant non-negativity
theorem determinant_nonneg {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    0 ≤ S (x / a) * S (x / b) - S x * S (x / (a * b : ℕ))

-- Sub-multiplicativity of joint divisibility events
theorem probability_mul_le {a b : ℕ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    {x : ℝ} (hx : 1 < x) :
    probability (a * b) x ≤ probability a x * probability b x

-- Positivity of chronological tent function
theorem S_pos {x : ℝ} (hx : 1 < x) : 0 < S x
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of negative correlation and sub-multiplicativity of divisibility events in continuous chronological tent measures, establishing the non-negativity of dilation determinants.
