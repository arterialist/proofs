import Mathlib.Data.Nat.ChineseRemainder
import Mathlib.Data.Int.ModEq
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.Real.Archimedean
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Exact shifted prime-power occupation by CRT

The CRT itself is `Nat.chineseRemainderOfFinset`. The bridge here prescribes
`n + h p ≡ p ^ e p` modulo the next prime power, and keeps both divisibility
statements as well as the integer p-adic valuation. Cutoffs may be real.
-/

namespace BuildingBlocks.ExactPrimePowerCRT

open scoped BigOperators

theorem exact_depth_of_modEq {p e : ℕ} (hp : p.Prime) {z : ℤ}
    (hz : Int.ModEq ((p : ℤ) ^ (e + 1)) z ((p : ℤ) ^ e)) :
    (p : ℤ) ^ e ∣ z ∧ ¬ (p : ℤ) ^ (e + 1) ∣ z ∧ padicValInt p z = e := by
  letI : Fact p.Prime := ⟨hp⟩
  have hsmall : (p : ℤ) ^ e ∣ z := by
    apply Int.modEq_zero_iff_dvd.mp
    exact (hz.of_dvd (pow_dvd_pow (p : ℤ) (Nat.le_succ e))).trans
      (dvd_refl ((p : ℤ) ^ e)).modEq_zero_int
  have hnext : ¬ (p : ℤ) ^ (e + 1) ∣ z := by
    intro hd
    have hh := Int.modEq_zero_iff_dvd.mp (hz.symm.trans hd.modEq_zero_int)
    have hh' : p ^ (e + 1) ∣ p ^ e := by exact_mod_cast hh
    have := (Nat.pow_dvd_pow_iff_le_right hp.one_lt).mp hh'
    omega
  have hz0 : z ≠ 0 := by
    intro h
    exact hnext (h ▸ dvd_zero _)
  refine ⟨hsmall, hnext, ?_⟩
  have hlo := (padicValInt_dvd_iff e z).mp hsmall
  have hhi : ¬ e + 1 ≤ padicValInt p z := by
    intro h
    exact hnext ((padicValInt_dvd_iff (e + 1) z).mpr (Or.inr h))
  rcases hlo with h | h
  · exact False.elim (hz0 h)
  · omega

/-- A bounded residue with the prescribed shifted congruences, including exponent zero. -/
theorem exists_shifted_residue (S : Finset ℕ) (e : ℕ → ℕ) (h : ℕ → ℤ)
    (hS : ∀ p ∈ S, p.Prime) :
    ∃ r : ℕ, r < ∏ p ∈ S, p ^ (e p + 1) ∧
      ∀ p ∈ S, Int.ModEq ((p : ℤ) ^ (e p + 1))
        ((r : ℤ) + h p) ((p : ℤ) ^ e p) := by
  let m : ℕ → ℕ := fun p => p ^ (e p + 1)
  let a : ℕ → ℕ := fun p =>
    ((((p : ℤ) ^ e p - h p) % (m p : ℤ)).toNat)
  have hm : ∀ p ∈ S, m p ≠ 0 := fun p hp => pow_ne_zero _ (hS p hp).ne_zero
  have hc : Set.Pairwise (↑S : Set ℕ) (fun p q => Nat.Coprime (m p) (m q)) := by
    intro p hp q hq hpq
    exact Nat.coprime_pow_primes _ _ (hS p hp) (hS q hq) hpq
  let r := Nat.chineseRemainderOfFinset a m S hm hc
  refine ⟨r, Nat.chineseRemainderOfFinset_lt_prod a m hm hc, ?_⟩
  intro p hp
  have ha : Int.ModEq (m p : ℤ) (a p : ℤ) ((p : ℤ) ^ e p - h p) := by
    dsimp [a]
    rw [Int.toNat_of_nonneg (Int.emod_nonneg _ (by exact_mod_cast hm p hp))]
    exact Int.mod_modEq _ _
  have hr : Int.ModEq (m p : ℤ) (r : ℤ) (a p : ℤ) :=
    Int.natCast_modEq_iff.mpr (r.property p hp)
  simpa [m] using (hr.trans ha).add_right (h p)

