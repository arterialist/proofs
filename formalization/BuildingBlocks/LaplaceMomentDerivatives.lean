import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open MeasureTheory Filter Set
open scoped Topology

namespace BuildingBlocks.LaplaceMomentDerivatives

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

noncomputable def integrand (τ : α → ℝ) (k : ℕ) (z : ℂ) (x : α) : ℂ :=
  (τ x : ℂ)^k * Complex.exp (-z * (τ x : ℂ))

noncomputable def moment (μ : Measure α) (τ : α → ℝ) (k : ℕ) (z : ℂ) : ℂ :=
  ∫ x, integrand τ k z x ∂μ

theorem pow_mul_exp_bound {y δ b c : ℝ} (hy : 0 ≤ y) (hδ : 0 < δ)
    (hbc : b + δ ≤ c) (k : ℕ) :
    y^k * Real.exp (-c*y) ≤ (k.factorial : ℝ) / δ^k * Real.exp (-b*y) := by
  have hd : 0 < δ^k := pow_pos hδ k
  have hf : (0 : ℝ) < k.factorial := by positivity
  have hp := Real.pow_div_factorial_le_exp (δ*y) (mul_nonneg hδ.le hy) k
  rw [div_le_iff₀ hf, mul_pow] at hp
  have hp' : y^k ≤ (k.factorial : ℝ) / δ^k * Real.exp (δ*y) := by
    calc
      y^k ≤ (Real.exp (δ*y) * (k.factorial : ℝ)) / δ^k :=
        (le_div_iff₀ hd).mpr (by nlinarith [hp])
      _ = _ := by ring
  calc
    _ ≤ ((k.factorial : ℝ) / δ^k * Real.exp (δ*y)) * Real.exp (-c*y) :=
      mul_le_mul_of_nonneg_right hp' (Real.exp_nonneg _)
    _ = (k.factorial : ℝ) / δ^k * Real.exp ((δ-c)*y) := by
      rw [mul_assoc, ← Real.exp_add]
      congr 2
      ring
    _ ≤ _ := by
      gcongr
      nlinarith

theorem measurable_integrand {τ : α → ℝ} (hτ : Measurable τ) (k : ℕ) (z : ℂ) :
    Measurable (integrand τ k z) := by
  have hc := Complex.measurable_ofReal.comp hτ
  exact (hc.pow_const k).mul (Complex.continuous_exp.measurable.comp (measurable_const.mul hc))

omit [MeasurableSpace α] in
theorem norm_integrand {τ : α → ℝ} {x : α} (hx : 0 ≤ τ x) (k : ℕ) (z : ℂ) :
    ‖integrand τ k z x‖ = (τ x)^k * Real.exp (-z.re * τ x) := by
  simp [integrand, norm_pow, Complex.norm_real, Real.norm_of_nonneg hx,
    Complex.norm_exp]

theorem integrable_integrand {τ : α → ℝ} (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) {b : ℝ}
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ)
    {z : ℂ} (hz : b < z.re) (k : ℕ) : Integrable (integrand τ k z) μ := by
  have hd : 0 < z.re - b := sub_pos.mpr hz
  apply (hb.const_mul ((k.factorial : ℝ) / (z.re-b)^k)).mono'
    (measurable_integrand hτ k z).aestronglyMeasurable
  filter_upwards [hτ0] with x hx
  rw [norm_integrand hx]
  exact pow_mul_exp_bound hx hd (by linarith) k

omit [MeasurableSpace α] in
theorem hasDerivAt_integrand (τ : α → ℝ) (k : ℕ) (z : ℂ) (x : α) :
    HasDerivAt (fun w => integrand τ k w x) (-integrand τ (k+1) z x) z := by
  have h := ((((hasDerivAt_id z).neg).mul_const (τ x : ℂ)).cexp).const_mul
    ((τ x : ℂ)^k)
  convert h using 1
  simp only [integrand, pow_succ, Pi.neg_apply, id_eq]
  ring

