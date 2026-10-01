import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.Tactic

/-!
Elementary ingredients for a small-window bound on the complete zeta Weil form.
This module proves the literal regular gamma-kernel estimates, logarithmic-shift
support exclusion, and scalar margins.  The Fourier/digamma cell identity,
integral operator bounds and identification of the complete Weil form remain
explicit analytic inputs; no theorem here asserts unrestricted positivity or RH.
-/

namespace BuildingBlocks.ActualWeilSingleWindowCoercivity

open Set MeasureTheory

private theorem exp_neg_le_quadratic (x : ℝ) (hx : 0 ≤ x) :
    Real.exp (-x) ≤ 1 - x + x ^ 2 / 2 := by
  let f : ℝ → ℝ := fun y => 1 - y + y ^ 2 / 2 - Real.exp (-y)
  have hd (y : ℝ) : HasDerivAt f (-1 + y + Real.exp (-y)) y := by
    dsimp [f]
    convert (((hasDerivAt_const y (1 : ℝ)).sub (hasDerivAt_id y)).add
      (((hasDerivAt_id y).pow 2).div_const 2)).sub
      ((Real.hasDerivAt_exp (-y)).comp y (hasDerivAt_id y).neg) using 1
    simp [id]
  have hm : MonotoneOn f (Ici 0) :=
    monotoneOn_of_hasDerivWithinAt_nonneg (convex_Ici 0)
      (by dsimp [f]; fun_prop)
      (fun y _ => (hd y).hasDerivWithinAt)
      (fun y _ => by linarith [Real.add_one_le_exp (-y)])
  have h := hm (by simp) hx hx
  dsimp [f] at h
  norm_num at h
  linarith

/-- Literal regular gamma quotient, with the value `1/4` assigned at zero.
Continuity of this extension at zero is not formalized in this module. -/
noncomputable def rho (r : ℝ) : ℝ :=
  if r = 0 then 1 / 4 else
    Real.exp (-r / 2) / (1 - Real.exp (-2 * r)) - 1 / (2 * r)

theorem rho_bounds {r : ℝ} (hr : 0 ≤ r) (hrw : r ≤ 1 / 6) :
    -(1 : ℝ) / 4 ≤ rho r ∧ rho r ≤ 5 / 16 := by
  by_cases hz : r = 0
  · subst r; norm_num [rho]
  have hrpos : 0 < r := lt_of_le_of_ne hr (Ne.symm hz)
  have hd : 0 < 1 - Real.exp (-2 * r) := by
    have h : Real.exp (-2 * r) < 1 := Real.exp_lt_one_iff.mpr (by linarith)
    linarith
  have hdle : 1 - Real.exp (-2 * r) ≤ 2 * r := by
    linarith [Real.add_one_le_exp (-2 * r)]
  have hdge : 2 * r - 2 * r ^ 2 ≤ 1 - Real.exp (-2 * r) := by
    have h := exp_neg_le_quadratic (2 * r) (by positivity)
    rw [show -(2 * r) = -2 * r by ring] at h
    nlinarith [h]
  have hnlo : 1 - r / 2 ≤ Real.exp (-r / 2) := by
    linarith [Real.add_one_le_exp (-r / 2)]
  have hnhi : Real.exp (-r / 2) ≤ 1 - r / 2 + r ^ 2 / 8 := by
    have h := exp_neg_le_quadratic (r / 2) (by positivity)
    rw [show -(r / 2) = -r / 2 by ring] at h
    nlinarith [h]
  have hd0 : 0 < 2 * r - 2 * r ^ 2 := by nlinarith
  have hlo : (1 - r / 2) / (2 * r) ≤
      Real.exp (-r / 2) / (1 - Real.exp (-2 * r)) := by
    exact div_le_div₀ (by linarith) hnlo hd hdle
  have hhi : Real.exp (-r / 2) / (1 - Real.exp (-2 * r)) ≤
      (1 - r / 2 + r ^ 2 / 8) / (2 * r - 2 * r ^ 2) := by
    exact div_le_div₀ (by nlinarith [sq_nonneg r]) hnhi hd0 hdge
  simp only [rho, if_neg hz]
  constructor
  · have he : (1 - r / 2) / (2 * r) - 1 / (2 * r) = -(1 : ℝ) / 4 := by
      field_simp
      ring
    linarith
  · have he : (1 - r / 2 + r ^ 2 / 8) / (2 * r - 2 * r ^ 2) -
        1 / (2 * r) ≤ (5 : ℝ) / 16 := by
      apply (sub_le_iff_le_add).mpr
      apply (div_le_iff₀ hd0).mpr
      field_simp
      nlinarith
    linarith

