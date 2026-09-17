import Mathlib.Tactic

open scoped BigOperators
open Finset

namespace PaidThetaCompensation

/-!
Finite-kernel algebra behind the radius-two positive-kernel reduction. A
single nonnegative kernel may already be the sum of a continuous quadrature
kernel and every oriented prime-power atom. Cauchy is applied only after
that sum has been formed.
-/

variable {U V : Type*} [Fintype U] [Fintype V]

def kernelColumn (k : U → V → ℝ) (x : V → ℝ) (u : U) : ℝ :=
  ∑ v, k u v * x v

noncomputable def kernelColumnComplex (k : U → V → ℝ) (x : V → ℂ) (u : U) : ℂ :=
  ∑ v, (k u v : ℂ) * x v

def kernelRowMass (k : U → V → ℝ) (u : U) : ℝ :=
  ∑ v, k u v

def pulledWeight (mu w : U → ℝ) (k : U → V → ℝ) (v : V) : ℝ :=
  ∑ u, mu u * w u * kernelRowMass k u * k u v

/-- Weighted Cauchy for one row of a nonnegative kernel. -/
theorem kernel_row_cauchy
    (k : V → ℝ) (x : V → ℝ) (hk : ∀ v, 0 ≤ k v) :
    (∑ v, k v * x v)^2 ≤ (∑ v, k v) * ∑ v, k v * (x v)^2 := by
  have h := sum_mul_sq_le_sq_mul_sq (Finset.univ)
    (fun v => Real.sqrt (k v)) (fun v => Real.sqrt (k v) * x v)
  have hroot : ∀ v, Real.sqrt (k v) * Real.sqrt (k v) = k v := by
    intro v
    nlinarith [Real.sq_sqrt (hk v)]
  have hsq : ∀ v, (Real.sqrt (k v))^2 = k v :=
    fun v => Real.sq_sqrt (hk v)
  simp_rw [← mul_assoc, hroot] at h
  simpa [mul_pow, mul_assoc, hsq] using h

/-- Complex version, obtained by applying the real row inequality to the
real and imaginary parts without splitting the kernel column. -/
theorem kernel_row_cauchy_complex
    (k : V → ℝ) (x : V → ℂ) (hk : ∀ v, 0 ≤ k v) :
    Complex.normSq (∑ v, (k v : ℂ) * x v) ≤
      (∑ v, k v) * ∑ v, k v * Complex.normSq (x v) := by
  have hre := kernel_row_cauchy k (fun v => (x v).re) hk
  have him := kernel_row_cauchy k (fun v => (x v).im) hk
  rw [Complex.normSq_apply]
  simp only [Complex.re_sum, Complex.im_sum, Complex.mul_re,
    Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero,
    Complex.mul_im, add_zero]
  conv_lhs => rw [← pow_two, ← pow_two]
  calc
    (∑ v, k v * (x v).re)^2 + (∑ v, k v * (x v).im)^2 ≤
        (∑ v, k v) * (∑ v, k v * (x v).re^2) +
        (∑ v, k v) * (∑ v, k v * (x v).im^2) := add_le_add hre him
    _ = (∑ v, k v) * ∑ v, k v * Complex.normSq (x v) := by
      simp_rw [Complex.normSq_apply, mul_add, Finset.sum_add_distrib]
      ring_nf

/-- Exact finite Jensen--Schur reduction. -/
theorem positive_kernel_cauchy_reduction
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℝ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * (kernelColumn k x u)^2) ≤
      ∑ v, pulledWeight mu w k v * (x v)^2 := by
  have hrow : ∀ u,
      mu u * w u * (kernelColumn k x u)^2 ≤
        mu u * w u * (kernelRowMass k u * ∑ v, k u v * (x v)^2) := by
    intro u
    exact mul_le_mul_of_nonneg_left
      (kernel_row_cauchy (k u) x (hk u)) (mul_nonneg (hmu u) (hw u))
  calc
    (∑ u, mu u * w u * (kernelColumn k x u)^2) ≤
        ∑ u, mu u * w u *
          (kernelRowMass k u * ∑ v, k u v * (x v)^2) :=
      Finset.sum_le_sum fun u _ => hrow u
    _ = ∑ v, pulledWeight mu w k v * (x v)^2 := by
      simp only [pulledWeight, kernelRowMass]
      simp_rw [mul_sum, Finset.sum_mul]
      rw [Finset.sum_comm]
      simp_rw [mul_sum]
      ring_nf

