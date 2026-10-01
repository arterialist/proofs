import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
Finite complex-jet and positive-normalizer algebra for a radial magnitude estimate.
There is no actual theta/zeta identity or analytic bound in this module.
The subconvexity, Cauchy, gamma, radial-normalizer and odd-integral inputs
remain written analysis.
-/

namespace BuildingBlocks.ThetaRadialMagnitudeAlgebra

def firstJet (p p1 z z1 : ℂ) : ℝ :=
  2 * ((p1 * z + p * z1) * star (p * z)).re

noncomputable def secondJet (p p1 p2 z z1 z2 : ℂ) : ℝ :=
  2 * (‖p1 * z + p * z1‖ ^ 2 +
    ((p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)).re)

private theorem product_norm_bound {p z : ℂ} {P Z : ℝ}
    (hP : 0 ≤ P) (hp : ‖p‖ ≤ P) (hz : ‖z‖ ≤ Z) :
    ‖p * z‖ ≤ P * Z := by
  rw [norm_mul]
  exact mul_le_mul hp hz (norm_nonneg z) hP

private theorem first_product_norm_bound {p p1 z z1 : ℂ} {P Z L : ℝ}
    (hP : 0 ≤ P) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) :
    ‖p1 * z + p * z1‖ ≤ 2 * P * Z * L := by
  calc
    ‖p1 * z + p * z1‖ ≤ ‖p1 * z‖ + ‖p * z1‖ := norm_add_le _ _
    _ ≤ (P * L) * Z + P * (Z * L) :=
      add_le_add (product_norm_bound (mul_nonneg hP hL) hp1 hz)
        (product_norm_bound hP hp hz1)
    _ = 2 * P * Z * L := by ring

theorem firstJet_bound {p p1 z z1 : ℂ} {P Z L : ℝ}
    (hP : 0 ≤ P) (hZ : 0 ≤ Z) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) :
    |firstJet p p1 z z1| ≤ 4 * P ^ 2 * Z ^ 2 * L := by
  have ha := first_product_norm_bound hP hL hp hp1 hz hz1
  have hb := product_norm_bound hP hp hz
  have hc : |((p1 * z + p * z1) * star (p * z)).re| ≤
      (2 * P * Z * L) * (P * Z) := by
    calc
      _ ≤ ‖(p1 * z + p * z1) * star (p * z)‖ := Complex.abs_re_le_norm _
      _ = ‖p1 * z + p * z1‖ * ‖p * z‖ := by simp only [norm_mul, norm_star]
      _ ≤ _ := mul_le_mul ha hb (norm_nonneg _) (by positivity)
  calc
    |firstJet p p1 z z1| =
        2 * |((p1 * z + p * z1) * star (p * z)).re| := by
      simp only [firstJet, abs_mul]
      norm_num
    _ ≤ 2 * ((2 * P * Z * L) * (P * Z)) :=
      mul_le_mul_of_nonneg_left hc (by norm_num)
    _ = 4 * P ^ 2 * Z ^ 2 * L := by ring

private theorem second_product_norm_bound {p p1 p2 z z1 z2 : ℂ} {P Z L : ℝ}
    (hP : 0 ≤ P) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L) (hp2 : ‖p2‖ ≤ P * L ^ 2)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) (hz2 : ‖z2‖ ≤ Z * L ^ 2) :
    ‖p2 * z + 2 * p1 * z1 + p * z2‖ ≤ 4 * P * Z * L ^ 2 := by
  have hmid : ‖(2 : ℂ) * p1 * z1‖ ≤ 2 * ((P * L) * (Z * L)) := by
    calc
      _ = 2 * (‖p1‖ * ‖z1‖) := by simp; ring
      _ ≤ _ := mul_le_mul_of_nonneg_left
        (mul_le_mul hp1 hz1 (norm_nonneg _) (mul_nonneg hP hL)) (by norm_num)
  calc
    _ ≤ ‖p2 * z + 2 * p1 * z1‖ + ‖p * z2‖ := norm_add_le _ _
    _ ≤ (‖p2 * z‖ + ‖2 * p1 * z1‖) + ‖p * z2‖ :=
      add_le_add_right (norm_add_le _ _) _
    _ ≤ ((P * L ^ 2) * Z + 2 * ((P * L) * (Z * L))) + P * (Z * L ^ 2) :=
      add_le_add
        (add_le_add (product_norm_bound (by positivity) hp2 hz) hmid)
        (product_norm_bound hP hp hz2)
    _ = 4 * P * Z * L ^ 2 := by ring

