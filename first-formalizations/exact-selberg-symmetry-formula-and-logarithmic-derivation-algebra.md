# First Formalization: Exact Selberg Symmetry Formula and Logarithmic Derivation Algebra

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergIdentity.lean`](../../formalization/BuildingBlocks/SelbergIdentity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebra of the Selberg symmetry formula, including the logarithmic derivation on Dirichlet convolutions, the operator identity $\Lambda_2 = \mu * \log^2$, pointwise non-negativity $\Lambda_2(n) \ge 0$, and the exact finite sum identity relating prime-log moments, Chebyshev convolutions, and Möbius-weighted squared-log sums in Lean 4:

1. **Logarithmic Derivation:**
   Formal proof that multiplication by $\log$ is a derivation on $(ArithmeticFunction, *)$ (`log_weighted_convolution`).
2. **Möbius-Logarithm Operator Identity:**
   Formal proof of $\Lambda_2 = \mu * \log^2$ (`selbergWeight_eq_moebius_logSquare`).
3. **Pointwise Non-Negativity:**
   Formal proof that $\Lambda_2(n) \ge 0$ for all $n$ (`selbergWeight_nonneg`).
4. **Exact Finite Selberg Symmetry Formula:**
   Formal proof of the exact sum identity $\sum \Lambda \log + \sum \Lambda \psi = \sum \mu \sum \log^2$ (`selberg_exact_identity`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic derivation on Dirichlet convolutions
theorem log_weighted_convolution (f g : ArithmeticFunction ℝ) :
    (f * g).pmul ArithmeticFunction.log =
      f.pmul ArithmeticFunction.log * g + f * g.pmul ArithmeticFunction.log

-- Second von Mangoldt weight equals Moebius convolved with log^2
theorem selbergWeight_eq_moebius_logSquare :
    selbergWeight = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      ArithmeticFunction.log.pmul ArithmeticFunction.log

-- Pointwise evaluation of Selberg weight
theorem selbergWeight_apply (n : ℕ) :
    selbergWeight n = ArithmeticFunction.vonMangoldt n * Real.log n +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d)

-- Non-negativity of Selberg weight
theorem selbergWeight_nonneg (n : ℕ) : 0 ≤ selbergWeight n

-- Exact finite Selberg symmetry formula
theorem selberg_exact_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * Real.log n) +
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * psi (N / n)) =
        ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
          ∑ k ∈ Finset.Icc 1 (N / d), Real.log k ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact finite Selberg symmetry formula and establishing that multiplication by $\log$ is a derivation on the arithmetic Dirichlet convolution algebra.
