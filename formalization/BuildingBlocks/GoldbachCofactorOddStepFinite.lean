import BuildingBlocks.GoldbachCofactorSuccessorQuadratic
import BuildingBlocks.GoldbachOddPowerBoundFinite
import Mathlib.Tactic

/-!
# One-sided odd-total successor bound for the actual Goldbach cofactor

When the new additive total is odd, one prime-power leg in every
pair must be a power of two. This bounds upward signed cofactor
steps by one logarithm without any analytic prime-distribution
estimate. It says nothing about the size of downward steps.
-/

namespace BuildingBlocks.GoldbachCofactorOddStepFinite

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n
abbrev ψ (n : ℕ) : ℝ := BuildingBlocks.CoarsePrimitive.psi n
abbrev q (n : ℕ) : ℝ := BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError n
abbrev Q (n : ℕ) : ℝ := BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError n

private def evenSupport (N : ℕ) : Finset ℕ :=
  (Icc 1 N).filter (fun y => Even y ∧ Λ y ≠ 0)

private theorem evenSupport_eq_image (N : ℕ) :
    evenSupport N = (Icc 1 (Nat.log 2 N)).image (fun k => 2 ^ k) := by
  ext y
  simp only [evenSupport, mem_filter, mem_Icc, mem_image]
  constructor
  · rintro ⟨⟨hy1, hyN⟩, he, hn⟩
    obtain ⟨k, hk, hpow, _⟩ :=
      BuildingBlocks.GoldbachOddCentering.even_nonzero_vonMangoldt he hn
    refine ⟨k, ⟨hk, ?_⟩, hpow.symm⟩
    exact Nat.le_log_of_pow_le (by omega) (hpow ▸ hyN)
  · rintro ⟨k, ⟨hk, hklog⟩, rfl⟩
    have hN : N ≠ 0 := by
      intro h
      subst N
      simp at hklog
      omega
    have hpow : 2 ^ k ≤ N := (Nat.le_log_iff_pow_le (by omega) hN).1 hklog
    have hpos : 1 ≤ 2 ^ k := pow_pos (by omega : 0 < (2 : ℕ)) k
    have he : Even (2 ^ k) := even_two.pow_of_ne_zero (by omega)
    have hn : Λ (2 ^ k) ≠ 0 :=
      (BuildingBlocks.GoldbachOddCentering.even_vonMangoldt_support he).2
        ⟨k, hk, rfl⟩
    exact ⟨⟨hpos, hpow⟩, he, hn⟩

private theorem geometric_half_prefix (K : ℕ) :
    (∑ k ∈ Icc 1 K, ((1 : ℝ) / 2) ^ k) =
      1 - ((1 : ℝ) / 2) ^ K := by
  induction K with
  | zero => simp
  | succ K ih =>
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ K + 1), ih, pow_succ]
      ring

