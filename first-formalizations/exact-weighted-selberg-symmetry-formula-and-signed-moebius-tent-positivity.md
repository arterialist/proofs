# First Formalization: Exact Weighted Selberg Symmetry Formula and Signed Möbius Tent Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergTent.lean`](../../formalization/BuildingBlocks/SelbergTent.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite weighted Selberg symmetry formula for general real weights $w(n)$, the triangular tent filter specialization $w(n) = N - n$, and the unconditional non-negativity of the signed Möbius tent sum in Lean 4:

1. **Exact Weighted Selberg Identity:**
   Formal proof that $\sum_{n \le N} w(n)\Lambda(n)\log n + \sum_{a \le N} \Lambda(a) \sum_{b \le N/a} w(ab)\Lambda(b) = \sum_{d \le N} \mu(d)\sum_{q \le N/d} w(dq)\log^2 q$ (`selberg_weighted_identity`).
2. **Tent Specialization:**
   Formal proof specializing the weighted identity to the linear tent weight $w(n) = N - n$ (`selberg_tent_identity`).
3. **Signed Möbius Tent Positivity:**
   Formal proof that the signed double sum $\sum_{d=1}^N \mu(d)\sum_{q=1}^{\lfloor N/d \rfloor}(N - dq)\log^2 q$ is non-negative for all $N \in \mathbb{N}$ (`selberg_moebius_tent_nonneg`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact weighted Selberg identity for an arbitrary real weight
theorem selberg_weighted_identity (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N,
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2

-- Triangular tent specialization
theorem selberg_tent_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N,
      ((N : ℝ) - n) * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d),
          ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2

-- Unconditional non-negativity of the signed Möbius tent sum
theorem selberg_moebius_tent_nonneg (N : ℕ) :
    0 ≤ ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ q ∈ Finset.Icc 1 (N / d),
        ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact weighted Selberg identity for arbitrary weight functions and the unconditional non-negativity of the signed Möbius tent sum.
