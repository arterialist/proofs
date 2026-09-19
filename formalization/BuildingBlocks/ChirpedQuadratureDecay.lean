import BuildingBlocks.ChirpedPhaseBandLocalization
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedQuadratureDecay

open BuildingBlocks.ChirpedPhaseBandLocalization

/-!
# Pointwise Second-Order Chirp Bounds

This module defines a scalar expression named `secondOrderIBPOperator` and bounds that expression
from amplitude, curvature, and gradient inequalities.  It also proves algebraic square and dyadic
bounds.  No oscillatory integral, integration-by-parts formula with boundary terms, or quadrature
error is defined, so these results alone are not an integral decay estimate.
-/

/-- The third derivative of the quadratic chirped phase is identically zero. -/
def chirpedPhaseThirdDeriv (_T _eta : ℝ) : ℝ := 0

/-- Vanishing of the third derivative of the quadratic chirped phase. -/
theorem chirpedPhaseThirdDeriv_eq_zero (T eta : ℝ) :
    chirpedPhaseThirdDeriv T eta = 0 := rfl

/-- The second derivative of the chirped phase is constant, so its derivative is zero everywhere. -/
theorem hasDerivAt_chirpedPhaseSecondDeriv (T eta x : ℝ) :
    HasDerivAt (fun _ : ℝ => -2 * eta * T) 0 x :=
  hasDerivAt_const x (-2 * eta * T)

/-- A scalar expression motivated by a second-order integration-by-parts calculation:
`D₂ = a₂ / p₁² - 3 * a₁ * p₂ / p₁³ + 3 * a₀ * p₂² / p₁⁴`. -/
noncomputable def secondOrderIBPOperator (a₀ a₁ a₂ p₁ p₂ : ℝ) : ℝ :=
  a₂ / p₁^2 - 3 * a₁ * p₂ / p₁^3 + 3 * a₀ * p₂^2 / p₁^4

/-- The uniform second-order integration-by-parts coefficient. -/
def secondOrderIBPCoeff (A₀ A₁ A₂ eta : ℝ) : ℝ :=
  A₂ + 6 * eta * A₁ + 12 * eta^2 * A₀

/-- Strict positivity of the second-order IBP coefficient. -/
theorem secondOrderIBPCoeff_pos {A₀ A₁ A₂ eta : ℝ}
    (hA₀ : 0 < A₀) (hA₁ : 0 ≤ A₁) (hA₂ : 0 < A₂) (heta : 0 < eta) :
    0 < secondOrderIBPCoeff A₀ A₁ A₂ eta := by
  unfold secondOrderIBPCoeff
  have h1 : 0 ≤ 6 * eta * A₁ := by positivity
  have h2 : 0 < 12 * eta^2 * A₀ := by positivity
  linarith

