import BuildingBlocks.GoldbachCumulativeStieltjes
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.Tactic

namespace BuildingBlocks.GoldbachOneSidedHeatTransfer

open Set MeasureTheory Real BuildingBlocks.GoldbachCumulativeFinite

noncomputable section

/-- Strong all-cutoff upper hypothesis; the eventual variant needs a finite-initial-range adjustment. -/
theorem upper_heat_square {ε C t : ℝ} (hε : 0 < ε) (hε' : ε < 1 / 2)
    (ht : 0 < t)
    (hS : ∀ X : ℝ, 0 < X →
      cumulativeGoldbach ⌊X⌋₊ ≤ X ^ 2 / 2 + C * X ^ (3 / 2 + ε : ℝ)) :
    GoldbachHeat.primeHeat t ^ 2 ≤
      1 / t ^ 2 + C * Gamma (5 / 2 + ε) * t ^ (-(3 / 2 + ε : ℝ)) := by
  let p : ℝ := 3 / 2 + ε
  let f : ℝ → ℝ := fun X => exp (-t * X) * cumulativeGoldbach ⌊X⌋₊
  let g : ℝ → ℝ := fun X => (X ^ 2 * exp (-(t * X))) / 2 +
    C * (X ^ p * exp (-(t * X)))
  have hi2 : IntegrableOn (fun X : ℝ => X ^ 2 * exp (-(t * X))) (Ioi 0) := by
    simpa [rpow_natCast, rpow_one] using
      (integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := 2) (b := t)
        (by norm_num) (by norm_num) ht)
  have hip : IntegrableOn (fun X : ℝ => X ^ p * exp (-(t * X))) (Ioi 0) := by
    apply integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := p) (b := t)
      (by dsimp [p]; linarith) (by norm_num) ht |>.congr_fun ?_ measurableSet_Ioi
    intro X hX
    simp
  have hig : IntegrableOn g (Ioi 0) := by
    exact (hi2.div_const 2).add (hip.const_mul C)
  have hmono : (∫ X in Ioi (0 : ℝ), f X) ≤ ∫ X in Ioi (0 : ℝ), g X := by
    apply integral_mono_of_nonneg
    · exact Filter.Eventually.of_forall (fun X => mul_nonneg (exp_pos _).le (by
        unfold cumulativeGoldbach
        exact Finset.sum_nonneg (fun n _ => by
          unfold goldbachAt
          exact Finset.sum_nonneg (fun a _ => mul_nonneg
            ArithmeticFunction.vonMangoldt_nonneg ArithmeticFunction.vonMangoldt_nonneg))))
    · exact hig
    · filter_upwards [ae_restrict_mem measurableSet_Ioi] with X hX
      dsimp [f, g]
      have h := mul_le_mul_of_nonneg_left (hS X hX) (exp_nonneg (-(t * X)))
      dsimp [p] at *
      rw [show -t * X = -(t * X) by ring]
      convert h using 1 <;> ring
  have h2 : (∫ X in Ioi (0 : ℝ), X ^ 2 * exp (-(t * X))) =
      (1 / t) ^ (3 : ℝ) * Gamma 3 := by
    simpa [show (3 : ℝ) - 1 = 2 by norm_num, rpow_natCast, rpow_one,
      Gamma_nat_eq_factorial, one_div, inv_pow] using
      (integral_rpow_mul_exp_neg_mul_Ioi (a := 3) (r := t)
        (by norm_num) ht)
  have hp : (∫ X in Ioi (0 : ℝ), X ^ p * exp (-(t * X))) =
      (1 / t) ^ (p + 1) * Gamma (p + 1) := by
    simpa [rpow_one] using
      (integral_rpow_mul_exp_neg_mul_Ioi (a := p + 1) (r := t)
        (by dsimp [p]; linarith) ht)
  have hG3 : Gamma (3 : ℝ) = 2 := by
    simpa using Gamma_nat_eq_factorial 2
  rw [← GoldbachCumulativeStieltjes.cumulative_stieltjes_heat_square ht]
  have htm := mul_le_mul_of_nonneg_left hmono ht.le
  rw [MeasureTheory.integral_add (hi2.div_const 2) (hip.const_mul C),
    MeasureTheory.integral_div, MeasureTheory.integral_const_mul, h2, hp, hG3] at htm
  have hbase : t * ((1 / t) ^ (3 : ℝ) * 2 / 2) = 1 / t ^ 2 := by
    rw [show (1 / t) ^ (3 : ℝ) = (1 / t) ^ (3 : ℕ) by norm_num]
    field_simp
  have hpow : t * (1 / t) ^ (p + 1) = t ^ (-p) := by
    rw [Real.rpow_add (one_div_pos.mpr ht), Real.rpow_one]
    rw [one_div, Real.inv_rpow (by positivity), ← Real.rpow_neg (le_of_lt ht)]
    field_simp
  dsimp only [f] at htm
  calc
    t * (∫ X in Ioi (0 : ℝ), exp (-t * X) * cumulativeGoldbach ⌊X⌋₊) ≤
        t * ((1 / t) ^ (3 : ℝ) * 2 / 2 +
          C * ((1 / t) ^ (p + 1) * Gamma (p + 1))) := htm
    _ = 1 / t ^ 2 + C * Gamma (p + 1) * t ^ (-p) := by
      rw [mul_add, hbase]
      congr 1
      calc
        t * (C * ((1 / t) ^ (p + 1) * Gamma (p + 1))) =
            C * Gamma (p + 1) * (t * (1 / t) ^ (p + 1)) := by ring
        _ = _ := by rw [hpow]
    _ = _ := by dsimp [p]; ring

