import BuildingBlocks.PrimeSeedJumps
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts

/-! Weak differentiation of the complete floor-defined prime seed, retaining
the birth and every signed proper-power atom. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.PrimeSeedMass

theorem cellDensity_hasDerivAt (L : ℝ) (j : ℕ) (v : ℝ) :
    HasDerivAt (cellDensity L j) (cellDensity L j v / 2) v := by
  unfold cellDensity
  convert (((hasDerivAt_id v).div_const 2).sub_const ((j + 2 : ℝ) * L)).exp using 1 <;> simp <;> ring

theorem seed_cell_weak_derivative {L : ℝ} (hL : 0 < L) (j : ℕ)
    {φ φ' : ℝ → ℝ} (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ') :
    (∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L),
      seed L v * (φ' v + φ v / 2)) =
      exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) -
        exp (-((j + 3 : ℝ) * L) / 2) * φ ((j + 1 : ℝ) * L) := by
  have hcont : Continuous φ := continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)
  have hd : Continuous (cellDensity L j) := by unfold cellDensity; fun_prop
  have hb := intervalIntegral.integral_deriv_mul_eq_sub
    (a := (j + 1 : ℝ) * L) (b := (j + 2 : ℝ) * L)
    (fun v _ => cellDensity_hasDerivAt L j v) (fun v _ => hφ v)
    ((hd.div_const 2).intervalIntegrable _ _) (hc.intervalIntegrable _ _)
  have he (v : ℝ) : cellDensity L j v / 2 * φ v + cellDensity L j v * φ' v =
      cellDensity L j v * (φ' v + φ v / 2) := by ring
  simp_rw [he] at hb
  have hi : (∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L),
      seed L v * (φ' v + φ v / 2)) =
      ∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L),
        cellDensity L j v * (φ' v + φ v / 2) := by
    apply setIntegral_congr_fun measurableSet_Ico
    intro v hv
    dsimp only
    rw [seed_eq_cellDensity hL j hv]
  rw [hi]
  rw [← integral_Icc_eq_integral_Ico, integral_Icc_eq_integral_Ioc,
    ← intervalIntegral.integral_of_le (by nlinarith), hb]
  congr 2 <;> unfold cellDensity <;> congr 1 <;> ring

theorem seed_test_product_integrable {L : ℝ} (hL : 0 < L) {φ : ℝ → ℝ}
    (hm : AEStronglyMeasurable φ volume) (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    Integrable (fun v => seed L v * φ v) := by
  have hi := (integrable_seed_and_integral hL).1.bdd_mul hm
    (by simpa only [Real.norm_eq_abs] using hb)
  simpa only [mul_comm] using hi

theorem summable_weighted_clock {L : ℝ} (hL : 0 < L) (a : ℝ) {φ : ℝ → ℝ}
    (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    Summable (fun j : ℕ => exp (-((j + a : ℝ) * L) / 2) * φ ((j + 1 : ℝ) * L)) := by
  obtain ⟨M, hM⟩ := hb
  have hr0 : 0 ≤ exp (-L / 2) := (exp_pos _).le
  have hr1 : exp (-L / 2) < 1 := exp_lt_one_iff.2 (by linarith)
  have hs := ((hasSum_geometric_of_lt_one hr0 hr1).summable.mul_left (exp (-a * L / 2))).mul_right M
  apply hs.of_norm_bounded
  intro j
  rw [Real.norm_eq_abs, abs_mul, abs_of_pos (exp_pos _)]
  have he : exp (-((j + a : ℝ) * L) / 2) = exp (-a * L / 2) * exp (-L / 2) ^ j := by
    rw [← exp_nat_mul, ← exp_add]
    congr 1
    ring
  rw [← he]
  exact mul_le_mul_of_nonneg_left (hM _) (exp_pos _).le

theorem seed_weak_derivative {L : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, seed L v * φ' v) = -(1 / 2) * (∫ v, seed L v * φ v) -
      exp (-3 * L / 2) * φ L +
        ∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) := by
  have hcont : Continuous φ := continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)
  have hiφ := seed_test_product_integrable hL hcont.aestronglyMeasurable hb
  have hiφ' := seed_test_product_integrable hL hc.aestronglyMeasurable hb'
  let f : ℝ → ℝ := fun v => seed L v * (φ' v + φ v / 2)
  have hif : Integrable f := by
    have hi := hiφ'.add (hiφ.div_const 2)
    apply hi.congr
    exact Eventually.of_forall (fun v => by dsimp [f]; ring)
  have hs := hasSum_integral_iUnion (f := f) (fun _ : ℕ => measurableSet_Ico)
    (pairwiseDisjoint_cells hL) hif.integrableOn
  rw [iUnion_cells hL] at hs
  have hfull : (∫ v in Ici L, f v) = ∫ v, f v := by
    apply setIntegral_eq_integral_of_forall_compl_eq_zero
    intro v hv
    dsimp [f]
    rw [seed_eq_zero (lt_of_not_ge hv), zero_mul]
  rw [hfull] at hs
  let A : ℕ → ℝ := fun j => exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L)
  let B : ℕ → ℝ := fun j => exp (-((j + 3 : ℝ) * L) / 2) * φ ((j + 1 : ℝ) * L)
  have hB : Summable B := summable_weighted_clock hL 3 hb
  have hA : Summable A := by
    have hh : ∃ M, ∀ v, |φ (v + L)| ≤ M := by
      obtain ⟨M, hM⟩ := hb
      exact ⟨M, fun v => hM (v + L)⟩
    convert summable_weighted_clock hL 2 hh using 1
    funext j
    dsimp [A]
    congr 2
    ring
  have hshift : Summable (fun j : ℕ => B (j + 1)) :=
    hB.comp_injective (fun _ _ h => Nat.add_right_cancel h)
  have he (j : ℕ) : A j - B (j + 1) =
      (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) := by
    dsimp [A, B]
    push_cast
    rw [show -((j + 1 + 3 : ℝ) * L) / 2 = -L + -((j + 2 : ℝ) * L) / 2 by ring,
      exp_add]
    have hh : (j + 1 + 1 : ℝ) * L = (j + 2 : ℝ) * L := by ring
    rw [hh]
    ring
  have hsum : (∫ v, f v) = (∑' j : ℕ, (A j - B (j + 1))) - B 0 := by
    have hcj (j : ℕ) : (∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L), f v) = A j - B j :=
      seed_cell_weak_derivative hL j hφ hc
    simp_rw [hcj] at hs
    rw [← hs.tsum_eq, hA.tsum_sub hB, hA.tsum_sub hshift, hB.tsum_eq_zero_add]
    ring
  have hfint : (∫ v, f v) = (∫ v, seed L v * φ' v) + (∫ v, seed L v * φ v) / 2 := by
    have heq (v : ℝ) : f v = seed L v * φ' v + (seed L v * φ v) / 2 := by dsimp [f]; ring
    simp_rw [heq]
    rw [integral_add hiφ' (hiφ.div_const 2), integral_div]
  rw [hfint] at hsum
  simp_rw [he] at hsum
  have hB0 : B 0 = exp (-3 * L / 2) * φ L := by simp [B]
  rw [hB0] at hsum
  linarith

/-- An order-zero bound for the literal weak derivative, with the exact
continuous-plus-atomic variation budget. -/
theorem seed_weak_derivative_bound {L M : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∀ v, |φ v| ≤ M) (hb' : ∃ M', ∀ v, |φ' v| ≤ M') :
    |∫ v, seed L v * φ' v| ≤ (2 * exp (-L) + 2 * exp (-3 * L / 2)) * M := by
  have hM : 0 ≤ M := (abs_nonneg (φ 0)).trans (hb 0)
  have hcont : Continuous φ := continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)
  have hi := seed_test_product_integrable hL hcont.aestronglyMeasurable ⟨M, hb⟩
  have hnorm : |∫ v, seed L v * φ v| ≤ 2 * exp (-L) * M := by
    calc
      _ ≤ ∫ v, |seed L v * φ v| := by
        simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun v => seed L v * φ v)
      _ ≤ ∫ v, seed L v * M := integral_mono hi.norm ((integrable_seed_and_integral hL).1.mul_const M)
        (fun v => by simpa only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (seed_nonneg L v)] using
          mul_le_mul_of_nonneg_left (hb v) (seed_nonneg L v))
      _ = _ := by rw [integral_mul_const, (integrable_seed_and_integral hL).2]
  have hpos (j : ℕ) : 0 ≤ (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) := by
    have he : exp (-L) < 1 := exp_lt_one_iff.2 (neg_neg_of_pos hL)
    exact mul_nonneg (sub_nonneg.2 he.le) (exp_pos _).le
  have hjump : |∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L)| ≤
      (exp (-L) + exp (-3 * L / 2)) * M := by
    rw [← Real.norm_eq_abs]
    apply tsum_of_norm_bounded ((hasSum_seed_negative_jumps hL).mul_right M)
    intro j
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hpos j)]
    exact mul_le_mul_of_nonneg_left (hb _) (hpos j)
  rw [seed_weak_derivative hL hφ hc ⟨M, hb⟩ hb']
  have ht := (abs_add_le
    (-(1 / 2) * (∫ v, seed L v * φ v) - exp (-3 * L / 2) * φ L)
    (∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L)))
  have hs := abs_sub (-(1 / 2) * (∫ v, seed L v * φ v)) (exp (-3 * L / 2) * φ L)
  simp only [abs_mul, abs_neg, abs_div, abs_one, abs_of_pos (by norm_num : (0 : ℝ) < 2), abs_of_pos (exp_pos _)] at hs
  have hbirth := mul_le_mul_of_nonneg_left (hb L) (exp_pos (-3 * L / 2)).le
  nlinarith

end BuildingBlocks.PrimeSeedMass
