import Mathlib.Data.Real.Sqrt
import Mathlib.Data.Nat.Prime.Int
import Mathlib.Tactic

/-!
Finite actual prime-power left-window geometry only. The local actual staircase
trace and interval Cauchy are proved separately in ActualPrimeErrorCausalTrace.
Full proper-power aggregation, geometric sums and logarithmic tails remain written;
no ordinary-prime signed upper, criterion premise or RH theorem is supplied.
-/

open Set

namespace BuildingBlocks.ActualPrimePowerWindowGeometry

def leftWindow (n : ℕ) : Set ℝ :=
  Icc ((n : ℝ) - Real.sqrt (n : ℝ)) (n : ℝ)

def windowInterior (n : ℕ) : Set ℝ :=
  Ioo ((n : ℝ) - Real.sqrt (n : ℝ)) (n : ℝ)

def ActualProperPrimePower (n : ℕ) : Prop :=
  ∃ p k : ℕ, p.Prime ∧ 2 ≤ k ∧ p ^ k = n

theorem four_le_pow {p k : ℕ} (hp : 2 ≤ p) (hk : 2 ≤ k) :
    4 ≤ p ^ k := by
  calc
    4 = 2 ^ 2 := by norm_num
    _ ≤ 2 ^ k := by exact Nat.pow_le_pow_right (by decide : 1 ≤ 2) hk
    _ ≤ p ^ k := by exact Nat.pow_le_pow_left hp k

theorem four_le_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 2 ≤ k) :
    4 ≤ p ^ k := four_le_pow hp.two_le hk

theorem one_le_window_left {n : ℕ} (hn : 4 ≤ n) :
    1 ≤ (n : ℝ) - Real.sqrt (n : ℝ) := by
  have hnR : (4 : ℝ) ≤ n := by exact_mod_cast hn
  have hnonneg : (0 : ℝ) ≤ (n : ℝ) - 1 := by linarith
  have hsq : (n : ℝ) ≤ ((n : ℝ) - 1) ^ 2 := by nlinarith
  have hsqrt := (Real.sqrt_le_left hnonneg).2 hsq
  linarith

theorem leftWindow_subset_one_to_n {n : ℕ} (hn : 4 ≤ n) :
    leftWindow n ⊆ Icc (1 : ℝ) (n : ℝ) := by
  intro t ht
  exact ⟨(one_le_window_left hn).trans ht.1, ht.2⟩

theorem leftWindow_subset_real_cutoff {n : ℕ} {Y : ℝ}
    (hn : 4 ≤ n) (hY : (n : ℝ) ≤ Y) :
    leftWindow n ⊆ Icc (1 : ℝ) Y := by
  intro t ht
  exact ⟨(one_le_window_left hn).trans ht.1, ht.2.trans hY⟩

theorem pow_eq_mul_pred_pow {p k : ℕ} (hk : 1 ≤ k) :
    p ^ k = p * p ^ (k - 1) := by
  calc
    p ^ k = p ^ ((k - 1) + 1) := by congr 1; omega
    _ = p * p ^ (k - 1) := by rw [pow_succ]; ring

theorem pow_add_pred_pow_le_pow {p q k : ℕ}
    (hpq : p < q) (hk : 2 ≤ k) :
    p ^ k + q ^ (k - 1) ≤ q ^ k := by
  have hk1 : 1 ≤ k := by omega
  have hpow : p ^ (k - 1) ≤ q ^ (k - 1) :=
    Nat.pow_le_pow_left hpq.le (k - 1)
  calc
    p ^ k + q ^ (k - 1) = p * p ^ (k - 1) + q ^ (k - 1) := by
      rw [pow_eq_mul_pred_pow hk1]
    _ ≤ p * q ^ (k - 1) + q ^ (k - 1) := by gcongr
    _ = (p + 1) * q ^ (k - 1) := by ring
    _ ≤ q * q ^ (k - 1) := by gcongr; omega
    _ = q ^ k := (pow_eq_mul_pred_pow hk1).symm

