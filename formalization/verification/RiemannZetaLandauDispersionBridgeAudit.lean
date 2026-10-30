import BuildingBlocks.RiemannZetaLandauDispersionBridge
import Lean.Util.CollectAxioms

open BuildingBlocks.RiemannZetaLandauDispersionBridge

#check W_re_nonpos_iff_fullNumerator_le_allocation
#print axioms W_re_nonpos_iff_fullNumerator_le_allocation

#check eventually_W_re_nonpos_iff_eventually_fullNumerator_le_allocation
#print axioms eventually_W_re_nonpos_iff_eventually_fullNumerator_le_allocation

#check RiemannHypothesis_of_fullNumerator_le_allocation_after
#print axioms RiemannHypothesis_of_fullNumerator_le_allocation_after

#check RiemannHypothesis_of_eventually_fullNumerator_le_allocation
#print axioms RiemannHypothesis_of_eventually_fullNumerator_le_allocation

#check analyticOnNhd_filledTransform_of_eventually_fullNumerator_le_allocation
#print axioms analyticOnNhd_filledTransform_of_eventually_fullNumerator_le_allocation

#check grand_rh_bundle_of_eventually_fullNumerator_le_allocation
#print axioms grand_rh_bundle_of_eventually_fullNumerator_le_allocation

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.W_re_nonpos_iff_fullNumerator_le_allocation,
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.eventually_W_re_nonpos_iff_eventually_fullNumerator_le_allocation,
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.RiemannHypothesis_of_fullNumerator_le_allocation_after,
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.RiemannHypothesis_of_eventually_fullNumerator_le_allocation,
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.analyticOnNhd_filledTransform_of_eventually_fullNumerator_le_allocation,
    `BuildingBlocks.RiemannZetaLandauDispersionBridge.grand_rh_bundle_of_eventually_fullNumerator_le_allocation
  ]
  let allowed : Array Name := #[`propext, `Classical.choice, `Quot.sound]

  for thm in theorems do
    match env.find? thm with
    | some info =>
      if info.isUnsafe then
        throwError s!"Unsafe declaration detected: {thm}"
      logInfo m!"AUDITED DECLARATION: {thm}"
    | none =>
      throwError s!"Declaration not found in environment: {thm}"

    let axioms ← Lean.collectAxioms thm
    for ax in axioms do
      if !allowed.contains ax then
        throwError s!"Prohibited or custom axiom detected: {ax} in {thm}"
    logInfo m!"  Axioms for {thm}: {axioms}"

  logInfo "RIEMANN ZETA LANDAU DISPERSION BRIDGE AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
