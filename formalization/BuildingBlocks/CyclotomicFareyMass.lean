import BuildingBlocks.CyclotomicFareyEndpoints
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Rat.BigOperators

open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary

/-- The final complete residue block for the neighbor denominators. -/
def fareyDenominatorBlock (n N : ℕ) : Finset ℕ :=
  (Finset.Icc (N - n + 1) N).filter (fun b => Nat.Coprime b n)

/-- The remaining Farey theorem: each actual neighbor denominator enumerates the
coprime final block exactly once. Its two maps record different directions even
when the two neighboring circle points coincide. -/
def FareyNeighborEnumeration : Prop :=
  ∀ n N : ℕ, 2 ≤ n → n ≤ N →
    ∃ (left right : {a // a ∈ phaseLabels n} ≃ {b // b ∈ fareyDenominatorBlock n N}),
      ∀ a : {a // a ∈ phaseLabels n},
        fareyLeftGap N (phaseRat n a) = 1 / ((n : ℚ) * (left a).val) ∧
        fareyRightGap N (phaseRat n a) = 1 / ((n : ℚ) * (right a).val)

/-- A geometric partition statement kept explicit until the finite circular
ordering proof is supplied. -/
def FareyTotalMassIdentity : Prop :=
  ∀ N : ℕ, 1 ≤ N → ∑ n ∈ Finset.Icc 1 N, fareySectorMass n N = 1

theorem fareySectorMassIdentity_of_neighborEnumeration (h : FareyNeighborEnumeration) :
    FareySectorMassIdentity := by
  intro n N hn hnN hN
  by_cases hn1 : n = 1
  · subst n
    rw [fareySectorMass_one hN]
    have hN1 : 1 ≤ N := by omega
    simp [Nat.sub_add_cancel hN1]
  · have hn2 : 2 ≤ n := by omega
    obtain ⟨left, right, hgap⟩ := h n N hn2 hnN
    have hl : (∑ a ∈ phaseLabels n, fareyLeftGap N (phaseRat n a)) =
        ∑ b ∈ fareyDenominatorBlock n N, 1 / ((n : ℚ) * b) := by
      rw [← Finset.sum_coe_sort (phaseLabels n),
        ← Finset.sum_coe_sort (fareyDenominatorBlock n N)]
      exact Fintype.sum_equiv left
        (fun a => fareyLeftGap N (phaseRat n a.val))
        (fun b => 1 / ((n : ℚ) * b.val)) (fun a => (hgap a).1)
    have hr : (∑ a ∈ phaseLabels n, fareyRightGap N (phaseRat n a)) =
        ∑ b ∈ fareyDenominatorBlock n N, 1 / ((n : ℚ) * b) := by
      rw [← Finset.sum_coe_sort (phaseLabels n),
        ← Finset.sum_coe_sort (fareyDenominatorBlock n N)]
      exact Fintype.sum_equiv right
        (fun a => fareyRightGap N (phaseRat n a.val))
        (fun b => 1 / ((n : ℚ) * b.val)) (fun a => (hgap a).2)
    have hq : (∑ a ∈ phaseLabels n,
        (fareyLeftGap N (phaseRat n a) + fareyRightGap N (phaseRat n a)) / 2) =
        (1 / (n : ℚ)) * ∑ b ∈ fareyDenominatorBlock n N, (1 / (b : ℚ)) := by
      rw [← Finset.sum_div, Finset.sum_add_distrib, hl, hr]
      rw [Finset.mul_sum]
      simp only [one_div_mul_one_div]
      ring
    have hc := congrArg (fun q : ℚ => (q : ℝ)) hq
    push_cast at hc
    simpa [fareySectorMass, fareyWeight, fareyDenominatorBlock] using hc

theorem fareySectorMass_le_inv_age (h : FareySectorMassIdentity)
    {n N : ℕ} (hn : 1 ≤ n) (hnN : n < N) :
    fareySectorMass n N ≤ 1 / ((N - n : ℕ) : ℝ) := by
  have hnle : n ≤ N := hnN.le
  have hN : 2 ≤ N := by omega
  have hk : 0 < N - n := by omega
  have hnr : (0 : ℝ) < n := by exact_mod_cast hn
  have hkr : (0 : ℝ) < (N - n : ℕ) := by exact_mod_cast hk
  have hcard : (fareyDenominatorBlock n N).card ≤ n := by
    calc
      _ ≤ (Finset.Icc (N - n + 1) N).card := Finset.card_filter_le _ _
      _ = n := by rw [Nat.card_Icc]; omega
  have hsum : (∑ b ∈ fareyDenominatorBlock n N, (1 / (b : ℝ))) ≤
      (n : ℝ) * (1 / ((N - n : ℕ) : ℝ)) := by
    calc
      _ ≤ ∑ _b ∈ fareyDenominatorBlock n N, (1 / ((N - n : ℕ) : ℝ)) := by
        apply Finset.sum_le_sum
        intro b hb
        have hbl := (Finset.mem_Icc.mp (Finset.mem_filter.mp hb).1).1
        exact one_div_le_one_div_of_le hkr (by exact_mod_cast (show N - n ≤ b by omega))
      _ = ((fareyDenominatorBlock n N).card : ℝ) * (1 / ((N - n : ℕ) : ℝ)) := by simp
      _ ≤ (n : ℝ) * (1 / ((N - n : ℕ) : ℝ)) := by
        exact mul_le_mul_of_nonneg_right (by exact_mod_cast hcard) (by positivity)
  rw [h n N hn hnle hN]
  change (1 / (n : ℝ)) * (∑ b ∈ fareyDenominatorBlock n N, 1 / (b : ℝ)) ≤ _
  calc
    _ ≤ (1 / (n : ℝ)) * ((n : ℝ) * (1 / ((N - n : ℕ) : ℝ))) :=
      mul_le_mul_of_nonneg_left hsum (by positivity)
    _ = _ := by field_simp

theorem fareySelectedMass_le_one (h : FareyTotalMassIdentity)
    {N : ℕ} (hN : 1 ≤ N) {s : Finset ℕ} (hs : s ⊆ Finset.Icc 1 N) :
    ∑ n ∈ s, fareySectorMass n N ≤ 1 := by
  rw [← h N hN]
  exact Finset.sum_le_sum_of_subset_of_nonneg hs (fun i _ _ => fareySectorMass_nonneg i N)

/-- The elementary determinant argument behind the missing Farey-neighbor proof.
A strict intermediate fraction has denominator at least the sum of the endpoint
denominators when their determinant is one. -/
theorem denominator_ge_of_determinant_one {a b c n d m : ℤ}
    (hn : 0 ≤ n) (hd : 0 ≤ d) (hdet : c * n - a * d = 1)
    (hl : a * m < b * n) (hr : b * d < c * m) : n + d ≤ m := by
  have hleft : 1 ≤ b * n - a * m := by omega
  have hright : 1 ≤ c * m - b * d := by omega
  have hid : m = d * (b * n - a * m) + n * (c * m - b * d) := by
    calc
      m = m * (c * n - a * d) := by rw [hdet]; ring
      _ = _ := by ring
  have hdl := mul_le_mul_of_nonneg_left hleft hd
  have hnr := mul_le_mul_of_nonneg_left hright hn
  linarith

end BuildingBlocks.CyclotomicBoundary
