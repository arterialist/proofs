import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
Literal ordinary integer-cell pairing and fixed long-Gaussian contour algebra.
Infinite floor/Mellin identities, functional reflection, Gaussian interchange,
contour deformation and the saddle remainder remain written analysis.
The coefficient transfers below have explicit Bernoulli-integral premises;
this file does not assert those premises for the actual zeta function.
-/

namespace BuildingBlocks.LongGaussianSourceAlgebra

/-- Zero-endpoint periodic primitive; it is minus the normalized B2 difference. -/
noncomputable def periodicPrimitive (t : ℝ) : ℝ :=
  Int.fract t * (1 - Int.fract t) / 2

theorem periodicPrimitive_bounds (t : ℝ) :
    0 ≤ periodicPrimitive t ∧ periodicPrimitive t ≤ 1 / 8 := by
  have ht0 := Int.fract_nonneg t
  have ht1 := Int.fract_lt_one t
  dsimp [periodicPrimitive]
  constructor
  · exact div_nonneg (mul_nonneg ht0 (by linarith)) (by norm_num)
  · nlinarith [sq_nonneg (Int.fract t - 1 / 2)]

theorem periodicPrimitive_int (n : ℤ) : periodicPrimitive (n : ℝ) = 0 := by
  simp [periodicPrimitive]

theorem periodicPrimitive_nat (n : ℕ) : periodicPrimitive (n : ℝ) = 0 := by
  simp [periodicPrimitive]

theorem fract_nat_clock (n : ℕ) {t : ℝ} (ht : 0 ≤ t) (htop : t ≤ 1 / 2) :
    Int.fract ((n : ℝ) + t) = t := by
  rw [Int.fract_natCast_add]
  exact Int.fract_eq_self.mpr ⟨ht, by linarith⟩

theorem unit_clock_weight_antitone {n : ℕ} {sigma t : ℝ}
    (hn : 1 ≤ n) (hsigma : 0 < sigma) (ht : 0 ≤ t) (htop : t ≤ 1 / 2) :
    Real.rpow ((n : ℝ) + 1 - t) (-sigma - 1) ≤
      Real.rpow ((n : ℝ) + t) (-sigma - 1) := by
  have hnreal : (1 : ℝ) ≤ n := by exact_mod_cast hn
  exact Real.rpow_le_rpow_of_nonpos (by linarith) (by linarith) (by linarith)

/-- The endpoint `t=0` uses the actual fractional part at the next integer. -/
theorem unit_clock_centered_pairing {n : ℕ} {sigma t : ℝ}
    (hn : 1 ≤ n) (hsigma : 0 < sigma) (ht : 0 ≤ t) (htop : t ≤ 1 / 2) :
    (Int.fract ((n : ℝ) + t) - 1 / 2) *
        Real.rpow ((n : ℝ) + t) (-sigma - 1) +
      (Int.fract ((n : ℝ) + 1 - t) - 1 / 2) *
        Real.rpow ((n : ℝ) + 1 - t) (-sigma - 1) ≤ 0 := by
  by_cases hz : t = 0
  · subst t
    simp only [add_zero, sub_zero, Int.fract_add_one, Int.fract_natCast]
    have hw1 : 0 ≤ Real.rpow (n : ℝ) (-sigma - 1) :=
      Real.rpow_nonneg (Nat.cast_nonneg n) _
    have hw2 : 0 ≤ Real.rpow ((n : ℝ) + 1) (-sigma - 1) :=
      Real.rpow_nonneg (by positivity) _
    nlinarith
  have htpos : 0 < t := lt_of_le_of_ne ht (Ne.symm hz)
  have hleft := fract_nat_clock n ht htop
  have hright : Int.fract ((n : ℝ) + 1 - t) = 1 - t := by
    rw [show (n : ℝ) + 1 - t = (n : ℝ) + (1 - t) by ring,
      Int.fract_natCast_add]
    exact Int.fract_eq_self.mpr ⟨by linarith, by linarith⟩
  rw [hleft, hright]
  have hw := unit_clock_weight_antitone hn hsigma ht htop
  have hh : 0 ≤ 1 / 2 - t := by linarith
  nlinarith [mul_le_mul_of_nonneg_left hw hh]

theorem low_band_gap {sigma t : ℝ} (hsigma : 1 / 2 ≤ sigma) (ht : |t| ≤ 6 / 7) :
    (3 : ℝ) / 196 ≤ 4 * sigma ^ 2 - ((sigma - 1) ^ 2 + t ^ 2) := by
  obtain ⟨htlo, hthi⟩ := abs_le.mp ht
  have hprod : 0 ≤ (6 / 7 + t) * (6 / 7 - t) :=
    mul_nonneg (by linarith) (by linarith)
  nlinarith [sq_nonneg (sigma - 1 / 2)]

noncomputable def realExponent (sigma : ℝ) : ℝ := sigma + (3 / 2) * (sigma - 3 / 2) ^ 2

