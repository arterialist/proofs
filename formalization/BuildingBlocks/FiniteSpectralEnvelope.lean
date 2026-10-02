import Mathlib.Algebra.Order.Chebyshev
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

/-!
Finite scalar spectral envelope. The vector is arbitrary real data with zero
sum. No positivity of `1 + y i`, zeta input, or finite kernel certificate is
assumed. This file does not assert a matrix or asymptotic zero-density theorem.
-/

namespace BuildingBlocks.FiniteSpectralEnvelope

noncomputable section

open scoped BigOperators
open Finset

def energy {m : ℕ} (y : Fin m → ℝ) : ℝ := ∑ i, y i ^ 2

def excessSq {m : ℕ} (y : Fin m → ℝ) : ℝ :=
  ∑ i, max (y i - 1) 0 ^ 2

def defect {m : ℕ} (y : Fin m → ℝ) : ℝ := energy y - excessSq y

def envelope (m : ℕ) (E : ℝ) : ℝ :=
  if E ≤ (m : ℝ) / ((m : ℝ) - 1) then E
  else E / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ)) - 1

theorem energy_nonneg {m : ℕ} (y : Fin m → ℝ) : 0 ≤ energy y := by
  exact sum_nonneg fun i _ => sq_nonneg (y i)

theorem excessSq_nonneg {m : ℕ} (y : Fin m → ℝ) : 0 ≤ excessSq y := by
  exact sum_nonneg fun i _ => sq_nonneg (max (y i - 1) 0)

theorem excessSq_eq_high_sum {m : ℕ} (y : Fin m → ℝ) :
    excessSq y = ∑ i ∈ univ.filter (fun i => 1 < y i), (y i - 1) ^ 2 := by
  classical
  unfold excessSq
  rw [sum_filter]
  apply sum_congr rfl
  intro i _
  by_cases hi : 1 < y i
  · simp [hi, max_eq_left (by linarith : 0 ≤ y i - 1)]
  · simp [hi, max_eq_right (by linarith : y i - 1 ≤ 0)]

