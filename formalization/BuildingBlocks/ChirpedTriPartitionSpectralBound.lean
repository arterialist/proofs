import BuildingBlocks.ChirpedQuadratureDecay
import BuildingBlocks.ChirpedSpectralRHBridge
import BuildingBlocks.CriticalTransformRH
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedTriPartitionSpectralBound

open BuildingBlocks.ChirpedPhaseBandLocalization
open BuildingBlocks.ChirpedQuadratureDecay

/-!
# Scalar Three-Band Partition Bounds

This module partitions a real frequency parameter into low, resonant, and high predicates.  Its
spectral upper bound is obtained by adding bounds stored in `TriPartitionCertificate`; the file
does not derive those bounds from a zeta spectrum.  The gradient lemmas cover their own explicit
subranges, and the RH result assumes a separate refutation for every candidate zero.
-/

/-- Low-frequency predicate for a real parameter. -/
def isLowFrequency (T gamma : ℝ) : Prop :=
  gamma ≤ T / 2

/-- Resonant-band predicate for a real parameter. -/
def isResonant (T gamma : ℝ) : Prop :=
  T / 2 < gamma ∧ gamma < T

/-- High-frequency predicate for a real parameter. -/
def isHighFrequency (T gamma : ℝ) : Prop :=
  T ≤ gamma

/-- The three bands form an exhaustive partition of all real ordinates. -/
theorem spectral_bands_exhaustive (T gamma : ℝ) :
    isLowFrequency T gamma ∨ isResonant T gamma ∨ isHighFrequency T gamma := by
  unfold isLowFrequency isResonant isHighFrequency
  by_cases h1 : gamma ≤ T / 2
  · exact Or.inl h1
  · by_cases h2 : gamma < T
    · exact Or.inr (Or.inl ⟨not_le.mp h1, h2⟩)
    · exact Or.inr (Or.inr (not_lt.mp h2))

/-- Mutual disjointness: low and resonant are disjoint. -/
theorem low_resonant_disjoint {T gamma : ℝ}
    (hlow : isLowFrequency T gamma) (hres : isResonant T gamma) : False := by
  unfold isLowFrequency at hlow
  unfold isResonant at hres
  linarith

/-- Mutual disjointness: resonant and high are disjoint. -/
theorem resonant_high_disjoint {T gamma : ℝ}
    (hres : isResonant T gamma) (hhigh : isHighFrequency T gamma) : False := by
  unfold isResonant at hres
  unfold isHighFrequency at hhigh
  linarith

/-- Mutual disjointness: low and high are disjoint for T > 0. -/
theorem low_high_disjoint {T gamma : ℝ} (hT : 0 < T)
    (hlow : isLowFrequency T gamma) (hhigh : isHighFrequency T gamma) : False := by
  unfold isLowFrequency at hlow
  unfold isHighFrequency at hhigh
  linarith

/-- The parameter `gamma = (3/4)*T` lies strictly inside the resonant band for `T > 0`. -/
theorem tuned_zero_is_resonant {T : ℝ} (hT : 0 < T) :
    isResonant T ((3 / 4) * T) := by
  unfold isResonant
  constructor
  · linarith
  · linarith

/-- Uniform gradient separation for `gamma <= 0` on `[0,1]` with `eta = 1/4`. -/
theorem negative_ordinate_gradient_separation
    {T gamma x : ℝ} (_hT : 0 < T) (hgamma : gamma ≤ 0)
    (_hx0 : 0 ≤ x) (hx1 : x ≤ 1) :
    T / 2 ≤ chirpedPhaseDeriv T (1 / 4) gamma x := by
  unfold chirpedPhaseDeriv
  have hlin : T - gamma - 2 * (1 / 4) * T * x = T - gamma - (T / 2) * x := by ring
  rw [hlin]
  have hx_le : (T / 2) * x ≤ T / 2 := by
    have hT2_pos : 0 ≤ T / 2 := by linarith
    calc
      (T / 2) * x ≤ (T / 2) * 1 := mul_le_mul_of_nonneg_left hx1 hT2_pos
      _ = T / 2 := mul_one _
  linarith

/-- Uniform gradient separation for `gamma >= 2*T` on `[0,1]` with `eta = 1/4`. -/
theorem high_frequency_gradient_separation
    {T gamma x : ℝ} (hT : 0 ≤ T) (hgamma : 2 * T ≤ gamma)
    (hx0 : 0 ≤ x) (_hx1 : x ≤ 1) :
    T ≤ |chirpedPhaseDeriv T (1 / 4) gamma x| := by
  unfold chirpedPhaseDeriv
  have hlin : T - gamma - 2 * (1 / 4) * T * x = T - gamma - (T / 2) * x := by ring
  rw [hlin]
  have hx_nonneg : 0 ≤ (T / 2) * x := by positivity
  have hneg : T - gamma - (T / 2) * x ≤ -T := by
    linarith
  have hle : T ≤ - (T - gamma - (T / 2) * x) := by linarith
  have habs : - (T - gamma - (T / 2) * x) ≤ |T - gamma - (T / 2) * x| := neg_le_abs _
  exact le_trans hle habs

