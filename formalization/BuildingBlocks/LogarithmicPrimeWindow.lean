import BuildingBlocks.FinitePrimeSourceIntegration
import BuildingBlocks.ChargeFrozenSource
import BuildingBlocks.ChargeFrozenIntegrability
import BuildingBlocks.PhysicalScatteringCorrelation
import Mathlib.MeasureTheory.Function.JacobianOneDim
import Mathlib.MeasureTheory.Group.Integral
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace LogarithmicPrimeWindow

noncomputable def window (R : ℝ → ℝ) (s x : ℝ) : ℝ :=
  x ^ (-(1 : ℝ) / 2) * R (Real.log x - s)

noncomputable def sourceKernel (R D : ℝ → ℝ) (y : ℝ) : ℝ :=
  D y - R y / 2

noncomputable def windowDerivative (R D : ℝ → ℝ) (s x : ℝ) : ℝ :=
  x ^ (-(3 : ℝ) / 2) * sourceKernel R D (Real.log x - s)

/-- The exact derivative supplying the prime-error integration bridge. -/
theorem window_hasDerivAt {R D : ℝ → ℝ} {s x : ℝ} (hx : 0 < x)
    (hR : HasDerivAt R (D (Real.log x - s)) (Real.log x - s)) :
    HasDerivAt (window R s) (windowDerivative R D s x) x := by
  have hp := Real.hasDerivAt_rpow_const (x := x) (p := -(1 : ℝ) / 2)
    (Or.inl (ne_of_gt hx))
  have hl := (Real.hasDerivAt_log (ne_of_gt hx)).sub_const s
  have hr := hR.comp x hl
  have hm := hp.mul hr
  have he : (-(1 : ℝ) / 2) * x ^ (-(1 : ℝ) / 2 - 1) * R (Real.log x - s) +
      x ^ (-(1 : ℝ) / 2) * (D (Real.log x - s) * x⁻¹) =
      windowDerivative R D s x := by
    have hpow : x ^ (-(1 : ℝ) / 2) * x⁻¹ = x ^ (-(3 : ℝ) / 2) := by
      rw [← Real.rpow_neg_one, ← Real.rpow_add hx]
      congr 1
      norm_num
    have hexp : (-(1 : ℝ) / 2 - 1) = -(3 : ℝ) / 2 := by norm_num
    rw [hexp]
    unfold windowDerivative sourceKernel
    calc
      _ = -(1 : ℝ) / 2 * x ^ (-(3 : ℝ) / 2) * R (Real.log x - s) +
          (x ^ (-(1 : ℝ) / 2) * x⁻¹) * D (Real.log x - s) := by ring
      _ = _ := by rw [hpow]; ring
  change HasDerivAt (fun x => x ^ (-(1 : ℝ) / 2) * R (Real.log x - s)) _ x
  convert hm using 1
  exact he.symm

/-- The lower endpoint lies outside the original correlation support. -/
theorem window_one_eq_zero {R : ℝ → ℝ} {s d : ℝ}
    (hR : ∀ y, d ≤ |y| → R y = 0) (hs : d ≤ s) (hs0 : 0 ≤ s) :
    window R s 1 = 0 := by
  unfold window
  rw [Real.log_one, zero_sub, hR (-s) (by simpa [abs_of_nonneg hs0] using hs)]
  simp

/-- The terminal weight is zero once the cutoff covers the closed support. -/
theorem window_endpoint_eq_zero {R : ℝ → ℝ} {s d x : ℝ}
    (hR : ∀ y, d ≤ |y| → R y = 0) (hd : 0 ≤ d)
    (hx : s + d ≤ Real.log x) : window R s x = 0 := by
  have hy : d ≤ Real.log x - s := by linarith
  have hy0 : 0 ≤ Real.log x - s := le_trans hd hy
  unfold window
  rw [hR (Real.log x - s) (by simpa [abs_of_nonneg hy0] using hy), mul_zero]

theorem windowDerivative_continuousAt {R D : ℝ → ℝ} {s x : ℝ}
    (hR : Continuous R) (hD : Continuous D) (hx : 0 < x) :
    ContinuousAt (windowDerivative R D s) x := by
  have hk : Continuous (sourceKernel R D) := by
    unfold sourceKernel
    exact hD.sub (hR.div_const 2)
  unfold windowDerivative
  apply ContinuousAt.mul
  · exact continuousAt_id.rpow_const (Or.inl (ne_of_gt hx))
  · exact hk.continuousAt.comp
      ((Real.continuousAt_log (ne_of_gt hx)).sub continuousAt_const)

