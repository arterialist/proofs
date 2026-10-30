/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.RiemannZetaExtendedRatioDeficit
import Lean

open Lean Elab Command
open BuildingBlocks.RiemannZetaExtendedRatioDeficit

#eval show CommandElabM Unit from do
  let thms := [
    ``normSq_coords_le_three_thousand_one_hundred_sixty_five,
    ``normSq_mul_sub_one_le_three_thousand_one_hundred_sixty_five,
    ``one_div_three_thousand_one_hundred_sixty_five_le_inv_normSq,
    ``intermediate_deficit_seven_forty_six_five_to_seven_forty_six_seven,
    ``intermediate_half_plane_zero_free_seven_forty_six_five_to_seven_forty_six_seven,
    ``normSq_coords_le_three_thousand_one_hundred_sixty_six,
    ``normSq_mul_sub_one_le_three_thousand_one_hundred_sixty_six,
    ``one_div_three_thousand_one_hundred_sixty_six_le_inv_normSq,
    ``intermediate_deficit_seven_forty_six_seven_to_seven_forty_six_seven_eight,
    ``intermediate_half_plane_zero_free_seven_forty_six_seven_to_seven_forty_six_seven_eight,
    ``normSq_coords_le_three_thousand_one_hundred_sixty_six_point_two,
    ``normSq_mul_sub_one_le_three_thousand_one_hundred_sixty_six_point_two,
    ``one_div_three_thousand_one_hundred_sixty_six_point_two_le_inv_normSq,
    ``intermediate_deficit_seven_forty_six_seven_eight_to_seven_forty_six_eight,
    ``intermediate_half_plane_zero_free_seven_forty_six_seven_eight_to_seven_forty_six_eight,
    ``cumulative_zero_free_base_seven_forty_six_eight,
    ``cumulative_zero_free_to_seven_four_six_eight,
    ``lowFrequencyZeroFree_seven_forty_six_eight,
    ``bounded_height_zero_free_seven_forty_six_eight,
    ``rh_iff_high_frequency_seven_forty_six_eight,
    ``rh_of_highFrequencyZeroFree_seven_forty_six_eight,
    ``highFrequencyZeroFree_seven_forty_six_eight_of_rh,
    ``RiemannHypothesis_of_pushed_contradiction
  ]
  for thm in thms do
    let axioms ← Lean.collectAxioms thm
    let allowed : List Name := [``propext, ``Classical.choice, ``Quot.sound]
    for ax in axioms do
      if !allowed.contains ax then
        throwError m!"Unexpected axiom in {thm}: {ax}"
    logInfo m!"Axiom Audit PASSED for {thm}: {axioms.toList}"