/-- Positive excess forces the exact dimension-sensitive energy lower bound. -/
theorem excess_pos_energy_bound {m : ℕ} (hm : 2 ≤ m) (y : Fin m → ℝ)
    (hzero : ∑ i, y i = 0) (hR : 0 < excessSq y) :
    (m : ℝ) * (1 + Real.sqrt (excessSq y)) ^ 2 ≤
      ((m : ℝ) - 1) * energy y := by
  classical
  let s : Finset (Fin m) := univ.filter (fun i => 1 < y i)
  let B : ℝ := ∑ i ∈ s, (y i - 1)
  let r : ℝ := Real.sqrt (excessSq y)
  let k : ℝ := s.card
  let t : ℝ := (sᶜ).card
  let Et : ℝ := ∑ i ∈ sᶜ, y i ^ 2
  have hRsum : excessSq y = ∑ i ∈ s, (y i - 1) ^ 2 :=
    excessSq_eq_high_sum y
  have hs : s.Nonempty := by
    by_contra hn
    have he : s = ∅ := not_nonempty_iff_eq_empty.mp hn
    rw [he] at hRsum
    simp only [sum_empty] at hRsum
    linarith
  have hk : 1 ≤ k := by
    have hc : 1 ≤ s.card := card_pos.mpr hs
    change (1 : ℝ) ≤ (s.card : ℝ)
    exact_mod_cast hc
  have hB0 : 0 ≤ B := by
    apply sum_nonneg
    intro i hi
    have hy : 1 < y i := (mem_filter.mp hi).2
    linarith
  have hRle : excessSq y ≤ B ^ 2 := by
    rw [hRsum]
    apply sum_sq_le_sq_sum_of_nonneg
    intro i hi
    have hy : 1 < y i := (mem_filter.mp hi).2
    linarith
  have hr0 : 0 ≤ r := Real.sqrt_nonneg _
  have hrB : r ≤ B := Real.sqrt_le_iff.mpr ⟨hB0, hRle⟩
  have hr2 : r ^ 2 = excessSq y := Real.sq_sqrt (excessSq_nonneg y)
  have hys : (∑ i ∈ s, y i) = B + k := by
    calc
      (∑ i ∈ s, y i) = ∑ i ∈ s, ((y i - 1) + 1) := by
        apply sum_congr rfl
        intro i _
        ring
      _ = B + k := by simp [B, k]
  have hyt : (∑ i ∈ sᶜ, y i) = -(B + k) := by
    have hsplit := sum_add_sum_compl s y
    rw [hzero, hys] at hsplit
    linarith
  have ht0 : 0 < t := by
    have htne : (sᶜ).Nonempty := by
      by_contra hn
      have he : sᶜ = ∅ := not_nonempty_iff_eq_empty.mp hn
      rw [he] at hyt
      simp only [sum_empty] at hyt
      linarith
    change (0 : ℝ) < ((sᶜ).card : ℝ)
    exact_mod_cast card_pos.mpr htne
  have hkt : k + t = (m : ℝ) := by
    have hc : s.card + (sᶜ).card = m := by simp
    change (s.card : ℝ) + ((sᶜ).card : ℝ) = (m : ℝ)
    exact_mod_cast hc
  have hEt0 : 0 ≤ Et := sum_nonneg fun i _ => sq_nonneg (y i)
  have hhigh : (∑ i ∈ s, y i ^ 2) = excessSq y + 2 * B + k := by
    calc
      (∑ i ∈ s, y i ^ 2) =
          ∑ i ∈ s, ((y i - 1) ^ 2 + 2 * (y i - 1) + 1) := by
        apply sum_congr rfl
        intro i _
        ring
      _ = excessSq y + 2 * B + k := by
        rw [sum_add_distrib, sum_add_distrib, ← mul_sum, ← hRsum]
        simp [B, k]
  have hE : energy y = r ^ 2 + 2 * B + k + Et := by
    have hsplit := sum_add_sum_compl s (fun i => y i ^ 2)
    rw [hhigh] at hsplit
    change excessSq y + 2 * B + k + Et = energy y at hsplit
    linarith
  have hcs : (k + B) ^ 2 ≤ t * Et := by
    have hc := sq_sum_le_card_mul_sum_sq (s := sᶜ) (f := y)
    rw [hyt, neg_sq] at hc
    change (k + B) ^ 2 ≤ ((sᶜ).card : ℝ) * (∑ i ∈ sᶜ, y i ^ 2)
    simpa only [add_comm] using hc
  have hkr : (k + r) ^ 2 ≤ (k + B) ^ 2 := by
    nlinarith
  have hElower : r ^ 2 + 2 * r + k + Et ≤ energy y := by
    linarith
  have hmult := mul_le_mul_of_nonneg_right hElower ht0.le
  have hfirst : (r ^ 2 + 2 * r + k) * t + (k + r) ^ 2 ≤ energy y * t := by
    nlinarith [hcs, hkr]
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hmp : 0 ≤ (m : ℝ) - 1 := by linarith
  have hscaled := mul_le_mul_of_nonneg_right hfirst hmp
  have hpositive : 0 ≤ (k - 1) * ((m : ℝ) + r) ^ 2 :=
    mul_nonneg (by linarith) (sq_nonneg _)
  have hidentity :
      ((r ^ 2 + 2 * r + k) * t + (k + r) ^ 2) * ((m : ℝ) - 1)
        - (m : ℝ) * (1 + r) ^ 2 * t = (k - 1) * ((m : ℝ) + r) ^ 2 := by
    have ht : t = (m : ℝ) - k := by linarith [hkt]
    rw [ht]
    ring
  have hcross : (m : ℝ) * (1 + r) ^ 2 * t ≤
      (((m : ℝ) - 1) * energy y) * t := by
    nlinarith [hscaled, hpositive, hidentity]
  exact (mul_le_mul_iff_left₀ ht0).mp hcross

theorem upper_branch_le_energy {m : ℕ} (hm : 2 ≤ m) {E : ℝ} (hE : 0 ≤ E) :
    E / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ)) - 1 ≤ E := by
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hm0 : 0 < (m : ℝ) := by linarith
  have hm1 : 0 ≤ (m : ℝ) - 1 := by linarith
  have hz : 0 ≤ ((m : ℝ) - 1) * E / (m : ℝ) :=
    div_nonneg (mul_nonneg hm1 hE) hm0.le
  have hs := Real.sq_sqrt hz
  have hid : E - (((m : ℝ) - 1) * E / (m : ℝ)) = E / (m : ℝ) := by
    field_simp
    ring
  nlinarith [sq_nonneg (Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ)) - 1)]

