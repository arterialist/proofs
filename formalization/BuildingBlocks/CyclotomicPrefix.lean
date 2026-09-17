import Mathlib.RingTheory.Polynomial.Cyclotomic.Roots
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import BuildingBlocks.CyclotomicOldFactor

/-! Actual complete cyclotomic prefixes and their full derivative deficits.
No bound on a zeta zero or arithmetic cancellation is asserted here. -/

open Finset Polynomial
open scoped BigOperators

namespace BuildingBlocks.CyclotomicBoundary

noncomputable section

def phaseRoot (n a : ℕ) : ℂ :=
  (Complex.exp (2 * Real.pi * Complex.I / (n : ℂ))) ^ a

theorem phaseRoot_isPrimitive {n a : ℕ} (hn : 0 < n) (ha : Nat.Coprime a n) :
    IsPrimitiveRoot (phaseRoot n a) n :=
  (Complex.isPrimitiveRoot_exp n hn.ne').pow_of_coprime a ha

/-- Includes `cyclotomic 1`, hence the root at one. -/
def prefixPolynomial (N : ℕ) : Polynomial ℂ :=
  ∏ m ∈ Finset.Icc 1 N, Polynomial.cyclotomic m ℂ

/-- The full derivative is used without a degree or lcm normalization. -/
def rootDeficit (N : ℕ) (α : ℂ) : ℝ :=
  max 0 (-Real.log ‖(prefixPolynomial N).derivative.eval α‖)

def oldRootUpdate (N : ℕ) (α : ℂ) : ℝ :=
  rootDeficit N α - rootDeficit (N - 1) α

theorem prefixPolynomial_succ (N : ℕ) :
    prefixPolynomial (N + 1) =
      prefixPolynomial N * Polynomial.cyclotomic (N + 1) ℂ := by
  exact Finset.prod_Icc_succ_top (by omega) _

theorem prefixPolynomial_step {N : ℕ} (hN : 1 ≤ N) :
    prefixPolynomial N = prefixPolynomial (N - 1) * Polynomial.cyclotomic N ℂ := by
  have h := prefixPolynomial_succ (N - 1)
  simpa [Nat.sub_add_cancel hN] using h

theorem prefixPolynomial_eval_zero {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hnN : n ≤ N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).eval α = 0 := by
  classical
  have hm : n ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨hn, hnN⟩
  have hf := (Finset.Icc 1 N).mul_prod_erase
    (fun m => Polynomial.cyclotomic m ℂ) hm
  have he : (Polynomial.cyclotomic n ℂ).eval α = 0 := hα.isRoot_cyclotomic hn
  rw [prefixPolynomial, ← hf, Polynomial.eval_mul, he, zero_mul]

theorem prefixDerivative_old_step {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α =
      (prefixPolynomial (N - 1)).derivative.eval α *
        (Polynomial.cyclotomic N ℂ).eval α := by
  have hz := prefixPolynomial_eval_zero hn (show n ≤ N - 1 by omega) hα
  rw [prefixPolynomial_step (by omega), Polynomial.derivative_mul]
  simp [Polynomial.eval_add, Polynomial.eval_mul, hz]

theorem clippedLog_lipschitz (x y : ℝ) :
    |max 0 (-x) - max 0 (-y)| ≤ |x - y| := by
  simpa only [max_comm, neg_sub_neg, abs_sub_comm] using
    abs_max_sub_max_le_abs (-x) (-y) 0

theorem prefixDerivative_ne_zero {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hnN : n ≤ N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α ≠ 0 := by
  classical
  have hm : n ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨hn, hnN⟩
  have hf := (Finset.Icc 1 N).mul_prod_erase
    (fun m => Polynomial.cyclotomic m ℂ) hm
  have he : (Polynomial.cyclotomic n ℂ).eval α = 0 := hα.isRoot_cyclotomic hn
  haveI : NeZero (n : ℂ) := ⟨by exact_mod_cast hn.ne'⟩
  have hd : (Polynomial.cyclotomic n ℂ).derivative.eval α ≠ 0 := by
    exact (Polynomial.separable_cyclotomic n ℂ).eval₂_derivative_ne_zero
      (RingHom.id ℂ) he
  have hr : (∏ m ∈ (Finset.Icc 1 N).erase n,
      Polynomial.cyclotomic m ℂ).eval α ≠ 0 := by
    rw [Polynomial.eval_prod]
    apply Finset.prod_ne_zero_iff.mpr
    intro m hm
    exact cyclotomic_eval_ne_zero_of_primitive hα
      (Finset.mem_Icc.mp (Finset.mem_erase.mp hm).2).1 (Finset.mem_erase.mp hm).1
  rw [prefixPolynomial, ← hf, Polynomial.derivative_mul]
  simpa only [Polynomial.eval_add, Polynomial.eval_mul, he, zero_mul, add_zero]
    using mul_ne_zero hd hr

theorem oldRootUpdate_abs_le_factorLog {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    |oldRootUpdate N α| ≤ |Real.log ‖(Polynomial.cyclotomic N ℂ).eval α‖| := by
  have hd := prefixDerivative_ne_zero hn (show n ≤ N - 1 by omega) hα
  have hf := cyclotomic_eval_ne_zero_of_primitive hα (show 0 < N by omega)
    (show N ≠ n by omega)
  have he : Real.log ‖(prefixPolynomial N).derivative.eval α‖ =
      Real.log ‖(prefixPolynomial (N - 1)).derivative.eval α‖ +
      Real.log ‖(Polynomial.cyclotomic N ℂ).eval α‖ := by
    rw [prefixDerivative_old_step hn hOld hα, norm_mul,
      Real.log_mul (norm_ne_zero_iff.mpr hd) (norm_ne_zero_iff.mpr hf)]
  unfold oldRootUpdate rootDeficit
  have h := clippedLog_lipschitz
    (Real.log ‖(prefixPolynomial N).derivative.eval α‖)
    (Real.log ‖(prefixPolynomial (N - 1)).derivative.eval α‖)
  simpa only [he, add_sub_cancel_left] using h

theorem oldRootUpdate_abs_le {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n)
    (hidentity : OldFactorRegularizedIdentity α n N) :
    |oldRootUpdate N α| ≤ (N.divisors.card : ℝ) * Real.log N :=
  (oldRootUpdate_abs_le_factorLog hn hOld hα).trans
    (oldFactor_log_bound_of_regularizedIdentity hα hn hOld hidentity)

end
end BuildingBlocks.CyclotomicBoundary
