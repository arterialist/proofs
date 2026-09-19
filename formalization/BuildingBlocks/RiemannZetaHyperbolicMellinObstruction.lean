import Mathlib
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaTrigonometricDecomposition

/-!
# Module 289: Riemann Zeta Hyperbolic Mellin Obstruction

This module establishes the exact differential and algebraic obstruction equations governing
the imaginary part of the completed Riemann zeta function $\Lambda_0(s)$ at any hypothetical
off-line zero $\rho = \beta + i\gamma$ in the upper half-plane ($\beta > 1/2, \gamma > 0$).

## Mathematical Summary

1. **AM-GM Symmetrized Lower Bound**:
   For any $x > 0$ and any $\beta \in \mathbb{R}$:
   $$2 x^{-3/4} \le x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}$$
   since the product is constant: $x^{\beta/2 - 1} \cdot x^{(1-\beta)/2 - 1} = x^{-3/2}$.

2. **Critical Symmetrized Upper Bound**:
   For any $x \ge 1$ and $\beta \in [1/2, 1]$:
   $$x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1} \le 2$$

3. **Fréchet Differentiability of Power Difference**:
   The hyperbolic amplitude $\operatorname{powerDiff}(\beta, x) = x^{\beta/2 - 1} - x^{(1-\beta)/2 - 1}$
   satisfies:
   $$\frac{\partial}{\partial \beta} \operatorname{powerDiff}(\beta, x) = (x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}) \cdot \frac{1}{2}\log x$$

4. **Pointwise Gradient Bounds**:
   For $x \ge 1$ and $\beta \in [1/2, 1]$:
   $$x^{-3/4} \log x \le \frac{\partial}{\partial \beta}\operatorname{powerDiff}(\beta, x) \le \log x$$

5. **Normalized Imaginary Ratio at Zeros**:
   Defining:
   $$\operatorname{normalizedImRatio}(s) := \frac{\operatorname{Im}(\Lambda_0(s))}{(2 s.\operatorname{re} - 1) s.\operatorname{im}}$$
   At any off-line zero $\rho$ with $\beta > 1/2$ and $\gamma > 0$, algebraic inversion forces:
   $$\operatorname{normalizedImRatio}(\rho) = \frac{1}{|\rho(\rho - 1)|^2}$$

6. **Coordinate Squeeze Bounds**:
   $$\frac{1}{(1 + \gamma^2)(1/4 + \gamma^2)} \le \operatorname{normalizedImRatio}(\rho) \le \frac{1}{(1/4 + \gamma^2)\gamma^2}$$
   - For small frequencies ($\gamma \le 1$): $\operatorname{normalizedImRatio}(\rho) \ge 2/5 = 0.4$.
   - For high frequencies ($\gamma \ge 1$): $\operatorname{normalizedImRatio}(\rho) \le 1/\gamma^4$.
-/

namespace BuildingBlocks.RiemannZetaHyperbolicMellinObstruction

open Real Complex MeasureTheory Filter Topology
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaTrigonometricDecomposition

/-! ### 1. AM-GM and Symmetrized Amplitude Bounds -/

