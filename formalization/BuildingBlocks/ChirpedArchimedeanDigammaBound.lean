import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedArchimedeanDigammaBound

/-- The Archimedean digamma local scale parameter: t/2 = T(1 + η x) / 2. -/
noncomputable def chirpedArchimedeanScale (T eta x : ℝ) : ℝ :=
  T * (1 + eta * x) / 2

/-- The Archimedean scale is strictly positive for positive carrier, chirp rate, and support. -/
theorem chirpedArchimedeanScale_pos {T eta x : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) :
    0 < chirpedArchimedeanScale T eta x := by
  unfold chirpedArchimedeanScale
  have h1 : 0 < 1 + eta * x := by
    have : 0 ≤ eta * x := mul_nonneg heta hx
    linarith
  positivity

/-- Algebraic split of the logarithmic Archimedean scale:
log(T(1 + η x) / 2) = log T - log 2 + log(1 + η x). -/
theorem chirped_archimedean_log_split {T eta x : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) :
    Real.log (chirpedArchimedeanScale T eta x) =
      Real.log T - Real.log 2 + Real.log (1 + eta * x) := by
  unfold chirpedArchimedeanScale
  have h_inner_pos : 0 < 1 + eta * x := by
    have : 0 ≤ eta * x := mul_nonneg heta hx
    linarith
  have h_num_pos : 0 < T * (1 + eta * x) := mul_pos hT h_inner_pos
  rw [Real.log_div (ne_of_gt h_num_pos) (by norm_num : (2 : ℝ) ≠ 0)]
  rw [Real.log_mul (ne_of_gt hT) (ne_of_gt h_inner_pos)]
  ring

/-- The Archimedean scale logarithm is bounded from below by log T - log 2. -/
theorem chirped_archimedean_log_ge_sub_two {T eta x : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) :
    Real.log T - Real.log 2 ≤ Real.log (chirpedArchimedeanScale T eta x) := by
  rw [chirped_archimedean_log_split hT heta hx]
  have h_one_le : 1 ≤ 1 + eta * x := by
    have : 0 ≤ eta * x := mul_nonneg heta hx
    linarith
  have h_log_nonneg : 0 ≤ Real.log (1 + eta * x) := Real.log_nonneg h_one_le
  linarith

/-- The Archimedean scale logarithm is bounded from above by log T - log 2 + η w on [0, w]. -/
theorem chirped_archimedean_log_le_top {T eta x w : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) (hxw : x ≤ w) :
    Real.log (chirpedArchimedeanScale T eta x) ≤
      Real.log T - Real.log 2 + eta * w := by
  rw [chirped_archimedean_log_split hT heta hx]
  have h_pos : 0 < 1 + eta * x := by
    have : 0 ≤ eta * x := mul_nonneg heta hx
    linarith
  have h_le_sub_one := Real.log_le_sub_one_of_pos h_pos
  have h_log_le : Real.log (1 + eta * x) ≤ eta * x := by linarith
  have h_x_le : eta * x ≤ eta * w := mul_le_mul_of_nonneg_left hxw heta
  linarith

/-- The deviation of the Archimedean scale logarithm from log T is bounded by log 2 + η w on [0, w]. -/
theorem chirped_archimedean_log_deviation_le {T eta x w : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) (hxw : x ≤ w) :
    |Real.log (chirpedArchimedeanScale T eta x) - Real.log T| ≤
      Real.log 2 + eta * w := by
  have h_ge := chirped_archimedean_log_ge_sub_two hT heta hx
  have h_le := chirped_archimedean_log_le_top hT heta hx hxw
  have h_log2_pos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h_etaw_nonneg : 0 ≤ eta * w := by
    have : 0 ≤ w := by linarith
    exact mul_nonneg heta this
  rw [abs_le]
  constructor
  · linarith
  · linarith

