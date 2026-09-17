import Mathlib.Analysis.SpecialFunctions.Trigonometric.InverseDeriv
import Mathlib.Analysis.Calculus.Deriv.MeanValue

open Set

namespace BuildingBlocks.ChargeArcsinBound

private theorem derivative_bounds {x : ℝ} (_hx : 0 ≤ x) (hx2 : x ^ 2 ≤ 1 / 2) :
    0 ≤ 1 / Real.sqrt (1 - x ^ 2) - 1 ∧
      1 / Real.sqrt (1 - x ^ 2) - 1 ≤ x ^ 2 := by
  let s := Real.sqrt (1 - x ^ 2)
  have hr : 0 < 1 - x ^ 2 := by linarith
  have hs : 0 < s := Real.sqrt_pos.mpr hr
  have hs2 : s ^ 2 = 1 - x ^ 2 := Real.sq_sqrt hr.le
  have hs1 : s ≤ 1 := by
    dsimp [s]
    apply Real.sqrt_le_one.mpr
    nlinarith [sq_nonneg x]
  have hshalf : (1 / 2 : ℝ) ≤ s := by nlinarith
  have hden : 1 ≤ s * (1 + s) := by nlinarith
  have he : 1 / s - 1 = x ^ 2 / (s * (1 + s)) := by
    field_simp
    nlinarith [hs2]
  constructor
  · exact sub_nonneg.mpr ((one_le_div hs).mpr hs1)
  · change 1 / s - 1 ≤ x ^ 2
    rw [he]
    simpa using div_le_div_of_nonneg_left (sq_nonneg x) (by norm_num : (0 : ℝ) < 1) hden

/-- The original charge arcsine correction has a cubic bound on its full closed domain. -/
theorem arcsin_sub_bounds {z : ℝ} (hz : 0 ≤ z) (hz2 : z ^ 2 ≤ 1 / 2) :
    0 ≤ Real.arcsin z - z ∧ Real.arcsin z - z ≤ z ^ 3 / 3 := by
  have bounds (x : ℝ) (hx : x ∈ Icc (0 : ℝ) z) : x ^ 2 ≤ 1 / 2 := by
    nlinarith [hx.1, hx.2]
  have hd (x : ℝ) (hx : x ∈ Icc (0 : ℝ) z) :
      HasDerivAt (fun x : ℝ => Real.arcsin x - x)
        (1 / Real.sqrt (1 - x ^ 2) - 1) x := by
    have hxb := bounds x hx
    exact (Real.hasDerivAt_arcsin (by nlinarith [hx.1]) (by nlinarith)).sub (hasDerivAt_id x)
  have hm : MonotoneOn (fun x : ℝ => Real.arcsin x - x) (Icc (0 : ℝ) z) := by
    apply monotoneOn_of_hasDerivWithinAt_nonneg (convex_Icc 0 z)
      (by fun_prop)
    · intro x hx
      exact (hd x (interior_subset hx)).hasDerivWithinAt
    · intro x hx
      exact (derivative_bounds (interior_subset hx).1 (bounds x (interior_subset hx))).1
  have hp : MonotoneOn (fun x : ℝ => x ^ 3 / 3 - (Real.arcsin x - x)) (Icc (0 : ℝ) z) := by
    apply monotoneOn_of_hasDerivWithinAt_nonneg (convex_Icc 0 z)
      (by fun_prop)
    · intro x hx
      have hh := (((hasDerivAt_id x).pow 3).div_const 3).sub (hd x (interior_subset hx))
      exact hh.hasDerivWithinAt
    · intro x hx
      convert sub_nonneg.mpr (derivative_bounds (interior_subset hx).1 (bounds x (interior_subset hx))).2 using 1
      norm_num
  have h0 : (0 : ℝ) ∈ Icc (0 : ℝ) z := ⟨le_rfl, hz⟩
  have hzz : z ∈ Icc (0 : ℝ) z := ⟨hz, le_rfl⟩
  have ha := hm h0 hzz hz
  have hb := hp h0 hzz hz
  simp only [Real.arcsin_zero, zero_pow (by norm_num : 3 ≠ 0), zero_div, sub_self] at ha hb
  exact ⟨ha, by linarith⟩

#print axioms arcsin_sub_bounds

end BuildingBlocks.ChargeArcsinBound
