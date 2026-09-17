import BuildingBlocks.IntegerBirthHalfDensity

open MeasureTheory Set Filter
open scoped Topology BigOperators

namespace BuildingBlocks.IntegerBirthDifferenceL1

open IntegerBirthHalfDensity IntegerBirthSourceBound

noncomputable def lower (n j : ℕ) : ℝ := max 1 ((n : ℝ)-j-1)

private theorem lower_one (n j : ℕ) : 1 ≤ lower n j := le_max_left _ _
private theorem lower_pos (n j : ℕ) : 0 < lower n j := lt_of_lt_of_le (by norm_num) (lower_one n j)

noncomputable def stripMajorant (n j : ℕ) (x : ℝ) : ℝ :=
  (Icc (lower n j) (lower n j+1)).indicator (fun _ => 1/(2*(n : ℝ)*Real.sqrt (lower n j))) x

noncomputable def tailMajorant (n j : ℕ) (x : ℝ) : ℝ :=
  (Ici (lower n j)).indicator (fun x => halfDensity 0 x / lower n j) x

private theorem majorants_nonnegative {n j : ℕ} {x : ℝ} (hx : 0 < x) :
    0 ≤ stripMajorant n j x ∧ 0 ≤ tailMajorant n j x := by
  have ha := lower_pos n j
  constructor
  · unfold stripMajorant Set.indicator
    split_ifs <;> positivity
  · unfold tailMajorant Set.indicator
    split_ifs
    · unfold halfDensity
      positivity
    · exact le_rfl

/-- The common tail is negative, with no discarded absolute mass. -/
theorem common_tail_difference (j : ℕ) {x : ℝ} (hx : 0 < x) :
    halfDensity j x-halfDensity (j+1) x =
      1/(2*Real.sqrt x*(x+j)*(x+j+1)) := by
  have hs : Real.sqrt x ≠ 0 := (Real.sqrt_pos.mpr hx).ne'
  have hj : 0 ≤ (j : ℝ) := Nat.cast_nonneg j
  unfold halfDensity
  push_cast
  field_simp
  <;> ring

/-- Absolute strip-plus-tail majorant on the literal original integration domain. -/
theorem difference_norm_le {n j : ℕ} (hn : 2 ≤ n) {x : ℝ} (hx : 1 < x) :
    ‖birthDensity n (j+1) x-birthDensity n j x‖ ≤ stripMajorant n j x+tailMajorant n j x := by
  have hx0 : 0 < x := by linarith
  have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hj0 : 0 ≤ (j : ℝ) := Nat.cast_nonneg j
  have ha0 := lower_pos n j
  have hsx : 0 < Real.sqrt x := Real.sqrt_pos.mpr hx0
  have hsa : 0 < Real.sqrt (lower n j) := Real.sqrt_pos.mpr ha0
  have hnon := majorants_nonnegative (n := n) (j := j) hx0
  by_cases hold : (n : ℝ) ≤ x+j
  · have hnew : (n : ℝ) ≤ x+(j+1 : ℕ) := by push_cast; linarith
    have hax : lower n j ≤ x := max_le hx.le (by linarith)
    rw [birthDensity, if_pos hnew, birthDensity, if_pos hold, Real.norm_eq_abs,
      abs_sub_comm, abs_of_nonneg (by
        rw [common_tail_difference j hx0]
        positivity : 0 ≤ halfDensity j x-halfDensity (j+1) x), common_tail_difference j hx0]
    have htail : tailMajorant n j x=halfDensity 0 x/lower n j := by
      simp [tailMajorant, hax]
    rw [htail]
    apply le_add_of_nonneg_of_le hnon.1
    have hp : lower n j*x ≤ (x+j)*(x+j+1) := by nlinarith
    have he : halfDensity 0 x/lower n j = 1/(2*Real.sqrt x*(lower n j*x)) := by
      unfold halfDensity
      simp only [Nat.cast_zero, add_zero]
      ring
    rw [he, mul_assoc (2*Real.sqrt x)]
    exact one_div_le_one_div_of_le (by positivity)
      (mul_le_mul_of_nonneg_left hp (by positivity))
  · by_cases hnew : (n : ℝ) ≤ x+(j+1 : ℕ)
    · have hnew' : (n : ℝ) ≤ x+j+1 := by simpa only [Nat.cast_add, Nat.cast_one, ←add_assoc] using hnew
      have hax : lower n j ≤ x := max_le hx.le (by linarith)
      have hxa : x ≤ lower n j+1 := by
        have hh : (n:ℝ)-j-1 ≤ lower n j := le_max_right _ _
        linarith
      have hs : stripMajorant n j x=1/(2*(n:ℝ)*Real.sqrt (lower n j)) := by
        simp [stripMajorant, hax, hxa]
      rw [birthDensity, if_pos hnew, birthDensity, if_neg hold, sub_zero, Real.norm_eq_abs,
        abs_of_nonneg (by unfold halfDensity; positivity : 0 ≤ halfDensity (j+1) x), hs]
      apply le_add_of_le_of_nonneg _ hnon.2
      unfold halfDensity
      push_cast
      apply one_div_le_one_div_of_le (by positivity : 0 < 2*(n:ℝ)*Real.sqrt (lower n j))
      exact mul_le_mul (by nlinarith : 2*(n:ℝ) ≤ 2*(x+(j+1))) (Real.sqrt_le_sqrt hax)
        hsa.le (by positivity)
    · rw [birthDensity, if_neg hnew, birthDensity, if_neg hold, sub_self, norm_zero]
      exact add_nonneg hnon.1 hnon.2

