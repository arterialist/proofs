import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.ChirpedBrunTitchmarshMass

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedBrunTitchmarshRowBound

noncomputable section

/-- The constellation span upper bound:
D_T = 2 * log T + 2 * log(log T) - B. -/
def constellationSpan (T B : ℝ) : ℝ :=
  2 * Real.log T + 2 * Real.log (Real.log T) - B

/-- Half of the constellation span decomposes into log T + log(log T) - B/2. -/
theorem constellationSpan_div_two (T B : ℝ) :
    constellationSpan T B / 2 = Real.log T + Real.log (Real.log T) - B / 2 := by
  unfold constellationSpan
  ring

/-- The exponential of half the constellation span equals T * (log T) * exp(-B/2). -/
theorem exp_half_constellationSpan {T B : ℝ} (hT : 1 < T) :
    Real.exp (constellationSpan T B / 2) = T * Real.log T * Real.exp (-B / 2) := by
  have hlogT : 0 < Real.log T := Real.log_pos hT
  rw [constellationSpan_div_two]
  have hsplit : Real.log T + Real.log (Real.log T) - B / 2 =
      (Real.log T + Real.log (Real.log T)) + (-B / 2) := by ring
  rw [hsplit, Real.exp_add, Real.exp_add]
  rw [Real.exp_log (by linarith : 0 < T)]
  rw [Real.exp_log hlogT]

/-- Exact cancellation of carrier frequency T:
exp(D_T / 2) / T = exp(-B/2) * log T. -/
theorem span_carrier_cancellation {T B : ℝ} (hT : 1 < T) :
    Real.exp (constellationSpan T B / 2) / T = Real.exp (-B / 2) * Real.log T := by
  have hTpos : 0 < T := by linarith
  have heq := exp_half_constellationSpan (B := B) hT
  rw [heq]
  have hTne : T ≠ 0 := ne_of_gt hTpos
  calc
    (T * Real.log T * Real.exp (-B / 2)) / T =
        ((Real.exp (-B / 2) * Real.log T) * T) / T := by ring
    _ = Real.exp (-B / 2) * Real.log T := mul_div_cancel_right₀ _ hTne

/-- Short-interval scale ratio identity:
for H = N / T, H / sqrt(N) = sqrt(N) / T. -/
theorem short_interval_scale_ratio {N T : ℝ} (hN : 0 < N) :
    (N / T) / Real.sqrt N = Real.sqrt N / T := by
  have hsqrt_pos : 0 < Real.sqrt N := Real.sqrt_pos.mpr hN
  have hsqrt_sq : Real.sqrt N * Real.sqrt N = N := Real.mul_self_sqrt (by linarith)
  calc
    (N / T) / Real.sqrt N = (Real.sqrt N * Real.sqrt N / T) / Real.sqrt N := by rw [hsqrt_sq]
    _ = ((Real.sqrt N / T) * Real.sqrt N) / Real.sqrt N := by ring
    _ = Real.sqrt N / T := mul_div_cancel_right₀ (Real.sqrt N / T) (ne_of_gt hsqrt_pos)

/-- For N = exp(d), sqrt(N) = exp(d / 2). -/
theorem sqrt_exp_eq_exp_div_two (d : ℝ) :
    Real.sqrt (Real.exp d) = Real.exp (d / 2) := by
  have hpos : 0 ≤ Real.exp (d / 2) := (Real.exp_pos (d / 2)).le
  have hsq : Real.exp d = (Real.exp (d / 2)) ^ 2 := by
    rw [sq, ← Real.exp_add]
    congr 1
    ring
  rw [hsq, Real.sqrt_sq hpos]

/-- The single-pair cross bound at distance d:
for H = exp(d) / T, H / sqrt(exp d) = exp(d / 2) / T. -/
theorem cross_scale_factor_eq (d T : ℝ) :
    (Real.exp d / T) / Real.sqrt (Real.exp d) = Real.exp (d / 2) / T := by
  have hN : 0 < Real.exp d := Real.exp_pos d
  rw [short_interval_scale_ratio hN, sqrt_exp_eq_exp_div_two]

/-- Geometric multiplier for reverse shells with center spacing w > 0:
C_ratio = 1 / (1 - exp(-w/2)). -/
def geometricShellRatio (w : ℝ) : ℝ :=
  1 / (1 - Real.exp (-w / 2))

