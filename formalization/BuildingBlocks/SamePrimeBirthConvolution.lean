import BuildingBlocks.ReflectionFilter

open MeasureTheory Set
open scoped Interval ENNReal

namespace BuildingBlocks.SamePrimeBirthConvolution

open ReflectionFilter

noncomputable def birth (b v : ℝ) : ℝ :=
  (Ici b).indicator (fun v => Real.exp (-v / 2)) v

noncomputable def theta (v : ℝ) : ℝ :=
  (Ici 0).indicator (fun v => Real.exp (-v / 2) - Real.exp (-3 * v / 2)) v

noncomputable def ramp (d v : ℝ) : ℝ := Real.exp (-v / 2) * max (v - d) 0

private theorem interval_eq_Icc (g : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) :
    (∫ u in a..b, g u) = ∫ u in Icc a b, g u := by
  rw [intervalIntegral.integral_of_le hab, integral_Icc_eq_integral_Ioc]

theorem birth_intervalIntegrable (b a c : ℝ) : IntervalIntegrable (birth b) volume a c := by
  apply (intervalIntegrable_iff').mpr
  exact ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-v / 2))).integrableOn_Icc).indicator measurableSet_Ici

/-- The two full birth histories overlap on exactly one closed interval. -/
theorem birth_product (b c s : ℝ) :
    (fun u => birth b u * birth c (s - u)) =
      (Icc b (s - c)).indicator (fun _ => Real.exp (-s / 2)) := by
  funext u
  by_cases hb : b ≤ u <;> by_cases hc : c ≤ s - u
  · have hm : u ∈ Icc b (s - c) := ⟨hb, by linarith⟩
    simp only [birth, Set.indicator_of_mem (show u ∈ Ici b from hb), Set.indicator_of_mem (show s - u ∈ Ici c from hc),
      Set.indicator_of_mem hm]
    rw [← Real.exp_add]
    congr 1
    ring
  · have hm : u ∉ Icc b (s - c) := fun h => hc (by linarith [h.2])
    simp [birth, hb, hc, Set.indicator_of_notMem hm]
  · have hm : u ∉ Icc b (s - c) := fun h => hb h.1
    simp [birth, hb, hc, Set.indicator_of_notMem hm]
  · have hm : u ∉ Icc b (s - c) := fun h => hb h.1
    simp [birth, hb, hc, Set.indicator_of_notMem hm]

theorem birth_product_integrable (b c s : ℝ) :
    Integrable (fun u => birth b u * birth c (s - u)) := by
  rw [birth_product]
  exact (integrable_indicator_iff measurableSet_Icc).mpr (integrable_const _)

/-- The literal convolution keeps the exact common birth endpoint. -/
theorem birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    (∫ u in 0..s, birth b u * birth c (s - u)) = ramp (b + c) s := by
  rw [birth_product, interval_eq_Icc _ hs, integral_indicator measurableSet_Icc,
    Measure.restrict_restrict measurableSet_Icc]
  have hsub : Icc b (s - c) ⊆ Icc 0 s := by
    intro u hu
    exact ⟨hb.trans hu.1, hu.2.trans (sub_le_self s hc)⟩
  rw [Set.inter_eq_left.mpr hsub, setIntegral_const, Real.volume_real_Icc]
  change max (s - c - b) 0 * Real.exp (-s / 2) = Real.exp (-s / 2) * max (s - (b + c)) 0
  rw [show s - c - b = s - (b + c) by ring]
  ring

theorem ramp_continuous (d : ℝ) : Continuous (ramp d) := by unfold ramp; fun_prop

@[simp] theorem ramp_at_birth (d : ℝ) : ramp d d = 0 := by simp [ramp]
@[simp] theorem theta_zero : theta 0 = 0 := by simp [theta]

private theorem kernel_ramp_eq (s d v : ℝ) :
    Real.exp (-3 * (s - v) / 2) * ramp d v =
      Real.exp (-3 * s / 2 + v) * max (v - d) 0 := by
  unfold ramp
  rw [← mul_assoc, ← Real.exp_add]
  congr 2
  ring