/-- The full finite scalar lower envelope, with no lower bound on the entries. -/
theorem defect_ge_envelope {m : ℕ} (hm : 2 ≤ m) (y : Fin m → ℝ)
    (hzero : ∑ i, y i = 0) : envelope m (energy y) ≤ defect y := by
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hm0 : 0 < (m : ℝ) := by linarith
  have hm1 : 0 < (m : ℝ) - 1 := by linarith
  have hE := energy_nonneg y
  by_cases hR : excessSq y = 0
  · unfold defect envelope
    rw [hR, sub_zero]
    split_ifs
    · exact le_rfl
    · exact upper_branch_le_energy hm hE
  · have hRpos : 0 < excessSq y := lt_of_le_of_ne (excessSq_nonneg y) (Ne.symm hR)
    let r := Real.sqrt (excessSq y)
    let a := Real.sqrt (((m : ℝ) - 1) * energy y / (m : ℝ))
    have hr0 : 0 ≤ r := Real.sqrt_nonneg _
    have hrpos : 0 < r := Real.sqrt_pos.mpr hRpos
    have hr2 : r ^ 2 = excessSq y := Real.sq_sqrt (excessSq_nonneg y)
    have hbound := excess_pos_energy_bound hm y hzero hRpos
    change (m : ℝ) * (1 + r) ^ 2 ≤ ((m : ℝ) - 1) * energy y at hbound
    have hstrict : (m : ℝ) < energy y * ((m : ℝ) - 1) := by
      have hp := mul_pos hm0 (show 0 < (1 + r) ^ 2 - 1 by nlinarith)
      nlinarith
    have hthreshold : (m : ℝ) / ((m : ℝ) - 1) < energy y :=
      (div_lt_iff₀ hm1).mpr hstrict
    have hz : 0 ≤ ((m : ℝ) - 1) * energy y / (m : ℝ) := by positivity
    have ha0 : 0 ≤ a := Real.sqrt_nonneg _
    have ha2 : a ^ 2 = ((m : ℝ) - 1) * energy y / (m : ℝ) := Real.sq_sqrt hz
    have hrad : (1 + r) ^ 2 ≤ ((m : ℝ) - 1) * energy y / (m : ℝ) := by
      apply (le_div_iff₀ hm0).mpr
      nlinarith [hbound]
    have hra : 1 + r ≤ a := Real.le_sqrt_of_sq_le hrad
    have hRsq : excessSq y ≤ (a - 1) ^ 2 := by nlinarith
    have hid : energy y - (((m : ℝ) - 1) * energy y / (m : ℝ)) =
        energy y / (m : ℝ) := by
      field_simp
      ring
    unfold envelope defect
    rw [if_neg (not_le.mpr hthreshold)]
    change energy y / (m : ℝ) + 2 * a - 1 ≤ energy y - excessSq y
    nlinarith [hRsq, ha2, hid]

theorem upper_branch_monotone {m : ℕ} (hm : 2 ≤ m) {E A : ℝ} (hEA : E ≤ A) :
    E / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ)) - 1 ≤
      A / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * A / (m : ℝ)) - 1 := by
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hm0 : 0 < (m : ℝ) := by linarith
  have hm1 : 0 ≤ (m : ℝ) - 1 := by linarith
  have hdiv := div_le_div_of_nonneg_right hEA hm0.le
  have hrad := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hEA hm1) hm0.le
  have hs := Real.sqrt_le_sqrt hrad
  linarith

theorem upper_branch_ge_threshold {m : ℕ} (hm : 2 ≤ m) {A : ℝ}
    (hA : (m : ℝ) / ((m : ℝ) - 1) ≤ A) :
    (m : ℝ) / ((m : ℝ) - 1) ≤
      A / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * A / (m : ℝ)) - 1 := by
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hm0 : 0 < (m : ℝ) := by linarith
  have hm1 : 0 < (m : ℝ) - 1 := by linarith
  have hr : 1 ≤ ((m : ℝ) - 1) * A / (m : ℝ) := by
    apply (le_div_iff₀ hm0).mpr
    have hp := (div_le_iff₀ hm1).mp hA
    nlinarith
  have hs : 1 ≤ Real.sqrt (((m : ℝ) - 1) * A / (m : ℝ)) :=
    (Real.one_le_sqrt).mpr hr
  have hdiv := div_le_div_of_nonneg_right hA hm0.le
  have hid : ((m : ℝ) / ((m : ℝ) - 1)) / (m : ℝ) + 1 =
      (m : ℝ) / ((m : ℝ) - 1) := by
    field_simp
    ring
  linarith

