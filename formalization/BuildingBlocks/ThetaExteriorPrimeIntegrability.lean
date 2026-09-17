import BuildingBlocks.PhysicalThetaMoments
import BuildingBlocks.WeakGroundPrimeTail

open MeasureTheory
namespace BuildingBlocks.ThetaExteriorPrimeIntegrability
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaParity
open BuildingBlocks.PhysicalThetaMoments BuildingBlocks.WeakGroundPrimeTail

noncomputable def exteriorWeight (R : ℝ) (psi : ℝ → ℝ) (v : ℝ) : ℝ :=
  if R < |v| then phi v * psi v else 0

theorem exteriorWeight_nonneg (R : ℝ) (psi : ℝ → ℝ)
    (hp : ∀ v, 0 ≤ psi v) (v : ℝ) : 0 ≤ exteriorWeight R psi v := by
  unfold exteriorWeight
  split_ifs
  · exact mul_nonneg (phi_positive v).le (hp v)
  · exact le_rfl

theorem complete_exterior_prime_integrals (R : ℝ) (psi : ℝ → ℝ) (P : ℝ)
    (hp : ∀ v, 0 ≤ psi v) (hpsi : AEStronglyMeasurable psi)
    (hbound : ∀ᵐ v, |psi v| ≤ P) (z : ℝ → ℂ) (beta C : ℝ)
    (hb : 1 / 2 < beta) (hC : 0 ≤ C)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-beta * |v|))
    (hmeas : ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      AEStronglyMeasurable
        (fun v => exteriorWeight R psi v • z (shift side n.val v))) :
    Summable (fun n : {n : ℕ // 2 ≤ n} =>
      (ArithmeticFunction.vonMangoldt n.val / Real.sqrt n.val) *
        ((∫ v, ‖exteriorWeight R psi v • z (shift true n.val v)‖) +
         (∫ v, ‖exteriorWeight R psi v • z (shift false n.val v)‖))) := by
  apply summable_complete_ground_prime_integrals volume (exteriorWeight R psi)
    z beta C hb hC (exteriorWeight_nonneg R psi hp) hz
  · exact bounded_exterior_ground_moment_integrable beta R psi P hpsi hbound
  · exact hmeas

theorem complete_exterior_prime_integrals_continuous_test
    (R : ℝ) (psi : ℝ → ℝ) (P : ℝ)
    (hp : ∀ v, 0 ≤ psi v) (hpsi : AEStronglyMeasurable psi)
    (hbound : ∀ᵐ v, |psi v| ≤ P) (z : ℝ → ℂ) (hzcont : Continuous z)
    (beta C : ℝ) (hb : 1 / 2 < beta) (hC : 0 ≤ C)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-beta * |v|)) :
    Summable (fun n : {n : ℕ // 2 ≤ n} =>
      (ArithmeticFunction.vonMangoldt n.val / Real.sqrt n.val) *
        ((∫ v, ‖exteriorWeight R psi v • z (shift true n.val v)‖) +
         (∫ v, ‖exteriorWeight R psi v • z (shift false n.val v)‖))) := by
  have hi : Integrable (exteriorWeight R psi) := by
    simpa only [zero_mul, Real.exp_zero, one_mul, exteriorWeight] using
      bounded_exterior_ground_moment_integrable 0 R psi P hpsi hbound
  apply complete_exterior_prime_integrals R psi P hp hpsi hbound z beta C hb hC hz
  intro side n
  have hc : Continuous (fun v => z (shift side n.val v)) := by
    unfold shift
    cases side <;> simp only [Bool.false_eq_true, if_false, if_true] <;> fun_prop
  exact hi.aestronglyMeasurable.smul hc.aestronglyMeasurable

#print axioms complete_exterior_prime_integrals_continuous_test
#print axioms exteriorWeight_nonneg
#print axioms complete_exterior_prime_integrals
end BuildingBlocks.ThetaExteriorPrimeIntegrability
