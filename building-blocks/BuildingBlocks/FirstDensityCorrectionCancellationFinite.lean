import Mathlib.Tactic

/-!
# Finite algebra for removing the first density correction

All analytic asymptotics enter as hypotheses.  The theorems prove the exact
subtraction, two-horizon cancellation, scaled coefficient identity, and the
failure of an unweighted adjacent-stage sum to cancel same-sign drifts.
-/

namespace BuildingBlocks.FirstDensityCorrectionCancellationFinite

/-- Subtracting the known level correction removes its admission increment
exactly, while retaining both level remainders. -/
theorem corrected_admission
    (A E C R : ℕ → ℝ) (ell : ℝ)
    (h : ∀ s, A s = E s + ell * C s + R s)
    (old new : ℕ) :
    ((A new - ell * C new) - (A old - ell * C old)) -
        (E new - E old) = R new - R old := by
  rw [h new, h old]
  ring

/-- Richardson combination for horizons whose logarithms are `L` and `aL`.
The coefficient proportional to the reciprocal logarithm cancels exactly. -/
theorem richardson_two_horizon
    (E C R₁ R₂ A₁ A₂ L a : ℝ)
    (hL : L ≠ 0) (ha : a ≠ 0) (ha1 : a ≠ 1)
    (h₁ : A₁ = E + C / L + R₁)
    (h₂ : A₂ = E + C / (a * L) + R₂) :
    (a * A₂ - A₁) / (a - 1) =
      E + (a * R₂ - R₁) / (a - 1) := by
  rw [h₁, h₂]
  have hden : a - 1 ≠ 0 := sub_ne_zero.mpr ha1
  field_simp [hL, ha, hden]
  ring

/-- If the correction increment is `exp(-2p) * (1+eps)`, then its
normalization in the fixed-profile admission formula is exactly
`p/L * (1+eps)`. -/
theorem scaled_leading_coefficient
    (p L kernel eps dC : ℝ) (hL : L ≠ 0) (hk : kernel ≠ 0)
    (hdC : dC = kernel * (1 + eps)) :
    p / kernel * (dC / L) = p / L * (1 + eps) := by
  rw [hdC]
  field_simp

/-- Same-sign leading corrections cannot cancel in an unweighted adjacent
sum. -/
theorem adjacent_positive_drift
    (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a + b := by
  positivity

/-- The unique two-term weighted cancellation relation.  It also displays
why a negative weight changes the fixed-profile observable. -/
theorem weighted_pair_cancellation
    (a b w₁ w₂ : ℝ) (hb : b ≠ 0)
    (hcancel : w₁ * a + w₂ * b = 0) :
    w₂ = -w₁ * a / b := by
  apply (eq_div_iff hb).2
  linarith

end BuildingBlocks.FirstDensityCorrectionCancellationFinite

#print axioms BuildingBlocks.FirstDensityCorrectionCancellationFinite.corrected_admission
#print axioms BuildingBlocks.FirstDensityCorrectionCancellationFinite.richardson_two_horizon
#print axioms BuildingBlocks.FirstDensityCorrectionCancellationFinite.scaled_leading_coefficient
#print axioms BuildingBlocks.FirstDensityCorrectionCancellationFinite.adjacent_positive_drift
#print axioms BuildingBlocks.FirstDensityCorrectionCancellationFinite.weighted_pair_cancellation
