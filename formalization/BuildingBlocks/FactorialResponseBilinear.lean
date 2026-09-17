import BuildingBlocks.FactorialPairedCovariance

open Finset MeasureTheory
namespace BuildingBlocks.FactorialBinaryCarry

/-- Full ordered bilinear row, with arbitrary finite signed coefficients. -/
theorem finite_response_product_row {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c : ι → ℝ) (d : κ → ℝ) (q : ι → ℕ) (a : κ → ℕ) (t : ℝ) :
    (∑ i ∈ s, c i * (1 - Real.exp (-(q i : ℝ) * t))) *
      (∑ j ∈ r, d j * (1 - Real.exp (-(a j : ℝ) * t))) * FactorialBinaryEnergy.weight t =
      ∑ i ∈ s, ∑ j ∈ r, (c i * d j) * FactorialKernelDictionary.kernelRow (q i) (a j) t := by
  simp only [Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
  ring

/-- Exact full positive-clock bilinear integral for the original compensated kernel. -/
theorem finite_response_product_integral {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c : ι → ℝ) (d : κ → ℝ) (q : ι → ℕ) (a : κ → ℕ) :
    (∫ t in Set.Ioi 0, (∑ i ∈ s, c i * (1 - Real.exp (-(q i : ℝ) * t))) *
      (∑ j ∈ r, d j * (1 - Real.exp (-(a j : ℝ) * t))) * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ s, ∑ j ∈ r, (c i * d j) * FactorialKernelDictionary.kernel (q i) (a j) := by
  simp_rw [finite_response_product_row]
  have hi : ∀ i j, IntegrableOn (fun t => (c i * d j) *
      FactorialKernelDictionary.kernelRow (q i) (a j) t) (Set.Ioi 0) := by
    intro i j
    exact (FactorialKernelDictionary.kernelRow_integrable (q i) (a j)).const_mul _
  rw [integral_finset_sum s (fun i hi' => integrable_finset_sum r (fun j hj => hi i j))]
  apply Finset.sum_congr rfl
  intro i hi'
  rw [integral_finset_sum r (fun j hj => hi i j)]
  apply Finset.sum_congr rfl
  intro j hj
  rw [integral_const_mul, FactorialKernelDictionary.kernel_integral]

/-- Original response at a natural clock scale in its exact ungrouped quotient basis. -/
theorem response_scaled_basis (K h : ℕ) (t : ℝ) :
    response K ((h : ℝ) * t) = ∑ n ∈ Icc 1 K, (ArithmeticFunction.moebius n : ℝ) *
      (1 - Real.exp (-((h * (K / n) : ℕ) : ℝ) * t)) := by
  unfold response
  apply Finset.sum_congr rfl
  intro n hn
  rw [Nat.cast_mul]
  rw [show -((K / n : ℕ) : ℝ) * ((h : ℝ) * t) =
    -((h : ℝ) * ((K / n : ℕ) : ℝ)) * t by ring]

/-- Exact actual cross-response energy, retaining all natural quotient pairs and signs. -/
theorem actual_response_product_integral (N M b c : ℕ) :
    (∫ t in Set.Ioi 0, response N ((b : ℝ) * t) * response M ((c : ℝ) * t) *
      FactorialBinaryEnergy.weight t) =
      ∑ n ∈ Icc 1 N, ∑ m ∈ Icc 1 M,
        ((ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ)) *
        FactorialKernelDictionary.kernel (b * (N / n)) (c * (M / m)) := by
  simp_rw [response_scaled_basis]
  exact finite_response_product_integral _ _ _ _ _ _

/-- The actual old-response mixed port retains both complete kernel sums. -/
theorem actual_old_innovation_kernel (N : ℕ) :
    (∫ t in Set.Ioi 0, response N (2 * t) * pairedPort N 1 t * FactorialBinaryEnergy.weight t) =
      (∑ n ∈ Icc 1 N, ∑ m ∈ Icc 1 (2 * N),
        ((ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ)) *
          FactorialKernelDictionary.kernel (2 * (N / n)) ((2 * N) / m)) -
      (∑ n ∈ Icc 1 N, ∑ m ∈ Icc 1 N,
        ((ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ)) *
          FactorialKernelDictionary.kernel (2 * (N / n)) (2 * (N / m))) := by
  have h1 := actual_response_product_integrable N (2 * N) 2 1
  have h2 := actual_response_product_integrable N N 2 2
  simp only [Nat.cast_ofNat, Nat.cast_one, one_mul] at h1 h2
  have he : (fun t : ℝ => response N (2 * t) * pairedPort N 1 t * FactorialBinaryEnergy.weight t) =
      fun t => response N (2 * t) * response (2 * N) t * FactorialBinaryEnergy.weight t -
        response N (2 * t) * response N (2 * t) * FactorialBinaryEnergy.weight t := by
    funext t
    simp only [pairedPort, Nat.div_one]
    ring
  rw [he, integral_sub h1 h2]
  have h3 := actual_response_product_integral N (2 * N) 2 1
  have h4 := actual_response_product_integral N N 2 2
  simp only [Nat.cast_ofNat, Nat.cast_one, one_mul] at h3 h4
  rw [h3, h4]

#print axioms actual_old_innovation_kernel
#print axioms finite_response_product_row
#print axioms finite_response_product_integral
#print axioms response_scaled_basis
#print axioms actual_response_product_integral
end BuildingBlocks.FactorialBinaryCarry
