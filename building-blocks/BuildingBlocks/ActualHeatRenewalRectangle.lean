import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.Calculus.ContDiff.Basic
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

#print axioms finite_right_rectangle
#print axioms finite_right_rectangle_div

end
end BuildingBlocks.ActualHeatRenewalRectangle
