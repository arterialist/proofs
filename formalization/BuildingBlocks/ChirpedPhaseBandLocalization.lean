import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedPhaseBandLocalization

/-!
# Quadratic Chirp Phase Algebra

This module differentiates a quadratic phase, locates its stationary point, and proves elementary
gradient-separation and pointwise rational bounds under stated assumptions.  The results concern
real scalar expressions; they do not define a wavepacket integral or establish an integrated
spectral estimate.
-/

/-- The chirped phase function Φ(x) = x(T - γ) - x²(ηT). -/
def chirpedPhase (T eta gamma x : ℝ) : ℝ :=
  x * (T - gamma) - x^2 * (eta * T)

/-- The derivative of the chirped phase: Φ'(x) = (T - γ) - 2ηTx. -/
def chirpedPhaseDeriv (T eta gamma x : ℝ) : ℝ :=
  (T - gamma) - 2 * eta * T * x

/-- The second derivative of the chirped phase: Φ''(x) = -2ηT. -/
def chirpedPhaseSecondDeriv (T eta : ℝ) : ℝ :=
  -2 * eta * T

/-- Rigorous derivative of the chirped phase function. -/
theorem hasDerivAt_chirpedPhase (T eta gamma x : ℝ) :
    HasDerivAt (chirpedPhase T eta gamma) (chirpedPhaseDeriv T eta gamma x) x := by
  have hi : HasDerivAt (fun y : ℝ => y) 1 x := hasDerivAt_id x
  have h1 : HasDerivAt (fun y : ℝ => y * (T - gamma)) (T - gamma) x := by
    simpa using hi.mul_const (T - gamma)
  have h2 : HasDerivAt (fun y : ℝ => y ^ 2) (2 * x) x := by
    simpa using hasDerivAt_pow 2 x
  have h3 : HasDerivAt (fun y : ℝ => y ^ 2 * (eta * T)) (2 * x * (eta * T)) x :=
    h2.mul_const (eta * T)
  have h4 := h1.sub h3
  have heq : T - gamma - 2 * x * (eta * T) = chirpedPhaseDeriv T eta gamma x := by
    unfold chirpedPhaseDeriv
    ring
  rw [heq] at h4
  exact h4

/-- Rigorous second derivative of the chirped phase function. -/
theorem hasDerivAt_chirpedPhaseDeriv (T eta gamma x : ℝ) :
    HasDerivAt (chirpedPhaseDeriv T eta gamma) (chirpedPhaseSecondDeriv T eta) x := by
  have hconst : HasDerivAt (fun _ : ℝ => T - gamma) 0 x := hasDerivAt_const x (T - gamma)
  have hid : HasDerivAt (fun y : ℝ => y) 1 x := hasDerivAt_id x
  have hlin : HasDerivAt (fun y : ℝ => (2 * eta * T) * y) (2 * eta * T * 1) x :=
    hid.const_mul (2 * eta * T)
  have hsub := hconst.sub hlin
  have hrew : chirpedPhaseDeriv T eta gamma = fun y : ℝ => (T - gamma) - (2 * eta * T) * y := by
    ext y
    unfold chirpedPhaseDeriv
    ring
  have hrew2 : chirpedPhaseSecondDeriv T eta = 0 - 2 * eta * T * 1 := by
    unfold chirpedPhaseSecondDeriv
    ring
  rw [hrew, hrew2]
  exact hsub

/-- Algebraic re-expression: Φ'(x) = T(1 - 2ηx) - γ. -/
theorem chirpedPhaseDeriv_eq (T eta gamma x : ℝ) :
    chirpedPhaseDeriv T eta gamma x = T * (1 - 2 * eta * x) - gamma := by
  unfold chirpedPhaseDeriv
  ring

/-- The unique stationary phase point x_* where Φ'(x_*) = 0. -/
noncomputable def stationaryPoint (T eta gamma : ℝ) : ℝ :=
  (T - gamma) / (2 * eta * T)

