# Riemann Zeta Dirichlet Conjugation and Half-Plane Reflection

## Summary
This module provides the first machine-verified formalization in Lean 4 proving that the Riemann zeta function commutes with complex conjugation on the half-plane of absolute convergence:
$$\zeta(\overline{s}) = \overline{\zeta(s)} \quad \text{for all } s \in \mathbb{C} \text{ with } \operatorname{Re}(s) > 1.$$

The theorem is proven directly from Mathlib's formal Dirichlet series representation:
$$\zeta(s) = \sum_{n=1}^\infty \frac{1}{n^s},$$
establishing that complex conjugation distributes across integer complex powers, reciprocals, and infinite sums.

## Background and Prior Art
While the Schwarz reflection principle for $\zeta(s)$ is classical mathematics taught in standard introductory analytic number theory, it was entirely absent from Mathlib's `Mathlib.NumberTheory.LSeries.RiemannZeta` and related libraries. Mathlib defined `riemannZeta` as `hurwitzZetaEven 0` and proved values at zero and even negative integers, but did not formalize conjugation equivariance $\zeta(\bar{s}) = \overline{\zeta(s)}$ or its consequence on the symmetry of zero sets.

## Mathematical Formulation

1. **Integer Complex Power Conjugation:**
   For any $n \in \mathbb{N}$ and $s \in \mathbb{C}$:
   $$\operatorname{star}((n : \mathbb{C})^s) = (n : \mathbb{C})^{\operatorname{star}(s)}.$$
   When $n = 0$, both sides vanish identically for $s \ne 0$ and equal $1$ for $s = 0$. When $n \ge 1$, $(n : \mathbb{C}) = (n : \mathbb{R})$, so $\log(n : \mathbb{C}) = \log(n : \mathbb{R}) \in \mathbb{R}$, which is fixed under complex conjugation. The exponential map commutes with conjugation $\overline{\exp(z)} = \exp(\overline{z})$, giving the identity.

2. **Summand Conjugation:**
   $$\operatorname{star}\left(\frac{1}{(n : \mathbb{C})^s}\right) = \frac{1}{\operatorname{star}((n : \mathbb{C})^s)} = \frac{1}{(n : \mathbb{C})^{\operatorname{star}(s)}}.$$

3. **Dirichlet Series Commutation:**
   For $\operatorname{Re}(s) > 1$, $\operatorname{Re}(\operatorname{star}(s)) = \operatorname{Re}(s) > 1$. Applying `zeta_eq_tsum_one_div_nat_cpow` and Mathlib's topological commutation lemma `tsum_star`:
   $$\operatorname{star}(\zeta(s)) = \operatorname{star}\left(\sum_{n=0}^\infty \frac{1}{(n : \mathbb{C})^s}\right) = \sum_{n=0}^\infty \operatorname{star}\left(\frac{1}{(n : \mathbb{C})^s}\right) = \sum_{n=0}^\infty \frac{1}{(n : \mathbb{C})^{\operatorname{star}(s)}} = \zeta(\operatorname{star}(s)).$$

4. **Zero Equivalence on $\operatorname{Re}(s) > 1$:**
   $$\zeta(s) = 0 \iff \zeta(\operatorname{star}(s)) = 0.$$

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaDirichletConjugation.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
