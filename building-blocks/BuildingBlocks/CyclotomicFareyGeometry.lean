import BuildingBlocks.CyclotomicFareyMass

open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary

/-- Reduced phases from different conductor-label pairs cannot coincide. -/
theorem phaseRat_eq_iff {n m a b : ℕ} (ha : a ∈ phaseLabels n)
    (hb : b ∈ phaseLabels m) : phaseRat n a = phaseRat m b ↔ n = m ∧ a = b := by
  constructor
  · intro h
    have han := (mem_phaseLabels.mp ha).1
    have hbm := (mem_phaseLabels.mp hb).1
    have hn : 0 < n := by omega
    have hm : 0 < m := by omega
    have hnq : (n : ℚ) ≠ 0 := by positivity
    have hmq : (m : ℚ) ≠ 0 := by positivity
    have heq : a * m = b * n := by
      have heqq := (div_eq_div_iff hnq hmq).mp h
      exact_mod_cast heqq
    have hnm : n ∣ m := (mem_phaseLabels.mp ha).2.symm.dvd_of_dvd_mul_left
      (heq.symm ▸ Nat.dvd_mul_left n b)
    have hmn : m ∣ n := (mem_phaseLabels.mp hb).2.symm.dvd_of_dvd_mul_left
      (heq ▸ Nat.dvd_mul_left m a)
    have hsame : n = m := Nat.dvd_antisymm hnm hmn
    subst m
    exact ⟨rfl, Nat.eq_of_mul_eq_mul_right hn heq⟩
  · rintro ⟨rfl, rfl⟩
    rfl

theorem fareyRightGap_attained {N : ℕ} (hN : 1 ≤ N) (x : ℚ) :
    ∃ y ∈ fareyPhases N, fareyRightGap N x = cyclicForwardGap x y := by
  have hn := fareyPhases_nonempty hN
  simpa only [fareyRightGap, dif_pos hn] using
    Finset.exists_mem_eq_inf' hn (cyclicForwardGap x)

theorem fareyLeftGap_attained {N : ℕ} (hN : 1 ≤ N) (x : ℚ) :
    ∃ y ∈ fareyPhases N, fareyLeftGap N x = cyclicForwardGap y x := by
  have hn := fareyPhases_nonempty hN
  simpa only [fareyLeftGap, dif_pos hn] using
    Finset.exists_mem_eq_inf' hn (fun y => cyclicForwardGap y x)

theorem fareyRightGap_le {N : ℕ} {x y : ℚ} (hy : y ∈ fareyPhases N) :
    fareyRightGap N x ≤ cyclicForwardGap x y := by
  have hn : (fareyPhases N).Nonempty := ⟨y, hy⟩
  simpa only [fareyRightGap, dif_pos hn] using Finset.inf'_le (cyclicForwardGap x) hy

theorem fareyLeftGap_le {N : ℕ} {x y : ℚ} (hy : y ∈ fareyPhases N) :
    fareyLeftGap N x ≤ cyclicForwardGap y x := by
  have hn : (fareyPhases N).Nonempty := ⟨y, hy⟩
  simpa only [fareyLeftGap, dif_pos hn] using
    Finset.inf'_le (fun y => cyclicForwardGap y x) hy

theorem fareyWeight_pos {N n a : ℕ} (hN : 1 ≤ N) (ha : a ∈ phaseLabels n) :
    0 < fareyWeight N n a := by
  have hx := And.intro (phaseRat_nonneg n a) (phaseRat_lt_one ha)
  obtain ⟨l, hl, heql⟩ := fareyLeftGap_attained hN (phaseRat n a)
  obtain ⟨r, hr, heqr⟩ := fareyRightGap_attained hN (phaseRat n a)
  have hleft := cyclicForwardGap_pos (fareyPhase_bounds hl) hx
  have hright := cyclicForwardGap_pos hx (fareyPhase_bounds hr)
  unfold fareyWeight
  rw [heql, heqr]
  exact_mod_cast (div_pos (add_pos hleft hright) (by norm_num : (0 : ℚ) < 2))


/-- The sectors partition the actual rational phase set without multiplicity. -/
theorem fareySectorMass_sum_eq_phase_sum (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, fareySectorMass n N) =
      ∑ x ∈ fareyPhases N,
        (((fareyLeftGap N x + fareyRightGap N x) / 2 : ℚ) : ℝ) := by
  symm
  unfold fareyPhases
  rw [Finset.sum_biUnion]
  · apply Finset.sum_congr rfl
    intro n hn
    rw [Finset.sum_image]
    · rfl
    · intro a ha b hb hab
      exact ((phaseRat_eq_iff ha hb).mp hab).2
  · intro n hn m hm hnm
    apply Finset.disjoint_left.mpr
    intro x hxn hxm
    obtain ⟨a, ha, hax⟩ := Finset.mem_image.mp hxn
    obtain ⟨b, hb, hbx⟩ := Finset.mem_image.mp hxm
    exact hnm ((phaseRat_eq_iff ha hb).mp (hax.trans hbx.symm)).1

/-- The remaining partition statement involves only finite cyclic gaps; the
arithmetic partition into reduced conductors has already been proved. -/
def FareyCyclicGapPartition : Prop :=
  ∀ N : ℕ, 1 ≤ N →
    (∑ x ∈ fareyPhases N,
      (((fareyLeftGap N x + fareyRightGap N x) / 2 : ℚ) : ℝ)) = 1

theorem fareyTotalMassIdentity_of_cyclicGapPartition (h : FareyCyclicGapPartition) :
    FareyTotalMassIdentity := by
  intro N hN
  rw [fareySectorMass_sum_eq_phase_sum]
  exact h N hN

end BuildingBlocks.CyclotomicBoundary
