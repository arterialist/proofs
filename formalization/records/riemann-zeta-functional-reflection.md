# Riemann Zeta Functional Equation Reflection Symmetry

## Summary
This module provides a machine-verified formalization in Lean 4 proving that the Riemann zeta function satisfies the Schwarz reflection symmetry across the real axis on the negative half-plane:
$$\zeta(\overline{w}) = \overline{\zeta(w)} \quad \text{for all } w \in \mathbb{C} \text{ with } \operatorname{Re}(w) < 0 \text{ away from non-positive integers}.$$

The result is deduced directly from the Riemann zeta functional equation (`riemannZeta_one_sub`):
$$\zeta(1 - s) = 2(2\pi)^{-s}\Gamma(s)\cos(\pi s / 2)\zeta(s)$$
and the half-plane Dirichlet series conjugation theorem on $\operatorname{Re}(s) > 1$ formalized in Module 274.

## Background and Significance
The proof composes Mathlib's functional equation with conjugation lemmas and the project theorem for the half-plane of absolute convergence. In analytic number theory, the fact that $\zeta(\bar{s}) = \overline{\zeta(s)}$ on $\operatorname{Re}(s) < 0$ is deduced by conjugating each factor on the right-hand side of the functional equation.

By formalizing the exact commutation of each constituent factor:
- $2 \in \mathbb{R}$
- $(2\pi)^{-s}$ with positive real base $2\pi > 0$
- Euler $\Gamma(s)$ via `Complex.Gamma_conj`
- Cosine $\cos(\pi s / 2)$ via `Complex.cos_conj`
- Riemann zeta $\zeta(s)$ via Dirichlet series conjugation on $\operatorname{Re}(s) > 1$

this module proves the reflection symmetry under the theorem's explicit side conditions: `w.re < 0`, `∀ n, 1 - w ≠ -n`, and `w ≠ 0`.

## Mathematical Formulation

1. **Positive Real Power Conjugation:**
   For $a \in \mathbb{R}$ with $a > 0$ and $s \in \mathbb{C}$:
   $$\operatorname{star}((a : \mathbb{C})^s) = (a : \mathbb{C})^{\operatorname{star}(s)}.$$

2. **Functional Equation Conjugation:**
   For $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$, $s \ne 1$, and $s \notin -\mathbb{N}$:
   $$\zeta(1 - \operatorname{star}(s)) = \operatorname{star}(\zeta(1 - s)).$$

3. **Left Half-Plane Reflection:**
   For $w \in \mathbb{C}$ with $\operatorname{Re}(w) < 0$, letting $s = 1 - w$:
   Since $\operatorname{Re}(s) = 1 - \operatorname{Re}(w) > 1$, applying the functional equation conjugation gives:
   $$\zeta(\operatorname{star}(w)) = \operatorname{star}(\zeta(w)).$$

4. **Zero Equivalence on $\operatorname{Re}(w) < 0$:**
   $$\zeta(w) = 0 \iff \zeta(\operatorname{star}(w)) = 0.$$

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaFunctionalReflection.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
