import BuildingBlocks.PrimeSeedAllPrimeLevy

/-! Quantitative dyadic tails of the actual prime activity majorant. -/

open MeasureTheory Real
open scoped MeasureTheory ENNReal

namespace BuildingBlocks.PrimeSeedMass

theorem reciprocal_square_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, 1 / ((j : ℝ) + K) ^ 2) ≤ 1 / ((K : ℝ) - 1) := by
  have hK' : (2 : ℝ) ≤ K := by exact_mod_cast hK
  have hs (j : ℕ) : 1 / ((j : ℝ) + K) ^ 2 ≤
      1 / ((j : ℝ) + K - 1) - 1 / ((j : ℝ) + K) := by
    have hj : (0 : ℝ) ≤ j := Nat.cast_nonneg j
    have hx : 0 < (j : ℝ) + K := by linarith
    have hx1 : 0 < (j : ℝ) + K - 1 := by linarith
    have heq : 1 / ((j : ℝ) + K - 1) - 1 / ((j : ℝ) + K) =
        1 / (((j : ℝ) + K - 1) * ((j : ℝ) + K)) := by
      field_simp
      ring
    rw [heq]
    apply div_le_div_of_nonneg_left (by norm_num) (mul_pos hx1 hx)
    nlinarith
  have hp (N : ℕ) : (∑ j ∈ Finset.range N, 1 / ((j : ℝ) + K) ^ 2) ≤
      1 / ((K : ℝ) - 1) - 1 / ((N : ℝ) + K - 1) := by
    induction N with
    | zero => simp
    | succ N ih =>
      rw [Finset.sum_range_succ]
      have h := add_le_add ih (hs N)
      convert h using 1 <;> (push_cast; ring)
  apply Real.tsum_le_of_sum_range_le (fun _ => by positivity)
  intro N
  apply (hp N).trans
  exact sub_le_self _ (one_div_nonneg.mpr (by
    have := Nat.cast_nonneg (α := ℝ) N
    linarith))

/-- Complete dyadic shells after `K` have a uniform `1/(K-1)` bound.
Every prime in each shell is included with its actual logarithmic weight. -/
theorem dyadic_prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' j : ℕ, ∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) / ((K : ℝ) - 1) := by
  have hC : 0 ≤ 8 / log 2 := by positivity
  have hbase : Summable (fun j : ℕ => 1 / ((j : ℝ) + K) ^ 2) := by
    have h : Summable (fun n : ℕ => 1 / (n : ℝ) ^ 2) := summable_one_div_nat_pow.mpr (by decide : 1 < 2)
    have hc := h.comp_injective (i := fun j => j + K)
      (fun _ _ h => Nat.add_right_cancel h)
    convert hc using 1
    ext j
    simp [Nat.cast_add]
  have htarget := hbase.mul_left (8 / log 2)
  have hnonneg (j : ℕ) :
      0 ≤ ∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val) := by
    apply tsum_nonneg
    intro p
    have hp : (1 : ℝ) < p.val := by exact_mod_cast p.val.property.one_lt
    exact (one_div_pos.mpr (mul_pos (by linarith) (log_pos hp))).le
  have hbound (j : ℕ) :
      (∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val)) ≤
        (8 / log 2) * (1 / ((j : ℝ) + K) ^ 2) := by
    simpa only [Nat.cast_add] using logFiber_weight_le (k := j + K) (by omega)
  have hsource := htarget.of_norm_bounded (fun j => by
    rw [Real.norm_eq_abs, abs_of_nonneg (hnonneg j)]
    exact hbound j)
  calc
    (∑' j : ℕ, ∑' p : logFiber (j + K), 1 / ((p.val : ℝ) * log p.val)) ≤
        ∑' j : ℕ, (8 / log 2) * (1 / ((j : ℝ) + K) ^ 2) :=
      hsource.tsum_le_tsum hbound htarget
    _ = (8 / log 2) * ∑' j : ℕ, 1 / ((j : ℝ) + K) ^ 2 := tsum_mul_left
    _ ≤ (8 / log 2) * (1 / ((K : ℝ) - 1)) :=
      mul_le_mul_of_nonneg_left (reciprocal_square_tail_le K hK) hC
    _ = _ := by ring

