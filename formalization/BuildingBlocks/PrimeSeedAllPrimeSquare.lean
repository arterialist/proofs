import BuildingBlocks.PrimeSeedPointwise

/-! Elementary square integrability of the actual all-prime seed. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.PrimeSeedMass

theorem finite_prime_square_integer_tail (S : Finset Nat.Primes) (K : ℕ) (hK : 1 ≤ K)
    (hlo : ∀ p ∈ S, K < (p : ℕ)) :
    (∑ p ∈ S, 1 / (p : ℝ) ^ 2) ≤ 1 / (K : ℝ) := by
  classical
  let e : S → ℕ := fun p => (p.val : ℕ) - (K + 1)
  have heq (p : S) : e p + (K + 1) = (p.val : ℕ) := by
    dsimp [e]
    exact Nat.sub_add_cancel (hlo p.val p.property)
  have hinj : Function.Injective e := by
    intro a b h
    apply Subtype.ext
    apply Subtype.ext
    have ha := heq a
    have hb := heq b
    omega
  have hg : Summable (fun j : ℕ => 1 / ((j : ℝ) + (K + 1 : ℕ)) ^ 2) := by
    have hs : Summable (fun n : ℕ => 1 / (n : ℝ) ^ 2) :=
      summable_one_div_nat_pow.mpr (by decide : 1 < 2)
    convert hs.comp_injective (i := fun j => j + (K + 1))
      (fun _ _ h => Nat.add_right_cancel h) using 1
    ext j
    simp only [Function.comp_def, Nat.cast_add]
  have hfin : Summable (fun p : S => 1 / (p.val : ℝ) ^ 2) :=
    summable_of_finite_support (Set.toFinite _)
  have h := Summable.tsum_le_tsum_of_inj
    (f := fun p : S => 1 / (p.val : ℝ) ^ 2) e hinj (fun _ _ => by positivity)
    (fun p => by
      have he : (e p : ℝ) + (K + 1 : ℕ) = (p.val : ℝ) := by exact_mod_cast heq p
      rw [he]) hfin hg
  have hsum : (∑' p : S, 1 / (p.val : ℝ) ^ 2) = ∑ p ∈ S, 1 / (p : ℝ) ^ 2 := by
    rw [tsum_fintype]
    exact Finset.sum_attach S (fun p : Nat.Primes => 1 / (p : ℝ) ^ 2)
  rw [hsum] at h
  have hb : (∑' j : ℕ, 1 / ((j : ℝ) + (K + 1 : ℕ)) ^ 2) ≤ 1 / (K : ℝ) := by
    simpa only [Nat.cast_add, Nat.cast_one, add_sub_cancel_right] using
      reciprocal_square_tail_le (K + 1) (by omega)
  exact h.trans hb

theorem finite_prime_cube_tail (S : Finset Nat.Primes) {Z : ℝ} (hZ : 2 ≤ Z)
    (hlo : ∀ p ∈ S, Z < (p : ℝ)) :
    (∑ p ∈ S, 1 / (p : ℝ) ^ 3) ≤ 4 / Z ^ 2 := by
  let K := ⌊Z⌋₊
  have hZ0 : 0 < Z := by linarith
  have hK : 1 ≤ K := (Nat.le_floor_iff hZ0.le).2 (by norm_num; linarith)
  have hK0 : (0 : ℝ) < K := by exact_mod_cast (show 0 < K by omega)
  have hKZ : (K : ℝ) ≤ Z := Nat.floor_le hZ0.le
  have hlow : ∀ p ∈ S, K < (p : ℕ) := by
    intro p hp
    exact_mod_cast hKZ.trans_lt (hlo p hp)
  have hZK : Z ≤ 2 * (K : ℝ) := by
    have hfloor : Z < (K : ℝ) + 1 := Nat.lt_floor_add_one Z
    have hKr : (1 : ℝ) ≤ K := by exact_mod_cast hK
    linarith
  calc
    _ ≤ ∑ p ∈ S, (1 / (K : ℝ)) * (1 / (p : ℝ) ^ 2) := by
      apply Finset.sum_le_sum
      intro p hp
      have hp0 : (0 : ℝ) < p := lt_trans hZ0 (hlo p hp)
      have hKp : (K : ℝ) ≤ p := hKZ.trans (hlo p hp).le
      rw [one_div_mul_one_div]
      apply div_le_div_of_nonneg_left (by norm_num) (mul_pos hK0 (sq_pos_of_pos hp0))
      nlinarith [mul_le_mul_of_nonneg_right hKp (sq_nonneg (p : ℝ))]
    _ = (1 / (K : ℝ)) * ∑ p ∈ S, 1 / (p : ℝ) ^ 2 := (Finset.mul_sum _ _ _).symm
    _ ≤ (1 / (K : ℝ)) * (1 / (K : ℝ)) :=
      mul_le_mul_of_nonneg_left (finite_prime_square_integer_tail S K hK hlow) (by positivity)
    _ ≤ 4 / Z ^ 2 := by
      rw [one_div_mul_one_div]
      apply (div_le_div_iff₀ (mul_pos hK0 hK0) (sq_pos_of_pos hZ0)).mpr
      have hs := (sq_le_sq₀ hZ0.le (by positivity)).mpr hZK
      nlinarith

theorem finite_prime_card_le (S : Finset Nat.Primes) {Z : ℝ} (hZ : 0 ≤ Z)
    (hhi : ∀ p ∈ S, (p : ℝ) ≤ Z) : (S.card : ℝ) ≤ Z := by
  classical
  have hs : S.image (fun p : Nat.Primes => (p : ℕ)) ⊆ Finset.Icc 1 ⌊Z⌋₊ := by
    intro n hn
    obtain ⟨p, hp, rfl⟩ := Finset.mem_image.mp hn
    exact Finset.mem_Icc.mpr ⟨p.property.one_lt.le, Nat.le_floor (hhi p hp)⟩
  have hc := Finset.card_le_card hs
  rw [Finset.card_image_of_injective S Subtype.val_injective, Nat.card_Icc] at hc
  have hn : S.card ≤ ⌊Z⌋₊ := by simpa using hc
  exact (by exact_mod_cast hn : (S.card : ℝ) ≤ ⌊Z⌋₊).trans (Nat.floor_le hZ)

theorem finite_seed_small_region (S : Finset Nat.Primes) (v : ℝ)
    (hhi : ∀ p ∈ S, (p : ℝ) ≤ exp (v / 3)) :
    finitePrimeSeed S v ≤ exp (-v / 6) := by
  calc
    _ ≤ ∑ _p ∈ S, exp (-v / 2) := by
      apply Finset.sum_le_sum
      intro p _
      exact seed_le_exp_neg_half (log_pos (by exact_mod_cast p.property.one_lt)) v
    _ = (S.card : ℝ) * exp (-v / 2) := by simp only [Finset.sum_const, nsmul_eq_mul]
    _ ≤ exp (v / 3) * exp (-v / 2) :=
      mul_le_mul_of_nonneg_right (finite_prime_card_le S (exp_pos _).le hhi) (exp_pos _).le
    _ = _ := by rw [← exp_add]; congr 1; ring

theorem finite_seed_middle_region (S : Finset Nat.Primes) {v : ℝ}
    (hv : 3 * log 2 ≤ v) (hlo : ∀ p ∈ S, exp (v / 3) < (p : ℝ))
    (hhi : ∀ p ∈ S, (p : ℝ) ≤ exp (v / 2)) :
    finitePrimeSeed S v ≤ 4 * exp (-v / 6) := by
  have hZ : 2 ≤ exp (v / 3) := by
    have h := exp_le_exp.mpr (show log (2 : ℝ) ≤ v / 3 by linarith)
    simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using h
  have heq : finitePrimeSeed S v = exp (v / 2) * ∑ p ∈ S, 1 / (p : ℝ) ^ 3 := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro p hp
    have hp1 : (1 : ℝ) < p := by exact_mod_cast p.property.one_lt
    have hloghi := log_le_log (by linarith : (0 : ℝ) < p) (hhi p hp)
    have hloglo := log_lt_log (exp_pos (v / 3)) (hlo p hp)
    rw [log_exp] at hloghi hloglo
    rw [prime_seed_second_envelope hp1 (by linarith) (by linarith)]
    ring
  rw [heq]
  calc
    _ ≤ exp (v / 2) * (4 / exp (v / 3) ^ 2) :=
      mul_le_mul_of_nonneg_left (finite_prime_cube_tail S hZ hlo) (exp_pos _).le
    _ = _ := by
      rw [pow_two, ← exp_add]
      have he : exp (v / 2) / exp (v / 3 + v / 3) = exp (-v / 6) := by
        rw [← exp_sub]
        congr 1
        ring
      calc
        _ = 4 * (exp (v / 2) / exp (v / 3 + v / 3)) := by ring
        _ = _ := by rw [he]

theorem finite_seed_large_region (S : Finset Nat.Primes) {v : ℝ}
    (hv : 3 * log 2 ≤ v) (hlo : ∀ p ∈ S, exp (v / 2) < (p : ℝ)) :
    finitePrimeSeed S v ≤ (64 * log 2) / v := by
  have hv0 : 0 < v := lt_of_lt_of_le (by positivity) hv
  have hY : 2 ≤ exp (v / 2) := by
    have hL : 0 < log (2 : ℝ) := log_pos (by norm_num)
    have h := exp_le_exp.mpr (show log (2 : ℝ) ≤ v / 2 by linarith)
    simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using h
  calc
    _ ≤ exp (v / 2) * ∑ p ∈ S, 1 / (p : ℝ) ^ 2 := by
      rw [Finset.mul_sum]
      apply Finset.sum_le_sum
      intro p hp
      have hp1 : (1 : ℝ) < p := by exact_mod_cast p.property.one_lt
      have hlog := log_lt_log (exp_pos (v / 2)) (hlo p hp)
      rw [log_exp] at hlog
      simpa only [div_eq_mul_inv, one_mul] using prime_seed_first_envelope hp1 (by linarith)
    _ ≤ exp (v / 2) * ((32 * log 2) / (exp (v / 2) * log (exp (v / 2)))) :=
      mul_le_mul_of_nonneg_left (finite_prime_square_tail S hY hlo) (exp_pos _).le
    _ = _ := by
      rw [log_exp]
      field_simp
      norm_num

theorem finite_seed_three_region_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    finitePrimeSeed S v ≤ (64 * log 2) / v + 5 * exp (-v / 6) := by
  classical
  let A := S.filter (fun p : Nat.Primes => (p : ℝ) ≤ exp (v / 3))
  let T := S.filter (fun p : Nat.Primes => ¬ (p : ℝ) ≤ exp (v / 3))
  let M := T.filter (fun p : Nat.Primes => (p : ℝ) ≤ exp (v / 2))
  let D := T.filter (fun p : Nat.Primes => ¬ (p : ℝ) ≤ exp (v / 2))
  have ha := finite_seed_small_region A v (fun p hp => (Finset.mem_filter.mp hp).2)
  have hm := finite_seed_middle_region M hv
    (fun p hp => lt_of_not_ge (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).2)
    (fun p hp => (Finset.mem_filter.mp hp).2)
  have hd := finite_seed_large_region D hv
    (fun p hp => lt_of_not_ge (Finset.mem_filter.mp hp).2)
  have h1 : finitePrimeSeed A v + finitePrimeSeed T v = finitePrimeSeed S v :=
    Finset.sum_filter_add_sum_filter_not S (fun p => (p : ℝ) ≤ exp (v / 3))
      (fun p => seed (log p) v)
  have h2 : finitePrimeSeed M v + finitePrimeSeed D v = finitePrimeSeed T v :=
    Finset.sum_filter_add_sum_filter_not T (fun p => (p : ℝ) ≤ exp (v / 2))
      (fun p => seed (log p) v)
  linarith

theorem age_mul_exp_neg_sixth_le (v : ℝ) : v * exp (-v / 6) ≤ 6 := by
  have he := add_one_le_exp (v / 6)
  rw [show -v / 6 = -(v / 6) by ring, exp_neg]
  apply (mul_inv_le_iff₀ (exp_pos (v / 6))).mpr
  linarith

theorem finite_seed_age_bound (S : Finset Nat.Primes) {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * finitePrimeSeed S v ≤ 64 * log 2 + 30 := by
  have hv0 : 0 < v := lt_of_lt_of_le (by positivity) hv
  calc
    _ ≤ v * ((64 * log 2) / v + 5 * exp (-v / 6)) :=
      mul_le_mul_of_nonneg_left (finite_seed_three_region_bound S hv) hv0.le
    _ = 64 * log 2 + 5 * (v * exp (-v / 6)) := by field_simp
    _ ≤ _ := by linarith [age_mul_exp_neg_sixth_le v]

theorem allPrimeSeed_eq_finite_support_sum (v : ℝ) :
    allPrimeSeed v = finitePrimeSeed (seed_prime_finite_support v).toFinset v := by
  classical
  unfold allPrimeSeed finitePrimeSeed
  apply tsum_eq_sum
  intro p hp
  simpa only [Set.Finite.mem_toFinset, Function.mem_support, not_not] using hp

theorem allPrimeSeed_age_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    v * allPrimeSeed v ≤ 64 * log 2 + 30 := by
  rw [allPrimeSeed_eq_finite_support_sum]
  exact finite_seed_age_bound _ hv

theorem allPrimeSeed_nonneg (v : ℝ) : 0 ≤ allPrimeSeed v :=
  tsum_nonneg (fun p => seed_nonneg (log p) v)

theorem measurable_allPrimeSeed : Measurable allPrimeSeed := by
  have hm := Measurable.ennreal_tsum (fun p : Nat.Primes =>
    (measurable_seed (log p)).ennreal_ofReal)
  have he (v : ℝ) : ENNReal.ofReal (allPrimeSeed v) =
      ∑' p : Nat.Primes, ENNReal.ofReal (seed (log p) v) :=
    ENNReal.ofReal_tsum_of_nonneg (fun p => seed_nonneg (log p) v)
      (summable_of_finite_support (seed_prime_finite_support v))
  convert hm.ennreal_toReal using 1
  funext v
  rw [← he, ENNReal.toReal_ofReal (allPrimeSeed_nonneg v)]

theorem allPrimeSeed_div_age_nonneg (v : ℝ) : 0 ≤ allPrimeSeed v / v := by
  rw [allPrimeSeed_div_age]
  apply tsum_nonneg
  intro p
  exact seed_div_age_nonneg (log_pos (by exact_mod_cast p.property.one_lt)) v

/-- The previously formalized actual finite activity is the needed integrable
majorant; the collective seed itself still has infinite first moment. -/
theorem integrable_allPrimeSeed_div_age : Integrable (fun v => allPrimeSeed v / v) := by
  refine ⟨(measurable_allPrimeSeed.div measurable_id).aestronglyMeasurable, ?_⟩
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall allPrimeSeed_div_age_nonneg)]
  have he := congrArg (fun μ : Measure ℝ => μ univ) allPrimeLevyMeasure_eq_withDensity
  dsimp only at he
  rw [withDensity_apply _ MeasurableSet.univ] at he
  simp only [setLIntegral_univ] at he
  rw [← he]
  exact measure_lt_top _ _

theorem allPrimeSeed_eq_earlier_support (A : ℝ) {v : ℝ} (hv : v ≤ A) :
    allPrimeSeed v = finitePrimeSeed (seed_prime_finite_support A).toFinset v := by
  classical
  unfold allPrimeSeed finitePrimeSeed
  apply tsum_eq_sum
  intro p hp
  have hz : seed (log p) A = 0 := by
    simpa only [Set.Finite.mem_toFinset, Function.mem_support, not_not] using hp
  have hA : A < log (p : ℝ) := by
    by_contra h
    rw [seed, if_pos (le_of_not_gt h)] at hz
    exact exp_ne_zero _ hz
  exact seed_eq_zero (hv.trans_lt hA)

theorem allPrimeSeed_square_tail_bound {v : ℝ} (hv : 3 * log 2 ≤ v) :
    allPrimeSeed v ^ 2 ≤ (64 * log 2 + 30) * (allPrimeSeed v / v) := by
  have hv0 : 0 < v := lt_of_lt_of_le (by positivity) hv
  have h := mul_le_mul_of_nonneg_right (allPrimeSeed_age_bound hv) (allPrimeSeed_nonneg v)
  rw [← mul_div_assoc]
  apply (le_div_iff₀ hv0).mpr
  convert h using 1 <;> ring

/-- Actual all-prime square integrability from Chebyshev and finite activity.
Every floor cell is retained. No prime number theorem or RH input occurs. -/
theorem integrable_allPrimeSeed_square : Integrable (fun v => allPrimeSeed v ^ 2) := by
  classical
  let S := (seed_prime_finite_support (3 * log 2)).toFinset
  have hS := (finitePrimeSeed_memLp_two S).integrable_sq
  have hD := integrable_allPrimeSeed_div_age.const_mul (64 * log 2 + 30)
  apply (hS.add hD).mono' (measurable_allPrimeSeed.pow_const 2).aestronglyMeasurable
  apply Filter.Eventually.of_forall
  intro v
  rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
  change allPrimeSeed v ^ 2 ≤ finitePrimeSeed S v ^ 2 + (64 * log 2 + 30) * (allPrimeSeed v / v)
  by_cases hv : 3 * log 2 ≤ v
  · exact (allPrimeSeed_square_tail_bound hv).trans (le_add_of_nonneg_left (sq_nonneg _))
  · rw [allPrimeSeed_eq_earlier_support (3 * log 2) (le_of_not_ge hv)]
    exact le_add_of_nonneg_right (mul_nonneg (by positivity)
      (by simpa only [← allPrimeSeed_eq_earlier_support (3 * log 2) (le_of_not_ge hv)] using
        allPrimeSeed_div_age_nonneg v))

theorem allPrimeSeed_memLp_two : MemLp allPrimeSeed 2 volume :=
  (memLp_two_iff_integrable_sq measurable_allPrimeSeed.aestronglyMeasurable).2
    integrable_allPrimeSeed_square

end BuildingBlocks.PrimeSeedMass
