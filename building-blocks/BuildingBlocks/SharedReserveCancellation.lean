import Mathlib.Tactic

namespace PaidThetaCompensation

/-!
Finite algebra common to the boundary-Weyl, observability-Gramian, and
effective-network interpretations of the even joint-null comparison.
-/

/-- The same exterior reserve `C` is subtracted from both the constrained
extension energy and the complete gain, so it cancels exactly. -/
theorem shared_reserve_cancellation
    (core Q C : ℝ) :
    (core - C) - (Q - C) = core - Q := by
  ring

/-- The desired signed comparison after shared-reserve cancellation is
exactly domination of the port Gram by the core supply. -/
theorem shared_reserve_nonnegative_iff
    (core Q C : ℝ) :
    0 ≤ (core - C) - (Q - C) ↔ Q ≤ core := by
  rw [shared_reserve_cancellation]
  constructor <;> intro h <;> linarith

/-- Any perturbation of only the common reserve changes storage and loss by
the same amount and leaves their signed difference invariant. -/
theorem shared_reserve_shift_invariant
    (core Q C Δ : ℝ) :
    (core - (C + Δ)) - (Q - (C + Δ)) =
      (core - C) - (Q - C) := by
  ring

/-- An upper bound on covariance gives a lower bound on its complementary
gain `D = Q-C`; this is the wrong direction for paying that gain. -/
theorem covariance_upper_forces_gain_lower
    {Q C D U : ℝ}
    (hdecomp : D = Q - C)
    (hC : C ≤ U) :
    Q - U ≤ D := by
  linarith

/-- Conversely, an upper bound on the complementary gain requires a lower
bound on the covariance. -/
theorem covariance_lower_gives_gain_upper
    {Q C D L : ℝ}
    (hdecomp : D = Q - C)
    (hC : L ≤ C) :
    D ≤ Q - L := by
  linarith

/-- Finite control/network certificate: a lower core coercivity coefficient
and an upper port coefficient prove the signed comparison when ordered. -/
theorem core_coercivity_pays_port
    {core Q coreCoeff portCoeff normSq : ℝ}
    (hnorm : 0 ≤ normSq)
    (hcore : coreCoeff * normSq ≤ core)
    (hport : Q ≤ portCoeff * normSq)
    (hcoeff : portCoeff ≤ coreCoeff) :
    0 ≤ core - Q := by
  have hpay : portCoeff * normSq ≤ coreCoeff * normSq :=
    mul_le_mul_of_nonneg_right hcoeff hnorm
  linarith

/-- The same coefficient test, written before cancellation in the two-port
storage/loss variables. -/
theorem shared_reserve_coefficient_certificate
    {core Q C coreCoeff portCoeff normSq : ℝ}
    (hnorm : 0 ≤ normSq)
    (hcore : coreCoeff * normSq ≤ core)
    (hport : Q ≤ portCoeff * normSq)
    (hcoeff : portCoeff ≤ coreCoeff) :
    0 ≤ (core - C) - (Q - C) := by
  rw [shared_reserve_cancellation]
  exact core_coercivity_pays_port hnorm hcore hport hcoeff

end PaidThetaCompensation