theorem width_lt_log_two {w : ℝ} (hw : w ≤ 1 / 6) : w < Real.log 2 := by
  linarith [Real.log_two_gt_d9]

/-- Literal exclusion of every integer logarithmic translation in a single window. -/
theorem no_integer_log_difference {w c : ℝ} {q : ℕ}
    (hw : w ≤ 1 / 6) (hq : 2 ≤ q) {x y : ℝ}
    (hx : x ∈ Icc c (c + w)) (hy : y ∈ Icc c (c + w)) :
    y - x ≠ Real.log (q : ℝ) := by
  have hqlog : Real.log 2 ≤ Real.log (q : ℝ) :=
    Real.log_le_log (by norm_num) (by exact_mod_cast hq)
  have hwidth := width_lt_log_two hw
  rcases hx with ⟨hx0, hx1⟩
  rcases hy with ⟨hy0, hy1⟩
  intro heq
  linarith

theorem conjugate_shift_product_zero {w c : ℝ} {q : ℕ}
    (hw : w ≤ 1 / 6) (hq : 2 ≤ q) {f g : ℝ → ℂ}
    (hf : Function.support f ⊆ Icc c (c + w))
    (hg : Function.support g ⊆ Icc c (c + w)) (x : ℝ) :
    star (f x) * g (x + Real.log (q : ℝ)) = 0 := by
  classical
  by_cases hfx : f x = 0
  · simp [hfx]
  have hx := hf (by simpa only [Function.mem_support] using hfx)
  have hgy : g (x + Real.log (q : ℝ)) = 0 := by
    by_contra hne
    have hy := hg (by simpa only [Function.mem_support] using hne)
    exact no_integer_log_difference hw hq hx hy (by ring)
  simp [hgy]

theorem integral_conjugate_shift_product_zero {w c : ℝ} {q : ℕ}
    (hw : w ≤ 1 / 6) (hq : 2 ≤ q) {f g : ℝ → ℂ}
    (hf : Function.support f ⊆ Icc c (c + w))
    (hg : Function.support g ⊆ Icc c (c + w)) (μ : Measure ℝ) :
    ∫ x, star (f x) * g (x + Real.log (q : ℝ)) ∂μ = 0 := by
  simp only [conjugate_shift_product_zero hw hq hf hg, integral_zero]

theorem conjugate_negative_shift_product_zero {w c : ℝ} {q : ℕ}
    (hw : w ≤ 1 / 6) (hq : 2 ≤ q) {f g : ℝ → ℂ}
    (hf : Function.support f ⊆ Icc c (c + w))
    (hg : Function.support g ⊆ Icc c (c + w)) (x : ℝ) :
    star (f x) * g (x - Real.log (q : ℝ)) = 0 := by
  classical
  by_cases hfx : f x = 0
  · simp [hfx]
  have hx := hf (by simpa only [Function.mem_support] using hfx)
  have hgy : g (x - Real.log (q : ℝ)) = 0 := by
    by_contra hne
    have hy := hg (by simpa only [Function.mem_support] using hne)
    exact no_integer_log_difference hw hq hy hx (by ring)
  simp [hgy]

theorem integral_conjugate_negative_shift_product_zero {w c : ℝ} {q : ℕ}
    (hw : w ≤ 1 / 6) (hq : 2 ≤ q) {f g : ℝ → ℂ}
    (hf : Function.support f ⊆ Icc c (c + w))
    (hg : Function.support g ⊆ Icc c (c + w)) (μ : Measure ℝ) :
    ∫ x, star (f x) * g (x - Real.log (q : ℝ)) ∂μ = 0 := by
  simp only [conjugate_negative_shift_product_zero hw hq hf hg, integral_zero]

theorem log_corner : (129 : ℝ) / 200 < Real.log (21 / 11) := by
  have h := Real.exp_bound' (x := (129 : ℝ) / 200) (by norm_num) (by norm_num)
    (n := 8) (by norm_num)
  norm_num [Finset.sum_range_succ, Nat.factorial] at h
  apply (Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 21 / 11)).mpr
  linarith

