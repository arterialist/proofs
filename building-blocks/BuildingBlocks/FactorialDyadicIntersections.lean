import BuildingBlocks.FactorialKernelDictionary
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma

open Finset
namespace BuildingBlocks.FactorialDyadicIntersections

/-- Saturating subtraction includes empty intersections and zero quotient rows. -/
def intersectionCount (X n m a b : ℕ) : ℕ :=
  min (min (2 * X) ((a + 1) * n)) ((b + 1) * m) - max (max X (a * n)) (b * m)

theorem quotient_interval (N n a : ℕ) (hn : 0 < n) :
    N / n = a ↔ a * n ≤ N ∧ N < (a + 1) * n := by
  rw [Nat.div_eq_iff hn, Nat.add_mul, one_mul]
  omega

/-- The exact simultaneous quotient fiber, including both half-open endpoints. -/
theorem quotient_fiber (X n m a b : ℕ) (hn : 0 < n) (hm : 0 < m) :
    ((Ico X (2 * X)).filter (fun N => N / n = a ∧ N / m = b)) =
      Ico (max (max X (a * n)) (b * m))
        (min (min (2 * X) ((a + 1) * n)) ((b + 1) * m)) := by
  ext N
  simp only [mem_filter, mem_Ico, quotient_interval N n a hn, quotient_interval N m b hm,
    max_le_iff, lt_min_iff]
  tauto

theorem quotient_fiber_card (X n m a b : ℕ) (hn : 0 < n) (hm : 0 < m) :
    ((Ico X (2 * X)).filter (fun N => N / n = a ∧ N / m = b)).card =
      intersectionCount X n m a b := by
  rw [quotient_fiber X n m a b hn hm, Nat.card_Ico]
  rfl

/-- Complete joint floor distribution, before any sign or periodic approximation. -/
theorem dyadic_quotient_sum (X n m : ℕ) (hn : 0 < n) (hm : 0 < m) (F : ℕ → ℕ → ℝ) :
    (∑ N ∈ Ico X (2 * X), F (N / n) (N / m)) =
      ∑ a ∈ range (2 * X + 1), ∑ b ∈ range (2 * X + 1),
        (intersectionCount X n m a b : ℝ) * F a b := by
  have hmaps : ∀ N ∈ Ico X (2 * X),
      (N / n, N / m) ∈ (range (2 * X + 1)).product (range (2 * X + 1)) := by
    intro N hN
    have h1 := Nat.div_le_self N n
    have h2 := Nat.div_le_self N m
    simp only [Finset.product_eq_sprod, Finset.mem_product, Finset.mem_range]
    have hN2 := (mem_Ico.mp hN).2
    omega
  have hs := sum_fiberwise_of_maps_to hmaps (fun N => F (N / n) (N / m))
  rw [← hs, Finset.product_eq_sprod, Finset.sum_product]
  apply sum_congr rfl
  intro a ha
  apply sum_congr rfl
  intro b hb
  have hf : ((Ico X (2 * X)).filter (fun N => (N / n, N / m) = (a, b))) =
      ((Ico X (2 * X)).filter (fun N => N / n = a ∧ N / m = b)) := by
    ext N
    simp only [mem_filter, Prod.mk.injEq]
  rw [hf]
  have he : ∀ N ∈ (Ico X (2 * X)).filter (fun N => N / n = a ∧ N / m = b),
      F (N / n) (N / m) = F a b := by
    intro N hN
    rw [(mem_filter.mp hN).2.1, (mem_filter.mp hN).2.2]
  rw [sum_congr rfl he]
  simp only [sum_const, nsmul_eq_mul, quotient_fiber_card X n m a b hn hm]

/-- The original compensated factorial kernel, with every zero-size row retained. -/
theorem dyadic_kernel_intersections (X n m : ℕ) (hn : 0 < n) (hm : 0 < m) :
    (∑ N ∈ Ico X (2 * X), FactorialKernelDictionary.kernel (N / n) (N / m)) =
      ∑ a ∈ range (2 * X + 1), ∑ b ∈ range (2 * X + 1),
        (intersectionCount X n m a b : ℝ) * FactorialKernelDictionary.kernel a b :=
  dyadic_quotient_sum X n m hn hm FactorialKernelDictionary.kernel

/-- Zero quotient histories permit a common complete support for the whole block. -/
theorem actual_energy_extended (N Y : ℕ) (hNY : N ≤ Y) :
    FactorialBinaryIntegrability.integratedEnergy N =
      ∑ n ∈ Icc 1 Y, ∑ m ∈ Icc 1 Y,
        (ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ) *
          FactorialKernelDictionary.kernel (N / n) (N / m) := by
  have he : ∀ t : ℝ,
      (∑ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ) *
        (1 - Real.exp (-((N / n : ℕ) : ℝ) * t))) = FactorialBinaryCarry.response N t := by
    intro t
    unfold FactorialBinaryCarry.response
    symm
    apply sum_subset
    · intro n hn
      exact mem_Icc.mpr ⟨(mem_Icc.mp hn).1, (mem_Icc.mp hn).2.trans hNY⟩
    · intro n hn hnot
      have h1 := (mem_Icc.mp hn).1
      have hlarge : N < n := by simp only [mem_Icc] at hnot; omega
      simp [Nat.div_eq_of_lt hlarge]
  rw [← FactorialKernelDictionary.quadratic_integral]
  simp_rw [he]
  rfl

/-- Entire original dyadic energy: actual signs, all quotient pairs and the full kernel. -/
theorem actual_dyadic_energy_intersections (X : ℕ) :
    (∑ N ∈ Ico X (2 * X), FactorialBinaryIntegrability.integratedEnergy N) =
      ∑ n ∈ Icc 1 (2 * X - 1), ∑ m ∈ Icc 1 (2 * X - 1),
        (ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ) *
          (∑ a ∈ range (2 * X + 1), ∑ b ∈ range (2 * X + 1),
            (intersectionCount X n m a b : ℝ) * FactorialKernelDictionary.kernel a b) := by
  have he : ∀ N ∈ Ico X (2 * X),
      FactorialBinaryIntegrability.integratedEnergy N =
        ∑ n ∈ Icc 1 (2 * X - 1), ∑ m ∈ Icc 1 (2 * X - 1),
          (ArithmeticFunction.moebius n : ℝ) * (ArithmeticFunction.moebius m : ℝ) *
            FactorialKernelDictionary.kernel (N / n) (N / m) := by
    intro N hN
    apply actual_energy_extended
    have hN2 := (mem_Ico.mp hN).2
    omega
  rw [sum_congr rfl he, sum_comm]
  apply sum_congr rfl
  intro n hn
  rw [sum_comm]
  apply sum_congr rfl
  intro m hm
  rw [← mul_sum, dyadic_kernel_intersections X n m (mem_Icc.mp hn).1 (mem_Icc.mp hm).1]

#print axioms actual_energy_extended
#print axioms actual_dyadic_energy_intersections
#print axioms quotient_interval
#print axioms quotient_fiber
#print axioms quotient_fiber_card
#print axioms dyadic_quotient_sum
#print axioms dyadic_kernel_intersections
end BuildingBlocks.FactorialDyadicIntersections
