import BuildingBlocks.FactorialBinaryEnergy
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

open Set MeasureTheory Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialBinaryIntegrability
open FactorialBinaryCarry FactorialBinaryEnergy

noncomputable def sizeBudget (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, |(ArithmeticFunction.moebius n : ℝ)| * (1 + (N / n : ℕ))

theorem sizeBudget_nonneg (N : ℕ) : 0 ≤ sizeBudget N := by
  unfold sizeBudget
  exact sum_nonneg (fun _ _ => by positivity)

theorem exponential_increment_bounds (q t : ℝ) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ 1 - Real.exp (-q * t) ∧
    1 - Real.exp (-q * t) ≤ 1 ∧ 1 - Real.exp (-q * t) ≤ q * t := by
  have hu : -q * t ≤ 0 := by nlinarith
  have he := Real.exp_le_one_iff.mpr hu
  have hl := Real.add_one_le_exp (-q * t)
  have hp := Real.exp_pos (-q * t)
  constructor
  · linarith
  constructor <;> linarith

theorem response_abs_linear (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |response N t| ≤ sizeBudget N * t := by
  unfold response sizeBudget
  calc
    |∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      (1 - Real.exp (-(N / n : ℕ) * t))| ≤
        ∑ n ∈ Icc 1 N, |(ArithmeticFunction.moebius n : ℝ) *
          (1 - Real.exp (-(N / n : ℕ) * t))| := abs_sum_le_sum_abs _ _
    _ ≤ ∑ n ∈ Icc 1 N,
        (|(ArithmeticFunction.moebius n : ℝ)| * (1 + (N / n : ℕ))) * t := by
      apply sum_le_sum
      intro n _
      have h := exponential_increment_bounds ((N / n : ℕ) : ℝ) t (by positivity) ht
      rw [abs_mul, abs_of_nonneg h.1]
      have hq : (0 : ℝ) ≤ (N / n : ℕ) := by positivity
      have hm := mul_le_mul_of_nonneg_left h.2.2
        (abs_nonneg (ArithmeticFunction.moebius n : ℝ))
      nlinarith [abs_nonneg (ArithmeticFunction.moebius n : ℝ)]
    _ = _ := by rw [sum_mul]

theorem response_abs_bounded (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |response N t| ≤ sizeBudget N := by
  unfold response sizeBudget
  apply (abs_sum_le_sum_abs _ _).trans
  apply sum_le_sum
  intro n _
  have h := exponential_increment_bounds ((N / n : ℕ) : ℝ) t (by positivity) ht
  rw [abs_mul, abs_of_nonneg h.1]
  have hq : (0 : ℝ) ≤ (N / n : ℕ) := by positivity
  have hm := mul_le_mul_of_nonneg_left h.2.1
    (abs_nonneg (ArithmeticFunction.moebius n : ℝ))
  nlinarith [abs_nonneg (ArithmeticFunction.moebius n : ℝ)]

theorem weight_le_inverse_square (u : ℝ) (hu : 0 < u) : weight u ≤ 1 / u ^ 2 := by
  have he : 0 < Real.exp u - 1 := sub_pos.mpr (Real.one_lt_exp_iff.mpr hu)
  unfold weight
  have hn : 0 ≤ 1 / (u * (Real.exp u - 1)) := by positivity
  linarith

theorem energyRow_majorant (N : ℕ) (u : ℝ) (hu : 0 < u) :
    energyRow N u ≤ 2 * sizeBudget N ^ 2 * (1 + u ^ 2)⁻¹ := by
  have hK := sizeBudget_nonneg N
  have hu0 : u ≠ 0 := ne_of_gt hu
  have hu2 : 0 < u ^ 2 := sq_pos_of_pos hu
  have hden : 0 < 1 + u ^ 2 := by positivity
  have hw := weight_le_inverse_square u hu
  have hbase : energyRow N u ≤ response N u ^ 2 / u ^ 2 := by
    unfold energyRow
    simpa only [mul_one_div] using mul_le_mul_of_nonneg_left hw (sq_nonneg (response N u))
  rw [← div_eq_mul_inv]
  by_cases hs : u ≤ 1
  · have hr := response_abs_linear N u hu.le
    have hr2 : response N u ^ 2 ≤ (sizeBudget N * u) ^ 2 := by
      simpa only [sq_abs] using pow_le_pow_left₀ (abs_nonneg (response N u)) hr 2
    have hfirst : energyRow N u ≤ sizeBudget N ^ 2 := by
      calc
        energyRow N u ≤ response N u ^ 2 / u ^ 2 := hbase
        _ ≤ (sizeBudget N * u) ^ 2 / u ^ 2 := div_le_div_of_nonneg_right hr2 hu2.le
        _ = sizeBudget N ^ 2 := by field_simp
    apply hfirst.trans
    apply (le_div_iff₀ hden).mpr
    have hs2 : u ^ 2 ≤ 1 := by nlinarith
    have hp := mul_le_mul_of_nonneg_left hs2 (sq_nonneg (sizeBudget N))
    nlinarith
  · have hr := response_abs_bounded N u hu.le
    have hr2 : response N u ^ 2 ≤ sizeBudget N ^ 2 := by
      simpa only [sq_abs] using pow_le_pow_left₀ (abs_nonneg (response N u)) hr 2
    calc
      energyRow N u ≤ response N u ^ 2 / u ^ 2 := hbase
      _ ≤ sizeBudget N ^ 2 / u ^ 2 := div_le_div_of_nonneg_right hr2 hu2.le
      _ ≤ 2 * sizeBudget N ^ 2 / (1 + u ^ 2) := by
        apply (div_le_div_iff₀ hu2 hden).mpr
        have hlarge : 1 ≤ u := by linarith
        have hs2 : 1 ≤ u ^ 2 := by nlinarith
        have hp := mul_le_mul_of_nonneg_left hs2 (sq_nonneg (sizeBudget N))
        nlinarith

theorem energyRow_integrable (N : ℕ) : IntegrableOn (energyRow N) (Ioi 0) := by
  have hc : ContinuousOn (energyRow N) (Ioi 0) := by
    intro u hu
    exact (((response_continuous N).continuousAt.pow 2).mul
      (weight_continuousAt u hu)).continuousWithinAt
  have hi : Integrable (fun u : ℝ => 2 * sizeBudget N ^ 2 * (1 + u ^ 2)⁻¹) :=
    integrable_inv_one_add_sq.const_mul _
  apply hi.integrableOn.mono' (hc.aestronglyMeasurable measurableSet_Ioi)
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with u hu
  rw [Real.norm_eq_abs, abs_of_nonneg (energyRow_nonneg N u hu)]
  exact energyRow_majorant N u hu

theorem densityRow_le_energy (N : ℕ) (u : ℝ) (hu : 0 < u) :
    densityRow N u ≤ 2 * energyRow N u := by
  have hs := weight_scale u hu
  have hp := weight_pos (u / 2) (by positivity : 0 < u / 2)
  have hD : density u ≤ 2 * weight u := by linarith
  unfold densityRow energyRow
  have h := mul_le_mul_of_nonneg_left hD (sq_nonneg (response N u))
  nlinarith

theorem densityRow_integrable (N : ℕ) : IntegrableOn (densityRow N) (Ioi 0) := by
  have hc : ContinuousOn (densityRow N) (Ioi 0) := by
    intro u hu
    exact (((response_continuous N).continuousAt.pow 2).mul
      (density_continuousAt u hu)).continuousWithinAt
  apply ((energyRow_integrable N).const_mul 2).mono'
    (hc.aestronglyMeasurable measurableSet_Ioi)
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with u hu
  rw [Real.norm_eq_abs, abs_of_nonneg (densityRow_nonneg N u hu)]
  exact densityRow_le_energy N u hu

theorem scaled_energyRow_integrable (N : ℕ) :
    IntegrableOn (fun u => energyRow N (u / 2) / 2) (Ioi 0) := by
  have hi : IntegrableOn (fun u => energyRow N ((1 / 2 : ℝ) * u)) (Ioi 0) :=
    (integrableOn_Ioi_comp_mul_left_iff (energyRow N) 0 (by norm_num : (0 : ℝ) < 1 / 2)).mpr
      (by simpa using energyRow_integrable N)
  have hi' : Integrable (fun u => energyRow N ((1 / 2 : ℝ) * u))
      (volume.restrict (Ioi 0)) := hi
  have he : (fun u : ℝ => energyRow N ((1 / 2 : ℝ) * u) / 2) =
      (fun u : ℝ => energyRow N (u / 2) / 2) := by
    funext u
    rw [show (1 / 2 : ℝ) * u = u / 2 by ring]
  change Integrable (fun u => energyRow N (u / 2) / 2) (volume.restrict (Ioi 0))
  rw [← he]
  exact hi'.div_const 2

theorem workRow_integrable (N b : ℕ) (hb : b ≤ 1) :
    IntegrableOn (workRow N b) (Ioi 0) := by
  have hi := ((scaled_energyRow_integrable (2 * N + b)).sub
    ((energyRow_integrable N).const_mul 2)).add (densityRow_integrable N)
  apply hi.congr
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with u hu
  have h := binary_energy_row N b hb u hu
  change energyRow (2 * N + b) (u / 2) / 2 - 2 * energyRow N u + densityRow N u = _
  linarith

noncomputable def integratedEnergy (N : ℕ) : ℝ := ∫ u in Ioi 0, energyRow N u
noncomputable def integratedDensity (N : ℕ) : ℝ := ∫ u in Ioi 0, densityRow N u
noncomputable def integratedWork (N b : ℕ) : ℝ := ∫ u in Ioi 0, workRow N b u

theorem scaled_energy_integral (N : ℕ) :
    (∫ u in Ioi 0, energyRow N (u / 2) / 2) = integratedEnergy N := by
  have h := integral_comp_mul_left_Ioi (energyRow N) 0
    (by norm_num : (0 : ℝ) < 1 / 2)
  have he : (fun u : ℝ => energyRow N (u / 2)) =
      (fun u : ℝ => energyRow N ((1 / 2 : ℝ) * u)) := by
    ext u
    congr 1
    ring
  rw [integral_div, he, h]
  unfold integratedEnergy
  norm_num

theorem binary_energy_infinite (N b : ℕ) (hb : b ≤ 1) :
    integratedEnergy (2 * N + b) - 2 * integratedEnergy N =
      integratedWork N b - integratedDensity N := by
  have he := energyRow_integrable N
  have hd := densityRow_integrable N
  have hw := workRow_integrable N b hb
  have hrow : (∫ u in Ioi 0, energyRow (2 * N + b) (u / 2) / 2) =
      ∫ u in Ioi 0, 2 * energyRow N u - densityRow N u + workRow N b u := by
    apply integral_congr_ae
    filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with u hu
    exact binary_energy_row N b hb u hu
  have hsum := integral_add ((he.const_mul 2).sub hd) hw
  have hsub := integral_sub (he.const_mul 2) hd
  simp only [Pi.sub_apply] at hsum hsub
  rw [hsub, integral_const_mul] at hsum
  rw [scaled_energy_integral, hsum] at hrow
  unfold integratedEnergy integratedDensity integratedWork
  unfold integratedEnergy at hrow
  linarith

theorem integratedWork_original_clock (N b : ℕ) :
    integratedWork N b = ∫ t in Ioi 0,
      (2 * response N (2 * t) * innovation N b t + innovation N b t ^ 2) * weight t := by
  have h := integral_comp_mul_left_Ioi (workRow N b) 0 (by norm_num : (0 : ℝ) < 2)
  norm_num at h
  have he : integratedWork N b = 2 * ∫ t in Ioi 0, workRow N b (2 * t) := by
    unfold integratedWork
    linarith
  rw [he, ← integral_const_mul]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun t => by
    change 2 * workRow N b (2 * t) =
      (2 * response N (2 * t) * innovation N b t + innovation N b t ^ 2) * weight t
    unfold workRow
    rw [show 2 * t / 2 = t by ring]
    ring)

#print axioms sizeBudget_nonneg
#print axioms exponential_increment_bounds
#print axioms response_abs_linear
#print axioms response_abs_bounded
#print axioms weight_le_inverse_square
#print axioms energyRow_majorant
#print axioms energyRow_integrable
#print axioms densityRow_le_energy
#print axioms densityRow_integrable
#print axioms scaled_energyRow_integrable
#print axioms workRow_integrable
#print axioms scaled_energy_integral
#print axioms binary_energy_infinite
#print axioms integratedWork_original_clock

end BuildingBlocks.FactorialBinaryIntegrability