/-- The reciprocal von Mangoldt mass on even integers is at most one:
only powers of two survive, so the mass is geometric. -/
theorem even_reciprocal_mass_le_one (N : ℕ) :
    (∑ y ∈ Icc 1 N, if Even y then Λ y / (y : ℝ) else 0) ≤ 1 := by
  have hsupport :
      (∑ y ∈ Icc 1 N, if Even y then Λ y / (y : ℝ) else 0) =
        ∑ y ∈ evenSupport N, Λ y / (y : ℝ) := by
    unfold evenSupport
    rw [Finset.sum_filter]
    apply Finset.sum_congr rfl
    intro y hy
    by_cases he : Even y
    · by_cases hn : Λ y = 0
      · simp [he, hn]
      · simp [he, hn]
    · simp [he]
  rw [hsupport, evenSupport_eq_image]
  rw [Finset.sum_image (fun _ _ _ _ h => Nat.pow_right_injective (by omega) h)]
  have hpow : ∀ k ∈ Icc 1 (Nat.log 2 N),
      Λ (2 ^ k) / ((2 ^ k : ℕ) : ℝ) =
        Real.log 2 * (((1 : ℝ) / 2) ^ k) := by
    intro k hk
    have hk1 : 1 ≤ k := (mem_Icc.mp hk).1
    have hk0 : k ≠ 0 := by omega
    change ArithmeticFunction.vonMangoldt (2 ^ k) / ((2 ^ k : ℕ) : ℝ) =
      Real.log 2 * (((1 : ℝ) / 2) ^ k)
    rw [ArithmeticFunction.vonMangoldt_apply_pow hk0,
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    push_cast
    rw [div_eq_mul_inv, ← inv_pow]
    simp only [one_div]
  calc
    (∑ k ∈ Icc 1 (Nat.log 2 N),
      Λ (2 ^ k) / ((2 ^ k : ℕ) : ℝ)) =
        Real.log 2 * (∑ k ∈ Icc 1 (Nat.log 2 N),
          (((1 : ℝ) / 2) ^ k)) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro k hk
            exact hpow k hk
    _ ≤ Real.log 2 := by
      rw [geometric_half_prefix]
      have hlog : 0 ≤ Real.log 2 := Real.log_nonneg (by norm_num)
      have hpow0 : 0 ≤ ((1 : ℝ) / 2) ^ Nat.log 2 N := by positivity
      nlinarith
    _ ≤ 1 := by
      have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
      norm_num at h
      exact h

/-- The total even von Mangoldt mass through N is at most log N. -/
theorem even_prime_mass_le_log (N : ℕ) (hN : N ≠ 0) :
    (∑ m ∈ Icc 1 N, if Even m then Λ m else 0) ≤ Real.log (N : ℝ) := by
  rw [BuildingBlocks.GoldbachOddPowerBoundFinite.even_vonMangoldt_sum]
  have hpow : (2 : ℝ) ^ Nat.log 2 N ≤ (N : ℝ) := by
    exact_mod_cast Nat.pow_log_le_self 2 hN
  have hlog := Real.log_le_log (by positivity : 0 < (2 : ℝ) ^ Nat.log 2 N) hpow
  simpa [Real.log_pow, mul_comm] using hlog

/-- The centered ratio's successor is at most the new prime-power
birth divided by its label. The missing term is the nonnegative
complete Chebyshev prefix. -/
theorem ratioError_step_le_prime (y : ℕ) (hy : 2 ≤ y) :
    q y - q (y - 1) ≤ Λ y / (y : ℝ) := by
  have hym : 1 ≤ y - 1 := by omega
  have hidx : y - 1 + 1 = y := by omega
  have hψ : 0 ≤ ψ (y - 1) := BuildingBlocks.CoarsePrimitive.psi_nonneg _
  have hden : 0 < ((y - 1 : ℕ) : ℝ) * (y : ℝ) := by
    have hy' : 0 < y - 1 := by omega
    have hy0 : 0 < y := by omega
    exact mul_pos (by exact_mod_cast hy') (by exact_mod_cast hy0)
  have hstep := BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError_succ
    (y - 1) hym
  rw [hidx] at hstep
  rw [hstep]
  dsimp [BuildingBlocks.GoldbachCofactorVolterraFinite.primeError]
  have hid :
      (Λ y - 1) / (y : ℝ) -
        (ψ (y - 1) - ((y - 1 : ℕ) : ℝ)) /
          (((y - 1 : ℕ) : ℝ) * (y : ℝ)) =
      Λ y / (y : ℝ) - ψ (y - 1) /
          (((y - 1 : ℕ) : ℝ) * (y : ℝ)) := by
    have hy0 : (y : ℝ) ≠ 0 := by positivity
    have hym0 : (((y - 1 : ℕ) : ℝ)) ≠ 0 := by positivity
    field_simp
    ring
  rw [hid]
  exact sub_le_self _ (div_nonneg hψ hden.le)

/-- The new two-leg endpoint is nonpositive. -/
theorem ratioError_two_nonpos : q 2 ≤ 0 := by
  have hψ2 : ψ 2 = Real.log 2 := by
    have h0 : Λ 0 = 0 := by
      simp [Λ]
    have h2 : Λ 2 = Real.log 2 :=
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
    simp [ψ, BuildingBlocks.CoarsePrimitive.psi,
      Finset.sum_range_succ, h0, h2]
  have hlog : Real.log 2 ≤ 1 := by
    have h := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    norm_num at h
    exact h
  dsimp [q, BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError,
    BuildingBlocks.GoldbachCofactorVolterraFinite.primeError]
  change BuildingBlocks.CoarsePrimitive.psi 2 = Real.log 2 at hψ2
  rw [hψ2]
  linarith

private theorem odd_complement_even {n m : ℕ} (hn : Odd n)
    (hm : m ≤ n) : Even m ∨ Even (n - m) := by
  rcases Nat.even_or_odd m with he | ho
  · exact Or.inl he
  · right
    rcases hn with ⟨a, ha⟩
    rcases ho with ⟨b, hb⟩
    unfold Even
    refine ⟨a - b, ?_⟩
    omega

def weightedPrimePair (n : ℕ) : ℝ :=
  ∑ m ∈ Icc 2 (n - 3), Λ m * (Λ (n - m) / ((n - m : ℕ) : ℝ))

/-- In an odd-total prime-power pair, one leg is even. Its entire
von Mangoldt mass is at most log n, while its reciprocal mass is
geometric. This gives a finite, uniform one-logarithm bound. -/
theorem weightedPrimePair_odd_le_two_log (n : ℕ) (hn : Odd n)
    (hn5 : 5 ≤ n) :
    weightedPrimePair n ≤ 2 * Real.log (n : ℝ) := by
  let L : ℝ := Real.log (n : ℝ)
  have hn0 : n ≠ 0 := by omega
  have hL : 0 ≤ L := Real.log_nonneg (by
    exact_mod_cast (show 1 ≤ n by omega))
  have hterm : ∀ m ∈ Icc 2 (n - 3),
      Λ m * (Λ (n - m) / ((n - m : ℕ) : ℝ)) ≤
        L * (if Even (n - m) then
          Λ (n - m) / ((n - m : ℕ) : ℝ) else 0) +
        (if Even m then Λ m else 0) := by
    intro m hm
    obtain ⟨hm2, hmle⟩ := mem_Icc.mp hm
    have hmn : m ≤ n := by omega
    have hy : 3 ≤ n - m := by omega
    have hypos : 0 < ((n - m : ℕ) : ℝ) := by
      exact_mod_cast (show 0 < n - m by omega)
    have hΛm : 0 ≤ Λ m := ArithmeticFunction.vonMangoldt_nonneg
    have hΛy : 0 ≤ Λ (n - m) := ArithmeticFunction.vonMangoldt_nonneg
    have hratio0 : 0 ≤ Λ (n - m) / ((n - m : ℕ) : ℝ) :=
      div_nonneg hΛy hypos.le
    have hΛmle : Λ m ≤ L :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log
          (by exact_mod_cast (show 0 < m by omega))
          (by exact_mod_cast hmn))
    have hratiole : Λ (n - m) / ((n - m : ℕ) : ℝ) ≤ 1 := by
      have hΛle := ArithmeticFunction.vonMangoldt_le_log (n := n - m)
      have hlogle := Real.log_le_self (Nat.cast_nonneg (n - m))
      apply (div_le_iff₀ hypos).2
      nlinarith
    by_cases he : Even (n - m)
    · have hsec : 0 ≤ (if Even m then Λ m else 0) := by
        split_ifs <;> positivity
      simp only [he, ↓reduceIte]
      have hmul := mul_le_mul_of_nonneg_right hΛmle hratio0
      linarith
    · have hmEven : Even m := (odd_complement_even hn hmn).resolve_right he
      simp only [he, hmEven, ↓reduceIte, mul_zero, zero_add]
      simpa only [mul_one] using
        (mul_le_mul_of_nonneg_left hratiole hΛm)
  have hreverse :
      (∑ m ∈ Icc 2 (n - 3),
        if Even (n - m) then
          Λ (n - m) / ((n - m : ℕ) : ℝ) else 0) =
      ∑ y ∈ Icc 3 (n - 2),
        if Even y then Λ y / (y : ℝ) else 0 := by
    apply Finset.sum_bij (fun m _ => n - m)
    · intro m hm
      simp only [mem_Icc] at hm ⊢
      omega
    · intro m hm k hk hmk
      simp only [mem_Icc] at hm hk
      omega
    · intro y hy
      simp only [mem_Icc] at hy
      refine ⟨n - y, ?_, ?_⟩
      · simp only [mem_Icc]
        omega
      · omega
    · intro m hm
      rfl
  have hrec :
      (∑ m ∈ Icc 2 (n - 3),
        if Even (n - m) then
          Λ (n - m) / ((n - m : ℕ) : ℝ) else 0) ≤ 1 := by
    rw [hreverse]
    have hsubset : Icc 3 (n - 2) ⊆ Icc 1 n := by
      intro y hy
      simp only [mem_Icc] at hy ⊢
      omega
    have hsum :
        (∑ y ∈ Icc 3 (n - 2),
          if Even y then Λ y / (y : ℝ) else 0) ≤
        ∑ y ∈ Icc 1 n, if Even y then Λ y / (y : ℝ) else 0 :=
      Finset.sum_le_sum_of_subset_of_nonneg hsubset
        (by
          intro y hy hnot
          by_cases he : Even y
          · simp only [he, ↓reduceIte]
            exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg
              (Nat.cast_nonneg _)
          · simp [he])
    exact hsum.trans (even_reciprocal_mass_le_one n)
  have hmass :
      (∑ m ∈ Icc 2 (n - 3), if Even m then Λ m else 0) ≤ L := by
    have hsubset : Icc 2 (n - 3) ⊆ Icc 1 n := by
      intro m hm
      simp only [mem_Icc] at hm ⊢
      omega
    have hsum :
        (∑ m ∈ Icc 2 (n - 3), if Even m then Λ m else 0) ≤
        ∑ m ∈ Icc 1 n, if Even m then Λ m else 0 :=
      Finset.sum_le_sum_of_subset_of_nonneg hsubset
        (by
          intro m hm hnot
          by_cases he : Even m
          · simpa only [he, ↓reduceIte] using
              (ArithmeticFunction.vonMangoldt_nonneg (n := m))
          · simp [he])
    exact hsum.trans (by simpa [L] using even_prime_mass_le_log n hn0)
  unfold weightedPrimePair
  calc
    _ ≤ ∑ m ∈ Icc 2 (n - 3),
        (L * (if Even (n - m) then
            Λ (n - m) / ((n - m : ℕ) : ℝ) else 0) +
          (if Even m then Λ m else 0)) := Finset.sum_le_sum hterm
    _ = L * (∑ m ∈ Icc 2 (n - 3),
          if Even (n - m) then
            Λ (n - m) / ((n - m : ℕ) : ℝ) else 0) +
        ∑ m ∈ Icc 2 (n - 3), if Even m then Λ m else 0 := by
          rw [Finset.sum_add_distrib, Finset.mul_sum]
    _ ≤ L * 1 + L := add_le_add
      (mul_le_mul_of_nonneg_left hrec hL) hmass
    _ = 2 * Real.log (n : ℝ) := by dsimp [L]; ring

/-- When the new Goldbach total `s+1` is odd, the actual signed
cofactor can rise by at most two logarithms. The endpoint is kept
with its true nonpositive sign; no lower bound on the step follows. -/
theorem signedCofactorError_odd_total_step_le_two_log (s : ℕ)
    (hs : 4 ≤ s) (hodd : Odd (s + 1)) :
    Q (s + 1) - Q s ≤ 2 * Real.log ((s + 1 : ℕ) : ℝ) := by
  have hend : Λ (s - 1) * q 2 ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos
      ArithmeticFunction.vonMangoldt_nonneg ratioError_two_nonpos
  have hterm : ∀ m ∈ Icc 2 (s - 2),
      Λ m * (q (s + 1 - m) - q (s - m)) ≤
        Λ m * (Λ (s + 1 - m) / ((s + 1 - m : ℕ) : ℝ)) := by
    intro m hm
    have hmle : m ≤ s - 2 := (mem_Icc.mp hm).2
    have hy : 2 ≤ s + 1 - m := by omega
    have hpred : s + 1 - m - 1 = s - m := by omega
    have hratio := ratioError_step_le_prime (s + 1 - m) hy
    rw [hpred] at hratio
    exact mul_le_mul_of_nonneg_left hratio
      ArithmeticFunction.vonMangoldt_nonneg
  have hsum := Finset.sum_le_sum hterm
  have hupper : s + 1 - 3 = s - 2 := by omega
  have hpair :
      (∑ m ∈ Icc 2 (s - 2),
        Λ m * (q (s + 1 - m) - q (s - m))) ≤
          weightedPrimePair (s + 1) := by
    simpa only [weightedPrimePair, hupper] using hsum
  have hsucc :=
    BuildingBlocks.GoldbachCofactorSuccessorFinite.signedCofactorError_succ
      s hs
  change Q (s + 1) - Q s = Λ (s - 1) * q 2 +
    ∑ m ∈ Icc 2 (s - 2),
      Λ m * (q (s + 1 - m) - q (s - m)) at hsucc
  calc
    Q (s + 1) - Q s = Λ (s - 1) * q 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * (q (s + 1 - m) - q (s - m)) := hsucc
    _ ≤ weightedPrimePair (s + 1) := by linarith
    _ ≤ 2 * Real.log ((s + 1 : ℕ) : ℝ) :=
      weightedPrimePair_odd_le_two_log (s + 1) hodd (by omega)

/-- A one-sided upper estimate on an even cutoff transfers to the
following odd cutoff with only a logarithmic cost. -/
theorem even_to_odd_upper_transfer (s : ℕ) (hs : 4 ≤ s)
    (hodd : Odd (s + 1)) (B : ℝ) (hQ : Q s ≤ B) :
    Q (s + 1) ≤ B + 2 * Real.log ((s + 1 : ℕ) : ℝ) := by
  have hstep := signedCofactorError_odd_total_step_le_two_log s hs hodd
  linarith

#print axioms even_reciprocal_mass_le_one
#print axioms even_prime_mass_le_log
#print axioms ratioError_step_le_prime
#print axioms ratioError_two_nonpos
#print axioms weightedPrimePair_odd_le_two_log
#print axioms signedCofactorError_odd_total_step_le_two_log
#print axioms even_to_odd_upper_transfer

end
end BuildingBlocks.GoldbachCofactorOddStepFinite
