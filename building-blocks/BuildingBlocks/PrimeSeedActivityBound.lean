import BuildingBlocks.PrimeSeedLevy
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Data.Nat.Log

/-! Elementary prime-shell bounds for the total activity of the positive seed.
The arithmetic input is the repository's proved Chebyshev bound for the actual
von Mangoldt prefix. No prime number theorem or RH assumption is used.
-/

open Real

namespace BuildingBlocks.PrimeSeedMass

theorem sum_log_primes_le_psi (S : Finset ℕ) (M : ℕ)
    (hprime : ∀ p ∈ S, p.Prime) (hM : ∀ p ∈ S, p ≤ M) :
    (∑ p ∈ S, log (p : ℝ)) ≤ BuildingBlocks.CoarsePrimitive.psi M := by
  rw [BuildingBlocks.CoarsePrimitive.psi_eq_sum_Icc]
  calc
    (∑ p ∈ S, log (p : ℝ)) = ∑ p ∈ S, ArithmeticFunction.vonMangoldt p := by
      apply Finset.sum_congr rfl
      intro p hp
      rw [ArithmeticFunction.vonMangoldt_apply_prime (hprime p hp)]
    _ ≤ ∑ p ∈ Finset.Icc 1 M, ArithmeticFunction.vonMangoldt p := by
      apply Finset.sum_le_sum_of_subset_of_nonneg
      · intro p hp
        exact Finset.mem_Icc.mpr ⟨(hprime p hp).one_lt.le, hM p hp⟩
      · intro p _ _
        exact ArithmeticFunction.vonMangoldt_nonneg

private theorem reciprocal_log_le_weight {x y : ℝ} (hx : 1 < x) (hxy : x ≤ y) :
    1 / (y * log y) ≤ log y / (x * log x ^ 2) := by
  have hx0 : 0 < x := by linarith
  have hy0 : 0 < y := by linarith
  have hlx : 0 < log x := log_pos hx
  have hly : 0 < log y := log_pos (lt_of_lt_of_le hx hxy)
  have hlog : log x ≤ log y := log_le_log hx0 hxy
  apply (div_le_div_iff₀ (mul_pos hy0 hly) (mul_pos hx0 (sq_pos_of_pos hlx))).2
  have hsq : log x ^ 2 ≤ log y ^ 2 := by nlinarith
  have hmul := mul_le_mul hxy hsq (sq_nonneg (log x)) hy0.le
  nlinarith [hmul]

/-- A complete prime shell has an inverse-square logarithmic activity bound. -/
theorem prime_shell_activity_le (S : Finset ℕ) (N : ℕ) (hN : 2 ≤ N)
    (hprime : ∀ p ∈ S, p.Prime)
    (hlo : ∀ p ∈ S, N ≤ p) (hhi : ∀ p ∈ S, p ≤ 2 * N) :
    (∑ p ∈ S, 1 / ((p : ℝ) * log p)) ≤ 8 * log 2 / log (N : ℝ) ^ 2 := by
  have hN1 : (1 : ℝ) < N := by exact_mod_cast (show 1 < N by omega)
  have hN0 : (0 : ℝ) < N := by linarith
  have hlog : 0 < log (N : ℝ) := log_pos hN1
  have hpsi := (sum_log_primes_le_psi S (2 * N) hprime hhi).trans
    (BuildingBlocks.CoarsePrimitive.psi_le_linear (2 * N))
  push_cast at hpsi
  calc
    (∑ p ∈ S, 1 / ((p : ℝ) * log p)) ≤
        ∑ p ∈ S, log (p : ℝ) / ((N : ℝ) * log (N : ℝ) ^ 2) := by
      apply Finset.sum_le_sum
      intro p hp
      exact reciprocal_log_le_weight hN1 (by exact_mod_cast hlo p hp)
    _ = (∑ p ∈ S, log (p : ℝ)) / ((N : ℝ) * log (N : ℝ) ^ 2) :=
      (Finset.sum_div _ _ _).symm
    _ ≤ ((4 * log 2) * (2 * (N : ℝ))) / ((N : ℝ) * log (N : ℝ) ^ 2) :=
      div_le_div_of_nonneg_right hpsi (by positivity)
    _ = 8 * log 2 / log (N : ℝ) ^ 2 := by
      field_simp
      ring

