import BuildingBlocks.GoldbachCumulativeFinite
import Mathlib.Analysis.Normed.Ring.InfiniteSum
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Tactic

/-! Discrete Abel identity for the actual cumulative ordered Goldbach convolution. -/

namespace BuildingBlocks.GoldbachCumulativeAbel

open Finset Real BuildingBlocks.GoldbachHeat BuildingBlocks.GoldbachCumulativeFinite

noncomputable section

private theorem goldbach_weighted_abs_summable {q : ℝ} (hq : 0 < q) (hq1 : q < 1) :
    Summable (fun n : ℕ => |goldbachAt n * q ^ n|) := by
  have ht : 0 < -Real.log q := by
    have hlog := Real.log_neg hq hq1
    linarith
  have h := shiftedPrimeGoldbach_heat_abs_summable ht
  have hexp (k : ℕ) :
      Real.exp (-(((k + 2 : ℕ) : ℝ) * (-Real.log q))) = q ^ (k + 2) := by
    rw [show -(((k + 2 : ℕ) : ℝ) * (-Real.log q)) =
      ((k + 2 : ℕ) : ℝ) * Real.log q by ring]
    rw [Real.exp_nat_mul, Real.exp_log hq]
  have hshift : Summable (fun k : ℕ => |goldbachAt (k + 2) * q ^ (k + 2)|) := by
    simpa only [goldbachAt_shift, hexp] using h
  exact (summable_nat_add_iff (f := fun n : ℕ => |goldbachAt n * q ^ n|) 2).1 hshift

/-- Exact generating identity for the natural right-continuous cutoff.
Convergence follows from the actual complete prime-power heat series. -/
theorem cumulative_goldbach_abel {q : ℝ} (hq : 0 < q) (hq1 : q < 1) :
    (1 - q) * (∑' N : ℕ, cumulativeGoldbach N * q ^ N) =
      ∑' k : ℕ, goldbachAt k * q ^ k := by
  have hf : Summable (fun n : ℕ => ‖goldbachAt n * q ^ n‖) := by
    simpa only [Real.norm_eq_abs] using goldbach_weighted_abs_summable hq hq1
  have hg : Summable (fun n : ℕ => ‖q ^ n‖) := by
    simpa only [Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hq.le _)] using
      summable_geometric_of_lt_one hq.le hq1
  have hcoeff (n : ℕ) :
      (∑ k ∈ range (n + 1), (goldbachAt k * q ^ k) * q ^ (n - k)) =
        cumulativeGoldbach n * q ^ n := by
    calc
      _ = ∑ k ∈ range (n + 1), goldbachAt k * q ^ n := by
        apply sum_congr rfl
        intro k hk
        have hkn : k ≤ n := by have := mem_range.mp hk; omega
        rw [mul_assoc, ← pow_add, Nat.add_sub_of_le hkn]
      _ = _ := by rw [← sum_mul]; rfl
  have hcauchy := tsum_mul_tsum_eq_tsum_sum_range_of_summable_norm hf hg
  simp_rw [hcoeff] at hcauchy
  rw [tsum_geometric_of_lt_one hq.le hq1] at hcauchy
  have hne : 1 - q ≠ 0 := by linarith
  calc
    (1 - q) * (∑' N : ℕ, cumulativeGoldbach N * q ^ N) =
      (1 - q) * ((∑' k : ℕ, goldbachAt k * q ^ k) * (1 - q)⁻¹) := by
        rw [hcauchy]
    _ = _ := by field_simp

/-- The actual positive-time prime heat square is the discrete Abel
transform of the cumulative ordered Goldbach count. -/
theorem primeHeat_square_eq_cumulative_abel {t : ℝ} (ht : 0 < t) :
    (1 - Real.exp (-t)) *
      (∑' N : ℕ, cumulativeGoldbach N * Real.exp (-t) ^ N) =
        primeHeat t ^ 2 := by
  let q : ℝ := Real.exp (-t)
  have hq : 0 < q := Real.exp_pos _
  have hq1 : q < 1 := by
    dsimp [q]
    exact Real.exp_lt_one_iff.mpr (by linarith)
  have hf : Summable (fun n : ℕ => goldbachAt n * q ^ n) := by
    apply Summable.of_norm
    simpa only [Real.norm_eq_abs] using goldbach_weighted_abs_summable hq hq1
  have hshift := hf.sum_add_tsum_nat_add 2
  have hzero : (∑ n ∈ range 2, goldbachAt n * q ^ n) = 0 := by
    simp [sum_range_succ]
  rw [hzero, zero_add] at hshift
  have hexp (k : ℕ) : q ^ (k + 2) =
      Real.exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
    dsimp [q]
    rw [← Real.exp_nat_mul]
    congr 1
    ring
  calc
    (1 - Real.exp (-t)) *
        (∑' N : ℕ, cumulativeGoldbach N * Real.exp (-t) ^ N) =
      ∑' k : ℕ, goldbachAt k * q ^ k := cumulative_goldbach_abel hq hq1
    _ = ∑' k : ℕ, shiftedPrimeGoldbach k *
        Real.exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
          rw [← hshift]
          congr 1
          funext k
          rw [goldbachAt_shift, hexp]
    _ = primeHeat t ^ 2 := (primeHeat_square_eq_goldbach ht).symm

#print axioms primeHeat_square_eq_cumulative_abel
#print axioms cumulative_goldbach_abel

end
end BuildingBlocks.GoldbachCumulativeAbel
