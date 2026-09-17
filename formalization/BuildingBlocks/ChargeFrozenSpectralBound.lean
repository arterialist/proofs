import BuildingBlocks.ChargeFrozenFourier
import BuildingBlocks.WeightedPrimePowers

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenSpectralBound

open ChargeFrozenFourier ChargeFrozenSource

theorem norm_mellin_atom {x : ℝ} (hx : 0 < x) (ξ : ℝ) :
    ‖(x : ℂ) ^ (-w ξ)‖ = x ^ (-(1 / 2 : ℝ)) := by
  rw [real_cpow_eq_exp_log hx, Complex.norm_exp, Real.rpow_def_of_pos hx]
  congr 1
  norm_num [w, Complex.mul_re, Complex.mul_im]
  ring

theorem norm_prime_sum_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)‖ ≤ (8 * Real.log 2) * (N : ℝ) ^ (1 / 2 : ℝ) := by
  calc
    _ ≤ ∑ n ∈ Finset.Icc 2 N, ‖(ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)‖ := norm_sum_le _ _
    _ = ∑ n ∈ Finset.Icc 2 N, (n : ℝ) ^ (-(1 / 2 : ℝ)) *
        ArithmeticFunction.vonMangoldt n := by
      apply Finset.sum_congr rfl
      intro n hn
      have hnp : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by
        have := (Finset.mem_Icc.mp hn).1; omega)
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
        abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
      have he := norm_mellin_atom hnp ξ
      push_cast at he
      rw [he, mul_comm]
    _ ≤ ∑ n ∈ Finset.Icc 1 N, (n : ℝ) ^ (-(1 / 2 : ℝ)) *
        ArithmeticFunction.vonMangoldt n := by
      apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.Icc_subset_Icc (by omega) le_rfl)
      intro n _ _
      exact mul_nonneg (Real.rpow_nonneg (Nat.cast_nonneg _) _) ArithmeticFunction.vonMangoldt_nonneg
    _ ≤ _ := by
      have hh := weighted_vonMangoldt_le (N := N) (by omega)
        (r := (1 / 2 : ℝ)) (by norm_num) (by norm_num)
      norm_num [div_eq_mul_inv] at hh
      nlinarith [hh]

theorem norm_density_integral_le {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    ‖∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)‖ ≤
      2 * ((N : ℝ) ^ (1 / 2 : ℝ) - 1) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  calc
    _ ≤ ∫ x : ℝ in (1 : ℝ)..(N : ℝ), ‖(x : ℂ) ^ (-w ξ)‖ :=
      intervalIntegral.norm_integral_le_integral_norm hNr
    _ = ∫ x : ℝ in (1 : ℝ)..(N : ℝ), x ^ (-(1 / 2 : ℝ)) := by
      apply intervalIntegral.integral_congr
      intro x hx
      rw [uIcc_of_le hNr] at hx
      exact norm_mellin_atom (by linarith [hx.1]) ξ
    _ = _ := by
      rw [integral_rpow (Or.inl (by norm_num : -1 < -(1 / 2 : ℝ)))]
      norm_num
      ring

theorem norm_mellin_numerator_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)) -
      (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))‖ ≤
      (8 * Real.log 2 + 2) * (N : ℝ) ^ (1 / 2 : ℝ) := by
  have hp := norm_prime_sum_le hN ξ
  have hd := norm_density_integral_le (N := N) (by omega) ξ
  have ht := norm_sub_le (-1 + (∑ n ∈ Finset.Icc 2 N,
    (ArithmeticFunction.vonMangoldt n : ℂ) * (n : ℂ) ^ (-w ξ)))
    (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))
  have ha := norm_add_le (-1 : ℂ) (∑ n ∈ Finset.Icc 2 N,
    (ArithmeticFunction.vonMangoldt n : ℂ) * (n : ℂ) ^ (-w ξ))
  norm_num only [norm_neg, norm_one] at ha
  nlinarith

theorem w_norm_sq (ξ : ℝ) : ‖w ξ‖ ^ 2 = 1 / 4 + ξ ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  norm_num [w]
  ring

/-- A uniform, unconditional envelope for every real frequency of the actual
frozen source. No cutoff in frequency or prime powers is introduced. -/
theorem fourier_norm_sq_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ)‖ ^ 2 ≤
      4 * (8 * Real.log 2 + 2) ^ 2 * (N : ℝ) / (1 + ξ ^ 2) := by
  let B : ℝ := (8 * Real.log 2 + 2) ^ 2 * (N : ℝ)
  have hB : 0 ≤ B := mul_nonneg (sq_nonneg _) (Nat.cast_nonneg _)
  have hn := norm_mellin_numerator_le hN ξ
  rw [← Real.sqrt_eq_rpow] at hn
  have hc : 0 ≤ 8 * Real.log 2 + 2 := by positivity
  have hs := Real.sq_sqrt (Nat.cast_nonneg N : (0 : ℝ) ≤ N)
  have hq : ‖-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)) -
      (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))‖ ^ 2 ≤ B := by
    have hz := norm_nonneg (-1 + (∑ n ∈ Finset.Icc 2 N,
      (ArithmeticFunction.vonMangoldt n : ℂ) * (n : ℂ) ^ (-w ξ)) -
      (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)))
    dsimp only [B]
    nlinarith [Real.sqrt_nonneg (N : ℝ)]
  have hd : 0 < 1 / 4 + ξ ^ 2 := by nlinarith [sq_nonneg ξ]
  calc
    _ = ‖-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))‖ ^ 2 /
        (1 / 4 + ξ ^ 2) := by
      rw [causalSource_fourier_mellin hN, norm_div, div_pow, w_norm_sq]
    _ ≤ B / (1 / 4 + ξ ^ 2) := div_le_div_of_nonneg_right hq hd.le
    _ ≤ 4 * B / (1 + ξ ^ 2) := by
      apply (div_le_div_iff₀ hd (by positivity : 0 < 1 + ξ ^ 2)).mpr
      nlinarith [mul_nonneg hB (sq_nonneg ξ)]
    _ = _ := by dsimp only [B]; ring

#print axioms norm_mellin_atom
#print axioms norm_prime_sum_le
#print axioms norm_density_integral_le
#print axioms norm_mellin_numerator_le
#print axioms w_norm_sq
#print axioms fourier_norm_sq_le

end BuildingBlocks.ChargeFrozenSpectralBound
