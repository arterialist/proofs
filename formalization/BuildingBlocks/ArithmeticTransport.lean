import BuildingBlocks.SelbergIdentity

open Finset
open scoped BigOperators ArithmeticFunction

namespace BuildingBlocks

/-- The coefficient operator underlying the second generalized von Mangoldt
weight. This is an algebraic operator; no Hilbert-space claim is built in. -/
noncomputable def primeTransport (f : ArithmeticFunction ℝ) : ArithmeticFunction ℝ :=
  f.pmul ArithmeticFunction.log + ArithmeticFunction.vonMangoldt * f

theorem primeTransport_vonMangoldt :
    primeTransport ArithmeticFunction.vonMangoldt = selbergWeight := rfl

theorem primeTransport_apply_divisors (f : ArithmeticFunction ℝ) (n : ℕ) :
    primeTransport f n = f n * Real.log n +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt (n / d) * f d := by
  simp only [primeTransport, ArithmeticFunction.add_apply, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.log_apply]
  rw [mul_comm ArithmeticFunction.vonMangoldt f, ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal (fun a b => f a * ArithmeticFunction.vonMangoldt b)]
  congr 1
  exact Finset.sum_congr rfl (fun _ _ => mul_comm _ _)

/-- Divisor summation conjugates prime transport to multiplication by log n. -/
theorem zeta_mul_primeTransport (f : ArithmeticFunction ℝ) :
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * primeTransport f =
      ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log := by
  rw [primeTransport, log_weighted_convolution, ArithmeticFunction.zeta_pmul, mul_add]
  rw [← mul_assoc, mul_comm (ArithmeticFunction.zeta : ArithmeticFunction ℝ)
    ArithmeticFunction.vonMangoldt, ArithmeticFunction.vonMangoldt_mul_zeta]
  exact add_comm _ _

theorem primeTransport_conjugation (f : ArithmeticFunction ℝ) :
    primeTransport f = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      (((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul ArithmeticFunction.log) := by
  rw [← zeta_mul_primeTransport, ← mul_assoc,
    ArithmeticFunction.coe_moebius_mul_coe_zeta, one_mul]

theorem primeTransport_moebius_mul (g : ArithmeticFunction ℝ) :
    primeTransport ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) * g) =
      (ArithmeticFunction.moebius : ArithmeticFunction ℝ) * g.pmul ArithmeticFunction.log := by
  rw [primeTransport_conjugation, ← mul_assoc,
    ArithmeticFunction.coe_zeta_mul_coe_moebius, one_mul]

theorem primeTransport_moebius :
    primeTransport (ArithmeticFunction.moebius : ArithmeticFunction ℝ) = 0 := by
  have he : (1 : ArithmeticFunction ℝ).pmul ArithmeticFunction.log = 0 := by
    ext n
    by_cases hn : n = 1 <;> simp [ArithmeticFunction.pmul_apply,
      ArithmeticFunction.one_apply, ArithmeticFunction.log_apply, hn]
  simpa only [mul_one, he, mul_zero] using primeTransport_moebius_mul 1

/-- A coefficient-space eigenvector at the arithmetic index k. -/
noncomputable def arithmeticDelta (k : ℕ) (hk : k ≠ 0) : ArithmeticFunction ℝ where
  toFun n := if n = k then 1 else 0
  map_zero' := by simp [Ne.symm hk]

theorem arithmeticDelta_apply (k : ℕ) (hk : k ≠ 0) (n : ℕ) :
    arithmeticDelta k hk n = if n = k then 1 else 0 := rfl