private theorem strip_integrable (n j : ℕ) : IntegrableOn (stripMajorant n j) (Ioi 1) := by
  have hi : Integrable (stripMajorant n j) :=
    (integrableOn_const (s := Icc (lower n j) (lower n j+1)) (by simp)).integrable_indicator measurableSet_Icc
  exact hi.integrableOn

private theorem tail_integrable (n j : ℕ) : IntegrableOn (tailMajorant n j) (Ioi 1) := by
  exact ((halfDensity_integrable 0 (by norm_num : (0:ℝ)<1)).div_const (lower n j)).indicator measurableSet_Ici

private theorem strip_integral (n j : ℕ) :
    (∫ x in Ioi (1:ℝ), stripMajorant n j x) = 1/(2*(n:ℝ)*Real.sqrt (lower n j)) := by
  simp only [stripMajorant]
  rw [←integral_Ici_eq_integral_Ioi, setIntegral_indicator measurableSet_Icc]
  have hs : Ici (1:ℝ) ∩ Icc (lower n j) (lower n j+1) = Icc (lower n j) (lower n j+1) :=
    inter_eq_right.mpr (fun _ hx => (lower_one n j).trans hx.1)
  rw [hs, setIntegral_const]
  simp

private theorem tail_integral (n j : ℕ) :
    (∫ x in Ioi (1:ℝ), tailMajorant n j x) = 1/(lower n j*Real.sqrt (lower n j)) := by
  simp only [tailMajorant]
  rw [←integral_Ici_eq_integral_Ioi, setIntegral_indicator measurableSet_Ici,
    Ici_inter_Ici, max_eq_right (lower_one n j), integral_Ici_eq_integral_Ioi,
    integral_div, halfDensity_integral_zero (lower_pos n j)]
  ring

