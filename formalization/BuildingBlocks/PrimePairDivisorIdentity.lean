import BuildingBlocks.PrimeHistoryDivisorResponse
import BuildingBlocks.SelbergDistinctPrimes

open scoped BigOperators

namespace BuildingBlocks

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

/-- The exact ordered coprime divisor-pair expansion of the actual
distinct-prime coefficient after the outer divisor lift. The coprime
condition removes same-prime histories, but no prime-power depth is cut. -/
theorem distinctPrimePairWeight_sqrt_divisor_expansion (n : ℕ) :
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * distinctPrimePairWeight m) =
      ∑ m ∈ n.divisors, ∑ d ∈ m.divisors,
        if d.Coprime (m / d) then
          Real.sqrt ((d * (m / d) : ℕ) : ℝ) *
            ArithmeticFunction.vonMangoldt d *
            ArithmeticFunction.vonMangoldt (m / d)
        else 0 := by
  apply Finset.sum_congr rfl
  intro m hm
  rw [distinctPrimePairWeight_eq_coprime_sum, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
  split_ifs <;> ring

/-- A nonzero actual distinct-pair coefficient has exactly two different
prime colors, each at an arbitrary positive power. This is the support
bridge needed to replace the divisor-pair expansion by score colors. -/
theorem distinctPrimePairWeight_support_two_prime_powers {n : ℕ}
    (h : distinctPrimePairWeight n ≠ 0) :
    ∃ p q i j : ℕ, p.Prime ∧ q.Prime ∧ p ≠ q ∧
      1 ≤ i ∧ 1 ≤ j ∧ n = p ^ i * q ^ j := by
  rw [distinctPrimePairWeight_eq_coprime_sum] at h
  obtain ⟨d, hd, ht⟩ := Finset.exists_ne_zero_of_sum_ne_zero h
  have hc : d.Coprime (n / d) := by
    by_contra hh
    simp [hh] at ht
  rw [if_pos hc] at ht
  have hd0 : ArithmeticFunction.vonMangoldt d ≠ 0 := by
    intro hh
    simp [hh] at ht
  have he0 : ArithmeticFunction.vonMangoldt (n / d) ≠ 0 := by
    intro hh
    simp [hh] at ht
  obtain ⟨p, i, hp, hi, hdi⟩ :=
    (isPrimePow_nat_iff d).mp (ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hd0)
  obtain ⟨q, j, hq, hj, heq⟩ :=
    (isPrimePow_nat_iff (n / d)).mp
      (ArithmeticFunction.vonMangoldt_ne_zero_iff.mp he0)
  have hpq : p ≠ q := by
    intro hpq
    subst q
    have hc' : (p ^ i).Coprime (p ^ j) := by simpa only [hdi, heq] using hc
    have hself : p.Coprime p :=
      (Nat.coprime_pow_right_iff hj p p).mp
        ((Nat.coprime_pow_left_iff hi p (p ^ j)).mp hc')
    have hp1 : p = 1 := by simpa [Nat.Coprime] using hself
    exact hp.ne_one hp1
  refine ⟨p, q, i, j, hp, hq, hpq, hi, hj, ?_⟩
  calc
    n = d * (n / d) := (Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1).symm
    _ = p ^ i * q ^ j := by rw [hdi, heq]

#print axioms distinctPrimePairWeight_support_two_prime_powers

/-- Final finite-color algebra. The remaining arithmetic interface is
the exact equality of its right side with the lifted divisor-pair sum. -/
theorem ordered_distinct_square_identity {α : Type*} [DecidableEq α]
    (S : Finset α) (f : α → ℝ) :
    (∑ p ∈ S, f p) ^ 2 - ∑ p ∈ S, f p ^ 2 =
      ∑ p ∈ S, ∑ q ∈ S, if p ≠ q then f p * f q else 0 := by
  classical
  calc
    (∑ p ∈ S, f p) ^ 2 - ∑ p ∈ S, f p ^ 2 =
        ∑ p ∈ S, ((∑ q ∈ S, f p * f q) - f p ^ 2) := by
          rw [sq, Finset.sum_mul_sum, Finset.sum_sub_distrib]
    _ = ∑ p ∈ S, ∑ q ∈ S, if p ≠ q then f p * f q else 0 := by
      apply Finset.sum_congr rfl
      intro p hp
      have hsingle :
          (∑ q ∈ S, if q = p then f p ^ 2 else 0) = f p ^ 2 := by
        simp [hp]
      rw [← hsingle, ← Finset.sum_sub_distrib]
      apply Finset.sum_congr rfl
      intro q hq
      by_cases h : p = q
      · subst q; simp; ring
      · simp [h, eq_comm]

#print axioms ordered_distinct_square_identity

/-- Exact weight matching for one ordered pair of positive prime powers. -/
theorem ordered_prime_power_pair_weight {p q i j : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hi : 1 ≤ i) (hj : 1 ≤ j) :
    Real.sqrt (((p ^ i * q ^ j : ℕ) : ℝ)) *
      ArithmeticFunction.vonMangoldt (p ^ i) *
      ArithmeticFunction.vonMangoldt (q ^ j) =
    (Real.log (p : ℝ) * Real.sqrt ((p : ℝ) ^ i)) *
      (Real.log (q : ℝ) * Real.sqrt ((q : ℝ) ^ j)) := by
  rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega : i ≠ 0),
    ArithmeticFunction.vonMangoldt_apply_pow (by omega : j ≠ 0),
    ArithmeticFunction.vonMangoldt_apply_prime hp,
    ArithmeticFunction.vonMangoldt_apply_prime hq]
  rw [Nat.cast_mul, Nat.cast_pow, Nat.cast_pow, Real.sqrt_mul (by positivity)]
  ring

