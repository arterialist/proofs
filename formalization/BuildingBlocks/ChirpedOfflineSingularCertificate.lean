import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.ChirpedSpectralArithmeticExclusion
import BuildingBlocks.ChirpedSpectralRHBridge
import BuildingBlocks.ChirpedQuantitativeExclusionThreshold
import BuildingBlocks.ChirpedTriPartitionSpectralBound

/-!
# Conditional Scalar Exclusion Certificate

This module proves power dominance for `singularEnergyDeficit` and shows that
`OfflineSingularCertificate s` is inconsistent.  The certificate itself contains the candidate
zero and the decisive nonpositivity inequality.  The file does not derive that certificate from
an actual wavepacket, spectral operator, or Weil formula.  Its RH theorem assumes certificates
for every candidate zero.
-/

namespace BuildingBlocks.ChirpedOfflineSingularCertificate

open Filter
open scoped Topology
open BuildingBlocks.CriticalTransformRH
open BuildingBlocks.ChirpedQuantitativeExclusionThreshold
open BuildingBlocks.ChirpedTriPartitionSpectralBound

noncomputable section

/-- The singular energy deficit function:
`singularEnergyDeficit d b A C T = 2 * b * T^(2 * d) - (A * Real.log T + C)`.
This is a scalar power-minus-log expression; no spectral interpretation is proved here. -/
def singularEnergyDeficit (d b A C T : ℝ) : ℝ :=
  2 * b * T^(2 * d) - (A * Real.log T + C)

/-- The singular energy deficit is strictly positive for all carrier frequencies
at or above the quantitative threshold `T_thresh(d, b, A, C)`. -/
theorem singular_energy_deficit_pos
    {d b A C T : ℝ} (hd : 0 < d) (hb : 0 < b)
    (hT : quantitativeThreshold d b A C ≤ T) :
    0 < singularEnergyDeficit d b A C T := by
  unfold singularEnergyDeficit
  have hdom := quantitative_power_dominance hd hb hT
  linarith

/-- The singular energy deficit strictly exceeds any target bound `M_val` for all large T. -/
theorem eventual_singular_energy_deficit_gt
    {d b A C M_val : ℝ} (hd : 0 < d) (hb : 0 < b) :
    ∀ᶠ (T : ℝ) in atTop, M_val < singularEnergyDeficit d b A C T := by
  unfold singularEnergyDeficit
  have h2d : 0 < 2 * d := by linarith
  have hdom := ChirpedSpectralArithmeticExclusion.power_dominance_over_log h2d hb (A := A) (C := C + M_val)
  filter_upwards [hdom, eventually_gt_atTop (1 : ℝ)] with T hT hT1
  have hpos : 0 < b * T^(2 * d) := mul_pos hb (Real.rpow_pos_of_pos (by linarith) (2 * d))
  linarith

/-- The singular energy deficit diverges to +∞ as T → +∞. -/
theorem tendsto_singular_energy_deficit_atTop
    {d b A C : ℝ} (hd : 0 < d) (hb : 0 < b) :
    Tendsto (fun T : ℝ => singularEnergyDeficit d b A C T) atTop atTop := by
  rw [tendsto_atTop]
  intro M_val
  have hgt := eventual_singular_energy_deficit_gt (A := A) (C := C) (M_val := M_val) hd hb
  filter_upwards [hgt] with T hT
  exact le_of_lt hT

/-- Inconsistent certificate containing a candidate-zero premise and the decisive bound. -/
structure OfflineSingularCertificate (s : ℂ) where
  hz : riemannZeta s = 0
  hs : s ≠ 1
  hre : 1 / 2 < s.re
  b : ℝ
  hb : 0 < b
  c₀ : ℝ
  C_tot : ℝ
  C_crit : ℝ
  C_nonres : ℝ
  T : ℝ
  hT_thresh : quantitativeThreshold (s.re - 1/2) b (C_crit - c₀) (C_nonres + C_tot) ≤ T
  Q_arith : ℝ
  Q_spec : ℝ
  h_weil_eq : Q_arith = Q_spec
  h_arith_lb : c₀ * Real.log T - C_tot ≤ Q_arith
  h_spec_ub : Q_spec ≤ C_crit * Real.log T + C_nonres - 2 * b * T^(2 * (s.re - 1/2))

/-- The existence of an OfflineSingularCertificate for a candidate zero `s`
forces the singular energy deficit to be non-positive at scale T. -/
theorem singular_energy_deficit_nonpos_of_cert {s : ℂ}
    (cert : OfflineSingularCertificate s) :
    singularEnergyDeficit (s.re - 1/2) cert.b (cert.C_crit - cert.c₀) (cert.C_nonres + cert.C_tot) cert.T ≤ 0 := by
  unfold singularEnergyDeficit
  have h_arith := cert.h_arith_lb
  have h_spec := cert.h_spec_ub
  have h_eq := cert.h_weil_eq
  linarith