/-- Differentiation at an interior point follows from one lower convergent
real parameter; its derivative is the next actual moment with a minus sign. -/
theorem hasDerivAt_moment {τ : α → ℝ} (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) {b : ℝ}
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ)
    {z : ℂ} (hz : b < z.re) (k : ℕ) :
    HasDerivAt (moment μ τ k) (-moment μ τ (k+1) z) z := by
  let δ : ℝ := (z.re-b)/2
  have hd : 0 < δ := by dsimp [δ]; linarith
  let C : ℝ := ((k+1).factorial : ℝ) / δ^(k+1)
  have hmeas : ∀ᶠ w in 𝓝 z, AEStronglyMeasurable (integrand τ k w) μ :=
    Filter.Eventually.of_forall fun w => (measurable_integrand hτ k w).aestronglyMeasurable
  have hdmeas : AEStronglyMeasurable (fun x => -integrand τ (k+1) z x) μ :=
    (measurable_integrand hτ (k+1) z).neg.aestronglyMeasurable
  have hbound : ∀ᵐ x ∂μ, ∀ w ∈ Metric.ball z δ,
      ‖-integrand τ (k+1) w x‖ ≤ C * Real.exp (-b * τ x) := by
    filter_upwards [hτ0] with x hx w hw
    have hn : ‖z-w‖ < δ := by simpa [dist_eq_norm, norm_sub_rev] using hw
    have hr := Complex.re_le_norm (z-w)
    simp only [Complex.sub_re] at hr
    rw [norm_neg, norm_integrand hx]
    exact pow_mul_exp_bound hx hd (by dsimp [δ] at *; linarith) (k+1)
  have hdiff : ∀ᵐ x ∂μ, ∀ w ∈ Metric.ball z δ,
      HasDerivAt (fun u => integrand τ k u x) (-integrand τ (k+1) w x) w :=
    Filter.Eventually.of_forall fun x w _ => hasDerivAt_integrand τ k w x
  have h := hasDerivAt_integral_of_dominated_loc_of_deriv_le hd hmeas
    (integrable_integrand hτ hτ0 hb hz k) hdmeas hbound (hb.const_mul C) hdiff
  simpa only [moment, integral_neg] using h.2

/-- All derivative orders are obtained by differentiation on the open
half-plane of convergence, rather than by postulating moment identities. -/
theorem iteratedDeriv_moment_zero {τ : α → ℝ} (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) {b : ℝ}
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ)
    (k : ℕ) {z : ℂ} (hz : b < z.re) :
    iteratedDeriv k (moment μ τ 0) z = (-1 : ℂ)^k * moment μ τ k z := by
  induction k generalizing z with
  | zero => simp
  | succ k ih =>
    rw [iteratedDeriv_succ]
    have he : iteratedDeriv k (moment μ τ 0) =ᶠ[𝓝 z]
        (fun w => (-1 : ℂ)^k * moment μ τ k w) := by
      have hn : {w : ℂ | b < w.re} ∈ 𝓝 z :=
        (isOpen_lt continuous_const Complex.continuous_re).mem_nhds hz
      filter_upwards [hn] with w hw
      exact ih hw
    rw [he.deriv_eq, ((hasDerivAt_moment hτ hτ0 hb hz k).const_mul ((-1 : ℂ)^k)).deriv]
    rw [pow_succ]
    ring

theorem moment_ofReal (τ : α → ℝ) (k : ℕ) (c : ℝ) :
    moment μ τ k (c : ℂ) =
      ((∫ x, (τ x)^k * Real.exp (-c * τ x) ∂μ : ℝ) : ℂ) := by
  have he (x : α) : integrand τ k (c : ℂ) x =
      (((τ x)^k * Real.exp (-c * τ x) : ℝ) : ℂ) := by
    simp [integrand, Complex.ofReal_exp]
  simp_rw [moment, he]
  exact integral_ofReal

theorem integrable_real_moment {τ : α → ℝ} (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) {b c : ℝ}
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ) (hc : b < c) (k : ℕ) :
    Integrable (fun x => (τ x)^k * Real.exp (-c * τ x)) μ := by
  have h := (integrable_integrand hτ hτ0 hb (z := (c : ℂ)) (by simpa using hc) k).re
  simpa [integrand, ← Complex.ofReal_pow, Complex.exp_re] using h

theorem real_moment_nonneg {τ : α → ℝ} (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (k : ℕ) (c : ℝ) :
    0 ≤ ∫ x, (τ x)^k * Real.exp (-c * τ x) ∂μ := by
  apply integral_nonneg_of_ae
  filter_upwards [hτ0] with x hx
  positivity

/-- Exact interface for the positive Taylor-moment theorem at a real center. -/
theorem iteratedDeriv_moment_zero_ofReal {τ : α → ℝ} (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) {b c : ℝ}
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ) (hc : b < c) (k : ℕ) :
    iteratedDeriv k (moment μ τ 0) (c : ℂ) = (-1 : ℂ)^k *
      ((∫ x, (τ x)^k * Real.exp (-c * τ x) ∂μ : ℝ) : ℂ) := by
  rw [iteratedDeriv_moment_zero hτ hτ0 hb k (by simpa using hc), moment_ofReal]

end BuildingBlocks.LaplaceMomentDerivatives
