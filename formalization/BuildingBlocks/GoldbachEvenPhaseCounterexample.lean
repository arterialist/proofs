import Mathlib.Tactic
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.NumberTheory.VonMangoldt
import BuildingBlocks.GoldbachEvenPhaseCenterFinite
set_option maxHeartbeats 2000000
set_option maxRecDepth 4000

/-!
# An actual negative parity-centered Goldbach triangle

At the even cutoff 118, the cumulative parity-centered von Mangoldt
Goldbach triangle is strictly negative. The proof retains every ordered
prime-power pair and both odd-lattice reference legs. It certifies each
prime logarithm against a four-decimal rational table by a finite Taylor
bound around a dyadic scale, evaluates the rational triangle by kernel
computation, and pays a uniform termwise error.
-/

namespace BuildingBlocks.GoldbachEvenPhaseCounterexample

open Finset Real

private noncomputable def taylorLog (x : ℝ) : ℝ := ∑ i ∈ range 20, x ^ (i + 1) / (i + 1)

private theorem logNatApprox (p k : ℕ) (hp : 0 < p) (hk : 2 ^ k ≤ p) :
    let x : ℝ := 1 - (2 : ℝ) ^ k / p
    |Real.log p - ((k : ℝ) * (69314718055 / 100000000000 : ℝ) + taylorLog x)| ≤
      (k : ℝ) * (1 / 4000000000 : ℝ) + x ^ 21 / (1 - x) := by
  dsimp
  let x : ℝ := 1 - (2 : ℝ) ^ k / p
  have hpR : (0 : ℝ) < p := by exact_mod_cast hp
  have hpow : (0 : ℝ) < (2 : ℝ) ^ k := pow_pos (by norm_num) _
  have hx0 : 0 ≤ x := by
    dsimp [x]
    have hkr : (2 : ℝ) ^ k ≤ p := by exact_mod_cast hk
    exact sub_nonneg.mpr (div_le_one_of_le₀ hkr hpR.le)
  have hx1 : x < 1 := by
    dsimp [x]
    have : (0 : ℝ) < (2 : ℝ) ^ k / p := div_pos hpow hpR
    linarith
  have hxabs : |x| < 1 := by rwa [abs_of_nonneg hx0]
  have ht := Real.abs_log_sub_add_sum_range_le hxabs 20
  have hlog : Real.log (p : ℝ) = (k : ℝ) * Real.log 2 - Real.log (1 - x) := by
    have h1x : 1 - x = (2 : ℝ) ^ k / p := by dsimp [x]; ring
    rw [h1x, Real.log_div hpow.ne' hpR.ne', Real.log_pow]
    ring
  have h2 : |Real.log 2 - (69314718055 / 100000000000 : ℝ)| ≤ (1 / 4000000000 : ℝ) := by
    rw [abs_le]
    constructor <;> linarith [Real.log_two_gt_d9, Real.log_two_lt_d9]
  have heq : Real.log (p : ℝ) - ((k : ℝ) * (69314718055 / 100000000000 : ℝ) + taylorLog x) =
      (k : ℝ) * (Real.log 2 - (69314718055 / 100000000000 : ℝ)) -
        (taylorLog x + Real.log (1 - x)) := by rw [hlog]; ring
  rw [heq]
  calc
    _ ≤ |(k : ℝ) * (Real.log 2 - (69314718055 / 100000000000 : ℝ))| +
        |taylorLog x + Real.log (1 - x)| := abs_sub _ _
    _ ≤ (k : ℝ) * (1 / 4000000000 : ℝ) + x ^ 21 / (1 - x) := by
      have ha : |(k : ℝ) * (Real.log 2 - (69314718055 / 100000000000 : ℝ))| ≤
          (k : ℝ) * (1 / 4000000000 : ℝ) := by
        rw [abs_mul, abs_of_nonneg (Nat.cast_nonneg k)]
        exact mul_le_mul_of_nonneg_left h2 (Nat.cast_nonneg k)
      change |taylorLog x + Real.log (1 - x)| ≤ _ at ht
      rw [abs_of_nonneg hx0] at ht
      norm_num only [Nat.reduceAdd] at ht
      linarith

private def logTable (p : ℕ) : ℚ :=
  if p = 2 then 6931 / 10000 else
  if p = 3 then 10986 / 10000 else
  if p = 5 then 16094 / 10000 else
  if p = 7 then 19459 / 10000 else
  if p = 11 then 23978 / 10000 else
  if p = 13 then 25649 / 10000 else
  if p = 17 then 28332 / 10000 else
  if p = 19 then 29444 / 10000 else
  if p = 23 then 31354 / 10000 else
  if p = 29 then 33672 / 10000 else
  if p = 31 then 34339 / 10000 else
  if p = 37 then 36109 / 10000 else
  if p = 41 then 37135 / 10000 else
  if p = 43 then 37612 / 10000 else
  if p = 47 then 38501 / 10000 else
  if p = 53 then 39702 / 10000 else
  if p = 59 then 40775 / 10000 else
  if p = 61 then 41108 / 10000 else
  if p = 67 then 42046 / 10000 else
  if p = 71 then 42626 / 10000 else
  if p = 73 then 42904 / 10000 else
  if p = 79 then 43694 / 10000 else
  if p = 83 then 44188 / 10000 else
  if p = 89 then 44886 / 10000 else
  if p = 97 then 45747 / 10000 else
  if p = 101 then 46151 / 10000 else
  if p = 103 then 46347 / 10000 else
  if p = 107 then 46728 / 10000 else
  if p = 109 then 46913 / 10000 else
  if p = 113 then 47273 / 10000 else
  0