/-- Positive constants used in the later scalar bounds. -/
structure TriPartitionCertificate where
  C_crit : ℝ
  C_nonres : ℝ
  b : ℝ
  d : ℝ
  hC_crit_pos : 0 < C_crit
  hC_nonres_pos : 0 < C_nonres
  hb_pos : 0 < b
  hd_pos : 0 < d

/-- Sum of the three constituent bounds stored in the certificate. -/
theorem tri_partition_spectral_upper_bound
    (cert : TriPartitionCertificate)
    (Q_spec Q_crit Q_nonres E_pair : ℝ → ℝ)
    (h_decomp : ∀ T, Q_spec T ≤ Q_crit T + Q_nonres T - E_pair T)
    (h_crit : ∀ T, Q_crit T ≤ cert.C_crit * Real.log T)
    (h_nonres : ∀ T, Q_nonres T ≤ cert.C_nonres)
    (h_pair : ∀ T, 2 * cert.b * T^(2 * cert.d) ≤ E_pair T)
    (T : ℝ) :
    Q_spec T ≤ cert.C_crit * Real.log T + cert.C_nonres - 2 * cert.b * T^(2 * cert.d) := by
  have hd := h_decomp T
  have hc := h_crit T
  have hn := h_nonres T
  have hp := h_pair T
  linarith

/-- Contradiction among the supplied bounds when the power term dominates. -/
theorem tri_partition_coercive_refutation
    (cert : TriPartitionCertificate)
    (Q_arith Q_spec Q_crit Q_nonres E_pair : ℝ → ℝ)
    (c₀ C_tot : ℝ)
    (_hc₀ : 0 < c₀)
    (h_arith : ∀ᶠ T in atTop, c₀ * Real.log T - C_tot ≤ Q_arith T)
    (h_ident : ∀ T, Q_arith T = Q_spec T)
    (h_decomp : ∀ T, Q_spec T ≤ Q_crit T + Q_nonres T - E_pair T)
    (h_crit : ∀ T, Q_crit T ≤ cert.C_crit * Real.log T)
    (h_nonres : ∀ T, Q_nonres T ≤ cert.C_nonres)
    (h_pair : ∀ T, 2 * cert.b * T^(2 * cert.d) ≤ E_pair T)
    (h_power_dom : ∀ᶠ T in atTop,
      (cert.C_crit - c₀) * Real.log T + cert.C_nonres + C_tot < 2 * cert.b * T^(2 * cert.d)) :
    False := by
  -- Intersect eventual filters
  have heventual := h_arith.and h_power_dom
  obtain ⟨T, ⟨harith_T, hdom_T⟩⟩ := heventual.exists
  have hspec_T := tri_partition_spectral_upper_bound cert Q_spec Q_crit Q_nonres E_pair
    h_decomp h_crit h_nonres h_pair T
  have heq := h_ident T
  linarith

/-- Conversion of an assumed candidate-zero refutation into `RightHalfZeroFree`. -/
theorem rightHalfZeroFree_of_tri_partition_refutation
    (hrefute : ∀ (s : ℂ), 1 / 2 < s.re → s ≠ 1 → riemannZeta s = 0 → False) :
    BuildingBlocks.RightHalfZeroFree := by
  intro s hsr hs hz
  exact (hrefute s hsr hs hz).elim

/-- Conditional conversion of the assumed refutation into `RiemannHypothesis`. -/
theorem RiemannHypothesis_of_tri_partition_refutation
    (hrefute : ∀ (s : ℂ), 1 / 2 < s.re → s ≠ 1 → riemannZeta s = 0 → False) :
    RiemannHypothesis :=
  CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
    (rightHalfZeroFree_of_tri_partition_refutation hrefute)

/-- Canonical constructor for TriPartitionCertificate. -/
def makeTriPartitionCertificate
    (C_crit C_nonres b d : ℝ)
    (hC_crit : 0 < C_crit) (hC_nonres : 0 < C_nonres)
    (hb : 0 < b) (hd : 0 < d) :
    TriPartitionCertificate where
  C_crit := C_crit
  C_nonres := C_nonres
  b := b
  d := d
  hC_crit_pos := hC_crit
  hC_nonres_pos := hC_nonres
  hb_pos := hb
  hd_pos := hd

#print axioms spectral_bands_exhaustive
#print axioms low_resonant_disjoint
#print axioms resonant_high_disjoint
#print axioms low_high_disjoint
#print axioms tuned_zero_is_resonant
#print axioms negative_ordinate_gradient_separation
#print axioms high_frequency_gradient_separation
#print axioms tri_partition_spectral_upper_bound
#print axioms tri_partition_coercive_refutation
#print axioms rightHalfZeroFree_of_tri_partition_refutation
#print axioms RiemannHypothesis_of_tri_partition_refutation
#print axioms makeTriPartitionCertificate

end BuildingBlocks.ChirpedTriPartitionSpectralBound