/-- Universal AM-GM inequality for non-negative reals: $2\sqrt{ab} \le a + b$. -/
theorem am_gm_two (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    2 * Real.sqrt (a * b) ≤ a + b := by
  have : 0 ≤ (Real.sqrt a - Real.sqrt b) ^ 2 := sq_nonneg _
  have h_id : (Real.sqrt a - Real.sqrt b) ^ 2 = a + b - 2 * Real.sqrt (a * b) := by
    have h1 : (Real.sqrt a) ^ 2 = a := Real.sq_sqrt ha
    have h2 : (Real.sqrt b) ^ 2 = b := Real.sq_sqrt hb
    have h3 : Real.sqrt a * Real.sqrt b = Real.sqrt (a * b) := (Real.sqrt_mul ha b).symm
    calc (Real.sqrt a - Real.sqrt b) ^ 2
      _ = (Real.sqrt a) ^ 2 - 2 * (Real.sqrt a * Real.sqrt b) + (Real.sqrt b) ^ 2 := by ring
      _ = a - 2 * Real.sqrt (a * b) + b := by rw [h1, h2, h3]
      _ = a + b - 2 * Real.sqrt (a * b) := by ring
  linarith

/-- Exponent product identity: $x^{\beta/2 - 1} \cdot x^{(1-\beta)/2 - 1} = x^{-3/2}$. -/
theorem rpow_beta_mul_rpow_one_sub_beta (x : ℝ) (hx : 0 < x) (b : ℝ) :
    x ^ (b / 2 - 1) * x ^ ((1 - b) / 2 - 1) = x ^ (- (3 : ℝ) / 2) := by
  rw [← Real.rpow_add hx]
  congr 1
  ring

/-- Square root of $x^{-3/2}$ is $x^{-3/4}$. -/
theorem sqrt_rpow_neg_three_halves (x : ℝ) (hx : 0 < x) :
    Real.sqrt (x ^ (- (3 : ℝ) / 2)) = x ^ (- (3 : ℝ) / 4) := by
  rw [Real.sqrt_eq_rpow]
  rw [← Real.rpow_mul (le_of_lt hx)]
  congr 1
  ring

/-- Universal AM-GM lower bound on symmetrized powers:
$2 x^{-3/4} \le x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}$. -/
theorem rpow_beta_add_rpow_one_sub_beta_ge (x : ℝ) (hx : 0 < x) (b : ℝ) :
    2 * x ^ (- (3 : ℝ) / 4) ≤ x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1) := by
  have ha : 0 ≤ x ^ (b / 2 - 1) := by positivity
  have hb : 0 ≤ x ^ ((1 - b) / 2 - 1) := by positivity
  have ham := am_gm_two (x ^ (b / 2 - 1)) (x ^ ((1 - b) / 2 - 1)) ha hb
  have hprod := rpow_beta_mul_rpow_one_sub_beta x hx b
  rw [hprod] at ham
  have hsqrt := sqrt_rpow_neg_three_halves x hx
  rw [hsqrt] at ham
  exact ham

/-- Symmetrized power sum upper bound for $\beta \in [1/2, 1]$ and $x \ge 1$:
$x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1} \le 2$. -/
theorem rpow_beta_add_rpow_one_sub_beta_le {x : ℝ} (hx : 1 ≤ x) {b : ℝ}
    (hb1 : 1 / 2 ≤ b) (hb2 : b ≤ 1) :
    x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1) ≤ 2 := by
  have h1 : b / 2 - 1 ≤ 0 := by linarith
  have h2 : (1 - b) / 2 - 1 ≤ 0 := by linarith
  have h_le1 : x ^ (b / 2 - 1) ≤ 1 := by
    simpa using Real.rpow_le_one_of_one_le_of_nonpos hx h1
  have h_le2 : x ^ ((1 - b) / 2 - 1) ≤ 1 := by
    simpa using Real.rpow_le_one_of_one_le_of_nonpos hx h2
  linarith

/-! ### 2. Differentiation of Hyperbolic Amplitude -/

/-- Real power representation via exponential and logarithm. -/
lemma rpow_eq_exp_log (x y : ℝ) (hx : 0 < x) : x ^ y = Real.exp (Real.log x * y) :=
  Real.rpow_def_of_pos hx y

