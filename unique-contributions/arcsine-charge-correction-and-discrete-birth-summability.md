# Unique Contribution 48: Arcsine Charge Correction and Absolute Summability of Discrete Prime Birth Jumps

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeBirthSummability.lean`](../../formalization/BuildingBlocks/ChargeBirthSummability.lean), [`formalization/BuildingBlocks/ChargeArcsinBound.lean`](../../formalization/BuildingBlocks/ChargeArcsinBound.lean), [`formalization/BuildingBlocks/IntegerBirthDiscreteCorrection.lean`](../../formalization/BuildingBlocks/IntegerBirthDiscreteCorrection.lean)  
**Classification:** Prime Number Theory / Harmonic Analysis / Special Functions

---

## 1. Executive Summary and Mathematical Statement

In the discrete renewal formulation of prime counting functions, the continuous circular angle transformation converts the normalized step coordinate into an angular phase $\arcsin(1/\sqrt{n})$. The difference between this angular phase and the flat Archimedean rate $1/\sqrt{n}$ defines the initial charge correction:
\[
\operatorname{correction}(n) = \arcsin\left(\frac{1}{\sqrt{n}}\right) - \frac{1}{\sqrt{n}}.
\]
This contribution establishes:

1. **Non-Asymptotic Arcsine Derivative Enclosure:**
   For all $z \in [0, 1/\sqrt{2}]$, the non-asymptotic mean-value derivative bounds prove:
   \[
   0 \le \arcsin z - z \le \frac{z^3}{3}.
   \]
2. **Sharp $n^{-3/2}$ Charge Correction Decay:**
   For every real scale $y \ge 2$:
   \[
   0 \le \arcsin\left(\frac{1}{\sqrt{y}}\right) - \frac{1}{\sqrt{y}} \le \frac{1}{3 y^{3/2}}.
   \]
3. **Exact Identification with Initial Discrete Birth Jumps:**
   For all integers $n \ge 2$, the charge correction is identically equal to the initial discrete birth jump:
   \[
   \operatorname{correction}(n) = \operatorname{discreteBirth}(n, 1) - \operatorname{discreteBirth}(n, 0).
   \]
4. **Unconditional Absolute Summability Across Prime Powers:**
   Because $\frac{\Lambda(n)}{3 n^{3/2}}$ is summable (since $\Lambda(n) \le \log n \ll n^{1/4}$ and $\sum n^{-5/4} < \infty$), the von Mangoldt weighted discrete birth jump sequence is **unconditionally absolutely summable**:
   \[
   \sum_{n=2}^\infty \left\| \Lambda(n) (\operatorname{discreteBirth}(n, 1) - \operatorname{discreteBirth}(n, 0)) \right\| < \infty.
   \]

---

## 2. Mathematical Proof

### 2.1. Derivative Monotonicity
The function $f(z) = \arcsin z - z$ has derivative $f'(z) = \frac{1}{\sqrt{1-z^2}} - 1 = \frac{z^2}{\sqrt{1-z^2}(1+\sqrt{1-z^2})}$.  
For $z \in [0, 1/\sqrt{2}]$, $\sqrt{1-z^2} \ge 1/\sqrt{2}$ and $1+\sqrt{1-z^2} \ge 1$, so:
\[
0 \le f'(z) \le z^2.
\]
Integrating $f'$ on $[0, z]$ immediately yields $0 \le f(z) \le z^3/3$.

### 2.2. Evaluation at Prime Scales
Substituting $z = 1/\sqrt{y}$ (which satisfies $z^2 = 1/y \le 1/2$ for all $y \ge 2$):
\[
0 \le \arcsin\left(\frac{1}{\sqrt{y}}\right) - \frac{1}{\sqrt{y}} \le \frac{(1/\sqrt{y})^3}{3} = \frac{1}{3 y^{3/2}}.
\]

### 2.3. Connection to Discrete Birth Step
From the explicit kernel $q(n, x) = \arcsin(\min(1, \sqrt{x/n}))$, we have $q(n, 0) = 0$ and $q(n, 1) = \arcsin(1/\sqrt{n})$.  
The flat linear projection evaluates to $1/\sqrt{n}$.  
Subtracting the two yields exactly $\arcsin(1/\sqrt{n}) - 1/\sqrt{n}$, proving that the initial discrete jump of the renewal kernel is strictly an arcsine geometric artifact whose rapid $n^{-3/2}$ decay prevents high-frequency divergence.

---

## 3. Machine Verification and Axiom Audit

Machine-verified in Lean 4.24.0:
```lean
theorem arcsin_sub_bounds {z : ℝ} (hz : 0 ≤ z) (hz2 : z ^ 2 ≤ 1 / 2) :
    0 ≤ Real.arcsin z - z ∧ Real.arcsin z - z ≤ z ^ 3 / 3

theorem correction_bounds {y : ℝ} (hy : 2 ≤ y) :
    0 ≤ correction y ∧ correction y ≤ 1 / (3 * y * Real.sqrt y)

theorem correction_eq_discrete_difference {n : ℕ} (hn : 2 ≤ n) :
    correction n = discreteBirth n 1 - discreteBirth n 0

theorem weighted_discrete_difference_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) *
      (discreteBirth (n + 2) 1 - discreteBirth (n + 2) 0)‖)
```
Axiom audit confirms dependence strictly on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Arcsine distributions and trigonometric kernel representations in renewal theory are standard, but the explicit non-asymptotic derivation bounding the prime birth discrepancy by $1/(3n^{3/2})$ and proving machine-verified summability of the weighted discrete difference sequence is novel.
- **Advancement:** Guarantees that the initial birth steps of the prime renewal process converge in $l^1$ norm when weighted by $\Lambda(n)$.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Results in Mathematics*.
