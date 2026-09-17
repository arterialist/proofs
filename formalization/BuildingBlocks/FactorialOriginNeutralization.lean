import BuildingBlocks.FactorialBinaryIntegrability
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.PSeries
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

open Finset
namespace BuildingBlocks.FactorialOriginNeutralization

/-- Global one-sided quadratic Taylor bound on the nonnegative real axis. -/
theorem exponential_remainder_bound (v : ℝ) (hv : 0 ≤ v) :
    |1 - Real.exp (-v) - v| ≤ v ^ 2 / 2 := by
  have hd : ∀ x : ℝ, HasDerivAt
      (fun y : ℝ => 1 - y + y^2 / 2 - Real.exp (-y))
      (x - 1 + Real.exp (-x)) x := by
    intro x
    convert (((hasDerivAt_const x (1 : ℝ)).sub (hasDerivAt_id x)).add
      (((hasDerivAt_id x).pow 2).div_const 2)).sub ((hasDerivAt_id x).neg.exp) using 1
    simp only [id_eq, Pi.neg_apply]
    ring
  have hmono := monotone_of_hasDerivAt_nonneg hd (by
    intro x
    change 0 ≤ x - 1 + Real.exp (-x)
    have h := Real.add_one_le_exp (-x)
    linarith)
  have he := hmono hv
  norm_num at he
  have hl := Real.add_one_le_exp (-v)
  rw [abs_of_nonpos (by linarith)]
  linarith

/-- An elementary finite inverse-square budget; no Möbius cancellation is assumed here. -/
theorem inverse_square_sum_le_two (N : ℕ) :
    (∑ n ∈ Icc 1 N, ((n : ℝ)^2)⁻¹) ≤ 2 := by
  have h := sum_Ioo_inv_sq_le (α := ℝ) 0 (N + 1)
  have he : Ioo 0 (N + 1) = Icc 1 N := by ext n; simp; omega
  simpa only [he, Nat.cast_zero, zero_add, div_one] using h

/-- Exact neutralization of the actual linear floor mass before absolute values. -/
theorem response_linear_neutralization (N : ℕ) (hN : 0 < N) (t : ℝ) :
    FactorialBinaryCarry.response N t = t +
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t) := by
  have hm := congrArg (fun z : ℤ => (z : ℝ)) (MertensTransfer.moebius_floor_mass hN)
  simp only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] at hm
  have he : ∀ n ∈ Icc 1 N,
      (ArithmeticFunction.moebius n : ℝ) * (1 - Real.exp (-((N / n : ℕ) : ℝ) * t)) =
      (ArithmeticFunction.moebius n : ℝ) *
        (1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t) +
      t * ((ArithmeticFunction.moebius n : ℝ) * (N / n : ℕ)) := by
    intro n hn
    ring
  unfold FactorialBinaryCarry.response
  rw [sum_congr rfl he, sum_add_distrib, ← mul_sum, hm]
  ring

theorem quotient_square_budget (N : ℕ) :
    (∑ n ∈ Icc 1 N, |(ArithmeticFunction.moebius n : ℝ)| * ((N / n : ℕ) : ℝ)^2) ≤
      2 * (N : ℝ)^2 := by
  calc
    _ ≤ ∑ n ∈ Icc 1 N, (N : ℝ)^2 * ((n : ℝ)^2)⁻¹ := by
      apply sum_le_sum
      intro n hn
      have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
        exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
      calc
        _ ≤ ((N / n : ℕ) : ℝ)^2 := by nlinarith [sq_nonneg (((N / n : ℕ) : ℝ))]
        _ ≤ ((N : ℝ) / n)^2 := pow_le_pow_left₀ (by positivity) Nat.cast_div_le 2
        _ = _ := by rw [div_pow, div_eq_mul_inv]
    _ = (N : ℝ)^2 * ∑ n ∈ Icc 1 N, ((n : ℝ)^2)⁻¹ := by rw [mul_sum]
    _ ≤ (N : ℝ)^2 * 2 := mul_le_mul_of_nonneg_left (inverse_square_sum_le_two N) (sq_nonneg _)
    _ = _ := by ring

