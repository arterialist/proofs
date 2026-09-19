# First Formalization: Collective All-Prime Seed Weak Derivative and Mutually Singular Radon Measures

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/PrimeSeedAllPrimeDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedAllPrimeDerivative.lean), [`formalization/BuildingBlocks/PrimeSeedFiniteDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedFiniteDerivative.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the distributional calculus of the collective prime renewal seed in Lean 4:

1. **Mutually Singular Positive Measures:**
   Formal construction of $\mu_{\mathrm{all}}^+$ and $\mu_{\mathrm{all}}^-$ as countable sums of single-prime measures and formal proof that they are mutually singular (`allPrimeDerivative_mutuallySingular`).
2. **Infinite Global Mass via Prime Harmonic Divergence:**
   Formal proof that $\mu_{\mathrm{all}}^+(\mathbb{R}) = \infty$ and $\mu_{\mathrm{all}}^-(\mathbb{R}) = \infty$ using the non-summability of prime reciprocals $\sum_p 1/p = \infty$ (`allPrimeDerivativePositive_mass`, `allPrimeDerivativeNegative_mass`).
3. **Local Finiteness on Half-Lines:**
   Formal proof that for any cutoff $A$, only primes $p \le \lfloor e^A \rfloor$ have non-zero mass in $(-\infty, A]$, yielding $\mu_{\mathrm{all}}^\pm((-\infty, A]) < \infty$ (`allPrimeDerivativePositive_Iic_finite`, `allPrimeDerivativeNegative_Iic_finite`).
4. **Weak Distributional Derivative Representation:**
   Formal proof that against any $C^1$ bounded test function with support bounded from above, the distributional derivative is represented by the difference of these Radon measures (`allPrimeSeed_weak_derivative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Mutual singularity of positive and negative derivative measures
theorem allPrimeDerivative_mutuallySingular :
    allPrimeDerivativePositive ⟂ₘ allPrimeDerivativeNegative

-- Infinite total variation
theorem allPrimeDerivativePositive_mass :
    allPrimeDerivativePositive univ = ∞

theorem allPrimeDerivativeNegative_mass :
    allPrimeDerivativeNegative univ = ∞

-- Local finiteness on left half-lines
theorem allPrimeDerivativePositive_Iic_finite (A : ℝ) :
    allPrimeDerivativePositive (Iic A) < ∞

-- Weak distributional derivative identity
theorem allPrimeSeed_weak_derivative {A : ℝ} {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M)
    (hz : ∀ v, A < v → φ v = 0) (hz' : ∀ v, A < v → φ' v = 0) :
    Integrable φ allPrimeDerivativePositive ∧ Integrable φ allPrimeDerivativeNegative ∧
      Integrable (fun v => allPrimeSeed v * φ' v) ∧
      (∫ v, allPrimeSeed v * φ' v) =
        (∫ v, φ v ∂allPrimeDerivativeNegative) - ∫ v, φ v ∂allPrimeDerivativePositive
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of a distributional derivative decomposition for an infinite superposition of prime renewal clocks into mutually singular Radon measures with infinite global mass and local finiteness in Lean 4.
