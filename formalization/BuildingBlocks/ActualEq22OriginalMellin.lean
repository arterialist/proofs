import BuildingBlocks.ActualEq22ArithmeticIdentity
import BuildingBlocks.ActualEq22MellinInversion

/-! Native original-object Eq22 Mellin--Perron reconstruction.

The original is the complex cast of Rnum - Tnum, with all-real matching,
including the empty cutoff region. Initial-line reconstruction and absolute
Perron convergence hold for every c > 2 and x > 0. The existing contour upper
remains written and unformalized; stronger arithmetic estimates and the eventual
RH sign remain open. -/

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualEq22OriginalMellin

noncomputable def original (x : ℝ) : ℂ := (ActualEq22ArithmeticIdentity.C_literal x : ℂ)

/-- The original Eq22 residual, including the empty region and every seam,
equals the independently constructed native Mellin readout. -/
theorem original_eq_forward : original = ActualEq22ForwardMellin.C := by
  funext x
  by_cases hx : 1 ≤ x
  · exact ActualEq22ArithmeticIdentity.literal_eq_forwardC hx
  · have hlt : x < 1 := lt_of_not_ge hx
    have hfloor : ⌊x⌋₊ = 0 := Nat.floor_eq_zero.mpr hlt
    rw [ActualEq22ForwardMellin.C_zero hlt.le]
    simp [original, ActualEq22ArithmeticIdentity.C_literal, ActualVolterraIdentity.Rnum,
      ActualVolterraIdentity.RnumOn, ActualEq22Residual.Tnum,
      ActualEq22Residual.TnumOn, hfloor]

theorem continuous_original : Continuous original := by
  rw [original_eq_forward]
  exact ActualEq22ForwardMellin.continuous_C

theorem hasMellin_original {s : ℂ} (hs : 1 < s.re) :
    HasMellin original (-s - 1)
      (riemannZeta (s + 1 / 2) *
        (1 / (s - 1) + deriv riemannZeta s / riemannZeta s) ^ 2 /
          (s * (s + 1))) := by
  rw [original_eq_forward]
  exact ActualEq22ForwardMellin.hasMellin_C_a0 hs

theorem verticalIntegrable_original (c : ℝ) (hc : 2 < c) :
    Complex.VerticalIntegrable (mellin original) (-c) := by
  rw [original_eq_forward]
  exact ActualEq22MellinInversion.verticalIntegrable_C c hc

theorem mellinInv_original {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    mellinInv (-c) (mellin original) x = original x := by
  rw [original_eq_forward]
  exact ActualEq22MellinInversion.mellinInv_C hc hx

/-- Initial-line reconstruction of the ORIGINAL physical Eq22 residual.
All analytic premises used by inversion are discharged natively. -/
theorem original_eq_closed_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    original x = (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ,
      (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
        ActualEq22MellinInversion.perronFactor0 ((c : ℂ) + t * Complex.I) := by
  rw [original_eq_forward]
  exact ActualEq22MellinInversion.C_eq_closed_perron hc hx

theorem original_closed_perron_integrable {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (fun t : ℝ =>
      (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
        ActualEq22MellinInversion.perronFactor0 ((c : ℂ) + t * Complex.I)) :=
  ActualEq22MellinInversion.integrable_closed_perron0 hc hx

/-- Same original residual with the already native complete normalized T. -/
theorem original_normalized_eq_closed_perron {c x : ℝ}
    (hc : 2 < c) (hx : 1 ≤ x) :
    ((ActualVolterraIdentity.Rnum x - ActualEq22Residual.Tnormalized x : ℝ) : ℂ) =
      (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ,
        (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
          ActualEq22MellinInversion.perronFactor0 ((c : ℂ) + t * Complex.I) := by
  simpa only [original, ActualEq22ArithmeticIdentity.C_literal,
    ActualEq22Residual.Tnum_eq_Tnormalized hx] using
      original_eq_closed_perron hc (by linarith : 0 < x)

end BuildingBlocks.ActualEq22OriginalMellin
