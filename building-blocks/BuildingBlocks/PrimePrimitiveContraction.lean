import BuildingBlocks.CoarsePrimeBounds

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive

theorem primeErrorReal_sq_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable (fun t => primeErrorReal t ^ 2) volume a b := by
  have hp : Monotone (fun t : ℝ => psi ⌊t⌋₊) :=
    fun _ _ h => psi_mono (Nat.floor_mono h)
  have hp2 : Monotone (fun t : ℝ => (psi ⌊t⌋₊)^2) := by
    intro x y h
    exact (sq_le_sq₀ (psi_nonneg _) (psi_nonneg _)).2 (hp h)
  have hip : IntervalIntegrable (fun t : ℝ => psi ⌊t⌋₊) volume a b := hp.intervalIntegrable
  have hip2 : IntervalIntegrable (fun t : ℝ => (psi ⌊t⌋₊)^2) volume a b :=
    hp2.intervalIntegrable
  have hi := hip2.sub
    (hip.mul_continuousOn
      (show ContinuousOn (fun t : ℝ => 2*t) (uIcc a b) by fun_prop))
  have hj := hi.add ((continuous_id.pow 2).intervalIntegrable a b)
  convert hj using 1
  funext t
  unfold primeErrorReal
  simp only [id_eq]
  ring

theorem coarsePrefix_square_weighted_parts {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, 2 * coarsePrefix 1 t * primeErrorReal t / t^3) =
      coarsePrefix 1 T ^ 2 / T^3 +
        3 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t ^ 2 / t^4 := by
  have hz : ∀ t ∈ uIcc (1 : ℝ) T, t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hT] at ht
    linarith [ht.1]
  have hv : ContinuousOn (fun t : ℝ => (t^3)⁻¹) (uIcc 1 T) :=
    (continuousOn_id.pow 3).inv₀ (fun t ht => pow_ne_zero _ (hz t ht))
  have hv' : ContinuousOn (fun t : ℝ => -3 / t^4) (uIcc 1 T) :=
    continuousOn_const.div (continuousOn_id.pow 4)
      (fun t ht => pow_ne_zero _ (hz t ht))
  have hd : ∀ t ∈ Ioo (min (1 : ℝ) T) (max (1 : ℝ) T),
      HasDerivWithinAt (fun u : ℝ => (u^3)⁻¹) (-3 / t^4) (Ioi t) t := by
    intro t ht
    have ht0 : t ≠ 0 := hz t ⟨ht.1.le, ht.2.le⟩
    have hh := ((hasDerivAt_id t).pow 3).inv (pow_ne_zero 3 ht0)
    have hh' : HasDerivAt (fun u : ℝ => (u^3)⁻¹)
        (-(3*t^2)/(t^3)^2) t := by simpa using hh
    convert hh'.hasDerivWithinAt using 1
    field_simp
  have hf' : IntervalIntegrable
      (fun t => 2 * coarsePrefix 1 t * primeErrorReal t) volume 1 T := by
    have hi := (primeErrorReal_intervalIntegrable 1 T).mul_continuousOn
      (show ContinuousOn (fun t => 2 * coarsePrefix 1 t) (uIcc 1 T) by
        exact (continuous_const.mul (coarsePrefix_continuous 1)).continuousOn)
    convert hi using 1
    funext t
    ring
  have h := intervalIntegral.integral_smul_deriv_eq_deriv_smul_of_hasDeriv_right
    ((coarsePrefix_continuous 1).pow 2).continuousOn hv
    (fun t _ => by simpa using (coarsePrefix_hasDerivWithinAt_right 1 t).pow 2)
    hd hf' hv'.intervalIntegrable
  have hzero : coarsePrefix 1 1 = 0 := by simp [coarsePrefix]
  simp only [smul_eq_mul, hzero, zero_pow (by decide : (2 : ℕ) ≠ 0),
    zero_mul, sub_zero] at h
  have heq : (fun t : ℝ => coarsePrefix 1 t ^ 2 * (-3 / t^4)) =
      (fun t => -3 * (coarsePrefix 1 t ^ 2 / t^4)) := by
    funext t
    ring
  rw [heq, intervalIntegral.integral_const_mul] at h
  simp only [← div_eq_mul_inv] at h
  linarith

theorem primePrimitive_weighted_contraction_identity {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, (primeErrorReal t - coarsePrefix 1 t / t)^2 / t^2) =
      (∫ t in (1 : ℝ)..T, primeErrorReal t ^ 2 / t^2) -
        coarsePrefix 1 T ^ 2 / T^3 -
          2 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t ^ 2 / t^4 := by
  have hz : ∀ t ∈ uIcc (1 : ℝ) T, t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hT] at ht
    linarith [ht.1]
  have hiE : IntervalIntegrable (fun t => primeErrorReal t ^ 2 / t^2) volume 1 T := by
    simpa only [div_eq_mul_inv] using
      (primeErrorReal_sq_intervalIntegrable 1 T).mul_continuousOn
        ((continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht)))
  have hiC : IntervalIntegrable
      (fun t => 2 * coarsePrefix 1 t * primeErrorReal t / t^3) volume 1 T := by
    have hc : ContinuousOn (fun t => 2 * coarsePrefix 1 t / t^3) (uIcc 1 T) :=
      (continuousOn_const.mul (coarsePrefix_continuous 1).continuousOn).div
        (continuousOn_id.pow 3) (fun t ht => pow_ne_zero _ (hz t ht))
    have hi := (primeErrorReal_intervalIntegrable 1 T).mul_continuousOn hc
    convert hi using 1
    funext t
    ring
  have hiJ : IntervalIntegrable (fun t => coarsePrefix 1 t ^ 2 / t^4) volume 1 T :=
    (((coarsePrefix_continuous 1).pow 2).continuousOn.div
      (continuousOn_id.pow 4) (fun t ht => pow_ne_zero _ (hz t ht))).intervalIntegrable
  have heq : (fun t : ℝ => (primeErrorReal t - coarsePrefix 1 t / t)^2 / t^2) =
      (fun t => primeErrorReal t ^ 2 / t^2 -
        2 * coarsePrefix 1 t * primeErrorReal t / t^3 + coarsePrefix 1 t ^ 2 / t^4) := by
    funext t
    by_cases ht : t = 0
    · simp [ht]
    · field_simp
      ring
  rw [heq, intervalIntegral.integral_add (hiE.sub hiC) hiJ,
    intervalIntegral.integral_sub hiE hiC, coarsePrefix_square_weighted_parts hT]
  ring

theorem primePrimitive_weighted_contraction {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, (primeErrorReal t - coarsePrefix 1 t / t)^2 / t^2) ≤
      ∫ t in (1 : ℝ)..T, primeErrorReal t ^ 2 / t^2 := by
  rw [primePrimitive_weighted_contraction_identity hT]
  have hJ : 0 ≤ ∫ t in (1 : ℝ)..T, coarsePrefix 1 t ^ 2 / t^4 :=
    intervalIntegral.integral_nonneg hT (fun t _ => div_nonneg (sq_nonneg _) (by positivity))
  have hEnd : 0 ≤ coarsePrefix 1 T ^ 2 / T^3 :=
    div_nonneg (sq_nonneg _) (pow_nonneg (by linarith) _)
  linarith

end BuildingBlocks
