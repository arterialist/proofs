# First Formalization: Exact Finite Prime-Cross Laplace Factorization and Zeta Logarithmic Derivative Convergence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean`](../../formalization/BuildingBlocks/CriticalChirpedLaplaceFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite Laplace transform factorization of the prime cross-correlation and proves convergence to the Riemann zeta logarithmic derivative in Lean 4:

1. **Exact Finite Laplace Factorization:**
   Formal proof of `actual_cross_laplace_dirichlet_finite`: The Laplace integral $\int_0^R e^{-zd} \text{actualCrossFinite}(N, C, d) dd$ factors cleanly into $(\sum_{n=2}^N \frac{\Lambda(n)}{n^{z+1/2}}) (\int_{-w}^w e^{zy} C(y) dy)$.
2. **Dirichlet Polynomial Convergence:**
   Formal proof of `prime_dirichlet_polynomial_tendsto_zeta`: On $\text{Re}(s) > 1$, $\sum_{n=2}^N \frac{\Lambda(n)}{n^s} \to -\frac{\zeta'}{\zeta}(s)$.
3. **Endpoint-Enclosed Laplace Limit:**
   Formal proof of `finite_cross_laplace_tendsto_logderiv`: The sequence of finite-cutoff Laplace integrals converges to $-\frac{\zeta'}{\zeta}(z+1/2) \int_{-w}^w e^{zy} C(y) dy$ for $\text{Re}(z) > 1/2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact finite Laplace transform factorization
theorem actual_cross_laplace_dirichlet_finite (N : ℕ) (C : ℝ → ℂ)
    (z : ℂ) (w R : ℝ) (hw : w < Real.log 2)
    (hR : ∀ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) + w ≤ R)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0) :
    (∫ d in (0 : ℝ)..R,
      Complex.exp (-z * (d : ℂ)) *
        CriticalChirpedEndpointFinite.actualCrossFinite N C d) =
      (∑ n ∈ Finset.Icc 2 N,
        ((ArithmeticFunction.vonMangoldt n : ℝ) : ℂ) /
          ((n : ℂ) ^ (z + (1 / 2 : ℂ)))) *
      (∫ y in (-w)..w, momentIntegrand C z y)

-- Convergence of prime Dirichlet polynomials to zeta logarithmic derivative
theorem prime_dirichlet_polynomial_tendsto_zeta (s : ℂ) (hs : 1 < s.re) :
    Filter.Tendsto (fun N : ℕ => primeDirichletPolynomial N s)
      Filter.atTop (nhds (-logDeriv riemannZeta s))

-- Grand convergence of finite Laplace transforms
theorem finite_cross_laplace_tendsto_logderiv (C : ℝ → ℂ)
    (z : ℂ) (w : ℝ) (hw : w < Real.log 2)
    (hC : Continuous C)
    (hleft : ∀ y, y ≤ -w → C y = 0)
    (hright : ∀ y, w ≤ y → C y = 0)
    (hz : 1 < (z + (1 / 2 : ℂ)).re) :
    Filter.Tendsto
      (fun N : ℕ => ∫ d in (0 : ℝ)..(Real.log (N : ℝ) + w),
        Complex.exp (-z * (d : ℂ)) *
          CriticalChirpedEndpointFinite.actualCrossFinite N C d)
      Filter.atTop
      (nhds ((-logDeriv riemannZeta (z + (1 / 2 : ℂ))) *
        (∫ y in (-w)..w, momentIntegrand C z y)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the exact finite-cutoff Laplace transform factorization of the prime cross-correlation and proving convergence to $-\frac{\zeta'}{\zeta}(s) \int C$ without unverified integral interchanges.
