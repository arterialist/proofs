import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.CriticalChirpedGramFinite
import BuildingBlocks.ChirpedSpectralArithmeticExclusion
import BuildingBlocks.ChirpedSpectralRHBridge
import BuildingBlocks.ChirpedConstellationSpanAmplification
import BuildingBlocks.ChirpedGrandSynthesis
import BuildingBlocks.ChirpedGramDefiniteness
import BuildingBlocks.ChirpedCoerciveSpectralExclusion

/-!
# Quantitative Power-Dominance Threshold

This module gives an explicit threshold after which `2*b*T^(2*d)` dominates a logarithmic-linear
expression, assuming `d > 0` and `b > 0`.  Its exclusion results apply to scalar inequalities
supplied as hypotheses.  No analytic spectral estimate or zeta-zero-to-system construction is
proved here.
-/

namespace BuildingBlocks.ChirpedQuantitativeExclusionThreshold

open Filter
open scoped Topology BigOperators
open BuildingBlocks.CriticalChirpedGramFinite
open BuildingBlocks.ChirpedSpectralArithmeticExclusion
open BuildingBlocks.ChirpedSpectralRHBridge
open BuildingBlocks.ChirpedConstellationSpanAmplification
open BuildingBlocks.ChirpedGrandSynthesis
open BuildingBlocks.ChirpedGramDefiniteness
open BuildingBlocks.ChirpedCoerciveSpectralExclusion

noncomputable section

/-- Quantitative base parameter for power dominance:
`Y_base = (|A| / d + |C| + 1) / (2 * b)`. -/
def quantitativeBase (d b A C : ℝ) : ℝ :=
  (|A| / d + |C| + 1) / (2 * b)

/-- The quantitative base parameter is strictly positive whenever `0 < d` and `0 < b`. -/
theorem quantitativeBase_pos {d b A C : ℝ} (hd : 0 < d) (hb : 0 < b) :
    0 < quantitativeBase d b A C := by
  unfold quantitativeBase
  have htop : 0 < |A| / d + |C| + 1 := by
    have hd_pos : 0 ≤ |A| / d := div_nonneg (abs_nonneg A) (le_of_lt hd)
    have hC_pos : 0 ≤ |C| := abs_nonneg C
    linarith
  have hbot : 0 < 2 * b := by linarith
  exact div_pos htop hbot

/-- Amplified target level `Y_target = max 1 (quantitativeBase d b A C + 1)`. -/
def quantitativeTarget (d b A C : ℝ) : ℝ :=
  max 1 (quantitativeBase d b A C + 1)

/-- The target level strictly exceeds 1 and quantitativeBase. -/
theorem one_le_quantitativeTarget (d b A C : ℝ) :
    1 ≤ quantitativeTarget d b A C :=
  le_max_left 1 _

theorem quantitativeBase_lt_target (d b A C : ℝ) :
    quantitativeBase d b A C < quantitativeTarget d b A C := by
  unfold quantitativeTarget
  have hlt : quantitativeBase d b A C < quantitativeBase d b A C + 1 := by linarith
  exact lt_of_lt_of_le hlt (le_max_right 1 _)

/-- Explicit closed-form quantitative threshold carrier:
`quantitativeThreshold d b A C = (quantitativeTarget d b A C)^(1 / d)`. -/
def quantitativeThreshold (d b A C : ℝ) : ℝ :=
  (quantitativeTarget d b A C) ^ (1 / d)

/-- The quantitative threshold is at least 1 for any d > 0. -/
theorem one_le_quantitativeThreshold {d b A C : ℝ} (hd : 0 < d) :
    1 ≤ quantitativeThreshold d b A C := by
  unfold quantitativeThreshold
  have h1 : (1 : ℝ) ≤ quantitativeTarget d b A C := one_le_quantitativeTarget d b A C
  have hinv : 0 ≤ 1 / d := by positivity
  have := Real.rpow_le_rpow (by norm_num) h1 hinv
  rwa [Real.one_rpow] at this

/-- The threshold is strictly positive for d > 0. -/
theorem quantitativeThreshold_pos {d b A C : ℝ} (hd : 0 < d) :
    0 < quantitativeThreshold d b A C :=
  lt_of_lt_of_le zero_lt_one (one_le_quantitativeThreshold hd)

/-- Universal half-power logarithmic bound specialized to exponent `d > 0`:
`log T ≤ (1 / d) * T^d` for all `T > 0`. -/
theorem log_le_rpow_div {d T : ℝ} (hd : 0 < d) (hT : 0 < T) :
    Real.log T ≤ (1 / d) * T^d := by
  have h2d : 0 < 2 * d := by linarith
  have h := log_le_rpow_half h2d hT
  have hdiv : (2 : ℝ) / (2 * d) = 1 / d := by
    have hne : (2 : ℝ) ≠ 0 := by norm_num
    calc
      2 / (2 * d) = 2 / 2 / d := by ring
      _ = 1 / d := by norm_num
  have hhalf : (2 * d) / 2 = d := by ring
  rw [hdiv, hhalf] at h
  exact h