/-- Fréchet derivative of $x^{\beta/2 - 1}$ with respect to $\beta$. -/
theorem hasDerivAt_rpow_beta (x : ℝ) (hx : 0 < x) (b : ℝ) :
    HasDerivAt (fun β => x ^ (β / 2 - 1)) (x ^ (b / 2 - 1) * (Real.log x / 2)) b := by
  have h_eq : (fun β => x ^ (β / 2 - 1)) = (fun β => Real.exp (Real.log x * (β / 2 - 1))) := by
    ext β; exact rpow_eq_exp_log x (β / 2 - 1) hx
  rw [h_eq]
  have h_affine : HasDerivAt (fun β => Real.log x * (β / 2 - 1)) (Real.log x / 2) b := by
    have : (fun β => Real.log x * (β / 2 - 1)) = (fun β => β * (Real.log x / 2) - Real.log x) := by
      ext β; ring
    rw [this]
    have h1 : HasDerivAt (fun β => β * (Real.log x / 2)) (Real.log x / 2) b := by
      simpa using (hasDerivAt_id b).mul_const (Real.log x / 2)
    have h2 := h1.sub_const (Real.log x)
    exact h2
  have h_exp := h_affine.exp
  have h_rew : Real.exp (Real.log x * (b / 2 - 1)) = x ^ (b / 2 - 1) := (rpow_eq_exp_log x (b / 2 - 1) hx).symm
  rw [h_rew] at h_exp
  exact h_exp

/-- Fréchet derivative of $x^{(1-\beta)/2 - 1}$ with respect to $\beta$. -/
theorem hasDerivAt_rpow_one_sub_beta (x : ℝ) (hx : 0 < x) (b : ℝ) :
    HasDerivAt (fun β => x ^ ((1 - β) / 2 - 1)) (x ^ ((1 - b) / 2 - 1) * (-Real.log x / 2)) b := by
  have h_eq : (fun β => x ^ ((1 - β) / 2 - 1)) = (fun β => Real.exp (Real.log x * ((1 - β) / 2 - 1))) := by
    ext β; exact rpow_eq_exp_log x ((1 - β) / 2 - 1) hx
  rw [h_eq]
  have h_affine : HasDerivAt (fun β => Real.log x * ((1 - β) / 2 - 1)) (-Real.log x / 2) b := by
    have : (fun β => Real.log x * ((1 - β) / 2 - 1)) = (fun β => β * (-Real.log x / 2) - Real.log x / 2) := by
      ext β; ring
    rw [this]
    have h1 : HasDerivAt (fun β => β * (-Real.log x / 2)) (-Real.log x / 2) b := by
      simpa using (hasDerivAt_id b).mul_const (-Real.log x / 2)
    have h2 := h1.sub_const (Real.log x / 2)
    exact h2
  have h_exp := h_affine.exp
  have h_rew : Real.exp (Real.log x * ((1 - b) / 2 - 1)) = x ^ ((1 - b) / 2 - 1) := (rpow_eq_exp_log x ((1 - b) / 2 - 1) hx).symm
  rw [h_rew] at h_exp
  exact h_exp

/-- Fréchet derivative of $\operatorname{powerDiff}(\beta, x)$ with respect to $\beta$. -/
theorem hasDerivAt_powerDiff (x : ℝ) (hx : 0 < x) (b : ℝ) :
    HasDerivAt (fun β => powerDiff β x)
      ((x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2)) b := by
  unfold powerDiff
  have h1 := hasDerivAt_rpow_beta x hx b
  have h2 := hasDerivAt_rpow_one_sub_beta x hx b
  have h3 := HasDerivAt.sub h1 h2
  convert h3 using 1
  ring

/-- Non-negativity of the derivative of $\operatorname{powerDiff}$ for $x \ge 1$. -/
theorem deriv_powerDiff_nonneg (x : ℝ) (hx : 1 ≤ x) (b : ℝ) :
    0 ≤ (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2) := by
  have hlog : 0 ≤ Real.log x / 2 := by
    have : 0 ≤ Real.log x := Real.log_nonneg hx
    linarith
  have hsum : 0 ≤ x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1) := by positivity
  exact mul_nonneg hsum hlog

/-- Lower bound on the derivative of $\operatorname{powerDiff}$ for $x \ge 1$:
$x^{-3/4}\log x \le \frac{\partial}{\partial \beta}\operatorname{powerDiff}(\beta, x)$. -/
theorem deriv_powerDiff_ge (x : ℝ) (hx : 1 ≤ x) (b : ℝ) :
    x ^ (- (3 : ℝ) / 4) * Real.log x ≤
      (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2) := by
  have hx_pos : 0 < x := by linarith
  have h_ge := rpow_beta_add_rpow_one_sub_beta_ge x hx_pos b
  have hlog : 0 ≤ Real.log x := Real.log_nonneg hx
  calc x ^ (- (3 : ℝ) / 4) * Real.log x
    _ = (2 * x ^ (- (3 : ℝ) / 4)) * (Real.log x / 2) := by ring
    _ ≤ (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2) := by
      nlinarith

