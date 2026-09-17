import Mathlib.Tactic
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Data.Nat.Prime.Basic

namespace BuildingBlocks.ActualScatteringMomentSigns

open Finset
noncomputable section

/-- Literal finite-history Mellin multiplier at beta=h+1/2. -/
def positiveMultiplier (p : ℝ) (h M : ℕ) : ℝ :=
  -(p ^ h) + (1 - p⁻¹) * ∑ j ∈ range M, ((p ^ (h + 1))⁻¹) ^ j

/-- Literal finite-history Mellin multiplier at -beta. -/
def negativeMultiplier (p : ℝ) (h M : ℕ) : ℝ :=
  -((p ^ (h + 1))⁻¹) + (1 - p⁻¹) * ∑ j ∈ range M, (p ^ h) ^ j

theorem literal_multiplier_signs {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier p h M < 0 ∧ 0 < negativeMultiplier p h M := by
  have hp0 : 0 < p := by linarith
  have hp1 : 1 ≤ p := by linarith
  have hph : p ≤ p ^ h := by
    simpa using pow_le_pow_right₀ hp1 hh
  have hph1 : p ≤ p ^ (h + 1) := by
    simpa using pow_le_pow_right₀ hp1 (show 1 ≤ h + 1 by omega)
  have hpow0 : 0 < p ^ (h + 1) := pow_pos hp0 _
  have hinv : p⁻¹ ≤ (1 / 2 : ℝ) := by
    simpa using inv_anti₀ (show (0 : ℝ) < 2 by norm_num) hp
  have hu0 : 0 ≤ (p ^ (h + 1))⁻¹ := le_of_lt (inv_pos.mpr hpow0)
  have huinv : (p ^ (h + 1))⁻¹ ≤ p⁻¹ :=
    inv_anti₀ hp0 hph1
  have hpow4 : 4 ≤ p ^ (h + 1) := by
    have hs : 4 ≤ p ^ 2 := by nlinarith
    exact hs.trans (pow_le_pow_right₀ hp1 (show 2 ≤ h + 1 by omega))
  have huquarter : (p ^ (h + 1))⁻¹ ≤ (1 / 4 : ℝ) := by
    simpa using inv_anti₀ (show (0 : ℝ) < 4 by norm_num) hpow4
  have ha0 : 0 ≤ 1 - p⁻¹ := by linarith
  have hs0 : 0 ≤ ∑ j ∈ range M, ((p ^ (h + 1))⁻¹) ^ j :=
    sum_nonneg (fun j _ => pow_nonneg hu0 j)
  have hgeom := geom_sum_mul_neg ((p ^ (h + 1))⁻¹) M
  have hbudget : (1 - p⁻¹) * (∑ j ∈ range M, ((p ^ (h + 1))⁻¹) ^ j) ≤ 1 := by
    have hle := mul_le_mul_of_nonneg_right
      (show 1 - p⁻¹ ≤ 1 - (p ^ (h + 1))⁻¹ by linarith) hs0
    have hlast : 0 ≤ ((p ^ (h + 1))⁻¹) ^ M := pow_nonneg hu0 M
    nlinarith [hgeom]
  have hhead : 1 ≤ ∑ j ∈ range M, (p ^ h) ^ j := by
    have hz : 0 ∈ range M := mem_range.mpr (by omega)
    simpa using single_le_sum
      (fun j (_ : j ∈ range M) => pow_nonneg (pow_nonneg hp0.le h) j) hz
  have hbudgetLower := mul_le_mul_of_nonneg_left hhead ha0
  constructor
  · unfold positiveMultiplier
    linarith
  · unfold negativeMultiplier
    nlinarith

theorem actual_prime_multiplier_product_negative {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M < 0 := by
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp.two_le
  obtain ⟨hpos, hneg⟩ := literal_multiplier_signs hpR hh hM
  exact mul_neg_of_neg_of_pos hpos hneg

/-- Exact parity and positive magnitude for every complete finite prime block.
No separation, evenness, or favorable full-Weil sign is assumed here. -/
theorem actual_prime_block_product_parity (B : Finset ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ B, p.Prime)
    (hdepth : ∀ p ∈ B, 1 ≤ depth p) :
    let A := fun (p : ℕ) => positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p)
    (0 < ∏ p ∈ B, -A p) ∧
      (∏ p ∈ B, A p) = (-1 : ℝ) ^ B.card * ∏ p ∈ B, -A p := by
  dsimp only
  constructor
  · apply prod_pos
    intro p hp
    exact neg_pos.mpr
      (actual_prime_multiplier_product_negative (hprime p hp) hh (hdepth p hp))
  · simpa using Finset.prod_neg (s := B) (fun (p : ℕ) =>
      -(positiveMultiplier (p : ℝ) h (depth p) *
        negativeMultiplier (p : ℝ) h (depth p)))

#print axioms literal_multiplier_signs
#print axioms actual_prime_multiplier_product_negative
#print axioms actual_prime_block_product_parity

end
end BuildingBlocks.ActualScatteringMomentSigns
