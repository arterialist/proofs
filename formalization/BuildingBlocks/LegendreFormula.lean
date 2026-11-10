import BuildingBlocks.SiftedIntegersVariance
import Mathlib.NumberTheory.PrimeCounting

/-!
# Legendre's formula for the prime counting function

Let `N ≥ 1`, let `S = Nat.primesLE N` be the set of primes `≤ N` and `P = primeProd S` their
product. With `count S n` the number of `1 ≤ m ≤ n` coprime to `P` (from
`BuildingBlocks.SiftedIntegersVariance`) and `π = Nat.primeCounting`:

* `coprime_primeProd_primesLE_iff` (sieve of Eratosthenes): for `1 ≤ m < (N + 1)²`, `m` is
  coprime to `P` iff `m = 1` or `m` is a prime `> N`.
* `count_primesLE`: for `N ≤ n < (N + 1)²`, `count S n = π n - π N + 1`, over `ℕ`. The
  subtraction is not truncated since `π N ≤ π n`; `count_primesLE_add` is the same statement
  without subtraction and `count_primesLE_int` is the same statement over `ℤ`.
* `legendre`: for `N ≤ n < (N + 1)²`, over `ℤ`,
  `π n - π N + 1 = ∑ d ∈ P.divisors, μ d * ⌊n / d⌋`.
* `legendre_sqrt`: the classical case `N = ⌊√n⌋`, for `n ≥ 1`.
* `legendre_err`: for `N ≤ n < (N + 1)²`, over `ℚ`,
  `π n - π N + 1 - density S * n = -∑ d ∈ P.divisors, μ d * (n mod d) / d`.

`Nat.primesLE N` is by definition `(Finset.range (N + 1)).filter Nat.Prime`
(`Nat.primesLE_eq_filter_range`).
-/

namespace BuildingBlocks.LegendreFormula

open Finset
open BuildingBlocks.SiftedIntegersVariance

/-! ## The sieve of Eratosthenes -/

/-- An integer is coprime to a product of primes iff none of them divides it. -/
theorem coprime_primeProd_iff {S : Finset ℕ} (hS : ∀ p ∈ S, p.Prime) (m : ℕ) :
    Nat.Coprime m (primeProd S) ↔ ∀ p ∈ S, ¬ p ∣ m := by
  rw [primeProd, Nat.coprime_prod_right_iff]
  refine forall₂_congr fun p hp => ?_
  rw [Nat.coprime_comm, (hS p hp).coprime_iff_not_dvd]

theorem prime_of_mem_primesLE (N : ℕ) : ∀ p ∈ Nat.primesLE N, p.Prime :=
  fun _ hp => Nat.prime_of_mem_primesLE hp

/-- **Sieve of Eratosthenes.** For `1 ≤ m < (N + 1)²`, `m` is coprime to the product of the
primes `≤ N` iff `m = 1` or `m` is a prime `> N`. -/
theorem coprime_primeProd_primesLE_iff {N m : ℕ} (hm1 : 1 ≤ m) (hm : m < (N + 1) ^ 2) :
    Nat.Coprime m (primeProd (Nat.primesLE N)) ↔ m = 1 ∨ (N < m ∧ m.Prime) := by
  rw [coprime_primeProd_iff (prime_of_mem_primesLE N)]
  constructor
  · intro h
    by_cases h1 : m = 1
    · exact Or.inl h1
    right
    have hmf : m.minFac.Prime := Nat.minFac_prime h1
    have hN : N < m.minFac := by
      by_contra hle
      exact h m.minFac (Nat.mem_primesLE.2 ⟨not_lt.1 hle, hmf⟩) (Nat.minFac_dvd m)
    have hp : m.Prime := by
      by_contra hnp
      have h2 : m.minFac ^ 2 ≤ m := Nat.minFac_sq_le_self hm1 hnp
      have h3 : (N + 1) ^ 2 ≤ m.minFac ^ 2 := Nat.pow_le_pow_left hN 2
      omega
    rw [hp.minFac_eq] at hN
    exact ⟨hN, hp⟩
  · rintro (rfl | ⟨hN, hp⟩) p hpS hdvd
    · exact (Nat.prime_of_mem_primesLE hpS).one_lt.ne' (Nat.dvd_one.1 hdvd)
    · have h1 : p = m := (Nat.prime_dvd_prime_iff_eq (Nat.prime_of_mem_primesLE hpS) hp).1 hdvd
      have h2 : p ≤ N := Nat.le_of_mem_primesLE hpS
      omega

