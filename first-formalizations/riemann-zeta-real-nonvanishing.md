# First Formalization: Real Axis Non-Vanishing of the Riemann Zeta Function

## Mathematical Context
On the critical strip $(0, 1)$, the Riemann zeta function is linked to the alternating Dirichlet eta series:
$$\eta(\sigma) = \sum_{n=1}^\infty \frac{(-1)^{n-1}}{n^\sigma} = (1 - 2^{1-\sigma}) \zeta(\sigma).$$

For every real $\sigma \in (0, 1)$:
1. The alternating series grouping $p_k(\sigma) = (2k-1)^{-\sigma} - (2k)^{-\sigma} > 0$ demonstrates that $\eta(\sigma) \ge p_1(\sigma) = 1 - 2^{-\sigma} > 0$.
2. The Dirichlet eta multiplier $1 - 2^{1-\sigma} < 0$ because $1 - \sigma > 0$ forces $2^{1-\sigma} > 1$.
3. As a result, $\zeta(\sigma) = \eta(\sigma) / (1 - 2^{1-\sigma}) < 0$.
4. Hence, $\zeta(\sigma) \ne 0$ for all real $\sigma \in (0, 1)$.

Together with Mathlib's verified `riemannZeta_ne_zero_of_one_le_re` (which certifies non-vanishing for $\operatorname{Re}(s) \ge 1$), this proves that $\zeta(s) \ne 0$ for all real $s > 1/2$ ($s \ne 1$).

While this argument is classical (Dirichlet 1837, Landau 1909), it was missing from Lean 4 / Mathlib.

## Formalization Structure in Lean 4
The formalization is verified in `formalization/BuildingBlocks/RiemannZetaRealNonvanishing.lean` (Module 271):

1. **Alternating Pair Positivity** (`alternating_pair_pos`):
   For any $k \ge 1$ and $\sigma > 0$:
   $$(2k-1)^{-\sigma} - (2k)^{-\sigma} > 0.$$
2. **First Alternating Term Positivity** (`first_alternating_term_pos`):
   $$1 - 2^{-\sigma} > 0 \quad \text{for all } \sigma > 0.$$
3. **Eta Multiplier Negativity** (`eta_multiplier_neg`):
   $$1 - 2^{1-\sigma} < 0 \quad \text{for all } \sigma < 1.$$
4. **Negative Real Part on Unit Interval** (`riemannZeta_re_neg_of_eta`):
   $$\operatorname{Re}(\zeta(\sigma)) < 0 \quad \text{for all } \sigma \in (0, 1).$$
5. **Real Zero Non-Existence** (`real_axis_zeta_ne_zero`):
   Combining the Dirichlet eta identity with Mathlib's `riemannZeta_ne_zero_of_one_le_re`, for all real $s > 1/2$ with $s \ne 1$:
   $$\zeta(s) \ne 0.$$

## Machine Verification
- **Module**: `formalization/BuildingBlocks/RiemannZetaRealNonvanishing.lean`
- **Lean Version**: 4.24.0 (Mathlib v4.24.0)
- **Sorries**: 0
- **Axioms**: `[propext, Classical.choice, Quot.sound]`
