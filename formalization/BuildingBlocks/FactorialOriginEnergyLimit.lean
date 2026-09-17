import BuildingBlocks.FactorialOriginProfile
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.MeasureTheory.Integral.DominatedConvergence

open Filter MeasureTheory
namespace BuildingBlocks.FactorialOriginEnergyLimit

theorem exponential_first_quotient_limit (u : ℝ) (hu : 0 < u) :
    Tendsto (fun N : ℕ => (Real.exp (u / N) - 1) / (u / N)) atTop (nhds 1) := by
  have ht := tendsto_const_div_atTop_nhds_zero_nat u
  have hl := (Real.exp_sub_sum_range_succ_isLittleO_pow 1).tendsto_div_nhds_zero.comp ht
  norm_num [Finset.sum_range_succ, Nat.factorial] at hl
  have h := hl.add_const 1
  norm_num at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 1] with N hN
  have hn : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  field_simp
  ring

theorem exponential_second_quotient_limit (u : ℝ) (hu : 0 < u) :
    Tendsto (fun N : ℕ => (Real.exp (u / N) - 1 - u / N) / (u / N)^2)
      atTop (nhds (1 / 2)) := by
  have ht := tendsto_const_div_atTop_nhds_zero_nat u
  have hl := (Real.exp_sub_sum_range_succ_isLittleO_pow 2).tendsto_div_nhds_zero.comp ht
  norm_num [Finset.sum_range_succ, Nat.factorial] at hl
  have h := hl.add_const (1 / 2 : ℝ)
  norm_num at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 1] with N hN
  have hn : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  field_simp
  ring

/-- The full compensated density, including cancellation of its singular terms. -/
theorem scaled_weight_limit (u : ℝ) (hu : 0 < u) :
    Tendsto (fun N : ℕ => FactorialBinaryEnergy.weight (u / N) / N)
      atTop (nhds (1 / (2 * u))) := by
  have h := ((exponential_second_quotient_limit u hu).div
    (exponential_first_quotient_limit u hu) (by norm_num)).div_const u
  have h' : Tendsto
      (fun N : ℕ => ((Real.exp (u / N) - 1 - u / N) / (u / N)^2) /
        ((Real.exp (u / N) - 1) / (u / N)) / u) atTop (nhds (1 / (2 * u))) := by
    simpa only [div_one, div_mul_eq_div_div] using h
  apply h'.congr'
  filter_upwards [eventually_ge_atTop 1] with N hN
  have hn : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  have he : 0 < Real.exp (u / N) - 1 :=
    sub_pos.mpr (Real.one_lt_exp_iff.mpr (by positivity))
  unfold FactorialBinaryEnergy.weight
  field_simp

theorem scaled_energy_row_limit (u : ℝ) (hu : 0 < u) :
    Tendsto (fun N : ℕ => FactorialBinaryEnergy.energyRow N (u / N) / N)
      atTop (nhds (FactorialOriginProfile.profile u ^ 2 / (2 * u))) := by
  have h := ((FactorialOriginProfile.actual_origin_profile_limit u hu.le).pow 2).mul
    (scaled_weight_limit u hu)
  have h' : Tendsto
      (fun N : ℕ => FactorialBinaryCarry.response N (u / N)^2 *
        (FactorialBinaryEnergy.weight (u / N) / N))
      atTop (nhds (FactorialOriginProfile.profile u^2 / (2 * u))) := by
    simpa only [mul_one_div] using h
  apply h'.congr'
  exact Eventually.of_forall (fun N => by unfold FactorialBinaryEnergy.energyRow; ring)

theorem scaled_energy_measurable (N : ℕ) :
    Measurable (fun u : ℝ => FactorialBinaryEnergy.energyRow N (u / N) / N) := by
  have hr : Continuous (fun u : ℝ => FactorialBinaryCarry.response N (u / N)) :=
    (FactorialBinaryEnergy.response_continuous N).comp (continuous_id.div_const (N : ℝ))
  have hrm := hr.measurable
  unfold FactorialBinaryEnergy.energyRow FactorialBinaryEnergy.weight
  fun_prop

/-- One common polynomial majorant for all actual positive integer horizons. -/
theorem scaled_energy_norm_bound (N : ℕ) (hN : 1 ≤ N) (u : ℝ) (hu : 0 < u) :
    ‖FactorialBinaryEnergy.energyRow N (u / N) / N‖ ≤ u / 2 + u^2 + u^3 / 2 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  have hn1 : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [Real.norm_eq_abs, abs_of_nonneg (div_nonneg
    (FactorialBinaryEnergy.energyRow_nonneg N (u / N) (by positivity)) hn.le)]
  apply (FactorialOriginNeutralization.origin_energy_row_bound N (by omega) u hu).trans
  have hfirst : u / (2 * (N : ℝ)^2) ≤ u / 2 := by
    gcongr
    nlinarith
  have hsecond : u^2 / (N : ℝ) ≤ u^2 := div_le_self (sq_nonneg u) hn1
  exact add_le_add (add_le_add hfirst hsecond) le_rfl

