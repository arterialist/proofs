import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import Mathlib.Topology.Algebra.Order.Floor
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-!
Finite primitive-energy bounds for test integrals of the actual prime error.
The statements, use, sources, and verification scope are in ../coarse-primitive.md.
-/

open Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

/-- Chebyshev's prime-power sum, including the integer cutoff. -/
noncomputable def psi (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.range (N + 1), ArithmeticFunction.vonMangoldt n

theorem psi_mono {M N : ℕ} (h : M ≤ N) : psi M ≤ psi N := by
  exact Finset.sum_le_sum_of_subset_of_nonneg
    (Finset.range_mono (Nat.add_le_add_right h 1))
    (fun _ _ _ => ArithmeticFunction.vonMangoldt_nonneg)

noncomputable def primeErrorReal (x : ℝ) : ℝ := psi ⌊x⌋₊ - x

noncomputable def coarsePrefix (X t : ℝ) : ℝ :=
  ∫ x in X..t, primeErrorReal x

noncomputable def coarseSuffix (X t : ℝ) : ℝ :=
  ∫ x in t..(2 * X), primeErrorReal x

noncomputable def coarsePrimitiveSquare (X : ℝ) : ℝ :=
  ∫ t in X..(2 * X), coarsePrefix X t ^ 2 + coarseSuffix X t ^ 2

theorem primeErrorReal_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable primeErrorReal volume a b := by
  have hp : Monotone (fun x : ℝ => psi ⌊x⌋₊) :=
    fun _ _ h => psi_mono (Nat.floor_mono h)
  exact hp.intervalIntegrable.sub (continuous_id.intervalIntegrable _ _)

theorem coarsePrefix_add_suffix (X t : ℝ) :
    coarsePrefix X t + coarseSuffix X t = coarsePrefix X (2 * X) := by
  exact intervalIntegral.integral_add_adjacent_intervals
    (primeErrorReal_intervalIntegrable X t) (primeErrorReal_intervalIntegrable t (2 * X))

theorem coarsePrefix_continuous (X : ℝ) : Continuous (coarsePrefix X) := by
  exact intervalIntegral.continuous_primitive (fun a b => primeErrorReal_intervalIntegrable a b) X

theorem coarseSuffix_continuous (X : ℝ) : Continuous (coarseSuffix X) := by
  have he : coarseSuffix X = fun t => coarsePrefix X (2 * X) - coarsePrefix X t := by
    funext t
    linarith [coarsePrefix_add_suffix X t]
  rw [he]
  exact continuous_const.sub (coarsePrefix_continuous X)

theorem coarsePrimitiveSquare_nonneg {X : ℝ} (hX : 0 ≤ X) :
    0 ≤ coarsePrimitiveSquare X := by
  exact intervalIntegral.integral_nonneg (by linarith)
    (fun t _ => add_nonneg (sq_nonneg _) (sq_nonneg _))

/-- Both primitive norms control the terminal mass without a pointwise
estimate on the prime error or a separate intermediate-scale hypothesis. -/
theorem coarse_terminal_mass_sq_le {X : ℝ} (hX : 0 ≤ X) :
    X * coarsePrefix X (2 * X) ^ 2 ≤ 2 * coarsePrimitiveSquare X := by
  have hp := (coarsePrefix_continuous X).pow 2
  have hr := (coarseSuffix_continuous X).pow 2
  have hi := intervalIntegral.integral_mono_on (a := X) (b := 2 * X)
    (by linarith)
    (show IntervalIntegrable (fun _ : ℝ => coarsePrefix X (2 * X) ^ 2)
      volume X (2 * X) from continuous_const.intervalIntegrable X (2 * X))
    (show IntervalIntegrable (fun t : ℝ => 2 *
      (coarsePrefix X t ^ 2 + coarseSuffix X t ^ 2)) volume X (2 * X) from
      (continuous_const.mul (hp.add hr)).intervalIntegrable X (2 * X))
    (fun t _ => show coarsePrefix X (2 * X) ^ 2 ≤
      2 * (coarsePrefix X t ^ 2 + coarseSuffix X t ^ 2) by
      rw [← coarsePrefix_add_suffix X t]
      nlinarith [sq_nonneg (coarsePrefix X t - coarseSuffix X t)])
  simpa [coarsePrimitiveSquare, intervalIntegral.integral_const,
    intervalIntegral.integral_const_mul, smul_eq_mul, show 2 * X - X = X by ring] using hi

theorem primeErrorReal_measurable : Measurable primeErrorReal := by
  have hp : Measurable psi := measurable_of_countable psi
  unfold primeErrorReal
  fun_prop

theorem primeErrorReal_continuousWithinAt_right (x : ℝ) :
    ContinuousWithinAt primeErrorReal (Ici x) x := by
  have he : ∀ᶠ y in 𝓝[≥] x, ⌊y⌋ = ⌊x⌋ :=
    (tendsto_floor_right_pure_floor x).eventually
      (show ∀ᶠ z : ℤ in pure ⌊x⌋, z = ⌊x⌋ from by simp)
  have hp : Tendsto (fun y : ℝ => psi ⌊y⌋₊) (𝓝[≥] x) (𝓝 (psi ⌊x⌋₊)) := by
    apply tendsto_const_nhds.congr'
    filter_upwards [he] with y hy
    simp only [← Int.floor_toNat, hy]
  exact hp.sub continuousWithinAt_id

theorem coarsePrefix_hasDerivWithinAt_right (X t : ℝ) :
    HasDerivWithinAt (coarsePrefix X) (primeErrorReal t) (Ioi t) t := by
  have h := intervalIntegral.integral_hasDerivWithinAt_right
    (s := Ici t) (t := Ioi t) (primeErrorReal_intervalIntegrable X t)
    primeErrorReal_measurable.stronglyMeasurable.stronglyMeasurableAtFilter
    ((primeErrorReal_continuousWithinAt_right t).mono Ioi_subset_Ici_self)
  exact h.mono Ioi_subset_Ici_self

/-- The elementary finite-interval Cauchy--Schwarz estimate, proved by
integrating a square. This avoids any inference about pointwise prime error. -/
theorem interval_abs_integral_sq_le {f : ℝ → ℝ} (hf : Continuous f)
    {a b : ℝ} (hab : a ≤ b) :
    (∫ x in a..b, |f x|) ^ 2 ≤ (b - a) * ∫ x in a..b, f x ^ 2 := by
  rcases hab.eq_or_lt with he | he
  · subst b
    simp
  let L := b - a
  let M := ∫ x in a..b, |f x|
  have hL : 0 < L := sub_pos.mpr he
  have hnonneg : 0 ≤ ∫ x in a..b, (L * |f x| - M) ^ 2 :=
    intervalIntegral.integral_nonneg hab (fun x _ => sq_nonneg _)
  have hid : (fun x => (L * |f x| - M) ^ 2) =
      (fun x => L ^ 2 * f x ^ 2 - 2 * L * M * |f x| + M ^ 2) := by
    funext x
    nlinarith [sq_abs (f x)]
  rw [hid, intervalIntegral.integral_add, intervalIntegral.integral_sub,
    intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const] at hnonneg
  · simp only [smul_eq_mul] at hnonneg
    change 0 ≤ L ^ 2 * (∫ x in a..b, f x ^ 2) - 2 * L * M * M + L * M ^ 2 at hnonneg
    change M ^ 2 ≤ L * (∫ x in a..b, f x ^ 2)
    nlinarith
  all_goals apply Continuous.intervalIntegrable; fun_prop

theorem coarsePrefix_abs_integral_sq_le {X : ℝ} (hX : 0 ≤ X) :
    (∫ t in X..(2 * X), |coarsePrefix X t|) ^ 2 ≤ X * coarsePrimitiveSquare X := by
  have hfirst := interval_abs_integral_sq_le (coarsePrefix_continuous X)
    (a := X) (b := 2 * X) (by linarith)
  have hsecond : (∫ t in X..(2 * X), coarsePrefix X t ^ 2) ≤ coarsePrimitiveSquare X := by
    apply intervalIntegral.integral_mono_on (by linarith)
      ((coarsePrefix_continuous X).pow 2 |>.intervalIntegrable _ _)
      (((coarsePrefix_continuous X).pow 2).add ((coarseSuffix_continuous X).pow 2)
        |>.intervalIntegrable _ _)
    exact fun t _ => le_add_of_nonneg_right (sq_nonneg _)
  have := mul_le_mul_of_nonneg_left hsecond hX
  have hlen : 2 * X - X = X := by ring
  rw [hlen] at hfirst
  exact hfirst.trans this

/-- Exact summation by parts for the actual prime error, including its
integer jumps and the terminal mass. Only the test function is differentiated
on both sides. -/
theorem coarsePrime_summation_by_parts {X : ℝ} {w w' : ℝ → ℂ}
    (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X)) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x) =
      (coarsePrefix X (2 * X) : ℂ) * w (2 * X) -
      ∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x := by
  have h := intervalIntegral.integral_smul_deriv_eq_deriv_smul_of_hasDeriv_right
    ((coarsePrefix_continuous X).continuousOn) hw
    (fun x _ => coarsePrefix_hasDerivWithinAt_right X x)
    (fun x hx => (hd x hx).hasDerivWithinAt)
    (primeErrorReal_intervalIntegrable X (2 * X)) hi
  have hz : coarsePrefix X X = 0 := by simp [coarsePrefix]
  simp only [hz, zero_smul, sub_zero, Complex.real_smul] at h
  apply eq_sub_iff_add_eq.mpr
  simpa only [add_comm] using eq_sub_iff_add_eq.mp h

