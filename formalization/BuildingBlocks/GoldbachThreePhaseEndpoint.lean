import BuildingBlocks.GoldbachThreePhaseHarmonicFinite
import BuildingBlocks.Bridge
import BuildingBlocks.GoldbachOddCentering

/-!
# Exact endpoint in the even three-generator Goldbach harmonic

The one-leg reference row is evaluated on the complete ordered even-total
triangle, including the terminal total.  This is the finite endpoint term in
the written reconstruction of the complete Chebyshev error.
-/

namespace BuildingBlocks.GoldbachThreePhaseEndpoint

open Finset
open BuildingBlocks.GoldbachPrimePhaseCutFinite
open BuildingBlocks.GoldbachEvenPhaseCenterFinite
open BuildingBlocks.GoldbachThreePhaseHarmonicFinite

private instance : Fact (Nat.Prime 3) := ⟨by norm_num⟩

private theorem even_pair_sum (N : ℕ) (f : ℕ → ℕ → ℝ) :
    (∑ q ∈ evenPairDomain N, f q.1 q.2) =
      ∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 N,
        if a + b ≤ N ∧ Even (a + b) then f a b else 0 := by
  simp [evenPairDomain, pairDomain, Finset.sum_filter, Finset.sum_product, ite_and]

private theorem one_leg_term (a b : ℕ) :
    (if padicValNat 3 a = 1 then weight a * oddReference b else 0) =
      if a = 3 then Real.log 3 * oddReference b else 0 := by
  by_cases ha : a = 3
  · subst a
    have hv : padicValNat 3 3 = 1 := by
      simp
    have hw : weight 3 = Real.log 3 := by
      simp [weight, ArithmeticFunction.vonMangoldt_apply_prime (by norm_num : Nat.Prime 3)]
    simp [hw]
  · by_cases hv : padicValNat 3 a = 1
    · have hw : weight a = 0 := by
        by_contra hn
        exact ha (BuildingBlocks.GoldbachThreePhaseHarmonicFinite.weight_three_label_one hn hv)
      simp [ha, hw]
    · simp [ha, hv]

