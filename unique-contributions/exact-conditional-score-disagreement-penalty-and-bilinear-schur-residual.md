# Unique Contribution 262: Exact Conditional Score Disagreement Penalty and Bilinear Schur Residual

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ConditionalScoreQuadratic.lean`](../../formalization/BuildingBlocks/ConditionalScoreQuadratic.lean), [`building-blocks/quadratic/conditional-score-quadratic.md`](../../building-blocks/quadratic/conditional-score-quadratic.md)  
**Classification:** Linear Algebra / Quadratic Forms / Schur Complements / Optimization Residuals / Score Coupling Penalties / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the joint variational estimation of mixed continuous and arithmetic energy forms, each component has an unconstrained optimal score $s_c^* = b_c / d_c$ and $s_p^* = b_p / d_p$ with minimal residuals $e_c - b_c^2/d_c$ and $e_p - b_p^2/d_p$. When a single global score parameter $s$ must be shared simultaneously by both continuous and prime sectors, a fundamental coupling penalty arises from the disagreement between the two individual optimal scores.

This contribution proves:

1. **Exact Scalar Score Disagreement Penalty:**  
   For any parameters $e_c, e_p, b_c, b_p \in \mathbb{R}$ and non-zero curvatures $d_c, d_p, d_c + d_p \ne 0$:
   \[
   (e_c + e_p) - \frac{(b_c + b_p)^2}{d_c + d_p} = \left(e_c - \frac{b_c^2}{d_c}\right) + \left(e_p - \frac{b_p^2}{d_p}\right) + \frac{d_c d_p}{d_c + d_p} \left( \frac{b_c}{d_c} - \frac{b_p}{d_p} \right)^2.
   \]
2. **Monotonicity of Joint Score Energy:**  
   Whenever the individual curvatures are strictly positive ($d_c > 0, d_p > 0$):
   \[
   \left(e_c - \frac{b_c^2}{d_c}\right) + \left(e_p - \frac{b_p^2}{d_p}\right) \le (e_c + e_p) - \frac{(b_c + b_p)^2}{d_c + d_p}.
   \]
   The joint constrained minimum is strictly larger than the sum of separate unconstrained minima unless the optimal scores match exactly: $b_c / d_c = b_p / d_p$.
3. **Bilinear Schur Residual Form:**  
   For any symmetric bilinear form $B$ on a real vector space $V$ and non-null vector $\phi \in V$, the rank-one Schur complement:
   \[
   \text{scoreResidual}(B, \phi)(x, y) = B(x, y) - \frac{B(x, \phi) B(\phi, y)}{B(\phi, \phi)}
   \]
   is positive semidefinite whenever $B$ is positive semidefinite, and identically annihilates the test vector: $\text{scoreResidual}(B, \phi)(\phi, v) = 0$ for all $v \in V$.
4. **Exact Bilinear Joint Form Penalty Identity:**  
   For any two symmetric bilinear forms $B_c, B_p$ with $B_c(\phi, \phi) \ne 0, B_p(\phi, \phi) \ne 0$ and $B_c(\phi, \phi) + B_p(\phi, \phi) \ne 0$:
   \[
   \text{scoreResidual}(B_c + B_p, \phi)(v, v) = \text{scoreResidual}(B_c, \phi)(v, v) + \text{scoreResidual}(B_p, \phi)(v, v) + \frac{B_c(\phi, \phi) B_p(\phi, \phi)}{B_c(\phi, \phi) + B_p(\phi, \phi)} \left( \frac{B_c(v, \phi)}{B_c(\phi, \phi)} - \frac{B_p(v, \phi)}{B_p(\phi, \phi)} \right)^2.
   \]
5. **Degenerate Pairing Annihilation:**  
   If $B$ is positive semidefinite and $B(\phi, \phi) = 0$, then $B(v, \phi) = 0$ for all $v \in V$.

---

## 2. Mathematical Proof

### 2.1. Scalar Disagreement Identity
Consider the difference between the joint minimum and separate minima:
\[
\Delta = \left[ (e_c + e_p) - \frac{(b_c + b_p)^2}{d_c + d_p} \right] - \left[ \left(e_c - \frac{b_c^2}{d_c}\right) + \left(e_p - \frac{b_p^2}{d_p}\right) \right] = \frac{b_c^2}{d_c} + \frac{b_p^2}{d_p} - \frac{(b_c + b_p)^2}{d_c + d_p}.
\]
Putting over the common denominator $d_c d_p (d_c + d_p)$:
\[
\frac{b_c^2 d_p (d_c + d_p) + b_p^2 d_c (d_c + d_p) - (b_c + b_p)^2 d_c d_p}{d_c d_p (d_c + d_p)}.
\]
Expanding the numerator:
\[
b_c^2 d_c d_p + b_c^2 d_p^2 + b_p^2 d_c^2 + b_p^2 d_c d_p - (b_c^2 d_c d_p + 2 b_c b_p d_c d_p + b_p^2 d_c d_p) = b_c^2 d_p^2 - 2 b_c b_p d_c d_p + b_p^2 d_c^2 = (b_c d_p - b_p d_c)^2.
\]
Dividing by $d_c d_p (d_c + d_p)$:
\[
\frac{(b_c d_p - b_p d_c)^2}{d_c d_p (d_c + d_p)} = \frac{d_c d_p}{d_c + d_p} \left( \frac{b_c}{d_c} - \frac{b_p}{d_p} \right)^2.
\]

### 2.2. Bilinear Form Extension
For $v \in V$, the quadratic displacement along $\phi$ is $B(v - s\phi, v - s\phi) = B(v, v) - 2 s B(v, \phi) + s^2 B(\phi, \phi)$.
Setting $e = B(v, v)$, $b = B(v, \phi)$, $d = B(\phi, \phi)$, the minimal value is attained at $s^* = B(v, \phi) / B(\phi, \phi)$, giving the Schur value $B(v, v) - B(v, \phi)^2 / B(\phi, \phi) = \text{scoreResidual}(B, \phi)(v, v)$.
Applying the scalar identity to the sum of forms $B_c + B_p$ immediately yields `joint_form_penalty`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ConditionalScoreQuadratic` in `formalization/BuildingBlocks/ConditionalScoreQuadratic.lean`):
```lean
theorem separate_penalty (ec ep bc bp dc dp : ℝ)
    (hc : dc ≠ 0) (hp : dp ≠ 0) (hd : dc + dp ≠ 0) :
    ec + ep - (bc + bp) ^ 2 / (dc + dp) =
      (ec - bc ^ 2 / dc) + (ep - bp ^ 2 / dp) +
        dc * dp / (dc + dp) * (bc / dc - bp / dp) ^ 2

theorem separate_minimum_le_joint (ec ep bc bp dc dp : ℝ)
    (hc : 0 < dc) (hp : 0 < dp) :
    (ec - bc ^ 2 / dc) + (ep - bp ^ 2 / dp) ≤
      ec + ep - (bc + bp) ^ 2 / (dc + dp)

theorem scoreResidual_nonnegative (B : BilinForm ℝ V)
    (hs : ∀ x y, B x y = B y x) (hpos : ∀ x, 0 ≤ B x x)
    (φ : V) (hd : 0 < B φ φ) (v : V) : 0 ≤ scoreResidual B φ v v

theorem scoreResidual_annihilates (B : BilinForm ℝ V) (φ v : V)
    (hd : B φ φ ≠ 0) : scoreResidual B φ φ v = 0

theorem joint_form_penalty (Bc Bp : BilinForm ℝ V)
    (hsc : ∀ x y, Bc x y = Bc y x) (hsp : ∀ x y, Bp x y = Bp y x)
    (φ v : V) (hc : Bc φ φ ≠ 0) (hp : Bp φ φ ≠ 0)
    (hd : Bc φ φ + Bp φ φ ≠ 0) :
    scoreResidual (Bc + Bp) φ v v =
      scoreResidual Bc φ v v + scoreResidual Bp φ v v +
        Bc φ φ * Bp φ φ / (Bc φ φ + Bp φ φ) *
          (Bc v φ / Bc φ φ - Bp v φ / Bp φ φ) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Schur complements, Gauss-Markov estimation, and parallel sum of positive operators (Anderson-Duffin 1969, Horn-Johnson 2012). A machine-verified algebraic proof of the exact score disagreement penalty and the additive Schur complement decomposition in Lean 4 is new.
- **Advancement:** Quantifies the exact energetic cost of forcing disparate sectors (e.g., continuous background vs arithmetic primes) into a single score parameter.
- **Target Venues:** *Linear Algebra and its Applications* or *SIAM Journal on Matrix Analysis and Applications*.
