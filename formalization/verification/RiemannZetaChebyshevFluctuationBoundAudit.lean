/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannZetaChebyshevFluctuationBound
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: Chebyshev Fluctuation Bound and Centered Growth Resolution

This audit module performs rigorous, in-kernel programmatic verification of all declarations
in `BuildingBlocks.RiemannZetaChebyshevFluctuationBound`.

Audit Standards:
1. Zero `sorry` / `sorryAx`.
2. Zero custom or unproven axioms.
3. Strict dependence on standard Lean 4 foundational axioms:
   `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks
open BuildingBlocks.RiemannZetaChebyshevFluctuationBound

/-! ### Declarative Axiom Checks -/

#check sum_vonMangoldt_sq_eq_sum_psi
#print axioms sum_vonMangoldt_sq_eq_sum_psi

#check sum_vonMangoldt_sq_le
#print axioms sum_vonMangoldt_sq_le

#check tent_sum_vonMangoldt_sq_le
#print axioms tent_sum_vonMangoldt_sq_le

#check sum_N_core_le
#print axioms sum_N_core_le

#check baseline_re_le
#print axioms baseline_re_le

#check C_N
#check C_N_pos
#print axioms C_N_pos

#check N_re_le
#print axioms N_re_le

#check fullNumerator_re_le_quartic
#print axioms fullNumerator_re_le_quartic

#check W_re_le_quartic
#print axioms W_re_le_quartic

#check eventually_fullNumerator_re_le_quartic
#print axioms eventually_fullNumerator_re_le_quartic

#check eventually_W_re_le_quartic
#print axioms eventually_W_re_le_quartic

#check norm_fullNumerator_le_perron
#print axioms norm_fullNumerator_le_perron

#check fullNumerator_re_le_perron
#print axioms fullNumerator_re_le_perron

#check W_re_le_perron
#print axioms W_re_le_perron

#check RiemannHypothesis_of_fullNumerator_log_growth_after
#print axioms RiemannHypothesis_of_fullNumerator_log_growth_after

#check RiemannHypothesis_of_eventually_fullNumerator_log_growth
#print axioms RiemannHypothesis_of_eventually_fullNumerator_log_growth

#check RiemannHypothesis_of_fullNumerator_subquadratic_growth_after
#print axioms RiemannHypothesis_of_fullNumerator_subquadratic_growth_after

#check RiemannHypothesis_of_eventually_fullNumerator_subquadratic_growth
#print axioms RiemannHypothesis_of_eventually_fullNumerator_subquadratic_growth

#check analyticOnNhd_filledTransform_of_eventually_fullNumerator_log_growth
#print axioms analyticOnNhd_filledTransform_of_eventually_fullNumerator_log_growth

#check target_of_eventually_fullNumerator_log_growth
#print axioms target_of_eventually_fullNumerator_log_growth

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.sum_vonMangoldt_sq_eq_sum_psi,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.sum_vonMangoldt_sq_le,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.tent_sum_vonMangoldt_sq_le,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.sum_N_core_le,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.baseline_re_le,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.C_N,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.C_N_pos,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.N_re_le,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.fullNumerator_re_le_quartic,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.W_re_le_quartic,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.eventually_fullNumerator_re_le_quartic,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.eventually_W_re_le_quartic,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.norm_fullNumerator_le_perron,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.fullNumerator_re_le_perron,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.W_re_le_perron,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.RiemannHypothesis_of_fullNumerator_log_growth_after,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.RiemannHypothesis_of_eventually_fullNumerator_log_growth,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.RiemannHypothesis_of_fullNumerator_subquadratic_growth_after,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.RiemannHypothesis_of_eventually_fullNumerator_subquadratic_growth,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.analyticOnNhd_filledTransform_of_eventually_fullNumerator_log_growth,
    `BuildingBlocks.RiemannZetaChebyshevFluctuationBound.target_of_eventually_fullNumerator_log_growth
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

  logInfo "CHEBYSHEV FLUCTUATION BOUND AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
