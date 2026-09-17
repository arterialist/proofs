import BuildingBlocks.ChargeFrozenMetric

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenBirthMetric

open CoarsePrimitive

open ChargeFrozenSource ChargeFrozenMetric

noncomputable def increment (N : ℕ) (v : ℝ) : ℝ := causalSource (N + 1) v - causalSource N v

theorem increment_before {N : ℕ} {v : ℝ} (hv : 0 < v) (hx : Real.exp v ≤ (N : ℝ)) :
    increment N v = 0 := by
  have hx1 : Real.exp v ≤ ((N + 1 : ℕ) : ℝ) := by push_cast; linarith
  unfold increment
  rw [causalSource_of_nonnegative (N + 1) hv.le, causalSource_of_nonnegative N hv.le]
  unfold source
  rw [min_eq_left hx, min_eq_left hx1, sub_self]

theorem increment_ramp {N : ℕ} {v : ℝ} (hv : 0 < v)
    (hx : (N : ℝ) < Real.exp v) (hx1 : Real.exp v < ((N + 1 : ℕ) : ℝ)) :
    increment N v = -(Real.exp v - (N : ℝ)) * Real.exp (-v / 2) := by
  have hf : ⌊Real.exp v⌋₊ = N := by
    apply (Nat.floor_eq_iff (Real.exp_pos v).le).mpr
    constructor
    · exact hx.le
    · simpa only [Nat.cast_add, Nat.cast_one] using hx1
  unfold increment
  rw [causalSource_of_nonnegative (N + 1) hv.le, causalSource_of_nonnegative N hv.le]
  unfold source
  rw [min_eq_left hx1.le, min_eq_right hx.le, Nat.floor_natCast, hf]
  ring

/-- The terminal formula includes the atom endpoint exp(v)=N+1. -/
theorem increment_terminal {N : ℕ} {v : ℝ} (hv : 0 < v)
    (hx1 : ((N + 1 : ℕ) : ℝ) ≤ Real.exp v) :
    increment N v = (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v / 2) := by
  have hx : (N : ℝ) ≤ Real.exp v := by push_cast at hx1; linarith
  unfold increment
  rw [causalSource_of_nonnegative (N + 1) hv.le, causalSource_of_nonnegative N hv.le]
  unfold source
  rw [min_eq_right hx1, min_eq_right hx, Nat.floor_natCast, Nat.floor_natCast, psi_succ]
  push_cast
  ring

theorem increment_piecewise {N : ℕ} {v : ℝ} (hv : 0 < v) :
    increment N v = if Real.exp v ≤ (N : ℝ) then 0 else
      if Real.exp v < ((N + 1 : ℕ) : ℝ) then -(Real.exp v - (N : ℝ)) * Real.exp (-v / 2)
      else (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v / 2) := by
  split_ifs with h h1
  · exact increment_before hv h
  · exact increment_ramp hv (lt_of_not_ge h) h1
  · exact increment_terminal hv (le_of_not_gt h1)

theorem increment_square_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => (increment N v)^2) (Ioi (0 : ℝ)) := by
  have h1 := (full_square_integrable (show 2 ≤ N + 1 by omega)).const_mul (2 : ℝ)
  have h0 := (full_square_integrable hN).const_mul (2 : ℝ)
  apply (h1.add h0).mono'
  · exact (((measurable_causalSource (N + 1)).sub (measurable_causalSource N)).pow_const 2).aestronglyMeasurable
  · filter_upwards [] with v
    rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg (increment N v))]
    change (increment N v)^2 ≤ 2 * (causalSource (N + 1) v)^2 + 2 * (causalSource N v)^2
    unfold increment
    nlinarith [sq_nonneg (causalSource (N + 1) v + causalSource N v)]

