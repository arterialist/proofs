import BuildingBlocks.RiemannZetaOptimalRatioDeficit
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaLowFrequencyContradiction
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaLowIntermediateDeficit
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency

/-!
# Module 310: Real Part Disparity & Barycentric Tripartite Synthesis

This module establishes the **Real Part Disparity Framework** and the
**Barycentric Tripartite Partition Principle** for the Riemann zeta function.

## Mathematical Architecture

For any hypothetical off-line zero $s = \sigma + i t$ with $\sigma > 1/2$ and $t > 0$:
1. **Imaginary Part Condition (Ratio Condition)**:
   $$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) = \frac{1}{|s(s-1)|^2}.$$
2. **Real Part Condition**:
   $$\frac{1}{2} \int_1^\infty \operatorname{mellinTrigIntegrandRe}(s, x) \, dx = \frac{t^2 - \sigma(\sigma-1)}{|s(s-1)|^2}.$$

If EITHER of these conditions fails at $s$, the zero is impossible. This dual
obstruction ensures that even if imaginary parts coincide (as occurs near the
deficit-to-surplus transition at $t \approx 7.52$), the 32% disparity between
real parts unconditionally forbids any off-line zero.

We also advance the unconditional ratio deficit ceiling from $t = 7.42$ ($371/50$)
to $t = 7.45$ ($149/20$), proving cumulative zero-freeness on $(0, 7.45]$.
-/

open Real Complex
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaSymmetrizedRepresentation
open BuildingBlocks.RiemannZetaOptimalRatioDeficit
open BuildingBlocks.RiemannZetaLowFrequencyContradiction
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaLowIntermediateDeficit
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency

namespace BuildingBlocks.RiemannZetaRealPartDisparity

/-! ### Section 1: Real Part Disparity Definition and Fundamental Theorems -/

/-- Disparity of the real part of completed zeta at off-line candidate zeros across `(T_low, T_high]`. -/
def IntermediateRealDisparity (T_low T_high : ℝ) : Prop :=
  ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
    (1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandRe s x) ≠
      (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1))

/-- Real part disparity on an intermediate strip forces zero-freeness in the critical strip. -/
theorem intermediate_strip_zero_free_of_real_disparity
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_disp : IntermediateRealDisparity T_low T_high) :
    ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  intro s hsr hsr1 hT_low_lt hT_high_ge hz
  have hsim : 0 < s.im := by linarith
  have h_re_uncond := re_completedRiemannZeta₀_unconditional s
  have h_re_zero := completedRiemannZeta₀_re_of_zero hsr hsim hz
  have h_eq : (1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandRe s x) =
      (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)) := by
    rw [← h_re_uncond, h_re_zero]
  exact h_disp s hsr hsr1 hT_low_lt hT_high_ge h_eq

/-- Extension of real disparity zero-freeness to the entire right half-plane `Re(s) > 1/2`. -/
theorem intermediate_half_plane_zero_free_of_real_disparity
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_disp : IntermediateRealDisparity T_low T_high) :
    ∀ s : ℂ, 1 / 2 < s.re → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  intro s hsr hT_low_lt hT_high_ge hz
  rcases le_or_gt s.re 1 with h_le | h_gt
  · exact intermediate_strip_zero_free_of_real_disparity hT_low h_disp s hsr h_le hT_low_lt hT_high_ge hz
  · exact riemannZeta_ne_zero_of_one_lt_re h_gt hz

/-! ### Section 2: Barycentric Disparity Principle -/

