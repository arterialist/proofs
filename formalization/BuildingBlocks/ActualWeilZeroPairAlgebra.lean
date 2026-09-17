import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic

namespace BuildingBlocks.ActualWeilZeroPairAlgebra

/-- The translated-bump multiplier has reciprocal factors in the complete
Weil zero-side convolution. The inverse here is essential: replacing it by
the complex conjugate would reverse the selected-zero sign. -/
theorem reciprocal_bump_factor (z : ℂ) (hz : z ≠ 0) :
    (1 - z) * (1 - z⁻¹) = 2 - z - z⁻¹ := by
  calc
    (1 - z) * (1 - z⁻¹) = 1 - z - z⁻¹ + z * z⁻¹ := by ring
    _ = 2 - z - z⁻¹ := by simp [hz]; ring

/-- For the reflected zero the translated-bump multiplier is the inverse
of the conjugate of the original one. Its two factors swap order, so the
full zero-side contribution is still the complex conjugate. -/
theorem reflected_bump_factor (W z : ℂ) :
    (star W) * ((1 - (star z)⁻¹) * (1 - star z)) =
      star (W * ((1 - z) * (1 - z⁻¹))) := by
  simp [star_mul, mul_comm]

/-- The right-half zero and its left-half reflection give twice the real
part of the right-half contribution. -/
theorem paired_bump_factor (W z : ℂ) (hz : z ≠ 0) :
    (W * ((1 - z) * (1 - z⁻¹))).re +
      ((star W) * ((1 - (star z)⁻¹) * (1 - star z))).re =
      2 * (W * (2 - z - z⁻¹)).re := by
  rw [reflected_bump_factor]
  simp only [Complex.star_def, Complex.conj_re]
  rw [reciprocal_bump_factor z hz]
  ring

/-- Once the oscillatory growing coefficient has positive real part,
the reflected pair has a negative term linear in the growth factor.
The two remaining real parts are bounded separately in the analytic
zero-sum argument. -/
theorem central_pair_upper (W u : ℂ) (r b M : ℝ)
    (hr : 0 < r) (hmain : b ≤ (W * u).re)
    (hbase : W.re ≤ M) (htail : -(W * star u).re ≤ M) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * M + 2 * M / r - 2 * b * r := by
  have hsplit :
      (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re =
        2 * W.re - r * (W * u).re - (W * star u).re / r := by
    have hdiv : (W * (star u / (r : ℂ))).re =
        (W * star u).re / r := by
      rw [div_eq_mul_inv, ← mul_assoc, ← Complex.ofReal_inv,
        Complex.re_mul_ofReal]
      ring
    simp only [mul_sub, Complex.sub_re, ← mul_assoc]
    rw [show (W * (2 : ℂ)).re = 2 * W.re by
      simp [Complex.mul_re]
      ring]
    rw [Complex.re_mul_ofReal]
    rw [hdiv]
    ring
  have hma : b * r ≤ (W * u).re * r :=
    mul_le_mul_of_nonneg_right hmain (le_of_lt hr)
  have hta : -(W * star u).re / r ≤ M / r :=
    div_le_div_of_nonneg_right htail (le_of_lt hr)
  have hta' : -((W * star u).re / r) ≤ M / r := by
    simpa only [neg_div] using hta
  have hbase4 : 4 * W.re ≤ 4 * M := by linarith
  have hmain2 : 2 * (b * r) ≤ 2 * ((W * u).re * r) := by
    linarith [hma]
  have htail2 : 2 * (-(W * star u).re / r) ≤ 2 * (M / r) := by
    linarith [hta']
  calc
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re =
        (4 * W.re - 2 * ((W * u).re * r)) +
          2 * (-(W * star u).re / r) := by rw [hsplit]; ring
    _ ≤ (4 * M - 2 * (b * r)) + 2 * (M / r) :=
      add_le_add (sub_le_sub hbase4 hmain2) htail2
    _ = 4 * M + 2 * M / r - 2 * b * r := by ring

/-- The phase has unit modulus for a real ordinate offset. This is the
version used for each zero in the central window. -/
theorem central_pair_upper_norm (W u : ℂ) (r b : ℝ)
    (hr : 0 < r) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * ‖W‖ + 2 * ‖W‖ / r - 2 * b * r := by
  have hbase : W.re ≤ ‖W‖ := Complex.re_le_norm W
  have htail : -(W * star u).re ≤ ‖W‖ := by
    have h := Complex.re_le_norm (-(W * star u))
    simpa [norm_mul, hu] using h
  exact central_pair_upper W u r b ‖W‖ hr hmain hbase htail

end BuildingBlocks.ActualWeilZeroPairAlgebra

#print axioms BuildingBlocks.ActualWeilZeroPairAlgebra.reciprocal_bump_factor
#print axioms BuildingBlocks.ActualWeilZeroPairAlgebra.reflected_bump_factor
#print axioms BuildingBlocks.ActualWeilZeroPairAlgebra.paired_bump_factor
#print axioms BuildingBlocks.ActualWeilZeroPairAlgebra.central_pair_upper
#print axioms BuildingBlocks.ActualWeilZeroPairAlgebra.central_pair_upper_norm
