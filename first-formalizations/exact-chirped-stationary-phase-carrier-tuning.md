# First Formalization 350: Exact Chirped Stationary Phase Carrier Tuning and Band Localization

## 1. Classification
- **Formalization Number**: 350
- **Unique Contribution Reference**: [Unique Contribution 341](../unique-contributions/exact-chirped-stationary-phase-carrier-tuning.md)
- **Lean 4 Source**: [`formalization/BuildingBlocks/ChirpedStationaryPhaseCarrier.lean`](../formalization/BuildingBlocks/ChirpedStationaryPhaseCarrier.lean)
- **Axioms**: Core Lean 4 only (`[propext, Classical.choice, Quot.sound]`)
- **Status**: 100% Machine-Checked in Lean 4 (Zero `sorry`, Zero custom axioms)

---

## 2. Formal Definitions and Theorems

```lean
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
    HasDerivAt (chirpedPhase η T s) (chirpedPhaseDeriv η T s x) x

/-- The tuned carrier is strictly positive when γ₀ > 0 and 2ηx₀ < 1. -/
theorem tunedCarrier_pos {γ₀ η x₀ : ℝ} (hγ : 0 < γ₀) (hηx : 2 * η * x₀ < 1) :
    0 < tunedCarrier γ₀ η x₀

/-- At the tuned carrier, the stationary phase condition vanishes identically at x₀. -/
theorem tunedCarrier_stationary {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1) :
    chirpedPhaseDeriv η (tunedCarrier γ₀ η x₀) γ₀ x₀ = 0

/-- The unique stationary phase point of the chirped packet at frequency s is (T - s) / (2ηT). -/
theorem stationary_point_eq {η T s : ℝ} (hη : η ≠ 0) (hT : T ≠ 0) (x : ℝ) :
    chirpedPhaseDeriv η T s x = 0 ↔ x = (T - s) / (2 * η * T)

/-- At the tuned carrier T = tunedCarrier γ₀ η x₀, the unique stationary point is x₀. -/
theorem tuned_stationary_point_eq {γ₀ η x₀ : ℝ} (hη : η ≠ 0) (hγ : 0 < γ₀)
    (hηx : 2 * η * x₀ < 1) :
    (tunedCarrier γ₀ η x₀ - γ₀) / (2 * η * tunedCarrier γ₀ η x₀) = x₀

/-- The target frequency γ₀ lies strictly inside the packet frequency band [T(1 - 2ηw), T]. -/
theorem tunedCarrier_in_band {γ₀ η x₀ w : ℝ} (hη : 0 < η) (hx0 : 0 < x₀)
    (hxw : x₀ < w) (hw : 2 * η * w < 1) (hγ : 0 < γ₀) :
    let T := tunedCarrier γ₀ η x₀
    T * (1 - 2 * η * w) < γ₀ ∧ γ₀ < T

/-- The curvature (second derivative) of the chirped phase is strictly positive. -/
theorem chirpedPhase_curvature_pos {η T : ℝ} (hη : 0 < η) (hT : 0 < T) :
    0 < 2 * η * T

/-- As the target ordinate γ₀ diverges to infinity, the tuned carrier diverges to infinity. -/
theorem tendsto_tunedCarrier_atTop {η x₀ : ℝ} (hηx : 2 * η * x₀ < 1) :
    Tendsto (fun γ₀ => tunedCarrier γ₀ η x₀) atTop atTop
```

---

## 3. Verification Commands

```bash
~/.elan/bin/lake build BuildingBlocks.ChirpedStationaryPhaseCarrier
```
Axioms checked via `#print axioms`: strictly standard `[propext, Classical.choice, Quot.sound]`. Zero `sorry`.
