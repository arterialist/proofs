import BuildingBlocks.PrimeSeedActivityTail

/-! Uniform event comparison for finite-activity jump laws. The comparison
retains the original positive convolution series, including its zero-jump term. -/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedProcess

instance jumpPower_isFiniteMeasure (μ : Measure ℝ) [IsFiniteMeasure μ] (n : ℕ) :
    IsFiniteMeasure (jumpPower μ n) := by
  induction n with
  | zero => change IsFiniteMeasure (Measure.dirac (0 : ℝ)); infer_instance
  | succ n ih =>
    letI := ih
    change IsFiniteMeasure (μ ∗ jumpPower μ n)
    infer_instance

theorem conv_mono_of_finite {μ ν ρ σ : Measure ℝ}
    [IsFiniteMeasure ρ] [IsFiniteMeasure σ] (hμ : μ ≤ ν) (hρ : ρ ≤ σ) :
    μ ∗ ρ ≤ ν ∗ σ := by
  apply Measure.map_mono ?_ (by fun_prop)
  apply Measure.le_iff.mpr
  intro A hA
  rw [Measure.prod_apply hA, Measure.prod_apply hA]
  exact lintegral_mono' hμ (fun x => hρ _)

theorem jumpPower_mono {μ ν : Measure ℝ} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (h : μ ≤ ν) (n : ℕ) : jumpPower μ n ≤ jumpPower ν n := by
  induction n with
  | zero => exact le_rfl
  | succ n ih => exact conv_mono_of_finite h ih

noncomputable def finiteJumpLaw (μ : Measure ℝ) [IsFiniteMeasure μ] (u : ℝ≥0) :
    Measure ℝ := poissonLaw (normalizedJump μ) (u * measureUnivNNReal μ)

instance finiteJumpLaw_isProbability (μ : Measure ℝ) [IsFiniteMeasure μ] (u : ℝ≥0) :
    IsProbabilityMeasure (finiteJumpLaw μ u) := by
  unfold finiteJumpLaw
  infer_instance

/-- Every history supported by the smaller jump measure survives in the larger
law with its exact extra zero-jump factor. -/
theorem finiteJumpLaw_domination {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) :
    ENNReal.ofReal (exp (-(u : ℝ) *
      ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ)))) •
        finiteJumpLaw μ u ≤ finiteJumpLaw ν u := by
  apply Measure.le_iff.mpr
  intro A hA
  simp only [finiteJumpLaw, poissonLaw_original_series, Measure.smul_apply,
    Measure.sum_apply _ hA, smul_eq_mul]
  rw [← ENNReal.tsum_mul_left]
  apply ENNReal.tsum_le_tsum
  intro n
  have he : exp (-(u : ℝ) * ((measureUnivNNReal ν : ℝ) -
      (measureUnivNNReal μ : ℝ))) * exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ)) =
      exp (-(u : ℝ) * (measureUnivNNReal ν : ℝ)) := by
    rw [← exp_add]
    congr 1
    ring
  have hw : ENNReal.ofReal (exp (-(u : ℝ) * ((measureUnivNNReal ν : ℝ) -
      (measureUnivNNReal μ : ℝ)))) * ENNReal.ofReal
      (exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ)) * (u : ℝ)^n / n.factorial) =
      ENNReal.ofReal (exp (-(u : ℝ) * (measureUnivNNReal ν : ℝ)) *
        (u : ℝ)^n / n.factorial) := by
    rw [← ENNReal.ofReal_mul (exp_pos _).le]
    congr 1
    rw [← mul_div_assoc, ← mul_assoc, he]
  rw [← mul_assoc, hw]
  exact mul_le_mul_left' (jumpPower_mono h n A) _

/-- A common positive subprobability gives a uniform event bound. -/
theorem probability_event_bound_of_domination {μ ν : Measure ℝ}
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] {c : ℝ}
    (hc : 0 ≤ c) (hc1 : c ≤ 1) (h : ENNReal.ofReal c • μ ≤ ν)
    {A : Set ℝ} (hA : MeasurableSet A) :
    |μ.real A - ν.real A| ≤ 1 - c := by
  have hd (B : Set ℝ) : c * μ.real B ≤ ν.real B := by
    have hh := ENNReal.toReal_mono (measure_ne_top ν B) (h B)
    simpa only [Measure.smul_apply, smul_eq_mul, ENNReal.toReal_mul,
      ENNReal.toReal_ofReal hc, Measure.real] using hh
  have hm := measureReal_add_measureReal_compl (μ := μ) hA
  have hn := measureReal_add_measureReal_compl (μ := ν) hA
  have hma := measureReal_nonneg (μ := μ) (s := A)
  have hmc := measureReal_nonneg (μ := μ) (s := Aᶜ)
  simp only [measureReal_univ_eq_one] at hm hn
  have ha := hd A
  have hb := hd Aᶜ
  apply abs_le.mpr
  constructor <;> nlinarith

/-- The probability error is controlled by the actual missing activity. -/
theorem finiteJumpLaw_event_bound {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) {A : Set ℝ}
    (hA : MeasurableSet A) :
    |(finiteJumpLaw μ u).real A - (finiteJumpLaw ν u).real A| ≤
      (u : ℝ) * ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ)) := by
  have hmass : (measureUnivNNReal μ : ℝ) ≤ (measureUnivNNReal ν : ℝ) := by
    exact ENNReal.toReal_mono (measure_ne_top ν Set.univ) (h Set.univ)
  have hx : 0 ≤ (u : ℝ) * ((measureUnivNNReal ν : ℝ) -
      (measureUnivNNReal μ : ℝ)) := mul_nonneg u.coe_nonneg (sub_nonneg.mpr hmass)
  have he := probability_event_bound_of_domination
    (μ := finiteJumpLaw μ u) (ν := finiteJumpLaw ν u)
    (c := exp (-(u : ℝ) * ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ))))
    (exp_pos _).le
    (exp_le_one_iff.mpr (by nlinarith)) (finiteJumpLaw_domination h u) hA
  apply he.trans
  have hh := add_one_le_exp (-(u : ℝ) * ((measureUnivNNReal ν : ℝ) -
      (measureUnivNNReal μ : ℝ)))
  nlinarith

end BuildingBlocks.PrimeSeedProcess
