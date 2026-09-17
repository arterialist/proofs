import BuildingBlocks.PrimeSeedMass

/-! The exact square integral of the complete single-prime successor seed.
This retains the literal floor definition and every prime-power interval.
-/

open MeasureTheory Real
open scoped Interval

namespace BuildingBlocks.PrimeSeedMass

private theorem integral_exp_sub (a b c : ℝ) :
    (∫ v in a..b, exp (v - c)) = exp (b - c) - exp (a - c) := by
  apply intervalIntegral.integral_eq_sub_of_hasDerivAt
  · intro v _
    simpa using ((hasDerivAt_id v).sub_const c).exp
  · exact (continuous_exp.comp (continuous_id.sub continuous_const)).intervalIntegrable _ _

theorem cell_square_integral (L : ℝ) (j : ℕ) :
    (∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L), cellDensity L j v ^ 2) =
      (1 - exp (-L)) * exp (-L) ^ (j + 2) := by
  have heq : (fun v => cellDensity L j v ^ 2) =
      (fun v => exp (v - 2 * (j + 2 : ℝ) * L)) := by
    funext v
    rw [cellDensity, ← exp_nat_mul]
    congr 1
    push_cast
    ring
  rw [heq, integral_exp_sub]
  have h₁ : (j + 2 : ℝ) * L - 2 * (j + 2 : ℝ) * L =
      (j + 2 : ℕ) * (-L) := by push_cast; ring
  have h₂ : (j + 1 : ℝ) * L - 2 * (j + 2 : ℝ) * L =
      (j + 3 : ℕ) * (-L) := by push_cast; ring
  rw [h₁, h₂, exp_nat_mul, exp_nat_mul,
    show j + 3 = (j + 2) + 1 by omega, pow_succ]
  ring

theorem hasSum_cell_square_integrals {L : ℝ} (hL : 0 < L) :
    HasSum (fun j : ℕ =>
      ∫ v in ((j + 1 : ℝ) * L)..((j + 2 : ℝ) * L), cellDensity L j v ^ 2)
      (exp (-L) ^ 2) := by
  let r := exp (-L)
  have hr0 : 0 < r := exp_pos _
  have hr1 : r < 1 := by dsimp [r]; exact exp_lt_one_iff.mpr (by linarith)
  have hs := (hasSum_geometric_of_lt_one hr0.le hr1).mul_left ((1 - r) * r ^ 2)
  convert hs using 1
  · funext j
    rw [cell_square_integral, pow_add]
    dsimp [r]
    ring
  · change r ^ 2 = (1 - r) * r ^ 2 * (1 - r)⁻¹
    field_simp [ne_of_gt (sub_pos.mpr hr1)]

/-- Exact squared mass, proved for the literal seed on the whole line. -/
theorem integrable_seed_square_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => seed L v ^ 2) ∧
      (∫ v, seed L v ^ 2) = exp (-L) ^ 2 := by
  have hab (j : ℕ) : (j + 1 : ℝ) * L ≤ (j + 2 : ℝ) * L := by linarith
  have heq (j : ℕ) : Set.EqOn (fun v => seed L v ^ 2)
      (fun v => cellDensity L j v ^ 2)
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) := by
    intro v hv
    dsimp only
    rw [seed_eq_cellDensity hL j hv]
  have hi (j : ℕ) : IntegrableOn (fun v => seed L v ^ 2)
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)) := by
    rw [integrableOn_congr_fun (heq j) measurableSet_Ico]
    apply (intervalIntegrable_iff_integrableOn_Ico_of_le (hab j)).1
    exact ((continuous_exp.comp
      ((continuous_id.div_const 2).sub continuous_const)).pow 2).intervalIntegrable _ _
  apply integral_of_clock_cells hL (fun v => sq_nonneg (seed L v))
    (fun v hv => by rw [seed_eq_zero hv]; norm_num) hi
  convert hasSum_cell_square_integrals hL using 1
  funext j
  rw [setIntegral_congr_fun measurableSet_Ico (heq j),
    ← integral_Icc_eq_integral_Ico, integral_Icc_eq_integral_Ioc,
    intervalIntegral.integral_of_le (hab j)]

theorem integral_prime_seed_square {p : ℝ} (hp : 1 < p) :
    (∫ v, seed (log p) v ^ 2) = 1 / p ^ 2 := by
  rw [(integrable_seed_square_and_integral (log_pos hp)).2, exp_neg,
    exp_log (by linarith : 0 < p)]
  simp [inv_pow, one_div]

end BuildingBlocks.PrimeSeedMass
