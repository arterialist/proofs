import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Coprime forcing and finite interaction bounds

The arithmetic forcing `log n - card n.divisors + 2 * eulerMascheroniConstant`
has a nonpositive mixed response on positive coprime arguments. A separate
finite product inequality bounds the terms beyond first order by the pair
coefficient. This is the first/second Bonferroni inequality, proved algebraically.

These local identities do not assert a bound for a global signed arithmetic sum.
-/
open Finset
open scoped BigOperators
namespace BuildingBlocks.TwoHistory
noncomputable section

/-- Arithmetic forcing from the logarithm, divisor count, and Euler–Mascheroni constant. -/
def forcing (n : ℕ) : ℝ :=
  Real.log n - (n.divisors.card : ℝ) + 2 * Real.eulerMascheroniConstant

/-- Mixed multiplicative response at coprime blocks is fixed by the actual
logarithm and divisor count. It is independent of the constant term. -/
theorem forcing_coprime_mixed {a b : ℕ} (ha : 0 < a) (hb : 0 < b)
    (hab : Nat.Coprime a b) :
    forcing (a * b) - forcing a - forcing b + forcing 1 =
      -((a.divisors.card : ℝ) - 1) * ((b.divisors.card : ℝ) - 1) := by
  unfold forcing
  rw [hab.card_divisors_mul, Nat.cast_mul, Nat.cast_mul,
    Real.log_mul (by exact_mod_cast ha.ne') (by exact_mod_cast hb.ne')]
  norm_num only [Nat.divisors_one, Finset.card_singleton, Nat.cast_one, Real.log_one]
  ring

theorem forcing_coprime_mixed_nonpos {a b : ℕ} (ha : 0 < a) (hb : 0 < b)
    (hab : Nat.Coprime a b) :
    forcing (a * b) - forcing a - forcing b + forcing 1 ≤ 0 := by
  rw [forcing_coprime_mixed ha hb hab]
  have hca : 1 ≤ a.divisors.card :=
    Finset.card_pos.mpr ⟨1, Nat.one_mem_divisors.mpr ha.ne'⟩
  have hcb : 1 ≤ b.divisors.card :=
    Finset.card_pos.mpr ⟨1, Nat.one_mem_divisors.mpr hb.ne'⟩
  have hcaR : (1 : ℝ) ≤ a.divisors.card := by exact_mod_cast hca
  have hcbR : (1 : ℝ) ≤ b.divisors.card := by exact_mod_cast hcb
  exact mul_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith)

/-- The remainder after the constant and linear terms of a finite product. -/
def higherDefect {ι : Type*} (s : Finset ι) (c : ι → ℝ) : ℝ :=
  (∏ p ∈ s, (1 - c p)) - 1 + ∑ p ∈ s, c p

def pairCoefficient {ι : Type*} (s : Finset ι) (c : ι → ℝ) : ℝ :=
  ((∑ p ∈ s, c p) ^ 2 - ∑ p ∈ s, (c p) ^ 2) / 2

/-- Classical first/second Bonferroni bounds, used without probabilistic assumptions. -/
theorem higherDefect_bounds {ι : Type*} (s : Finset ι) (c : ι → ℝ)
    (hc : ∀ p ∈ s, 0 ≤ c p ∧ c p ≤ 1) :
    0 ≤ higherDefect s c ∧ higherDefect s c ≤ pairCoefficient s c := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [higherDefect, pairCoefficient]
  | @insert p s hps ih =>
    have hp := hc p (Finset.mem_insert_self _ _)
    have hs : ∀ q ∈ s, 0 ≤ c q ∧ c q ≤ 1 :=
      fun q hq => hc q (Finset.mem_insert_of_mem hq)
    have hi := ih hs
    have hsum : 0 ≤ ∑ q ∈ s, c q := Finset.sum_nonneg (fun q hq => (hs q hq).1)
    have hd : higherDefect (insert p s) c =
        (1 - c p) * higherDefect s c + c p * (∑ q ∈ s, c q) := by
      simp only [higherDefect, Finset.prod_insert hps, Finset.sum_insert hps]
      ring
    have he : pairCoefficient (insert p s) c =
        pairCoefficient s c + c p * (∑ q ∈ s, c q) := by
      simp only [pairCoefficient, Finset.sum_insert hps]
      ring
    rw [hd, he]
    constructor
    · exact add_nonneg (mul_nonneg (by linarith) hi.1) (mul_nonneg hp.1 hsum)
    · have hh : (1 - c p) * higherDefect s c ≤ higherDefect s c := by
        nlinarith [mul_nonneg hp.1 hi.1]
      linarith [hi.2]

/-- Reciprocal exponent coefficients lie in the interval required by Bonferroni. -/
theorem exponentCoefficient_bounds (a b : ℕ) :
    0 ≤ (1 : ℝ) / (((a : ℝ) + 1) * ((b : ℝ) + 1)) ∧
    (1 : ℝ) / (((a : ℝ) + 1) * ((b : ℝ) + 1)) ≤ 1 := by
  constructor
  · positivity
  · apply (div_le_one (by positivity)).mpr
    have ha : (0 : ℝ) ≤ a := by positivity
    have hb : (0 : ℝ) ≤ b := by positivity
    nlinarith [mul_nonneg ha hb]

end
end BuildingBlocks.TwoHistory