/-- Quadratic decomposition of `T^(2d) = T^d * T^d`. -/
theorem rpow_two_d_eq_mul {d T : ℝ} (hT : 0 < T) :
    T^(2 * d) = T^d * T^d := by
  rw [← Real.rpow_add hT]
  congr 1
  ring

/-- Quantitative Pointwise Power Dominance Theorem:
For any displacement `d > 0`, coupling `b > 0`, and background constants `A, C ∈ ℝ`,
the power term `2 * b * T^(2d)` strictly exceeds `A * log T + C` for ALL `T ≥ quantitativeThreshold d b A C`. -/
theorem quantitative_power_dominance
    {d b A C T : ℝ} (hd : 0 < d) (hb : 0 < b)
    (hT : quantitativeThreshold d b A C ≤ T) :
    A * Real.log T + C < 2 * b * T^(2 * d) := by
  have hT1 : 1 ≤ T := le_trans (one_le_quantitativeThreshold hd) hT
  have hT0 : 0 < T := lt_of_lt_of_le zero_lt_one hT1
  set Y := T^d
  have hY1 : 1 ≤ Y := by
    have hle := Real.rpow_le_rpow (by norm_num) hT1 (le_of_lt hd)
    rwa [Real.one_rpow] at hle
  have htarget_le_Y : quantitativeTarget d b A C ≤ Y := by
    have hthresh_nonneg : 0 ≤ quantitativeThreshold d b A C :=
      le_of_lt (quantitativeThreshold_pos hd)
    have htarget_nonneg : 0 ≤ quantitativeTarget d b A C :=
      le_trans (by norm_num) (one_le_quantitativeTarget d b A C)
    have hinv_inv : (1 / d) * d = 1 := one_div_mul_cancel (ne_of_gt hd)
    have hpow := Real.rpow_le_rpow hthresh_nonneg hT (le_of_lt hd)
    unfold quantitativeThreshold at hpow
    rw [← Real.rpow_mul htarget_nonneg, hinv_inv, Real.rpow_one] at hpow
    exact hpow
  have hbase_lt_Y : quantitativeBase d b A C < Y :=
    lt_of_lt_of_le (quantitativeBase_lt_target d b A C) htarget_le_Y
  have hlog_bd := log_le_rpow_div hd hT0
  have hA_log : A * Real.log T ≤ (|A| / d) * Y := by
    calc
      A * Real.log T ≤ |A| * Real.log T := by
        have hAle := le_abs_self A
        nlinarith [Real.log_nonneg hT1]
      _ ≤ |A| * ((1 / d) * Y) := by
        nlinarith [abs_nonneg A]
      _ = (|A| / d) * Y := by ring
  have hcomb : A * Real.log T + C ≤ (|A| / d + |C|) * Y := by
    calc
      A * Real.log T + C ≤ (|A| / d) * Y + |C| := by linarith [le_abs_self C]
      _ ≤ (|A| / d) * Y + |C| * Y := by
        nlinarith [abs_nonneg C]
      _ = (|A| / d + |C|) * Y := by ring
  have hY_strict : (|A| / d + |C|) < 2 * b * Y := by
    unfold quantitativeBase at hbase_lt_Y
    have hmul : (|A| / d + |C| + 1) < 2 * b * Y := by
      have h2b : 0 < 2 * b := by linarith
      have hlt := (div_lt_iff₀ h2b).mp hbase_lt_Y
      rwa [mul_comm] at hlt
    linarith
  have hstrict : (|A| / d + |C|) * Y < 2 * b * Y^2 := by
    have hY_pos : 0 < Y := lt_of_lt_of_le zero_lt_one hY1
    calc
      (|A| / d + |C|) * Y < (2 * b * Y) * Y := by nlinarith
      _ = 2 * b * Y^2 := by ring
  have hY2_eq : Y^2 = T^(2 * d) := by
    rw [sq, ← rpow_two_d_eq_mul hT0]
  rw [hY2_eq] at hstrict
  linarith

