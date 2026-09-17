import BuildingBlocks.GoldbachHeatBaseline
import Mathlib.Analysis.Normed.Group.FunctionSeries

/-! Actual finite-horizon heat energies and the fixed cost of changing from
the discrete density to the continuous density with its initial atom. -/

open MeasureTheory Real Set
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

theorem heatSeries_continuousOn_Ici {a : ℕ → ℝ}
    (ha : ∀ n, 1 ≤ n → |a n| ≤ n) {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn (fun t => ∑' n : ℕ, a (n + 1) *
      exp (-(((n + 1 : ℕ) : ℝ) * t))) (Ici ε) := by
  have hu := (summable_nat_add_iff 1).2 (summable_pow_mul_exp_neg_nat_mul 1 hε)
  simp only [pow_one] at hu
  apply continuousOn_tsum (fun n => by fun_prop) hu
  intro n t ht
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (exp_pos _)]
  calc
    _ ≤ ((n + 1 : ℕ) : ℝ) * exp (-(((n + 1 : ℕ) : ℝ) * t)) :=
      mul_le_mul_of_nonneg_right (ha _ (by omega)) (exp_nonneg _)
    _ ≤ ((n + 1 : ℕ) : ℝ) * exp (-ε * ((n + 1 : ℕ) : ℝ)) := by
      apply mul_le_mul_of_nonneg_left _ (by positivity)
      apply exp_le_exp.mpr
      have hn : 0 ≤ ((n + 1 : ℕ) : ℝ) := by positivity
      nlinarith [mul_le_mul_of_nonneg_left ht hn]

theorem centeredHeat_continuousOn_Ici {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn centeredHeat (Ici ε) :=
  heatSeries_continuousOn_Ici (fun _ hn => centeredCoefficient_abs_le hn) hε

theorem primeHeat_continuousOn_Ici {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn primeHeat (Ici ε) := by
  apply heatSeries_continuousOn_Ici _ hε
  intro n hn
  rw [abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
  have hn' : 0 < (n : ℝ) := by exact_mod_cast (by omega : 0 < n)
  exact (ArithmeticFunction.vonMangoldt_le_log.trans (log_le_sub_one_of_pos hn')).trans (by linarith)

theorem mixedCenteredHeat_continuousOn_Ici {ε : ℝ} (hε : 0 < ε) :
    ContinuousOn mixedCenteredHeat (Ici ε) := by
  unfold mixedCenteredHeat
  apply (primeHeat_continuousOn_Ici hε).sub
  apply ContinuousOn.mul
  · apply continuousOn_const.add
    exact continuousOn_const.div continuousOn_id (fun t ht => ne_of_gt (hε.trans_le ht))
  · fun_prop

theorem centeredHeat_square_integrableOn {ε : ℝ} (hε : 0 < ε) :
    IntegrableOn (fun t => centeredHeat t ^ 2) (Icc ε 1) :=
  ((centeredHeat_continuousOn_Ici hε).pow 2).mono Icc_subset_Ici_self |>.integrableOn_Icc

theorem mixedCenteredHeat_square_integrableOn {ε : ℝ} (hε : 0 < ε) :
    IntegrableOn (fun t => mixedCenteredHeat t ^ 2) (Icc ε 1) :=
  ((mixedCenteredHeat_continuousOn_Ici hε).pow 2).mono Icc_subset_Ici_self |>.integrableOn_Icc

noncomputable def horizonEnergy (f : ℝ → ℝ) (ε : ℝ) : ℝ :=
  ∫ t in Icc ε 1, f t ^ 2

theorem densityCorrection_horizon_le {ε : ℝ} (hε : 0 < ε) :
    horizonEnergy densityCorrection ε ≤ 1 / 2 := by
  apply le_trans _ densityCorrection_square_integral_le
  apply setIntegral_mono_set densityCorrection_square_integrable
    (Filter.Eventually.of_forall (fun t => sq_nonneg (densityCorrection t)))
  exact Filter.Eventually.of_forall (fun t ht => hε.trans_le ht.1)

/-- The exact two centerings have comparable energies with an absolute
additive cost, on every positive-time cutoff. -/
theorem mixed_energy_le_centered {ε : ℝ} (hε : 0 < ε) :
    horizonEnergy mixedCenteredHeat ε ≤ 2 * horizonEnergy centeredHeat ε + 1 := by
  have hd : IntegrableOn (fun t => densityCorrection t ^ 2) (Icc ε 1) :=
    densityCorrection_square_integrable.mono_set (fun t ht => hε.trans_le ht.1)
  have hi : horizonEnergy mixedCenteredHeat ε ≤
      2 * horizonEnergy centeredHeat ε + 2 * horizonEnergy densityCorrection ε := by
    unfold horizonEnergy
    rw [← integral_const_mul, ← integral_const_mul, ← integral_add
      ((centeredHeat_square_integrableOn hε).const_mul 2) (hd.const_mul 2)]
    apply integral_mono_ae (mixedCenteredHeat_square_integrableOn hε)
      (((centeredHeat_square_integrableOn hε).const_mul 2).add (hd.const_mul 2))
    filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
    have he := mixedCenteredHeat_sub_centered (hε.trans_le ht.1)
    simp only [Pi.add_apply] at *
    have hC : mixedCenteredHeat t = centeredHeat t + densityCorrection t := by linarith
    rw [hC]
    nlinarith [sq_nonneg (centeredHeat t - densityCorrection t)]
  linarith [densityCorrection_horizon_le hε]

theorem centered_energy_le_mixed {ε : ℝ} (hε : 0 < ε) :
    horizonEnergy centeredHeat ε ≤ 2 * horizonEnergy mixedCenteredHeat ε + 1 := by
  have hd : IntegrableOn (fun t => densityCorrection t ^ 2) (Icc ε 1) :=
    densityCorrection_square_integrable.mono_set (fun t ht => hε.trans_le ht.1)
  have hi : horizonEnergy centeredHeat ε ≤
      2 * horizonEnergy mixedCenteredHeat ε + 2 * horizonEnergy densityCorrection ε := by
    unfold horizonEnergy
    rw [← integral_const_mul, ← integral_const_mul, ← integral_add
      ((mixedCenteredHeat_square_integrableOn hε).const_mul 2) (hd.const_mul 2)]
    apply integral_mono_ae (centeredHeat_square_integrableOn hε)
      (((mixedCenteredHeat_square_integrableOn hε).const_mul 2).add (hd.const_mul 2))
    filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
    have he := mixedCenteredHeat_sub_centered (hε.trans_le ht.1)
    simp only [Pi.add_apply] at *
    have hA : centeredHeat t = mixedCenteredHeat t - densityCorrection t := by linarith
    rw [hA]
    nlinarith [sq_nonneg (mixedCenteredHeat t + densityCorrection t)]
  linarith [densityCorrection_horizon_le hε]

end BuildingBlocks.GoldbachHeat
