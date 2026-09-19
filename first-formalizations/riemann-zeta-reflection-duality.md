# Riemann Zeta Real Reflection Duality and Left-Right Critical Equivalence

## Summary
This module formalizes the real-axis reflection duality of both the completed Riemann zeta function $\Lambda(s)$ and the uncompleted Riemann zeta function $\zeta(s)$ under the involution $\sigma \mapsto 1 - \sigma$ in Lean 4:
1. Proves that the modified completed Riemann zeta function $\Lambda_0(\sigma : \mathbb{C})$ has vanishing imaginary part and equals its real part on the entire real line:
   `completedRiemannZeta₀_ofReal_im_zero`, `completedRiemannZeta₀_ofReal_eq_re`.
2. Establishes the real functional reflection equations for $\Lambda_0$ and $\Lambda$:
   `completedRiemannZeta₀_ofReal_one_sub`, `completedRiemannZeta_ofReal_one_sub`.
3. Establishes real part invariance under reflection:
   `completedRiemannZeta₀_ofReal_re_one_sub`, `completedRiemannZeta_ofReal_re_one_sub`.
4. Proves pointwise zero and non-vanishing equivalence under reflection:
   `completedRiemannZeta_ofReal_zero_iff_one_sub`, `completedRiemannZeta_ofReal_ne_zero_iff_one_sub`.
5. Proves pointwise negative energy equivalence:
   `completedRiemannZeta_ofReal_re_neg_iff_one_sub`.
6. Proves pointwise zero and non-vanishing equivalence for uncompleted $\zeta$ on $(0, 1)$:
   `riemannZeta_ofReal_zero_iff_one_sub`, `riemannZeta_ofReal_ne_zero_iff_one_sub`.
7. Proves the interval equivalence reducing zero-freeness on $(1/2, 1)$ to $(0, 1/2)$:
   `realAxisZeroFree_of_left_half_zero_free`, `realAxisZeroFree_of_left_half_zeta_zero_free`.
8. Proves the bidirectional equivalence between left-half and right-half zero-freeness:
   `left_half_zeta_zero_free_iff_right_half_zeta_zero_free`, `realAxisZeroFree_iff_left_half_zeta_zero_free`.
9. Gives conditional RH deductions from one supplied universal system record plus left-half real-axis zero-freeness:
   - `RiemannHypothesis_of_weil_and_left_half_zero_free`
   - `RiemannHypothesis_of_refutation_and_left_half_zero_free`
   - `RiemannHypothesis_of_fredholm_and_left_half_zero_free`.

## Background and Mathematical Significance
The functional equation of the Riemann zeta function links values at $s$ to $1 - s$. On the real line, the involution $\sigma \mapsto 1 - \sigma$ interchanges the interval $(0, 1/2)$ and $(1/2, 1)$, with the critical point $\sigma = 1/2$ acting as the fixed point of symmetry.

By combining the real reflection invariance $\Lambda(1 - \sigma) = \Lambda(\sigma)$ with the non-vanishing of the Deligne factor $\Gamma_{\mathbb{R}}(\sigma) \ne 0$ for $\sigma > 0$, any zero on the right half-interval $(1/2, 1)$ corresponds to a zero on the left half-interval $(0, 1/2)$, and vice versa. This equivalence allows verifying real-axis zero-freeness on either interval.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/RiemannZetaReflectionDuality.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