/-- The geometric shell ratio is strictly positive for w > 0. -/
theorem geometricShellRatio_pos {w : ℝ} (hw : 0 < w) :
    0 < geometricShellRatio w := by
  unfold geometricShellRatio
  have hneg : -w / 2 < 0 := by linarith
  have hlt : Real.exp (-w / 2) < 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_lt_exp.mpr hneg
  have hsub_pos : 0 < 1 - Real.exp (-w / 2) := by linarith
  exact one_div_pos.mpr hsub_pos

/-- The total geometric cross coefficient:
C_geom = C_cross * geometricShellRatio w. -/
def totalGeometricCoeff (C_cross w : ℝ) : ℝ :=
  C_cross * geometricShellRatio w

/-- Strict positivity of the total geometric cross coefficient. -/
theorem totalGeometricCoeff_pos {C_cross w : ℝ}
    (hC : 0 < C_cross) (hw : 0 < w) :
    0 < totalGeometricCoeff C_cross w :=
  mul_pos hC (geometricShellRatio_pos hw)

/-- Master Brun-Titchmarsh high-distance row equality:
C_cross * (geometricShellRatio w * (exp(D_T / 2) / T)) =
totalGeometricCoeff C_cross w * exp(-B/2) * log T. -/
theorem brun_titchmarsh_high_distance_row_eq
    {C_cross w B T : ℝ}
    (hT : 1 < T) :
    C_cross * (geometricShellRatio w * (Real.exp (constellationSpan T B / 2) / T)) =
    totalGeometricCoeff C_cross w * Real.exp (-B / 2) * Real.log T := by
  have hcancel := span_carrier_cancellation (B := B) hT
  unfold totalGeometricCoeff
  calc
    C_cross * (geometricShellRatio w * (Real.exp (constellationSpan T B / 2) / T)) =
        C_cross * geometricShellRatio w * (Real.exp (constellationSpan T B / 2) / T) := by ring
    _ = C_cross * geometricShellRatio w * (Real.exp (-B / 2) * Real.log T) := by rw [hcancel]
    _ = (C_cross * geometricShellRatio w) * Real.exp (-B / 2) * Real.log T := by ring

/-- Master Brun-Titchmarsh high-distance row bound. -/
theorem brun_titchmarsh_high_distance_row_le
    {C_cross w B T : ℝ}
    (hT : 1 < T) :
    C_cross * (geometricShellRatio w * (Real.exp (constellationSpan T B / 2) / T)) ≤
    totalGeometricCoeff C_cross w * Real.exp (-B / 2) * Real.log T :=
  le_of_eq (brun_titchmarsh_high_distance_row_eq hT)

/-- Master total row sum bound including low-distance remainder C_0:
R_cross(T) ≤ C_geom * exp(-B/2) * log T + C_0. -/
theorem total_prime_row_le
    {R_high C_0 C_geom B T : ℝ}
    (h_high : R_high ≤ C_geom * Real.exp (-B / 2) * Real.log T) :
    R_high + C_0 ≤ C_geom * Real.exp (-B / 2) * Real.log T + C_0 := by
  linarith

/-- Constructive certificate bundling the Brun-Titchmarsh row bound parameters. -/
structure BrunTitchmarshRowCertificate where
  w : ℝ
  w_pos : 0 < w
  C_cross : ℝ
  C_cross_pos : 0 < C_cross
  C_geom : ℝ
  C_geom_pos : 0 < C_geom
  C_geom_eq : C_geom = totalGeometricCoeff C_cross w

/-- Constructor for `BrunTitchmarshRowCertificate`. -/
def makeBrunTitchmarshRowCertificate
    (w C_cross : ℝ) (hw : 0 < w) (hC : 0 < C_cross) :
    BrunTitchmarshRowCertificate where
  w := w
  w_pos := hw
  C_cross := C_cross
  C_cross_pos := hC
  C_geom := totalGeometricCoeff C_cross w
  C_geom_pos := totalGeometricCoeff_pos hC hw
  C_geom_eq := rfl

end

end BuildingBlocks.ChirpedBrunTitchmarshRowBound

#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.constellationSpan_div_two
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.exp_half_constellationSpan
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.span_carrier_cancellation
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.short_interval_scale_ratio
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.sqrt_exp_eq_exp_div_two
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.cross_scale_factor_eq
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.geometricShellRatio_pos
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.totalGeometricCoeff_pos
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.brun_titchmarsh_high_distance_row_eq
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.brun_titchmarsh_high_distance_row_le
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.total_prime_row_le
#print axioms BuildingBlocks.ChirpedBrunTitchmarshRowBound.makeBrunTitchmarshRowCertificate
