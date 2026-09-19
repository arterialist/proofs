# First Formalization: Banach–Steinhaus Regular Source Möbius Floor-Inverse Obstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/RegularSource.lean`](../../formalization/BuildingBlocks/RegularSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the sharp exponent $2/3$ barrier for Möbius floor inversion of regular sequences using functional analysis:

1. **Banach Space Construction:**
   Formal construction of `regularSourceSpace` as a closed subspace of $\ell^\infty \times \ell^\infty$ (`regularSourceSpace_isClosed.completeSpace_coe`).
2. **Möbius Floor Functional:**
   Formalization of continuous linear functionals `regularMobiusFunctional r N` mapping regular sequences to $\frac{1}{N^r} \sum_{d \le N} \mu(d) f(\lfloor N/d \rfloor)$.
3. **Failure of Uniform Boundedness:**
   Formal proof that for any $r < 2/3$, the sequence of operator norms $\|\Lambda_{r, N}\|$ is not uniformly bounded (`regularMobiusFunctional_not_uniformly_bounded`).
4. **Existence of Counterexample via Banach–Steinhaus:**
   Formal application of Mathlib's `banach_steinhaus` theorem to deduce the existence of a fixed trajectory $f$ satisfying $|f(q)| \le \sqrt{q}$ and $|\Delta f(q)| \le 1$ whose Möbius floor inverse cannot be bounded by $O(N^r)$ (`exists_fixed_regular_source_with_unbounded_inverse`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unboundedness of operator norms
theorem regularMobiusFunctional_not_uniformly_bounded {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∀ N : ℕ, ‖regularMobiusFunctional r N‖ ≤ C

-- Counterexample trajectory via Banach-Steinhaus
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified application of the Banach–Steinhaus theorem to arithmetic Möbius inversion, rigorously proving that general regularity conditions cannot force sub-$2/3$ cancellation.
