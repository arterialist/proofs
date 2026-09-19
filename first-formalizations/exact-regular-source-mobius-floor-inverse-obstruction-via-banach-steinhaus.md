# First Formalization: Exact Regular Source Möbius Floor-Inverse Obstruction via Banach-Steinhaus

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/RegularSource.lean`](../../formalization/BuildingBlocks/RegularSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the existence of a fixed square-root-bounded, 1-Lipschitz sequence whose Möbius floor inverse exceeds every eventual power bound $N^r$ for any exponent $r < 2/3$, via the Banach-Steinhaus uniform boundedness principle in Lean 4:

1. **Reciprocal Square Partial Sum Bound:**
   Formal proof of `reciprocal_square_sum_Icc_bound`: $\sum_{k=2}^m 1/k^2 \le 3/4$.
2. **Terminal Half Squarefree Density:**
   Formal proof of `squarefree_terminal_half_lower`: $\#\{d \in (N/2, N] : \mu^2(d)=1\} \ge N/16$ for $N \ge 256$.
3. **Non-Uniform Boundedness of Evaluation Functionals:**
   Formal proof of `regularMobiusFunctional_not_uniformly_bounded`: For $r < 2/3$, the evaluation functionals have unbounded operator norms.
4. **Banach-Steinhaus Counterexample Construction:**
   Formal proof of `exists_fixed_regular_source_with_unbounded_inverse`: Existence of a single universal regular sequence $f$ whose floor Möbius inverse fails to be bounded by $C N^r$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal square sum upper bound
theorem reciprocal_square_sum_Icc_bound (m : ℕ) :
    (∑ k ∈ Finset.Icc 2 m, 1 / (k : ℝ) ^ 2) ≤ 3 / 4

-- Squarefree lower density on terminal half-interval
theorem squarefree_terminal_half_lower {N : ℕ} (hN : 256 ≤ N) :
    (N : ℝ) / 16 ≤ ((squarefreeWindow (N / 2) N).card : ℝ)

-- Failure of uniform boundedness on regular source space
theorem regularMobiusFunctional_not_uniformly_bounded {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∀ N : ℕ, ‖regularMobiusFunctional r N‖ ≤ C

-- Main obstruction theorem via Banach-Steinhaus
theorem exists_fixed_regular_source_with_unbounded_inverse {r : ℝ} (hr : r < 2 / 3) :
    ∃ f : ℕ → ℝ, (∀ q : ℕ, |f q| ≤ Real.sqrt q) ∧
      (∀ q : ℕ, |f (q + 1) - f q| ≤ 1) ∧
      ¬ ∃ C : ℝ, ∃ N₀ : ℕ, ∀ N : ℕ, max 1 N₀ ≤ N →
        |signedMobiusInverse f N| ≤ C * (N : ℝ) ^ r
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 combining functional analysis (the Banach-Steinhaus uniform boundedness theorem on complete normed spaces) with analytic number theory (Möbius arithmetic functions and squarefree density) to prove the impossibility of sub-2/3 floor-sum bounds on regular sequences.
