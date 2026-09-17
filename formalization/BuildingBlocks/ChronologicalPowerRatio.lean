import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace BuildingBlocks.ChronologicalPowerRatio

/-- The inverse-square-root mass of the first `n` actual positive integers. -/
noncomputable def A (n : ℕ) : ℝ :=
  ∑ j ∈ Finset.range n, 1 / Real.sqrt (j + 1)

/-- Its first integer moment. -/
noncomputable def B (n : ℕ) : ℝ :=
  ∑ j ∈ Finset.range n, Real.sqrt (j + 1)

noncomputable def D (n : ℕ) : ℝ := (n + 1) * A n

@[simp] theorem A_zero : A 0 = 0 := by simp [A]
@[simp] theorem B_zero : B 0 = 0 := by simp [B]
@[simp] theorem D_zero : D 0 = 0 := by simp [D]

theorem A_succ (n : ℕ) : A (n + 1) = A n + 1 / Real.sqrt (n + 1) := by
  simp [A, Finset.sum_range_succ]

theorem B_succ (n : ℕ) : B (n + 1) = B n + Real.sqrt (n + 1) := by
  simp [B, Finset.sum_range_succ]

theorem A_nonneg (n : ℕ) : 0 ≤ A n := by
  unfold A
  positivity

theorem sqrt_pos (n : ℕ) : 0 < Real.sqrt (n + 1) := by positivity

theorem reciprocal_sqrt_step (n : ℕ) :
    1 / Real.sqrt (n + 1) ≤ 2 * (Real.sqrt (n + 1) - Real.sqrt n) := by
  have hs := sqrt_pos n
  have he := Real.sq_sqrt (show (0 : ℝ) ≤ n + 1 by positivity)
  have hf := Real.sq_sqrt (show (0 : ℝ) ≤ n by positivity)
  have hle : Real.sqrt (n : ℝ) ≤ Real.sqrt (n + 1) := by
    apply Real.sqrt_le_sqrt
    linarith
  have hsq : 0 ≤ (Real.sqrt (n + 1) - Real.sqrt n) ^ 2 := sq_nonneg _
  apply (div_le_iff₀ hs).2
  nlinarith

theorem A_bound (n : ℕ) (hn : 1 ≤ n) : A n ≤ 2 * Real.sqrt n - 1 := by
  induction n, hn using Nat.le_induction with
  | base => norm_num [A]
  | succ n hn ih =>
    rw [A_succ]
    have ht := reciprocal_sqrt_step n
    push_cast
    linarith

/-- The parameter controlling the ratio of successive moment increments. -/
noncomputable def h (n : ℕ) : ℝ :=
  A n / Real.sqrt (n + 1) + 1 / (n + 1)

theorem h_nonneg (n : ℕ) : 0 ≤ h n := by
  have := A_nonneg n
  unfold h
  positivity

theorem h_succ_lt (n : ℕ) : h n < h (n + 1) := by
  have hs := sqrt_pos n
  have ht := sqrt_pos (n + 1)
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ n + 1 by positivity)
  have ht2 := Real.sq_sqrt (show (0 : ℝ) ≤ (n + 1 : ℕ) + 1 by positivity)
  have hst : Real.sqrt (n + 1) < Real.sqrt ((n + 1 : ℕ) + 1) := by
    apply Real.sqrt_lt_sqrt (by positivity)
    push_cast
    linarith
  have hn0 : (0 : ℝ) < n + 1 := by positivity
  have hn1 : (0 : ℝ) < (n + 1 : ℕ) + 1 := by positivity
  have ha : A n <
      (Real.sqrt (n + 1) - 1 / Real.sqrt (n + 1)) +
        (Real.sqrt ((n + 1 : ℕ) + 1) - 1 / Real.sqrt ((n + 1 : ℕ) + 1)) := by
    by_cases hn : n = 0
    · subst n
      norm_num [A]
      have hh : 1 < Real.sqrt 2 := (Real.lt_sqrt (by norm_num)).2 (by norm_num)
      calc
        (Real.sqrt 2)⁻¹ < (1 : ℝ) := by
          simpa [one_div] using one_div_lt_one_div_of_lt (by norm_num : (0 : ℝ) < 1) hh
        _ < Real.sqrt 2 := hh
    · have hnp : 1 ≤ n := by omega
      have hab := A_bound n hnp
      have hu := Real.sqrt_nonneg (n : ℝ)
      have hu2 := Real.sq_sqrt (show (0 : ℝ) ≤ n by positivity)
      have hsu : Real.sqrt (n : ℝ) < Real.sqrt (n + 1) :=
        Real.sqrt_lt_sqrt (by positivity) (by linarith)
      have hs1 : 1 < Real.sqrt (n + 1) := by
        apply (Real.lt_sqrt (by norm_num)).2
        exact_mod_cast (show 1 < n + 1 by omega)
      have haux : 2 * Real.sqrt n - 1 < 2 * (n : ℝ) / Real.sqrt (n + 1) := by
        apply (lt_div_iff₀ hs).2
        have hdiff : 0 < (Real.sqrt (n + 1) - Real.sqrt n) ^ 2 :=
          sq_pos_of_pos (sub_pos.2 hsu)
        nlinarith
      have hfirst : (n : ℝ) / Real.sqrt (n + 1) =
          Real.sqrt (n + 1) - 1 / Real.sqrt (n + 1) := by
        apply (div_eq_iff (ne_of_gt hs)).2
        field_simp
        nlinarith [hs2]
      have hsecond : Real.sqrt (n + 1) - 1 / Real.sqrt (n + 1) <
          Real.sqrt ((n + 1 : ℕ) + 1) - 1 / Real.sqrt ((n + 1 : ℕ) + 1) := by
        have hi : 1 / Real.sqrt ((n + 1 : ℕ) + 1) < 1 / Real.sqrt (n + 1) :=
          one_div_lt_one_div_of_lt hs hst
        linarith
      rw [mul_div_assoc, hfirst] at haux
      linarith
  let s := Real.sqrt (n + 1)
  let t := Real.sqrt ((n + 1 : ℕ) + 1)
  have hs' : 0 < s := hs
  have ht' : 0 < t := ht
  have hdiff : (s + t) * (t - s) = 1 := by
    dsimp [s, t]
    push_cast at ht2 ⊢
    nlinarith
  have hrewrite : (s - 1 / s) + (t - 1 / t) =
      (s + t) * (1 - 1 / (s * t)) := by
    field_simp
    ring
  change A n < (s - 1 / s) + (t - 1 / t) at ha
  rw [hrewrite] at ha
  have hm := mul_lt_mul_of_pos_right ha (show 0 < t - s from sub_pos.2 hst)
  have hcore : A n * (t - s) < 1 - 1 / (s * t) := by
    calc
      A n * (t - s) < (s + t) * (1 - 1 / (s * t)) * (t - s) := hm
      _ = (s + t) * (t - s) * (1 - 1 / (s * t)) := by ring
      _ = 1 - 1 / (s * t) := by rw [hdiff, one_mul]
  have hf0 : h n = A n / s + 1 / s ^ 2 := by
    change A n / s + 1 / (n + 1) = _
    rw [show s ^ 2 = (n : ℝ) + 1 from hs2]
  have hf1 : h (n + 1) = (A n + 1 / s) / t + 1 / t ^ 2 := by
    unfold h
    rw [A_succ]
    change (A n + 1 / s) / t + 1 / ((n + 1 : ℕ) + 1 : ℝ) = _
    rw [show t ^ 2 = ((n + 1 : ℕ) + 1 : ℝ) from ht2]
  have heq : h (n + 1) - h n =
      (1 - 1 / (s * t) - A n * (t - s)) / (s * t) := by
    rw [hf0, hf1]
    field_simp
    nlinarith [hdiff]
  exact sub_pos.mp (heq.symm ▸ div_pos (sub_pos.2 hcore) (mul_pos hs' ht'))

