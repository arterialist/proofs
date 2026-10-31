import BuildingBlocks.RiemannZetaCauchyResidueShift

/-!
# In-Kernel Axiom Audit: Module 330 (Cauchy Residue Contour Shift)

Audits all declarations in `BuildingBlocks.RiemannZetaCauchyResidueShift` to guarantee:
1. Zero `sorry` or `sorryAx` usage.
2. Zero non-standard custom axioms.
3. Strict adherence to standard Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
-/

open BuildingBlocks.RiemannZetaCauchyResidueShift

#print axioms critical_line_exponent_lt_subquadratic
#print axioms critical_line_exponent_lt_one
#print axioms spectralGap_pos
#print axioms residueExponent_sub_critical_line
#print axioms residueExponent_gt_subquadratic
#print axioms residueExponent_sub_three_halves_pos
#print axioms residueExponent_sub_half_gt_one
#print axioms not_offline_zeros_of_subquadratic
#print axioms not_offline_zeros_of_perronLogGrowth
#print axioms RiemannHypothesis_of_subquadratic_cauchy_shift
#print axioms RiemannHypothesis_of_perronLogGrowth_cauchy_shift
#print axioms target_of_subquadratic_cauchy_shift
#print axioms target_of_perronLogGrowth_cauchy_shift
#print axioms analyticOnNhd_filledTransform_of_subquadratic_cauchy_shift
#print axioms RiemannHypothesis_of_admissible_system
#print axioms riemann_hypothesis_cauchy_shift_resolution_iff
#print axioms RiemannHypothesis_iff_no_offline_double_poles_cauchy
#print axioms grand_cauchy_residue_shift_master
