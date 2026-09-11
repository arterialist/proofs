import Mathlib.NumberTheory.SmoothNumbers
import Mathlib.Data.Nat.Find
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-!
# Stopping an actual divisor chain at a real threshold

Prime factors are bounded inclusively by the real number `Y`. The witness is an
actual natural-number divisor; removing any prime factor crosses below `T`.
-/

namespace BuildingBlocks

/-- A least divisor above `T` has every strictly smaller divisor below `T`. -/
theorem exists_minimal_divisor_ge {Q : ℕ} {T : ℝ} (hTQ : T ≤ (Q : ℝ)) :
    ∃ d : ℕ, d ∣ Q ∧ T ≤ (d : ℝ) ∧
      ∀ e : ℕ, e ∣ d → e < d → (e : ℝ) < T := by
  classical
  have hex : ∃ d : ℕ, d ∣ Q ∧ T ≤ (d : ℝ) := ⟨Q, dvd_rfl, hTQ⟩
  let d := Nat.find hex
  have hd := Nat.find_spec hex
  refine ⟨d, hd.1, hd.2, ?_⟩
  intro e hed hedlt
  apply lt_of_not_ge
  intro hTe
  exact Nat.find_min hex hedlt ⟨hed.trans hd.1, hTe⟩

/-- For `T > 1`, an actual prime division gives a strict upper bound `Y * T`.
The final conjunct records the stopping condition for every prime divisor. -/
theorem exists_smooth_divisor_stopping_strict {Q : ℕ} {Y T : ℝ}
    (hQ : 0 < Q) (hY : 2 ≤ Y) (hT : 1 < T) (hTQ : T ≤ (Q : ℝ))
    (hprime : ∀ p : ℕ, p.Prime → p ∣ Q → (p : ℝ) ≤ Y) :
    ∃ d : ℕ, 0 < d ∧ d ∣ Q ∧ T ≤ (d : ℝ) ∧ (d : ℝ) < Y * T ∧
      ∀ p : ℕ, p.Prime → p ∣ d → ((d / p : ℕ) : ℝ) < T := by
  obtain ⟨d, hdQ, hTd, hmin⟩ := exists_minimal_divisor_ge hTQ
  have hdpos : 0 < d := Nat.pos_of_dvd_of_pos hdQ hQ
  have hdgt : 1 < d := by exact_mod_cast (lt_of_lt_of_le hT hTd)
  have hstop : ∀ p : ℕ, p.Prime → p ∣ d → ((d / p : ℕ) : ℝ) < T := by
    intro p hp hpd
    exact hmin (d / p) (Nat.div_dvd_of_dvd hpd) (Nat.div_lt_self hdpos hp.one_lt)
  obtain ⟨p, hp, hpd⟩ := Nat.exists_prime_and_dvd (ne_of_gt hdgt)
  have hpY := hprime p hp (hpd.trans hdQ)
  have hdlt : (d : ℝ) < Y * T := by
    calc
      (d : ℝ) = (p : ℝ) * ((d / p : ℕ) : ℝ) := by
        exact_mod_cast (Nat.mul_div_cancel' hpd).symm
      _ ≤ Y * ((d / p : ℕ) : ℝ) :=
        mul_le_mul_of_nonneg_right hpY (Nat.cast_nonneg _)
      _ < Y * T := mul_lt_mul_of_pos_left (hstop p hp hpd) (by linarith)
  exact ⟨d, hdpos, hdQ, hTd, hdlt, hstop⟩

/-- Every positive integer whose prime factors are at most `Y` has an actual
divisor in `[T, Y*T]`, for `Y ≥ 2` and `1 ≤ T ≤ Q`.
When `Q = 1` the threshold is necessarily `1`; at threshold `1` the witness is `1`.
-/
theorem exists_smooth_divisor_stopping {Q : ℕ} {Y T : ℝ}
    (hQ : 0 < Q) (hY : 2 ≤ Y) (hT : 1 ≤ T) (hTQ : T ≤ (Q : ℝ))
    (hprime : ∀ p : ℕ, p.Prime → p ∣ Q → (p : ℝ) ≤ Y) :
    ∃ d : ℕ, 0 < d ∧ d ∣ Q ∧ T ≤ (d : ℝ) ∧ (d : ℝ) ≤ Y * T := by
  by_cases hQone : Q = 1
  · subst Q
    have hTone : T = 1 := by norm_num at hTQ; linarith
    subst T
    exact ⟨1, by norm_num, dvd_rfl, by norm_num,
      by simpa using (show (1 : ℝ) ≤ Y by linarith)⟩
  by_cases hTone : T = 1
  · subst T
    exact ⟨1, by norm_num, one_dvd Q, by norm_num,
      by simpa using (show (1 : ℝ) ≤ Y by linarith)⟩
  obtain ⟨d, hdpos, hdQ, hTd, hdlt, _⟩ :=
    exists_smooth_divisor_stopping_strict hQ hY (lt_of_le_of_ne hT (Ne.symm hTone)) hTQ hprime
  exact ⟨d, hdpos, hdQ, hTd, hdlt.le⟩

/-- The same interval lemma using mathlib's strict smoothness convention:
membership in `smoothNumbers (Y + 1)` means every prime factor is at most `Y`. -/
theorem exists_smooth_divisor_stopping_of_mem_smoothNumbers {Q Y : ℕ} {T : ℝ}
    (hY : 2 ≤ Y) (hQ : Q ∈ Nat.smoothNumbers (Y + 1))
    (hT : 1 ≤ T) (hTQ : T ≤ (Q : ℝ)) :
    ∃ d : ℕ, 0 < d ∧ d ∣ Q ∧ T ≤ (d : ℝ) ∧ (d : ℝ) ≤ (Y : ℝ) * T := by
  apply exists_smooth_divisor_stopping
    (Nat.pos_of_ne_zero (Nat.ne_zero_of_mem_smoothNumbers hQ))
    (by exact_mod_cast hY) hT hTQ
  intro p hp hpQ
  exact_mod_cast Nat.lt_succ_iff.mp ((Nat.mem_smoothNumbers'.mp hQ) p hp hpQ)

end BuildingBlocks