theorem primeTransport_delta_eigenvector (k : ℕ) (hk : k ≠ 0) (n : ℕ) :
    primeTransport ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      arithmeticDelta k hk) n =
        Real.log k * ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
          arithmeticDelta k hk) n := by
  rw [primeTransport_moebius_mul]
  simp only [ArithmeticFunction.mul_apply, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.log_apply, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d _
  by_cases hd : d.2 = k
  · simp [arithmeticDelta_apply, hd, mul_comm]
  · simp [arithmeticDelta_apply, hd]

theorem primeTransport_delta_eigenvector_ne_zero (k : ℕ) (hk : k ≠ 0) :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) * arithmeticDelta k hk ≠ 0 := by
  intro he
  have h := congrArg (fun f : ArithmeticFunction ℝ =>
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) he
  dsimp only at h
  rw [← mul_assoc, ArithmeticFunction.coe_zeta_mul_coe_moebius, one_mul, mul_zero] at h
  have hh := congrArg (fun f : ArithmeticFunction ℝ => f k) h
  simp [arithmeticDelta_apply] at hh

/-- The conjugation is an exact inverse on arbitrary coefficient sequences.
It includes all signs of the Möbius function and asserts no norm bound. -/
theorem primeTransport_eq_iff (f h : ArithmeticFunction ℝ) :
    primeTransport f = h ↔
      ∀ n : ℕ, Real.log n *
        ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) n =
          ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * h) n := by
  constructor
  · intro he n
    rw [← he, zeta_mul_primeTransport]
    simp only [ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply, mul_comm]
  · intro he
    have hh : ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f).pmul
        ArithmeticFunction.log = (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * h := by
      ext n
      simpa only [ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply, mul_comm] using he n
    rw [primeTransport_conjugation, hh, ← mul_assoc,
      ArithmeticFunction.coe_moebius_mul_coe_zeta, one_mul]

theorem convolution_apply_of_pointwise_scale (a f g : ArithmeticFunction ℝ) (c : ℝ)
    (he : ∀ n, f n = c * g n) (n : ℕ) :
    (a * f) n = c * (a * g) n := by
  simp only [ArithmeticFunction.mul_apply, he, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d _
  ring

/-- The algebraic point eigenvalues on all arithmetic coefficient sequences
are exactly log k. No norm, completion, or zeta-zero correspondence is assumed. -/
theorem primeTransport_eigenvalues (lam : ℝ) :
    (∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) ↔
      ∃ k : ℕ, k ≠ 0 ∧ lam = Real.log k := by
  constructor
  · rintro ⟨f, hf, he⟩
    have hg : (ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f ≠ 0 := by
      intro hz
      have hh := congrArg (fun g : ArithmeticFunction ℝ =>
        (ArithmeticFunction.moebius : ArithmeticFunction ℝ) * g) hz
      dsimp only at hh
      rw [← mul_assoc, ArithmeticFunction.coe_moebius_mul_coe_zeta, one_mul, mul_zero] at hh
      exact hf hh
    obtain ⟨k, hk⟩ : ∃ k : ℕ, ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) k ≠ 0 := by
      by_contra hh
      push_neg at hh
      exact hg (ArithmeticFunction.ext hh)
    refine ⟨k, ?_, ?_⟩
    · intro hk0
      simp [hk0] at hk
    · have hh := convolution_apply_of_pointwise_scale
        (ArithmeticFunction.zeta : ArithmeticFunction ℝ) (primeTransport f) f lam he k
      rw [zeta_mul_primeTransport] at hh
      simp only [ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply] at hh
      have hmul : Real.log k * ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) k =
          lam * ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) k := by
        rw [mul_comm]
        exact hh
      exact (mul_right_cancel₀ hk hmul).symm
  · rintro ⟨k, hk, rfl⟩
    exact ⟨(ArithmeticFunction.moebius : ArithmeticFunction ℝ) * arithmeticDelta k hk,
      primeTransport_delta_eigenvector_ne_zero k hk, primeTransport_delta_eigenvector k hk⟩

