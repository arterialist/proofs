/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannZetaPerronHolomorphy
import Lean

open Lean Elab Command
open BuildingBlocks.RiemannZetaPerronHolomorphy

#eval show CommandElabM Unit from do
  let thms := [
    ``centeredZetaLogDerivative_eq_sub,
    ``denominator_ne_zero,
    ``shifted_arg_ne_one,
    ``analyticAt_fullFactor_off_zeros,
    ``analyticAt_fullFactor_of_rightHalfZeroFree,
    ``analyticAt_fullFactor_of_RH,
    ``off_line_exponent_gt_three_halves,
    ``exponent_gap_pos,
    ``not_rightHalfZeroFree_of_zero,
    ``not_RiemannHypothesis_of_zero,
    ``perronSingularityFree_iff_rightHalfZeroFree,
    ``RiemannHypothesis_iff_perronSingularityFree,
    ``perronSingularityFree_of_highFrequencyContradictionSystem
  ]
  for thm in thms do
    let axioms ← Lean.collectAxioms thm
    let allowed : List Name := [``propext, ``Classical.choice, ``Quot.sound]
    for ax in axioms do
      if !allowed.contains ax then
        throwError m!"Unexpected axiom in {thm}: {ax}"
    logInfo m!"Axiom Audit PASSED for {thm}: {axioms.toList}"
