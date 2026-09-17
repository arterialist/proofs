import BuildingBlocks.LaplaceConvergenceAbscissa
import BuildingBlocks.LaplaceMomentDerivatives
import Mathlib.Analysis.Complex.CauchyIntegral

open MeasureTheory Set

namespace BuildingBlocks.LaplaceConvergenceAnalytic

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} {τ : α → ℝ}

/-- Every point strictly right of the finite infimum has a lower convergent
real parameter, which supplies the actual dominated Laplace derivative. -/
theorem hasDerivAt_above_inf (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ))
    {z : ℂ} (hz : sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re) :
    HasDerivAt (LaplaceMomentDerivatives.moment μ τ 0)
      (-LaplaceMomentDerivatives.moment μ τ 1 z) z := by
  let a : ℝ := sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ)
  let b : ℝ := (a + z.re)/2
  have hab : a < b := by dsimp [a, b]; linarith
  have hbz : b < z.re := by dsimp [a, b]; linarith
  have hb := LaplaceConvergenceAbscissa.integrable_above_inf μ τ hτ hτ0 hne hbdd hab
  exact LaplaceMomentDerivatives.hasDerivAt_moment hτ hτ0 hb hbz 0

/-- Holomorphy is proved for the integral itself, without an analytic
continuation assumption or any assertion at the convergence boundary. -/
theorem analyticOnNhd_above_inf (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ)) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment μ τ 0)
      {z : ℂ | sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re} := by
  have hd : DifferentiableOn ℂ (LaplaceMomentDerivatives.moment μ τ 0)
      {z : ℂ | sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re} :=
    fun z hz => (hasDerivAt_above_inf hτ hτ0 hne hbdd hz).differentiableAt.differentiableWithinAt
  exact hd.analyticOnNhd (isOpen_lt continuous_const Complex.continuous_re)

/-- Convergence at every real parameter makes the actual Laplace integral
entire. In particular this handles the negative-infinite-abscissa case. -/
theorem differentiable_of_convergenceSet_eq_univ (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hall : LaplaceConvergenceAbscissa.convergenceSet μ τ = univ) :
    Differentiable ℂ (LaplaceMomentDerivatives.moment μ τ 0) := by
  intro z
  have hb : Integrable (fun x => Real.exp (-(z.re-1) * τ x)) μ := by
    apply (LaplaceConvergenceAbscissa.integrable_iff_mem μ τ hτ _).mpr
    rw [hall]
    exact mem_univ _
  exact (LaplaceMomentDerivatives.hasDerivAt_moment hτ hτ0 hb
    (show z.re-1 < z.re by linarith) 0).differentiableAt

theorem analyticOnNhd_univ (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hall : LaplaceConvergenceAbscissa.convergenceSet μ τ = univ) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment μ τ 0) univ :=
  fun z _ => (differentiable_of_convergenceSet_eq_univ hτ hτ0 hall).analyticAt z

theorem analyticOnNhd_of_not_bddBelow (hτ : Measurable τ)
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hbdd : ¬BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ)) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment μ τ 0) univ :=
  analyticOnNhd_univ hτ hτ0
    (LaplaceConvergenceAbscissa.convergenceSet_eq_univ_of_not_bddBelow μ τ hτ0 hbdd)

end BuildingBlocks.LaplaceConvergenceAnalytic