set_option maxRecDepth 2000 in
theorem euler_constant_lt : Real.eulerMascheroniConstant < (29 : ℝ) / 50 := by
  have hH : harmonic 256 < (49 / 8 : ℚ) := by norm_num [harmonic]
  have hHr : (harmonic 256 : ℝ) < ((49 / 8 : ℚ) : ℝ) := Rat.cast_lt.mpr hH
  norm_num at hHr
  have h := Real.eulerMascheroniConstant_lt_eulerMascheroniSeq' 256
  norm_num [Real.eulerMascheroniSeq'] at h
  have hlog : Real.log (256 : ℝ) = 8 * Real.log 2 := by
    rw [show (256 : ℝ) = 2 ^ (8 : ℕ) by norm_num, Real.log_pow]
    norm_num
  rw [hlog] at h
  linarith [Real.log_two_gt_d9]

theorem gamma_corner_arithmetic :
    (129 : ℝ) / 200 - 29 / 50 - 5 / 96 = 31 / 2400 := by norm_num

theorem full_corner_arithmetic :
    (31 : ℝ) / 2400 - 1 / 1000 = 143 / 12000 ∧
      (1 : ℝ) / 100 < 143 / 12000 := by norm_num

/-- Complex polar algebra for the cosh and sinh moments. The integral
identification of those moments and their Cauchy bounds remain outside Lean. -/
theorem complex_polar_algebra (C S : ℂ) :
    2 * ((C + S) * star (C - S)).re =
      2 * Complex.normSq C - 2 * Complex.normSq S := by
  simp [Complex.mul_re, Complex.normSq_apply]
  ring

theorem rho_abs_bound {r : ℝ} (hr : 0 ≤ r) (hrw : r ≤ 1 / 6) :
    |rho r| ≤ 5 / 16 := by
  obtain ⟨hl, hu⟩ := rho_bounds hr hrw
  exact abs_le.mpr ⟨by linarith, hu⟩

/-- Width-dependent archimedean coefficient after the elementary kernel estimate. -/
noncomputable def gammaCoefficient (w : ℝ) : ℝ :=
  Real.log (1 / (Real.pi * w)) - Real.eulerMascheroniConstant - 5 * w / 16

theorem gammaCoefficient_eq {w : ℝ} (hw : 0 < w) :
    gammaCoefficient w =
      Real.log 2 - Real.log w - Real.log (2 * Real.pi) -
        Real.eulerMascheroniConstant - 5 * w / 16 := by
  unfold gammaCoefficient
  rw [one_div, Real.log_inv, Real.log_mul Real.pi_ne_zero hw.ne',
    Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) Real.pi_ne_zero]
  ring

theorem gammaCoefficient_gt {w : ℝ} (hw : 0 < w) (hwmax : w ≤ 1 / 6) :
    (31 : ℝ) / 2400 < gammaCoefficient w := by
  have hp : Real.pi < (22 : ℝ) / 7 := by linarith [Real.pi_lt_d4]
  have hd : 0 < Real.pi * w := mul_pos Real.pi_pos hw
  have hden : Real.pi * w < (11 : ℝ) / 21 := by
    have hmul := mul_le_mul_of_nonneg_left hwmax Real.pi_pos.le
    linarith
  have harg : (21 : ℝ) / 11 < 1 / (Real.pi * w) := by
    apply (lt_div_iff₀ hd).mpr
    nlinarith
  have hlog : Real.log (21 / 11 : ℝ) < Real.log (1 / (Real.pi * w)) :=
    Real.log_lt_log (by norm_num) harg
  unfold gammaCoefficient
  linarith [log_corner, euler_constant_lt]

