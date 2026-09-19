# First Formalization: Exact All-Prime Lévy Measure Finiteness and Pure-Jump Probability Semigroup

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeLevy.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeLevy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finiteness of the aggregated all-prime Lévy jump measure without PNT, identifies its continuous density $B(v)/v$, and constructs the compound Poisson transition probability semigroup in Lean 4:

1. **Individual Prime Jump Bound and Summability:**
   Formal proof that $\int \frac{\text{seed}_{\log p}(v)}{v} \le \frac{2}{p \log p}$ (`prime_levy_mass_le`) and that the sum over all primes converges (`summable_prime_levy_masses`).
2. **All-Prime Lévy Measure and Finiteness:**
   Formal construction of `allPrimeLevyMeasure` and proof of the typeclass instance `IsFiniteMeasure` (`allPrimeLevyMeasure_isFiniteMeasure`).
3. **Finite Prime Activation and Density Identification:**
   Formal proof that at every age $v$, only finitely many primes have $\text{seed}_{\log p}(v) \ne 0$ (`seed_prime_finite_support`), and proof that $\nu_{\mathcal{P}}$ is the measure with density $B(v)/v$ (`allPrimeLevyMeasure_eq_withDensity`).
4. **Probability Semigroup and Series Expansion:**
   Formal proof that `allPrimeProcess u` is a probability measure (`allPrimeProcess_isProbability`), satisfies $\mathcal{P}_0 = \delta_0$ (`allPrimeProcess_zero`), satisfies the convolution semigroup identity $\mathcal{P}_u * \mathcal{P}_v = \mathcal{P}_{u+v}$ (`allPrimeProcess_add`), and admits the exact compound Poisson jump series expansion (`allPrimeProcess_original_series`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Individual prime Lévy mass bound
theorem prime_levy_mass_le (p : Nat.Primes) :
    (∫ v, seed (log p) v / v) ≤ 2 * (1 / ((p : ℝ) * log p))

-- Summability over all primes
theorem summable_prime_levy_masses :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v / v)

-- Finite measure instance for all-prime Lévy measure
instance allPrimeLevyMeasure_isFiniteMeasure : IsFiniteMeasure allPrimeLevyMeasure

-- Finite prime support at each age
theorem seed_prime_finite_support (v : ℝ) :
    (Function.support (fun p : Nat.Primes => seed (log p) v)).Finite

-- Identification with continuous density B(v)/v
theorem allPrimeLevyMeasure_eq_withDensity :
    allPrimeLevyMeasure = volume.withDensity
      (fun v => ENNReal.ofReal (allPrimeSeed v / v))

-- Convolution semigroup identity
theorem allPrimeProcess_add (u v : ℝ≥0) :
    allPrimeProcess u ∗ allPrimeProcess v = allPrimeProcess (u + v)

-- Compound Poisson series expansion
theorem allPrimeProcess_original_series (u : ℝ≥0) :
    allPrimeProcess u = Measure.sum (fun n : ℕ =>
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ)) *
          (u : ℝ) ^ n / n.factorial) • jumpPower PrimeSeedMass.allPrimeLevyMeasure n)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 constructing the all-prime Lévy jump measure, proving its finiteness unconditionally from elementary Chebyshev bounds, and proving the exact convolution semigroup law $\mathcal{P}_{u+v} = \mathcal{P}_u * \mathcal{P}_v$.
