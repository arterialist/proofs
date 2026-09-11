import BuildingBlocks.QuotientMass
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.MeasureTheory.Function.JacobianOneDim

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

theorem quotient_coefficient_sum (N : ℕ) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) = (mertens N : ℝ) := by
  have hh := sum_grouped_by_quotient N
    (fun k => (ArithmeticFunction.moebius k : ℝ)) (fun _ => 1)
  simp only [mul_one] at hh
  simp only [quotientCoefficient, Int.cast_sum]
  rw [← hh, mertens, Int.cast_sum]
  have hs : Finset.Icc 1 N = Finset.Ico 1 (N + 1) := by
    ext k
    simp only [Finset.mem_Icc, Finset.mem_Ico]
    omega
  rw [hs, Finset.sum_Ico_eq_sub _ (by omega : 1 ≤ N + 1)]
  simp

/-- A finite fractional-part approximation with the exact quotient coefficients. -/
noncomputable def dualApproximation (N : ℕ) (x : ℝ) : ℝ :=
  (∑ q ∈ Finset.Icc 1 N,
    (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) / ((N : ℝ) * x))) -
      Int.fract (1 / ((N : ℝ) * x))

/-- The error in reciprocal coordinates, which is periodic in its argument. -/
noncomputable def reciprocalError (N : ℕ) (y : ℝ) : ℝ :=
  1 + (∑ q ∈ Finset.Icc 1 N,
    (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y)) - Int.fract y

theorem reciprocalError_periodic (N : ℕ) :
    Function.Periodic (reciprocalError N) 1 := by
  intro y
  simp only [reciprocalError, mul_add, mul_one, Int.fract_add_natCast, Int.fract_add_one]

theorem dualApproximation_reciprocal {N : ℕ} (hN : 0 < N) {y : ℝ} (hy : y ≠ 0) :
    1 + dualApproximation N (1 / ((N : ℝ) * y)) = reciprocalError N y := by
  have hn : (N : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hN)
  have hq (q : ℕ) : (q : ℝ) / ((N : ℝ) * (1 / ((N : ℝ) * y))) = (q : ℝ) * y := by
    field_simp
  have h1 : 1 / ((N : ℝ) * (1 / ((N : ℝ) * y))) = y := by field_simp
  simp only [dualApproximation, reciprocalError, hq, h1]
  ring

theorem reciprocalError_floor {N : ℕ} (hN : 0 < N) (y : ℝ) :
    reciprocalError N y = 1 -
      (∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) *
        (⌊(q : ℝ) * y⌋ : ℝ)) + (⌊y⌋ : ℝ) := by
  simp only [reciprocalError, Int.fract, mul_sub, Finset.sum_sub_distrib]
  have hh : (∑ q ∈ Finset.Icc 1 N,
      (quotientCoefficient N q : ℝ) * ((q : ℝ) * y)) = y := by
    simp_rw [← mul_assoc, ← Finset.sum_mul, quotient_floor_mass hN, one_mul]
  rw [hh]
  ring

theorem fract_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable (Int.fract : ℝ → ℝ) volume a b := by
  apply (intervalIntegrable_const (c := (1 : ℝ))).mono_fun'
    measurable_fract.aestronglyMeasurable
  exact Eventually.of_forall (fun x => by
    simpa only [Real.norm_eq_abs, abs_of_nonneg (Int.fract_nonneg x)] using
      (Int.fract_lt_one x).le)

theorem integral_fract_unit : (∫ y in (0 : ℝ)..1, Int.fract y) = 1 / 2 := by
  have he : (∫ y in (0 : ℝ)..1, Int.fract y) = ∫ y in (0 : ℝ)..1, y := by
    apply intervalIntegral.integral_congr_ae
    filter_upwards [(Set.countable_singleton (1 : ℝ)).ae_notMem volume] with y hy hmem
    have hy' : y ≠ 1 := hy
    rw [uIoc_of_le (by norm_num : (0 : ℝ) ≤ 1)] at hmem
    exact Int.fract_eq_self.mpr ⟨hmem.1.le, lt_of_le_of_ne hmem.2 hy'⟩
  rw [he, integral_id]
  norm_num

theorem integral_fract_nat_mul {q : ℕ} (hq : 0 < q) :
    (∫ y in (0 : ℝ)..1, Int.fract ((q : ℝ) * y)) = 1 / 2 := by
  have hp : Function.Periodic (Int.fract : ℝ → ℝ) 1 := Int.fract_add_one
  have hi := hp.intervalIntegral_add_zsmul_eq (q : ℤ) 0 fract_intervalIntegrable
  simp only [zsmul_eq_mul, Int.cast_natCast, mul_one, zero_add,
    integral_fract_unit] at hi
  rw [intervalIntegral.integral_comp_mul_left _ (by positivity : (q : ℝ) ≠ 0)]
  simp only [mul_zero, mul_one, hi, smul_eq_mul]
  field_simp

