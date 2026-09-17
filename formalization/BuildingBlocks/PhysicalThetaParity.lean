import BuildingBlocks.PhysicalThetaUniform
import Mathlib.Analysis.SpecialFunctions.Gaussian.PoissonSummation

/-! True parity of the literal physical theta series via real Gaussian Poisson modularity. -/
namespace BuildingBlocks.PhysicalThetaParity
open Real
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaSeed
open BuildingBlocks.PhysicalThetaUniform

noncomputable def integerSeed (n : ℤ) (u : ℝ) : ℝ :=
  exp (u / 2) * exp (-π * (n : ℝ) ^ 2 * exp (2 * u))
noncomputable def fullSeedSum (u : ℝ) : ℝ := ∑' n : ℤ, integerSeed n u
noncomputable def theta (t : ℝ) : ℝ := ∑' n : ℤ, exp (-π * t * (n : ℝ) ^ 2)
noncomputable def fullSlope (u : ℝ) : ℝ := 2 * slopeSum u - exp (u / 2) / 2
noncomputable def fullCurvature (u : ℝ) : ℝ := 2 * curvatureSum u - exp (u / 2) / 4

theorem integerSeed_nat (n : ℕ) (u : ℝ) : integerSeed n u = seed n u := by
  simp [integerSeed, seed, argument]

theorem integerSeed_neg_nat (n : ℕ) (u : ℝ) : integerSeed (-(n : ℤ)) u = seed n u := by
  simp [integerSeed, seed, argument]

theorem integerSeed_summable (u : ℝ) : Summable (fun n => integerSeed n u) := by
  have hp : Summable (fun n : ℕ => integerSeed n u) := by
    simpa only [integerSeed_nat] using seed_summable u
  have hn : Summable (fun n : ℕ => integerSeed (-(n : ℤ)) u) := by
    simpa only [integerSeed_neg_nat] using seed_summable u
  exact Summable.of_nat_of_neg (f := fun n : ℤ => integerSeed n u) hp hn

theorem fullSeedSum_decomposition (u : ℝ) :
    fullSeedSum u = 2 * seedSum u - exp (u / 2) := by
  have hp : Summable (fun n : ℕ => integerSeed n u) := by
    simpa only [integerSeed_nat] using seed_summable u
  have hn : Summable (fun n : ℕ => integerSeed (-(n : ℤ)) u) := by
    simpa only [integerSeed_neg_nat] using seed_summable u
  have h := Summable.tsum_of_nat_of_neg (f := fun n : ℤ => integerSeed n u) hp hn
  have hz : integerSeed 0 u = exp (u / 2) := by simp [integerSeed]
  simp only [integerSeed_nat, integerSeed_neg_nat, hz] at h
  unfold fullSeedSum seedSum
  linarith

theorem fullSeedSum_theta (u : ℝ) : fullSeedSum u = exp (u / 2) * theta (exp (2 * u)) := by
  unfold fullSeedSum theta
  rw [← tsum_mul_left]
  apply tsum_congr
  intro n
  unfold integerSeed
  congr 2
  ring

theorem theta_log_modular (u : ℝ) : theta (exp (2 * u)) = exp (-u) * theta (exp (-2 * u)) := by
  have hr : exp (2 * u) ^ (1 / 2 : ℝ) = exp u := by
    rw [rpow_def_of_pos (exp_pos _), log_exp]
    congr 1
    ring
  have h := Real.tsum_exp_neg_mul_int_sq (exp_pos (2 * u))
  rw [hr] at h
  unfold theta
  rw [h, exp_neg]
  simp only [one_div]
  congr 1
  apply tsum_congr
  intro n
  congr 1
  have hn : exp (-2 * u) = (exp (2 * u))⁻¹ := by
    calc
      exp (-2 * u) = exp (-(2 * u)) := by congr 1; ring
      _ = _ := exp_neg _
  rw [hn]
  ring

