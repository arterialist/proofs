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

/-- Distinct rational frequencies are separated by the reciprocal product
of their positive denominators. -/
theorem rationalFrequencySpacing (a b : ℤ) (n m : ℕ)
    (hn : 0 < n) (hm : 0 < m)
    (hneq : a * (m : ℤ) ≠ b * (n : ℤ)) :
    (1 : ℚ) / ((n : ℚ) * m) ≤
      |(a : ℚ) / n - (b : ℚ) / m| := by
  have hnq : (n : ℚ) ≠ 0 := by positivity
  have hmq : (m : ℚ) ≠ 0 := by positivity
  have hcross : (a * (m : ℤ) - b * (n : ℤ)) ≠ 0 :=
    sub_ne_zero.mpr hneq
  have habsZ : (1 : ℤ) ≤ |a * (m : ℤ) - b * (n : ℤ)| :=
    Int.one_le_abs hcross
  have habsQ : (1 : ℚ) ≤
      |((a * (m : ℤ) - b * (n : ℤ) : ℤ) : ℚ)| := by
    exact_mod_cast habsZ
  rw [show (a : ℚ) / n - (b : ℚ) / m =
      (((a * (m : ℤ) - b * (n : ℤ) : ℤ) : ℚ) /
        ((n : ℚ) * m)) by
      field_simp
      norm_num
      ring]
  rw [abs_div]
  have hden : 0 < (n : ℚ) * m := mul_pos (by positivity) (by positivity)
  rw [abs_of_pos hden]
  exact (div_le_div_iff_of_pos_right hden).mpr habsQ

/-- Frequencies with positive denominators at most 2Q are separated by
1/(4Q^2). -/
theorem dyadicRationalFrequencySpacing (a b : ℤ) (n m Q : ℕ)
    (hn : 0 < n) (hm : 0 < m)
    (hnQ : n ≤ 2 * Q) (hmQ : m ≤ 2 * Q)
    (hneq : a * (m : ℤ) ≠ b * (n : ℤ)) :
    (1 : ℚ) / (4 * (Q : ℚ) ^ 2) ≤
      |(a : ℚ) / n - (b : ℚ) / m| := by
  have hbase := rationalFrequencySpacing a b n m hn hm hneq
  have hQ : 0 < Q := by omega
  have hprodNat : n * m ≤ 4 * Q ^ 2 := by
    nlinarith [Nat.mul_le_mul hnQ hmQ]
  have hprod : (n : ℚ) * m ≤ 4 * (Q : ℚ) ^ 2 := by
    exact_mod_cast hprodNat
  have hnm : 0 < (n : ℚ) * m := by positivity
  exact (one_div_le_one_div_of_le hnm hprod).trans hbase

/-- Distinct reciprocal sample points `N / s` and `N / t` are separated by
`N / (s * t)`. This is the elementary curvature input for sampling at
products `s = q * r`; it does not assert the needed spectral large-sieve
estimate. -/
theorem reciprocalNaturalSpacing (N s t : ℕ)
    (hN : 0 < N) (hs : 0 < s) (ht : 0 < t) (hst : s ≠ t) :
    (N : ℚ) / ((s : ℚ) * t) ≤
      |(N : ℚ) / s - (N : ℚ) / t| := by
  have hdiffZ : (t : ℤ) - s ≠ 0 := sub_ne_zero.mpr (by exact_mod_cast hst.symm)
  have hdiff : (1 : ℚ) ≤ |(t : ℚ) - s| := by
    exact_mod_cast Int.one_le_abs hdiffZ
  have hdenPos : 0 < (s : ℚ) * t := mul_pos (by positivity) (by positivity)
  rw [show (N : ℚ) / s - (N : ℚ) / t =
      (N : ℚ) * ((t : ℚ) - s) / ((s : ℚ) * t) by field_simp]
  rw [abs_div, abs_mul, abs_of_nonneg (by positivity : (0 : ℚ) ≤ N),
    abs_of_pos hdenPos]
  have hnum : (N : ℚ) ≤ (N : ℚ) * |(t : ℚ) - s| := by
    simpa using mul_le_mul_of_nonneg_left hdiff (show (0 : ℚ) ≤ N by positivity)
  exact div_le_div_of_nonneg_right
    hnum (le_of_lt hdenPos)

