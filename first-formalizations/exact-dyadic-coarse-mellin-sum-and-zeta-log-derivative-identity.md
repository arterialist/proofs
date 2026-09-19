# First Formalization: Exact Dyadic Coarse-Mellin Sum and Zeta Log-Derivative Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional integrability of the Chebyshev prime-power error kernel, the countable dyadic partition of $(1, \infty)$, the convergence of the dyadic Mellin series, and the exact closed connection to the Riemann zeta logarithmic derivative in Lean 4:

1. **Unconditional Integrability:**
   Formal proof that $(\psi(\lfloor x \rfloor) - x) x^{-(s+1)}$ is integrable on $(1, \infty)$ for $\operatorname{Re}(s) > 1$ (`primeErrorReal_kernel_integrable_unconditional`).
2. **Dyadic Interval Union:**
   Formal proof of $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$ (`coarse_dyadic_Ioc_union`).
3. **Mellin Block Summation:**
   Formal proof that $\sum_{k=0}^\infty M_k(s) = \int_1^\infty (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx$ (`coarseMellinBlock_hasSum_integral`, `coarseMellinSum_eq_integral`).
4. **Zeta Log-Derivative Identity:**
   Formal derivation of $s \cdot \mathcal{M}_{\text{dyad}}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}$ (`coarseMellinSum_eq_logDerivative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unconditional integrability of the prime error kernel
theorem primeErrorReal_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1)

-- Disjoint dyadic partition of the half-line
theorem coarse_dyadic_Ioc_union :
    (⋃ k : ℕ, Ioc ((2 : ℝ)^k) ((2 : ℝ)^(k + 1))) = Ioi 1

-- HasSum convergence of dyadic blocks
theorem coarseMellinBlock_hasSum_integral {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun k : ℕ => coarseMellinBlock k s)
      (∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

-- Total sum equals improper Mellin integral
theorem coarseMellinSum_eq_integral {s : ℂ} (hs : 1 < s.re) :
    coarseMellinSum s =
      ∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))

-- Exact identity with zeta log-derivative
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

This formalization provides the first machine-verified implementation in Lean 4 proving the exact convergence of the dyadic block sum of Chebyshev error Mellin transforms to $-\frac{\zeta'(s)}{s\zeta(s)} - \frac{1}{s-1}$ on $\operatorname{Re}(s) > 1$.