/-- The actual primes in one dyadic logarithmic shell. -/
def logFiber (k : ℕ) : Set Nat.Primes := {p | Nat.log 2 p = k}

theorem finite_logFiber (k : ℕ) : (logFiber k).Finite := by
  have hf : ((fun p : Nat.Primes => (p : ℕ)) ⁻¹' Set.Iio (2 ^ (k + 1))).Finite :=
    (Set.finite_Iio _).preimage (fun _ _ _ _ h => Subtype.ext h)
  apply hf.subset
  intro p hp
  have hb := Nat.lt_pow_succ_log_self (by decide : 1 < 2) (p : ℕ)
  change Nat.log 2 (p : ℕ) = k at hp
  rw [hp] at hb
  exact hb

private theorem prime_log_weight_nonneg (p : Nat.Primes) :
    0 ≤ 1 / ((p : ℝ) * log p) := by
  have hp : (1 : ℝ) < p := by exact_mod_cast p.property.one_lt
  exact (one_div_pos.mpr (mul_pos (by linarith) (log_pos hp))).le

theorem logFiber_weight_le {k : ℕ} (hk : 1 ≤ k) :
    (∑' p : logFiber k, 1 / ((p.val : ℝ) * log p.val)) ≤
      (8 / log 2) * (1 / (k : ℝ) ^ 2) := by
  classical
  letI := (finite_logFiber k).fintype
  let S := Finset.univ.image (fun p : logFiber k => (p.val : ℕ))
  have hinj : Function.Injective (fun p : logFiber k => (p.val : ℕ)) :=
    fun _ _ h => Subtype.ext (Subtype.ext h)
  have hsum : (∑ n ∈ S, 1 / ((n : ℝ) * log n)) =
      ∑ p : logFiber k, 1 / ((p.val : ℝ) * log p.val) := by
    dsimp [S]
    rw [Finset.sum_image (fun p _ q _ h => hinj h)]
  have hN : 2 ≤ 2 ^ k := by
    calc
      2 = 2 ^ 1 := by norm_num
      _ ≤ 2 ^ k := Nat.pow_le_pow_right (by decide) hk
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
  calc
    (∑ n ∈ S, 1 / ((n : ℝ) * log n)) ≤ 8 * log 2 / log ((2 ^ k : ℕ) : ℝ) ^ 2 :=
      prime_shell_activity_le S (2 ^ k) hN hprime hlo hhi
    _ = (8 / log 2) * (1 / (k : ℝ) ^ 2) := by
      rw [Nat.cast_pow, Nat.cast_ofNat, log_pow]
      have hlog : log 2 ≠ 0 := (log_pos (by norm_num : (1 : ℝ) < 2)).ne'
      field_simp

/-- Chebyshev's bound suffices for convergence of the complete prime activity
majorant. This is stronger than convergence of any fixed finite cutoff. -/
theorem summable_prime_reciprocal_mul_log :
    Summable (fun p : Nat.Primes => 1 / ((p : ℝ) * log p)) := by
  apply (summable_partition prime_log_weight_nonneg
    (s := logFiber) (fun p => ⟨Nat.log 2 p, rfl, fun k hk => hk.symm⟩)).2
  constructor
  · intro k
    letI := (finite_logFiber k).fintype
    exact (hasSum_fintype _).summable
  · have hs := (summable_one_div_nat_pow.mpr (by decide : 1 < 2)).mul_left (8 / log 2)
    apply hs.of_norm_bounded_eventually_nat
    filter_upwards [Filter.eventually_ge_atTop 1] with k hk
    have hn : 0 ≤ ∑' p : logFiber k, 1 / ((p.val : ℝ) * log p.val) :=
      tsum_nonneg (fun p => prime_log_weight_nonneg p.val)
    rw [Real.norm_eq_abs, abs_of_nonneg hn]
    exact logFiber_weight_le hk

end BuildingBlocks.PrimeSeedMass
