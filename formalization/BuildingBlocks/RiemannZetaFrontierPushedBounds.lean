import BuildingBlocks.RiemannZetaExtendedPushedBounds
import BuildingBlocks.RiemannZetaExtendedRatioDeficit
import BuildingBlocks.RiemannZetaRatioSurplus
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaThresholdFredholmBridge
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaRealPartDisparity
import BuildingBlocks.RiemannZetaGrandIntermediateIntegration

/-!
# Module 332: Riemann Zeta Frontier Pushed Bounds and Cumulative Zero-Freeness to 7.46820

This module advances the unconditionally verified zero-free ordinate ceiling of the Riemann
zeta function from $t = 373409 / 50000 = 7.46818$ to $t = 37341 / 5000 = 7.46820$.

## Mathematical Architecture

1. **Bootstrap Step 1 ($7.46818 \to 7.468195$)**:
   Across $(373409/50000, 1493639/200000]$, the coordinate polynomial remains strictly bounded by
   $C_6 = 3166507 / 1000 = 3166.507$. The decay bound gives:
   $$\frac{1}{2}\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (373409/50000)} = \frac{6250}{19790677} \le \frac{1}{3166.50832} < \frac{1000}{3166507} \le \frac{1}{|s(s-1)|^2}.$$

2. **Bootstrap Step 2 ($7.468195 \to 7.46820$)**:
   Across $(1493639/200000, 37341/5000]$, the coordinate polynomial remains strictly bounded by
   $C_7 = 6333029 / 2000 = 3166.5145$. The decay bound gives:
   $$\frac{1}{2}\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (1493639/200000)} = \frac{25000}{79162867} \le \frac{1}{3166.51468} < \frac{2000}{6333029} \le \frac{1}{|s(s-1)|^2}.$$

3. **Cumulative Zero-Freeness to 7.46820**:
   Extends the cumulative zero-free ceiling from $t = 7.46818$ to $t = 7.46820$:
   $$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 37341/5000 \implies \zeta(s) \ne 0.$$

4. **Low-Frequency Zero-Freeness & Master Equivalence**:
   Derives `LowFrequencyZeroFree (37341 / 5000)` and proves the pushed master reduction:
   $$\text{RiemannHypothesis} \iff \text{HighFrequencyZeroFree}(37341 / 5000).$$

5. **Master Tripartite Gluing**:
   Glues cumulative zero-freeness to $7.46820$ with the crossover real part disparity and surplus.

