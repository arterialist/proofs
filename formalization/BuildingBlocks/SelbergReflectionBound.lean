import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.SelbergReflection
import Mathlib.MeasureTheory.Function.JacobianOneDim
import Mathlib.Algebra.QuadraticDiscriminant

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

private theorem reciprocal_maps_Icc {T : ℝ} (hT : 1 ≤ T) {t : ℝ}
    (ht : t ∈ Icc 1 T) : T / t ∈ Icc 1 T := by
  have htp : 0 < t := by linarith [ht.1]
  exact ⟨(le_div_iff₀ htp).2 (by linarith [ht.2]), div_le_self (by linarith) ht.1⟩

private theorem reciprocal_image_Icc {T : ℝ} (hT : 1 ≤ T) :
    (fun t : ℝ => T / t) '' Icc 1 T = Icc 1 T := by
  ext y
  constructor
  · rintro ⟨t, ht, rfl⟩
    exact reciprocal_maps_Icc hT ht
  · intro hy
    refine ⟨T / y, reciprocal_maps_Icc hT hy, ?_⟩
    have hTp : T ≠ 0 := by linarith
    have hyp : y ≠ 0 := by linarith [hy.1]
    field_simp

private theorem reciprocal_deriv {T : ℝ} (_hT : 1 ≤ T) :
    ∀ t ∈ Icc (1 : ℝ) T,
      HasDerivWithinAt (fun a : ℝ => T / a) (-T / t^2) (Icc 1 T) t := by
  intro t ht
  have htp : t ≠ 0 := by linarith [ht.1]
  convert ((hasDerivAt_const t T).div (hasDerivAt_id t) htp).hasDerivWithinAt using 1
  simp

private theorem reciprocal_injOn {T : ℝ} (hT : 1 ≤ T) :
    InjOn (fun t : ℝ => T / t) (Icc 1 T) := by
  intro a ha b hb hab
  have hTp : T ≠ 0 := by linarith
  have ha0 : a ≠ 0 := by linarith [ha.1]
  have hb0 : b ≠ 0 := by linarith [hb.1]
  have hh := (div_eq_div_iff ha0 hb0).mp hab
  exact (mul_left_cancel₀ hTp) hh.symm

theorem integral_reciprocal_square {T : ℝ} (hT : 1 ≤ T) (q : ℝ → ℝ) :
    (∫ a in (1 : ℝ)..T, q (T/a)^2) = T * ∫ t in (1 : ℝ)..T, q t^2/t^2 := by
  have h := integral_image_eq_integral_abs_deriv_smul measurableSet_Icc
    (reciprocal_deriv hT) (reciprocal_injOn hT) (fun t => q t^2/t^2)
  rw [reciprocal_image_Icc hT] at h
  have heq : (∫ a in Icc (1 : ℝ) T, |-T/a^2| • (q (T/a)^2/(T/a)^2)) =
      (∫ a in Icc (1 : ℝ) T, q (T/a)^2 / T) := by
    apply setIntegral_congr_fun measurableSet_Icc
    intro a ha
    have hap : a ≠ 0 := by linarith [ha.1]
    have hTp : T ≠ 0 := by linarith
    dsimp only
    rw [smul_eq_mul, abs_of_nonpos (div_nonpos_of_nonpos_of_nonneg (by linarith) (sq_nonneg a) : -T / a^2 ≤ 0)]
    field_simp
  rw [heq, integral_div] at h
  rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hT] at h
  rw [integral_Icc_eq_integral_Ioc, ← intervalIntegral.integral_of_le hT] at h
  have hTp : T ≠ 0 := by linarith
  simpa only [mul_comm] using ((eq_div_iff hTp).mp h).symm

theorem reciprocal_square_integrable {T : ℝ} (hT : 1 ≤ T) {q : ℝ → ℝ}
    (hq : IntervalIntegrable (fun t => q t^2/t^2) volume 1 T) :
    IntervalIntegrable (fun a => q (T/a)^2) volume 1 T := by
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul measurableSet_Icc
    (reciprocal_deriv hT) (reciprocal_injOn hT) (fun t => q t^2/t^2)
  rw [reciprocal_image_Icc hT] at h
  have hi := h.mp ((intervalIntegrable_iff_integrableOn_Icc_of_le hT).mp hq)
  have hj := hi.const_mul T
  apply (intervalIntegrable_iff_integrableOn_Icc_of_le hT).mpr
  apply IntegrableOn.congr_fun hj _ measurableSet_Icc
  intro a ha
  have hap : a ≠ 0 := by linarith [ha.1]
  have hTp : T ≠ 0 := by linarith
  dsimp only
  rw [smul_eq_mul, abs_of_nonpos (div_nonpos_of_nonpos_of_nonneg (by linarith) (sq_nonneg a) : -T / a^2 ≤ 0)]
  field_simp

