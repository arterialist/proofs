# First Formalization in Lean 4: Two-Exponential-Rate Weil Gram Factorization and Packet Derivative Positivity

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean`](../../formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean)  
**Dependencies:** `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the study of the complete Weil quadratic form on two causal exponentials $u_a(x) = e^{-ax}\mathbf{1}_{x \ge 0}$ and $u_b(x) = e^{-bx}\mathbf{1}_{x \ge 0}$, the continuous and discrete arithmetic interactions evaluate to the $2 \times 2$ Gram matrix with diagonal $F(a)/a, F(b)/b$ and off-diagonal $(F(a)+F(b))/(a+b)$, where $F(a) = \frac{\xi'}{\xi}(a+1/2)$.

This Lean 4 module establishes:
1. The exact algebraic factorization of the cleared Gram determinant numerator:
   \[
   AB(a-b)^2 - ab(A-B)^2 = (bA - aB)(bB - aA).
   \]
2. The positivity theorem proving that the determinant is strictly positive whenever the opposite ratio bounds $aB < bA$ and $aA < bB$ hold.
3. The rational zero-packet derivative identities for each conjugate/reflected quartet:
   \[
   g(a) = \frac{2a(a^2+p)}{a^4 + 2pa^2 + q^2}, \qquad p = \gamma^2 - \delta^2, \quad q = \gamma^2 + \delta^2.
   \]
   Machine-checks that for $a > 0, p > 0$, and $q^2 \le 2p^2$:
   \[
   \frac{d}{da}(a g(a)) = \frac{4a(pa^4 + 2q^2 a^2 + pq^2)}{(a^4 + 2pa^2 + q^2)^2} > 0,
   \]
   \[
   -\frac{d}{da}(g(a)/a) = \frac{4a(a^4 + 2pa^2 + 2p^2 - q^2)}{(a^4 + 2pa^2 + q^2)^2} > 0.
   \]

---

## 2. Machine-Verified Theorems

### 2.1 Packet Derivative Positivity

```lean
theorem packet_a_mul_derivative_num_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) :
    0 < p * a ^ 4 + 2 * q ^ 2 * a ^ 2 + p * q ^ 2

theorem packet_div_derivative_num_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) (hqp : q ^ 2 ≤ 2 * p ^ 2) :
    0 < a ^ 4 + 2 * p * a ^ 2 + 2 * p ^ 2 - q ^ 2

theorem packet_derivative_fractions_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) (hqp : q ^ 2 ≤ 2 * p ^ 2) :
    0 < 4 * a * (p * a ^ 4 + 2 * q ^ 2 * a ^ 2 + p * q ^ 2) /
        (a ^ 4 + 2 * p * a ^ 2 + q ^ 2) ^ 2 ∧
    0 < 4 * a * (a ^ 4 + 2 * p * a ^ 2 + 2 * p ^ 2 - q ^ 2) /
        (a ^ 4 + 2 * p * a ^ 2 + q ^ 2) ^ 2
```

### 2.2 Gram Determinant Factorization and Strict Positivity

```lean
theorem gram_det_factor (a b A B : ℝ) :
    A * B * (a - b) ^ 2 - a * b * (A - B) ^ 2 =
      (b * A - a * B) * (b * B - a * A)

theorem gram_det_pos {a b A B : ℝ}
    (hdiv : a * B < b * A) (hmul : a * A < b * B) :
    0 < A * B * (a - b) ^ 2 - a * b * (A - B) ^ 2
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/TwoRateWeilGramAlgebra.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.TwoRateWeilGramAlgebra.packet_derivative_fractions_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.TwoRateWeilGramAlgebra.gram_det_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
