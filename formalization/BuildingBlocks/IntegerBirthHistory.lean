import BuildingBlocks.CoarsePrimeBounds

open scoped BigOperators

set_option autoImplicit false

namespace BuildingBlocks.IntegerBirthHistory

open BuildingBlocks.CoarsePrimitive

/-- The last birth coefficient is retained in this exact telescope. -/
theorem birth_coefficients_sum (H : ℕ → ℝ) (n : ℕ) :
    (∑ k ∈ Finset.range (n + 1), (H (k + 1) - H k)) = H (n + 1) - H 0 := by
  induction n with
  | zero => simp
  | succ n ih => rw [Finset.sum_range_succ, ih]; ring

theorem birth_coefficients_sum_zero (H : ℕ → ℝ) (n : ℕ)
    (hseed : H 0 = 0) (htail : H (n + 1) = 0) :
    (∑ k ∈ Finset.range (n + 1), (H (k + 1) - H k)) = 0 := by
  rw [birth_coefficients_sum, hseed, htail, sub_self]

/-- The literal integer restriction of the cumulative-history ground field. -/
noncomputable def historyField (n : ℕ) : ℝ :=
  Real.log n - (∑ m ∈ Finset.range (n + 1),
    ArithmeticFunction.vonMangoldt m / (m : ℝ)) + psi n / (n : ℝ)