/-- The physical window derivative is integrable on every positive cutoff interval. -/
theorem windowDerivative_intervalIntegrable {R D : ℝ → ℝ} {s a b : ℝ}
    (hR : Continuous R) (hD : Continuous D) (ha : 0 < a) (hab : a ≤ b) :
    IntervalIntegrable (windowDerivative R D s) MeasureTheory.volume a b := by
  apply ContinuousOn.intervalIntegrable_of_Icc hab
  intro x hx
  exact (windowDerivative_continuousAt hR hD (lt_of_lt_of_le ha hx.1)).continuousWithinAt

noncomputable def positiveWindow (p : ℝ) (R : ℝ → ℝ) (s x : ℝ) : ℝ :=
  if 0 < x then x ^ p * R (Real.log x - s) else 0

/-- The support lies above one, so extension by zero creates no boundary charge. -/
theorem positiveWindow_zero_below_one {R : ℝ → ℝ} {p s d x : ℝ}
    (hR : ∀ y, d ≤ |y| → R y = 0) (hs : d ≤ s) (hx : x < 1) :
    positiveWindow p R s x = 0 := by
  unfold positiveWindow
  by_cases hx0 : 0 < x
  · rw [if_pos hx0]
    have hl : Real.log x < 0 := Real.log_neg hx0 hx
    have hy : d ≤ |Real.log x - s| :=
      le_trans (by linarith : d ≤ -(Real.log x - s)) (neg_le_abs _)
    rw [hR _ hy, mul_zero]
  · rw [if_neg hx0]

theorem positiveWindow_hasDerivAt {R D : ℝ → ℝ} {s d : ℝ}
    (hR : ∀ y, d ≤ |y| → R y = 0) (hs : d ≤ s)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (x : ℝ) :
    HasDerivAt (positiveWindow (-(1 : ℝ) / 2) R s)
      (positiveWindow (-(3 : ℝ) / 2) (sourceKernel R D) s x) x := by
  by_cases hx : 0 < x
  · have he : positiveWindow (-(1 : ℝ) / 2) R s =ᶠ[nhds x] window R s := by
      filter_upwards [eventually_gt_nhds hx] with y hy
      simp only [positiveWindow, hy, if_true, window]
    have hd := (window_hasDerivAt hx (hderiv _)).congr_of_eventuallyEq he
    simpa only [positiveWindow, hx, if_true, windowDerivative] using hd
  · have hx1 : x < 1 := by linarith
    have he : positiveWindow (-(1 : ℝ) / 2) R s =ᶠ[nhds x] (fun _ => 0) := by
      filter_upwards [eventually_lt_nhds hx1] with y hy
      exact positiveWindow_zero_below_one hR hs hy
    have hd := (hasDerivAt_const x (0 : ℝ)).congr_of_eventuallyEq he
    simpa only [positiveWindow, hx, if_false] using hd

theorem positiveWindow_continuous {R : ℝ → ℝ} {p s d : ℝ}
    (hR : Continuous R) (hRs : ∀ y, d ≤ |y| → R y = 0) (hs : d ≤ s) :
    Continuous (positiveWindow p R s) := by
  apply continuous_iff_continuousAt.mpr
  intro x
  by_cases hx : 0 < x
  · have hc : ContinuousAt (fun y => y ^ p * R (Real.log y - s)) x :=
      (continuousAt_id.rpow_const (Or.inl (ne_of_gt hx))).mul
        (hR.continuousAt.comp ((Real.continuousAt_log (ne_of_gt hx)).sub continuousAt_const))
    apply hc.congr_of_eventuallyEq
    filter_upwards [eventually_gt_nhds hx] with y hy
    simp only [positiveWindow, hy, if_true]
  · have hx1 : x < 1 := by linarith
    apply (continuousAt_const (y := (0 : ℝ))).congr_of_eventuallyEq
    filter_upwards [eventually_lt_nhds hx1] with y hy
    exact positiveWindow_zero_below_one hRs hs hy