/-- The Archimedean continuous background constant:
C_cont := log 2 + η * w + C_Gamma. -/
noncomputable def chirpedArchimedeanCoeff (eta w C_Gamma : ℝ) : ℝ :=
  Real.log 2 + eta * w + C_Gamma

/-- The Archimedean continuous background coefficient is strictly positive. -/
theorem chirpedArchimedeanCoeff_pos {eta w C_Gamma : ℝ}
    (heta : 0 ≤ eta) (hw : 0 ≤ w) (hGamma : 0 ≤ C_Gamma) :
    0 < chirpedArchimedeanCoeff eta w C_Gamma := by
  unfold chirpedArchimedeanCoeff
  have h_log2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h_etaw : 0 ≤ eta * w := mul_nonneg heta hw
  positivity

/-- Total continuous background bound combining scale logarithm deviation and digamma remainder:
|log(scale) + R_Gamma - log T| ≤ C_cont. -/
theorem chirped_archimedean_total_deviation_le {T eta x w C_Gamma R_Gamma : ℝ}
    (hT : 0 < T) (heta : 0 ≤ eta) (hx : 0 ≤ x) (hxw : x ≤ w)
    (hR : |R_Gamma| ≤ C_Gamma) :
    |(Real.log (chirpedArchimedeanScale T eta x) + R_Gamma) - Real.log T| ≤
      chirpedArchimedeanCoeff eta w C_Gamma := by
  have h_dev := chirped_archimedean_log_deviation_le hT heta hx hxw
  unfold chirpedArchimedeanCoeff
  have h_sum : |(Real.log (chirpedArchimedeanScale T eta x) - Real.log T) + R_Gamma| ≤
      |Real.log (chirpedArchimedeanScale T eta x) - Real.log T| + |R_Gamma| := abs_add_le _ _
  have h_id : (Real.log (chirpedArchimedeanScale T eta x) + R_Gamma) - Real.log T =
      (Real.log (chirpedArchimedeanScale T eta x) - Real.log T) + R_Gamma := by ring
  rw [h_id]
  linarith

/-- Constructive certificate bundling Archimedean continuous bound parameters. -/
structure ChirpedArchimedeanBoundCertificate (eta w C_Gamma : ℝ) : Prop where
  eta_nonneg : 0 ≤ eta
  w_pos : 0 < w
  Gamma_nonneg : 0 ≤ C_Gamma
  coeff_pos : 0 < chirpedArchimedeanCoeff eta w C_Gamma
  total_bound : ∀ (T x R_Gamma : ℝ), 0 < T → 0 ≤ x → x ≤ w → |R_Gamma| ≤ C_Gamma →
    |(Real.log (chirpedArchimedeanScale T eta x) + R_Gamma) - Real.log T| ≤
      chirpedArchimedeanCoeff eta w C_Gamma

/-- Constructor for `ChirpedArchimedeanBoundCertificate`. -/
theorem makeArchimedeanBoundCertificate {eta w C_Gamma : ℝ}
    (heta : 0 ≤ eta) (hw : 0 < w) (hGamma : 0 ≤ C_Gamma) :
    ChirpedArchimedeanBoundCertificate eta w C_Gamma :=
  ⟨heta, hw, hGamma,
   chirpedArchimedeanCoeff_pos heta (le_of_lt hw) hGamma,
   fun _T _x _R_Gamma hT hx hxw hR =>
     chirped_archimedean_total_deviation_le hT heta hx hxw hR⟩

end BuildingBlocks.ChirpedArchimedeanDigammaBound

#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirpedArchimedeanScale_pos
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirped_archimedean_log_split
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirped_archimedean_log_ge_sub_two
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirped_archimedean_log_le_top
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirped_archimedean_log_deviation_le
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirpedArchimedeanCoeff_pos
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.chirped_archimedean_total_deviation_le
#print axioms BuildingBlocks.ChirpedArchimedeanDigammaBound.makeArchimedeanBoundCertificate
