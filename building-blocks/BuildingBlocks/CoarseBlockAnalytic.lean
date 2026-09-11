import BuildingBlocks.CoarseDyadicBase
import Mathlib.Analysis.Calculus.ParametricIntervalIntegral

open Filter Set MeasureTheory
open scoped Topology Interval

set_option maxHeartbeats 1200000

namespace BuildingBlocks.CoarsePrimitive

/-- A finite Mellin integral of the actual prime error is entire. -/
theorem coarsePrime_finiteMellin_differentiable {X : ℝ} (hX : 0 < X) :
    Differentiable ℂ (fun s : ℂ => ∫ x in X..(2 * X),
      (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) := by
  let L : ℝ → ℂ := fun x => (Real.log (max X x) : ℂ)
  have hL : Continuous L := by
    apply Complex.continuous_ofReal.comp
    apply Continuous.log (continuous_const.max continuous_id)
    exact fun x => ne_of_gt (lt_of_lt_of_le hX (le_max_left _ _))
  let W : ℂ → ℝ → ℂ := fun s x => Complex.exp (L x * (-(s + 1)))
  let D : ℂ → ℝ → ℂ := fun s x => Complex.exp (L x * (-(s + 1))) * (-L x)
  have hW (s : ℂ) : Continuous (W s) := by dsimp [W]; fun_prop
  have hD : Continuous (fun p : ℂ × ℝ => D p.1 p.2) := by
    dsimp [D]; fun_prop
  have hder (x : ℝ) (s : ℂ) : HasDerivAt (fun z => W z x) (D s x) s := by
    convert ((((hasDerivAt_id s).add_const 1).neg).const_mul (L x)).cexp using 1
    simp [D]
  have hwi (s : ℂ) : IntervalIntegrable (fun x => primeErrorReal x • W s x)
      volume X (2 * X) :=
    (primeErrorReal_intervalIntegrable X (2 * X)).smul_continuousOn (hW s).continuousOn
  have hdi (s : ℂ) : IntervalIntegrable (fun x => primeErrorReal x • D s x)
      volume X (2 * X) :=
    (primeErrorReal_intervalIntegrable X (2 * X)).smul_continuousOn
      (hD.comp (continuous_const.prodMk continuous_id)).continuousOn
  have heq : (fun s : ℂ => ∫ x in X..(2 * X),
      (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) =
      (fun s : ℂ => ∫ x in X..(2 * X), primeErrorReal x • W s x) := by
    funext s
    apply intervalIntegral.integral_congr
    intro x hx
    have hxx : X ≤ x := by
      rw [uIcc_of_le (by linarith)] at hx
      exact hx.1
    have hxpos : 0 < x := hX.trans_le hxx
    simp [W, L, max_eq_right hxx, Complex.real_smul,
      Complex.cpow_def_of_ne_zero (Complex.ofReal_ne_zero.mpr hxpos.ne'),
      ← Complex.ofReal_log hxpos.le]
  rw [heq]
  intro s
  obtain ⟨C, hC⟩ := ((isCompact_closedBall s 1).prod (isCompact_Icc (a := X) (b := 2 * X))).exists_bound_of_continuousOn hD.continuousOn
  have hd := intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun s x => primeErrorReal x • W s x)
    (F' := fun s x => primeErrorReal x • D s x)
    (bound := fun x => ‖primeErrorReal x‖ * C)
    (x₀ := s) (ε := 1) (by norm_num)
    (Filter.Eventually.of_forall (fun z => by
      simpa [uIoc_of_le (by linarith : X ≤ 2 * X)] using (hwi z).aestronglyMeasurable))
    (hwi s) (by simpa [uIoc_of_le (by linarith : X ≤ 2 * X)] using (hdi s).aestronglyMeasurable)
    (Filter.Eventually.of_forall (by
      intro x hx z hz
      rw [norm_smul]
      apply mul_le_mul_of_nonneg_left _ (norm_nonneg _)
      apply hC (z, x)
      exact ⟨Metric.ball_subset_closedBall hz, by
        rw [uIoc_of_le (by linarith)] at hx
        exact ⟨hx.1.le, hx.2⟩⟩))
    ((primeErrorReal_intervalIntegrable X (2 * X)).norm.mul_const C)
    (Filter.Eventually.of_forall (fun x _ z _ => HasDerivAt.const_smul (primeErrorReal x) (hder x z)))
  exact hd.2.differentiableAt

theorem coarseMellinBlock_analytic (k : ℕ) :
    AnalyticOnNhd ℂ (coarseMellinBlock k) Set.univ := by
  have h := coarsePrime_finiteMellin_differentiable (pow_pos (by norm_num : (0 : ℝ) < 2) k)
  exact fun s _ => h.analyticAt s

end BuildingBlocks.CoarsePrimitive