/-- Upper bound on the derivative of $\operatorname{powerDiff}$ for $x \ge 1$ and $\beta \in [1/2, 1]$:
$\frac{\partial}{\partial \beta}\operatorname{powerDiff}(\beta, x) \le \log x$. -/
theorem deriv_powerDiff_le {x : ℝ} (hx : 1 ≤ x) {b : ℝ}
    (hb1 : 1 / 2 ≤ b) (hb2 : b ≤ 1) :
    (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2) ≤ Real.log x := by
  have h_le := rpow_beta_add_rpow_one_sub_beta_le hx hb1 hb2
  have hlog : 0 ≤ Real.log x / 2 := by
    have : 0 ≤ Real.log x := Real.log_nonneg hx
    linarith
  calc (x ^ (b / 2 - 1) + x ^ ((1 - b) / 2 - 1)) * (Real.log x / 2)
    _ ≤ 2 * (Real.log x / 2) := by nlinarith
    _ = Real.log x := by ring

/-! ### 3. Coordinate Denominator Bounds at Off-Line Zeros -/

/-- $(u - 1)^2 \le 1/4$ when $1/2 \le u \le 1$. -/
lemma sub_one_sq_le_one_fourth {u : ℝ} (hu1 : 1 / 2 ≤ u) (hu2 : u ≤ 1) :
    (u - 1) ^ 2 ≤ 1 / 4 := by
  have h_nonneg : 0 ≤ u - 1 + 1 / 2 := by linarith
  have h_nonpos : u - 1 - 1 / 2 ≤ 0 := by linarith
  have h_mul : (u - 1 + 1 / 2) * (u - 1 - 1 / 2) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos h_nonneg h_nonpos
  have h_ring : (u - 1 + 1 / 2) * (u - 1 - 1 / 2) = (u - 1) ^ 2 - 1 / 4 := by ring
  linarith

/-- $u^2 \le 1$ when $0 \le u \le 1$. -/
lemma sq_le_one_of_le_one {u : ℝ} (hu1 : 0 ≤ u) (hu2 : u ≤ 1) :
    u ^ 2 ≤ 1 := by
  nlinarith

/-- Lower coordinate bound on $|\rho(\rho-1)|^2 \ge (1/4 + \gamma^2)\gamma^2$. -/
theorem normSq_mul_sub_one_ge_quarter_gamma_sq (s : ℂ) (hsr : (1 : ℝ) / 2 ≤ s.re) :
    (1 / 4 + s.im ^ 2) * s.im ^ 2 ≤ normSq (s * (s - 1)) := by
  rw [normSq_mul_sub_one_eq_coords]
  have h1 : 1 / 4 ≤ s.re ^ 2 := by
    have : (1 / 2 : ℝ) ^ 2 ≤ s.re ^ 2 := sq_le_sq' (by linarith) hsr
    have : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by norm_num
    linarith
  have h2 : 0 ≤ (s.re - 1) ^ 2 := sq_nonneg (s.re - 1)
  have h3 : 1 / 4 + s.im ^ 2 ≤ s.re ^ 2 + s.im ^ 2 := by linarith
  have h4 : s.im ^ 2 ≤ (s.re - 1) ^ 2 + s.im ^ 2 := by linarith
  nlinarith