/-- The block Mellin identity retains the terminal mass. -/
theorem coarsePrime_mellin_block {X : ℝ} (hX : 0 < X) (s : ℂ) :
    (∫ x in X..(2 * X), (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) =
      (coarsePrefix X (2 * X) : ℂ) * (2 * X : ℂ) ^ (-(s + 1)) +
      (s + 1) * ∫ x in X..(2 * X),
        (coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2)) := by
  have hpos : ∀ x ∈ [[X, 2 * X]], 0 < x := by
    intro x hx
    rw [uIcc_of_le (by linarith)] at hx
    linarith [hx.1]
  have hc (z : ℂ) : ContinuousOn (fun x : ℝ => (x : ℂ) ^ z) [[X, 2 * X]] := by
    apply Complex.continuous_ofReal.continuousOn.cpow_const
    intro x hx
    exact Complex.ofReal_mem_slitPlane.mpr (hpos x hx)
  have hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)),
      HasDerivAt (fun y : ℝ => (y : ℂ) ^ (-(s + 1)))
        (-(s + 1) * (x : ℂ) ^ (-(s + 2))) x := by
    intro x hx
    have hxpos := hpos x (Set.mem_Icc_of_Ioo hx)
    have h := (Complex.hasStrictDerivAt_cpow_const
      (x := (x : ℂ)) (c := -(s + 1))
      (Complex.ofReal_mem_slitPlane.mpr hxpos)).hasDerivAt.comp_ofReal
    convert h using 1
    congr 2
    ring
  have hi : IntervalIntegrable
      (fun x : ℝ => -(s + 1) * (x : ℂ) ^ (-(s + 2))) volume X (2 * X) :=
    (continuousOn_const.mul (hc (-(s + 2)))).intervalIntegrable
  have h := coarsePrime_summation_by_parts (hc (-(s + 1))) hd hi
  rw [h]
  simp only [Complex.ofReal_mul, Complex.ofReal_ofNat]
  have hid : (fun x : ℝ => (coarsePrefix X x : ℂ) *
      (-(s + 1) * (x : ℂ) ^ (-(s + 2)))) =
      (fun x : ℝ => -(s + 1) * ((coarsePrefix X x : ℂ) * (x : ℂ) ^ (-(s + 2)))) := by
    funext x
    ring
  rw [hid, intervalIntegral.integral_const_mul]
  ring

