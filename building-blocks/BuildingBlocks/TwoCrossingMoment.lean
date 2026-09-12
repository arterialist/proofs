import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/- The comparison principle is classical: Karlin–Novikoff,
Generalized convex inequalities, Pacific J. Math. 13 (1963), §1, Lemma b.
https://msp.org/pjm/1963/13-4/pjm-v13-n4-p18-s.pdf
This module proves the explicit affine-comparator version below. -/

open MeasureTheory

namespace BuildingBlocks

/-- A signed density with two crossings and vanishing zeroth and first moments
integrates a function below zero when that function lies above its affine
comparison between the crossings and below it outside.  The affine comparison integrates to zero by the two moment identities. -/
theorem integral_nonpos_of_two_crossings
    {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (K W H : α → ℝ) (a b lo hi : ℝ)
    (hKH : Integrable (fun x => K x * H x) μ)
    (hWH : Integrable (fun x => W x * H x) μ)
    (hH : Integrable H μ)
    (hzero : (∫ x, H x ∂μ) = 0)
    (hfirst : (∫ x, W x * H x ∂μ) = 0)
    (hout : ∀ x, W x ≤ lo ∨ hi ≤ W x →
      0 ≤ H x ∧ K x ≤ a * W x + b)
    (hin : ∀ x, lo < W x → W x < hi →
      H x ≤ 0 ∧ a * W x + b ≤ K x) :
    (∫ x, K x * H x ∂μ) ≤ 0 := by
  have haff : Integrable (fun x => (a * W x + b) * H x) μ := by
    convert (hWH.const_mul a).add (hH.const_mul b) using 1
    funext x
    dsimp only [Pi.add_apply]
    ring
  have haffzero : (∫ x, (a * W x + b) * H x ∂μ) = 0 := by
    have hid : (fun x => (a * W x + b) * H x) =
        (fun x => a * (W x * H x) + b * H x) := by
      funext x
      ring
    rw [hid, integral_add (hWH.const_mul a) (hH.const_mul b),
      integral_const_mul, integral_const_mul, hzero, hfirst]
    ring
  rw [← haffzero]
  apply integral_mono_ae hKH haff
  filter_upwards [] with x
  by_cases houter : W x ≤ lo ∨ hi ≤ W x
  · exact mul_le_mul_of_nonneg_right (hout x houter).2 (hout x houter).1
  · have hl : lo < W x := lt_of_not_ge (fun h => houter (Or.inl h))
    have hr : W x < hi := lt_of_not_ge (fun h => houter (Or.inr h))
    exact mul_le_mul_of_nonpos_right (hin x hl hr).2 (hin x hl hr).1

end BuildingBlocks
