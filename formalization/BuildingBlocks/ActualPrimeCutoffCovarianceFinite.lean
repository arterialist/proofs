import Mathlib.Tactic

/-!
# Finite actual-cutoff prime-power covariance reduction

This file formalizes the finite arithmetic part of equation (6) of
`building-blocks/prime-distribution/prime-score-negative-covariance.md`.
The probability weight is the actual
cutoff weight `(x-n)/sqrt n` on positive integers `n < x`. The theorem keeps
every prime power up to the finite cutoff `J`, and makes the strict
monotonicity of the one-prime mean an explicit named hypothesis. It does not
prove that monotonicity, an RH bound, or the full signed balance.
-/

namespace BuildingBlocks.ActualPrimeCutoffCovarianceFinite

noncomputable section

/-- The point mass used by the actual cutoff law. -/
def cutoffWeight (x : ℝ) (n : ℕ) : ℝ :=
  if (n : ℝ) < x then (x - n) / Real.sqrt n else 0

theorem cutoffWeight_eq_zero_of_le_one {x : ℝ} {n : ℕ}
    (hx : x ≤ 1) (hn : 1 ≤ n) : cutoffWeight x n = 0 := by
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn
  simp [cutoffWeight, not_lt.mpr (hx.trans hnR)]

/-- The exact cofactor scaling of the cutoff weight. This is the arithmetic
change of variables behind the prime-power size bias. -/
theorem cutoffWeight_dilate {a n : ℕ} {x : ℝ}
    (ha : 0 < a) (hn : 0 < n) :
    cutoffWeight x (a * n) =
      Real.sqrt (a : ℝ) * cutoffWeight (x / a) n := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hsqa : (Real.sqrt (a : ℝ)) ^ 2 = a := Real.sq_sqrt haR.le
  have hsqr : Real.sqrt (a : ℝ) ≠ 0 := (Real.sqrt_pos.2 haR).ne'
  have hsqn : Real.sqrt (n : ℝ) ≠ 0 := (Real.sqrt_pos.2 hnR).ne'
  have hiff : ((a * n : ℕ) : ℝ) < x ↔ (n : ℝ) < x / a := by
    rw [Nat.cast_mul]
    constructor
    · intro h
      exact (lt_div_iff₀ haR).2 (by simpa [mul_comm] using h)
    · intro h
      exact_mod_cast (show (a : ℝ) * n < x from by
        simpa [mul_comm] using (lt_div_iff₀ haR).1 h)
  by_cases h : ((a * n : ℕ) : ℝ) < x
  · simp only [cutoffWeight]
    rw [if_pos h, if_pos (hiff.mp h)]
    rw [Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg a)]
    field_simp [hsqr, hsqn, ne_of_gt haR]
    rw [hsqa]
    ring
  · simp only [cutoffWeight, if_neg h, if_neg (mt hiff.mpr h), mul_zero]

/-- Unnormalized mass of the actual finite cutoff law. `N` is chosen beyond
the active support, so increasing it does not alter the value. -/
def cutoffMass (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n

/-- Exact finite reindexing of the actual cutoff mass on multiples of `a`.
The quotient cutoff `N/a` is retained, so this lemma needs no assumption on
the real endpoint `x`. -/
theorem cutoff_multiples_sum (N a : ℕ) (x : ℝ) (ha : 0 < a) :
    (∑ n ∈ Finset.Icc 1 N,
      if a ∣ n then cutoffWeight x n else 0) =
      Real.sqrt (a : ℝ) * cutoffMass (N / a) (x / a) := by
  rw [← Finset.sum_filter]
  have he :
      (∑ m ∈ Finset.Icc 1 (N / a), cutoffWeight x (a * m)) =
      ∑ n ∈ (Finset.Icc 1 N).filter (fun n => a ∣ n), cutoffWeight x n := by
    apply Finset.sum_bij (fun m _ => a * m)
    · intro m hm
      obtain ⟨hm1, hmN⟩ := Finset.mem_Icc.mp hm
      apply Finset.mem_filter.mpr
      constructor
      · apply Finset.mem_Icc.mpr
        constructor
        · exact Nat.mul_pos ha hm1
        · simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le ha).mp hmN
      · exact dvd_mul_right a m
    · intro u hu v hv huv
      exact Nat.eq_of_mul_eq_mul_left ha huv
    · intro n hn
      obtain ⟨hnI, han⟩ := Finset.mem_filter.mp hn
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hnI
      refine ⟨n / a, ?_, ?_⟩
      · apply Finset.mem_Icc.mpr
        constructor
        · apply Nat.one_le_iff_ne_zero.mpr
          intro hz
          have hh := Nat.div_mul_cancel han
          rw [hz, zero_mul] at hh
          omega
        · exact Nat.div_le_div_right hnN
      · simpa [Nat.mul_comm] using Nat.div_mul_cancel han
    · intro m hm
      rfl
  rw [← he]
  unfold cutoffMass
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro m hm
  have hmpos : 0 < m := (Finset.mem_Icc.mp hm).1
  exact cutoffWeight_dilate ha hmpos