theorem coarse_terminal_mass_le_sqrt {X : ℝ} (hX : 0 < X) :
    |coarsePrefix X (2 * X)| ≤ Real.sqrt (2 * coarsePrimitiveSquare X / X) := by
  apply Real.le_sqrt_of_sq_le
  rw [sq_abs, le_div_iff₀ hX]
  simpa only [mul_comm] using coarse_terminal_mass_sq_le hX.le

theorem coarsePrefix_abs_integral_le_sqrt {X : ℝ} (hX : 0 ≤ X) :
    (∫ t in X..(2 * X), |coarsePrefix X t|) ≤ Real.sqrt (X * coarsePrimitiveSquare X) :=
  Real.le_sqrt_of_sq_le (coarsePrefix_abs_integral_sq_le hX)

/-- A finite-block test-function estimate from the actual primitive energy.
The bound assumes no estimate on the prime error or on this energy. -/
theorem coarsePrime_test_bound {X K : ℝ} (hX : 0 < X) (hK : 0 ≤ K)
    {w w' : ℝ → ℂ} (hw : ContinuousOn w [[X, 2 * X]])
    (hd : ∀ x ∈ Ioo (min X (2 * X)) (max X (2 * X)), HasDerivAt w (w' x) x)
    (hi : IntervalIntegrable w' volume X (2 * X))
    (hbound : ∀ x ∈ Ioc X (2 * X), ‖w' x‖ ≤ K) :
    ‖∫ x in X..(2 * X), (primeErrorReal x : ℂ) * w x‖ ≤
      Real.sqrt (2 * coarsePrimitiveSquare X / X) * ‖w (2 * X)‖ +
      K * Real.sqrt (X * coarsePrimitiveSquare X) := by
  have hnorm : ‖∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x‖ ≤
      K * ∫ x in X..(2 * X), |coarsePrefix X x| := by
    have hb := intervalIntegral.norm_integral_le_of_norm_le
      (f := fun x => (coarsePrefix X x : ℂ) * w' x)
      (g := fun x => K * |coarsePrefix X x|) (μ := volume) (a := X) (b := 2 * X)
      (by linarith)
      (Filter.Eventually.of_forall (fun x hx => show
        ‖(coarsePrefix X x : ℂ) * w' x‖ ≤ K * |coarsePrefix X x| by
        rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, mul_comm K]
        exact mul_le_mul_of_nonneg_left (hbound x hx) (abs_nonneg _)))
      ((continuous_const.mul (coarsePrefix_continuous X).abs).intervalIntegrable _ _)
    simpa only [intervalIntegral.integral_const_mul] using hb
  rw [coarsePrime_summation_by_parts hw hd hi]
  calc
    _ ≤ ‖(coarsePrefix X (2 * X) : ℂ) * w (2 * X)‖ +
        ‖∫ x in X..(2 * X), (coarsePrefix X x : ℂ) * w' x‖ := norm_sub_le _ _
    _ ≤ |coarsePrefix X (2 * X)| * ‖w (2 * X)‖ +
        K * ∫ x in X..(2 * X), |coarsePrefix X x| := by
      simpa only [norm_mul, Complex.norm_real, Real.norm_eq_abs] using
        add_le_add_left hnorm ‖(coarsePrefix X (2 * X) : ℂ) * w (2 * X)‖
    _ ≤ _ := add_le_add
      (mul_le_mul_of_nonneg_right (coarse_terminal_mass_le_sqrt hX) (norm_nonneg _))
      (mul_le_mul_of_nonneg_left (coarsePrefix_abs_integral_le_sqrt hX.le) hK)

end BuildingBlocks.CoarsePrimitive