theorem secondJet_bound {p p1 p2 z z1 z2 : ℂ} {P Z L : ℝ}
    (hP : 0 ≤ P) (hZ : 0 ≤ Z) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L) (hp2 : ‖p2‖ ≤ P * L ^ 2)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) (hz2 : ‖z2‖ ≤ Z * L ^ 2) :
    |secondJet p p1 p2 z z1 z2| ≤ 16 * P ^ 2 * Z ^ 2 * L ^ 2 := by
  have ha := first_product_norm_bound hP hL hp hp1 hz hz1
  have hb := product_norm_bound hP hp hz
  have hd := second_product_norm_bound hP hL hp hp1 hp2 hz hz1 hz2
  have ha2 : ‖p1 * z + p * z1‖ ^ 2 ≤ (2 * P * Z * L) ^ 2 := by
    simpa only [pow_two] using mul_self_le_mul_self (norm_nonneg _) ha
  have hc : |((p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)).re| ≤
      (4 * P * Z * L ^ 2) * (P * Z) := by
    calc
      _ ≤ ‖(p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)‖ :=
        Complex.abs_re_le_norm _
      _ = ‖p2 * z + 2 * p1 * z1 + p * z2‖ * ‖p * z‖ := by
        simp only [norm_mul, norm_star]
      _ ≤ _ := mul_le_mul hd hb (norm_nonneg _) (by positivity)
  calc
    |secondJet p p1 p2 z z1 z2| =
        2 * |‖p1 * z + p * z1‖ ^ 2 +
          ((p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)).re| := by
      simp only [secondJet, abs_mul]
      norm_num
    _ ≤ 2 * (‖p1 * z + p * z1‖ ^ 2 +
        |((p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)).re|) := by
      have ht := abs_add_le (‖p1 * z + p * z1‖ ^ 2)
        (((p2 * z + 2 * p1 * z1 + p * z2) * star (p * z)).re)
      rw [abs_of_nonneg (sq_nonneg ‖p1 * z + p * z1‖)] at ht
      exact mul_le_mul_of_nonneg_left ht (by norm_num)
    _ ≤ 2 * ((2 * P * Z * L) ^ 2 + (4 * P * Z * L ^ 2) * (P * Z)) :=
      mul_le_mul_of_nonneg_left (add_le_add ha2 hc) (by norm_num)
    _ = 16 * P ^ 2 * Z ^ 2 * L ^ 2 := by ring

theorem positiveNormalizer_quotient {K a E w c : ℝ}
    (_hE : 0 ≤ E) (ha : 0 ≤ a) (hc : 0 < c) (hw : 0 < w)
    (hK : |K| ≤ a * E) (hdom : c * E ≤ w) :
    |K / w| ≤ a / c := by
  rw [abs_div, abs_of_pos hw]
  apply (div_le_div_iff₀ hw hc).mpr
  calc
    |K| * c ≤ (a * E) * c := mul_le_mul_of_nonneg_right hK hc.le
    _ = a * (c * E) := by ring
    _ ≤ a * w := mul_le_mul_of_nonneg_left hdom ha

theorem firstJet_normalized_bound {p p1 z z1 : ℂ} {P Z L w c : ℝ}
    (hP : 0 ≤ P) (hZ : 0 ≤ Z) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L)
    (hc : 0 < c) (hw : 0 < w) (hdom : c * (P ^ 2 * L) ≤ w) :
    |firstJet p p1 z z1 / w| ≤ (4 * Z ^ 2) / c := by
  apply positiveNormalizer_quotient (E := P ^ 2 * L) (by positivity)
    (by positivity) hc hw _ hdom
  convert firstJet_bound hP hZ hL hp hp1 hz hz1 using 1
  ring

theorem secondJet_normalized_bound {p p1 p2 z z1 z2 : ℂ} {P Z L w c : ℝ}
    (hP : 0 ≤ P) (hZ : 0 ≤ Z) (hL : 0 ≤ L)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L) (hp2 : ‖p2‖ ≤ P * L ^ 2)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) (hz2 : ‖z2‖ ≤ Z * L ^ 2)
    (hc : 0 < c) (hw : 0 < w) (hdom : c * (P ^ 2 * L ^ 2) ≤ w) :
    |secondJet p p1 p2 z z1 z2 / w| ≤ (16 * Z ^ 2) / c := by
  apply positiveNormalizer_quotient (E := P ^ 2 * L ^ 2) (by positivity)
    (by positivity) hc hw _ hdom
  convert secondJet_bound hP hZ hL hp hp1 hp2 hz hz1 hz2 using 1
  ring

/-- The integral/oddness hypothesis is an input; this is its finite algebraic reduction. -/
theorem oddLayer_normalized_bound {p p1 p2 z z1 z2 : ℂ} {P Z L y K w c : ℝ}
    (hP : 0 ≤ P) (hZ : 0 ≤ Z) (hL : 0 ≤ L) (hy : 0 ≤ y)
    (hp : ‖p‖ ≤ P) (hp1 : ‖p1‖ ≤ P * L) (hp2 : ‖p2‖ ≤ P * L ^ 2)
    (hz : ‖z‖ ≤ Z) (hz1 : ‖z1‖ ≤ Z * L) (hz2 : ‖z2‖ ≤ Z * L ^ 2)
    (hc : 0 < c) (hw : 0 < w) (hdom : c * (P ^ 2 * L ^ 2 * y) ≤ w)
    (hodd : |K| ≤ |secondJet p p1 p2 z z1 z2| * y) :
    |K / w| ≤ (16 * Z ^ 2) / c := by
  apply positiveNormalizer_quotient (E := P ^ 2 * L ^ 2 * y) (by positivity)
    (by positivity) hc hw _ hdom
  calc
    |K| ≤ |secondJet p p1 p2 z z1 z2| * y := hodd
    _ ≤ (16 * P ^ 2 * Z ^ 2 * L ^ 2) * y :=
      mul_le_mul_of_nonneg_right (secondJet_bound hP hZ hL hp hp1 hp2 hz hz1 hz2) hy
    _ = (16 * Z ^ 2) * (P ^ 2 * L ^ 2 * y) := by ring

#print axioms firstJet_bound
#print axioms secondJet_bound
#print axioms positiveNormalizer_quotient
#print axioms firstJet_normalized_bound
#print axioms secondJet_normalized_bound
#print axioms oddLayer_normalized_bound

end BuildingBlocks.ThetaRadialMagnitudeAlgebra
