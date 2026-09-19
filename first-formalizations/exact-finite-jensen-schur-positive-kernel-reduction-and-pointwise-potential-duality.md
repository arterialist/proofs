# First Formalization: Exact Finite Jensen-Schur Positive Kernel Reduction and Pointwise Potential Duality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PositiveKernelCauchy.lean`](../../formalization/BuildingBlocks/PositiveKernelCauchy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the row-wise real and complex Cauchy inequalities, the exact finite Jensen-Schur reduction of non-negative matrix kernels to pulled diagonal weights, and the pointwise potential certificate duality in Lean 4:

1. **Row-Wise Real & Complex Cauchy Inequalities:**
   Formal proof of $(\sum k_v x_v)^2 \le (\sum k_v)\sum k_v x_v^2$ (`kernel_row_cauchy`) and $|\sum k_v x_v|^2 \le (\sum k_v)\sum k_v |x_v|^2$ (`kernel_row_cauchy_complex`).
2. **Positive Kernel Jensen-Schur Reduction:**
   Formal proof that weighted quadratic forms of non-negative kernels are bounded by pulled diagonal weights $\sum_u \mu_u w_u (K x)_u^2 \le \sum_v W_{\text{pulled}}(v) x(v)^2$ (`positive_kernel_cauchy_reduction`).
3. **Hermitian Complex Extension:**
   Formal proof of the complex Hermitian version (`positive_kernel_cauchy_reduction_complex`).
4. **Pointwise Potential Certificate Duality:**
   Formal proof that pointwise domination $W(v)/a + \alpha \le \kappa(v)$ yields global quadratic operator bounds (`pointwise_weight_pays_port`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Real row-wise Cauchy inequality
theorem kernel_row_cauchy
    (k : V → ℝ) (x : V → ℝ) (hk : ∀ v, 0 ≤ k v) :
    (∑ v, k v * x v)^2 ≤ (∑ v, k v) * ∑ v, k v * (x v)^2

-- Complex row-wise Cauchy inequality
theorem kernel_row_cauchy_complex
    (k : V → ℝ) (x : V → ℂ) (hk : ∀ v, 0 ≤ k v) :
    Complex.normSq (∑ v, (k v : ℂ) * x v) ≤
      (∑ v, k v) * ∑ v, k v * Complex.normSq (x v)

-- Exact real Jensen-Schur reduction to pulled diagonal weights
theorem positive_kernel_cauchy_reduction
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℝ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * (kernelColumn k x u)^2) ≤
      ∑ v, pulledWeight mu w k v * (x v)^2

-- Exact complex Hermitian Jensen-Schur reduction
theorem positive_kernel_cauchy_reduction_complex
    (mu w : U → ℝ) (k : U → V → ℝ) (x : V → ℂ)
    (hmu : ∀ u, 0 ≤ mu u) (hw : ∀ u, 0 ≤ w u)
    (hk : ∀ u v, 0 ≤ k u v) :
    (∑ u, mu u * w u * Complex.normSq (kernelColumnComplex k x u)) ≤
      ∑ v, pulledWeight mu w k v * Complex.normSq (x v)

-- Pointwise potential certificate duality
theorem pointwise_weight_pays_port
    (W kappa : V → ℝ) (x : V → ℝ) (a alpha internal : ℝ)
    (ha : 0 < a) (hinternal : 0 ≤ internal)
    (hpoint : ∀ v, W v / a + alpha ≤ kappa v) :
    (∑ v, W v * (x v)^2) / a ≤
      internal + ∑ v, kappa v * (x v)^2 - alpha * ∑ v, (x v)^2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving finite positive kernel reductions to pulled diagonal weights and establishing pointwise potential certificate duality for operator positivity.
