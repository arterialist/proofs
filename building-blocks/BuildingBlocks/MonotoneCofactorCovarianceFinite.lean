import Mathlib.Tactic
import Mathlib.NumberTheory.VonMangoldt

/-!
# Complete prime-power cofactor budget and its geometric shadow

The finite identity retains the actual von Mangoldt function, all divisors,
and the exact complementary geometric cofactor weights. The critical-zero
oscillation and all analytic estimates remain written mathematics.
-/

namespace BuildingBlocks.MonotoneCofactorCovarianceFinite

open scoped ArithmeticFunction BigOperators

noncomputable section

/-- The geometric cofactor weight, zero at the arithmetic-function origin. -/
def geometricCofactor (q : ℝ) : ArithmeticFunction ℝ :=
  ⟨fun n => if n = 0 then 0 else q ^ n, by simp⟩

/-- The increasing complementary cofactor weight. -/
def positiveCofactor (q : ℝ) : ArithmeticFunction ℝ :=
  (ζ : ArithmeticFunction ℝ) - geometricCofactor q

/-- The complete prime-power coefficient splits into the positive-cone
coefficient and its signed geometric shadow. -/
theorem complete_budget_shadow (q : ℝ) :
    (Λ * positiveCofactor q) + (Λ * geometricCofactor q) =
      ArithmeticFunction.log := by
  simp [positiveCofactor, mul_sub]

/-- Any finite log-clock test preserves the full prime-power split. -/
theorem finite_budget_shadow (q : ℝ) (s : Finset ℕ) (L : ℕ → ℝ) :
    (∑ n ∈ s, (Λ * positiveCofactor q) n * L n) +
        (∑ n ∈ s, (Λ * geometricCofactor q) n * L n) =
      ∑ n ∈ s, Real.log (n : ℝ) * L n := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  rw [← add_mul]
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n)
    (complete_budget_shadow q)
  simpa only [ArithmeticFunction.log_apply, ArithmeticFunction.add_apply] using
    congrArg (fun x : ℝ => x * L n) h

/-- Centering changes the deterministic complete log score into a variance. -/
theorem finite_log_variance (s : Finset ℕ) (ell : ℝ)
    (hcenter : ∑ n ∈ s, (Real.log (n : ℝ) - ell) = 0) :
    (∑ n ∈ s, Real.log (n : ℝ) * (Real.log (n : ℝ) - ell)) =
      ∑ n ∈ s, (Real.log (n : ℝ) - ell) ^ 2 := by
  calc
    _ = ∑ n ∈ s,
          ((Real.log (n : ℝ) - ell) ^ 2 +
            ell * (Real.log (n : ℝ) - ell)) := by
            apply Finset.sum_congr rfl
            intro n hn
            ring
    _ = ∑ n ∈ s, (Real.log (n : ℝ) - ell) ^ 2 := by
          rw [Finset.sum_add_distrib, ← Finset.mul_sum, hcenter]
          simp

/-- Exact positive-budget plus shadow equals the centered log variance. -/
theorem finite_budget_shadow_variance (q : ℝ) (s : Finset ℕ) (ell : ℝ)
    (hcenter : ∑ n ∈ s, (Real.log (n : ℝ) - ell) = 0) :
    (∑ n ∈ s, (Λ * positiveCofactor q) n *
      (Real.log (n : ℝ) - ell)) +
        (∑ n ∈ s, (Λ * geometricCofactor q) n *
          (Real.log (n : ℝ) - ell)) =
      ∑ n ∈ s, (Real.log (n : ℝ) - ell) ^ 2 := by
  rw [finite_budget_shadow q s]
  exact finite_log_variance s ell hcenter

end
end BuildingBlocks.MonotoneCofactorCovarianceFinite

#print axioms BuildingBlocks.MonotoneCofactorCovarianceFinite.complete_budget_shadow
#print axioms BuildingBlocks.MonotoneCofactorCovarianceFinite.finite_budget_shadow
#print axioms BuildingBlocks.MonotoneCofactorCovarianceFinite.finite_log_variance
#print axioms BuildingBlocks.MonotoneCofactorCovarianceFinite.finite_budget_shadow_variance
