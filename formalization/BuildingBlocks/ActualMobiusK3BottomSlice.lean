import Mathlib.Tactic

/-!
# Exponent algebra for the K=3 Möbius prefix extension

This module checks the rational identities, support bounds, uniform buffer,
and Type I margin used in the companion analytic note. It does not formalize
the external exponential-sum estimates.
-/

namespace BuildingBlocks.ActualMobiusK3BottomSlice

noncomputable section

def dStar (lambda : ℝ) : ℝ := 2 * (lambda + 1) / 5
def cutoffU (lambda : ℝ) : ℝ := (42 * lambda - 55) / 126
def gammaZero (lambda : ℝ) : ℝ := (4 - lambda) / 10
def deltaMax (lambda kappa : ℝ) : ℝ := (lambda - 2) / 10 - kappa
def d (lambda delta : ℝ) : ℝ := dStar lambda + delta
def dFinal (lambda kappa : ℝ) : ℝ := lambda / 2 + 1 / 5 - kappa
def xiSplit (lambda : ℝ) : ℝ := (lambda - 2) / 2
def transitionLower : ℝ := -(1 / 420)
def smallExponent (lambda delta xi : ℝ) : ℝ := (d lambda delta - xi) / 2
def subsetLower (delta xi : ℝ) : ℝ := (5 * delta - xi) / 2
def subsetUpper (lambda delta xi : ℝ) : ℝ := 1 - (d lambda delta + xi) / 2

def rsOne (lambda delta alpha : ℝ) : ℝ :=
  (d lambda delta + alpha - lambda) / 4
def rsTwo (lambda delta alpha : ℝ) : ℝ :=
  (3 * d lambda delta - lambda - 1 - alpha) / 4
def typeIOne (lambda delta : ℝ) : ℝ :=
  d lambda delta / 2 + cutoffU lambda + 13 / 84 - lambda / 2

theorem endpoint_identity (lambda kappa : ℝ) :
    dStar lambda + deltaMax lambda kappa = dFinal lambda kappa := by
  simp [dStar, deltaMax, dFinal]
  ring

theorem aspect_identities (lambda delta xi : ℝ) :
    smallExponent lambda delta xi = (d lambda delta - xi) / 2 ∧
      d lambda delta - smallExponent lambda delta xi =
        (d lambda delta + xi) / 2 := by
  simp [smallExponent]
  ring

theorem rs_bord_overlap {lambda delta kappa : ℝ}
    (hk : 0 < kappa)
    (hkUpper : kappa < (lambda - 2) / 10)
    (hdelta : delta ≤ deltaMax lambda kappa) :
    4 * d lambda delta - 2 * lambda < lambda - d lambda delta := by
  simp [d, dStar, deltaMax] at hdelta ⊢
  linarith

theorem all_short_alpha_bounds {lambda delta xi c : ℝ}
    (hc0 : smallExponent lambda delta xi - 2 * cutoffU lambda ≤ c)
    (hc1 : c ≤ smallExponent lambda delta xi / 3) :
    d lambda delta - 2 * cutoffU lambda ≤
        (d lambda delta + xi) / 2 + c ∧
      (d lambda delta + xi) / 2 + c ≤
        (2 * d lambda delta + xi) / 3 := by
  constructor
  · simp [smallExponent, d, dStar, cutoffU] at hc0 ⊢
    linarith
  · simp [smallExponent, d, dStar] at hc1 ⊢
    linarith

theorem all_short_first_margin {lambda delta xi alpha : ℝ}
    (halpha : alpha ≤ (2 * d lambda delta + xi) / 3) :
    rsOne lambda delta alpha ≤
      -(lambda - 2 - 5 * delta - xi) / 12 := by
  simp [rsOne, d, dStar] at halpha ⊢
  linarith

theorem small_above_cutoff {lambda delta xi kappa : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk : 0 < kappa)
    (hkUpper : kappa < (lambda - 2) / 10)
    (hdeltaLower : transitionLower ≤ delta)
    (hxi : xi ≤ xiSplit lambda) :
    cutoffU lambda < smallExponent lambda delta xi := by
  norm_num [transitionLower, cutoffU, smallExponent, d, dStar, deltaMax,
    xiSplit] at hdeltaLower hxi ⊢
  linarith

