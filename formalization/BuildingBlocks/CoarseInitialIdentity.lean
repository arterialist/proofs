import BuildingBlocks.CoarseDyadicBase
import BuildingBlocks.CoarsePrimeBounds

open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

theorem primePsi_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (psi ⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
  have hneg : (-s).re < -1 := by simpa using neg_lt_neg hs
  have hl : IntegrableOn (fun x : ℝ => (x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
    apply (integrableOn_Ioi_cpow_of_lt hneg zero_lt_one).congr_fun _ measurableSet_Ioi
    intro x hx
    exact (linear_kernel_eq (by change 1 < x at hx; linarith)).symm
  have hm : Measurable (fun x : ℝ => (psi ⌊x⌋₊ : ℂ)) :=
    Complex.measurable_ofReal.comp ((measurable_of_countable psi).comp measurable_id.nat_floor)
  have hc : ContinuousOn (fun x : ℝ => (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
    intro x hx
    exact (Complex.continuousAt_ofReal_cpow_const _ _
      (Or.inr (by change 1 < x at hx; linarith))).continuousWithinAt
  refine (hl.norm.const_mul (4 * Real.log 2)).mono'
    (hm.aestronglyMeasurable.mul (hc.aestronglyMeasurable measurableSet_Ioi)) ?_
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  have hx0 : 0 ≤ x := by change 1 < x at hx; linarith
  have hc0 : 0 ≤ 4 * Real.log 2 := by positivity
  have hp : psi ⌊x⌋₊ ≤ (4 * Real.log 2) * x :=
    (psi_le_linear _).trans (mul_le_mul_of_nonneg_left (Nat.floor_le hx0) hc0)
  simp only [norm_mul, Complex.norm_real, Real.norm_of_nonneg (psi_nonneg _),
    Real.norm_of_nonneg hx0]
  simpa only [mul_assoc] using mul_le_mul_of_nonneg_right hp (norm_nonneg _)

theorem primeErrorReal_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
  have hneg : (-s).re < -1 := by simpa using neg_lt_neg hs
  have hl : IntegrableOn (fun x : ℝ => (x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
    apply (integrableOn_Ioi_cpow_of_lt hneg zero_lt_one).congr_fun _ measurableSet_Ioi
    intro x hx
    exact (linear_kernel_eq (by change 1 < x at hx; linarith)).symm
  simpa only [primeErrorReal, Complex.ofReal_sub, sub_mul] using
    (primePsi_kernel_integrable_unconditional hs).sub hl

theorem coarse_dyadic_Ioc_union :
    (⋃ k : ℕ, Ioc ((2 : ℝ)^k) ((2 : ℝ)^(k + 1))) = Ioi 1 := by
  ext x
  constructor
  · intro hx
    obtain ⟨k, hk⟩ := mem_iUnion.mp hx
    exact lt_of_le_of_lt (one_le_pow₀ (by norm_num)) hk.1
  · intro hx
    have hex : ∃ n : ℕ, x ≤ (2 : ℝ)^n := by
      obtain ⟨n, hn⟩ := pow_unbounded_of_one_lt x (by norm_num : (1 : ℝ) < 2)
      exact ⟨n, hn.le⟩
    let n := Nat.find hex
    have hn : x ≤ (2 : ℝ)^n := Nat.find_spec hex
    have hn0 : n ≠ 0 := by
      intro h
      simp only [h, pow_zero] at hn
      exact (not_le_of_gt hx) hn
    obtain ⟨k, hk⟩ := Nat.exists_eq_succ_of_ne_zero hn0
    apply mem_iUnion.mpr
    refine ⟨k, ?_, ?_⟩
    · have hmin := Nat.find_min hex (show k < Nat.find hex by change k < n; omega)
      exact lt_of_not_ge hmin
    · simpa only [hk, Nat.succ_eq_add_one] using hn

theorem coarseMellinBlock_hasSum_integral {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun k : ℕ => coarseMellinBlock k s)
      (∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) := by
  have hd : Pairwise (fun i j : ℕ =>
      Disjoint (Ioc ((2 : ℝ)^i) ((2 : ℝ)^(i+1)))
        (Ioc ((2 : ℝ)^j) ((2 : ℝ)^(j+1)))) := by
    intro i j hij
    rcases lt_or_gt_of_ne hij with h | h
    · exact Ioc_disjoint_Ioc_of_le
        (pow_le_pow_right₀ (by norm_num) (by omega : i+1 ≤ j))
    · exact (Ioc_disjoint_Ioc_of_le
        (pow_le_pow_right₀ (by norm_num) (by omega : j+1 ≤ i))).symm
  have hi := primeErrorReal_kernel_integrable_unconditional hs
  rw [← coarse_dyadic_Ioc_union] at hi
  have hh := hasSum_integral_iUnion (fun k : ℕ =>
    (measurableSet_Ioc : MeasurableSet (Ioc ((2 : ℝ)^k) ((2 : ℝ)^(k+1))))) hd hi
  rw [coarse_dyadic_Ioc_union] at hh
  convert hh using 1
  funext k
  rw [coarseMellinBlock, intervalIntegral.integral_of_le (by nlinarith [pow_pos (by norm_num : (0 : ℝ) < 2) k])]
  simp only [pow_succ, mul_comm]

theorem coarseMellinSum_eq_integral {s : ℂ} (hs : 1 < s.re) :
    coarseMellinSum s =
      ∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)) :=
  (coarseMellinBlock_hasSum_integral hs).tsum_eq

theorem coarseMellinSum_eq_logDerivative {s : ℂ} (hs : 1 < s.re) :
    s * coarseMellinSum s =
      -deriv riemannZeta s / riemannZeta s - s / (s - 1) := by
  have hneg : (-s).re < -1 := by simpa using neg_lt_neg hs
  have hp := primePsi_kernel_integrable_unconditional hs
  have hl : IntegrableOn (fun x : ℝ => (x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1) := by
    apply (integrableOn_Ioi_cpow_of_lt hneg zero_lt_one).congr_fun _ measurableSet_Ioi
    intro x hx
    exact (linear_kernel_eq (by change 1 < x at hx; linarith)).symm
  have hli : (∫ x : ℝ in Ioi 1, (x : ℂ) * (x : ℂ) ^ (-(s + 1))) = 1 / (s - 1) := by
    rw [setIntegral_congr_fun measurableSet_Ioi
      (fun x hx => linear_kernel_eq (s := s) (by change 1 < x at hx; linarith)),
      integral_Ioi_cpow_of_lt hneg zero_lt_one]
    simp only [Complex.ofReal_one, Complex.one_cpow]
    convert (neg_div_neg_eq (1 : ℂ) (s - 1)) using 1; congr 1; ring
  rw [coarseMellinSum_eq_integral hs,
    zeta_logDerivative_eq_prime_integral_unconditional hs]
  simp_rw [primeErrorReal, Complex.ofReal_sub, sub_mul]
  rw [integral_sub hp hl, hli]
  ring

end BuildingBlocks.CoarsePrimitive

#print axioms BuildingBlocks.CoarsePrimitive.coarseMellinBlock_hasSum_integral
#print axioms BuildingBlocks.CoarsePrimitive.coarseMellinSum_eq_integral
#print axioms BuildingBlocks.CoarsePrimitive.coarseMellinSum_eq_logDerivative
