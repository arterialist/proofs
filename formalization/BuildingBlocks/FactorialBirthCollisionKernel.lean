import BuildingBlocks.FactorialKernelDictionary
import BuildingBlocks.FactorialOriginNeutralization
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic

open MeasureTheory Filter
namespace BuildingBlocks.FactorialBirthCollisionKernel

noncomputable def row (h : ℕ) (t : ℝ) : ℝ :=
  (1 - Real.exp (-t))^2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t) * FactorialBinaryEnergy.weight t

noncomputable def kernel (h : ℕ) : ℝ := ∫ t in Set.Ioi 0, row h t

theorem row_nonnegative (h : ℕ) (t : ℝ) (ht : 0 < t) : 0 ≤ row h t := by
  unfold row
  exact mul_nonneg (mul_nonneg (sq_nonneg _) (Real.exp_pos _).le)
    (FactorialBinaryEnergy.weight_pos t ht).le

theorem row_integrable (h : ℕ) : IntegrableOn (row h) (Set.Ioi 0) := by
  have hm : Measurable (row h) := by unfold row FactorialBinaryEnergy.weight; fun_prop
  apply (FactorialKernelDictionary.kernelRow_integrable 1 1).mono' hm.aestronglyMeasurable
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
  rw [Real.norm_eq_abs, abs_of_nonneg (row_nonnegative h t ht)]
  have he : Real.exp (-((h - 2 : ℕ) : ℝ) * t) ≤ 1 :=
    Real.exp_le_one_iff.mpr (by
      have hh : (0 : ℝ) ≤ (h - 2 : ℕ) := by positivity
      exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hh) ht.le)
  unfold row FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
  norm_num only [Nat.cast_one, neg_one_mul]
  have hw := (FactorialBinaryEnergy.weight_pos t ht).le
  nlinarith [mul_nonneg (sq_nonneg (1 - Real.exp (-t))) hw,
    mul_le_mul_of_nonneg_left he (mul_nonneg (sq_nonneg (1 - Real.exp (-t))) hw)]

theorem kernel_two : kernel 2 = Real.log 2 := by
  have he : row 2 = FactorialKernelDictionary.kernelRow 1 1 := by
    funext t
    simp [row, FactorialKernelDictionary.kernelRow, FactorialEntropyIntegral.numerator, pow_two]
  unfold kernel
  rw [he, FactorialKernelDictionary.kernel_integral]
  norm_num [FactorialKernelDictionary.kernel]
  ring

theorem kernel_nonnegative (h : ℕ) : 0 ≤ kernel h := by
  unfold kernel
  apply integral_nonneg_of_ae
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
  exact row_nonnegative h t ht

theorem row_exponential_majorant (h : ℕ) (t : ℝ) (ht : 0 < t) :
    row h t ≤ t / 2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t) := by
  have hf := FactorialBinaryIntegrability.exponential_increment_bounds 1 t (by norm_num) ht.le
  norm_num only [neg_one_mul, one_mul] at hf
  have hf2 : (1 - Real.exp (-t))^2 ≤ t^2 := pow_le_pow_left₀ hf.1 hf.2.2 2
  have hw := FactorialOriginNeutralization.weight_le_half_inverse t ht
  unfold row
  calc
    _ ≤ ((1 - Real.exp (-t))^2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) * (1 / (2 * t)) :=
      mul_le_mul_of_nonneg_left hw (by positivity)
    _ ≤ (t^2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) * (1 / (2 * t)) :=
      mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hf2 (Real.exp_pos _).le) (by positivity)
    _ = _ := by field_simp

theorem kernel_gap_bound (h : ℕ) (hh : 3 ≤ h) :
    kernel h ≤ 1 / (2 * (((h - 2 : ℕ) : ℝ))^2) := by
  have ha : (0 : ℝ) < (h - 2 : ℕ) := by exact_mod_cast (by omega : 0 < h - 2)
  have hi : IntegrableOn (fun t : ℝ => t / 2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) (Set.Ioi 0) := by
    have hg := integrableOn_rpow_mul_exp_neg_mul_rpow (s := 1) (p := 1)
      (by norm_num) (by norm_num) ha
    have hg' : IntegrableOn (fun t : ℝ => t * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) (Set.Ioi 0) := by
      simpa only [Real.rpow_one] using hg
    have hd := hg'.div_const 2
    simpa only [mul_div_assoc, div_mul_eq_mul_div] using hd
  have hm := Real.integral_rpow_mul_exp_neg_mul_Ioi (a := 2) (by norm_num) ha
  have hg : Real.Gamma 2 = 1 := by norm_num
  norm_num [Real.rpow_two, hg] at hm
  have hex : (fun t : ℝ => t * Real.exp (-(((h - 2 : ℕ) : ℝ) * t))) =
      (fun t : ℝ => t * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) := by
    funext t
    congr 1
    congr 1
    ring
  rw [hex] at hm
  have he : (fun t : ℝ => t / 2 * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) =
      (fun t : ℝ => (t * Real.exp (-((h - 2 : ℕ) : ℝ) * t)) / 2) := by funext t; ring
  have hb := integral_mono_ae (row_integrable h) hi (by
    filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
    exact row_exponential_majorant h t ht)
  unfold kernel
  apply hb.trans_eq
  rw [he, integral_div, hm]
  field_simp

theorem kernel_inverse_square_bound (h : ℕ) (hh : 2 ≤ h) :
    kernel h ≤ 9 / (2 * (h : ℝ)^2) := by
  by_cases he : h = 2
  · subst h
    rw [kernel_two]
    have hl := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    norm_num at hl ⊢
    linarith
  have hh3 : 3 ≤ h := by omega
  have hhr : (3 : ℝ) ≤ h := by exact_mod_cast hh3
  have ha : (0 : ℝ) < (h - 2 : ℕ) := by exact_mod_cast (by omega : 0 < h - 2)
  have hc : ((h - 2 : ℕ) : ℝ) = (h : ℝ) - 2 := by rw [Nat.cast_sub hh]; norm_num
  have hl : (h : ℝ) ≤ 3 * ((h - 2 : ℕ) : ℝ) := by rw [hc]; linarith
  have hs := pow_le_pow_left₀ (by positivity : (0 : ℝ) ≤ h) hl 2
  apply (kernel_gap_bound h hh3).trans
  apply (div_le_div_iff₀ (by positivity) (by positivity)).mpr
  nlinarith

#print axioms row_nonnegative
#print axioms row_integrable
#print axioms kernel_two
#print axioms kernel_nonnegative
#print axioms row_exponential_majorant
#print axioms kernel_gap_bound
#print axioms kernel_inverse_square_bound
end BuildingBlocks.FactorialBirthCollisionKernel