/-- Pointwise bound on the second-order IBP operator under gradient lower bound `Δ ≤ |p₁|`. -/
theorem second_order_ibp_pointwise_bound
    {a₀ a₁ a₂ p₁ p₂ A₀ A₁ A₂ eta T Δ : ℝ}
    (ha₀ : |a₀| ≤ A₀) (ha₁ : |a₁| ≤ A₁) (ha₂ : |a₂| ≤ A₂)
    (hp₂ : |p₂| = 2 * eta * T)
    (hΔ_pos : 0 < Δ) (hp₁ : Δ ≤ |p₁|)
    (hA₀_nonneg : 0 ≤ A₀) (hA₁_nonneg : 0 ≤ A₁) (hA₂_nonneg : 0 ≤ A₂)
    (heta_nonneg : 0 ≤ eta) (hT_nonneg : 0 ≤ T) :
    |secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂| ≤
    A₂ / Δ^2 + 6 * eta * T * A₁ / Δ^3 + 12 * eta^2 * T^2 * A₀ / Δ^4 := by
  unfold secondOrderIBPOperator
  -- Triangle inequality: |x - y + z| ≤ |x| + |y| + |z|
  have hsub : a₂ / p₁^2 - 3 * a₁ * p₂ / p₁^3 = a₂ / p₁^2 + (- (3 * a₁ * p₂ / p₁^3)) := sub_eq_add_neg _ _
  have htri1 : |(a₂ / p₁^2 - 3 * a₁ * p₂ / p₁^3) + 3 * a₀ * p₂^2 / p₁^4| ≤
      |a₂ / p₁^2 - 3 * a₁ * p₂ / p₁^3| + |3 * a₀ * p₂^2 / p₁^4| := abs_add_le _ _
  have htri2 : |a₂ / p₁^2 + (- (3 * a₁ * p₂ / p₁^3))| ≤
      |a₂ / p₁^2| + |- (3 * a₁ * p₂ / p₁^3)| := abs_add_le _ _
  rw [abs_neg] at htri2
  rw [← hsub] at htri2
  have htri : |secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂| ≤
      |a₂ / p₁^2| + |3 * a₁ * p₂ / p₁^3| + |3 * a₀ * p₂^2 / p₁^4| := by
    unfold secondOrderIBPOperator
    linarith
  -- Term 1: |a₂ / p₁²| = |a₂| / |p₁|² ≤ A₂ / Δ²
  have hp1_sq_nonneg : 0 ≤ |p₁|^2 := by positivity
  have h1 : |a₂ / p₁^2| ≤ A₂ / Δ^2 := by
    rw [abs_div, abs_pow]
    have hden : Δ^2 ≤ |p₁|^2 := by
      nlinarith [hp₁, abs_nonneg p₁]
    have hnum : |a₂| ≤ A₂ := ha₂
    have hden_pos : 0 < Δ^2 := by positivity
    calc
      |a₂| / |p₁|^2 ≤ A₂ / |p₁|^2 := by
        exact div_le_div_of_nonneg_right hnum hp1_sq_nonneg
      _ ≤ A₂ / Δ^2 := by
        exact div_le_div_of_nonneg_left hA₂_nonneg hden_pos hden
  -- Term 2: |3 * a₁ * p₂ / p₁³| ≤ 6 * eta * T * A₁ / Δ³
  have hp1_cubed_nonneg : 0 ≤ |p₁|^3 := by positivity
  have h2 : |3 * a₁ * p₂ / p₁^3| ≤ 6 * eta * T * A₁ / Δ^3 := by
    rw [abs_div, abs_mul, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 3), hp₂]
    have hnum_le : 3 * |a₁| * (2 * eta * T) ≤ 6 * eta * T * A₁ := by
      have h3 : 3 * |a₁| * (2 * eta * T) = 6 * eta * T * |a₁| := by ring
      rw [h3]
      have hpos : 0 ≤ 6 * eta * T := by positivity
      exact mul_le_mul_of_nonneg_left ha₁ hpos
    have hden_le : Δ^3 ≤ |p₁|^3 := by
      have hΔ_sq : Δ^2 ≤ |p₁|^2 := by nlinarith [hp₁, abs_nonneg p₁]
      nlinarith [hp₁, abs_nonneg p₁]
    rw [abs_pow]
    have hΔ3_pos : 0 < Δ^3 := by positivity
    calc
      3 * |a₁| * (2 * eta * T) / |p₁|^3 ≤ (6 * eta * T * A₁) / |p₁|^3 := by
        exact div_le_div_of_nonneg_right hnum_le hp1_cubed_nonneg
      _ ≤ (6 * eta * T * A₁) / Δ^3 := by
        have hnum_nonneg : 0 ≤ 6 * eta * T * A₁ := by positivity
        exact div_le_div_of_nonneg_left hnum_nonneg hΔ3_pos hden_le
  -- Term 3: |3 * a₀ * p₂² / p₁⁴| ≤ 12 * eta² * T² * A₀ / Δ⁴
  have hp1_pow4_nonneg : 0 ≤ |p₁|^4 := by positivity
  have h3 : |3 * a₀ * p₂^2 / p₁^4| ≤ 12 * eta^2 * T^2 * A₀ / Δ^4 := by
    rw [abs_div, abs_mul, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 3), abs_pow, hp₂]
    have hp2_sq : (2 * eta * T)^2 = 4 * eta^2 * T^2 := by ring
    rw [hp2_sq]
    have hnum_le : 3 * |a₀| * (4 * eta^2 * T^2) ≤ 12 * eta^2 * T^2 * A₀ := by
      have h_eq : 3 * |a₀| * (4 * eta^2 * T^2) = 12 * eta^2 * T^2 * |a₀| := by ring
      rw [h_eq]
      have hpos : 0 ≤ 12 * eta^2 * T^2 := by positivity
      exact mul_le_mul_of_nonneg_left ha₀ hpos
    rw [abs_pow]
    have hden_le : Δ^4 ≤ |p₁|^4 := by
      have h2a : Δ^2 ≤ |p₁|^2 := by nlinarith [hp₁, abs_nonneg p₁]
      nlinarith [h2a, abs_nonneg p₁]
    have hΔ4_pos : 0 < Δ^4 := by positivity
    calc
      3 * |a₀| * (4 * eta^2 * T^2) / |p₁|^4 ≤ (12 * eta^2 * T^2 * A₀) / |p₁|^4 := by
        exact div_le_div_of_nonneg_right hnum_le hp1_pow4_nonneg
      _ ≤ (12 * eta^2 * T^2 * A₀) / Δ^4 := by
        have hnum_nonneg : 0 ≤ 12 * eta^2 * T^2 * A₀ := by positivity
        exact div_le_div_of_nonneg_left hnum_nonneg hΔ4_pos hden_le
  linarith

