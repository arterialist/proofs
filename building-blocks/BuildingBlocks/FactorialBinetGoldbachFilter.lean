import BuildingBlocks.FactorialBinetGoldbachFinite

/-!
# Finite prime and Goldbach filters for the complete cofactor source

The abstract hypotheses are discharged by the written Binet residual bounds.
Every source coefficient still includes all divisor histories and prime powers.
-/

namespace BuildingBlocks.FactorialBinetGoldbachFilter

open Finset
open scoped BigOperators
open BuildingBlocks.FactorialBinetGoldbachFinite

noncomputable section

/-- The normalized complete-history prime state, defined at every integer. -/
def state (v : ℕ → ℝ) (n : ℕ) : ℝ :=
  primeSource v n / (v 1 * Real.log (n : ℝ))

theorem state_nonneg (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    {n : ℕ} (hn : 2 ≤ n) : 0 ≤ state v n := by
  have hn1 : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast (by omega : 1 ≤ n)
  exact div_nonneg (primeSource_nonneg v hv n)
    (mul_nonneg (hv 1) (Real.log_nonneg hn1))

theorem state_prime (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv1 : 0 < v 1)
    {p : ℕ} (hp : p.Prime) : state v p = 1 := by
  have hlog : 0 < Real.log (p : ℝ) :=
    Real.log_pos (by exact_mod_cast hp.one_lt)
  rw [state, primeSource_prime_eq_direct v hv hv2 hp]
  exact div_self (ne_of_gt (mul_pos hv1 hlog))

theorem state_composite_le (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1) (hv1 : 0 < v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    state v n ≤ (47 / 80 : ℝ) := by
  have hlog : 0 < Real.log (n : ℝ) :=
    Real.log_pos (by exact_mod_cast (by omega : 1 < n))
  have hden : 0 < v 1 * Real.log (n : ℝ) := mul_pos hv1 hlog
  apply (div_le_iff₀ hden).2
  simpa only [mul_assoc] using
    (primeSource_composite_le_rational v hv2 hv12 hratio hn hnp)

theorem state_le_one (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1) (hv1 : 0 < v 1)
    {n : ℕ} (hn : 2 ≤ n) : state v n ≤ 1 := by
  by_cases hp : n.Prime
  · rw [state_prime v hv hv2 hv1 hp]
  · exact (state_composite_le v hv2 hv12 hratio hv1 hn hp).trans (by norm_num)

/-- The exact ordered prime count on `[2,N]`. -/
def primeCount (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 2 N, if n.Prime then (1 : ℝ) else 0

/-- Powers of the full-history state approximate the exact prime count
with a uniform rational error at every finite horizon. -/
theorem prime_filter_bound (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1) (hv1 : 0 < v 1)
    (N h : ℕ) :
    0 ≤ (∑ n ∈ Icc 2 N, state v n ^ h) - primeCount N ∧
      (∑ n ∈ Icc 2 N, state v n ^ h) - primeCount N ≤
        (N - 1 : ℕ) * (47 / 80 : ℝ) ^ h := by
  have hterm (n : ℕ) (hn : n ∈ Icc 2 N) :
      0 ≤ state v n ^ h - (if n.Prime then (1 : ℝ) else 0) ∧
        state v n ^ h - (if n.Prime then (1 : ℝ) else 0) ≤
          (47 / 80 : ℝ) ^ h := by
    have hn2 : 2 ≤ n := (mem_Icc.mp hn).1
    by_cases hp : n.Prime
    · simp only [hp, ↓reduceIte, state_prime v hv hv2 hv1 hp, one_pow, sub_self]
      exact ⟨le_refl _, pow_nonneg (by norm_num) _⟩
    · have hnonneg := state_nonneg v hv hn2
      have hwall := state_composite_le v hv2 hv12 hratio hv1 hn2 hp
      have hpow : state v n ^ h ≤ (47 / 80 : ℝ) ^ h := by gcongr
      simp only [hp, ↓reduceIte, sub_zero]
      exact ⟨pow_nonneg hnonneg _, hpow⟩
  have hsum :
      0 ≤ ∑ n ∈ Icc 2 N,
        (state v n ^ h - if n.Prime then (1 : ℝ) else 0) ∧
      (∑ n ∈ Icc 2 N,
        (state v n ^ h - if n.Prime then (1 : ℝ) else 0)) ≤
          (Icc 2 N).card * (47 / 80 : ℝ) ^ h := by
    constructor
    · apply sum_nonneg
      intro n hn
      exact (hterm n hn).1
    · calc
        (∑ n ∈ Icc 2 N,
          (state v n ^ h - if n.Prime then (1 : ℝ) else 0)) ≤
            ∑ _n ∈ Icc 2 N, (47 / 80 : ℝ) ^ h := by
              apply sum_le_sum
              intro n hn
              exact (hterm n hn).2
        _ = (Icc 2 N).card * (47 / 80 : ℝ) ^ h := by simp
  simp only [sum_sub_distrib, primeCount] at hsum ⊢
  simpa only [Nat.card_Icc, Nat.cast_sub, Nat.cast_add, Nat.cast_one] using hsum

/-- A full ordered additive packet, with both addends at least two. -/
def pairPacket (v : ℕ → ℝ) (k h : ℕ) : ℝ :=
  ∑ a ∈ Icc 2 (k - 2), state v a ^ h * state v (k - a) ^ h

/-- The exact number of ordered ordinary-prime pairs summing to `k`. -/
def goldbachCount (k : ℕ) : ℝ :=
  ∑ a ∈ Icc 2 (k - 2),
    if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0

/-- The full-history packet approximates the exact ordered Goldbach
count, with every endpoint accounted for. -/
theorem goldbach_filter_bound (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1) (hv1 : 0 < v 1)
    {k : ℕ} (hk : 4 ≤ k) (h : ℕ) :
    0 ≤ pairPacket v k h - goldbachCount k ∧
      pairPacket v k h - goldbachCount k ≤
        (k - 3 : ℕ) * (47 / 80 : ℝ) ^ h := by
  have hterm (a : ℕ) (ha : a ∈ Icc 2 (k - 2)) :
      0 ≤ state v a ^ h * state v (k - a) ^ h -
        (if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0) ∧
      state v a ^ h * state v (k - a) ^ h -
        (if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0) ≤
          (47 / 80 : ℝ) ^ h := by
    have ha2 : 2 ≤ a := (mem_Icc.mp ha).1
    have haub : a ≤ k - 2 := (mem_Icc.mp ha).2
    have hb2 : 2 ≤ k - a := by omega
    have ha0 := state_nonneg v hv ha2
    have hb0 := state_nonneg v hv hb2
    have ha1 := state_le_one v hv hv2 hv12 hratio hv1 ha2
    have hb1 := state_le_one v hv hv2 hv12 hratio hv1 hb2
    by_cases hpa : a.Prime
    · by_cases hpb : (k - a).Prime
      · simp only [hpa, hpb, and_self, ↓reduceIte,
          state_prime v hv hv2 hv1 hpa,
          state_prime v hv hv2 hv1 hpb, one_pow, one_mul, sub_self]
        exact ⟨le_refl _, pow_nonneg (by norm_num) _⟩
      · have hwall := state_composite_le v hv2 hv12 hratio hv1 hb2 hpb
        have hpow : state v (k - a) ^ h ≤ (47 / 80 : ℝ) ^ h := by gcongr
        simp [hpa, hpb, state_prime v hv hv2 hv1 hpa]
        exact ⟨pow_nonneg hb0 _, hpow⟩
    · have hwall := state_composite_le v hv2 hv12 hratio hv1 ha2 hpa
      have hpow : state v a ^ h ≤ (47 / 80 : ℝ) ^ h := by gcongr
      have hpowb : state v (k - a) ^ h ≤ (1 : ℝ) := by
        simpa using (pow_le_pow_left₀ hb0 hb1 h)
      have hmul : state v a ^ h * state v (k - a) ^ h ≤
          (47 / 80 : ℝ) ^ h := by
        calc
          state v a ^ h * state v (k - a) ^ h ≤
            (47 / 80 : ℝ) ^ h * state v (k - a) ^ h :=
              mul_le_mul_of_nonneg_right hpow (pow_nonneg hb0 _)
          _ ≤ (47 / 80 : ℝ) ^ h * 1 :=
              mul_le_mul_of_nonneg_left hpowb (pow_nonneg (by norm_num) _)
          _ = _ := by ring
      simp only [hpa, false_and, ↓reduceIte, sub_zero]
      exact ⟨mul_nonneg (pow_nonneg ha0 _) (pow_nonneg hb0 _), hmul⟩
  have hsum :
      0 ≤ ∑ a ∈ Icc 2 (k - 2),
        (state v a ^ h * state v (k - a) ^ h -
          if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0) ∧
      (∑ a ∈ Icc 2 (k - 2),
        (state v a ^ h * state v (k - a) ^ h -
          if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0)) ≤
          (Icc 2 (k - 2)).card * (47 / 80 : ℝ) ^ h := by
    constructor
    · apply sum_nonneg
      intro a ha
      exact (hterm a ha).1
    · calc
        (∑ a ∈ Icc 2 (k - 2),
          (state v a ^ h * state v (k - a) ^ h -
            if a.Prime ∧ (k - a).Prime then (1 : ℝ) else 0)) ≤
          ∑ _a ∈ Icc 2 (k - 2), (47 / 80 : ℝ) ^ h := by
            apply sum_le_sum
            intro a ha
            exact (hterm a ha).2
        _ = (Icc 2 (k - 2)).card * (47 / 80 : ℝ) ^ h := by simp
  simp only [sum_sub_distrib, pairPacket, goldbachCount] at hsum ⊢
  have hcard : (Icc 2 (k - 2)).card = k - 3 := by
    rw [Nat.card_Icc]
    omega
  simpa only [hcard] using hsum

/-- A strict finite packet surplus certifies an ordinary ordered
Goldbach representation at that one additive total. -/
theorem goldbach_certificate (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1) (hv1 : 0 < v 1)
    {k : ℕ} (hk : 4 ≤ k) (h : ℕ)
    (hpacket : (k - 3 : ℕ) * (47 / 80 : ℝ) ^ h < pairPacket v k h) :
    ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = k := by
  have hbound :=
    (goldbach_filter_bound v hv hv2 hv12 hratio hv1 hk h).2
  have hcount : 0 < goldbachCount k := by linarith
  by_contra hnone
  have hzero : goldbachCount k = 0 := by
    unfold goldbachCount
    apply Finset.sum_eq_zero
    intro a ha
    have hnot : ¬ (a.Prime ∧ (k - a).Prime) := by
      intro hh
      have haub : a ≤ k - 2 := (mem_Icc.mp ha).2
      have hadd : a + (k - a) = k := by omega
      exact hnone ⟨a, k - a, hh.1, hh.2, hadd⟩
    simp [hnot]
  linarith

end

#print axioms state_prime
#print axioms state_composite_le
#print axioms prime_filter_bound
#print axioms goldbach_filter_bound
#print axioms goldbach_certificate

end BuildingBlocks.FactorialBinetGoldbachFilter
