import Mathlib.Analysis.Complex.TaylorSeries
import Mathlib.Analysis.Complex.Basic
import Mathlib.Topology.Instances.ENNReal.Lemmas
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators ENNReal

namespace BuildingBlocks.PositiveTaylorMoments

/-- The nonnegative exponential-moment Taylor term. -/
noncomputable def momentTerm (m : ℕ → ℝ) (t : ℝ) (k : ℕ) : ℝ :=
  m k / (k.factorial : ℝ) * t^k

theorem momentTerm_nonneg {m : ℕ → ℝ} (hm : ∀ k, 0 ≤ m k)
    {t : ℝ} (ht : 0 ≤ t) (k : ℕ) : 0 ≤ momentTerm m t k := by
  unfold momentTerm
  exact mul_nonneg (div_nonneg (hm k) (Nat.cast_nonneg _)) (pow_nonneg ht _)

/-- Analytic Taylor convergence at the shifted point. The derivative-to-moment
identity is explicit input; no integral convergence outside a disk is assumed. -/
theorem hasSum_complex {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (ht : 0 ≤ t) (htR : t < R) :
    HasSum (fun k => (momentTerm m t k : ℂ)) (F (c - (t : ℂ))) := by
  have hz : c - (t : ℂ) ∈ Metric.ball c R := by
    simpa only [Metric.mem_ball, dist_eq_norm, sub_sub_cancel_left, norm_neg,
      Complex.norm_real, Real.norm_of_nonneg ht] using htR
  have h := Complex.hasSum_taylorSeries_on_ball hF hz
  apply h.congr_fun
  intro k
  rw [hderiv]
  simp only [smul_eq_mul, sub_sub_cancel_left, momentTerm,
    Complex.ofReal_mul, Complex.ofReal_div, Complex.ofReal_pow, Complex.ofReal_natCast]
  have hp : (-(t : ℂ))^k * (-1 : ℂ)^k = (t : ℂ)^k := by
    rw [← mul_pow]
    simp
  symm
  calc
    _ = (k.factorial : ℂ)⁻¹ * ((-(t : ℂ))^k * (-1 : ℂ)^k) * (m k : ℂ) := by ring
    _ = _ := by rw [hp]; ring

theorem hasSum_real {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (ht : 0 ≤ t) (htR : t < R) :
    HasSum (momentTerm m t) (F (c - (t : ℂ))).re := by
  simpa only [Complex.ofReal_re] using
    Complex.hasSum_re (hasSum_complex hF hderiv ht htR)

theorem summable_abs {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (ht : 0 ≤ t) (htR : t < R) :
    Summable (fun k => |momentTerm m t k|) :=
  (hasSum_real hF hderiv ht htR).summable.abs

/-- Positivity of the real value follows from the actual supplied moments. -/
theorem shifted_value_nonneg {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (hm : ∀ k, 0 ≤ m k) (ht : 0 ≤ t) (htR : t < R) :
    0 ≤ (F (c - (t : ℂ))).re := by
  rw [← (hasSum_real hF hderiv ht htR).tsum_eq]
  exact tsum_nonneg (momentTerm_nonneg hm ht)

/-- The finite ENNReal total needed for monotone exponential-moment summation. -/
theorem tsum_ofReal_lt_top {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (ht : 0 ≤ t) (htR : t < R) :
    (∑' k, ENNReal.ofReal (momentTerm m t k)) < ∞ :=
  (hasSum_real hF hderiv ht htR).summable.tsum_ofReal_lt_top

theorem tsum_ofReal_eq {F : ℂ → ℂ} {c : ℂ} {R t : ℝ} {m : ℕ → ℝ}
    (hF : DifferentiableOn ℂ F (Metric.ball c R))
    (hderiv : ∀ k, iteratedDeriv k F c = (-1 : ℂ)^k * (m k : ℂ))
    (hm : ∀ k, 0 ≤ m k) (ht : 0 ≤ t) (htR : t < R) :
    (∑' k, ENNReal.ofReal (momentTerm m t k)) =
      ENNReal.ofReal (F (c - (t : ℂ))).re := by
  rw [← ENNReal.ofReal_tsum_of_nonneg (momentTerm_nonneg hm ht)
    (hasSum_real hF hderiv ht htR).summable,
    (hasSum_real hF hderiv ht htR).tsum_eq]

end BuildingBlocks.PositiveTaylorMoments
