import BuildingBlocks.RiemannZetaRealPartDisparity
import BuildingBlocks.RiemannZetaOptimalRatioDeficit
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaLowIntermediateDeficit
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaMellinIntegralDomination

/-!
# Module 311: Riemann Zeta Ratio Surplus, Power-Four Pole Decay, and Cumulative Extension to 7.465

This module formalizes:
1. **Deficit Bootstrap to $t = 7.46$ ($373/50$) and $t = 7.465$ ($1493/200$)**:
   Extends the unconditional intermediate ratio deficit to $t = 1493/200 = 7.465$.
   On $[149/20, 373/50]$, $(1/2)\operatorname{symmetrizedRatioIntegral}(s) \le 1/3158 < 1/3153 \le 1/|s(s-1)|^2$.
   On $[373/50, 1493/200]$, $(1/2)\operatorname{symmetrizedRatioIntegral}(s) \le 1/3163 < 1/3162 \le 1/|s(s-1)|^2$.

2. **Cumulative Zero-Free Extension to $t = 7.465$**:
   Combines all previous deficit intervals with the new bootstrap steps to establish:
   $$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 1493/200 \implies \zeta(s) \ne 0.$$

3. **Power-Four Pole Decay Theorems in the Upper Strip**:
   Proves the unconditional lower bound:
   $$|s(s-1)|^2 \ge \operatorname{Im}(s)^4 \implies \frac{1}{|s(s-1)|^2} \le \frac{1}{\operatorname{Im}(s)^4}.$$
   Instantiates exact upper bounds:
   - For $t \ge 8$: $\frac{1}{|s(s-1)|^2} \le \frac{1}{4096}$.
   - For $t \ge 10$: $\frac{1}{|s(s-1)|^2} \le \frac{1}{10000}$.
   - For $t \ge 14$: $\frac{1}{|s(s-1)|^2} \le \frac{1}{38416}$.

4. **Ratio Surplus Criteria and Master Tripartite Gluing**:
   Formalizes the transfer from power-four pole decay to `IntermediateRatioSurplus`,
   and proves the Master Tripartite Gluing Theorem extending unconditional zero-freeness
   across cumulative deficit, crossover real disparity, and surplus regimes.

## Axiom Status
This module depends strictly on standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No unproven hypotheses or ad hoc axioms are introduced.
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

namespace BuildingBlocks.RiemannZetaRatioSurplus

/-! ### Section 1: Bootstrap Deficit Extension to 7.46 (373/50) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 139129/2500$ ($t \le 373/50 = 7.46$). -/
theorem normSq_coords_le_three_thousand_one_hundred_fifty_three {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 139129 / 2500) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 3153 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 3153 := by
    have h1 : y^2 ≤ (139129 / 2500 : ℝ)^2 := by nlinarith
    have h2 : (139129 / 2500 : ℝ)^2 = 19356878641 / 6250000 := by norm_num
    have h3 : (139129 / 2500 : ℝ) = 347822500 / 6250000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 3153$ for $\operatorname{Im}(s) \le 373/50$. -/
theorem normSq_mul_sub_one_le_three_thousand_one_hundred_fifty_three {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373 / 50) :
    normSq (s * (s - 1)) ≤ 3153 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 139129 / 2500 := by
    have : s.im^2 ≤ (373 / 50 : ℝ)^2 := by nlinarith
    have : (373 / 50 : ℝ)^2 = 139129 / 2500 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_one_hundred_fifty_three hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 373/50$:
$$\frac{1}{3153} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_three_thousand_one_hundred_fifty_three_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 373 / 50) :
    (1 : ℝ) / 3153 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_one_hundred_fifty_three hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(149/20, 373/50]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (149/20)} \le \frac{1}{3158} < \frac{1}{3153} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_five_to_seven_forty_six :
    IntermediateRatioDeficit (149 / 20) (373 / 50) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (149 / 20 : ℝ)) ≤ (1 : ℝ) / 3158 := by
    have h1 : (3158 : ℝ) ≤ 424 * (149 / 20) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 3158 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_three_thousand_one_hundred_fifty_three_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 3158 < 1 / 3153 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(149/20, 373/50]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_five_to_seven_forty_six {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 149 / 20 < s.im) (hsim2 : s.im ≤ 373 / 50) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_five_to_seven_forty_six s hsr hsim1 hsim2

