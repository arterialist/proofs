import Mathlib.Tactic
import BuildingBlocks.KappaCoefficientPositivity

/-!
# Finite full-slope resummation

This module proves the finite rectangular identities only.  It contains no
prime-packet asymptotic and no interchange of infinite sums or integrals.
-/

namespace BuildingBlocks.FullKappaSlopeFinite

open scoped BigOperators
open BuildingBlocks.KappaCoefficientPositivity

noncomputable section

/-- The negative slope primitive from the note, with `g 0 = 0`. -/
def g (m : ℕ) : ℝ := -tauNat m

lemma g_zero : g 0 = 0 := by simp [g, tauNat, tau]

lemma g_eq_log_ratio (m : ℕ) :
    g m = (m : ℝ) * Real.log ((m : ℝ) / (m + 1)) := by
  by_cases hm : m = 0
  · subst m
    simp [g, tauNat, tau]
  · have hmpos : (0 : ℝ) < m := by exact_mod_cast Nat.pos_of_ne_zero hm
    unfold g tauNat tau
    rw [Real.log_div hmpos.ne' (by positivity : (m : ℝ) + 1 ≠ 0)]
    ring

/-- Exact consecutive slope difference. -/
theorem kappa_eq_g_sub_g_succ (m : ℕ) :
    kappa m = g m - g (m + 1) := by
  rw [kappa_eq_tauNat_succ_sub]
  simp [g]
  ring

/-- Prefix of `g`, including the harmless zero term. -/
def prefixG (n : ℕ) : ℝ := ∑ m ∈ Finset.range n, g m

/-- The note's factorial-log prefix, defined as its finite `g` sum. -/
def H (n : ℕ) : ℝ := ∑ m ∈ Finset.range n, g (m + 1)

lemma H_zero : H 0 = 0 := by simp [H]

/-- Factorial-log form of the finite prefix. -/
theorem H_eq_log_factorial_sub (n : ℕ) :
    H n = Real.log (n.factorial : ℝ) -
      (n : ℝ) * Real.log ((n : ℝ) + 1) := by
  induction n with
  | zero => simp [H]
  | succ n ih =>
      rw [H, Finset.sum_range_succ]
      change (∑ m ∈ Finset.range n, g (m + 1)) + g (n + 1) = _
      rw [← H, ih, g_eq_log_ratio]
      rw [Nat.factorial_succ, Nat.cast_mul]
      norm_num only [Nat.cast_add, Nat.cast_one]
      rw [Real.log_mul (by positivity : (n : ℝ) + 1 ≠ 0)
        (by positivity : (n.factorial : ℝ) ≠ 0)]
      rw [Real.log_div (by positivity : (n : ℝ) + 1 ≠ 0)
        (by positivity : (n : ℝ) + 1 + 1 ≠ 0)]
      push_cast
      ring

theorem H_eq_log_factorial_ratio (n : ℕ) :
    H n = Real.log ((n.factorial : ℝ) / (((n : ℝ) + 1) ^ n)) := by
  rw [H_eq_log_factorial_sub]
  rw [Real.log_div (by positivity : (n.factorial : ℝ) ≠ 0)
    (by positivity : ((n : ℝ) + 1) ^ n ≠ 0), Real.log_pow]

lemma prefixG_succ_eq_H (n : ℕ) : prefixG (n + 1) = H n := by
  unfold prefixG H
  rw [show n + 1 = 1 + n by omega, Finset.sum_range_add]
  simp only [Finset.sum_range_one, g_zero, zero_add]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Nat.add_comm]

/-- Finite rectangular full-slope kernel.  This definition gives the clean
zero conventions `K 0 B = K A 0 = 0`. -/
def K (A B : ℕ) : ℝ :=
  ∑ a ∈ Finset.range A, ∑ b ∈ Finset.range B, kappa (a + b)

@[simp] lemma K_zero_left (B : ℕ) : K 0 B = 0 := by simp [K]
@[simp] lemma K_zero_right (A : ℕ) : K A 0 = 0 := by simp [K]

lemma K_comm (A B : ℕ) : K A B = K B A := by
  unfold K
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro b hb
  apply Finset.sum_congr rfl
  intro a ha
  rw [Nat.add_comm]

lemma row_sum_kappa (a B : ℕ) :
    (∑ b ∈ Finset.range B, kappa (a + b)) = g a - g (a + B) := by
  simp_rw [kappa_eq_g_sub_g_succ]
  have h := Finset.sum_range_sub' (fun b => g (a + b)) B
  simpa [Nat.add_assoc] using h

