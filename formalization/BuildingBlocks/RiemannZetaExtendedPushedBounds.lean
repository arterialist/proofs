import BuildingBlocks.RiemannZetaExtendedRatioDeficit
import BuildingBlocks.RiemannZetaRatioSurplus
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaThresholdFredholmBridge
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaRealPartDisparity
import BuildingBlocks.RiemannZetaGrandIntermediateIntegration

/-!
# Module 328: Riemann Zeta Extended Pushed Bounds and Cumulative Zero-Freeness to 7.46818

This module advances the unconditionally verified zero-free ordinate ceiling of the Riemann
zeta function from $t = 1867/250 = 7.468$ to $t = 373409/50000 = 7.46818$.

## Mathematical Architecture

1. **Bootstrap Step 1 ($7.468 \to 7.46814$)**:
   Across $(1867/250, 373407/50000]$, the coordinate polynomial remains strictly bounded by
   $C_4 = 158321 / 50 = 3166.42$. The decay bound gives:
   $$\frac{1}{2}\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (1867/250)} = \frac{125}{395804} \le \frac{1}{3166.432} < \frac{50}{158321} \le \frac{1}{|s(s-1)|^2}.$$

2. **Bootstrap Step 2 ($7.46814 \to 7.46818$)**:
   Across $(373407/50000, 373409/50000]$, the coordinate polynomial remains strictly bounded by
   $C_5 = 316649 / 100 = 3166.49$. The decay bound gives:
   $$\frac{1}{2}\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (373407/50000)} = \frac{6250}{19790571} \le \frac{1}{3166.49136} < \frac{100}{316649} \le \frac{1}{|s(s-1)|^2}.$$

3. **Cumulative Zero-Freeness to 7.46818**:
   Extends the cumulative zero-free ceiling from $t = 7.468$ to $t = 7.46818$:
   $$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 373409/50000 \implies \zeta(s) \ne 0.$$

4. **Low-Frequency Zero-Freeness & Master Equivalence**:
   Derives `LowFrequencyZeroFree (373409 / 50000)` and proves the pushed master reduction:
   $$\text{RiemannHypothesis} \iff \text{HighFrequencyZeroFree}(373409 / 50000).$$

5. **Master Tripartite Gluing**:
   Glues cumulative zero-freeness to $7.46818$ with the crossover real part disparity and surplus.

## Axiom Status
This module depends strictly on standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No unproven hypotheses or custom axioms.
-/

open Real Complex MeasureTheory Set Filter Topology
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaOptimalRatioDeficit
open BuildingBlocks.RiemannZetaRealPartDisparity
open BuildingBlocks.RiemannZetaLowIntermediateDeficit
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaRatioSurplus
open BuildingBlocks.RiemannZetaExtendedRatioDeficit
open BuildingBlocks.RiemannZetaGrandIntermediateIntegration
open BuildingBlocks.RiemannZetaThresholdFredholmBridge

namespace BuildingBlocks.RiemannZetaExtendedPushedBounds

/-! ### Section 1: Bootstrap Step 1 Deficit Extension ($7.468 \to 7.46814$) -/

/-- Coordinate polynomial bound for coordinate norm-squared up to
$y \le 139432787649 / 2500000000$ ($t \le 373407/50000 = 7.46814$). -/
theorem normSq_coords_le_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_div_fifty {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 139432787649 / 2500000000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (158321 : ℝ) / 50 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (158321 : ℝ) / 50 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (139432787649 / 2500000000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (139432787649 / 2500000000 : ℝ)^2 = 19441502271571126947201 / 6250000000000000000 := by norm_num
    have h3 : (139432787649 / 2500000000 : ℝ) = 348581969122500000000 / 6250000000000000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 158321 / 50$ for $\operatorname{Im}(s) \le 373407/50000$. -/
theorem normSq_mul_sub_one_le_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_div_fifty {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373407 / 50000) :
    normSq (s * (s - 1)) ≤ (158321 : ℝ) / 50 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 139432787649 / 2500000000 := by
    have : s.im^2 ≤ (373407 / 50000 : ℝ)^2 := by nlinarith
    have : (373407 / 50000 : ℝ)^2 = 139432787649 / 2500000000 := by norm_num
    linarith
  exact normSq_coords_le_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_div_fifty
    hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 373407/50000$:
$$\frac{50}{158321} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem fifty_div_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373407 / 50000) :
    (1 : ℝ) / (158321 / 50) ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_div_fifty
    hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(1867/250, 373407/50000]$ ($7.468 < t \le 7.46814$):
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (1867/250)} \le \frac{1}{3166.432} < \frac{1}{3166.42} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_eight_to_seven_forty_six_eight_one_four :
    IntermediateRatioDeficit (1867 / 250) (373407 / 50000) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (1867 / 250 : ℝ)) ≤ (1 : ℝ) / (395804 / 125) := by
    have h1 : ((395804 / 125 : ℝ)) ≤ 424 * (1867 / 250) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 : ℝ) / (395804 / 125) :=
    h_decay.trans h_dec_le
  have h_inv := fifty_div_one_hundred_fifty_eight_thousand_three_hundred_twenty_one_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / (395804 / 125) < (1 : ℝ) / (158321 / 50) := by norm_num
  linarith

