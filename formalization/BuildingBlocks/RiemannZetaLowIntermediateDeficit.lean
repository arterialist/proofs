import Mathlib
import BuildingBlocks.RiemannZetaThresholdSynthesis
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaPhaseContradiction
import BuildingBlocks.RiemannZetaLowFrequencyContradiction
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency

/-!
# RiemannZetaLowIntermediateDeficit

This module formalizes **Module 305**: the machine-verified, unconditional discharge of the
low-intermediate frequency band $(1, 19/10]$ for the Riemann zeta function.

## Core Advancements

1. **Polynomial Geometry of the Inverse Pole Term**:
   - `normSq_polynomial_identity`: Exact polynomial factorization
     $$(x^2 + y)((x - 1)^2 + y) = y^2 + y + x(x - 1)(x(x - 1) + 2y).$$
   - `remainder_nonpos`: For $x \in [1/2, 1]$ and $y \ge 1/4$, the remainder is strictly non-positive,
     guaranteeing $(x^2 + y)((x - 1)^2 + y) \le y^2 + y$.

2. **Rigorous Pole Upper Bound**:
   - `normSq_coords_le_seventeen`: For $x \in [1/2, 1]$ and $y \in [1/4, 361/100]$, the norm-squared
     satisfies $|s(s-1)|^2 \le 17$.
   - `one_div_seventeen_le_inv_normSq`: Establishes the uniform lower bound
     $$\frac{1}{17} \le \frac{1}{|s(s-1)|^2}.$$

3. **Unconditional Deficit in the $(1, 19/10]$ Band**:
   - `intermediate_deficit_one_to_nineteen_tenths`: Proves `IntermediateRatioDeficit 1 (19 / 10)`.
     Since the halved ratio integral is $\le 1/20$ while the pole term is $\ge 1/17$, the deficit
     gap $1/17 - 1/20 = 3/340 > 0$ strictly excludes all zeros.

4. **Band-Wide and Cumulative Half-Plane Zero-Freeness**:
   - `intermediate_strip_zero_free_one_to_nineteen_tenths`: $\zeta(s) \ne 0$ on $(1/2, 1] \times (1, 19/10]$.
   - `intermediate_half_plane_zero_free_one_to_nineteen_tenths`: $\zeta(s) \ne 0$ for $\operatorname{Re}(s) > 1/2$
     and $\operatorname{Im}(s) \in (1, 19/10]$.
   - `cumulative_zero_free_to_nineteen_tenths`: Unconditional zero-freeness for all $0 < \operatorname{Im}(s) \le 19/10$.
-/

open Real Complex
open BuildingBlocks.RiemannZetaThresholdSynthesis
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaPhaseContradiction
open BuildingBlocks.RiemannZetaLowFrequencyContradiction
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency

namespace BuildingBlocks.RiemannZetaLowIntermediateDeficit

/-! ### Subsection 1: Polynomial Factorization and Remainder Sign -/

/-- Exact polynomial identity decomposing $|s(s-1)|^2$ into the dominant $y^2 + y$ term
and a negative-definite remainder in the critical strip. -/
lemma normSq_polynomial_identity (x y : ℝ) :
    (x^2 + y) * ((x - 1)^2 + y) = y^2 + y + x * (x - 1) * (x * (x - 1) + 2 * y) := by
  ring

/-- For $x \in [1/2, 1]$ and $y \ge 1/4$, the remainder term $x(x-1)(x(x-1) + 2y)$ is non-positive. -/
lemma remainder_nonpos {x y : ℝ} (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy : 1 / 4 ≤ y) :
    x * (x - 1) * (x * (x - 1) + 2 * y) ≤ 0 := by
  have h_xx1_nonpos : x * (x - 1) ≤ 0 := by
    nlinarith
  have h_xx1_ge : - (1 / 4 : ℝ) ≤ x * (x - 1) := by
    have : (x - 1 / 2)^2 ≥ 0 := sq_nonneg (x - 1 / 2)
    have : x * (x - 1) = (x - 1 / 2)^2 - 1 / 4 := by ring
    linarith
  have h_bracket : 0 ≤ x * (x - 1) + 2 * y := by
    linarith
  exact mul_nonpos_of_nonpos_of_nonneg h_xx1_nonpos h_bracket