theorem cutoff_multiples_sum_weighted (N a : ℕ) (x : ℝ)
    (f : ℕ → ℝ) (ha : 0 < a) :
    (∑ n ∈ Finset.Icc 1 N,
      if a ∣ n then cutoffWeight x n * f n else 0) =
      Real.sqrt (a : ℝ) *
        ∑ d ∈ Finset.Icc 1 (N / a),
          cutoffWeight (x / a) d * f (a * d) := by
  rw [← Finset.sum_filter]
  have he :
      (∑ d ∈ Finset.Icc 1 (N / a),
        cutoffWeight x (a * d) * f (a * d)) =
      ∑ n ∈ (Finset.Icc 1 N).filter (fun n => a ∣ n),
        cutoffWeight x n * f n := by
    apply Finset.sum_bij (fun d _ => a * d)
    · intro d hd
      obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
      apply Finset.mem_filter.mpr
      constructor
      · apply Finset.mem_Icc.mpr
        constructor
        · exact Nat.mul_pos ha hd1
        · simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le ha).mp hdN
      · exact dvd_mul_right a d
    · intro u hu v hv huv
      exact Nat.eq_of_mul_eq_mul_left ha huv
    · intro n hn
      obtain ⟨hnI, han⟩ := Finset.mem_filter.mp hn
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hnI
      refine ⟨n / a, ?_, ?_⟩
      · apply Finset.mem_Icc.mpr
        constructor
        · apply Nat.one_le_iff_ne_zero.mpr
          intro hz
          have hh := Nat.div_mul_cancel han
          rw [hz, zero_mul] at hh
          omega
        · exact Nat.div_le_div_right hnN
      · simpa [Nat.mul_comm] using Nat.div_mul_cancel han
    · intro d hd
      rfl
  rw [← he]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [cutoffWeight_dilate ha (Finset.mem_Icc.mp hd).1]
  ring