#print axioms ordered_prime_power_pair_weight

#print axioms distinctPrimePairWeight_sqrt_divisor_expansion

private theorem prime_power_pair_coprime_iff {p q i j : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hi : 1 ≤ i) (hj : 1 ≤ j) :
    (p ^ i).Coprime (q ^ j) ↔ p ≠ q := by
  constructor
  · intro hc hpq
    subst q
    have hself : p.Coprime p :=
      (Nat.coprime_pow_right_iff hj p p).mp
        ((Nat.coprime_pow_left_iff hi p (p ^ j)).mp hc)
    have hp1 : p = 1 := by simpa [Nat.Coprime] using hself
    exact hp.ne_one hp1
  · intro hpq
    exact Nat.coprime_pow_primes i j hp hq hpq

private theorem prime_pow_product_dvd_iff {n p q i j : ℕ}
    (hn : n ≠ 0) (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hi : 1 ≤ i) (hj : 1 ≤ j) :
    p ^ i * q ^ j ∣ n ↔ i ≤ n.factorization p ∧ j ≤ n.factorization q := by
  constructor
  · intro h
    have hpi : p ^ i ∣ n := (dvd_mul_right _ _).trans h
    have hqj : q ^ j ∣ n := (dvd_mul_left _ _).trans h
    exact ⟨(hp.pow_dvd_iff_le_factorization hn).mp hpi,
      (hq.pow_dvd_iff_le_factorization hn).mp hqj⟩
  · rintro ⟨hpi, hqj⟩
    exact (prime_power_pair_coprime_iff hp hq hi hj).mpr hpq |>.mul_dvd_of_dvd_of_dvd
      ((hp.pow_dvd_iff_le_factorization hn).mpr hpi)
      ((hq.pow_dvd_iff_le_factorization hn).mpr hqj)

private theorem mul_div_left_nat {a b : ℕ} (ha : a ≠ 0) : a * b / a = b := by
  simpa [ha] using Nat.mul_div_cancel_left b a

