import BuildingBlocks.PhysicalThetaMoments
import BuildingBlocks.WeakGroundPrimeTail
import Mathlib.MeasureTheory.Group.Measure

/-! Literal bounded exterior physical source and complete prime-power arrival series.
No killed-ground eigenfunction property is assumed. -/
namespace BuildingBlocks.PhysicalGroundPrimeArrival
open Real MeasureTheory
open scoped ArithmeticFunction.vonMangoldt
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaUniform
open BuildingBlocks.PhysicalThetaParity BuildingBlocks.PhysicalThetaMoments
open BuildingBlocks.WeakGroundPrimeTail

noncomputable def source (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) : ℝ :=
  if R < |v| then phi v * ψ v else 0
noncomputable def tailConstant : ℝ := amplitude * exp ((9 / 2 + 1) ^ 2 / (2 * π))
noncomputable def arrivalTerm (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) (n : {n : ℕ // 2 ≤ n}) : ℝ :=
  (Λ n.val / sqrt n.val) *
    (source R ψ (shift true n.val v) + source R ψ (shift false n.val v))
noncomputable def primeArrival (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) : ℝ :=
  ∑' n : {n : ℕ // 2 ≤ n}, arrivalTerm R ψ v n
noncomputable def primeMass : ℝ :=
  ∑' n : {n : ℕ // 2 ≤ n}, Λ n.val / (n.val : ℝ) ^ (3 / 2 : ℝ)

theorem tailConstant_nonneg : 0 ≤ tailConstant :=
  mul_nonneg amplitude_nonneg (exp_nonneg _)

theorem phi_tail_bound (v : ℝ) : phi v ≤ tailConstant * exp (-|v|) := by
  simpa [tailConstant] using weighted_phi_bound 0 v

theorem source_exponential_moment_integrable (β R : ℝ) (ψ : ℝ → ℝ) (P : ℝ)
    (hψ : AEStronglyMeasurable ψ) (hbound : ∀ᵐ u, |ψ u| ≤ P) :
    Integrable (fun v => exp (β * |v|) * source R ψ v) :=
  bounded_exterior_ground_moment_integrable β R ψ P hψ hbound

theorem source_bound_at (R v P : ℝ) (ψ : ℝ → ℝ) (hP : 0 ≤ P) (hψ : |ψ v| ≤ P) :
    |source R ψ v| ≤ (P * tailConstant) * exp (-|v|) := by
  unfold source
  split_ifs
  · rw [abs_mul, abs_of_nonneg (phi_positive v).le]
    calc
      _ ≤ phi v * P := mul_le_mul_of_nonneg_left hψ (phi_positive v).le
      _ ≤ (tailConstant * exp (-|v|)) * P := mul_le_mul_of_nonneg_right (phi_tail_bound v) hP
      _ = _ := by ring
  · simp only [abs_zero]
    exact mul_nonneg (mul_nonneg hP tailConstant_nonneg) (exp_nonneg _)

theorem shifted_bound_ae (ψ : ℝ → ℝ) (P : ℝ) (hψ : ∀ᵐ v, |ψ v| ≤ P)
    (side : Bool) (n : {n : ℕ // 2 ≤ n}) :
    ∀ᵐ v, |ψ (shift side n.val v)| ≤ P := by
  cases side
  · have h := (measurePreserving_add_right (volume : Measure ℝ) (-log n.val)).quasiMeasurePreserving.ae hψ
    simpa [shift, sub_eq_add_neg] using h
  · have h := (measurePreserving_add_right (volume : Measure ℝ) (log n.val)).quasiMeasurePreserving.ae hψ
    simpa [shift] using h

theorem arrivalTerm_bound (R v P : ℝ) (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (n : {n : ℕ // 2 ≤ n})
    (hψ : ∀ side : Bool, |ψ (shift side n.val v)| ≤ P) :
    ‖arrivalTerm R ψ v n‖ ≤ (2 * P * tailConstant * exp |v|) *
      (Λ n.val / (n.val : ℝ) ^ (3 / 2 : ℝ)) := by
  have hx : 1 ≤ (n.val : ℝ) := by exact_mod_cast (le_trans (by norm_num : 1 ≤ 2) n.property)
  have hp : 0 < (n.val : ℝ) := lt_of_lt_of_le zero_lt_one hx
  have hc : 0 ≤ Λ n.val / sqrt n.val := div_nonneg ArithmeticFunction.vonMangoldt_nonneg (sqrt_nonneg _)
  have hb : ∀ side : Bool, |source R ψ (shift side n.val v)| ≤
      (P * tailConstant) * (exp |v| / (n.val : ℝ)) := by
    intro side
    have hs := source_bound_at R (shift side n.val v) P ψ hP (hψ side)
    have he := shifted_exponential_bound_both side v n.val 1 hx (by norm_num)
    simp only [neg_one_mul, one_mul, rpow_one] at he
    exact hs.trans (mul_le_mul_of_nonneg_left he (mul_nonneg hP tailConstant_nonneg))
  unfold arrivalTerm
  rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg hc]
  calc
    _ ≤ (Λ n.val / sqrt n.val) *
        (2 * (P * tailConstant) * (exp |v| / (n.val : ℝ))) := by
      apply mul_le_mul_of_nonneg_left _ hc
      have h := (abs_add_le _ _).trans (add_le_add (hb true) (hb false))
      nlinarith
    _ = _ := by
      have hr : (n.val : ℝ) ^ (3 / 2 : ℝ) = sqrt n.val * (n.val : ℝ) := by
        rw [show (3 / 2 : ℝ) = 1 / 2 + 1 by norm_num, rpow_add hp, rpow_one, sqrt_eq_rpow]
      rw [hr]
      simp only [div_eq_mul_inv, mul_inv_rev]
      ring

theorem prime_arrival_absolutely_summable_ae (R P : ℝ) (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (hψ : ∀ᵐ v, |ψ v| ≤ P) :
    ∀ᵐ v, Summable (fun n : {n : ℕ // 2 ≤ n} => ‖arrivalTerm R ψ v n‖) := by
  have hall : ∀ᵐ v, ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      |ψ (shift side n.val v)| ≤ P :=
    ae_all_iff.mpr (fun side => ae_all_iff.mpr (fun n => shifted_bound_ae ψ P hψ side n))
  filter_upwards [hall] with v hv
  have hm := ((summable_vonMangoldt_div_rpow (by norm_num : (1 : ℝ) < 3 / 2)).mul_left
    (2 * P * tailConstant * exp |v|)).subtype (fun n => 2 ≤ n)
  apply hm.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro n
  exact arrivalTerm_bound R v P ψ hP n (fun side => hv side n)

theorem prime_arrival_bound_ae (R P : ℝ) (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (hψ : ∀ᵐ v, |ψ v| ≤ P) :
    ∀ᵐ v, ‖primeArrival R ψ v‖ ≤ (2 * P * tailConstant * exp |v|) * primeMass := by
  have hall : ∀ᵐ v, ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      |ψ (shift side n.val v)| ≤ P :=
    ae_all_iff.mpr (fun side => ae_all_iff.mpr (fun n => shifted_bound_ae ψ P hψ side n))
  filter_upwards [hall, prime_arrival_absolutely_summable_ae R P ψ hP hψ] with v hv hsum
  have hm := ((summable_vonMangoldt_div_rpow (by norm_num : (1 : ℝ) < 3 / 2)).mul_left
    (2 * P * tailConstant * exp |v|)).subtype (fun n => 2 ≤ n)
  have hl := hsum.tsum_le_tsum (fun n => arrivalTerm_bound R v P ψ hP n (fun side => hv side n)) hm
  rw [tsum_mul_left] at hl
  exact (norm_tsum_le_tsum_norm hsum).trans hl

#print axioms tailConstant_nonneg
#print axioms phi_tail_bound
#print axioms source_exponential_moment_integrable
#print axioms source_bound_at
#print axioms shifted_bound_ae
#print axioms arrivalTerm_bound
#print axioms prime_arrival_absolutely_summable_ae
#print axioms prime_arrival_bound_ae
end BuildingBlocks.PhysicalGroundPrimeArrival