/-- For `1 ≤ N ≤ n < (N + 1)²`, the integers in `[1, n]` coprime to the product of the primes
`≤ N` are `1` and the primes in `(N, n]`. -/
theorem filter_coprime_primeProd_primesLE {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n)
    (hn : n < (N + 1) ^ 2) :
    {m ∈ Icc 1 n | Nat.Coprime m (primeProd (Nat.primesLE N))}
      = insert 1 {p ∈ Ioc N n | p.Prime} := by
  ext m
  simp only [mem_filter, mem_Icc, mem_insert, mem_Ioc]
  constructor
  · rintro ⟨⟨h1, h2⟩, hco⟩
    rcases (coprime_primeProd_primesLE_iff h1 (lt_of_le_of_lt h2 hn)).1 hco with h | ⟨h, hp⟩
    · exact Or.inl h
    · exact Or.inr ⟨⟨h, h2⟩, hp⟩
  · rintro (rfl | ⟨⟨h1, h2⟩, hp⟩)
    · exact ⟨⟨le_rfl, by omega⟩, Nat.coprime_one_left _⟩
    · have hm1 : 1 ≤ m := by omega
      exact ⟨⟨hm1, h2⟩,
        (coprime_primeProd_primesLE_iff hm1 (lt_of_le_of_lt h2 hn)).2 (Or.inr ⟨h1, hp⟩)⟩

/-! ## Counting -/

