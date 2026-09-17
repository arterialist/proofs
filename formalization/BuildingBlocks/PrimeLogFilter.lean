import BuildingBlocks.CoarsePrimeBounds
import BuildingBlocks.CausalFilterEnergy
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks

open CoarsePrimitive

noncomputable def primeLogError (t : ℝ) : ℝ :=
  Real.exp (-(1 / 2 : ℝ) * t) * primeErrorReal (Real.exp t)

noncomputable def primeLogResponse (t : ℝ) : ℝ :=
  Real.exp (-(3 / 2 : ℝ) * t) * coarsePrefix 1 (Real.exp t)

theorem primeLogResponse_zero : primeLogResponse 0 = 0 := by
  simp [primeLogResponse, coarsePrefix]

theorem primeLogResponse_continuous : Continuous primeLogResponse := by
  unfold primeLogResponse
  exact (Real.continuous_exp.comp (continuous_const.mul continuous_id)).mul
    ((coarsePrefix_continuous 1).comp Real.continuous_exp)

/-- Exact logarithmic-time filter equation for the actual prime error.
The right derivative retains prime-power jumps of the input. -/
theorem primeLogResponse_hasDerivWithinAt_right (t : ℝ) :
    HasDerivWithinAt primeLogResponse
      (primeLogError t - (3 / 2 : ℝ) * primeLogResponse t) (Ioi t) t := by
  have hc := (coarsePrefix_hasDerivWithinAt_right 1 (Real.exp t)).comp t
    (Real.hasDerivAt_exp t).hasDerivWithinAt
    (show MapsTo Real.exp (Ioi t) (Ioi (Real.exp t)) from
      fun y hy => Real.exp_lt_exp.mpr hy)
  have he : HasDerivAt (fun u : ℝ => Real.exp (-(3 / 2 : ℝ) * u))
      (Real.exp (-(3 / 2 : ℝ) * t) * (-(3 / 2 : ℝ))) t := by
    simpa only [Function.comp_def, mul_one] using
      (Real.hasDerivAt_exp (-(3 / 2 : ℝ) * t)).comp t
      ((hasDerivAt_id t).const_mul (-(3 / 2 : ℝ)))
  have hexp : Real.exp (-(3 / 2 : ℝ) * t) * Real.exp t =
      Real.exp (-(1 / 2 : ℝ) * t) := by
    rw [← Real.exp_add]
    congr 1
    ring
  have hd := he.hasDerivWithinAt.mul hc
  convert hd using 1
  dsimp [primeLogError, primeLogResponse, Function.comp_def]
  rw [← hexp]
  ring

theorem primeLogError_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable primeLogError volume a b := by
  have hp : Monotone (fun t : ℝ => psi ⌊Real.exp t⌋₊) := by
    intro t u h
    exact psi_mono (Nat.floor_mono (Real.exp_le_exp.mpr h))
  have hip : IntervalIntegrable (fun t : ℝ => psi ⌊Real.exp t⌋₊) volume a b :=
    hp.intervalIntegrable
  have hi := hip.sub (Real.continuous_exp.intervalIntegrable a b)
  have hc : Continuous (fun t : ℝ => Real.exp (-(1 / 2 : ℝ) * t)) :=
    Real.continuous_exp.comp (continuous_const.mul continuous_id)
  change IntervalIntegrable
    (fun t => Real.exp (-(1 / 2 : ℝ) * t) * (psi ⌊Real.exp t⌋₊ - Real.exp t))
    volume a b
  simpa only [mul_comm] using hi.mul_continuousOn hc.continuousOn

theorem primeLogError_sq_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable (fun t => primeLogError t ^ 2) volume a b := by
  have hp : Monotone (fun t : ℝ => psi ⌊Real.exp t⌋₊) := by
    intro t u h
    exact psi_mono (Nat.floor_mono (Real.exp_le_exp.mpr h))
  have hp2 : Monotone (fun t : ℝ => (psi ⌊Real.exp t⌋₊)^2) := by
    intro t u h
    exact (sq_le_sq₀ (psi_nonneg _) (psi_nonneg _)).2 (hp h)
  have hip : IntervalIntegrable (fun t : ℝ => psi ⌊Real.exp t⌋₊) volume a b :=
    hp.intervalIntegrable
  have hip2 : IntervalIntegrable (fun t : ℝ => (psi ⌊Real.exp t⌋₊)^2)
      volume a b := hp2.intervalIntegrable
  have him := hip.mul_continuousOn
    (show ContinuousOn (fun t : ℝ => 2 * Real.exp t) (uIcc a b) from
      (continuous_const.mul Real.continuous_exp).continuousOn)
  have hir := (hip2.sub him).add
    ((Real.continuous_exp.pow 2).intervalIntegrable a b)
  have hc : Continuous (fun t : ℝ => Real.exp (-(1 / 2 : ℝ) * t)^2) :=
    (Real.continuous_exp.comp (continuous_const.mul continuous_id)).pow 2
  have hi := hir.mul_continuousOn hc.continuousOn
  convert hi using 1
  funext t
  dsimp [primeLogError, primeErrorReal]
  ring

theorem primeLogFilter_energy_identity (T : ℝ) :
    (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) =
      (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) - primeLogResponse T ^ 2 -
        2 * ∫ t in (0 : ℝ)..T, primeLogResponse t ^ 2 := by
  simpa only [show (2 : ℝ) * (3 / 2) - 1 = 2 by norm_num] using
    causalFilter_energy_identity
    primeLogResponse_continuous.continuousOn primeLogResponse_zero
    (primeLogError_intervalIntegrable 0 T) (primeLogError_sq_intervalIntegrable 0 T)
    (fun t _ => primeLogResponse_hasDerivWithinAt_right t)

end BuildingBlocks
