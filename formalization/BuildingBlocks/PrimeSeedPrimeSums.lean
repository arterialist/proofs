import BuildingBlocks.PrimeSeedSquare
import Mathlib.NumberTheory.SumPrimeReciprocals

/-! The complete prime seed has divergent total component mass but summable
component square integrals. The latter assertion alone does not estimate the
cross-prime terms in the square of the collective seed.
-/

open MeasureTheory Real

namespace BuildingBlocks.PrimeSeedMass

private theorem prime_one_lt (p : Nat.Primes) : (1 : ℝ) < p := by
  exact_mod_cast p.property.one_lt

/-- Euler's divergence theorem applied to the exact arithmetic seed masses. -/
theorem not_summable_prime_seed_integrals :
    ¬ Summable (fun p : Nat.Primes => ∫ v, seed (log p) v) := by
  intro h
  apply Nat.Primes.not_summable_one_div
  have hs := h.mul_left (1 / 2 : ℝ)
  convert hs using 1
  funext p
  rw [integral_prime_seed (prime_one_lt p)]
  ring

/-- The component square integrals are summable. No orthogonality of distinct
prime seeds, or estimate of their mixed terms, is asserted. -/
theorem summable_prime_seed_square_integrals :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v ^ 2) := by
  have hs : Summable (fun n : ℕ => 1 / (n : ℝ) ^ 2) :=
    summable_one_div_nat_pow.mpr (by decide)
  have ht := hs.subtype Nat.Prime
  convert ht using 1
  funext p
  exact integral_prime_seed_square (prime_one_lt p)

/-- Every finite aggregate retains all the powers of every admitted prime. -/
theorem integral_finset_prime_seed (S : Finset Nat.Primes) :
    (∫ v, ∑ p ∈ S, seed (log p) v) = ∑ p ∈ S, 2 / (p : ℝ) := by
  rw [integral_finset_sum]
  · apply Finset.sum_congr rfl
    intro p _
    exact integral_prime_seed (prime_one_lt p)
  · intro p _
    exact (integrable_seed_and_integral (log_pos (prime_one_lt p))).1

/-- No integrable function can dominate every finite complete prime aggregate.
Thus any pointwise completion dominating these sums is not integrable. -/
theorem no_integrable_majorant_prime_seeds :
    ¬ ∃ G : ℝ → ℝ, Integrable G ∧
      ∀ (S : Finset Nat.Primes) (v : ℝ), (∑ p ∈ S, seed (log p) v) ≤ G v := by
  rintro ⟨G, hG, hdom⟩
  apply not_summable_prime_seed_integrals
  apply summable_of_sum_le (c := ∫ v, G v)
    (fun p : Nat.Primes => integral_nonneg (μ := volume) (seed_nonneg (log (p : ℝ))))
  intro S
  have hi : Integrable (fun v => ∑ p ∈ S, seed (log p) v) := by
    apply integrable_finset_sum
    intro p _
    exact (integrable_seed_and_integral (log_pos (prime_one_lt p))).1
  calc
    (∑ p ∈ S, ∫ v, seed (log p) v) = ∫ v, ∑ p ∈ S, seed (log p) v := by
      rw [integral_finset_sum]
      intro p _
      exact (integrable_seed_and_integral (log_pos (prime_one_lt p))).1
    _ ≤ ∫ v, G v := integral_mono hi hG (hdom S)

end BuildingBlocks.PrimeSeedMass
