import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedStationaryPhaseCarrier

/-- The total phase of the chirped Fourier transform at frequency s and carrier T. -/
def chirpedPhase (η T s : ℝ) (x : ℝ) : ℝ :=
  x * (s - T) + x^2 * (η * T)

/-- The derivative of the total chirped phase with respect to x. -/
def chirpedPhaseDeriv (η T s x : ℝ) : ℝ :=
  s - T + 2 * η * T * x

/-- The tuned carrier frequency that centers the stationary phase point at x₀ for target ordinate γ₀. -/
noncomputable def tunedCarrier (γ₀ η x₀ : ℝ) : ℝ :=
  γ₀ / (1 - 2 * η * x₀)

/-- Exact derivative of the chirped phase function. -/
theorem hasDerivAt_chirpedPhase (η T s x : ℝ) :
    HasDerivAt (chirpedPhase η T s) (chirpedPhaseDeriv η T s x) x := by
  have hi : HasDerivAt (fun y : ℝ => y) 1 x := hasDerivAt_id x
  have h1 : HasDerivAt (fun y : ℝ => y * (s - T)) (s - T) x := by
    simpa using hi.mul_const (s - T)
  have h2 : HasDerivAt (fun y : ℝ => y ^ 2) (2 * x) x := by
    simpa using hasDerivAt_pow 2 x
  have h3 : HasDerivAt (fun y : ℝ => y ^ 2 * (η * T)) (2 * x * (η * T)) x :=
    h2.mul_const (η * T)
  have h4 : HasDerivAt (fun y : ℝ => y * (s - T) + y ^ 2 * (η * T)) (s - T + 2 * x * (η * T)) x :=
    h1.add h3
  have heq1 : chirpedPhase η T s = (fun y : ℝ => y * (s - T) + y ^ 2 * (η * T)) := rfl
  have heq2 : chirpedPhaseDeriv η T s x = s - T + 2 * x * (η * T) := by
    dsimp [chirpedPhaseDeriv]
    ring
  rw [heq1, heq2]
  exact h4

/-- The tuned carrier is strictly positive when γ₀ > 0 and 2ηx₀ < 1. -/
theorem tunedCarrier_pos {γ₀ η x₀ : ℝ} (hγ : 0 < γ₀) (hηx : 2 * η * x₀ < 1) :
    0 < tunedCarrier γ₀ η x₀ := by
  unfold tunedCarrier
  have hden : 0 < 1 - 2 * η * x₀ := by linarith
  exact div_pos hγ hden

/-- At the tuned carrier, the stationary phase condition vanishes identically at x₀. -/
theorem tunedCarrier_stationary {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1) :
    chirpedPhaseDeriv η (tunedCarrier γ₀ η x₀) γ₀ x₀ = 0 := by
  unfold chirpedPhaseDeriv tunedCarrier
  have hden : 1 - 2 * η * x₀ ≠ 0 := by
    intro hc
    apply hηx
    linarith
  have hcancel : (γ₀ / (1 - 2 * η * x₀)) * (1 - 2 * η * x₀) = γ₀ :=
    div_mul_cancel₀ γ₀ hden
  calc
    γ₀ - (γ₀ / (1 - 2 * η * x₀)) + 2 * η * (γ₀ / (1 - 2 * η * x₀)) * x₀
      = γ₀ - (γ₀ / (1 - 2 * η * x₀)) * (1 - 2 * η * x₀) := by ring
    _ = γ₀ - γ₀ := by rw [hcancel]
    _ = 0 := by ring

/-- The unique stationary phase point of the chirped packet at frequency s is (T - s) / (2ηT). -/
theorem stationary_point_eq {η T s : ℝ} (hη : η ≠ 0) (hT : T ≠ 0) (x : ℝ) :
    chirpedPhaseDeriv η T s x = 0 ↔ x = (T - s) / (2 * η * T) := by
  unfold chirpedPhaseDeriv
  constructor
  · intro h
    have h1 : 2 * η * T * x = T - s := by linarith
    have h2 : 2 * η * T ≠ 0 := by
      intro hc
      apply mul_ne_zero (mul_ne_zero two_ne_zero hη) hT hc
    exact (eq_div_iff h2).mpr (by linarith [h1])
  · intro h
    rw [h]
    have h2 : 2 * η * T ≠ 0 := mul_ne_zero (mul_ne_zero two_ne_zero hη) hT
    calc
      s - T + 2 * η * T * ((T - s) / (2 * η * T))
        = s - T + (T - s) := by rw [mul_div_cancel₀ _ h2]
      _ = 0 := by ring

