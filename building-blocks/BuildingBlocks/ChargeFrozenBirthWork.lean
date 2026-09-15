import BuildingBlocks.ChargeFrozenBirthMetric

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenBirthWork

open CoarsePrimitive

open ChargeFrozenSource ChargeFrozenMetric ChargeFrozenBirthMetric

theorem source_increment_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => causalSource N v * increment N v) (Ioi (0 : ℝ)) := by
  apply ((full_square_integrable hN).add (increment_square_integrable hN)).mono'
  · exact ((measurable_causalSource N).mul
      ((measurable_causalSource (N + 1)).sub (measurable_causalSource N))).aestronglyMeasurable
  · filter_upwards [] with v
    rw [Real.norm_eq_abs]
    change |causalSource N v * increment N v| ≤ (causalSource N v)^2 + (increment N v)^2
    apply abs_le.mpr
    constructor
    · nlinarith [sq_nonneg (causalSource N v + increment N v)]
    · nlinarith [sq_nonneg (causalSource N v - increment N v)]

theorem source_increment_ramp {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) (hv1 : v < Real.log ((N + 1 : ℕ) : ℝ)) :
    causalSource N v * increment N v =
      -(psi N - (N : ℝ)) * (1 - (N : ℝ) * Real.exp (-v)) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hMp : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N by omega))
  have hx : (N : ℝ) < Real.exp v := by simpa only [Real.exp_log hNp] using Real.exp_lt_exp.mpr hv
  have hx1 : Real.exp v < ((N + 1 : ℕ) : ℝ) := by simpa only [Real.exp_log hMp] using Real.exp_lt_exp.mpr hv1
  rw [causalSource_terminal hN hv, increment_ramp (lt_of_le_of_lt hlog hv) hx hx1]
  have hh : Real.exp (-v / 2) * Real.exp (-v / 2) = Real.exp (-v) := by
    rw [← Real.exp_add]; congr 1; ring
  have he : Real.exp v * Real.exp (-v) = 1 := by rw [← Real.exp_add]; simp
  calc
    _ = -(psi N - (N : ℝ)) * (Real.exp v - (N : ℝ)) *
      (Real.exp (-v / 2) * Real.exp (-v / 2)) := by ring
    _ = _ := by rw [hh, mul_assoc, sub_mul, he]

theorem source_increment_terminal {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log ((N + 1 : ℕ) : ℝ) < v) :
    causalSource N v * increment N v =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hMp : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
  have hab : Real.log (N : ℝ) < Real.log ((N + 1 : ℕ) : ℝ) := Real.log_lt_log hNp (by push_cast; linarith)
  have hlog : 0 ≤ Real.log ((N + 1 : ℕ) : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N + 1 by omega))
  have hx : ((N + 1 : ℕ) : ℝ) ≤ Real.exp v := by simpa only [Real.exp_log hMp] using (Real.exp_lt_exp.mpr hv).le
  rw [causalSource_terminal hN (hab.trans hv), increment_terminal (lt_of_le_of_lt hlog hv) hx]
  have hh : Real.exp (-v / 2) * Real.exp (-v / 2) = Real.exp (-v) := by
    rw [← Real.exp_add]; congr 1; ring
  calc
    _ = (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) - 1) *
      (Real.exp (-v / 2) * Real.exp (-v / 2)) := by ring
    _ = _ := by rw [hh]

