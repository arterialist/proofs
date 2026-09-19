# Unique Contribution 287: Exact Logarithmic Overlap Loss and Algebraic Spacing Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogarithmicOverlap.lean`](../../formalization/BuildingBlocks/LogarithmicOverlap.lean), [`building-blocks/logarithmic-overlap/bounds.md`](../../building-blocks/logarithmic-overlap/bounds.md)  
**Classification:** Analytic Number Theory / Real Analysis / Multiplicative Spacing / Logarithmic Inequalities / GCD–LCM Overlap / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the fine distribution analysis of arithmetic progressions, logarithmic divisor sums, and GCD/LCM spacing configurations, products of shifted logarithmic quantities arise when bounding joint density correlations. The essential loss occurs because the product of perturbed logarithmic factors $(L + \log(1-u))(L + \log(1+u+v))$ is strictly deficient compared to the diagonal baseline $L(L + \log(1+v))$.

This contribution proves:

1. **Exact Overlap Identity:**  
   For any $L > 0$, $0 \le u < 1$, and $v \ge 0$:
   \[
   (L + \log(1 - u))(L + \log(1 + u + v)) - L(L + \log(1 + v)) = L \log(1 - \Phi(u, v)) + \log(1 - u) \log(1 + u + v),
   \]
   where $\Phi(u, v) = \frac{u(u + v)}{1 + v}$ is the canonical relative overlap fraction.
2. **Definitive Overlap Loss Bound:**  
   Because $\log(1 - u) \le 0$ and $\log(1 + u + v) \ge 0$, the cross-product of logarithms is negative semi-definite, and $\log(1 - \Phi) \le -\Phi$, yielding the non-asymptotic inequality:
   \[
   (L + \log(1 - u))(L + \log(1 + u + v)) - L(L + \log(1 + v)) \le -L \frac{u(u + v)}{1 + v}.
   \]
3. **Uniform Error Compensation Bound:**  
   If a perturbed upper product with uniform error parameter $\eta \ge 0$ majorizes the baseline:
   \[
   L(L + \log(1 + v)) \le (L + \log(1 - u) + \eta)(L + \log(1 + u + v) + \eta),
   \]
   then $\eta$ must unconditionally pay for the entire overlap loss:
   \[
   L \frac{u(u + v)}{1 + v} \le (2L + \log(1 + v)) \eta + \eta^2.
   \]
4. **Normalized Spacing Fraction Bound:**  
   Dividing by $L$ gives the scale-invariant spacing criterion:
   \[
   \frac{u(u + v)}{1 + v} \le \left( 2 + \frac{\log(1 + v)}{L} \right) \eta + \frac{\eta^2}{L}.
   \]
5. **Reciprocal Correction Identity:**  
   For reciprocal perturbations $(A + \kappa/A)(B + \kappa/B)$, the exact algebraic identity:
   \[
   (A + \kappa/A)(B + \kappa/B) = AB + \kappa(A/B + B/A) + \frac{\kappa^2}{AB}
   \]
   enables tight quantification of hyperbolic curvature compensation.

---

## 2. Mathematical Proof

### 2.1. Decomposition of the Rational Argument
Notice that:
\[
1 - \Phi(u, v) = 1 - \frac{u(u+v)}{1+v} = \frac{1 + v - u^2 - uv}{1+v} = \frac{(1 - u)(1 + u + v)}{1 + v}.
\]
Since $0 \le u < 1$ and $v \ge 0$, all three factors $(1-u)$, $(1+u+v)$, and $(1+v)$ are strictly positive.
Taking the logarithm:
\[
\log(1 - \Phi(u, v)) = \log(1 - u) + \log(1 + u + v) - \log(1 + v).
\]

### 2.2. Product Expansion and Loss
Expanding the product difference:
\[
(L + \log(1 - u))(L + \log(1 + u + v)) - L(L + \log(1 + v))
\]
\[
= L^2 + L(\log(1 - u) + \log(1 + u + v)) + \log(1 - u)\log(1 + u + v) - L^2 - L\log(1 + v)
\]
\[
= L(\log(1 - u) + \log(1 + u + v) - \log(1 + v)) + \log(1 - u)\log(1 + u + v)
\]
\[
= L \log(1 - \Phi(u, v)) + \log(1 - u)\log(1 + u + v).
\]
Since $u \in [0, 1)$, $\log(1-u) \le 0$. Since $u, v \ge 0$, $\log(1+u+v) \ge 0$.
Thus $\log(1-u)\log(1+u+v) \le 0$.
Furthermore, using $\log(1 - x) \le -x$ for $x < 1$:
\[
L \log(1 - \Phi(u, v)) \le -L \Phi(u, v) = -L \frac{u(u+v)}{1+v}.
\]
This proves the fundamental loss inequality.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.LogarithmicOverlap` in `formalization/BuildingBlocks/LogarithmicOverlap.lean`):
```lean
theorem overlap_identity (L : ℝ) {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) =
      L * Real.log (1 - overlapFraction u v) +
        Real.log (1 - u) * Real.log (1 + u + v)

theorem overlap_loss {L u v : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) ≤
      -L * u * (u + v) / (1 + v)

theorem uniform_error_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    L * u * (u + v) / (1 + v) ≤
      (2 * L + Real.log (1 + v)) * η + η ^ 2

theorem uniform_error_fraction_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    u * (u + v) / (1 + v) ≤
      (2 + Real.log (1 + v) / L) * η + η ^ 2 / L
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Spacing problems in multiplicative number theory (Erdős, Hall & Tenenbaum 1988), GCD/LCM bounds (de la Bretèche & Tenenbaum 2013). The non-asymptotic verification of logarithmic product overlap loss and normalized uniform error constraints in Lean 4 is new.
- **Advancement:** Establishes a rigorous non-asymptotic lower bound on the error cost incurred by perturbed logarithmic products, preventing false cancellations in GCD spacing models.
- **Target Venues:** *Acta Arithmetica* or *Journal of Mathematical Analysis and Applications*.