/-- At the tuned carrier T = tunedCarrier γ₀ η x₀, the unique stationary point is x₀. -/
theorem tuned_stationary_point_eq {γ₀ η x₀ : ℝ} (hη : η ≠ 0) (hγ : 0 < γ₀)
    (hηx : 2 * η * x₀ < 1) :
    (tunedCarrier γ₀ η x₀ - γ₀) / (2 * η * tunedCarrier γ₀ η x₀) = x₀ := by
  have hTpos := tunedCarrier_pos hγ hηx
  have hTne : tunedCarrier γ₀ η x₀ ≠ 0 := ne_of_gt hTpos
  have hstat : chirpedPhaseDeriv η (tunedCarrier γ₀ η x₀) γ₀ x₀ = 0 :=
    tunedCarrier_stationary (ne_of_lt hηx)
  exact ((stationary_point_eq hη hTne x₀).mp hstat).symm

/-- The target frequency γ₀ lies strictly inside the packet frequency band [T(1 - 2ηw), T]. -/
theorem tunedCarrier_in_band {γ₀ η x₀ w : ℝ} (hη : 0 < η) (hx0 : 0 < x₀)
    (hxw : x₀ < w) (hw : 2 * η * w < 1) (hγ : 0 < γ₀) :
    let T := tunedCarrier γ₀ η x₀
    T * (1 - 2 * η * w) < γ₀ ∧ γ₀ < T := by
  intro T
  have hx0_lt_1 : 2 * η * x₀ < 1 := by
    have h1 : 2 * η * x₀ < 2 * η * w := by
      nlinarith
    linarith
  have hTpos : 0 < T := tunedCarrier_pos hγ hx0_lt_1
  have hden : 1 - 2 * η * x₀ ≠ 0 := by linarith
  have hT_eq : T * (1 - 2 * η * x₀) = γ₀ := by
    dsimp [T, tunedCarrier]
    exact div_mul_cancel₀ γ₀ hden
  constructor
  · calc
      T * (1 - 2 * η * w) < T * (1 - 2 * η * x₀) := by
        apply mul_lt_mul_of_pos_left _ hTpos
        nlinarith
      _ = γ₀ := hT_eq
  · calc
      γ₀ = T * (1 - 2 * η * x₀) := hT_eq.symm
      _ < T * 1 := by
        apply mul_lt_mul_of_pos_left _ hTpos
        linarith [mul_pos (mul_pos (by norm_num : (0 : ℝ) < 2) hη) hx0]
      _ = T := mul_one T

/-- The curvature (second derivative) of the chirped phase is strictly positive. -/
theorem chirpedPhase_curvature_pos {η T : ℝ} (hη : 0 < η) (hT : 0 < T) :
    0 < 2 * η * T := by
  nlinarith

/-- As the target ordinate γ₀ diverges to infinity, the tuned carrier diverges to infinity. -/
theorem tendsto_tunedCarrier_atTop {η x₀ : ℝ} (hηx : 2 * η * x₀ < 1) :
    Tendsto (fun γ₀ => tunedCarrier γ₀ η x₀) atTop atTop := by
  have hden_pos : 0 < 1 - 2 * η * x₀ := by linarith
  rw [tendsto_atTop_atTop]
  intro b
  refine ⟨b * (1 - 2 * η * x₀), fun γ₀ hγ => ?_⟩
  unfold tunedCarrier
  exact (le_div_iff₀ hden_pos).mpr hγ

#print axioms hasDerivAt_chirpedPhase
#print axioms tunedCarrier_pos
#print axioms tunedCarrier_stationary
#print axioms stationary_point_eq
#print axioms tuned_stationary_point_eq
#print axioms tunedCarrier_in_band
#print axioms chirpedPhase_curvature_pos
#print axioms tendsto_tunedCarrier_atTop

end BuildingBlocks.ChirpedStationaryPhaseCarrier