private theorem prime_power_pair_unique {p q i j p' q' i' j' : ℕ}
    (hp : p.Prime) (hq : q.Prime) (hp' : p'.Prime) (hq' : q'.Prime)
    (hi : 1 ≤ i) (hj : 1 ≤ j) (hi' : 1 ≤ i') (hj' : 1 ≤ j')
    (ha : p ^ i = p' ^ i')
    (hm : p ^ i * q ^ j = p' ^ i' * q' ^ j') :
    p = p' ∧ i = i' ∧ q = q' ∧ j = j' := by
  have hpp : p = p' := by
    have hpow : p ^ ((i - 1) + 1) = p' ^ ((i' - 1) + 1) := by
      simpa [Nat.sub_add_cancel hi, Nat.sub_add_cancel hi'] using ha
    exact (hp.pow_inj hp' hpow).1
  have hii : i = i' := by
    subst p'
    exact Nat.pow_right_injective hp.two_le ha
  have hb : q ^ j = q' ^ j' := by
    rw [← ha] at hm
    exact (Nat.eq_of_mul_eq_mul_left (pow_pos hp.pos i)) hm
  have hqq : q = q' := by
    have hpow : q ^ ((j - 1) + 1) = q' ^ ((j' - 1) + 1) := by
      simpa [Nat.sub_add_cancel hj, Nat.sub_add_cancel hj'] using hb
    exact (hq.pow_inj hq' hpow).1
  have hjj : j = j' := by
    subst q'
    exact Nat.pow_right_injective hq.two_le hb
  exact ⟨hpp, hii, hqq, hjj⟩

private theorem prime_power_pair_sum_bij {n : ℕ} (hn : n ≠ 0) :
    (∑ a ∈ ((n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p))).product
        (n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p)))).filter
          (fun a => a.1.1 ≠ a.2.1),
      Real.sqrt ((((a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 : ℕ) : ℝ))) *
        ArithmeticFunction.vonMangoldt (a.1.1 ^ a.1.2) *
        ArithmeticFunction.vonMangoldt (a.2.1 ^ a.2.2)) =
    ∑ b ∈ n.divisors.sigma (fun m => m.divisors.filter
        (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d))),
      Real.sqrt (b.1 : ℝ) * ArithmeticFunction.vonMangoldt b.2 *
        ArithmeticFunction.vonMangoldt (b.1 / b.2) := by
  classical
  let P := n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p))
  let Q := (P.product P).filter (fun a => a.1.1 ≠ a.2.1)
  let B := n.divisors.sigma (fun m => m.divisors.filter
    (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d)))
  change (∑ a ∈ Q, _) = ∑ b ∈ B, _
  apply Finset.sum_bij (fun a _ => ⟨a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2,
    a.1.1 ^ a.1.2⟩)
  · intro a ha
    obtain ⟨hpa, hqa⟩ := Finset.mem_product.mp (Finset.mem_filter.mp ha).1
    have hp := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hpa).1).1
    have hq := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hqa).1).1
    have hi := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hpa).2).1
    have hj := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hqa).2).1
    have hpq : a.1.1 ≠ a.2.1 := (Finset.mem_filter.mp ha).2
    have hmn : a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 ∣ n :=
      (prime_pow_product_dvd_iff hn hp hq hpq hi hj).mpr
        ⟨(Finset.mem_Icc.mp (Finset.mem_sigma.mp hpa).2).2,
          (Finset.mem_Icc.mp (Finset.mem_sigma.mp hqa).2).2⟩
    have ha0 : a.1.1 ^ a.1.2 ≠ 0 := ne_of_gt (pow_pos hp.pos _)
    have hm0 : a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 ≠ 0 :=
      ne_of_gt (mul_pos (pow_pos hp.pos _) (pow_pos hq.pos _))
    apply Finset.mem_sigma.mpr
    constructor
    · exact Nat.mem_divisors.mpr ⟨hmn, hn⟩
    · apply Finset.mem_filter.mpr
      constructor
      · exact Nat.mem_divisors.mpr ⟨dvd_mul_right _ _, hm0⟩
      · rw [mul_div_left_nat ha0]
        exact ⟨(prime_power_pair_coprime_iff hp hq hi hj).mpr hpq,
          ⟨a.1.1, a.1.2, hp.prime, hi, rfl⟩,
          ⟨a.2.1, a.2.2, hq.prime, hj, rfl⟩⟩
  · intro a ha b hb heq
    obtain ⟨hpa, hqa⟩ := Finset.mem_product.mp (Finset.mem_filter.mp ha).1
    obtain ⟨hpb, hqb⟩ := Finset.mem_product.mp (Finset.mem_filter.mp hb).1
    have hp := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hpa).1).1
    have hq := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hqa).1).1
    have hp' := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hpb).1).1
    have hq' := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hqb).1).1
    have hi := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hpa).2).1
    have hj := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hqa).2).1
    have hi' := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hpb).2).1
    have hj' := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hqb).2).1
    have hm : a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 =
        b.1.1 ^ b.1.2 * b.2.1 ^ b.2.2 := congrArg Sigma.fst heq
    have hd : a.1.1 ^ a.1.2 = b.1.1 ^ b.1.2 :=
      congrArg (fun z : Σ _m : ℕ, ℕ => z.2) heq
    obtain ⟨hpp, hii, hqq, hjj⟩ :=
      prime_power_pair_unique hp hq hp' hq' hi hj hi' hj' hd hm
    apply Prod.ext
    · exact Sigma.ext hpp (heq_of_eq hii)
    · exact Sigma.ext hqq (heq_of_eq hjj)
  · intro b hb
    obtain ⟨hbm, hbd⟩ := Finset.mem_sigma.mp hb
    obtain ⟨hbdm, hc, hdpow, hepow⟩ := by
      simpa only [Finset.mem_filter, and_assoc] using hbd
    obtain ⟨p, i, hp, hi, hdi⟩ := (isPrimePow_nat_iff b.2).mp hdpow
    obtain ⟨q, j, hq, hj, heq⟩ := (isPrimePow_nat_iff (b.1 / b.2)).mp hepow
    have hpq : p ≠ q := by
      apply (prime_power_pair_coprime_iff hp hq hi hj).mp
      simpa only [hdi, heq] using hc
    have hm : b.1 = p ^ i * q ^ j := by
      calc
        b.1 = b.2 * (b.1 / b.2) :=
          (Nat.mul_div_cancel' (Nat.mem_divisors.mp hbdm).1).symm
        _ = p ^ i * q ^ j := by rw [hdi, heq]
    have hpn : p ^ i * q ^ j ∣ n := hm ▸ (Nat.mem_divisors.mp hbm).1
    have hfac := (prime_pow_product_dvd_iff hn hp hq hpq hi hj).mp hpn
    have hpdiv : p ∣ n :=
      (dvd_pow_self p (by omega : i ≠ 0)).trans ((dvd_mul_right _ _).trans hpn)
    have hqdiv : q ∣ n :=
      (dvd_pow_self q (by omega : j ≠ 0)).trans ((dvd_mul_left _ _).trans hpn)
    have hpmem : p ∈ n.primeFactors := Nat.mem_primeFactors.mpr ⟨hp, hpdiv, hn⟩
    have hqmem : q ∈ n.primeFactors := Nat.mem_primeFactors.mpr ⟨hq, hqdiv, hn⟩
    refine ⟨(⟨p, i⟩, ⟨q, j⟩), ?_, ?_⟩
    · apply Finset.mem_filter.mpr
      constructor
      · exact Finset.mem_product.mpr
          ⟨Finset.mem_sigma.mpr ⟨hpmem, Finset.mem_Icc.mpr ⟨hi, hfac.1⟩⟩,
           Finset.mem_sigma.mpr ⟨hqmem, Finset.mem_Icc.mpr ⟨hj, hfac.2⟩⟩⟩
      · exact hpq
    · apply Sigma.ext hm.symm
      exact heq_of_eq hdi
  · intro a ha
    have hp := (Nat.mem_primeFactors.mp
      (Finset.mem_sigma.mp (Finset.mem_product.mp (Finset.mem_filter.mp ha).1).1).1).1
    have ha0 : a.1.1 ^ a.1.2 ≠ 0 := ne_of_gt (pow_pos hp.pos _)
    rw [mul_div_left_nat ha0]

private theorem distinct_prime_lift_eq_ordered_power_pairs {n : ℕ} (hn : n ≠ 0) :
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * distinctPrimePairWeight m) =
    ∑ a ∈ ((n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p))).product
        (n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p)))).filter
          (fun a => a.1.1 ≠ a.2.1),
      Real.sqrt ((((a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 : ℕ) : ℝ))) *
        ArithmeticFunction.vonMangoldt (a.1.1 ^ a.1.2) *
        ArithmeticFunction.vonMangoldt (a.2.1 ^ a.2.2) := by
  classical
  let B := n.divisors.sigma (fun m => m.divisors.filter
    (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d)))
  have hrow (m : ℕ) :
      (∑ d ∈ m.divisors,
        if d.Coprime (m / d) then
          Real.sqrt ((d * (m / d) : ℕ) : ℝ) *
            ArithmeticFunction.vonMangoldt d *
            ArithmeticFunction.vonMangoldt (m / d)
        else 0) =
      ∑ d ∈ m.divisors.filter
        (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d)),
        Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt d *
          ArithmeticFunction.vonMangoldt (m / d) := by
    symm
    calc
      (∑ d ∈ m.divisors.filter
          (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d)),
          Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt d *
            ArithmeticFunction.vonMangoldt (m / d)) =
        ∑ d ∈ m.divisors.filter
          (fun d => d.Coprime (m / d) ∧ IsPrimePow d ∧ IsPrimePow (m / d)),
          if d.Coprime (m / d) then
            Real.sqrt ((d * (m / d) : ℕ) : ℝ) *
              ArithmeticFunction.vonMangoldt d *
              ArithmeticFunction.vonMangoldt (m / d)
          else 0 := by
            apply Finset.sum_congr rfl
            intro d hd
            obtain ⟨hdiv, hc, _, _⟩ := by simpa only [Finset.mem_filter, and_assoc] using hd
            rw [if_pos hc, Nat.mul_div_cancel' (Nat.mem_divisors.mp hdiv).1]
      _ = _ := by
        apply Finset.sum_subset (Finset.filter_subset _ _)
        intro d hd hnot
        by_cases hc : d.Coprime (m / d)
        · rw [if_pos hc]
          by_cases hdp : IsPrimePow d
          · have hep : ¬IsPrimePow (m / d) := by
              intro he
              exact hnot (Finset.mem_filter.mpr ⟨hd, hc, hdp, he⟩)
            simp [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hep]
          · simp [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hdp]
        · simp [hc]
  calc
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * distinctPrimePairWeight m) =
        ∑ m ∈ n.divisors, ∑ d ∈ m.divisors,
          if d.Coprime (m / d) then
            Real.sqrt ((d * (m / d) : ℕ) : ℝ) *
              ArithmeticFunction.vonMangoldt d *
              ArithmeticFunction.vonMangoldt (m / d)
          else 0 := distinctPrimePairWeight_sqrt_divisor_expansion n
    _ = ∑ b ∈ B, Real.sqrt (b.1 : ℝ) *
          ArithmeticFunction.vonMangoldt b.2 *
          ArithmeticFunction.vonMangoldt (b.1 / b.2) := by
        simp_rw [hrow]
        simp only [B, Finset.sum_sigma]
    _ = _ := (prime_power_pair_sum_bij hn).symm

