import BuildingBlocks.GoldbachHeatLocalEnergy
import Mathlib.Analysis.Complex.ExponentialBounds

open Real Filter Set
open scoped BigOperators Topology

namespace BuildingBlocks.GoldbachHeat

/-- A complete geometric majorant for the actual prime-power heat series. -/
theorem primeHeat_geometric_le {t : ℝ} (ht : 0 < t) :
    primeHeat t ≤ exp (-t) ^ 2 / (1 - exp (-t)) ^ 2 := by
  have hq : ‖exp (-t)‖ < 1 := by
    rw [Real.norm_eq_abs, abs_of_pos (exp_pos _)]
    exact exp_lt_one_iff.mpr (by linarith)
  have hs := (hasSum_coe_mul_geometric_of_norm_lt_one hq).mul_right (exp (-t))
  have he (n : ℕ) : exp (-(((n + 1 : ℕ) : ℝ) * t)) = exp (-t) ^ (n + 1) := by
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  have hh : HasSum (fun n : ℕ => (n : ℝ) * exp (-(((n + 1 : ℕ) : ℝ) * t)))
      (exp (-t) ^ 2 / (1 - exp (-t)) ^ 2) := by
    convert hs using 1
    · funext n
      rw [he, pow_succ]
      ring
    · ring
  unfold primeHeat
  calc
    _ ≤ ∑' n : ℕ, (n : ℝ) * exp (-(((n + 1 : ℕ) : ℝ) * t)) := by
      apply Summable.tsum_le_tsum _ (primeHeat_summable ht) hh.summable
      intro n
      apply mul_le_mul_of_nonneg_right _ (exp_nonneg _)
      have hp : 0 < ((n + 1 : ℕ) : ℝ) := by positivity
      have hl := (ArithmeticFunction.vonMangoldt_le_log (n := n + 1)).trans
        (log_le_sub_one_of_pos hp)
      push_cast at hl
      linarith
    _ = _ := hh.tsum_eq

theorem mixedCenteredHeat_one_negative : mixedCenteredHeat 1 < 0 := by
  have hp := exp_pos (-1 : ℝ)
  have he : 2 < exp (1 : ℝ) := by linarith [Real.exp_one_gt_d9]
  have hq : exp (-1 : ℝ) < 1 / 2 := by
    rw [exp_neg]
    simpa only [one_div] using one_div_lt_one_div_of_lt (by norm_num : (0 : ℝ) < 2) he
  have hd : 0 < (1 - exp (-1 : ℝ)) ^ 2 := sq_pos_of_pos (by linarith)
  have hbound := primeHeat_geometric_le (t := 1) (by norm_num)
  have hstrict : exp (-1 : ℝ) ^ 2 / (1 - exp (-1 : ℝ)) ^ 2 < 2 * exp (-1 : ℝ) := by
    apply (div_lt_iff₀ hd).mpr
    nlinarith [mul_pos hp (show 1 - 2 * exp (-1 : ℝ) > 0 by linarith),
      mul_pos hp (show 2 - exp (-1 : ℝ) > 0 by linarith)]
  unfold mixedCenteredHeat
  norm_num only [one_div_one]
  linarith

/-- Literal logarithmic-time profile of the mixed atom-and-density centered heat source. -/
noncomputable def criticalHeatProfile (v : ℝ) : ℝ :=
  exp (-v / 2) * mixedCenteredHeat (exp (-v))

theorem criticalHeatProfile_zero_negative : criticalHeatProfile 0 < 0 := by
  simpa [criticalHeatProfile] using mixedCenteredHeat_one_negative

theorem criticalHeatProfile_continuousAt_zero : ContinuousAt criticalHeatProfile 0 := by
  have hc : ContinuousAt mixedCenteredHeat 1 :=
    (mixedCenteredHeat_continuousOn_Ici (ε := 1 / 2) (by norm_num)).continuousAt
      (Ici_mem_nhds (by norm_num : (1 / 2 : ℝ) < 1))
  have hc' : ContinuousAt mixedCenteredHeat (exp (-(0 : ℝ))) := by
    simpa only [neg_zero, exp_zero] using hc
  have hi : ContinuousAt (fun v : ℝ => exp (-v)) 0 := continuousAt_id.neg.rexp
  have ho : ContinuousAt (fun v : ℝ => exp (-v / 2)) 0 :=
    (continuousAt_id.neg.div_const 2).rexp
  have hh : ContinuousAt (fun v : ℝ => mixedCenteredHeat (exp (-v))) 0 :=
    ContinuousAt.comp (f := fun v : ℝ => exp (-v)) (g := mixedCenteredHeat) hc' hi
  change ContinuousAt (fun v : ℝ => exp (-v / 2) * mixedCenteredHeat (exp (-v))) 0
  exact ho.mul hh

theorem criticalHeatProfile_eventually_negative :
    ∀ᶠ v in 𝓝 (0 : ℝ), criticalHeatProfile v < 0 :=
  criticalHeatProfile_continuousAt_zero.tendsto.eventually_lt_const
    criticalHeatProfile_zero_negative

#print axioms criticalHeatProfile_continuousAt_zero
#print axioms criticalHeatProfile_eventually_negative

#print axioms primeHeat_geometric_le
#print axioms mixedCenteredHeat_one_negative
#print axioms criticalHeatProfile_zero_negative

end BuildingBlocks.GoldbachHeat