/-- In particular the algebraic eigenvalues are nonnegative, unconditionally.
This positivity contains no estimate for the summatory Möbius function. -/
theorem primeTransport_eigenvalue_nonneg {lam : ℝ}
    (h : ∃ f : ArithmeticFunction ℝ, f ≠ 0 ∧ ∀ n, primeTransport f n = lam * f n) :
    0 ≤ lam := by
  obtain ⟨k, _, rfl⟩ := (primeTransport_eigenvalues lam).mp h
  exact Real.log_natCast_nonneg k

theorem primeTransport_kernel_iff (f : ArithmeticFunction ℝ) :
    primeTransport f = 0 ↔
      ∀ n : ℕ, f n = f 1 * (ArithmeticFunction.moebius n : ℝ) := by
  constructor
  · intro hf
    have hz := (primeTransport_eq_iff f 0).mp hf
    have hshape : ∀ n : ℕ,
        ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) n =
          f 1 * (1 : ArithmeticFunction ℝ) n := by
      intro n
      by_cases hn0 : n = 0
      · simp [hn0]
      by_cases hn1 : n = 1
      · simp [hn1]
      have hlog : Real.log (n : ℝ) ≠ 0 :=
        Real.log_ne_zero_of_pos_of_ne_one (by exact_mod_cast Nat.pos_of_ne_zero hn0)
          (by exact_mod_cast hn1)
      have hh := hz n
      simp only [mul_zero, ArithmeticFunction.zero_apply] at hh
      rw [(mul_eq_zero.mp hh).resolve_left hlog, ArithmeticFunction.one_apply_ne hn1, mul_zero]
    intro n
    have hrec : (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
        ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f) = f := by
      rw [← mul_assoc, ArithmeticFunction.coe_moebius_mul_coe_zeta, one_mul]
    calc
      f n = ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
        ((ArithmeticFunction.zeta : ArithmeticFunction ℝ) * f)) n := by rw [hrec]
      _ = f 1 * ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) * 1) n :=
        convolution_apply_of_pointwise_scale _ _ _ _ hshape n
      _ = f 1 * (ArithmeticFunction.moebius n : ℝ) := by simp
  · intro hf
    apply (primeTransport_eq_iff f 0).mpr
    intro n
    rw [convolution_apply_of_pointwise_scale (ArithmeticFunction.zeta : ArithmeticFunction ℝ)
      f (ArithmeticFunction.moebius : ArithmeticFunction ℝ) (f 1) hf n,
      ArithmeticFunction.coe_zeta_mul_coe_moebius]
    by_cases hn : n = 1 <;> simp [ArithmeticFunction.one_apply, hn]

theorem primeTransport_sub (f g : ArithmeticFunction ℝ) :
    primeTransport (f - g) = primeTransport f - primeTransport g := by
  unfold primeTransport
  rw [mul_sub]
  ext n
  change (f n - g n) * ArithmeticFunction.log n +
      ((ArithmeticFunction.vonMangoldt * f) n - (ArithmeticFunction.vonMangoldt * g) n) =
    (f n * ArithmeticFunction.log n + (ArithmeticFunction.vonMangoldt * f) n) -
      (g n * ArithmeticFunction.log n + (ArithmeticFunction.vonMangoldt * g) n)
  ring

theorem primeTransport_equal_iff (f g : ArithmeticFunction ℝ) :
    primeTransport f = primeTransport g ↔
      ∀ n : ℕ, f n - g n = (f 1 - g 1) * (ArithmeticFunction.moebius n : ℝ) := by
  rw [← sub_eq_zero, ← primeTransport_sub, primeTransport_kernel_iff]
  rfl

/-- Fixing the coefficient at 1 removes the Möbius kernel ambiguity. It
does not bound the size of the signed inverse. -/
theorem primeTransport_unique_of_initial {f g : ArithmeticFunction ℝ}
    (he : primeTransport f = primeTransport g) (h1 : f 1 = g 1) : f = g := by
  have hh := (primeTransport_equal_iff f g).mp he
  ext n
  have hn := hh n
  rw [h1, sub_self, zero_mul] at hn
  exact sub_eq_zero.mp hn

end BuildingBlocks