/-- For $x \in [1/2, 1]$ and $y \in [1/4, 361/100]$, the product $(x^2 + y)((x - 1)^2 + y)$ is bounded above by 17. -/
lemma normSq_coords_le_seventeen {x y : ℝ} (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1)
    (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 361 / 100) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 17 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 17 := by
    nlinarith
  linarith

/-! ### Subsection 2: Coordinate Bounds and Pole Majorization -/

/-- For any $s$ in the critical strip with imaginary part $\le 19/10$, the norm-squared satisfies
$|s(s-1)|^2 \le 17$. -/
theorem normSq_mul_sub_one_le_seventeen {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 19 / 10) :
    normSq (s * (s - 1)) ≤ 17 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 361 / 100 := by
    have : s.im^2 ≤ (19 / 10 : ℝ)^2 := by nlinarith
    have : (19 / 10 : ℝ)^2 = 361 / 100 := by norm_num
    linarith
  exact normSq_coords_le_seventeen hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared:
$$\frac{1}{17} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_seventeen_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 19 / 10) :
    (1 : ℝ) / 17 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_seventeen hsr1 hsr2 hsim1 hsim2
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
  have h17 : 0 < (17 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-! ### Subsection 3: Unconditional Deficit in the $(1, 19/10]$ Band -/

/-- Strict deficit between the halved ratio integral and the inverse pole term on $(1, 19/10]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le 1/20 < 1/17 \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_one_to_nineteen_tenths :
    IntermediateRatioDeficit 1 (19 / 10) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_twenty := half_symmetrizedRatioIntegral_le_one_twentieth hsr1 hsr2 (by linarith) h_int
  have h_inv := one_div_seventeen_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 20 < 1 / 17 := by norm_num
  linarith

/-! ### Subsection 4: Zero-Freeness in the $(1, 19/10]$ Band and Extension -/

/-- Unconditional non-vanishing of $\zeta(s)$ on the critical strip segment
$(1/2, 1] \times (1, 19/10]$. -/
theorem intermediate_strip_zero_free_one_to_nineteen_tenths {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 < s.im) (hsim2 : s.im ≤ 19 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num) intermediate_deficit_one_to_nineteen_tenths
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional non-vanishing of $\zeta(s)$ on the entire right half-plane $\operatorname{Re}(s) > 1/2$
for frequencies $1 < \operatorname{Im}(s) \le 19/10$. -/
theorem intermediate_half_plane_zero_free_one_to_nineteen_tenths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1 < s.im) (hsim2 : s.im ≤ 19 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num) intermediate_deficit_one_to_nineteen_tenths
    s hsr hsim1 hsim2

/-- Unconditional non-vanishing of $\zeta(s)$ on the right half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 19/10$, seamlessly combining the low-frequency
band $[0, 1]$ with the intermediate band $(1, 19/10]$. -/
theorem cumulative_zero_free_to_nineteen_tenths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 19 / 10) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 1
  · rcases le_or_gt s.re 1 with h_le | h_gt
    · exact low_freq_free_unconditional hsr h_le hsim_pos h1
    · exact riemannZeta_ne_zero_of_one_lt_re h_gt
  · have h1_lt : 1 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_one_to_nineteen_tenths hsr h1_lt hsim_le

end BuildingBlocks.RiemannZetaLowIntermediateDeficit

open BuildingBlocks.RiemannZetaLowIntermediateDeficit

#print axioms normSq_polynomial_identity
#print axioms remainder_nonpos
#print axioms normSq_coords_le_seventeen
#print axioms normSq_mul_sub_one_le_seventeen
#print axioms one_div_seventeen_le_inv_normSq
#print axioms intermediate_deficit_one_to_nineteen_tenths
#print axioms intermediate_strip_zero_free_one_to_nineteen_tenths
#print axioms intermediate_half_plane_zero_free_one_to_nineteen_tenths
#print axioms cumulative_zero_free_to_nineteen_tenths
