# First Formalization: Exact Hermitian Optimizer-Mismatch Identity and Joint-Null Covariance Compression

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/OptimizerMismatch.lean`](../../formalization/BuildingBlocks/OptimizerMismatch.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact scalar Hermitian algebra, optimizer mismatch identities, and covariance compression bounds in Lean 4:

1. **Affine Completion of Squares:**
   Formal proof of `affine_completion_of_square`, `affine_minimum_lower_bound`, `affine_optimizer_value`, and `affine_minimum_eq_iff`.
2. **Exact Optimizer-Mismatch Identity:**
   Formal proof of `optimizer_mismatch_identity`:
   \[
   \mathcal{V}_C - \mathcal{V}_Q = \mathcal{Q}_{Q - C}(c_Q) + d_C |c_Q - c_C|^2.
   \]
3. **Signed Observed Comparison and Nonnegativity:**
   Formal proof of `observed_optimizer_mismatch_identity` and `unobserved_gain_nonnegative`: certified lower bounds under finite observation.
4. **Common Nullspace Optimization:**
   Formal proof of `affineOptimizer_eq_zero_of_joint_null`, `affineOptimizer_of_joint_null`, `joint_null_mismatch_square`, and `observed_optimizer_mismatch_joint_null`.
5. **Covariance Loss and Ritz Bounds:**
   Formal proof of `jointNull_loss_le_covariance_ratio` ($D_{ff} + \text{mixedSq}/C_{qq} \le (Q_{qq}/C_{qq}) D_{ff}$) and `inverse_ritz_lower_bound`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Completion of the Hermitian affine square
theorem affine_completion_of_square
    (z m c : ℂ) (d : ℝ) (hd : d ≠ 0) :
    affineScalarEnergy z m c d =
      d * Complex.normSq (c - affineOptimizer z m d) -
        Complex.normSq (z + m) / d

-- Exact optimizer mismatch identity
theorem optimizer_mismatch_identity
    (base qff cff dQ dC : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) :
    affineOptimizedValue base cff dC zC m -
        affineOptimizedValue base qff dQ zQ m =
      residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
          (affineOptimizer zQ m dQ) +
        dC * Complex.normSq
          (affineOptimizer zQ m dQ - affineOptimizer zC m dC)

-- Observed mismatch identity on the joint nullspace
theorem observed_optimizer_mismatch_joint_null
    (base qff cff dQ dC obs : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) (hnull : zQ + m = 0) :
    affineOptimizedValue base qff dQ zQ m + obs =
      affineOptimizedValue base cff dC zC m -
        ((qff - cff) - obs + Complex.normSq (zQ - zC) / dC)

-- Covariance compression ratio via Cauchy-Schwarz
theorem jointNull_loss_le_covariance_ratio
    {Dff Dqq Cqq Qqq mixedSq : ℝ}
    (hCqq : 0 < Cqq)
    (hQ : Qqq = Cqq + Dqq)
    (hmixed : mixedSq ≤ Dff * Dqq) :
    Dff + mixedSq / Cqq ≤ (Qqq / Cqq) * Dff
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact decomposition of variational form comparison into residual quadratic evaluations and metric optimizer-mismatch penalties, accompanied by certified joint-null covariance compression.
