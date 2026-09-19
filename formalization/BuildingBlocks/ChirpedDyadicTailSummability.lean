import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedDyadicTailSummability

/-- Geometric series partial sum bound: for 0 ≤ r < 1, ∑_{k=0}^K r^k ≤ 1 / (1 - r). -/
theorem geom_sum_le_inv_sub (r : ℝ) (hr0 : 0 ≤ r) (hr1 : r < 1) (K : ℕ) :
    (Finset.range (K + 1)).sum (fun k => r ^ k) ≤ 1 / (1 - r) := by
  have h1 : 0 < 1 - r := sub_pos.mpr hr1
  have h_geom : (Finset.range (K + 1)).sum (fun k => r ^ k) * (1 - r) = 1 - r ^ (K + 1) := by
    exact geom_sum_mul_neg r (K + 1)
  have hrK : 0 ≤ r ^ (K + 1) := by positivity
  have h_le : 1 - r ^ (K + 1) ≤ 1 := by linarith
  have h_mul : (Finset.range (K + 1)).sum (fun k => r ^ k) * (1 - r) ≤ 1 := by linarith
  exact (le_div_iff₀ h1).mpr h_mul

/-- Dyadic geometric ratio r = 1/2 gives sum ≤ 2. -/
theorem dyadic_half_sum_le (K : ℕ) :
    (Finset.range (K + 1)).sum (fun k => (1 / 2 : ℝ) ^ k) ≤ 2 := by
  have h := geom_sum_le_inv_sub (1 / 2 : ℝ) (by norm_num) (by norm_num) K
  have h2 : (1 : ℝ) / (1 - 1 / 2) = 2 := by norm_num
  linarith

/-- Dyadic geometric ratio r = 1/4 gives sum ≤ 4/3. -/
theorem dyadic_quarter_sum_le (K : ℕ) :
    (Finset.range (K + 1)).sum (fun k => (1 / 4 : ℝ) ^ k) ≤ 4 / 3 := by
  have h := geom_sum_le_inv_sub (1 / 4 : ℝ) (by norm_num) (by norm_num) K
  have h43 : (1 : ℝ) / (1 - 1 / 4) = 4 / 3 := by norm_num
  linarith

/-- The k-th dyadic annulus inner radius: 2^k * Δ_0. -/
def dyadicInnerRadius (Δ0 : ℝ) (k : ℕ) : ℝ :=
  (2 : ℝ) ^ k * Δ0

/-- The k-th dyadic annulus outer radius: 2^(k+1) * Δ_0. -/
def dyadicOuterRadius (Δ0 : ℝ) (k : ℕ) : ℝ :=
  (2 : ℝ) ^ (k + 1) * Δ0

/-- Annulus inner radius is positive for positive base separation Δ0. -/
theorem dyadicInnerRadius_pos {Δ0 : ℝ} (hΔ : 0 < Δ0) (k : ℕ) :
    0 < dyadicInnerRadius Δ0 k := by
  unfold dyadicInnerRadius
  positivity

/-- Reciprocal square gradient bound on the k-th annulus:
since |Φ'| ≥ dyadicInnerRadius Δ0 k, (dyadicInnerRadius Δ0 k)² ≤ x_grad². -/
theorem dyadic_reciprocal_square_gradient_le {Δ0 x_grad : ℝ}
    (k : ℕ)
    (hgrad : dyadicInnerRadius Δ0 k ≤ |x_grad|)
    (h_inner_nonneg : 0 ≤ dyadicInnerRadius Δ0 k) :
    (dyadicInnerRadius Δ0 k) ^ 2 ≤ x_grad ^ 2 := by
  have h_abs : 0 ≤ |x_grad| := abs_nonneg x_grad
  have h_sq : (dyadicInnerRadius Δ0 k) ^ 2 ≤ |x_grad| ^ 2 := by
    nlinarith [hgrad, h_inner_nonneg, h_abs]
  rw [sq_abs] at h_sq
  exact h_sq

/-- Dyadic zero count upper bound on the k-th annulus:
N(A_k) ≤ C_dens * 2^(k+1) * Δ0 * (log T + (k+1) * log 2). -/
noncomputable def dyadicZeroCountBound (C_dens Δ0 T : ℝ) (k : ℕ) : ℝ :=
  C_dens * dyadicOuterRadius Δ0 k * (Real.log T + (k + 1 : ℝ) * Real.log 2)

/-- The k-th annulus energy weight: (4^k * Δ0^2)⁻¹. -/
noncomputable def dyadicWeight (Δ0 : ℝ) (k : ℕ) : ℝ :=
  1 / (((2 : ℝ) ^ k * Δ0) ^ 2)

