import BuildingBlocks.GoldbachCofactorLinearSplitFinite
import Mathlib.Tactic

/-!
# Finite Abel decomposition of the pointwise Goldbach cofactor

The analytic pointwise estimate splits the complete prime error into a chosen
zero packet and a residual. This module checks the finite algebra behind that
step. It retains the residual at `1`, the residual at the terminal prime leg,
and every variation of the complementary error ratio. No estimate on zeros
or on the residual is assumed.
-/

namespace BuildingBlocks.GoldbachCofactorPointwiseAbelFinite

open Finset Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorVolterraFinite
open BuildingBlocks.GoldbachCofactorSuccessorFinite
open BuildingBlocks.GoldbachCofactorLinearSplitFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

/-- The part of the actual prime error not represented by an arbitrary packet. -/
def residual (F : ℕ → ℝ) (m : ℕ) : ℝ := primeError m - F m

/-- A finite difference against a moving weight, with both endpoints. -/
theorem finite_difference_abel (R w : ℕ → ℝ) (k : ℕ) :
    (∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m) =
      R (k + 2) * w (k + 2) - R 1 * w 2 +
        ∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1)) := by
  induction k with
  | zero =>
      simp
      ring
  | succ k ih =>
      rw [Finset.sum_Icc_succ_top (by omega : 2 ≤ (k + 2) + 1)]
      rw [Finset.sum_Ico_succ_top (by omega : 2 ≤ k + 2)]
      rw [ih]
      have hsub : k + 2 + 1 - 1 = k + 2 := by omega
      simp only [hsub]
      ring

/-- A uniform bound on the residual pays only for the two endpoints and
the total variation of the complementary weight. -/
theorem finite_difference_abs_le_variation (R w : ℕ → ℝ) (k : ℕ) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (k + 2), |R m| ≤ M) :
    |∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m| ≤
      M * (|w (k + 2)| + |w 2| +
        ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)|) := by
  rw [finite_difference_abel]
  have hterminal : |R (k + 2) * w (k + 2)| ≤ M * |w (k + 2)| := by
    rw [abs_mul]
    exact mul_le_mul_of_nonneg_right
      (hR (k + 2) (by simp)) (abs_nonneg _)
  have hinitial : |R 1 * w 2| ≤ M * |w 2| := by
    rw [abs_mul]
    exact mul_le_mul_of_nonneg_right
      (hR 1 (by simp)) (abs_nonneg _)
  have hvariation :
      |∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))| ≤
        M * ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)| := by
    calc
      |∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))| ≤
          ∑ m ∈ Ico 2 (k + 2), |R m * (w m - w (m + 1))| :=
            Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ m ∈ Ico 2 (k + 2), M * |w m - w (m + 1)| := by
        apply Finset.sum_le_sum
        intro m hm
        rw [abs_mul]
        have hm' : m ∈ Icc 1 (k + 2) := by
          simp only [mem_Ico] at hm
          simp only [mem_Icc]
          omega
        exact mul_le_mul_of_nonneg_right (hR m hm') (abs_nonneg _)
      _ = M * ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)| := by
        rw [Finset.mul_sum]
  calc
    |R (k + 2) * w (k + 2) - R 1 * w 2 +
        ∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))| ≤
      |R (k + 2) * w (k + 2)| + |R 1 * w 2| +
        |∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))| := by
          have hsub :
              |R (k + 2) * w (k + 2) - R 1 * w 2| ≤
                |R (k + 2) * w (k + 2)| + |R 1 * w 2| := by
            simpa only [sub_eq_add_neg, abs_neg] using
              abs_add_le (R (k + 2) * w (k + 2)) (-(R 1 * w 2))
          linarith [abs_add_le
            (R (k + 2) * w (k + 2) - R 1 * w 2)
            (∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1)))]
    _ ≤ M * |w (k + 2)| + M * |w 2| +
        M * ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)| := by
          linarith
    _ = _ := by ring