theorem reciprocalError_measurable (N : ℕ) : Measurable (reciprocalError N) := by
  unfold reciprocalError
  fun_prop

theorem reciprocalError_abs_bound (N : ℕ) (y : ℝ) :
    |reciprocalError N y| ≤ 2 +
      ∑ q ∈ Finset.Icc 1 N, |(quotientCoefficient N q : ℝ)| := by
  have hs : |∑ q ∈ Finset.Icc 1 N,
      (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y)| ≤
      ∑ q ∈ Finset.Icc 1 N, |(quotientCoefficient N q : ℝ)| := by
    apply (Finset.abs_sum_le_sum_abs _ _).trans
    apply Finset.sum_le_sum
    intro q hq
    rw [abs_mul, abs_of_nonneg (Int.fract_nonneg _)]
    exact mul_le_of_le_one_right (abs_nonneg _) (Int.fract_lt_one _).le
  have hh := (abs_add_le (1 + ∑ q ∈ Finset.Icc 1 N,
      (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y)) (-Int.fract y)).trans
    (add_le_add_right (abs_add_le _ _) _)
  simp only [abs_one, abs_neg, abs_of_nonneg (Int.fract_nonneg y), ← sub_eq_add_neg] at hh
  dsimp [reciprocalError]
  linarith [Int.fract_lt_one y]

theorem reciprocalError_pow_intervalIntegrable (N m : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun y => reciprocalError N y ^ m) volume a b := by
  apply (intervalIntegrable_const (c := (2 + ∑ q ∈ Finset.Icc 1 N,
    |(quotientCoefficient N q : ℝ)|) ^ m)).mono_fun'
      ((reciprocalError_measurable N).pow_const m).aestronglyMeasurable
  apply Eventually.of_forall
  intro y
  simp only [Real.norm_eq_abs, abs_pow]
  exact pow_le_pow_left₀ (abs_nonneg _) (reciprocalError_abs_bound N y) m

theorem reciprocalError_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (reciprocalError N) volume a b := by
  simpa using reciprocalError_pow_intervalIntegrable N 1 a b

theorem reciprocalError_mean_zero_one (N : ℕ) :
    (∫ y in (0 : ℝ)..1, reciprocalError N y) = ((mertens N : ℝ) + 1) / 2 := by
  have hs : ∀ q ∈ Finset.Icc 1 N, IntervalIntegrable
      (fun y : ℝ => (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y))
        volume 0 1 := by
    intro q hq
    have hq' : (q : ℝ) ≠ 0 := by
      exact_mod_cast (Nat.ne_of_gt (Finset.mem_Icc.mp hq).1)
    have hh := (fract_intervalIntegrable 0 (q : ℝ)).comp_mul_left (c := (q : ℝ))
    simp only [zero_div, div_self hq'] at hh
    exact hh.const_mul _
  have hs' : IntervalIntegrable (fun y : ℝ => ∑ q ∈ Finset.Icc 1 N,
      (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y)) volume 0 1 := by
    simpa only [Finset.sum_fn] using IntervalIntegrable.sum (Finset.Icc 1 N) hs
  simp only [reciprocalError]
  rw [intervalIntegral.integral_sub ((intervalIntegrable_const (c := (1 : ℝ))).add hs')
      (fract_intervalIntegrable 0 1),
    intervalIntegral.integral_add intervalIntegrable_const hs',
    intervalIntegral.integral_finset_sum hs, integral_fract_unit]
  have he : (∑ q ∈ Finset.Icc 1 N, ∫ y in (0 : ℝ)..1,
      (quotientCoefficient N q : ℝ) * Int.fract ((q : ℝ) * y)) =
      (mertens N : ℝ) / 2 := by
    simp_rw [intervalIntegral.integral_const_mul]
    calc
      _ = ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) * (1 / 2) := by
        apply Finset.sum_congr rfl
        intro q hq
        rw [integral_fract_nat_mul (Finset.mem_Icc.mp hq).1]
      _ = _ := by rw [← Finset.sum_mul, quotient_coefficient_sum]; ring
  rw [he]
  norm_num
  ring