private theorem finite_color_power_pair_sum
    (S : Finset ℕ) (I : ℕ → Finset ℕ) (f : ℕ → ℕ → ℝ) :
    (∑ a ∈ ((S.sigma I).product (S.sigma I)).filter (fun a => a.1.1 ≠ a.2.1),
      f a.1.1 a.1.2 * f a.2.1 a.2.2) =
      ∑ p ∈ S, ∑ q ∈ S,
        if p ≠ q then (∑ i ∈ I p, f p i) * (∑ j ∈ I q, f q j) else 0 := by
  classical
  calc
    (∑ a ∈ ((S.sigma I).product (S.sigma I)).filter (fun a => a.1.1 ≠ a.2.1),
      f a.1.1 a.1.2 * f a.2.1 a.2.2) =
        ∑ a ∈ S.sigma I, ∑ b ∈ S.sigma I,
          if a.1 ≠ b.1 then f a.1 a.2 * f b.1 b.2 else 0 := by
            rw [Finset.sum_filter]
            exact Finset.sum_product (S.sigma I) (S.sigma I)
              (fun a => if a.1.1 ≠ a.2.1 then f a.1.1 a.1.2 * f a.2.1 a.2.2 else 0)
    _ = ∑ p ∈ S, ∑ i ∈ I p, ∑ q ∈ S, ∑ j ∈ I q,
          if p ≠ q then f p i * f q j else 0 := by
            simp only [Finset.sum_sigma]
    _ = ∑ p ∈ S, ∑ q ∈ S, ∑ i ∈ I p, ∑ j ∈ I q,
          if p ≠ q then f p i * f q j else 0 := by
            apply Finset.sum_congr rfl
            intro p hp
            exact Finset.sum_comm
    _ = ∑ p ∈ S, ∑ q ∈ S,
          if p ≠ q then (∑ i ∈ I p, f p i) * (∑ j ∈ I q, f q j) else 0 := by
            apply Finset.sum_congr rfl
            intro p hp
            apply Finset.sum_congr rfl
            intro q hq
            by_cases hpq : p ≠ q
            · simp only [if_pos hpq, Finset.sum_mul_sum]
            · simp [hpq]

