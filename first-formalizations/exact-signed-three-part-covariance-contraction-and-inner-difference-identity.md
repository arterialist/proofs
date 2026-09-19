# First Formalization: Exact Signed Three-Part Covariance Contraction and Inner Difference Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CollectiveSourceRangeFinite.lean`](../../formalization/BuildingBlocks/CollectiveSourceRangeFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact three-part spectral covariance split commutation, coherent signed contraction, and inner product difference identity in Lean 4:

1. **Exact Three-Part Covariance Commutation:**
   Formal proof of `signed_three_part_contraction`: The signed difference contraction commutes additively across mass, continuous, and prime spectral components.
2. **Inner Product Difference Identity:**
   Formal proof of `inner_difference_identity`: $\|x - y\|^2 = \|x\|^2 - 2 \langle x, y \rangle + \|y\|^2$, maintaining exact signed cross-terms.
3. **Linear Preimage Conservation:**
   Formal proof of `signed_source_preimage`: Linear maps commute with coherent linear combinations $T(x_1 - s x_2) = y_1 - s y_2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Linear map preimage conservation
theorem signed_source_preimage
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (T : V →ₗ[ℝ] W) (x₁ x₂ : V) (y₁ y₂ : W) (s : ℝ)
    (h₁ : T x₁ = y₁) (h₂ : T x₂ = y₂) :
    T (x₁ - s • x₂) = y₁ - s • y₂

-- Linear projection preserves differences
theorem linear_map_preserves_difference
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (P : V →ₗ[ℝ] W) (y₁ y₂ : V) :
    P (y₁ - y₂) = P y₁ - P y₂

-- Exact three-part spectral decomposition commutation
theorem signed_three_part_contraction
    (Am Ac Ap Bm Bc Bp Cm Cc Cp : ℝ) :
    (Am + Ac + Ap) - 2 * (Bm + Bc + Bp) + (Cm + Cc + Cp) =
      (Am - 2 * Bm + Cm) +
      (Ac - 2 * Bc + Cc) +
      (Ap - 2 * Bp + Cp)

-- Exact real inner product difference identity
theorem inner_difference_identity
    {V : Type*} [SeminormedAddCommGroup V] [InnerProductSpace ℝ V]
    (x y : V) :
    ‖x - y‖ ^ 2 =
      ‖x‖ ^ 2 - 2 * inner ℝ x y + ‖y‖ ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 guaranteeing channel-by-channel cancellation across multi-part spectral splittings and exact signed inner product difference preservation.