/-- Unconditional zero-freeness across $(1867/250, 373407/50000]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_eight_to_seven_forty_six_eight_one_four {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1867 / 250 < s.im) (hsim2 : s.im ≤ 373407 / 50000) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_eight_to_seven_forty_six_eight_one_four s hsr hsim1 hsim2

/-! ### Section 2: Bootstrap Step 2 Deficit Extension ($7.46814 \to 7.46818$) -/

/-- Coordinate polynomial bound for coordinate norm-squared up to
$y \le 139434281281 / 2500000000$ ($t \le 373409/50000 = 7.46818$). -/
theorem normSq_coords_le_three_hundred_sixteen_thousand_six_hundred_forty_nine_div_one_hundred {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 139434281281 / 2500000000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (316649 : ℝ) / 100 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (316649 : ℝ) / 100 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (139434281281 / 2500000000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (139434281281 / 2500000000 : ℝ)^2 = 19441918796349027000961 / 6250000000000000000 := by norm_num
    have h3 : (139434281281 / 2500000000 : ℝ) = 348585703202500000000 / 6250000000000000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 316649 / 100$ for $\operatorname{Im}(s) \le 373409/50000$. -/
theorem normSq_mul_sub_one_le_three_hundred_sixteen_thousand_six_hundred_forty_nine_div_one_hundred {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373409 / 50000) :
    normSq (s * (s - 1)) ≤ (316649 : ℝ) / 100 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 139434281281 / 2500000000 := by
    have : s.im^2 ≤ (373409 / 50000 : ℝ)^2 := by nlinarith
    have : (373409 / 50000 : ℝ)^2 = 139434281281 / 2500000000 := by norm_num
    linarith
  exact normSq_coords_le_three_hundred_sixteen_thousand_six_hundred_forty_nine_div_one_hundred
    hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 373409/50000$:
$$\frac{100}{316649} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_hundred_div_three_hundred_sixteen_thousand_six_hundred_forty_nine_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373409 / 50000) :
    (1 : ℝ) / (316649 / 100) ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_hundred_sixteen_thousand_six_hundred_forty_nine_div_one_hundred
    hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(373407/50000, 373409/50000]$ ($7.46814 < t \le 7.46818$):
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (373407/50000)} \le \frac{1}{3166.49136} < \frac{1}{3166.49} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_eight_one_four_to_seven_forty_six_eight_one_eight :
    IntermediateRatioDeficit (373407 / 50000) (373409 / 50000) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (373407 / 50000 : ℝ)) ≤ (1 : ℝ) / (19790571 / 6250) := by
    have h1 : ((19790571 / 6250 : ℝ)) ≤ 424 * (373407 / 50000) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 : ℝ) / (19790571 / 6250) :=
    h_decay.trans h_dec_le
  have h_inv := one_hundred_div_three_hundred_sixteen_thousand_six_hundred_forty_nine_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / (19790571 / 6250) < (1 : ℝ) / (316649 / 100) := by norm_num
  linarith

/-- Unconditional zero-freeness across $(373407/50000, 373409/50000]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_eight_one_four_to_seven_forty_six_eight_one_eight {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 373407 / 50000 < s.im) (hsim2 : s.im ≤ 373409 / 50000) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_eight_one_four_to_seven_forty_six_eight_one_eight s hsr hsim1 hsim2

/-! ### Section 3: Cumulative Zero-Free Extension to 7.46818 -/

