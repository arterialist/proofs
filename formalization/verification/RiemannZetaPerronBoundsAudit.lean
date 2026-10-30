import BuildingBlocks.RiemannZetaPerronBounds
import Lean.Util.CollectAxioms

open BuildingBlocks.RiemannZetaPerronBounds

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let decls : List Name := [
    `BuildingBlocks.RiemannZetaPerronBounds.sum_vonMangoldt_sq_eq_sum_psi,
    `BuildingBlocks.RiemannZetaPerronBounds.sum_vonMangoldt_sq_le,
    `BuildingBlocks.RiemannZetaPerronBounds.vonMangoldt_mul_vonMangoldt_nonneg,
    `BuildingBlocks.RiemannZetaPerronBounds.tent_sum_vonMangoldt_sq_le,
    `BuildingBlocks.RiemannZetaPerronBounds.sum_N_core_le,
    `BuildingBlocks.RiemannZetaPerronBounds.baseline_re_le,
    `BuildingBlocks.RiemannZetaPerronBounds.C_N_pos,
    `BuildingBlocks.RiemannZetaPerronBounds.N_re_le,
    `BuildingBlocks.RiemannZetaPerronBounds.fullNumerator_re_le_quartic,
    `BuildingBlocks.RiemannZetaPerronBounds.W_re_le_quartic,
    `BuildingBlocks.RiemannZetaPerronBounds.eventually_fullNumerator_re_le_quartic,
    `BuildingBlocks.RiemannZetaPerronBounds.eventually_W_re_le_quartic,
    `BuildingBlocks.RiemannZetaPerronBounds.RiemannHypothesis_of_fullNumerator_log_growth_after,
    `BuildingBlocks.RiemannZetaPerronBounds.RiemannHypothesis_of_eventually_fullNumerator_log_growth,
    `BuildingBlocks.RiemannZetaPerronBounds.norm_fullNumerator_le_perron,
    `BuildingBlocks.RiemannZetaPerronBounds.fullNumerator_re_le_perron,
    `BuildingBlocks.RiemannZetaPerronBounds.W_re_le_perron
  ]

  let allowed : Array Name := #[`propext, `Classical.choice, `Quot.sound]

  for thm in decls do
    match env.find? thm with
    | some info =>
      if info.isUnsafe then
        throwError s!"Unsafe declaration detected: {thm}"
      let axioms ← Lean.collectAxioms thm
      for ax in axioms do
        if !allowed.contains ax then
          throwError s!"Prohibited axiom {ax} in {thm}"
      logInfo m!"AUDITED: {thm} (axioms: {axioms})"
    | none =>
      throwError s!"Declaration not found in environment: {thm}"

  logInfo "RIEMANN ZETA PERRON BOUNDS AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