/-! ### Section 2: Bootstrap Deficit Extension to 7.465 (1493/200) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 2229049/40000$ ($t \le 1493/200 = 7.465$). -/
theorem normSq_coords_le_three_thousand_one_hundred_sixty_two {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 2229049 / 40000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 3162 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 3162 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (2229049 / 40000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (2229049 / 40000 : ℝ)^2 = 4968659444401 / 1600000000 := by norm_num
    have h3 : (2229049 / 40000 : ℝ) = 89161960000 / 1600000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 3162$ for $\operatorname{Im}(s) \le 1493/200$. -/
theorem normSq_mul_sub_one_le_three_thousand_one_hundred_sixty_two {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1493 / 200) :
    normSq (s * (s - 1)) ≤ 3162 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 2229049 / 40000 := by
    have : s.im^2 ≤ (1493 / 200 : ℝ)^2 := by nlinarith
    have : (1493 / 200 : ℝ)^2 = 2229049 / 40000 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_one_hundred_sixty_two hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 1493/200$:
$$\frac{1}{3162} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_three_thousand_one_hundred_sixty_two_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1493 / 200) :
    (1 : ℝ) / 3162 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_one_hundred_sixty_two hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(373/50, 1493/200]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (373/50)} \le \frac{1}{3163} < \frac{1}{3162} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_to_seven_forty_six_five :
    IntermediateRatioDeficit (373 / 50) (1493 / 200) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (373 / 50 : ℝ)) ≤ (1 : ℝ) / 3163 := by
    have h1 : (3163 : ℝ) ≤ 424 * (373 / 50) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 3163 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_three_thousand_one_hundred_sixty_two_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 3163 < 1 / 3162 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(373/50, 1493/200]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_to_seven_forty_six_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 373 / 50 < s.im) (hsim2 : s.im ≤ 1493 / 200) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_to_seven_forty_six_five s hsr hsim1 hsim2

/-! ### Section 3: Cumulative Zero-Freeness Extension to 7.465 -/

/-- Cumulative zero-freeness extended unconditionally to $t = 1493/200 = 7.465$:
For all $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 1493/200$, $\zeta(s) \ne 0$. -/
theorem cumulative_zero_free_to_seven_four_six_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 1493 / 200) :
    riemannZeta s ≠ 0 := by
  rcases le_or_gt s.im (149 / 20) with h_prev | h_above1
  · exact cumulative_zero_free_to_seven_and_forty_five_hundredths hsr hsim1 h_prev
  · rcases le_or_gt s.im (373 / 50) with h_mid | h_above2
    · exact intermediate_half_plane_zero_free_seven_forty_five_to_seven_forty_six
        hsr h_above1 h_mid
    · exact intermediate_half_plane_zero_free_seven_forty_six_to_seven_forty_six_five
        hsr h_above2 hsim2

/-! ### Section 4: Power-Four Pole Asymptotic Decay in the Upper Strip -/

/-- For any $s \in \mathbb{C}$, $\operatorname{normSq}(s(s-1))$ is bounded below by $\operatorname{Im}(s)^4$. -/
theorem normSq_mul_sub_one_ge_im_pow_four (s : ℂ) :
    s.im ^ 4 ≤ normSq (s * (s - 1)) := by
  rw [normSq_mul_sub_one_eq_coords]
  have h1 : s.im ^ 2 ≤ s.re ^ 2 + s.im ^ 2 := by
    have : 0 ≤ s.re ^ 2 := sq_nonneg s.re
    linarith
  have h2 : s.im ^ 2 ≤ (s.re - 1) ^ 2 + s.im ^ 2 := by
    have : 0 ≤ (s.re - 1) ^ 2 := sq_nonneg (s.re - 1)
    linarith
  have h3 : 0 ≤ s.re ^ 2 + s.im ^ 2 := by positivity
  have h_mul : s.im ^ 2 * s.im ^ 2 ≤ (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) :=
    mul_le_mul h1 h2 (sq_nonneg s.im) h3
  have h4 : s.im ^ 4 = s.im ^ 2 * s.im ^ 2 := by ring
  linarith