theorem small_below_three_cutoffs {lambda delta xi kappa : ℝ}
    (hk : 0 < kappa)
    (hkUpper : kappa < (lambda - 2) / 10)
    (hdelta : delta ≤ deltaMax lambda kappa)
    (hxi0 : 0 ≤ xi) :
    smallExponent lambda delta xi < 3 * cutoffU lambda := by
  simp [cutoffU, smallExponent, d, dStar, deltaMax] at hdelta ⊢
  linarith

theorem forced_atom_identity (lambda delta xi : ℝ) :
    smallExponent lambda delta xi - subsetLower delta xi =
      (lambda + 1) / 5 - 2 * delta := by
  simp [smallExponent, subsetLower, d, dStar]
  ring

theorem uniform_buffer_ledger {lambda kappa delta xi : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk0 : 0 < kappa)
    (hk : kappa < (lambda - 2) / 10)
    (hdelta : delta ≤ deltaMax lambda kappa)
    (hxi0 : 0 ≤ xi) (hxi : xi ≤ xiSplit lambda) :
    cutoffU lambda < subsetUpper lambda delta xi - kappa ∧
      2 * (subsetLower delta xi + kappa) <
        subsetUpper lambda delta xi - kappa ∧
      smallExponent lambda delta xi <
        2 * (subsetUpper lambda delta xi - kappa) ∧
      subsetLower delta xi + kappa < smallExponent lambda delta xi ∧
      2 * gammaZero lambda + 2 * delta <
        smallExponent lambda delta xi - subsetLower delta xi - kappa := by
  simp [cutoffU, subsetUpper, subsetLower, smallExponent, d, dStar,
    deltaMax, xiSplit, gammaZero] at hdelta hxi ⊢
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  constructor <;> linarith

theorem pruning_margin {lambda kappa delta xi : ℝ}
    (hdelta : delta ≤ deltaMax lambda kappa)
    (hxi : xiSplit lambda ≤ xi) :
    5 * kappa ≤ xi - 5 * delta := by
  simp [deltaMax, xiSplit] at hdelta hxi ⊢
  linarith

theorem k3_margin {lambda kappa delta xi : ℝ}
    (hdelta : delta ≤ deltaMax lambda kappa)
    (hxi : xi ≤ xiSplit lambda) :
    5 * kappa ≤ lambda - 2 - 5 * delta - xi := by
  simp [deltaMax, xiSplit] at hdelta hxi ⊢
  linarith

theorem type_i_one_identity (lambda delta : ℝ) :
    typeIOne lambda delta =
      (42 * lambda - 103) / 1260 + delta / 2 := by
  simp [typeIOne, d, dStar, cutoffU]
  ring

theorem type_i_one_negative {lambda kappa delta : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk0 : 0 < kappa)
    (hdelta : delta ≤ deltaMax lambda kappa) :
    typeIOne lambda delta < 0 := by
  rw [type_i_one_identity]
  simp [deltaMax] at hdelta
  linarith

theorem pruning_delta_condition {lambda kappa delta : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk0 : 0 < kappa)
    (hdelta : delta ≤ deltaMax lambda kappa) :
    delta < (103 - 42 * lambda) / 630 := by
  simp [deltaMax] at hdelta
  linarith

theorem decomposition_length {lambda kappa delta : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk0 : 0 < kappa)
    (hdelta : delta ≤ deltaMax lambda kappa) :
    d lambda delta - cutoffU lambda < 1 := by
  simp [d, dStar, cutoffU, deltaMax] at hdelta ⊢
  linarith

theorem transition_reaches_previous_cutoff (lambda : ℝ) :
    d lambda transitionLower = dStar lambda - 1 / 420 := by
  simp [d, transitionLower]
  ring

end
end BuildingBlocks.ActualMobiusK3BottomSlice
