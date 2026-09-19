import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.Scope
import BuildingBlocks.ChirpedQuadratureDecay

/-!
# Finite Dyadic Envelope Algebra

This module defines scalar shell envelopes and proves finite-sum geometric bounds.  The names
`shellPointwiseDecay` and `shellZeroCount` are formulas, not estimates derived here for an actual
zeta-zero sum.  No infinite tail, oscillatory integral, or Riemann-von Mangoldt remainder theorem
is formalized in this file.
-/

namespace BuildingBlocks.ChirpedDyadicTailEnergy

open Filter
open scoped Topology BigOperators
open BuildingBlocks.ChirpedQuadratureDecay

noncomputable section

/-- Minimal frequency separation in dyadic shell `m ≥ 1`:
`shellMinDelta m T = 2^(m - 1) * T`. -/
def shellMinDelta (m : ℕ) (T : ℝ) : ℝ :=
  (2 : ℝ)^(m - 1) * T

/-- Defined fourth-power shell expression for `m ≥ 1`:
`shellPointwiseDecay C_IBP2 m T = 16 * C_IBP2^2 / (16^m * T^4)`. -/
def shellPointwiseDecay (C_IBP2 : ℝ) (m : ℕ) (T : ℝ) : ℝ :=
  16 * C_IBP2^2 / ((16 : ℝ)^m * T^4)

/-- Defined count-shaped expression for the shell `[2^m T, 2^(m+1) T)`:
`shellZeroCount C_dens m T = C_dens * 2^(m + 1) * T * ((m + 2 : ℝ) * Real.log T)`. -/
def shellZeroCount (C_dens : ℝ) (m : ℕ) (T : ℝ) : ℝ :=
  C_dens * (2 : ℝ)^(m + 1) * T * ((m + 2 : ℝ) * Real.log T)

/-- Dimensionless geometric shell decay factor:
`geometricShellFactor m = (m + 2 : ℝ) / (8 : ℝ)^m`. -/
def geometricShellFactor (m : ℕ) : ℝ :=
  (m + 2 : ℝ) / (8 : ℝ)^m

/-- Defined shell envelope:
`shellEnergyBound C_IBP2 C_dens m T = 32 * C_IBP2^2 * C_dens * (Real.log T / T^3) * geometricShellFactor m`. -/
def shellEnergyBound (C_IBP2 C_dens : ℝ) (m : ℕ) (T : ℝ) : ℝ :=
  32 * C_IBP2^2 * C_dens * (Real.log T / T^3) * geometricShellFactor m

/-- Algebraic factorization: the product of the two defined shell expressions
equals the defined shell envelope by algebra. -/
theorem shell_energy_product_eq (C_IBP2 C_dens T : ℝ) (m : ℕ) (hT : T ≠ 0) :
    shellPointwiseDecay C_IBP2 m T * shellZeroCount C_dens m T =
    shellEnergyBound C_IBP2 C_dens m T := by
  unfold shellPointwiseDecay shellZeroCount shellEnergyBound geometricShellFactor
  have h16 : (16 : ℝ)^m = (2 : ℝ)^m * (8 : ℝ)^m := by
    rw [← mul_pow]
    norm_num
  have h2pow : (2 : ℝ)^(m + 1) = (2 : ℝ)^m * 2 := by rw [pow_succ]
  rw [h16, h2pow]
  have hT4 : T^4 = T^3 * T := by ring
  rw [hT4]
  have h2m_ne : (2 : ℝ)^m ≠ 0 := by positivity
  have h8m_ne : (8 : ℝ)^m ≠ 0 := by positivity
  field_simp
  ring

/-- Finite sum of the defined shell envelopes for `1 ≤ m ≤ M`:
`finiteDyadicTailEnergy C_IBP2 C_dens M T = ∑ m ∈ Finset.range M, shellEnergyBound C_IBP2 C_dens (m + 1) T`. -/
def finiteDyadicTailEnergy (C_IBP2 C_dens : ℝ) (M : ℕ) (T : ℝ) : ℝ :=
  ∑ m ∈ Finset.range M, shellEnergyBound C_IBP2 C_dens (m + 1) T

