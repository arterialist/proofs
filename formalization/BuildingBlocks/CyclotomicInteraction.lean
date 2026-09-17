import BuildingBlocks.CyclotomicPrefix
import BuildingBlocks.CyclotomicFareyBasic
import BuildingBlocks.CyclotomicBoundarySums

/-! Actual current-cutoff Farey weights times full derivative-deficit updates. -/
open Finset
open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary
noncomputable section

/-- Only old conductors occur, so the born factor is excluded. -/
def oldConductors (N : ℕ) : Finset ℕ := Icc 1 (N - 1)
def smallConductors (N Y : ℕ) : Finset ℕ :=
  (oldConductors N).filter (fun n => n ≤ Y)
def recentConductors (N : ℕ) : Finset ℕ :=
  (oldConductors N).filter (fun n => N - n ≤ Nat.sqrt N)
def controlledRecentConductors (N Y : ℕ) : Finset ℕ :=
  (recentConductors N).filter (fun n => Y < n)
def interiorConductors (N Y : ℕ) : Finset ℕ :=
  (oldConductors N).filter (fun n => Y < n ∧ Nat.sqrt N < N - n)

/-- Both weights are at cutoff N; there is no weight-change correction in this term. -/
def sectorSigned (N n : ℕ) : ℝ :=
  ∑ a ∈ phaseLabels n, fareyWeight N n a * oldRootUpdate N (phaseRoot n a)
def sectorAbsolute (N n : ℕ) : ℝ :=
  ∑ a ∈ phaseLabels n, fareyWeight N n a * |oldRootUpdate N (phaseRoot n a)|

def selectedMass (N : ℕ) (s : Finset ℕ) : ℝ := ∑ n ∈ s, fareySectorMass n N
def selectedAbsolute (N : ℕ) (s : Finset ℕ) : ℝ := ∑ n ∈ s, sectorAbsolute N n
def selectedSigned (N : ℕ) (s : Finset ℕ) : ℝ := ∑ n ∈ s, sectorSigned N n

/-- Exact radial identity required only at actual old phase labels in this prefix. -/
def ActualOldFactorIdentities (X : ℕ) : Prop :=
  ∀ N ∈ Icc 3 X, ∀ n ∈ oldConductors N, ∀ a ∈ phaseLabels n,
    OldFactorRegularizedIdentity (phaseRoot n a) n N

theorem selectedMass_nonneg (N : ℕ) (s : Finset ℕ) : 0 ≤ selectedMass N s :=
  Finset.sum_nonneg (fun _ _ => fareySectorMass_nonneg _ _)
theorem sectorAbsolute_nonneg (N n : ℕ) : 0 ≤ sectorAbsolute N n :=
  Finset.sum_nonneg (fun _ ha => mul_nonneg (fareyWeight_nonneg ha) (abs_nonneg _))
theorem selectedAbsolute_nonneg (N : ℕ) (s : Finset ℕ) :
    0 ≤ selectedAbsolute N s :=
  Finset.sum_nonneg (fun _ _ => sectorAbsolute_nonneg _ _)

theorem abs_sectorSigned_le (N n : ℕ) : |sectorSigned N n| ≤ sectorAbsolute N n := by
  calc
    _ ≤ ∑ a ∈ phaseLabels n, |fareyWeight N n a * oldRootUpdate N (phaseRoot n a)| :=
      Finset.abs_sum_le_sum_abs _ _
    _ = _ := by
      apply Finset.sum_congr rfl
      intro a ha
      rw [abs_mul, abs_of_nonneg (fareyWeight_nonneg ha)]

theorem abs_selectedSigned_le (N : ℕ) (s : Finset ℕ) :
    |selectedSigned N s| ≤ selectedAbsolute N s :=
  (Finset.abs_sum_le_sum_abs _ _).trans
    (Finset.sum_le_sum (fun _ _ => abs_sectorSigned_le _ _))

theorem selectedAbsolute_mono {N : ℕ} {s t : Finset ℕ} (h : s ⊆ t) :
    selectedAbsolute N s ≤ selectedAbsolute N t :=
  Finset.sum_le_sum_of_subset_of_nonneg h (fun _ _ _ => sectorAbsolute_nonneg _ _)

theorem selectedAbsolute_le {X N : ℕ} (hidentity : ActualOldFactorIdentities X)
    (hN : N ∈ Icc 3 X) (s : Finset ℕ) (hs : s ⊆ oldConductors N) :
    selectedAbsolute N s ≤ (N.divisors.card : ℝ) * Real.log N * selectedMass N s := by
  unfold selectedAbsolute selectedMass
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro n hn
  have hno := hs hn
  have hn1 := (Finset.mem_Icc.mp hno).1
  have hnN : n < N := by have := (Finset.mem_Icc.mp hno).2; omega
  unfold sectorAbsolute fareySectorMass
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro a ha
  have hp := phaseRoot_isPrimitive hn1 (mem_phaseLabels.mp ha).2
  have hb := oldRootUpdate_abs_le hn1 hnN hp (hidentity N hN n hno a ha)
  simpa only [mul_comm] using mul_le_mul_of_nonneg_left hb (fareyWeight_nonneg ha)