/-- Specialization of the published original-source identity to the actual log window. -/
theorem positiveWindow_original_source {R D : ℝ → ℝ} {s d : ℝ} {N : ℕ}
    (hN : 1 ≤ N) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      positiveWindow (-(1 : ℝ) / 2) R s n) -
        (∫ x in (1 : ℝ)..(N : ℝ), positiveWindow (-(1 : ℝ) / 2) R s x) =
      -(∫ x in (1 : ℝ)..(N : ℝ), BuildingBlocks.CoarsePrimitive.primeErrorReal x *
        positiveWindow (-(3 : ℝ) / 2) (sourceKernel R D) s x) := by
  have hk : Continuous (sourceKernel R D) := by
    unfold sourceKernel
    exact hD.sub (hR.div_const 2)
  have hks : ∀ y, d ≤ |y| → sourceKernel R D y = 0 := by
    intro y hy
    simp only [sourceKernel, hRs y hy, hDs y hy, zero_div, sub_self]
  have hF1 : positiveWindow (-(1 : ℝ) / 2) R s 1 = 0 := by
    simpa only [positiveWindow, show (0 : ℝ) < 1 by norm_num, if_true, window] using
      window_one_eq_zero hRs hs (le_trans hd hs)
  have hNpos : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hFN : positiveWindow (-(1 : ℝ) / 2) R s N = 0 := by
    simpa only [positiveWindow, hNpos, if_true, window] using
      window_endpoint_eq_zero hRs hd hcut
  exact FinitePrimeSourceIntegration.original_prime_error_integration
    hN (positiveWindow_continuous hk hks hs)
    (positiveWindow_hasDerivAt hRs hs hderiv) hF1 hFN

/-- On the positive integration interval, the readout is the literal unextended window. -/
theorem window_original_source {R D : ℝ → ℝ} {s d : ℝ} {N : ℕ}
    (hN : 1 ≤ N) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        (∫ x in (1 : ℝ)..(N : ℝ), window R s x) =
      -(∫ x in (1 : ℝ)..(N : ℝ), BuildingBlocks.CoarsePrimitive.primeErrorReal x *
        windowDerivative R D s x) := by
  have h := positiveWindow_original_source hN hd hs hR hD hRs hDs hderiv hcut
  have hsum : (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      positiveWindow (-(1 : ℝ) / 2) R s n) =
      ∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n := by
    apply Finset.sum_congr rfl
    intro n hn
    have hn0 : (0 : ℝ) < n := by
      exact_mod_cast (show 0 < n by have := (Finset.mem_Icc.mp hn).1; omega)
    simp only [positiveWindow, hn0, if_true, window]
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hfi : (∫ x in (1 : ℝ)..(N : ℝ), positiveWindow (-(1 : ℝ) / 2) R s x) =
      ∫ x in (1 : ℝ)..(N : ℝ), window R s x := by
    apply intervalIntegral.integral_congr
    intro x hx
    rw [Set.uIcc_of_le hNR] at hx
    have hx0 : 0 < x := lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) hx.1
    simp only [positiveWindow, hx0, if_true, window]
  have hdi : (∫ x in (1 : ℝ)..(N : ℝ), BuildingBlocks.CoarsePrimitive.primeErrorReal x *
      positiveWindow (-(3 : ℝ) / 2) (sourceKernel R D) s x) =
      ∫ x in (1 : ℝ)..(N : ℝ), BuildingBlocks.CoarsePrimitive.primeErrorReal x *
        windowDerivative R D s x := by
    apply intervalIntegral.integral_congr
    intro x hx
    rw [Set.uIcc_of_le hNR] at hx
    have hx0 : 0 < x := lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) hx.1
    simp only [positiveWindow, hx0, if_true, windowDerivative]
  rw [hsum, hfi, hdi] at h
  exact h

/-- Exponentiation takes the exact half-open integration interval to its positive image. -/
theorem exp_image_Ioc (b : ℝ) :
    Real.exp '' Set.Ioc 0 b = Set.Ioc 1 (Real.exp b) := by
  ext x
  constructor
  · rintro ⟨v, hv, rfl⟩
    constructor
    · simpa only [Real.exp_zero] using Real.exp_lt_exp.mpr hv.1
    · exact Real.exp_le_exp.mpr hv.2
  · intro hx
    have hx0 : 0 < x := lt_trans (by norm_num : (0 : ℝ) < 1) hx.1
    refine ⟨Real.log x, ⟨Real.log_pos hx.1, ?_⟩, Real.exp_log hx0⟩
    apply Real.exp_le_exp.mp
    simpa only [Real.exp_log hx0] using hx.2

