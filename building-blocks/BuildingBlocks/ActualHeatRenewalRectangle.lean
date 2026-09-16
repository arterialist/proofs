import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import Mathlib.Tactic

/-! A finite right-endpoint rectangle estimate used in the renewal-cell audit.
The infinite tail and the special heat profile are separate analytic questions. -/

namespace BuildingBlocks.ActualHeatRenewalRectangle

open Set intervalIntegral Finset MeasureTheory

noncomputable section

private theorem cell_bound (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    {a b : ℝ} (hab : a ≤ b) :
    |(b - a) * G b - ∫ t in a..b, G t| ≤
      (b - a) * ∫ t in a..b, |deriv G t| := by
  have hc : Continuous G := hG.continuous
  have hd : Continuous (deriv G) := hG.continuous_deriv_one
  have hgi : IntervalIntegrable G volume a b := hc.intervalIntegrable a b
  have hdi : IntervalIntegrable (fun t => |deriv G t|) volume a b :=
    hd.abs.intervalIntegrable a b
  have hsubi : IntervalIntegrable (fun t => G b - G t) volume a b :=
    (continuous_const.sub hc).intervalIntegrable a b
  have habs : IntervalIntegrable (fun t => |G b - G t|) volume a b :=
    (continuous_const.sub hc).abs.intervalIntegrable a b
  have hnonneg : ∀ t, 0 ≤ |deriv G t| := fun t => abs_nonneg _
  have hpoint (t : ℝ) (ht : t ∈ Icc a b) :
      |G b - G t| ≤ ∫ u in a..b, |deriv G u| := by
    have hftc : ∫ u in t..b, deriv G u = G b - G t :=
      integral_deriv_eq_sub (fun x hx => hG.differentiable (by norm_num) x)
        (hd.intervalIntegrable _ _)
    have hnorm : |G b - G t| ≤ ∫ u in t..b, |deriv G u| := by
      rw [← hftc]
      exact abs_integral_le_integral_abs ht.2
    exact hnorm.trans <| integral_mono_interval ht.1 ht.2 le_rfl
      (Filter.Eventually.of_forall (fun _ => hnonneg _)) hdi
  have hmono : (∫ t in a..b, |G b - G t|) ≤
      ∫ _t in a..b, (∫ u in a..b, |deriv G u|) :=
    integral_mono_on hab habs (intervalIntegrable_const) hpoint
  have hconst : (∫ _t in a..b, (∫ u in a..b, |deriv G u|)) =
      (b - a) * ∫ u in a..b, |deriv G u| := by simp [intervalIntegral.integral_const]
  have hrewrite : (b - a) * G b - ∫ t in a..b, G t =
      ∫ t in a..b, (G b - G t) := by
    rw [integral_sub (intervalIntegrable_const) hgi]
    simp [intervalIntegral.integral_const]
  rw [hrewrite]
  exact (abs_integral_le_integral_abs hab).trans (hmono.trans_eq hconst)

/-- For a positive mesh `δ`, the right-endpoint sum on the first `N` cells
has error bounded by `δ` times the integral of `|G'|` over the grid. -/
theorem finite_right_rectangle (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) * δ) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      δ * ∫ t in (0 : ℝ)..(N : ℝ) * δ, |deriv G t| := by
  induction N with
  | zero => simp
  | succ N ih =>
    have hcell : |δ * G (((N + 1 : ℕ) : ℝ) * δ) -
        ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ, G t| ≤
        δ * ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ, |deriv G t| := by
      have h := cell_bound G hG (a := (N : ℝ) * δ)
        (b := ((N + 1 : ℕ) : ℝ) * δ) (by push_cast; nlinarith)
      convert h using 1 <;> push_cast <;> ring_nf
    have hgi : IntervalIntegrable G volume 0 ((N : ℝ) * δ) :=
      hG.continuous.intervalIntegrable _ _
    have hgj : IntervalIntegrable G volume ((N : ℝ) * δ) (((N + 1 : ℕ) : ℝ) * δ) :=
      hG.continuous.intervalIntegrable _ _
    have hdi : IntervalIntegrable (fun t => |deriv G t|) volume 0 ((N : ℝ) * δ) :=
      hG.continuous_deriv_one.abs.intervalIntegrable _ _
    have hdj : IntervalIntegrable (fun t => |deriv G t|) volume
        ((N : ℝ) * δ) (((N + 1 : ℕ) : ℝ) * δ) :=
      hG.continuous_deriv_one.abs.intervalIntegrable _ _
    rw [sum_range_succ]
    rw [← integral_add_adjacent_intervals hgi hgj,
      ← integral_add_adjacent_intervals hdi hdj]
    have htri := abs_add_le
      (δ * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) * δ) -
        ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t)
      (δ * G (((N + 1 : ℕ) : ℝ) * δ) -
        ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ, G t)
    have hsum := add_le_add ih hcell
    convert htri.trans hsum using 1 <;> ring_nf

