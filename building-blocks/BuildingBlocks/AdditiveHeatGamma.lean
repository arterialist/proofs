import Mathlib.Analysis.SpecialFunctions.Gamma.Beta
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic

namespace BuildingBlocks.AdditiveHeatGamma

theorem sin_half_line (ξ : ℝ) :
    Complex.sin ((Real.pi : ℂ) * ((1 / 2 : ℂ) + (ξ : ℂ) * Complex.I)) =
      (Real.cosh (Real.pi * ξ) : ℂ) := by
  have ha : (Real.pi : ℂ) * ((1 / 2 : ℂ) + (ξ : ℂ) * Complex.I) =
      ((Real.pi * ξ : ℝ) : ℂ) * Complex.I + (Real.pi : ℂ) / 2 := by
    push_cast
    ring
  rw [ha, Complex.sin_add_pi_div_two, Complex.cos_mul_I, ← Complex.ofReal_cosh]

theorem gamma_half_line_norm_sq (ξ : ℝ) :
    ‖Complex.Gamma ((1 / 2 : ℂ) + (ξ : ℂ) * Complex.I)‖ ^ 2 =
      Real.pi / Real.cosh (Real.pi * ξ) := by
  let z : ℂ := (1 / 2 : ℂ) + (ξ : ℂ) * Complex.I
  have hz : 1 - z = (starRingEnd ℂ) z := by
    apply Complex.ext <;> simp [z] <;> ring
  have h := Complex.Gamma_mul_Gamma_one_sub z
  rw [hz, Complex.Gamma_conj, Complex.mul_conj, Complex.normSq_eq_norm_sq] at h
  rw [sin_half_line] at h
  exact_mod_cast h

#print axioms sin_half_line
#print axioms gamma_half_line_norm_sq

end BuildingBlocks.AdditiveHeatGamma
