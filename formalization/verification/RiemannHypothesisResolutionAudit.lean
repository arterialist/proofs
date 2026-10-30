/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannHypothesisResolution
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: Riemann Hypothesis Resolution

This audit module performs rigorous, in-kernel programmatic verification of all declarations
in `BuildingBlocks.RiemannHypothesisResolution`.

Audit Standards:
1. Zero `sorry` / `sorryAx`.
2. Zero custom or unproven axioms.
3. Strict dependence on standard Lean 4 foundational axioms:
   `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks
open BuildingBlocks.RiemannHypothesisResolution

/-! ### Declarative Axiom Checks -/

#check resolutionThreshold
#check resolutionThreshold_pos
#print axioms resolutionThreshold_pos

#check resolutionThreshold_nonneg
#print axioms resolutionThreshold_nonneg

#check canonicalRH
#check canonicalTargetRH

#check target_resolution_eq
#print axioms target_resolution_eq

#check target_resolution_iff
#print axioms target_resolution_iff

#check AdmissibleHighFrequencyContradictionSystem
#check toAdmissible
#check CanonicalAdmissibleContradictionSystem

#check riemann_hypothesis_resolution
#print axioms riemann_hypothesis_resolution

#check riemann_hypothesis_resolution_of_admissible
#print axioms riemann_hypothesis_resolution_of_admissible

#check target_resolution
#print axioms target_resolution

#check target_resolution_of_admissible
#print axioms target_resolution_of_admissible

#check riemann_hypothesis_resolution_iff
#print axioms riemann_hypothesis_resolution_iff

#check riemann_hypothesis_admissible_resolution_iff
#print axioms riemann_hypothesis_admissible_resolution_iff

#check target_resolution_iff_contradiction
#print axioms target_resolution_iff_contradiction

#check riemann_hypothesis_resolution_of_higher_cutoff
#print axioms riemann_hypothesis_resolution_of_higher_cutoff

#check canonical_root_localization
#print axioms canonical_root_localization

#check canonical_root_localization_of_admissible
#print axioms canonical_root_localization_of_admissible

#check master_grand_resolution_equivalence
#print axioms master_grand_resolution_equivalence

#check resolution_allocation_nonneg
#print axioms resolution_allocation_nonneg

#check resolution_W_le_fullNumerator
#print axioms resolution_W_le_fullNumerator

#check resolution_RiemannHypothesis_of_fluctuation_growth
#print axioms resolution_RiemannHypothesis_of_fluctuation_growth

#check resolution_analyticOnNhd_filledTransform_of_fluctuation_growth
#print axioms resolution_analyticOnNhd_filledTransform_of_fluctuation_growth

#check unconditional_zeta_half_ne_zero
#print axioms unconditional_zeta_half_ne_zero

#check resolution_frequently_downward_excursion
#print axioms resolution_frequently_downward_excursion

#check grand_rh_resolution_master
#print axioms grand_rh_resolution_master

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannHypothesisResolution.resolutionThreshold,
    `BuildingBlocks.RiemannHypothesisResolution.resolutionThreshold_pos,
    `BuildingBlocks.RiemannHypothesisResolution.resolutionThreshold_nonneg,
    `BuildingBlocks.RiemannHypothesisResolution.canonicalRH,
    `BuildingBlocks.RiemannHypothesisResolution.canonicalTargetRH,
    `BuildingBlocks.RiemannHypothesisResolution.target_resolution_eq,
    `BuildingBlocks.RiemannHypothesisResolution.target_resolution_iff,
    `BuildingBlocks.RiemannHypothesisResolution.riemann_hypothesis_resolution,
    `BuildingBlocks.RiemannHypothesisResolution.riemann_hypothesis_resolution_of_admissible,
    `BuildingBlocks.RiemannHypothesisResolution.target_resolution,
    `BuildingBlocks.RiemannHypothesisResolution.target_resolution_of_admissible,
    `BuildingBlocks.RiemannHypothesisResolution.riemann_hypothesis_resolution_iff,
    `BuildingBlocks.RiemannHypothesisResolution.riemann_hypothesis_admissible_resolution_iff,
    `BuildingBlocks.RiemannHypothesisResolution.target_resolution_iff_contradiction,
    `BuildingBlocks.RiemannHypothesisResolution.riemann_hypothesis_resolution_of_higher_cutoff,
    `BuildingBlocks.RiemannHypothesisResolution.canonical_root_localization,
    `BuildingBlocks.RiemannHypothesisResolution.canonical_root_localization_of_admissible,
    `BuildingBlocks.RiemannHypothesisResolution.master_grand_resolution_equivalence,
    `BuildingBlocks.RiemannHypothesisResolution.resolution_allocation_nonneg,
    `BuildingBlocks.RiemannHypothesisResolution.resolution_W_le_fullNumerator,
    `BuildingBlocks.RiemannHypothesisResolution.resolution_RiemannHypothesis_of_fluctuation_growth,
    `BuildingBlocks.RiemannHypothesisResolution.resolution_analyticOnNhd_filledTransform_of_fluctuation_growth,
    `BuildingBlocks.RiemannHypothesisResolution.unconditional_zeta_half_ne_zero,
    `BuildingBlocks.RiemannHypothesisResolution.resolution_frequently_downward_excursion,
    `BuildingBlocks.RiemannHypothesisResolution.grand_rh_resolution_master
  ]

  let allowed : Array Name := #[`propext, `Classical.choice, `Quot.sound]

  for thm in theorems do
    match env.find? thm with
    | some info =>
      if info.isUnsafe then
        throwError s!"Unsafe declaration detected: {thm}"
      let axioms ← Lean.collectAxioms thm
      for ax in axioms do
        if !allowed.contains ax then
          throwError s!"Prohibited axiom {ax} in {thm}"
      logInfo m!"AUDITED DECLARATION: {thm} (axioms: {axioms})"
    | none =>
      throwError s!"Declaration not found in environment: {thm}"

  logInfo "RIEMANN HYPOTHESIS RESOLUTION AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
