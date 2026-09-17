import Mathlib.RingTheory.Polynomial.Cyclotomic.Eval
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

noncomputable section
open scoped BigOperators
open Polynomial
namespace BuildingBlocks.CyclotomicBoundary

theorem cyclotomic_eval_ne_zero_of_primitive {α : ℂ} {n m : ℕ}
    (hα : IsPrimitiveRoot α n) (hm : 0 < m) (hmn : m ≠ n) :
    (cyclotomic m ℂ).eval α ≠ 0 := by
  intro h
  have hp : IsPrimitiveRoot α m :=
    (Polynomial.isRoot_cyclotomic_iff_charZero hm).mp h
  exact hmn (hp.eq_orderOf.trans hα.eq_orderOf.symm)

/-- A coarse algebraic chord bound, avoiding angular parametrization. -/
theorem root_chord_lower_bound {z : ℂ} {n : ℕ} (hn : 0 < n)
    (hzpow : z ^ n = 1) (hz : z ≠ 1) (hznorm : ‖z‖ = 1) :
    (n : ℝ)⁻¹ ≤ ‖1 - z‖ := by
  have ht (j : ℕ) : ‖1 - z ^ j‖ ≤ (j : ℝ) * ‖1 - z‖ := by
    induction j with
    | zero => simp
    | succ j ih =>
      calc
        ‖1 - z ^ (j + 1)‖ = ‖(1 - z ^ j) + z ^ j * (1 - z)‖ := by
          congr 1
          rw [pow_succ]
          ring
        _ ≤ ‖1 - z ^ j‖ + ‖z ^ j * (1 - z)‖ := norm_add_le _ _
        _ = ‖1 - z ^ j‖ + ‖1 - z‖ := by simp [norm_pow, hznorm]
        _ ≤ (j : ℝ) * ‖1 - z‖ + ‖1 - z‖ := add_le_add_right ih _
        _ = ((j + 1 : ℕ) : ℝ) * ‖1 - z‖ := by push_cast; ring
  have hs : ∑ j ∈ Finset.range n, z ^ j = 0 := by
    rw [geom_sum_eq hz, hzpow, sub_self, zero_div]
  have heq : ∑ j ∈ Finset.range n, (1 - z ^ j) = (n : ℂ) := by
    rw [Finset.sum_sub_distrib, hs]
    simp
  have hle : (n : ℝ) ≤ (n : ℝ) * ((n : ℝ) * ‖1 - z‖) := by
    calc
      (n : ℝ) = ‖∑ j ∈ Finset.range n, (1 - z ^ j)‖ := by
        rw [heq]; simp
      _ ≤ ∑ j ∈ Finset.range n, ‖1 - z ^ j‖ := norm_sum_le _ _
      _ ≤ ∑ _j ∈ Finset.range n, (n : ℝ) * ‖1 - z‖ := by
        apply Finset.sum_le_sum
        intro j hj
        exact (ht j).trans (mul_le_mul_of_nonneg_right
          (by exact_mod_cast (Finset.mem_range.mp hj).le) (norm_nonneg _))
      _ = (n : ℝ) * ((n : ℝ) * ‖1 - z‖) := by simp
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hone : 1 ≤ (n : ℝ) * ‖1 - z‖ := by nlinarith
  apply (mul_le_mul_iff_right₀ hnR).mp
  simpa [mul_comm, mul_inv_cancel₀ (ne_of_gt hnR)] using hone

