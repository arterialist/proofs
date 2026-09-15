import BuildingBlocks.FactorialBinaryIntegrability
import BuildingBlocks.FrullaniIntegral

open Set MeasureTheory Filter
open scoped Topology

namespace BuildingBlocks.FactorialEntropyIntegral
open FactorialBinaryIntegrability

noncomputable def numerator (a b t : ℝ) : ℝ :=
  (1 - Real.exp (-a * t)) * (1 - Real.exp (-b * t))

noncomputable def integrand (a b t : ℝ) : ℝ := numerator a b t / t ^ 2

theorem numerator_bounds (a b t : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (ht : 0 ≤ t) :
    0 ≤ numerator a b t ∧ numerator a b t ≤ 1 ∧
      numerator a b t ≤ a * b * t ^ 2 := by
  have h₁ := exponential_increment_bounds a t ha ht
  have h₂ := exponential_increment_bounds b t hb ht
  unfold numerator
  refine ⟨mul_nonneg h₁.1 h₂.1, ?_, ?_⟩
  · simpa using mul_le_mul h₁.2.1 h₂.2.1 h₂.1 (by norm_num : (0 : ℝ) ≤ 1)
  · have h := mul_le_mul h₁.2.2 h₂.2.2 h₂.1 (mul_nonneg ha ht)
    nlinarith

theorem integrand_majorant (a b t : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (ht : 0 < t) :
    integrand a b t ≤ 2 * (a * b + 1) * (1 + t ^ 2)⁻¹ := by
  have hn := numerator_bounds a b t ha hb ht.le
  have ht2 : 0 < t ^ 2 := sq_pos_of_pos ht
  have hd : 0 < 1 + t ^ 2 := by positivity
  have hab : 0 ≤ a * b := mul_nonneg ha hb
  unfold integrand
  rw [← div_eq_mul_inv]
  by_cases hs : t ≤ 1
  · have hfirst : numerator a b t / t ^ 2 ≤ a * b := by
      exact (div_le_iff₀ ht2).mpr hn.2.2
    apply hfirst.trans
    apply (le_div_iff₀ hd).mpr
    have hs2 : t ^ 2 ≤ 1 := by nlinarith
    have hp := mul_le_mul_of_nonneg_left hs2 hab
    nlinarith
  · apply (div_le_div_of_nonneg_right hn.2.1 ht2.le).trans
    apply (div_le_div_iff₀ ht2 hd).mpr
    have hs2 : 1 ≤ t ^ 2 := by nlinarith
    have hp : 0 ≤ a * b * t ^ 2 := by positivity
    nlinarith

theorem entropy_integrable (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    IntegrableOn (integrand a b) (Ioi 0) := by
  have hc : ContinuousOn (integrand a b) (Ioi 0) := by
    intro t ht
    unfold integrand numerator
    apply ContinuousAt.continuousWithinAt
    have ht0 : t ^ 2 ≠ 0 := ne_of_gt (sq_pos_of_pos ht)
    fun_prop (disch := aesop)
  have hi : Integrable (fun t : ℝ => 2 * (a * b + 1) * (1 + t ^ 2)⁻¹) :=
    integrable_inv_one_add_sq.const_mul _
  apply hi.integrableOn.mono' (hc.aestronglyMeasurable measurableSet_Ioi)
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
  rw [Real.norm_eq_abs, abs_of_nonneg (by
    unfold integrand
    exact div_nonneg (numerator_bounds a b t ha hb ht.le).1 (sq_nonneg t))]
  exact integrand_majorant a b t ha hb ht

theorem quotient_bounds (a b t : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (ht : 0 ≤ t) :
    0 ≤ numerator a b t / t ∧ numerator a b t / t ≤ a * b * t := by
  have hn := numerator_bounds a b t ha hb ht
  refine ⟨div_nonneg hn.1 ht, ?_⟩
  rcases ht.eq_or_lt with rfl | ht
  · simp
  · apply (div_le_iff₀ ht).mpr
    nlinarith [hn.2.2]

theorem quotient_continuous_origin (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    ContinuousWithinAt (fun t => numerator a b t / t) (Ici 0) 0 := by
  change Filter.Tendsto (fun t => numerator a b t / t) (nhdsWithin 0 (Ici 0))
    (𝓝 (numerator a b 0 / 0))
  simp only [div_zero]
  apply squeeze_zero' (g := fun t => a * b * t) ?_ ?_ (by
    simpa using ((tendsto_const_nhds : Tendsto (fun _ : ℝ => a * b) (𝓝 0) (𝓝 (a * b))).mul tendsto_id).mono_left
      (nhdsWithin_le_nhds : nhdsWithin (0 : ℝ) (Ici 0) ≤ 𝓝 0))
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact (quotient_bounds a b t ha hb ht).1
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact (quotient_bounds a b t ha hb ht).2

theorem quotient_tendsto_infinity (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    Filter.Tendsto (fun t => numerator a b t / t) Filter.atTop (𝓝 0) := by
  apply squeeze_zero' (g := fun t : ℝ => 1 / t) ?_ ?_ (by simpa only [one_div] using tendsto_inv_atTop_zero)
  · filter_upwards [Filter.eventually_gt_atTop (0 : ℝ)] with t ht
    exact (quotient_bounds a b t ha hb ht.le).1
  · filter_upwards [Filter.eventually_gt_atTop (0 : ℝ)] with t ht
    exact div_le_div_of_nonneg_right (numerator_bounds a b t ha hb ht.le).2.1 ht.le

noncomputable def derivativeRow (a b t : ℝ) : ℝ :=
  a * ((Real.exp (-a * t) - Real.exp (-(a + b) * t)) / t) +
  b * ((Real.exp (-b * t) - Real.exp (-(a + b) * t)) / t)

theorem quotient_hasDerivAt (a b t : ℝ) (ht : 0 < t) :
    HasDerivAt (fun t => numerator a b t / t)
      (derivativeRow a b t - integrand a b t) t := by
  have h₁ := ((hasDerivAt_id t).const_mul (-a)).exp
  have h₂ := ((hasDerivAt_id t).const_mul (-b)).exp
  have h := ((h₁.const_sub 1).mul (h₂.const_sub 1)).div (hasDerivAt_id t) (ne_of_gt ht)
  have he : Real.exp (-(a + b) * t) = Real.exp (-a * t) * Real.exp (-b * t) := by
    rw [← Real.exp_add]
    congr 1
    ring
  convert h using 1
  unfold derivativeRow integrand numerator
  rw [he]
  dsimp only [id_eq, Pi.mul_apply]
  field_simp

theorem derivativeRow_integrable (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    IntegrableOn (derivativeRow a b) (Ioi 0) := by
  exact ((FrullaniIntegral.frullani_integrable a (a + b) ha (by linarith)).const_mul a).add
    ((FrullaniIntegral.frullani_integrable b (a + b) hb (by linarith)).const_mul b)

theorem entropy_integral (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    (∫ t in Ioi 0, integrand a b t) =
      (a + b) * Real.log (a + b) - a * Real.log a - b * Real.log b := by
  have hd := derivativeRow_integrable a b ha hb
  have hi := entropy_integrable a b ha.le hb.le
  have h := integral_Ioi_of_hasDerivAt_of_tendsto
    (quotient_continuous_origin a b ha.le hb.le)
    (fun t ht => quotient_hasDerivAt a b t ht) (hd.sub hi)
    (quotient_tendsto_infinity a b ha.le hb.le)
  rw [integral_sub hd hi] at h
  have hr : (∫ t in Ioi 0, derivativeRow a b t) =
      a * Real.log ((a + b) / a) + b * Real.log ((a + b) / b) := by
    unfold derivativeRow
    rw [integral_add ((FrullaniIntegral.frullani_integrable a (a + b) ha (by linarith)).const_mul a)
      ((FrullaniIntegral.frullani_integrable b (a + b) hb (by linarith)).const_mul b),
      integral_const_mul, integral_const_mul,
      FrullaniIntegral.frullani a (a + b) ha (by linarith),
      FrullaniIntegral.frullani b (a + b) hb (by linarith)]
  rw [hr, div_zero] at h
  rw [Real.log_div (by linarith) (ne_of_gt ha),
    Real.log_div (by linarith) (ne_of_gt hb)] at h
  linarith

theorem entropy_integral_nat (n m : ℕ) :
    (∫ t in Ioi 0, integrand n m t) =
      ((n : ℝ) + m) * Real.log ((n : ℝ) + m) -
        (n : ℝ) * Real.log n - (m : ℝ) * Real.log m := by
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · simp [integrand, numerator]
  rcases Nat.eq_zero_or_pos m with rfl | hm
  · simp [integrand, numerator]
  exact entropy_integral n m (by exact_mod_cast hn) (by exact_mod_cast hm)

#print axioms entropy_integral_nat

#print axioms quotient_hasDerivAt
#print axioms derivativeRow_integrable
#print axioms entropy_integral

#print axioms quotient_bounds
#print axioms quotient_continuous_origin
#print axioms quotient_tendsto_infinity

#print axioms numerator_bounds
#print axioms integrand_majorant
#print axioms entropy_integrable

end BuildingBlocks.FactorialEntropyIntegral
