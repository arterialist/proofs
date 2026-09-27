import BuildingBlocks.PrimePrimitiveFormula
import Mathlib.NumberTheory.AbelSummation

open Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks.ConnectedLowModeFinite

open CoarsePrimitive

/-- The literal complete prime-power score on the real cell containing `t`. -/
noncomputable def completeScore (t : ℝ) : ℂ :=
  ∑ n ∈ Finset.Icc 0 ⌊t⌋₊, (ArithmeticFunction.vonMangoldt n : ℂ)

theorem completeScore_eq_psi (t : ℝ) :
    completeScore t = (psi ⌊t⌋₊ : ℂ) := by
  unfold completeScore psi
  rw [← Complex.ofReal_sum]
  congr 1
  apply Finset.sum_congr
  · ext n
    simp only [Finset.mem_Icc, Finset.mem_range]
    omega
  · intro n hn
    rfl

/-- The analytic weighted prime-error integral is split before evaluating the
finite complete-prime-power term. The second integral is the continuous `-t`
part of the literal prime error. -/
noncomputable def weightedActualError (X : ℕ) (f : ℝ → ℂ) : ℂ :=
  (∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ), deriv f t * completeScore t) -
    ∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ), deriv f t * (t : ℂ)

/-- Abel's identity for the actual cutoff, including every prime power and
both endpoints. The upper endpoint is included with its exact weight. -/
theorem weightedActualError_finite {X : ℕ} (hX : 1 ≤ X)
    {f : ℝ → ℂ}
    (hf_diff : ∀ t ∈ Set.Icc (X : ℝ) (2 * X : ℕ), DifferentiableAt ℝ f t)
    (hf_int : IntegrableOn (deriv f) (Set.Icc (X : ℝ) (2 * X : ℕ))) :
    weightedActualError X f =
      f (2 * X : ℕ) * (psi (2 * X) : ℂ) -
      f (X : ℝ) * (psi X : ℂ) -
      (∑ n ∈ Finset.Ioc X (2 * X),
        f n * (ArithmeticFunction.vonMangoldt n : ℂ)) -
      ∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ), deriv f t * (t : ℂ) := by
  have hle : X ≤ 2 * X := by omega
  have hab := sum_mul_eq_sub_sub_integral_mul'
    (c := fun n : ℕ => (ArithmeticFunction.vonMangoldt n : ℂ))
    (f := f) hle hf_diff hf_int
  have hpsi (N : ℕ) :
      (∑ n ∈ Finset.Icc 0 N, (ArithmeticFunction.vonMangoldt n : ℂ)) =
        (psi N : ℂ) := by
    simpa [completeScore] using completeScore_eq_psi (N : ℝ)
  rw [hpsi, hpsi] at hab
  unfold weightedActualError completeScore
  linear_combination hab

/-- A primitive of the complex exponential weight minus its constant mode. -/
noncomputable def phasePrimitive (k : ℂ) (t : ℝ) : ℂ :=
  Complex.exp (k * (t : ℂ)) / k - (t : ℂ)

theorem phasePrimitive_hasDerivAt (k : ℂ) (hk : k ≠ 0) (t : ℝ) :
    HasDerivAt (phasePrimitive k)
      (Complex.exp (k * (t : ℂ)) - 1) t := by
  have he : HasDerivAt
      (fun z : ℂ => Complex.exp (k * z))
      (Complex.exp (k * (t : ℂ)) * k) (t : ℂ) := by
    simpa only [id_eq, mul_one] using (((hasDerivAt_id (t : ℂ)).const_mul k).cexp)
  have her := he.comp_ofReal
  have hid : HasDerivAt (fun u : ℝ => (u : ℂ)) 1 t :=
    (hasDerivAt_id (t : ℂ)).comp_ofReal
  simpa [phasePrimitive, hk] using (her.div_const k).sub hid

/-- The weighted error is the literal complete prime-power score minus its
continuous density, both tested by the exponential phase with constant mode
removed. The derivative of the phase primitive is proved above. -/
theorem weightedPhaseActualError_eq_integrals (X : ℕ) {k : ℂ} (hk : k ≠ 0) :
    weightedActualError X (phasePrimitive k) =
      (∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ),
        (Complex.exp (k * (t : ℂ)) - 1) * completeScore t) -
      ∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ),
        (Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ) := by
  have heq : deriv (phasePrimitive k) =
      fun t : ℝ => Complex.exp (k * (t : ℂ)) - 1 := by
    funext t
    exact (phasePrimitive_hasDerivAt k hk t).deriv
  simp only [weightedActualError, heq]

theorem weightedPhaseActualError_finite {X : ℕ} (hX : 1 ≤ X)
    {k : ℂ} (hk : k ≠ 0) :
    weightedActualError X (phasePrimitive k) =
      phasePrimitive k (2 * X : ℕ) * (psi (2 * X) : ℂ) -
      phasePrimitive k (X : ℝ) * (psi X : ℂ) -
      (∑ n ∈ Finset.Ioc X (2 * X),
        phasePrimitive k n * (ArithmeticFunction.vonMangoldt n : ℂ)) -
      ∫ t in Set.Ioc (X : ℝ) (2 * X : ℕ),
        (Complex.exp (k * (t : ℂ)) - 1) * (t : ℂ) := by
  have hd : ∀ t ∈ Set.Icc (X : ℝ) (2 * X : ℕ),
      DifferentiableAt ℝ (phasePrimitive k) t := by
    intro t _
    exact (phasePrimitive_hasDerivAt k hk t).differentiableAt
  have hi : IntegrableOn (deriv (phasePrimitive k))
      (Set.Icc (X : ℝ) (2 * X : ℕ)) := by
    have heq : deriv (phasePrimitive k) =
        fun t : ℝ => Complex.exp (k * (t : ℂ)) - 1 := by
      funext t
      exact (phasePrimitive_hasDerivAt k hk t).deriv
    rw [heq]
    exact ((Complex.continuous_exp.comp
      (continuous_const.mul Complex.continuous_ofReal)).sub
      continuous_const).integrableOn_Icc
  have h := weightedActualError_finite hX hd hi
  have heq : deriv (phasePrimitive k) =
      fun t : ℝ => Complex.exp (k * (t : ℂ)) - 1 := by
    funext t
    exact (phasePrimitive_hasDerivAt k hk t).deriv
  simpa only [heq] using h

#print axioms weightedActualError_finite
#print axioms weightedPhaseActualError_eq_integrals
#print axioms weightedPhaseActualError_finite

end BuildingBlocks.ConnectedLowModeFinite