/-- The centered pair term can be read in the prime-leg direction. -/
theorem centeredPairRemainder_reverse (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      ∑ m ∈ Icc 2 (s - 2), (Λ m - 1) * ratioError (s - m) := by
  unfold centeredPairRemainder
  apply Finset.sum_bij (fun y _ => s - y)
  · intro y hy
    simp only [mem_Icc] at hy ⊢
    omega
  · intro y hy z hz hyz
    simp only [mem_Icc] at hy hz
    omega
  · intro m hm
    simp only [mem_Icc] at hm
    refine ⟨s - m, ?_, ?_⟩
    · simp only [mem_Icc]
      omega
    · omega
  · intro y hy
    have hyle : y ≤ s := by
      simp only [mem_Icc] at hy
      omega
    rw [Nat.sub_sub_self hyle]
    ring

/-- The actual centered birth is the discrete derivative of the complete
prime error, including the coefficient at one. -/
theorem centeredPairRemainder_as_difference (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      ∑ m ∈ Icc 2 (s - 2),
        (primeError m - primeError (m - 1)) * ratioError (s - m) := by
  rw [centeredPairRemainder_reverse s hs]
  apply Finset.sum_congr rfl
  intro m hm
  have hm2 : 2 ≤ m := (mem_Icc.mp hm).1
  have hstep : m - 1 + 1 = m := by omega
  have hb := primeError_succ (m - 1)
  rw [hstep] at hb
  rw [hb]

/-- The arbitrary packet and its residual account for every centered birth. -/
theorem centeredPairRemainder_packet_split (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      (∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)) +
      (∑ m ∈ Icc 2 (s - 2),
        (residual F m - residual F (m - 1)) * ratioError (s - m)) := by
  rw [centeredPairRemainder_as_difference s hs, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  unfold residual
  ring

/-- Exact pointwise packet decomposition. The two residual endpoints are
visible, so the formula remains valid for the smallest total `s = 4`. -/
theorem centeredPairRemainder_packet_abel (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      (∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)) +
      residual F (s - 2) * ratioError 2 -
      residual F 1 * ratioError (s - 2) +
      (∑ m ∈ Ico 2 (s - 2),
        residual F m *
          (ratioError (s - m) - ratioError (s - (m + 1)))) := by
  rw [centeredPairRemainder_packet_split F s hs]
  have htop : s - 4 + 2 = s - 2 := by omega
  have hend : s - (s - 2) = 2 := by omega
  have h := finite_difference_abel (residual F)
    (fun m => ratioError (s - m)) (s - 4)
  simp only [htop, hend] at h
  rw [h]
  ring

/-- The literal finite error estimate used in the pointwise proof. Its
analytic input is only a uniform bound on the chosen packet residual. -/
theorem centeredPairRemainder_packet_error_bound
    (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (s - 2), |residual F m| ≤ M) :
    |centeredPairRemainder s -
      ∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)| ≤
      M * (|ratioError 2| + |ratioError (s - 2)| +
        ∑ m ∈ Ico 2 (s - 2),
          |ratioError (s - m) - ratioError (s - (m + 1))|) := by
  have htop : s - 4 + 2 = s - 2 := by omega
  have hend : s - (s - 2) = 2 := by omega
  have hR' : ∀ m ∈ Icc 1 (s - 4 + 2), |residual F m| ≤ M := by
    intro m hm
    exact hR m (by simpa only [htop] using hm)
  have h := finite_difference_abs_le_variation (residual F)
    (fun m => ratioError (s - m)) (s - 4) M hR'
  simp only [htop, hend] at h
  rw [centeredPairRemainder_packet_split F s hs]
  simpa only [add_sub_cancel_left] using h

#print axioms finite_difference_abel
#print axioms finite_difference_abs_le_variation
#print axioms centeredPairRemainder_reverse
#print axioms centeredPairRemainder_as_difference
#print axioms centeredPairRemainder_packet_split
#print axioms centeredPairRemainder_packet_abel
#print axioms centeredPairRemainder_packet_error_bound

end
end BuildingBlocks.GoldbachCofactorPointwiseAbelFinite