/-- The exact pointwise arithmetic identity for the actual distinct-prime
Selberg coefficient, retaining every prime power in every color. -/
theorem distinctPrimePairWeight_divisor_eq_score_square {n : ℕ} (hn : n ≠ 0) :
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * distinctPrimePairWeight m) =
      (∑ p ∈ n.primeFactors, fullPrimeScore p n) ^ 2 -
        ∑ p ∈ n.primeFactors, (fullPrimeScore p n) ^ 2 := by
  classical
  let I : ℕ → Finset ℕ := fun p => Finset.Icc 1 (n.factorization p)
  let f : ℕ → ℕ → ℝ := fun p i => Real.log (p : ℝ) * Real.sqrt ((p : ℝ) ^ i)
  calc
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * distinctPrimePairWeight m) =
        ∑ a ∈ ((n.primeFactors.sigma I).product (n.primeFactors.sigma I)).filter
            (fun a => a.1.1 ≠ a.2.1),
          Real.sqrt ((((a.1.1 ^ a.1.2 * a.2.1 ^ a.2.2 : ℕ) : ℝ))) *
            ArithmeticFunction.vonMangoldt (a.1.1 ^ a.1.2) *
            ArithmeticFunction.vonMangoldt (a.2.1 ^ a.2.2) :=
      distinct_prime_lift_eq_ordered_power_pairs hn
    _ = ∑ a ∈ ((n.primeFactors.sigma I).product (n.primeFactors.sigma I)).filter
          (fun a => a.1.1 ≠ a.2.1), f a.1.1 a.1.2 * f a.2.1 a.2.2 := by
      apply Finset.sum_congr rfl
      intro a ha
      obtain ⟨hpa, hqa⟩ := Finset.mem_product.mp (Finset.mem_filter.mp ha).1
      have hp := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hpa).1).1
      have hq := (Nat.mem_primeFactors.mp (Finset.mem_sigma.mp hqa).1).1
      have hi := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hpa).2).1
      have hj := (Finset.mem_Icc.mp (Finset.mem_sigma.mp hqa).2).1
      exact ordered_prime_power_pair_weight hp hq hi hj
    _ = ∑ p ∈ n.primeFactors, ∑ q ∈ n.primeFactors,
          if p ≠ q then (∑ i ∈ I p, f p i) * (∑ j ∈ I q, f q j) else 0 :=
      finite_color_power_pair_sum n.primeFactors I f
    _ = ∑ p ∈ n.primeFactors, ∑ q ∈ n.primeFactors,
          if p ≠ q then fullPrimeScore p n * fullPrimeScore q n else 0 := by
      apply Finset.sum_congr rfl
      intro p hp
      apply Finset.sum_congr rfl
      intro q hq
      congr 1
      simp only [I, f, fullPrimeScore, Finset.mul_sum]
    _ = _ := (ordered_distinct_square_identity n.primeFactors
      (fun p => fullPrimeScore p n)).symm

#print axioms distinctPrimePairWeight_divisor_eq_score_square

end BuildingBlocks