## Axiom Status
This module depends strictly on standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`, with 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
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
open BuildingBlocks.RiemannZetaExtendedPushedBounds
open BuildingBlocks.RiemannZetaGrandIntermediateIntegration
open BuildingBlocks.RiemannZetaThresholdFredholmBridge

namespace BuildingBlocks.RiemannZetaFrontierPushedBounds

/-! ### Section 1: Bootstrap Step 1 Deficit Extension ($7.46818 \to 7.468195$) -/

/-- Coordinate polynomial bound for coordinate norm-squared up to
$y \le 2230957462321 / 40000000000$ ($t \le 1493639/200000 = 7.468195$). -/
theorem normSq_coords_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 2230957462321 / 40000000000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (3166507 : ℝ) / 1000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (3166507 : ℝ) / 1000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (2230957462321 / 40000000000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (2230957462321 / 40000000000 : ℝ)^2 = 4977171198685756134707041 / 1600000000000000000000 := by norm_num
    have h3 : (2230957462321 / 40000000000 : ℝ) = 89238298492840000000000 / 1600000000000000000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 3166507 / 1000$ for $\operatorname{Im}(s) \le 1493639/200000$. -/
theorem normSq_mul_sub_one_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1493639 / 200000) :
    normSq (s * (s - 1)) ≤ (3166507 : ℝ) / 1000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 2230957462321 / 40000000000 := by
    have : s.im^2 ≤ (1493639 / 200000 : ℝ)^2 := by nlinarith
    have : (1493639 / 200000 : ℝ)^2 = 2230957462321 / 40000000000 := by norm_num
    linarith
  exact normSq_coords_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand
    hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 1493639/200000$:
$$\frac{1000}{3166507} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_thousand_div_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1493639 / 200000) :
    (1 : ℝ) / (3166507 / 1000) ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand
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

/-- Unconditional Intermediate Ratio Deficit on $(373409/50000, 1493639/200000]$ ($7.46818 < t \le 7.468195$):
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (373409/50000)} \le \frac{1}{3166.50832} < \frac{1}{3166.507} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five :
    IntermediateRatioDeficit (373409 / 50000) (1493639 / 200000) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (373409 / 50000 : ℝ)) ≤ (1 : ℝ) / (19790677 / 6250) := by
    have h1 : ((19790677 / 6250 : ℝ)) ≤ 424 * (373409 / 50000) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 : ℝ) / (19790677 / 6250) :=
    h_decay.trans h_dec_le
  have h_inv := one_thousand_div_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / (19790677 / 6250) < (1 : ℝ) / (3166507 / 1000) := by norm_num
  linarith

/-- Unconditional zero-freeness across $(373409/50000, 1493639/200000]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 373409 / 50000 < s.im) (hsim2 : s.im ≤ 1493639 / 200000) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five s hsr hsim1 hsim2

/-! ### Section 2: Bootstrap Step 2 Deficit Extension ($7.468195 \to 7.46820$) -/

/-- Coordinate polynomial bound for coordinate norm-squared up to
$y \le 1394350281 / 25000000$ ($t \le 37341/5000 = 7.46820$). -/
theorem normSq_coords_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 1394350281 / 25000000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (6333029 : ℝ) / 2000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (6333029 : ℝ) / 2000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (1394350281 / 25000000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (1394350281 / 25000000 : ℝ)^2 = 1944212706124778961 / 625000000000000 := by norm_num
    have h3 : (1394350281 / 25000000 : ℝ) = 34858757025000000 / 625000000000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 6333029 / 2000$ for $\operatorname{Im}(s) \le 37341/5000$. -/
theorem normSq_mul_sub_one_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 37341 / 5000) :
    normSq (s * (s - 1)) ≤ (6333029 : ℝ) / 2000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 1394350281 / 25000000 := by
    have : s.im^2 ≤ (37341 / 5000 : ℝ)^2 := by nlinarith
    have : (37341 / 5000 : ℝ)^2 = 1394350281 / 25000000 := by norm_num
    linarith
  exact normSq_coords_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand
    hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 37341/5000$:
$$\frac{2000}{6333029} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem two_thousand_div_six_million_three_hundred_thirty_three_thousand_twenty_nine_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 37341 / 5000) :
    (1 : ℝ) / (6333029 / 2000) ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand
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

/-- Unconditional Intermediate Ratio Deficit on $(1493639/200000, 37341/5000]$ ($7.468195 < t \le 7.46820$):
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (1493639/200000)} \le \frac{1}{3166.51468} < \frac{1}{3166.5145} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two :
    IntermediateRatioDeficit (1493639 / 200000) (37341 / 5000) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (1493639 / 200000 : ℝ)) ≤ (1 : ℝ) / (79162867 / 25000) := by
    have h1 : ((79162867 / 25000 : ℝ)) ≤ 424 * (1493639 / 200000) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 : ℝ) / (79162867 / 25000) :=
    h_decay.trans h_dec_le
  have h_inv := two_thousand_div_six_million_three_hundred_thirty_three_thousand_twenty_nine_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / (79162867 / 25000) < (1 : ℝ) / (6333029 / 2000) := by norm_num
  linarith

/-- Unconditional zero-freeness across $(1493639/200000, 37341/5000]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1493639 / 200000 < s.im) (hsim2 : s.im ≤ 37341 / 5000) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two s hsr hsim1 hsim2

/-! ### Section 3: Cumulative Zero-Free Extension to 7.46820 -/

/-- **Cumulative Zero-Free Ceiling to 7.46820**:
Unconditionally proves $\zeta(s) \ne 0$ for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 37341/5000 = 7.46820$. -/
theorem cumulative_zero_free_to_seven_four_six_eight_two {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 37341 / 5000) :
    riemannZeta s ≠ 0 := by
  rcases le_or_gt s.im (373409 / 50000) with h_prev | h_above1
  · exact cumulative_zero_free_to_seven_four_six_eight_one_eight hsr hsim1 h_prev
  · rcases le_or_gt s.im (1493639 / 200000) with h_mid | h_above2
    · exact intermediate_half_plane_zero_free_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five
        hsr h_above1 h_mid
    · exact intermediate_half_plane_zero_free_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two
        hsr h_above2 hsim2

/-- CumulativeZeroFree proposition instantiated at $H = 37341 / 5000 = 7.46820$. -/
theorem cumulative_zero_free_base_seven_forty_six_eight_two :
    CumulativeZeroFree (37341 / 5000) :=
  fun _ hsr hsim1 hsim2 =>
    cumulative_zero_free_to_seven_four_six_eight_two hsr hsim1 hsim2

/-! ### Section 4: Low-Frequency Zero-Freeness & Master Equivalence -/

/-- Mathlib's canonical `LowFrequencyZeroFree` unconditionally certified up to $H = 37341/5000 = 7.46820$. -/
theorem lowFrequencyZeroFree_seven_forty_six_eight_two :
    LowFrequencyZeroFree (37341 / 5000) :=
  lowFrequencyZeroFree_of_cumulativeZeroFree
    (by norm_num) cumulative_zero_free_base_seven_forty_six_eight_two

/-- Zero-freeness on the bilateral bounded-height critical strip up to height $7.46820$. -/
theorem bounded_height_zero_free_seven_forty_six_eight_two :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → |s.im| ≤ 37341 / 5000 → riemannZeta s ≠ 0 := by
  intro s hsr hs1 h_bound hz
  have h_le := lowFrequencyZeroFree_seven_forty_six_eight_two s hz hs1 h_bound
  linarith

/-- Pushed Master Logical Equivalence:
`RiemannHypothesis` is logically equivalent to high-frequency zero-freeness above $7.46820$. -/
theorem rh_iff_high_frequency_seven_forty_six_eight_two :
    RiemannHypothesis ↔ HighFrequencyZeroFree (37341 / 5000) := by
  constructor
  · intro rh
    exact highFrequencyZeroFree_of_RH rh (37341 / 5000)
  · intro h_high
    exact RiemannHypothesis_of_cumulative_and_high (37341 / 5000) (by norm_num)
      cumulative_zero_free_base_seven_forty_six_eight_two h_high

/-- Unconditional RH deduction from high-frequency refutation above $7.46820$. -/
theorem rh_of_high_frequency_seven_forty_six_eight_two :
    HighFrequencyZeroFree (37341 / 5000) → RiemannHypothesis :=
  rh_iff_high_frequency_seven_forty_six_eight_two.mpr

/-- High-frequency zero-freeness above $7.46820$ from Riemann Hypothesis. -/
theorem high_frequency_of_rh_seven_forty_six_eight_two :
    RiemannHypothesis → HighFrequencyZeroFree (37341 / 5000) :=
  rh_iff_high_frequency_seven_forty_six_eight_two.mp

/-! ### Section 5: Master Tripartite Gluing Synthesis from 7.46820 -/

/-- Master Tripartite Gluing Theorem extending cumulative zero-freeness from $7.46820$:
Combines cumulative deficit to $7.46820$ with crossover real disparity and surplus. -/
theorem cumulative_zero_free_tripartite_from_seven_four_six_eight_two
    {T_2 T_3 : ℝ} (hT_2 : 37341 / 5000 ≤ T_2)
    (h_real : IntermediateRealDisparity (37341 / 5000) T_2)
    (h_surp : IntermediateRatioSurplus T_2 T_3) :
    ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → s.im ≤ T_3 → riemannZeta s ≠ 0 := by
  intro s hsr hsim_pos hsim_le
  rcases le_or_gt s.im (37341 / 5000) with h_def | h_above
  · exact cumulative_zero_free_to_seven_four_six_eight_two hsr hsim_pos h_def
  · rcases le_or_gt s.im T_2 with h_mid | h_surp_zone
    · exact intermediate_half_plane_zero_free_of_real_disparity
        (by norm_num) h_real s hsr h_above h_mid
    · exact intermediate_half_plane_zero_free_of_surplus
        (by linarith) h_surp s hsr h_surp_zone hsim_le

/-! ### Section 6: In-File Declarative Axiom Audits -/

#print axioms normSq_coords_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand
#print axioms normSq_mul_sub_one_le_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_div_one_thousand
#print axioms one_thousand_div_three_million_one_hundred_sixty_six_thousand_five_hundred_seven_le_inv_normSq
#print axioms intermediate_deficit_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five
#print axioms intermediate_half_plane_zero_free_seven_forty_six_eight_one_eight_to_seven_forty_six_eight_one_nine_five
#print axioms normSq_coords_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand
#print axioms normSq_mul_sub_one_le_six_million_three_hundred_thirty_three_thousand_twenty_nine_div_two_thousand
#print axioms two_thousand_div_six_million_three_hundred_thirty_three_thousand_twenty_nine_le_inv_normSq
#print axioms intermediate_deficit_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two
#print axioms intermediate_half_plane_zero_free_seven_forty_six_eight_one_nine_five_to_seven_forty_six_eight_two
#print axioms cumulative_zero_free_to_seven_four_six_eight_two
#print axioms cumulative_zero_free_base_seven_forty_six_eight_two
#print axioms lowFrequencyZeroFree_seven_forty_six_eight_two
#print axioms bounded_height_zero_free_seven_forty_six_eight_two
#print axioms rh_iff_high_frequency_seven_forty_six_eight_two
#print axioms rh_of_high_frequency_seven_forty_six_eight_two
#print axioms high_frequency_of_rh_seven_forty_six_eight_two
#print axioms cumulative_zero_free_tripartite_from_seven_four_six_eight_two

end BuildingBlocks.RiemannZetaFrontierPushedBounds
