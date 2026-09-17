import Mathlib.Tactic
import Mathlib.Data.Real.Basic

namespace BuildingBlocks.FiniteWeilPrimeCertificate

def selected : List ℕ :=
  [9697, 9719, 9721, 9733, 9739, 9743, 9749, 9767,
   9769, 9781, 9787, 9791, 9803, 9811, 9817, 9829,
   9833, 9839, 9851, 9857, 9859, 9871, 9883, 9887]

theorem prime_10007 : Nat.Prime 10007 := by norm_num

theorem selected_primes : ∀ q ∈ selected, Nat.Prime q := by
  norm_num [selected]

theorem selected_window : ∀ q ∈ selected,
    q < 10007 ∧ 32 * (10007 - q) < 10007 ∧ 8192 < q ∧ q < 102 ^ 2 := by
  norm_num [selected]

theorem selected_distinct_count : selected.Nodup ∧ selected.length = 24 := by
  norm_num [selected, List.nodup_cons]

theorem positive_margin :
    (24 * 13 : ℝ) / 1632 - 14 / 400 - 49 / 344 = 251 / 18275 ∧
    (0 : ℝ) < 251 / 18275 := by norm_num

#print axioms prime_10007
#print axioms selected_primes
#print axioms selected_window
#print axioms selected_distinct_count
#print axioms positive_margin

end BuildingBlocks.FiniteWeilPrimeCertificate