/-- Upper coordinate bound on $|\rho(\rho-1)|^2 \le (1 + \gamma^2)(1/4 + \gamma^2)$ for $\beta \in [1/2, 1]$. -/
theorem normSq_mul_sub_one_le_coords {s : ℂ} (hsr1 : (1 : ℝ) / 2 ≤ s.re) (hsr2 : s.re ≤ 1) :
    normSq (s * (s - 1)) ≤ (1 + s.im ^ 2) * (1 / 4 + s.im ^ 2) := by
  rw [normSq_mul_sub_one_eq_coords]
  have h1 : s.re ^ 2 ≤ 1 := sq_le_one_of_le_one (by linarith) hsr2
  have h2 : (s.re - 1) ^ 2 ≤ 1 / 4 := sub_one_sq_le_one_fourth hsr1 hsr2
  have h_term1 : s.re ^ 2 + s.im ^ 2 ≤ 1 + s.im ^ 2 := by linarith
  have h_term2 : (s.re - 1) ^ 2 + s.im ^ 2 ≤ 1 / 4 + s.im ^ 2 := by linarith
  nlinarith

/-- Positivity of coordinate product factor $(1 + \gamma^2)(1/4 + \gamma^2)$. -/
lemma coords_product_pos {γ : ℝ} (hγ : 0 < γ) :
    0 < (1 + γ ^ 2) * (1 / 4 + γ ^ 2) := by
  have h1 : 0 < 1 + γ ^ 2 := by positivity
  have h2 : 0 < 1 / 4 + γ ^ 2 := by positivity
  exact mul_pos h1 h2

/-- Upper bound on reciprocal squared norm $1/|\rho(\rho-1)|^2 \le 1/((1/4 + \gamma^2)\gamma^2)$. -/
theorem inv_normSq_mul_sub_one_le {s : ℂ} (hsr : (1 : ℝ) / 2 ≤ s.re) (hsim : 0 < s.im) :
    1 / normSq (s * (s - 1)) ≤ 1 / ((1 / 4 + s.im ^ 2) * s.im ^ 2) := by
  have h_le := normSq_mul_sub_one_ge_quarter_gamma_sq s hsr
  have h_pos : 0 < (1 / 4 + s.im ^ 2) * s.im ^ 2 := by
    have h1 : 0 < 1 / 4 + s.im ^ 2 := by positivity
    have h2 : 0 < s.im ^ 2 := sq_pos_of_ne_zero (ne_of_gt hsim)
    exact mul_pos h1 h2
  exact one_div_le_one_div_of_le h_pos h_le

/-- Lower bound on reciprocal squared norm $1/|\rho(\rho-1)|^2 \ge 1/((1 + \gamma^2)(1/4 + \gamma^2))$. -/
theorem inv_normSq_mul_sub_one_ge {s : ℂ} (hsr1 : (1 : ℝ) / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim : 0 < s.im) :
    1 / ((1 + s.im ^ 2) * (1 / 4 + s.im ^ 2)) ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_coords hsr1 hsr2
  have h_pos2 : 0 < normSq (s * (s - 1)) := by
    have hs_ne : s ≠ 0 := by
      intro h
      have h0 : s.re = 0 := by rw [h, zero_re]
      linarith
    have hs1_ne : s - 1 ≠ 0 := by
      intro h
      have h1 : s.im = 0 := by
        have := congr_arg Complex.im h
        simp only [sub_im, one_im, zero_im] at this
        linarith
      linarith
    exact normSq_pos.mpr (mul_ne_zero hs_ne hs1_ne)
  exact one_div_le_one_div_of_le h_pos2 h_le

/-! ### 4. Normalized Imaginary Ratio at Putative Zeros -/

/-- The normalized imaginary ratio $\operatorname{normImRatio}(s) := \frac{\operatorname{Im}(\Lambda_0(s))}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)}$. -/
noncomputable def normImRatio (s : ℂ) : ℝ :=
  (completedRiemannZeta₀ s).im / ((2 * s.re - 1) * s.im)

