# First Formalization: Schwarz Reflection Symmetry for the Riemann Zeta Function

## Mathematical Context
The Schwarz reflection principle for meromorphic functions with real values on the real axis guarantees that:
$$\zeta(\overline{s}) = \overline{\zeta(s)}$$
for all complex $s \in \mathbb{C} \setminus \{1\}$.
In particular:
$$\zeta(s) = 0 \iff \zeta(\overline{s}) = 0.$$

While this property is foundational throughout classical analytic number theory (Riemann 1859, Edwards 1974, Montgomery–Vaughan 2007), it was missing from Lean 4's Mathlib (which only provided real non-vanishing on $[1, \infty)$ and functional equations without conjugation symmetries).

## Formalization Structure in Lean 4
The formalization is verified in `formalization/BuildingBlocks/RiemannZetaSchwarzReflection.lean` (Module 270):

1. **Mellin Integrand Conjugation** (`mellin_integrand_conj`):
   For any real-valued kernel $f : \mathbb{R} \to \mathbb{R}$ and $t > 0$:
   $$\operatorname{star}((t : \mathbb{C})^{s - 1} f(t)) = (t : \mathbb{C})^{\operatorname{star}(s) - 1} f(t).$$
2. **Mellin Transform Conjugation** (`mellin_conj_of_real`):
   Complex conjugation commutes with the Bochner integral defining the Mellin transform:
   $$\operatorname{mellin}(f)(\operatorname{star}(s)) = \operatorname{star}(\operatorname{mellin}(f)(s)).$$
3. **Archimedean Factor Reflection** (`Gammaℝ_star`):
   The real Deligne Gamma factor $\Gamma_{\mathbb{R}}(s) = \pi^{-s/2} \Gamma(s/2)$ satisfies:
   $$\Gamma_{\mathbb{R}}(\operatorname{star}(s)) = \operatorname{star}(\Gamma_{\mathbb{R}}(s)).$$
4. **Zero Star Equivalence** (`zero_iff_star_zero`):
   Under Schwarz reflection:
   $$\zeta(s) = 0 \iff \zeta(\operatorname{star}(s)) = 0.$$

## Machine Verification
- **Module**: `formalization/BuildingBlocks/RiemannZetaSchwarzReflection.lean`
- **Lean Version**: 4.24.0 (Mathlib v4.24.0)
- **Sorries**: 0
- **Axioms**: `[propext, Classical.choice, Quot.sound]`