/-- Change of variables for arbitrary integrands, so step-function sources are allowed. -/
theorem exp_interval_substitution {b : ℝ} (hb : 0 ≤ b) (g : ℝ → ℝ) :
    (∫ x in (1 : ℝ)..Real.exp b, g x) =
      ∫ v in (0 : ℝ)..b, Real.exp v * g (Real.exp v) := by
  have h := MeasureTheory.integral_image_eq_integral_abs_deriv_smul
    (s := Set.Ioc (0 : ℝ) b) (f := Real.exp) (f' := Real.exp) measurableSet_Ioc
    (fun x _ => (Real.hasDerivAt_exp x).hasDerivWithinAt)
    Real.exp_injective.injOn g
  rw [exp_image_Ioc] at h
  have heb : (1 : ℝ) ≤ Real.exp b := by
    simpa only [Real.exp_zero] using Real.exp_le_exp.mpr hb
  rw [intervalIntegral.integral_of_le heb, intervalIntegral.integral_of_le hb]
  simpa only [abs_of_nonneg (Real.exp_nonneg _), smul_eq_mul] using h

noncomputable def logarithmicSource (v : ℝ) : ℝ :=
  Real.exp (-v / 2) * BuildingBlocks.CoarsePrimitive.primeErrorReal (Real.exp v)

/-- The square-root normalization and the Jacobian combine to the original log source. -/
theorem exp_source_readout {R D : ℝ → ℝ} {s : ℝ} {N : ℕ} (hN : 1 ≤ N) :
    (∫ x in (1 : ℝ)..(N : ℝ), BuildingBlocks.CoarsePrimitive.primeErrorReal x *
        windowDerivative R D s x) =
      ∫ v in (0 : ℝ)..Real.log N, logarithmicSource v * sourceKernel R D (v - s) := by
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le (by norm_num) hNR
  have h := exp_interval_substitution (Real.log_nonneg hNR)
    (fun x => BuildingBlocks.CoarsePrimitive.primeErrorReal x * windowDerivative R D s x)
  rw [Real.exp_log hNp] at h
  rw [h]
  apply intervalIntegral.integral_congr
  intro v _
  have hp : Real.exp v * (Real.exp v) ^ (-(3 : ℝ) / 2) = Real.exp (-v / 2) := by
    rw [Real.rpow_def_of_pos (Real.exp_pos v), Real.log_exp, ← Real.exp_add]
    congr 1
    ring
  change Real.exp v * (BuildingBlocks.CoarsePrimitive.primeErrorReal (Real.exp v) *
      ((Real.exp v) ^ (-(3 : ℝ) / 2) * sourceKernel R D (Real.log (Real.exp v) - s))) = _
  rw [Real.log_exp]
  unfold logarithmicSource
  calc
    _ = (Real.exp v * (Real.exp v) ^ (-(3 : ℝ) / 2)) *
      BuildingBlocks.CoarsePrimitive.primeErrorReal (Real.exp v) * sourceKernel R D (v - s) := by ring
    _ = _ := by rw [hp]

theorem frozenSource_eq_logarithmic {C : ℕ} {v : ℝ}
    (hv : 0 ≤ v) (hC : Real.exp v ≤ C) :
    BuildingBlocks.ChargeFrozenSource.causalSource C v = logarithmicSource v := by
  rw [BuildingBlocks.ChargeFrozenSource.causalSource_of_nonnegative C hv]
  unfold BuildingBlocks.ChargeFrozenSource.source logarithmicSource
    BuildingBlocks.CoarsePrimitive.primeErrorReal
  rw [min_eq_left hC]

/-- Every window uses the original frozen causal source on its covered interval. -/
theorem window_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        (∫ x in (1 : ℝ)..(N : ℝ), window R s x) =
      -(∫ v in (0 : ℝ)..Real.log N, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel R D (v - s)) := by
  rw [window_original_source hN hd hs hR hD hRs hDs hderiv hcut, exp_source_readout hN]
  congr 1
  apply intervalIntegral.integral_congr
  intro v hv
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [Set.uIcc_of_le (Real.log_nonneg hNR)] at hv
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le (by norm_num) hNR
  have heN : Real.exp v ≤ N := by
    simpa only [Real.exp_log hNp] using Real.exp_le_exp.mpr hv.2
  have heC : Real.exp v ≤ C := le_trans heN (by exact_mod_cast hNC)
  change logarithmicSource v * sourceKernel R D (v - s) =
    BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s)
  rw [frozenSource_eq_logarithmic hv.1 heC]

