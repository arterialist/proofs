# First Formalization: Exact Dyadic Coarse Mellin Zeta Logarithmic Derivative Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional Lebesgue integrability of prime error Mellin kernels, the pairwise disjoint dyadic partition of $(1, \infty)$, the equivalence between dyadic series and improper integrals, and the exact logarithmic derivative identity with Mathlib's native `riemannZeta` in Lean 4:

1. **Unconditional Kernel Integrability:**
   Formal proofs of `primePsi_kernel_integrable_unconditional` and `primeErrorReal_kernel_integrable_unconditional` for all $\text{Re}(s) > 1$.
2. **Dyadic Partition and HasSum Identity:**
   Formal proofs of `coarse_dyadic_Ioc_union` ($\bigcup_k (2^k, 2^{k+1}] = (1, \infty)$) and `coarseMellinBlock_hasSum_integral` ($\sum_k \text{coarseMellinBlock}(k, s) = \int_1^\infty \Delta(x) x^{-(s+1)} dx$).
3. **Grand Logarithmic Derivative Identity:**
   Formal proof of `coarseMellinSum_eq_logDerivative`:
   \[
   s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1} \quad \text{for all } \text{Re}(s) > 1.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unconditional integrability of the Chebyshev step kernel on (1, ∞)
theorem primePsi_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (psi ⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1)

-- Unconditional integrability of the prime error kernel on (1, ∞)
theorem primeErrorReal_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1)

-- Dyadic decomposition of the ray (1, ∞)
theorem coarse_dyadic_Ioc_union :
    (⋃ k : ℕ, Ioc ((2 : ℝ)^k) ((2 : ℝ)^(k + 1))) = Ioi 1

-- HasSum representation of the dyadic Mellin series
theorem coarseMellinBlock_hasSum_integral {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun k : ℕ => coarseMellinBlock k s)
      (∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

-- Grand identity connecting the coarse Mellin sum to the zeta logarithmic derivative
theorem coarseMellinSum_eq_logDerivative {s : ℂ} (hs : 1 < s.re) :
    s * coarseMellinSum s =
      -deriv riemannZeta s / riemannZeta s - s / (s - 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 connecting dyadic block partitions of the Chebyshev prime counting error to Mathlib's native Riemann zeta function and its derivative, rigorously proving $s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}$.
