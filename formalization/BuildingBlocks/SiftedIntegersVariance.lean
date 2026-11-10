import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Associated
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.GCD.BigOperators
import Mathlib.Data.Nat.ModEq
import Mathlib.Data.Nat.Squarefree
import Mathlib.NumberTheory.ArithmeticFunction.Moebius

/-!
# Integers free of a finite set of primes: exact mean and variance of the counting error

Let `S` be a finite set of primes, `P = ∏ p ∈ S, p`, `k = #S` and
`a = ∏ p ∈ S, (1 - 1/p)`. Let `N(n)` be the number of `1 ≤ m ≤ n` coprime to `P`, and
`R(n) = N(n) - a n`. In this file `P = primeProd S`, `a = density S`, `N = count S`,
`R = err S`.

Main results, all over one period `n = 1, …, P`:

* `sum_Icc_err_sq`: for `S` nonempty, `∑ R(n)² = P (a 2^k / 12 + a² / 6)`.
* `sum_Icc_err`: for `S` nonempty, `∑ R(n) = a P / 2`. (`sum_Icc_err_empty`: the sum is `0`
  for `S = ∅`.)
* `variance_err`: `(∑ R(n)²)/P - ((∑ R(n))/P)² = a (2^k - a) / 12`, for every `S`.

The versions for every `S` (with the indicator of `S = ∅`), summed over `range P`, are
`sum_range_err_sq` and `sum_range_err`. `err_add_primeProd` is the periodicity of `R`.

The proof uses finite sums only (no Fourier analysis). Squarefree divisors of `P` are indexed
by subsets `T ⊆ S`, with `d = primeProd T` and `μ(d) = (-1)^#T`:

1. `count_eq_sum` (Legendre): `N(n) = ∑_{T ⊆ S} (-1)^#T ⌊n / d_T⌋`, and `density_eq_sum`:
   `a = ∑_{T ⊆ S} (-1)^#T / d_T`.
2. `err_eq_sum`: `R(n) = -∑_{T ⊆ S} (-1)^#T (n mod d_T) / d_T`.
3. `sum_mod_mul_mod`: for coprime `x, y`,
   `∑_{n < g x y z} (n mod g x)(n mod g y) = g x y z ((g x - 1)(g y - 1)/4 + (g² - 1)/12)`,
   by the Chinese remainder theorem in the form `sum_range_mul_mod_mod`.
4. `sum_powerset_inter_prod` and `sum_gcd_sq`:
   `∑_{T, U ⊆ S} (-1)^{#T + #U} gcd(d_T, d_U)² / (d_T d_U) = 2^k a`.

Steps 1 and 2 are restated with Mathlib's Möbius function over `P.divisors` in
`count_eq_sum_divisors`, `density_eq_sum_divisors` and `err_eq_sum_divisors`; the dictionary
is `sum_divisors_primeProd`.
-/

namespace BuildingBlocks.SiftedIntegersVariance

open Finset

/-! ## Definitions -/

/-- The product `P` of the primes in `S`. -/
def primeProd (S : Finset ℕ) : ℕ := ∏ p ∈ S, p

/-- The density `a = ∏ p ∈ S, (1 - 1/p)`. -/
def density (S : Finset ℕ) : ℚ := ∏ p ∈ S, (1 - 1 / (p : ℚ))

/-- `N(n)`: the number of `m` with `1 ≤ m ≤ n` coprime to `P`. -/
def count (S : Finset ℕ) (n : ℕ) : ℕ := #{m ∈ Icc 1 n | Nat.Coprime m (primeProd S)}

/-- The counting error `R(n) = N(n) - a n`. -/
def err (S : Finset ℕ) (n : ℕ) : ℚ := (count S n : ℚ) - density S * n

/-! ## Numerical sanity checks -/

example : ∑ n ∈ Icc 1 (primeProd {2}), err {2} n ^ 2 = 1 / 4 := by decide +kernel
example : ∑ n ∈ Icc 1 (primeProd {2}), err {2} n = 1 / 2 := by decide +kernel
example : (∑ n ∈ Icc 1 (primeProd {2}), err {2} n ^ 2) / primeProd {2}
    - ((∑ n ∈ Icc 1 (primeProd {2}), err {2} n) / primeProd {2}) ^ 2 = 1 / 16 := by
  decide +kernel
example : (∑ n ∈ Icc 1 (primeProd {3}), err {3} n ^ 2) / primeProd {3}
    - ((∑ n ∈ Icc 1 (primeProd {3}), err {3} n) / primeProd {3}) ^ 2 = 2 / 27 := by
  decide +kernel
example : (∑ n ∈ Icc 1 (primeProd {2, 3}), err {2, 3} n ^ 2) / primeProd {2, 3}
    - ((∑ n ∈ Icc 1 (primeProd {2, 3}), err {2, 3} n) / primeProd {2, 3}) ^ 2 = 11 / 108 := by
  decide +kernel