/-- Complex finite-kernel reduction used by the Hermitian theta form. -/
theorem positive_kernel_cauchy_reduction_complex
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℂ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * Complex.normSq (kernelColumnComplex k x u)) ≤
      ∑ v, pulledWeight mu w k v * Complex.normSq (x v) := by
  have hrow : ∀ u,
      mu u * w u * Complex.normSq (kernelColumnComplex k x u) ≤
        mu u * w u *
          (kernelRowMass k u * ∑ v, k u v * Complex.normSq (x v)) := by
    intro u
    exact mul_le_mul_of_nonneg_left
      (kernel_row_cauchy_complex (k u) x (hk u))
      (mul_nonneg (hmu u) (hw u))
  calc
    (∑ u, mu u * w u * Complex.normSq (kernelColumnComplex k x u)) ≤
        ∑ u, mu u * w u *
          (kernelRowMass k u * ∑ v, k u v * Complex.normSq (x v)) :=
      Finset.sum_le_sum fun u _ => hrow u
    _ = ∑ v, pulledWeight mu w k v * Complex.normSq (x v) := by
      simp only [pulledWeight, kernelRowMass]
      simp_rw [mul_sum, Finset.sum_mul]
      rw [Finset.sum_comm]
      simp_rw [mul_sum]
      ring_nf

/-- Division by the positive ground normalization preserves the bound. -/
theorem positive_kernel_normalized_reduction
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℝ) (a : ℝ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) (ha : 0 < a) :
    (∑ u, mu u * w u * (kernelColumn k x u)^2) / a ≤
      (∑ v, pulledWeight mu w k v * (x v)^2) / a := by
  exact div_le_div_of_nonneg_right
    (positive_kernel_cauchy_reduction mu w k x hmu hw hk) ha.le

omit [Fintype U] in
/-- Continuous and arithmetic pieces are combined before Cauchy. -/
theorem combined_kernel_column
    (kc kp : U → V → ℝ) (x : V → ℝ) (u : U) :
    kernelColumn (fun u v => kc u v + kp u v) x u =
      kernelColumn kc x u + kernelColumn kp x u := by
  simp [kernelColumn, add_mul, Finset.sum_add_distrib]

omit [Fintype U] in
/-- Complex combined column identity. -/
theorem combined_kernel_column_complex
    (kc kp : U → V → ℝ) (x : V → ℂ) (u : U) :
    kernelColumnComplex (fun u v => kc u v + kp u v) x u =
      kernelColumnComplex kc x u + kernelColumnComplex kp x u := by
  simp [kernelColumnComplex, add_mul, Finset.sum_add_distrib]

omit [Fintype U] in
/-- The row mass in the pulled weight retains the same combined kernel. -/
theorem combined_kernel_rowMass
    (kc kp : U → V → ℝ) (u : U) :
    kernelRowMass (fun u v => kc u v + kp u v) u =
      kernelRowMass kc u + kernelRowMass kp u := by
  simp [kernelRowMass, Finset.sum_add_distrib]

/-- The killed-potential pointwise certificate after the kernel reduction. -/
theorem pointwise_weight_pays_port
    (W kappa : V → ℝ) (x : V → ℝ) (a alpha internal : ℝ)
    (ha : 0 < a) (hinternal : 0 ≤ internal)
    (hpoint : ∀ v, W v / a + alpha ≤ kappa v) :
    (∑ v, W v * (x v)^2) / a ≤
      internal + ∑ v, kappa v * (x v)^2 - alpha * ∑ v, (x v)^2 := by
  have hv : ∀ v, (W v / a) * (x v)^2 ≤
      (kappa v - alpha) * (x v)^2 := by
    intro v
    exact mul_le_mul_of_nonneg_right (by linarith [hpoint v]) (sq_nonneg (x v))
  have hs := Finset.sum_le_sum fun v (_ : v ∈ (Finset.univ : Finset V)) => hv v
  calc
    (∑ v, W v * (x v)^2) / a = ∑ v, (W v / a) * (x v)^2 := by
      rw [Finset.sum_div]
      apply Finset.sum_congr rfl
      intro v _
      field_simp [ha.ne']
    _ ≤ ∑ v, (kappa v - alpha) * (x v)^2 := hs
    _ ≤ internal + ∑ v, kappa v * (x v)^2 - alpha * ∑ v, (x v)^2 := by
      simp_rw [sub_mul]
      rw [Finset.sum_sub_distrib, ← Finset.mul_sum]
      linarith

end PaidThetaCompensation

#print axioms PaidThetaCompensation.kernel_row_cauchy
#print axioms PaidThetaCompensation.kernel_row_cauchy_complex
#print axioms PaidThetaCompensation.positive_kernel_cauchy_reduction
#print axioms PaidThetaCompensation.positive_kernel_cauchy_reduction_complex
#print axioms PaidThetaCompensation.pointwise_weight_pays_port
