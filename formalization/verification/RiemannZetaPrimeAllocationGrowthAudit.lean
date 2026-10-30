import BuildingBlocks.RiemannZetaPrimeAllocationGrowth
import Lean.Util.CollectAxioms

open BuildingBlocks.RiemannZetaPrimeAllocationGrowth

#check T_re_nonneg
#print axioms T_re_nonneg

#check allocation_re_nonneg
#print axioms allocation_re_nonneg

#check W_re_le_fullNumerator_re
#print axioms W_re_le_fullNumerator_re

#check RiemannHypothesis_of_fullNumerator_growth_after
#print axioms RiemannHypothesis_of_fullNumerator_growth_after

#check RiemannHypothesis_of_eventually_fullNumerator_growth
#print axioms RiemannHypothesis_of_eventually_fullNumerator_growth

#check analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth
#print axioms analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth

#check grand_rh_bundle_of_eventually_fullNumerator_growth
#print axioms grand_rh_bundle_of_eventually_fullNumerator_growth

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.T_re_nonneg,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.allocation_re_nonneg,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.RiemannHypothesis_of_fullNumerator_growth_after,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.RiemannHypothesis_of_eventually_fullNumerator_growth,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth,
    `BuildingBlocks.RiemannZetaPrimeAllocationGrowth.grand_rh_bundle_of_eventually_fullNumerator_growth
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

  logInfo "RIEMANN ZETA PRIME ALLOCATION GROWTH AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
