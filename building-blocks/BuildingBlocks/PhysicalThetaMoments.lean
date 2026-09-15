import BuildingBlocks.PhysicalThetaParity
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Integral.IntegrableOn

/-! Every fixed exponential moment of the literal physical theta kernel. -/
namespace BuildingBlocks.PhysicalThetaMoments
open Real Set MeasureTheory
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaUniform
open BuildingBlocks.PhysicalThetaParity

noncomputable def coefficient (n : ℕ) : ℝ := (n : ℝ) ^ 4 * exp (-π * n / 2)
noncomputable def amplitude : ℝ := 4 * π ^ 2 * ∑' n : ℕ, coefficient n

theorem coefficient_summable : Summable coefficient := by
  apply (summable_pow_mul_exp_neg_nat_mul 4 (show 0 < π / 2 by positivity)).congr
  intro n
  unfold coefficient
  congr 2
  ring

theorem amplitude_nonneg : 0 ≤ amplitude := by
  unfold amplitude
  apply mul_nonneg (by positivity)
  exact tsum_nonneg (fun n => by unfold coefficient; positivity)

theorem term_gaussian_bound (n : ℕ) {u : ℝ} (hu : 0 ≤ u) :
    term n u ≤ (4 * π ^ 2 * exp (9 * u / 2) * exp (-π * exp (2 * u) / 2)) *
      coefficient n := by
  by_cases hz : n = 0
  · simp [hz, term_zero, coefficient]
  have hn : 1 ≤ (n : ℝ) := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hz
  have he : 1 ≤ exp (2 * u) := by
    rw [← exp_zero]
    exact exp_le_exp.mpr (by linarith)
  have hp := mul_nonneg (sub_nonneg.mpr hn) (sub_nonneg.mpr he)
  have hs := mul_le_mul_of_nonneg_right (nat_square_ge n) (exp_nonneg (2 * u))
  have hsplit : ((n : ℝ) + exp (2 * u)) / 2 ≤ (n : ℝ) ^ 2 * exp (2 * u) := by
    nlinarith
  have hd : exp (-π * (n : ℝ) ^ 2 * exp (2 * u)) ≤
      exp (-π * n / 2) * exp (-π * exp (2 * u) / 2) := by
    rw [← exp_add]
    apply exp_le_exp.mpr
    have h := mul_le_mul_of_nonneg_left hsplit pi_pos.le
    nlinarith
  have hdrop : term n u ≤
      (4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2)) *
        exp (-π * (n : ℝ) ^ 2 * exp (2 * u)) := by
    unfold term
    have h : 0 ≤ 6 * π * (n : ℝ) ^ 2 * exp (5 * u / 2) := by positivity
    exact mul_le_mul_of_nonneg_right (sub_le_self _ h) (exp_nonneg _)
  have h := hdrop.trans (mul_le_mul_of_nonneg_left hd
    (show 0 ≤ 4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2) by positivity))
  unfold coefficient
  convert h using 1
  ring

theorem phi_gaussian_bound {u : ℝ} (hu : 0 ≤ u) :
    phi u ≤ amplitude * exp (9 * u / 2) * exp (-π * exp (2 * u) / 2) := by
  have h := (term_summable u).tsum_le_tsum (fun n => term_gaussian_bound n hu)
    (coefficient_summable.mul_left
      (4 * π ^ 2 * exp (9 * u / 2) * exp (-π * exp (2 * u) / 2)))
  rw [tsum_mul_left] at h
  unfold phi amplitude
  convert h using 1
  ring

theorem exp_two_ge_square {r : ℝ} (hr : 0 ≤ r) : r ^ 2 ≤ exp (2 * r) := by
  have h := add_one_le_exp r
  have hp := exp_pos r
  have he : exp (2 * r) = exp r ^ 2 := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  rw [he]
  nlinarith

theorem exponential_gaussian_domination (a : ℝ) {r : ℝ} (hr : 0 ≤ r) :
    exp (a * r) * exp (-π * exp (2 * r) / 2) ≤
      exp ((a + 1) ^ 2 / (2 * π)) * exp (-r) := by
  have hq : (a + 1) * r - π * r ^ 2 / 2 ≤ (a + 1) ^ 2 / (2 * π) := by
    apply (le_div_iff₀ (show 0 < 2 * π by positivity)).mpr
    nlinarith [sq_nonneg (π * r - (a + 1))]
  have he := mul_le_mul_of_nonneg_left (exp_two_ge_square hr) (show 0 ≤ π / 2 by positivity)
  rw [← exp_add, ← exp_add]
  apply exp_le_exp.mpr
  linarith

theorem phi_abs (u : ℝ) : phi |u| = phi u := by
  by_cases hu : 0 ≤ u
  · rw [abs_of_nonneg hu]
  · rw [abs_of_neg (lt_of_not_ge hu), phi_even]