example : (∑ n ∈ Icc 1 (primeProd {3, 7}), err {3, 7} n ^ 2) / primeProd {3, 7}
    - ((∑ n ∈ Icc 1 (primeProd {3, 7}), err {3, 7} n) / primeProd {3, 7}) ^ 2 = 8 / 49 := by
  decide +kernel

/-! ## Finite sum tools -/

/-- A sum over `range (a * b)` split by quotient and remainder on division by `a`. -/
theorem sum_range_mul_eq (a b : ℕ) (F : ℕ → ℚ) :
    ∑ n ∈ range (a * b), F n = ∑ q ∈ range b, ∑ r ∈ range a, F (a * q + r) := by
  induction b with
  | zero => simp
  | succ b ih => rw [Nat.mul_succ, sum_range_add, ih, sum_range_succ]

/-- A function of `n mod x` summed over `z` full periods. -/
theorem sum_range_mul_mod (x z : ℕ) (f : ℕ → ℚ) :
    ∑ n ∈ range (x * z), f (n % x) = z * ∑ r ∈ range x, f r := by
  rw [sum_range_mul_eq]
  have h : ∀ q ∈ range z, ∑ r ∈ range x, f ((x * q + r) % x) = ∑ r ∈ range x, f r := by
    intro q _
    refine sum_congr rfl fun r hr => ?_
    rw [Nat.mul_add_mod, Nat.mod_eq_of_lt (mem_range.1 hr)]
  rw [sum_congr rfl h, sum_const, card_range, nsmul_eq_mul]

/-- For coprime `x, y`, the map `t ↦ (x t + i) mod y` permutes `range y`. -/
theorem sum_range_affine_mod {x y : ℕ} (hxy : Nat.Coprime x y) (i : ℕ) (h : ℕ → ℚ) :
    ∑ t ∈ range y, h ((x * t + i) % y) = ∑ j ∈ range y, h j := by
  rcases Nat.eq_zero_or_pos y with rfl | hy
  · simp
  have hinj : Set.InjOn (fun t => (x * t + i) % y) (range y : Set ℕ) := by
    intro t ht t' ht' htt
    simp only [coe_range, Set.mem_Iio] at ht ht'
    have h1 : x * t + i ≡ x * t' + i [MOD y] := htt
    have h2 : x * t ≡ x * t' [MOD y] := Nat.ModEq.add_right_cancel' i h1
    have h3 : t ≡ t' [MOD y] := Nat.ModEq.cancel_left_of_coprime hxy.symm h2
    exact h3.eq_of_lt_of_lt ht ht'
  have himg : (range y).image (fun t => (x * t + i) % y) = range y := by
    apply eq_of_subset_of_card_le
    · intro j hj
      rw [mem_image] at hj
      obtain ⟨t, -, rfl⟩ := hj
      exact mem_range.2 (Nat.mod_lt _ hy)
    · rw [card_image_of_injOn hinj]
  calc ∑ t ∈ range y, h ((x * t + i) % y)
      = ∑ j ∈ (range y).image (fun t => (x * t + i) % y), h j := (sum_image hinj).symm
    _ = ∑ j ∈ range y, h j := by rw [himg]