/-- The inverse normSq is bounded above by $1 / \operatorname{Im}(s)^4$ for $\operatorname{Im}(s) > 0$. -/
theorem inv_normSq_le_inv_im_pow_four {s : ℂ} (hsim : 0 < s.im) :
    1 / normSq (s * (s - 1)) ≤ 1 / s.im ^ 4 := by
  have h_ge := normSq_mul_sub_one_ge_im_pow_four s
  have h_pos : 0 < s.im ^ 4 := by positivity
  exact one_div_le_one_div_of_le h_pos h_ge

/-- For $t \ge 8$, the pole term $1/|s(s-1)|^2$ is strictly bounded above by $1/4096$. -/
theorem inv_normSq_le_one_div_4096 {s : ℂ} (hsim : 8 ≤ s.im) :
    1 / normSq (s * (s - 1)) ≤ (1 : ℝ) / 4096 := by
  have hsim_pos : 0 < s.im := by linarith
  have h_le := inv_normSq_le_inv_im_pow_four hsim_pos
  have h_t4 : (4096 : ℝ) ≤ s.im ^ 4 := by
    have h1 : (8 : ℝ) ^ 4 ≤ s.im ^ 4 :=
      pow_le_pow_left₀ (by norm_num) hsim 4
    have h2 : (8 : ℝ) ^ 4 = 4096 := by norm_num
    linarith
  have h_inv : 1 / s.im ^ 4 ≤ (1 : ℝ) / 4096 :=
    one_div_le_one_div_of_le (by norm_num) h_t4
  exact h_le.trans h_inv

/-- For $t \ge 10$, the pole term $1/|s(s-1)|^2$ is strictly bounded above by $1/10000$. -/
theorem inv_normSq_le_one_div_10000 {s : ℂ} (hsim : 10 ≤ s.im) :
    1 / normSq (s * (s - 1)) ≤ (1 : ℝ) / 10000 := by
  have hsim_pos : 0 < s.im := by linarith
  have h_le := inv_normSq_le_inv_im_pow_four hsim_pos
  have h_t4 : (10000 : ℝ) ≤ s.im ^ 4 := by
    have h1 : (10 : ℝ) ^ 4 ≤ s.im ^ 4 :=
      pow_le_pow_left₀ (by norm_num) hsim 4
    have h2 : (10 : ℝ) ^ 4 = 10000 := by norm_num
    linarith
  have h_inv : 1 / s.im ^ 4 ≤ (1 : ℝ) / 10000 :=
    one_div_le_one_div_of_le (by norm_num) h_t4
  exact h_le.trans h_inv

/-- For $t \ge 14$, the pole term $1/|s(s-1)|^2$ is strictly bounded above by $1/38416$. -/
theorem inv_normSq_le_one_div_38416 {s : ℂ} (hsim : 14 ≤ s.im) :
    1 / normSq (s * (s - 1)) ≤ (1 : ℝ) / 38416 := by
  have hsim_pos : 0 < s.im := by linarith
  have h_le := inv_normSq_le_inv_im_pow_four hsim_pos
  have h_t4 : (38416 : ℝ) ≤ s.im ^ 4 := by
    have h1 : (14 : ℝ) ^ 4 ≤ s.im ^ 4 :=
      pow_le_pow_left₀ (by norm_num) hsim 4
    have h2 : (14 : ℝ) ^ 4 = 38416 := by norm_num
    linarith
  have h_inv : 1 / s.im ^ 4 ≤ (1 : ℝ) / 38416 :=
    one_div_le_one_div_of_le (by norm_num) h_t4
  exact h_le.trans h_inv