/-- Scale reduction lemma: for Δ ≥ T, T / Δ³ ≤ 1 / Δ². -/
theorem scale_reduction_cubed {T Δ : ℝ} (hT_le : T ≤ Δ) (hΔ : 0 < Δ) :
    T / Δ^3 ≤ 1 / Δ^2 := by
  have hΔ2 : 0 < Δ^2 := by positivity
  have hdiv : T / Δ^3 = (T / Δ) / Δ^2 := by
    calc
      T / Δ^3 = T / (Δ * Δ^2) := by ring_nf
      _ = (T / Δ) / Δ^2 := by ring
  rw [hdiv]
  have hle1 : T / Δ ≤ 1 := (div_le_one hΔ).mpr hT_le
  exact div_le_div_of_nonneg_right hle1 (le_of_lt hΔ2)

/-- Scale reduction lemma: for Δ ≥ T > 0, T² / Δ⁴ ≤ 1 / Δ². -/
theorem scale_reduction_quartic {T Δ : ℝ} (hT : 0 ≤ T) (hT_le : T ≤ Δ) (hΔ : 0 < Δ) :
    T^2 / Δ^4 ≤ 1 / Δ^2 := by
  have hΔ2 : 0 < Δ^2 := by positivity
  have hdiv : T^2 / Δ^4 = (T / Δ)^2 / Δ^2 := by
    calc
      T^2 / Δ^4 = (T / Δ)^2 * (1 / Δ^2) := by ring
      _ = (T / Δ)^2 / Δ^2 := by ring
  rw [hdiv]
  have hle1 : T / Δ ≤ 1 := (div_le_one hΔ).mpr hT_le
  have hsq1 : (T / Δ)^2 ≤ 1 := by
    nlinarith [div_nonneg hT (le_of_lt hΔ)]
  exact div_le_div_of_nonneg_right hsq1 (le_of_lt hΔ2)

/-- Pointwise bound for `secondOrderIBPOperator` when `Delta >= T > 0`. -/
theorem second_order_decay_bound
    {a₀ a₁ a₂ p₁ p₂ A₀ A₁ A₂ eta T Δ : ℝ}
    (ha₀ : |a₀| ≤ A₀) (ha₁ : |a₁| ≤ A₁) (ha₂ : |a₂| ≤ A₂)
    (hp₂ : |p₂| = 2 * eta * T)
    (hΔ_pos : 0 < Δ) (hp₁ : Δ ≤ |p₁|)
    (hT_le : T ≤ Δ)
    (hA₀_nonneg : 0 ≤ A₀) (hA₁_nonneg : 0 ≤ A₁) (hA₂_nonneg : 0 ≤ A₂)
    (heta_nonneg : 0 ≤ eta) (hT_nonneg : 0 ≤ T) :
    |secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂| ≤
    secondOrderIBPCoeff A₀ A₁ A₂ eta / Δ^2 := by
  have hpw := second_order_ibp_pointwise_bound ha₀ ha₁ ha₂ hp₂ hΔ_pos hp₁
    hA₀_nonneg hA₁_nonneg hA₂_nonneg heta_nonneg hT_nonneg
  have hred1 := scale_reduction_cubed hT_le hΔ_pos
  have hred2 := scale_reduction_quartic hT_nonneg hT_le hΔ_pos
  have hterm2 : 6 * eta * T * A₁ / Δ^3 ≤ 6 * eta * A₁ / Δ^2 := by
    have heq : 6 * eta * T * A₁ / Δ^3 = (6 * eta * A₁) * (T / Δ^3) := by ring
    have htarget : 6 * eta * A₁ / Δ^2 = (6 * eta * A₁) * (1 / Δ^2) := by ring
    rw [heq, htarget]
    have hpos : 0 ≤ 6 * eta * A₁ := by positivity
    exact mul_le_mul_of_nonneg_left hred1 hpos
  have hterm3 : 12 * eta^2 * T^2 * A₀ / Δ^4 ≤ 12 * eta^2 * A₀ / Δ^2 := by
    have heq : 12 * eta^2 * T^2 * A₀ / Δ^4 = (12 * eta^2 * A₀) * (T^2 / Δ^4) := by ring
    have htarget : 12 * eta^2 * A₀ / Δ^2 = (12 * eta^2 * A₀) * (1 / Δ^2) := by ring
    rw [heq, htarget]
    have hpos : 0 ≤ 12 * eta^2 * A₀ := by positivity
    exact mul_le_mul_of_nonneg_left hred2 hpos
  unfold secondOrderIBPCoeff
  have hsum : A₂ / Δ^2 + 6 * eta * A₁ / Δ^2 + 12 * eta^2 * A₀ / Δ^2 =
      (A₂ + 6 * eta * A₁ + 12 * eta^2 * A₀) / Δ^2 := by ring
  linarith

