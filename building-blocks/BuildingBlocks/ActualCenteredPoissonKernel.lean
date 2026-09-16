import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Tactic

namespace BuildingBlocks.ActualCenteredPoissonKernel

open Finset

/-- The centered Poisson covariance kernel is an exact positive geometric tail.
The index `k` is the distance from the larger of the two horizons. -/
theorem centeredKernel_eq_tail (q : ℝ) (n m : ℕ) :
    q ^ max n m - q ^ (n + m) =
      (1 - q) * ∑ k ∈ range (min n m), q ^ (max n m + k) := by
  have hsum :
      (∑ k ∈ range (min n m), q ^ (max n m + k)) =
        q ^ max n m * ∑ k ∈ range (min n m), q ^ k := by
    simp_rw [pow_add]
    rw [mul_sum]
  rw [hsum]
  have hgeom := geom_sum_mul_neg q (min n m)
  have hnm : max n m + min n m = n + m := by
    omega
  calc
    q ^ max n m - q ^ (n + m) =
        q ^ max n m - q ^ (max n m + min n m) := by rw [hnm]
    _ = q ^ max n m * (1 - q ^ min n m) := by
      rw [pow_add]
      ring
    _ = q ^ max n m * ((∑ k ∈ range (min n m), q ^ k) * (1 - q)) := by
      rw [hgeom]
    _ = (1 - q) * (q ^ max n m * ∑ k ∈ range (min n m), q ^ k) := by ring

/-- For `0 ≤ q ≤ 1`, every centered covariance entry is nonnegative. -/
theorem centeredKernel_nonneg {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1)
    (n m : ℕ) : 0 ≤ q ^ max n m - q ^ (n + m) := by
  rw [centeredKernel_eq_tail]
  exact mul_nonneg (sub_nonneg.mpr hq1)
    (sum_nonneg fun k _ => pow_nonneg hq0 _)

#print axioms centeredKernel_eq_tail
#print axioms centeredKernel_nonneg

end BuildingBlocks.ActualCenteredPoissonKernel
