import BuildingBlocks.CyclotomicFareyBasic
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Rat.BigOperators

open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary

/-- Reduced labels give each rational phase exactly once. -/
theorem phaseRat_eq_iff_labels {n m a b : ℕ}
    (ha : a ∈ phaseLabels n) (hb : b ∈ phaseLabels m) :
    phaseRat n a = phaseRat m b ↔ n = m ∧ a = b := by
  constructor
  · intro h
    have hn : n ≠ 0 := Nat.ne_of_gt (Nat.zero_lt_of_lt (mem_phaseLabels.mp ha).1)
    have hm : m ≠ 0 := Nat.ne_of_gt (Nat.zero_lt_of_lt (mem_phaseLabels.mp hb).1)
    have hc : a * m = b * n := by
      have hcross := (div_eq_div_iff (by exact_mod_cast hn : (n : ℚ) ≠ 0)
        (by exact_mod_cast hm : (m : ℚ) ≠ 0)).mp h
      exact_mod_cast hcross
    have hnm : n ∣ m := (mem_phaseLabels.mp ha).2.symm.dvd_of_dvd_mul_left
      (by rw [hc]; exact Nat.dvd_mul_left n b)
    have hmn : m ∣ n := (mem_phaseLabels.mp hb).2.symm.dvd_of_dvd_mul_left
      (by rw [← hc]; exact Nat.dvd_mul_left m a)
    have heq : n = m := Nat.dvd_antisymm hnm hmn
    refine ⟨heq, ?_⟩
    subst m
    exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero hn) hc
  · rintro ⟨rfl, rfl⟩
    rfl

/-- The exact finite geometric statement needed for mass one. This is a premise,
not a definition of the weights and not an axiom. -/
def FareyGapPartition (N : ℕ) : Prop :=
  ∑ x ∈ fareyPhases N, (fareyLeftGap N x + fareyRightGap N x) = 2

/-- The actual phase set is a disjoint union of its reduced conductor labels. -/
theorem sum_fareyPhases {M : Type*} [AddCommMonoid M] (N : ℕ) (f : ℚ → M) :
    ∑ x ∈ fareyPhases N, f x =
      ∑ n ∈ Finset.Icc 1 N, ∑ a ∈ phaseLabels n, f (phaseRat n a) := by
  unfold fareyPhases
  rw [Finset.sum_biUnion]
  · apply Finset.sum_congr rfl
    intro n hn
    apply Finset.sum_image
    intro a ha b hb hab
    exact ((phaseRat_eq_iff_labels ha hb).mp hab).2
  · intro n hn m hm hnm
    apply Finset.disjoint_left.mpr
    intro x hx hy
    obtain ⟨a, ha, rfl⟩ := Finset.mem_image.mp hx
    obtain ⟨b, hb, hab⟩ := Finset.mem_image.mp hy
    exact hnm ((phaseRat_eq_iff_labels ha hb).mp hab.symm).1

/-- The sum of actual sector weights equals the geometric phase-set sum. -/
theorem sum_fareySectorMass_eq (N : ℕ) :
    ∑ n ∈ Finset.Icc 1 N, fareySectorMass n N =
      ((∑ x ∈ fareyPhases N, (fareyLeftGap N x + fareyRightGap N x)) / 2 : ℚ) := by
  rw [sum_fareyPhases]
  simp only [fareySectorMass, fareyWeight, Finset.sum_div, Rat.cast_sum]

/-- The selected-mass integration needs only this geometric partition premise. -/
theorem sum_fareySectorMass_eq_one_of_partition {N : ℕ}
    (hpartition : FareyGapPartition N) :
    ∑ n ∈ Finset.Icc 1 N, fareySectorMass n N = 1 := by
  rw [sum_fareySectorMass_eq, hpartition]
  norm_num

/-- Any set of conductors has mass at most one under the exact partition premise. -/
theorem sum_selected_fareySectorMass_le_one {N : ℕ} (s : Finset ℕ)
    (hs : s ⊆ Finset.Icc 1 N) (hpartition : FareyGapPartition N) :
    ∑ n ∈ s, fareySectorMass n N ≤ 1 := by
  rw [← sum_fareySectorMass_eq_one_of_partition hpartition]
  exact Finset.sum_le_sum_of_subset_of_nonneg hs
    (fun n _ _ => fareySectorMass_nonneg n N)

/-- The old small-conductor selection is an actual subset of all cutoff conductors. -/
theorem sum_small_old_fareySectorMass_le_one {N Y : ℕ}
    (hpartition : FareyGapPartition N) :
    ∑ n ∈ Finset.Icc 1 (min Y (N - 1)), fareySectorMass n N ≤ 1 := by
  apply sum_selected_fareySectorMass_le_one _ _ hpartition
  intro n hn
  exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1,
    (Finset.mem_Icc.mp hn).2.trans ((min_le_right _ _).trans (Nat.sub_le _ _))⟩

end BuildingBlocks.CyclotomicBoundary