theorem complex_saddle (L t : ℝ) :
    (((7 / 6 : ℝ) : ℂ) + (t : ℂ) * Complex.I) * (L : ℂ) +
      (3 / 2 : ℂ) * (L : ℂ) *
        ((((7 / 6 : ℝ) : ℂ) + (t : ℂ) * Complex.I) - 3 / 2) ^ 2 =
      ((4 / 3 * L - 3 / 2 * L * t ^ 2 : ℝ) : ℂ) := by
  apply Complex.ext <;>
    simp [pow_two, Complex.mul_re, Complex.mul_im] <;> ring

theorem left_exponent : realExponent (7 / 6) = (4 : ℝ) / 3 := by
  norm_num [realExponent]

theorem high_exponent : realExponent 2 - (3 / 2) * (6 / 7) ^ 2 = (499 : ℝ) / 392 := by
  norm_num [realExponent]

theorem exponent_gap : (4 : ℝ) / 3 - 499 / 392 = 71 / 1176 := by norm_num

theorem right_line_correction {L : ℝ} (hL : L ≠ 0) :
    L * realExponent (2 + 1 / L) = (19 / 8) * L + 5 / 2 + 3 / (2 * L) := by
  dsimp [realExponent]
  field_simp
  ring

/-- Finite transfer from the explicitly supplied actual analytic corner inputs. -/
theorem half_coefficient_from_Bernoulli_inputs {J Jprime z zprime : ℝ}
    (hJ0 : 0 ≤ J) (hJ1 : J ≤ 1 / 8) (hJprime : Jprime ≤ 1 / 12)
    (hz : z = -3 / 2 + (1 / 2) * J)
    (hzprime : zprime = -4 + J + (1 / 2) * Jprime) :
    (23 : ℝ) / 9 ≤ zprime / z ∧
      (784 : ℝ) / 243 ≤ (4 / 3) * (zprime / z - 1) ^ 2 := by
  have hzlo : -(3 : ℝ) / 2 ≤ z := by linarith
  have hzneg : z < 0 := by linarith
  have hzphi : zprime ≤ -(23 : ℝ) / 6 := by linarith
  have hq : (23 : ℝ) / 9 ≤ zprime / z := by
    apply (le_div_iff_of_neg hzneg).mpr
    nlinarith
  exact ⟨hq, by nlinarith [sq_nonneg (zprime / z - 23 / 9)]⟩

theorem sixth_quotient_from_Bernoulli_inputs {J Jprime z zprime : ℝ}
    (hJ0 : 0 ≤ J) (hJ1 : J ≤ 1 / 8) (hJprime : Jprime ≤ 3 / 28)
    (hz : z = -7 / 10 + (1 / 6) * J)
    (hzprime : zprime = -36 / 25 + J + (1 / 6) * Jprime) :
    (454 : ℝ) / 245 ≤ zprime / z := by
  have hzlo : -(7 : ℝ) / 10 ≤ z := by linarith
  have hzneg : z < 0 := by linarith
  have hzphi : zprime ≤ -(227 : ℝ) / 175 := by linarith
  apply (le_div_iff_of_neg hzneg).mpr
  nlinarith

theorem two_thirds_from_Bernoulli_inputs {J z : ℝ}
    (hJ1 : J ≤ 1 / 8) (hz : z = -5 / 2 + (2 / 3) * J) :
    z ≤ -(29 : ℝ) / 12 := by linarith

theorem saddle_coefficient_negative {q z : ℝ}
    (hq : (454 : ℝ) / 245 ≤ q) (hz : z ≤ -(29 : ℝ) / 12) :
    z / ((7 / 6) * (1 / 6)) * (q - 1 / 5) ^ 2 ≤ -(570807 : ℝ) / 16807 := by
  have hsquare : (81 / 49 : ℝ) ^ 2 ≤ (q - 1 / 5) ^ 2 := by
    nlinarith [sq_nonneg (q - 454 / 245)]
  have hratio : z / ((7 / 6) * (1 / 6)) ≤
      (-(29 : ℝ) / 12) / ((7 / 6) * (1 / 6)) :=
    div_le_div_of_nonneg_right hz (by norm_num)
  calc
    _ ≤ ((-(29 : ℝ) / 12) / ((7 / 6) * (1 / 6))) * (q - 1 / 5) ^ 2 :=
      mul_le_mul_of_nonneg_right hratio (sq_nonneg _)
    _ ≤ ((-(29 : ℝ) / 12) / ((7 / 6) * (1 / 6))) * (81 / 49) ^ 2 :=
      mul_le_mul_of_nonpos_left hsquare (by norm_num)
    _ = _ := by norm_num

#print axioms periodicPrimitive_bounds
#print axioms periodicPrimitive_int
#print axioms periodicPrimitive_nat
#print axioms fract_nat_clock
#print axioms unit_clock_weight_antitone
#print axioms unit_clock_centered_pairing
#print axioms low_band_gap
#print axioms complex_saddle
#print axioms left_exponent
#print axioms high_exponent
#print axioms exponent_gap
#print axioms right_line_correction
#print axioms half_coefficient_from_Bernoulli_inputs
#print axioms sixth_quotient_from_Bernoulli_inputs
#print axioms two_thirds_from_Bernoulli_inputs
#print axioms saddle_coefficient_negative

end BuildingBlocks.LongGaussianSourceAlgebra