/-- At any off-line zero $\rho$, $\operatorname{normImRatio}(\rho) = \frac{1}{|\rho(\rho - 1)|^2}$. -/
theorem normImRatio_eq_inv_normSq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    normImRatio s = 1 / normSq (s * (s - 1)) := by
  unfold normImRatio
  have him := completedRiemannZeta₀_im_of_zero hsr hsim hz
  rw [him]
  have h_num : (2 * s.re - 1) * s.im ≠ 0 := by
    have h1 : 0 < 2 * s.re - 1 := by linarith
    exact ne_of_gt (mul_pos h1 hsim)
  rw [div_div]
  rw [mul_comm (normSq (s * (s - 1))) ((2 * s.re - 1) * s.im)]
  rw [← div_div]
  rw [div_self h_num]

/-- Lower bound on $\operatorname{normImRatio}$ at an off-line zero. -/
theorem normImRatio_ge_of_zero {s : ℂ} (hsr1 : (1 : ℝ) / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    1 / ((1 + s.im ^ 2) * (1 / 4 + s.im ^ 2)) ≤ normImRatio s := by
  rw [normImRatio_eq_inv_normSq_of_zero hsr1 hsim hz]
  exact inv_normSq_mul_sub_one_ge (le_of_lt hsr1) hsr2 hsim

/-- Upper bound on $\operatorname{normImRatio}$ at an off-line zero. -/
theorem normImRatio_le_of_zero {s : ℂ} (hsr1 : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    normImRatio s ≤ 1 / ((1 / 4 + s.im ^ 2) * s.im ^ 2) := by
  rw [normImRatio_eq_inv_normSq_of_zero hsr1 hsim hz]
  exact inv_normSq_mul_sub_one_le (le_of_lt hsr1) hsim

/-- Low-frequency lower bound: for $\gamma \le 1$, $\operatorname{normImRatio}(\rho) \ge 2/5 = 0.4$. -/
theorem normImRatio_ge_two_fifths_of_zero {s : ℂ} (hsr1 : (1 : ℝ) / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 1) (hz : riemannZeta s = 0) :
    (2 : ℝ) / 5 ≤ normImRatio s := by
  have h_ge := normImRatio_ge_of_zero hsr1 hsr2 hsim1 hz
  have h_denom : (1 + s.im ^ 2) * (1 / 4 + s.im ^ 2) ≤ (5 : ℝ) / 2 := by
    have h1 : s.im ^ 2 ≤ 1 := by nlinarith
    have h2 : 1 + s.im ^ 2 ≤ 2 := by linarith
    have h3 : 1 / 4 + s.im ^ 2 ≤ 5 / 4 := by linarith
    nlinarith
  have h_denom_pos : 0 < (1 + s.im ^ 2) * (1 / 4 + s.im ^ 2) := coords_product_pos hsim1
  have h_recip : 1 / ((5 : ℝ) / 2) ≤ 1 / ((1 + s.im ^ 2) * (1 / 4 + s.im ^ 2)) :=
    one_div_le_one_div_of_le h_denom_pos h_denom
  have : 1 / ((5 : ℝ) / 2) = (2 : ℝ) / 5 := by norm_num
  linarith

/-- High-frequency quartic decay: for $\gamma \ge 1$, $\operatorname{normImRatio}(\rho) \le 1/\gamma^4$. -/
theorem normImRatio_le_four_power_of_zero {s : ℂ} (hsr1 : (1 : ℝ) / 2 < s.re) (hsim : 1 ≤ s.im)
    (hz : riemannZeta s = 0) :
    normImRatio s ≤ 1 / s.im ^ 4 := by
  have hsim_pos : 0 < s.im := by linarith
  have h_le := normImRatio_le_of_zero hsr1 hsim_pos hz
  have h_denom : s.im ^ 4 ≤ (1 / 4 + s.im ^ 2) * s.im ^ 2 := by
    have : s.im ^ 4 = s.im ^ 2 * s.im ^ 2 := by ring
    rw [this]
    have : s.im ^ 2 ≤ 1 / 4 + s.im ^ 2 := by linarith
    nlinarith
  have h_pos : 0 < s.im ^ 4 := by positivity
  have h_recip : 1 / ((1 / 4 + s.im ^ 2) * s.im ^ 2) ≤ 1 / s.im ^ 4 :=
    one_div_le_one_div_of_le h_pos h_denom
  linarith

end BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