private theorem polarCoefficient_monotone :
    Monotone (fun w : ℝ => 2 * Real.sinh (w / 2) - w) := by
  apply monotone_of_hasDerivAt_nonneg
    (f' := fun w : ℝ => Real.cosh (w / 2) - 1)
  · intro w
    convert (((Real.hasDerivAt_sinh (w / 2)).comp w
      ((hasDerivAt_id w).div_const 2)).const_mul 2).sub (hasDerivAt_id w) using 1
    dsimp
    ring
  · intro w
    change 0 ≤ Real.cosh (w / 2) - 1
    linarith [Real.one_le_cosh (w / 2)]

/-- Uniform elementary polar budget. The Cauchy estimate connecting this
coefficient to the two polar moments remains an analytic input. -/
theorem polar_coefficient_lt {w : ℝ} (hw : w ≤ 1 / 6) :
    2 * Real.sinh (w / 2) - w < (1 : ℝ) / 1000 := by
  have hpos := Real.exp_bound' (x := (1 : ℝ) / 12) (by norm_num) (by norm_num)
    (n := 4) (by norm_num)
  have hneg := Real.exp_bound (x := -(1 : ℝ) / 12) (by norm_num)
    (n := 4) (by norm_num)
  norm_num [Finset.sum_range_succ, Nat.factorial] at hpos hneg
  have hn := (abs_le.mp hneg).1
  have hcorner : 2 * Real.sinh ((1 / 6 : ℝ) / 2) - 1 / 6 < (1 : ℝ) / 1000 := by
    rw [Real.sinh_eq]
    norm_num
    linarith
  exact lt_of_le_of_lt (polarCoefficient_monotone hw) hcorner

/-- Scalar consequence of the explicit cell and gamma-kernel estimates.
This is not a formal construction of the Fourier/digamma cell form. -/
theorem gamma_lower_from_analytic_inputs
    (w mass variance cell kernel gamma : ℝ) (hw : 0 < w)
    (hCellLower : Real.log 2 * mass + variance / 2 ≤ cell)
    (hKernelUpper : kernel ≤ (5 / 16 : ℝ) * w * mass)
    (hGammaIdentity : gamma = cell +
      (-Real.log w - Real.log (2 * Real.pi) - Real.eulerMascheroniConstant) * mass - kernel) :
    gammaCoefficient w * mass + variance / 2 ≤ gamma := by
  rw [gammaCoefficient_eq hw]
  nlinarith

/-- The named premises are the analytic cell bound, complete gamma identity,
integral kernel estimate, polar Cauchy estimate, arithmetic vanishing and full
Weil decomposition. They are not proved by this scalar theorem. -/
theorem single_window_coercivity_from_analytic_inputs
    (w mass variance cell kernel gamma pole primeRow Q : ℝ)
    (hw : 0 < w) (hwmax : w ≤ 1 / 6) (hmass : 0 ≤ mass) (hvariance : 0 ≤ variance)
    (hCellLower : Real.log 2 * mass + variance / 2 ≤ cell)
    (hKernelUpper : kernel ≤ (5 / 16 : ℝ) * w * mass)
    (hGammaIdentity : gamma = cell +
      (-Real.log w - Real.log (2 * Real.pi) - Real.eulerMascheroniConstant) * mass - kernel)
    (hPolarLower : -(2 * Real.sinh (w / 2) - w) * mass ≤ pole)
    (hPrimeRowZero : primeRow = 0)
    (hCompleteWeilIdentity : Q = gamma + pole + primeRow) :
    (143 / 12000 : ℝ) * mass + variance / 2 ≤ Q ∧ (1 / 100 : ℝ) * mass ≤ Q := by
  have hg := gamma_lower_from_analytic_inputs w mass variance cell kernel gamma
    hw hCellLower hKernelUpper hGammaIdentity
  have hgc := mul_le_mul_of_nonneg_right (gammaCoefficient_gt hw hwmax).le hmass
  have hp := mul_le_mul_of_nonneg_right (polar_coefficient_lt hwmax).le hmass
  constructor <;> nlinarith

theorem single_window_strict_from_analytic_inputs
    (w mass variance cell kernel gamma pole primeRow Q : ℝ)
    (hw : 0 < w) (hwmax : w ≤ 1 / 6) (hmass : 0 < mass)
    (hCellLower : Real.log 2 * mass + variance / 2 ≤ cell)
    (hKernelUpper : kernel ≤ (5 / 16 : ℝ) * w * mass)
    (hGammaIdentity : gamma = cell +
      (-Real.log w - Real.log (2 * Real.pi) - Real.eulerMascheroniConstant) * mass - kernel)
    (hPolarLower : -(2 * Real.sinh (w / 2) - w) * mass ≤ pole)
    (hPrimeRowZero : primeRow = 0)
    (hCompleteWeilIdentity : Q = gamma + pole + primeRow) :
    (143 / 12000 : ℝ) * mass + variance / 2 < Q := by
  have hg := gamma_lower_from_analytic_inputs w mass variance cell kernel gamma
    hw hCellLower hKernelUpper hGammaIdentity
  have hgc := mul_lt_mul_of_pos_right (gammaCoefficient_gt hw hwmax) hmass
  have hp := mul_lt_mul_of_pos_right (polar_coefficient_lt hwmax) hmass
  nlinarith

theorem log_narrow_corner : (109 : ℝ) / 50 < Real.log (98 / 11) := by
  have h := Real.exp_bound' (x := (109 : ℝ) / 200) (by norm_num) (by norm_num)
    (n := 8) (by norm_num)
  norm_num [Finset.sum_range_succ, Nat.factorial] at h
  have he : Real.exp ((109 : ℝ) / 200) ≤ 863 / 500 := by linarith
  have hp := pow_le_pow_left₀ (Real.exp_pos _).le he 4
  have he4 : Real.exp ((109 : ℝ) / 50) < 98 / 11 := by
    rw [show (109 / 50 : ℝ) = (4 : ℕ) * (109 / 200 : ℝ) by norm_num,
      Real.exp_nat_mul]
    exact lt_of_le_of_lt hp (by norm_num)
  exact (Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 98 / 11)).mpr he4

