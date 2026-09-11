import BuildingBlocks.CyclotomicFareyBasic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Ring

open scoped BigOperators
namespace BuildingBlocks.CyclotomicBoundary

private theorem one_div_le_gap_zero {N : ℕ} (hN : 1 ≤ N) {x : ℚ}
    (hx : x ∈ fareyPhases N) : (1 : ℚ) / N ≤ cyclicForwardGap 0 x := by
  obtain ⟨n, hn, hnN, a, ha, rfl⟩ := mem_fareyPhases.mp hx
  have hnq : (0 : ℚ) < n := by exact_mod_cast hn
  have hNq : (0 : ℚ) < N := by exact_mod_cast hN
  have hrec : (1 : ℚ) / N ≤ 1 / n :=
    one_div_le_one_div_of_le hnq (by exact_mod_cast hnN)
  have ha0 := phaseRat_nonneg n a
  by_cases ha' : a = 0
  · subst a
    simp only [phaseRat, Nat.cast_zero, zero_div, cyclicForwardGap, lt_self_iff_false,
      ↓reduceIte, sub_self, zero_add]
    exact (div_le_one hNq).mpr (by exact_mod_cast hN)
  · have haq : (1 : ℚ) ≤ a := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr ha')
    have hap : (0 : ℚ) < a := by linarith
    have hxpos : 0 < phaseRat n a := div_pos hap hnq
    simp only [cyclicForwardGap, hxpos, ↓reduceIte, sub_zero]
    exact hrec.trans ((div_le_div_iff_of_pos_right hnq).mpr haq)

private theorem one_div_le_gap_to_zero {N : ℕ} {x : ℚ}
    (hx : x ∈ fareyPhases N) : (1 : ℚ) / N ≤ cyclicForwardGap x 0 := by
  obtain ⟨n, hn, hnN, a, ha, rfl⟩ := mem_fareyPhases.mp hx
  have hnq : (0 : ℚ) < n := by exact_mod_cast hn
  have hrec : (1 : ℚ) / N ≤ 1 / n :=
    one_div_le_one_div_of_le hnq (by exact_mod_cast hnN)
  have han : (a : ℚ) + 1 ≤ n := by exact_mod_cast (Nat.succ_le_of_lt (mem_phaseLabels.mp ha).1)
  have ha0 := phaseRat_nonneg n a
  simp only [cyclicForwardGap, not_lt.mpr ha0, ↓reduceIte]
  apply hrec.trans
  unfold phaseRat
  apply (div_le_iff₀ hnq).mpr
  have hn0 : (n : ℚ) ≠ 0 := ne_of_gt hnq
  field_simp
  nlinarith

theorem fareyRightGap_zero {N : ℕ} (hN : 2 ≤ N) :
    fareyRightGap N 0 = 1 / (N : ℚ) := by
  have hN1 : 1 ≤ N := by omega
  have hne := fareyPhases_nonempty hN1
  have hlabel : 1 ∈ phaseLabels N := mem_phaseLabels.mpr ⟨by omega, Nat.coprime_one_left N⟩
  have hphase := phaseRat_mem_fareyPhases hN1 (le_refl N) hlabel
  have hpos : 0 < phaseRat N 1 := by unfold phaseRat; positivity
  unfold fareyRightGap
  rw [dif_pos hne]
  apply le_antisymm
  · calc
      _ ≤ cyclicForwardGap 0 (phaseRat N 1) := Finset.inf'_le _ hphase
      _ = 1 / (N : ℚ) := by
        rw [cyclicForwardGap, if_pos hpos]
        simp [phaseRat]
  · exact Finset.le_inf' hne _ (fun x hx => one_div_le_gap_zero hN1 hx)

theorem fareyLeftGap_zero {N : ℕ} (hN : 2 ≤ N) :
    fareyLeftGap N 0 = 1 / (N : ℚ) := by
  have hN1 : 1 ≤ N := by omega
  have hne := fareyPhases_nonempty hN1
  have hlabel : N - 1 ∈ phaseLabels N := mem_phaseLabels.mpr
    ⟨by omega, (Nat.coprime_self_sub_left hN1).mpr (Nat.coprime_one_left N)⟩
  have hphase := phaseRat_mem_fareyPhases hN1 (le_refl N) hlabel
  have ha0 := phaseRat_nonneg N (N - 1)
  have hN0 : (N : ℚ) ≠ 0 := by positivity
  unfold fareyLeftGap
  rw [dif_pos hne]
  apply le_antisymm
  · calc
      _ ≤ cyclicForwardGap (phaseRat N (N - 1)) 0 := Finset.inf'_le _ hphase
      _ = 1 / (N : ℚ) := by
        rw [cyclicForwardGap, if_neg (not_lt.mpr ha0)]
        simp only [phaseRat, Nat.cast_sub hN1, Nat.cast_one]
        field_simp
        ring
  · exact Finset.le_inf' hne _ (fun x hx => one_div_le_gap_to_zero hx)

theorem fareyWeight_one {N : ℕ} (hN : 2 ≤ N) : fareyWeight N 1 0 = 1 / (N : ℝ) := by
  unfold fareyWeight
  rw [phaseRat_one_zero, fareyLeftGap_zero hN, fareyRightGap_zero hN]
  push_cast
  ring

theorem fareySectorMass_one {N : ℕ} (hN : 2 ≤ N) :
    fareySectorMass 1 N = 1 / (N : ℝ) := by
  simpa [fareySectorMass] using fareyWeight_one hN

@[simp] theorem fareyPhases_two : fareyPhases 2 = {0, 1 / 2} := by
  ext x
  simp only [Finset.mem_insert, Finset.mem_singleton]
  constructor
  · intro hx
    obtain ⟨n, hn, hnN, a, ha, rfl⟩ := mem_fareyPhases.mp hx
    have han := (mem_phaseLabels.mp ha).1
    have hn_cases : n = 1 ∨ n = 2 := by omega
    rcases hn_cases with rfl | rfl <;> interval_cases a <;> norm_num [phaseRat]
  · rintro (rfl | rfl)
    · exact zero_mem_fareyPhases (by omega)
    · exact mem_fareyPhases.mpr ⟨2, by omega, le_rfl, 1, by decide, by norm_num [phaseRat]⟩

/-- At cutoff two the same physical phase is both neighbors of `1/2`,
with a separate gap of `1/2` in each direction. -/
theorem fareyGaps_two : fareyLeftGap 2 (1 / 2) = 1 / 2 ∧
    fareyRightGap 2 (1 / 2) = 1 / 2 := by
  norm_num [fareyLeftGap, fareyRightGap, fareyPhases_two, cyclicForwardGap,
    Finset.inf'_insert, Finset.inf'_singleton]

theorem fareyWeight_two : fareyWeight 2 2 1 = 1 / 2 := by
  unfold fareyWeight
  norm_num [phaseRat, fareyGaps_two.1, fareyGaps_two.2]

end BuildingBlocks.CyclotomicBoundary
