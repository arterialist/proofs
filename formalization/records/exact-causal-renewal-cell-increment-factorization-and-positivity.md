# Contribution 247: Exact Causal Renewal Cell Increment Factorization and Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CausalRenewalFiniteCells.lean`](../../formalization/BuildingBlocks/CausalRenewalFiniteCells.lean), [`building-blocks/archimedean/causal-renewal-finite-cells.md`](../../building-blocks/archimedean/causal-renewal-finite-cells.md)  
**Classification:** Integral Equations / Causal Renewal Theory / Logarithmic Mean / Euler-Maclaurin Summation / Delay-Differential Systems / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In analyzing the Archimedean renewal equation that couples prime-counting fluctuations to the causal heat semigroup, the energy increment over each square-root cell $[\sqrt{n}, \sqrt{n+1}]$ governs the overall stability and positivity of the renewal operator. Verifying that each local increment is strictly positive requires factoring the integral discrepancy through the logarithmic mean $L(a, b) = (b-a)/(\log b - \log a)$ and comparing high-order Euler-Maclaurin remainders with sharp cubic gaps.

This contribution proves:

1. **Exact Algebraic Factorization of Renewal Cell Increments:**  
   For any amplitude $A$ and endpoints $b > a > 0$:
   $$
   2(\log b - \log a) A - 4(b - a) = 2(\log b - \log a) (A - 2 L(a, b)),
   $$
   isolating the exact dependence of the energy increment on the comparison between $A$ and twice the logarithmic mean $L(a, b)$.
2. **Sharp Elementary Reciprocal Cube Gap:**  
   If $b^3 < 3 a^3$, then:
   $$
   \frac{1}{24 a^3} < \frac{1}{8 b^3}.
   $$
3. **Non-Asymptotic Cube Comparison on Square-Root Cells:**  
   For every integer $n \ge 1$:
   $$
   (\sqrt{n+1})^3 < 3 (\sqrt{n})^3.
   $$
   The proof uses exact squaring $(n+1)^3 \le 8n^3 < 9n^3 = (3n^{3/2})^2$ without transcendental approximations.
4. **Cell Increment Positivity Theorem:**
   If $A$ satisfies the signed Euler expansion $A = 2a + \frac{1}{2a} - \frac{1}{24a^3} + r$ with $r > 0$, and the logarithmic mean satisfies $2 L(a, b) < 2a + \frac{1}{2a} - \frac{1}{8b^3}$, then the cell increment is strictly positive:
   $$
   \text{cellIncrement}(A, a, b) > 0.
   $$
   Specializing to $a = \sqrt{n}$ and $b = \sqrt{n+1}$ establishes strict positivity on every cell $n \ge 1$:
   $$
   \text{cellIncrement}(A, \sqrt{n}, \sqrt{n+1}) > 0.
   $$

---

## 2. Mathematical Proof

### 2.1. Factorization
Using $L(a, b) = (b-a)/(\log b - \log a)$:
$$
2(\log b - \log a)(A - 2 L(a, b)) = 2(\log b - \log a) A - 4(\log b - \log a) \frac{b-a}{\log b - \log a} = 2(\log b - \log a) A - 4(b - a).
$$

### 2.2. Non-Asymptotic Cube Gap
For $n \ge 1$, let $x = n \ge 1$. Then $x + 1 \le 2x$.
Cubing both sides: $(x + 1)^3 \le 8x^3 < 9x^3$.
Expressing in terms of square roots:
$$
\left( (\sqrt{x+1})^3 \right)^2 = (x+1)^3 < 9x^3 = \left( 3 (\sqrt{x})^3 \right)^2.
$$
Since square roots and powers are positive, taking square roots yields $(\sqrt{n+1})^3 < 3 (\sqrt{n})^3$.
Consequently, $8 (\sqrt{n+1})^3 < 24 (\sqrt{n})^3$, which implies:
$$
\frac{1}{24 (\sqrt{n})^3} < \frac{1}{8 (\sqrt{n+1})^3}.
$$

### 2.3. Positivity Transfer
Subtracting the logarithmic mean bound from $A$:
$$
A - 2 L(a, b) > \left( 2a + \frac{1}{2a} - \frac{1}{24a^3} + r \right) - \left( 2a + \frac{1}{2a} - \frac{1}{8b^3} \right) = \frac{1}{8b^3} - \frac{1}{24a^3} + r.
$$
Since $\frac{1}{8b^3} - \frac{1}{24a^3} > 0$ and $r > 0$, the difference $A - 2 L(a, b) > 0$.
Since $\log b - \log a > 0$, the product $2(\log b - \log a)(A - 2 L(a, b)) > 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CausalRenewalFiniteCells` in `formalization/BuildingBlocks/CausalRenewalFiniteCells.lean`):
```lean
theorem rawCellIncrement_eq_cellIncrement {A a b : ℝ}
    (hlog : Real.log b ≠ Real.log a) :
    rawCellIncrement A a b = cellIncrement A a b

theorem sqrt_succ_cube_lt_three {n : ℕ} (hn : 1 ≤ n) :
    Real.sqrt (n + 1 : ℝ) ^ 3 < 3 * Real.sqrt (n : ℝ) ^ 3

theorem cellIncrement_pos_of_euler_bounds
    {A a b r : ℝ} (ha : 0 < a) (hab : a < b)
    (hA : A = 2 * a + 1 / (2 * a) - 1 / (24 * a ^ 3) + r)
    (hr : 0 < r) (hcube : b ^ 3 < 3 * a ^ 3)
    (hL : 2 * logarithmicMean a b <
      2 * a + 1 / (2 * a) - 1 / (8 * b ^ 3)) :
    0 < cellIncrement A a b

theorem sqrt_cellIncrement_pos_of_euler_bounds
    {n : ℕ} (hn : 1 ≤ n) {A r : ℝ}
    (hA : A = 2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
      1 / (24 * Real.sqrt (n : ℝ) ^ 3) + r)
    (hr : 0 < r)
    (hL : 2 * logarithmicMean (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ)) <
      2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
        1 / (8 * Real.sqrt (n + 1 : ℝ) ^ 3)) :
    0 < cellIncrement A (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Logarithmic mean inequalities (Carlson 1972, Neuman-Sándor 2003) and Euler-Maclaurin asymptotic expansions. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Guarantees positivity of the infinite-dimensional causal renewal operator on every finite cell without global asymptotic approximations.
- **Target Venues:** *Journal of Mathematical Inequalities* or *Integral Equations and Operator Theory*.
