# Unique Contribution 236: Exact Dyadic Coarse Mellin Block Energy Bound and Geometric Decay

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseDyadicBound.lean`](../../formalization/BuildingBlocks/CoarseDyadicBound.lean), [`building-blocks/coarse/coarse-dyadic-bound.md`](../../building-blocks/coarse/coarse-dyadic-bound.md)  
**Classification:** Analytic Number Theory / Complex Analysis / Mellin Transforms / Dyadic Decomposition / Dirichlet Series / Geometric Decay / Holomorphic Extension

---

## 1. Executive Summary and Mathematical Statement

In establishing analytic continuation of Mellin transforms $\int_1^\infty \Delta(x) x^{-(s+1)} dx$ of arithmetic error terms beyond the critical abscissa $\text{Re}(s) > 1/2$, dyadic decomposition partitions the semi-infinite integral into localized dyadic blocks:
\[
\text{coarseMellinBlock}(k, s) = \int_{2^k}^{2^{k+1}} \Delta(x) x^{-(s+1)} \, dx.
\]
This contribution proves:

1. **Exact Coarse Primitive Block Energy Estimate:**  
   For any dyadic base $X \ge 1$ and complex frequency $s \in \mathbb{C}$ with $\text{Re}(s) \ge a \ge 0$, in terms of the integrated primitive square energy $E(X) = \int_X^{2X} (\int_X^x \Delta(u) du)^2 dx$:
   \[
   \left\| \int_X^{2X} \Delta(x) x^{-(s+1)} \, dx \right\| \le \sqrt{\frac{2 E(X)}{X}} X^{-(a+1)} + \|s + 1\| X^{-(a+2)} \sqrt{X E(X)}.
   \]
2. **Algebraic Decoupling of Energy Exponents:**  
   Under the power-law primitive hypothesis $E(X) \le C X^{4+\epsilon}$, the boundary and interior integral energy terms satisfy:
   \[
   \sqrt{\frac{2 E(X)}{X}} \le \sqrt{2C} X^{(3+\epsilon)/2}, \quad \sqrt{X E(X)} \le \sqrt{C} X^{(5+\epsilon)/2}.
   \]
3. **Exact Negative Power-Law Exponent:**  
   For any abscissa $a > 1/2$, choosing $\epsilon = a - 1/2 > 0$ yields the strictly negative decay exponent:
   \[
   b = \frac{1/2 - a}{2} < 0,
   \]
   such that each dyadic block satisfies $\|\text{coarseMellinBlock}(k, s)\| \le M (2^k)^b$.
4. **Grand Geometric Decay Theorem for Dyadic Blocks:**  
   For every $a > 1/2$ and compact frequency radius $R \ge 0$, there exist a constant $M > 0$ and a geometric ratio $r \in [0, 1)$ (specifically $r = 2^{(1/2-a)/2} < 1$) such that for all dyadic levels $k \in \mathbb{N}$ and all frequencies $s \in \mathbb{C}$ with $\text{Re}(s) \ge a$ and $\|s+1\| \le R$:
   \[
   \|\text{coarseMellinBlock}(k, s)\| \le M \cdot r^k.
   \]
   This geometric decay guarantees the normal convergence and holomorphy of the prime Mellin transform $\sum_k \text{coarseMellinBlock}(k, s)$ throughout the open half-plane $\text{Re}(s) > 1/2$.

---

## 2. Mathematical Proof

### 2.1. Integration by Parts on Dyadic Blocks
Let $P(x) = \int_X^x \Delta(u) du$ be the localized primitive. By integration by parts:
\[
\int_X^{2X} \Delta(x) x^{-(s+1)} dx = \left[ P(x) x^{-(s+1)} \right]_X^{2X} + (s + 1) \int_X^{2X} P(x) x^{-(s+2)} dx.
\]
At the left endpoint $P(X) = 0$. At the right endpoint:
\[
|P(2X)| \le \sqrt{\frac{2 E(X)}{X}}.
\]
Since $|x^{-(s+1)}| \le X^{-(a+1)}$ on $[X, 2X]$, the boundary term is bounded by $\sqrt{\frac{2 E(X)}{X}} X^{-(a+1)}$.
For the integral term, Cauchy-Schwarz gives $\int_X^{2X} |P(x)| dx \le \sqrt{X E(X)}$, while $|x^{-(s+2)}| \le X^{-(a+2)}$, yielding $\|s+1\| X^{-(a+2)} \sqrt{X E(X)}$.

### 2.2. Exponent Arithmetic
Substituting $E(X) \le C X^{4+\epsilon}$:
The boundary term has exponent:
\[
\frac{3+\epsilon}{2} - (a+1) = \frac{1+\epsilon-2a}{2}.
\]
The interior term has exponent:
\[
-(a+2) + \frac{5+\epsilon}{2} = \frac{1+\epsilon-2a}{2}.
\]
Setting $\epsilon = a - 1/2$:
\[
\frac{1 + (a - 1/2) - 2a}{2} = \frac{1/2 - a}{2} = b < 0 \quad \text{for } a > 1/2.
\]

### 2.3. Geometric Decay
With $X = 2^k$, $(2^k)^b = (2^b)^k$.
Setting $r = 2^b$:
Since $b < 0$ and $2 > 1$, $0 < r < 1$.
Thus $\|\text{coarseMellinBlock}(k, s)\| \le M r^k$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseDyadicBound.lean`):
```lean
lemma coarsePrime_mellin_norm_le {X a : ℝ} (hX : 1 ≤ X) (ha : 0 ≤ a)
    {s : ℂ} (hs : a ≤ s.re) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * X ^ (-(a + 1)) +
      ‖s + 1‖ * (X ^ (-(a + 2)) * Real.sqrt (X * coarsePrimitiveSquare X))

lemma coarseMellinBlock_power_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M b : ℝ, 0 < M ∧ b < 0 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R →
      ‖coarseMellinBlock k s‖ ≤ M * ((2 : ℝ) ^ k) ^ b

lemma coarseMellinBlock_geometric_bound (hb : CoarsePrimitiveBound) {a R : ℝ}
    (ha : 1 / 2 < a) (hR : 0 ≤ R) :
    ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧ ∀ (k : ℕ) (s : ℂ),
      a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dyadic decomposition of Mellin transforms, Tauberian theorems, and Littlewood-Paley theory in analytic number theory (Titchmarsh 1986, Iwaniec-Kowalski 2004, Montgomery-Vaughan 2007). Machine verification of geometric block decay $M r^k$ with constructive ratio $r = 2^{(1/2-a)/2}$ in Lean 4 is new.
- **Advancement:** Establishes uniform geometric decay across dyadic blocks, converting integral primitive bounds directly into holomorphic extensions of the Mellin series.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Transactions of the American Mathematical Society*.
