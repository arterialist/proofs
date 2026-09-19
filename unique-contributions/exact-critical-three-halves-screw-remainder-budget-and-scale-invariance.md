# Contribution 334: Exact Critical Three-Halves Screw Remainder Budget and Scale Invariance

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean`](../../formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean), [`building-blocks/goldbach/screw-remainder-threshold.md`](../../building-blocks/goldbach/screw-remainder-threshold.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Goldbach Problem / Dyadic Minor Arcs / Remainder Budgets / Scale Invariance / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dyadic screw consumption architecture for the Goldbach conjecture, weighted prime pair sums at scales $N$ and $N^2$ enter with signs and scaling factors $2\sqrt{x}$ and $-x/2$. The interaction of the two remainder errors determines whether the consumer can close the minor-arc gap.

This contribution proves:

1. **Exact Absolute Dyadic Remainder Budget:**  
   For any scale $x \ge 0$ and error bounds $|\text{err}| \le b$, $|\text{errSq}| \le b_{\text{sq}}$:
   $$
   \left| 2\sqrt{x} \, \text{err} - \frac{x}{2} \, \text{errSq} \right| \le 2\sqrt{x} b + \frac{x}{2} b_{\text{sq}}.
   $$
2. **Exact Critical Three-Halves Scale-Invariant Collapse:**  
   When the errors scale at the critical Fujii/Montgomery exponent $3/2$ (giving weighted errors $|\text{err}| \le \frac{5C}{\sqrt{x}}$ and $|\text{errSq}| \le \frac{5C}{x}$), the scale $x$ vanishes identically:
   $$
   2\sqrt{x}\left(\frac{5C}{\sqrt{x}}\right) + \frac{x}{2}\left(\frac{5C}{x}\right) = 10C + \frac{5}{2}C = \frac{25}{2}C.
   $$
   Thus, the total error budget is bounded by the universal, scale-independent constant $\frac{25}{2}C$.
3. **Exact Two-Sided Margin Transfer:**  
   - If $\text{raw} + \text{budget} \le 3 \cdot \text{origin}$, then $\text{raw} - \text{contribution} \le 3 \cdot \text{origin}$.
   - Conversely, $\text{raw} - \text{contribution} \le 3 \cdot \text{origin} \implies \text{raw} \le 3 \cdot \text{origin} + \text{budget}$.

---

## 2. Mathematical Proof

### 2.1. Triangle Inequality on Dyadic Combination
By the triangle inequality:
$|2\sqrt{x}\text{err} - (x/2)\text{errSq}| \le |2\sqrt{x}\text{err}| + |(x/2)\text{errSq}| = 2\sqrt{x}|\text{err}| + (x/2)|\text{errSq}| \le 2\sqrt{x}b + (x/2)b_{\text{sq}}$.

### 2.2. Critical Cancellation
Substituting $b = 5C/\sqrt{x}$ and $b_{\text{sq}} = 5C/x$:
The first term becomes $2\sqrt{x}(5C/\sqrt{x}) = 10C$.
The second term becomes $(x/2)(5C/x) = (5/2)C$.
Summing yields $10C + 2.5C = 12.5C = 25C/2$, independent of $x$.

### 2.3. Margin Propagation
Follows by elementary linear ordering on $\mathbb{R}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachScrewRemainderThresholdFinite` in `formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean`):
```lean
theorem dyadic_remainder_budget {x err errSq b bSq : ℝ}
    (hx : 0 ≤ x)
    (herr : |err| ≤ b) (herrSq : |errSq| ≤ bSq) :
    |dyadicRemainderContribution x err errSq| ≤
      2 * Real.sqrt x * b + x / 2 * bSq

theorem critical_three_halves_budget {x C err errSq : ℝ}
    (hx : 0 < x)
    (herr : |err| ≤ 5 * C / Real.sqrt x)
    (herrSq : |errSq| ≤ 5 * C / x) :
    |dyadicRemainderContribution x err errSq| ≤ 25 * C / 2

theorem robust_dyadic_of_margin {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hraw : raw + budget ≤ 3 * origin) :
    raw - contribution ≤ 3 * origin

theorem raw_dyadic_of_corrected {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hcorr : raw - contribution ≤ 3 * origin) :
    raw ≤ 3 * origin + budget
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Fujii (1991) *An additive problem of prime numbers*; Montgomery & Vaughan (1975) *The exceptional set in Goldbach's problem*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic scale invariance of the dyadic Goldbach screw error budget at the critical exponent $3/2$, fixing the absolute threshold constant at $25C/2$.
- **Target Venues:** *Ramanujan Journal* or *Integers*.
