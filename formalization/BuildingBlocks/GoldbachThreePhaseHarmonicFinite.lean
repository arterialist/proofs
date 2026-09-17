import BuildingBlocks.GoldbachEvenPhaseCenterFinite
import Mathlib.NumberTheory.Padics.PadicVal.Basic

/-!
# The three-adic rows in the even Goldbach phase harmonic

These are finite support statements for the actual von Mangoldt function.
They isolate the rows that survive the first angular harmonic of the
three-generator phase, retaining every prime-power contribution.
-/

namespace BuildingBlocks.GoldbachThreePhaseHarmonicFinite

open BuildingBlocks.GoldbachPrimePhaseCutFinite
open BuildingBlocks.GoldbachEvenPhaseCenterFinite

private instance : Fact (Nat.Prime 3) := ⟨by norm_num⟩

/-- A nonzero von Mangoldt weight with a factor of three comes from a
power of three, with its exponent exactly the three-adic valuation. -/
theorem weight_three_power {n : ℕ} (hw : weight n ≠ 0)
    (hv : 0 < padicValNat 3 n) :
    ∃ k : ℕ, 0 < k ∧ n = 3 ^ k ∧ padicValNat 3 n = k := by
  have hprimepow : IsPrimePow n :=
    ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hw
  obtain ⟨p, k, hp, hk, hpk⟩ := (isPrimePow_nat_iff n).mp hprimepow
  have h3dvd : 3 ∣ n := dvd_of_one_le_padicValNat hv
  have h3p : 3 ∣ p := (by norm_num : Nat.Prime 3).dvd_of_dvd_pow
    (hpk ▸ h3dvd)
  have hp3 : p = 3 := ((Nat.prime_dvd_prime_iff_eq (by norm_num) hp).mp h3p).symm
  subst p
  refine ⟨k, hk, hpk.symm, ?_⟩
  rw [hpk.symm, padicValNat.prime_pow]

/-- Among von Mangoldt-supported indices, valuation one singles out
the generator three itself. -/
theorem weight_three_label_one {n : ℕ} (hw : weight n ≠ 0)
    (hv : padicValNat 3 n = 1) : n = 3 := by
  obtain ⟨k, _, hnk, hval⟩ := weight_three_power hw (by omega : 0 < padicValNat 3 n)
  have hk : k = 1 := by omega
  simpa [hk] using hnk

/-- If two nonzero von Mangoldt weights have three-adic labels differing
by one, the first index is three when the second has label zero.
Otherwise the pair is adjacent on the three-power ladder. -/
theorem weight_three_adjacent_rows {a b : ℕ}
    (ha : weight a ≠ 0) (hb : weight b ≠ 0)
    (hv : padicValNat 3 a = padicValNat 3 b + 1) :
    (padicValNat 3 b = 0 ∧ a = 3) ∨
      ∃ k : ℕ, 0 < k ∧ a = 3 ^ (k + 1) ∧ b = 3 ^ k := by
  by_cases hb0 : padicValNat 3 b = 0
  · left
    refine ⟨hb0, ?_⟩
    exact weight_three_label_one ha (by omega)
  · right
    obtain ⟨k, hk, hbk, hbkval⟩ := weight_three_power hb (by omega)
    obtain ⟨j, hj, haj, hajval⟩ := weight_three_power ha (by omega)
    have hjk : j = k + 1 := by omega
    exact ⟨k, hk, by simpa [hjk] using haj, hbk⟩

