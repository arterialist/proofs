/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.HighFrequencyReductionBridge
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: High-Frequency Reduction Bridge

This audit module performs rigorous, in-kernel programmatic verification of all declarations
in `BuildingBlocks.HighFrequencyReductionBridge`.

Audit Standards:
1. Zero `sorry` / `sorryAx`.
2. Zero custom or unproven axioms.
3. Strict dependence on standard Lean 4 foundational axioms:
   `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks
open BuildingBlocks.HighFrequencyReductionBridge

/-! ### Declarative Axiom Checks -/

#check H0
#check canonicalThreshold
#check canonicalThreshold_pos
#print axioms canonicalThreshold_pos

#check canonicalThreshold_nonneg
#print axioms canonicalThreshold_nonneg

#check H0_pos
#print axioms H0_pos

#check H0_nonneg
#print axioms H0_nonneg

#check HighFrequencyDomain
#check HighFrequencyUpperDomain
#check HighFrequencyThresholdContradictionSystem

#check highFrequencyZeroFree_of_threshold_contradiction
#print axioms highFrequencyZeroFree_of_threshold_contradiction

#check highFrequencyZeroFree_of_upper_contradiction
#print axioms highFrequencyZeroFree_of_upper_contradiction

#check threshold_contradiction_of_highFrequencyZeroFree
#print axioms threshold_contradiction_of_highFrequencyZeroFree

#check highFrequencyZeroFree_iff_threshold_contradiction
#print axioms highFrequencyZeroFree_iff_threshold_contradiction

#check highFrequencyZeroFree_of_canonical_contradiction
#print axioms highFrequencyZeroFree_of_canonical_contradiction

#check RiemannHypothesis_of_canonical_contradiction
#print axioms RiemannHypothesis_of_canonical_contradiction

#check rh_of_high_frequency_threshold_contradiction
#print axioms rh_of_high_frequency_threshold_contradiction

#check RiemannHypothesis_iff_canonical_contradiction
#print axioms RiemannHypothesis_iff_canonical_contradiction

#check rh_iff_high_frequency_threshold_contradiction
#print axioms rh_iff_high_frequency_threshold_contradiction

#check displacement_residual_pos_of_strip
#print axioms displacement_residual_pos_of_strip

#check displacement_functional_pos_at_zero
#print axioms displacement_functional_pos_at_zero

#check barrier_displacement_nonpos_impossible
#print axioms barrier_displacement_nonpos_impossible

#check barrier_displacement_residual_mismatch_impossible
#print axioms barrier_displacement_residual_mismatch_impossible

#check barrier_displacement_integral_nonpos_impossible
#print axioms barrier_displacement_integral_nonpos_impossible

#check highFrequencyContradiction_mono
#print axioms highFrequencyContradiction_mono

#check RiemannHypothesis_of_higher_cutoff
#print axioms RiemannHypothesis_of_higher_cutoff

#check master_high_frequency_reduction
#print axioms master_high_frequency_reduction

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.HighFrequencyReductionBridge.H0,
    `BuildingBlocks.HighFrequencyReductionBridge.canonicalThreshold,
    `BuildingBlocks.HighFrequencyReductionBridge.canonicalThreshold_pos,
    `BuildingBlocks.HighFrequencyReductionBridge.canonicalThreshold_nonneg,
    `BuildingBlocks.HighFrequencyReductionBridge.H0_pos,
    `BuildingBlocks.HighFrequencyReductionBridge.H0_nonneg,
    `BuildingBlocks.HighFrequencyReductionBridge.HighFrequencyDomain,
    `BuildingBlocks.HighFrequencyReductionBridge.HighFrequencyUpperDomain,
    `BuildingBlocks.HighFrequencyReductionBridge.highFrequencyZeroFree_of_threshold_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.highFrequencyZeroFree_of_upper_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.threshold_contradiction_of_highFrequencyZeroFree,
    `BuildingBlocks.HighFrequencyReductionBridge.highFrequencyZeroFree_iff_threshold_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.highFrequencyZeroFree_of_canonical_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.RiemannHypothesis_of_canonical_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.rh_of_high_frequency_threshold_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.RiemannHypothesis_iff_canonical_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.rh_iff_high_frequency_threshold_contradiction,
    `BuildingBlocks.HighFrequencyReductionBridge.displacement_residual_pos_of_strip,
    `BuildingBlocks.HighFrequencyReductionBridge.displacement_functional_pos_at_zero,
    `BuildingBlocks.HighFrequencyReductionBridge.barrier_displacement_nonpos_impossible,
    `BuildingBlocks.HighFrequencyReductionBridge.barrier_displacement_residual_mismatch_impossible,
    `BuildingBlocks.HighFrequencyReductionBridge.barrier_displacement_integral_nonpos_impossible,
    `BuildingBlocks.HighFrequencyReductionBridge.highFrequencyContradiction_mono,
    `BuildingBlocks.HighFrequencyReductionBridge.RiemannHypothesis_of_higher_cutoff,
    `BuildingBlocks.HighFrequencyReductionBridge.master_high_frequency_reduction
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

  logInfo "HIGH-FREQUENCY REDUCTION BRIDGE AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