/-- The absolute successor difference is bounded by separately integrated positive strip and common tail. -/
theorem difference_integral_norm_le {n j : ℕ} (hn : 2 ≤ n) :
    (∫ x in Ioi (1:ℝ), ‖birthDensity n (j+1) x-birthDensity n j x‖) ≤
      2/(lower n j*Real.sqrt (lower n j)) := by
  have hi := ((birthDensity_integrable n (j+1)).sub (birthDensity_integrable n j)).norm
  have hm := (strip_integrable n j).add (tail_integrable n j)
  have hh := integral_mono_ae hi hm (by
    filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
    exact difference_norm_le hn hx)
  simp only [Pi.add_apply, Pi.sub_apply] at hh
  rw [integral_add (strip_integrable n j) (tail_integrable n j), strip_integral, tail_integral] at hh
  apply hh.trans
  have hn0 : 0 < (n:ℝ) := by exact_mod_cast (show 0<n by omega)
  have ha : lower n j ≤ n := max_le (by exact_mod_cast (show 1≤n by omega)) (by
    have := Nat.cast_nonneg (α := ℝ) j
    linarith)
  have hsa : 0 < Real.sqrt (lower n j) := Real.sqrt_pos.mpr (lower_pos n j)
  have hfirst : 1/(2*(n:ℝ)*Real.sqrt (lower n j)) ≤ 1/(lower n j*Real.sqrt (lower n j)) :=
    one_div_le_one_div_of_le (mul_pos (lower_pos n j) hsa)
      (mul_le_mul_of_nonneg_right (by linarith) hsa.le)
  calc
    _ ≤ 1/(lower n j*Real.sqrt (lower n j))+1/(lower n j*Real.sqrt (lower n j)) := add_le_add_right hfirst _
    _ = _ := by ring

/-- Uniform polynomial clock bound with the summable actual birth weight n^(-3/2). -/
theorem difference_integral_norm_birth_bound {n j : ℕ} (hn : 2 ≤ n) :
    (∫ x in Ioi (1:ℝ), ‖birthDensity n (j+1) x-birthDensity n j x‖) ≤
      2*((j:ℝ)+2)^2/((n:ℝ)*Real.sqrt n) := by
  apply (difference_integral_norm_le hn).trans
  have hn0 : 0 < (n:ℝ) := by exact_mod_cast (show 0<n by omega)
  have ha0 := lower_pos n j
  have hc : 1 ≤ (j:ℝ)+2 := by have := Nat.cast_nonneg (α := ℝ) j; linarith
  have hna : (n:ℝ) ≤ ((j:ℝ)+2)*lower n j := by
    have ha := lower_one n j
    have hb : (n:ℝ)-j-1 ≤ lower n j := le_max_right _ _
    nlinarith
  have hs : Real.sqrt (n:ℝ) ≤ ((j:ℝ)+2)*Real.sqrt (lower n j) := by
    apply (Real.sqrt_le_iff).mpr
    refine ⟨by positivity, ?_⟩
    rw [mul_pow, Real.sq_sqrt ha0.le]
    nlinarith
  have hp := mul_le_mul hna hs (Real.sqrt_nonneg (n:ℝ)) (by positivity : 0 ≤ ((j:ℝ)+2)*lower n j)
  have hden : 0 < (n:ℝ)*Real.sqrt n := mul_pos hn0 (Real.sqrt_pos.mpr hn0)
  apply (div_le_div_iff₀ (mul_pos ha0 (Real.sqrt_pos.mpr ha0)) hden).mpr
  nlinarith

/-- Full actual Lambda-weighted L1 summability; no conclusion is inferred from signed birth masses. -/
theorem mangoldt_difference_integral_norm_summable (j : ℕ) :
    Summable (fun n : ℕ => ∫ x in Ioi (1:ℝ),
      ‖ArithmeticFunction.vonMangoldt (n+2) *
        (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)‖) := by
  have hm := summable_birthWeight.mul_left (2*((j:ℝ)+2)^2)
  apply hm.of_nonneg_of_le (fun _ => integral_nonneg (fun _ => norm_nonneg _))
  intro n
  simp_rw [norm_mul, Real.norm_eq_abs,
    abs_of_nonneg (ArithmeticFunction.vonMangoldt_nonneg (n := n+2))]
  rw [integral_const_mul]
  have hh := mul_le_mul_of_nonneg_left (difference_integral_norm_birth_bound (n := n+2) (j := j) (by omega))
    (ArithmeticFunction.vonMangoldt_nonneg (n := n+2))
  convert hh using 1
  unfold birthWeight
  ring