/-- Arithmetic-geometric sequence bound on natural numbers: `m + 3 ≤ 3 * 2^m`. -/
theorem nat_shell_index_le_three_pow_two (m : ℕ) :
    m + 3 ≤ 3 * 2^m := by
  induction m with
  | zero => decide
  | succ k ih =>
    have h2 : 2^(k + 1) = 2^k * 2 := by rw [pow_succ]
    rw [h2]
    omega

/-- Real arithmetic-geometric sequence bound: `(m + 3 : ℝ) ≤ 3 * 2^m` for all `m ∈ ℕ`. -/
theorem shell_index_le_three_pow_two (m : ℕ) :
    (m + 3 : ℝ) ≤ 3 * (2 : ℝ)^m := by
  have h := nat_shell_index_le_three_pow_two m
  exact_mod_cast h

/-- Geometric domination of individual shell factor:
`geometricShellFactor (m + 1) ≤ (3 / 8) * (1 / 4)^m` for all `m ∈ ℕ`. -/
theorem geometric_shell_factor_le_quarter (m : ℕ) :
    geometricShellFactor (m + 1) ≤ (3 / 8) * ((1 / 4 : ℝ)^m) := by
  unfold geometricShellFactor
  have h8 : (8 : ℝ)^(m + 1) = 8 * (8 : ℝ)^m := by rw [pow_succ]; ring
  have h8m : (8 : ℝ)^m = (2 : ℝ)^m * (4 : ℝ)^m := by
    rw [← mul_pow]
    norm_num
  rw [h8, h8m]
  have hle := shell_index_le_three_pow_two m
  have h2m_pos : 0 < (2 : ℝ)^m := by positivity
  have h4m_pos : 0 < (4 : ℝ)^m := by positivity
  have hdiv_pos : 0 < 8 * ((2 : ℝ)^m * (4 : ℝ)^m) := by positivity
  have hq : (1 / 4 : ℝ)^m = 1 / (4 : ℝ)^m := by
    rw [one_div_pow]
  rw [hq]
  have hnum : ((m + 1 : ℕ) + 2 : ℝ) = (m + 3 : ℝ) := by
    push_cast
    ring
  rw [hnum]
  rw [div_le_iff₀ hdiv_pos]
  calc
    (m + 3 : ℝ) ≤ 3 * (2 : ℝ)^m := hle
    _ = (3 / 8 * (1 / (4 : ℝ)^m)) * (8 * ((2 : ℝ)^m * (4 : ℝ)^m)) := by
      have h4_ne : (4 : ℝ)^m ≠ 0 := ne_of_gt h4m_pos
      field_simp

/-- Finite geometric sum exact formula:
`∑ m ∈ Finset.range M, (1 / 4)^m = 4 / 3 - (4 / 3) * (1 / 4)^M` for all `M`. -/
theorem sum_quarter_pow_eq (M : ℕ) :
    ∑ m ∈ Finset.range M, ((1 / 4 : ℝ)^m) = 4 / 3 - (4 / 3) * ((1 / 4 : ℝ)^M) := by
  induction M with
  | zero =>
    simp only [Finset.range_zero, Finset.sum_empty, pow_zero, mul_one, sub_self]
  | succ k ih =>
    rw [Finset.sum_range_succ, ih]
    have hpow : ((1 / 4 : ℝ)^(k + 1)) = (1 / 4 : ℝ) * ((1 / 4 : ℝ)^k) := by
      rw [pow_succ]
      ring
    rw [hpow]
    ring

/-- Finite geometric series bound:
`∑ m ∈ Finset.range M, (1 / 4)^m ≤ 4 / 3` for all `M`. -/
theorem sum_quarter_pow_le (M : ℕ) :
    ∑ m ∈ Finset.range M, ((1 / 4 : ℝ)^m) ≤ 4 / 3 := by
  rw [sum_quarter_pow_eq]
  have hpos : 0 ≤ (4 / 3 : ℝ) * ((1 / 4 : ℝ)^M) := by positivity
  linarith

