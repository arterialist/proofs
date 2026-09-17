import BuildingBlocks.FactorialPairedRenewal

open Finset MeasureTheory
namespace BuildingBlocks.FactorialBinaryCarry

noncomputable def pairedPort (N k : ℕ) (t : ℝ) : ℝ :=
  response ((2 * N) / k) t - response (N / k) (2 * t)

/-- Complete ordered offdiagonal products of a zero-sum finite real family. -/
theorem ordered_cross_of_sum_zero {ι : Type*} [DecidableEq ι] (s : Finset ι) (a : ι → ℝ)
    (ha : ∑ k ∈ s, a k = 0) :
    (∑ k ∈ s, ∑ l ∈ s, if k = l then 0 else a k * a l) = -(∑ k ∈ s, (a k)^2) := by
  have he : ∀ k ∈ s, (∑ l ∈ s, if k = l then 0 else a k * a l) = a k * (∑ l ∈ s, a l) - (a k)^2 := by
    intro k hk
    calc
      _ = ∑ l ∈ s, (a k * a l - if k = l then (a k)^2 else 0) := by
        apply Finset.sum_congr rfl
        intro l hl
        by_cases h : k = l
        · subst l; simp [pow_two]
        · simp [h]
      _ = _ := by rw [Finset.sum_sub_distrib, ← Finset.mul_sum]; simp [hk]
  rw [Finset.sum_congr rfl he]
  simp [ha, Finset.sum_neg_distrib]

/-- Actual complete paired quotient covariance, including all terminal copies and orders. -/
theorem paired_ordered_cross (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      if k = l then 0 else pairedPort N k t * pairedPort N l t) =
      -(∑ k ∈ Icc 1 (2 * N), (pairedPort N k t)^2) := by
  apply ordered_cross_of_sum_zero
  exact paired_quotient_response_sum_zero N t

/-- Entire positive-clock covariance of the complete summed rows with original density. -/
theorem paired_ordered_cross_clock (N : ℕ) :
    (∫ t in Set.Ioi 0, (∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      if k = l then 0 else pairedPort N k t * pairedPort N l t) * FactorialBinaryEnergy.weight t) =
      -(∫ t in Set.Ioi 0, (∑ k ∈ Icc 1 (2 * N), (pairedPort N k t)^2) * FactorialBinaryEnergy.weight t) := by
  simp_rw [paired_ordered_cross, neg_mul]
  exact integral_neg _

/-- Full compensated bilinear integrability for arbitrary finite signed natural-scale rows. -/
theorem finite_response_product_integrable {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c : ι → ℝ) (d : κ → ℝ) (q : ι → ℕ) (a : κ → ℕ) :
    IntegrableOn (fun t : ℝ => (∑ i ∈ s, c i * (1 - Real.exp (-(q i : ℝ) * t))) *
      (∑ j ∈ r, d j * (1 - Real.exp (-(a j : ℝ) * t))) * FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  have hi : IntegrableOn (fun t : ℝ => ∑ i ∈ s, ∑ j ∈ r,
      (c i * d j) * FactorialKernelDictionary.kernelRow (q i) (a j) t) (Set.Ioi 0) := by
    apply integrable_finset_sum
    intro i hi
    apply integrable_finset_sum
    intro j hj
    exact (FactorialKernelDictionary.kernelRow_integrable (q i) (a j)).const_mul _
  apply hi.congr
  apply Filter.Eventually.of_forall
  intro t
  symm
  simp only [Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
  ring

/-- Every product of actual responses at natural clock scales is absolutely integrable. -/
theorem actual_response_product_integrable (N M b c : ℕ) :
    IntegrableOn (fun t : ℝ => response N ((b : ℝ) * t) * response M ((c : ℝ) * t) *
      FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  have he : ∀ (K h : ℕ) (t : ℝ), response K ((h : ℝ) * t) =
      ∑ n ∈ Icc 1 K, (ArithmeticFunction.moebius n : ℝ) *
        (1 - Real.exp (-((h * (K / n) : ℕ) : ℝ) * t)) := by
    intro K h t
    unfold response
    apply Finset.sum_congr rfl
    intro n hn
    rw [Nat.cast_mul]
    congr 2
    ring
  simp_rw [he]
  exact finite_response_product_integrable _ _ _ _ _ _

/-- Absolute integrability of each full actual paired quotient product. -/
theorem pairedPort_product_integrable (N k l : ℕ) :
    IntegrableOn (fun t : ℝ => pairedPort N k t * pairedPort N l t * FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  have h11 := actual_response_product_integrable ((2 * N) / k) ((2 * N) / l) 1 1
  have h12 := actual_response_product_integrable ((2 * N) / k) (N / l) 1 2
  have h21 := actual_response_product_integrable (N / k) ((2 * N) / l) 2 1
  have h22 := actual_response_product_integrable (N / k) (N / l) 2 2
  simp only [Nat.cast_one, Nat.cast_ofNat, one_mul] at h11 h12 h21 h22
  apply ((h11.sub h12).sub h21 |>.add h22).congr
  exact Filter.Eventually.of_forall (fun t => by dsimp [pairedPort]; ring)

/-- Complete sum of individual ordered clock correlations equals minus total port energy. -/
theorem paired_integrated_covariance (N : ℕ) :
    (∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      ∫ t in Set.Ioi 0, if k = l then 0 else pairedPort N k t * pairedPort N l t * FactorialBinaryEnergy.weight t) =
      -(∑ k ∈ Icc 1 (2 * N), ∫ t in Set.Ioi 0, (pairedPort N k t)^2 * FactorialBinaryEnergy.weight t) := by
  have hi : ∀ k l : ℕ, IntegrableOn (fun t : ℝ => if k = l then 0 else
      pairedPort N k t * pairedPort N l t * FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
    intro k l
    by_cases h : k = l
    · simp only [h, ite_true]; exact integrableOn_zero
    · simpa only [h, ite_false] using pairedPort_product_integrable N k l
  have hd : ∀ k : ℕ, IntegrableOn (fun t : ℝ => (pairedPort N k t)^2 * FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
    intro k
    simpa only [pow_two] using pairedPort_product_integrable N k k
  have hc : (∫ t in Set.Ioi 0, ∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      if k = l then 0 else pairedPort N k t * pairedPort N l t * FactorialBinaryEnergy.weight t) =
      ∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
        ∫ t in Set.Ioi 0, if k = l then 0 else pairedPort N k t * pairedPort N l t * FactorialBinaryEnergy.weight t := by
    rw [integral_finset_sum (Icc 1 (2 * N)) (fun k hk => integrable_finset_sum _ (fun l hl => hi k l))]
    apply Finset.sum_congr rfl
    intro k hk
    exact integral_finset_sum (Icc 1 (2 * N)) (fun l hl => hi k l)
  have hs := paired_ordered_cross_clock N
  simp_rw [Finset.sum_mul, ite_mul, zero_mul] at hs
  rw [hc, integral_finset_sum (Icc 1 (2 * N)) (fun k hk => hd k)] at hs
  exact hs

#print axioms paired_integrated_covariance
#print axioms finite_response_product_integrable
#print axioms actual_response_product_integrable
#print axioms pairedPort_product_integrable
#print axioms ordered_cross_of_sum_zero
#print axioms paired_ordered_cross
#print axioms paired_ordered_cross_clock
end BuildingBlocks.FactorialBinaryCarry