/-- No global integrability of an unfrozen source is used to obtain the full compact readout. -/
theorem window_frozen_source_full {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        (∫ x in (1 : ℝ)..(N : ℝ), window R s x) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s)) := by
  rw [window_frozen_source hN hNC hd hs hR hD hRs hDs hderiv hcut]
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [intervalIntegral.integral_of_le (Real.log_nonneg hNR)]
  congr 1
  apply MeasureTheory.setIntegral_eq_integral_of_forall_compl_eq_zero
  intro v hv
  have hnot : ¬ (0 < v ∧ v ≤ Real.log N) := hv
  have hy : d ≤ |v - s| := by
    by_cases hv0 : 0 < v
    · have hvN : Real.log N < v := by exact lt_of_not_ge (fun h => hnot ⟨hv0, h⟩)
      exact le_trans (by linarith : d ≤ v - s) (le_abs_self _)
    · exact le_trans (by linarith : d ≤ -(v - s)) (neg_le_abs _)
  simp only [sourceKernel, hRs _ hy, hDs _ hy, zero_div, sub_self, mul_zero]

noncomputable def densityMoment (R : ℝ → ℝ) : ℝ :=
  ∫ y : ℝ, Real.exp (y / 2) * R y

theorem density_translation (R : ℝ → ℝ) (s : ℝ) :
    (∫ v : ℝ, Real.exp (v / 2) * R (v - s)) = Real.exp (s / 2) * densityMoment R := by
  have he : (fun v => Real.exp (v / 2) * R (v - s)) =
      (fun v => Real.exp (s / 2) * (Real.exp ((v - s) / 2) * R (v - s))) := by
    funext v
    rw [← mul_assoc, ← Real.exp_add]
    congr 2
    ring
  rw [he, MeasureTheory.integral_const_mul]
  unfold densityMoment
  rw [MeasureTheory.integral_sub_right_eq_self (fun y : ℝ => Real.exp (y / 2) * R y) s]

/-- The complete density window, evaluated before arithmetic comparison. -/
theorem window_density_integral {R : ℝ → ℝ} {s d : ℝ} {N : ℕ}
    (hN : 1 ≤ N) (hs : d ≤ s)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hcut : s + d ≤ Real.log N) :
    (∫ x in (1 : ℝ)..(N : ℝ), window R s x) = Real.exp (s / 2) * densityMoment R := by
  have hNR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le (by norm_num) hNR
  have h := exp_interval_substitution (Real.log_nonneg hNR) (window R s)
  rw [Real.exp_log hNp] at h
  rw [h]
  have he : (fun v => Real.exp v * window R s (Real.exp v)) =
      (fun v => Real.exp (v / 2) * R (v - s)) := by
    funext v
    unfold window
    rw [Real.log_exp, ← mul_assoc, Real.rpow_def_of_pos (Real.exp_pos v), Real.log_exp,
      ← Real.exp_add]
    congr 2
    ring
  rw [he, intervalIntegral.integral_of_le (Real.log_nonneg hNR)]
  have hi : (∫ v in Set.Ioc (0 : ℝ) (Real.log N), Real.exp (v / 2) * R (v - s)) =
      ∫ v : ℝ, Real.exp (v / 2) * R (v - s) := by
    apply MeasureTheory.setIntegral_eq_integral_of_forall_compl_eq_zero
    intro v hv
    have hnot : ¬(0 < v ∧ v ≤ Real.log N) := hv
    have hy : d ≤ |v - s| := by
      by_cases hv0 : 0 < v
      · have hvN : Real.log N < v := lt_of_not_ge (fun h => hnot ⟨hv0, h⟩)
        exact le_trans (by linarith : d ≤ v - s) (le_abs_self _)
      · exact le_trans (by linarith : d ≤ -(v - s)) (neg_le_abs _)
    rw [hRs _ hy, mul_zero]
  rw [hi, density_translation]

