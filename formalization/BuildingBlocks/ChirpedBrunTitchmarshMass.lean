import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedBrunTitchmarshMass

noncomputable section

/-- The logarithmic ratio of constellation upper endpoint to short interval length:
(log(u + h)) / (log h) for h ≥ T^(1/2) and u + h ≤ T^2 * (log T)^2. -/
def sieveLogRatio (logT loglogT : ℝ) : ℝ :=
  (2 * logT + 2 * loglogT) / (logT / 2)

/-- The sieve log ratio simplifies algebraically to 4 + 4 * (loglogT / logT). -/
theorem sieveLogRatio_eq (logT loglogT : ℝ) (hlog : logT ≠ 0) :
    sieveLogRatio logT loglogT = 4 + 4 * (loglogT / logT) := by
  unfold sieveLogRatio
  field_simp
  ring

/-- Whenever loglogT / logT ≤ 1/4, the sieve log ratio is bounded by 5. -/
theorem sieveLogRatio_le_five {logT loglogT : ℝ}
    (hlog : 0 < logT) (hratio : loglogT / logT ≤ 1 / 4) :
    sieveLogRatio logT loglogT ≤ 5 := by
  have hne : logT ≠ 0 := ne_of_gt hlog
  rw [sieveLogRatio_eq logT loglogT hne]
  linarith

/-- Lower bound on interval length logarithm: if T^(1/2) ≤ h, then (1/2) * log T ≤ log h. -/
theorem log_h_ge_half_logT {T h : ℝ} (hT : 1 ≤ T) (hh : T^( (1:ℝ)/2 ) ≤ h) :
    (1 / 2) * Real.log T ≤ Real.log h := by
  have hTpos : 0 < T := by linarith
  have hpowpos : 0 < T^( (1:ℝ)/2 ) := Real.rpow_pos_of_pos hTpos (1/2)
  have hmono := Real.log_le_log hpowpos hh
  have hlogpow : Real.log (T^( (1:ℝ)/2 )) = (1 / 2) * Real.log T :=
    Real.log_rpow hTpos (1/2)
  rw [hlogpow] at hmono
  exact hmono

/-- Upper bound on constellation endpoint logarithm:
if 1 < T and u + h ≤ T^2 * (Real.log T)^2, then log(u + h) ≤ 2 * log T + 2 * log(log T). -/
theorem log_endpoint_le {T u h : ℝ}
    (hT : 1 < T) (hpos : 0 < u + h)
    (hle : u + h ≤ T^2 * (Real.log T)^2) :
    Real.log (u + h) ≤ 2 * Real.log T + 2 * Real.log (Real.log T) := by
  have hlogT : 0 < Real.log T := Real.log_pos hT
  have hlogT2 : 0 < (Real.log T)^2 := sq_pos_of_pos hlogT
  have hT2 : 0 < T^2 := by positivity
  have hlog_le := Real.log_le_log hpos hle
  have hsplit : Real.log (T^2 * (Real.log T)^2) = Real.log (T^2) + Real.log ((Real.log T)^2) :=
    Real.log_mul (ne_of_gt hT2) (ne_of_gt hlogT2)
  have hlog_T2 : Real.log (T^2) = 2 * Real.log T := by
    rw [sq, Real.log_mul (by linarith) (by linarith)]
    ring
  have hlog_log2 : Real.log ((Real.log T)^2) = 2 * Real.log (Real.log T) := by
    rw [sq, Real.log_mul (ne_of_gt hlogT) (ne_of_gt hlogT)]
    ring
  rw [hsplit, hlog_T2, hlog_log2] at hlog_le
  exact hlog_le

/-- Universal half-power bound on the logarithm of any positive variable. -/
theorem log_le_two_sqrt {y : ℝ} (hy : 0 < y) :
    Real.log y ≤ 2 * y^( (1:ℝ)/2 ) := by
  have hpow : 0 < y^( (1:ℝ)/2 ) := Real.rpow_pos_of_pos hy (1/2)
  have hle := Real.log_le_sub_one_of_pos hpow
  rw [Real.log_rpow hy] at hle
  linarith

