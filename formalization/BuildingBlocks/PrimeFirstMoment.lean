import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.PrimePrimitiveFormula
import BuildingBlocks.WeightedPrimePowers

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The exact finite first Mellin moment of the physical prime error. The term
`psi N / N` is retained; its limiting contribution is one. -/
theorem primeError_first_moment {N : ℕ} (hN : 1 ≤ N) :
    (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t / t ^ 2) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le zero_lt_one hNr
  have hr : ∀ t : ℝ, t ^ (-(1 : ℝ) - 1) = (t ^ 2)⁻¹ := by
    intro t
    rw [show -(1 : ℝ) - 1 = -(2 : ℕ) by norm_num,
      Real.rpow_neg_natCast, zpow_neg, zpow_natCast]
  have hw := weighted_vonMangoldt_abel hN (1 : ℝ)
  simp only [Real.rpow_neg_one, hr, one_mul] at hw
  have hp : IntervalIntegrable (fun t : ℝ => psi ⌊t⌋₊ / t ^ 2) volume 1 N := by
    have hh := rpow_psi_intervalIntegrable hN (-(1 : ℝ) - 1)
    simpa only [hr, div_eq_mul_inv, mul_comm] using hh
  have hz : ∀ t ∈ Set.uIcc (1 : ℝ) (N : ℝ), t ≠ 0 := by
    intro t ht
    rw [Set.uIcc_of_le hNr] at ht
    linarith [ht.1]
  have hi : IntervalIntegrable (fun t : ℝ => t⁻¹) volume 1 N :=
    (continuousOn_id.inv₀ hz).intervalIntegrable
  have heq : (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t / t ^ 2) =
      ∫ t in (1 : ℝ)..(N : ℝ), psi ⌊t⌋₊ / t ^ 2 - t⁻¹ := by
    apply intervalIntegral.integral_congr
    intro t ht
    have ht0 := hz t ht
    unfold primeErrorReal
    field_simp
  rw [heq, intervalIntegral.integral_sub hp hi,
    integral_inv_of_pos zero_lt_one hNp, div_one]
  have he : (∫ t in (1 : ℝ)..(N : ℝ), psi ⌊t⌋₊ / t ^ 2) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) := by
    simp only [div_eq_mul_inv, mul_comm] at hw ⊢
    linarith
  rw [he]

/-- Integration by parts retains the terminal primitive before taking any
limit. Integer jumps are handled by the existing right-derivative theorem. -/
theorem coarsePrefix_first_moment {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, primeErrorReal t / t ^ 2) =
      coarsePrefix 1 T / T ^ 2 +
        2 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t / t ^ 3 := by
  have hz : ∀ t ∈ Set.uIcc (1 : ℝ) T, t ≠ 0 := by
    intro t ht
    rw [Set.uIcc_of_le hT] at ht
    linarith [ht.1]
  have hv : ContinuousOn (fun t : ℝ => (t ^ 2)⁻¹) (Set.uIcc 1 T) :=
    (continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht))
  have hv' : ContinuousOn (fun t : ℝ => -2 / t ^ 3) (Set.uIcc 1 T) :=
    continuousOn_const.div (continuousOn_id.pow 3)
      (fun t ht => pow_ne_zero _ (hz t ht))
  have hd : ∀ t ∈ Ioo (min (1 : ℝ) T) (max (1 : ℝ) T),
      HasDerivWithinAt (fun t : ℝ => (t ^ 2)⁻¹) (-2 / t ^ 3) (Ioi t) t := by
    intro t ht
    have ht0 : t ≠ 0 := hz t ⟨ht.1.le, ht.2.le⟩
    have hh := ((hasDerivAt_id t).pow 2).inv (pow_ne_zero 2 ht0)
    have hh' : HasDerivAt (fun u : ℝ => (u ^ 2)⁻¹)
        (-(2 * t) / (t ^ 2) ^ 2) t := by
      simpa using hh
    convert hh'.hasDerivWithinAt using 1
    field_simp
    <;> ring
  have h := intervalIntegral.integral_smul_deriv_eq_deriv_smul_of_hasDeriv_right
    (coarsePrefix_continuous 1).continuousOn hv
    (fun t _ => coarsePrefix_hasDerivWithinAt_right 1 t) hd
    (primeErrorReal_intervalIntegrable 1 T) hv'.intervalIntegrable
  have hzero : coarsePrefix 1 1 = 0 := by simp [coarsePrefix]
  simp only [smul_eq_mul, hzero, zero_mul, sub_zero] at h
  have hf : (fun t : ℝ => coarsePrefix 1 t * (-2 / t ^ 3)) =
      (fun t : ℝ => -2 * (coarsePrefix 1 t / t ^ 3)) := by
    funext t
    ring
  rw [hf, intervalIntegral.integral_const_mul] at h
  simp only [← div_eq_mul_inv] at h
  linarith

/-- Exact finite moment of the actual primitive in finite arithmetic form. -/
theorem primePrimitive_first_moment {N : ℕ} (hN : 1 ≤ N) :
    2 * (∫ t in (1 : ℝ)..(N : ℝ), coarsePrefix 1 t / t ^ 3) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ) - coarsePrefix 1 N / (N : ℝ) ^ 2 := by
  have h := coarsePrefix_first_moment (T := N) (by exact_mod_cast hN)
  rw [primeError_first_moment hN] at h
  linarith

end BuildingBlocks
