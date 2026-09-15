import BuildingBlocks.PhysicalThetaMoments
import Mathlib.MeasureTheory.Measure.WithDensity
import Mathlib.MeasureTheory.Function.L2Space

namespace BuildingBlocks.PhysicalThetaMeasure
open Real MeasureTheory
open scoped ENNReal
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaUniform
open BuildingBlocks.PhysicalThetaParity BuildingBlocks.PhysicalThetaMoments

noncomputable def b (v : ℝ) : ℝ := exp (v / 2) + exp (-v / 2)
noncomputable def weight (v : ℝ) : ℝ := b v * phi v
noncomputable def density (v : ℝ) : ℝ≥0∞ := ENNReal.ofReal (weight v)
noncomputable def nu : Measure ℝ := volume.withDensity density
noncomputable def physicalWeight (v : ℝ) : ℝ := b v / phi v
noncomputable abbrev GroundSpace := Lp ℝ 2 nu
noncomputable def exteriorNu (R : ℝ) : Measure ℝ := nu.restrict {v : ℝ | R < |v|}
noncomputable abbrev ExteriorGroundSpace (R : ℝ) := Lp ℝ 2 (exteriorNu R)

theorem b_eq_two_cosh (v : ℝ) : b v = 2 * cosh (v / 2) := by
  rw [b, cosh_eq, neg_div]
  ring

theorem b_positive (v : ℝ) : 0 < b v := add_pos (exp_pos _) (exp_pos _)

theorem weight_positive (v : ℝ) : 0 < weight v := mul_pos (b_positive v) (phi_positive v)

theorem weight_continuous : Continuous weight := by
  have hb : Continuous b := by unfold b; fun_prop
  exact hb.mul phi_continuous

theorem density_measurable : Measurable density :=
  weight_continuous.measurable.ennreal_ofReal

theorem weight_integrable : Integrable weight := by
  have hi := (phi_exponential_moment_integrable (1 / 2)).const_mul 2
  apply hi.mono' weight_continuous.aestronglyMeasurable
  filter_upwards [] with v
  have h1 : exp (v / 2) ≤ exp ((1 / 2) * |v|) := exp_le_exp.mpr (by
    have h := le_abs_self v
    linarith)
  have h2 : exp (-v / 2) ≤ exp ((1 / 2) * |v|) := exp_le_exp.mpr (by
    have h := neg_le_abs v
    linarith)
  rw [Real.norm_eq_abs, abs_of_pos (weight_positive v)]
  unfold weight b
  have h := mul_le_mul_of_nonneg_right (add_le_add h1 h2) (phi_positive v).le
  nlinarith

instance nu_finite : IsFiniteMeasure nu := by
  apply isFiniteMeasure_withDensity
  exact (lintegral_ofReal_ne_top_iff_integrable weight_continuous.aestronglyMeasurable
    (Filter.Eventually.of_forall (fun v => (weight_positive v).le))).mpr weight_integrable

instance exteriorNu_finite (R : ℝ) : IsFiniteMeasure (exteriorNu R) := by
  unfold exteriorNu
  infer_instance

theorem nu_absolutelyContinuous : nu ≪ volume := withDensity_absolutelyContinuous _ _

theorem volume_absolutelyContinuous : volume ≪ nu := by
  apply withDensity_absolutelyContinuous' density_measurable.aemeasurable
  exact Filter.Eventually.of_forall (fun v => ne_of_gt (ENNReal.ofReal_pos.mpr (weight_positive v)))

theorem ae_dictionary (p : ℝ → Prop) : (∀ᵐ v ∂nu, p v) ↔ ∀ᵐ v, p v :=
  ⟨fun h => h.filter_mono volume_absolutelyContinuous.ae_le,
    fun h => h.filter_mono nu_absolutelyContinuous.ae_le⟩

theorem aestronglyMeasurable_dictionary (ψ : ℝ → ℝ) :
    AEStronglyMeasurable ψ nu ↔ AEStronglyMeasurable ψ volume :=
  ⟨fun h => AEStronglyMeasurable.mono_ac volume_absolutelyContinuous h,
    fun h => AEStronglyMeasurable.mono_ac nu_absolutelyContinuous h⟩

theorem physical_square_identity (ψ : ℝ → ℝ) (v : ℝ) :
    weight v * ψ v ^ 2 = physicalWeight v * (phi v * ψ v) ^ 2 := by
  unfold weight physicalWeight
  have hp := (phi_positive v).ne'
  field_simp

theorem physical_square_lintegral (ψ : ℝ → ℝ) :
    (∫⁻ v, ENNReal.ofReal (ψ v ^ 2) ∂nu) =
      ∫⁻ v, ENNReal.ofReal (physicalWeight v * (phi v * ψ v) ^ 2) := by
  rw [nu, lintegral_withDensity_eq_lintegral_mul_non_measurable volume density_measurable
    (Filter.Eventually.of_forall (fun v => ENNReal.ofReal_lt_top)) ]
  apply lintegral_congr
  intro v
  simp only [Pi.mul_apply, density]
  rw [← ENNReal.ofReal_mul (weight_positive v).le, physical_square_identity]

theorem physical_mass_memLp_dictionary (ψ : ℝ → ℝ) (hψ : AEStronglyMeasurable ψ nu) :
    MemLp ψ 2 nu ↔
      (∫⁻ v, ENNReal.ofReal (physicalWeight v * (phi v * ψ v) ^ 2)) ≠ ∞ := by
  have hm : AEStronglyMeasurable (fun v => ψ v ^ 2) nu := by
    simpa only [Pi.pow_apply] using hψ.pow 2
  rw [memLp_two_iff_integrable_sq hψ,
    ← lintegral_ofReal_ne_top_iff_integrable hm
      (Filter.Eventually.of_forall (fun v => sq_nonneg (ψ v))),
    physical_square_lintegral]

#print axioms b_eq_two_cosh
#print axioms b_positive
#print axioms weight_positive
#print axioms weight_continuous
#print axioms density_measurable
#print axioms weight_integrable
#print axioms nu_finite
#print axioms exteriorNu_finite
#print axioms nu_absolutelyContinuous
#print axioms volume_absolutelyContinuous
#print axioms ae_dictionary
#print axioms aestronglyMeasurable_dictionary
#print axioms physical_square_identity
#print axioms physical_square_lintegral
#print axioms physical_mass_memLp_dictionary
end BuildingBlocks.PhysicalThetaMeasure