/-- At x_*, the phase derivative vanishes identically. -/
theorem stationaryPoint_deriv_zero (T eta gamma : ℝ) (hT : T ≠ 0) (heta : eta ≠ 0) :
    chirpedPhaseDeriv T eta gamma (stationaryPoint T eta gamma) = 0 := by
  unfold chirpedPhaseDeriv stationaryPoint
  have h2 : (2 : ℝ) ≠ 0 := by norm_num
  have hden : 2 * eta * T ≠ 0 := mul_ne_zero (mul_ne_zero h2 heta) hT
  have hcancel : 2 * eta * T * ((T - gamma) / (2 * eta * T)) = T - gamma :=
    mul_div_cancel₀ (T - gamma) hden
  linarith

/-- Equivalence between stationary point being strictly positive and γ < T. -/
theorem stationaryPoint_pos_iff {T eta gamma : ℝ} (hT : 0 < T) (heta : 0 < eta) :
    0 < stationaryPoint T eta gamma ↔ gamma < T := by
  unfold stationaryPoint
  have hden : 0 < 2 * eta * T := by positivity
  rw [div_pos_iff_of_pos_right hden]
  constructor
  · intro h
    linarith
  · intro h
    linarith

/-- Equivalence between stationary point being bounded by w and T(1 - 2ηw) < γ. -/
theorem stationaryPoint_lt_iff {T eta gamma w : ℝ} (hT : 0 < T) (heta : 0 < eta) :
    stationaryPoint T eta gamma < w ↔ T * (1 - 2 * eta * w) < gamma := by
  unfold stationaryPoint
  have hden : 0 < 2 * eta * T := by positivity
  rw [div_lt_iff₀ hden]
  constructor
  · intro h
    nlinarith
  · intro h
    nlinarith

/-- Equivalence between stationary point lying in the open interval (0, w) and
ordinate γ belonging to the open resonant band (T(1 - 2ηw), T). -/
theorem stationaryPoint_in_band_iff {T eta gamma w : ℝ}
    (hT : 0 < T) (heta : 0 < eta) :
    (0 < stationaryPoint T eta gamma ∧ stationaryPoint T eta gamma < w) ↔
    (T * (1 - 2 * eta * w) < gamma ∧ gamma < T) := by
  rw [stationaryPoint_pos_iff hT heta, stationaryPoint_lt_iff hT heta]
  tauto

/-- For canonical parameters η = 1/4 and w = 1, the lower band edge is T/2. -/
theorem canonical_resonant_band_eq (T : ℝ) :
    T * (1 - 2 * (1 / 4) * 1) = T / 2 := by
  ring

/-- For canonical parameters η = 1/4 and w = 1, the resonant band is (T/2, T). -/
theorem canonical_resonant_band_iff {T gamma : ℝ} (hT : 0 < T) :
    (0 < stationaryPoint T (1 / 4) gamma ∧ stationaryPoint T (1 / 4) gamma < 1) ↔
    (T / 2 < gamma ∧ gamma < T) := by
  have heta : (0 : ℝ) < 1 / 4 := by norm_num
  have h := stationaryPoint_in_band_iff (gamma := gamma) (w := 1) hT heta
  have heq : T * (1 - 2 * (1 / 4) * 1) = T / 2 := canonical_resonant_band_eq T
  rw [heq] at h
  exact h

/-- Uniform negative gradient separation for high frequencies above the carrier:
if γ ≥ T + Δ, then Φ'(x) ≤ -Δ for all x ≥ 0. -/
theorem phase_deriv_le_of_high_frequency {T eta gamma Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : 0 ≤ x)
    (hgamma : T + Delta ≤ gamma) :
    chirpedPhaseDeriv T eta gamma x ≤ -Delta := by
  unfold chirpedPhaseDeriv
  have hlin : 0 ≤ 2 * eta * T * x := by positivity
  linarith

/-- Uniform absolute gradient separation for high frequencies:
if γ ≥ T + Δ with Δ > 0, then |Φ'(x)| ≥ Δ for all x ≥ 0. -/
theorem phase_deriv_abs_ge_of_high_frequency {T eta gamma Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : 0 ≤ x) (_hDelta : 0 < Delta)
    (hgamma : T + Delta ≤ gamma) :
    Delta ≤ |chirpedPhaseDeriv T eta gamma x| := by
  have hle := phase_deriv_le_of_high_frequency hT heta hx hgamma
  have h1 : Delta ≤ - (chirpedPhaseDeriv T eta gamma x) := by linarith
  have h2 : - (chirpedPhaseDeriv T eta gamma x) ≤ |chirpedPhaseDeriv T eta gamma x| := neg_le_abs _
  linarith

