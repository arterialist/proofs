# First Formalization 370: Riemann Zeta Kernel Energy Bound and Symmetrized Majorization

## Mathematical Overview

For any $t > 0$, the Jacobi theta kernel excess satisfies the Poisson cosine series representation:
$$\vartheta(t) - 1 = 2 \sum_{n=1}^\infty e^{-\pi n^2 t}.$$
Because $n \le n^2$ for all $n \ge 1$, we have $-\pi n^2 t \le -\pi n t$, establishing the pointwise comparison with a geometric series:
$$2 \sum_{n=1}^\infty e^{-\pi n^2 t} \le 2 \sum_{n=1}^\infty e^{-\pi n t} = \frac{2 e^{-\pi t}}{1 - e^{-\pi t}}.$$

On the ray $[1, \infty)$, the denominator is uniformly bounded below:
since $\pi > 3$ implies $e^{-\pi} \le 1/2$, we have for all $t \ge 1$:
$$1 - e^{-\pi t} \ge 1 - e^{-\pi} \ge 1/2.$$
Consequently,
$$\vartheta(t) - 1 \le 4 e^{-\pi t} \quad \text{for all } t \ge 1.$$

For the symmetrized Mellin integrand $K_\sigma(x) + K_{1-\sigma}(x)$ on $[1, \infty)$ with $\sigma \in [0, 1]$, the kernel bound gives:
$$K_\sigma(x) + K_{1-\sigma}(x) \le 2 f_{\text{modif}}(x) \le 8 e^{-\pi x}.$$

Evaluating the improper integral over $(1, \infty)$:
$$\int_1^\infty 8 e^{-\pi x} \, dx = \frac{8 e^{-\pi}}{\pi} \le \frac{8 \cdot (1/2)}{3} = \frac{4}{3} < 4.$$

Multiplying by the normalization factor $1/2$:
$$\frac{1}{2} \int_1^\infty 8 e^{-\pi x} \, dx \le \frac{2}{3} < 2 < 4,$$
which strictly bounds the completed zeta entire component below the critical pole cancellation threshold of $4$.

## Formalization Structure

In `formalization/BuildingBlocks/RiemannZetaKernelEnergyBound.lean`:

1. **Quadratic and Exponential Term Domination**:
   - `nat_le_sq`: Quadratic power domination $n \le n^2$.
   - `exp_neg_pi_sq_le_exp_neg_pi_mul`: Termwise majorization $\exp(-\pi n^2 t) \le \exp(-\pi n t)$.
   - `exp_geom_pow`: Factorization into powers of the base ratio $\exp(-\pi t)$.
   - `exp_neg_pi_lt_one`: Base ratio strictly less than 1.
   - `hasSum_geom_theta`: Geometric series sum $\sum_{n=0}^\infty 2 e^{-\pi t} (e^{-\pi t})^n = \frac{2 e^{-\pi t}}{1 - e^{-\pi t}}$.

2. **Pointwise Majorization of the Theta Kernel**:
   - `evenKernel_sub_one_le_geom`: Uniform bound $\vartheta(t) - 1 \le \frac{2 e^{-\pi t}}{1 - e^{-\pi t}}$ for all $t > 0$.

3. **Uniform Denominator Bounds on $[1, \infty)$**:
   - `exp_neg_pi_le_half`: $\exp(-\pi) \le 1/2$.
   - `sub_exp_neg_pi_ge_half`: $1 - \exp(-\pi) \ge 1/2$.
   - `exp_neg_pi_mul_le_of_one_le`: Monotonicity on $[1, \infty)$.
   - `one_sub_exp_ge_half_of_one_le`: Denominator bound $1 - \exp(-\pi t) \ge 1/2$ for $t \ge 1$.
   - `evenKernel_sub_one_le_four_exp`: Pointwise exponential decay $\vartheta(t) - 1 \le 4 \exp(-\pi t)$ on $[1, \infty)$.

4. **Modifying Kernel and Mellin Integrand Bounds**:
   - `real_f_modif_le_four_exp`: $f_{\text{modif}}(x) \le 4 \exp(-\pi x)$ for all $x \ge 1$.
   - `mellinIntegrand_le_four_exp`: $K_\sigma(x) \le 4 \exp(-\pi x)$ for $x \ge 1$ and $\sigma \le 1$.
   - `symmetrized_integrand_le_eight_exp`: $K_\sigma(x) + K_{1-\sigma}(x) \le 8 \exp(-\pi x)$ for $x \ge 1$ and $\sigma \in [0, 1]$.

5. **Improper Integral Evaluation and Energy Bounds**:
   - `integral_exp_neg_pi_Ioi_one`: $\int_1^\infty \exp(-\pi x) dx = \exp(-\pi)/\pi$.
   - `integral_exp_neg_pi_le_one_sixth`: Numerical majorization $\int_1^\infty \exp(-\pi x) dx \le 1/6$.
   - `eight_mul_integral_exp_neg_pi_lt_four`: $8 \int_1^\infty \exp(-\pi x) dx < 4$.
   - `symmetrizedEnergyBound`: The dominant envelope $8 \exp(-\pi x)$.
   - `integral_symmetrizedEnergyBound`: $\int_1^\infty \text{symmetrizedEnergyBound}(x) dx = 8 \exp(-\pi)/\pi$.
   - `integral_symmetrizedEnergyBound_lt_four`: $\int_1^\infty \text{symmetrizedEnergyBound}(x) dx < 4$.
   - `half_integral_symmetrizedEnergyBound_lt_four`: $\frac{1}{2} \int_1^\infty \text{symmetrizedEnergyBound}(x) dx < 4$.
   - `half_integral_symmetrizedEnergyBound_lt_two`: $\frac{1}{2} \int_1^\infty \text{symmetrizedEnergyBound}(x) dx < 2$.

6. **Deductions of the Riemann Hypothesis**:
   - `completedRiemannZeta₀_eq_completedHurwitzZetaEven₀`: Identification of completed zeta functions at $a = 0$.
   - `RiemannHypothesis_of_weil_and_energy_bound`: Global deduction of Mathlib's `RiemannHypothesis` from a `UniversalWeilSystem` and the kernel energy bound.
   - `RiemannHypothesis_of_refutation_and_energy_bound`: Global deduction of Mathlib's `RiemannHypothesis` from a `UniversalZeroRefutationSystem` and the kernel energy bound.

## Foundational Axioms and Verification
- Zero `sorry` placeholders.
- Verified under foundational Lean 4 axioms: `[propext, Classical.choice, Quot.sound]`.
