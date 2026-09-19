# First Formalization: Exact Goldbach Cofactor Generating Series and Analytic Parity Projections

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachCofactorParitySeries.lean`](../../formalization/BuildingBlocks/GoldbachCofactorParitySeries.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact generating function factorization and parity projections of Goldbach cofactor sequences in Lean 4:

1. **Component Series Absolute Convergence:**
   Formal proof of `ratioSeries_summable`, `ratioBirthSeries_summable`, and `primeSeries_summable` inside the open disk $|z| < 1$.
2. **Infinite Abel Identity:**
   Formal proof of `ratioSeries_abel`: $(1-z)\mathcal{R}(z) = q(2)z^2 + \mathcal{B}(z)$.
3. **Discrete Convolution Antidiagonal:**
   Formal proof of `cofactor_eq_antidiagonal` and `cofactor_antidiagonal`: $Q(k+4) = \sum_{p \in \text{antidiagonal}(k)} \Lambda(p_1+2)q(p_2+2)$.
4. **Generating Series Product Factorization:**
   Formal proof of `cofactorSeries_eq_mul`: $\mathcal{Q}(z) = \mathcal{P}(z) \cdot \mathcal{R}(z)$ on $|z| < 1$.
5. **Analytic Parity Projections:**
   Formal proof of `evenCofactorSeries_projection` and `oddCofactorSeries_projection`: $2 \mathcal{Q}_{\text{even}}(z) = \mathcal{Q}(z) + \mathcal{Q}(-z)$ and $2 \mathcal{Q}_{\text{odd}}(z) = \mathcal{Q}(z) - \mathcal{Q}(-z)$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Infinite Abel identity for prime-error ratio series
theorem ratioSeries_abel {z : ℝ} (hz : |z| < 1) :
    (1 - z) * ratioSeries z = q 2 * z ^ 2 + ratioBirthSeries z

-- Discrete convolution antidiagonal representation
theorem cofactor_eq_antidiagonal (k : ℕ) :
    Q (k + 4) =
      ∑ p ∈ Finset.antidiagonal k, Λ (p.1 + 2) * q (p.2 + 2)

-- Complete generating series product factorization
theorem cofactorSeries_eq_mul {z : ℝ} (hz : |z| < 1) :
    cofactorSeries z = primeSeries z * ratioSeries z

-- Even parity projection operator
theorem evenCofactorSeries_projection {z : ℝ} (hz : |z| < 1) :
    2 * evenCofactorSeries z = cofactorSeries z + cofactorSeries (-z)

-- Odd parity projection operator
theorem oddCofactorSeries_projection {z : ℝ} (hz : |z| < 1) :
    2 * oddCofactorSeries z = cofactorSeries z - cofactorSeries (-z)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 decomposing the generating series of Goldbach cofactor convolutions into prime and error-ratio series with exact parity projection operators on the open unit disk.
