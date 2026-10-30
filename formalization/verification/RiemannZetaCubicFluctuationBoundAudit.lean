/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannZetaCubicFluctuationBound
import Lean.Util.CollectAxioms

/-!
# In-Kernel Axiom Audit: Cubic Fluctuation Bound and Divisor Sum Convergence

This audit module performs rigorous, in-kernel programmatic verification of all declarations
in `BuildingBlocks.RiemannZetaCubicFluctuationBound`.

Audit Standards:
1. Zero `sorry` / `sorryAx`.
2. Zero custom or unproven axioms.
3. Strict dependence on standard Lean 4 foundational axioms:
   `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks
open BuildingBlocks.RiemannZetaCubicFluctuationBound

/-! ### Declarative Axiom Checks -/

#check sum_inv_sq_le_two_sub_inv
#print axioms sum_inv_sq_le_two_sub_inv

#check sum_inv_sq_le_two
#print axioms sum_inv_sq_le_two

#check sqrt_div_pow_three_le_one_div_sq
#print axioms sqrt_div_pow_three_le_one_div_sq

#check sum_sqrt_div_pow_three_le_two
#print axioms sum_sqrt_div_pow_three_le_two

#check sum_sqrt_mul_div_le
#print axioms sum_sqrt_mul_div_le

#check C_cubic
#check C_cubic_pos
#print axioms C_cubic_pos

#check fullNumerator_re_le_cubic
#print axioms fullNumerator_re_le_cubic

#check W_re_le_cubic
#print axioms W_re_le_cubic

#check eventually_fullNumerator_re_le_cubic
#print axioms eventually_fullNumerator_re_le_cubic

#check eventually_W_re_le_cubic
#print axioms eventually_W_re_le_cubic

/-! ### In-Kernel Programmatic Declaration and Transitive Axiom Audit -/

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let theorems := #[
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_inv_sq_le_two_sub_inv,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_inv_sq_le_two,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.sqrt_div_pow_three_le_one_div_sq,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_sqrt_div_pow_three_le_two,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_sqrt_mul_div_le,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.C_cubic,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.C_cubic_pos,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.fullNumerator_re_le_cubic,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.W_re_le_cubic,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.eventually_fullNumerator_re_le_cubic,
    `BuildingBlocks.RiemannZetaCubicFluctuationBound.eventually_W_re_le_cubic
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

  logInfo "CUBIC FLUCTUATION BOUND AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
