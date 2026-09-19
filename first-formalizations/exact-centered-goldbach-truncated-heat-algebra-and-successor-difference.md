# First Formalization: Exact Centered Goldbach Truncated Heat Algebra and Successor Difference

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CenteredGoldbachTruncatedHeat.lean`](../../formalization/BuildingBlocks/CenteredGoldbachTruncatedHeat.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Cauchy product algebra, compact support bounds, interior uncentered identification, and discrete successor difference identities for the centered Goldbach heat polynomial in Lean 4:

1. **Finite Cauchy Product Expansion:**
   Formal derivation of $(H_Y(z))^2 = \sum_{N=2}^{2Y} r_c^{(Y)}(N) z^N$ (`truncatedHeat_square`) and its exponential heat formulation (`centered_finiteHeat_square`).
2. **Support Ceiling:**
   Formal proof that $r_c^{(Y)}(N) = 0$ for all $N > 2Y$ (`truncatedCoefficient_eq_zero_of_two_mul_lt`).
3. **Interior Identification:**
   Formal proof that for all $2 \le N \le Y + 1$, truncation does not affect the convolution: $r_c^{(Y)}(N) = r_c(N)$ (`truncatedCoefficient_interior`).
4. **Chebyshev Representation:**
   Formal proof that $r_c(N) = r_\Lambda(N) - 2\psi(N-1) + (N-1)$ (`truncatedCoefficient_interior_prime_psi`).
5. **Exact Additive Successor Difference:**
   Formal derivation of $r_c(N+1) - r_c(N) = \sum_{m=1}^{N-1} \Lambda(m)(\Lambda(N+1-m) - \Lambda(N-m)) - 2\Lambda(N) + 1$ (`centeredGoldbach_successor`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Truncated heat polynomial Cauchy square
theorem truncatedHeat_square (Y : ℕ) (z : ℝ) :
    truncatedHeat Y z ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N * z ^ N

-- Truncated heat square in exponential time
theorem centered_finiteHeat_square (Y : ℕ) (t : ℝ) :
    finiteHeat centeredCoefficient Y t ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N *
        Real.exp (-((N : ℝ) * t))

-- Support vanishes above 2Y
theorem truncatedCoefficient_eq_zero_of_two_mul_lt {Y N : ℕ} (hN : 2 * Y < N) :
    truncatedCoefficient Y N = 0

-- Invariance on the interior interval [2, Y+1]
theorem truncatedCoefficient_interior {Y N : ℕ} (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N = shiftedGoldbach (N - 2)

-- Exact Chebyshev representation
theorem truncatedCoefficient_interior_prime_psi {Y N : ℕ}
    (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N =
      shiftedPrimeGoldbach (N - 2) - 2 * BuildingBlocks.CoarsePrimitive.psi (N - 1) +
        (N - 1 : ℕ)

-- Closed additive successor difference formula
theorem centeredGoldbach_successor {N : ℕ} (hN : 2 ≤ N) :
    shiftedGoldbach (N - 1) - shiftedGoldbach (N - 2) =
      (∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
        (ArithmeticFunction.vonMangoldt (N + 1 - m) -
          ArithmeticFunction.vonMangoldt (N - m))) -
        2 * ArithmeticFunction.vonMangoldt N + 1
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the exact Cauchy algebra, sharp interior invariance, and closed successor difference formula $\Delta r_c(N) = \Lambda * \nabla \Lambda - 2\Lambda(N) + 1$ for centered Goldbach convolutions.