/-- Pointwise Refutation Theorem: any OfflineSingularCertificate yields a direct contradiction. -/
theorem refute_singular_zero {s : ℂ} (cert : OfflineSingularCertificate s) : False := by
  have hd : 0 < s.re - 1/2 := by linarith [cert.hre]
  have hpos := singular_energy_deficit_pos hd cert.hb cert.hT_thresh
  have hnonpos := singular_energy_deficit_nonpos_of_cert cert
  linarith

/-- Right-Half Zero-Freeness from pointwise singular certificates:
if every putative zero with `s.re > 1/2` admits an OfflineSingularCertificate,
then no zeros can exist in the right half of the critical strip. -/
theorem rightHalfZeroFree_of_certificates
    (h_certs : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → 1 / 2 < s.re → OfflineSingularCertificate s) :
    RightHalfZeroFree := by
  intro s hsr hs hz
  have cert := h_certs s hz hs hsr
  exact (refute_singular_zero cert).elim

/-- Conditional RH deduction assuming every candidate zero admits a certificate. -/
theorem RiemannHypothesis_of_certificates
    (h_certs : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → 1 / 2 < s.re → OfflineSingularCertificate s) :
    RiemannHypothesis :=
  CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
    (rightHalfZeroFree_of_certificates h_certs)

/-- Certificate builder from candidate-zero facts and all required scalar bounds. -/
def makeOfflineSingularCertificate
    (s : ℂ) (hz : riemannZeta s = 0) (hs : s ≠ 1) (hre : 1 / 2 < s.re)
    (b : ℝ) (hb : 0 < b)
    (c₀ C_tot C_crit C_nonres T : ℝ)
    (hT_thresh : quantitativeThreshold (s.re - 1/2) b (C_crit - c₀) (C_nonres + C_tot) ≤ T)
    (Q_arith Q_spec : ℝ)
    (h_weil_eq : Q_arith = Q_spec)
    (h_arith_lb : c₀ * Real.log T - C_tot ≤ Q_arith)
    (h_spec_ub : Q_spec ≤ C_crit * Real.log T + C_nonres - 2 * b * T^(2 * (s.re - 1/2))) :
    OfflineSingularCertificate s where
  hz := hz
  hs := hs
  hre := hre
  b := b
  hb := hb
  c₀ := c₀
  C_tot := C_tot
  C_crit := C_crit
  C_nonres := C_nonres
  T := T
  hT_thresh := hT_thresh
  Q_arith := Q_arith
  Q_spec := Q_spec
  h_weil_eq := h_weil_eq
  h_arith_lb := h_arith_lb
  h_spec_ub := h_spec_ub

/-- Stability under displacement enlargement: for any candidate zero with displacement
`d ≥ d₀ > 0`, the deficit at displacement `d` is bounded below by the deficit at `d₀`
for all `T ≥ 1`. -/
theorem singular_energy_deficit_monotone_displacement
    {d d₀ b A C T : ℝ} (_hd₀ : 0 < d₀) (hle : d₀ ≤ d) (hb : 0 ≤ b)
    (hT1 : 1 ≤ T) :
    singularEnergyDeficit d₀ b A C T ≤ singularEnergyDeficit d b A C T := by
  unfold singularEnergyDeficit
  have h2d₀ : 2 * d₀ ≤ 2 * d := by linarith
  have hT0 : 0 ≤ T := le_trans (by norm_num) hT1
  have hpow := Real.rpow_le_rpow_of_exponent_le hT1 h2d₀
  nlinarith

/-- Universal Pointwise Energy Exclusion Theorem:
Given any displacement `d > 0` and coupling `b > 0`, the interval of acceptable
scalar Weil energies is empty for all carrier scales `T ≥ quantitativeThreshold d b A C`:
there is no real number `Q` simultaneously satisfying
`c₀ * log T - C_tot ≤ Q` and `Q ≤ C_crit * log T + C_nonres - 2b T^(2d)`. -/
theorem empty_weil_energy_interval
    {d b c₀ C_tot C_crit C_nonres T : ℝ}
    (hd : 0 < d) (hb : 0 < b)
    (hT : quantitativeThreshold d b (C_crit - c₀) (C_nonres + C_tot) ≤ T)
    (Q : ℝ)
    (h_lb : c₀ * Real.log T - C_tot ≤ Q)
    (h_ub : Q ≤ C_crit * Real.log T + C_nonres - 2 * b * T^(2 * d)) :
    False := by
  have hle : c₀ * Real.log T - C_tot ≤ C_crit * Real.log T + C_nonres - 2 * b * T^(2 * d) :=
    le_trans h_lb h_ub
  have hdom := quantitative_power_dominance hd hb hT
  linarith

end

end BuildingBlocks.ChirpedOfflineSingularCertificate

#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.singular_energy_deficit_pos
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.tendsto_singular_energy_deficit_atTop
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.singular_energy_deficit_nonpos_of_cert
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.refute_singular_zero
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.rightHalfZeroFree_of_certificates
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.RiemannHypothesis_of_certificates
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.makeOfflineSingularCertificate
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.singular_energy_deficit_monotone_displacement
#print axioms BuildingBlocks.ChirpedOfflineSingularCertificate.empty_weil_energy_interval
