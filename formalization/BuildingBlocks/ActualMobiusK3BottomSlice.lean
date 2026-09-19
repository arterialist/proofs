import Mathlib.Tactic

/-!
# Exponent algebra for the K=3 Möbius prefix extension

This module checks the rational identities, support bounds, uniform buffer,
Type I margin, transition splice, and equality obstruction used in the
companion analytic note. It does not formalize the external exponential-sum
estimates.
-/

namespace BuildingBlocks.ActualMobiusK3BottomSlice

noncomputable section

def dStar (lambda : ℝ) : ℝ := 2 * (lambda + 1) / 5
def cutoffU (lambda : ℝ) : ℝ := (42 * lambda - 55) / 126
def gammaZero (lambda : ℝ) : ℝ := (4 - lambda) / 10
def deltaMax (lambda kappa : ℝ) : ℝ := (lambda - 2) / 5 - kappa
def d (lambda delta : ℝ) : ℝ := dStar lambda + delta
def dFinal (lambda kappa : ℝ) : ℝ := 3 * lambda / 5 - kappa
def xiSplit (lambda : ℝ) : ℝ := lambda - 2
def transitionLower : ℝ := -(1 / 420)
def smallExponent (lambda delta xi : ℝ) : ℝ := (d lambda delta - xi) / 2
def subsetLower (delta xi : ℝ) : ℝ := (5 * delta - xi) / 2
def subsetUpper (lambda delta xi : ℝ) : ℝ := 1 - (d lambda delta + xi) / 2

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

theorem rs_bord_overlap_margin {lambda delta kappa : ℝ}
    (hdelta : delta ≤ deltaMax lambda kappa) :
    5 * kappa ≤ 3 * lambda - 5 * d lambda delta := by
  simp [d, dStar, deltaMax] at hdelta ⊢
  linarith

theorem small_above_cutoff {lambda delta xi kappa : ℝ}
    (hhigh : lambda < 29 / 14)
    (hk0 : 0 < kappa)
    (hk : kappa < (lambda - 2) / 5)
    (hdeltaLower : transitionLower ≤ delta)
    (hxi : xi ≤ xiSplit lambda) :
    cutoffU lambda < smallExponent lambda delta xi := by
  norm_num [transitionLower, cutoffU, smallExponent, d, dStar, deltaMax,
    xiSplit] at hdeltaLower hxi ⊢
  linarith

theorem small_below_three_cutoffs {lambda delta xi kappa : ℝ}
    (hlow : 2 < lambda)
    (hk0 : 0 < kappa)
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
    (hk : kappa < (lambda - 2) / 5)
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

theorem equality_geometry (lambda : ℝ) :
    let delta := (lambda - 2) / 5
    let xi := lambda - 2
    let x := (3 * lambda / 5 - xi) / 2
    x = (5 - lambda) / 5 ∧
      2 * gammaZero lambda + 2 * delta = lambda / 5 := by
  dsimp
  simp [gammaZero]
  constructor <;> ring

theorem equality_short_factor_admissible {lambda : ℝ}
    (hlow : 2 < lambda) :
    (5 - 2 * lambda) / 5 < cutoffU lambda := by
  simp [cutoffU]
  linarith

theorem equality_contact_geometry (lambda : ℝ) :
    let de := 3 * lambda / 5
    let delta := (lambda - 2) / 5
    let xi := lambda - 2
    let base := (de + xi) / 2
    let s0 := (5 - 2 * lambda) / 5
    let z := lambda / 5
    lambda - de = 4 * de - 2 * lambda ∧
      lambda - de - base = s0 ∧
      1 - base = 2 * s0 ∧
      z - (1 - base) = lambda - 2 ∧
      2 * gammaZero lambda + 2 * delta = z := by
  dsimp
  simp [gammaZero]
  constructor
  · ring
  constructor
  · ring
  constructor
  · ring
  constructor <;> ring

theorem type_i_endpoint_margin (lambda kappa : ℝ) :
    (42 * lambda - 103) / 1260 + deltaMax lambda kappa / 2 =
      (168 * lambda - 355) / 1260 - kappa / 2 := by
  simp [deltaMax]
  ring

end
end BuildingBlocks.ActualMobiusK3BottomSlice
