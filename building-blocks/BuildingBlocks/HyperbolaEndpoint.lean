/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Finite endpoint correction from complementary divisors and Möbius inversion.
Immediate source snapshot and classical attribution: ../verification/hyperbola-endpoint.json.
Imported mathlib dependencies retain their Apache 2.0 license.
-/
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Nat.Sqrt
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

open Finset
open scoped BigOperators

namespace BuildingBlocks.HyperbolaEndpoint

/-- A square quotient leaves exactly the squarefree part in this Möbius sum. -/
theorem moebius_square_quotient_sum {N : ℕ} (hN : N ≠ 0) :
    (∑ d ∈ N.divisors, (ArithmeticFunction.moebius d : ℤ) *
      if IsSquare (N / d) then 1 else 0) =
      (-1 : ℤ) ^ ArithmeticFunction.cardFactors N := by
  classical
  obtain ⟨a, b, ha, hb, he, hsa⟩ := Nat.sq_mul_squarefree_of_pos (Nat.pos_of_ne_zero hN)
  have had : a ∣ N := by rw [← he]; exact dvd_mul_left a (b ^ 2)
  have hdiv : N / a = b ^ 2 := by rw [← he, Nat.mul_div_cancel _ ha]
  have ham : a ∈ N.divisors := Nat.mem_divisors.mpr ⟨had, hN⟩
  rw [Finset.sum_eq_single a]
  · rw [if_pos (hdiv ▸ IsSquare.sq b), mul_one,
      ArithmeticFunction.moebius_apply_of_squarefree hsa, ← he,
      ArithmeticFunction.cardFactors_mul (pow_ne_zero 2 hb.ne') ha.ne',
      ArithmeticFunction.cardFactors_pow, pow_add, pow_mul]
    norm_num
  · intro d hd hda
    by_cases hsd : Squarefree d
    · by_cases hs : IsSquare (N / d)
      · obtain ⟨c, hc⟩ := hs.exists_sq
        have hdc := Nat.div_mul_cancel (Nat.mem_divisors.mp hd).1
        rw [hc] at hdc
        have hd0 : d ≠ 0 := by
          intro hz
          simp [hz] at hdc
          exact hN hdc.symm
        have hc0 : c ≠ 0 := by
          intro hz
          simp [hz] at hdc
          exact hN hdc.symm
        have hda' : d = a := by
          apply Nat.eq_of_factorization_eq hd0 ha.ne'
          intro p
          have hf := congrArg (fun k : ℕ => k.factorization p) (hdc.trans he.symm)
          simp only [Nat.factorization_mul (pow_ne_zero 2 hc0) hd0,
            Nat.factorization_mul (pow_ne_zero 2 hb.ne') ha.ne',
            Nat.factorization_pow, Finsupp.add_apply, Finsupp.smul_apply,
            smul_eq_mul] at hf
          have hdp := hsd.natFactorization_le_one p
          have hap := hsa.natFactorization_le_one p
          omega
        exact (hda hda').elim
      · simp [hs]
    · simp [ArithmeticFunction.moebius_eq_zero_of_not_squarefree hsd]
  · exact fun h => (h ham).elim

/-- One member of each paired divisor, including the square diagonal. -/
def halfDivisorCount (N : ℕ) : ℕ :=
  (N.divisorsAntidiagonal.filter (fun p => p.1 ≤ p.2)).card

theorem twice_halfDivisorCount {N : ℕ} (hN : N ≠ 0) :
    2 * halfDivisorCount N = N.divisors.card + if IsSquare N then 1 else 0 := by
  classical
  let L := N.divisorsAntidiagonal.filter (fun p => p.1 ≤ p.2)
  let R := N.divisorsAntidiagonal.filter (fun p => p.2 ≤ p.1)
  have hu : L ∪ R = N.divisorsAntidiagonal := by
    ext p
    simp only [L, R, mem_union, mem_filter]
    constructor
    · rintro (hp | hp) <;> exact hp.1
    · intro hp
      rcases le_total p.1 p.2 with h | h
      · exact Or.inl ⟨hp, h⟩
      · exact Or.inr ⟨hp, h⟩
  have hi : L ∩ R = N.divisorsAntidiagonal.filter (fun p => p.1 = p.2) := by
    ext p
    simp only [L, R, mem_inter, mem_filter]
    constructor
    · rintro ⟨hp, hq⟩
      exact ⟨hp.1, Nat.le_antisymm hp.2 hq.2⟩
    · rintro ⟨hp, he⟩
      exact ⟨⟨hp, he.le⟩, ⟨hp, he.ge⟩⟩
  have hc : L.card = R.card := by
    apply Finset.card_bij (fun p _ => p.swap)
    · intro p hp
      simpa [L, R] using hp
    · intro p _ q _ h
      exact Prod.swap_injective h
    · intro p hp
      refine ⟨p.swap, ?_, Prod.swap_swap p⟩
      simpa [L, R] using hp
  have hd : (N.divisorsAntidiagonal.filter (fun p => p.1 = p.2)).card =
      if IsSquare N then 1 else 0 := by
    split_ifs with hs
    · obtain ⟨a, ha⟩ := hs
      have he : N.divisorsAntidiagonal.filter (fun p => p.1 = p.2) = {(a, a)} := by
        ext p
        simp only [mem_filter, mem_singleton]
        constructor
        · rintro ⟨hp, he⟩
          have hp := (Nat.mem_divisorsAntidiagonal.mp hp).1
          have hpa : p.1 = a := by nlinarith
          exact Prod.ext hpa (by omega)
        · rintro rfl
          exact ⟨Nat.mem_divisorsAntidiagonal.mpr ⟨ha.symm, hN⟩, rfl⟩
      simp [he]
    · have he : N.divisorsAntidiagonal.filter (fun p => p.1 = p.2) = ∅ := by
        apply Finset.eq_empty_iff_forall_notMem.mpr
        intro p hp
        obtain ⟨hp, he⟩ := mem_filter.mp hp
        exact hs ⟨p.1, by simpa [← he] using (Nat.mem_divisorsAntidiagonal.mp hp).1.symm⟩
      simp [he]
  have ha : N.divisorsAntidiagonal.card = N.divisors.card := by
    rw [← Nat.map_div_right_divisors, Finset.card_map]
  have hh := Finset.card_union_add_card_inter L R
  rw [hu, hi, hd, ha, ← hc] at hh
  change 2 * L.card = _
  omega

theorem moebius_divisorCard_sum {N : ℕ} (hN : N ≠ 0) :
    (∑ d ∈ N.divisors, (ArithmeticFunction.moebius d : ℤ) *
      ((N / d).divisors.card : ℤ)) = 1 := by
  let z : ArithmeticFunction ℤ := ArithmeticFunction.zeta
  have hz : ∀ k : ℕ, (z * z) k = (k.divisors.card : ℤ) := by
    intro k
    rw [ArithmeticFunction.coe_mul_zeta_apply]
    simp only [Finset.card_eq_sum_ones, Nat.cast_sum, Nat.cast_one]
    apply Finset.sum_congr rfl
    intro d hd
    change (ArithmeticFunction.zeta d : ℤ) = 1
    exact_mod_cast ArithmeticFunction.zeta_apply_ne
      (Nat.pos_of_mem_divisors hd).ne'
  have he : ArithmeticFunction.moebius * (z * z) = z := by
    rw [← mul_assoc, ArithmeticFunction.moebius_mul_coe_zeta, one_mul]
  have hh := congrArg (fun f : ArithmeticFunction ℤ => f N) he
  change (ArithmeticFunction.moebius * (z * z)) N = z N at hh
  rw [ArithmeticFunction.mul_apply, Nat.sum_divisorsAntidiagonal
    (fun a b => ArithmeticFunction.moebius a * (z * z) b)] at hh
  simp only [hz] at hh
  convert hh using 1
  change (1 : ℤ) = (ArithmeticFunction.zeta N : ℤ)
  exact_mod_cast (ArithmeticFunction.zeta_apply_ne hN).symm

/-- The full signed integer-endpoint contribution of the hyperbola sawtooth sum. -/
noncomputable def hyperbolaEndpointCorrection (N : ℕ) : ℤ :=
  ∑ d ∈ N.divisors, ArithmeticFunction.moebius d * (halfDivisorCount (N / d) : ℤ)

theorem twice_hyperbolaEndpointCorrection {N : ℕ} (hN : N ≠ 0) :
    2 * hyperbolaEndpointCorrection N =
      1 + (-1 : ℤ) ^ ArithmeticFunction.cardFactors N := by
  classical
  have he : ∀ d ∈ N.divisors,
      2 * (halfDivisorCount (N / d) : ℤ) =
      ((N / d).divisors.card : ℤ) + if IsSquare (N / d) then 1 else 0 := by
    intro d hd
    have hq : N / d ≠ 0 := (Nat.div_pos
      (Nat.le_of_dvd (Nat.pos_of_ne_zero hN) (Nat.mem_divisors.mp hd).1)
      (Nat.pos_of_mem_divisors hd)).ne'
    exact_mod_cast twice_halfDivisorCount hq
  dsimp [hyperbolaEndpointCorrection]
  rw [Finset.mul_sum]
  calc
    _ = ∑ d ∈ N.divisors, (ArithmeticFunction.moebius d : ℤ) *
        (((N / d).divisors.card : ℤ) + if IsSquare (N / d) then 1 else 0) := by
      apply Finset.sum_congr rfl
      intro d hd
      rw [← he d hd]
      ring
    _ = _ := by
      simp_rw [mul_add, Finset.sum_add_distrib]
      rw [moebius_divisorCard_sum hN, moebius_square_quotient_sum hN]

theorem hyperbolaEndpointCorrection_zero_or_one {N : ℕ} (hN : N ≠ 0) :
    hyperbolaEndpointCorrection N = 0 ∨ hyperbolaEndpointCorrection N = 1 := by
  have hh := twice_hyperbolaEndpointCorrection hN
  rcases neg_one_pow_eq_or (R := ℤ) (ArithmeticFunction.cardFactors N) with h | h <;>
    rw [h] at hh <;> omega

theorem halfDivisorCount_eq_sqrt_divisors (N : ℕ) :
    halfDivisorCount N = ((Icc 1 N.sqrt).filter (fun m => m ∣ N)).card := by
  classical
  apply Finset.card_bij (fun p _ => p.1)
  · intro p hp
    obtain ⟨hp, hle⟩ := mem_filter.mp hp
    obtain ⟨hprod, hN⟩ := Nat.mem_divisorsAntidiagonal.mp hp
    have hp0 : 0 < p.1 := Nat.pos_of_ne_zero (left_ne_zero_of_mul (hprod ▸ hN))
    apply mem_filter.mpr
    refine ⟨mem_Icc.mpr ⟨hp0, Nat.le_sqrt.mpr ?_⟩, ?_⟩
    · nlinarith
    · exact ⟨p.2, hprod.symm⟩
  · intro p hp q hq he
    have hp' := (Nat.mem_divisorsAntidiagonal.mp (mem_filter.mp hp).1)
    have hq' := (Nat.mem_divisorsAntidiagonal.mp (mem_filter.mp hq).1)
    have hp0 : p.1 ≠ 0 := left_ne_zero_of_mul (hp'.1 ▸ hp'.2)
    apply Prod.ext he
    apply Nat.eq_of_mul_eq_mul_left (Nat.pos_of_ne_zero hp0)
    rw [hp'.1, he, hq'.1]
  · intro m hm
    obtain ⟨hm, hmd⟩ := mem_filter.mp hm
    obtain ⟨hm1, hms⟩ := mem_Icc.mp hm
    have hprod : m * (N / m) = N := Nat.mul_div_cancel' hmd
    have hN : N ≠ 0 := by
      intro hz
      simp [hz] at hms
      omega
    refine ⟨(m, N / m), mem_filter.mpr ⟨Nat.mem_divisorsAntidiagonal.mpr
      ⟨hprod, hN⟩, ?_⟩, rfl⟩
    have hs := Nat.le_sqrt.mp hms
    dsimp
    exact (Nat.le_div_iff_mul_le hm1).mpr hs

theorem hyperbolaEndpointCorrection_eq_jump_sum {N : ℕ} (hN : N ≠ 0) :
    hyperbolaEndpointCorrection N =
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℤ) *
        ∑ m ∈ Icc 1 (N / n).sqrt, if n * m ∣ N then (1 : ℤ) else 0 := by
  classical
  let w : ℕ → ℤ := fun n => ArithmeticFunction.moebius n *
    ∑ m ∈ Icc 1 (N / n).sqrt, if n * m ∣ N then 1 else 0
  have hsub : N.divisors ⊆ Icc 1 N := by
    intro n hn
    exact mem_Icc.mpr ⟨Nat.pos_of_mem_divisors hn,
      Nat.le_of_dvd (Nat.pos_of_ne_zero hN) (Nat.mem_divisors.mp hn).1⟩
  have hzero : ∀ n ∈ Icc 1 N, n ∉ N.divisors → w n = 0 := by
    intro n _ hn
    have hnd : ¬n ∣ N := fun h => hn (Nat.mem_divisors.mpr ⟨h, hN⟩)
    dsimp [w]
    have he : (∑ m ∈ Icc 1 (N / n).sqrt, if n * m ∣ N then (1 : ℤ) else 0) = 0 := by
      apply Finset.sum_eq_zero
      intro m _
      exact if_neg (fun h => hnd ((dvd_mul_right n m).trans h))
    rw [he, mul_zero]
  change hyperbolaEndpointCorrection N = ∑ n ∈ Icc 1 N, w n
  rw [← Finset.sum_subset hsub hzero]
  apply Finset.sum_congr rfl
  intro n hn
  dsimp [w]
  congr 1
  rw [halfDivisorCount_eq_sqrt_divisors, Finset.card_eq_sum_ones,
    Nat.cast_sum, Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro m _
  have hn0 := Nat.pos_of_mem_divisors hn
  have hnd := (Nat.mem_divisors.mp hn).1
  have he : m ∣ N / n ↔ n * m ∣ N := by
    exact Nat.dvd_div_iff_mul_dvd hnd
  simp [he]

end BuildingBlocks.HyperbolaEndpoint
