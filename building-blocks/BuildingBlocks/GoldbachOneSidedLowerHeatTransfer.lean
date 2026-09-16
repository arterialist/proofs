import BuildingBlocks.GoldbachCumulativeStieltjes
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.Tactic

namespace BuildingBlocks.GoldbachOneSidedLowerHeatTransfer

open Set MeasureTheory Real BuildingBlocks.GoldbachCumulativeFinite

noncomputable section

private theorem primeHeat_pos {t : ℝ} (ht : 0 < t) :
    0 < GoldbachHeat.primeHeat t := by
  unfold GoldbachHeat.primeHeat
  apply (GoldbachHeat.primeHeat_summable ht).tsum_pos
    (fun n => mul_nonneg ArithmeticFunction.vonMangoldt_nonneg (exp_pos _).le) 1
  norm_num [ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two,
    Real.log_pos_iff] <;> positivity

private theorem cumulative_integrable {t : ℝ} (ht : 0 < t) :
    IntegrableOn (fun X : ℝ => exp (-t * X) * cumulativeGoldbach ⌊X⌋₊) (Ioi 0) := by
  by_contra hn
  have hzero : (∫ X in Ioi (0 : ℝ), exp (-t * X) * cumulativeGoldbach ⌊X⌋₊) = 0 :=
    integral_undef hn
  have hident := GoldbachCumulativeStieltjes.cumulative_stieltjes_heat_square ht
  rw [hzero, mul_zero] at hident
  nlinarith [primeHeat_pos ht]

