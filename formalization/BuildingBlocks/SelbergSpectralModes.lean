import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Ring

open MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

/-- An additive frequency on logarithmic time. -/
noncomputable def spectralMode (γ t : ℝ) : ℂ :=
  Complex.exp (Complex.I * (γ : ℂ) * (t : ℂ))

theorem continuous_spectralMode (γ : ℝ) : Continuous (spectralMode γ) := by
  unfold spectralMode
  fun_prop

/-- The exact reflected integral, including the resonant branch. The identity
uses oriented interval integrals and therefore holds for every real `T`. -/
theorem integral_reflected_spectralMode (γ δ T : ℝ) :
    (∫ t in (0 : ℝ)..T, spectralMode γ t * spectralMode δ (T - t)) =
      if γ = δ then (T : ℂ) * spectralMode γ T
      else (spectralMode γ T - spectralMode δ T) /
        (Complex.I * ((γ : ℂ) - (δ : ℂ))) := by
  by_cases h : γ = δ
  · subst δ
    simp only [if_true]
    have heq : (fun t : ℝ => spectralMode γ t * spectralMode γ (T - t)) =
        fun _ => spectralMode γ T := by
      funext t
      unfold spectralMode
      rw [← Complex.exp_add]
      congr 1
      push_cast
      ring
    rw [heq]
    simp
  · simp only [h, if_false]
    have hc : Complex.I * ((γ : ℂ) - (δ : ℂ)) ≠ 0 := by
      apply mul_ne_zero Complex.I_ne_zero
      exact sub_ne_zero.mpr (by exact_mod_cast h)
    have heq : (fun t : ℝ => spectralMode γ t * spectralMode δ (T - t)) =
        fun t : ℝ => spectralMode δ T *
          Complex.exp ((Complex.I * ((γ : ℂ) - (δ : ℂ))) * (t : ℂ)) := by
      funext t
      unfold spectralMode
      rw [← Complex.exp_add, ← Complex.exp_add]
      congr 1
      push_cast
      ring
    rw [heq, intervalIntegral.integral_const_mul,
      integral_exp_mul_complex hc]
    simp only [Complex.ofReal_zero, mul_zero, Complex.exp_zero]
    have hexp : spectralMode δ T *
        Complex.exp ((Complex.I * ((γ : ℂ) - (δ : ℂ))) * (T : ℂ)) =
        spectralMode γ T := by
      unfold spectralMode
      rw [← Complex.exp_add]
      congr 1
      ring
    rw [← mul_div_assoc, mul_sub, mul_one, hexp]

/-- Finite spectral reflection retains every unequal-frequency cross term. -/
theorem integral_reflected_spectral_sum {ι κ : Type*}
    (s : Finset ι) (r : Finset κ) (A : ι → ℂ) (B : κ → ℂ)
    (γ : ι → ℝ) (δ : κ → ℝ) (T : ℝ) :
    (∫ t in (0 : ℝ)..T,
      (∑ i ∈ s, A i * spectralMode (γ i) t) *
      (∑ j ∈ r, B j * spectralMode (δ j) (T - t))) =
    ∑ i ∈ s, ∑ j ∈ r, (A i * B j) *
      (if γ i = δ j then (T : ℂ) * spectralMode (γ i) T
       else (spectralMode (γ i) T - spectralMode (δ j) T) /
         (Complex.I * ((γ i : ℂ) - (δ j : ℂ)))) := by
  have heq : (fun t : ℝ =>
      (∑ i ∈ s, A i * spectralMode (γ i) t) *
      (∑ j ∈ r, B j * spectralMode (δ j) (T - t))) =
      fun t => ∑ i ∈ s, ∑ j ∈ r,
        (A i * B j) * (spectralMode (γ i) t * spectralMode (δ j) (T - t)) := by
    funext t
    simp only [Finset.sum_mul, Finset.mul_sum]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro i hi
    apply Finset.sum_congr rfl
    intro j hj
    ring
  rw [heq, intervalIntegral.integral_finset_sum]
  · apply Finset.sum_congr rfl
    intro i hi
    rw [intervalIntegral.integral_finset_sum]
    · apply Finset.sum_congr rfl
      intro j hj
      rw [intervalIntegral.integral_const_mul, integral_reflected_spectralMode]
    · intro j hj
      apply Continuous.intervalIntegrable
      unfold spectralMode
      fun_prop
  · intro i hi
    apply Continuous.intervalIntegrable
    unfold spectralMode
    fun_prop

end BuildingBlocks