/-- Uniform positive gradient separation for low frequencies below the resonant band:
if γ ≤ T(1 - 2ηw) - Δ, then Φ'(x) ≥ Δ for all x ≤ w. -/
theorem phase_deriv_ge_of_low_frequency {T eta gamma w Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : x ≤ w)
    (hgamma : gamma ≤ T * (1 - 2 * eta * w) - Delta) :
    Delta ≤ chirpedPhaseDeriv T eta gamma x := by
  rw [chirpedPhaseDeriv_eq]
  have h1 : 2 * eta * x ≤ 2 * eta * w := by nlinarith
  have h2 : 1 - 2 * eta * w ≤ 1 - 2 * eta * x := by linarith
  have h3 : T * (1 - 2 * eta * w) ≤ T * (1 - 2 * eta * x) := by nlinarith
  linarith

/-- Uniform absolute gradient separation for low frequencies:
if γ ≤ T(1 - 2ηw) - Δ with Δ > 0, then |Φ'(x)| ≥ Δ for all x ≤ w. -/
theorem phase_deriv_abs_ge_of_low_frequency {T eta gamma w Delta x : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hx : x ≤ w) (_hDelta : 0 < Delta)
    (hgamma : gamma ≤ T * (1 - 2 * eta * w) - Delta) :
    Delta ≤ |chirpedPhaseDeriv T eta gamma x| := by
  have hge := phase_deriv_ge_of_low_frequency hT heta hx hgamma
  have h2 : chirpedPhaseDeriv T eta gamma x ≤ |chirpedPhaseDeriv T eta gamma x| := le_abs_self _
  linarith

