/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import BuildingBlocks.ActualCriticalLineAmplitude

/-!
# In-Kernel Verification Audit: ActualCriticalLineAmplitude

Confirms strict dependence exclusively on standard Lean 4 foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
with exactly 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

open BuildingBlocks.ActualCriticalLineAmplitude

#print axioms analyticAt_M_of
#print axioms M_ne_zero_of
#print axioms line_facts
#print axioms analyticAt_M_line
#print axioms M_ne_zero_line
#print axioms Fext_eq_filledTransform
#print axioms Fext_pole
#print axioms tendsto_add_ofReal
#print axioms tendsto_add_ofReal_punctured
#print axioms tendsto_sq_Fext
#print axioms exists_quarter
#print axioms eventually_eq_Fext_on_ray
#print axioms tendsto_half_add
#print axioms tendsto_sq_ofReal
#print axioms norm_coeff_le_of_upper
#print axioms norm_coeff_le_of_lower
#print axioms im_ne_zero_of_zero_on_line
#print axioms norm_M_le_norm_coeff
#print axioms exists_line_upper_excursion
#print axioms exists_line_lower_excursion
#print axioms line_amplitude
#print axioms M_ne_zero_of_zero_on_line
#print axioms multiplicity_bound_of_upper
