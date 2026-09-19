# First Formalization: Exact Finite-Prime Lévy Jump Measures and First-Moment Reconstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedLevy.lean`](../../formalization/BuildingBlocks/PrimeSeedLevy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the integrability of age-divided prime successor seeds, the finite measure property of finite-prime Lévy jump measures, and the exact first-moment reconstruction formula $\int v \, d\nu_S = \sum_{p \in S} 2/p$ in Lean 4:

1. **Age-Division Integrability:**
   Formal proof that $\text{seed}_L(v)/v$ is non-negative, bounded by $\text{seed}_L(v)/L$, and integrable on $\mathbb{R}$ (`seed_div_age_nonneg`, `seed_div_age_le`, `integrable_seed_div_age`).
2. **Finite-Prime Lévy Jump Measure:**
   Formal construction of $\nu_S = \text{levyMeasure}_S$ and proof of the finite measure typeclass instance `IsFiniteMeasure (levyMeasure S)`.
3. **Exact Age Inversion Identity:**
   Formal proof that $v \cdot \text{levyDensity}_S(v) = \sum_{p \in S} \text{seed}_{\log p}(v)$ everywhere (`age_mul_levyDensity`).
4. **First-Moment Reconstruction:**
   Formal proof that $\int_{\mathbb{R}} v \cdot \text{levyDensity}_S(v) \, dv = \sum_{p \in S} 2/p$ (`integral_age_mul_levyDensity`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Pointwise age bound
theorem seed_div_age_le {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v / v ≤ seed L v / L

-- Integrability of age-divided seed
theorem integrable_seed_div_age {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => seed L v / v)

-- Upper bound on total age-divided mass
theorem integral_seed_div_age_le {L : ℝ} (hL : 0 < L) :
    (∫ v, seed L v / v) ≤ 2 * exp (-L) / L

-- Finite measure instance for Lévy jump measure
instance levyMeasure_isFiniteMeasure (S : Finset Nat.Primes) :
    IsFiniteMeasure (levyMeasure S)

-- Pointwise age reconstruction
theorem age_mul_levyDensity (S : Finset Nat.Primes) (v : ℝ) :
    v * levyDensity S v = ∑ p ∈ S, seed (log p) v

-- Exact first-moment reconstruction formula
theorem integral_age_mul_levyDensity (S : Finset Nat.Primes) :
    (∫ v, v * levyDensity S v) = ∑ p ∈ S, 2 / (p : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 constructing finite-prime Lévy jump measures from continuous prime successor seeds, proving their finite activity and recovering the exact prime harmonic sum $\sum_{p \in S} 2/p$ as the first moment.
