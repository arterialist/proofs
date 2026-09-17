import BuildingBlocks.FixedProfileGreenAdmissionFinite

namespace BuildingBlocks.FiniteDivisorEnvelopeSplit

open Finset
open scoped BigOperators

/-- Exact low-divisor/exponential-tail split.  It is deliberately stated for
an arbitrary row, so later analytic envelopes can be inserted without changing
any actual divisor coefficient. -/
theorem divisor_sum_low_add_tail (f : ℕ → ℝ) (N D : ℕ) :
    (∑ d ∈ N.divisors, f d) =
      (∑ d ∈ N.divisors with d ≤ D, f d) +
      (∑ d ∈ N.divisors with D < d, f d) := by
  classical
  rw [← Finset.sum_filter_add_sum_filter_not N.divisors (fun d => d ≤ D) f]
  congr 1
  have heq : {d ∈ N.divisors | ¬ d ≤ D} = {d ∈ N.divisors | D < d} := by
    ext d
    simp only [Finset.mem_filter, not_le]
  rw [heq]

/-- A nonnegative low-divisor row is bounded by the complete integer envelope
on the same finite range. -/
theorem divisor_low_le_integer_envelope (f : ℕ → ℝ) (N D : ℕ)
    (hf : ∀ d, 0 ≤ f d) :
    (∑ d ∈ N.divisors with 1 ≤ d ∧ d ≤ D, f d) ≤
      ∑ d ∈ Finset.Icc 1 D, f d := by
  classical
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro d hd
    simp only [Finset.mem_filter] at hd
    exact Finset.mem_Icc.mpr hd.2
  · intro d hd₁ hd₂
    exact hf d

/-- Absolute values allow restriction from the primorial divisor packet to a
complete finite integer majorant; no cancellation is assumed. -/
theorem abs_divisor_low_sum_le (f : ℕ → ℝ) (N D : ℕ) :
    |∑ d ∈ N.divisors with 1 ≤ d ∧ d ≤ D, f d| ≤
      ∑ d ∈ Finset.Icc 1 D, |f d| := by
  calc
    |∑ d ∈ N.divisors with 1 ≤ d ∧ d ≤ D, f d| ≤
        ∑ d ∈ N.divisors with 1 ≤ d ∧ d ≤ D, |f d| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ d ∈ Finset.Icc 1 D, |f d| :=
      divisor_low_le_integer_envelope (fun d => |f d|) N D (fun d => abs_nonneg _)

#print axioms divisor_sum_low_add_tail
#print axioms divisor_low_le_integer_envelope
#print axioms abs_divisor_low_sum_le

end BuildingBlocks.FiniteDivisorEnvelopeSplit