/-- On the complete even-total triangle, the zero-label row has an odd
partner below the terminal cutoff; every other surviving row is a
same-generator pair with total exactly `4 * 3 ^ k`. -/
theorem weight_three_adjacent_even_rows {a b N : ℕ}
    (ha : weight a ≠ 0) (hb : weight b ≠ 0)
    (hv : padicValNat 3 a = padicValNat 3 b + 1)
    (hpair : (a, b) ∈ evenPairDomain N) :
    (a = 3 ∧ Odd b ∧ b ≤ N - 3 ∧ padicValNat 3 b = 0) ∨
      ∃ k : ℕ, 0 < k ∧ a = 3 ^ (k + 1) ∧ b = 3 ^ k ∧
        4 * 3 ^ k ≤ N := by
  have htotal : a + b ≤ N := by
    have h := (Finset.mem_filter.mp hpair).1
    exact (Finset.mem_filter.mp h).2
  have heven : Even (a + b) := (Finset.mem_filter.mp hpair).2
  rcases weight_three_adjacent_rows ha hb hv with ⟨hb0, ha3⟩ | ⟨k, hk, hak, hbk⟩
  · left
    subst a
    refine ⟨rfl, ?_, by omega, hb0⟩
    rcases heven with ⟨j, hj⟩
    refine ⟨j - 2, ?_⟩
    omega
  · right
    refine ⟨k, hk, hak, hbk, ?_⟩
    rw [hak, hbk] at htotal
    have hpow : 3 ^ (k + 1) + 3 ^ k = 4 * 3 ^ k := by
      rw [pow_succ]
      omega
    omega

/-- The centered one-leg term at first angular frequency has only the
generator three on its Mangoldt leg. Even total forces an odd reference
partner and fixes the exact terminal range. -/
theorem weight_three_reference_row {a b N : ℕ}
    (ha : weight a ≠ 0)
    (hv : padicValNat 3 a = 1)
    (hpair : (a, b) ∈ evenPairDomain N) :
    a = 3 ∧ Odd b ∧ b ≤ N - 3 := by
  have ha3 := weight_three_label_one ha hv
  have htotal : a + b ≤ N := by
    have h := (Finset.mem_filter.mp hpair).1
    exact (Finset.mem_filter.mp h).2
  have heven : Even (a + b) := (Finset.mem_filter.mp hpair).2
  subst a
  refine ⟨rfl, ?_, by omega⟩
  rcases heven with ⟨j, hj⟩
  exact ⟨j - 2, by omega⟩

/-- Exponents on the same-generator ladder that occur in the odd prefix
but are too late to fit the even additive triangle. -/
def lateThreeLadder (N : ℕ) : Finset ℕ :=
  (Finset.range (N + 1)).filter
    (fun k => 0 < k ∧ N < 4 * 3 ^ k ∧ 3 ^ k ≤ N - 3)

/-- The finite cutoff loses no exponent from the mathematical correction
set: `k < 3 ^ k ≤ N - 3` already places every admissible `k` in the range. -/
theorem mem_lateThreeLadder_iff {N k : ℕ} :
    k ∈ lateThreeLadder N ↔
      0 < k ∧ N < 4 * 3 ^ k ∧ 3 ^ k ≤ N - 3 := by
  constructor
  · exact fun h => (Finset.mem_filter.mp h).2
  · intro h
    have hkpow : k < 3 ^ k := Nat.lt_pow_self (by omega : 1 < 3)
    have hkN : k < N + 1 := by omega
    exact Finset.mem_filter.mpr ⟨Finset.mem_range.mpr hkN, h⟩

private theorem lateThreeLadder_spread {N x y : ℕ}
    (hx : x ∈ lateThreeLadder N) (hy : y ∈ lateThreeLadder N) :
    x ≤ y + 1 ∧ y ≤ x + 1 := by
  have hx' := (Finset.mem_filter.mp hx).2
  have hy' := (Finset.mem_filter.mp hy).2
  constructor
  · by_contra h
    have hyx : y + 2 ≤ x := by omega
    have hpow : 3 ^ (y + 2) ≤ 3 ^ x :=
      Nat.pow_le_pow_right (by omega) hyx
    have hbase : 9 * 3 ^ y ≤ 3 ^ x := by
      calc
        9 * 3 ^ y = 3 ^ (y + 2) := by rw [pow_add]; ring
        _ ≤ _ := hpow
    omega
  · by_contra h
    have hxy : x + 2 ≤ y := by omega
    have hpow : 3 ^ (x + 2) ≤ 3 ^ y :=
      Nat.pow_le_pow_right (by omega) hxy
    have hbase : 9 * 3 ^ x ≤ 3 ^ y := by
      calc
        9 * 3 ^ x = 3 ^ (x + 2) := by rw [pow_add]; ring
        _ ≤ _ := hpow
    omega

