# Riemann Zeta Real Axis Pole Cancellation and Zero-Freeness

## Summary
This module formalizes the real pole cancellation mechanism of the completed Riemann zeta function $\Lambda(s)$ on the interval $(0, 1)$ in Lean 4:
1. Proves the global quadratic upper bound:
   $$\forall \sigma \in \mathbb{R}, \quad \sigma(1 - \sigma) \le \frac{1}{4}$$
   (`real_quad_le_one_fourth`), with strict inequality $\sigma(1 - \sigma) < 1/4$ for $\sigma \ne 1/2$ (`real_quad_lt_one_fourth_of_ne_half`).
2. Proves the universal pole lower bound on the unit interval:
   $$\forall \sigma \in (0, 1), \quad 4 \le \frac{1}{\sigma} + \frac{1}{1 - \sigma}$$
   (`real_pole_bound`), with strict inequality $4 < 1/\sigma + 1/(1-\sigma)$ for $\sigma \ne 1/2$ (`real_pole_bound_strict`).
3. Formulates the real decomposition of `completedRiemannZeta`:
   $$\Lambda(\sigma) = \Lambda_0(\sigma) - \left(\frac{1}{\sigma} + \frac{1}{1 - \sigma}\right)$$
   (`completedRiemannZeta_ofReal_eq`), and its real part projection:
   $$\operatorname{Re}(\Lambda(\sigma)) = \operatorname{Re}(\Lambda_0(\sigma)) - \left(\frac{1}{\sigma} + \frac{1}{1 - \sigma}\right)$$
   (`completedRiemannZeta_ofReal_re`).
4. Establishes the negative energy dominance principle: whenever $\operatorname{Re}(\Lambda_0(\sigma)) < 4$ on $(0, 1)$, the singular pole subtraction forces:
   $$\operatorname{Re}(\Lambda(\sigma)) < 0 \implies \Lambda(\sigma) \ne 0$$
   (`completedRiemannZeta_ofReal_re_neg_of_bound`, `completedRiemannZeta_ofReal_ne_zero_of_bound`).
5. Descends the non-vanishing to the uncompleted Riemann zeta function:
   $$\zeta(\sigma : \mathbb{C}) \ne 0 \quad (\sigma \in (0, 1))$$
   (`riemannZeta_ofReal_ne_zero_of_completed_bound`).
6. Deduces the abstract real-axis zero-freeness property `RealAxisZeroFree` on $(1/2, 1)$ (`realAxisZeroFree_of_completed_bound`), and positive real axis non-vanishing on $(1/2, \infty) \setminus \{1\}$ (`real_axis_zeta_ne_zero_of_completed_bound`).
7. Completes end-to-end deduction bridges deriving Mathlib's `RiemannHypothesis` from the three universal spectral systems under the bounded entire part condition:
   - `RiemannHypothesis_of_weil_and_completed_bound`
   - `RiemannHypothesis_of_refutation_and_completed_bound`
   - `RiemannHypothesis_of_fredholm_and_completed_bound`.

## Background and Mathematical Significance
The completed Riemann zeta function $\Lambda(s)$ satisfies the decomposition $\Lambda(s) = \Lambda_0(s) - 1/s - 1/(1-s)$, where $\Lambda_0(s)$ is an entire function given by the Mellin transform of the modified Jacobi theta kernel. On the critical real segment $\sigma \in (0, 1)$, the singular term $1/\sigma + 1/(1-\sigma) = \frac{1}{\sigma(1-\sigma)}$ attains its minimum value of $4$ at $\sigma = 1/2$ and diverges to $+\infty$ at both endpoints $\sigma \to 0^+$ and $\sigma \to 1^-$.

Because the theta tail integral defining $\Lambda_0(\sigma)$ is numerically very small ($\Lambda_0(1/2) \approx 0.023 \ll 4$), the singular pole term dominates across the entire open interval $(0, 1)$, ensuring $\operatorname{Re}(\Lambda(\sigma)) < 0$. This module provides the machine-checked framework linking this pole cancellation directly to zero refutation, Gamma non-vanishing descent, and the final deduction of the Riemann Hypothesis.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaPoleCancellation.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
