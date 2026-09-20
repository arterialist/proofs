# Global Schwarz Reflection of Completed and Riemann Zeta Functions

## Summary
This module provides a machine-verified proof in Lean 4 that:
1. The completed Riemann zeta function `completedRiemannZeta` satisfies the global Schwarz reflection symmetry across the real axis:
   $$\Lambda(\overline{s}) = \overline{\Lambda(s)} \quad \text{for all } s \in \mathbb{C}.$$
2. The zeros of `completedRiemannZeta` reflect across the real axis globally:
   $$\Lambda(s) = 0 \iff \Lambda(\overline{s}) = 0 \quad \text{for all } s \in \mathbb{C}.$$
3. The Riemann zeta function `riemannZeta` satisfies exact Schwarz reflection on the open right half-plane $\operatorname{Re}(s) > 0$:
   $$\zeta(\overline{s}) = \overline{\zeta(s)} \quad \text{for all } s \in \mathbb{C} \text{ with } \operatorname{Re}(s) > 0.$$
4. For all off-line zero candidates in the critical half-plane $\operatorname{Re}(s) > 1/2$:
   $$\zeta(s) = 0 \iff \zeta(\overline{s}) = 0.$$

## Background and Mathematical Significance
In analytic number theory, the fact that $\zeta(\bar{s}) = \overline{\zeta(s)}$ is fundamental to the study of the zeros of the Riemann zeta function. It guarantees that any off-line zero with $\operatorname{Im}(s) < 0$ reflects across the real axis to an off-line zero with $\operatorname{Im}(s) > 0$, allowing researchers to restrict attention to the upper half-plane $\operatorname{Im}(s) > 0$.

A bounded search of the pinned Mathlib tree did not find these completed-zeta or zeta reflection statements; this records a local library gap rather than worldwide priority. This module proves them by inspecting the underlying definition of `completedHurwitzZetaEven 0`:
- Mathlib constructs `completedHurwitzZetaEven 0` via a weak functional equation pair `hurwitzEvenFEPair 0`.
- The modifying function `WeakFEPair.f_modif` is defined in terms of `evenKernel 0 : ℝ → ℝ`, which is explicitly real-valued.
- Proving that `P₀.f_modif x = (real_f_modif x : ℂ)` allows the application of `mellin_conj_of_real` from Module 270.
- This establishes that the entire function `completedRiemannZeta₀` satisfies $\Lambda_0(\bar{s}) = \overline{\Lambda_0(s)}$.
- The pole subtractions $-1/s - 1/(1-s)$ commute with conjugation, establishing global reflection for $\Lambda(s)$.
- Finally, using the identity $\zeta(s) = \Lambda(s) / \Gamma_{\mathbb{R}}(s)$ and the non-vanishing $\Gamma_{\mathbb{R}}(s) \ne 0$ for $\operatorname{Re}(s) > 0$ (`Gammaℝ_ne_zero_of_re_pos`), the reflection symmetry of $\zeta(s)$ on $\operatorname{Re}(s) > 0$ is deduced unconditionally.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaGlobalSchwarzReflection.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
