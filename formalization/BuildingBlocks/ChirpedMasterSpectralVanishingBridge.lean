import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.Scope
import BuildingBlocks.ChirpedDyadicTailEnergy
import BuildingBlocks.ChirpedQuantitativeExclusionThreshold

/-!
# Contradiction from Supplied Tail and Coercivity Bounds

`totalNonresonantTailEnvelope` is the scalar function `C/T^2`.  A `VanishingBridgeSystem` stores
two arbitrary real functions together with an arithmetic lower bound, a spectral upper bound,
and their equality.  Power dominance makes that package inconsistent.  This module does not
construct the functions or prove the stored bounds from a wavepacket or the Weil explicit formula.
The RH theorem is conditional on a witness producing such a system for every candidate zero.
-/

namespace BuildingBlocks.ChirpedMasterSpectralVanishingBridge

open Filter
open scoped Topology
open BuildingBlocks.ChirpedDyadicTailEnergy
open BuildingBlocks.ChirpedQuantitativeExclusionThreshold

noncomputable section

/-- Total non-resonant tail envelope combining low-frequency and dyadic high-frequency tails:
`totalNonresonantTailEnvelope C_tail_tot T = C_tail_tot * (Real.log T / T^3)`. -/
def totalNonresonantTailEnvelope (C_tail_tot : ℝ) (T : ℝ) : ℝ :=
  C_tail_tot * (Real.log T / T^3)

/-- Asymptotic vanishing of the total non-resonant tail envelope as `T → +∞`. -/
theorem tendsto_totalNonresonantTailEnvelope_atTop (C_tail_tot : ℝ) :
    Tendsto (fun T : ℝ => totalNonresonantTailEnvelope C_tail_tot T) atTop (nhds 0) := by
  unfold totalNonresonantTailEnvelope
  have h := tendsto_log_div_pow_three_atTop.const_mul C_tail_tot
  rwa [mul_zero] at h

/-- Explicit carrier threshold guaranteeing non-resonant tail energy `< ε`:
`tailEpsilonThreshold C_tail_tot ε = Real.sqrt (C_tail_tot / ε) + 1`. -/
def tailEpsilonThreshold (C_tail_tot ε : ℝ) : ℝ :=
  Real.sqrt (C_tail_tot / ε) + 1

