# First Formalization: Regular Source Möbius Floor-Inverse Obstruction via Banach–Steinhaus

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/RegularSource.lean`](../../formalization/BuildingBlocks/RegularSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization provides the first machine-verified proof of the structural obstruction preventing sub-2/3 bounds for general square-root-bounded Lipschitz sources under Möbius floor inversion:

1. **Reciprocal Square Tail Bound and Squarefree Density:**
   Formal proof of $\sum_{k=2}^m 1/k^2 \le 3/4$ (`reciprocal_square_sum_Icc_bound`) and the squarefree counting lower bound on finite intervals.
2. **Floor Quotient Separation:**
   Formal proof that at scale $N = t^3$, the floor quotients $c_d = \lfloor t^3/d \rfloor$ are separated by at least $t$ for all $1 \le d < e \le t$ (`floor_diff_ge_scale`).
3. **Finite Tent Envelopes and $t^2/64$ Lower Bound:**
   Formal definition of finite maximum Lipschitz tent envelopes and formal proof that $I_{f_t}(t^3) \ge t^2/64$ (`signedMobiusInverse_smoothTestSource_lower`).
4. **Closed Banach Subspace and Operator Norm Divergence:**
   Formal construction of the complete subspace $E \subset \ell^\infty \times \ell^\infty$ of coupled square-root sequences and proof that the functional operator norms $\|L_{r, N}\|$ are unbounded for $r < 2/3$ (`regularMobiusFunctional_not_uniformly_bounded`).
5. **Fixed Counterexample via Banach–Steinhaus:**
   Formal application of Mathlib's `banach_steinhaus` theorem to deduce the existence of a single fixed sequence $f$ with $|f(q)| \le \sqrt{q}$ and $|f(q+1) - f(q)| \le 1$ whose Möbius floor inverse exceeds every eventual bound of power $N^r$ (`exists_fixed_regular_source_with_unbounded_inverse`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite lower bound on separated cubic tents
theorem signedMobiusInverse_smoothTestSource_lower {t : ℕ} (ht : 256 ≤ t) :
    (t : ℝ) ^ 2 / 64 ≤ signedMobiusInverse (smoothTestSource t) (t ^ 3)

-- Operator norm divergence for r < 2/3
theorem regularMobiusFunctional_not_uniformly_bounded {r : ℝ} (hr : r < 2 / 3) :
    ¬ ∃ C : ℝ, ∀ N : ℕ, ‖regularMobiusFunctional r N‖ ≤ C

-- Existence of fixed regular source with unbounded inverse
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

This formalization provides the first machine-verified proof that coarse square-root bounds and Lipschitz regularity are structurally insufficient to imply sub-2/3 bounds on Möbius floor inverses, formally ruling out a broad class of attempted proofs of the Riemann Hypothesis that do not exploit the arithmetic structure of divisor forcing.