theorem oldConductors_partition (N Y : ℕ) :
    oldConductors N = smallConductors N Y ∪
      controlledRecentConductors N Y ∪ interiorConductors N Y := by
  ext n
  by_cases ho : n ∈ oldConductors N <;>
    simp [smallConductors, controlledRecentConductors, recentConductors,
      interiorConductors, Finset.mem_union, Finset.mem_filter, ho]
  omega

theorem selectedSigned_partition (N Y : ℕ) :
    selectedSigned N (oldConductors N) = selectedSigned N (smallConductors N Y) +
      selectedSigned N (controlledRecentConductors N Y) +
      selectedSigned N (interiorConductors N Y) := by
  have h1 : Disjoint (smallConductors N Y) (controlledRecentConductors N Y) := by
    simp only [Finset.disjoint_left, smallConductors, controlledRecentConductors,
      recentConductors, Finset.mem_filter]
    omega
  have h2 : Disjoint (smallConductors N Y ∪ controlledRecentConductors N Y)
      (interiorConductors N Y) := by
    simp only [Finset.disjoint_left, smallConductors, controlledRecentConductors,
      recentConductors, interiorConductors, Finset.mem_union, Finset.mem_filter]
    omega
  unfold selectedSigned
  rw [oldConductors_partition N Y, Finset.sum_union h2, Finset.sum_union h1]

/-- Exact signed old interaction, summed from cutoff 3. -/
def oldInteraction (X : ℕ) : ℝ :=
  ∑ N ∈ Icc 3 X, selectedSigned N (oldConductors N)
def interiorInteraction (X Y : ℕ) : ℝ :=
  ∑ N ∈ Icc 3 X, selectedSigned N (interiorConductors N Y)
def controlledInteraction (X Y : ℕ) : ℝ :=
  ∑ N ∈ Icc 3 X, (selectedSigned N (smallConductors N Y) +
    selectedSigned N (controlledRecentConductors N Y))
def smallBoundaryCost (X Y : ℕ) : ℝ :=
  ∑ N ∈ Icc 3 X, selectedAbsolute N (smallConductors N Y)
def recentBoundaryCost (X : ℕ) : ℝ :=
  ∑ N ∈ Icc 3 X, selectedAbsolute N (recentConductors N)

theorem oldInteraction_partition (X Y : ℕ) :
    oldInteraction X = controlledInteraction X Y + interiorInteraction X Y := by
  unfold oldInteraction controlledInteraction interiorInteraction
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl (fun N _ => selectedSigned_partition N Y)

theorem controlledInteraction_abs_le (X Y : ℕ) :
    |controlledInteraction X Y| ≤ smallBoundaryCost X Y + recentBoundaryCost X := by
  unfold controlledInteraction smallBoundaryCost recentBoundaryCost
  rw [← Finset.sum_add_distrib]
  apply (Finset.abs_sum_le_sum_abs _ _).trans
  apply Finset.sum_le_sum
  intro N hN
  exact (abs_add_le _ _).trans (add_le_add (abs_selectedSigned_le _ _)
    ((abs_selectedSigned_le _ _).trans
      (selectedAbsolute_mono (Finset.filter_subset _ _))))

theorem nat_sqrt_lt_iff_real (X n : ℕ) :
    Nat.sqrt X < n ↔ Real.sqrt (X : ℝ) < (n : ℝ) := by
  rw [Nat.sqrt_lt', Real.sqrt_lt (Nat.cast_nonneg _) (Nat.cast_nonneg _)]
  norm_cast

/-- The exact integer filter is the strict real interior from the reduction. -/
theorem mem_interiorConductors_iff {N X n : ℕ} (hn : 1 ≤ n) (hOld : n < N) :
    n ∈ interiorConductors N (Nat.sqrt X) ↔
      Real.sqrt X < (n : ℝ) ∧ (n : ℝ) < (N : ℝ) - Real.sqrt N := by
  have hno : n ∈ oldConductors N := Finset.mem_Icc.mpr ⟨hn, by omega⟩
  simp only [interiorConductors, Finset.mem_filter, hno, true_and]
  rw [nat_sqrt_lt_iff_real, nat_sqrt_lt_iff_real, Nat.cast_sub hOld.le]
  constructor <;> intro h <;> constructor <;> linarith [h.1, h.2]

end
end BuildingBlocks.CyclotomicBoundary
