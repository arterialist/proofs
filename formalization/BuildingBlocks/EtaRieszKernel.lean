import BuildingBlocks.RieszTentMellin

open MeasureTheory Set

namespace BuildingBlocks.EtaRieszKernel

/-- Convolving the atom at `a` with `δ₁ + dt` retains its linear birth term. -/
noncomputable def kernel (a x : ℝ) : ℂ :=
  if a < x then (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) else 0

theorem kernel_eq_zero {a x : ℝ} (hx : x ≤ a) : kernel a x = 0 := by
  simp [kernel, not_lt.mpr hx]

theorem kernel_eq_tent_add_square {a : ℝ} (ha : 0 < a) (x : ℝ) :
    kernel a x = RieszTentMellin.tent a x +
      (((max (x - a) 0) ^ 2 / (2 * a) : ℝ) : ℂ) := by
  by_cases hx : a < x
  · simp only [kernel, if_pos hx, RieszTentMellin.tent,
      max_eq_left (sub_nonneg.mpr hx.le)]
    have ha0 : (a : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr ha.ne'
    push_cast
    field_simp [ha0]
    ring
  · simp [kernel, hx, RieszTentMellin.tent,
      max_eq_right (sub_nonpos.mpr (le_of_not_gt hx))]

theorem kernel_power_eq {x : ℝ} (hx : 0 < x) (a : ℝ) (s : ℂ) :
    (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2) =
      (1 / (2 * (a : ℂ))) *
        ((x : ℂ) ^ (-s) - (a : ℂ) ^ 2 * (x : ℂ) ^ (-s - 2)) := by
  have hpow : (x : ℂ) ^ (-s) = (x : ℂ) ^ 2 * (x : ℂ) ^ (-s - 2) := by
    rw [show -s = 2 + (-s - 2) by ring,
      Complex.cpow_add _ _ (Complex.ofReal_ne_zero.mpr hx.ne')]
    norm_num
  rw [hpow]
  push_cast
  ring

theorem integrableOn_kernel_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
      (x : ℂ) ^ (-s - 2)) (Ioi a) := by
  have h1 := integrableOn_Ioi_cpow_of_lt (show (-s).re < -1 by simp; linarith) ha
  have h2 := integrableOn_Ioi_cpow_of_lt (show (-s - 2).re < -1 by simp; linarith) ha
  have hi : IntegrableOn (fun x : ℝ => (1 / (2 * (a : ℂ))) *
      ((x : ℂ) ^ (-s) - (a : ℂ) ^ 2 * (x : ℂ) ^ (-s - 2))) (Ioi a) :=
    (h1.sub (h2.const_mul ((a : ℂ) ^ 2))).const_mul (1 / (2 * (a : ℂ)))
  exact hi.congr_fun (fun x hx => (kernel_power_eq (ha.trans hx) a s).symm) measurableSet_Ioi

theorem integral_kernel_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi a, (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
      (x : ℂ) ^ (-s - 2)) = (a : ℂ) ^ (-s) / ((s - 1) * (s + 1)) := by
  have h1 : (-s).re < -1 := by simp; linarith
  have h2 : (-s - 2).re < -1 := by simp; linarith
  have ha0 : (a : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr ha.ne'
  have hs1 : s - 1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hs2 : s + 1 ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have heq : (∫ x : ℝ in Ioi a, (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
      (x : ℂ) ^ (-s - 2)) = (1 / (2 * (a : ℂ))) *
      ((∫ x : ℝ in Ioi a, (x : ℂ) ^ (-s)) -
        (a : ℂ) ^ 2 * (∫ x : ℝ in Ioi a, (x : ℂ) ^ (-s - 2))) := by
    rw [← integral_const_mul, ← integral_sub
      (integrableOn_Ioi_cpow_of_lt h1 ha)
      ((integrableOn_Ioi_cpow_of_lt h2 ha).const_mul ((a : ℂ) ^ 2)),
      ← integral_const_mul]
    exact setIntegral_congr_fun measurableSet_Ioi
      (fun x hx => kernel_power_eq (ha.trans hx) a s)
  rw [heq, integral_Ioi_cpow_of_lt h1 ha, integral_Ioi_cpow_of_lt h2 ha]
  have hplus : (a : ℂ) ^ (-s + 1) = (a : ℂ) * (a : ℂ) ^ (-s) := by
    rw [Complex.cpow_add _ _ ha0, Complex.cpow_one]
    ring
  have hminus : (a : ℂ) * (a : ℂ) ^ (-s - 1) = (a : ℂ) ^ (-s) := by
    nth_rw 1 [← Complex.cpow_one (a : ℂ)]
    rw [← Complex.cpow_add _ _ ha0]
    congr 1
    ring
  rw [show -s - 2 + 1 = -s - 1 by ring]
  have hfirst : -(a : ℂ) ^ (-s + 1) / (-s + 1) =
      (a : ℂ) ^ (-s + 1) / (s - 1) := by
    rw [show -s + 1 = -(s - 1) by ring, neg_div_neg_eq]
  have hsecond : -(a : ℂ) ^ (-s - 1) / (-s - 1) =
      (a : ℂ) ^ (-s - 1) / (s + 1) := by
    rw [show -s - 1 = -(s + 1) by ring, neg_div_neg_eq]
  rw [hfirst, hsecond, hplus, ← mul_div_assoc,
    show (a : ℂ) ^ 2 * (a : ℂ) ^ (-s - 1) =
      (a : ℂ) * (a : ℂ) ^ (-s) by rw [pow_two, mul_assoc, hminus]]
  field_simp
  ring

theorem mellin_integrand_kernel (a : ℝ) (s : ℂ) :
    (fun x : ℝ => (x : ℂ) ^ ((-s - 1) - 1) • kernel a x) =
      (Ioi a).indicator (fun x : ℝ =>
        (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2)) := by
  funext x
  rw [show (-s - 1) - 1 = -s - 2 by ring]
  by_cases hx : a < x <;> simp [kernel, hx, mul_comm]

/-- Exact Mellin transform of the full atom-plus-continuous eta kernel. -/
theorem hasMellin_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    HasMellin (kernel a) (-s - 1) ((a : ℂ) ^ (-s) / ((s - 1) * (s + 1))) := by
  have hi := integrableOn_kernel_power ha hs
  have hsubset : Ioi a ⊆ Ioi (0 : ℝ) := Ioi_subset_Ioi ha.le
  constructor
  · unfold MellinConvergent
    rw [mellin_integrand_kernel a s]
    have hglobal : Integrable ((Ioi a).indicator
        (fun x : ℝ => (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
          (x : ℂ) ^ (-s - 2))) :=
      (integrable_indicator_iff measurableSet_Ioi).2 hi
    exact hglobal.integrableOn
  · unfold mellin
    rw [mellin_integrand_kernel a s, setIntegral_indicator measurableSet_Ioi,
      inter_eq_right.mpr hsubset]
    exact integral_kernel_power ha hs

theorem norm_kernel_integrand {a x : ℝ} (ha : 0 < a) (hx : 0 < x) (s : ℂ) :
    ‖(x : ℂ) ^ (-s - 2) * kernel a x‖ =
      ((x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x).re := by
  have he : -(s.re : ℂ) - 2 = ((-s.re - 2 : ℝ) : ℂ) := by push_cast; rfl
  rw [he, ← Complex.ofReal_cpow hx.le]
  by_cases hax : a < x
  · have hp : 0 ≤ (x ^ 2 - a ^ 2) / (2 * a) :=
      div_nonneg (by nlinarith) (by positivity)
    rw [show kernel a x = (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) by
      simp only [kernel, if_pos hax]]
    rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos hx, Complex.norm_real,
      Real.norm_of_nonneg hp, ← Complex.ofReal_mul, Complex.ofReal_re]
    norm_num
  · simp [kernel, hax]

/-- The absolute Mellin integral has the same real-axis kernel and both endpoint factors. -/
theorem integral_norm_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * kernel a x‖) =
      a ^ (-s.re) / ((s.re - 1) * (s.re + 1)) := by
  have hr := hasMellin_kernel ha (show 1 < (s.re : ℂ).re from hs)
  have hi : IntegrableOn (fun x : ℝ =>
      (x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x) (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-(s.re : ℂ) - 1) - 1 = -(s.re : ℂ) - 2 by ring] using hr.1
  have heq : (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * kernel a x‖) =
      (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x).re := by
    have hre : (∫ x : ℝ in Ioi 0,
        ((x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x).re) =
        (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x).re :=
      integral_re hi
    exact (setIntegral_congr_fun measurableSet_Ioi
      (fun x hx => norm_kernel_integrand ha hx s)).trans hre
  have hval : (∫ x : ℝ in Ioi 0,
      (x : ℂ) ^ (-(s.re : ℂ) - 2) * kernel a x) =
      (a : ℂ) ^ (-(s.re : ℂ)) / (((s.re : ℂ) - 1) * ((s.re : ℂ) + 1)) := by
    convert hr.2 using 1
    unfold mellin
    congr 1
    funext x
    simp only [smul_eq_mul]
    congr 2
    ring
  rw [heq, hval]
  have hp : (a : ℂ) ^ (-(s.re : ℂ)) = ((a ^ (-s.re) : ℝ) : ℂ) := by
    rw [← Complex.ofReal_neg, ← Complex.ofReal_cpow ha.le]
  rw [hp]
  norm_cast

end BuildingBlocks.EtaRieszKernel
