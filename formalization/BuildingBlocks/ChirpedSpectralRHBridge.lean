import BuildingBlocks.ChirpedSpectralArithmeticExclusion
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.Scope

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedSpectralRHBridge

/-- The arithmetic lower bound for chirped packets at carrier T. -/
def ChirpedArithmeticLowerBound (Q_arith : ℝ → ℝ) (a : ℝ) : Prop :=
  ∀ᶠ T in atTop, a * Real.log T ≤ Q_arith T

/-- The spectral upper bound in the presence of an off-line zero displacement d > 0. -/
def ChirpedSpectralUpperBound (Q_spec : ℝ → ℝ) (C_crit M b d : ℝ) : Prop :=
  ∀ᶠ T in atTop, Q_spec T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d)

/-- The Weil explicit identity equates the arithmetic and spectral quadratic forms. -/
def WeilSpectralArithmeticIdentity (Q_arith Q_spec : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, Q_arith T = Q_spec T

/-- A hypothetical off-line zero configuration with displacement d = β - 1/2 > 0. -/
def ChirpedOfflineZeroConfiguration (d : ℝ) : Prop :=
  ∃ (Q_arith Q_spec : ℝ → ℝ) (a C_crit M b : ℝ),
    0 < a ∧ 0 < b ∧
    WeilSpectralArithmeticIdentity Q_arith Q_spec ∧
    ChirpedArithmeticLowerBound Q_arith a ∧
    ChirpedSpectralUpperBound Q_spec C_crit M b d

/-- Two eventually true propositions on ℝ with opposite truth values at infinity produce a contradiction. -/
theorem eventually_contradiction {p : ℝ → Prop}
    (h1 : ∀ᶠ x : ℝ in atTop, p x) (h2 : ∀ᶠ x : ℝ in atTop, ¬ p x) :
    False := by
  obtain ⟨a1, ha1⟩ := Filter.eventually_atTop.mp h1
  obtain ⟨a2, ha2⟩ := Filter.eventually_atTop.mp h2
  let b := max a1 a2
  have hp : p b := ha1 b (le_max_left a1 a2)
  have hnp : ¬ p b := ha2 b (le_max_right a1 a2)
  exact hnp hp

/-- Every off-line zero displacement d > 0 produces an impossible spectral-arithmetic configuration. -/
theorem chirped_offline_zero_inadmissible {d : ℝ} (hd : 0 < d) :
    ¬ ChirpedOfflineZeroConfiguration d := by
  rintro ⟨Q_arith, Q_spec, a, C_crit, M, b, _ha, hb, hid, hlow, hup⟩
  have hexcl := ChirpedSpectralArithmeticExclusion.chirped_spectral_arithmetic_exclusion
    (C_crit := C_crit) (a := a) (M := M) hb hd
  have hbound : ∀ᶠ T in atTop,
      a * Real.log T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d) := by
    filter_upwards [hlow, hup] with T hTlow hTup
    rw [hid T] at hTlow
    exact hTlow.trans hTup
  exact eventually_contradiction hbound hexcl

/-- If every right-half zero candidate generates an admissible chirped configuration,
then the right half-plane contains no zeros of the Riemann zeta function. -/
theorem rightHalfZeroFree_of_chirped_configuration
    (h_carrier : ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s = 0 →
      ChirpedOfflineZeroConfiguration (s.re - 1/2)) :
    RightHalfZeroFree := by
  intro s hsr hs hz
  have hd : 0 < s.re - 1/2 := by linarith
  have hcfg := h_carrier s hsr hs hz
  have hinad := chirped_offline_zero_inadmissible hd
  exact hinad hcfg

/-- Full mathlib Riemann Hypothesis deduced from the chirped spectral-arithmetic
exclusion theorem under the hypothesis that off-line zeros couple to chirped packets. -/
theorem RiemannHypothesis_of_chirped_configuration
    (h_carrier : ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s = 0 →
      ChirpedOfflineZeroConfiguration (s.re - 1/2)) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_chirped_configuration h_carrier

#print axioms eventually_contradiction
#print axioms chirped_offline_zero_inadmissible
#print axioms rightHalfZeroFree_of_chirped_configuration
#print axioms RiemannHypothesis_of_chirped_configuration

end BuildingBlocks.ChirpedSpectralRHBridge
