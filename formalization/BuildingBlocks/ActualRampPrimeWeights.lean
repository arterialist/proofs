import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic

open scoped BigOperators

/-!
Finite arithmetic weights in the oriented correlation of damped causal ramps.
The actual von Mangoldt function is used, so prime powers and the internal
transition endpoint are included exactly. This module does not identify the
complete Weil form or prove its analytic positivity.
-/

namespace BuildingBlocks.ActualRampPrimeWeights

/-- The oriented correlation weight for causal ramps of lengths `A` and `B`
at logarithmic prime-power shift `u`. -/
noncomputable def orientedWeight (A B u : ℝ) : ℝ :=
  1 - Real.exp (-(min B (max 0 (A - u))))

theorem orientedWeight_mono {A A' B B' u : ℝ}
    (hA : A ≤ A') (hB : B ≤ B') :
    orientedWeight A B u ≤ orientedWeight A' B' u := by
  unfold orientedWeight
  have hmax : max (0 : ℝ) (A - u) ≤ max 0 (A' - u) :=
    max_le_max le_rfl (sub_le_sub_right hA u)
  have hmin : min B (max (0 : ℝ) (A - u)) ≤
      min B' (max (0 : ℝ) (A' - u)) := min_le_min hB hmax
  have hexp : Real.exp (-(min B' (max (0 : ℝ) (A' - u)))) ≤
      Real.exp (-(min B (max (0 : ℝ) (A - u)))) :=
    (Real.exp_le_exp).2 (neg_le_neg hmin)
  linarith

theorem orientedWeight_nonneg {A B u : ℝ} (hB : 0 ≤ B) :
    0 ≤ orientedWeight A B u := by
  have hmax : 0 ≤ max (0 : ℝ) (A - u) := le_max_left _ _
  have hmin : 0 ≤ min B (max (0 : ℝ) (A - u)) := le_min hB hmax
  have hexp : Real.exp (-(min B (max (0 : ℝ) (A - u)))) ≤ 1 :=
    (Real.exp_le_one_iff).2 (neg_nonpos.mpr hmin)
  unfold orientedWeight
  linarith

theorem orientedWeight_outer_zero {A B u : ℝ}
    (hB : 0 ≤ B) (hAu : A ≤ u) :
    orientedWeight A B u = 0 := by
  have hmax : max (0 : ℝ) (A - u) = 0 := max_eq_left (sub_nonpos.mpr hAu)
  have hmin : min B (0 : ℝ) = 0 := min_eq_right hB
  simp [orientedWeight, hmax, hmin]

theorem orientedWeight_internal_transition {A B : ℝ} (hB : 0 ≤ B) :
    orientedWeight A B (A - B) = 1 - Real.exp (-B) := by
  have hsub : A - (A - B) = B := by ring
  have hmax : max (0 : ℝ) B = B := max_eq_right hB
  simp [orientedWeight, hsub, hmax]

theorem orientedWeight_internal_transition_pos {A B : ℝ} (hB : 0 < B) :
    0 < orientedWeight A B (A - B) := by
  rw [orientedWeight_internal_transition hB.le]
  have hexp : Real.exp (-B) < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  linarith

theorem orientedWeight_plateau {A B u : ℝ}
    (hB : 0 ≤ B) (hu : u ≤ A - B) :
    orientedWeight A B u = 1 - Real.exp (-B) := by
  have hBu : B ≤ A - u := by linarith
  have hAu : 0 ≤ A - u := le_trans hB hBu
  have hmax : max (0 : ℝ) (A - u) = A - u := max_eq_right hAu
  have hmin : min B (A - u) = B := min_eq_left hBu
  simp [orientedWeight, hmax, hmin]

theorem orientedWeight_slope {A B u : ℝ}
    (huA : u ≤ A) (hAB : A - u ≤ B) :
    orientedWeight A B u = 1 - Real.exp (u - A) := by
  have hmax : max (0 : ℝ) (A - u) = A - u :=
    max_eq_right (sub_nonneg.mpr huA)
  have hmin : min B (A - u) = A - u := min_eq_right hAB
  rw [orientedWeight, hmax, hmin]
  congr 1
  ring_nf

theorem orientedWeight_slope_prime {A B : ℝ} {n : ℕ}
    (hn : 0 < n) (huA : Real.log (n : ℝ) ≤ A)
    (hAB : A - Real.log (n : ℝ) ≤ B) :
    orientedWeight A B (Real.log (n : ℝ)) =
      1 - (n : ℝ) * Real.exp (-A) := by
  rw [orientedWeight_slope huA hAB]
  have hnR : (0 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  rw [show Real.log (n : ℝ) - A = Real.log (n : ℝ) + (-A) by ring,
    Real.exp_add, Real.exp_log hnR]

/-- Exact finite actual-von-Mangoldt oriented prime-power cross weight. -/
noncomputable def actualPrimeCross (N : ℕ) (A B : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 2 N,
    (ArithmeticFunction.vonMangoldt n / (n : ℝ)) *
      orientedWeight A B (Real.log (n : ℝ))

theorem actualPrimeCross_mono (N : ℕ) {A A' B B' : ℝ}
    (hA : A ≤ A') (hB : B ≤ B') :
    actualPrimeCross N A B ≤ actualPrimeCross N A' B' := by
  unfold actualPrimeCross
  apply Finset.sum_le_sum
  intro n hn
  have hc : 0 ≤ ArithmeticFunction.vonMangoldt n / (n : ℝ) :=
    div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg n)
  exact mul_le_mul_of_nonneg_left (orientedWeight_mono hA hB) hc

theorem actualPrimeCross_nonneg (N : ℕ) {A B : ℝ} (hB : 0 ≤ B) :
    0 ≤ actualPrimeCross N A B := by
  unfold actualPrimeCross
  apply Finset.sum_nonneg
  intro n hn
  exact mul_nonneg
    (div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg n))
    (orientedWeight_nonneg hB)

