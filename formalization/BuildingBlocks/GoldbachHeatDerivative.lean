import BuildingBlocks.GoldbachHeatLocalEnergy
import Mathlib.Analysis.Calculus.SmoothSeries

open Real Set
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

noncomputable def primeHeatDerivativeTerm (n : ℕ) (t : ℝ) : ℝ :=
  -((n + 1 : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt (n + 1) *
    exp (-(((n + 1 : ℕ) : ℝ) * t))

noncomputable def primeHeatDerivative (t : ℝ) : ℝ := ∑' n, primeHeatDerivativeTerm n t

theorem primeHeatTerm_hasDerivAt (n : ℕ) (t : ℝ) :
    HasDerivAt (fun y => ArithmeticFunction.vonMangoldt (n + 1) *
      exp (-(((n + 1 : ℕ) : ℝ) * y))) (primeHeatDerivativeTerm n t) t := by
  convert (((hasDerivAt_id t).const_mul (-((n + 1 : ℕ) : ℝ))).exp).const_mul
      (ArithmeticFunction.vonMangoldt (n + 1)) using 1
  · simp only [id_eq, neg_mul]
  · unfold primeHeatDerivativeTerm
    simp only [id_eq, neg_mul, mul_one]
    ring

theorem primeHeatDerivativeTerm_bound (n : ℕ) (ε t : ℝ) (ht : ε ≤ t) :
    ‖primeHeatDerivativeTerm n t‖ ≤ ((n + 1 : ℕ) : ℝ) ^ 2 *
      exp (-ε * ((n + 1 : ℕ) : ℝ)) := by
  have hn : 0 ≤ ((n + 1 : ℕ) : ℝ) := by positivity
  have hl : ArithmeticFunction.vonMangoldt (n + 1) ≤ ((n + 1 : ℕ) : ℝ) := by
    have hp : 0 < ((n + 1 : ℕ) : ℝ) := by positivity
    exact ArithmeticFunction.vonMangoldt_le_log.trans
      ((log_le_sub_one_of_pos hp).trans (by linarith))
  unfold primeHeatDerivativeTerm
  simp only [norm_mul, Real.norm_eq_abs, abs_neg, abs_of_nonneg hn,
    abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg, abs_of_pos (exp_pos _)]
  calc
    _ ≤ ((n + 1 : ℕ) : ℝ) ^ 2 * exp (-(((n + 1 : ℕ) : ℝ) * t)) := by
      nlinarith [mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left hl hn) (exp_nonneg (-(((n + 1 : ℕ) : ℝ) * t)))]
    _ ≤ _ := mul_le_mul_of_nonneg_left
      (exp_le_exp.mpr (by nlinarith)) (sq_nonneg _)

theorem primeHeatDerivative_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun n => primeHeatDerivativeTerm n t) := by
  have hu := (summable_nat_add_iff 1).2 (summable_pow_mul_exp_neg_nat_mul 2 ht)
  exact hu.of_norm_bounded (fun n => primeHeatDerivativeTerm_bound n t t le_rfl)

theorem primeHeatDerivative_continuousOn_Ici {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn primeHeatDerivative (Ici ε) := by
  have hu := (summable_nat_add_iff 1).2 (summable_pow_mul_exp_neg_nat_mul 2 hε)
  unfold primeHeatDerivative
  apply continuousOn_tsum (fun n => by unfold primeHeatDerivativeTerm; fun_prop) hu
  intro n t ht
  exact primeHeatDerivativeTerm_bound n ε t ht

theorem primeHeat_hasDerivAt {t : ℝ} (ht : 0 < t) :
    HasDerivAt primeHeat (primeHeatDerivative t) t := by
  have he : 0 < t / 2 := by linarith
  have hu := (summable_nat_add_iff 1).2 (summable_pow_mul_exp_neg_nat_mul 2 he)
  exact hasDerivAt_tsum_of_isPreconnected hu isOpen_Ioi (convex_Ioi (t / 2)).isPreconnected
    (fun n y _ => primeHeatTerm_hasDerivAt n y)
    (fun n y hy => primeHeatDerivativeTerm_bound n (t / 2) y hy.le)
    (by change t / 2 < t; linarith : t ∈ Ioi (t / 2)) (primeHeat_summable ht)
    (by change t / 2 < t; linarith : t ∈ Ioi (t / 2))

#print axioms primeHeatTerm_hasDerivAt
#print axioms primeHeatDerivativeTerm_bound
#print axioms primeHeatDerivative_summable
#print axioms primeHeatDerivative_continuousOn_Ici
#print axioms primeHeat_hasDerivAt

noncomputable def mixedCenteredHeatDerivative (t : ℝ) : ℝ :=
  primeHeatDerivative t + (1 / t ^ 2 + (1 + 1 / t)) * exp (-t)

theorem mixedCenteredHeat_hasDerivAt {t : ℝ} (ht : 0 < t) :
    HasDerivAt mixedCenteredHeat (mixedCenteredHeatDerivative t) t := by
  have hi := (hasDerivAt_const t (1 : ℝ)).div (hasDerivAt_id t) (ne_of_gt ht)
  have hb := ((hasDerivAt_const t (1 : ℝ)).add hi).mul (hasDerivAt_id t).neg.exp
  convert (primeHeat_hasDerivAt ht).sub hb using 1
  unfold mixedCenteredHeatDerivative
  simp only [id_eq, Pi.add_apply, Pi.div_apply, Pi.neg_apply]
  ring

theorem mixedCenteredHeatDerivative_continuousOn_Ici {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn mixedCenteredHeatDerivative (Ici ε) := by
  unfold mixedCenteredHeatDerivative
  apply (primeHeatDerivative_continuousOn_Ici hε).add
  apply ContinuousOn.mul
  · apply ContinuousOn.add
    · exact continuousOn_const.div (continuousOn_id.pow 2)
        (fun t ht => pow_ne_zero 2 (ne_of_gt (hε.trans_le ht)))
    · exact continuousOn_const.add (continuousOn_const.div continuousOn_id
        (fun t ht => ne_of_gt (hε.trans_le ht)))
  · fun_prop

#print axioms mixedCenteredHeat_hasDerivAt
#print axioms mixedCenteredHeatDerivative_continuousOn_Ici

end BuildingBlocks.GoldbachHeat