/-- **Cumulative Zero-Free Ceiling to 7.46818**:
Unconditionally proves $\zeta(s) \ne 0$ for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 373409/50000 = 7.46818$. -/
theorem cumulative_zero_free_to_seven_four_six_eight_one_eight {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 373409 / 50000) :
    riemannZeta s ≠ 0 := by
  rcases le_or_gt s.im (1867 / 250) with h_prev | h_above1
  · exact cumulative_zero_free_to_seven_four_six_eight hsr hsim1 h_prev
  · rcases le_or_gt s.im (373407 / 50000) with h_mid | h_above2
    · exact intermediate_half_plane_zero_free_seven_forty_six_eight_to_seven_forty_six_eight_one_four
        hsr h_above1 h_mid
    · exact intermediate_half_plane_zero_free_seven_forty_six_eight_one_four_to_seven_forty_six_eight_one_eight
        hsr h_above2 hsim2

/-- CumulativeZeroFree proposition instantiated at $H = 373409 / 50000 = 7.46818$. -/
theorem cumulative_zero_free_base_seven_forty_six_eight_one_eight :
    CumulativeZeroFree (373409 / 50000) :=
  fun _ hsr hsim1 hsim2 =>
    cumulative_zero_free_to_seven_four_six_eight_one_eight hsr hsim1 hsim2

/-! ### Section 4: Low-Frequency Zero-Freeness & Master Equivalence -/

/-- Mathlib's canonical `LowFrequencyZeroFree` unconditionally certified up to $H = 373409/50000 = 7.46818$. -/
theorem lowFrequencyZeroFree_seven_forty_six_eight_one_eight :
    LowFrequencyZeroFree (373409 / 50000) :=
  lowFrequencyZeroFree_of_cumulativeZeroFree
    (by norm_num) cumulative_zero_free_base_seven_forty_six_eight_one_eight

/-- Zero-freeness on the bilateral bounded-height critical strip up to height $7.46818$. -/
theorem bounded_height_zero_free_seven_forty_six_eight_one_eight :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → |s.im| ≤ 373409 / 50000 → riemannZeta s ≠ 0 := by
  intro s hsr hs1 h_bound hz
  have h_le := lowFrequencyZeroFree_seven_forty_six_eight_one_eight s hz hs1 h_bound
  linarith

/-- Pushed Master Logical Equivalence:
`RiemannHypothesis` is logically equivalent to high-frequency zero-freeness above $7.46818$. -/
theorem rh_iff_high_frequency_seven_forty_six_eight_one_eight :
    RiemannHypothesis ↔ HighFrequencyZeroFree (373409 / 50000) := by
  constructor
  · intro rh
    exact highFrequencyZeroFree_of_RH rh (373409 / 50000)
  · intro h_high
    exact RiemannHypothesis_of_cumulative_and_high (373409 / 50000) (by norm_num)
      cumulative_zero_free_base_seven_forty_six_eight_one_eight h_high

/-- Unconditional RH deduction from high-frequency refutation above $7.46818$. -/
theorem rh_of_high_frequency_seven_forty_six_eight_one_eight :
    HighFrequencyZeroFree (373409 / 50000) → RiemannHypothesis :=
  rh_iff_high_frequency_seven_forty_six_eight_one_eight.mpr

/-- High-frequency zero-freeness above $7.46818$ from Riemann Hypothesis. -/
theorem high_frequency_of_rh_seven_forty_six_eight_one_eight :
    RiemannHypothesis → HighFrequencyZeroFree (373409 / 50000) :=
  rh_iff_high_frequency_seven_forty_six_eight_one_eight.mp

/-! ### Section 5: Master Tripartite Gluing Synthesis from 7.46818 -/

/-- Master Tripartite Gluing Theorem extending cumulative zero-freeness from $7.46818$:
Combines cumulative deficit to $7.46818$ with crossover real disparity and surplus. -/
theorem cumulative_zero_free_tripartite_from_seven_four_six_eight_one_eight
    {T_2 T_3 : ℝ} (hT_2 : 373409 / 50000 ≤ T_2)
    (h_real : IntermediateRealDisparity (373409 / 50000) T_2)
    (h_surp : IntermediateRatioSurplus T_2 T_3) :
    ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → s.im ≤ T_3 → riemannZeta s ≠ 0 := by
  intro s hsr hsim_pos hsim_le
  rcases le_or_gt s.im (373409 / 50000) with h_def | h_above
  · exact cumulative_zero_free_to_seven_four_six_eight_one_eight hsr hsim_pos h_def
  · rcases le_or_gt s.im T_2 with h_mid | h_surp_zone
    · exact intermediate_half_plane_zero_free_of_real_disparity
        (by norm_num) h_real s hsr h_above h_mid
    · exact intermediate_half_plane_zero_free_of_surplus
        (by linarith) h_surp s hsr h_surp_zone hsim_le

end BuildingBlocks.RiemannZetaExtendedPushedBounds