theorem increment_square_integral_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (increment N v)^2) =
      (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
        (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ) := by
  let a := Real.log (N : ℝ)
  let b := Real.log ((N + 1 : ℕ) : ℝ)
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hMp : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
  have ha : 0 ≤ a := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N by omega))
  have hab : a < b := Real.log_lt_log hNp (by push_cast; linarith)
  have hb : 0 ≤ b := ha.trans hab.le
  have hi := increment_square_integrable hN
  have hp : IntegrableOn (fun v => (increment N v)^2) (Ioc 0 b) := hi.mono_set (fun _ h => h.1)
  have ht : IntegrableOn (fun v => (increment N v)^2) (Ioi b) := hi.mono_set (fun _ h => lt_of_le_of_lt hb h)
  have hpa : IntegrableOn (fun v => (increment N v)^2) (Ioc 0 a) := hi.mono_set (fun _ h => h.1)
  have hpr : IntegrableOn (fun v => (increment N v)^2) (Ioc a b) := hi.mono_set (fun _ h => lt_of_le_of_lt ha h.1)
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
  have hz : (∫ v in Ioc (0 : ℝ) a, (increment N v)^2) = 0 := by
    apply integral_eq_zero_of_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioc] with v hv
    have hx : Real.exp v ≤ (N : ℝ) := by simpa only [a, Real.exp_log hNp] using Real.exp_le_exp.mpr hv.2
    rw [increment_before hv.1 hx]
    norm_num
  rw [hz, zero_add, integral_Ioc_eq_integral_Ioo]
  have hr : (∫ v in Ioo a b, (increment N v)^2) =
      ∫ v in Ioo a b, (Real.exp v - (N : ℝ))^2 * Real.exp (-v) := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with v hv
    have hx : (N : ℝ) < Real.exp v := by simpa only [a, Real.exp_log hNp] using Real.exp_lt_exp.mpr hv.1
    have hx1 : Real.exp v < ((N + 1 : ℕ) : ℝ) := by simpa only [b, Real.exp_log hMp] using Real.exp_lt_exp.mpr hv.2
    rw [increment_ramp (lt_of_le_of_lt ha hv.1) hx hx1, mul_pow, neg_sq, ← Real.exp_nat_mul]
    congr 2
    ring
  have htt : (∫ v in Ioi b, (increment N v)^2) =
      (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ) := by
    have he : (∫ v in Ioi b, (increment N v)^2) =
        ∫ v in Ioi b, (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 * Real.exp (-v) := by
      apply integral_congr_ae
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
      have hx : ((N + 1 : ℕ) : ℝ) ≤ Real.exp v := by
        simpa only [b, Real.exp_log hMp] using (Real.exp_lt_exp.mpr hv).le
      rw [increment_terminal (lt_of_le_of_lt hb hv) hx, mul_pow, ← Real.exp_nat_mul]
      congr 2
      ring
    rw [he, integral_const_mul]
    have hex : (∫ v in Ioi b, Real.exp (-v)) = Real.exp (-b) := by
      simpa using integral_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) b
    rw [hex, Real.exp_neg, Real.exp_log hMp, div_eq_mul_inv]
  rw [hr, htt]

theorem ramp_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
      (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) =
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) := by
  let a := Real.log (N : ℝ)
  let b := Real.log ((N + 1 : ℕ) : ℝ)
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hMp : (0 : ℝ) < ((N + 1 : ℕ) : ℝ) := by positivity
  have hab : a ≤ b := (Real.log_lt_log hNp (by push_cast; linarith)).le
  have he (v : ℝ) : (Real.exp v - (N : ℝ))^2 * Real.exp (-v) =
      Real.exp v - 2 * (N : ℝ) + (N : ℝ)^2 * Real.exp (-v) := by
    have hh : Real.exp v * Real.exp (-v) = 1 := by rw [← Real.exp_add]; simp
    calc
      _ = Real.exp v * (Real.exp v * Real.exp (-v)) -
        2 * (N : ℝ) * (Real.exp v * Real.exp (-v)) + (N : ℝ)^2 * Real.exp (-v) := by ring
      _ = _ := by rw [hh]; ring
  have hnexp : (∫ v in a..b, Real.exp (-v)) = Real.exp (-a) - Real.exp (-b) := by
    have hd (v : ℝ) : HasDerivAt (fun v : ℝ => -Real.exp (-v)) (Real.exp (-v)) v := by
      simpa using ((Real.hasDerivAt_exp (-v)).comp v (hasDerivAt_id v).neg).neg
    have hi : IntervalIntegrable (fun v : ℝ => Real.exp (-v)) volume a b := by
      exact (by fun_prop : Continuous (fun v : ℝ => Real.exp (-v))).intervalIntegrable _ _
    simp [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v) hi]
    ring
  rw [← integral_Ioc_eq_integral_Ioo, ← intervalIntegral.integral_of_le hab]
  simp_rw [he]
  have hi1 : IntervalIntegrable (fun v : ℝ => Real.exp v - 2 * (N : ℝ)) volume a b := by
    exact (by fun_prop : Continuous (fun v : ℝ => Real.exp v - 2 * (N : ℝ))).intervalIntegrable _ _
  have hi2 : IntervalIntegrable (fun v : ℝ => (N : ℝ)^2 * Real.exp (-v)) volume a b := by
    exact (by fun_prop : Continuous (fun v : ℝ => (N : ℝ)^2 * Real.exp (-v))).intervalIntegrable _ _
  rw [intervalIntegral.integral_add hi1 hi2,
    intervalIntegral.integral_sub (Real.continuous_exp.intervalIntegrable _ _) intervalIntegrable_const,
    integral_exp, intervalIntegral.integral_const, intervalIntegral.integral_const_mul, hnexp]
  simp only [smul_eq_mul]
  have hlog : b - a = Real.log (1 + 1 / (N : ℝ)) := by
    rw [← Real.log_div hMp.ne' hNp.ne']
    congr 1
    push_cast
    field_simp
  rw [hlog]
  simp only [a, b, Real.exp_neg, Real.exp_log hNp, Real.exp_log hMp]
  push_cast
  field_simp
  ring

theorem increment_square_integral_evaluated {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (increment N v)^2) =
      1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
        (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ) := by
  rw [increment_square_integral_split hN, ramp_square_integral hN]

#print axioms increment_piecewise
#print axioms increment_terminal
#print axioms increment_square_integrable
#print axioms increment_square_integral_split
#print axioms ramp_square_integral
#print axioms increment_square_integral_evaluated

end BuildingBlocks.ChargeFrozenBirthMetric
