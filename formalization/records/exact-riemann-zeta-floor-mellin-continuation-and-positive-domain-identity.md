# Contribution 304: Exact Riemann Zeta Floor-Mellin Continuation and Positive-Domain Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FloorMellin.lean`](../../formalization/BuildingBlocks/FloorMellin.lean), [`building-blocks/contour-inversion/floor-mellin.md`](../../building-blocks/contour-inversion/floor-mellin.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Mellin Transforms / Analytic Continuation / Floor Remainder / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The classical analytic continuation of the Riemann zeta function to the critical strip $0 < \text{Re}(s) < 1$ is traditionally established via the Euler–Maclaurin summation formula or the functional equation via the theta transform. An alternative direct integral representation uses the fractional-part (floor remainder) kernel $\{x\} = x - \lfloor x \rfloor$.

This contribution proves:

1. **Exact Floor-Mellin Integral Representation on the Critical Strip:**  
   For all $s \in \mathbb{C}$ with $\text{Re}(s) > 0$ and $s \ne 1$:
   $$
   \zeta(s) = \frac{s}{s - 1} - s \int_1^\infty (x - \lfloor x \rfloor) x^{-(s+1)} dx.
   $$
   This expresses the meromorphic continuation of $\zeta(s)$ across the critical strip directly in terms of the fractional-part Mellin transform without assuming the Riemann Hypothesis or the functional equation.
2. **Holomorphy of the Fractional-Part Mellin Transform:**  
   The transform:
   $$
   \text{floorMellin}(s) = \int_1^\infty \{x\} x^{-(s+1)} dx
   $$
   is analytic on the entire open right half-plane $\Omega = \{s \in \mathbb{C} : \text{Re}(s) > 0\}$.
3. **Punctured Positive Domain Analytic Identity Theorem:**  
   If $F : \mathbb{C} \to \mathbb{C}$ is analytic on the punctured right half-plane $\{s : \text{Re}(s) > 0, s \ne 1\}$ and vanishes on the half-plane $\text{Re}(s) > 1$, then $F(s) = 0$ identically everywhere on $\{s : \text{Re}(s) > 0, s \ne 1\}$.
4. **Generalized Mellin Transform Convergence:**  
   The floor remainder $\rho(x) = \mathbf{1}_{x \ge 1} \{x\}$ satisfies $\rho(x) = O(1)$ as $x \to \infty$ and $\rho(x) = 0$ for $x < 1$, ensuring uniform convergence of its Mellin transform $\mathcal{M}[\rho](-s)$ for all $\text{Re}(s) > 0$.
5. **Exact Integral Relation for $\text{Re}(s) > 1$:**  
   For $\text{Re}(s) > 1$, Dirichlet series summation by parts rigorously yields:
   $$
   \zeta(s) = s \int_1^\infty \lfloor x \rfloor x^{-(s+1)} dx.
   $$

---

## 2. Mathematical Proof

### 2.1. Summation by Parts and Floor Integral
For $\text{Re}(s) > 1$, $\zeta(s) = \sum_{n=1}^\infty n^{-s}$.
Writing $n^{-s} = s \int_n^\infty x^{-(s+1)} dx$, interchanging sum and integral yields:
$$
\zeta(s) = s \int_1^\infty \left( \sum_{n \le x} 1 \right) x^{-(s+1)} dx = s \int_1^\infty \lfloor x \rfloor x^{-(s+1)} dx.
$$

### 2.2. Linear and Fractional Decomposition
Decompose $\lfloor x \rfloor = x - \{x\}$ for $x \ge 1$.
For $\text{Re}(s) > 1$:
$$
\int_1^\infty x \cdot x^{-(s+1)} dx = \int_1^\infty x^{-s} dx = \left[ \frac{x^{-(s-1)}}{-(s-1)} \right]_1^\infty = \frac{1}{s - 1}.
$$
Multiplying by $s$:
$$
s \int_1^\infty x^{-(s)} dx = \frac{s}{s - 1}.
$$
Subtracting the fractional-part integral gives:
$$
\zeta(s) = \frac{s}{s - 1} - s \int_1^\infty \{x\} x^{-(s+1)} dx, \qquad \text{Re}(s) > 1.
$$

### 2.3. Analytic Continuation via Domain Identity
Because $0 \le \{x\} < 1$, the integral $\int_1^\infty \{x\} x^{-(s+1)} dx$ is absolutely converged for $\text{Re}(s) > 0$:
$$
\int_1^\infty |\{x\}| x^{-(\text{Re}(s)+1)} dx \le \int_1^\infty x^{-(\text{Re}(s)+1)} dx = \frac{1}{\text{Re}(s)} < \infty.
$$
By standard theorems on parametric integrals, $s \mapsto \text{floorMellin}(s)$ is analytic on $\text{Re}(s) > 0$.
Define $F(s) = \zeta(s) - \frac{s}{s - 1} + s \cdot \text{floorMellin}(s)$.
$F(s)$ is analytic on $\{s : \text{Re}(s) > 0, s \ne 1\}$.
By Step 2.2, $F(s) = 0$ for all $\text{Re}(s) > 1$.
By the identity theorem for connected domains (`identity_on_positiveDomain`), $F(s) = 0$ for all $\text{Re}(s) > 0, s \ne 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/FloorMellin.lean`):
```lean
theorem floorMellin_analytic : AnalyticOnNhd ℂ floorMellin {s | 0 < s.re}

theorem floorRemainder_mellinConvergent {s : ℂ} (hs : 0 < s.re) :
    MellinConvergent floorRemainder (-s)

theorem identity_on_positiveDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F {s | 0 < s.re ∧ s ≠ 1})
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0) :
    ∀ s : ℂ, 0 < s.re → s ≠ 1 → F s = 0

theorem zeta_eq_floorMellin {s : ℂ} (hs : 0 < s.re) (hne : s ≠ 1) :
    riemannZeta s = s / (s - 1) - s * floorMellin s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Riemann (1859); Titchmarsh (1986) *The Theory of the Riemann Zeta-Function*, Section 2.1 (Theorem 2.1); Edwards (1974) *Riemann's Zeta Function*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes a completely self-contained machine-checked proof of the classical representation $\zeta(s) = \frac{s}{s-1} - s \int_1^\infty \{x\}x^{-(s+1)}dx$ valid throughout the critical strip without invoking functional equations.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Number Theory*.
