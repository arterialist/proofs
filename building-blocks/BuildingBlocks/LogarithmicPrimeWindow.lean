import BuildingBlocks.FinitePrimeSourceIntegration
import BuildingBlocks.ChargeFrozenSource
import Mathlib.MeasureTheory.Function.JacobianOneDim
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

end LogarithmicPrimeWindow