theorem pow_add_pred_pow_lt_pow {p q k : ℕ}
    (hp : 0 < p) (hpq : p < q) (hk : 2 ≤ k) :
    p ^ k + q ^ (k - 1) < q ^ k := by
  have hk1 : 1 ≤ k := by omega
  have hpow : p ^ (k - 1) < q ^ (k - 1) :=
    Nat.pow_lt_pow_left hpq (by omega : k - 1 ≠ 0)
  have hmul := Nat.mul_lt_mul_of_pos_left hpow hp
  calc
    p ^ k + q ^ (k - 1) = p * p ^ (k - 1) + q ^ (k - 1) := by
      rw [pow_eq_mul_pred_pow hk1]
    _ < p * q ^ (k - 1) + q ^ (k - 1) := Nat.add_lt_add_right hmul _
    _ = (p + 1) * q ^ (k - 1) := by ring
    _ ≤ q * q ^ (k - 1) := by gcongr; omega
    _ = q ^ k := (pow_eq_mul_pred_pow hk1).symm

theorem sqrt_pow_le_pred_pow {q k : ℕ}
    (hq : 1 ≤ q) (hk : 2 ≤ k) :
    Real.sqrt ((q ^ k : ℕ) : ℝ) ≤ ((q ^ (k - 1) : ℕ) : ℝ) := by
  have hexp : k ≤ (k - 1) * 2 := by omega
  have hpow : q ^ k ≤ q ^ ((k - 1) * 2) :=
    Nat.pow_le_pow_right hq hexp
  apply (Real.sqrt_le_left (by positivity :
    (0 : ℝ) ≤ ((q ^ (k - 1) : ℕ) : ℝ))).2
  exact_mod_cast (by simpa [pow_mul] using hpow : q ^ k ≤ (q ^ (k - 1)) ^ 2)

theorem earlier_pow_le_later_window_left {p q k : ℕ}
    (hpq : p < q) (hk : 2 ≤ k) :
    ((p ^ k : ℕ) : ℝ) ≤
      ((q ^ k : ℕ) : ℝ) - Real.sqrt ((q ^ k : ℕ) : ℝ) := by
  have hq : 1 ≤ q := by omega
  have hsep : ((p ^ k : ℕ) : ℝ) + ((q ^ (k - 1) : ℕ) : ℝ) ≤
      ((q ^ k : ℕ) : ℝ) := by
    exact_mod_cast pow_add_pred_pow_le_pow hpq hk
  linarith [sqrt_pow_le_pred_pow hq hk]

theorem earlier_pow_lt_later_window_left {p q k : ℕ}
    (hp : 0 < p) (hpq : p < q) (hk : 2 ≤ k) :
    ((p ^ k : ℕ) : ℝ) <
      ((q ^ k : ℕ) : ℝ) - Real.sqrt ((q ^ k : ℕ) : ℝ) := by
  have hq : 1 ≤ q := by omega
  have hsep : ((p ^ k : ℕ) : ℝ) + ((q ^ (k - 1) : ℕ) : ℝ) <
      ((q ^ k : ℕ) : ℝ) := by
    exact_mod_cast pow_add_pred_pow_lt_pow hp hpq hk
  linarith [sqrt_pow_le_pred_pow hq hk]

theorem ordered_closed_windows_disjoint {p q k : ℕ}
    (hp : 0 < p) (hpq : p < q) (hk : 2 ≤ k) :
    Disjoint (leftWindow (p ^ k)) (leftWindow (q ^ k)) := by
  apply Set.disjoint_left.mpr
  intro t htP htQ
  have hsep := earlier_pow_lt_later_window_left hp hpq hk
  have hpEnd : t ≤ ((p ^ k : ℕ) : ℝ) := htP.2
  have hqStart : ((q ^ k : ℕ) : ℝ) - Real.sqrt ((q ^ k : ℕ) : ℝ) ≤ t := htQ.1
  linarith

theorem prime_closed_windows_disjoint {p q k : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q) (hk : 2 ≤ k) :
    Disjoint (leftWindow (p ^ k)) (leftWindow (q ^ k)) := by
  rcases lt_or_gt_of_ne hpq with h | h
  · exact ordered_closed_windows_disjoint hp.pos h hk
  · exact (ordered_closed_windows_disjoint hq.pos h hk).symm

theorem ordered_windows_disjoint_interiors {p q k : ℕ}
    (hpq : p < q) (hk : 2 ≤ k) :
    Disjoint (windowInterior (p ^ k)) (windowInterior (q ^ k)) := by
  apply Set.disjoint_left.mpr
  intro t htP htQ
  have hsep := earlier_pow_le_later_window_left hpq hk
  have hpEnd : t < ((p ^ k : ℕ) : ℝ) := htP.2
  have hqStart : ((q ^ k : ℕ) : ℝ) - Real.sqrt ((q ^ k : ℕ) : ℝ) < t := htQ.1
  linarith