/-- The dyadic decomposition retains every prime beyond the literal cutoff. -/
noncomputable def primeTailEquiv (K : ℕ) :
    (Σ j : ℕ, logFiber (j + K)) ≃ {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)} where
  toFun a := ⟨a.2.val, by
    have h := Nat.pow_log_le_self 2 a.2.val.property.ne_zero
    have he : Nat.log 2 (a.2.val : ℕ) = a.1 + K := a.2.property
    rw [he] at h
    exact (Nat.pow_le_pow_right (by decide : 0 < 2) (by omega : K ≤ a.1 + K)).trans h⟩
  invFun p := ⟨Nat.log 2 (p.val : ℕ) - K, ⟨p.val, by
    change Nat.log 2 (p.val : ℕ) = Nat.log 2 (p.val : ℕ) - K + K
    exact (Nat.sub_add_cancel (Nat.le_log_of_pow_le (by decide) p.property)).symm⟩⟩
  left_inv a := by
    rcases a with ⟨j, p⟩
    have he : Nat.log 2 (p.val : ℕ) = j + K := p.property
    apply Sigma.ext (show Nat.log 2 (p.val : ℕ) - K = j from by omega)
    apply (Subtype.heq_iff_coe_eq (by
      intro x
      change Nat.log 2 (x : ℕ) = Nat.log 2 (p.val : ℕ) - K + K ↔
        Nat.log 2 (x : ℕ) = j + K
      omega)).mpr
    rfl
  right_inv p := by rfl

theorem prime_activity_tail_le (K : ℕ) (hK : 2 ≤ K) :
    (∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
      1 / ((p.val : ℝ) * log p.val)) ≤ (8 / log 2) / ((K : ℝ) - 1) := by
  have hs := summable_prime_reciprocal_mul_log.subtype
    (fun p : Nat.Primes => 2 ^ K ≤ (p : ℕ))
  have he := (primeTailEquiv K).tsum_eq
    (fun p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)} =>
      1 / ((p.val : ℝ) * log p.val))
  have hh := hs.comp_injective (primeTailEquiv K).injective
  rw [← he]
  change Summable (fun a : Σ j : ℕ, logFiber (j + K) =>
    1 / ((a.2.val : ℝ) * log a.2.val)) at hh
  change (∑' a : Σ j : ℕ, logFiber (j + K),
    1 / ((a.2.val : ℝ) * log a.2.val)) ≤ _
  rw [hh.tsum_sigma]
  exact dyadic_prime_activity_tail_le K hK