private theorem logTable_bound {p : ℕ} (hp : p.Prime) (hle : p ≤ 117) :
    |Real.log p - (logTable p : ℝ)| < 1 / 10000 := by
  have h := logNatApprox p (Nat.log 2 p) hp.pos (Nat.pow_log_le_self 2 hp.ne_zero)
  interval_cases p <;> norm_num at hp
  all_goals norm_num [logTable, taylorLog] at h ⊢
  all_goals obtain ⟨hl, hu⟩ := abs_le.mp h
  all_goals rw [abs_lt]
  all_goals constructor <;> linarith

private def ratWeight (n : ℕ) : ℚ :=
  if IsPrimePow n then logTable (Nat.minFac n) else 0

private theorem ratWeight_bounded (n : ℕ) (hn : n ≤ 117) :
    0 ≤ ratWeight n ∧ ratWeight n ≤ 5 := by
  have h : ∀ m ∈ Finset.range 118, 0 ≤ ratWeight m ∧ ratWeight m ≤ 5 := by native_decide
  exact h n (Finset.mem_range.mpr (by omega))

private theorem weight_approx (n : ℕ) (hn : n ≤ 117) :
    |ArithmeticFunction.vonMangoldt n - (ratWeight n : ℝ)| ≤ 1 / 10000 := by
  rw [ArithmeticFunction.vonMangoldt_apply]
  by_cases h : IsPrimePow n
  · have hne : n ≠ 1 := h.ne_one
    have hpos : 0 < n := h.pos
    have hp := logTable_bound (Nat.minFac_prime hne) ((Nat.minFac_le hpos).trans hn)
    simpa [ratWeight, h] using hp.le
  · simp [ratWeight, h]

private def ratOddRef (n : ℕ) : ℚ := if Odd n then 2 else 0

private def ratEvenSum (N : ℕ) : ℚ :=
  ∑ q ∈ BuildingBlocks.GoldbachEvenPhaseCenterFinite.evenPairDomain N,
    (ratWeight q.1 - ratOddRef q.1) * (ratWeight q.2 - ratOddRef q.2)

private theorem rat_even_118_exact :
    ratEvenSum 118 = -(2924955171 / 100000000) := by native_decide

open BuildingBlocks.GoldbachEvenPhaseCenterFinite
open BuildingBlocks.GoldbachPrimePhaseCutFinite

private theorem ratOddRef_real (n : ℕ) : oddReference n = (ratOddRef n : ℝ) := by
  by_cases h : Odd n <;> simp [oddReference, ratOddRef, h]

private theorem centered_abs_le_six (n : ℕ) (hn : n ≤ 117) :
    |weight n - oddReference n| ≤ 6 ∧
      |(ratWeight n : ℝ) - oddReference n| ≤ 6 := by
  have happrox := weight_approx n hn
  have hrat := ratWeight_bounded n hn
  have hratR : (0 : ℝ) ≤ (ratWeight n : ℝ) ∧ (ratWeight n : ℝ) ≤ 5 := by
    exact_mod_cast hrat
  have href : (0 : ℝ) ≤ oddReference n ∧ oddReference n ≤ 2 := by
    unfold oddReference
    split_ifs <;> norm_num
  have hw : weight n = ArithmeticFunction.vonMangoldt n := rfl
  rw [hw]
  rw [abs_le] at happrox
  constructor <;> rw [abs_le] <;> constructor <;> linarith

