import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Polynomial
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedNonstationaryGradientSeparation

/-- The chirped phase function Φ(x) = x(T - γ) - x²(ηT) for carrier frequency T,
chirp rate η, zero ordinate γ, and spatial position x. -/
def chirpedPhase (T eta gamma x : ℝ) : ℝ :=
  x * (T - gamma) - x^2 * (eta * T)

/-- The exact derivative of the chirped phase: Φ'(x) = (T - γ) - 2ηTx. -/
def chirpedPhaseDeriv (T eta gamma x : ℝ) : ℝ :=
  (T - gamma) - 2 * eta * T * x

/-- Φ'(x) is the rigorous derivative of Φ(x) with respect to x. -/
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

/-- Algebraic re-expression: Φ'(x) = T(1 - 2ηx) - γ. -/
theorem chirpedPhaseDeriv_eq (T eta gamma x : ℝ) :
    chirpedPhaseDeriv T eta gamma x = T * (1 - 2 * eta * x) - gamma := by
  unfold chirpedPhaseDeriv
  ring

/-- Upper bound on the derivative across [0, w]: achieved at the left endpoint x = 0. -/
theorem chirpedPhaseDeriv_le_top (T eta gamma x : ℝ)
    (hT : 0 < T) (heta : 0 < eta) (hx : 0 ≤ x) :
    chirpedPhaseDeriv T eta gamma x ≤ T - gamma := by
  unfold chirpedPhaseDeriv
  have h : 0 ≤ 2 * eta * T * x := by
    positivity
  linarith

/-- Lower bound on the derivative across [0, w]: achieved at the right endpoint x = w. -/
theorem chirpedPhaseDeriv_ge_bot (T eta gamma x w : ℝ)
    (hT : 0 < T) (heta : 0 < eta) (hx : x ≤ w) :
    T * (1 - 2 * eta * w) - gamma ≤ chirpedPhaseDeriv T eta gamma x := by
  rw [chirpedPhaseDeriv_eq]
  have h1 : 2 * eta * x ≤ 2 * eta * w := by
    nlinarith
  have h2 : 1 - 2 * eta * w ≤ 1 - 2 * eta * x := by
    linarith
  have h3 : T * (1 - 2 * eta * w) ≤ T * (1 - 2 * eta * x) := by
    nlinarith
  linarith

/-- For ordinates γ strictly above the carrier T (γ > T), the phase derivative is
strictly negative everywhere on x ≥ 0 with magnitude at least γ - T. -/
theorem deriv_neg_of_gt_carrier (T eta gamma x : ℝ)
    (hT : 0 < T) (heta : 0 < eta) (hx : 0 ≤ x) (hgamma : T < gamma) :
    chirpedPhaseDeriv T eta gamma x ≤ T - gamma ∧
    gamma - T ≤ |chirpedPhaseDeriv T eta gamma x| := by
  have hle := chirpedPhaseDeriv_le_top T eta gamma x hT heta hx
  have hneg : chirpedPhaseDeriv T eta gamma x < 0 := by
    linarith
  have habs : |chirpedPhaseDeriv T eta gamma x| = -chirpedPhaseDeriv T eta gamma x :=
    abs_of_neg hneg
  constructor
  · exact hle
  · rw [habs]
    linarith

/-- For ordinates γ strictly below the resonant band (γ < T(1 - 2ηw)), the phase
derivative is strictly positive everywhere on x ≤ w with magnitude at least
T(1 - 2ηw) - γ. -/
theorem deriv_pos_of_lt_band (T eta gamma x w : ℝ)
    (hT : 0 < T) (heta : 0 < eta) (hx : x ≤ w)
    (hgamma : gamma < T * (1 - 2 * eta * w)) :
    0 < T * (1 - 2 * eta * w) - gamma ∧
    T * (1 - 2 * eta * w) - gamma ≤ |chirpedPhaseDeriv T eta gamma x| := by
  have hge := chirpedPhaseDeriv_ge_bot T eta gamma x w hT heta hx
  have hpos : 0 < T * (1 - 2 * eta * w) - gamma := by
    linarith
  have hderiv_pos : 0 < chirpedPhaseDeriv T eta gamma x := by
    linarith
  have habs : |chirpedPhaseDeriv T eta gamma x| = chirpedPhaseDeriv T eta gamma x :=
    abs_of_pos hderiv_pos
  constructor
  · exact hpos
  · rw [habs]
    exact hge

