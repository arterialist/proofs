# First Formalization: Exact Dyadic Prime Error Mellin Series and Riemann Zeta Logarithmic Derivative Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes unconditional integrability of prime and error kernels, pairwise disjoint dyadic interval decomposition, and the exact logarithmic derivative identity connecting the dyadic Mellin sum to the Riemann zeta function in Lean 4:

1. **Kernel Integrability:**
   Formal proofs that $\psi(\lfloor x \rfloor) x^{-(s+1)}$ and $(\psi(x) - x)x^{-(s+1)}$ are integrable on $(1, \infty)$ for $\text{Re}(s) > 1$ (`primePsi_kernel_integrable_unconditional`, `primeErrorReal_kernel_integrable_unconditional`).
2. **Dyadic Union Decomposition:**
   Formal proof that $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$ (`coarse_dyadic_Ioc_union`).
3. **Dyadic Mellin Summation:**
   Formal proof of `HasSum (fun k => coarseMellinBlock k s) (∫ x in Ioi 1, ...)` (`coarseMellinBlock_hasSum_integral`) and equality with `coarseMellinSum s` (`coarseMellinSum_eq_integral`).
4. **Exact Zeta Logarithmic Derivative Identity:**
   Formal proof that $s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ for $\text{Re}(s) > 1$ (`coarseMellinSum_eq_logDerivative`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unconditional dyadic Mellin series summation
theorem coarseMellinBlock_hasSum_integral {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun k : ℕ => coarseMellinBlock k s)
      (∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

-- Equality of dyadic sum to continuous Mellin integral
theorem coarseMellinSum_eq_integral {s : ℂ} (hs : 1 < s.re) :
    coarseMellinSum s =
      ∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))

-- Exact relation to Mathlib riemannZeta logarithmic derivative
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

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 connecting dyadic interval decompositions of prime error Mellin transforms directly to the derivative and logarithmic derivative of Mathlib's `riemannZeta` with explicit polar subtraction $s/(s-1)$.