theorem distinct_windows_disjoint_interiors {p q k : ℕ}
    (hpq : p ≠ q) (hk : 2 ≤ k) :
    Disjoint (windowInterior (p ^ k)) (windowInterior (q ^ k)) := by
  rcases lt_or_gt_of_ne hpq with h | h
  · exact ordered_windows_disjoint_interiors h hk
  · exact (ordered_windows_disjoint_interiors h hk).symm

theorem prime_power_window_subset_cutoff {p k : ℕ} {Y : ℝ}
    (hp : p.Prime) (hk : 2 ≤ k) (hY : ((p ^ k : ℕ) : ℝ) ≤ Y) :
    leftWindow (p ^ k) ⊆ Icc (1 : ℝ) Y :=
  leftWindow_subset_real_cutoff (four_le_prime_pow hp hk) hY

theorem prime_power_representation_unique {p q k l : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hk : 2 ≤ k) (hl : 2 ≤ l)
    (h : p ^ k = q ^ l) : p = q ∧ k = l := by
  have hk1 : 1 ≤ k := by omega
  have hl1 : 1 ≤ l := by omega
  have h' : p ^ ((k - 1) + 1) = q ^ ((l - 1) + 1) := by
    simpa [Nat.sub_add_cancel hk1, Nat.sub_add_cancel hl1] using h
  obtain ⟨hpq, hkl⟩ := hp.pow_inj hq h'
  exact ⟨hpq, by omega⟩

theorem actual_proper_prime_power_unique_row {n : ℕ}
    (hn : ActualProperPrimePower n) :
    ∃! row : ℕ × ℕ, row.1.Prime ∧ 2 ≤ row.2 ∧ row.1 ^ row.2 = n := by
  obtain ⟨p, k, hp, hk, hpk⟩ := hn
  refine ⟨(p, k), ⟨hp, hk, hpk⟩, ?_⟩
  intro row hrow
  obtain ⟨hqp, hlk⟩ := prime_power_representation_unique hrow.1 hp
    hrow.2.1 hk (hrow.2.2.trans hpk.symm)
  exact Prod.ext hqp hlk

theorem actual_proper_prime_power_four_le {n : ℕ}
    (hn : ActualProperPrimePower n) : 4 ≤ n := by
  obtain ⟨p, k, hp, hk, rfl⟩ := hn
  exact four_le_prime_pow hp hk

theorem no_actual_proper_prime_power_before_four {Y : ℝ} (hY : Y < 4) :
    ¬ ∃ n : ℕ, ActualProperPrimePower n ∧ (n : ℝ) ≤ Y := by
  rintro ⟨n, hn, hnY⟩
  have hn4 : (4 : ℝ) ≤ n := by
    exact_mod_cast actual_proper_prime_power_four_le hn
  linarith

theorem window_four : leftWindow 4 = Icc (2 : ℝ) 4 := by
  norm_num [leftWindow]

theorem seven_mem_window_eight : (7 : ℝ) ∈ windowInterior 8 := by
  change (8 : ℝ) - Real.sqrt 8 < 7 ∧ (7 : ℝ) < 8
  have hs : (1 : ℝ) < Real.sqrt 8 := by
    nlinarith [Real.sqrt_nonneg (8 : ℝ), Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 8)]
  constructor <;> linarith

theorem seven_mem_window_nine : (7 : ℝ) ∈ windowInterior 9 := by
  norm_num [windowInterior]

theorem actual_different_exponents_overlap :
    ActualProperPrimePower 8 ∧ ActualProperPrimePower 9 ∧
      (7 : ℝ) ∈ windowInterior (2 ^ 3) ∩ windowInterior (3 ^ 2) := by
  refine ⟨⟨2, 3, by decide, by decide, by norm_num⟩,
    ⟨3, 2, by decide, by decide, by norm_num⟩, ?_⟩
  norm_num only [Nat.reducePow]
  exact ⟨seven_mem_window_eight, seven_mem_window_nine⟩

theorem different_exponents_not_disjoint :
    ¬ Disjoint (windowInterior (2 ^ 3)) (windowInterior (3 ^ 2)) := by
  intro h
  have hm := actual_different_exponents_overlap.2.2
  exact (Set.disjoint_left.mp h) hm.1 hm.2

end BuildingBlocks.ActualPrimePowerWindowGeometry
