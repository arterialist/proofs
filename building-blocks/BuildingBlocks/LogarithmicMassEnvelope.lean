import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-! The scalar envelope in the spectral logarithmic-moment estimate.
This module does not assert the source PNT bound or the layer-cake estimate. -/
namespace BuildingBlocks.LogarithmicMassEnvelope

noncomputable def envelope (A h : ℝ) : ℝ := h * (1 + Real.log (1 + A / h))

lemma hasDerivAt_envelope {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    HasDerivAt (envelope A)
      (1 + Real.log (1 + A / h) - A / (A + h)) h := by
  have hp : 0 < 1 + A / h := by positivity
  have hd := (hasDerivAt_id h).mul
    ((((hasDerivAt_const h A).div (hasDerivAt_id h) hh.ne').const_add 1).log hp.ne')
  have he : 1 * Real.log (1 + A / h) + h * ((0 * h - A * 1) / h ^ 2 / (1 + A / h))
      = Real.log (1 + A / h) - A / (A + h) := by
    have hah : A + h ≠ 0 := by positivity
    field_simp [hh.ne', hah]
    ring
  have hd' : HasDerivAt (fun x : ℝ => x * Real.log (1 + A / x))
      (Real.log (1 + A / h) - A / (A + h)) h := by
    convert hd using 1
    simp only [Pi.div_apply, id_eq]
    exact he.symm
  convert (hasDerivAt_id h).add hd' using 1
  · funext x
    simp only [envelope, Pi.add_apply, id_eq]
    ring
  · ring

lemma envelope_derivative_pos {A h : ℝ} (hA : 0 ≤ A) (hh : 0 < h) :
    0 < 1 + Real.log (1 + A / h) - A / (A + h) := by
  have hl : 0 ≤ Real.log (1 + A / h) := Real.log_nonneg (by have hd : 0 ≤ A / h := div_nonneg hA hh.le; linarith)
  have hr : A / (A + h) < 1 := (div_lt_one (by positivity)).2 (by linarith)
  linarith

theorem envelope_strictMonoOn {A : ℝ} (hA : 0 ≤ A) :
    StrictMonoOn (envelope A) (Set.Ioi 0) := by
  apply strictMonoOn_of_deriv_pos (convex_Ioi 0)
  · intro h hh
    exact (hasDerivAt_envelope hA hh).continuousAt.continuousWithinAt
  · intro h hh
    have hh' : 0 < h := by simpa using hh
    rw [(hasDerivAt_envelope hA hh').deriv]
    exact envelope_derivative_pos hA hh'

theorem envelope_le {A h H : ℝ} (hA : 0 ≤ A) (hh : 0 < h)
    (hH : h ≤ H) : envelope A h ≤ envelope A H :=
  (envelope_strictMonoOn hA).monotoneOn hh (lt_of_lt_of_le hh hH) hH

#print axioms hasDerivAt_envelope
#print axioms envelope_derivative_pos
#print axioms envelope_strictMonoOn
#print axioms envelope_le
end BuildingBlocks.LogarithmicMassEnvelope
