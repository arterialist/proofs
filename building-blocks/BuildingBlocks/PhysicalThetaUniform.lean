import BuildingBlocks.PhysicalThetaSeed
import Mathlib.Analysis.Calculus.SmoothSeries

/-! Actual local summable derivative envelopes and twice-differentiated seed sum. -/
namespace BuildingBlocks.PhysicalThetaUniform
open Real Set
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaSeed

noncomputable def seedEnvelope (A B : ℝ) (n : ℕ) : ℝ :=
  exp (B / 2) * exp (-(π * exp (2 * A)) * n)
noncomputable def slopeEnvelope (A B : ℝ) (n : ℕ) : ℝ :=
  (1 / 2 + 2 * argument n B) * seedEnvelope A B n
noncomputable def curvatureEnvelope (A B : ℝ) (n : ℕ) : ℝ :=
  (1 / 4 + 6 * argument n B + 4 * argument n B ^ 2) * seedEnvelope A B n

theorem argument_nonneg (n : ℕ) (u : ℝ) : 0 ≤ argument n u := by
  unfold argument
  positivity

theorem argument_mono (n : ℕ) {u B : ℝ} (hu : u ≤ B) : argument n u ≤ argument n B := by
  unfold argument
  exact mul_le_mul_of_nonneg_left (exp_le_exp.mpr (by linarith)) (by positivity)

theorem seed_uniform_bound (n : ℕ) {A B u : ℝ} (hA : A ≤ u) (hB : u ≤ B) :
    |seed n u| ≤ seedEnvelope A B n := by
  have ha : exp (u / 2) ≤ exp (B / 2) := exp_le_exp.mpr (by linarith)
  have hb : exp (-argument n u) ≤ exp (-(π * exp (2 * A)) * n) := by
    apply exp_le_exp.mpr
    have hx := argument_mono n hA
    have hn := mul_le_mul_of_nonneg_left (nat_square_ge n)
      (show 0 ≤ π * exp (2 * A) by positivity)
    dsimp [argument] at hx ⊢
    nlinarith
  unfold seed seedEnvelope
  rw [abs_of_nonneg (mul_nonneg (exp_nonneg _) (exp_nonneg _))]
  exact mul_le_mul ha hb (exp_nonneg _) (exp_nonneg _)

theorem slope_uniform_bound (n : ℕ) {A B u : ℝ} (hA : A ≤ u) (hB : u ≤ B) :
    |slope n u| ≤ slopeEnvelope A B n := by
  have hx := argument_nonneg n u
  have hm := argument_mono n hB
  have hc : |1 / 2 - 2 * argument n u| ≤ 1 / 2 + 2 * argument n B := by
    apply abs_le.mpr
    constructor <;> linarith
  unfold PhysicalThetaSeed.slope slopeEnvelope
  rw [abs_mul]
  exact mul_le_mul hc (seed_uniform_bound n hA hB) (abs_nonneg _) (by linarith)

theorem curvature_uniform_bound (n : ℕ) {A B u : ℝ} (hA : A ≤ u) (hB : u ≤ B) :
    |curvature n u| ≤ curvatureEnvelope A B n := by
  have hx := argument_nonneg n u
  have hB0 := argument_nonneg n B
  have hm := argument_mono n hB
  have hsq : argument n u ^ 2 ≤ argument n B ^ 2 := by
    nlinarith
  have hc : |1 / 4 - 6 * argument n u + 4 * argument n u ^ 2| ≤
      1 / 4 + 6 * argument n B + 4 * argument n B ^ 2 := by
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (argument n u)]
  unfold curvature curvatureEnvelope
  rw [abs_mul]
  exact mul_le_mul hc (seed_uniform_bound n hA hB) (abs_nonneg _) (by positivity)

theorem seedEnvelope_summable (A B : ℝ) : Summable (seedEnvelope A B) := by
  have h : Summable (fun n : ℕ => exp (-(π * exp (2 * A)) * n)) := by
    simpa using summable_pow_mul_exp_neg_nat_mul 0 (show 0 < π * exp (2 * A) by positivity)
  exact h.mul_left (exp (B / 2))

theorem slopeEnvelope_summable (A B : ℝ) : Summable (slopeEnvelope A B) := by
  have hc : 0 < π * exp (2 * A) := by positivity
  have h0 : Summable (fun n : ℕ => exp (-(π * exp (2 * A)) * n)) := by
    simpa using summable_pow_mul_exp_neg_nat_mul 0 hc
  have h2 := summable_pow_mul_exp_neg_nat_mul 2 hc
  apply ((h0.mul_left ((1 / 2) * exp (B / 2))).add
    (h2.mul_left (2 * π * exp (2 * B) * exp (B / 2)))).congr
  intro n
  dsimp [slopeEnvelope, seedEnvelope, argument]
  ring