theorem gammaCoefficient_narrow_gt {w : ℝ} (hw : 0 < w) (hwmax : w ≤ 1 / 28) :
    (8 : ℝ) / 5 - 5 * w / 16 < gammaCoefficient w := by
  have hp : Real.pi < (22 : ℝ) / 7 := by linarith [Real.pi_lt_d4]
  have hd : 0 < Real.pi * w := mul_pos Real.pi_pos hw
  have hden : Real.pi * w < (11 : ℝ) / 98 := by
    have hmul := mul_le_mul_of_nonneg_left hwmax Real.pi_pos.le
    linarith
  have harg : (98 : ℝ) / 11 < 1 / (Real.pi * w) := by
    apply (lt_div_iff₀ hd).mpr
    nlinarith
  have hlog : Real.log (98 / 11 : ℝ) < Real.log (1 / (Real.pi * w)) :=
    Real.log_lt_log (by norm_num) harg
  unfold gammaCoefficient
  linarith [log_narrow_corner, euler_constant_lt]

theorem narrow_corner_budget {w : ℝ} (hw : 0 < w) (hwmax : w ≤ 1 / 28) :
    (19 : ℝ) / 12 < gammaCoefficient w - 1 / 1000 := by
  linarith [gammaCoefficient_narrow_gt hw hwmax]

/-- Narrow-window gamma comparison, with the integral/cell identification
still explicit. The weak inequality covers the zero profile. -/
theorem gamma_narrow_from_analytic_inputs
    (w mass variance cell kernel gamma : ℝ) (hw : 0 < w) (hwmax : w ≤ 1 / 28)
    (hmass : 0 ≤ mass)
    (hCellLower : Real.log 2 * mass + variance / 2 ≤ cell)
    (hKernelUpper : kernel ≤ (5 / 16 : ℝ) * w * mass)
    (hGammaIdentity : gamma = cell +
      (-Real.log w - Real.log (2 * Real.pi) - Real.eulerMascheroniConstant) * mass - kernel) :
    (19 / 12 : ℝ) * mass + variance / 2 ≤ gamma := by
  have hg := gamma_lower_from_analytic_inputs w mass variance cell kernel gamma
    hw hCellLower hKernelUpper hGammaIdentity
  have hc : (19 : ℝ) / 12 ≤ gammaCoefficient w := by
    linarith [narrow_corner_budget hw hwmax]
  have hm := mul_le_mul_of_nonneg_right hc hmass
  linarith

theorem single_window_narrow_strict_from_analytic_inputs
    (w mass variance cell kernel gamma pole primeRow Q : ℝ)
    (hw : 0 < w) (hwmax : w ≤ 1 / 28) (hmass : 0 < mass)
    (hCellLower : Real.log 2 * mass + variance / 2 ≤ cell)
    (hKernelUpper : kernel ≤ (5 / 16 : ℝ) * w * mass)
    (hGammaIdentity : gamma = cell +
      (-Real.log w - Real.log (2 * Real.pi) - Real.eulerMascheroniConstant) * mass - kernel)
    (hPolarLower : -(2 * Real.sinh (w / 2) - w) * mass ≤ pole)
    (hPrimeRowZero : primeRow = 0)
    (hCompleteWeilIdentity : Q = gamma + pole + primeRow) :
    (19 / 12 : ℝ) * mass + variance / 2 < Q := by
  have hg := gamma_lower_from_analytic_inputs w mass variance cell kernel gamma
    hw hCellLower hKernelUpper hGammaIdentity
  have hc := mul_lt_mul_of_pos_right (narrow_corner_budget hw hwmax) hmass
  have hp := mul_lt_mul_of_pos_right
    (polar_coefficient_lt (by linarith : w ≤ 1 / 6)) hmass
  nlinarith

