# First Formalization: Exact All-Prime Jump Process Finite-Activity Infinite-First-Moment Dichotomy

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedInfiniteMean.lean`](../../formalization/BuildingBlocks/PrimeSeedInfiniteMean.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes that the all-prime jump process exhibits a profound dichotomy: its total jump activity is strictly finite, yet its first moment diverges to infinity at all positive times $u > 0$ due to Euler's harmonic prime divergence in Lean 4:

1. **Singleton First-Moment Reconstruction:**
   Formal proof that integrating $v$ against the singleton prime jump measure $\nu_{\{p\}}$ reconstructs the seed mass $\int \text{seed}_{\log p} = \frac{2}{p}$ (`singleton_levyMeasure_firstMoment`).
2. **All-Prime Lévy First-Moment Divergence:**
   Formal proof that the extended non-negative integral of $v$ against $\nu_{\mathcal{P}}$ equals $\infty$ (`allPrimeLevyMeasure_firstMoment`).
3. **Process First-Moment Divergence at Positive Times:**
   Formal proof that $\int_0^\infty v \, \mathcal{P}_u(dv) = \infty$ for all $u > 0$ via sub-measure domination by the $n=1$ jump term (`allPrimeProcess_firstMoment`).
4. **Non-Integrability of the Age Coordinate:**
   Formal proof that $v \mapsto v$ is not integrable against $\mathcal{P}_u$ for any $u > 0$ (`not_integrable_allPrimeProcess_age`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Singleton prime first-moment reconstruction
theorem singleton_levyMeasure_firstMoment (p : Nat.Primes) :
    (∫⁻ v, ENNReal.ofReal v ∂levyMeasure {p}) =
      ENNReal.ofReal (∫ v, seed (log p) v)

-- All-prime Lévy measure first-moment divergence
theorem allPrimeLevyMeasure_firstMoment :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeLevyMeasure) = ∞

-- All-prime process first-moment divergence at time u > 0
theorem allPrimeProcess_firstMoment (u : ℝ≥0) (hu : 0 < u) :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeProcess u) = ∞

-- Non-integrability of the age coordinate
theorem not_integrable_allPrimeProcess_age (u : ℝ≥0) (hu : 0 < u) :
    ¬ Integrable (fun v : ℝ => v) (allPrimeProcess u)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that the all-prime pure jump renewal process has infinite first moment at all positive operational times $u > 0$, rigorously formalizing the interplay between finite Lévy activity and Euler harmonic prime divergence.