theorem source_increment_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), causalSource N v * increment N v) =
      (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ))) := by
  let a := Real.log (N : ℝ)
  let b := Real.log ((N + 1 : ℕ) : ℝ)
  let E := psi N - (N : ℝ)
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hMp : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
  have ha : 0 ≤ a := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N by omega))
  have hab : a < b := Real.log_lt_log hNp (by push_cast; linarith)
  have hb : 0 ≤ b := ha.trans hab.le
  have hi := source_increment_integrable hN
  have hp : IntegrableOn (fun v => causalSource N v * increment N v) (Ioc 0 b) := hi.mono_set (fun _ h => h.1)
  have ht : IntegrableOn (fun v => causalSource N v * increment N v) (Ioi b) := hi.mono_set (fun _ h => lt_of_le_of_lt hb h)
  have hpa : IntegrableOn (fun v => causalSource N v * increment N v) (Ioc 0 a) := hi.mono_set (fun _ h => h.1)
  have hpr : IntegrableOn (fun v => causalSource N v * increment N v) (Ioc a b) := hi.mono_set (fun _ h => lt_of_le_of_lt ha h.1)
  have hu : Ioc (0 : ℝ) b ∪ Ioi b = Ioi (0 : ℝ) := by
    ext v
    simp only [mem_union, mem_Ioc, mem_Ioi]
    constructor
    · rintro (h | h) <;> linarith
    · intro h
      by_cases hh : v ≤ b
      · exact Or.inl ⟨h, hh⟩
      · exact Or.inr (lt_of_not_ge hh)
  have hd : Disjoint (Ioc (0 : ℝ) b) (Ioi b) := Set.disjoint_left.mpr (fun _ h k => not_lt_of_ge h.2 k)
  rw [← hu, setIntegral_union hd measurableSet_Ioi hp ht]
  have hd2 : Disjoint (Ioc (0 : ℝ) a) (Ioc a b) := Set.disjoint_left.mpr (fun _ h k => not_lt_of_ge h.2 k.1)
  rw [← Ioc_union_Ioc_eq_Ioc ha hab.le, setIntegral_union hd2 measurableSet_Ioc hpa hpr]
  have hz : (∫ v in Ioc (0 : ℝ) a, causalSource N v * increment N v) = 0 := by
    apply integral_eq_zero_of_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioc] with v hv
    have hx : Real.exp v ≤ (N : ℝ) := by simpa only [a, Real.exp_log hNp] using Real.exp_le_exp.mpr hv.2
    rw [increment_before hv.1 hx, mul_zero]
    rfl
  rw [hz, zero_add, integral_Ioc_eq_integral_Ioo]
  have hnexp : (∫ v in a..b, Real.exp (-v)) = Real.exp (-a) - Real.exp (-b) := by
    have hd (v : ℝ) : HasDerivAt (fun v : ℝ => -Real.exp (-v)) (Real.exp (-v)) v := by
      simpa using ((Real.hasDerivAt_exp (-v)).comp v (hasDerivAt_id v).neg).neg
    have hi : IntervalIntegrable (fun v : ℝ => Real.exp (-v)) volume a b :=
      (by fun_prop : Continuous (fun v : ℝ => Real.exp (-v))).intervalIntegrable _ _
    rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v) hi]
    ring
  have hr : (∫ v in Ioo a b, causalSource N v * increment N v) =
      -E * ((b - a) - (N : ℝ) * (Real.exp (-a) - Real.exp (-b))) := by
    have he : (∫ v in Ioo a b, causalSource N v * increment N v) =
        ∫ v in Ioo a b, -E * (1 - (N : ℝ) * Real.exp (-v)) := by
      apply integral_congr_ae
      filter_upwards [ae_restrict_mem measurableSet_Ioo] with v hv
      exact source_increment_ramp hN hv.1 hv.2
    rw [he, ← integral_Ioc_eq_integral_Ioo, ← intervalIntegral.integral_of_le hab.le,
      intervalIntegral.integral_const_mul]
    have hin : IntervalIntegrable (fun v : ℝ => (N : ℝ) * Real.exp (-v)) volume a b :=
      (by fun_prop : Continuous (fun v : ℝ => (N : ℝ) * Real.exp (-v))).intervalIntegrable _ _
    rw [intervalIntegral.integral_sub intervalIntegrable_const hin, intervalIntegral.integral_const,
      intervalIntegral.integral_const_mul, hnexp]
    simp
  have htt : (∫ v in Ioi b, causalSource N v * increment N v) =
      E * (ArithmeticFunction.vonMangoldt (N + 1) - 1) / ((N + 1 : ℕ) : ℝ) := by
    have he : (∫ v in Ioi b, causalSource N v * increment N v) =
        ∫ v in Ioi b, E * (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v) := by
      apply integral_congr_ae
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
      exact source_increment_terminal hN hv
    rw [he, integral_const_mul]
    have hex : (∫ v in Ioi b, Real.exp (-v)) = Real.exp (-b) := by
      simpa using integral_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) b
    rw [hex, Real.exp_neg, Real.exp_log hMp, div_eq_mul_inv]
  rw [hr, htt]
  have hlog : b - a = Real.log (1 + 1 / (N : ℝ)) := by
    rw [← Real.log_div hMp.ne' hNp.ne']
    congr 1
    push_cast
    field_simp
  rw [hlog]
  simp only [a, b, E, Real.exp_neg, Real.exp_log hNp, Real.exp_log hMp]
  push_cast
  field_simp
  ring

theorem full_square_integral_increment {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource (N + 1) v)^2) -
      (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
        2 * (psi N - (N : ℝ)) * (ArithmeticFunction.vonMangoldt (N + 1) /
          ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ))) +
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ) := by
  have h0 := full_square_integrable hN
  have hm : IntegrableOn (fun v => 2 * (causalSource N v * increment N v)) (Ioi (0 : ℝ)) :=
    (source_increment_integrable hN).const_mul 2
  have hb := increment_square_integrable hN
  have he : (∫ v in Ioi (0 : ℝ), (causalSource (N + 1) v)^2) =
      ∫ v in Ioi (0 : ℝ), ((causalSource N v)^2 + 2 * (causalSource N v * increment N v)) +
        (increment N v)^2 := by
    apply integral_congr_ae
    filter_upwards [] with v
    unfold increment
    ring
  have ha : IntegrableOn (fun v => (causalSource N v)^2 +
      2 * (causalSource N v * increment N v)) (Ioi (0 : ℝ)) := h0.add hm
  rw [he, integral_add ha hb, integral_add h0 hm, integral_const_mul,
    source_increment_integral hN, increment_square_integral_evaluated hN]
  ring

#print axioms source_increment_integrable
#print axioms source_increment_integral
#print axioms full_square_integral_increment

end BuildingBlocks.ChargeFrozenBirthWork