/-- Every nonvanishing root-of-unity chord has logarithm bounded by its conductor. -/
theorem abs_log_primitive_chord_le {α : ℂ} {n d : ℕ}
    (hα : IsPrimitiveRoot α n) (hn : 0 < n) (hnd : ¬ n ∣ d) :
    |Real.log ‖1 - α ^ d‖| ≤ Real.log n := by
  have hn2 : 2 ≤ n := by
    by_contra h
    have : n = 1 := by omega
    exact hnd (by simp [this])
  have hz : α ^ d ≠ 1 := fun h => hnd ((hα.pow_eq_one_iff_dvd d).mp h)
  have hnorm : ‖α ^ d‖ = 1 := by
    simp [norm_pow, hα.norm'_eq_one (Nat.ne_of_gt hn)]
  have hpow : (α ^ d) ^ n = 1 := by
    rw [← pow_mul, Nat.mul_comm, pow_mul, hα.pow_eq_one, one_pow]
  have hl := root_chord_lower_bound hn hpow hz hnorm
  have hnR : 0 < (n : ℝ) := by exact_mod_cast hn
  have hpos : 0 < ‖1 - α ^ d‖ := lt_of_lt_of_le (inv_pos.mpr hnR) hl
  have hu : ‖1 - α ^ d‖ ≤ (n : ℝ) := by
    calc
      ‖1 - α ^ d‖ ≤ ‖(1 : ℂ)‖ + ‖α ^ d‖ := norm_sub_le _ _
      _ = 2 := by norm_num [hnorm]
      _ ≤ (n : ℝ) := by exact_mod_cast hn2
  apply abs_le.mpr
  constructor
  · simpa using Real.log_le_log (inv_pos.mpr hnR) hl
  · exact Real.log_le_log hpos hu

/-- Finite radial regularization of a divisor term. In particular conductor one
uses `log d` for every divisor, never the totalized value `log 0`. -/
def regularizedDivisorLog (α : ℂ) (n d : ℕ) : ℝ :=
  if n ∣ d then Real.log d else Real.log ‖1 - α ^ d‖

/-- Each correctly regularized term is bounded, including at conductor one. -/
theorem abs_regularizedDivisorLog_le {α : ℂ} {n N d : ℕ}
    (hα : IsPrimitiveRoot α n) (hn : 0 < n) (hnN : n ≤ N)
    (hd : d ∈ N.divisors) :
    |regularizedDivisorLog α n d| ≤ Real.log N := by
  have hN : 0 < N := lt_of_lt_of_le hn hnN
  have hdvd : d ∣ N := (Nat.mem_divisors.mp hd).1
  have hdpos : 0 < d := Nat.pos_of_dvd_of_pos hdvd hN
  have hdN : d ≤ N := Nat.le_of_dvd hN hdvd
  unfold regularizedDivisorLog
  split_ifs with hnd
  · rw [abs_of_nonneg (Real.log_nonneg (by exact_mod_cast hdpos))]
    exact Real.log_le_log (by exact_mod_cast hdpos) (by exact_mod_cast hdN)
  · exact (abs_log_primitive_chord_le hα hn hnd).trans
      (Real.log_le_log (by exact_mod_cast hn) (by exact_mod_cast hnN))

/-- The precise remaining radial-limit identity. It applies only to old factors;
born factors must not be given this identity. -/
def OldFactorRegularizedIdentity (α : ℂ) (n N : ℕ) : Prop :=
  Real.log ‖(cyclotomic N ℂ).eval α‖ =
    ∑ d ∈ N.divisors, (ArithmeticFunction.moebius (N / d) : ℝ) *
      regularizedDivisorLog α n d

/-- Once the exact regularized identity is supplied, the old-factor logarithm
bound follows from proved term estimates and the Moebius coefficient bound. -/
theorem oldFactor_log_bound_of_regularizedIdentity {α : ℂ} {n N : ℕ}
    (hα : IsPrimitiveRoot α n) (hn : 0 < n) (hnN : n < N)
    (hidentity : OldFactorRegularizedIdentity α n N) :
    |Real.log ‖(cyclotomic N ℂ).eval α‖| ≤
      (N.divisors.card : ℝ) * Real.log N := by
  rw [hidentity]
  calc
    |∑ d ∈ N.divisors, (ArithmeticFunction.moebius (N / d) : ℝ) *
        regularizedDivisorLog α n d| ≤
      ∑ d ∈ N.divisors, |(ArithmeticFunction.moebius (N / d) : ℝ) *
        regularizedDivisorLog α n d| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _d ∈ N.divisors, Real.log N := by
      apply Finset.sum_le_sum
      intro d hd
      rw [abs_mul]
      have hmu : |(ArithmeticFunction.moebius (N / d) : ℝ)| ≤ 1 := by
        exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := N / d))
      exact (mul_le_mul_of_nonneg_right hmu (abs_nonneg _)).trans
        (by simpa using abs_regularizedDivisorLog_le hα hn hnN.le hd)
    _ = (N.divisors.card : ℝ) * Real.log N := by simp

end BuildingBlocks.CyclotomicBoundary