/-- Quantitative Pointwise Coercive Spectral Exclusion:
For all `T ≥ quantitativeThreshold d b (C_crit - c₀) (6M + C_tot)`, the inequality
`c₀ * log T - C_tot ≤ C_crit * log T + 6M - 2b T^(2d)` is FALSE. -/
theorem quantitative_coercive_exclusion
    {d b c₀ C_tot C_crit M T : ℝ} (hd : 0 < d) (hb : 0 < b)
    (hT : quantitativeThreshold d b (C_crit - c₀) (6 * M + C_tot) ≤ T) :
    ¬ (c₀ * Real.log T - C_tot ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d)) := by
  have hdom := quantitative_power_dominance (A := C_crit - c₀) (C := 6 * M + C_tot) hd hb hT
  intro hle
  linarith

/-- Pointwise refutation: if a coercive Weil pair holds at any scale above the
quantitative threshold, it forces an immediate contradiction. -/
theorem quantitative_offline_refutation
    {ι : Type*} [Fintype ι] [Nonempty ι]
    {W_arith W_spec : (ι → ℂ) → ℝ → ℝ} (c : ι → ℂ) (hc : c ≠ 0)
    {d b c₀ C_tot C_crit M T : ℝ} (hd : 0 < d) (hb : 0 < b)
    (hT : quantitativeThreshold d b (C_crit - c₀) (6 * M + C_tot) ≤ T)
    (h_id : W_arith c T = W_spec c T)
    (h_arith : (c₀ * Real.log T - C_tot) * energy c ≤ W_arith c T)
    (h_spec : W_spec c T ≤ (C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d)) * energy c) :
    False := by
  have hscalar := coercive_inequality_of_weil_identity c hc h_id h_arith h_spec
  have hnot := quantitative_coercive_exclusion hd hb hT
  exact hnot hscalar

/-- Hypothesis that every candidate zero supplies scalar lower, upper, and equality bounds at a
scale above the quantitative threshold. -/
def QuantitativeCoerciveSystem : Prop :=
  ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s = 0 →
    ∃ (ι : Type) (_ : Fintype ι) (_ : Nonempty ι)
      (W_arith W_spec : (ι → ℂ) → ℝ → ℝ) (c : ι → ℂ)
      (c₀ C_tot C_crit M b T : ℝ),
      c ≠ 0 ∧ 0 < b ∧
      quantitativeThreshold (s.re - 1/2) b (C_crit - c₀) (6 * M + C_tot) ≤ T ∧
      W_arith c T = W_spec c T ∧
      (c₀ * Real.log T - C_tot) * energy c ≤ W_arith c T ∧
      W_spec c T ≤ (C_crit * Real.log T + 6 * M - 2 * b * T^(2 * (s.re - 1/2))) * energy c

/-- A `QuantitativeCoerciveSystem` is inconsistent; an assumed instance yields `RightHalfZeroFree`. -/
theorem rightHalfZeroFree_of_quantitative_system (hsys : QuantitativeCoerciveSystem) :
    RightHalfZeroFree := by
  intro s hsr hs hz
  obtain ⟨ι, hfin, hnon, W_arith, W_spec, c, c₀, C_tot, C_crit, M, b, T,
          hc, hb, hT, hid, harith, hspec⟩ :=
    hsys s hsr hs hz
  have hd : 0 < s.re - 1 / 2 := by linarith
  exact quantitative_offline_refutation c hc hd hb hT hid harith hspec

/-- Conditional deduction of `RiemannHypothesis` from a `QuantitativeCoerciveSystem`. -/
theorem RiemannHypothesis_of_quantitative_system (hsys : QuantitativeCoerciveSystem) :
    RiemannHypothesis :=
  CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
    (rightHalfZeroFree_of_quantitative_system hsys)

/-- Certificate for quantitative exclusion threshold. -/
structure QuantitativeThresholdCertificate where
  d : ℝ
  b : ℝ
  A : ℝ
  C : ℝ
  thresh : ℝ
  hd : 0 < d
  hb : 0 < b
  hthresh_eq : thresh = quantitativeThreshold d b A C

/-- Constructor for QuantitativeThresholdCertificate. -/
def makeQuantitativeCertificate (d b A C : ℝ) (hd : 0 < d) (hb : 0 < b) :
    QuantitativeThresholdCertificate where
  d := d
  b := b
  A := A
  C := C
  thresh := quantitativeThreshold d b A C
  hd := hd
  hb := hb
  hthresh_eq := rfl

end

end BuildingBlocks.ChirpedQuantitativeExclusionThreshold

#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitativeBase_pos
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.one_le_quantitativeTarget
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitativeBase_lt_target
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.one_le_quantitativeThreshold
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitativeThreshold_pos
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.log_le_rpow_div
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.rpow_two_d_eq_mul
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitative_power_dominance
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitative_coercive_exclusion
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.quantitative_offline_refutation
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.rightHalfZeroFree_of_quantitative_system
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.RiemannHypothesis_of_quantitative_system
#print axioms BuildingBlocks.ChirpedQuantitativeExclusionThreshold.makeQuantitativeCertificate
