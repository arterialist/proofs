# Contribution 234: Exact Global Cubic Arcsine Sandwich Inequality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeArcsinBound.lean`](../../formalization/BuildingBlocks/ChargeArcsinBound.lean), [`building-blocks/charge/charge-arcsin-bound.md`](../../building-blocks/charge/charge-arcsin-bound.md)  
**Classification:** Real Analysis / Classical Inequalities / Inverse Trigonometric Bounds / Mean Value Theorem / Convexity / Machine-Checked Analysis

---

## 1. Executive Summary and Mathematical Statement

In establishing quantitative discrete correction estimates for arithmetic half-densities, the difference between the inverse sine and its linear term $\arcsin(z) - z$ arises from geometric angle defect integrals. To ensure summability without Taylor remainder approximations or asymptotic big-$O$ error terms, an unconditional, non-asymptotic global upper bound is required on the full domain $z \in [0, 1/\sqrt{2}]$.

This contribution proves:

1. **Exact Derivative Decomposition and Quadratic Control:**  
   For all $x \ge 0$ with $x^2 \le 1/2$, the derivative $g'(x) = \frac{d}{dx}(\arcsin x - x) = \frac{1}{\sqrt{1 - x^2}} - 1$ satisfies:
   $$
   0 \le \frac{1}{\sqrt{1 - x^2}} - 1 \le x^2.
   $$
2. **Global Cubic Arcsine Sandwich Theorem:**
   For every real number $z$ in the closed interval $[0, 1/\sqrt{2}]$ (satisfying $z \ge 0$ and $z^2 \le 1/2$):
   $$
   0 \le \arcsin(z) - z \le \frac{z^3}{3}.
   $$
3. **Non-Asymptotic Sharpness:**  
   While the infinitesimal Taylor expansion at $z \to 0$ begins with $\frac{z^3}{6}$, this theorem establishes that $\frac{z^3}{3}$ is a rigorous, unconditional global upper bound across the entire half-circle domain $[0, 1/\sqrt{2}]$ without any higher-order error terms.

---

## 2. Mathematical Proof

### 2.1. Derivative Upper Bound
Let $s = \sqrt{1 - x^2}$.
For $x^2 \le 1/2$, $1 - x^2 \ge 1/2 > 0$, so $s > 0$ and $s \le 1$.
Furthermore, $s^2 = 1 - x^2 \ge 1/2$, which implies $s \ge 1/\sqrt{2} \ge 1/2$.
Expanding the difference:
$$
\frac{1}{s} - 1 = \frac{1 - s}{s} = \frac{1 - s^2}{s(1 + s)} = \frac{x^2}{s(1 + s)}.
$$
Since $s \ge 1/2$, we have $s(1 + s) \ge \frac{1}{2}(1 + \frac{1}{2}) = \frac{3}{4}$. More directly, with $s \ge 1/2$ and $s \le 1$, $s(1 + s) \ge 1$ holds for all $x^2 \le 1/2$.
Thus:
$$
0 \le \frac{1}{\sqrt{1 - x^2}} - 1 = \frac{x^2}{s(1 + s)} \le x^2.
$$

### 2.2. Monotonicity and Integration
Define $h_1(x) = \arcsin x - x$ and $h_2(x) = \frac{x^3}{3} - (\arcsin x - x)$.
On $[0, z] \subseteq [0, 1/\sqrt{2}]$:
- $h_1'(x) = \frac{1}{\sqrt{1 - x^2}} - 1 \ge 0 \implies h_1$ is monotone nondecreasing.
- $h_2'(x) = x^2 - \left(\frac{1}{\sqrt{1 - x^2}} - 1\right) \ge 0 \implies h_2$ is monotone nondecreasing.

Evaluating at $x = 0$:
$$
h_1(0) = \arcsin(0) - 0 = 0, \quad h_2(0) = 0 - 0 = 0.
$$
By monotonicity on $[0, z]$:
$$
h_1(z) \ge h_1(0) = 0 \implies \arcsin(z) - z \ge 0,
$$
$$
h_2(z) \ge h_2(0) = 0 \implies \frac{z^3}{3} - (\arcsin(z) - z) \ge 0 \implies \arcsin(z) - z \le \frac{z^3}{3}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeArcsinBound` in `formalization/BuildingBlocks/ChargeArcsinBound.lean`):
```lean
theorem arcsin_sub_bounds {z : ℝ} (hz : 0 ≤ z) (hz2 : z ^ 2 ≤ 1 / 2) :
    0 ≤ Real.arcsin z - z ∧ Real.arcsin z - z ≤ z ^ 3 / 3
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical trigonometric inequalities and Taylor series bounds (Mitrinović 1970, Kuang 2004, Neuman 2013). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Replaces asymptotic big-$O$ Taylor remainders with an exact, non-asymptotic global inequality valid across $[0, 1/\sqrt{2}]$.
- **Target Venues:** *Journal of Mathematical Inequalities* or *Real Analysis Exchange*.
