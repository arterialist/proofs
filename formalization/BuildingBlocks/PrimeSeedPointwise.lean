import BuildingBlocks.PrimeSeedMemory
import BuildingBlocks.PrimeSeedActivityTail

/-! Pointwise envelopes for the literal prime seed. These retain every clock
cell and support the elementary all-prime square-integrability argument. -/

open MeasureTheory Real Set

namespace BuildingBlocks.PrimeSeedMass

/-- The strict upper floor inequality controls all proper-power histories at once. -/
theorem seed_le_exp_neg_half {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v ≤ exp (-v / 2) := by
  by_cases hv : v < L
  · rw [seed_eq_zero hv]
    exact (exp_pos _).le
  · have hfloor := Nat.lt_floor_add_one (v / L)
    have hlt : v < (⌊v / L⌋₊ + 1 : ℝ) * L := (div_lt_iff₀ hL).mp hfloor
    rw [seed, if_pos (le_of_not_gt hv)]
    apply exp_le_exp.mpr
    linarith

theorem seed_le_first_envelope {L v : ℝ} (hL : 0 < L) (hv : v < 2 * L) :
    seed L v ≤ exp (v / 2 - 2 * L) := by
  by_cases hlo : v < L
  · rw [seed_eq_zero hlo]
    exact (exp_pos _).le
  · have hm : v ∈ Ico (((0 : ℕ) + 1 : ℝ) * L) (((0 : ℕ) + 2 : ℝ) * L) := by
      constructor <;> norm_num <;> linarith
    rw [seed_eq_cellDensity hL 0 hm]
    simp [cellDensity]

theorem seed_second_envelope {L v : ℝ} (hL : 0 < L)
    (hlo : 2 * L ≤ v) (hhi : v < 3 * L) :
    seed L v = exp (v / 2 - 3 * L) := by
  have hm : v ∈ Ico (((1 : ℕ) + 1 : ℝ) * L) (((1 : ℕ) + 2 : ℝ) * L) := by
    constructor <;> norm_num <;> linarith
  rw [seed_eq_cellDensity hL 1 hm]
  norm_num [cellDensity]

theorem prime_seed_first_envelope {p v : ℝ} (hp : 1 < p) (hv : v < 2 * log p) :
    seed (log p) v ≤ exp (v / 2) / p ^ 2 := by
  have h := seed_le_first_envelope (log_pos hp) hv
  have he : exp (2 * log p) = p ^ 2 := by
    rw [show (2 : ℝ) * log p = log p + log p by ring, exp_add,
      exp_log (by linarith : 0 < p)]
    ring
  rwa [exp_sub, he] at h

theorem prime_seed_second_envelope {p v : ℝ} (hp : 1 < p)
    (hlo : 2 * log p ≤ v) (hhi : v < 3 * log p) :
    seed (log p) v = exp (v / 2) / p ^ 3 := by
  rw [seed_second_envelope (log_pos hp) hlo hhi, exp_sub]
  have he : exp (3 * log p) = p ^ 3 := by
    rw [show (3 : ℝ) * log p = log p + log p + log p by ring, exp_add, exp_add,
      exp_log (by linarith : 0 < p)]
    ring
  rw [he]

/-- The weighted square tail on one complete prime shell uses only the
already proved linear bound for the actual von Mangoldt prefix. -/
theorem prime_shell_log_square_le (S : Finset ℕ) (N : ℕ) (hN : 1 ≤ N)
    (hprime : ∀ p ∈ S, p.Prime) (hlo : ∀ p ∈ S, N ≤ p)
    (hhi : ∀ p ∈ S, p ≤ 2 * N) :
    (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) ≤ (8 * log 2) / N := by
  have hN0 : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hs := (sum_log_primes_le_psi S (2 * N) hprime hhi).trans
    (BuildingBlocks.CoarsePrimitive.psi_le_linear (2 * N))
  push_cast at hs
  calc
    _ ≤ ∑ p ∈ S, log (p : ℝ) / (N : ℝ) ^ 2 := by
      apply Finset.sum_le_sum
      intro p hp
      have hp0 : (1 : ℝ) < p := by exact_mod_cast (hprime p hp).one_lt
      have hNp : (N : ℝ) ≤ p := by exact_mod_cast hlo p hp
      apply div_le_div_of_nonneg_left (log_pos hp0).le (sq_pos_of_pos hN0)
      nlinarith
    _ = (∑ p ∈ S, log (p : ℝ)) / (N : ℝ) ^ 2 := (Finset.sum_div _ _ _).symm
    _ ≤ ((4 * log 2) * (2 * (N : ℝ))) / (N : ℝ) ^ 2 :=
      div_le_div_of_nonneg_right hs (sq_nonneg _)
    _ = _ := by field_simp; ring

theorem log_square_le_four_mul {x : ℝ} (hx : 1 < x) : log x ^ 2 ≤ 4 * x := by
  have hx0 : 0 < x := by linarith
  have h := log_le_sub_one_of_pos (sqrt_pos.mpr hx0)
  rw [log_sqrt hx0.le] at h
  have hl : log x ≤ 2 * sqrt x := by linarith
  have hs := (sq_le_sq₀ (log_pos hx).le (by positivity)).mpr hl
  nlinarith [sq_sqrt hx0.le]

theorem summable_prime_log_square :
    Summable (fun p : Nat.Primes => log (p : ℝ) / (p : ℝ) ^ 2) := by
  apply (summable_prime_reciprocal_mul_log.mul_left 4).of_norm_bounded
  intro p
  have hp : (1 : ℝ) < p := by exact_mod_cast p.property.one_lt
  have hp0 : (0 : ℝ) < p := by linarith
  have hl : 0 < log (p : ℝ) := log_pos hp
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  have hs := mul_le_mul_of_nonneg_left (log_square_le_four_mul hp) hp0.le
  apply (div_le_iff₀ (sq_pos_of_pos hp0)).mpr
  have he : 4 * (1 / ((p : ℝ) * log p)) * (p : ℝ) ^ 2 = 4 * (p : ℝ) / log p := by
    field_simp
  rw [he]
  apply (le_div_iff₀ hl).mpr
  simpa only [pow_two] using log_square_le_four_mul hp

theorem logFiber_log_square_le (k : ℕ) :
    (∑' p : logFiber k, log (p.val : ℝ) / (p.val : ℝ) ^ 2) ≤
      (8 * log 2) / (2 : ℝ) ^ k := by
  classical
  letI := (finite_logFiber k).fintype
  let S := Finset.univ.image (fun p : logFiber k => (p.val : ℕ))
  have hinj : Function.Injective (fun p : logFiber k => (p.val : ℕ)) :=
    fun _ _ h => Subtype.ext (Subtype.ext h)
  have hsum : (∑ n ∈ S, log (n : ℝ) / (n : ℝ) ^ 2) =
      ∑ p : logFiber k, log (p.val : ℝ) / (p.val : ℝ) ^ 2 := by
    dsimp [S]
    rw [Finset.sum_image (fun p _ q _ h => hinj h)]
  have hprime : ∀ p ∈ S, p.Prime := by
    intro p hp
    obtain ⟨q, _, rfl⟩ := Finset.mem_image.mp hp
    exact q.val.property
  have hlo : ∀ p ∈ S, 2 ^ k ≤ p := by
    intro p hp
    obtain ⟨q, _, rfl⟩ := Finset.mem_image.mp hp
    have h := Nat.pow_log_le_self 2 q.val.property.ne_zero
    have hq : Nat.log 2 (q.val : ℕ) = k := q.property
    rwa [hq] at h
  have hhi : ∀ p ∈ S, p ≤ 2 * 2 ^ k := by
    intro p hp
    obtain ⟨q, _, rfl⟩ := Finset.mem_image.mp hp
    have h := Nat.lt_pow_succ_log_self (by decide : 1 < 2) (q.val : ℕ)
    have hq : Nat.log 2 (q.val : ℕ) = k := q.property
    rw [hq, Nat.pow_succ, Nat.mul_comm] at h
    exact h.le
  rw [tsum_fintype, ← hsum]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    prime_shell_log_square_le S (2 ^ k) (Nat.one_le_pow k 2 (by decide)) hprime hlo hhi

theorem prime_log_square_dyadic_tail (K : ℕ) :
    (∑' p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)},
      log (p.val : ℝ) / (p.val : ℝ) ^ 2) ≤ (16 * log 2) / (2 : ℝ) ^ K := by
  have hs := summable_prime_log_square.subtype (fun p : Nat.Primes => 2 ^ K ≤ (p : ℕ))
  have he := (primeTailEquiv K).tsum_eq
    (fun p : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)} => log (p.val : ℝ) / (p.val : ℝ) ^ 2)
  have hh := hs.comp_injective (primeTailEquiv K).injective
  rw [← he]
  change Summable (fun a : Σ j : ℕ, logFiber (j + K) =>
    log (a.2.val : ℝ) / (a.2.val : ℝ) ^ 2) at hh
  change (∑' a : Σ j : ℕ, logFiber (j + K), log (a.2.val : ℝ) / (a.2.val : ℝ) ^ 2) ≤ _
  rw [hh.tsum_sigma]
  have hg := (hasSum_geometric_of_lt_one (by norm_num : (0 : ℝ) ≤ 1 / 2)
    (by norm_num : (1 / 2 : ℝ) < 1)).mul_left ((8 * log 2) / (2 : ℝ) ^ K)
  have hb (j : ℕ) :
      (∑' p : logFiber (j + K), log (p.val : ℝ) / (p.val : ℝ) ^ 2) ≤
        ((8 * log 2) / (2 : ℝ) ^ K) * (1 / 2 : ℝ) ^ j := by
    have h := logFiber_log_square_le (j + K)
    convert h using 1
    rw [pow_add, div_pow, one_pow]
    field_simp
  have hb_sum := hh.sigma.tsum_le_tsum hb hg.summable
  rw [hg.tsum_eq] at hb_sum
  convert hb_sum using 1 <;> field_simp <;> ring

theorem finite_prime_log_square_dyadic_tail (S : Finset Nat.Primes) (K : ℕ)
    (hlo : ∀ p ∈ S, 2 ^ K ≤ (p : ℕ)) :
    (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) ≤ (16 * log 2) / (2 : ℝ) ^ K := by
  classical
  let e : S → {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)} := fun p => ⟨p.val, hlo p.val p.property⟩
  have he : Function.Injective e := by
    intro a b h
    apply Subtype.ext
    exact congrArg (fun q : {p : Nat.Primes // 2 ^ K ≤ (p : ℕ)} => q.val) h
  have hfin : Summable (fun p : S => log (p.val : ℝ) / (p.val : ℝ) ^ 2) :=
    summable_of_finite_support (Set.toFinite _)
  have h := Summable.tsum_le_tsum_of_inj
    (f := fun p : S => log (p.val : ℝ) / (p.val : ℝ) ^ 2) e he
    (fun p _ => by
      have hp : (1 : ℝ) < p.val := by exact_mod_cast p.val.property.one_lt
      exact div_nonneg (log_pos hp).le (sq_nonneg _))
    (fun p => le_rfl) hfin
    (summable_prime_log_square.subtype (fun p : Nat.Primes => 2 ^ K ≤ (p : ℕ)))
  have hsum : (∑' p : S, log (p.val : ℝ) / (p.val : ℝ) ^ 2) =
      ∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2 := by
    rw [tsum_fintype]
    exact Finset.sum_attach S (fun p => log (p : ℝ) / (p : ℝ) ^ 2)
  rw [hsum] at h
  exact h.trans (prime_log_square_dyadic_tail K)

theorem finite_prime_log_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) ≤ (32 * log 2) / Y := by
  let N := ⌊Y⌋₊
  let K := Nat.log 2 N
  have hY0 : 0 < Y := by linarith
  have hN : 2 ≤ N := by
    change 2 ≤ ⌊Y⌋₊
    exact (Nat.le_floor_iff hY0.le).2 (by exact_mod_cast hY)
  have hpow : 2 ^ K ≤ N := Nat.pow_log_le_self 2 (by omega : N ≠ 0)
  have hNY : (N : ℝ) ≤ Y := Nat.floor_le hY0.le
  have hNp : ∀ p ∈ S, 2 ^ K ≤ (p : ℕ) := by
    intro p hp
    apply hpow.trans
    exact_mod_cast (hNY.trans (hlo p hp).le)
  have hYpow : Y ≤ 2 * (2 : ℝ) ^ K := by
    have hlt := Nat.lt_pow_succ_log_self (by decide : 1 < 2) N
    have hnat : N + 1 ≤ 2 ^ (K + 1) := hlt
    have hreal : (N : ℝ) + 1 ≤ (2 : ℝ) ^ (K + 1) := by exact_mod_cast hnat
    have hfloor : Y < (N : ℝ) + 1 := Nat.lt_floor_add_one Y
    rw [pow_succ] at hreal
    linarith
  calc
    _ ≤ (16 * log 2) / (2 : ℝ) ^ K := finite_prime_log_square_dyadic_tail S K hNp
    _ ≤ _ := by
      apply (div_le_div_iff₀ (by positivity) hY0).mpr
      have h := mul_le_mul_of_nonneg_left hYpow (by positivity : 0 ≤ 16 * log (2 : ℝ))
      nlinarith

/-- A full finite tail, without discarding any prime above the threshold. -/
theorem finite_prime_square_tail (S : Finset Nat.Primes) {Y : ℝ} (hY : 2 ≤ Y)
    (hlo : ∀ p ∈ S, Y < (p : ℝ)) :
    (∑ p ∈ S, 1 / (p : ℝ) ^ 2) ≤ (32 * log 2) / (Y * log Y) := by
  have hY0 : 0 < Y := by linarith
  have hlY : 0 < log Y := log_pos (by linarith)
  calc
    _ ≤ ∑ p ∈ S, (log (p : ℝ) / (p : ℝ) ^ 2) / log Y := by
      apply Finset.sum_le_sum
      intro p hp
      have hp0 : (0 : ℝ) < p := lt_trans hY0 (hlo p hp)
      have hlog := log_le_log hY0 (hlo p hp).le
      apply (le_div_iff₀ hlY).mpr
      rw [one_div, mul_comm, ← div_eq_mul_inv]
      exact div_le_div_of_nonneg_right hlog (sq_nonneg _)
    _ = (∑ p ∈ S, log (p : ℝ) / (p : ℝ) ^ 2) / log Y := (Finset.sum_div _ _ _).symm
    _ ≤ ((32 * log 2) / Y) / log Y :=
      div_le_div_of_nonneg_right (finite_prime_log_square_tail S hY hlo) hlY.le
    _ = _ := by rw [div_div]

end BuildingBlocks.PrimeSeedMass