/-- Literal prime atoms minus the full density moment equal the frozen source pairing. -/
theorem window_residual_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        Real.exp (s / 2) * densityMoment R =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s)) := by
  rw [← window_density_integral hN hs hRs hcut]
  exact window_frozen_source_full hN hNC hd hs hR hD hRs hDs hderiv hcut

noncomputable def physicalMoment (f : ℝ → ℝ) (a : ℝ) : ℝ :=
  ∫ v : ℝ, f v * Real.exp (a * v)

noncomputable def autocorrelation (f : ℝ → ℝ) (y : ℝ) : ℝ :=
  ∫ v : ℝ, f (v + y) * f v

theorem real_mellin_dictionary (f : ℝ → ℝ) (a : ℝ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (fun v => (f v : ℂ)) (a : ℂ) =
      (physicalMoment f a : ℂ) := by
  unfold BuildingBlocks.FullComplexHistoryMellin.mellin physicalMoment
  simp only [← Complex.ofReal_mul, ← Complex.ofReal_exp, integral_complex_ofReal]

theorem autocorrelation_cast (f : ℝ → ℝ) (y : ℝ) :
    BuildingBlocks.PhysicalScatteringCorrelation.correlation
      (fun v => (f v : ℂ)) (fun v => (f v : ℂ)) y = (autocorrelation f y : ℂ) := by
  unfold BuildingBlocks.PhysicalScatteringCorrelation.correlation autocorrelation
  simp only [Complex.conj_ofReal, ← Complex.ofReal_mul, integral_complex_ofReal]

/-- Actual autocorrelation moments have the opposite-sign physical Mellin factors. -/
theorem autocorrelation_moment {f : ℝ → ℝ} (hf : Continuous f)
    (hfc : HasCompactSupport f) (a : ℝ) :
    physicalMoment (autocorrelation f) a = physicalMoment f a * physicalMoment f (-a) := by
  have hc : Continuous (fun v => (f v : ℂ)) := Complex.continuous_ofReal.comp hf
  have hcc : HasCompactSupport (fun v => (f v : ℂ)) := by
    simpa only [Function.comp_def] using hfc.comp_left (g := Complex.ofReal) Complex.ofReal_zero
  have h := BuildingBlocks.PhysicalScatteringCorrelation.correlation_mellin hc hc hcc hcc (a : ℂ)
  have he : BuildingBlocks.PhysicalScatteringCorrelation.correlation
      (fun v => (f v : ℂ)) (fun v => (f v : ℂ)) =
      (fun y => (autocorrelation f y : ℂ)) := by
    funext y
    exact autocorrelation_cast f y
  rw [he, real_mellin_dictionary] at h
  unfold BuildingBlocks.FullComplexHistoryMellin.pairedWeight at h
  simp only [Complex.conj_ofReal, ← Complex.ofReal_neg, real_mellin_dictionary,
    Complex.conj_ofReal, ← Complex.ofReal_mul] at h
  exact Complex.ofReal_injective h

theorem densityMoment_physicalMoment (R : ℝ → ℝ) :
    densityMoment R = physicalMoment R ((1 : ℝ) / 2) := by
  unfold densityMoment physicalMoment
  congr 1
  funext y
  have he : y / 2 = (1 : ℝ) / 2 * y := by ring
  rw [he, mul_comm]

theorem densityMoment_autocorrelation {f : ℝ → ℝ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    densityMoment (autocorrelation f) =
      physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2) := by
  rw [densityMoment_physicalMoment, autocorrelation_moment hf hfc]
  congr 1
  norm_num

/-- Full actual autocorrelation residual, with its two physical density moments retained. -/
theorem autocorrelation_residual_frozen_source {f D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hf : Continuous f) (hfc : HasCompactSupport f) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → autocorrelation f y = 0)
    (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt (autocorrelation f) (D y) y)
    (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window (autocorrelation f) s n) -
        Real.exp (s / 2) *
          (physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel (autocorrelation f) D (v - s)) := by
  rw [← densityMoment_autocorrelation hf hfc]
  have hR : Continuous (autocorrelation f) := continuous_iff_continuousAt.mpr
    (fun y => (hderiv y).continuousAt)
  exact window_residual_frozen_source hN hNC hd hs hR hD hRs hDs hderiv hcut

