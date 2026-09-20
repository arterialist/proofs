import Mathlib

/-!
# Arithmetic ledger for centered restricted-divisor windows

For a window of H consecutive integers distributed among g residue
classes, the exact centered pair-count defect is b * (g - b), where
b = H % g. This file checks that identity, its sharp quadratic bound,
and the critical exponent obtained after normalizing a sqrt Q window
mean by a window of length Q / P.
-/

namespace BuildingBlocks.ActualMobiusCenteredDivisorWindow

noncomputable section

/-- The exact residue-class defect for a consecutive window. There are
b = H % g residue classes of size H / g + 1 and g - b classes of
size H / g. -/
theorem balancedResidueDefect (H g : ℕ) (hg : 0 < g) :
    (g : ℤ) * (((g - H % g : ℕ) : ℤ) * (H / g : ℤ) ^ 2 +
      (H % g : ℤ) * ((H / g : ℤ) + 1) ^ 2) - (H : ℤ) ^ 2 =
      (H % g : ℤ) * (g - H % g : ℕ) := by
  have hb_lt : H % g < g := Nat.mod_lt H hg
  have hb_le : H % g ≤ g := Nat.le_of_lt hb_lt
  have hdecomp_nat : H % g + g * (H / g) = H := Nat.mod_add_div H g
  have hsub : ((g - H % g : ℕ) : ℤ) =
      (g : ℤ) - (H % g : ℤ) := by
    simpa using (Nat.cast_sub (R := ℤ) hb_le)
  have hdecomp : (H % g : ℤ) + (g : ℤ) * (H / g : ℤ) = (H : ℤ) := by
    exact_mod_cast hdecomp_nat
  rw [hsub]
  nlinarith

/-- The residue defect is nonnegative and at most g^2 / 4. -/
theorem remainderDefectBounds (H g : ℕ) (hg : 0 < g) :
    (0 : ℤ) ≤ (H % g : ℤ) * (g - H % g : ℕ) ∧
      4 * ((H % g : ℤ) * (g - H % g : ℕ)) ≤ (g : ℤ) ^ 2 := by
  have hb_lt : H % g < g := Nat.mod_lt H hg
  have hb_le : H % g ≤ g := Nat.le_of_lt hb_lt
  have hsub : ((g - H % g : ℕ) : ℤ) =
      (g : ℤ) - (H % g : ℤ) := by
    simpa using (Nat.cast_sub (R := ℤ) hb_le)
  rw [hsub]
  have hbz : (0 : ℤ) ≤ (H % g : ℤ) := by
    exact_mod_cast (Nat.zero_le (H % g))
  have hbgz : (H % g : ℤ) ≤ (g : ℤ) := by
    exact_mod_cast hb_le
  constructor
  · exact mul_nonneg hbz (sub_nonneg.mpr hbgz)
  · nlinarith [sq_nonneg ((g : ℤ) - 2 * (H % g : ℤ))]

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5
def windowExponent (lambda : ℝ) : ℝ := q lambda - p lambda

/-- A sqrt Q root-mean-square bound divided by a window of length Q/P
has exponent -(lambda - 2) / 2. -/
theorem normalizedWindowRmsExponent (lambda : ℝ) :
    q lambda / 2 - windowExponent lambda = -(lambda - 2) / 2 := by
  simp [p, q, windowExponent]
  ring

theorem normalizedWindowRmsSaves {lambda : ℝ} (hlambda : 2 < lambda) :
    q lambda / 2 - windowExponent lambda < 0 := by
  rw [normalizedWindowRmsExponent]
  linarith

/-- Two such normalized window bounds supply exactly the factor
P^2 / Q = T^(-(lambda - 2)). -/
theorem twoWindowExponent (lambda : ℝ) :
    2 * (q lambda / 2 - windowExponent lambda) = -(lambda - 2) := by
  rw [normalizedWindowRmsExponent]
  ring

end

end BuildingBlocks.ActualMobiusCenteredDivisorWindow

#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.balancedResidueDefect
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.remainderDefectBounds
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.twoWindowExponent
