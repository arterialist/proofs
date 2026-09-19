# First Formalization: Exact Finite First Mellin Moment of the Prime Error and Primitive

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeFirstMoment.lean`](../../formalization/BuildingBlocks/PrimeFirstMoment.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite first Mellin moment of the prime-counting error $E(t) = \psi(t) - t$, its connection to the prime primitive area via right-differentiable integration by parts, and the exact arithmetic representation of the primitive moment in Lean 4:

1. **Exact Finite First Mellin Moment:**
   Formal proof of $\int_1^N \frac{E(t)}{t^2} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N$ (`primeError_first_moment`).
2. **Right-Differentiable Integration by Parts:**
   Formal proof of $\int_1^T \frac{E(t)}{t^2} dt = \frac{\psi_1(T)}{T^2} + 2\int_1^T \frac{\psi_1(t)}{t^3} dt$ (`coarsePrefix_first_moment`).
3. **Exact Arithmetic Primitive Moment Representation:**
   Formal proof evaluating $2\int_1^N \frac{\psi_1(t)}{t^3} dt = \sum_{n=1}^N \frac{\Lambda(n)}{n} - \frac{\psi(N)}{N} - \log N - \frac{\psi_1(N)}{N^2}$ (`primePrimitive_first_moment`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite first Mellin moment of prime error
theorem primeError_first_moment {N : ℕ} (hN : 1 ≤ N) :
    (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t / t ^ 2) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ)

-- Integration by parts connecting error moment to primitive
theorem coarsePrefix_first_moment {T : ℝ} (hT : 1 ≤ T) :
    (∫ t in (1 : ℝ)..T, primeErrorReal t / t ^ 2) =
      coarsePrefix 1 T / T ^ 2 +
        2 * ∫ t in (1 : ℝ)..T, coarsePrefix 1 t / t ^ 3

-- Exact arithmetic representation of primitive moment
theorem primePrimitive_first_moment {N : ℕ} (hN : 1 ≤ N) :
    2 * (∫ t in (1 : ℝ)..(N : ℝ), coarsePrefix 1 t / t ^ 3) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) -
        psi N / (N : ℝ) - Real.log (N : ℝ) - coarsePrefix 1 N / (N : ℝ) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact finite first Mellin moment identity for the prime error and its primitive with all boundary terms explicitly evaluated.