/-- Finite geometric-factor sum bound:
`∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ 1 / 2` for all `M`. -/
theorem sum_geometric_shell_factor_le_half (M : ℕ) :
    ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ 1 / 2 := by
  have hterm : ∀ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ (3 / 8) * ((1 / 4 : ℝ)^m) := by
    intro m _
    exact geometric_shell_factor_le_quarter m
  have hsum := Finset.sum_le_sum hterm
  have hmul : ∑ m ∈ Finset.range M, (3 / 8 : ℝ) * ((1 / 4 : ℝ)^m) =
              (3 / 8) * ∑ m ∈ Finset.range M, ((1 / 4 : ℝ)^m) := by
    rw [← Finset.mul_sum]
  rw [hmul] at hsum
  have hgeom := sum_quarter_pow_le M
  have hbound : (3 / 8 : ℝ) * ∑ m ∈ Finset.range M, ((1 / 4 : ℝ)^m) ≤ (3 / 8) * (4 / 3) := by
    nlinarith
  have hhalf : (3 / 8 : ℝ) * (4 / 3) = 1 / 2 := by norm_num
  rw [hhalf] at hbound
  exact le_trans hsum hbound

/-- The finite geometric-factor sum is bounded by 1 for all `M`. -/
theorem sum_geometric_shell_factor_le_one (M : ℕ) :
    ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤ 1 := by
  have hhalf := sum_geometric_shell_factor_le_half M
  linarith

/-- Finite sum bound for the defined dyadic envelope:
For any number of dyadic shells `M` and any carrier scale `T ≥ 1`, the total
high-frequency tail energy is bounded uniformly by
`16 * C_IBP2^2 * C_dens * (log T / T^3)`. -/
theorem finite_dyadic_tail_le_master
    (C_IBP2 C_dens : ℝ) (M : ℕ) (T : ℝ)
    (_hC1 : 0 ≤ C_IBP2) (hC2 : 0 ≤ C_dens) (hT : 1 ≤ T) :
    finiteDyadicTailEnergy C_IBP2 C_dens M T ≤
    16 * C_IBP2^2 * C_dens * (Real.log T / T^3) := by
  unfold finiteDyadicTailEnergy
  have heq : (∑ m ∈ Finset.range M, shellEnergyBound C_IBP2 C_dens (m + 1) T) =
             (32 * C_IBP2^2 * C_dens * (Real.log T / T^3)) *
             ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro m _hm
    unfold shellEnergyBound
    ring
  rw [heq]
  have hlog_nonneg : 0 ≤ Real.log T := Real.log_nonneg hT
  have hT_pos : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have hT3_pos : 0 < T^3 := by positivity
  have hsum_le := sum_geometric_shell_factor_le_half M
  have hcoeff_nonneg : 0 ≤ 32 * C_IBP2^2 * C_dens * (Real.log T / T^3) := by
    have hsq : 0 ≤ C_IBP2^2 := sq_nonneg C_IBP2
    have hdiv : 0 ≤ Real.log T / T^3 := div_nonneg hlog_nonneg (le_of_lt hT3_pos)
    positivity
  have hle : (32 * C_IBP2^2 * C_dens * (Real.log T / T^3)) *
             ∑ m ∈ Finset.range M, geometricShellFactor (m + 1) ≤
             (32 * C_IBP2^2 * C_dens * (Real.log T / T^3)) * (1 / 2) := by
    nlinarith
  have hhalf : (32 * C_IBP2^2 * C_dens * (Real.log T / T^3)) * (1 / 2) =
               16 * C_IBP2^2 * C_dens * (Real.log T / T^3) := by ring
  rw [hhalf] at hle
  exact hle

