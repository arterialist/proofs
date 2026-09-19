# First Formalization: The Arithmetic Birth Gram Kernel and Universal Positive Semidefiniteness

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/ChargeFrozenBirthGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthGram.lean), [`formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthFiniteGram.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic and operator-theoretic properties of the arithmetic birth Gram kernel $K(m, n)$:

1. **Off-Diagonal Cross Integrals and Rank-1 Factorization:**
   Formal proof that for any $2 \le m < N$, the $L^2(0, \infty)$ inner product of the birth increments factors as $(\Lambda(m+1) - 1) \left( \frac{\Lambda(N+1)}{N+1} - \log\left(1 + \frac{1}{N}\right) \right)$ (`birth_gram_integral`), using disjoint interval unions and almost-everywhere support containment.
2. **Identification with the Arithmetic Matrix Kernel:**
   Formal verification that the piecewise integral $\int_0^\infty \delta_m(v) \delta_n(v) dv$ identically matches the arithmetic definition `gramKernel m n` on all pairs $(m, n)$ with $2 \le m, n$ (`birth_gram_eq_kernel`).
3. **Finite Energy Double-Sum Representation:**
   Formal expansion and Fubini interchange proving that the continuous $L^2$ norm of any finite linear combination $\sum_{n \in s} c_n \delta_n$ equals the discrete quadratic form $\sum_{m, n \in s} c_m c_n K(m, n)$ (`finite_energy_eq_kernel`).
4. **Universal Finite Positive Semidefiniteness:**
   Formal deduction that for every finite index set $s \subset \{n \in \mathbb{N} \mid n \ge 2\}$ and real coefficients $c$, the arithmetic matrix quadratic form is unconditionally non-negative: $\sum_{m, n \in s} c_m c_n K(m, n) \ge 0$ (`finite_kernel_quadratic_nonnegative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Gram kernel definition
noncomputable def gramKernel (m n : ℕ) : ℝ :=
  if m < n then (ArithmeticFunction.vonMangoldt (m + 1) - 1) *
    (ArithmeticFunction.vonMangoldt (n + 1) / ((n + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (n : ℝ)))
  else if n < m then (ArithmeticFunction.vonMangoldt (n + 1) - 1) *
    (ArithmeticFunction.vonMangoldt (m + 1) / ((m + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (m : ℝ)))
  else 1 + (m : ℝ) / ((m + 1 : ℕ) : ℝ) - 2 * (m : ℝ) * Real.log (1 + 1 / (m : ℝ)) +
    (ArithmeticFunction.vonMangoldt (m + 1) - 1)^2 / ((m + 1 : ℕ) : ℝ)

-- Off-diagonal integral evaluation
theorem birth_gram_integral {m N : ℕ} (hm : 2 ≤ m) (hmN : m < N) (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment N v) =
      (ArithmeticFunction.vonMangoldt (m + 1) - 1) * (ArithmeticFunction.vonMangoldt (N + 1) /
        ((N + 1 : ℕ) : ℝ) - Real.log (1 + 1 / (N : ℝ)))

-- Kernel identity
theorem birth_gram_eq_kernel {m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n) :
    (∫ v in Ioi (0 : ℝ), increment m v * increment n v) = gramKernel m n

-- Universal positive semidefiniteness
theorem finite_kernel_quadratic_nonnegative (s : Finset ℕ) (c : ℕ → ℝ)
    (hs : ∀ n ∈ s, 2 ≤ n) : 0 ≤ ∑ m ∈ s, ∑ n ∈ s, c m * c n * gramKernel m n
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of the exact arithmetic Gram kernel representing causal prime step transitions and its unconditional positive semidefiniteness on all finite subsets of natural numbers.
