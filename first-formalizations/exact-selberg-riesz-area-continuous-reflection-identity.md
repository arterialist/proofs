# First Formalization: Exact Selberg-Riesz Area Continuous Reflection Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergReflection.lean`](../../formalization/BuildingBlocks/SelbergReflection.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact continuous reflection identity relating the discrete centered Selberg auto-convolution area primitive $S(N)$ to the continuous integral pairing of the prime-counting error $E(a)$ with its reflected primitive deficit in Lean 4:

1. **Modified Error Deficit Identity:**
   Formal proof that $E(y) - \psi_1(y)/y = M_1(y)/y - y/2 - 1/(2y)$ (`primeError_sub_primitive_quotient`).
2. **Reflected Prime-Birth Moment Integration:**
   Formal proof of $\int_1^N E(a) M_1(N/a) da = \sum_{n \le N} n \Lambda(n) \psi_1(N/n)$ (`integral_primeError_reflected_birthMoment`).
3. **Double Hyperbola Primal Summation:**
   Formal proof expressing $\sum_{n \le N} n \Lambda(n) \psi_1(N/n)$ as the double sum $\sum (N-ab)\Lambda(a)\Lambda(b)$ plus harmonic and linear moment corrections (`reflected_primePrimitive_sum`).
4. **Exact Selberg Reflection Formula:**
   Formal proof that $S(N) = N \int_1^N \frac{E(a)}{a}(E(N/a) - \psi_1(N/a)/(N/a)) da$ (`selbergCenteredArea_reflection`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Modified prime error deficit identity
theorem primeError_sub_primitive_quotient {y : ℝ} (hy : 1 ≤ y) :
    primeErrorReal y - coarsePrefix 1 y / y =
      primeBirthMoment y / y - y / 2 - 1 / (2*y)

-- Integration of prime error against reflected birth moment
theorem integral_primeError_reflected_birthMoment {N : ℕ} (hN : 1 ≤ N) :
    (∫ a in (1 : ℝ)..(N : ℝ), primeErrorReal a * primeBirthMoment ((N : ℝ) / a)) =
      ∑ n ∈ Finset.Icc 1 N,
        (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n)

-- Reflected primitive sum in terms of double hyperbola sum
theorem reflected_primePrimitive_sum {N : ℕ} :
    (∑ n ∈ Finset.Icc 1 N,
      (n : ℝ) * ArithmeticFunction.vonMangoldt n * coarsePrefix 1 ((N : ℝ) / n)) =
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
      ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
        ArithmeticFunction.vonMangoldt b) -
    (N : ℝ)^2 / 2 * (∑ n ∈ Finset.Icc 1 N,
      ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
    (∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n) / 2

-- Exact Selberg continuous reflection theorem
theorem selbergCenteredArea_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = (N : ℝ) *
      ∫ a in (1 : ℝ)..(N : ℝ),
        primeErrorReal a *
          (primeErrorReal ((N : ℝ) / a) -
            coarsePrefix 1 ((N : ℝ) / a) / ((N : ℝ) / a)) / a
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact continuous reflection theorem connecting discrete Selberg area primitives to continuous integral pairings of prime errors without remainder terms.