/-- Uniform non-stationary gradient separation theorem:
If γ is separated from the resonant band [T(1 - 2ηw), T] by distance at least Δ > 0,
then for all x ∈ [0, w], the derivative magnitude |Φ'(x)| is bounded below by Δ. -/
theorem nonstationary_gradient_separation {T eta gamma w Δ : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hΔ : 0 < Δ)
    (h_sep : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma)
    {x : ℝ} (hx0 : 0 ≤ x) (hxw : x ≤ w) :
    Δ ≤ |chirpedPhaseDeriv T eta gamma x| := by
  cases h_sep with
  | inl h_below =>
    have hband : gamma < T * (1 - 2 * eta * w) := by linarith
    have ⟨_, h_le⟩ := deriv_pos_of_lt_band T eta gamma x w hT heta hxw hband
    linarith
  | inr h_above =>
    have hcarrier : T < gamma := by linarith
    have ⟨_, h_le⟩ := deriv_neg_of_gt_carrier T eta gamma x hT heta hx0 hcarrier
    linarith

/-- Reciprocal square gradient bound:
For any point separated by Δ from the resonant band, the squared derivative
(Φ'(x))² is bounded below by Δ² > 0. -/
theorem reciprocal_square_gradient_le {T eta gamma w Δ : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hΔ : 0 < Δ)
    (h_sep : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma)
    {x : ℝ} (hx0 : 0 ≤ x) (hxw : x ≤ w) :
    Δ^2 ≤ (chirpedPhaseDeriv T eta gamma x)^2 ∧
    0 < (chirpedPhaseDeriv T eta gamma x)^2 := by
  have hsep := nonstationary_gradient_separation hT heta hΔ h_sep hx0 hxw
  have hΔ_nonneg : 0 ≤ Δ := le_of_lt hΔ
  have habs_nonneg : 0 ≤ |chirpedPhaseDeriv T eta gamma x| := abs_nonneg _
  have hsq : Δ * Δ ≤ |chirpedPhaseDeriv T eta gamma x| * |chirpedPhaseDeriv T eta gamma x| :=
    mul_le_mul hsep hsep hΔ_nonneg habs_nonneg
  have habs_sq : |chirpedPhaseDeriv T eta gamma x| * |chirpedPhaseDeriv T eta gamma x| =
      (chirpedPhaseDeriv T eta gamma x)^2 := by
    rw [← sq, sq_abs]
  rw [habs_sq, ← sq] at hsq
  have hpos : 0 < (chirpedPhaseDeriv T eta gamma x)^2 := by
    have hΔ2 : 0 < Δ^2 := by positivity
    exact lt_of_lt_of_le hΔ2 hsq
  exact ⟨hsq, hpos⟩

/-- Constructive certificate bundling non-stationary phase separation parameters. -/
structure NonstationaryGradientCertificate (T eta w gamma Δ : ℝ) : Prop where
  T_pos : 0 < T
  eta_pos : 0 < eta
  w_pos : 0 < w
  Delta_pos : 0 < Δ
  separated : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma
  uniform_lower_bound : ∀ x, 0 ≤ x → x ≤ w → Δ ≤ |chirpedPhaseDeriv T eta gamma x|

/-- Constructor for `NonstationaryGradientCertificate`. -/
theorem makeNonstationaryCertificate {T eta w gamma Δ : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hw : 0 < w) (hΔ : 0 < Δ)
    (h_sep : gamma ≤ T * (1 - 2 * eta * w) - Δ ∨ T + Δ ≤ gamma) :
    NonstationaryGradientCertificate T eta w gamma Δ :=
  ⟨hT, heta, hw, hΔ, h_sep,
   fun _ hx0 hxw => nonstationary_gradient_separation hT heta hΔ h_sep hx0 hxw⟩

end BuildingBlocks.ChirpedNonstationaryGradientSeparation

#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.hasDerivAt_chirpedPhase
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.chirpedPhaseDeriv_eq
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.chirpedPhaseDeriv_le_top
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.chirpedPhaseDeriv_ge_bot
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.deriv_neg_of_gt_carrier
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.deriv_pos_of_lt_band
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.nonstationary_gradient_separation
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.reciprocal_square_gradient_le
#print axioms BuildingBlocks.ChirpedNonstationaryGradientSeparation.makeNonstationaryCertificate
