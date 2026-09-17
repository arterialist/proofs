import BuildingBlocks.CyclotomicInteraction
import BuildingBlocks.CyclotomicFareyPartition
import BuildingBlocks.CyclotomicFareyBounds

open Finset
open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary
noncomputable section

private theorem harmonic_nonneg_real (X : ℕ) : (0 : ℝ) ≤ harmonic X := by
  simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  exact Finset.sum_nonneg (fun _ _ => by positivity)

private theorem sum_cutoff_three (X : ℕ) (f : ℕ → ℝ) :
    (∑ N ∈ Icc 1 X, if 3 ≤ N then f N else 0) = ∑ N ∈ Icc 3 X, f N := by
  rw [← Finset.sum_filter]
  congr 1
  ext N
  simp only [Finset.mem_filter, Finset.mem_Icc]
  omega

/-- Integration into the actual full derivative cost, with the remaining geometric
mass estimates displayed explicitly. The final wrapper supplies them from Farey lemmas. -/
theorem smallBoundaryCost_le_of_masses {X Y : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N)
    (hlate : ∀ N ∈ Icc 3 X, 2 * Y < N →
      selectedMass N (smallConductors N Y) ≤ 2 * (Y : ℝ) / N) :
    smallBoundaryCost X Y ≤
      2 * (Y : ℝ) * Real.log X * (harmonic X : ℝ) * (1 + (harmonic X : ℝ)) := by
  let mass := fun N => if 3 ≤ N then selectedMass N (smallConductors N Y) else 0
  let cost := fun N => if 3 ≤ N then selectedAbsolute N (smallConductors N Y) else 0
  have hz : ∀ N ∈ Icc 1 X, 0 ≤ mass N := by
    intro N hN
    dsimp [mass]
    split_ifs
    · exact selectedMass_nonneg _ _
    · exact le_rfl
  have hc : ∀ N ∈ Icc 1 X, cost N ≤ (N.divisors.card : ℝ) * Real.log N * mass N := by
    intro N hN
    by_cases h3 : 3 ≤ N
    · dsimp [cost, mass]
      rw [if_pos h3, if_pos h3]
      exact selectedAbsolute_le hi (Finset.mem_Icc.mpr ⟨h3, (Finset.mem_Icc.mp hN).2⟩)
        _ (Finset.filter_subset _ _)
    · simp [cost, mass, h3]
  have he : ∀ N ∈ Icc 1 X, N ≤ 2 * Y → mass N ≤ 1 := by
    intro N hN hNY
    by_cases h3 : 3 ≤ N
    · dsimp [mass]
      rw [if_pos h3]
      apply sum_selected_fareySectorMass_le_one _ _
        (hpartition N (Finset.mem_Icc.mpr ⟨h3, (Finset.mem_Icc.mp hN).2⟩))
      intro n hn
      have hn' := (Finset.mem_filter.mp hn).1
      exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn').1,
        (Finset.mem_Icc.mp hn').2.trans (Nat.sub_le _ _)⟩
    · simp [mass, h3]
  have hl : ∀ N ∈ Icc 1 X, 2 * Y < N → mass N ≤ 2 * (Y : ℝ) / N := by
    intro N hN hNY
    by_cases h3 : 3 ≤ N
    · simpa only [mass, if_pos h3] using
        hlate N (Finset.mem_Icc.mpr ⟨h3, (Finset.mem_Icc.mp hN).2⟩) hNY
    · simp only [mass, if_neg h3]
      positivity
  have h := small_mass_log_cost_bound hX mass cost hz hc he hl
  simpa only [cost, sum_cutoff_three, smallBoundaryCost] using h

theorem recentBoundaryCost_le_of_masses {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X)
    (hmass : ∀ N ∈ Icc 3 X, selectedMass N (recentConductors N) ≤
      2 * (harmonic N : ℝ) / Real.sqrt N) :
    recentBoundaryCost X ≤ 4 * Real.sqrt X * (harmonic X : ℝ) ^ 2 * Real.log X := by
  let mass := fun N => if 3 ≤ N then selectedMass N (recentConductors N) else 0
  let cost := fun N => if 3 ≤ N then selectedAbsolute N (recentConductors N) else 0
  have hz : ∀ N ∈ Icc 1 X, 0 ≤ mass N := by
    intro N hN
    dsimp [mass]
    split_ifs
    · exact selectedMass_nonneg _ _
    · exact le_rfl
  have hc : ∀ N ∈ Icc 1 X, cost N ≤ (N.divisors.card : ℝ) * Real.log N * mass N := by
    intro N hN
    by_cases h3 : 3 ≤ N
    · dsimp [cost, mass]
      rw [if_pos h3, if_pos h3]
      exact selectedAbsolute_le hi (Finset.mem_Icc.mpr ⟨h3, (Finset.mem_Icc.mp hN).2⟩)
        _ (Finset.filter_subset _ _)
    · simp [cost, mass, h3]
  have hm : ∀ N ∈ Icc 1 X, mass N ≤ 2 * (harmonic N : ℝ) / Real.sqrt N := by
    intro N hN
    by_cases h3 : 3 ≤ N
    · simpa only [mass, if_pos h3] using
        hmass N (Finset.mem_Icc.mpr ⟨h3, (Finset.mem_Icc.mp hN).2⟩)
    · simp only [mass, if_neg h3]
      have hh := harmonic_nonneg_real N
      positivity
  have h := recent_mass_log_cost_bound hX mass cost hz hc hm
  simpa only [cost, sum_cutoff_three, recentBoundaryCost] using h

/-- Explicit real error at the two arithmetic boundaries. -/
def boundaryError (X : ℕ) : ℝ :=
  2 * Real.sqrt X * Real.log X * (harmonic X : ℝ) * (1 + 3 * (harmonic X : ℝ))

theorem boundaryCosts_le_of_masses {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N)
    (hlate : ∀ N ∈ Icc 3 X, 2 * Nat.sqrt X < N →
      selectedMass N (smallConductors N (Nat.sqrt X)) ≤ 2 * (Nat.sqrt X : ℝ) / N)
    (hrecent : ∀ N ∈ Icc 3 X, selectedMass N (recentConductors N) ≤
      2 * (harmonic N : ℝ) / Real.sqrt N) :
    smallBoundaryCost X (Nat.sqrt X) + recentBoundaryCost X ≤ boundaryError X := by
  have hs := smallBoundaryCost_le_of_masses hX hi hpartition hlate
  have hr := recentBoundaryCost_le_of_masses hX hi hrecent
  have hsqrt : (Nat.sqrt X : ℝ) ≤ Real.sqrt X := by
    apply Real.le_sqrt_of_sq_le
    exact_mod_cast Nat.sqrt_le' X
  have hh := harmonic_nonneg_real X
  have hl : 0 ≤ Real.log X := Real.log_nonneg (by exact_mod_cast hX)
  calc
    _ ≤ 2 * (Nat.sqrt X : ℝ) * Real.log X * (harmonic X : ℝ) * (1 + (harmonic X : ℝ)) +
        4 * Real.sqrt X * (harmonic X : ℝ) ^ 2 * Real.log X := add_le_add hs hr
    _ ≤ 2 * Real.sqrt X * Real.log X * (harmonic X : ℝ) * (1 + (harmonic X : ℝ)) +
        4 * Real.sqrt X * (harmonic X : ℝ) ^ 2 * Real.log X := by
      gcongr
    _ = boundaryError X := by unfold boundaryError; ring

/-- Actual two-boundary reduction. All three unfinished dependencies appear as
ordinary parameters: radial regularization, Farey neighbors, and cyclic partition. -/
theorem boundaryCosts_le {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X) (hneighbor : FareyNeighborEnumeration)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N) :
    smallBoundaryCost X (Nat.sqrt X) + recentBoundaryCost X ≤ boundaryError X := by
  have hm := fareySectorMassIdentity_of_neighborEnumeration hneighbor
  apply boundaryCosts_le_of_masses hX hi hpartition
  · intro N hN hY
    simpa only [selectedMass, smallConductors, oldConductors] using
      fareySmallSelectedMass_le_two_mul_div hm (Finset.mem_Icc.mp hN).1 hY
  · intro N hN
    simpa only [selectedMass, recentConductors, oldConductors] using
      fareyRecentSelectedMass_le_two_harmonic_div_sqrt hm (Finset.mem_Icc.mp hN).1