private theorem integral_exp_ramp (s d : ℝ) :
    (∫ v in d..s, Real.exp (-3 * s / 2 + v) * (v - d)) =
      Real.exp (-s / 2) * (s - d - 1) + Real.exp (-3 * s / 2 + d) := by
  have hd (v : ℝ) : HasDerivAt
      (fun v => Real.exp (-3 * s / 2 + v) * (v - d - 1))
      (Real.exp (-3 * s / 2 + v) * (v - d)) v := by
    have ha := ((hasDerivAt_const v (-3 * s / 2)).add (hasDerivAt_id v)).exp
    have hb := ((hasDerivAt_id v).sub_const d).sub_const 1
    have hh := ha.mul hb
    change HasDerivAt (fun v => Real.exp (-3 * s / 2 + v) * (v - d - 1))
      (Real.exp (-3 * s / 2 + v) * (0 + 1) * (v - d - 1) +
        Real.exp (-3 * s / 2 + v) * 1) v at hh
    convert hh using 1 <;> ring
  have hi : IntervalIntegrable (fun v => Real.exp (-3 * s / 2 + v) * (v - d)) volume d s :=
    (by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * s / 2 + v) * (v - d))).intervalIntegrable _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v) hi]
  rw [show -3 * s / 2 + s = -s / 2 by ring]
  ring