/-- Cauchy--Schwarz on an interval, with no continuity assumption on the
functions. This version applies to the actual jump functions. -/
theorem interval_integral_mul_sq_le {f g : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : IntervalIntegrable (fun t => f t^2) volume a b)
    (hg : IntervalIntegrable (fun t => g t^2) volume a b)
    (hfg : IntervalIntegrable (fun t => f t*g t) volume a b) :
    (∫ t in a..b, f t*g t)^2 ≤
      (∫ t in a..b, f t^2) * ∫ t in a..b, g t^2 := by
  have hp : ∀ z : ℝ, 0 ≤ (∫ t in a..b, f t^2)*(z*z) +
      (-2*(∫ t in a..b, f t*g t))*z + (∫ t in a..b, g t^2) := by
    intro z
    have hn := intervalIntegral.integral_nonneg (μ := volume) hab
      (fun t _ => sq_nonneg (z*f t-g t))
    have heq : (fun t => (z*f t-g t)^2) =
        (fun t => z^2*f t^2 - (2*z)*(f t*g t) + g t^2) := by
      funext t
      ring
    rw [heq, intervalIntegral.integral_add ((hf.const_mul _).sub (hfg.const_mul _)) hg,
      intervalIntegral.integral_sub (hf.const_mul _) (hfg.const_mul _),
      intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul] at hn
    nlinarith
  have hd := discrim_le_zero hp
  unfold discrim at hd
  nlinarith

theorem primePrimitive_quotient_sq_integrable {T : ℝ} (hT : 1 ≤ T) :
    IntervalIntegrable
      (fun t => (primeErrorReal t - coarsePrefix 1 t / t)^2/t^2) volume 1 T := by
  have hz : ∀ t ∈ uIcc (1 : ℝ) T, t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hT] at ht
    linarith [ht.1]
  have hiE : IntervalIntegrable (fun t => primeErrorReal t^2/t^2) volume 1 T := by
    simpa only [div_eq_mul_inv] using
      (primeErrorReal_sq_intervalIntegrable 1 T).mul_continuousOn
        ((continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht)))
  have hiC : IntervalIntegrable
      (fun t => 2 * coarsePrefix 1 t * primeErrorReal t / t^3) volume 1 T := by
    have hc : ContinuousOn (fun t => 2 * coarsePrefix 1 t / t^3) (uIcc 1 T) :=
      (continuousOn_const.mul (coarsePrefix_continuous 1).continuousOn).div
        (continuousOn_id.pow 3) (fun t ht => pow_ne_zero _ (hz t ht))
    convert (primeErrorReal_intervalIntegrable 1 T).mul_continuousOn hc using 1
    funext t
    ring
  have hiJ : IntervalIntegrable (fun t => coarsePrefix 1 t^2/t^4) volume 1 T :=
    (((coarsePrefix_continuous 1).pow 2).continuousOn.div
      (continuousOn_id.pow 4) (fun t ht => pow_ne_zero _ (hz t ht))).intervalIntegrable
  apply IntervalIntegrable.congr _ ((hiE.sub hiC).add hiJ)
  intro t ht
  have ht0 := hz t (uIoc_subset_uIcc ht)
  dsimp only
  field_simp
  ring