/-- The same estimate in the audit's `1 / X` mesh notation. -/
theorem finite_right_rectangle_div (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (X : ℝ) (hX : 0 < X) (N : ℕ) :
    |(1 / X) * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) / X) -
      ∫ t in (0 : ℝ)..(N : ℝ) / X, G t| ≤
      (1 / X) * ∫ t in (0 : ℝ)..(N : ℝ) / X, |deriv G t| := by
  simpa [div_eq_mul_inv] using
    finite_right_rectangle G hG (1 / X) (by positivity) N

private def trapWeight (a b t : ℝ) : ℝ := (t - a) * (b - t) / 2
private def trapSlope (a b t : ℝ) : ℝ := (a + b) / 2 - t

private theorem trapWeight_hasDerivAt (a b t : ℝ) :
    HasDerivAt (trapWeight a b) (trapSlope a b t) t := by
  unfold trapWeight trapSlope
  convert (((hasDerivAt_id t).sub_const a).mul
    ((hasDerivAt_const t b).sub (hasDerivAt_id t))).div_const 2 using 1 <;> dsimp <;> ring_nf

private theorem trapSlope_hasDerivAt (a b t : ℝ) :
    HasDerivAt (trapSlope a b) (-1) t := by
  unfold trapSlope
  convert (hasDerivAt_const t ((a + b) / 2)).sub (hasDerivAt_id t) using 1 <;> ring_nf

