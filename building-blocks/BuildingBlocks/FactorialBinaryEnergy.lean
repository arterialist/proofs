import BuildingBlocks.FactorialBinaryCarry

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks.FactorialBinaryEnergy
open FactorialBinaryCarry

noncomputable def weight (t : ℝ) : ℝ :=
  1 / t ^ 2 - 1 / (t * (Real.exp t - 1))

noncomputable def density (t : ℝ) : ℝ :=
  1 / (t * (Real.exp (t / 2) + 1))

theorem weight_scale (u : ℝ) (hu : 0 < u) :
    weight (u / 2) / 2 = 2 * weight u - density u := by
  have hu0 : u ≠ 0 := ne_of_gt hu
  have ha : Real.exp (u / 2) - 1 ≠ 0 :=
    sub_ne_zero.mpr (ne_of_gt (Real.one_lt_exp_iff.mpr (by positivity)))
  have hb : Real.exp u - 1 ≠ 0 :=
    sub_ne_zero.mpr (ne_of_gt (Real.one_lt_exp_iff.mpr hu))
  have hc : Real.exp (u / 2) + 1 ≠ 0 := by positivity
  have he : Real.exp u = Real.exp (u / 2) ^ 2 := by
    rw [pow_two, ← Real.exp_add, show u / 2 + u / 2 = u by ring]
  unfold weight density
  field_simp
  rw [he]
  ring

theorem density_pos (u : ℝ) (hu : 0 < u) : 0 < density u := by
  unfold density
  positivity

theorem weight_continuousAt (u : ℝ) (hu : 0 < u) : ContinuousAt weight u := by
  have hu0 : u ≠ 0 := ne_of_gt hu
  have hb : Real.exp u - 1 ≠ 0 :=
    sub_ne_zero.mpr (ne_of_gt (Real.one_lt_exp_iff.mpr hu))
  have hs : u ^ 2 ≠ 0 := pow_ne_zero _ hu0
  have hd : u * (Real.exp u - 1) ≠ 0 := mul_ne_zero hu0 hb
  unfold weight
  fun_prop (disch := aesop)

theorem density_continuousAt (u : ℝ) (hu : 0 < u) : ContinuousAt density u := by
  have hu0 : u ≠ 0 := ne_of_gt hu
  have hb : Real.exp (u / 2) + 1 ≠ 0 := by positivity
  have hd : u * (Real.exp (u / 2) + 1) ≠ 0 := mul_ne_zero hu0 hb
  have htwo : (2 : ℝ) ≠ 0 := by norm_num
  unfold density
  fun_prop (disch := aesop)

theorem response_continuous (N : ℕ) : Continuous (response N) := by
  unfold response
  fun_prop (disch := aesop)

noncomputable def energyRow (N : ℕ) (u : ℝ) : ℝ := response N u ^ 2 * weight u
noncomputable def densityRow (N : ℕ) (u : ℝ) : ℝ := response N u ^ 2 * density u
noncomputable def workRow (N b : ℕ) (u : ℝ) : ℝ :=
  (2 * response N u * innovation N b (u / 2) + innovation N b (u / 2) ^ 2) *
    weight (u / 2) / 2

theorem binary_energy_row (N b : ℕ) (hb : b ≤ 1) (u : ℝ) (hu : 0 < u) :
    energyRow (2 * N + b) (u / 2) / 2 =
      2 * energyRow N u - densityRow N u + workRow N b u := by
  have hr := response_binary N b hb (u / 2)
  rw [show 2 * (u / 2) = u by ring] at hr
  have hw := weight_scale u hu
  unfold energyRow densityRow workRow
  rw [hr]
  nlinarith

theorem densityRow_nonneg (N : ℕ) (u : ℝ) (hu : 0 < u) :
    0 ≤ densityRow N u := by
  unfold densityRow
  exact mul_nonneg (sq_nonneg _) (le_of_lt (density_pos u hu))

theorem innovation_continuous (N b : ℕ) : Continuous (innovation N b) := by
  unfold innovation
  fun_prop (disch := aesop)

