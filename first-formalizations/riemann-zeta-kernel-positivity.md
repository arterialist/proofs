# Riemann Zeta Kernel Positivity, Modular Symmetry, and Symmetrized Bounding

## Summary
This module establishes the foundational positivity, strict positivity, modular inversion symmetry, and symmetrized uniform upper bounds for the real modifying kernel `real_f_modif` and its Mellin integrand `mellinIntegrand` generating the completed Riemann zeta function $\Lambda_0(s)$ in Lean 4:
1. **Pointwise Positivity of Theta Excess:**
   - Proves non-negativity of the Poisson-summed theta excess:
     `evenKernel_sub_one_nonneg : 0 ≤ evenKernel 0 t - 1` for all $t > 0$.
   - Proves strict positivity of the theta excess by isolating the $n = 0$ positive cosine mode:
     `evenKernel_sub_one_pos : 0 < evenKernel 0 t - 1` for all $t > 0$.
2. **Inversion Excess Positivity:**
   - Proves strict positivity of the modular inverted theta excess via the functional equation $\vartheta(t) = t^{-1/2} \vartheta(1/t)$:
     `evenKernel_sub_rpow_pos : 0 < evenKernel 0 t - t^(-1/2)` for all $t > 0$.
   - Proves non-negativity:
     `evenKernel_sub_rpow_nonneg : 0 ≤ evenKernel 0 t - t^(-1/2)` for all $t > 0$.
3. **Global Kernel Structure:**
   - Proves global non-negativity everywhere on $\mathbb{R}$:
     `real_f_modif_nonneg : 0 ≤ real_f_modif x`.
   - Proves vanishing on the non-positive axis:
     `real_f_modif_eq_zero_of_le_zero : x ≤ 0 → real_f_modif x = 0`.
   - Proves vanishing at the reflection center:
     `real_f_modif_one : real_f_modif 1 = 0`.
   - Proves strict positivity for $x > 1$:
     `real_f_modif_pos_of_gt_one : 1 < x → 0 < real_f_modif x`.
   - Proves strict positivity on the open unit interval $(0, 1)$:
     `real_f_modif_pos_of_mem_Ioo : x ∈ Set.Ioo 0 1 → 0 < real_f_modif x`.
4. **Exact Modular Kernel Symmetry:**
   - Proves exact scale-covariance under the inversion $x \mapsto 1/x$:
     `real_f_modif_symmetry : real_f_modif (1 / x) = x^(1/2) * real_f_modif x` for all $x > 0$.
5. **Mellin Integrand and Properties:**
   - Defines the real Mellin integrand:
     `mellinIntegrand σ x = real_f_modif x * x^(σ / 2 - 1)`.
   - Proves global non-negativity:
     `mellinIntegrand_nonneg : 0 ≤ mellinIntegrand σ x`.
   - Proves strict positivity on $(1, \infty)$ and $(0, 1)$:
     `mellinIntegrand_pos_of_gt_one`, `mellinIntegrand_pos_of_mem_Ioo`.
   - Proves the modular inversion law:
     `mellinIntegrand_symm : mellinIntegrand σ (1 / x) = x^2 * mellinIntegrand (1 - σ) x` for all $x > 0$.
6. **Symmetrized Pointwise Majorization:**
   - Proves non-positive power bound on $[1, \infty)$:
     `rpow_le_one_of_one_le_of_nonpos : 1 ≤ x → a ≤ 0 → x^a ≤ 1`.
   - Proves that for all $\sigma \le 1$, the Mellin integrand on $[1, \infty)$ is majorized by the modifying kernel:
     `mellinIntegrand_le_kernel_of_one_le : σ ≤ 1 → 1 ≤ x → mellinIntegrand σ x ≤ real_f_modif x`.
   - Proves the symmetrized majorization bound across the critical strip:
     `symmetrized_integrand_le : 0 ≤ σ → σ ≤ 1 → 1 ≤ x → mellinIntegrand σ x + mellinIntegrand (1 - σ) x ≤ 2 * real_f_modif x`.
7. **RH Bridges:**
   - Deduces Mathlib's `RiemannHypothesis` from kernel bounds via:
     - `RiemannHypothesis_of_weil_and_kernel_bound`
     - `RiemannHypothesis_of_refutation_and_kernel_bound`.

## Background and Mathematical Significance
The entire completed zeta function $\Lambda_0(s)$ is given by the Mellin transform of the modifying kernel $f_{\text{modif}}(x)$. This kernel subtracts the boundary singularity at infinity (the volume pole at $s = 1$) and the singularity at zero (the pole at $s = 0$).

Because the Jacobi theta function satisfies the Poisson summation formula and modular transformation $\vartheta(x) = x^{-1/2} \vartheta(1/x)$, omitting the boundary terms leaves a purely positive Gaussian core. This module establishes in Lean 4 that the kernel is everywhere non-negative, strictly positive away from $x = 1$, satisfies exact modular covariance $f_{\text{modif}}(1/x) = x^{1/2} f_{\text{modif}}(x)$, and obeys the uniform majorization $K_\sigma(x) + K_{1-\sigma}(x) \le 2 f_{\text{modif}}(x)$ on $[1, \infty)$ for all $\sigma \in [0, 1]$.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaKernelPositivity.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