/-- Once the integer cutoff is beyond the real support, more integers
contribute zero. The weak endpoint `x ≤ M+1` is enough because the weight
uses the strict condition `n < x`. -/
theorem cutoffMass_stable {M N : ℕ} {x : ℝ}
    (hMN : M ≤ N) (hx : x ≤ M + 1) :
    cutoffMass N x = cutoffMass M x := by
  unfold cutoffMass
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬ n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hxn : ¬ (n : ℝ) < x := by
      have : (M : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hnlarge
      exact not_lt.mpr (hx.trans this)
    simp [cutoffWeight, hxn]

theorem cutoff_dilated_endpoint {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    x / (a : ℝ) ≤ (N / a : ℕ) + 1 := by
  have haR : (0 : ℝ) < a := by exact_mod_cast ha
  have hNat : N + 1 ≤ a * (N / a + 1) := by
    have hrem := Nat.mod_lt N ha
    have hdecomp := Nat.mod_add_div N a
    calc
      N + 1 = N % a + a * (N / a) + 1 := by omega
      _ ≤ a + a * (N / a) := by omega
      _ = a * (N / a + 1) := by ring
  have hReal : x ≤ (a : ℝ) * ((N / a : ℕ) + 1) :=
    hx.trans (by exact_mod_cast hNat)
  exact (div_le_iff₀ haR).2 (by simpa [mul_comm] using hReal)

theorem cutoffMass_dilated_stable {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    cutoffMass (N / a) (x / a) = cutoffMass N (x / a) := by
  exact (cutoffMass_stable (Nat.div_le_self N a)
    (cutoff_dilated_endpoint ha hx)).symm

/-- The original finite score on an integer sample, retaining every power
`p^j` in the displayed cutoff. -/
def primeScore (J p n : ℕ) : ℝ :=
  Real.log p *
    ∑ j ∈ Finset.Icc 1 J,
      if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0

/-- The published score expressed with the full p-adic valuation. -/
def fullPrimeScore (p n : ℕ) : ℝ :=
  Real.log p *
    ∑ j ∈ Finset.Icc 1 (n.factorization p), Real.sqrt ((p : ℝ) ^ j)

theorem primeScore_eq_fullPrimeScore {N p n : ℕ}
    (hp : p.Prime) (hn : 1 ≤ n) (hnN : n ≤ N) :
    primeScore N p n = fullPrimeScore p n := by
  have hn0 : n ≠ 0 := by omega
  have hfac : n.factorization p ≤ N :=
    (Nat.factorization_lt p hn0).le.trans hnN
  unfold primeScore fullPrimeScore
  congr 1
  calc
    (∑ j ∈ Finset.Icc 1 N,
        if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) =
      ∑ j ∈ Finset.Icc 1 N,
        if j ≤ n.factorization p then Real.sqrt ((p : ℝ) ^ j) else 0 := by
          apply Finset.sum_congr rfl
          intro j hj
          simp only [hp.pow_dvd_iff_le_factorization hn0]
    _ = ∑ j ∈ Finset.Icc 1 (n.factorization p),
        Real.sqrt ((p : ℝ) ^ j) := by
          rw [← Finset.sum_filter]
          congr 1
          ext j
          simp only [Finset.mem_filter, Finset.mem_Icc]
          omega

/-- A distinct prime's score is invariant when a power of `p` is inserted
into the cofactor. -/
theorem primeScore_mul_other {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (hpq : p ≠ q) (J j d : ℕ) :
    primeScore J q (p ^ j * d) = primeScore J q d := by
  unfold primeScore
  congr 1
  apply Finset.sum_congr rfl
  intro k hk
  have hcop : Nat.Coprime (q ^ k) (p ^ j) := by
    exact ((Nat.coprime_primes hq hp).mpr hpq.symm).pow k j
  simp only [hcop.dvd_mul_left]

/-- The original finite cutoff-law expectation, before cofactor reindexing. -/
def originalPrimeMean (N J p : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * primeScore J p n) /
    cutoffMass N x

def originalScoreMass (N J p : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * primeScore J p n

theorem originalScoreMass_stable {M N J q : ℕ} {y : ℝ}
    (hMN : M ≤ N) (hy : y ≤ (M : ℝ) + 1) :
    originalScoreMass N J q y = originalScoreMass M J q y := by
  unfold originalScoreMass
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬ n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hyn : ¬ (n : ℝ) < y := by
      have : (M : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hnlarge
      exact not_lt.mpr (hy.trans this)
    simp [cutoffWeight, hyn]

theorem cutoff_prime_power_mass {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n *
        (if a ∣ n then Real.sqrt (a : ℝ) else 0)) =
      (a : ℝ) * cutoffMass N (x / a) := by
  have haR : (0 : ℝ) ≤ a := by exact_mod_cast (Nat.zero_le a)
  calc
    _ = Real.sqrt (a : ℝ) *
        (∑ n ∈ Finset.Icc 1 N, if a ∣ n then cutoffWeight x n else 0) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro n hn
          split_ifs <;> ring
    _ = Real.sqrt (a : ℝ) *
        (Real.sqrt (a : ℝ) * cutoffMass (N / a) (x / a)) := by
          rw [cutoff_multiples_sum N a x ha]
    _ = (a : ℝ) * cutoffMass (N / a) (x / a) := by
          rw [← mul_assoc, ← pow_two, Real.sq_sqrt haR]
    _ = (a : ℝ) * cutoffMass N (x / a) := by
          rw [cutoffMass_dilated_stable ha hx]

theorem cutoffMass_nonneg (N : ℕ) (x : ℝ) : 0 ≤ cutoffMass N x := by
  unfold cutoffMass
  apply Finset.sum_nonneg
  intro n hn
  unfold cutoffWeight
  split_ifs with h
  · exact div_nonneg (sub_nonneg.mpr h.le) (Real.sqrt_nonneg _)
  · exact le_refl _

theorem cutoffMass_pos {N : ℕ} {x : ℝ} (hN : 1 ≤ N) (hx : 1 < x) :
    0 < cutoffMass N x := by
  unfold cutoffMass
  apply Finset.sum_pos'
  · intro n hn
    unfold cutoffWeight
    split_ifs with h
    · exact div_nonneg (sub_nonneg.mpr h.le) (Real.sqrt_nonneg _)
    · exact le_refl _
  · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hN⟩, ?_⟩
    simpa [cutoffWeight, hx] using (sub_pos.mpr hx)

/-- The finite actual-prime-power score mean after exact cofactor dilation.
All powers `p^j` with `1 ≤ j ≤ J` are retained. -/
def primeMean (N J p : ℕ) (x : ℝ) : ℝ :=
  Real.log p / cutoffMass N x *
    ∑ j ∈ Finset.Icc 1 J,
      (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j)

/-- The cofactor formula for the mean is exactly the expectation of the
original integer-valued score when `N` contains the whole cutoff support.
No moment or sign estimate enters this identification. -/
theorem originalPrimeMean_eq_primeMean
    {N J p : ℕ} {x : ℝ} (hp : 0 < p) (hx : x ≤ (N : ℝ) + 1) :
    originalPrimeMean N J p x = primeMean N J p x := by
  have hraw :
      (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * primeScore J p n) =
        Real.log p *
          ∑ j ∈ Finset.Icc 1 J,
            (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) := by
    calc
      _ = Real.log p *
          ∑ n ∈ Finset.Icc 1 N, ∑ j ∈ Finset.Icc 1 J,
            cutoffWeight x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro n hn
            unfold primeScore
            calc
              cutoffWeight x n *
                  (Real.log p * ∑ j ∈ Finset.Icc 1 J,
                    if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) =
                  (cutoffWeight x n * Real.log p) *
                    ∑ j ∈ Finset.Icc 1 J,
                      if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0 := by ring
              _ = ∑ j ∈ Finset.Icc 1 J,
                    (cutoffWeight x n * Real.log p) *
                      (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
                    rw [Finset.mul_sum]
              _ = Real.log p * ∑ j ∈ Finset.Icc 1 J,
                    cutoffWeight x n *
                      (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
                    rw [Finset.mul_sum]
                    apply Finset.sum_congr rfl
                    intro j hj
                    ring
      _ = Real.log p *
          ∑ j ∈ Finset.Icc 1 J, ∑ n ∈ Finset.Icc 1 N,
            cutoffWeight x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
            rw [Finset.sum_comm]
      _ = _ := by
            congr 1
            apply Finset.sum_congr rfl
            intro j hj
            simpa only [Nat.cast_pow] using
              (cutoff_prime_power_mass (N := N) (a := p ^ j)
                (pow_pos hp j) hx)
  unfold originalPrimeMean primeMean
  rw [hraw]
  ring

theorem originalScoreMass_eq_mass_mul_primeMean
    {N J q : ℕ} {y : ℝ} (hN : 1 ≤ N) (hq : 0 < q)
    (hyN : y ≤ (N : ℝ) + 1) :
    originalScoreMass N J q y = cutoffMass N y * primeMean N J q y := by
  by_cases hy : 1 < y
  · have hZ : cutoffMass N y ≠ 0 :=
      (cutoffMass_pos hN hy).ne'
    have hmean := originalPrimeMean_eq_primeMean (N := N) (J := J)
      (p := q) (x := y) hq hyN
    unfold originalPrimeMean at hmean
    unfold originalScoreMass
    rw [← hmean]
    field_simp
  · have hy1 : y ≤ 1 := le_of_not_gt hy
    have hZ : cutoffMass N y = 0 := by
      unfold cutoffMass
      apply Finset.sum_eq_zero
      intro n hn
      exact cutoffWeight_eq_zero_of_le_one hy1 (Finset.mem_Icc.mp hn).1
    have hS : originalScoreMass N J q y = 0 := by
      unfold originalScoreMass
      apply Finset.sum_eq_zero
      intro n hn
      simp [cutoffWeight_eq_zero_of_le_one hy1 (Finset.mem_Icc.mp hn).1]
    simp [hZ, hS]

/-- Exact prime-power extraction in the original two-score numerator.
Distinctness is used precisely to keep the `q` score on the cofactor. -/
theorem cutoff_prime_power_cross_mass {N J p q j : ℕ} {x : ℝ}
    (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hx : x ≤ (N : ℝ) + 1) :
    (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n *
        (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) *
          primeScore J q n) =
      (p : ℝ) ^ j * originalScoreMass N J q (x / (p : ℝ) ^ j) := by
  have ha : 0 < p ^ j := pow_pos hp.pos j
  have haR : (0 : ℝ) ≤ (p : ℝ) ^ j := by positivity
  calc
    _ = Real.sqrt ((p : ℝ) ^ j) *
        (∑ n ∈ Finset.Icc 1 N,
          if p ^ j ∣ n then cutoffWeight x n * primeScore J q n else 0) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro n hn
          split_ifs <;> ring
    _ = Real.sqrt ((p : ℝ) ^ j) *
        (Real.sqrt ((p : ℝ) ^ j) *
          ∑ d ∈ Finset.Icc 1 (N / p ^ j),
            cutoffWeight (x / (p : ℝ) ^ j) d * primeScore J q (p ^ j * d)) := by
          rw [show ((p : ℝ) ^ j) = ((p ^ j : ℕ) : ℝ) by norm_cast]
          rw [cutoff_multiples_sum_weighted N (p ^ j) x (primeScore J q) ha]
    _ = (p : ℝ) ^ j * originalScoreMass (N / p ^ j) J q (x / (p : ℝ) ^ j) := by
          simp_rw [primeScore_mul_other hp hq hpq J j]
          unfold originalScoreMass
          rw [← mul_assoc, ← pow_two, Real.sq_sqrt haR]
    _ = (p : ℝ) ^ j * originalScoreMass N J q (x / (p : ℝ) ^ j) := by
          rw [← originalScoreMass_stable (Nat.div_le_self N (p ^ j))
            (by simpa only [Nat.cast_pow] using
              (cutoff_dilated_endpoint (a := p ^ j) ha hx))]

/-- The ordered cross-prime score moment after extracting the `p^j`
cofactor. For distinct primes, this is the exact reindexed finite moment. -/
def crossMoment (N J p q : ℕ) (x : ℝ) : ℝ :=
  Real.log p / cutoffMass N x *
    ∑ j ∈ Finset.Icc 1 J,
      (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
        primeMean N J q (x / (p : ℝ) ^ j)

/-- The original unexpanded two-score moment under the finite cutoff law. -/
def originalCrossMoment (N J p q : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * primeScore J p n * primeScore J q n) /
    cutoffMass N x

/-- The original random-variable cross moment equals the size-biased
cofactor expression. `x ≤ N+1` makes the integer law complete on `n < x`;
`p ≠ q` makes the `q` score invariant under extraction of `p^j`.
The equality holds for every finite `J`; taking `J=N` retains all active
prime powers under this cutoff. -/
theorem originalCrossMoment_eq_crossMoment
    {N J p q : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hx : x ≤ (N : ℝ) + 1) :
    originalCrossMoment N J p q x = crossMoment N J p q x := by
  have hraw :
      (∑ n ∈ Finset.Icc 1 N,
        cutoffWeight x n * primeScore J p n * primeScore J q n) =
        Real.log p *
          ∑ j ∈ Finset.Icc 1 J,
            (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
              primeMean N J q (x / (p : ℝ) ^ j) := by
    calc
      _ = Real.log p *
          ∑ n ∈ Finset.Icc 1 N, ∑ j ∈ Finset.Icc 1 J,
            cutoffWeight x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) *
                primeScore J q n := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro n hn
            rw [show primeScore J p n =
              Real.log p * ∑ j ∈ Finset.Icc 1 J,
                if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0 from rfl]
            calc
              (cutoffWeight x n *
                  (Real.log p * ∑ j ∈ Finset.Icc 1 J,
                    if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0)) *
                  primeScore J q n =
                (cutoffWeight x n * primeScore J q n * Real.log p) *
                  ∑ j ∈ Finset.Icc 1 J,
                    if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0 := by ring
              _ = ∑ j ∈ Finset.Icc 1 J,
                    (cutoffWeight x n * primeScore J q n * Real.log p) *
                      (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) := by
                    rw [Finset.mul_sum]
              _ = Real.log p * ∑ j ∈ Finset.Icc 1 J,
                    cutoffWeight x n *
                      (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) *
                        primeScore J q n := by
                    rw [Finset.mul_sum]
                    apply Finset.sum_congr rfl
                    intro j hj
                    ring
      _ = Real.log p *
          ∑ j ∈ Finset.Icc 1 J, ∑ n ∈ Finset.Icc 1 N,
            cutoffWeight x n *
              (if p ^ j ∣ n then Real.sqrt ((p : ℝ) ^ j) else 0) *
                primeScore J q n := by
            rw [Finset.sum_comm]
      _ = Real.log p *
          ∑ j ∈ Finset.Icc 1 J,
            (p : ℝ) ^ j * originalScoreMass N J q (x / (p : ℝ) ^ j) := by
            congr 1
            apply Finset.sum_congr rfl
            intro j hj
            exact cutoff_prime_power_cross_mass hp hq hpq hx
      _ = _ := by
            congr 1
            apply Finset.sum_congr rfl
            intro j hj
            have ha : 0 < p ^ j := pow_pos hp.pos j
            have hy : x / (p : ℝ) ^ j ≤ (N : ℝ) + 1 := by
              have hqend := cutoff_dilated_endpoint (N := N) (a := p ^ j) ha hx
              have hdiv : N / p ^ j ≤ N := Nat.div_le_self N (p ^ j)
              have hdivR : ((N / p ^ j : ℕ) : ℝ) ≤ N := by exact_mod_cast hdiv
              have hy' : x / (p : ℝ) ^ j ≤ (N / p ^ j : ℕ) + 1 := by
                simpa only [Nat.cast_pow] using hqend
              linarith
            rw [originalScoreMass_eq_mass_mul_primeMean hN hq.pos hy]
            ring
  unfold originalCrossMoment crossMoment
  rw [hraw]
  ring

/-- The complete, untruncated mean of the published p-adic score on the
actual integer cutoff law. -/
def fullScoreMean (N p : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n * fullPrimeScore p n) /
    cutoffMass N x

/-- The complete two-score moment before cofactor reindexing. -/
def fullCrossMoment (N p q : ℕ) (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 N,
      cutoffWeight x n * fullPrimeScore p n * fullPrimeScore q n) /
    cutoffMass N x

theorem fullScoreMean_eq_primeMean {N p : ℕ} {x : ℝ}
    (hp : p.Prime) (hx : x ≤ (N : ℝ) + 1) :
    fullScoreMean N p x = primeMean N N p x := by
  have hs : fullScoreMean N p x = originalPrimeMean N N p x := by
    unfold fullScoreMean originalPrimeMean
    congr 1
    apply Finset.sum_congr rfl
    intro n hn
    rw [primeScore_eq_fullPrimeScore hp (Finset.mem_Icc.mp hn).1
      (Finset.mem_Icc.mp hn).2]
  rw [hs]
  exact originalPrimeMean_eq_primeMean hp.pos hx

theorem fullCrossMoment_eq_crossMoment {N p q : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hx : x ≤ (N : ℝ) + 1) :
    fullCrossMoment N p q x = crossMoment N N p q x := by
  have hs : fullCrossMoment N p q x = originalCrossMoment N N p q x := by
    unfold fullCrossMoment originalCrossMoment
    congr 1
    apply Finset.sum_congr rfl
    intro n hn
    rw [primeScore_eq_fullPrimeScore hp (Finset.mem_Icc.mp hn).1
      (Finset.mem_Icc.mp hn).2]
    rw [primeScore_eq_fullPrimeScore hq (Finset.mem_Icc.mp hn).1
      (Finset.mem_Icc.mp hn).2]
  rw [hs]
  exact originalCrossMoment_eq_crossMoment hN hp hq hpq hx

/-- Covariance using the complete finite prime-power cross moment. -/
def crossCovariance (N J p q : ℕ) (x : ℝ) : ℝ :=
  crossMoment N J p q x - primeMean N J p x * primeMean N J q x

/-- Equation (6): the exact finite size-bias covariance identity. -/
theorem negative_crossCovariance_eq (N J p q : ℕ) (x : ℝ)
    :
    -crossCovariance N J p q x =
      Real.log p / cutoffMass N x *
        ∑ j ∈ Finset.Icc 1 J,
          (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
            (primeMean N J q x - primeMean N J q (x / (p : ℝ) ^ j)) := by
  unfold crossCovariance crossMoment
  rw [show primeMean N J p x =
      Real.log p / cutoffMass N x *
        ∑ j ∈ Finset.Icc 1 J,
          (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) from rfl]
  simp_rw [mul_sub]
  rw [Finset.sum_sub_distrib]
  simp only [← Finset.sum_mul]
  ring

/-- Equation (6) for the original full cutoff random variables: no
prime-power row is omitted. The strict covariance sign additionally
requires the cutoff-mean monotonicity proved analytically in the written
note, but not assumed in this exact identity. -/
theorem negative_fullCovariance_eq {N p q : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hp : p.Prime) (hq : q.Prime) (hpq : p ≠ q)
    (hx : x ≤ (N : ℝ) + 1) :
    -(fullCrossMoment N p q x -
        fullScoreMean N p x * fullScoreMean N q x) =
      Real.log p / cutoffMass N x *
        ∑ j ∈ Finset.Icc 1 N,
          (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
            (fullScoreMean N q x -
              fullScoreMean N q (x / (p : ℝ) ^ j)) := by
  rw [fullCrossMoment_eq_crossMoment hN hp hq hpq hx,
    fullScoreMean_eq_primeMean hp hx,
    fullScoreMean_eq_primeMean hq hx]
  have hqmean (j : ℕ) :
      fullScoreMean N q (x / (p : ℝ) ^ j) =
        primeMean N N q (x / (p : ℝ) ^ j) := by
    have ha : 0 < p ^ j := pow_pos hp.pos j
    have hy : x / (p : ℝ) ^ j ≤ (N : ℝ) + 1 := by
      have hqend := cutoff_dilated_endpoint (N := N) (a := p ^ j) ha hx
      have hdiv : N / p ^ j ≤ N := Nat.div_le_self N (p ^ j)
      have hdivR : ((N / p ^ j : ℕ) : ℝ) ≤ N := by exact_mod_cast hdiv
      have hy' : x / (p : ℝ) ^ j ≤ (N / p ^ j : ℕ) + 1 := by
        simpa only [Nat.cast_pow] using hqend
      linarith
    exact fullScoreMean_eq_primeMean hq hy
  simp_rw [hqmean]
  exact negative_crossCovariance_eq N N p q x

/-- The strict pairwise sign follows from the exact finite identity under
the explicitly named monotonicity of the other prime's actual cutoff mean.
The independent analytic/finite-grid proof of that monotonicity is not
imported into this module. -/
theorem crossCovariance_neg_of_primeMean_monotone
    {N J p q : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hJ : 1 ≤ J) (hp : 1 < p) (hxp : (p : ℝ) < x)
    (hmono : ∀ j ∈ Finset.Icc 1 J,
      primeMean N J q (x / (p : ℝ) ^ j) ≤ primeMean N J q x)
    (hstrict : primeMean N J q (x / p) < primeMean N J q x) :
    crossCovariance N J p q x < 0 := by
  have hx : 1 < x := lt_trans (by exact_mod_cast hp) hxp
  have hZ : 0 < cutoffMass N x := cutoffMass_pos hN hx
  have hlog : 0 < Real.log (p : ℝ) := Real.log_pos (by exact_mod_cast hp)
  have hsum : 0 < ∑ j ∈ Finset.Icc 1 J,
      (p : ℝ) ^ j * cutoffMass N (x / (p : ℝ) ^ j) *
        (primeMean N J q x - primeMean N J q (x / (p : ℝ) ^ j)) := by
    apply Finset.sum_pos'
    · intro j hj
      apply mul_nonneg
      · apply mul_nonneg
        · positivity
        · exact cutoffMass_nonneg N _
      · exact sub_nonneg.mpr (hmono j hj)
    · refine ⟨1, Finset.mem_Icc.mpr ⟨le_refl _, hJ⟩, ?_⟩
      have hp0 : (0 : ℝ) < p := by exact_mod_cast (lt_trans Nat.zero_lt_one hp)
      have hpx : 1 < x / (p : ℝ) := (one_lt_div hp0).mpr hxp
      have hzp : 0 < cutoffMass N (x / (p : ℝ)) := cutoffMass_pos hN hpx
      have hd : 0 < primeMean N J q x - primeMean N J q (x / p) := sub_pos.mpr hstrict
      simpa using mul_pos (mul_pos (by positivity) hzp) hd
  have hneg : 0 < -crossCovariance N J p q x := by
    rw [negative_crossCovariance_eq]
    exact mul_pos (div_pos hlog hZ) hsum
  linarith

end
end BuildingBlocks.ActualPrimeCutoffCovarianceFinite

#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceFinite.negative_crossCovariance_eq
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceFinite.cutoffWeight_dilate
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceFinite.crossCovariance_neg_of_primeMean_monotone
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceFinite.negative_fullCovariance_eq
#print axioms BuildingBlocks.ActualPrimeCutoffCovarianceFinite.fullCrossMoment_eq_crossMoment