/-- The literal L0 filter acts on a birth ramp without an inserted derivative. -/
theorem filtered_ramp {d s : ℝ} (hd : 0 ≤ d) (hs : 0 ≤ s) :
    L0 (ramp d) s = Real.exp (-d / 2) * theta (s - d) := by
  have hi (a b : ℝ) : IntervalIntegrable
      (fun v => Real.exp (-3 * s / 2 + v) * max (v - d) 0) volume a b :=
    (by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * s / 2 + v) * max (v - d) 0)).intervalIntegrable _ _
  unfold L0
  simp_rw [kernel_ramp_eq]
  by_cases hsd : s ≤ d
  · have hz : (∫ v in 0..s, Real.exp (-3 * s / 2 + v) * max (v - d) 0) = 0 := by
      rw [interval_eq_Icc _ hs]
      apply setIntegral_eq_zero_of_forall_eq_zero
      intro v hv
      simp [max_eq_right (show v - d ≤ 0 by linarith [hv.2])]
    rw [hz]
    by_cases heq : s = d
    · subst s; simp
    · have hlt : s - d < 0 := by exact sub_neg.mpr (lt_of_le_of_ne hsd heq)
      simp [ramp, theta, max_eq_right (sub_nonpos.mpr hsd), not_le.mpr hlt]
  · have hds : d ≤ s := le_of_not_ge hsd
    have hz : (∫ v in 0..d, Real.exp (-3 * s / 2 + v) * max (v - d) 0) = 0 := by
      rw [interval_eq_Icc _ hd]
      apply setIntegral_eq_zero_of_forall_eq_zero
      intro v hv
      simp [max_eq_right (sub_nonpos.mpr hv.2)]
    have hpart : (∫ v in d..s, Real.exp (-3 * s / 2 + v) * max (v - d) 0) =
        ∫ v in d..s, Real.exp (-3 * s / 2 + v) * (v - d) := by
      apply intervalIntegral.integral_congr
      intro v hv
      have hv' : v ∈ Icc d s := by simpa [uIcc_of_le hds] using hv
      dsimp only
      rw [max_eq_left (sub_nonneg.mpr hv'.1)]
    rw [← intervalIntegral.integral_add_adjacent_intervals (hi 0 d) (hi d s), hz,
      zero_add, hpart, integral_exp_ramp]
    simp only [ramp, max_eq_left (sub_nonneg.mpr hds), theta,
      Set.indicator_of_mem (show s - d ∈ Ici 0 from sub_nonneg.mpr hds)]
    simp only [mul_sub]
    rw [← Real.exp_add, ← Real.exp_add]
    rw [show -d / 2 + -(s - d) / 2 = -s / 2 by ring,
      show -d / 2 + (-3 * s - -3 * d) / 2 = -3 * s / 2 + d by ring]
    ring

/-- The outer filtered pair integral is a genuine integrable function. -/
theorem filtered_pair_integrable {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) *
      (∫ u in 0..v, birth b u * birth c (v - u))) volume 0 s := by
  have hi : IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * ramp (b + c) v) volume 0 s :=
    ((by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * (s - v) / 2))).mul
      (ramp_continuous (b + c))).intervalIntegrable _ _
  apply hi.congr
  intro v hv
  have hv' : v ∈ Ioc 0 s := by simpa [uIoc_of_le hs] using hv
  dsimp only
  rw [birth_convolution hb hc hv'.1.le]

/-- Exact normalized pair calibration at every nonnegative external age. -/
theorem filtered_birth_convolution {b c s : ℝ} (hb : 0 ≤ b) (hc : 0 ≤ c) (hs : 0 ≤ s) :
    L0 (fun v => ∫ u in 0..v, birth b u * birth c (v - u)) s =
      Real.exp (-(b + c) / 2) * theta (s - b - c) := by
  have heq : (∫ v in 0..s, Real.exp (-3 * (s - v) / 2) *
      (∫ u in 0..v, birth b u * birth c (v - u))) =
      ∫ v in 0..s, Real.exp (-3 * (s - v) / 2) * ramp (b + c) v := by
    apply intervalIntegral.integral_congr
    intro v hv
    have hv' : v ∈ Icc 0 s := by simpa [uIcc_of_le hs] using hv
    dsimp only
    rw [birth_convolution hb hc hv'.1]
  unfold L0
  dsimp only
  rw [heq, birth_convolution hb hc hs]
  change L0 (ramp (b + c)) s = _
  rw [filtered_ramp (add_nonneg hb hc) hs]
  congr 2
  ring

/-- Finite regrouping of all positive exponent pairs with prescribed total m.
The indices are exactly (j,m-j), 1 ≤ j ≤ m-1. -/
theorem filtered_pairs_by_total {ell s : ℝ} (hell : 0 ≤ ell) (hs : 0 ≤ s)
    {m : ℕ} (hm : 2 ≤ m) :
    (∑ j ∈ Finset.Icc 1 (m - 1),
      L0 (fun v => ∫ u in 0..v, birth ((j : ℝ) * ell) u *
        birth (((m - j : ℕ) : ℝ) * ell) (v - u)) s) =
      ((m - 1 : ℕ) : ℝ) * (Real.exp (-((m : ℝ) * ell) / 2) * theta (s - (m : ℝ) * ell)) := by
  have hterm (j : ℕ) (hj : j ∈ Finset.Icc 1 (m - 1)) :
      L0 (fun v => ∫ u in 0..v, birth ((j : ℝ) * ell) u *
        birth (((m - j : ℕ) : ℝ) * ell) (v - u)) s =
      Real.exp (-((m : ℝ) * ell) / 2) * theta (s - (m : ℝ) * ell) := by
    have hjm : j ≤ m := by have := (Finset.mem_Icc.mp hj).2; omega
    rw [filtered_birth_convolution (mul_nonneg (Nat.cast_nonneg _) hell)
      (mul_nonneg (Nat.cast_nonneg _) hell) hs, Nat.cast_sub hjm]
    congr 2 <;> ring
  rw [Finset.sum_congr rfl hterm]
  simp

#print axioms filtered_pairs_by_total
#print axioms birth_intervalIntegrable
#print axioms birth_product_integrable
#print axioms birth_convolution
#print axioms filtered_ramp
#print axioms filtered_birth_convolution

end BuildingBlocks.SamePrimeBirthConvolution
