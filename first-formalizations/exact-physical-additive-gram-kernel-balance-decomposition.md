# First Formalization: Exact Physical-Additive Gram Kernel Balance Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/AdditivePairBalance.lean`](../../formalization/BuildingBlocks/AdditivePairBalance.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic balance decomposition between the physical kernel $1/\max(x, y)$ and additive Cauchy kernel $1/(x+y)$, along with the strict indefiniteness of the balance discrepancy form in Lean 4:

1. **Kernel Balance Identity:**
   Formal proof of $K_{\text{phys}}(x, y) = 2 K_{\text{add}}(x, y) - K_{\text{bal}}(x, y)$ for $x, y > 0$ (`kernel_identity`).
2. **Pointwise Non-Negativity:**
   Formal proof that $K_{\text{bal}}(x, y) \ge 0$ (`balance_nonnegative`).
3. **Finite Gram Decomposition:**
   Formal derivation of $\mathcal{G}_s(c; K_{\text{phys}}) = 2\mathcal{G}_s(c; K_{\text{add}}) - \mathcal{G}_s(c; K_{\text{bal}})$ (`complete_finite_gram_identity`).
4. **Strict Indefiniteness:**
   Formal proofs that the balance quadratic form attains values $+1/3$ and $-1/3$, proving it is neither positive nor negative semi-definite (`positive_balance_value`, `negative_balance_value`, `balance_not_positive_quadratic`, `balance_not_negative_quadratic`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Kernel balance identity
theorem kernel_identity {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    physical x y = 2 * additive x y - balance x y

-- Finite Gram decomposition
theorem complete_finite_gram_identity {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    finiteGram s x c physical =
      2 * finiteGram s x c additive - finiteGram s x c balance

-- Strict indefiniteness
theorem balance_not_positive_quadratic :
    ¬ (∀ a b : ℝ, 0 ≤ twoPoint balance a b)

theorem balance_not_negative_quadratic :
    ¬ (∀ a b : ℝ, twoPoint balance a b ≤ 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 decomposing physical scattering Gram matrices into additive Cauchy Gram matrices and a strictly indefinite balance discrepancy form.
