import BuildingBlocks.RiemannZetaFredholmPerronContourResolution
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: Module 334 (Riemann Zeta Fredholm-Perron Contour Resolution)

Audits all declarations in `BuildingBlocks.RiemannZetaFredholmPerronContourResolution` to guarantee:
1. Zero `sorry` or `sorryAx` usage.
2. Zero non-standard custom axioms.
3. Strict adherence to standard Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks.RiemannZetaFredholmPerronContourResolution

/-! ### Declarative In-File Axiom Checks -/

#print axioms frontierCutoff_pos
#print axioms frontierCutoff_nonneg
#print axioms cumulative_zero_free_frontier
#print axioms asymptoticCutoff_pos
#print axioms asymptoticCutoff_nonneg
#print axioms cumulative_zero_free_asymptotic
#print axioms fredholm_perron_of_RiemannHypothesis
#print axioms RiemannHypothesis_of_fredholm_perron
#print axioms RiemannHypothesis_of_fredholm_perron_frontier
#print axioms RiemannHypothesis_of_fredholm_perron_asymptotic
#print axioms target_of_fredholm_perron_frontier
#print axioms target_of_fredholm_perron_asymptotic
#print axioms RiemannHypothesis_iff_carrier_family_frontier
#print axioms RiemannHypothesis_iff_carrier_family_asymptotic
#print axioms RiemannHypothesis_iff_fredholm_perron_frontier
#print axioms RiemannHypothesis_iff_fredholm_perron_asymptotic
#print axioms spectral_gap_carrier_residue_duality
#print axioms carrier_power_dominates_residue_threshold
#print axioms fredholm_carrier_gap_residue_coercivity
#print axioms grand_fredholm_perron_master

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.frontierCutoff,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.frontierCutoff_pos,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.frontierCutoff_nonneg,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.cumulative_zero_free_frontier,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.asymptoticCutoff,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.asymptoticCutoff_pos,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.asymptoticCutoff_nonneg,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.cumulative_zero_free_asymptotic,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.FredholmPerronSynthesisSystem,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.fredholm_perron_of_RiemannHypothesis,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_of_fredholm_perron,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_of_fredholm_perron_frontier,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_of_fredholm_perron_asymptotic,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.target_of_fredholm_perron_frontier,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.target_of_fredholm_perron_asymptotic,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_iff_carrier_family_frontier,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_iff_carrier_family_asymptotic,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_iff_fredholm_perron_frontier,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.RiemannHypothesis_iff_fredholm_perron_asymptotic,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.spectral_gap_carrier_residue_duality,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.carrier_power_dominates_residue_threshold,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.fredholm_carrier_gap_residue_coercivity,
    `BuildingBlocks.RiemannZetaFredholmPerronContourResolution.grand_fredholm_perron_master
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

  logInfo "FREDHOLM PERRON CONTOUR RESOLUTION AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