/-- Actual response estimate that uses the complete linear arithmetic cancellation. -/
theorem response_abs_quadratic (N : ℕ) (hN : 0 < N) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤ t + (N : ℝ)^2 * t^2 := by
  rw [response_linear_neutralization N hN t]
  calc
    _ ≤ |t| + |∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (1 - Real.exp (-((N / n : ℕ) : ℝ) * t) - (N / n : ℕ) * t)| := abs_add_le _ _
    _ ≤ t + ∑ n ∈ Icc 1 N, |(ArithmeticFunction.moebius n : ℝ)| *
        (((N / n : ℕ) : ℝ) * t)^2 / 2 := by
      rw [abs_of_nonneg ht]
      apply add_le_add_left
      apply (abs_sum_le_sum_abs _ _).trans
      apply sum_le_sum
      intro n hn
      rw [abs_mul]
      have he := exponential_remainder_bound (((N / n : ℕ) : ℝ) * t) (by positivity)
      rw [← neg_mul] at he
      have hm := mul_le_mul_of_nonneg_left he (abs_nonneg (ArithmeticFunction.moebius n : ℝ))
      nlinarith
    _ = t + (t^2 / 2) * ∑ n ∈ Icc 1 N,
        |(ArithmeticFunction.moebius n : ℝ)| * ((N / n : ℕ) : ℝ)^2 := by
      rw [mul_sum]
      congr 1
      apply sum_congr rfl
      intro n hn
      ring
    _ ≤ t + (t^2 / 2) * (2 * (N : ℝ)^2) :=
      add_le_add_left (mul_le_mul_of_nonneg_left (quotient_square_budget N) (by positivity)) _
    _ = _ := by ring

/-- Uniform in every actual horizon, on the scaled clock u/N. -/
theorem response_origin_uniform (N : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 ≤ u) :
    |FactorialBinaryCarry.response N (u / N)| ≤ u / N + u^2 := by
  have hnR : (N : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hN)
  have h := response_abs_quadratic N hN (u / N) (by positivity)
  have he : (N : ℝ)^2 * (u / N)^2 = u^2 := by field_simp
  simpa only [he] using h

/-- A sharp global first-order upper bound for the full compensated density. -/
theorem weight_le_half_inverse (t : ℝ) (ht : 0 < t) :
    FactorialBinaryEnergy.weight t ≤ 1 / (2 * t) := by
  have hd : ∀ x : ℝ, HasDerivAt
      (fun y : ℝ => y - 2 + (y + 2) * Real.exp (-y))
      (1 - (x + 1) * Real.exp (-x)) x := by
    intro x
    convert ((hasDerivAt_id x).sub (hasDerivAt_const x (2 : ℝ))).add
      (((hasDerivAt_id x).add (hasDerivAt_const x (2 : ℝ))).mul
        ((hasDerivAt_id x).neg.exp)) using 1
    simp only [Pi.add_apply, id_eq, Pi.neg_apply]
    ring
  have hmono := monotone_of_hasDerivAt_nonneg hd (by
    intro x
    change 0 ≤ 1 - (x + 1) * Real.exp (-x)
    have hm := mul_le_mul_of_nonneg_right (Real.add_one_le_exp x) (Real.exp_pos (-x)).le
    simp only [← Real.exp_add, add_neg_cancel, Real.exp_zero] at hm
    linarith)
  have hg := hmono ht.le
  norm_num at hg
  have hc : (t - 2 + (t + 2) * Real.exp (-t)) * Real.exp t =
      (t - 2) * Real.exp t + t + 2 := by
    rw [add_mul, mul_assoc, ← Real.exp_add]
    simp only [neg_add_cancel, Real.exp_zero, mul_one]
    ring
  have hE : 0 ≤ (t - 2) * Real.exp t + t + 2 := by
    rw [← hc]
    exact mul_nonneg hg (Real.exp_pos t).le
  have he : 0 < Real.exp t - 1 := sub_pos.mpr (Real.one_lt_exp_iff.mpr ht)
  have hrow : FactorialBinaryEnergy.weight t =
      (Real.exp t - 1 - t) / (t^2 * (Real.exp t - 1)) := by
    unfold FactorialBinaryEnergy.weight
    field_simp
  rw [hrow]
  apply (div_le_div_iff₀ (by positivity) (by positivity)).mpr
  nlinarith [mul_nonneg ht.le hE]