theorem fullSeedSum_even (u : ℝ) : fullSeedSum (-u) = fullSeedSum u := by
  rw [fullSeedSum_theta (-u), fullSeedSum_theta u, theta_log_modular u]
  have he : exp (u / 2) * exp (-u) = exp ((-u) / 2) := by
    rw [← exp_add]
    congr 1
    ring
  have ht : exp (-2 * u) = exp (2 * (-u)) := by congr 1; ring
  rw [← mul_assoc, he, ht]

theorem fullSeedSum_hasDerivAt (u : ℝ) : HasDerivAt fullSeedSum (fullSlope u) u := by
  have h1 := (seedSum_hasDerivAt u).const_mul (2 : ℝ)
  have h2 := ((hasDerivAt_id u).div_const (2 : ℝ)).exp
  have he : fullSeedSum = fun v => 2 * seedSum v - exp (v / 2) :=
    funext fullSeedSum_decomposition
  rw [he]
  convert h1.sub h2 using 1
  dsimp [fullSlope]
  ring

theorem fullSlope_hasDerivAt (u : ℝ) : HasDerivAt fullSlope (fullCurvature u) u := by
  have h1 := (slopeSum_hasDerivAt u).const_mul (2 : ℝ)
  have h2 := (((hasDerivAt_id u).div_const (2 : ℝ)).exp).div_const (2 : ℝ)
  convert h1.sub h2 using 1
  dsimp [fullSlope, fullCurvature]
  ring

theorem fullSeed_differential_identity (u : ℝ) :
    fullCurvature u - fullSeedSum u / 4 = 2 * phi u := by
  rw [fullSeedSum_decomposition]
  have h := curvature_tsum_minus_quarter_seed u
  change curvatureSum u - seedSum u / 4 = phi u at h
  dsimp [fullCurvature]
  linarith

theorem fullSlope_odd (u : ℝ) : fullSlope (-u) = -fullSlope u := by
  have h := (fullSeedSum_hasDerivAt (-u)).comp u (hasDerivAt_id u).neg
  change HasDerivAt (fun v => fullSeedSum (-v)) (fullSlope (-u) * (-1)) u at h
  have he : (fun v => fullSeedSum (-v)) = fullSeedSum := funext fullSeedSum_even
  rw [he] at h
  have hu := (fullSeedSum_hasDerivAt u).unique h
  linarith

theorem fullCurvature_even (u : ℝ) : fullCurvature (-u) = fullCurvature u := by
  have h := (fullSlope_hasDerivAt (-u)).comp u (hasDerivAt_id u).neg
  change HasDerivAt (fun v => fullSlope (-v)) (fullCurvature (-u) * (-1)) u at h
  have he : (fun v => fullSlope (-v)) = fun v => -fullSlope v := funext fullSlope_odd
  rw [he] at h
  have hu := ((fullSlope_hasDerivAt u).neg).unique h
  linarith

theorem phi_even (u : ℝ) : phi (-u) = phi u := by
  have hn := fullSeed_differential_identity (-u)
  have hp := fullSeed_differential_identity u
  rw [fullCurvature_even, fullSeedSum_even] at hn
  linarith

theorem phi_positive (u : ℝ) : 0 < phi u := by
  by_cases hu : 0 ≤ u
  · exact phi_pos hu
  · rw [← phi_even u]
    exact phi_pos (by linarith)

#print axioms integerSeed_nat
#print axioms integerSeed_neg_nat
#print axioms integerSeed_summable
#print axioms fullSeedSum_decomposition
#print axioms fullSeedSum_theta
#print axioms theta_log_modular
#print axioms fullSeedSum_even
#print axioms fullSeedSum_hasDerivAt
#print axioms fullSlope_hasDerivAt
#print axioms fullSeed_differential_identity
#print axioms fullSlope_odd
#print axioms fullCurvature_even
#print axioms phi_even
#print axioms phi_positive
end BuildingBlocks.PhysicalThetaParity