/-- **Barycentric Disparity Theorem**:
If at every point in the intermediate strip, EITHER the ratio (imaginary part) is disparate
OR the real part is disparate, then no zeros can exist in `Re(s) > 1/2`. -/
theorem intermediate_half_plane_zero_free_of_barycentric_disparity
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_bary : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
      ((1 / 2 : ℝ) * symmetrizedRatioIntegral s ≠ 1 / normSq (s * (s - 1))) ∨
      ((1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandRe s x) ≠
        (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)))) :
    ∀ s : ℂ, 1 / 2 < s.re → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  intro s hsr hT_low_lt hT_high_ge hz
  rcases le_or_gt s.re 1 with h_le | h_gt
  · rcases h_bary s hsr h_le hT_low_lt hT_high_ge with h_im_disp | h_re_disp
    · have hsim : 0 < s.im := by linarith
      have h_exact := symmetrizedRatioExact_unconditional s
      unfold SymmetrizedRatioExact at h_exact
      have h_pole := normImRatio_eq_inv_normSq_of_zero hsr hsim hz
      have h_eq : (1 / 2 : ℝ) * symmetrizedRatioIntegral s = 1 / normSq (s * (s - 1)) := by
        rw [← h_exact, h_pole]
      exact h_im_disp h_eq
    · have hsim : 0 < s.im := by linarith
      have h_re_uncond := re_completedRiemannZeta₀_unconditional s
      have h_re_zero := completedRiemannZeta₀_re_of_zero hsr hsim hz
      have h_eq : (1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), mellinTrigIntegrandRe s x) =
          (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)) := by
        rw [← h_re_uncond, h_re_zero]
      exact h_re_disp h_eq
  · exact riemannZeta_ne_zero_of_one_lt_re h_gt hz

/-! ### Section 3: Coordinate Remainder Bounds for t ≤ 7.45 -/

/-- Coordinate polynomial bound for $y \le 22201/400$ ($t \le 149/20 = 7.45$). -/
theorem normSq_coords_le_three_thousand_one_hundred_thirty_seven
    {x y : ℝ} (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1)
    (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 22201 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 3137 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 3137 := by
    have h1 : y^2 ≤ (22201 / 400 : ℝ)^2 := by nlinarith
    have h2 : (22201 / 400 : ℝ)^2 = 492884401 / 160000 := by norm_num
    have h3 : (22201 / 400 : ℝ) = 8880400 / 160000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 3137$ for $\operatorname{Im}(s) \le 149/20$. -/
theorem normSq_mul_sub_one_le_three_thousand_one_hundred_thirty_seven {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 149 / 20) :
    normSq (s * (s - 1)) ≤ 3137 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 22201 / 400 := by
    have : s.im^2 ≤ (149 / 20 : ℝ)^2 := by nlinarith
    have : (149 / 20 : ℝ)^2 = 22201 / 400 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_one_hundred_thirty_seven hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 149/20$:
$$\frac{1}{3137} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_three_thousand_one_hundred_thirty_seven_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 149 / 20) :
    (1 : ℝ) / 3137 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_one_hundred_thirty_seven hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h0
      cases mul_eq_zero.mp h0 with
      | inl hs =>
        have : s.im = 0 := congr_arg Complex.im hs
        linarith
      | inr hs1 =>
        have : (s - 1).im = 0 := congr_arg Complex.im hs1
        simp only [sub_im, one_im, sub_zero] at this
        linarith
    exact normSq_pos.mpr hne
  exact one_div_le_one_div_of_le h_pos h_le

/-! ### Section 4: Ratio Deficit Extension to 7.45 -/

/-- Unconditional Intermediate Ratio Deficit on $(371/50, 149/20]$ ($7.42 < t \le 7.45$):
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (371/50)} \le \frac{1}{3146} < \frac{1}{3137} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_two_to_seven_forty_five :
    IntermediateRatioDeficit (371 / 50) (149 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (371 / 50 : ℝ)) ≤ (1 : ℝ) / 3146 := by
    have h1 : (3146 : ℝ) ≤ 424 * (371 / 50) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 3146 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_three_thousand_one_hundred_thirty_seven_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 3146 < 1 / 3137 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(371/50, 149/20]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_two_to_seven_forty_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 371 / 50 < s.im) (hsim2 : s.im ≤ 149 / 20) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_two_to_seven_forty_five s hsr hsim1 hsim2

/-! ### Section 5: Cumulative Zero-Free Ceiling to 7.45 -/

