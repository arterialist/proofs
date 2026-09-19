# Catalog entry 352: scalar chirped phase-coherence bounds

This page documents `formalization/BuildingBlocks/ChirpedFresnelPhaseCoherence.lean`.

The module proves seven real-valued identities and inequalities:

- `cos_ge_half_of_abs_le_one`, using Mathlib's `Real.one_sub_sq_div_two_le_cos`;
- a phase-deviation bound on the interval defined by the scalar `fresnelRadius`;
- the resulting pointwise cosine and `a_min * cos` lower bounds;
- `tunedCarrier_product_eq`;
- positivity of `a_min^2 / (η*T)`;
- `fresnel_energy_eq`, the identity
  `a_min^2 * fresnelRadius η T ^ 2 = a_min^2 / (η*T)`.

Here “energy” is the name of a scalar expression. The file does not define or integrate a wavepacket, prove a Fresnel integral estimate, or establish an operator norm/coercivity result. The real-power step uses pinned Mathlib declarations `Real.rpow_mul` and `Real.rpow_neg_one` from `Mathlib/Analysis/SpecialFunctions/Pow/Real.lean`.

The project-specific arrangement of these scalar lemmas may be useful as a certificate component. A bounded search establishes substantial Mathlib overlap in the underlying trigonometric and real-power facts, so no worldwide first-formalization claim is made.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`, from `lake-manifest.json`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
