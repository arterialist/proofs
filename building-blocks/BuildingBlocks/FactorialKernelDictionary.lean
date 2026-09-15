import BuildingBlocks.FactorialEntropyIntegral
import BuildingBlocks.FactorialDensityIntegral

open Set MeasureTheory Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialKernelDictionary
open FactorialBinaryEnergy

noncomputable def kernel (n m : ℕ) : ℝ :=
  ((n : ℝ) + m) * Real.log ((n : ℝ) + m) -
    (n : ℝ) * Real.log n - (m : ℝ) * Real.log m -
    Real.log ((n + m).choose n : ℝ)

noncomputable def kernelRow (n m : ℕ) (t : ℝ) : ℝ :=
  FactorialEntropyIntegral.numerator n m t * weight t

theorem kernelRow_eq (n m : ℕ) (t : ℝ) :
    kernelRow n m t = FactorialEntropyIntegral.integrand n m t -
      FactorialDensityIntegral.integrand n m t := by
  unfold kernelRow weight FactorialEntropyIntegral.integrand
    FactorialEntropyIntegral.numerator FactorialDensityIntegral.integrand
  ring

theorem kernelRow_integrable (n m : ℕ) : IntegrableOn (kernelRow n m) (Ioi 0) := by
  have he := FactorialEntropyIntegral.entropy_integrable (n : ℝ) m (by positivity) (by positivity)
  have hd := FactorialDensityIntegral.factorial_density_integrable n m
  apply (he.sub hd).congr
  exact Filter.Eventually.of_forall (fun t => (kernelRow_eq n m t).symm)

theorem kernel_integral (n m : ℕ) :
    (∫ t in Ioi 0, kernelRow n m t) = kernel n m := by
  simp_rw [kernelRow_eq]
  rw [integral_sub
    (FactorialEntropyIntegral.entropy_integrable (n : ℝ) m (by positivity) (by positivity))
    (FactorialDensityIntegral.factorial_density_integrable n m),
    FactorialEntropyIntegral.entropy_integral_nat,
    FactorialDensityIntegral.factorial_density_log_choose]
  rfl

theorem quadratic_row {ι : Type*} (s : Finset ι) (c : ι → ℝ) (q : ι → ℕ) (t : ℝ) :
    (∑ i ∈ s, c i * (1 - Real.exp (-(q i : ℝ) * t))) ^ 2 * weight t =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * kernelRow (q i) (q j) t := by
  simp only [pow_two, sum_mul, mul_sum]
  apply sum_congr rfl
  intro i hi
  apply sum_congr rfl
  intro j hj
  unfold kernelRow FactorialEntropyIntegral.numerator
  ring

theorem quadratic_integral {ι : Type*} (s : Finset ι) (c : ι → ℝ) (q : ι → ℕ) :
    (∫ t in Ioi 0, (∑ i ∈ s, c i * (1 - Real.exp (-(q i : ℝ) * t))) ^ 2 * weight t) =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * kernel (q i) (q j) := by
  simp_rw [quadratic_row]
  have hi : ∀ i j, IntegrableOn (fun t => c i * c j * kernelRow (q i) (q j) t) (Ioi 0) :=
    fun i j => (kernelRow_integrable (q i) (q j)).const_mul _
  rw [integral_finset_sum s (fun i _ => integrable_finset_sum s (fun j _ => hi i j))]
  apply sum_congr rfl
  intro i _
  rw [integral_finset_sum s (fun j _ => hi i j)]
  apply sum_congr rfl
  intro j _
  rw [integral_const_mul, kernel_integral]

theorem quadratic_nonneg {ι : Type*} (s : Finset ι) (c : ι → ℝ) (q : ι → ℕ) :
    0 ≤ ∑ i ∈ s, ∑ j ∈ s, c i * c j * kernel (q i) (q j) := by
  rw [← quadratic_integral]
  apply integral_nonneg_of_ae
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
  exact mul_nonneg (sq_nonneg _) (weight_pos t ht).le

theorem actual_moebius_energy (N : ℕ) :
    FactorialBinaryIntegrability.integratedEnergy N =
      ∑ n ∈ Icc 1 N, ∑ m ∈ Icc 1 N,
        (ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ) *
          kernel (N / n) (N / m) := by
  unfold FactorialBinaryIntegrability.integratedEnergy energyRow FactorialBinaryCarry.response
  exact quadratic_integral (Icc 1 N) (fun n => (ArithmeticFunction.moebius n : ℝ))
    (fun n => N / n)

#print axioms quadratic_row
#print axioms quadratic_integral
#print axioms actual_moebius_energy
#print axioms quadratic_nonneg

#print axioms kernelRow_eq
#print axioms kernelRow_integrable
#print axioms kernel_integral

end BuildingBlocks.FactorialKernelDictionary