/-- Product of zero count factor and reciprocal square gradient on the k-th annulus:
(C_dens * dyadicOuterRadius Δ0 k) * dyadicWeight Δ0 k = (2 * C_dens / Δ0) * (1/2)^k. -/
theorem dyadic_annulus_term_eq (C_dens Δ0 : ℝ) (k : ℕ)
    (hΔ : Δ0 ≠ 0) :
    (C_dens * (dyadicOuterRadius Δ0 k)) * (dyadicWeight Δ0 k) =
      (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k := by
  unfold dyadicOuterRadius dyadicWeight
  have h2k_pos : 0 < (2 : ℝ) ^ k := by positivity
  have h2k_ne : (2 : ℝ) ^ k ≠ 0 := ne_of_gt h2k_pos
  have h_pow_succ : (2 : ℝ) ^ (k + 1) = 2 * (2 : ℝ) ^ k := by
    exact pow_succ' 2 k
  rw [h_pow_succ, one_div_pow]
  have h_cancel : ∀ (A B : ℝ), A ≠ 0 → B ≠ 0 →
    (C_dens * (2 * A * B)) * (1 / ((A * B) ^ 2)) = (2 * C_dens / B) * (1 / A) := by
    intro A B _ _
    field_simp
  exact h_cancel ((2 : ℝ) ^ k) Δ0 h2k_ne hΔ

/-- The total dyadic tail logarithmic constant: C_tail := 4 * C_dens / Δ0. -/
noncomputable def dyadicTailCoeff (C_dens Δ0 : ℝ) : ℝ :=
  4 * C_dens / Δ0

/-- The dyadic tail coefficient is strictly positive for positive density and base separation. -/
theorem dyadicTailCoeff_pos {C_dens Δ0 : ℝ} (hC : 0 < C_dens) (hΔ : 0 < Δ0) :
    0 < dyadicTailCoeff C_dens Δ0 := by
  unfold dyadicTailCoeff
  positivity

/-- Total dyadic tail bound for the lead logarithmic term over any finite number of dyadic annuli:
∑_{k=0}^K (2 * C_dens / Δ0) * (1/2)^k * log T ≤ (dyadicTailCoeff C_dens Δ0) * log T. -/
theorem dyadic_tail_sum_le (C_dens Δ0 T : ℝ) (K : ℕ)
    (hC : 0 < C_dens) (hΔ : 0 < Δ0) (hT : 1 ≤ T) :
    (Finset.range (K + 1)).sum (fun k => (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k * Real.log T) ≤
      (dyadicTailCoeff C_dens Δ0) * Real.log T := by
  have hlog : 0 ≤ Real.log T := Real.log_nonneg hT
  have h_factor :
    (Finset.range (K + 1)).sum (fun k => (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k * Real.log T) =
      ((2 * C_dens / Δ0) * Real.log T) * (Finset.range (K + 1)).sum (fun k => (1 / 2 : ℝ) ^ k) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro k _
    ring
  rw [h_factor]
  have h_geom := dyadic_half_sum_le K
  have h_coeff_nonneg : 0 ≤ (2 * C_dens / Δ0) * Real.log T := by positivity
  have h_mul := mul_le_mul_of_nonneg_left h_geom h_coeff_nonneg
  unfold dyadicTailCoeff
  calc
    ((2 * C_dens / Δ0) * Real.log T) * (Finset.range (K + 1)).sum (fun k => (1 / 2 : ℝ) ^ k)
      ≤ ((2 * C_dens / Δ0) * Real.log T) * 2 := h_mul
    _ = (4 * C_dens / Δ0) * Real.log T := by ring

/-- Constructive certificate bundling dyadic tail summability parameters. -/
structure DyadicTailSumCertificate (C_dens Δ0 : ℝ) : Prop where
  dens_pos : 0 < C_dens
  Δ0_pos : 0 < Δ0
  tail_pos : 0 < dyadicTailCoeff C_dens Δ0
  tail_bound : ∀ (T : ℝ) (K : ℕ), 1 ≤ T →
    (Finset.range (K + 1)).sum (fun k => (2 * C_dens / Δ0) * (1 / 2 : ℝ) ^ k * Real.log T) ≤
      (dyadicTailCoeff C_dens Δ0) * Real.log T

/-- Constructor for `DyadicTailSumCertificate`. -/
theorem makeDyadicTailSumCertificate {C_dens Δ0 : ℝ}
    (hC : 0 < C_dens) (hΔ : 0 < Δ0) :
    DyadicTailSumCertificate C_dens Δ0 :=
  ⟨hC, hΔ, dyadicTailCoeff_pos hC hΔ,
   fun T K hT => dyadic_tail_sum_le C_dens Δ0 T K hC hΔ hT⟩

end BuildingBlocks.ChirpedDyadicTailSummability

#print axioms BuildingBlocks.ChirpedDyadicTailSummability.geom_sum_le_inv_sub
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadic_half_sum_le
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadic_quarter_sum_le
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadicInnerRadius_pos
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadic_reciprocal_square_gradient_le
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadic_annulus_term_eq
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadicTailCoeff_pos
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.dyadic_tail_sum_le
#print axioms BuildingBlocks.ChirpedDyadicTailSummability.makeDyadicTailSumCertificate