theorem actualPrimeCross_mono_cutoff {N N' : ℕ} {A B : ℝ}
    (hNN : N ≤ N') (hB : 0 ≤ B) :
    actualPrimeCross N A B ≤ actualPrimeCross N' A B := by
  unfold actualPrimeCross
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro n hn
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1,
      (Finset.mem_Icc.mp hn).2.trans hNN⟩
  · intro n hn hnot
    exact mul_nonneg
      (div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg n))
      (orientedWeight_nonneg hB)

noncomputable def firstPrimeCross (N : ℕ) (L : ℝ) : ℝ :=
  actualPrimeCross N L L

noncomputable def secondPrimeCross (N : ℕ) (L Delta : ℝ) : ℝ :=
  actualPrimeCross N (L + Delta) L

/-- At the internal transition the oriented prime-power weight is retained. -/
theorem secondPrimeWeight_internal_transition {L Delta : ℝ} (hL : 0 ≤ L) :
    orientedWeight (L + Delta) L Delta = 1 - Real.exp (-L) := by
  have hshift : (L + Delta) - L = Delta := by ring
  simpa [hshift] using orientedWeight_internal_transition
    (A := L + Delta) (B := L) hL

theorem secondPrimeWeight_at_prime_transition {L Delta : ℝ} {n : ℕ}
    (hL : 0 ≤ L) (hlog : Real.log (n : ℝ) = Delta) :
    orientedWeight (L + Delta) L (Real.log (n : ℝ)) = 1 - Real.exp (-L) := by
  rw [hlog]
  exact secondPrimeWeight_internal_transition hL

theorem secondPrimeWeight_plateau {L Delta : ℝ} {n : ℕ}
    (hL : 0 ≤ L) (hu : Real.log (n : ℝ) ≤ Delta) :
    orientedWeight (L + Delta) L (Real.log (n : ℝ)) = 1 - Real.exp (-L) := by
  exact orientedWeight_plateau hL (by linarith)

theorem secondPrimeWeight_slope {L Delta : ℝ} {n : ℕ}
    (hn : 0 < n) (hDelta : Delta ≤ Real.log (n : ℝ))
    (houter : Real.log (n : ℝ) ≤ L + Delta) :
    orientedWeight (L + Delta) L (Real.log (n : ℝ)) =
      1 - (n : ℝ) * Real.exp (-(L + Delta)) := by
  exact orientedWeight_slope_prime hn houter (by linarith)

theorem secondPrimeWeight_outer_zero {L Delta : ℝ} {n : ℕ}
    (hL : 0 ≤ L) (houter : L + Delta ≤ Real.log (n : ℝ)) :
    orientedWeight (L + Delta) L (Real.log (n : ℝ)) = 0 :=
  orientedWeight_outer_zero hL houter

/-- In the sloping region the exact prime-power summand has the
`Λ(n)/n - exp(-M) Λ(n)` form used in the written correlation formula. -/
theorem secondPrimeTerm_slope {L Delta : ℝ} {n : ℕ}
    (hn : 0 < n) (hDelta : Delta ≤ Real.log (n : ℝ))
    (houter : Real.log (n : ℝ) ≤ L + Delta) :
    (ArithmeticFunction.vonMangoldt n / (n : ℝ)) *
        orientedWeight (L + Delta) L (Real.log (n : ℝ)) =
      ArithmeticFunction.vonMangoldt n / (n : ℝ) -
        ArithmeticFunction.vonMangoldt n * Real.exp (-(L + Delta)) := by
  rw [secondPrimeWeight_slope hn hDelta houter]
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hn)
  field_simp

theorem firstPrimeCross_mono (N : ℕ) {L L' : ℝ} (hL : L ≤ L') :
    firstPrimeCross N L ≤ firstPrimeCross N L' :=
  actualPrimeCross_mono N hL hL

theorem secondPrimeCross_mono (N : ℕ) {L L' Delta Delta' : ℝ}
    (hL : L ≤ L') (hD : Delta ≤ Delta') :
    secondPrimeCross N L Delta ≤ secondPrimeCross N L' Delta' := by
  exact actualPrimeCross_mono N (add_le_add hL hD) hL

end BuildingBlocks.ActualRampPrimeWeights

#print axioms BuildingBlocks.ActualRampPrimeWeights.secondPrimeWeight_internal_transition
#print axioms BuildingBlocks.ActualRampPrimeWeights.actualPrimeCross_mono
