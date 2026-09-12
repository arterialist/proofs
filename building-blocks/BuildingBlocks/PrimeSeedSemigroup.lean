import BuildingBlocks.PrimeSeedCompoundPoisson
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Algebra.BigOperators.NatAntidiagonal

/-! Addition of process times for the complete prime-seed Poisson law. -/

open MeasureTheory ProbabilityTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedProcess

theorem jumpPower_add (μ : Measure ℝ) [IsProbabilityMeasure μ] (m n : ℕ) :
    jumpPower μ m ∗ jumpPower μ n = jumpPower μ (m + n) := by
  induction m with
  | zero => simp [jumpPower]
  | succ m ih =>
    rw [jumpPower, Measure.conv_assoc, ih, Nat.succ_add, jumpPower]

private theorem exp_coeff_add (r s : ℝ) (n : ℕ) :
    (r + s) ^ n / n.factorial =
      ∑ k ∈ Finset.range (n + 1),
        (r ^ k / k.factorial) * (s ^ (n - k) / (n - k).factorial) := by
  rw [add_pow, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro k hk
  have hkn : k ≤ n := Nat.lt_succ_iff.mp (Finset.mem_range.mp hk)
  have hcast : (n.choose k : ℝ) * k.factorial * (n - k).factorial = n.factorial := by
    exact_mod_cast Nat.choose_mul_factorial_mul_factorial hkn
  have hk0 : (k.factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero k
  have hnk0 : ((n - k).factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero (n - k)
  have hn0 : (n.factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero n
  have hchoose : (n.choose k : ℝ) = n.factorial / (k.factorial * (n - k).factorial) := by
    apply (eq_div_iff (mul_ne_zero hk0 hnk0)).2
    nlinarith [hcast]
  rw [hchoose]
  field_simp

theorem poissonPMFReal_add (r s : ℝ≥0) (n : ℕ) :
    poissonPMFReal (r + s) n =
      ∑ k ∈ Finset.range (n + 1), poissonPMFReal r k * poissonPMFReal s (n - k) := by
  simp only [poissonPMFReal, NNReal.coe_add, neg_add, exp_add]
  rw [show exp (-(r : ℝ)) * exp (-(s : ℝ)) * ((r : ℝ) + s) ^ n / n.factorial =
      (exp (-(r : ℝ)) * exp (-(s : ℝ))) *
        (((r : ℝ) + s) ^ n / n.factorial) by ring,
    exp_coeff_add, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro k _
  ring

theorem poissonPMF_add_antidiagonal (r s : ℝ≥0) (n : ℕ) :
    (∑ k ∈ Finset.antidiagonal n, poissonPMF r k.1 * poissonPMF s k.2) =
      poissonPMF (r + s) n := by
  rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ
    (fun a b => poissonPMF r a * poissonPMF s b) n]
  change (∑ k ∈ Finset.range (n + 1),
    ENNReal.ofReal (poissonPMFReal r k) * ENNReal.ofReal (poissonPMFReal s (n - k))) =
      ENNReal.ofReal (poissonPMFReal (r + s) n)
  simp_rw [← ENNReal.ofReal_mul poissonPMFReal_nonneg]
  rw [← ENNReal.ofReal_sum_of_nonneg (fun k _ =>
    mul_nonneg poissonPMFReal_nonneg poissonPMFReal_nonneg), ← poissonPMFReal_add]

private theorem tsum_pair_antidiagonal (F : ℕ × ℕ → ℝ≥0∞) :
    (∑' k, F k) = ∑' n : ℕ, ∑ k ∈ Finset.antidiagonal n, F k := by
  rw [← Finset.sigmaAntidiagonalEquivProd.tsum_eq F, ENNReal.tsum_sigma']
  apply tsum_congr
  intro n
  rw [tsum_fintype]
  change (∑ b : Finset.antidiagonal n, F b.val) = _
  exact Finset.sum_coe_sort (Finset.antidiagonal n) F

private theorem conv_sum_sum (f g : ℕ → Measure ℝ) [∀ n, SFinite (g n)] :
    (Measure.sum f) ∗ (Measure.sum g) =
      Measure.sum (fun k : ℕ × ℕ => f k.1 ∗ g k.2) := by
  unfold Measure.conv
  rw [Measure.prod_sum, Measure.map_sum (by fun_prop)]

/-- Every pair of jump histories is retained when process times are added. -/
theorem poissonLaw_add (μ : Measure ℝ) [IsProbabilityMeasure μ] (r s : ℝ≥0) :
    poissonLaw μ r ∗ poissonLaw μ s = poissonLaw μ (r + s) := by
  have hconv : poissonLaw μ r ∗ poissonLaw μ s = Measure.sum (fun k : ℕ × ℕ =>
      (poissonPMF r k.1 * poissonPMF s k.2) • jumpPower μ (k.1 + k.2)) := by
    unfold poissonLaw
    rw [conv_sum_sum]
    congr 1
    funext k
    rw [Measure.conv_smul_right, Measure.conv_smul_left, smul_smul, jumpPower_add,
      mul_comm (poissonPMF s k.2) (poissonPMF r k.1)]
  ext A hA
  rw [hconv, poissonLaw, Measure.sum_apply _ hA, Measure.sum_apply _ hA]
  simp only [Measure.smul_apply, smul_eq_mul]
  rw [tsum_pair_antidiagonal]
  apply tsum_congr
  intro n
  calc
    (∑ k ∈ Finset.antidiagonal n,
      (poissonPMF r k.1 * poissonPMF s k.2) * (jumpPower μ (k.1 + k.2)) A) =
        ∑ k ∈ Finset.antidiagonal n,
          (poissonPMF r k.1 * poissonPMF s k.2) * (jumpPower μ n) A := by
      apply Finset.sum_congr rfl
      intro k hk
      rw [Finset.mem_antidiagonal.mp hk]
    _ = (∑ k ∈ Finset.antidiagonal n, poissonPMF r k.1 * poissonPMF s k.2) *
        (jumpPower μ n) A := by rw [Finset.sum_mul]
    _ = _ := by rw [poissonPMF_add_antidiagonal]

/-- The actual finite-prime positive process is a convolution semigroup. -/
theorem seedProcess_add (S : Finset Nat.Primes) (u v : ℝ≥0) :
    seedProcess S u ∗ seedProcess S v = seedProcess S (u + v) := by
  simp only [seedProcess, add_mul, poissonLaw_add]

end BuildingBlocks.PrimeSeedProcess