theorem reciprocalError_mean_one_two (N : ℕ) :
    (∫ y in (1 : ℝ)..2, reciprocalError N y) = ((mertens N : ℝ) + 1) / 2 := by
  have hh := (reciprocalError_periodic N).intervalIntegral_add_eq 1 0
  norm_num only [zero_add, one_add_one_eq_two] at hh
  rw [hh, reciprocalError_mean_zero_one]

/-- Cauchy-Schwarz on a unit interval, proved here by integrating a square. -/
theorem unit_interval_mean_square_le {f : ℝ → ℝ}
    (hf : IntervalIntegrable f volume 1 2)
    (hf2 : IntervalIntegrable (fun y => f y ^ 2) volume 1 2) :
    (∫ y in (1 : ℝ)..2, f y) ^ 2 ≤ ∫ y in (1 : ℝ)..2, f y ^ 2 := by
  let m : ℝ := ∫ y in (1 : ℝ)..2, f y
  have hp := intervalIntegral.integral_nonneg_of_forall (μ := volume) (by norm_num : (1 : ℝ) ≤ 2)
    (fun y => sq_nonneg (f y - m))
  have he : (∫ y in (1 : ℝ)..2, (f y - m) ^ 2) =
      (∫ y in (1 : ℝ)..2, f y ^ 2) - m ^ 2 := by
    have hid : (fun y => (f y - m) ^ 2) = (fun y => f y ^ 2 - 2 * m * f y + m ^ 2) := by
      funext y
      ring
    rw [hid, intervalIntegral.integral_add (hf2.sub (hf.const_mul _))
        intervalIntegrable_const,
      intervalIntegral.integral_sub hf2 (hf.const_mul _),
      intervalIntegral.integral_const_mul]
    simp only [intervalIntegral.integral_const, smul_eq_mul]
    change (∫ y in (1 : ℝ)..2, f y ^ 2) - 2 * m * m + (2 - 1) * m ^ 2 = _
    ring
  rw [he] at hp
  exact sub_nonneg.mp hp

/-- A finite, unconditional mean-square lower bound. -/
theorem reciprocalError_mean_square_lower (N : ℕ) :
    ((mertens N : ℝ) + 1) ^ 2 / 4 ≤
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2 := by
  have hh := unit_interval_mean_square_le (reciprocalError_intervalIntegrable N 1 2)
    (reciprocalError_pow_intervalIntegrable N 2 1 2)
  rw [reciprocalError_mean_one_two] at hh
  nlinarith

theorem reciprocalError_weighted_intervalIntegrable (N : ℕ) :
    IntervalIntegrable (fun y => reciprocalError N y ^ 2 / y ^ 2) volume 1 2 := by
  have hc : ContinuousOn (fun y : ℝ => (y ^ 2)⁻¹) (Set.uIcc 1 2) := by
    apply (continuousOn_id.pow 2).inv₀
    intro y hy
    rw [uIcc_of_le (by norm_num : (1 : ℝ) ≤ 2)] at hy
    exact pow_ne_zero _ (show y ≠ 0 by linarith [hy.1])
  simpa only [div_eq_mul_inv] using
    (reciprocalError_pow_intervalIntegrable N 2 1 2).mul_continuousOn hc

theorem reciprocalError_weighted_lower (N : ℕ) :
    ((mertens N : ℝ) + 1) ^ 2 / 16 ≤
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2 / y ^ 2 := by
  have hh := intervalIntegral.integral_mono_on (by norm_num : (1 : ℝ) ≤ 2)
    ((reciprocalError_pow_intervalIntegrable N 2 1 2).div_const 4)
    (reciprocalError_weighted_intervalIntegrable N) (fun y hy => ?_)
  · rw [intervalIntegral.integral_div] at hh
    linarith [reciprocalError_mean_square_lower N]
  · have hy0 : (0 : ℝ) < y := by linarith [hy.1]
    have hy2 : y ^ 2 ≤ 4 := by nlinarith [hy.2]
    apply (div_le_div_iff₀ (by norm_num : (0 : ℝ) < 4) (sq_pos_of_pos hy0)).mpr
    exact mul_le_mul_of_nonneg_left hy2 (sq_nonneg _)

/-- The actual squared error on the shrinking interval in the original variable. -/
noncomputable def dualWindowEnergy (N : ℕ) : ℝ :=
  ∫ x in (1 / (2 * (N : ℝ)))..(1 / (N : ℝ)), (1 + dualApproximation N x) ^ 2