/-- Rectangular resummation in the prefix with the clean all-natural endpoint
convention. -/
theorem K_eq_prefix (A B : ℕ) :
    K A B = prefixG A + prefixG B - prefixG (A + B) := by
  unfold K
  simp_rw [row_sum_kappa]
  rw [Finset.sum_sub_distrib]
  unfold prefixG
  have hBA := Finset.sum_range_add g B A
  rw [Nat.add_comm B A] at hBA
  have hshift : (∑ a ∈ Finset.range A, g (a + B)) =
      (∑ a ∈ Finset.range A, g (B + a)) := by
    apply Finset.sum_congr rfl
    intro a ha
    rw [Nat.add_comm]
  rw [hshift]
  linarith

/-- The exact boundary formula from the note. -/
theorem K_eq_H_min_max {A B : ℕ} (hA : 1 ≤ A) (hB : 1 ≤ B) :
    K A B = H (Nat.min A B - 1) + H (Nat.max A B - 1) -
      H (A + B - 1) := by
  rw [K_eq_prefix]
  have hPA : prefixG A = H (A - 1) := by
    simpa [Nat.sub_add_cancel hA] using prefixG_succ_eq_H (A - 1)
  have hPB : prefixG B = H (B - 1) := by
    simpa [Nat.sub_add_cancel hB] using prefixG_succ_eq_H (B - 1)
  have hPAB : prefixG (A + B) = H (A + B - 1) := by
    have hAB : 1 ≤ A + B := by omega
    simpa [Nat.sub_add_cancel hAB] using prefixG_succ_eq_H (A + B - 1)
  rw [hPA, hPB, hPAB]
  rcases le_total A B with h | h
  · simp [Nat.min_eq_left h, Nat.max_eq_right h]
  · simp [Nat.min_eq_right h, Nat.max_eq_left h]
    ring

/-- Every nonempty rectangle has strictly positive full-slope mass. -/
theorem K_pos {A B : ℕ} (hA : 0 < A) (hB : 0 < B) : 0 < K A B := by
  unfold K
  apply Finset.sum_pos
  · intro a ha
    apply Finset.sum_pos
    · intro b hb
      exact kappa_pos (a + b)
    · exact Finset.nonempty_range_iff.mpr (ne_of_gt hB)
  · exact Finset.nonempty_range_iff.mpr (ne_of_gt hA)

/-- Strict growth when a nonempty row is appended. -/
theorem K_strictMono_left {A B : ℕ} (hB : 0 < B) : K A B < K (A + 1) B := by
  unfold K
  rw [Finset.sum_range_succ]
  have hrow : 0 < ∑ b ∈ Finset.range B, kappa (A + b) := by
    apply Finset.sum_pos
    · intro b hb
      exact kappa_pos (A + b)
    · exact Finset.nonempty_range_iff.mpr (ne_of_gt hB)
  linarith

/-- Strict growth when a nonempty column is appended. -/
theorem K_strictMono_right {A B : ℕ} (hA : 0 < A) : K A B < K A (B + 1) := by
  rw [K_comm A B, K_comm A (B + 1)]
  exact K_strictMono_left hA

/-- Weak coordinatewise monotonicity, including empty rectangles. -/
theorem K_mono {A A' B B' : ℕ} (hAA : A ≤ A') (hBB : B ≤ B') :
    K A B ≤ K A' B' := by
  have hleft : K A B ≤ K A' B := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hAA
    clear hAA
    induction k with
    | zero => simp
    | succ k ih =>
        rw [Nat.add_succ]
        by_cases hB0 : B = 0
        · subst B
          simp
        · exact ih.trans (K_strictMono_left (Nat.pos_of_ne_zero hB0)).le
  have hright : K A' B ≤ K A' B' := by
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hBB
    clear hBB
    induction k with
    | zero => simp
    | succ k ih =>
        rw [Nat.add_succ]
        by_cases hA0 : A' = 0
        · subst A'
          simp
        · exact ih.trans (K_strictMono_right (Nat.pos_of_ne_zero hA0)).le
  exact hleft.trans hright

/-- A finite prefix-resummation statement for any cutoff rectangle. -/
theorem finite_prefix_resummation (A B : ℕ) :
    (∑ a ∈ Finset.range A, ∑ b ∈ Finset.range B, kappa (a + b)) =
      prefixG A + prefixG B - prefixG (A + B) :=
  K_eq_prefix A B

end
end BuildingBlocks.FullKappaSlopeFinite

#print axioms BuildingBlocks.FullKappaSlopeFinite.kappa_eq_g_sub_g_succ
#print axioms BuildingBlocks.FullKappaSlopeFinite.K_eq_prefix
#print axioms BuildingBlocks.FullKappaSlopeFinite.K_eq_H_min_max
#print axioms BuildingBlocks.FullKappaSlopeFinite.K_pos
#print axioms BuildingBlocks.FullKappaSlopeFinite.K_strictMono_left
#print axioms BuildingBlocks.FullKappaSlopeFinite.K_mono
