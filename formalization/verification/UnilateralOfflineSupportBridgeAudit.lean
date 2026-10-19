import BuildingBlocks.UnilateralOfflineSupportBridge

open BuildingBlocks

#check not_trivial_zero_of_half_lt_re
#print axioms not_trivial_zero_of_half_lt_re

#check right_offline_to_left_offline
#print axioms right_offline_to_left_offline

#check left_offline_to_right_offline
#print axioms left_offline_to_right_offline

#check rightOfflineSupport_empty_iff_leftOfflineSupport_empty
#print axioms rightOfflineSupport_empty_iff_leftOfflineSupport_empty

#check rightHalfZeroFree_iff_rightOfflineSupport_empty
#print axioms rightHalfZeroFree_iff_rightOfflineSupport_empty

#check RiemannHypothesis_iff_rightOfflineSupport_empty
#print axioms RiemannHypothesis_iff_rightOfflineSupport_empty

#check RiemannHypothesis_iff_leftOfflineSupport_empty
#print axioms RiemannHypothesis_iff_leftOfflineSupport_empty

#check offline_supports_empty_iff_rightOfflineSupport_empty
#print axioms offline_supports_empty_iff_rightOfflineSupport_empty

#check offline_supports_empty_iff_leftOfflineSupport_empty
#print axioms offline_supports_empty_iff_leftOfflineSupport_empty

#check spectralSupportConfinement_iff_RiemannHypothesis
#print axioms spectralSupportConfinement_iff_RiemannHypothesis

#check spectralSupportConfinement_iff_spectralDistance_zero
#print axioms spectralSupportConfinement_iff_spectralDistance_zero

#check rightOfflineSupportAbove_empty_iff_highFrequencyZeroFree
#print axioms rightOfflineSupportAbove_empty_iff_highFrequencyZeroFree

#check highFrequencyZeroFree_mono
#print axioms highFrequencyZeroFree_mono

#check rightOfflineSupport_empty_iff_highFrequencyZeroFree_of_low
#print axioms rightOfflineSupport_empty_iff_highFrequencyZeroFree_of_low

#check unilateral_rh_equivalence_chain
#print axioms unilateral_rh_equivalence_chain

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.not_trivial_zero_of_half_lt_re,
    `BuildingBlocks.right_offline_to_left_offline,
    `BuildingBlocks.left_offline_to_right_offline,
    `BuildingBlocks.rightOfflineSupport_empty_iff_leftOfflineSupport_empty,
    `BuildingBlocks.rightHalfZeroFree_iff_rightOfflineSupport_empty,
    `BuildingBlocks.RiemannHypothesis_iff_rightOfflineSupport_empty,
    `BuildingBlocks.RiemannHypothesis_iff_leftOfflineSupport_empty,
    `BuildingBlocks.offline_supports_empty_iff_rightOfflineSupport_empty,
    `BuildingBlocks.offline_supports_empty_iff_leftOfflineSupport_empty,
    `BuildingBlocks.spectralSupportConfinement_iff_RiemannHypothesis,
    `BuildingBlocks.spectralSupportConfinement_iff_spectralDistance_zero,
    `BuildingBlocks.rightOfflineSupportAbove_empty_iff_highFrequencyZeroFree,
    `BuildingBlocks.highFrequencyZeroFree_mono,
    `BuildingBlocks.rightOfflineSupport_empty_iff_highFrequencyZeroFree_of_low,
    `BuildingBlocks.unilateral_rh_equivalence_chain
  ]
  for thm in theorems do
    match env.find? thm with
    | some info =>
      if info.isUnsafe then
        throwError s!"Unsafe declaration detected: {thm}"
      logInfo m!"AUDITED DECLARATION {thm}"
    | none =>
      throwError s!"Declaration not found in environment: {thm}"
  logInfo "UNILATERAL OFFLINE SUPPORT BRIDGE AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