/-- The all-cutoff lower estimate for the actual cumulative Goldbach step count
transfers to a lower estimate for the square of the positive prime heat sum. -/
theorem lower_heat_square {ε C t : ℝ} (hε : 0 < ε) (hε' : ε < 1 / 2)
    (ht : 0 < t)
    (hS : ∀ X : ℝ, 0 < X →
      X ^ 2 / 2 - C * X ^ (3 / 2 + ε : ℝ) ≤ cumulativeGoldbach ⌊X⌋₊) :
    1 / t ^ 2 - C * Gamma (5 / 2 + ε) * t ^ (-(3 / 2 + ε : ℝ)) ≤
      GoldbachHeat.primeHeat t ^ 2 := by
  let p : ℝ := 3 / 2 + ε
  let f : ℝ → ℝ := fun X => exp (-t * X) * cumulativeGoldbach ⌊X⌋₊
  let g : ℝ → ℝ := fun X => (X ^ 2 * exp (-(t * X))) / 2 -
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
  have hig : IntegrableOn g (Ioi 0) := (hi2.div_const 2).sub (hip.const_mul C)
  have hif : IntegrableOn f (Ioi 0) := cumulative_integrable ht
  have hmono : (∫ X in Ioi (0 : ℝ), g X) ≤ ∫ X in Ioi (0 : ℝ), f X := by
    apply integral_mono_ae hig hif
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with X hX
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
  have hG3 : Gamma (3 : ℝ) = 2 := by simpa using Gamma_nat_eq_factorial 2
  rw [← GoldbachCumulativeStieltjes.cumulative_stieltjes_heat_square ht]
  have htm := mul_le_mul_of_nonneg_left hmono ht.le
  rw [MeasureTheory.integral_sub (hi2.div_const 2) (hip.const_mul C),
    MeasureTheory.integral_div, MeasureTheory.integral_const_mul, h2, hp, hG3] at htm
  have hbase : t * ((1 / t) ^ (3 : ℝ) * 2 / 2) = 1 / t ^ 2 := by
    rw [show (1 / t) ^ (3 : ℝ) = (1 / t) ^ (3 : ℕ) by norm_num]
    field_simp
  have hpow : t * (1 / t) ^ (p + 1) = t ^ (-p) := by
    rw [Real.rpow_add (one_div_pos.mpr ht), Real.rpow_one]
    rw [one_div, Real.inv_rpow (by positivity), ← Real.rpow_neg (le_of_lt ht)]
    field_simp
  have hterm : t * (C * ((1 / t) ^ (p + 1) * Gamma (p + 1))) =
      C * Gamma (p + 1) * t ^ (-p) := by
    calc
      _ = C * Gamma (p + 1) * (t * (1 / t) ^ (p + 1)) := by ring
      _ = _ := by rw [hpow]
  dsimp only [f] at htm
  calc
    1 / t ^ 2 - C * Gamma (5 / 2 + ε) * t ^ (-(3 / 2 + ε : ℝ)) =
        t * ((1 / t) ^ (3 : ℝ) * 2 / 2 -
          C * ((1 / t) ^ (p + 1) * Gamma (p + 1))) := by
      rw [mul_sub, hbase, hterm]
      dsimp [p]
      ring
    _ ≤ t * (∫ X in Ioi (0 : ℝ), exp (-t * X) * cumulativeGoldbach ⌊X⌋₊) := htm

#print axioms lower_heat_square

/-- A lower prime-heat estimate when the integrated error is small enough
that the linear lower bound remains nonnegative. -/
theorem lower_primeHeat {ε C t : ℝ} (hε : 0 < ε) (hε' : ε < 1 / 2)
    (hC : 0 ≤ C) (ht : 0 < t)
    (hS : ∀ X : ℝ, 0 < X →
      X ^ 2 / 2 - C * X ^ (3 / 2 + ε : ℝ) ≤ cumulativeGoldbach ⌊X⌋₊)
    (hsmall : C * Gamma (5 / 2 + ε) * t ^ (1 / 2 - ε : ℝ) ≤ 1) :
    1 / t - (C * Gamma (5 / 2 + ε)) * t ^ (-(1 / 2 + ε : ℝ)) ≤
      GoldbachHeat.primeHeat t := by
  let p : ℝ := 3 / 2 + ε
  let A : ℝ := 1 / t
  let M : ℝ := C * Gamma (p + 1) * t ^ (-p)
  have hsq : A ^ 2 - M ≤ GoldbachHeat.primeHeat t ^ 2 := by
    convert lower_heat_square hε hε' ht hS using 1 <;> dsimp [A, M, p] <;> ring_nf
  have hM : 0 ≤ M := by dsimp [M]; positivity
  have hAt : A * t = 1 := by dsimp [A]; field_simp
  have htp2 : t ^ (-p) * t ^ 2 = t ^ (1 / 2 - ε : ℝ) := by
    calc
      t ^ (-p) * t ^ 2 = t ^ (-p + 2) := by
        rw [← Real.rpow_natCast t 2]
        exact (Real.rpow_add ht (-p) 2).symm
      _ = t ^ (1 / 2 - ε : ℝ) := by congr 1; dsimp [p]; ring
  have hMt : M * t ^ 2 ≤ 1 := by
    calc
      M * t ^ 2 = C * Gamma (p + 1) * (t ^ (-p) * t ^ 2) := by dsimp [M]; ring
      _ = C * Gamma (5 / 2 + ε) * t ^ (1 / 2 - ε : ℝ) := by
        rw [htp2]
        congr 1
        dsimp [p]
        ring
      _ ≤ 1 := hsmall
  have hAleft : 0 ≤ A - M * t := by
    by_contra hn
    have hneg : A - M * t < 0 := lt_of_not_ge hn
    have hnegprod := mul_neg_of_neg_of_pos hneg ht
    nlinarith [hAt, hMt]
  have hHsq : (A - M * t) ^ 2 ≤ A ^ 2 - M := by
    have he : (A - M * t) ^ 2 = A ^ 2 - 2 * M + M * (M * t ^ 2) := by
      calc
        (A - M * t) ^ 2 = A ^ 2 - 2 * (A * t) * M + M * (M * t ^ 2) := by ring
        _ = _ := by rw [hAt]; ring
    rw [he]
    have hh := mul_le_mul_of_nonneg_left hMt hM
    nlinarith
  have hh : A - M * t ≤ GoldbachHeat.primeHeat t :=
    le_of_sq_le_sq (hHsq.trans hsq) (primeHeat_pos ht).le
  have htp : t ^ (-p) * t = t ^ (-(1 / 2 + ε : ℝ)) := by
    calc
      t ^ (-p) * t = t ^ (-p) * t ^ (1 : ℝ) := by rw [Real.rpow_one]
      _ = t ^ (-p + 1) := (Real.rpow_add ht (-p) 1).symm
      _ = t ^ (-(1 / 2 + ε : ℝ)) := by congr 1; dsimp [p]; ring
  have hterm : M * t = (C * Gamma (5 / 2 + ε)) * t ^ (-(1 / 2 + ε : ℝ)) := by
    calc
      M * t = C * Gamma (p + 1) * (t ^ (-p) * t) := by dsimp [M]; ring
      _ = _ := by rw [htp]; dsimp [p]; ring
  calc
    1 / t - (C * Gamma (5 / 2 + ε)) * t ^ (-(1 / 2 + ε : ℝ)) =
        A - M * t := by
      rw [hterm]
    _ ≤ GoldbachHeat.primeHeat t := hh

#print axioms lower_primeHeat

end
end BuildingBlocks.GoldbachOneSidedLowerHeatTransfer
