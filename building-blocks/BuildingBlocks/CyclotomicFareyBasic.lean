import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Data.Rat.Cast.Order
import Mathlib.Data.Real.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

open scoped BigOperators

namespace BuildingBlocks.CyclotomicBoundary

/-- Reduced representatives in `[0,n)`, including the representative `0` for conductor one. -/
def phaseLabels (n : ℕ) : Finset ℕ :=
  (Finset.range n).filter (fun a => Nat.Coprime a n)

/-- A reduced phase is represented in the half-open unit interval. -/
def phaseRat (n a : ℕ) : ℚ := (a : ℚ) / n

/-- The actual finite set of reduced phases at cutoff `N`. -/
def fareyPhases (N : ℕ) : Finset ℚ :=
  (Finset.Icc 1 N).biUnion (fun n => (phaseLabels n).image (phaseRat n))

/-- Positive clockwise displacement. The self displacement is one full turn. -/
def cyclicForwardGap (x y : ℚ) : ℚ := if x < y then y - x else y - x + 1

/-- The clockwise gap to the next actual phase, with wrap at one. -/
def fareyRightGap (N : ℕ) (x : ℚ) : ℚ :=
  if h : (fareyPhases N).Nonempty then
    (fareyPhases N).inf' h (cyclicForwardGap x)
  else 0

/-- The counterclockwise gap to the preceding actual phase, with wrap at zero. -/
def fareyLeftGap (N : ℕ) (x : ℚ) : ℚ :=
  if h : (fareyPhases N).Nonempty then
    (fareyPhases N).inf' h (fun y => cyclicForwardGap y x)
  else 0

/-- Half the sum of the two actual cyclic gaps. No weight formula is assumed. -/
def fareyWeight (N n a : ℕ) : ℝ :=
  ((fareyLeftGap N (phaseRat n a) + fareyRightGap N (phaseRat n a)) / 2 : ℚ)

/-- Total actual half-gap weight of conductor `n`. -/
def fareySectorMass (n N : ℕ) : ℝ :=
  ∑ a ∈ phaseLabels n, fareyWeight N n a

@[simp] theorem mem_phaseLabels {n a : ℕ} :
    a ∈ phaseLabels n ↔ a < n ∧ Nat.Coprime a n := by
  simp [phaseLabels]

@[simp] theorem phaseLabels_one : phaseLabels 1 = {0} := by decide

@[simp] theorem phaseRat_one_zero : phaseRat 1 0 = 0 := by norm_num [phaseRat]

@[simp] theorem mem_fareyPhases {N : ℕ} {x : ℚ} :
    x ∈ fareyPhases N ↔ ∃ n, 1 ≤ n ∧ n ≤ N ∧ ∃ a ∈ phaseLabels n, phaseRat n a = x := by
  simp only [fareyPhases, Finset.mem_biUnion, Finset.mem_Icc, Finset.mem_image]
  aesop

theorem phaseRat_mem_fareyPhases {N n a : ℕ} (hn : 1 ≤ n) (hnN : n ≤ N)
    (ha : a ∈ phaseLabels n) : phaseRat n a ∈ fareyPhases N :=
  mem_fareyPhases.mpr ⟨n, hn, hnN, a, ha, rfl⟩

theorem phaseRat_nonneg (n a : ℕ) : 0 ≤ phaseRat n a := by
  unfold phaseRat
  positivity

theorem phaseRat_lt_one {n a : ℕ} (ha : a ∈ phaseLabels n) : phaseRat n a < 1 := by
  have han := (mem_phaseLabels.mp ha).1
  have hn : (0 : ℚ) < n := by exact_mod_cast (Nat.zero_lt_of_lt han)
  exact (div_lt_one hn).mpr (by exact_mod_cast han)

theorem fareyPhase_bounds {N : ℕ} {x : ℚ} (hx : x ∈ fareyPhases N) :
    0 ≤ x ∧ x < 1 := by
  obtain ⟨n, _, _, a, ha, rfl⟩ := mem_fareyPhases.mp hx
  exact ⟨phaseRat_nonneg _ _, phaseRat_lt_one ha⟩

theorem zero_mem_fareyPhases {N : ℕ} (hN : 1 ≤ N) : 0 ∈ fareyPhases N := by
  exact mem_fareyPhases.mpr ⟨1, le_rfl, hN, 0, by simp, by simp⟩

theorem fareyPhases_nonempty {N : ℕ} (hN : 1 ≤ N) : (fareyPhases N).Nonempty :=
  ⟨0, zero_mem_fareyPhases hN⟩

theorem cyclicForwardGap_pos {x y : ℚ} (hx : 0 ≤ x ∧ x < 1)
    (hy : 0 ≤ y ∧ y < 1) : 0 < cyclicForwardGap x y := by
  unfold cyclicForwardGap
  split_ifs <;> linarith [hx.1, hx.2, hy.1, hy.2]

theorem fareyRightGap_nonneg {N : ℕ} {x : ℚ} (hx : 0 ≤ x ∧ x < 1) :
    0 ≤ fareyRightGap N x := by
  unfold fareyRightGap
  split_ifs with h
  · exact Finset.le_inf' h _ (fun y hy => (cyclicForwardGap_pos hx (fareyPhase_bounds hy)).le)
  · exact le_rfl

theorem fareyLeftGap_nonneg {N : ℕ} {x : ℚ} (hx : 0 ≤ x ∧ x < 1) :
    0 ≤ fareyLeftGap N x := by
  unfold fareyLeftGap
  split_ifs with h
  · exact Finset.le_inf' h _ (fun y hy => (cyclicForwardGap_pos (fareyPhase_bounds hy) hx).le)
  · exact le_rfl

theorem fareyWeight_nonneg {N n a : ℕ} (ha : a ∈ phaseLabels n) :
    0 ≤ fareyWeight N n a := by
  have hx := And.intro (phaseRat_nonneg n a) (phaseRat_lt_one ha)
  have hl := fareyLeftGap_nonneg (N := N) hx
  have hr := fareyRightGap_nonneg (N := N) hx
  unfold fareyWeight
  exact_mod_cast (div_nonneg (add_nonneg hl hr) (by norm_num : (0 : ℚ) ≤ 2))

theorem fareySectorMass_nonneg (n N : ℕ) : 0 ≤ fareySectorMass n N := by
  exact Finset.sum_nonneg (fun a ha => fareyWeight_nonneg ha)

/-- The arithmetic sector formula, stated separately from the actual geometric weights.
This is a proposition to be proved or supplied, not an axiom or a weight definition. -/
def FareySectorMassIdentity : Prop :=
  ∀ n N : ℕ, 1 ≤ n → n ≤ N → 2 ≤ N →
    fareySectorMass n N = (1 / (n : ℝ)) *
      ∑ b ∈ (Finset.Icc (N - n + 1) N).filter (fun b => Nat.Coprime b n),
        (1 / (b : ℝ))

end BuildingBlocks.CyclotomicBoundary
