# First Formalization: Exact Two-Bump Hermitian Gram Lower Bound and Strict Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean`](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact lower bound and strict positivity of the two-bump Hermitian Gram form under a spectral margin in Lean 4:

1. **Exact Hermitian Gram Lower Bound:**
   Formal proof of `signed_gram_lower`: $(d - \|p\|)(|a|^2 + |b|^2) \le d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p)$.
2. **Strict Positivity under Spectral Gap:**
   Formal proof of `signed_gram_pos`: $d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p) > 0$ whenever $\|p\| < d$ and $(a, b) \ne (0, 0)$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact lower bound for the two-bump Hermitian Gram form
theorem signed_gram_lower (d : ℝ) (p a b : ℂ) :
    (d - ‖p‖) * (Complex.normSq a + Complex.normSq b) ≤
      d * (Complex.normSq a + Complex.normSq b) -
        2 * (b * star a * p).re

-- Strict positivity under spectral margin
theorem signed_gram_pos {d : ℝ} {p a b : ℂ}
    (hmargin : ‖p‖ < d) (hnonzero : a ≠ 0 ∨ b ≠ 0) :
    0 < d * (Complex.normSq a + Complex.normSq b) -
      2 * (b * star a * p).re
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the sharp spectral contraction lower bound and strict positivity for annular Hermitian Gram matrices.
