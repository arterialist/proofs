import BuildingBlocks.MertensArithmetic

open Finset
open scoped BigOperators
namespace BuildingBlocks
open MertensTransfer HyperbolaProduct

theorem quotient_floor_mass {N : ℕ} (hN : 0 < N) :
    ∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) * (q : ℝ) = 1 := by
  have hh := congrArg (fun z : ℤ => (z : ℝ)) (moebius_floor_mass hN)
  simp only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] at hh
  rw [sum_grouped_by_quotient] at hh
  simpa only [quotientCoefficient, Int.cast_sum] using hh


end BuildingBlocks
