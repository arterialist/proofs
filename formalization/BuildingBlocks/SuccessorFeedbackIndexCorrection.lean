import BuildingBlocks.SuccessorFeedbackPowerDifference
import Mathlib.Analysis.PSeries

/-! The holomorphic correction between the two literal driver index conventions.
No change from the Abel clock to a different clock is made here. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def indexCorrectionTerm (j : ℕ) (z : ℂ) : ℂ :=
  (driver (j + 1) : ℂ) *
    ((((j + 2 : ℕ) : ℂ) ^ (-z)) - (((j + 1 : ℕ) : ℂ) ^ (-z)))

noncomputable def indexCorrection (z : ℂ) : ℂ :=
  (driver 0 : ℂ) + ∑' j : ℕ, indexCorrectionTerm j z

theorem indexCorrectionTerm_differentiable (j : ℕ) :
    Differentiable ℂ (indexCorrectionTerm j) := by
  apply Differentiable.const_mul
  exact (differentiable_id.neg.const_cpow (Or.inl (by exact_mod_cast (show j + 2 ≠ 0 by omega)))).sub
    (differentiable_id.neg.const_cpow (Or.inl (by exact_mod_cast (Nat.succ_ne_zero j))))

private theorem shifted_driver_growth {ε : ℝ} (hε : 0 < ε) (hε' : ε ≤ 1 / 2) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ j : ℕ,
      |driver (j + 1)| ≤ C * (j + 1 : ℝ) ^ (-(1 / 2 : ℝ) + ε) := by
  obtain ⟨C, hC⟩ := driverCoefficient_power_bound hε
  refine ⟨max C 0, le_max_right _ _, ?_⟩
  intro j
  have h := hC (j + 2) (by omega)
  simp only [driverCoefficient, show j + 2 ≠ 0 by omega, if_false,
    show j + 2 - 1 = j + 1 by omega, Complex.norm_real, Real.norm_eq_abs, Nat.cast_add,
    Nat.cast_ofNat] at h
  have hp : (j + 2 : ℝ) ^ (-(1 / 2 : ℝ) + ε) ≤
      (j + 1 : ℝ) ^ (-(1 / 2 : ℝ) + ε) :=
    rpow_le_rpow_of_nonpos (by positivity) (by linarith) (by linarith)
  exact h.trans ((mul_le_mul_of_nonneg_right (le_max_left C 0) (by positivity)).trans
    (mul_le_mul_of_nonneg_left hp (le_max_right C 0)))

/-- Every bounded parameter set strictly to the right of `Re z = -1/2`
has a summable majorant for the literal index correction. -/
theorem indexCorrection_uniform_majorant {α M : ℝ} (hα : -(1 / 2 : ℝ) < α)
    (hM : 0 ≤ M) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ j z, α ≤ z.re → ‖z‖ ≤ M →
      ‖indexCorrectionTerm j z‖ ≤ u j := by
  let ε : ℝ := min (1 / 4) ((α + 1 / 2) / 2)
  have hε : 0 < ε := lt_min (by norm_num) (by linarith)
  have hε' : ε ≤ 1 / 2 := (min_le_left _ _).trans (by norm_num)
  have heα : ε < α + 1 / 2 := (min_le_right _ _).trans_lt (by linarith)
  obtain ⟨C, hC, hc⟩ := shifted_driver_growth hε hε'
  let q : ℝ := ε - α - 3 / 2
  have hq : q < -1 := by dsimp [q]; linarith
  refine ⟨fun j => (C * M) * (j + 1 : ℝ) ^ q, ?_, ?_⟩
  · have hs := (summable_nat_rpow.mpr hq).comp_injective Nat.succ_injective
    have hs' : Summable (fun j : ℕ => (j + 1 : ℝ) ^ q) := by
      simpa only [Function.comp_def, Nat.cast_add, Nat.cast_one, Nat.cast_succ] using hs
    exact hs'.mul_left (C * M)
  · intro j z hz hzM
    have hj : (1 : ℝ) ≤ j + 1 := by have := Nat.cast_nonneg (α := ℝ) j; linarith
    have hj0 : (0 : ℝ) < j + 1 := lt_of_lt_of_le (by norm_num) hj
    have hd := negativePower_difference_bound (by linarith : -1 ≤ z.re) hj0
      (show (j + 1 : ℝ) ≤ j + 2 by linarith)
    have he : ‖(((j + 2 : ℕ) : ℂ) ^ (-z)) - (((j + 1 : ℕ) : ℂ) ^ (-z))‖ ≤
        M * (j + 1 : ℝ) ^ (-α - 1) := by
      simp only [Complex.ofReal_add, Complex.ofReal_natCast, Complex.ofReal_one,
        Complex.ofReal_ofNat] at hd
      have hb : ‖(((j + 2 : ℕ) : ℂ) ^ (-z)) - (((j + 1 : ℕ) : ℂ) ^ (-z))‖ ≤
          ‖z‖ * (j + 1 : ℝ) ^ (-z.re - 1) := by
        simpa only [Nat.cast_add, Nat.cast_ofNat, Nat.cast_one, show (j + 2 : ℝ) - (j + 1) = 1 by ring,
          mul_one] using hd
      exact hb.trans (mul_le_mul hzM
        (rpow_le_rpow_of_exponent_le hj (by linarith)) (by positivity) hM)
    rw [indexCorrectionTerm, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    calc
      _ ≤ (C * (j + 1 : ℝ) ^ (-(1 / 2 : ℝ) + ε)) *
          (M * (j + 1 : ℝ) ^ (-α - 1)) :=
        mul_le_mul (hc j) he (norm_nonneg _) (by positivity)
      _ = _ := by
        calc
          _ = (C * M) * ((j + 1 : ℝ) ^ (-(1 / 2 : ℝ) + ε) *
              (j + 1 : ℝ) ^ (-α - 1)) := by ring
          _ = _ := by rw [← rpow_add hj0]; congr 2; dsimp [q]; ring

theorem indexCorrection_summable {z : ℂ} (hz : -(1 / 2 : ℝ) < z.re) :
    Summable (fun j => indexCorrectionTerm j z) := by
  obtain ⟨u, hu, hb⟩ := indexCorrection_uniform_majorant hz (norm_nonneg z)
  exact Summable.of_norm_bounded hu (fun j => hb j z le_rfl le_rfl)

/-- The literal index correction is holomorphic on the larger half-plane. -/
theorem indexCorrection_differentiableAt {z : ℂ} (hz : -(1 / 2 : ℝ) < z.re) :
    DifferentiableAt ℂ indexCorrection z := by
  let α : ℝ := (z.re - 1 / 2) / 2
  let M : ℝ := ‖z‖ + 1
  have hα : -(1 / 2 : ℝ) < α := by dsimp [α]; linarith
  have hαz : α < z.re := by dsimp [α]; linarith
  have hM : 0 ≤ M := by dsimp [M]; positivity
  obtain ⟨u, hu, hb⟩ := indexCorrection_uniform_majorant hα hM
  let U : Set ℂ := {w | α < w.re ∧ ‖w‖ < M}
  have hU : IsOpen U :=
    (isOpen_lt continuous_const Complex.continuous_re).inter
      (isOpen_lt continuous_norm continuous_const)
  have hzU : z ∈ U := ⟨hαz, by dsimp [M]; linarith⟩
  have hd := Complex.differentiableOn_tsum_of_summable_norm hu
    (fun j => (indexCorrectionTerm_differentiable j).differentiableOn (s := U))
    hU (fun j w hw => hb j w hw.1.le hw.2.le)
  exact (differentiableAt_const (driver 0 : ℂ)).add (hd.differentiableAt (hU.mem_nhds hzU))

theorem indexCorrection_analyticOnNhd :
    AnalyticOnNhd ℂ indexCorrection {z : ℂ | -(1 / 2 : ℝ) < z.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  exact fun z hz => (indexCorrection_differentiableAt hz).differentiableWithinAt

noncomputable def unshiftedDirichlet (z : ℂ) : ℂ :=
  ∑' j : ℕ, (driver (j + 1) : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z

theorem indexCorrectionTerm_eq (j : ℕ) (z : ℂ) :
    indexCorrectionTerm j z =
      (driver (j + 1) : ℂ) / ((j + 2 : ℕ) : ℂ) ^ z -
        (driver (j + 1) : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z := by
  simp only [indexCorrectionTerm, Complex.cpow_neg, mul_sub, div_eq_mul_inv]

private theorem shifted_tail_summable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    Summable (fun j : ℕ => (driver (j + 1) : ℂ) / ((j + 2 : ℕ) : ℂ) ^ z) := by
  have h := (driver_dirichlet_summable hz).comp_injective Nat.succ_injective
  simpa [Function.comp_def, Nat.succ_eq_add_one, Nat.cast_add, Nat.cast_one, Nat.cast_ofNat,
    add_assoc, show (1 : ℂ) + 1 = 2 by norm_num] using h

theorem unshiftedDirichlet_summable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    Summable (fun j : ℕ => (driver (j + 1) : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z) := by
  have h := (shifted_tail_summable hz).sub (indexCorrection_summable (z := z) (by linarith))
  apply h.congr
  intro j
  rw [indexCorrectionTerm_eq]
  ring

/-- Exact initial-domain equality: the zero driver and both index conventions
are preserved before the correction is continued holomorphically. -/
theorem indexCorrection_eq_difference {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    indexCorrection z = dirichletTransform z - unshiftedDirichlet z := by
  have he := (driver_dirichlet_summable hz).tsum_eq_zero_add
  have hD : dirichletTransform z = (driver 0 : ℂ) +
      ∑' j : ℕ, (driver (j + 1) : ℂ) / ((j + 2 : ℕ) : ℂ) ^ z := by
    rw [dirichletTransform_eq_series hz]
    simpa [Nat.add_assoc] using he
  rw [indexCorrection, hD, unshiftedDirichlet]
  have hs : (∑' j : ℕ, indexCorrectionTerm j z) =
      (∑' j : ℕ, (driver (j + 1) : ℂ) / ((j + 2 : ℕ) : ℂ) ^ z) -
        ∑' j : ℕ, (driver (j + 1) : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z := by
    simp_rw [indexCorrectionTerm_eq]
    exact (shifted_tail_summable hz).tsum_sub (unshiftedDirichlet_summable hz)
  rw [hs]
  ring

end BuildingBlocks.SuccessorFeedback