/-- One full residue class has the exact depths; no positivity premise is needed
for `padicValInt`, and nonzero shifted values follow from the congruences. -/
theorem exists_exact_residue_class (S : Finset ℕ) (e : ℕ → ℕ) (h : ℕ → ℤ)
    (hS : ∀ p ∈ S, p.Prime) :
    ∃ r : ℕ, r < ∏ p ∈ S, p ^ (e p + 1) ∧
      ∀ n : ℤ, Int.ModEq (∏ p ∈ S, (p : ℤ) ^ (e p + 1)) n r →
        ∀ p ∈ S,
          (p : ℤ) ^ e p ∣ n + h p ∧
          ¬ (p : ℤ) ^ (e p + 1) ∣ n + h p ∧
          padicValInt p (n + h p) = e p := by
  obtain ⟨r, hr, hp⟩ := exists_shifted_residue S e h hS
  refine ⟨r, hr, ?_⟩
  intro n hn p hpm
  apply exact_depth_of_modEq (hS p hpm)
  exact ((hn.of_dvd (Finset.dvd_prod_of_mem (fun q : ℕ => (q : ℤ) ^ (e q + 1)) hpm)).add_right
    (h p)).trans (hp p hpm)

/-- The first integer in a residue class at or above a real cutoff is less than
one modulus beyond that cutoff. This also proves its minimality. -/
theorem exists_first_representative (r Q : ℤ) (hQ : 0 < Q) (X : ℝ) :
    ∃ n : ℤ, X ≤ (n : ℝ) ∧ (n : ℝ) < X + Q ∧ Int.ModEq Q n r ∧
      ∀ m : ℤ, X ≤ (m : ℝ) → Int.ModEq Q m r → n ≤ m := by
  let k : ℤ := ⌈(X - r) / Q⌉
  refine ⟨r + Q * k, ?_, ?_, Int.modEq_add_fac_self, ?_⟩
  · have hk := Int.le_ceil ((X - r) / Q)
    have hQr : (0 : ℝ) < Q := by exact_mod_cast hQ
    have := (div_le_iff₀ hQr).mp hk
    dsimp [k]
    push_cast
    linarith
  · have hk := Int.ceil_lt_add_one ((X - r) / Q)
    have hQr : (0 : ℝ) < Q := by exact_mod_cast hQ
    have hh := mul_lt_mul_of_pos_right hk hQr
    rw [add_mul, div_mul_cancel₀ _ hQr.ne'] at hh
    dsimp [k]
    push_cast
    linarith
  · intro m hm hmr
    obtain ⟨j, hj⟩ := Int.modEq_iff_add_fac.mp hmr.symm
    have hQr : (0 : ℝ) < Q := by exact_mod_cast hQ
    have hjr : (X - r) / Q ≤ (j : ℝ) := by
      apply (div_le_iff₀ hQr).mpr
      rw [hj] at hm
      push_cast at hm
      linarith
    have hkj : k ≤ j := Int.ceil_le.mpr hjr
    rw [hj]
    exact add_le_add_left (mul_le_mul_of_nonneg_left hkj hQ.le) r

/-- Positive actual integers and positive shifted values with the exact prescribed
depths, within one CRT modulus of any admissible real cutoff. -/
theorem exists_positive_exact_depths_above
    (S : Finset ℕ) (e : ℕ → ℕ) (h : ℕ → ℤ)
    (hS : ∀ p ∈ S, p.Prime) (X : ℝ) (hX : 0 < X)
    (hshift : ∀ p ∈ S, 0 < X + (h p : ℝ)) :
    ∃ n : ℤ, 0 < n ∧ X ≤ (n : ℝ) ∧
      (n : ℝ) < X + (∏ p ∈ S, (p : ℤ) ^ (e p + 1) : ℤ) ∧
      ∀ p ∈ S, 0 < n + h p ∧
        (p : ℤ) ^ e p ∣ n + h p ∧
        ¬ (p : ℤ) ^ (e p + 1) ∣ n + h p ∧
        padicValInt p (n + h p) = e p := by
  obtain ⟨r, _, hr⟩ := exists_exact_residue_class S e h hS
  have hQ : (0 : ℤ) < ∏ p ∈ S, (p : ℤ) ^ (e p + 1) := by
    apply Finset.prod_pos
    intro p hp
    exact pow_pos (by exact_mod_cast (hS p hp).pos) _
  obtain ⟨n, hnX, hnlt, hnr, _⟩ :=
    exists_first_representative r _ hQ X
  refine ⟨n, ?_, hnX, hnlt, ?_⟩
  · exact_mod_cast lt_of_lt_of_le hX hnX
  · intro p hp
    refine ⟨?_, hr n hnr p hp⟩
    have ht : (0 : ℝ) < (n : ℝ) + (h p : ℝ) :=
      lt_of_lt_of_le (hshift p hp) (add_le_add_right hnX _)
    exact_mod_cast ht

end BuildingBlocks.ExactPrimePowerCRT
