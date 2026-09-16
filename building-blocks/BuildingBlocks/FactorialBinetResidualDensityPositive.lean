import Mathlib.Tactic
import Mathlib.Analysis.Calculus.Deriv.MeanValue

/-!
# Positivity of the twice-corrected factorial-clock density

The actual compensated factorial density is
`1/t² - 1/(t*(exp t - 1))`. Removing the first two Stirling modes
leaves a strictly positive pointwise density. The Laplace identification
with the Binet remainder is a separate analytic obligation.
-/

namespace BuildingBlocks.FactorialBinetResidualDensityPositive

noncomputable section

private def poly (x : ℝ) : ℝ := x ^ 2 - 6 * x + 12
private def witness (x : ℝ) : ℝ := poly x * (Real.exp x - 1) - 12 * x
private def witnessOne (x : ℝ) : ℝ :=
  (x ^ 2 - 4 * x + 6) * Real.exp x - 2 * x - 6
private def witnessTwo (x : ℝ) : ℝ :=
  (x ^ 2 - 2 * x + 2) * Real.exp x - 2

private theorem deriv_witness (x : ℝ) : deriv witness x = witnessOne x := by
  have hp : HasDerivAt (fun y : ℝ => y ^ 2 - 6 * y + 12) (2 * x - 6) x := by
    convert ((hasDerivAt_id x).pow 2 |>.sub ((hasDerivAt_id x).const_mul 6) |>.add_const 12) using 1
    all_goals simp only [id_eq]
    all_goals ring
  have he : HasDerivAt (fun y : ℝ => Real.exp y - 1) (Real.exp x) x :=
    (Real.hasDerivAt_exp x).sub_const 1
  have hl : HasDerivAt (fun y : ℝ => 12 * y) 12 x := by
    convert (hasDerivAt_id x).const_mul 12 using 1
    all_goals simp only [mul_one]
  have h := (hp.mul he).sub hl
  have hh : HasDerivAt witness (witnessOne x) x := by
    convert h using 1
    dsimp [witnessOne]
    ring
  exact hh.deriv

private theorem deriv_witnessOne (x : ℝ) :
    deriv witnessOne x = witnessTwo x := by
  have hp : HasDerivAt (fun y : ℝ => y ^ 2 - 4 * y + 6) (2 * x - 4) x := by
    convert ((hasDerivAt_id x).pow 2 |>.sub ((hasDerivAt_id x).const_mul 4) |>.add_const 6) using 1
    all_goals simp only [id_eq]
    all_goals ring
  have hl : HasDerivAt (fun y : ℝ => 2 * y + 6) 2 x := by
    convert (hasDerivAt_id x).const_mul 2 |>.add_const 6 using 1
    all_goals simp only [mul_one]
  have h := (hp.mul (Real.hasDerivAt_exp x)).sub hl
  have hh : HasDerivAt witnessOne (witnessTwo x) x := by
    convert h using 1
    · funext y
      dsimp [witnessOne]
      ring
    · dsimp [witnessTwo]
      ring
  exact hh.deriv

private theorem deriv_witnessTwo (x : ℝ) :
    deriv witnessTwo x = x ^ 2 * Real.exp x := by
  have hp : HasDerivAt (fun y : ℝ => y ^ 2 - 2 * y + 2) (2 * x - 2) x := by
    convert ((hasDerivAt_id x).pow 2 |>.sub ((hasDerivAt_id x).const_mul 2) |>.add_const 2) using 1
    all_goals simp only [id_eq]
    all_goals ring
  have h := (hp.mul (Real.hasDerivAt_exp x)).sub_const 2
  have hh : HasDerivAt witnessTwo (x ^ 2 * Real.exp x) x := by
    convert h using 1
    ring
  exact hh.deriv

private theorem witnessTwo_pos {x : ℝ} (hx : 0 < x) : 0 < witnessTwo x := by
  have hmono : StrictMonoOn witnessTwo (Set.Ici 0) := by
    apply strictMonoOn_of_deriv_pos (convex_Ici (0 : ℝ))
    · unfold witnessTwo
      fun_prop
    · intro y hy
      have hy' : 0 < y := by simpa using hy
      rw [deriv_witnessTwo]
      positivity
  have h := hmono (by simp : (0 : ℝ) ∈ Set.Ici 0) (by simp [hx.le] : x ∈ Set.Ici 0) hx
  simpa [witnessTwo] using h

private theorem witnessOne_pos {x : ℝ} (hx : 0 < x) : 0 < witnessOne x := by
  have hmono : StrictMonoOn witnessOne (Set.Ici 0) := by
    apply strictMonoOn_of_deriv_pos (convex_Ici (0 : ℝ))
    · unfold witnessOne
      fun_prop
    · intro y hy
      have hy' : 0 < y := by simpa using hy
      rw [deriv_witnessOne]
      exact witnessTwo_pos hy'
  have h := hmono (by simp : (0 : ℝ) ∈ Set.Ici 0) (by simp [hx.le] : x ∈ Set.Ici 0) hx
  simpa [witnessOne] using h

private theorem witness_pos {x : ℝ} (hx : 0 < x) : 0 < witness x := by
  have hmono : StrictMonoOn witness (Set.Ici 0) := by
    apply strictMonoOn_of_deriv_pos (convex_Ici (0 : ℝ))
    · unfold witness poly
      fun_prop
    · intro y hy
      have hy' : 0 < y := by simpa using hy
      rw [deriv_witness]
      exact witnessOne_pos hy'
  have h := hmono (by simp : (0 : ℝ) ∈ Set.Ici 0) (by simp [hx.le] : x ∈ Set.Ici 0) hx
  simpa [witness, poly] using h

/-- The original factorial density after subtracting its first two
Stirling modes. -/
def residualWeight (t : ℝ) : ℝ :=
  1 / t ^ 2 - 1 / (t * (Real.exp t - 1)) - 1 / (2 * t) + 1 / 12

theorem residualWeight_eq (t : ℝ) (ht : 0 < t) :
    residualWeight t = witness t / (12 * t ^ 2 * (Real.exp t - 1)) := by
  have ht0 : t ≠ 0 := ne_of_gt ht
  have he0 : Real.exp t - 1 ≠ 0 := sub_ne_zero.mpr
    (ne_of_gt (Real.one_lt_exp_iff.mpr ht))
  unfold residualWeight witness poly
  field_simp
  ring

theorem residualWeight_pos {t : ℝ} (ht : 0 < t) : 0 < residualWeight t := by
  rw [residualWeight_eq t ht]
  have he : 0 < Real.exp t - 1 := sub_pos.mpr (Real.one_lt_exp_iff.mpr ht)
  have hden : 0 < 12 * t ^ 2 * (Real.exp t - 1) := by positivity
  exact div_pos (witness_pos ht) hden

#print axioms residualWeight_eq
#print axioms residualWeight_pos

end
end BuildingBlocks.FactorialBinetResidualDensityPositive