theorem dualWindowEnergy_eq_weighted {N : ℕ} (hN : 0 < N) :
    dualWindowEnergy N = (1 / (N : ℝ)) *
      ∫ y in (1 : ℝ)..2, reciprocalError N y ^ 2 / y ^ 2 := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  let f : ℝ → ℝ := fun y => 1 / ((N : ℝ) * y)
  let f' : ℝ → ℝ := fun y => -1 / ((N : ℝ) * y ^ 2)
  have hd : ∀ y ∈ Set.Icc (1 : ℝ) 2, HasDerivWithinAt f (f' y) (Set.Icc 1 2) y := by
    intro y hy
    have hy0 : y ≠ 0 := by linarith [hy.1]
    have hh := ((hasDerivAt_id y).const_mul (N : ℝ)).inv (mul_ne_zero hn.ne' hy0)
    convert hh.hasDerivWithinAt using 1 <;> dsimp [f, f']
    · funext x
      simp only [one_div, Pi.inv_apply]
    · field_simp
  have hc : ContinuousOn f (Set.Icc 1 2) := fun y hy => (hd y hy).continuousWithinAt
  have ha : AntitoneOn f (Set.Icc 1 2) := by
    intro y hy z hz hyz
    exact one_div_le_one_div_of_le (mul_pos hn (by linarith [hy.1]))
      (mul_le_mul_of_nonneg_left hyz hn.le)
  have himage : f '' Set.Icc (1 : ℝ) 2 = Set.Icc (1 / (2 * (N : ℝ))) (1 / (N : ℝ)) := by
    simpa only [f, mul_one, mul_comm (N : ℝ) 2] using
      hc.image_Icc_of_antitoneOn (by norm_num : (1 : ℝ) ≤ 2) ha
  have hinj : Set.InjOn f (Set.Icc 1 2) := by
    intro y hy z hz he
    have hh : (N : ℝ) * y = (N : ℝ) * z := by
      simpa only [f, one_div, inv_inj] using he
    exact mul_left_cancel₀ hn.ne' hh
  have he := integral_image_eq_integral_abs_deriv_smul measurableSet_Icc hd hinj
    (fun x => (1 + dualApproximation N x) ^ 2)
  have hends : 1 / (2 * (N : ℝ)) ≤ 1 / (N : ℝ) :=
    one_div_le_one_div_of_le hn (by linarith)
  rw [himage, integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hends,
    integral_Icc_eq_integral_Ioc,
    ← intervalIntegral.integral_of_le (by norm_num : (1 : ℝ) ≤ 2)] at he
  rw [dualWindowEnergy, he, ← intervalIntegral.integral_const_mul]
  apply intervalIntegral.integral_congr
  intro y hy
  rw [uIcc_of_le (by norm_num : (1 : ℝ) ≤ 2)] at hy
  have hy0 : (0 : ℝ) < y := by linarith [hy.1]
  change |f' y| * (1 + dualApproximation N (f y)) ^ 2 =
    (1 / (N : ℝ)) * (reciprocalError N y ^ 2 / y ^ 2)
  rw [show f y = 1 / ((N : ℝ) * y) from rfl,
    dualApproximation_reciprocal hN hy0.ne']
  simp only [f', abs_div, abs_neg, abs_one,
    abs_of_pos (mul_pos hn (sq_pos_of_pos hy0))]
  field_simp

theorem dualWindowEnergy_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualWindowEnergy N := by
  rw [dualWindowEnergy_eq_weighted hN]
  have hh := mul_le_mul_of_nonneg_left (reciprocalError_weighted_lower N)
    (show 0 ≤ 1 / (N : ℝ) by positivity)
  convert hh using 1
  ring

theorem dualError_eq_reciprocalError (N : ℕ) (x : ℝ) :
    1 + dualApproximation N x = reciprocalError N (1 / ((N : ℝ) * x)) := by
  simp only [dualApproximation, reciprocalError, div_eq_mul_inv, one_mul]
  ring

theorem dualApproximation_zero_above_one {N : ℕ} (hN : 0 < N) {x : ℝ} (hx : 1 < x) :
    dualApproximation N x = 0 := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hn1 : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hnx : (N : ℝ) < (N : ℝ) * x := by nlinarith
  have hpos : (0 : ℝ) < (N : ℝ) * x := by positivity
  have hq : ∀ q ∈ Finset.Icc 1 N,
      Int.fract ((q : ℝ) / ((N : ℝ) * x)) = (q : ℝ) / ((N : ℝ) * x) := by
    intro q hq
    apply Int.fract_eq_self.mpr
    constructor
    · positivity
    · apply (div_lt_one hpos).mpr
      exact lt_of_le_of_lt (by exact_mod_cast (Finset.mem_Icc.mp hq).2) hnx
  have h1 : Int.fract (1 / ((N : ℝ) * x)) = 1 / ((N : ℝ) * x) :=
    Int.fract_eq_self.mpr ⟨by positivity, (div_lt_one hpos).mpr (hn1.trans_lt hnx)⟩
  dsimp [dualApproximation]
  rw [h1]
  have hs : (∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) *
      Int.fract ((q : ℝ) / ((N : ℝ) * x))) = 1 / ((N : ℝ) * x) := by
    calc
      _ = ∑ q ∈ Finset.Icc 1 N,
          (quotientCoefficient N q : ℝ) * ((q : ℝ) / ((N : ℝ) * x)) := by
        apply Finset.sum_congr rfl
        intro q hmem
        rw [hq q hmem]
      _ = _ := by simp_rw [← mul_div_assoc, ← Finset.sum_div, quotient_floor_mass hN]
  rw [hs, sub_self]

theorem dualError_sq_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun x => (1 + dualApproximation N x) ^ 2) volume a b := by
  simp only [dualError_eq_reciprocalError]
  apply (intervalIntegrable_const (c := (2 + ∑ q ∈ Finset.Icc 1 N,
    |(quotientCoefficient N q : ℝ)|) ^ 2)).mono_fun'
  · apply Measurable.aestronglyMeasurable
    apply Measurable.pow_const
    exact (reciprocalError_measurable N).comp (by fun_prop)
  · apply Eventually.of_forall
    intro x
    simp only [Real.norm_eq_abs, abs_pow]
    exact pow_le_pow_left₀ (abs_nonneg _) (reciprocalError_abs_bound N _) 2

/-- Squared L² error against the constant -1 on (0,1). -/
noncomputable def dualMeanSquareError (N : ℕ) : ℝ :=
  ∫ x in (0 : ℝ)..1, (1 + dualApproximation N x) ^ 2

theorem dualWindowEnergy_le_total {N : ℕ} (hN : 0 < N) :
    dualWindowEnergy N ≤ dualMeanSquareError N := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hn1 : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  apply intervalIntegral.integral_mono_interval (by positivity)
    (one_div_le_one_div_of_le hn (by linarith))
    (by simpa using one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 1) hn1)
    (Eventually.of_forall fun x => sq_nonneg _)
    (dualError_sq_intervalIntegrable N 0 1)

theorem dualMeanSquareError_lower {N : ℕ} (hN : 0 < N) :
    ((mertens N : ℝ) + 1) ^ 2 / (16 * (N : ℝ)) ≤ dualMeanSquareError N :=
  (dualWindowEnergy_lower hN).trans (dualWindowEnergy_le_total hN)

/-- An explicit necessary arithmetic estimate for this particular sequence. -/
theorem mertens_sq_le_dual_error {N : ℕ} (hN : 0 < N) :
    (mertens N : ℝ) ^ 2 / (N : ℝ) ≤ 32 * dualMeanSquareError N + 2 / (N : ℝ) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hh := (div_le_iff₀ (show 0 < 16 * (N : ℝ) by positivity)).mp
    (dualMeanSquareError_lower hN)
  apply (div_le_iff₀ hn).mpr
  have he : (32 * dualMeanSquareError N + 2 / (N : ℝ)) * (N : ℝ) =
      32 * dualMeanSquareError N * (N : ℝ) + 2 := by field_simp
  rw [he]
  nlinarith [sq_nonneg ((mertens N : ℝ) + 2)]

theorem mertens_sq_normalized_tendsto_of_dual_error
    (h : Tendsto dualMeanSquareError atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0) := by
  have hi : Tendsto (fun N : ℕ => (N : ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  have hh : Tendsto (fun N : ℕ => 32 * dualMeanSquareError N + 2 / (N : ℝ))
      atTop (𝓝 0) := by
    simpa only [div_eq_mul_inv, mul_zero, add_zero] using (h.const_mul 32).add (hi.const_mul 2)
  apply squeeze_zero' (Eventually.of_forall fun N => by positivity) ?_ hh
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with N hN
  exact mertens_sq_le_dual_error hN

/-- Conditional route exclusion: the oscillation premise is visible and is
not proved or postulated as an axiom in this project. -/
theorem dual_error_not_tendsto_of_mertens_oscillation
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto dualMeanSquareError atTop (𝓝 0) := by
  exact fun h => hM (mertens_sq_normalized_tendsto_of_dual_error h)

end BuildingBlocks