/-- All-cutoff upper cumulative estimate gives an upper prime-heat estimate. -/
theorem upper_primeHeat {ε C t : ℝ} (hε : 0 < ε) (hε' : ε < 1 / 2)
    (hC : 0 ≤ C) (ht : 0 < t)
    (hS : ∀ X : ℝ, 0 < X →
      cumulativeGoldbach ⌊X⌋₊ ≤ X ^ 2 / 2 + C * X ^ (3 / 2 + ε : ℝ)) :
    GoldbachHeat.primeHeat t ≤
      1 / t + (C * Gamma (5 / 2 + ε)) * t ^ (-(1 / 2 + ε : ℝ)) := by
  let p : ℝ := 3 / 2 + ε
  let A : ℝ := 1 / t
  let M : ℝ := C * Gamma (p + 1) * t ^ (-p)
  have hsq : GoldbachHeat.primeHeat t ^ 2 ≤ A ^ 2 + M := by
    convert upper_heat_square hε hε' ht hS using 1 <;> dsimp [A, M, p] <;> ring_nf
  have hM : 0 ≤ M := by
    dsimp [M]
    positivity
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hAt : A * t = 1 := by dsimp [A]; field_simp
  have hH : 0 ≤ A + M * t := add_nonneg hA (mul_nonneg hM ht.le)
  have hHsq : A ^ 2 + M ≤ (A + M * t) ^ 2 := by
    have he : (A + M * t) ^ 2 = A ^ 2 + 2 * M + (M * t) ^ 2 := by
      calc
        (A + M * t) ^ 2 = A ^ 2 + 2 * (A * t) * M + (M * t) ^ 2 := by ring
        _ = _ := by rw [hAt]; ring
    rw [he]
    nlinarith [sq_nonneg (M * t)]
  have hh := le_of_sq_le_sq (hsq.trans hHsq) hH
  have htp : t ^ (-p) * t = t ^ (-(1 / 2 + ε : ℝ)) := by
    calc
      t ^ (-p) * t = t ^ (-p) * t ^ (1 : ℝ) := by rw [Real.rpow_one]
      _ = t ^ (-p + 1) := (Real.rpow_add ht (-p) 1).symm
      _ = t ^ (-(1 / 2 + ε : ℝ)) := by congr 1; dsimp [p]; ring
  calc
    GoldbachHeat.primeHeat t ≤ A + M * t := hh
    _ = 1 / t + C * Gamma (p + 1) * (t ^ (-p) * t) := by dsimp [A, M]; ring
    _ = 1 / t + (C * Gamma (5 / 2 + ε)) * t ^ (-(1 / 2 + ε : ℝ)) := by
      rw [htp]
      dsimp [p]
      ring

#print axioms upper_heat_square
#print axioms upper_primeHeat

end
end BuildingBlocks.GoldbachOneSidedHeatTransfer