/-- The omitted measure contains every complete prime history with `P ≤ p`. -/
noncomputable def primeTailLevyMeasure (P : ℕ) : Measure ℝ :=
  Measure.sum (fun p : {p : Nat.Primes // P ≤ (p : ℕ)} => levyMeasure {p.val})

theorem primeTailLevyMeasure_mass (P : ℕ) :
    primeTailLevyMeasure P Set.univ = ENNReal.ofReal
      (∑' p : {p : Nat.Primes // P ≤ (p : ℕ)}, ∫ v, seed (log p.val) v / v) := by
  rw [primeTailLevyMeasure, Measure.sum_apply _ MeasurableSet.univ]
  simp_rw [singleton_levyMeasure_mass]
  exact (ENNReal.ofReal_tsum_of_nonneg (fun p => integral_nonneg
    (seed_div_age_nonneg (log_pos (by exact_mod_cast p.val.property.one_lt))))
    (summable_prime_levy_masses.subtype _)).symm

instance primeTailLevyMeasure_isFiniteMeasure (P : ℕ) :
    IsFiniteMeasure (primeTailLevyMeasure P) := by
  constructor
  rw [primeTailLevyMeasure_mass]
  exact ENNReal.ofReal_lt_top

/-- An explicit unconditional activity tail for the actual omitted prime measure. -/
theorem primeTailLevyMeasure_mass_le (K : ℕ) (hK : 2 ≤ K) :
    primeTailLevyMeasure (2 ^ K) Set.univ ≤
      ENNReal.ofReal ((16 / log 2) / ((K : ℝ) - 1)) := by
  rw [primeTailLevyMeasure_mass]
  apply ENNReal.ofReal_le_ofReal
  have hs := (summable_prime_reciprocal_mul_log.subtype
    (fun p : Nat.Primes => 2 ^ K ≤ (p : ℕ))).mul_left 2
  calc
    (∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)}, ∫ v, seed (log p.val) v / v) ≤
        ∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
          2 * (1 / ((p.val : ℝ) * log p.val)) :=
      (summable_prime_levy_masses.subtype _).tsum_le_tsum
        (fun p => prime_levy_mass_le p.val) hs
    _ = 2 * ∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
          1 / ((p.val : ℝ) * log p.val) := tsum_mul_left
    _ ≤ 2 * ((8 / log 2) / ((K : ℝ) - 1)) :=
      mul_le_mul_of_nonneg_left (prime_activity_tail_le K hK) (by norm_num)
    _ = _ := by ring

/-- Finite cutoff and omitted histories split the all-prime measure exactly. -/
theorem allPrimeLevyMeasure_cutoff_split (P : ℕ) :
    (Measure.sum (fun p : {p : Nat.Primes // (p : ℕ) < P} => levyMeasure {p.val})) +
      primeTailLevyMeasure P = allPrimeLevyMeasure := by
  have he : {p : Nat.Primes | (p : ℕ) < P}ᶜ = {p : Nat.Primes | P ≤ (p : ℕ)} := by
    ext p
    simp
  have h := Measure.sum_add_sum_compl {p : Nat.Primes | (p : ℕ) < P}
    (fun p => levyMeasure {p})
  rw [he] at h
  exact h

theorem primeTailLevyMeasure_mass_antitone {P Q : ℕ} (hPQ : P ≤ Q) :
    primeTailLevyMeasure Q Set.univ ≤ primeTailLevyMeasure P Set.univ := by
  rw [primeTailLevyMeasure_mass, primeTailLevyMeasure_mass]
  apply ENNReal.ofReal_le_ofReal
  exact Summable.tsum_le_tsum_of_inj
    (fun p : {p : Nat.Primes // Q ≤ (p : ℕ)} =>
      (⟨p.val, hPQ.trans p.property⟩ : {p : Nat.Primes // P ≤ (p : ℕ)}))
    (fun _ _ h => Subtype.ext (congrArg
      (fun p : {p : Nat.Primes // P ≤ (p : ℕ)} => p.val) h))
    (fun p _ => integral_nonneg (seed_div_age_nonneg
      (log_pos (by exact_mod_cast p.val.property.one_lt))))
    (fun _ => le_rfl)
    (summable_prime_levy_masses.subtype _) (summable_prime_levy_masses.subtype _)

/-- The cutoff bound in its usual logarithmic form, with an explicit constant. -/
theorem primeTailLevyMeasure_mass_le_log (P : ℕ) (hP : 8 ≤ P) :
    primeTailLevyMeasure P Set.univ ≤ ENNReal.ofReal (32 / log (P : ℝ)) := by
  let K := Nat.log 2 P
  have hK : 3 ≤ K := Nat.le_log_of_pow_le (by decide) hP
  have hlow : 2 ^ K ≤ P := Nat.pow_log_le_self 2 (by omega)
  have hupper : P < 2 ^ (K + 1) := Nat.lt_pow_succ_log_self (by decide) P
  have hlog2 : 0 < log 2 := log_pos (by norm_num)
  have hlogP : 0 < log (P : ℝ) := log_pos (by exact_mod_cast (by omega : 1 < P))
  have hlogUpper : log (P : ℝ) ≤ ((K : ℝ) + 1) * log 2 := by
    have hp : (0 : ℝ) < P := by exact_mod_cast (by omega : 0 < P)
    have hpow : (P : ℝ) ≤ (2 : ℝ) ^ (K + 1) := by exact_mod_cast hupper.le
    have h := log_le_log hp hpow
    simpa only [log_pow, Nat.cast_add, Nat.cast_one] using h
  have hK' : (3 : ℝ) ≤ K := by exact_mod_cast hK
  calc
    primeTailLevyMeasure P Set.univ ≤ primeTailLevyMeasure (2 ^ K) Set.univ :=
      primeTailLevyMeasure_mass_antitone hlow
    _ ≤ ENNReal.ofReal ((16 / log 2) / ((K : ℝ) - 1)) :=
      primeTailLevyMeasure_mass_le K (by omega)
    _ ≤ ENNReal.ofReal (32 / log (P : ℝ)) := by
      apply ENNReal.ofReal_le_ofReal
      rw [div_div]
      apply (div_le_div_iff₀ (mul_pos hlog2 (by linarith)) hlogP).mpr
      nlinarith

end BuildingBlocks.PrimeSeedMass