/-- Finiteness of the limiting profile energy is proved on every fixed band. -/
theorem profile_energy_integrable (U : ℝ) :
    IntegrableOn (fun u : ℝ => FactorialOriginProfile.profile u^2 / (2 * u)) (Set.Ioc 0 U) := by
  have hm : AEStronglyMeasurable (fun u : ℝ => FactorialOriginProfile.profile u^2 / (2 * u))
      (volume.restrict (Set.Ioc 0 U)) := by
    apply aestronglyMeasurable_of_tendsto_ae atTop
      (fun N : ℕ => (scaled_energy_measurable N).aestronglyMeasurable)
    filter_upwards [self_mem_ae_restrict measurableSet_Ioc] with u hu
    exact scaled_energy_row_limit u hu.1
  have hp : Continuous (fun u : ℝ => u / 2 + u^2 + u^3 / 2) := by fun_prop
  have hi : IntegrableOn (fun u : ℝ => u / 2 + u^2 + u^3 / 2) (Set.Ioc 0 U) :=
    hp.integrableOn_Icc.mono_set (by intro u hu; exact ⟨hu.1.le, hu.2⟩)
  apply hi.mono' hm
  filter_upwards [self_mem_ae_restrict measurableSet_Ioc] with u hu
  apply le_of_tendsto (tendsto_norm.comp (scaled_energy_row_limit u hu.1))
  filter_upwards [eventually_ge_atTop 1] with N hN
  exact scaled_energy_norm_bound N hN u hu.1

/-- Dominated convergence on the entire fixed scaled band, including the origin endpoint. -/
theorem scaled_origin_energy_limit (U : ℝ) :
    Tendsto (fun N : ℕ => ∫ u in Set.Ioc 0 U, FactorialBinaryEnergy.energyRow N (u / N) / N)
      atTop (nhds (∫ u in Set.Ioc 0 U, FactorialOriginProfile.profile u^2 / (2 * u))) := by
  have hp : Continuous (fun u : ℝ => u / 2 + u^2 + u^3 / 2) := by fun_prop
  have hi : IntegrableOn (fun u : ℝ => u / 2 + u^2 + u^3 / 2) (Set.Ioc 0 U) :=
    hp.integrableOn_Icc.mono_set (by intro u hu; exact ⟨hu.1.le, hu.2⟩)
  apply tendsto_integral_filter_of_dominated_convergence (fun u : ℝ => u / 2 + u^2 + u^3 / 2)
    (Eventually.of_forall (fun N => (scaled_energy_measurable N).aestronglyMeasurable)) _ hi _
  · filter_upwards [eventually_ge_atTop 1] with N hN
    filter_upwards [self_mem_ae_restrict measurableSet_Ioc] with u hu
    exact scaled_energy_norm_bound N hN u hu.1
  · filter_upwards [self_mem_ae_restrict measurableSet_Ioc] with u hu
    exact scaled_energy_row_limit u hu.1

/-- Original origin-band energy converges with its actual moving endpoint U/N retained. -/
theorem actual_origin_energy_limit (U : ℝ) (hU : 0 ≤ U) :
    Tendsto (fun N : ℕ => ∫ t in Set.Ioc 0 (U / N), FactorialBinaryEnergy.energyRow N t)
      atTop (nhds (∫ u in Set.Ioc 0 U, FactorialOriginProfile.profile u^2 / (2 * u))) := by
  apply (scaled_origin_energy_limit U).congr'
  filter_upwards [eventually_ge_atTop 1] with N hN
  have hn : (0 : ℝ) < N := by exact_mod_cast (by omega : 0 < N)
  rw [← intervalIntegral.integral_of_le hU,
    ← intervalIntegral.integral_of_le (div_nonneg hU hn.le), intervalIntegral.integral_div,
    intervalIntegral.integral_comp_div _ hn.ne']
  simp only [zero_div, smul_eq_mul]
  field_simp

#print axioms scaled_energy_measurable
#print axioms scaled_energy_norm_bound
#print axioms profile_energy_integrable
#print axioms exponential_first_quotient_limit
#print axioms exponential_second_quotient_limit
#print axioms scaled_weight_limit
#print axioms scaled_energy_row_limit
#print axioms scaled_origin_energy_limit
#print axioms actual_origin_energy_limit
end BuildingBlocks.FactorialOriginEnergyLimit
