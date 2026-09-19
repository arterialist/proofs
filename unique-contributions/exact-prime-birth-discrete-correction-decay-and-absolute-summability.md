# Unique Contribution 235: Exact Prime Birth Discrete Correction Decay and Absolute Summability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeBirthSummability.lean`](../../formalization/BuildingBlocks/ChargeBirthSummability.lean), [`building-blocks/charge/charge-birth-summability.md`](../../building-blocks/charge/charge-birth-summability.md)  
**Classification:** Analytic Number Theory / Operator Defect Theory / Discrete Corrections / Prime Power Summability / Arcsine Decay / Von Mangoldt Weights

---

## 1. Executive Summary and Mathematical Statement

In the discrete-to-continuous renewal theory of prime counting functions, discrete correction factors arise from the difference between successive discrete birth charges:
\[
\text{correction}(y) = \arcsin\left(\frac{1}{\sqrt{y}}\right) - \frac{1}{\sqrt{y}}.
\]
This contribution proves:

1. **Non-Asymptotic Cubic Decay Rate:**  
   For all real scales $y \ge 2$, the discrete correction satisfies the strict, non-asymptotic decay inequality:
   \[
   0 \le \text{correction}(y) \le \frac{1}{3 y^{3/2}}.
   \]
2. **Discrete Difference Identification:**  
   For every integer $n \ge 2$, the continuous correction evaluates precisely to the difference between the first and zeroth physical discrete prime births:
   \[
   \text{correction}(n) = \text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0).
   \]
3. **Grand Absolute Summability of Von Mangoldt Weighted Corrections:**  
   The prime power weighted correction series is absolutely convergent:
   \[
   \sum_{n=2}^\infty \Lambda(n) |\text{correction}(n)| \le \frac{1}{3} \sum_{n=2}^\infty \frac{\Lambda(n)}{n^{3/2}} < \infty.
   \]
4. **Grand Absolute Summability of Successive Discrete Birth Differences:**  
   The series of successive physical discrete birth differences weighted by the prime spectrum converges unconditionally:
   \[
   \sum_{n=2}^\infty \Lambda(n) \|\text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0)\| < \infty.
   \]

---

## 2. Mathematical Proof

### 2.1. Cubic Decay via Arcsine Sandwich
Setting $z = 1/\sqrt{y}$:
Since $y \ge 2$, $z > 0$ and $z^2 = 1/y \le 1/2$.
Applying the global cubic arcsine sandwich inequality (Contribution 234, `ChargeArcsinBound.arcsin_sub_bounds`):
\[
0 \le \arcsin(z) - z \le \frac{z^3}{3}.
\]
Substituting $z = 1/\sqrt{y}$:
\[
\frac{z^3}{3} = \frac{(1/\sqrt{y})^3}{3} = \frac{1}{3 y \sqrt{y}} = \frac{1}{3 y^{3/2}}.
\]
Thus $0 \le \text{correction}(y) \le \frac{1}{3 y^{3/2}}$ holds unconditionally for all $y \ge 2$.

### 2.2. Discrete Birth Identity
From `discreteBirth_eq_prebirth`, for $n \ge 2$:
\[
\text{discreteBirth}(n, 1) = q(1, n) + \arcsin(1/\sqrt{n}) = 0 + \arcsin(1/\sqrt{n}) = \arcsin(1/\sqrt{n}),
\]
\[
\text{discreteBirth}(n, 0) = q(0, n) + 0 = 1/\sqrt{n}.
\]
Subtracting the two terms:
\[
\text{discreteBirth}(n, 1) - \text{discreteBirth}(n, 0) = \arcsin(1/\sqrt{n}) - \frac{1}{\sqrt{n}} = \text{correction}(n).
\]

### 2.3. Von Mangoldt Summability
Since $\Lambda(n) \ge 0$ and $0 \le \text{correction}(n) \le \frac{1}{3 n^{3/2}}$:
\[
\sum_{n=2}^\infty \Lambda(n) |\text{correction}(n)| \le \frac{1}{3} \sum_{n=2}^\infty \frac{\Lambda(n)}{n^{3/2}}.
\]
Because $\sum \frac{\Lambda(n)}{n^s} = -\frac{\zeta'}{\zeta}(s)$ converges absolutely for all $\text{Re}(s) > 1$ (and specifically at $s = 3/2 > 1$), the comparison test proves unconditional convergence.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeBirthSummability` in `formalization/BuildingBlocks/ChargeBirthSummability.lean`):
```lean
theorem correction_bounds {y : ℝ} (hy : 2 ≤ y) :
    0 ≤ correction y ∧ correction y ≤ 1 / (3 * y * Real.sqrt y)

theorem correction_eq_discrete_difference {n : ℕ} (hn : 2 ≤ n) :
    correction n = discreteBirth n 1 - discreteBirth n 0

theorem weighted_correction_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) * correction ((n + 2 : ℕ) : ℝ)‖)

theorem weighted_discrete_difference_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) *
      (discreteBirth (n + 2) 1 - discreteBirth (n + 2) 0)‖)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet series of the von Mangoldt function $-\zeta'(s)/\zeta(s)$ (Titchmarsh 1986, Montgomery-Vaughan 2007) and discrete boundary corrections in renewal processes (Feller 1971). The exact machine-verified $O(n^{-3/2})$ decay and summability of arithmetic discrete birth differences in Lean 4 is new.
- **Advancement:** Establishes non-asymptotic bounds showing that the arithmetic correction factors converge at rate $n^{-3/2}$, guaranteeing absolute integrability and summability across the prime spectrum.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Acta Arithmetica*.
