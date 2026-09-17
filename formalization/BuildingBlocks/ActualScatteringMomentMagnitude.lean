import BuildingBlocks.ActualScatteringMomentSigns

namespace BuildingBlocks.ActualScatteringMomentMagnitude

open Finset
open BuildingBlocks.ActualScatteringMomentSigns

theorem literal_multiplier_magnitude {p : ℝ} {h M : ℕ}
    (hp : 2 ≤ p) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    (p ^ h) ^ M / 8 ≤
        -(positiveMultiplier p h M * negativeMultiplier p h M) ∧
      -(positiveMultiplier p h M * negativeMultiplier p h M) ≤
        2 * (p ^ h) ^ M := by
  set R : ℝ := p ^ h
  set U : ℝ := (p ^ (h + 1))⁻¹
  set a : ℝ := 1 - p⁻¹
  set S : ℝ := ∑ j ∈ range M, R ^ j
  set T : ℝ := ∑ j ∈ range M, U ^ j
  have hp0 : 0 < p := by linarith
  have hp1 : 1 ≤ p := by linarith
  have hR2 : 2 ≤ R := by
    exact hp.trans (by simpa [R] using pow_le_pow_right₀ hp1 hh)
  have hR0 : 0 ≤ R := hR2.trans' (by norm_num)
  have hU0 : 0 ≤ U := by simp [U, hp0.le]
  have hp_inv : p⁻¹ ≤ (1 / 2 : ℝ) := by
    simpa using inv_anti₀ (show (0 : ℝ) < 2 by norm_num) hp
  have hpow4 : 4 ≤ p ^ (h + 1) := by
    have hs : 4 ≤ p ^ 2 := by nlinarith
    exact hs.trans (pow_le_pow_right₀ hp1 (show 2 ≤ h + 1 by omega))
  have hUquarter : U ≤ (1 / 4 : ℝ) := by
    simpa [U] using inv_anti₀ (show (0 : ℝ) < 4 by norm_num) hpow4
  have ha0 : 0 ≤ a := by dsimp [a]; linarith
  have ha1 : a ≤ 1 := by
    dsimp [a]
    have hi : 0 ≤ p⁻¹ := inv_nonneg.mpr hp0.le
    linarith
  have haHalf : (1 / 2 : ℝ) ≤ a := by dsimp [a]; linarith
  have hS0 : 0 ≤ S := by
    dsimp [S]
    exact sum_nonneg (fun j _ => pow_nonneg hR0 j)
  have hT0 : 0 ≤ T := by
    dsimp [T]
    exact sum_nonneg (fun j _ => pow_nonneg hU0 j)
  have hgeomT : T * (1 - U) = 1 - U ^ M := by
    dsimp [T]
    exact geom_sum_mul_neg U M
  have ha_le : a ≤ 1 - U := by
    dsimp [a, U]
    have hph1 : p ≤ p ^ (h + 1) := by
      simpa using pow_le_pow_right₀ hp1 (show 1 ≤ h + 1 by omega)
    have huinv : (p ^ (h + 1))⁻¹ ≤ p⁻¹ := inv_anti₀ hp0 hph1
    linarith
  have hTbudget : a * T ≤ 1 := by
    have hle := mul_le_mul_of_nonneg_right ha_le hT0
    have hlast : 0 ≤ U ^ M := pow_nonneg hU0 M
    nlinarith [hgeomT]
  have hXlo : R / 2 ≤ -positiveMultiplier p h M := by
    have : R / 2 ≤ R - 1 := by nlinarith
    dsimp [positiveMultiplier, R, U, a, T]
    linarith
  have hXhi : -positiveMultiplier p h M ≤ R := by
    dsimp [positiveMultiplier, R, U, a, T]
    nlinarith [mul_nonneg ha0 hT0]
  have hq1 : 1 ≤ R ^ (M - 1) := one_le_pow₀ (by linarith : 1 ≤ R)
  have hidx : M - 1 ∈ range M := mem_range.mpr (by omega)
  have hSlo : R ^ (M - 1) ≤ S := by
    dsimp [S]
    exact single_le_sum (fun j (_ : j ∈ range M) => pow_nonneg hR0 j) hidx
  have hgeomS : S * (R - 1) = R ^ M - 1 := by
    dsimp [S]
    exact geom_sum_mul R M
  have hpowSplit : R ^ M = R ^ (M - 1) * R := by
    conv_lhs => rw [show M = (M - 1) + 1 by omega, pow_succ]
  have hShi : S ≤ 2 * R ^ (M - 1) := by
    have hRm : R / 2 ≤ R - 1 := by nlinarith
    have hm := mul_le_mul_of_nonneg_left hRm hS0
    nlinarith [hgeomS]
  have hYlo : R ^ (M - 1) / 4 ≤ negativeMultiplier p h M := by
    have haq := mul_le_mul_of_nonneg_left hSlo ha0
    have huq : U ≤ U * R ^ (M - 1) := by nlinarith [mul_nonneg hU0 (sub_nonneg.mpr hq1)]
    dsimp [negativeMultiplier, R, U, a, S]
    nlinarith
  have hYhi : negativeMultiplier p h M ≤ 2 * R ^ (M - 1) := by
    have haS := mul_le_mul_of_nonneg_right ha1 hS0
    dsimp [negativeMultiplier, R, U, a, S]
    nlinarith
  have hlo := mul_le_mul hXlo hYlo
    (by positivity : 0 ≤ R ^ (M - 1) / 4)
    (by linarith [hXlo] : 0 ≤ -positiveMultiplier p h M)
  have hhi := mul_le_mul hXhi hYhi
    (by linarith [hYlo] : 0 ≤ negativeMultiplier p h M)
    (by linarith : 0 ≤ R)
  constructor
  · calc
      R ^ M / 8 = R / 2 * (R ^ (M - 1) / 4) := by rw [hpowSplit]; ring
      _ ≤ -positiveMultiplier p h M * negativeMultiplier p h M := hlo
      _ = -(positiveMultiplier p h M * negativeMultiplier p h M) := by ring
  · calc
      -(positiveMultiplier p h M * negativeMultiplier p h M) =
          -positiveMultiplier p h M * negativeMultiplier p h M := by ring
      _ ≤ R * (2 * R ^ (M - 1)) := hhi
      _ = 2 * R ^ M := by rw [hpowSplit]; ring

theorem actual_prime_multiplier_magnitude {p h M : ℕ}
    (hp : p.Prime) (hh : 1 ≤ h) (hM : 1 ≤ M) :
    ((p : ℝ) ^ (h * M)) / 8 ≤
        -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ∧
      -(positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M) ≤
        2 * (p : ℝ) ^ (h * M) := by
  have hpR : (2 : ℝ) ≤ p := by exact_mod_cast hp.two_le
  simpa only [pow_mul] using literal_multiplier_magnitude hpR hh hM

#print axioms literal_multiplier_magnitude
#print axioms actual_prime_multiplier_magnitude

end BuildingBlocks.ActualScatteringMomentMagnitude