theorem selberg_reflection_integrable {N : ℕ} (hN : 1 ≤ N) :
    IntervalIntegrable
      (fun a => (primeErrorReal a / a) *
        (primeErrorReal ((N : ℝ)/a) - coarsePrefix 1 ((N : ℝ)/a) / ((N : ℝ)/a)))
      volume 1 N := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hz : ∀ t ∈ uIcc (1 : ℝ) (N : ℝ), t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hNr] at ht
    linarith [ht.1]
  have hiE : IntervalIntegrable (fun a => primeErrorReal a/a^2) volume 1 N := by
    simpa only [div_eq_mul_inv] using
      (primeErrorReal_intervalIntegrable 1 (N : ℝ)).mul_continuousOn
        ((continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht)))
  have hi := (((primeError_reflected_birthMoment_integrable hN).sub
    (hiE.const_mul ((N : ℝ)^2/2))).sub
      ((primeErrorReal_intervalIntegrable 1 (N : ℝ)).div_const 2)).div_const (N : ℝ)
  apply IntervalIntegrable.congr _ hi
  intro a ha
  rw [uIoc_of_le hNr] at ha
  have hap : 0 < a := by linarith [ha.1]
  have hNp : (0 : ℝ) < N := by linarith
  have hq : 1 ≤ (N : ℝ)/a := (le_div_iff₀ hap).2 (by linarith [ha.2])
  dsimp only
  rw [primeError_sub_primitive_quotient hq]
  field_simp

/-- The Cauchy bound for the actual finite centered convolution, retaining the
strictly smaller filtered energy before using its contraction. -/
theorem selbergCenteredArea_sq_le_filtered {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N ^ 2 ≤ (N : ℝ)^3 *
      (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2) *
      (∫ t in (1 : ℝ)..(N : ℝ),
        (primeErrorReal t - coarsePrefix 1 t/t)^2/t^2) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hz : ∀ t ∈ uIcc (1 : ℝ) (N : ℝ), t ≠ 0 := by
    intro t ht
    rw [uIcc_of_le hNr] at ht
    linarith [ht.1]
  have hiF : IntervalIntegrable (fun t => (primeErrorReal t/t)^2) volume 1 N := by
    simpa only [div_pow, div_eq_mul_inv, mul_pow, inv_pow, id_eq] using
      (primeErrorReal_sq_intervalIntegrable 1 (N : ℝ)).mul_continuousOn
        ((continuousOn_id.pow 2).inv₀ (fun t ht => pow_ne_zero _ (hz t ht)))
  have hiG := reciprocal_square_integrable hNr (primePrimitive_quotient_sq_integrable hNr)
  have hc := interval_integral_mul_sq_le hNr hiF hiG (selberg_reflection_integrable hN)
  rw [integral_reciprocal_square hNr (fun t => primeErrorReal t - coarsePrefix 1 t/t)] at hc
  have hid : selbergCenteredArea N = (N : ℝ) *
      ∫ a in (1 : ℝ)..(N : ℝ), (primeErrorReal a/a) *
        (primeErrorReal ((N : ℝ)/a) - coarsePrefix 1 ((N : ℝ)/a)/((N : ℝ)/a)) := by
    rw [selbergCenteredArea_reflection hN]
    congr 1
    apply intervalIntegral.integral_congr
    intro a ha
    dsimp only
    ring
  rw [hid]
  simp only [div_pow] at hc
  have hh := mul_le_mul_of_nonneg_left hc (sq_nonneg (N : ℝ))
  nlinarith

theorem selbergCenteredArea_sq_le {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N ^ 2 ≤ (N : ℝ)^3 *
      (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2)^2 := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hV : 0 ≤ ∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2 :=
    intervalIntegral.integral_nonneg hNr (fun t _ => div_nonneg (sq_nonneg _) (sq_nonneg _))
  have hc := mul_le_mul_of_nonneg_left (primePrimitive_weighted_contraction hNr)
    (mul_nonneg (pow_nonneg (by positivity : (0 : ℝ) ≤ N) 3) hV)
  have hh := selbergCenteredArea_sq_le_filtered hN
  nlinarith

theorem abs_selbergCenteredArea_le {N : ℕ} (hN : 1 ≤ N) :
    |selbergCenteredArea N| ≤ (N : ℝ) * Real.sqrt N *
      ∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2 := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hN0 : (0 : ℝ) ≤ N := by positivity
  have hV : 0 ≤ ∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2 :=
    intervalIntegral.integral_nonneg hNr (fun t _ => div_nonneg (sq_nonneg _) (sq_nonneg _))
  apply (sq_le_sq₀ (abs_nonneg _) (mul_nonneg
    (mul_nonneg hN0 (Real.sqrt_nonneg _)) hV)).mp
  rw [sq_abs, mul_pow, mul_pow, Real.sq_sqrt hN0]
  have hh := selbergCenteredArea_sq_le hN
  nlinarith

end BuildingBlocks