theorem envelope_monotone {m : ℕ} (hm : 2 ≤ m) {E A : ℝ} (hEA : E ≤ A) :
    envelope m E ≤ envelope m A := by
  unfold envelope
  split_ifs with hE hA hA
  · exact hEA
  · exact hE.trans (upper_branch_ge_threshold hm (le_of_lt (not_le.mp hA)))
  · exact False.elim (hE (hEA.trans hA))
  · exact upper_branch_monotone hm hEA

theorem upper_branch_one_lipschitz {m : ℕ} (hm : 2 ≤ m) {E A : ℝ}
    (hE : (m : ℝ) / ((m : ℝ) - 1) ≤ E) (hEA : E ≤ A) :
    A / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * A / (m : ℝ)) - 1 ≤
      E / (m : ℝ) + 2 * Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ)) - 1 + (A - E) := by
  have hmR : 2 ≤ (m : ℝ) := by exact_mod_cast hm
  have hm0 : 0 < (m : ℝ) := by linarith
  have hm1 : 0 < (m : ℝ) - 1 := by linarith
  let u := Real.sqrt (((m : ℝ) - 1) * E / (m : ℝ))
  let v := Real.sqrt (((m : ℝ) - 1) * A / (m : ℝ))
  have hrE : 1 ≤ ((m : ℝ) - 1) * E / (m : ℝ) := by
    apply (le_div_iff₀ hm0).mpr
    have hp := (div_le_iff₀ hm1).mp hE
    nlinarith
  have hu : 1 ≤ u := (Real.one_le_sqrt).mpr hrE
  have huv : u ≤ v := by
    apply Real.sqrt_le_sqrt
    exact div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hEA hm1.le) hm0.le
  have hu2 : u ^ 2 = ((m : ℝ) - 1) * E / (m : ℝ) :=
    Real.sq_sqrt (by linarith)
  have hv2 : v ^ 2 = ((m : ℝ) - 1) * A / (m : ℝ) :=
    Real.sq_sqrt (by
      have hrad := div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_left hEA hm1.le) hm0.le
      linarith)
  have hpoly : 0 ≤ (v - u) * (v + u - 2) :=
    mul_nonneg (by linarith) (by linarith)
  have hidE : E - (((m : ℝ) - 1) * E / (m : ℝ)) = E / (m : ℝ) := by
    field_simp
    ring
  have hidA : A - (((m : ℝ) - 1) * A / (m : ℝ)) = A / (m : ℝ) := by
    field_simp
    ring
  change A / (m : ℝ) + 2 * v - 1 ≤ E / (m : ℝ) + 2 * u - 1 + (A - E)
  nlinarith [hpoly, hu2, hv2, hidE, hidA]

theorem envelope_one_lipschitz {m : ℕ} (hm : 2 ≤ m) {E A : ℝ}
    (hE0 : 0 ≤ E) (hEA : E ≤ A) : envelope m A ≤ envelope m E + (A - E) := by
  have hA0 : 0 ≤ A := hE0.trans hEA
  unfold envelope
  split_ifs with hA hE hE
  · linarith
  · exact False.elim (hE (hEA.trans hA))
  · have h := upper_branch_le_energy hm hA0
    linarith
  · exact upper_branch_one_lipschitz hm (le_of_lt (not_le.mp hE)) hEA

/-- Adding nonnegative span cost compensates for any prescribed real energy floor. -/
theorem defect_add_cost_ge_envelope {m : ℕ} (hm : 2 ≤ m) (y : Fin m → ℝ)
    (hzero : ∑ i, y i = 0) {A x : ℝ} (hx : 0 ≤ x)
    (hfloor : A ≤ energy y + x) : envelope m A ≤ defect y + x := by
  have hbase := defect_ge_envelope hm y hzero
  by_cases hAE : A ≤ energy y
  · have hmono := envelope_monotone hm hAE
    linarith
  · have hEA : energy y ≤ A := le_of_lt (not_le.mp hAE)
    have hlip := envelope_one_lipschitz hm (energy_nonneg y) hEA
    linarith

end
end BuildingBlocks.FiniteSpectralEnvelope