theorem curvatureEnvelope_summable (A B : ℝ) : Summable (curvatureEnvelope A B) := by
  have hc : 0 < π * exp (2 * A) := by positivity
  have h0 : Summable (fun n : ℕ => exp (-(π * exp (2 * A)) * n)) := by
    simpa using summable_pow_mul_exp_neg_nat_mul 0 hc
  have h2 := summable_pow_mul_exp_neg_nat_mul 2 hc
  have h4 := summable_pow_mul_exp_neg_nat_mul 4 hc
  apply (((h0.mul_left ((1 / 4) * exp (B / 2))).add
    (h2.mul_left (6 * π * exp (2 * B) * exp (B / 2)))).add
    (h4.mul_left (4 * π ^ 2 * exp (2 * B) ^ 2 * exp (B / 2)))).congr
  intro n
  dsimp [curvatureEnvelope, seedEnvelope, argument]
  ring

theorem slope_summable (u : ℝ) : Summable (fun n => slope n u) := by
  apply (slopeEnvelope_summable (u - 1) (u + 1)).of_norm_bounded
  intro n
  simpa only [Real.norm_eq_abs] using slope_uniform_bound n
    (show u - 1 ≤ u by linarith) (show u ≤ u + 1 by linarith)

noncomputable def seedSum (u : ℝ) : ℝ := ∑' n : ℕ, seed n u
noncomputable def slopeSum (u : ℝ) : ℝ := ∑' n : ℕ, slope n u
noncomputable def curvatureSum (u : ℝ) : ℝ := ∑' n : ℕ, curvature n u

theorem seedSum_hasDerivAt (u : ℝ) : HasDerivAt seedSum (slopeSum u) u := by
  have hi : u ∈ Ioo (u - 1) (u + 1) := by constructor <;> linarith
  apply hasDerivAt_tsum_of_isPreconnected
    (slopeEnvelope_summable (u - 1) (u + 1)) isOpen_Ioo isPreconnected_Ioo
    (fun n y _ => seed_hasDerivAt n y) _ hi (seed_summable u) hi
  intro n y hy
  simpa only [Real.norm_eq_abs] using slope_uniform_bound n hy.1.le hy.2.le

theorem slopeSum_hasDerivAt (u : ℝ) : HasDerivAt slopeSum (curvatureSum u) u := by
  have hi : u ∈ Ioo (u - 1) (u + 1) := by constructor <;> linarith
  apply hasDerivAt_tsum_of_isPreconnected
    (curvatureEnvelope_summable (u - 1) (u + 1)) isOpen_Ioo isPreconnected_Ioo
    (fun n y _ => slope_hasDerivAt n y) _ hi (slope_summable u) hi
  intro n y hy
  simpa only [Real.norm_eq_abs] using curvature_uniform_bound n hy.1.le hy.2.le

theorem seedSum_deriv : deriv seedSum = slopeSum := by
  funext u
  exact (seedSum_hasDerivAt u).deriv

theorem seedSum_second_deriv : deriv (deriv seedSum) = curvatureSum := by
  rw [seedSum_deriv]
  funext u
  exact (slopeSum_hasDerivAt u).deriv

theorem seedSum_differential_identity (u : ℝ) :
    deriv (deriv seedSum) u - seedSum u / 4 = phi u := by
  rw [seedSum_second_deriv]
  exact curvature_tsum_minus_quarter_seed u

theorem curvature_continuous (n : ℕ) : Continuous (curvature n) := by
  unfold curvature seed argument
  fun_prop

theorem seedSum_continuous : Continuous seedSum := by
  apply continuous_iff_continuousAt.mpr
  intro u
  exact (seedSum_hasDerivAt u).continuousAt

theorem curvatureSum_continuous : Continuous curvatureSum := by
  apply continuous_iff_continuousAt.mpr
  intro u
  have hi : u ∈ Ioo (u - 1) (u + 1) := by constructor <;> linarith
  have hc : ContinuousOn curvatureSum (Ioo (u - 1) (u + 1)) := by
    apply continuousOn_tsum (fun n => (curvature_continuous n).continuousOn)
      (curvatureEnvelope_summable (u - 1) (u + 1))
    intro n y hy
    simpa only [Real.norm_eq_abs] using curvature_uniform_bound n hy.1.le hy.2.le
  exact hc.continuousAt (isOpen_Ioo.mem_nhds hi)

theorem phi_continuous : Continuous phi := by
  have he : phi = fun u => curvatureSum u - seedSum u / 4 := by
    funext u
    exact (curvature_tsum_minus_quarter_seed u).symm
  rw [he]
  exact curvatureSum_continuous.sub (seedSum_continuous.div_const 4)

#print axioms curvature_continuous
#print axioms seedSum_continuous
#print axioms curvatureSum_continuous
#print axioms phi_continuous
#print axioms argument_nonneg
#print axioms argument_mono
#print axioms seed_uniform_bound
#print axioms slope_uniform_bound
#print axioms curvature_uniform_bound
#print axioms seedEnvelope_summable
#print axioms slopeEnvelope_summable
#print axioms curvatureEnvelope_summable
#print axioms slope_summable
#print axioms seedSum_hasDerivAt
#print axioms slopeSum_hasDerivAt
#print axioms seedSum_deriv
#print axioms seedSum_second_deriv
#print axioms seedSum_differential_identity
end BuildingBlocks.PhysicalThetaUniform