theorem rows_intervalIntegrable (N b : ℕ) (a c : ℝ) (ha : 0 < a) (hac : a ≤ c) :
    IntervalIntegrable (energyRow N) volume a c ∧
    IntervalIntegrable (densityRow N) volume a c ∧
    IntervalIntegrable (workRow N b) volume a c := by
  have he : ContinuousOn (energyRow N) (Icc a c) := by
    intro u hu
    have hu0 : 0 < u := lt_of_lt_of_le ha hu.1
    exact (((response_continuous N).continuousAt.pow 2).mul
      (weight_continuousAt u hu0)).continuousWithinAt
  have hd : ContinuousOn (densityRow N) (Icc a c) := by
    intro u hu
    have hu0 : 0 < u := lt_of_lt_of_le ha hu.1
    exact (((response_continuous N).continuousAt.pow 2).mul
      (density_continuousAt u hu0)).continuousWithinAt
  have hw : ContinuousOn (workRow N b) (Icc a c) := by
    intro u hu
    have hu0 : 0 < u := lt_of_lt_of_le ha hu.1
    have hweight := weight_continuousAt (u / 2) (by positivity : 0 < u / 2)
    have hr := response_continuous N
    have hi := innovation_continuous N b
    have htwo : (2 : ℝ) ≠ 0 := by norm_num
    apply ContinuousAt.continuousWithinAt
    unfold workRow
    fun_prop (disch := aesop)
  rw [← uIcc_of_le hac] at he hd hw
  exact ⟨he.intervalIntegrable, hd.intervalIntegrable, hw.intervalIntegrable⟩

theorem binary_energy_interval (N b : ℕ) (hb : b ≤ 1)
    (a c : ℝ) (ha : 0 < a) (hac : a ≤ c) :
    (∫ u in a..c, energyRow (2 * N + b) (u / 2) / 2) =
      2 * (∫ u in a..c, energyRow N u) - (∫ u in a..c, densityRow N u) +
        (∫ u in a..c, workRow N b u) := by
  obtain ⟨he, hd, hw⟩ := rows_intervalIntegrable N b a c ha hac
  have hrow : ∀ u ∈ uIcc a c,
      energyRow (2 * N + b) (u / 2) / 2 =
        2 * energyRow N u - densityRow N u + workRow N b u := by
    intro u hu
    rw [uIcc_of_le hac] at hu
    exact binary_energy_row N b hb u (lt_of_lt_of_le ha hu.1)
  rw [intervalIntegral.integral_congr hrow,
    intervalIntegral.integral_add ((he.const_mul 2).sub hd) hw,
    intervalIntegral.integral_sub (he.const_mul 2) hd,
    intervalIntegral.integral_const_mul]

theorem weight_pos (u : ℝ) (hu : 0 < u) : 0 < weight u := by
  have hu0 : u ≠ 0 := ne_of_gt hu
  have hb : 0 < Real.exp u - 1 :=
    sub_pos.mpr (Real.one_lt_exp_iff.mpr hu)
  have hn : 0 < Real.exp u - 1 - u := by
    have he := Real.add_one_lt_exp hu0
    linarith
  have heq : weight u = (Real.exp u - 1 - u) / (u ^ 2 * (Real.exp u - 1)) := by
    unfold weight
    field_simp
  rw [heq]
  exact div_pos hn (mul_pos (sq_pos_of_pos hu) hb)

theorem energyRow_nonneg (N : ℕ) (u : ℝ) (hu : 0 < u) :
    0 ≤ energyRow N u := by
  unfold energyRow
  exact mul_nonneg (sq_nonneg _) (le_of_lt (weight_pos u hu))

#print axioms weight_scale
#print axioms density_pos
#print axioms weight_continuousAt
#print axioms density_continuousAt
#print axioms response_continuous
#print axioms binary_energy_row
#print axioms densityRow_nonneg
#print axioms innovation_continuous
#print axioms rows_intervalIntegrable
#print axioms binary_energy_interval
#print axioms weight_pos
#print axioms energyRow_nonneg

end BuildingBlocks.FactorialBinaryEnergy