/-- `π n = π N + #{primes in (N, n]}` for `N ≤ n`. -/
theorem primeCounting_eq_add_card {N n : ℕ} (hNn : N ≤ n) :
    Nat.primeCounting n = Nat.primeCounting N + #{p ∈ Ioc N n | p.Prime} := by
  have hdisj : Disjoint (Nat.primesLE N) {p ∈ Ioc N n | p.Prime} := by
    rw [Finset.disjoint_left]
    intro p hp hp'
    have h1 : p ≤ N := Nat.le_of_mem_primesLE hp
    have h2 : N < p := (mem_Ioc.1 (mem_filter.1 hp').1).1
    omega
  have hunion : Nat.primesLE n = Nat.primesLE N ∪ {p ∈ Ioc N n | p.Prime} := by
    ext p
    simp only [Nat.mem_primesLE, mem_union, mem_filter, mem_Ioc]
    constructor
    · rintro ⟨h, hp⟩
      by_cases hpN : p ≤ N
      · exact Or.inl ⟨hpN, hp⟩
      · exact Or.inr ⟨⟨not_le.1 hpN, h⟩, hp⟩
    · rintro (⟨h, hp⟩ | ⟨⟨-, h⟩, hp⟩)
      · exact ⟨h.trans hNn, hp⟩
      · exact ⟨h, hp⟩
  rw [← Nat.primesLE_card_eq_primeCounting n, ← Nat.primesLE_card_eq_primeCounting N, hunion,
    card_union_of_disjoint hdisj]

/-- For `1 ≤ N ≤ n < (N + 1)²`: `count S n + π N = π n + 1`, with `S` the primes `≤ N`. -/
theorem count_primesLE_add {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n) (hn : n < (N + 1) ^ 2) :
    count (Nat.primesLE N) n + Nat.primeCounting N = Nat.primeCounting n + 1 := by
  have h1 : (1 : ℕ) ∉ {p ∈ Ioc N n | p.Prime} := by
    intro h
    exact Nat.not_prime_one (mem_filter.1 h).2
  rw [count, filter_coprime_primeProd_primesLE hN hNn hn, card_insert_of_notMem h1,
    primeCounting_eq_add_card hNn]
  omega

/-- For `1 ≤ N ≤ n < (N + 1)²`, the number of `1 ≤ m ≤ n` coprime to the product of the primes
`≤ N` is `π n - π N + 1`. This is over `ℕ`; the subtraction is not truncated because
`π N ≤ π n` (`Nat.monotone_primeCounting`). -/
theorem count_primesLE {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n) (hn : n < (N + 1) ^ 2) :
    count (Nat.primesLE N) n = Nat.primeCounting n - Nat.primeCounting N + 1 := by
  have h := count_primesLE_add hN hNn hn
  have hmono : Nat.primeCounting N ≤ Nat.primeCounting n := Nat.monotone_primeCounting hNn
  omega

/-- `count_primesLE` over `ℤ`. -/
theorem count_primesLE_int {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n) (hn : n < (N + 1) ^ 2) :
    (count (Nat.primesLE N) n : ℤ) = (Nat.primeCounting n : ℤ) - Nat.primeCounting N + 1 := by
  have h := count_primesLE_add hN hNn hn
  omega

/-! ## Legendre's formula -/

section Moebius

open ArithmeticFunction
open scoped ArithmeticFunction.Moebius

/-- **Legendre's formula.** For `1 ≤ N ≤ n < (N + 1)²` and `P` the product of the primes
`≤ N`: `π n - π N + 1 = ∑ d ∈ P.divisors, μ d * ⌊n / d⌋`, over `ℤ`. -/
theorem legendre {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n) (hn : n < (N + 1) ^ 2) :
    (Nat.primeCounting n : ℤ) - Nat.primeCounting N + 1
      = ∑ d ∈ (primeProd (Nat.primesLE N)).divisors, μ d * ((n / d : ℕ) : ℤ) := by
  rw [← count_primesLE_int hN hNn hn, count_eq_sum_divisors (prime_of_mem_primesLE N)]

/-- **Legendre's formula**, classical case `N = ⌊√n⌋`: for `n ≥ 1` and `P` the product of the
primes `≤ √n`, `π n - π ⌊√n⌋ + 1 = ∑ d ∈ P.divisors, μ d * ⌊n / d⌋`. -/
theorem legendre_sqrt {n : ℕ} (hn : 1 ≤ n) :
    (Nat.primeCounting n : ℤ) - Nat.primeCounting (Nat.sqrt n) + 1
      = ∑ d ∈ (primeProd (Nat.primesLE (Nat.sqrt n))).divisors, μ d * ((n / d : ℕ) : ℤ) :=
  legendre (Nat.sqrt_pos.2 hn) (Nat.sqrt_le_self n) (Nat.lt_succ_sqrt' n)

/-- **Legendre's formula, error-term form.** For `1 ≤ N ≤ n < (N + 1)²`, `S` the primes `≤ N`
and `P` their product: `π n - π N + 1 - density S * n = -∑ d ∈ P.divisors, μ d (n mod d) / d`,
over `ℚ`, with `density S = ∏ p ∈ S, (1 - 1/p)`. -/
theorem legendre_err {N n : ℕ} (hN : 1 ≤ N) (hNn : N ≤ n) (hn : n < (N + 1) ^ 2) :
    (Nat.primeCounting n : ℚ) - Nat.primeCounting N + 1 - density (Nat.primesLE N) * n
      = -∑ d ∈ (primeProd (Nat.primesLE N)).divisors, (μ d : ℚ) * ((n % d : ℕ) : ℚ) / d := by
  rw [← err_eq_sum_divisors (prime_of_mem_primesLE N), err]
  have h := congrArg (Int.cast : ℤ → ℚ) (count_primesLE_int hN hNn hn)
  push_cast at h
  rw [h]

end Moebius

/-! ## Numerical sanity checks -/

-- `N = 3`, `n = 10`: the integers `≤ 10` coprime to `6` are `1, 5, 7`.
example : count (Nat.primesLE 3) 10 = 3 := by decide +kernel
example : Nat.primeCounting 10 - Nat.primeCounting 3 + 1 = 3 := by decide +kernel
-- `N = 5`, `n = 30`: the integers `≤ 30` coprime to `30` are `1, 7, 11, 13, 17, 19, 23, 29`.
example : count (Nat.primesLE 5) 30 = 8 := by decide +kernel
example : Nat.primeCounting 30 - Nat.primeCounting 5 + 1 = 8 := by decide +kernel
-- The hypothesis `n < (N + 1)²` is needed: for `N = 2`, `n = 9` the integer `9` is counted.
example : count (Nat.primesLE 2) 9 = 5 ∧ Nat.primeCounting 9 - Nat.primeCounting 2 + 1 = 4 := by
  decide +kernel

section

open ArithmeticFunction
open scoped ArithmeticFunction.Moebius

-- The right-hand side of `legendre`: `10 - 5 - 3 + 1 = 3` and
-- `30 - 15 - 10 - 6 + 5 + 3 + 2 - 1 = 8`.
example : ∑ d ∈ (primeProd (Nat.primesLE 3)).divisors, μ d * ((10 / d : ℕ) : ℤ) = 3 := by
  decide +kernel
example : ∑ d ∈ (primeProd (Nat.primesLE 5)).divisors, μ d * ((30 / d : ℕ) : ℤ) = 8 := by
  decide +kernel

end

end BuildingBlocks.LegendreFormula