theorem twoBoundary_abs_le {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X) (hneighbor : FareyNeighborEnumeration)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N) :
    |controlledInteraction X (Nat.sqrt X)| ≤ boundaryError X :=
  (controlledInteraction_abs_le _ _).trans (boundaryCosts_le hX hi hneighbor hpartition)

/-- The signed interior is kept unchanged and is not bounded by this theorem. -/
theorem oldInteraction_le_interior_add_boundaryError {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X) (hneighbor : FareyNeighborEnumeration)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N) :
    oldInteraction X ≤ interiorInteraction X (Nat.sqrt X) + boundaryError X := by
  rw [oldInteraction_partition X (Nat.sqrt X)]
  have h := (le_abs_self (controlledInteraction X (Nat.sqrt X))).trans
    (twoBoundary_abs_le hX hi hneighbor hpartition)
  linarith

/-- Actual current-weight clipped full-derivative deficit. -/
def weightedDeficit (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, ∑ a ∈ phaseLabels n, fareyWeight N n a * rootDeficit N (phaseRoot n a)

def birthBudget (X : ℕ) : ℝ := (1 / 2 : ℝ) * Real.log X * (1 + Real.log X) ^ 3

/-- The independently reviewed angular consumer, still an explicit Lean premise. -/
def AngularConsumerInequality (X : ℕ) : Prop :=
  weightedDeficit X ≤ oldInteraction X + birthBudget X

/-- Exact handoff to the angular consumer. No estimate of the remaining signed
interior, no RH assertion, and no extra weight-change term are introduced. -/
theorem weightedDeficit_le_interior_of_angularConsumer {X : ℕ} (hX : 1 ≤ X)
    (hi : ActualOldFactorIdentities X) (hneighbor : FareyNeighborEnumeration)
    (hpartition : ∀ N ∈ Icc 3 X, FareyGapPartition N)
    (hconsumer : AngularConsumerInequality X) :
    weightedDeficit X ≤ interiorInteraction X (Nat.sqrt X) + boundaryError X + birthBudget X :=
  hconsumer.trans (add_le_add_right
    (oldInteraction_le_interior_add_boundaryError hX hi hneighbor hpartition) _)

end
end BuildingBlocks.CyclotomicBoundary
