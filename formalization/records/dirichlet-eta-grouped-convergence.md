# Grouped Dirichlet Eta Convergence and Positivity

## Summary
This module provides a machine-verified proof in Lean 4 of the absolute convergence and strict positivity of the grouped Dirichlet eta function on the positive real axis:
1. Formalizes the grouped alternating pairs:
   $$u_n(\sigma) = (2n+1)^{-\sigma} - (2n+2)^{-\sigma} \quad (n \in \mathbb{N}).$$
2. Proves pointwise strict positivity `etaPair_pos`:
   $$u_n(\sigma) > 0 \quad \text{for all } n \in \mathbb{N}, \; \sigma > 0.$$
3. Establishes the exact leading value `etaPair_zero`:
   $$u_0(\sigma) = 1 - 2^{-\sigma} > 0.$$
4. Applies Lagrange's Mean Value Theorem (`exists_hasDerivAt_eq_slope`) to deduce the differential decay bound `etaPair_bound`:
   $$u_n(\sigma) \le \sigma (2n+1)^{-\sigma - 1} \le \sigma (n+1)^{-(\sigma + 1)}.$$
5. Proves absolute summability `summable_etaPair` of $\sum_{n=0}^\infty u_n(\sigma)$ for all $\sigma > 0$ via comparison with Mathlib's shifted $p$-series (`Real.summable_one_div_nat_add_rpow`).
6. Defines the grouped Dirichlet eta sum `groupedDirichletEta σ` and proves its strict positivity `groupedDirichletEta_pos`:
   $$\operatorname{groupedDirichletEta}(\sigma) \ge 1 - 2^{-\sigma} > 0 \quad \text{for all } \sigma > 0.$$
7. Connects the grouped sum directly to `DirichletEtaIdentity` and deduces real part negativity `riemannZeta_re_neg_of_rel` and non-vanishing `riemannZeta_ne_zero_of_rel` on $(0, 1)$.

## Background and Mathematical Significance
The non-vanishing of the Riemann zeta function on the critical line segment $(1/2, 1)$ is an essential component of the Riemann Hypothesis. Classically, this is shown by relating $\zeta(s)$ to the alternating Dirichlet eta function:
$$\eta(s) = \sum_{n=1}^\infty \frac{(-1)^{n-1}}{n^s} = (1 - 2^{1-s}) \zeta(s).$$
For real $\sigma \in (0, 1)$, the prefactor $1 - 2^{1-\sigma}$ is strictly negative. Grouping the alternating series into positive pairs $u_n(\sigma) = (2n+1)^{-\sigma} - (2n+2)^{-\sigma} > 0$ proves immediately that $\eta(\sigma) > 0$, forcing $\zeta(\sigma) < 0$.

However, Mathlib had no formalized definition or theory of the Dirichlet eta function, its grouped pairs, or their convergence on $\sigma > 0$. This module develops this theory entirely from first principles in Lean 4, providing the explicit positive certificate `groupedDirichletEta σ > 0` and bounding each pair via the derivative of $x \mapsto x^{-\sigma}$.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/DirichletEtaGroupedConvergence.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