/-- For all carrier scales `T ≥ tailEpsilonThreshold C_tail_tot ε`, the non-resonant tail
energy is strictly smaller than `ε`. -/
theorem tail_envelope_lt_epsilon
    (C_tail_tot : ℝ) (hC : 0 ≤ C_tail_tot) {ε : ℝ} (hε : 0 < ε)
    {T : ℝ} (hT : tailEpsilonThreshold C_tail_tot ε ≤ T) :
    totalNonresonantTailEnvelope C_tail_tot T < ε := by
  unfold totalNonresonantTailEnvelope tailEpsilonThreshold at *
  have hdiv_nonneg : 0 ≤ C_tail_tot / ε := div_nonneg hC (le_of_lt hε)
  have hsqrt_nonneg : 0 ≤ Real.sqrt (C_tail_tot / ε) := Real.sqrt_nonneg _
  have hT_ge_one : 1 ≤ T := by linarith
  have hT_gt_sqrt : Real.sqrt (C_tail_tot / ε) < T := by linarith
  have hT_pos : 0 < T := by linarith
  have hT2_gt : C_tail_tot / ε < T^2 := by
    have hsq := (Real.sqrt_lt' hT_pos).mp hT_gt_sqrt
    exact hsq
  have hdiv_T2 : C_tail_tot / T^2 < ε := by
    have hT2_pos : 0 < T^2 := by positivity
    rw [div_lt_iff₀ hT2_pos]
    rw [div_lt_iff₀ hε] at hT2_gt
    linarith
  have hlog_le := log_div_pow_three_le T hT_ge_one
  have hmul_le : C_tail_tot * (Real.log T / T^3) ≤ C_tail_tot * (1 / T^2) := by
    nlinarith
  have heq : C_tail_tot * (1 / T^2) = C_tail_tot / T^2 := by ring
  rw [heq] at hmul_le
  exact lt_of_le_of_lt hmul_le hdiv_T2

/-- Comprehensive system bundling arithmetic coercivity and vanishing-tail spectral upper bound. -/
structure VanishingBridgeSystem where
  C_crit : ℝ
  C_tail_tot : ℝ
  c0 : ℝ
  C_tot : ℝ
  b : ℝ
  d : ℝ
  hb : 0 < b
  hd : 0 < d
  hC_crit : 0 ≤ C_crit
  hC_tail : 0 ≤ C_tail_tot
  hc0 : 0 < c0
  hC_tot : 0 ≤ C_tot
  Q_spec : ℝ → ℝ
  Q_arith : ℝ → ℝ
  h_spec_bound : ∀ T : ℝ, 1 ≤ T →
    Q_spec T ≤ C_crit * Real.log T + totalNonresonantTailEnvelope C_tail_tot T - 2 * b * T^(2 * d)
  h_arith_bound : ∀ T : ℝ, 1 ≤ T →
    c0 * Real.log T - C_tot ≤ Q_arith T
  h_weil_eq : ∀ T : ℝ, Q_arith T = Q_spec T

/-- Carrier scale chosen to satisfy both scalar thresholds. -/
def masterRefutationCarrier (sys : VanishingBridgeSystem) : ℝ :=
  let A := sys.C_crit - sys.c0
  let C := sys.C_tot + 1
  max (tailEpsilonThreshold sys.C_tail_tot 1) (quantitativeThreshold sys.d sys.b A C)

/-- The lower bound, upper bound, and equality stored in a `VanishingBridgeSystem` are inconsistent. -/
theorem vanishing_bridge_refutation (sys : VanishingBridgeSystem) : False := by
  let A := sys.C_crit - sys.c0
  let C := sys.C_tot + 1
  let T_star := masterRefutationCarrier sys
  have hT_ge_thresh : quantitativeThreshold sys.d sys.b A C ≤ T_star := by
    dsimp [T_star, masterRefutationCarrier]
    exact le_max_right _ _
  have hT_ge_tail : tailEpsilonThreshold sys.C_tail_tot 1 ≤ T_star := by
    dsimp [T_star, masterRefutationCarrier]
    exact le_max_left _ _
  have hT_ge_one : 1 ≤ T_star := by
    have h1 : 1 ≤ tailEpsilonThreshold sys.C_tail_tot 1 := by
      unfold tailEpsilonThreshold
      have hsq : 0 ≤ Real.sqrt (sys.C_tail_tot / 1) := Real.sqrt_nonneg _
      linarith
    exact le_trans h1 hT_ge_tail
  have hdom := quantitative_power_dominance sys.hd sys.hb hT_ge_thresh
  have htail := tail_envelope_lt_epsilon sys.C_tail_tot sys.hC_tail zero_lt_one hT_ge_tail
  have hspec := sys.h_spec_bound T_star hT_ge_one
  have harith := sys.h_arith_bound T_star hT_ge_one
  have hweil := sys.h_weil_eq T_star
  rw [hweil] at harith
  have hcomb : sys.c0 * Real.log T_star - sys.C_tot ≤
      sys.C_crit * Real.log T_star + totalNonresonantTailEnvelope sys.C_tail_tot T_star - 2 * sys.b * T_star^(2 * sys.d) :=
    le_trans harith hspec
  have hcomb2 : sys.c0 * Real.log T_star - sys.C_tot <
      sys.C_crit * Real.log T_star + 1 - 2 * sys.b * T_star^(2 * sys.d) := by
    linarith
  have hshift : 2 * sys.b * T_star^(2 * sys.d) <
      (sys.C_crit - sys.c0) * Real.log T_star + (sys.C_tot + 1) := by
    linarith
  have hlt_AC : 2 * sys.b * T_star^(2 * sys.d) < A * Real.log T_star + C := by
    dsimp [A, C]
    exact hshift
  linarith

/-- Candidate-zero exclusion conditional on a witness supplying a `VanishingBridgeSystem`. -/
theorem rightHalfZeroFree_of_vanishing_bridge
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → 1 / 2 < s.re → VanishingBridgeSystem) :
    RightHalfZeroFree := by
  intro s hsr hs hz
  have sys := witness s hz hs hsr
  exact (vanishing_bridge_refutation sys).elim

/-- Conditional deduction of `RiemannHypothesis` from the stated witness function. -/
theorem RiemannHypothesis_of_vanishing_bridge
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → 1 / 2 < s.re → VanishingBridgeSystem) :
    RiemannHypothesis :=
  CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
    (rightHalfZeroFree_of_vanishing_bridge witness)

/-- Constructor requiring all scalar functions and decisive bounds as arguments. -/
def makeVanishingBridgeSystem
    (C_crit C_tail_tot c0 C_tot b d : ℝ)
    (hb : 0 < b) (hd : 0 < d) (hC_crit : 0 ≤ C_crit) (hC_tail : 0 ≤ C_tail_tot)
    (hc0 : 0 < c0) (hC_tot : 0 ≤ C_tot)
    (Q_spec Q_arith : ℝ → ℝ)
    (h_spec_bound : ∀ T : ℝ, 1 ≤ T →
      Q_spec T ≤ C_crit * Real.log T + totalNonresonantTailEnvelope C_tail_tot T - 2 * b * T^(2 * d))
    (h_arith_bound : ∀ T : ℝ, 1 ≤ T →
      c0 * Real.log T - C_tot ≤ Q_arith T)
    (h_weil_eq : ∀ T : ℝ, Q_arith T = Q_spec T) :
    VanishingBridgeSystem where
  C_crit := C_crit
  C_tail_tot := C_tail_tot
  c0 := c0
  C_tot := C_tot
  b := b
  d := d
  hb := hb
  hd := hd
  hC_crit := hC_crit
  hC_tail := hC_tail
  hc0 := hc0
  hC_tot := hC_tot
  Q_spec := Q_spec
  Q_arith := Q_arith
  h_spec_bound := h_spec_bound
  h_arith_bound := h_arith_bound
  h_weil_eq := h_weil_eq

end

end BuildingBlocks.ChirpedMasterSpectralVanishingBridge
