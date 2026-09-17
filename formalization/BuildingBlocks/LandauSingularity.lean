import BuildingBlocks.LaplaceConvergenceAbscissa
import BuildingBlocks.LaplaceMomentDerivatives
import BuildingBlocks.LocalLandauExtension

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.LandauSingularity

/-- Moving the center to the right spends exactly the displacement in radius. -/
theorem shifted_ball_subset (a R δ : ℝ) (hδ : 0 ≤ δ) :
    Metric.ball ((a + δ : ℝ) : ℂ) (R - δ) ⊆ Metric.ball (a : ℂ) R := by
  apply Metric.ball_subset_ball'
  have hd : dist ((a + δ : ℝ) : ℂ) (a : ℂ) = δ := by
    rw [dist_eq_norm, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
    simp [abs_of_nonneg hδ]
  rw [hd]
  linarith

/-- Agreement on the right portion of the original disk gives an actual germ
at an interior real center, without any value at the boundary. -/
theorem extension_germ {F L : ℂ → ℂ} {a R δ : ℝ}
    (hδ : 0 < δ) (hδR : δ < R)
    (heq : ∀ z ∈ Metric.ball (a : ℂ) R, a < z.re → F z = L z) :
    F =ᶠ[𝓝 ((a + δ : ℝ) : ℂ)] L := by
  have hc : ((a + δ : ℝ) : ℂ) ∈ Metric.ball (a : ℂ) R := by
    simpa only [Metric.mem_ball, dist_eq_norm, ← Complex.ofReal_sub,
      Complex.norm_real, Real.norm_eq_abs, add_sub_cancel_left, abs_of_pos hδ] using hδR
  have hhalf : {z : ℂ | a < z.re} ∈ 𝓝 ((a + δ : ℝ) : ℂ) :=
    (isOpen_lt continuous_const Complex.continuous_re).mem_nhds (by
      simp only [Set.mem_setOf_eq, Complex.ofReal_re]
      linarith)
  filter_upwards [Metric.isOpen_ball.mem_nhds hc, hhalf] with z hz hza
  exact heq z hz hza

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} {τ : α → ℝ}

/-- A finite abscissa of a positive Laplace integral cannot have a holomorphic
extension agreeing with the integral on the right portion of a disk. -/
theorem finite_abscissa_singular (hτ : Measurable τ)
    (hτ0 : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ))
    {R : ℝ} (hR : 0 < R) {F : ℂ → ℂ}
    (hF : DifferentiableOn ℂ F (Metric.ball
      ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R))
    (heq : ∀ z ∈ Metric.ball
      ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R,
      sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re →
      F z = LaplaceMomentDerivatives.moment μ τ 0 z) : False := by
  let a : ℝ := sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ)
  let δ : ℝ := R / 8
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have hδR : δ < R := by dsimp [δ]; linarith
  have hb : Integrable (fun y => Real.exp (-(a + δ / 2) * τ y)) μ :=
    LaplaceConvergenceAbscissa.integrable_above_inf μ τ hτ hτ0 hne hbdd (by
      change a < a + δ / 2
      linarith)
  have hFc : DifferentiableOn ℂ F (Metric.ball ((a + δ : ℝ) : ℂ) (R - δ)) :=
    hF.mono (shifted_ball_subset a R δ hδ.le)
  have hgerm : F =ᶠ[𝓝 ((a + δ : ℝ) : ℂ)] LaplaceMomentDerivatives.moment μ τ 0 :=
    extension_germ hδ hδR heq
  have hleft : Integrable (fun y => Real.exp (-((a + δ) - 2 * δ) * τ y)) μ :=
    LocalLandauExtension.integrable_of_analytic_germ hτ hτ0 hb
      (show a + δ / 2 < a + δ by linarith) hFc hgerm
      (show 0 ≤ 2 * δ by linarith) (show 2 * δ < R - δ by dsimp [δ]; linarith)
  exact (LaplaceConvergenceAbscissa.not_integrable_below_inf μ τ hτ hbdd (by
    change (a + δ) - 2 * δ < a
    linarith)) hleft

theorem no_holomorphic_extension (hτ : Measurable τ)
    (hτ0 : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ)) :
    ¬ ∃ (R : ℝ) (F : ℂ → ℂ), 0 < R ∧
      DifferentiableOn ℂ F (Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R) ∧
      (∀ z ∈ Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R,
        sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re →
        F z = LaplaceMomentDerivatives.moment μ τ 0 z) := by
  rintro ⟨R, F, hR, hF, heq⟩
  exact finite_abscissa_singular hτ hτ0 hne hbdd hR hF heq

end BuildingBlocks.LandauSingularity
