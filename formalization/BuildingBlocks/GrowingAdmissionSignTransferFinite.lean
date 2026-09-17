import Mathlib.Tactic

/-!
# Finite perturbation algebra for growing prime admissions

The analytic estimates enter only through explicit hypotheses.  The results
below retain both endpoint errors when an energy expansion is differenced.
-/

namespace BuildingBlocks.GrowingAdmissionSignTransferFinite

/-- Differencing two level expansions retains the correction increment and
both level remainders. -/
theorem admission_difference
    (A E C R : ℕ → ℝ) (ell : ℝ) (old new : ℕ)
    (h : ∀ s, A s = E s + ell * C s + R s) :
    A new - A old =
      (E new - E old) + ell * (C new - C old) + (R new - R old) := by
  rw [h new, h old]
  ring

/-- A correction increment and two bounded level errors give the stated
absolute admission error. -/
theorem admission_error_le
    (A E C R : ℕ → ℝ) (ell cErr r : ℝ) (old new : ℕ)
    (h : ∀ s, A s = E s + ell * C s + R s)
    (hc : |ell * (C new - C old)| ≤ cErr)
    (hro : |R old| ≤ r) (hrn : |R new| ≤ r) :
    |(A new - A old) - (E new - E old)| ≤ cErr + 2 * r := by
  rw [admission_difference A E C R ell old new h]
  have hd : |R new - R old| ≤ 2 * r := by
    calc
      |R new - R old| ≤ |R new| + |R old| := abs_sub _ _
      _ ≤ r + r := add_le_add hrn hro
      _ = 2 * r := by ring
  calc
    |(E new - E old + ell * (C new - C old) + (R new - R old)) -
        (E new - E old)| =
        |ell * (C new - C old) + (R new - R old)| := by
          congr 1
          ring
    _ ≤ |ell * (C new - C old)| + |R new - R old| := abs_add_le _ _
    _ ≤ cErr + 2 * r := add_le_add hc hd

/-- A positive profile admission keeps its sign when the total absolute
perturbation is smaller than its margin. -/
theorem positive_admission_of_error_lt
    (actual profile err : ℝ)
    (herr : |actual - profile| ≤ err) (hmargin : err < profile) :
    0 < actual := by
  have hlower : profile - err ≤ actual := by
    have := (abs_le.mp (le_trans herr (le_refl err))).1
    linarith
  linarith

/-- A negative profile admission keeps its sign under the corresponding
strict margin condition. -/
theorem negative_admission_of_error_lt
    (actual profile err : ℝ)
    (herr : |actual - profile| ≤ err) (hmargin : err < -profile) :
    actual < 0 := by
  have hupper : actual ≤ profile + err := by
    have := (abs_le.mp (le_trans herr (le_refl err))).2
    linarith
  linarith

/-- Consecutive admissions telescope exactly; no sign information is gained
by summing them. -/
theorem cumulative_admissions (A : ℕ → ℝ) (N : ℕ) :
    ∑ n ∈ Finset.range N, (A (n + 1) - A n) = A N - A 0 := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_range_succ]
      rw [ih]
      ring

/-- A positive limiting/profile lower bound survives a smaller level error. -/
theorem positive_plateau_of_error_lt
    (actual profile floor err : ℝ)
    (hprofile : floor ≤ profile)
    (herr : |actual - profile| ≤ err)
    (hmargin : err < floor) :
    0 < actual := by
  have hlower : profile - err ≤ actual := by
    have := (abs_le.mp (le_trans herr (le_refl err))).1
    linarith
  linarith

end BuildingBlocks.GrowingAdmissionSignTransferFinite

#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.admission_difference
#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.admission_error_le
#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.positive_admission_of_error_lt
#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.negative_admission_of_error_lt
#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.cumulative_admissions
#print axioms BuildingBlocks.GrowingAdmissionSignTransferFinite.positive_plateau_of_error_lt