/-! ### Section 5: Ratio Surplus Criteria and Refutation Theorems -/

/-- Ratio Surplus is established whenever the halved ratio integral is strictly greater than $1/T_{\mathrm{low}}^4$. -/
theorem intermediate_surplus_of_inv_pow_four_bound {T_low T_high : ℝ} (hT_low : 0 < T_low)
    (h_ratio_lower : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
      1 / T_low ^ 4 < (1 / 2 : ℝ) * symmetrizedRatioIntegral s) :
    IntermediateRatioSurplus T_low T_high := by
  intro s hsr1 hsr2 hsim1 hsim2
  have hsim_pos : 0 < s.im := hT_low.trans hsim1
  have h_pole_le : 1 / normSq (s * (s - 1)) ≤ 1 / s.im ^ 4 :=
    inv_normSq_le_inv_im_pow_four hsim_pos
  have h_t_ge : T_low ^ 4 < s.im ^ 4 := by
    have : T_low < s.im := hsim1
    exact pow_lt_pow_left₀ this (le_of_lt hT_low) (by norm_num)
  have h_inv_t : 1 / s.im ^ 4 < 1 / T_low ^ 4 :=
    one_div_lt_one_div_of_lt (by positivity) h_t_ge
  have h_lower := h_ratio_lower s hsr1 hsr2 hsim1 hsim2
  exact (h_pole_le.trans_lt h_inv_t).trans h_lower

/-- Zero-freeness across a surplus window from a uniform lower bound. -/
theorem intermediate_half_plane_zero_free_of_surplus_lower_bound
    {T_low T_high : ℝ} (hT_low : 0 < T_low)
    (h_ratio_lower : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
      1 / T_low ^ 4 < (1 / 2 : ℝ) * symmetrizedRatioIntegral s) :
    ∀ s : ℂ, 1 / 2 < s.re → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  have h_surp := intermediate_surplus_of_inv_pow_four_bound hT_low h_ratio_lower
  exact intermediate_half_plane_zero_free_of_surplus (le_of_lt hT_low) h_surp

/-! ### Section 6: Master Tripartite Gluing Synthesis -/

/-- Master Tripartite Gluing Theorem extending cumulative zero-freeness to $T_3$:
Combines cumulative deficit to $7.465$ with crossover real disparity and surplus. -/
theorem cumulative_zero_free_tripartite_to_T3
    {T_2 T_3 : ℝ} (hT_2 : 1493 / 200 ≤ T_2)
    (h_real : IntermediateRealDisparity (1493 / 200) T_2)
    (h_surp : IntermediateRatioSurplus T_2 T_3) :
    ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → s.im ≤ T_3 → riemannZeta s ≠ 0 := by
  intro s hsr hsim_pos hsim_le
  rcases le_or_gt s.im (1493 / 200) with h_def | h_above
  · exact cumulative_zero_free_to_seven_four_six_five hsr hsim_pos h_def
  · rcases le_or_gt s.im T_2 with h_mid | h_surp_zone
    · exact intermediate_half_plane_zero_free_of_real_disparity
        (by norm_num) h_real s hsr h_above h_mid
    · exact intermediate_half_plane_zero_free_of_surplus
        (by linarith) h_surp s hsr h_surp_zone hsim_le

end BuildingBlocks.RiemannZetaRatioSurplus

#print axioms BuildingBlocks.RiemannZetaRatioSurplus.cumulative_zero_free_to_seven_four_six_five
#print axioms BuildingBlocks.RiemannZetaRatioSurplus.inv_normSq_le_one_div_4096
#print axioms BuildingBlocks.RiemannZetaRatioSurplus.inv_normSq_le_one_div_10000
#print axioms BuildingBlocks.RiemannZetaRatioSurplus.inv_normSq_le_one_div_38416
#print axioms BuildingBlocks.RiemannZetaRatioSurplus.intermediate_half_plane_zero_free_of_surplus_lower_bound
#print axioms BuildingBlocks.RiemannZetaRatioSurplus.cumulative_zero_free_tripartite_to_T3