/-- Full scaled clock density is bounded by a polynomial integrable at u=0. -/
theorem origin_energy_row_bound (N : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 < u) :
    FactorialBinaryEnergy.energyRow N (u / N) / N ≤
      u / (2 * (N : ℝ)^2) + u^2 / N + u^3 / 2 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hr := response_origin_uniform N hN u hu.le
  have hr2 : (FactorialBinaryCarry.response N (u / N))^2 ≤ (u / N + u^2)^2 := by
    simpa only [sq_abs] using pow_le_pow_left₀ (abs_nonneg _) hr 2
  have hw := weight_le_half_inverse (u / N) (by positivity)
  have hrow : FactorialBinaryEnergy.energyRow N (u / N) / N ≤
      (u / N + u^2)^2 / (2 * u) := by
    unfold FactorialBinaryEnergy.energyRow
    have ha := mul_le_mul_of_nonneg_left hw (sq_nonneg (FactorialBinaryCarry.response N (u / N)))
    have hb := mul_le_mul_of_nonneg_right hr2 (by positivity : 0 ≤ 1 / (2 * (u / N)))
    have hc := div_le_div_of_nonneg_right (ha.trans hb) hn.le
    have he : ((u / N + u^2)^2 * (1 / (2 * (u / N)))) / N =
        (u / N + u^2)^2 / (2 * u) := by field_simp
    simpa only [he] using hc
  apply hrow.trans_eq
  field_simp
  ring

theorem origin_polynomial_integral (N : ℕ) (U : ℝ) (hU : 0 ≤ U) :
    (∫ u in Set.Ioc 0 U, u / (2 * (N : ℝ)^2) + u^2 / N + u^3 / 2) =
      U^2 / (4 * (N : ℝ)^2) + U^3 / (3 * N) + U^4 / 8 := by
  have hd : ∀ x : ℝ, HasDerivAt
      (fun y : ℝ => y^2 / (4 * (N : ℝ)^2) + y^3 / (3 * N) + y^4 / 8)
      (x / (2 * (N : ℝ)^2) + x^2 / N + x^3 / 2) x := by
    intro x
    convert ((((hasDerivAt_id x).pow 2).div_const (4 * (N : ℝ)^2)).add
      (((hasDerivAt_id x).pow 3).div_const (3 * (N : ℝ)))).add
      (((hasDerivAt_id x).pow 4).div_const 8) using 1
    simp only [id_eq]
    ring
  have hp : Continuous (fun u : ℝ => u / (2 * (N : ℝ)^2) + u^2 / N + u^3 / 2) := by fun_prop
  rw [← intervalIntegral.integral_of_le hU,
    intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ => hd x) (hp.intervalIntegrable 0 U)]
  simp

/-- The complete scaled origin band, not only a pointwise response estimate. -/
theorem scaled_origin_energy_bound (N : ℕ) (hN : 0 < N) (U : ℝ) (hU : 0 ≤ U) :
    (∫ u in Set.Ioc 0 U, FactorialBinaryEnergy.energyRow N (u / N) / N) ≤
      U^2 / (4 * (N : ℝ)^2) + U^3 / (3 * N) + U^4 / 8 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hi : MeasureTheory.IntegrableOn
      (fun u : ℝ => FactorialBinaryEnergy.energyRow N ((1 / N : ℝ) * u)) (Set.Ioi 0) :=
    (MeasureTheory.integrableOn_Ioi_comp_mul_left_iff (FactorialBinaryEnergy.energyRow N) 0
      (by positivity : (0 : ℝ) < 1 / N)).mpr
      (by simpa only [mul_zero] using FactorialBinaryIntegrability.energyRow_integrable N)
  have hi' : MeasureTheory.IntegrableOn
      (fun u : ℝ => FactorialBinaryEnergy.energyRow N (u / N) / N) (Set.Ioc 0 U) := by
    have hj : MeasureTheory.IntegrableOn
        (fun u : ℝ => FactorialBinaryEnergy.energyRow N ((1 / N : ℝ) * u) / N) (Set.Ioi 0) :=
      hi.div_const (N : ℝ)
    have hk := hj.mono_set (by intro u hu; exact hu.1 : Set.Ioc 0 U ⊆ Set.Ioi 0)
    simpa only [one_div_mul_eq_div] using hk
  have hp : Continuous (fun u : ℝ => u / (2 * (N : ℝ)^2) + u^2 / N + u^3 / 2) := by fun_prop
  have hp' : MeasureTheory.IntegrableOn
      (fun u : ℝ => u / (2 * (N : ℝ)^2) + u^2 / N + u^3 / 2) (Set.Icc 0 U) :=
    hp.integrableOn_Icc
  have hp'' := hp'.mono_set (by intro u hu; exact ⟨hu.1.le, hu.2⟩ : Set.Ioc 0 U ⊆ Set.Icc 0 U)
  have he := MeasureTheory.integral_mono_ae hi' hp'' (by
    filter_upwards [MeasureTheory.self_mem_ae_restrict measurableSet_Ioc] with u hu
    exact origin_energy_row_bound N hN u hu.1)
  rw [origin_polynomial_integral N U hU] at he
  exact he

