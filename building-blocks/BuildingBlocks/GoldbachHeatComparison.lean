import BuildingBlocks.GoldbachHeatQuadratic
import Mathlib.Algebra.QuadraticDiscriminant

/-! Complete signed cross terms and perturbation bounds for finite Goldbach heat energy. -/

open Real
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

noncomputable def finitePairing (a b : ℕ → ℝ) (N : ℕ) (s : ℝ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 N, ∑ n ∈ Finset.Icc 1 N,
    a m * b n * (1 / ((m : ℝ) + n)) ^ s

theorem finitePairing_self (a : ℕ → ℝ) (N : ℕ) (s : ℝ) :
    finitePairing a a N s = finiteEnergy a N s := rfl

theorem finitePairing_symm (a b : ℕ → ℝ) (N : ℕ) (s : ℝ) :
    finitePairing a b N s = finitePairing b a N s := by
  unfold finitePairing
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [add_comm (n : ℝ) m, mul_comm (a n) (b m)]

theorem finitePairing_add_left (a b c : ℕ → ℝ) (N : ℕ) (s : ℝ) :
    finitePairing (fun n => a n + b n) c N s =
      finitePairing a c N s + finitePairing b c N s := by
  simp only [finitePairing, add_mul, Finset.sum_add_distrib]

theorem finitePairing_mul_left (a b : ℕ → ℝ) (N : ℕ) (s r : ℝ) :
    finitePairing (fun n => r * a n) b N s = r * finitePairing a b N s := by
  simp only [finitePairing, mul_assoc, Finset.mul_sum]

theorem finiteEnergy_add_mul (a b : ℕ → ℝ) (N : ℕ) (s r : ℝ) :
    finiteEnergy (fun n => a n + r * b n) N s =
      finiteEnergy a N s + 2 * r * finitePairing a b N s + r ^ 2 * finiteEnergy b N s := by
  rw [← finitePairing_self, finitePairing_add_left, finitePairing_mul_left]
  rw [finitePairing_symm a, finitePairing_add_left, finitePairing_mul_left]
  rw [finitePairing_symm b (fun n => a n + r * b n),
    finitePairing_add_left, finitePairing_mul_left]
  rw [finitePairing_symm b a, finitePairing_self, finitePairing_self]
  ring

/-- Cauchy–Schwarz for the full signed additive kernel. No coefficientwise sign
or independence hypothesis is used. -/
theorem finitePairing_sq_le (a b : ℕ → ℝ) (N : ℕ) {s : ℝ} (hs : 0 < s) :
    finitePairing a b N s ^ 2 ≤ finiteEnergy a N s * finiteEnergy b N s := by
  have h := discrim_le_zero (a := finiteEnergy b N s)
    (b := 2 * finitePairing a b N s) (c := finiteEnergy a N s) (fun r => ?_)
  · simp only [discrim] at h
    nlinarith
  · have hp := finiteEnergy_nonneg (fun n => a n + r * b n) N hs
    rw [finiteEnergy_add_mul] at hp
    nlinarith

/-- Adding a signed baseline retains the exact cross term and costs at most
twice each complete energy. -/
theorem finiteEnergy_add_le (a b : ℕ → ℝ) (N : ℕ) {s : ℝ} (hs : 0 < s) :
    finiteEnergy (fun n => a n + b n) N s ≤
      2 * finiteEnergy a N s + 2 * finiteEnergy b N s := by
  have h := finiteEnergy_nonneg (fun n => a n + (-1) * b n) N hs
  rw [finiteEnergy_add_mul] at h
  have he := finiteEnergy_add_mul a b N s 1
  simp only [one_mul, one_pow] at he
  rw [he]
  linarith

/-- The actual prime coefficients are the centered coefficients plus the
discrete density, including the initial index one. -/
theorem vonMangoldt_energy_le_centered (N : ℕ) {s : ℝ} (hs : 0 < s) :
    finiteEnergy (fun n => ArithmeticFunction.vonMangoldt n) N s ≤
      2 * finiteEnergy centeredCoefficient N s + 2 * finiteEnergy (fun _ => 1) N s := by
  convert finiteEnergy_add_le centeredCoefficient (fun _ => 1) N hs using 1
  congr 1
  funext n
  simp [centeredCoefficient]

end BuildingBlocks.GoldbachHeat
