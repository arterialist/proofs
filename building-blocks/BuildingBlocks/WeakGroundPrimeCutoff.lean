import BuildingBlocks.WeakGroundPrimeTail
import Mathlib.Analysis.Normed.Group.Tannery
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! Hard-cutoff convergence of the actual all-power weak prime row. -/
namespace BuildingBlocks.WeakGroundPrimeCutoff
open MeasureTheory Filter
open scoped Topology ArithmeticFunction.vonMangoldt
open BuildingBlocks.WeakGroundPrimeTail

noncomputable def cutOverlap (k : ℕ) (side : Bool) (x : ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) (v : ℝ) : ℂ :=
  if |shift side x v| ≤ (k : ℝ) then G v • z (shift side x v) else 0

theorem cutOverlap_measurable (μ : Measure ℝ) (k : ℕ) (side : Bool) (x : ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ)
    (hm : AEStronglyMeasurable (fun v => G v • z (shift side x v)) μ) :
    AEStronglyMeasurable (cutOverlap k side x G z) μ := by
  have hc : Continuous (fun v => |shift side x v|) := by
    cases side <;> simp only [shift, Bool.false_eq_true, if_false, if_true] <;> fun_prop
  have hs : MeasurableSet {v : ℝ | |shift side x v| ≤ (k : ℝ)} :=
    measurableSet_le hc.measurable measurable_const
  exact hm.indicator hs

theorem cutOverlap_norm_le (k : ℕ) (side : Bool) (x v : ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) :
    ‖cutOverlap k side x G z v‖ ≤ ‖G v • z (shift side x v)‖ := by
  unfold cutOverlap
  split_ifs
  · exact le_rfl
  · simpa using norm_nonneg (G v • z (shift side x v))

theorem cutOverlap_tendsto (side : Bool) (x v : ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) :
    Tendsto (fun k => cutOverlap k side x G z v) atTop
      (𝓝 (G v • z (shift side x v))) := by
  obtain ⟨N, hN⟩ := exists_nat_gt |shift side x v|
  apply tendsto_const_nhds.congr'
  filter_upwards [eventually_ge_atTop N] with k hk
  have hh : |shift side x v| ≤ (k : ℝ) :=
    hN.le.trans (by exact_mod_cast hk)
  simp [cutOverlap, hh]

theorem cutOverlap_integral_tendsto (μ : Measure ℝ) (side : Bool) (x : ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ)
    (hf : Integrable (fun v => G v • z (shift side x v)) μ) :
    Tendsto (fun k => ∫ v, cutOverlap k side x G z v ∂μ) atTop
      (𝓝 (∫ v, G v • z (shift side x v) ∂μ)) := by
  apply tendsto_integral_filter_of_dominated_convergence
    (fun v => ‖G v • z (shift side x v)‖)
  · exact Eventually.of_forall (fun k => cutOverlap_measurable μ k side x G z hf.aestronglyMeasurable)
  · exact Eventually.of_forall (fun k => Eventually.of_forall
      (fun v => cutOverlap_norm_le k side x v G z))
  · exact hf.norm
  · exact Eventually.of_forall (fun v => cutOverlap_tendsto side x v G z)

theorem cutoff_complete_prime_row_tendsto (μ : Measure ℝ)
    (G : ℝ → ℝ) (z : ℝ → ℂ) (β C : ℝ)
    (hβ : 1 / 2 < β) (hC : 0 ≤ C) (hG : ∀ v, 0 ≤ G v)
    (hz : ∀ v, ‖z v‖ ≤ C * Real.exp (-β * |v|))
    (hm : Integrable (fun v => Real.exp (β * |v|) * G v) μ)
    (hmeas : ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      AEStronglyMeasurable (fun v => G v • z (shift side n.val v)) μ) :
    Tendsto (fun k => ∑' n : {n : ℕ // 2 ≤ n},
      (Λ n.val / Real.sqrt n.val) •
        ((∫ v, cutOverlap k true n.val G z v ∂μ) +
         (∫ v, cutOverlap k false n.val G z v ∂μ))) atTop
      (𝓝 (∑' n : {n : ℕ // 2 ≤ n}, (Λ n.val / Real.sqrt n.val) •
        ((∫ v, G v • z (shift true n.val v) ∂μ) +
         (∫ v, G v • z (shift false n.val v) ∂μ)))) := by
  have hf : ∀ side : Bool, ∀ n : {n : ℕ // 2 ≤ n},
      Integrable (fun v => G v • z (shift side n.val v)) μ := by
    intro side n
    have hx : 1 ≤ (n.val : ℝ) := by exact_mod_cast (le_trans (by norm_num : 1 ≤ 2) n.property)
    exact (exponential_overlap_integrable_bound μ G z side n.val β C hx
      (by linarith) hC hG hz hm (hmeas side n)).1
  apply tendsto_tsum_of_dominated_convergence
    (summable_complete_ground_prime_integrals μ G z β C hβ hC hG hz hm hmeas)
  · intro n
    exact ((cutOverlap_integral_tendsto μ true n.val G z (hf true n)).add
      (cutOverlap_integral_tendsto μ false n.val G z (hf false n))).const_smul _
  · apply Eventually.of_forall
    intro k n
    have hc : 0 ≤ Λ n.val / Real.sqrt n.val :=
      div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Real.sqrt_nonneg _)
    have hb : ∀ side : Bool,
        ‖∫ v, cutOverlap k side n.val G z v ∂μ‖ ≤
          ∫ v, ‖G v • z (shift side n.val v)‖ ∂μ := by
      intro side
      exact norm_integral_le_of_norm_le (hf side n).norm
        (Eventually.of_forall (fun v => cutOverlap_norm_le k side n.val v G z))
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg hc]
    apply mul_le_mul_of_nonneg_left _ hc
    exact (norm_add_le _ _).trans (add_le_add (hb true) (hb false))

#print axioms cutOverlap_measurable
#print axioms cutOverlap_norm_le
#print axioms cutOverlap_tendsto
#print axioms cutOverlap_integral_tendsto
#print axioms cutoff_complete_prime_row_tendsto
end BuildingBlocks.WeakGroundPrimeCutoff