/-- Original full compensated energy on 0<t≤U/N, with its actual moving endpoint. -/
theorem actual_origin_energy_bound (N : ℕ) (hN : 0 < N) (U : ℝ) (hU : 0 ≤ U) :
    (∫ t in Set.Ioc 0 (U / N), FactorialBinaryEnergy.energyRow N t) ≤
      U^2 / (4 * (N : ℝ)^2) + U^3 / (3 * N) + U^4 / 8 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have he : (∫ u in Set.Ioc 0 U, FactorialBinaryEnergy.energyRow N (u / N) / N) =
      ∫ t in Set.Ioc 0 (U / N), FactorialBinaryEnergy.energyRow N t := by
    rw [← intervalIntegral.integral_of_le hU,
      ← intervalIntegral.integral_of_le (div_nonneg hU hn.le), intervalIntegral.integral_div,
      intervalIntegral.integral_comp_div _ hn.ne']
    simp only [zero_div, smul_eq_mul]
    field_simp
  have h := scaled_origin_energy_bound N hN U hU
  rw [he] at h
  exact h

/-- Unconditional full origin-band payment on each complete dyadic block. -/
theorem dyadic_origin_energy_bound (X : ℕ) (hX : 0 < X) (U : ℝ) (hU : 0 ≤ U) :
    (∑ N ∈ Ico X (2 * X), ∫ t in Set.Ioc 0 (U / N), FactorialBinaryEnergy.energyRow N t) ≤
      U^2 / (4 * (X : ℝ)) + U^3 / 3 + U^4 * X / 8 := by
  have hx : (0 : ℝ) < X := by exact_mod_cast hX
  calc
    _ ≤ ∑ N ∈ Ico X (2 * X),
        (U^2 / (4 * (X : ℝ)^2) + U^3 / (3 * X) + U^4 / 8) := by
      apply sum_le_sum
      intro N hN
      have hNX := (mem_Ico.mp hN).1
      have hn : 0 < N := hX.trans_le hNX
      have hnr : (X : ℝ) ≤ N := by exact_mod_cast hNX
      apply (actual_origin_energy_bound N hn U hU).trans
      gcongr
    _ = (X : ℝ) * (U^2 / (4 * (X : ℝ)^2) + U^3 / (3 * X) + U^4 / 8) := by
      simp only [sum_const, nsmul_eq_mul, Nat.card_Ico]
      congr 1
      norm_cast
      omega
    _ = _ := by field_simp

#print axioms dyadic_origin_energy_bound
#print axioms origin_polynomial_integral
#print axioms scaled_origin_energy_bound
#print axioms actual_origin_energy_bound
#print axioms weight_le_half_inverse
#print axioms origin_energy_row_bound
#print axioms exponential_remainder_bound
#print axioms inverse_square_sum_le_two
#print axioms response_linear_neutralization
#print axioms quotient_square_budget
#print axioms response_abs_quadratic
#print axioms response_origin_uniform
end BuildingBlocks.FactorialOriginNeutralization