/-- At most two adjacent powers of three lie in the correction interval
`(N/4, N-3]`; this is the bounded ladder term in the exact harmonic. -/
theorem lateThreeLadder_card_le_two (N : ℕ) :
    (lateThreeLadder N).card ≤ 2 := by
  by_contra h
  have hthree : 2 < (lateThreeLadder N).card := by omega
  obtain ⟨a, b, c, ha, hb, hc, hab, hac, hbc⟩ :=
    Finset.two_lt_card_iff.mp hthree
  have hab' := lateThreeLadder_spread ha hb
  have hac' := lateThreeLadder_spread ha hc
  have hbc' := lateThreeLadder_spread hb hc
  omega

/-- The algebraic first cosine coefficient of the finite centered
three-generator phase. The indicator terms are the Fourier coefficients
of `cos ((v₃(a)-v₃(b)) θ)` and `cos (v₃(a) θ)` respectively. -/
noncomputable def threeFirstHarmonic (N : ℕ) : ℝ :=
  ∑ q ∈ evenPairDomain N,
    (weight q.1 * weight q.2 *
        ((if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then 1 else 0) +
         (if padicValNat 3 q.2 = padicValNat 3 q.1 + 1 then 1 else 0)) -
      weight q.1 * oddReference q.2 *
        (if padicValNat 3 q.1 = 1 then 1 else 0) -
      oddReference q.1 * weight q.2 *
        (if padicValNat 3 q.2 = 1 then 1 else 0))

private theorem evenPairDomain_swap {N a b : ℕ} :
    (a, b) ∈ evenPairDomain N ↔ (b, a) ∈ evenPairDomain N := by
  simp [evenPairDomain, pairDomain, and_comm, add_comm]

private theorem sum_evenPair_swap (N : ℕ) (f : ℕ → ℕ → ℝ) :
    (∑ q ∈ evenPairDomain N, f q.2 q.1) =
      ∑ q ∈ evenPairDomain N, f q.1 q.2 := by
  apply Finset.sum_bij (fun q _ => (q.2, q.1))
  · intro q hq
    exact evenPairDomain_swap.mp hq
  · intro q₁ h₁ q₂ h₂ h
    simpa [Prod.swap] using congrArg Prod.swap h
  · intro q hq
    exact ⟨(q.2, q.1), evenPairDomain_swap.mpr hq, by cases q; rfl⟩
  · intro q hq
    rfl

/-- Ordered-pair symmetry doubles the unique orientation with a
one-step increase in the three-adic label. -/
theorem threeFirstHarmonic_oriented (N : ℕ) :
    threeFirstHarmonic N =
      2 * (Finset.sum (evenPairDomain N) (fun q =>
        (if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then
            weight q.1 * weight q.2 else 0) -
        (if padicValNat 3 q.1 = 1 then
            weight q.1 * oddReference q.2 else 0))) := by
  let P (a b : ℕ) : ℝ :=
    if padicValNat 3 a = padicValNat 3 b + 1 then
      weight a * weight b else 0
  let R (a b : ℕ) : ℝ :=
    if padicValNat 3 a = 1 then weight a * oddReference b else 0
  have hpair : threeFirstHarmonic N =
      Finset.sum (evenPairDomain N) (fun q =>
        (P q.1 q.2 + P q.2 q.1) - (R q.1 q.2 + R q.2 q.1)) := by
    unfold threeFirstHarmonic
    apply Finset.sum_congr rfl
    intro q hq
    dsimp [P, R]
    split_ifs <;> ring
  rw [hpair]
  simp_rw [Finset.sum_sub_distrib, Finset.sum_add_distrib]
  rw [sum_evenPair_swap N P, sum_evenPair_swap N R]
  dsimp [P, R]
  ring

#print axioms weight_three_power
#print axioms weight_three_label_one
#print axioms weight_three_adjacent_rows
#print axioms weight_three_adjacent_even_rows
#print axioms weight_three_reference_row
#print axioms lateThreeLadder_card_le_two
#print axioms mem_lateThreeLadder_iff
#print axioms threeFirstHarmonic_oriented

end BuildingBlocks.GoldbachThreePhaseHarmonicFinite