/-- The next prime-power arrival cancels exactly in the history difference. -/
theorem historyField_succ {n : ℕ} (hn : 1 ≤ n) :
    historyField (n + 1) - historyField n =
      Real.log (1 + 1 / (n : ℝ)) - psi n / ((n : ℝ) * (n + 1 : ℕ)) := by
  have h0 : (n : ℝ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  have h1 : ((n + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  have hlog : Real.log ((n + 1 : ℕ) : ℝ) - Real.log (n : ℝ) =
      Real.log (1 + 1 / (n : ℝ)) := by
    rw [← Real.log_div h1 h0]
    congr 1
    push_cast
    field_simp
  unfold historyField
  rw [Finset.sum_range_succ, psi_succ]
  have hcancel :
      -(ArithmeticFunction.vonMangoldt (n + 1) / ((n + 1 : ℕ) : ℝ)) +
        (psi n + ArithmeticFunction.vonMangoldt (n + 1)) / ((n + 1 : ℕ) : ℝ) -
        psi n / (n : ℝ) = -psi n / ((n : ℝ) * ((n + 1 : ℕ) : ℝ)) := by
    field_simp
    push_cast
    ring
  simp only [neg_div] at hcancel
  linarith

/-- The explicit integer-cell logarithmic remainder, not a prime-error bound. -/
noncomputable def logRemainder (n : ℕ) : ℝ :=
  (n : ℝ) * ((n : ℝ) + 1) * Real.log (1 + 1 / (n : ℝ)) - (n : ℝ)

theorem actual_error_reconstruction {n : ℕ} (hn : 1 ≤ n) :
    psi n - (n : ℝ) = (n : ℝ) * ((n : ℝ) + 1) *
      (historyField n - historyField (n + 1)) + logRemainder n := by
  have h0 : (n : ℝ) ≠ 0 := by exact_mod_cast (show n ≠ 0 by omega)
  have h1 : (n : ℝ) + 1 ≠ 0 := by positivity
  have hd := historyField_succ hn
  push_cast at hd
  have hm := congrArg (fun x : ℝ => (n : ℝ) * ((n : ℝ) + 1) * x) hd
  field_simp at hm
  have hratio : ((n : ℝ) + 1) / (n : ℝ) = 1 + 1 / (n : ℝ) := by
    field_simp
  rw [hratio] at hm
  unfold logRemainder
  nlinarith

theorem logRemainder_bounds {n : ℕ} (hn : 1 ≤ n) :
    0 < logRemainder n ∧ logRemainder n < 1 := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hy : (0 : ℝ) < 1 + 1 / (n : ℝ) := by positivity
  have hyne : (1 : ℝ) + 1 / (n : ℝ) ≠ 1 := by
    have : (0 : ℝ) < 1 / (n : ℝ) := by positivity
    linarith
  have hu : Real.log (1 + 1 / (n : ℝ)) < 1 / (n : ℝ) := by
    simpa using Real.log_lt_sub_one_of_pos hy hyne
  have hinv : (1 + 1 / (n : ℝ))⁻¹ = (n : ℝ) / ((n : ℝ) + 1) := by
    field_simp
  have hune : (1 + 1 / (n : ℝ))⁻¹ ≠ 1 := by
    rw [hinv]
    intro h
    have := (div_eq_one_iff_eq hn1.ne').mp h
    linarith
  have hl := Real.log_lt_sub_one_of_pos (inv_pos.mpr hy) hune
  rw [Real.log_inv, hinv] at hl
  have hlow := mul_lt_mul_of_pos_right hl hn1
  have hhigh := mul_lt_mul_of_pos_right hu (mul_pos hn0 hn1)
  have hdiv : (n : ℝ) / ((n : ℝ) + 1) * ((n : ℝ) + 1) = (n : ℝ) :=
    div_mul_cancel₀ _ hn1.ne'
  have hdiv2 : 1 / (n : ℝ) * ((n : ℝ) * ((n : ℝ) + 1)) = (n : ℝ) + 1 := by
    field_simp
  rw [sub_mul, hdiv] at hlow
  rw [hdiv2] at hhigh
  unfold logRemainder
  constructor <;> nlinarith

/-- Finite Abel summation, with both boundary terms retained. -/
theorem finite_birth_pairing (H F : ℕ → ℝ) (n : ℕ) :
    (∑ k ∈ Finset.range (n + 1), (H (k + 1) - H k) * F (k + 1)) =
      H (n + 1) * F (n + 1) - H 0 * F 1 +
        ∑ k ∈ Finset.range n, H (k + 1) * (F (k + 1) - F (k + 2)) := by
  induction n with
  | zero => simp; ring
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, Finset.sum_range_succ]
    ring

/-- Exact native birth pairing with the actual cumulative prime-power history.
The endpoint hypotheses express the finite probe's tail cancellation. -/
theorem actual_history_pairing (H : ℕ → ℝ) (n : ℕ)
    (hseed : H 0 = 0) (htail : H (n + 1) = 0) :
    (∑ k ∈ Finset.range (n + 1),
      (H (k + 1) - H k) * historyField (k + 1)) =
      ∑ k ∈ Finset.range n, H (k + 1) *
        (psi (k + 1) / (((k + 1 : ℕ) : ℝ) * (k + 2 : ℕ)) -
          Real.log (1 + 1 / ((k + 1 : ℕ) : ℝ))) := by
  rw [finite_birth_pairing, hseed, htail]
  simp only [zero_mul, sub_self, zero_add]
  apply Finset.sum_congr rfl
  intro k hk
  have hd := historyField_succ (n := k + 1) (by omega)
  have he : historyField (k + 1) - historyField (k + 2) =
      psi (k + 1) / (((k + 1 : ℕ) : ℝ) * ((k + 2 : ℕ) : ℝ)) -
        Real.log (1 + 1 / ((k + 1 : ℕ) : ℝ)) := by
    simpa only [Nat.add_assoc] using (show
      historyField (k + 1) - historyField (k + 1 + 1) =
        psi (k + 1) / (((k + 1 : ℕ) : ℝ) * ((k + 1 + 1 : ℕ) : ℝ)) -
          Real.log (1 + 1 / ((k + 1 : ℕ) : ℝ)) by linarith)
  rw [he]

#print axioms historyField_succ
#print axioms actual_error_reconstruction
#print axioms logRemainder_bounds
#print axioms birth_coefficients_sum_zero
#print axioms finite_birth_pairing
#print axioms actual_history_pairing

end BuildingBlocks.IntegerBirthHistory