/-- Chinese remainder theorem as an identity of sums: for coprime `x, y` the pair
`(q mod x, q mod y)` runs once over `range x × range y` as `q` runs over `range (x * y)`. -/
theorem sum_range_mul_mod_mod {x y : ℕ} (hxy : Nat.Coprime x y) (f h : ℕ → ℚ) :
    ∑ q ∈ range (x * y), f (q % x) * h (q % y)
      = (∑ i ∈ range x, f i) * (∑ j ∈ range y, h j) := by
  rw [sum_range_mul_eq, sum_comm, sum_mul_sum]
  refine sum_congr rfl fun i hi => ?_
  have hi' := mem_range.1 hi
  have key : ∀ t, f ((x * t + i) % x) * h ((x * t + i) % y) = f i * h ((x * t + i) % y) := by
    intro t
    rw [Nat.mul_add_mod, Nat.mod_eq_of_lt hi']
  simp only [key]
  rw [← mul_sum, ← mul_sum, sum_range_affine_mod hxy i h]

theorem sum_range_cast (n : ℕ) : ∑ i ∈ range n, (i : ℚ) = n * (n - 1) / 2 := by
  induction n with
  | zero => simp
  | succ n ih => rw [sum_range_succ, ih]; push_cast; ring

theorem sum_range_cast_sq (n : ℕ) :
    ∑ i ∈ range n, (i : ℚ) ^ 2 = (n - 1) * n * (2 * n - 1) / 6 := by
  induction n with
  | zero => simp
  | succ n ih => rw [sum_range_succ, ih]; push_cast; ring

/-! ## Step 3: the correlation of two remainders -/

/-- **Key lemma.** For coprime `x, y` and any `g, z`, over `z` periods of length `g x y`,
`∑ (n mod g x)(n mod g y) = g x y z ((g x - 1)(g y - 1)/4 + (g² - 1)/12)`. -/
theorem sum_mod_mul_mod {x y : ℕ} (hxy : Nat.Coprime x y) (g z : ℕ) :
    ∑ n ∈ range (g * (x * y) * z), ((n % (g * x) : ℕ) : ℚ) * ((n % (g * y) : ℕ) : ℚ)
      = (g * x * y * z : ℚ) * (((g * x - 1) * (g * y - 1)) / 4 + ((g : ℚ) ^ 2 - 1) / 12) := by
  -- reduce to one period
  have hper : ∀ q ∈ range z, ∑ r ∈ range (g * (x * y)),
      (((g * (x * y) * q + r) % (g * x) : ℕ) : ℚ) * (((g * (x * y) * q + r) % (g * y) : ℕ) : ℚ)
      = ∑ r ∈ range (g * (x * y)), ((r % (g * x) : ℕ) : ℚ) * ((r % (g * y) : ℕ) : ℚ) := by
    intro q _
    refine sum_congr rfl fun r _ => ?_
    have e1 : g * (x * y) * q + r = g * x * (y * q) + r := by ring
    have e2 : g * (x * y) * q + r = g * y * (x * q) + r := by ring
    rw [show (g * (x * y) * q + r) % (g * x) = r % (g * x) by rw [e1, Nat.mul_add_mod],
      show (g * (x * y) * q + r) % (g * y) = r % (g * y) by rw [e2, Nat.mul_add_mod]]
  rw [sum_range_mul_eq, sum_congr rfl hper, sum_const, card_range, nsmul_eq_mul]
  -- one period: write `n = g q + r`
  have step : ∀ q ∈ range (x * y), ∑ r ∈ range g,
      (((g * q + r) % (g * x) : ℕ) : ℚ) * (((g * q + r) % (g * y) : ℕ) : ℚ)
      = ∑ r ∈ range g, (r : ℚ) ^ 2 + g * (∑ r ∈ range g, (r : ℚ)) * ((q % x : ℕ) : ℚ)
        + g * (∑ r ∈ range g, (r : ℚ)) * ((q % y : ℕ) : ℚ)
        + (g : ℚ) ^ 3 * (((q % x : ℕ) : ℚ) * ((q % y : ℕ) : ℚ)) := by
    intro q _
    have h1 : ∀ r ∈ range g,
        (((g * q + r) % (g * x) : ℕ) : ℚ) * (((g * q + r) % (g * y) : ℕ) : ℚ)
        = (r : ℚ) ^ 2 + g * ((q % x : ℕ) : ℚ) * (r : ℚ) + g * ((q % y : ℕ) : ℚ) * (r : ℚ)
          + (g : ℚ) ^ 2 * (((q % x : ℕ) : ℚ) * ((q % y : ℕ) : ℚ)) := by
      intro r hr
      have hr' := mem_range.1 hr
      have hg : 0 < g := by omega
      have e1 : (g * q + r) % g = r := by rw [Nat.mul_add_mod, Nat.mod_eq_of_lt hr']
      have e2 : (g * q + r) / g = q := by
        rw [Nat.mul_add_div hg, Nat.div_eq_of_lt hr', add_zero]
      rw [Nat.mod_mul, Nat.mod_mul, e1, e2]
      push_cast
      ring
    rw [sum_congr rfl h1, sum_add_distrib, sum_add_distrib, sum_add_distrib, ← mul_sum,
      ← mul_sum, sum_const, card_range, nsmul_eq_mul]
    ring
  rw [sum_range_mul_eq g (x * y), sum_congr rfl step, sum_add_distrib, sum_add_distrib,
    sum_add_distrib, ← mul_sum, ← mul_sum, ← mul_sum, sum_const, card_range, nsmul_eq_mul,
    sum_range_mul_mod_mod hxy (fun i => (i : ℚ)) (fun j => (j : ℚ)),
    sum_range_mul_mod x y (fun i => (i : ℚ))]
  have hy : ∑ q ∈ range (x * y), ((q % y : ℕ) : ℚ) = x * ∑ r ∈ range y, (r : ℚ) := by
    rw [mul_comm x y]
    exact sum_range_mul_mod y x (fun i => (i : ℚ))
  rw [hy, sum_range_cast, sum_range_cast, sum_range_cast, sum_range_cast_sq]
  push_cast
  ring

/-! ## Steps 1 and 2: Legendre's formula, indexed by subsets of `S` -/

variable {S : Finset ℕ}

theorem primeProd_pos (hS : ∀ p ∈ S, p.Prime) : 0 < primeProd S :=
  prod_pos fun p hp => (hS p hp).pos

theorem primeProd_ne_zero_of_subset (hS : ∀ p ∈ S, p.Prime) {T : Finset ℕ} (hT : T ⊆ S) :
    (primeProd T : ℚ) ≠ 0 :=
  Nat.cast_ne_zero.2 (primeProd_pos fun p hp => hS p (hT hp)).ne'

theorem primeProd_dvd_of_subset {T : Finset ℕ} (hT : T ⊆ S) : primeProd T ∣ primeProd S :=
  prod_dvd_prod_of_subset T S _ hT

/-- `∏ p ∈ T, (-1/p) = (-1)^#T / d_T`: the weight `μ(d)/d` of the squarefree `d = d_T`. -/
theorem prod_neg_inv_eq (T : Finset ℕ) :
    ∏ p ∈ T, (-(1 / (p : ℚ))) = (-1 : ℚ) ^ #T / (primeProd T : ℚ) := by
  rw [Finset.prod_neg, prod_div_distrib, prod_const_one, primeProd, Nat.cast_prod, mul_one_div]

/-- The indicator of `gcd(m, P) = 1` as an alternating sum over the squarefree divisors of
`P` that divide `m`. -/
theorem coprime_indicator (hS : ∀ p ∈ S, p.Prime) (m : ℕ) :
    (if Nat.Coprime m (primeProd S) then (1 : ℚ) else 0)
      = ∑ T ∈ S.powerset, (-1 : ℚ) ^ #T * (if primeProd T ∣ m then 1 else 0) := by
  have h1 : Nat.Coprime m (primeProd S) ↔ ∀ p ∈ S, ¬ p ∣ m := by
    rw [primeProd, Nat.coprime_prod_right_iff]
    refine forall₂_congr fun p hp => ?_
    rw [Nat.coprime_comm, (hS p hp).coprime_iff_not_dvd]
  have h2 : (if Nat.Coprime m (primeProd S) then (1 : ℚ) else 0)
      = ∏ p ∈ S, (1 + -(if p ∣ m then (1 : ℚ) else 0)) := by
    rw [if_congr h1 rfl rfl, ← prod_boole]
    refine prod_congr rfl fun p _ => ?_
    by_cases h : p ∣ m <;> simp [h]
  rw [h2, prod_one_add]
  refine sum_congr rfl fun T hT => ?_
  have hT' := mem_powerset.1 hT
  have h3 : (∀ p ∈ T, p ∣ m) ↔ primeProd T ∣ m := by
    constructor
    · intro h
      exact Finset.prod_primes_dvd m (fun p hp => (hS p (hT' hp)).prime) h
    · intro h p hp
      exact (dvd_prod_of_mem (fun p => p) hp).trans h
  rw [Finset.prod_neg, prod_boole, if_congr h3 rfl rfl]

/-- **Legendre's formula**: `N(n) = ∑_{T ⊆ S} (-1)^#T ⌊n / d_T⌋`. -/
theorem count_eq_sum (hS : ∀ p ∈ S, p.Prime) (n : ℕ) :
    (count S n : ℚ) = ∑ T ∈ S.powerset, (-1 : ℚ) ^ #T * ((n / primeProd T : ℕ) : ℚ) := by
  have hIcc : Icc 1 n = Ioc 0 n := by
    ext m
    simp only [mem_Icc, mem_Ioc]
    omega
  unfold count
  rw [card_filter, hIcc]
  push_cast
  simp only [coprime_indicator hS]
  rw [sum_comm]
  refine sum_congr rfl fun T _ => ?_
  rw [← mul_sum, ← Nat.Ioc_filter_dvd_card_eq_div, card_filter]
  push_cast
  rfl

/-- `a = ∑_{T ⊆ S} (-1)^#T / d_T`. -/
theorem density_eq_sum (S : Finset ℕ) :
    density S = ∑ T ∈ S.powerset, (-1 : ℚ) ^ #T / (primeProd T : ℚ) := by
  unfold density
  simp only [sub_eq_add_neg]
  rw [prod_one_add]
  exact sum_congr rfl fun T _ => prod_neg_inv_eq T

/-- **Step 2**: `R(n) = -∑_{T ⊆ S} (-1)^#T (n mod d_T) / d_T`. -/
theorem err_eq_sum (hS : ∀ p ∈ S, p.Prime) (n : ℕ) :
    err S n = -∑ T ∈ S.powerset, (-1 : ℚ) ^ #T * ((n % primeProd T : ℕ) : ℚ) / primeProd T := by
  unfold err
  rw [count_eq_sum hS, density_eq_sum, sum_mul, ← sum_sub_distrib, ← sum_neg_distrib]
  refine sum_congr rfl fun T hT => ?_
  have hpos : (primeProd T : ℚ) ≠ 0 := primeProd_ne_zero_of_subset hS (mem_powerset.1 hT)
  have hdiv : ((n / primeProd T : ℕ) : ℚ) = ((n : ℚ) - ((n % primeProd T : ℕ) : ℚ)) / primeProd T := by
    rw [eq_div_iff hpos]
    have h := congrArg (Nat.cast : ℕ → ℚ) (Nat.div_add_mod n (primeProd T))
    push_cast at h
    linarith
  rw [hdiv]
  ring

/-- `R` has period `P`. -/
theorem err_add_primeProd (hS : ∀ p ∈ S, p.Prime) (n : ℕ) :
    err S (n + primeProd S) = err S n := by
  rw [err_eq_sum hS, err_eq_sum hS]
  congr 1
  refine sum_congr rfl fun T hT => ?_
  obtain ⟨c, hc⟩ := primeProd_dvd_of_subset (mem_powerset.1 hT)
  rw [hc, Nat.add_mul_mod_self_left]

theorem err_zero (S : Finset ℕ) : err S 0 = 0 := by
  simp [err, count]

theorem err_primeProd (hS : ∀ p ∈ S, p.Prime) : err S (primeProd S) = 0 := by
  have h := err_add_primeProd hS 0
  rwa [zero_add, err_zero] at h

/-! ## The same formulas over the divisors of `P`, with the Möbius function -/

section Moebius

open ArithmeticFunction
open scoped ArithmeticFunction.Moebius

theorem moebius_primeProd (hS : ∀ p ∈ S, p.Prime) : μ (primeProd S) = (-1) ^ #S := by
  have hco : (S : Set ℕ).Pairwise (Function.onFun Nat.Coprime fun p => p) := by
    intro p hp q hq hpq
    exact (Nat.coprime_primes (hS p hp) (hS q hq)).2 hpq
  unfold primeProd
  rw [isMultiplicative_moebius.map_prod (fun p => p) S hco,
    prod_congr rfl (fun p hp => moebius_apply_prime (hS p hp)), prod_const]

theorem squarefree_primeProd (hS : ∀ p ∈ S, p.Prime) : Squarefree (primeProd S) := by
  apply Finset.squarefree_prod_of_pairwise_isCoprime
  · intro p hp q hq hpq
    exact Nat.coprime_iff_isRelPrime.1 ((Nat.coprime_primes (hS p hp) (hS q hq)).2 hpq)
  · intro p hp
    exact (hS p hp).squarefree

/-- The divisors of `P` are the products `d_T` over subsets `T ⊆ S`, and `μ(d_T) = (-1)^#T`. -/
theorem sum_divisors_primeProd (hS : ∀ p ∈ S, p.Prime) (f : ℕ → ℚ) :
    ∑ d ∈ (primeProd S).divisors, (μ d : ℚ) * f d
      = ∑ T ∈ S.powerset, (-1 : ℚ) ^ #T * f (primeProd T) := by
  symm
  refine sum_nbij' (fun T => primeProd T) (fun d => d.primeFactors) ?_ ?_ ?_ ?_ ?_
  · intro T hT
    exact Nat.mem_divisors.2
      ⟨primeProd_dvd_of_subset (mem_powerset.1 hT), (primeProd_pos hS).ne'⟩
  · intro d hd
    have hd' := Nat.mem_divisors.1 hd
    rw [mem_powerset]
    have h := Nat.primeFactors_mono hd'.1 hd'.2
    rwa [primeProd, Nat.primeFactors_prod hS] at h
  · intro T hT
    exact Nat.primeFactors_prod fun p hp => hS p (mem_powerset.1 hT hp)
  · intro d hd
    exact Nat.prod_primeFactors_of_squarefree
      ((squarefree_primeProd hS).squarefree_of_dvd (Nat.mem_divisors.1 hd).1)
  · intro T hT
    rw [moebius_primeProd fun p hp => hS p (mem_powerset.1 hT hp)]
    push_cast
    rfl

/-- **Legendre's formula** in its usual form: `N(n) = ∑_{d ∣ P} μ(d) ⌊n / d⌋`. -/
theorem count_eq_sum_divisors (hS : ∀ p ∈ S, p.Prime) (n : ℕ) :
    (count S n : ℤ) = ∑ d ∈ (primeProd S).divisors, μ d * ((n / d : ℕ) : ℤ) := by
  have h : (count S n : ℚ)
      = ∑ d ∈ (primeProd S).divisors, (μ d : ℚ) * ((n / d : ℕ) : ℚ) := by
    rw [sum_divisors_primeProd hS (fun d => ((n / d : ℕ) : ℚ)), count_eq_sum hS]
  apply Int.cast_injective (α := ℚ)
  push_cast
  exact h

/-- `a = ∑_{d ∣ P} μ(d) / d`. -/
theorem density_eq_sum_divisors (hS : ∀ p ∈ S, p.Prime) :
    density S = ∑ d ∈ (primeProd S).divisors, (μ d : ℚ) / d := by
  have h := sum_divisors_primeProd hS (fun d => 1 / (d : ℚ))
  simp only [mul_one_div] at h
  rw [h, density_eq_sum]

/-- `R(n) = -∑_{d ∣ P} μ(d) (n mod d) / d`: equation (1) of the written note at integers. -/
theorem err_eq_sum_divisors (hS : ∀ p ∈ S, p.Prime) (n : ℕ) :
    err S n = -∑ d ∈ (primeProd S).divisors, (μ d : ℚ) * ((n % d : ℕ) : ℚ) / d := by
  have h := sum_divisors_primeProd hS (fun d => ((n % d : ℕ) : ℚ) / (d : ℚ))
  simp only [← mul_div_assoc] at h
  rw [h, err_eq_sum hS]

end Moebius

/-! ## The mean over one period -/

theorem sum_powerset_neg_one_pow_card_rat (S : Finset ℕ) :
    ∑ T ∈ S.powerset, (-1 : ℚ) ^ #T = if S = ∅ then 1 else 0 := by
  have h := Finset.sum_powerset_neg_one_pow_card (x := S)
  exact_mod_cast h

/-- The mean identity over `range P`, for every `S`. -/
theorem sum_range_err (hS : ∀ p ∈ S, p.Prime) :
    ∑ n ∈ range (primeProd S), err S n
      = primeProd S * (density S - (if S = ∅ then 1 else 0)) / 2 := by
  simp only [err_eq_sum hS]
  rw [sum_neg_distrib, sum_comm]
  have h : ∀ T ∈ S.powerset, ∑ n ∈ range (primeProd S),
      (-1 : ℚ) ^ #T * ((n % primeProd T : ℕ) : ℚ) / primeProd T
      = primeProd S / 2 * ((-1 : ℚ) ^ #T - (-1 : ℚ) ^ #T / primeProd T) := by
    intro T hT
    have hT' := mem_powerset.1 hT
    have hP : primeProd S = primeProd T * primeProd (S \ T) := by
      rw [mul_comm]
      exact (prod_sdiff hT').symm
    have hpos : (primeProd T : ℚ) ≠ 0 := primeProd_ne_zero_of_subset hS hT'
    rw [← sum_div, ← mul_sum, hP,
      sum_range_mul_mod (primeProd T) (primeProd (S \ T)) (fun r => (r : ℚ)), sum_range_cast]
    push_cast
    field_simp
  rw [sum_congr rfl h, ← mul_sum, sum_sub_distrib, ← density_eq_sum,
    sum_powerset_neg_one_pow_card_rat]
  ring

/-! ## Step 4: the two product formulas -/

/-- A double sum over pairs of subsets, weighted on `T`, on `U` and on `T ∩ U`, is a
product over `S`. -/
theorem sum_powerset_inter_prod (S : Finset ℕ) (α β γ : ℕ → ℚ) :
    ∑ T ∈ S.powerset, ∑ U ∈ S.powerset,
        (∏ p ∈ T, α p) * (∏ p ∈ U, β p) * (∏ p ∈ T ∩ U, γ p)
      = ∏ p ∈ S, (1 + α p + β p + α p * β p * γ p) := by
  induction S using Finset.induction_on with
  | empty => simp
  | insert p S hp ih =>
    rw [prod_insert hp, ← ih, sum_powerset_insert hp]
    simp only [sum_powerset_insert hp]
    rw [← sum_add_distrib, mul_sum]
    refine sum_congr rfl fun T hT => ?_
    have hpT : p ∉ T := fun h => hp (mem_powerset.1 hT h)
    rw [← sum_add_distrib, ← sum_add_distrib, ← sum_add_distrib, mul_sum]
    refine sum_congr rfl fun U hU => ?_
    have hpU : p ∉ U := fun h => hp (mem_powerset.1 hU h)
    have hpTU : p ∉ T ∩ U := fun h => hpT (mem_inter.1 h).1
    have e1 : insert p T ∩ U = T ∩ U := insert_inter_of_notMem hpU
    have e2 : T ∩ insert p U = T ∩ U := inter_insert_of_notMem hpT
    have e3 : insert p T ∩ insert p U = insert p (T ∩ U) := (insert_inter_distrib T U p).symm
    rw [e1, e2, e3, prod_insert hpT, prod_insert hpU, prod_insert hpTU]
    ring

/-- `∑_{T, U ⊆ S} (-1)^{#T + #U} gcd(d_T, d_U)² / (d_T d_U) = 2^k a`. Here
`gcd(d_T, d_U) = d_{T ∩ U}`. -/
theorem sum_gcd_sq (hS : ∀ p ∈ S, p.Prime) :
    ∑ T ∈ S.powerset, ∑ U ∈ S.powerset,
        ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
          * (primeProd (T ∩ U) : ℚ) ^ 2
      = 2 ^ #S * density S := by
  have h := sum_powerset_inter_prod S (fun p => -(1 / (p : ℚ))) (fun p => -(1 / (p : ℚ)))
    (fun p => (p : ℚ) ^ 2)
  have hterm : ∀ T U : Finset ℕ,
      ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U) * (primeProd (T ∩ U) : ℚ) ^ 2
      = (∏ p ∈ T, -(1 / (p : ℚ))) * (∏ p ∈ U, -(1 / (p : ℚ))) * ∏ p ∈ T ∩ U, (p : ℚ) ^ 2 := by
    intro T U
    rw [prod_neg_inv_eq, prod_neg_inv_eq, prod_pow]
    simp only [primeProd, Nat.cast_prod]
  simp only [hterm]
  rw [h, density, ← prod_const, ← prod_mul_distrib]
  refine prod_congr rfl fun p hp => ?_
  have hp0 : (p : ℚ) ≠ 0 := Nat.cast_ne_zero.2 (hS p hp).ne_zero
  field_simp
  ring

/-! ## The second moment over one period -/

/-- Step 3 applied to two squarefree divisors `d_T, d_U` of `P`. -/
theorem sum_mod_primeProd (hS : ∀ p ∈ S, p.Prime) {T U : Finset ℕ} (hT : T ⊆ S) (hU : U ⊆ S) :
    ∑ n ∈ range (primeProd S), ((n % primeProd T : ℕ) : ℚ) * ((n % primeProd U : ℕ) : ℚ)
      = (primeProd S : ℚ) * (((primeProd T : ℚ) - 1) * ((primeProd U : ℚ) - 1) / 4
          + ((primeProd (T ∩ U) : ℚ) ^ 2 - 1) / 12) := by
  have hT' : primeProd T = primeProd (T ∩ U) * primeProd (T \ U) := by
    have h := prod_sdiff (f := fun p : ℕ => p) (inter_subset_left : T ∩ U ⊆ T)
    rw [sdiff_inter_self_left] at h
    unfold primeProd
    rw [← h, mul_comm]
  have hU' : primeProd U = primeProd (T ∩ U) * primeProd (U \ T) := by
    have h := prod_sdiff (f := fun p : ℕ => p) (inter_subset_right : T ∩ U ⊆ U)
    rw [inter_comm, sdiff_inter_self_left] at h
    unfold primeProd
    rw [← h, mul_comm, inter_comm]
  have hTU : primeProd (T ∪ U)
      = primeProd (T ∩ U) * (primeProd (T \ U) * primeProd (U \ T)) := by
    rw [← mul_assoc, ← hT', ← union_sdiff_self_eq_union]
    exact prod_union disjoint_sdiff
  have hP : primeProd S
      = primeProd (T ∩ U) * (primeProd (T \ U) * primeProd (U \ T))
        * primeProd (S \ (T ∪ U)) := by
    rw [← hTU, mul_comm]
    exact (prod_sdiff (union_subset hT hU)).symm
  have hco : Nat.Coprime (primeProd (T \ U)) (primeProd (U \ T)) := by
    unfold primeProd
    rw [Nat.coprime_prod_left_iff]
    intro p hp
    rw [Nat.coprime_prod_right_iff]
    intro q hq
    rw [Nat.coprime_primes (hS p (hT (mem_sdiff.1 hp).1)) (hS q (hU (mem_sdiff.1 hq).1))]
    rintro rfl
    exact (mem_sdiff.1 hp).2 (mem_sdiff.1 hq).1
  rw [hP, hT', hU', sum_mod_mul_mod hco]
  push_cast
  ring

/-- The second moment over `range P`, for every `S`. -/
theorem sum_range_err_sq (hS : ∀ p ∈ S, p.Prime) :
    ∑ n ∈ range (primeProd S), err S n ^ 2
      = (primeProd S : ℚ) * (((if S = ∅ then 1 else 0) - density S) ^ 2 / 4
          + (2 ^ #S * density S - density S ^ 2) / 12) := by
  have herr : ∀ n, err S n ^ 2 = ∑ T ∈ S.powerset, ∑ U ∈ S.powerset,
      ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
        * (((n % primeProd T : ℕ) : ℚ) * ((n % primeProd U : ℕ) : ℚ)) := by
    intro n
    rw [err_eq_sum hS, neg_sq, sq, sum_mul_sum]
    refine sum_congr rfl fun T _ => sum_congr rfl fun U _ => ?_
    ring
  have h1 : ∑ n ∈ range (primeProd S), err S n ^ 2 = ∑ T ∈ S.powerset, ∑ U ∈ S.powerset,
      ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
        * ∑ n ∈ range (primeProd S),
            ((n % primeProd T : ℕ) : ℚ) * ((n % primeProd U : ℕ) : ℚ) := by
    simp only [herr]
    rw [sum_comm]
    refine sum_congr rfl fun T _ => ?_
    rw [sum_comm]
    refine sum_congr rfl fun U _ => ?_
    rw [mul_sum]
  have h2 : ∀ T ∈ S.powerset, ∀ U ∈ S.powerset,
      ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
        * ∑ n ∈ range (primeProd S),
            ((n % primeProd T : ℕ) : ℚ) * ((n % primeProd U : ℕ) : ℚ)
      = (primeProd S : ℚ) / 4
          * (((-1 : ℚ) ^ #T - (-1 : ℚ) ^ #T / primeProd T)
            * ((-1 : ℚ) ^ #U - (-1 : ℚ) ^ #U / primeProd U))
        + (primeProd S : ℚ) / 12
          * (((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
            * (primeProd (T ∩ U) : ℚ) ^ 2)
        - (primeProd S : ℚ) / 12
          * (((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)) := by
    intro T hT U hU
    have hT0 : (primeProd T : ℚ) ≠ 0 := primeProd_ne_zero_of_subset hS (mem_powerset.1 hT)
    have hU0 : (primeProd U : ℚ) ≠ 0 := primeProd_ne_zero_of_subset hS (mem_powerset.1 hU)
    rw [sum_mod_primeProd hS (mem_powerset.1 hT) (mem_powerset.1 hU)]
    field_simp
    ring
  rw [h1, sum_congr rfl fun T hT => sum_congr rfl fun U hU => h2 T hT U hU]
  have hsplit : ∀ (c : ℚ) (A B : Finset ℕ → ℚ) (W : Finset ℕ → Finset ℕ → ℚ),
      ∑ T ∈ S.powerset, ∑ U ∈ S.powerset,
        (c / 4 * (A T * A U) + c / 12 * W T U - c / 12 * (B T * B U))
      = c / 4 * ((∑ T ∈ S.powerset, A T) * ∑ U ∈ S.powerset, A U)
        + c / 12 * (∑ T ∈ S.powerset, ∑ U ∈ S.powerset, W T U)
        - c / 12 * ((∑ T ∈ S.powerset, B T) * ∑ U ∈ S.powerset, B U) := by
    intro c A B W
    rw [sum_mul_sum, sum_mul_sum]
    simp only [mul_sum, sum_add_distrib, sum_sub_distrib]
  rw [hsplit (primeProd S : ℚ) (fun T => (-1 : ℚ) ^ #T - (-1 : ℚ) ^ #T / primeProd T)
    (fun T => (-1 : ℚ) ^ #T / primeProd T)
    (fun T U => ((-1 : ℚ) ^ #T / primeProd T) * ((-1 : ℚ) ^ #U / primeProd U)
            * (primeProd (T ∩ U) : ℚ) ^ 2),
    sum_gcd_sq hS, sum_sub_distrib, ← density_eq_sum, sum_powerset_neg_one_pow_card_rat]
  ring

/-! ## Main statements over `n = 1, …, P` -/

/-- Since `R(0) = R(P) = 0`, sums over `Icc 1 P` and over `range P` agree. -/
theorem sum_Icc_eq_sum_range (f : ℕ → ℚ) (P : ℕ) (h0 : f 0 = 0) (hP : f P = 0) :
    ∑ n ∈ Icc 1 P, f n = ∑ n ∈ range P, f n := by
  have hIcc : Icc 1 P = Ico 1 (P + 1) := by
    ext m
    simp only [mem_Icc, mem_Ico]
    omega
  have h1 : ∑ n ∈ range (P + 1), f n = f 0 + ∑ n ∈ Icc 1 P, f n := by
    rw [range_eq_Ico, sum_eq_sum_Ico_succ_bot (Nat.succ_pos P), hIcc]
  rw [sum_range_succ, h0, hP] at h1
  linarith

/-- **Second moment.** For a nonempty finite set `S` of primes,
`∑_{n=1}^{P} R(n)² = P (a 2^k / 12 + a² / 6)`. -/
theorem sum_Icc_err_sq (hS : ∀ p ∈ S, p.Prime) (hne : S.Nonempty) :
    ∑ n ∈ Icc 1 (primeProd S), err S n ^ 2
      = (primeProd S : ℚ) * (density S * 2 ^ #S / 12 + density S ^ 2 / 6) := by
  rw [sum_Icc_eq_sum_range (fun n => err S n ^ 2) _ (by simp [err_zero])
    (by simp [err_primeProd hS]), sum_range_err_sq hS, ite_eq_right hne.ne_empty]
  ring

/-- **Mean.** For a nonempty finite set `S` of primes, `∑_{n=1}^{P} R(n) = a P / 2`. -/
theorem sum_Icc_err (hS : ∀ p ∈ S, p.Prime) (hne : S.Nonempty) :
    ∑ n ∈ Icc 1 (primeProd S), err S n = density S * primeProd S / 2 := by
  rw [sum_Icc_eq_sum_range (err S) _ (err_zero S) (err_primeProd hS), sum_range_err hS,
    ite_eq_right hne.ne_empty]
  ring

/-- For `S = ∅` every integer is counted, `R = 0`, and the mean sum is `0`. -/
theorem sum_Icc_err_empty : ∑ n ∈ Icc 1 (primeProd ∅), err ∅ n = 0 := by
  rw [sum_Icc_eq_sum_range (err ∅) _ (err_zero ∅) (err_primeProd (by simp)),
    sum_range_err (by simp)]
  simp [density]

/-- **Variance over one period.** For every finite set `S` of primes (empty or not),
`(1/P) ∑_{n=1}^{P} R(n)² - ((1/P) ∑_{n=1}^{P} R(n))² = a (2^k - a) / 12`. -/
theorem variance_err (hS : ∀ p ∈ S, p.Prime) :
    (∑ n ∈ Icc 1 (primeProd S), err S n ^ 2) / primeProd S
        - ((∑ n ∈ Icc 1 (primeProd S), err S n) / primeProd S) ^ 2
      = density S * (2 ^ #S - density S) / 12 := by
  have hP : (primeProd S : ℚ) ≠ 0 := primeProd_ne_zero_of_subset hS (subset_refl S)
  rw [sum_Icc_eq_sum_range (fun n => err S n ^ 2) _ (by simp [err_zero])
    (by simp [err_primeProd hS]), sum_range_err_sq hS,
    sum_Icc_eq_sum_range (err S) _ (err_zero S) (err_primeProd hS), sum_range_err hS]
  field_simp
  ring

end BuildingBlocks.SiftedIntegersVariance