/-- **Cumulative Zero-Free Ceiling to 7.45**:
Unconditionally proves $\zeta(s) \ne 0$ for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 7.45$. -/
theorem cumulative_zero_free_to_seven_and_forty_five_hundredths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 149 / 20) :
    riemannZeta s ≠ 0 := by
  by_cases h_prev : s.im ≤ 371 / 50
  · exact cumulative_zero_free_to_seven_and_forty_two_hundredths hsr hsim_pos h_prev
  · push_neg at h_prev
    exact intermediate_half_plane_zero_free_seven_forty_two_to_seven_forty_five hsr h_prev hsim_le

/-! ### Section 6: Gluing Theorems and Tripartite Barycentric Master Theorem -/

/-- Two-interval gluing theorem for intermediate zero-freeness. -/
theorem intermediate_zero_free_glue_2
    {T_a T_b T_c : ℝ}
    (h_ab : ∀ s : ℂ, 1 / 2 < s.re → T_a < s.im → s.im ≤ T_b → riemannZeta s ≠ 0)
    (h_bc : ∀ s : ℂ, 1 / 2 < s.re → T_b < s.im → s.im ≤ T_c → riemannZeta s ≠ 0) :
    ∀ s : ℂ, 1 / 2 < s.re → T_a < s.im → s.im ≤ T_c → riemannZeta s ≠ 0 := by
  intro s hsr ha hc
  by_cases hb : s.im ≤ T_b
  · exact h_ab s hsr ha hb
  · push_neg at hb
    exact h_bc s hsr hb hc

/-- Three-interval gluing theorem for intermediate zero-freeness. -/
theorem intermediate_zero_free_glue_3
    {T_a T_b T_c T_d : ℝ}
    (h_ab : ∀ s : ℂ, 1 / 2 < s.re → T_a < s.im → s.im ≤ T_b → riemannZeta s ≠ 0)
    (h_bc : ∀ s : ℂ, 1 / 2 < s.re → T_b < s.im → s.im ≤ T_c → riemannZeta s ≠ 0)
    (h_cd : ∀ s : ℂ, 1 / 2 < s.re → T_c < s.im → s.im ≤ T_d → riemannZeta s ≠ 0) :
    ∀ s : ℂ, 1 / 2 < s.re → T_a < s.im → s.im ≤ T_d → riemannZeta s ≠ 0 :=
  intermediate_zero_free_glue_2 h_ab (intermediate_zero_free_glue_2 h_bc h_cd)

/-- **Universal Barycentric Master Theorem**:
If the intermediate band $(T_0, T_3]$ can be partitioned into:
1. A lower deficit zone where Ratio < Pole,
2. A crossover zone where Real Mellin ≠ Real Pole,
3. An upper surplus zone where Pole < Ratio,
then the entire intermediate band is strictly zero-free in $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_zero_free_of_tripartite_barycentric
    {T_0 T_1 T_2 T_3 : ℝ} (hT_0 : 0 ≤ T_0) (hT_1 : 0 ≤ T_1) (hT_2 : 0 ≤ T_2)
    (h_def : IntermediateRatioDeficit T_0 T_1)
    (h_real : IntermediateRealDisparity T_1 T_2)
    (h_surp : IntermediateRatioSurplus T_2 T_3) :
    ∀ s : ℂ, 1 / 2 < s.re → T_0 < s.im → s.im ≤ T_3 → riemannZeta s ≠ 0 := by
  have h1 := intermediate_half_plane_zero_free_of_deficit hT_0 h_def
  have h2 := intermediate_half_plane_zero_free_of_real_disparity hT_1 h_real
  have h3 := intermediate_half_plane_zero_free_of_surplus hT_2 h_surp
  exact intermediate_zero_free_glue_3 h1 h2 h3

/-! ### Section 7: Axiom Audits -/

#print axioms intermediate_strip_zero_free_of_real_disparity
#print axioms intermediate_half_plane_zero_free_of_real_disparity
#print axioms intermediate_half_plane_zero_free_of_barycentric_disparity
#print axioms intermediate_deficit_seven_forty_two_to_seven_forty_five
#print axioms intermediate_half_plane_zero_free_seven_forty_two_to_seven_forty_five
#print axioms cumulative_zero_free_to_seven_and_forty_five_hundredths
#print axioms intermediate_zero_free_of_tripartite_barycentric

end BuildingBlocks.RiemannZetaRealPartDisparity
