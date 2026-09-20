import Mathlib

/-!
# Arithmetic ledger for centered restricted-divisor windows

For a window of H consecutive integers distributed among g residue
classes, the exact centered pair-count defect is b * (g - b), where
b = H % g. This file checks that identity, its sharp quadratic bound,
and the critical exponent obtained after normalizing a sqrt H window
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

/-- The same defect is at most the window length times the modulus. This is
stronger than the quadratic bound when the modulus exceeds the window. -/
theorem remainderDefect_le_window_mul (H g : ℕ) :
    (H % g) * (g - H % g) ≤ H * g := by
  exact Nat.mul_le_mul (Nat.mod_le H g) (Nat.sub_le g (H % g))

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5
def windowExponent (lambda : ℝ) : ℝ := q lambda - p lambda

/-- A square-root-H root-mean-square bound divided by a window of length
H = Q/P has exponent -(3*lambda - 5)/10. -/
theorem normalizedWindowRmsExponent (lambda : ℝ) :
    windowExponent lambda / 2 - windowExponent lambda =
      -(3 * lambda - 5) / 10 := by
  simp [p, q, windowExponent]
  ring

theorem normalizedWindowRmsSaves {lambda : ℝ} (hlambda : 5 / 3 < lambda) :
    windowExponent lambda / 2 - windowExponent lambda < 0 := by
  rw [normalizedWindowRmsExponent]
  linarith

/-- Two such normalized window bounds supply exactly the factor
P / Q = T^(1 - 3*lambda/5). -/
theorem twoWindowExponent (lambda : ℝ) :
    2 * (windowExponent lambda / 2 - windowExponent lambda) =
      p lambda - q lambda := by
  simp [windowExponent]
  ring

/-- Combining the two-window gain with the previous Q/P^2 loss leaves
the strict averaged saving P^(-1). -/
theorem averagedResidualExponent (lambda : ℝ) :
    (q lambda - 2 * p lambda) +
        2 * (windowExponent lambda / 2 - windowExponent lambda) =
      -p lambda := by
  simp [windowExponent]
  ring

theorem averagedResidualSaves {lambda : ℝ} (hlambda : lambda < 5 / 2) :
    (q lambda - 2 * p lambda) +
        2 * (windowExponent lambda / 2 - windowExponent lambda) < 0 := by
  rw [averagedResidualExponent]
  simp [p]
  linarith

/-- Markov at the square root of the averaged P^(-1) gain leaves the
simultaneous almost-all-center exponent -p/2. -/
def almostAllHighScaleExponent (lambda : ℝ) : ℝ := -p lambda / 2

theorem almostAllHighScaleExponent_eq (lambda : ℝ) :
    almostAllHighScaleExponent lambda = -(1 - 2 * lambda / 5) / 2 := by
  simp [almostAllHighScaleExponent, p]

theorem almostAllHighScaleSaves {lambda : ℝ} (hlambda : lambda < 5 / 2) :
    almostAllHighScaleExponent lambda < 0 := by
  rw [almostAllHighScaleExponent_eq]
  linarith

end

end BuildingBlocks.ActualMobiusCenteredDivisorWindow

#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.balancedResidueDefect
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.remainderDefectBounds
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.remainderDefect_le_window_mul
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.twoWindowExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.averagedResidualExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.averagedResidualSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.almostAllHighScaleExponent_eq
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.almostAllHighScaleSaves
