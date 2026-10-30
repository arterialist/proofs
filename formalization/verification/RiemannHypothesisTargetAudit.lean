/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannHypothesisTarget
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: Riemann Hypothesis Target and Grand Equivalence

This audit module performs rigorous, in-kernel verification of all declarations
in `BuildingBlocks.RiemannHypothesisTarget`.

Audit Standards:
1. Zero `sorry` / `sorryAx`.
2. Zero custom or unproven axioms.
3. Strict dependence on standard Lean 4 foundational axioms:
   `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks
open BuildingBlocks.RiemannHypothesisTarget

/-! ### Declarative Axiom Checks -/

#check canonicalRiemannHypothesis
#check canonicalTarget

#check target_eq_canonical
#print axioms target_eq_canonical

#check rh_iff_target
#print axioms rh_iff_target

#check real_axis_zero_free
#print axioms real_axis_zero_free

#check cumulative_zero_free_seven_forty_six_five
#print axioms cumulative_zero_free_seven_forty_six_five

#check cumulativeZeroFree_base_seven_forty_six_five
#print axioms cumulativeZeroFree_base_seven_forty_six_five

#check lowFrequencyZeroFree_seven_forty_six_five
#print axioms lowFrequencyZeroFree_seven_forty_six_five

#check bounded_height_zero_free
#print axioms bounded_height_zero_free

#check highFrequencyZeroFree_of_rh
#print axioms highFrequencyZeroFree_of_rh

#check rh_of_highFrequencyZeroFree
#print axioms rh_of_highFrequencyZeroFree

#check rh_iff_high_frequency_seven_forty_six_five
#print axioms rh_iff_high_frequency_seven_forty_six_five

#check rightOfflineSupport_iff_leftOfflineSupport
#print axioms rightOfflineSupport_iff_leftOfflineSupport

#check rh_iff_spectralSupportConfinement
#print axioms rh_iff_spectralSupportConfinement

#check spectralSupportConfinement_iff_dist_zero
#print axioms spectralSupportConfinement_iff_dist_zero

#check master_grand_rh_equivalence
#print axioms master_grand_rh_equivalence

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannHypothesisTarget.canonicalRiemannHypothesis,
    `BuildingBlocks.RiemannHypothesisTarget.canonicalTarget,
    `BuildingBlocks.RiemannHypothesisTarget.target_eq_canonical,
    `BuildingBlocks.RiemannHypothesisTarget.rh_iff_target,
    `BuildingBlocks.RiemannHypothesisTarget.rightHalfZeroFree,
    `BuildingBlocks.RiemannHypothesisTarget.spectralZeroSupport,
    `BuildingBlocks.RiemannHypothesisTarget.criticalLineSupport,
    `BuildingBlocks.RiemannHypothesisTarget.rightOfflineSupport,
    `BuildingBlocks.RiemannHypothesisTarget.leftOfflineSupport,
    `BuildingBlocks.RiemannHypothesisTarget.spectralSupportConfinement,
    `BuildingBlocks.RiemannHypothesisTarget.spectralDist,
    `BuildingBlocks.RiemannHypothesisTarget.highFrequencyZeroFree,
    `BuildingBlocks.RiemannHypothesisTarget.lowFrequencyZeroFree,
    `BuildingBlocks.RiemannHypothesisTarget.cumulativeZeroFree,
    `BuildingBlocks.RiemannHypothesisTarget.real_axis_zero_free,
    `BuildingBlocks.RiemannHypothesisTarget.cumulative_zero_free_seven_forty_six_five,
    `BuildingBlocks.RiemannHypothesisTarget.cumulativeZeroFree_base_seven_forty_six_five,
    `BuildingBlocks.RiemannHypothesisTarget.lowFrequencyZeroFree_seven_forty_six_five,
    `BuildingBlocks.RiemannHypothesisTarget.bounded_height_zero_free,
    `BuildingBlocks.RiemannHypothesisTarget.highFrequencyZeroFree_of_rh,
    `BuildingBlocks.RiemannHypothesisTarget.rh_of_highFrequencyZeroFree,
    `BuildingBlocks.RiemannHypothesisTarget.rh_iff_high_frequency_seven_forty_six_five,
    `BuildingBlocks.RiemannHypothesisTarget.rightOfflineSupport_iff_leftOfflineSupport,
    `BuildingBlocks.RiemannHypothesisTarget.rh_iff_spectralSupportConfinement,
    `BuildingBlocks.RiemannHypothesisTarget.spectralSupportConfinement_iff_dist_zero,
    `BuildingBlocks.RiemannHypothesisTarget.master_grand_rh_equivalence
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

  logInfo "RIEMANN HYPOTHESIS TARGET AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