/-- The complete weighted birth difference belongs to L1 before it is integrated termwise. -/
theorem weighted_difference_integrable (n j : ℕ) :
    IntegrableOn (fun x => ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) (Ioi 1) :=
  ((birthDensity_integrable (n+2) (j+1)).sub (birthDensity_integrable (n+2) j)).const_mul _

/-- The actual countable series of signed birth differences is integrable. -/
theorem all_birth_difference_integrable (j : ℕ) :
    IntegrableOn (fun x => ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) (Ioi 1) := by
  let μ : Measure ℝ := volume.restrict (Ioi (1:ℝ))
  let F : ℕ → ℝ → ℝ := fun n x => ArithmeticFunction.vonMangoldt (n+2) *
    (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)
  have hi (n : ℕ) : Integrable (F n) μ := weighted_difference_integrable n j
  have hm (n : ℕ) : AEMeasurable (fun x => ‖F n x‖ₑ) μ := (hi n).1.enorm
  have he (n : ℕ) : (∫⁻ x, ‖F n x‖ₑ ∂μ) = ‖∫ x, ‖F n x‖ ∂μ‖ₑ := by
    rw [← ofReal_integral_norm_eq_lintegral_enorm (hi n)]
    exact (Real.enorm_eq_ofReal (integral_nonneg (fun x => norm_nonneg (F n x)))).symm
  have hfin : (∑' n, ∫⁻ x, ‖F n x‖ₑ ∂μ) ≠ ⊤ := by
    rw [funext he]
    exact ENNReal.tsum_coe_ne_top_iff_summable.2 <| NNReal.summable_coe.1
      (mangoldt_difference_integral_norm_summable j).abs
  have hpoint : ∀ᵐ x ∂μ, Summable (fun n => (‖F n x‖₊ : ℝ)) := by
    have hh := hfin
    rw [←lintegral_tsum hm] at hh
    refine (ae_lt_top' (AEMeasurable.ennreal_tsum hm) hh).mono ?_
    intro x hx
    rw [←ENNReal.tsum_coe_ne_top_iff_summable_coe]
    exact hx.ne
  have hmeas : AEStronglyMeasurable (fun x => ∑' n, F n x) μ := by
    apply aestronglyMeasurable_of_tendsto_ae atTop
      (f := fun k x => ∑ n ∈ Finset.range k, F n x)
      (fun k => (Finset.range k).aestronglyMeasurable_fun_sum (fun n _ => (hi n).1))
    filter_upwards [hpoint] with x hx
    exact hx.of_norm.hasSum.tendsto_sum_nat
  refine ⟨hmeas, ?_⟩
  rw [hasFiniteIntegral_iff_enorm]
  apply lt_of_le_of_lt (lintegral_mono (fun x => enorm_tsum_le_tsum_enorm))
  rw [lintegral_tsum hm]
  exact lt_top_iff_ne_top.mpr hfin

/-- The literal half-density arithmetic series may be integrated before taking its signed birth masses. -/
theorem all_birth_difference_integral (j : ℕ) :
    (∫ x in Ioi (1:ℝ), ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) =
    ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (IntegerBirthDiscreteCorrection.discreteBirth (n+2) (j+1)-
        IntegerBirthDiscreteCorrection.discreteBirth (n+2) j) := by
  rw [←integral_tsum_of_summable_integral_norm (fun n => weighted_difference_integrable n j)
    (mangoldt_difference_integral_norm_summable j)]
  apply tsum_congr
  intro n
  rw [integral_const_mul, integral_sub (birthDensity_integrable (n+2) (j+1))
    (birthDensity_integrable (n+2) j), birthDensity_integral (by omega), birthDensity_integral (by omega)]

#print axioms difference_norm_le
#print axioms difference_integral_norm_birth_bound
#print axioms mangoldt_difference_integral_norm_summable
#print axioms all_birth_difference_integrable
#print axioms all_birth_difference_integral

end BuildingBlocks.IntegerBirthDifferenceL1