/-- For y ≥ 64, log y / y ≤ 1/4. -/
theorem log_div_self_le_quarter {y : ℝ} (hy : 64 ≤ y) :
    Real.log y / y ≤ 1 / 4 := by
  have hypos : 0 < y := by linarith
  have hbd := log_le_two_sqrt hypos
  have hpow_pos : 0 < y^( (1:ℝ)/2 ) := Real.rpow_pos_of_pos hypos (1/2)
  have hpow_ge_8 : 8 ≤ y^( (1:ℝ)/2 ) := by
    have h64_pow : (64 : ℝ)^( (1:ℝ)/2 ) = 8 := by
      have : (64 : ℝ) = 8^2 := by norm_num
      rw [this, ← Real.rpow_natCast, ← Real.rpow_mul (by norm_num : (0:ℝ) ≤ 8)]
      norm_num
    rw [← h64_pow]
    exact Real.rpow_le_rpow (by norm_num) hy (by norm_num)
  have hmul : 8 * y^( (1:ℝ)/2 ) ≤ y := by
    have hprod : y^( (1:ℝ)/2 ) * y^( (1:ℝ)/2 ) = y := by
      rw [← Real.rpow_add hypos]
      norm_num
    calc
      8 * y^( (1:ℝ)/2 ) ≤ y^( (1:ℝ)/2 ) * y^( (1:ℝ)/2 ) := by
        nlinarith [hpow_ge_8, hpow_pos]
      _ = y := hprod
  have htwo_pow_le : 2 * y^( (1:ℝ)/2 ) ≤ y / 4 := by
    linarith [hmul]
  have hlog_le_quarter_y : Real.log y ≤ y / 4 :=
    hbd.trans htwo_pow_le
  exact (div_le_iff₀ hypos).mpr (by linarith [hlog_le_quarter_y])

/-- For log T ≥ 64, the ratio log(log T) / log T is bounded by 1/4. -/
theorem loglogT_ratio_le_quarter {T : ℝ} (hT : 64 ≤ Real.log T) :
    Real.log (Real.log T) / Real.log T ≤ 1 / 4 :=
  log_div_self_le_quarter hT

/-- For log T ≥ 64, the sieve log ratio is bounded by 5. -/
theorem sieveLogRatio_le_five_of_logT_ge_64 {T : ℝ} (hT : 64 ≤ Real.log T) :
    sieveLogRatio (Real.log T) (Real.log (Real.log T)) ≤ 5 := by
  have hlogT_pos : 0 < Real.log T := by linarith
  have hratio := loglogT_ratio_le_quarter hT
  exact sieveLogRatio_le_five hlogT_pos hratio

/-- The sieve constant for Montgomery-Vaughan short-interval mass:
C_sieve = 2 * K_ratio + C_higher = 2 * 5 + 2 = 12. -/
def sieveConstant : ℝ := 12

/-- The sieve constant is strictly positive. -/
theorem sieveConstant_pos : 0 < sieveConstant := by
  unfold sieveConstant
  norm_num

/-- Bound on ordinary prime short-interval mass:
log(u + h) * (2h / log h) ≤ 2h * sieveLogRatio ≤ 10h. -/
theorem ordinary_prime_mass_le {u h logT loglogT : ℝ}
    (hhpos : 0 ≤ h)
    (hlog_ratio : sieveLogRatio logT loglogT ≤ 5)
    (h_ratio_bound : (Real.log (u + h)) / (Real.log h) ≤ sieveLogRatio logT loglogT) :
    Real.log (u + h) * (2 * h / Real.log h) ≤ 10 * h := by
  have hprod : Real.log (u + h) * (2 * h / Real.log h) =
      2 * h * (Real.log (u + h) / Real.log h) := by ring
  rw [hprod]
  have hle : Real.log (u + h) / Real.log h ≤ 5 := h_ratio_bound.trans hlog_ratio
  nlinarith [hle, hhpos]

/-- Total short-interval von Mangoldt sieve mass bound:
ordinary prime mass (10h) plus higher-power mass (2h) is at most 12h = C_sieve * h. -/
theorem short_interval_psi_mass_le (h : ℝ) :
    10 * h + 2 * h ≤ sieveConstant * h := by
  unfold sieveConstant
  linarith

/-- Constructive certificate bundling the short-interval sieve mass parameters. -/
structure ShortIntervalSieveCertificate where
  sieve_coeff : ℝ
  sieve_pos : 0 < sieve_coeff
  ratio_bound : ℝ
  ratio_le : ratio_bound ≤ 5
  total_le : 2 * ratio_bound + 2 ≤ sieve_coeff

/-- Constructor for `ShortIntervalSieveCertificate`. -/
def makeShortIntervalSieveCertificate : ShortIntervalSieveCertificate where
  sieve_coeff := sieveConstant
  sieve_pos := sieveConstant_pos
  ratio_bound := 5
  ratio_le := le_rfl
  total_le := by
    unfold sieveConstant
    norm_num

end

end BuildingBlocks.ChirpedBrunTitchmarshMass

#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.sieveLogRatio_eq
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.sieveLogRatio_le_five
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.log_h_ge_half_logT
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.log_endpoint_le
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.log_le_two_sqrt
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.log_div_self_le_quarter
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.loglogT_ratio_le_quarter
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.sieveLogRatio_le_five_of_logT_ge_64
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.ordinary_prime_mass_le
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.short_interval_psi_mass_le
#print axioms BuildingBlocks.ChirpedBrunTitchmarshMass.makeShortIntervalSieveCertificate