/-- Scalar improvement from `23/42` to `67/84` in the existing pole-null
two-window comparison. Each gamma estimate and cross-row bound is explicitly
assumed, so this theorem does not construct the two-window Weil form. -/
theorem two_window_scalar_improvement
    (A B gammaL gammaR c crossPrime crossGamma kappa Q : ℝ)
    (hMass : 0 < A + B)
    (hGammaL : (19 / 12 : ℝ) * A ≤ gammaL)
    (hGammaR : (19 / 12 : ℝ) * B ≤ gammaR)
    (hc0 : 0 ≤ c) (hc : c < 3 / 4) (hk : kappa < 1 / 28)
    (hPrimeCross : 2 * crossPrime ≤ A + B)
    (hGammaCross : 2 * crossGamma ≤ kappa * (A + B))
    (hExactWeilPoleNull :
      Q = gammaL + gammaR - 2 * c * crossPrime - 2 * crossGamma) :
    (67 / 84 : ℝ) * (A + B) < Q := by
  have hPrimeScaled := mul_le_mul_of_nonneg_left hPrimeCross hc0
  have hCoef : (c + kappa) * (A + B) <
      (3 / 4 + 1 / 28 : ℝ) * (A + B) :=
    mul_lt_mul_of_pos_right (by linarith) hMass
  nlinarith [hPrimeScaled]

/-- The same comparison retaining both normalized-cell mean-zero energies. -/
theorem two_window_scalar_improvement_with_variance
    (A B VL VR gammaL gammaR c crossPrime crossGamma kappa Q : ℝ)
    (hMass : 0 < A + B)
    (hGammaL : (19 / 12 : ℝ) * A + VL / 2 ≤ gammaL)
    (hGammaR : (19 / 12 : ℝ) * B + VR / 2 ≤ gammaR)
    (hc0 : 0 ≤ c) (hc : c < 3 / 4) (hk : kappa < 1 / 28)
    (hPrimeCross : 2 * crossPrime ≤ A + B)
    (hGammaCross : 2 * crossGamma ≤ kappa * (A + B))
    (hExactWeilPoleNull :
      Q = gammaL + gammaR - 2 * c * crossPrime - 2 * crossGamma) :
    (67 / 84 : ℝ) * (A + B) + (VL + VR) / 2 < Q := by
  have hPrimeScaled := mul_le_mul_of_nonneg_left hPrimeCross hc0
  have hCoef : (c + kappa) * (A + B) <
      (3 / 4 + 1 / 28 : ℝ) * (A + B) :=
    mul_lt_mul_of_pos_right (by linarith) hMass
  nlinarith [hPrimeScaled]

#print axioms rho_bounds
#print axioms rho_abs_bound
#print axioms no_integer_log_difference
#print axioms conjugate_shift_product_zero
#print axioms conjugate_negative_shift_product_zero
#print axioms integral_conjugate_shift_product_zero
#print axioms integral_conjugate_negative_shift_product_zero
#print axioms log_corner
#print axioms euler_constant_lt
#print axioms gamma_corner_arithmetic
#print axioms full_corner_arithmetic
#print axioms complex_polar_algebra
#print axioms gammaCoefficient_eq
#print axioms gammaCoefficient_gt
#print axioms polar_coefficient_lt
#print axioms gamma_lower_from_analytic_inputs
#print axioms single_window_coercivity_from_analytic_inputs
#print axioms single_window_strict_from_analytic_inputs
#print axioms log_narrow_corner
#print axioms gammaCoefficient_narrow_gt
#print axioms narrow_corner_budget
#print axioms gamma_narrow_from_analytic_inputs
#print axioms single_window_narrow_strict_from_analytic_inputs
#print axioms two_window_scalar_improvement
#print axioms two_window_scalar_improvement_with_variance

end BuildingBlocks.ActualWeilSingleWindowCoercivity