theorem h_strictMono : StrictMono h := strictMono_nat_of_lt_succ h_succ_lt

theorem A_pos (n : ℕ) (hn : 1 ≤ n) : 0 < A n := by
  obtain ⟨k, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : n ≠ 0)
  rw [A_succ]
  have := A_nonneg k
  have := sqrt_pos k
  positivity

theorem D_pos (n : ℕ) (hn : 1 ≤ n) : 0 < D n := by
  unfold D
  exact mul_pos (by positivity) (A_pos n hn)

theorem D_succ (n : ℕ) :
    D (n + 1) = D n + Real.sqrt (n + 1) * (1 + h n) := by
  have hs := sqrt_pos n
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ n + 1 by positivity)
  unfold D h
  rw [A_succ]
  push_cast
  field_simp
  nlinarith [hs2]

theorem D_eq_sum (n : ℕ) :
    D n = ∑ j ∈ Finset.range n, Real.sqrt (j + 1) * (1 + h j) := by
  induction n with
  | zero => simp
  | succ n ih => rw [D_succ, Finset.sum_range_succ, ih]

/-- Every old increment has smaller `h` than the next one. -/
theorem D_lt_B_mul (n : ℕ) (hn : 1 ≤ n) : D n < B n * (1 + h n) := by
  rw [D_eq_sum, B, Finset.sum_mul]
  apply Finset.sum_lt_sum
  · intro j hj
    have hjn : j < n := Finset.mem_range.mp hj
    exact (mul_lt_mul_of_pos_left (by linarith [h_strictMono hjn]) (sqrt_pos j)).le
  · refine ⟨0, Finset.mem_range.mpr (by omega), ?_⟩
    exact mul_lt_mul_of_pos_left
      (by linarith [h_strictMono (show 0 < n by omega)]) (sqrt_pos 0)

/-- The normalized mean integer under inverse-square-root weights strictly
decreases as the actual integer cutoff increases. -/
theorem normalizedRatio_succ_lt (n : ℕ) (hn : 1 ≤ n) :
    B (n + 1) / D (n + 1) < B n / D n := by
  have hd := D_pos n hn
  have he := D_pos (n + 1) (by omega)
  have hi := D_lt_B_mul n hn
  have hs := sqrt_pos n
  apply (div_lt_div_iff₀ he hd).2
  rw [B_succ, D_succ]
  nlinarith [mul_lt_mul_of_pos_left hi hs]

theorem normalizedRatio_lt {k N : ℕ} (hk : 1 ≤ k) (hkn : k < N) :
    B N / D N < B k / D k := by
  have hanti : StrictAnti (fun i : ℕ => B (i + 1) / D (i + 1)) := by
    apply strictAnti_nat_of_succ_lt
    intro i
    exact normalizedRatio_succ_lt (i + 1) (by omega)
  obtain ⟨i, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : k ≠ 0)
  obtain ⟨j, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : N ≠ 0)
  exact hanti (by omega)

end BuildingBlocks.ChronologicalPowerRatio