/-- If `q,r,q',r'` lie in `[1,2Q]` and their products differ, the reciprocal
centers `N/(qr)` are separated by `N/(16Q^4)`. -/
theorem dyadicReciprocalProductSpacing (N q r q' r' Q : ℕ)
    (hN : 0 < N) (hq : 0 < q) (hr : 0 < r)
    (hq' : 0 < q') (hr' : 0 < r')
    (hqQ : q ≤ 2 * Q) (hrQ : r ≤ 2 * Q)
    (hqQ' : q' ≤ 2 * Q) (hrQ' : r' ≤ 2 * Q)
    (hprodNe : q * r ≠ q' * r') :
    (N : ℚ) / (16 * (Q : ℚ) ^ 4) ≤
      |(N : ℚ) / (q * r) - (N : ℚ) / (q' * r')| := by
  have hQ : 0 < Q := by omega
  have hleft : q * r ≤ 4 * Q ^ 2 := by
    nlinarith [Nat.mul_le_mul hqQ hrQ]
  have hright : q' * r' ≤ 4 * Q ^ 2 := by
    nlinarith [Nat.mul_le_mul hqQ' hrQ']
  have hdenNat : (q * r) * (q' * r') ≤ 16 * Q ^ 4 := by
    nlinarith [Nat.mul_le_mul hleft hright]
  have hden : ((q * r : ℕ) : ℚ) * (q' * r' : ℕ) ≤
      16 * (Q : ℚ) ^ 4 := by
    exact_mod_cast hdenNat
  have hsmall : (N : ℚ) / (16 * (Q : ℚ) ^ 4) ≤
      (N : ℚ) / (((q * r : ℕ) : ℚ) * (q' * r' : ℕ)) := by
    exact div_le_div_of_nonneg_left (by positivity) (by positivity) hden
  simpa only [Nat.cast_mul] using
    hsmall.trans (reciprocalNaturalSpacing N (q * r) (q' * r') hN
      (Nat.mul_pos hq hr) (Nat.mul_pos hq' hr') hprodNe)

/-- At the critical packet scale `N ≥ Q^5`, distinct product centers are
separated by at least `Q/16`. -/
theorem criticalReciprocalProductSpacing (N q r q' r' Q : ℕ)
    (hN : 0 < N) (hq : 0 < q) (hr : 0 < r)
    (hq' : 0 < q') (hr' : 0 < r')
    (hqQ : q ≤ 2 * Q) (hrQ : r ≤ 2 * Q)
    (hqQ' : q' ≤ 2 * Q) (hrQ' : r' ≤ 2 * Q)
    (hscale : Q ^ 5 ≤ N) (hprodNe : q * r ≠ q' * r') :
    (Q : ℚ) / 16 ≤
      |(N : ℚ) / (q * r) - (N : ℚ) / (q' * r')| := by
  have hQ : 0 < Q := by omega
  have hscaleQ : (Q : ℚ) ^ 5 ≤ N := by exact_mod_cast hscale
  calc
    (Q : ℚ) / 16 = (Q : ℚ) ^ 5 / (16 * (Q : ℚ) ^ 4) := by
      field_simp
    _ ≤ (N : ℚ) / (16 * (Q : ℚ) ^ 4) :=
      div_le_div_of_nonneg_right hscaleQ (by positivity)
    _ ≤ |(N : ℚ) / (q * r) - (N : ℚ) / (q' * r')| :=
      dyadicReciprocalProductSpacing N q r q' r' Q hN hq hr hq' hr'
        hqQ hrQ hqQ' hrQ' hprodNe

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

/-- The T-exponent of the large-sieve local N-window Q^4 / P^(1-sigma). -/
def localCenterLengthExponent (lambda sigma : ℝ) : ℝ :=
  4 * q lambda - (1 - sigma) * p lambda

/-- At the local window length Q^4 / P^(1-sigma), the normalized large-sieve
boundary term Q^4 / (P Y) has exponent -sigma*p. -/
theorem localBoundaryGainExponent (lambda sigma : ℝ) :
    (4 * q lambda - p lambda) -
        localCenterLengthExponent lambda sigma = -sigma * p lambda := by
  simp [localCenterLengthExponent]
  ring

/-- Markov at the square root of the local mean gain leaves
-sigma*p/2. -/
def localAlmostAllExponent (lambda sigma : ℝ) : ℝ :=
  -sigma * p lambda / 2

theorem localAlmostAllSaves {lambda sigma : ℝ}
    (hlambda : lambda < 5 / 2) (hsigma : 0 < sigma) :
    localAlmostAllExponent lambda sigma < 0 := by
  have hp : 0 < p lambda := by
    simp [p]
    linarith
  have hprod : 0 < sigma * p lambda := mul_pos hsigma hp
  simp [localAlmostAllExponent]
  linarith

end

end BuildingBlocks.ActualMobiusCenteredDivisorWindow

#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.balancedResidueDefect
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.remainderDefectBounds
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.remainderDefect_le_window_mul
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.rationalFrequencySpacing
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.dyadicRationalFrequencySpacing
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.reciprocalNaturalSpacing
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.dyadicReciprocalProductSpacing
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.criticalReciprocalProductSpacing
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.normalizedWindowRmsSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.twoWindowExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.averagedResidualExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.averagedResidualSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.almostAllHighScaleExponent_eq
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.almostAllHighScaleSaves
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.localBoundaryGainExponent
#print axioms BuildingBlocks.ActualMobiusCenteredDivisorWindow.localAlmostAllSaves