/-- Scalar expression motivated by a first-order integration-by-parts bound. -/
noncomputable def ibpKernelBound (A A' eta T Delta : ℝ) : ℝ :=
  A' / Delta + (2 * eta * T * A) / (Delta ^ 2)

/-- Strict positivity of the IBP kernel bound when amplitudes are non-negative and positive. -/
theorem ibpKernelBound_pos {A A' eta T Delta : ℝ}
    (hA : 0 < A) (hA' : 0 ≤ A') (heta : 0 < eta) (hT : 0 < T) (hDelta : 0 < Delta) :
    0 < ibpKernelBound A A' eta T Delta := by
  unfold ibpKernelBound
  have h1 : 0 ≤ A' / Delta := div_nonneg hA' (le_of_lt hDelta)
  have hnum : 0 < 2 * eta * T * A := by positivity
  have hden : 0 < Delta ^ 2 := by positivity
  have h2 : 0 < (2 * eta * T * A) / (Delta ^ 2) := div_pos hnum hden
  linarith

/-- Pointwise bound for the defined rational expression:
|(a'(x) / Φ'(x)) - (a(x) Φ''(x) / (Φ'(x))²)| ≤ A'/Δ + (2ηTA)/Δ². -/
theorem ibp_integrand_pointwise_bound
    {a a' deriv deriv_sec A A' eta T Delta : ℝ}
    (hderiv_sec : deriv_sec = -2 * eta * T)
    (ha : |a| ≤ A) (ha' : |a'| ≤ A')
    (heta : 0 ≤ eta) (hT : 0 ≤ T)
    (hDelta : 0 < Delta) (hgrad : Delta ≤ |deriv|) :
    |a' / deriv - a * deriv_sec / (deriv ^ 2)| ≤ ibpKernelBound A A' eta T Delta := by
  unfold ibpKernelBound
  have htri : |a' / deriv - a * deriv_sec / (deriv ^ 2)| ≤
      |a' / deriv| + |a * deriv_sec / (deriv ^ 2)| := by
    have hsub : a' / deriv - a * deriv_sec / (deriv ^ 2) =
        a' / deriv + (- (a * deriv_sec / (deriv ^ 2))) := by ring
    rw [hsub]
    have h1 := abs_add_le (a' / deriv) (- (a * deriv_sec / (deriv ^ 2)))
    rw [abs_neg] at h1
    exact h1
  have hterm1 : |a' / deriv| ≤ A' / Delta := by
    rw [abs_div]
    have hpos : 0 < |deriv| := lt_of_lt_of_le hDelta hgrad
    have hdiv1 : |a'| / |deriv| ≤ A' / |deriv| :=
      div_le_div_of_nonneg_right ha' (le_of_lt hpos)
    have hA'_nonneg : 0 ≤ A' := le_trans (abs_nonneg a') ha'
    have hdiv2 : A' / |deriv| ≤ A' / Delta :=
      div_le_div_of_nonneg_left hA'_nonneg hDelta hgrad
    exact le_trans hdiv1 hdiv2
  have hterm2 : |a * deriv_sec / (deriv ^ 2)| ≤ (2 * eta * T * A) / (Delta ^ 2) := by
    rw [abs_div, abs_mul]
    have hsq : |deriv ^ 2| = |deriv| ^ 2 := by
      rw [sq, sq, abs_mul]
    rw [hsq, hderiv_sec]
    have hpos_etaT : 0 ≤ 2 * eta * T := by positivity
    have hneg : -2 * eta * T = - (2 * eta * T) := by ring
    rw [hneg, abs_neg, abs_of_nonneg hpos_etaT]
    have hA_nonneg : 0 ≤ A := le_trans (abs_nonneg a) ha
    have hmul_le : |a| * (2 * eta * T) ≤ A * (2 * eta * T) :=
      mul_le_mul_of_nonneg_right ha hpos_etaT
    have hderiv_pos : 0 < |deriv| := lt_of_lt_of_le hDelta hgrad
    have hsq_pos : 0 < |deriv| ^ 2 := sq_pos_of_pos hderiv_pos
    have hdiv3 : (|a| * (2 * eta * T)) / (|deriv| ^ 2) ≤ (A * (2 * eta * T)) / (|deriv| ^ 2) :=
      div_le_div_of_nonneg_right hmul_le (le_of_lt hsq_pos)
    have hsq_le : Delta ^ 2 ≤ |deriv| ^ 2 := by
      have hDelta_nonneg : 0 ≤ Delta := le_of_lt hDelta
      have hderiv_nonneg : 0 ≤ |deriv| := abs_nonneg deriv
      nlinarith
    have hDelta_sq_pos : 0 < Delta ^ 2 := sq_pos_of_pos hDelta
    have hnum_nonneg : 0 ≤ A * (2 * eta * T) := mul_nonneg hA_nonneg hpos_etaT
    have hdiv4 : (A * (2 * eta * T)) / (|deriv| ^ 2) ≤ (A * (2 * eta * T)) / (Delta ^ 2) :=
      div_le_div_of_nonneg_left hnum_nonneg hDelta_sq_pos hsq_le
    have hle_trans : (|a| * (2 * eta * T)) / (|deriv| ^ 2) ≤ (A * (2 * eta * T)) / (Delta ^ 2) :=
      le_trans hdiv3 hdiv4
    have heq_num : A * (2 * eta * T) = 2 * eta * T * A := by ring
    rw [heq_num] at hle_trans
    exact hle_trans
  linarith

/-- Certificate packaging phase parameters and proved scalar bounds. -/
structure PhaseBandCertificate where
  T : ℝ
  eta : ℝ
  w : ℝ
  hT : 0 < T
  heta : 0 < eta
  hw : 0 < w
  lowerBand : ℝ
  upperBand : ℝ
  hlower : lowerBand = T * (1 - 2 * eta * w)
  hupper : upperBand = T
  band_pos : lowerBand < upperBand

/-- Constructor for the canonical phase band certificate (η = 1/4, w = 1). -/
noncomputable def makeCanonicalPhaseBandCertificate (T : ℝ) (hT : 0 < T) : PhaseBandCertificate where
  T := T
  eta := 1 / 4
  w := 1
  hT := hT
  heta := by norm_num
  hw := by norm_num
  lowerBand := T / 2
  upperBand := T
  hlower := by ring
  hupper := rfl
  band_pos := by linarith

#print axioms hasDerivAt_chirpedPhase
#print axioms hasDerivAt_chirpedPhaseDeriv
#print axioms stationaryPoint_deriv_zero
#print axioms stationaryPoint_in_band_iff
#print axioms canonical_resonant_band_iff
#print axioms phase_deriv_abs_ge_of_high_frequency
#print axioms phase_deriv_abs_ge_of_low_frequency
#print axioms ibp_integrand_pointwise_bound
#print axioms makeCanonicalPhaseBandCertificate

end BuildingBlocks.ChirpedPhaseBandLocalization