theorem frozen_kernel_integrable {R D : ℝ → ℝ} {d : ℝ}
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (C : ℕ) (s : ℝ) :
    MeasureTheory.Integrable (fun v : ℝ => BuildingBlocks.ChargeFrozenSource.causalSource C v *
      sourceKernel R D (v - s)) := by
  have hk : Continuous (sourceKernel R D) := hD.sub (hR.div_const 2)
  have hks : HasCompactSupport (sourceKernel R D) := by
    apply HasCompactSupport.of_support_subset_isCompact (K := Set.Icc (-d) d) isCompact_Icc
    intro y hy
    have hyn : sourceKernel R D y ≠ 0 := hy
    have hlt : |y| < d := by
      apply lt_of_not_ge
      intro h
      apply hyn
      simp only [sourceKernel, hRs y h, hDs y h, zero_div, sub_self]
    exact abs_le.mp hlt.le
  have hnc : HasCompactSupport (fun y => ‖sourceKernel R D y‖) := by
    simpa only [Function.comp_def] using hks.comp_left (g := fun x : ℝ => ‖x‖) norm_zero
  have hb := (hnc.isCompact_range hk.norm).bddAbove
  obtain ⟨B, hB⟩ := hb
  have hi := (BuildingBlocks.ChargeFrozenIntegrability.integrable_causalSource C).bdd_mul
    (hk.comp (continuous_id.sub continuous_const)).aestronglyMeasurable
    ⟨B, fun v => hB ⟨v - s, rfl⟩⟩
  change MeasureTheory.Integrable (fun v : ℝ => sourceKernel R D (v - s) *
    BuildingBlocks.ChargeFrozenSource.causalSource C v) at hi
  exact hi.congr (Filter.Eventually.of_forall (fun v => mul_comm _ _))

/-- All signed windows use one complete frozen source, with no coefficient discarded. -/
theorem signed_windows_frozen_source {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {R D : ℝ → ℝ} {d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y)
    (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window R (s i) n) - Real.exp (s i / 2) * densityMoment R)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * sourceKernel R D (v - s i))) := by
  have hi : ∀ i ∈ T, MeasureTheory.Integrable (fun v : ℝ => c i *
      (BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s i))) := by
    intro i _
    exact (frozen_kernel_integrable hR hD hRs hDs C (s i)).const_mul (c i)
  calc
    _ = -(∑ i ∈ T, c i * (∫ v : ℝ,
        BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s i))) := by
      rw [← Finset.sum_neg_distrib]
      apply Finset.sum_congr rfl
      intro i hiT
      rw [window_residual_frozen_source hN hNC hd (hs i hiT) hR hD hRs hDs hderiv (hcut i hiT)]
      ring
    _ = -(∫ v : ℝ, ∑ i ∈ T, c i *
        (BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s i))) := by
      rw [MeasureTheory.integral_finset_sum T hi]
      simp only [MeasureTheory.integral_const_mul]
    _ = _ := by
      congr 1
      apply MeasureTheory.integral_congr_ae
      filter_upwards [] with v
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      ring

#print axioms window_hasDerivAt
#print axioms window_one_eq_zero
#print axioms window_endpoint_eq_zero
#print axioms windowDerivative_continuousAt
#print axioms windowDerivative_intervalIntegrable
#print axioms positiveWindow_zero_below_one
#print axioms positiveWindow_hasDerivAt
#print axioms positiveWindow_continuous
#print axioms positiveWindow_original_source
#print axioms window_original_source
#print axioms exp_image_Ioc
#print axioms exp_interval_substitution
#print axioms exp_source_readout
#print axioms frozenSource_eq_logarithmic
#print axioms window_frozen_source
#print axioms window_frozen_source_full
#print axioms density_translation
#print axioms window_density_integral
#print axioms window_residual_frozen_source
#print axioms real_mellin_dictionary
#print axioms autocorrelation_cast
#print axioms autocorrelation_moment
#print axioms densityMoment_physicalMoment
#print axioms densityMoment_autocorrelation
#print axioms autocorrelation_residual_frozen_source
#print axioms frozen_kernel_integrable
#print axioms signed_windows_frozen_source

end LogarithmicPrimeWindow
