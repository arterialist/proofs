# First Formalization: Exact Factorial-Geometric Mertens Convolution and Quotient-Floor Square Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialGeometricMertens.lean`](../../formalization/BuildingBlocks/FactorialGeometricMertens.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite quotient triangle duality identity, the quotient-floor repetition multiplicity $L^2$ bound, and the exact geometric Mertens representation of the factorial binary carry response function in Lean 4:

1. **Quotient Triangle Duality:**
   Formal proof that $\sum_{n=1}^N a(n) \sum_{j < N/n} q^j = \sum_{j < N} q^j \sum_{n \le N/(j+1)} a(n)$ (`quotient_triangle`).
2. **Quotient-Floor Multiplicity Bound:**
   Formal proof that $\sum_{N=1}^X f(\lfloor N/j \rfloor)^2 \le j \sum_{m=0}^X f(m)^2$ via fiberwise decomposition and cardinality bounding (`quotient_floor_square_bound`).
3. **Exact Geometric Mertens Representation:**
   Formal proof that the factorial carry response function equals $(1 - e^{-t}) \sum_{j < N} e^{-jt} M(\lfloor N/(j+1) \rfloor)$ (`response_geometric`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact quotient triangle duality
theorem quotient_triangle (N : ℕ) (a : ℕ → ℝ) (q : ℝ) :
    (∑ n ∈ Icc 1 N, a n * ∑ j ∈ range (N / n), q ^ j) =
      ∑ j ∈ range N, q ^ j * ∑ n ∈ Icc 1 (N / (j + 1)), a n

-- Quotient-floor repetition multiplicity bound
theorem quotient_floor_square_bound (X j : ℕ) (hj : 0 < j) (f : ℕ → ℝ) :
    (∑ N ∈ Icc 1 X, f (N / j) ^ 2) ≤
      (j : ℝ) * ∑ m ∈ range (X + 1), f m ^ 2

-- Exact geometric Mertens representation
theorem response_geometric (N : ℕ) (t : ℝ) :
    FactorialBinaryCarry.response N t =
      (1 - Real.exp (-t)) * ∑ j ∈ range N,
        Real.exp (-t) ^ j * (BuildingBlocks.MertensTransfer.mertens (N / (j + 1)) : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 expressing exponential arithmetic carry responses as exact discrete geometric convolutions of the Mertens function, with fiberwise-proven quotient multiplicity bounds.