/-- Pointwise log/cube decay bound:
`Real.log T / T^3 ≤ 1 / T^2` for all `T ≥ 1`. -/
theorem log_div_pow_three_le (T : ℝ) (hT : 1 ≤ T) :
    Real.log T / T^3 ≤ 1 / T^2 := by
  have hlog_le_T : Real.log T ≤ T := by
    have h := Real.log_le_sub_one_of_pos (lt_of_lt_of_le zero_lt_one hT)
    linarith
  have hT_pos : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have hT3_pos : 0 < T^3 := by positivity
  have h1 : Real.log T / T^3 ≤ T / T^3 := by
    exact div_le_div_of_nonneg_right hlog_le_T (le_of_lt hT3_pos)
  have h2 : T / T^3 = 1 / T^2 := by
    have hne : T ≠ 0 := ne_of_gt hT_pos
    field_simp
  rw [h2] at h1
  exact h1

/-- Asymptotic vanishing of `Real.log T / T^3` as `T → +∞`. -/
theorem tendsto_log_div_pow_three_atTop :
    Tendsto (fun T : ℝ => Real.log T / T^3) atTop (nhds 0) := by
  have hpow_inv : Tendsto (fun T : ℝ => 1 / T^2) atTop (nhds 0) := by
    have h2 : Tendsto (fun T : ℝ => T^2) atTop atTop := by
      exact tendsto_pow_atTop (by norm_num)
    have hinv := tendsto_inv_atTop_zero.comp h2
    simp only [Function.comp_def, one_div] at hinv ⊢
    exact hinv
  have h_squeeze : ∀ᶠ T : ℝ in atTop,
      0 ≤ Real.log T / T^3 ∧ Real.log T / T^3 ≤ 1 / T^2 := by
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with T hT
    have hlog_nonneg : 0 ≤ Real.log T := Real.log_nonneg hT
    have hT3_pos : 0 < T^3 := by positivity
    refine ⟨div_nonneg hlog_nonneg (le_of_lt hT3_pos), log_div_pow_three_le T hT⟩
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hpow_inv
    (by filter_upwards [h_squeeze] with T hT; exact hT.1)
    (by filter_upwards [h_squeeze] with T hT; exact hT.2)

/-- Asymptotic vanishing of the dyadic tail energy envelope:
`16 * C_IBP2^2 * C_dens * (Real.log T / T^3) → 0` as `T → +∞`. -/
theorem tendsto_tail_envelope_atTop (C_IBP2 C_dens : ℝ) :
    Tendsto (fun T : ℝ => 16 * C_IBP2^2 * C_dens * (Real.log T / T^3)) atTop (nhds 0) := by
  have h := tendsto_log_div_pow_three_atTop.const_mul (16 * C_IBP2^2 * C_dens)
  rwa [mul_zero] at h

/-- Certificate bundling the dyadic tail energy summation parameters. -/
structure DyadicTailEnergyCertificate where
  C_IBP2 : ℝ
  C_dens : ℝ
  C_tail_unit : ℝ
  hC_unit_eq : C_tail_unit = 16 * C_IBP2^2 * C_dens
  hC1 : 0 ≤ C_IBP2
  hC2 : 0 ≤ C_dens

/-- Canonical constructor for DyadicTailEnergyCertificate. -/
def makeDyadicTailCertificate
    (C_IBP2 C_dens : ℝ) (hC1 : 0 ≤ C_IBP2) (hC2 : 0 ≤ C_dens) :
    DyadicTailEnergyCertificate where
  C_IBP2 := C_IBP2
  C_dens := C_dens
  C_tail_unit := 16 * C_IBP2^2 * C_dens
  hC_unit_eq := rfl
  hC1 := hC1
  hC2 := hC2

end

end BuildingBlocks.ChirpedDyadicTailEnergy

#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.shell_energy_product_eq
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.nat_shell_index_le_three_pow_two
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.shell_index_le_three_pow_two
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.geometric_shell_factor_le_quarter
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.sum_quarter_pow_eq
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.sum_quarter_pow_le
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.sum_geometric_shell_factor_le_half
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.sum_geometric_shell_factor_le_one
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.finite_dyadic_tail_le_master
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.log_div_pow_three_le
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.tendsto_log_div_pow_three_atTop
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.tendsto_tail_envelope_atTop
#print axioms BuildingBlocks.ChirpedDyadicTailEnergy.makeDyadicTailCertificate