theorem weighted_phi_bound (β u : ℝ) :
    exp (β * |u|) * phi u ≤
      (amplitude * exp ((β + 9 / 2 + 1) ^ 2 / (2 * π))) * exp (-|u|) := by
  have hp := phi_gaussian_bound (abs_nonneg u)
  rw [phi_abs] at hp
  have h := mul_le_mul_of_nonneg_left hp (exp_nonneg (β * |u|))
  have he : exp (β * |u|) * exp (9 * |u| / 2) = exp ((β + 9 / 2) * |u|) := by
    rw [← exp_add]
    congr 1
    ring
  calc
    _ ≤ exp (β * |u|) * (amplitude * exp (9 * |u| / 2) * exp (-π * exp (2 * |u|) / 2)) := h
    _ = amplitude * (exp ((β + 9 / 2) * |u|) * exp (-π * exp (2 * |u|) / 2)) := by
      rw [← he]
      ring
    _ ≤ amplitude * (exp ((β + 9 / 2 + 1) ^ 2 / (2 * π)) * exp (-|u|)) :=
      mul_le_mul_of_nonneg_left (exponential_gaussian_domination (β + 9 / 2) (abs_nonneg u))
        amplitude_nonneg
    _ = _ := by ring

theorem integrable_exp_neg_abs : Integrable (fun u : ℝ => exp (-|u|)) := by
  have hn : IntegrableOn (fun u : ℝ => exp (-|u|)) (Iic 0) := by
    apply (integrableOn_exp_Iic 0).congr_fun _ measurableSet_Iic
    intro u hu
    change u ≤ 0 at hu
    change exp u = exp (-|u|)
    rw [abs_of_nonpos hu]
    simp
  have hp : IntegrableOn (fun u : ℝ => exp (-|u|)) (Ioi 0) := by
    apply (integrableOn_exp_neg_Ioi 0).congr_fun _ measurableSet_Ioi
    intro u hu
    change 0 < u at hu
    change exp (-u) = exp (-|u|)
    rw [abs_of_pos hu]
  have h := hn.union hp
  have he : Iic (0 : ℝ) ∪ Ioi 0 = univ := by
    ext u
    simp only [mem_union, mem_Iic, mem_Ioi, mem_univ, iff_true]
    exact le_or_gt u 0
  rw [he, integrableOn_univ] at h
  exact h

theorem phi_exponential_moment_integrable (β : ℝ) :
    Integrable (fun u : ℝ => exp (β * |u|) * phi u) := by
  have hg := integrable_exp_neg_abs.const_mul
    (amplitude * exp ((β + 9 / 2 + 1) ^ 2 / (2 * π)))
  apply hg.mono'
  · exact ((continuous_exp.comp (continuous_const.mul continuous_abs)).mul
      phi_continuous).aestronglyMeasurable
  · apply Filter.Eventually.of_forall
    intro u
    rw [Real.norm_eq_abs, abs_of_nonneg
      (mul_nonneg (exp_nonneg _) (phi_positive u).le)]
    exact weighted_phi_bound β u

theorem bounded_multiplier_moment_integrable (β : ℝ) (ψ : ℝ → ℝ) (P : ℝ)
    (hψ : AEStronglyMeasurable ψ) (hbound : ∀ᵐ u, |ψ u| ≤ P) :
    Integrable (fun u : ℝ => (exp (β * |u|) * phi u) * ψ u) := by
  have hf := phi_exponential_moment_integrable β
  apply (hf.const_mul P).mono'
  · exact hf.aestronglyMeasurable.mul hψ
  · filter_upwards [hbound] with u hu
    have hb : 0 ≤ exp (β * |u|) * phi u :=
      mul_nonneg (exp_nonneg _) (phi_positive u).le
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg hb]
    simpa only [mul_comm] using mul_le_mul_of_nonneg_left hu hb

theorem bounded_exterior_ground_moment_integrable (β R : ℝ) (ψ : ℝ → ℝ) (P : ℝ)
    (hψ : AEStronglyMeasurable ψ) (hbound : ∀ᵐ u, |ψ u| ≤ P) :
    Integrable (fun u : ℝ => exp (β * |u|) *
      (if R < |u| then phi u * ψ u else 0)) := by
  have hs : MeasurableSet {u : ℝ | R < |u|} :=
    measurableSet_lt measurable_const continuous_abs.measurable
  have hf := (bounded_multiplier_moment_integrable β ψ P hψ hbound).indicator hs
  convert hf using 1
  funext u
  by_cases hu : R < |u|
  · simp [Set.indicator, hu, mul_assoc]
  · simp [Set.indicator, hu]

#print axioms coefficient_summable
#print axioms amplitude_nonneg
#print axioms term_gaussian_bound
#print axioms phi_gaussian_bound
#print axioms exp_two_ge_square
#print axioms exponential_gaussian_domination
#print axioms phi_abs
#print axioms weighted_phi_bound
#print axioms integrable_exp_neg_abs
#print axioms phi_exponential_moment_integrable
#print axioms bounded_multiplier_moment_integrable
#print axioms bounded_exterior_ground_moment_integrable
end BuildingBlocks.PhysicalThetaMoments