private theorem one_leg_sum_single (N : ℕ) (hN : 3 ≤ N) :
    (∑ q ∈ evenPairDomain N,
      if padicValNat 3 q.1 = 1 then weight q.1 * oddReference q.2 else 0) =
      ∑ b ∈ Icc 1 N,
        if 3 + b ≤ N ∧ Even (3 + b) then
          Real.log 3 * oddReference b else 0 := by
  calc
    _ = ∑ q ∈ evenPairDomain N,
        (if q.1 = 3 then Real.log 3 * oddReference q.2 else 0) := by
          apply Finset.sum_congr rfl
          intro q _
          exact one_leg_term q.1 q.2
    _ = ∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 N,
          if a + b ≤ N ∧ Even (a + b) then
            (if a = 3 then Real.log 3 * oddReference b else 0) else 0 :=
      by simpa using
        (even_pair_sum N (fun a b => if a = 3 then Real.log 3 * oddReference b else 0))
    _ = ∑ a ∈ Icc 1 N,
          if a = 3 then
            ∑ b ∈ Icc 1 N,
              if 3 + b ≤ N ∧ Even (3 + b) then
                Real.log 3 * oddReference b else 0
          else 0 := by
      apply Finset.sum_congr rfl
      intro a _
      by_cases ha : a = 3 <;> simp [ha]
    _ = _ := by
      rw [Finset.sum_ite_eq']
      simp [hN]

/-- The actual Mangoldt one-leg term at the first three-adic harmonic has
the exact odd-lattice endpoint `N - 2`, with no omitted terminal pair. -/
theorem one_leg_reference_exact (k : ℕ) :
    (∑ q ∈ evenPairDomain (2 * k + 6),
      if padicValNat 3 q.1 = 1 then weight q.1 * oddReference q.2 else 0) =
      Real.log 3 * (2 * k + 4 : ℝ) := by
  rw [one_leg_sum_single (2 * k + 6) (by omega)]
  have hset :
      (Icc 1 (2 * k + 6)).filter
          (fun b => 3 + b ≤ 2 * k + 6 ∧ Even (3 + b)) =
        (range (2 * k + 4)).filter Odd := by
    ext b
    simp only [mem_filter, mem_Icc, mem_range]
    constructor
    · rintro ⟨⟨hb1, hbN⟩, hsum, heven⟩
      rcases heven with ⟨j, hj⟩
      refine ⟨by omega, ⟨j - 2, by omega⟩⟩
    · rintro ⟨hrange, hodd⟩
      rcases hodd with ⟨j, hj⟩
      refine ⟨⟨by omega, by omega⟩, by omega, ⟨j + 2, by omega⟩⟩
  calc
    (∑ b ∈ Icc 1 (2 * k + 6),
        if 3 + b ≤ 2 * k + 6 ∧ Even (3 + b) then
          Real.log 3 * oddReference b else 0) =
        ∑ b ∈ (Icc 1 (2 * k + 6)).filter
          (fun b => 3 + b ≤ 2 * k + 6 ∧ Even (3 + b)),
          Real.log 3 * oddReference b := by rw [sum_filter]
    _ = ∑ b ∈ (range (2 * k + 4)).filter Odd,
          Real.log 3 * oddReference b := by rw [hset]
    _ = ∑ b ∈ range (2 * k + 4), Real.log 3 * oddReference b := by
      rw [sum_filter]
      apply sum_congr rfl
      intro b _
      by_cases hb : Odd b <;> simp [hb, oddReference]
    _ = Real.log 3 * (2 * k + 4 : ℝ) := by
      rw [← mul_sum, oddReference_three_partner_prefix]

/-- The only nonzero Mangoldt weight with three-adic valuation `j + 1`
is the power `3 ^ (j + 1)`, and its weight is `log 3`. -/
theorem weight_label_as_power (a j : ℕ) :
    (if padicValNat 3 a = j + 1 then weight a else 0) =
      if a = 3 ^ (j + 1) then Real.log 3 else 0 := by
  by_cases ha : a = 3 ^ (j + 1)
  · subst a
    have hv : padicValNat 3 (3 ^ (j + 1)) = j + 1 :=
      by simp [padicValNat.prime_pow]
    have hw : weight (3 ^ (j + 1)) = Real.log 3 := by
      rw [weight, ArithmeticFunction.vonMangoldt_apply_pow (by omega),
        ArithmeticFunction.vonMangoldt_apply_prime (by norm_num : Nat.Prime 3)]
      norm_num
    simp [hv, hw]
  · by_cases hv : padicValNat 3 a = j + 1
    · have hw : weight a = 0 := by
        by_contra hn
        obtain ⟨l, hl, hal, hval⟩ :=
          BuildingBlocks.GoldbachThreePhaseHarmonicFinite.weight_three_power hn
            (by omega : 0 < padicValNat 3 a)
        have hlj : l = j + 1 := by omega
        exact ha (by simpa [hlj] using hal)
      simp [ha, hv, hw]
    · simp [ha, hv]

/-- The full oriented two-leg harmonic is a single sum over the second
arrival. The unique first arrival is `3 ^ (v₃(b)+1)` whenever its
Mangoldt weight is nonzero. All additive endpoints and prime powers are
still present in the domain test. -/
theorem two_leg_unique_partner (N : ℕ) :
    (∑ q ∈ evenPairDomain N,
      if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then
        weight q.1 * weight q.2 else 0) =
      Real.log 3 *
        ∑ b ∈ Icc 1 N,
          if 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
              Even (3 ^ (padicValNat 3 b + 1) + b) then
            weight b else 0 := by
  have hterm (a b : ℕ) :
      (if padicValNat 3 a = padicValNat 3 b + 1 then
        weight a * weight b else 0) =
        (if a = 3 ^ (padicValNat 3 b + 1) then
          Real.log 3 * weight b else 0) := by
    calc
      _ = (if padicValNat 3 a = padicValNat 3 b + 1 then weight a else 0) *
          weight b := by split_ifs <;> ring
      _ = (if a = 3 ^ (padicValNat 3 b + 1) then Real.log 3 else 0) *
          weight b := by rw [weight_label_as_power]
      _ = _ := by split_ifs <;> ring
  calc
    (∑ q ∈ evenPairDomain N,
      if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then
        weight q.1 * weight q.2 else 0) =
      ∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 N,
        if a + b ≤ N ∧ Even (a + b) then
          (if padicValNat 3 a = padicValNat 3 b + 1 then
            weight a * weight b else 0) else 0 := by
      simpa using (even_pair_sum N (fun a b =>
        if padicValNat 3 a = padicValNat 3 b + 1 then
          weight a * weight b else 0))
    _ = ∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 N,
        if a + b ≤ N ∧ Even (a + b) then
          (if a = 3 ^ (padicValNat 3 b + 1) then
            Real.log 3 * weight b else 0) else 0 := by
      apply sum_congr rfl
      intro a _
      apply sum_congr rfl
      intro b _
      rw [hterm]
    _ =
      ∑ b ∈ Icc 1 N, ∑ a ∈ Icc 1 N,
        if a + b ≤ N ∧ Even (a + b) then
          (if a = 3 ^ (padicValNat 3 b + 1) then
            Real.log 3 * weight b else 0) else 0 := by
      rw [Finset.sum_comm]
    _ = ∑ b ∈ Icc 1 N,
        if 3 ^ (padicValNat 3 b + 1) ∈ Icc 1 N then
          if 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
              Even (3 ^ (padicValNat 3 b + 1) + b) then
            Real.log 3 * weight b else 0
        else 0 := by
      apply sum_congr rfl
      intro b _
      have hcollapse :
          (∑ a ∈ Icc 1 N,
            if a + b ≤ N ∧ Even (a + b) then
              (if a = 3 ^ (padicValNat 3 b + 1) then
                Real.log 3 * weight b else 0) else 0) =
            ∑ a ∈ Icc 1 N,
              if a = 3 ^ (padicValNat 3 b + 1) then
                (if a + b ≤ N ∧ Even (a + b) then
                  Real.log 3 * weight b else 0) else 0 := by
        apply sum_congr rfl
        intro a _
        split_ifs <;> simp_all
      rw [hcollapse, sum_ite_eq']
    _ = Real.log 3 *
          ∑ b ∈ Icc 1 N,
            if 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
                Even (3 ^ (padicValNat 3 b + 1) + b) then
              weight b else 0 := by
      rw [mul_sum]
      apply sum_congr rfl
      intro b _
      by_cases hc : 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
          Even (3 ^ (padicValNat 3 b + 1) + b)
      · have hm : 3 ^ (padicValNat 3 b + 1) ∈ Icc 1 N := by
          simp only [mem_Icc]
          have hp : 0 < 3 ^ (padicValNat 3 b + 1) := pow_pos (by omega) _
          exact ⟨by omega, by omega⟩
        simp [hm, hc]
      · simp [hc]

noncomputable def lateThreeBases (N : ℕ) : Finset ℕ :=
  (Icc 1 (N - 3)).filter
    (fun b => weight b ≠ 0 ∧ 0 < padicValNat 3 b ∧ N < 4 * b)

theorem lateThreeBases_eq_image (N : ℕ) :
    lateThreeBases N = (lateThreeLadder N).image (fun k => 3 ^ k) := by
  ext b
  simp only [lateThreeBases, mem_filter, mem_Icc, mem_image]
  constructor
  · rintro ⟨⟨hb1, hbN⟩, hw, hv, hlate⟩
    obtain ⟨k, hk, hbk, hval⟩ := weight_three_power hw hv
    refine ⟨k, ?_, hbk.symm⟩
    apply mem_lateThreeLadder_iff.mpr
    exact ⟨hk, by simpa [hbk] using hlate, by simpa [hbk] using hbN⟩
  · rintro ⟨k, hk, rfl⟩
    obtain ⟨hkpos, hlate, hprefix⟩ := mem_lateThreeLadder_iff.mp hk
    have hw : weight (3 ^ k) ≠ 0 := by
      rw [weight, ArithmeticFunction.vonMangoldt_apply_pow (by omega),
        ArithmeticFunction.vonMangoldt_apply_prime (by norm_num : Nat.Prime 3)]
      norm_num
    have hv : padicValNat 3 (3 ^ k) = k := by simp [padicValNat.prime_pow]
    have hpow : 0 < 3 ^ k := pow_pos (by omega) _
    exact ⟨⟨by omega, hprefix⟩, hw, by omega, hlate⟩

theorem lateThreeBases_card_eq_ladder (N : ℕ) :
    (lateThreeBases N).card = (lateThreeLadder N).card := by
  rw [lateThreeBases_eq_image]
  exact Finset.card_image_of_injective _
    (Nat.pow_right_injective (by omega : 1 < 3))

private theorem three_plus_even_iff_odd (b : ℕ) :
    Even (3 + b) ↔ Odd b := by
  constructor
  · rintro ⟨j, hj⟩
    exact ⟨j - 2, by omega⟩
  · rintro ⟨j, hj⟩
    exact ⟨j + 2, by omega⟩

private theorem active_iff_prefix_not_late {N b : ℕ}
    (hN : 3 ≤ N) (hb : b ∈ Icc 1 N) (hw : weight b ≠ 0) :
    (3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
       Even (3 ^ (padicValNat 3 b + 1) + b)) ↔
      (Odd b ∧ b ≤ N - 3) ∧ b ∉ lateThreeBases N := by
  by_cases hv : padicValNat 3 b = 0
  · have hlate : b ∉ lateThreeBases N := by
      simp [lateThreeBases, hv]
    simp only [hv, zero_add, pow_one, hlate, not_false_eq_true, and_true]
    constructor
    · rintro ⟨hbound, heven⟩
      exact ⟨(three_plus_even_iff_odd b).mp heven, by omega⟩
    · rintro ⟨hodd, hbound⟩
      exact ⟨by omega, (three_plus_even_iff_odd b).mpr hodd⟩
  · have hvpos : 0 < padicValNat 3 b := by omega
    obtain ⟨k, hk, hbk, hval⟩ := weight_three_power hw hvpos
    subst b
    have hsum : 3 ^ (k + 1) + 3 ^ k = 4 * 3 ^ k := by
      rw [pow_succ]
      omega
    have hodd : Odd (3 ^ k) := (show Odd (3 : ℕ) by norm_num).pow
    have heven : Even (4 * 3 ^ k) := by
      exact ⟨2 * 3 ^ k, by omega⟩
    have hlate : 3 ^ k ∈ lateThreeBases N ↔
        3 ^ k ≤ N - 3 ∧ N < 4 * 3 ^ k := by
      have hmem : 1 ≤ 3 ^ k := by
        have hp : 0 < 3 ^ k := pow_pos (by omega) _
        omega
      have hwk : weight (3 ^ k) ≠ 0 := hw
      simp [lateThreeBases, hmem, hwk, hval, hk]
    simp only [hval, hsum]
    constructor
    · rintro ⟨hbound, _⟩
      refine ⟨⟨hodd, by omega⟩, ?_⟩
      intro hl
      have hbad := (hlate.mp hl).2
      omega
    · rintro ⟨⟨_, hprefix⟩, hnlate⟩
      have hbound : 4 * 3 ^ k ≤ N := by
        by_contra h
        have hl : 3 ^ k ∈ lateThreeBases N :=
          hlate.mpr ⟨hprefix, by omega⟩
        exact hnlate hl
      exact ⟨hbound, heven⟩

private theorem two_leg_atom {N b : ℕ}
    (hN : 3 ≤ N) (hb : b ∈ Icc 1 N) :
    (if 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
        Even (3 ^ (padicValNat 3 b + 1) + b) then
        weight b else 0) =
      (if Odd b ∧ b ≤ N - 3 then weight b else 0) -
        (if b ∈ lateThreeBases N then weight b else 0) := by
  by_cases hw : weight b = 0
  · simp [hw]
  · have hiff := active_iff_prefix_not_late hN hb hw
    have hlate_prefix : b ∈ lateThreeBases N → Odd b ∧ b ≤ N - 3 := by
      intro hl
      change b ∈ (Icc 1 (N - 3)).filter
        (fun b => weight b ≠ 0 ∧ 0 < padicValNat 3 b ∧ N < 4 * b) at hl
      obtain ⟨hbset, ⟨hweight, hval, _⟩⟩ := Finset.mem_filter.mp hl
      have hbound := (Finset.mem_Icc.mp hbset).2
      obtain ⟨k, hk, hbk, _⟩ := weight_three_power hweight hval
      refine ⟨?_, hbound⟩
      rw [hbk]
      exact (show Odd (3 : ℕ) by norm_num).pow
    by_cases hp : Odd b ∧ b ≤ N - 3
    · by_cases hl : b ∈ lateThreeBases N
      · have hn : ¬(3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
            Even (3 ^ (padicValNat 3 b + 1) + b)) := by
          intro h
          exact (hiff.mp h).2 hl
        simp [hp, hl, hn]
      · have ha : 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
            Even (3 ^ (padicValNat 3 b + 1) + b) := hiff.mpr ⟨hp, hl⟩
        simp [hp, hl, ha]
    · have hl : b ∉ lateThreeBases N := by
        intro h
        exact hp (hlate_prefix h)
      have hn : ¬(3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
            Even (3 ^ (padicValNat 3 b + 1) + b)) := by
        intro h
        exact hp (hiff.mp h).1
      simp [hp, hl, hn]

noncomputable def oddWeightPrefix (Y : ℕ) : ℝ :=
  ∑ b ∈ Icc 1 Y, if Odd b then weight b else 0

noncomputable def twoPowerPrefix (Y : ℕ) : ℝ :=
  ∑ b ∈ Icc 1 Y, if Even b then weight b else 0

private theorem lateThreeBases_subset_domain (N : ℕ) :
    lateThreeBases N ⊆ Icc 1 N := by
  intro b hb
  have h := (Finset.mem_filter.mp hb).1
  have hbnd := Finset.mem_Icc.mp h
  exact Finset.mem_Icc.mpr ⟨hbnd.1, by omega⟩

/-- The two-leg term is the complete odd prime-power prefix, minus only
the late same-generator ladder. The powers of two are accounted for in
`twoPowerPrefix` below. -/
theorem two_leg_exact_odd_prefix (k : ℕ) :
    (∑ q ∈ evenPairDomain (2 * k + 6),
      if padicValNat 3 q.1 = padicValNat 3 q.2 + 1 then
        weight q.1 * weight q.2 else 0) =
      Real.log 3 *
        (oddWeightPrefix (2 * k + 3) -
          Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)) := by
  let N := 2 * k + 6
  have hN : 3 ≤ N := by dsimp [N]; omega
  have hcut : N - 3 = 2 * k + 3 := by dsimp [N]; omega
  rw [show 2 * k + 6 = N by rfl, two_leg_unique_partner]
  have hsum :
      (∑ b ∈ Icc 1 N,
        if 3 ^ (padicValNat 3 b + 1) + b ≤ N ∧
            Even (3 ^ (padicValNat 3 b + 1) + b) then weight b else 0) =
        (∑ b ∈ Icc 1 N, if Odd b ∧ b ≤ N - 3 then weight b else 0) -
          (∑ b ∈ Icc 1 N, if b ∈ lateThreeBases N then weight b else 0) := by
    rw [← sum_sub_distrib]
    apply sum_congr rfl
    intro b hb
    exact two_leg_atom hN hb
  rw [hsum]
  have hoddset :
      (Icc 1 N).filter (fun b => Odd b ∧ b ≤ N - 3) =
        (Icc 1 (N - 3)).filter Odd := by
    ext b
    simp only [mem_filter, mem_Icc]
    constructor <;> intro h <;> rcases h with ⟨⟨hb1, hb2⟩, hodd⟩
    · exact ⟨⟨hb1, hodd.2⟩, hodd.1⟩
    · exact ⟨⟨hb1, by omega⟩, hodd, hb2⟩
  have hodd :
      (∑ b ∈ Icc 1 N, if Odd b ∧ b ≤ N - 3 then weight b else 0) =
        oddWeightPrefix (N - 3) := by
    rw [← sum_filter, hoddset]
    simp [oddWeightPrefix, sum_filter]
  have hlate_set :
      (Icc 1 N).filter (fun b => b ∈ lateThreeBases N) = lateThreeBases N := by
    ext b
    simp only [mem_filter]
    constructor
    · exact fun h => h.2
    · exact fun h => ⟨lateThreeBases_subset_domain N h, h⟩
  have hlate :
      (∑ b ∈ Icc 1 N, if b ∈ lateThreeBases N then weight b else 0) =
        Real.log 3 * ((lateThreeLadder N).card : ℝ) := by
    rw [← sum_filter, hlate_set]
    have hw : ∀ b ∈ lateThreeBases N, weight b = Real.log 3 := by
      intro b hb
      have hbdata := (Finset.mem_filter.mp hb).2
      obtain ⟨j, hj, hbj, _⟩ := weight_three_power hbdata.1 hbdata.2.1
      rw [hbj, weight, ArithmeticFunction.vonMangoldt_apply_pow (by omega),
        ArithmeticFunction.vonMangoldt_apply_prime (by norm_num : Nat.Prime 3)]
      norm_num
    calc
      (∑ b ∈ lateThreeBases N, weight b) =
          ∑ _b ∈ lateThreeBases N, Real.log 3 := by
        apply sum_congr rfl
        intro b hb
        exact hw b hb
      _ = Real.log 3 * ((lateThreeLadder N).card : ℝ) := by
        simp [lateThreeBases_card_eq_ladder, mul_comm]
  rw [hodd, hlate, hcut]

theorem psi_eq_odd_add_two_prefix (Y : ℕ) :
    BuildingBlocks.psi Y = oddWeightPrefix Y + twoPowerPrefix Y := by
  have hset : range (Y + 1) = insert 0 (Icc 1 Y) := by
    ext n
    simp only [mem_range, mem_insert, mem_Icc]
    omega
  calc
    BuildingBlocks.psi Y = ∑ b ∈ Icc 1 Y, weight b := by
      rw [BuildingBlocks.psi, hset, sum_insert (by simp)]
      simp [weight]
    _ = ∑ b ∈ Icc 1 Y,
          ((if Odd b then weight b else 0) +
            (if Even b then weight b else 0)) := by
      apply sum_congr rfl
      intro b _
      rcases Nat.even_or_odd b with he | ho
      · have hno : ¬Odd b := Nat.not_odd_iff_even.mpr he
        simp [he, hno]
      · have hne : ¬Even b := Nat.not_even_iff_odd.mpr ho
        simp [ho, hne]
    _ = oddWeightPrefix Y + twoPowerPrefix Y := by
      rw [sum_add_distrib]
      rfl

private noncomputable def twoPowerSupport (Y : ℕ) : Finset ℕ :=
  (Icc 1 Y).filter (fun b => Even b ∧ weight b ≠ 0)

private theorem twoPowerSupport_eq_image (Y : ℕ) :
    twoPowerSupport Y = (Icc 1 (Nat.log 2 Y)).image (fun j => 2 ^ j) := by
  ext b
  simp only [twoPowerSupport, mem_filter, mem_Icc, mem_image]
  constructor
  · rintro ⟨⟨hb1, hbY⟩, heven, hw⟩
    obtain ⟨j, hj, hbj, _⟩ :=
      BuildingBlocks.GoldbachOddCentering.even_nonzero_vonMangoldt
        heven hw
    refine ⟨j, ⟨hj, ?_⟩, hbj.symm⟩
    exact Nat.le_log_of_pow_le (by omega) (hbj ▸ hbY)
  · rintro ⟨j, ⟨hj, hjlog⟩, rfl⟩
    have hY : Y ≠ 0 := by
      intro h
      subst Y
      simp at hjlog
      omega
    have hpow : 2 ^ j ≤ Y := (Nat.le_log_iff_pow_le (by omega) hY).1 hjlog
    have hpos : 1 ≤ 2 ^ j := by
      have hp : 0 < 2 ^ j := pow_pos (by omega) _
      omega
    have heven : Even (2 ^ j) := even_two.pow_of_ne_zero (by omega)
    have hw : weight (2 ^ j) ≠ 0 := by
      change ArithmeticFunction.vonMangoldt (2 ^ j) ≠ 0
      exact (BuildingBlocks.GoldbachOddCentering.even_vonMangoldt_support heven).2
        ⟨j, hj, rfl⟩
    exact ⟨⟨hpos, hpow⟩, heven, hw⟩

/-- The even Mangoldt prefix is exactly the contribution of every power
of two up to the cutoff, each with weight `log 2`. -/
theorem twoPowerPrefix_eq_power_count (Y : ℕ) :
    twoPowerPrefix Y = Real.log 2 * (Nat.log 2 Y : ℝ) := by
  have hsupport : twoPowerPrefix Y = ∑ b ∈ twoPowerSupport Y, weight b := by
    rw [twoPowerPrefix, twoPowerSupport, sum_filter]
    apply sum_congr rfl
    intro b _
    by_cases he : Even b
    · by_cases hw : weight b = 0 <;> simp [he, hw]
    · simp [he]
  rw [hsupport, twoPowerSupport_eq_image]
  rw [Finset.sum_image (fun _ _ _ _ h => Nat.pow_right_injective (by omega) h)]
  have hterm : ∀ j ∈ Icc 1 (Nat.log 2 Y), weight (2 ^ j) = Real.log 2 := by
    intro j hj
    have hjpos : j ≠ 0 := by
      have := (Finset.mem_Icc.mp hj).1
      omega
    rw [weight, ArithmeticFunction.vonMangoldt_apply_pow hjpos,
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    norm_num
  calc
    (∑ j ∈ Icc 1 (Nat.log 2 Y), weight (2 ^ j)) =
      ∑ _j ∈ Icc 1 (Nat.log 2 Y), Real.log 2 := by
        apply sum_congr rfl
        intro j hj
        exact hterm j hj
    _ = Real.log 2 * (Nat.log 2 Y : ℝ) := by simp [mul_comm]

/-- The algebraic first harmonic of the full even Goldbach triangle is
exactly the complete prime error, with the powers of two, one-lattice
endpoint, and bounded same-generator ladder retained. -/
theorem three_first_harmonic_exact (k : ℕ) :
    threeFirstHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) -
          (2 * k + 3 : ℝ) - twoPowerPrefix (2 * k + 3) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)) := by
  rw [threeFirstHarmonic_oriented, sum_sub_distrib]
  have htwo := two_leg_exact_odd_prefix k
  have hone := one_leg_reference_exact k
  have hpsi := psi_eq_odd_add_two_prefix (2 * k + 3)
  rw [htwo, hone]
  rw [hpsi]
  ring

/-- Equation (5) of the written note, now with the even-prime-power
correction evaluated as `log 2` times the exact count of powers of two. -/
theorem three_first_harmonic_prime_error (k : ℕ) :
    threeFirstHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)) := by
  rw [three_first_harmonic_exact, twoPowerPrefix_eq_power_count]

#print axioms one_leg_reference_exact
#print axioms weight_label_as_power
#print axioms two_leg_unique_partner
#print axioms two_leg_exact_odd_prefix
#print axioms psi_eq_odd_add_two_prefix
#print axioms twoPowerPrefix_eq_power_count
#print axioms three_first_harmonic_exact
#print axioms three_first_harmonic_prime_error

end BuildingBlocks.GoldbachThreePhaseEndpoint