/-- Squaring the nonnegative pointwise bound gives a fourth-power denominator. -/
theorem fourth_power_energy_decay
    {a₀ a₁ a₂ p₁ p₂ A₀ A₁ A₂ eta T Δ : ℝ}
    (ha₀ : |a₀| ≤ A₀) (ha₁ : |a₁| ≤ A₁) (ha₂ : |a₂| ≤ A₂)
    (hp₂ : |p₂| = 2 * eta * T)
    (hΔ_pos : 0 < Δ) (hp₁ : Δ ≤ |p₁|)
    (hT_le : T ≤ Δ)
    (hA₀_nonneg : 0 ≤ A₀) (hA₁_nonneg : 0 ≤ A₁) (hA₂_nonneg : 0 ≤ A₂)
    (heta_nonneg : 0 ≤ eta) (hT_nonneg : 0 ≤ T) :
    (secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂)^2 ≤
    (secondOrderIBPCoeff A₀ A₁ A₂ eta)^2 / Δ^4 := by
  have hbound := second_order_decay_bound ha₀ ha₁ ha₂ hp₂ hΔ_pos hp₁ hT_le
    hA₀_nonneg hA₁_nonneg hA₂_nonneg heta_nonneg hT_nonneg
  have hsq : (secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂)^2 ≤
      (secondOrderIBPCoeff A₀ A₁ A₂ eta / Δ^2)^2 := by
    have h1 : (secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂)^2 =
        |secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂|^2 := (sq_abs _).symm
    rw [h1]
    nlinarith [hbound, abs_nonneg (secondOrderIBPOperator a₀ a₁ a₂ p₁ p₂)]
  have heq : (secondOrderIBPCoeff A₀ A₁ A₂ eta / Δ^2)^2 =
      (secondOrderIBPCoeff A₀ A₁ A₂ eta)^2 / Δ^4 := by
    ring
  rw [heq] at hsq
  exact hsq

/-- Certificate storing constants for the scalar pointwise bound. -/
structure QuadratureDecayCertificate where
  A₀ : ℝ
  A₁ : ℝ
  A₂ : ℝ
  eta : ℝ
  coeff : ℝ
  hA₀_pos : 0 < A₀
  hA₁_nonneg : 0 ≤ A₁
  hA₂_pos : 0 < A₂
  heta_pos : 0 < eta
  hcoeff_eq : coeff = secondOrderIBPCoeff A₀ A₁ A₂ eta
  hcoeff_pos : 0 < coeff

/-- Canonical constructor for QuadratureDecayCertificate. -/
def makeQuadratureDecayCertificate
    (A₀ A₁ A₂ eta : ℝ)
    (hA₀ : 0 < A₀) (hA₁ : 0 ≤ A₁) (hA₂ : 0 < A₂) (heta : 0 < eta) :
    QuadratureDecayCertificate where
  A₀ := A₀
  A₁ := A₁
  A₂ := A₂
  eta := eta
  coeff := secondOrderIBPCoeff A₀ A₁ A₂ eta
  hA₀_pos := hA₀
  hA₁_nonneg := hA₁
  hA₂_pos := hA₂
  heta_pos := heta
  hcoeff_eq := rfl
  hcoeff_pos := secondOrderIBPCoeff_pos hA₀ hA₁ hA₂ heta

#print axioms chirpedPhaseThirdDeriv_eq_zero
#print axioms hasDerivAt_chirpedPhaseSecondDeriv
#print axioms secondOrderIBPCoeff_pos
#print axioms second_order_ibp_pointwise_bound
#print axioms scale_reduction_cubed
#print axioms scale_reduction_quartic
#print axioms second_order_decay_bound
#print axioms fourth_power_energy_decay
#print axioms makeQuadratureDecayCertificate

end BuildingBlocks.ChirpedQuadratureDecay