private theorem pair_approx_le (q : ℕ × ℕ)
    (hq : q ∈ evenPairDomain 118) :
    (weight q.1 - oddReference q.1) * (weight q.2 - oddReference q.2) ≤
      ((ratWeight q.1 : ℝ) - oddReference q.1) *
        ((ratWeight q.2 : ℝ) - oddReference q.2) + 12 / 10000 := by
  rw [evenPairDomain] at hq
  have hdom : q ∈ pairDomain 118 := (Finset.mem_filter.mp hq).1
  rw [pairDomain] at hdom
  have hprod : q.1 ∈ Finset.Icc 1 118 ∧ q.2 ∈ Finset.Icc 1 118 :=
    Finset.mem_product.mp (Finset.mem_filter.mp hdom).1
  have hsum : q.1 + q.2 ≤ 118 := (Finset.mem_filter.mp hdom).2
  have h1 : q.1 ≤ 117 := by have h2 := (Finset.mem_Icc.mp hprod.2).1; omega
  have h2 : q.2 ≤ 117 := by have h1' := (Finset.mem_Icc.mp hprod.1).1; omega
  have ha1 := weight_approx q.1 h1
  have ha2 := weight_approx q.2 h2
  have hc1 := (centered_abs_le_six q.1 h1).2
  have hc2 := (centered_abs_le_six q.2 h2).1
  change |weight q.1 - (ratWeight q.1 : ℝ)| ≤ _ at ha1
  change |weight q.2 - (ratWeight q.2 : ℝ)| ≤ _ at ha2
  have heq :
      (weight q.1 - oddReference q.1) * (weight q.2 - oddReference q.2) -
        ((ratWeight q.1 : ℝ) - oddReference q.1) *
          ((ratWeight q.2 : ℝ) - oddReference q.2) =
      (weight q.1 - (ratWeight q.1 : ℝ)) * (weight q.2 - oddReference q.2) +
        ((ratWeight q.1 : ℝ) - oddReference q.1) *
          (weight q.2 - (ratWeight q.2 : ℝ)) := by ring
  have hbound :
      |(weight q.1 - (ratWeight q.1 : ℝ)) * (weight q.2 - oddReference q.2) +
        ((ratWeight q.1 : ℝ) - oddReference q.1) *
          (weight q.2 - (ratWeight q.2 : ℝ))| ≤ 12 / 10000 := by
    calc
      _ ≤ |(weight q.1 - (ratWeight q.1 : ℝ)) * (weight q.2 - oddReference q.2)| +
          |((ratWeight q.1 : ℝ) - oddReference q.1) *
            (weight q.2 - (ratWeight q.2 : ℝ))| := abs_add_le _ _
      _ = |weight q.1 - (ratWeight q.1 : ℝ)| * |weight q.2 - oddReference q.2| +
          |(ratWeight q.1 : ℝ) - oddReference q.1| *
            |weight q.2 - (ratWeight q.2 : ℝ)| := by rw [abs_mul, abs_mul]
      _ ≤ (1 / 10000 : ℝ) * 6 + 6 * (1 / 10000 : ℝ) := by gcongr
      _ = 12 / 10000 := by norm_num
  have hle := le_abs_self ((weight q.1 - oddReference q.1) *
      (weight q.2 - oddReference q.2) -
        ((ratWeight q.1 : ℝ) - oddReference q.1) *
          ((ratWeight q.2 : ℝ) - oddReference q.2))
  rw [heq] at hle
  linarith

private theorem even_card_118 : (evenPairDomain 118).card = 3481 := by native_decide

private theorem zero_phase_form :
    evenCenteredGoldbach 118 (fun _ => 0) =
      ∑ q ∈ evenPairDomain 118,
        (weight q.1 - oddReference q.1) * (weight q.2 - oddReference q.2) := by
  unfold evenCenteredGoldbach
  apply Finset.sum_congr rfl
  intro q hq
  simp only [sub_self, Real.cos_zero, mul_one]
  ring

private theorem rat_even_form :
    (ratEvenSum 118 : ℝ) =
      ∑ q ∈ evenPairDomain 118,
        ((ratWeight q.1 : ℝ) - oddReference q.1) *
          ((ratWeight q.2 : ℝ) - oddReference q.2) := by
  unfold ratEvenSum
  push_cast
  apply Finset.sum_congr rfl
  intro q hq
  rw [ratOddRef_real, ratOddRef_real]

/-- The actual zero-phase parity-centered even Goldbach triangle is negative at 118. -/
theorem evenCenteredGoldbach_118_neg :
    evenCenteredGoldbach 118 (fun _ => 0) < -25 := by
  have hsum :
      (∑ q ∈ evenPairDomain 118,
        (weight q.1 - oddReference q.1) * (weight q.2 - oddReference q.2)) ≤
      ∑ q ∈ evenPairDomain 118,
        (((ratWeight q.1 : ℝ) - oddReference q.1) *
          ((ratWeight q.2 : ℝ) - oddReference q.2) + 12 / 10000) := by
    apply Finset.sum_le_sum
    intro q hq
    exact pair_approx_le q hq
  rw [Finset.sum_add_distrib, ← rat_even_form] at hsum
  simp only [Finset.sum_const, nsmul_eq_mul] at hsum
  rw [even_card_118] at hsum
  rw [zero_phase_form]
  have hrat : (ratEvenSum 118 : ℝ) = -(2924955171 / 100000000 : ℝ) := by
    calc
      _ = ((-(2924955171 / 100000000) : ℚ) : ℝ) :=
        congrArg (fun x : ℚ => (x : ℝ)) rat_even_118_exact
      _ = _ := by norm_num
  rw [hrat] at hsum
  norm_num at hsum ⊢
  linarith

#print axioms evenCenteredGoldbach_118_neg

end BuildingBlocks.GoldbachEvenPhaseCounterexample