private theorem trap_cell_identity (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    (a b : ℝ) :
    (b - a) / 2 * (G a + G b) - ∫ t in a..b, G t =
      ∫ t in a..b, trapWeight a b t * deriv (deriv G) t := by
  have hG1 : ContDiff ℝ 1 G := hG.of_le (by norm_num)
  have hGtwo : ContDiff ℝ (1 + 1) G := by simpa using hG
  have hD : ContDiff ℝ 1 (deriv G) := hGtwo.deriv'
  have hDD : Continuous (deriv (deriv G)) := hD.continuous_deriv_one
  let F : ℝ → ℝ := fun t => trapWeight a b t * deriv G t - trapSlope a b t * G t
  have hF (t : ℝ) : HasDerivAt F
      (trapWeight a b t * deriv (deriv G) t + G t) t := by
    dsimp [F]
    convert ((trapWeight_hasDerivAt a b t).mul
      ((hD.differentiable (by norm_num) t).hasDerivAt)).sub
      ((trapSlope_hasDerivAt a b t).mul
      ((hG1.differentiable (by norm_num) t).hasDerivAt)) using 1 <;> ring_nf
  have hint : IntervalIntegrable
      (fun t => trapWeight a b t * deriv (deriv G) t + G t) volume a b := by
    apply Continuous.intervalIntegrable
    exact (((continuous_id.sub continuous_const).mul
      (continuous_const.sub continuous_id)).div_const 2).mul hDD |>.add hG1.continuous
  have hftc : ∫ t in a..b,
      (trapWeight a b t * deriv (deriv G) t + G t) = F b - F a :=
    integral_eq_sub_of_hasDerivAt (fun t _ => hF t) hint
  have hwi : IntervalIntegrable
      (fun t => trapWeight a b t * deriv (deriv G) t) volume a b := by
    apply Continuous.intervalIntegrable
    exact (((continuous_id.sub continuous_const).mul
      (continuous_const.sub continuous_id)).div_const 2).mul hDD
  rw [integral_add hwi (hG1.continuous.intervalIntegrable _ _)] at hftc
  dsimp [F, trapWeight, trapSlope] at hftc
  simp only [trapWeight] at *
  linear_combination -hftc

private theorem trap_cell_bound (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    {a b : ℝ} (hab : a ≤ b) :
    |(b - a) / 2 * (G a + G b) - ∫ t in a..b, G t| ≤
      (b - a) ^ 2 / 4 * ∫ t in a..b, |deriv (deriv G) t| := by
  rw [trap_cell_identity G hG a b]
  have hGtwo : ContDiff ℝ (1 + 1) G := by simpa using hG
  have hD : ContDiff ℝ 1 (deriv G) := hGtwo.deriv'
  have hDD : Continuous (deriv (deriv G)) := hD.continuous_deriv_one
  have hwi : IntervalIntegrable
      (fun t => |trapWeight a b t * deriv (deriv G) t|) volume a b := by
    apply Continuous.intervalIntegrable
    exact ((((continuous_id.sub continuous_const).mul
      (continuous_const.sub continuous_id)).div_const 2).mul hDD).abs
  have hbi : IntervalIntegrable
      (fun t => (b - a) ^ 2 / 4 * |deriv (deriv G) t|) volume a b :=
    (continuous_const.mul hDD.abs).intervalIntegrable _ _
  have hmono : (∫ t in a..b, |trapWeight a b t * deriv (deriv G) t|) ≤
      ∫ t in a..b, (b - a) ^ 2 / 4 * |deriv (deriv G) t| := by
    apply integral_mono_on hab hwi hbi
    intro t ht
    have hwa : |trapWeight a b t| ≤ (b - a) ^ 2 / 4 := by
      have hnonneg : 0 ≤ trapWeight a b t := by
        unfold trapWeight
        apply div_nonneg (mul_nonneg (sub_nonneg.mpr ht.1) (sub_nonneg.mpr ht.2))
        norm_num
      rw [abs_of_nonneg hnonneg]
      unfold trapWeight
      nlinarith [sq_nonneg (t - (a + b) / 2)]
    rw [abs_mul]
    exact mul_le_mul_of_nonneg_right hwa (abs_nonneg _)
  exact (abs_integral_le_integral_abs hab).trans <| by
    rw [intervalIntegral.integral_const_mul] at hmono
    exact hmono

/-- Finite trapezoid rule over `N` cells, with both endpoints of every cell
shown explicitly. Interior endpoints occur twice with half weight. -/
theorem finite_trapezoid_cells (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |(∑ m ∈ range N, δ / 2 *
        (G ((m : ℝ) * δ) + G (((m + 1 : ℕ) : ℝ) * δ))) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      δ ^ 2 / 4 * ∫ t in (0 : ℝ)..(N : ℝ) * δ,
        |deriv (deriv G) t| := by
  induction N with
  | zero => simp
  | succ N ih =>
    have hcell : |δ / 2 *
        (G ((N : ℝ) * δ) + G (((N + 1 : ℕ) : ℝ) * δ)) -
        ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ, G t| ≤
        δ ^ 2 / 4 * ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ,
          |deriv (deriv G) t| := by
      have h := trap_cell_bound G hG (a := (N : ℝ) * δ)
        (b := ((N + 1 : ℕ) : ℝ) * δ) (by push_cast; nlinarith)
      convert h using 1 <;> push_cast <;> ring_nf
    have hgi : IntervalIntegrable G volume 0 ((N : ℝ) * δ) :=
      hG.continuous.intervalIntegrable _ _
    have hgj : IntervalIntegrable G volume ((N : ℝ) * δ) (((N + 1 : ℕ) : ℝ) * δ) :=
      hG.continuous.intervalIntegrable _ _
    have hGtwo : ContDiff ℝ (1 + 1) G := by simpa using hG
    have hD : ContDiff ℝ 1 (deriv G) := hGtwo.deriv'
    have hDD : Continuous (deriv (deriv G)) := hD.continuous_deriv_one
    have hdi : IntervalIntegrable (fun t => |deriv (deriv G) t|) volume
        0 ((N : ℝ) * δ) := hDD.abs.intervalIntegrable _ _
    have hdj : IntervalIntegrable (fun t => |deriv (deriv G) t|) volume
        ((N : ℝ) * δ) (((N + 1 : ℕ) : ℝ) * δ) :=
      hDD.abs.intervalIntegrable _ _
    rw [sum_range_succ]
    rw [← integral_add_adjacent_intervals hgi hgj,
      ← integral_add_adjacent_intervals hdi hdj]
    have htri := abs_add_le
      ((∑ m ∈ range N, δ / 2 *
          (G ((m : ℝ) * δ) + G (((m + 1 : ℕ) : ℝ) * δ))) -
        ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t)
      (δ / 2 * (G ((N : ℝ) * δ) + G (((N + 1 : ℕ) : ℝ) * δ)) -
        ∫ t in (N : ℝ) * δ..((N + 1 : ℕ) : ℝ) * δ, G t)
    have hsum := add_le_add ih hcell
    convert htri.trans hsum using 1 <;> ring_nf

private theorem trapezoid_cells_eq (G : ℝ → ℝ) (δ : ℝ) (N : ℕ) :
    (∑ m ∈ range (N + 1), δ / 2 *
        (G ((m : ℝ) * δ) + G (((m + 1 : ℕ) : ℝ) * δ))) =
      δ / 2 * (G 0 + G (((N + 1 : ℕ) : ℝ) * δ)) +
        δ * ∑ m ∈ Ico 1 (N + 1), G ((m : ℝ) * δ) := by
  induction N with
  | zero => simp
  | succ N ih =>
    rw [sum_range_succ, Finset.sum_Ico_succ_top (by omega : 1 ≤ N + 1), ih]
    push_cast
    ring_nf

/-- Finite trapezoid rule in endpoint form. The parameter `N + 1` is the
positive number of cells; the interior sum runs from 1 through `N`. -/
theorem finite_trapezoid_endpoints (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ / 2 * (G 0 + G (((N + 1 : ℕ) : ℝ) * δ)) +
        δ * ∑ m ∈ Ico 1 (N + 1), G ((m : ℝ) * δ) -
      ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ, G t| ≤
      δ ^ 2 / 4 * ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ,
        |deriv (deriv G) t| := by
  rw [← trapezoid_cells_eq]
  exact finite_trapezoid_cells G hG δ hδ (N + 1)

#print axioms finite_right_rectangle
#print axioms finite_right_rectangle_div
#print axioms finite_trapezoid_cells
#print axioms finite_trapezoid_endpoints

end
end BuildingBlocks.ActualHeatRenewalRectangle
