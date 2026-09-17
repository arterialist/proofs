import BuildingBlocks.PhysicalThetaJumpEnergy
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.Tactic.Linarith

namespace BuildingBlocks.PhysicalKillingPositivity
open MeasureTheory Real
open scoped ENNReal ArithmeticFunction.vonMangoldt
open BuildingBlocks.PhysicalThetaSeries BuildingBlocks.PhysicalThetaUniform
open BuildingBlocks.PhysicalThetaParity BuildingBlocks.PhysicalThetaJumpEnergy

theorem crossing_interval {R a u : ℝ} (hR : 0 < R) (ha : 0 < a)
    (hu : u ∈ Set.Ioo (-R - a) (-R - a + min R a / 2)) :
    R < |u| ∧ |u + a| < R := by
  have hdR := min_le_left R a
  have hda := min_le_right R a
  have h1 : u < -R := by linarith [hu.2]
  have h2 : -R < u + a := by linarith [hu.1]
  have h3 : u + a < R := by linarith [hu.2]
  exact ⟨by rw [abs_of_neg (by linarith)]; linarith, abs_lt.mpr ⟨h2, h3⟩⟩

theorem constant_killed_edge_positive {R a c : ℝ} (hR : 0 < R) (ha : 0 < a) (hc : c ≠ 0) :
    0 < edgeMass (killedExtension R (fun _ => c)) a := by
  let k := killedExtension R (fun _ => c)
  let F : ℝ → ℝ≥0∞ := fun u => ENNReal.ofReal
    (phi (u + a) * phi u * (k (u + a) - k u) ^ 2)
  have hk : Measurable k := by
    exact Measurable.ite (measurableSet_lt measurable_const continuous_abs.measurable)
      measurable_const measurable_const
  have hF : Measurable F := by
    have hs : Measurable (fun u : ℝ => u + a) := measurable_id.add_const a
    exact (((phi_continuous.measurable.comp hs).mul phi_continuous.measurable).mul
      (((hk.comp hs).sub hk).pow_const 2)).ennreal_ofReal
  have hsub : Set.Ioo (-R - a) (-R - a + min R a / 2) ⊆ Function.support F := by
    intro u hu
    obtain ⟨hstart, hend⟩ := crossing_interval hR ha hu
    have hp : 0 < phi (u + a) * phi u * c ^ 2 :=
      mul_pos (mul_pos (phi_positive _) (phi_positive _)) (sq_pos_of_ne_zero hc)
    have he : F u = ENNReal.ofReal (phi (u + a) * phi u * c ^ 2) := by
      simp [F, k, killedExtension, hstart, not_lt.mpr hend.le]
    change F u ≠ 0
    rw [he]
    exact ne_of_gt (ENNReal.ofReal_pos.mpr hp)
  have hvol : 0 < volume (Set.Ioo (-R - a) (-R - a + min R a / 2)) := by
    rw [Real.volume_Ioo]
    apply ENNReal.ofReal_pos.mpr
    have hd : 0 < min R a := lt_min hR ha
    linarith
  exact (lintegral_pos_iff_support hF).mpr (lt_of_lt_of_le hvol (measure_mono hsub))

theorem constant_killed_energy_positive {R c : ℝ} (hR : 0 < R) (hc : c ≠ 0) :
    0 < killedEnergy R (fun _ => c) := by
  have ha : 0 < log (2 : ℝ) := log_pos (by norm_num)
  have he := constant_killed_edge_positive hR ha hc
  have hcoeff : 0 < ENNReal.ofReal (Λ 2 / sqrt (2 : ℝ)) := by
    apply ENNReal.ofReal_pos.mpr
    rw [ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    exact div_pos ha (sqrt_pos.mpr (by norm_num))
  have hp : 0 < primeEnergy (killedExtension R (fun _ => c)) :=
    lt_of_lt_of_le (ENNReal.mul_pos hcoeff.ne' he.ne') (ENNReal.le_tsum (⟨2, by norm_num⟩ : {n : ℕ // 2 ≤ n}))
  exact lt_of_lt_of_le hp (le_add_left le_rfl)

#print axioms crossing_interval
#print axioms constant_killed_edge_positive
#print axioms constant_killed_energy_positive
end BuildingBlocks.PhysicalKillingPositivity
