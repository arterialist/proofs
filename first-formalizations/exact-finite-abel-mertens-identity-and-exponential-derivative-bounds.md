# First Formalization: Exact Finite Abel-Mertens Identity and Exponential Derivative Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualFiniteAbelMertens.lean`](../../formalization/BuildingBlocks/ActualFiniteAbelMertens.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite Abel summation formula for the Mertens function and exponential Möbius derivatives in Lean 4:

1. **Exact Discrete Abel Summation Formula:**
   Formal inductive proof that $\sum_{n=1}^N \mu(n) q^n = M(N) q^N + (1 - q) \sum_{k=0}^{N-1} M(k) q^k$ (`truncated_mobius_abel`).
2. **Exponential Möbius Sum Derivative:**
   Formal derivation of the derivative for $\sum_{n=1}^N \mu(n) e^{-nt}$ (`hasDerivAt_truncatedMobiusExp`).
3. **Absolute Derivative Majorization:**
   Formal proof of $|E_N'(t)| \le \sum_{k=0}^{N-1} (k+1) e^{-(k+1)t}$ (`abs_truncatedMobiusDerivative_le`).
4. **Consecutive Grid Gap Identity:**
   Formal verification that $2/X - 2/(X+1) = 2/(X(X+1))$ (`integer_grid_gap`, `integer_grid_gap_pos`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite Abel-Mertens identity
theorem truncated_mobius_abel (N : ℕ) (q : ℝ) :
    truncatedMobiusPower N q =
      finiteMertens N * q ^ N +
        (1 - q) * ∑ k ∈ range N, finiteMertens k * q ^ k

-- Exact derivative of finite exponential Möbius sum
theorem hasDerivAt_truncatedMobiusExp (N : ℕ) (t : ℝ) :
    HasDerivAt (truncatedMobiusExp N) (truncatedMobiusDerivative N t) t

-- Non-asymptotic absolute derivative bound
theorem abs_truncatedMobiusDerivative_le (N : ℕ) (t : ℝ) :
    |truncatedMobiusDerivative N t| ≤
      ∑ k ∈ range N, ((k + 1 : ℕ) : ℝ) *
        Real.exp (-((k + 1 : ℕ) : ℝ) * t)

-- Sampling grid gap identity
theorem integer_grid_gap (X : ℕ) (hX : 1 ≤ X) :
    (2 : ℝ) / X - 2 / (X + 1) = 2 / (X * (X + 1))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 of the exact discrete Abel-Mertens summation identity with the boundary term $M(N) q^N$ and its associated exponential derivative bounds.
