# First Formalization 345: Exact Proper-Cofactor Dirichlet Dual Algebra and Multiplicative Prime-Row Convolution

**Lean 4 Source File:** [`formalization/BuildingBlocks/ActualCofactorDirichletDualAlgebra.lean`](../../formalization/BuildingBlocks/ActualCofactorDirichletDualAlgebra.lean)  
**Corresponding Unique Contribution:** [`unique-contributions/exact-proper-cofactor-dirichlet-dual-algebra-and-multiplicative-convolution.md`](../../unique-contributions/exact-proper-cofactor-dirichlet-dual-algebra-and-multiplicative-convolution.md)  
**Verification Date:** September 2026  
**Build Status:** Clean build (`lake build BuildingBlocks`), 0 warnings, 0 `sorry`, 0 custom axioms.  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]`.

---

## 1. Formalization Summary

This entry documents a machine-checked proof that the von Mangoldt prime-power row $P(N, g)$ decomposes identically into the non-oscillatory logarithmic row $L(N, g)$ minus the proper-cofactor dilated prime-power rows, and that against completely multiplicative weights $\chi$, this forms an exact finite Dirichlet convolution equation.

The formalization achieves:
1. Complete involution-based proof of divisor-sum symmetry `sum_divisors_swap`.
2. Hyperbolic factor-pair transposition `factor_pairs_swap` for general additive commutative monoids.
3. Transposition of proper cofactor sums `proper_cofactor_pairs_swap` for additive commutative groups.
4. Exact finite von Mangoldt divisor expansion `weighted_log_eq_complete_future`.
5. Exact prime-row decomposition `primeRow_eq_logRow_sub_cofactors` for arbitrary complex weights.
6. Square-root normalized prime-row decomposition `primeRowSqrt_eq_logRowSqrt_sub_cofactors` matching the Weil form.
7. Complete Dirichlet convolution `multiplicative_dirichlet_convolution_primeRow` for multiplicative weights.
8. Truncated proper-cofactor decomposition `truncated_prime_cofactor_identity` separating low and high cofactors.

---

## 2. Key Formal Statements and Machine Types

```lean
/-- Divisor sum reordering via the involution d ↦ n/d. -/
theorem sum_divisors_swap {R : Type*} [AddCommMonoid R]
    (n : ℕ) (hn : n ≠ 0) (f : ℕ → ℕ → R) :
    (∑ d ∈ n.divisors, f d (n / d)) = ∑ d ∈ n.divisors, f (n / d) d

/-- Exact transposition of factor pairs on the hyperbolic domain a * b ≤ N. -/
theorem factor_pairs_swap {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ a ∈ Icc 1 N, ∑ b ∈ Icc 1 (N / a), f a b) =
      ∑ b ∈ Icc 1 N, ∑ a ∈ Icc 1 (N / b), f a b

/-- Exact transposition of proper-cofactor factor pairs (k ≥ 2). -/
theorem proper_cofactor_pairs_swap {R : Type*} [AddCommGroup R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    (∑ d ∈ Icc 1 N, ∑ k ∈ Icc 2 (N / d), f d k) =
      ∑ k ∈ Icc 2 N, ∑ d ∈ Icc 1 (N / k), f d k

/-- The prime-power row equals the logarithmic row minus the sum of proper-cofactor dilated prime rows. -/
theorem primeRow_eq_logRow_sub_cofactors (N : ℕ) (g : ℕ → ℂ) :
    primeRow N g = logRow N g -
      ∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => g (k * d))

/-- Square-root normalized prime row decomposition. -/
theorem primeRowSqrt_eq_logRowSqrt_sub_cofactors (N : ℕ) (h : ℕ → ℂ) :
    primeRowSqrt N h = logRowSqrt N h -
      ∑ k ∈ Icc 2 N, primeRow (N / k) (fun d => h (k * d) / (Real.sqrt ((k * d : ℕ) : ℝ) : ℂ))

/-- For completely multiplicative weights, the prime-power row convolution with χ recovers the logarithmic row. -/
theorem multiplicative_dirichlet_convolution_primeRow (N : ℕ) (χ : ℕ → ℂ)
    (hN : 1 ≤ N) (hχ1 : χ 1 = 1) (hχ_mul : ∀ k d, χ (k * d) = χ k * χ d) :
    (∑ k ∈ Icc 1 N, χ k * primeRow (N / k) χ) = logRow N χ

/-- Truncated Dirichlet cofactor decomposition against high cofactors. -/
theorem truncated_prime_cofactor_identity (N K : ℕ) (χ : ℕ → ℂ)
    (hK : 2 ≤ K) (hKN : K ≤ N) (hχ1 : χ 1 = 1) (hχ_mul : ∀ k d, χ (k * d) = χ k * χ d) :
    (∑ k ∈ Icc 1 K, χ k * primeRow (N / k) χ) =
      logRow N χ - ∑ k ∈ Icc (K + 1) N, χ k * primeRow (N / k) χ
```

---

## 3. Axiom Verification Output

```text
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.sum_divisors_swap' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.factor_pairs_swap' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.proper_cofactor_pairs_swap' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.primeRow_eq_logRow_sub_cofactors' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.primeRowSqrt_eq_logRowSqrt_sub_cofactors' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.multiplicative_dirichlet_convolution_primeRow' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualCofactorDirichletDualAlgebra.truncated_prime_cofactor_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
```
