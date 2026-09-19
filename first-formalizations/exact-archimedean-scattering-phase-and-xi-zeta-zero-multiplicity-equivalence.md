# First Formalization: Exact Archimedean Scattering Phase and Xi-Zeta Zero-Multiplicity Equivalence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualArchimedeanFactor.lean`](../../formalization/BuildingBlocks/ActualArchimedeanFactor.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact logarithmic derivative of the real gamma factor, the Archimedean scattering phase multiplier, the boundary series of completed zeta and xi, the equality of analytic zero multiplicities between $\xi$ and $\zeta$, and residue limits of logarithmic derivatives in Lean 4:

1. **Archimedean Gamma Log-Derivative:**
   Formal proof of $(\log \Gamma_{\mathbb{R}})'(s) = -\frac{\log \pi}{2} + \frac{1}{2} (\log \Gamma)'(s/2)$ (`gamma_factor_log_derivative`).
2. **Archimedean Scattering Multiplier:**
   Formal evaluation of $\operatorname{archMultiplier}(t) = -\log \pi + \operatorname{Re}(\psi(1/4 + it/2))$ (`actual_arch_multiplier`).
3. **Completed Zeta and Xi Log-Derivatives:**
   Formal derivation of Dirichlet prime series representations on $\operatorname{Re}(s) > 1$ (`completed_zeta_prime_boundary`, `xi_prime_boundary`).
4. **Analytic Zero Order Equivalence:**
   Formal proof that $\operatorname{analyticOrderAt}(\xi, s) = \operatorname{analyticOrderAt}(\zeta, s)$ for $\operatorname{Re}(s) > 0, s \ne 1$ (`xi_zeta_zero_order`).
5. **Logarithmic Derivative Residue Limits:**
   Formal proof of $\lim_{w \to \rho} (w - \rho) \frac{\zeta'(w)}{\zeta(w)} = m_\rho$ and $\lim_{w \to \rho} (w - \rho) \frac{\xi'(w)}{\xi(w)} = m_\rho$ (`zeta_log_derivative_order`, `xi_log_derivative_order`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Gamma factor logarithmic derivative
theorem gamma_factor_log_derivative (s : ℂ) (hs : 0 < s.re) :
    logDeriv Complex.Gammaℝ s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2

-- Archimedean scattering phase multiplier
theorem actual_arch_multiplier (t : ℝ) :
    archMultiplier t = -Real.log Real.pi +
      (logDeriv Complex.Gamma ((1 / 4 : ℂ) + Complex.I * (t : ℂ) / 2)).re

-- Completed zeta logarithmic derivative boundary series
theorem completed_zeta_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv completedRiemannZeta s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s

-- Entire xi function and functional equation
theorem xi_entire : Differentiable ℂ xi
theorem xi_functional_equation (s : ℂ) : xi (1 - s) = xi s

-- Equality of zero orders
theorem xi_zeta_zero_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    analyticOrderAt xi s = analyticOrderAt riemannZeta s

-- Zeros of xi are isolated
theorem xi_zeros_isolated (s : ℂ) :
    ∀ᶠ w in nhdsWithin s {s}ᶜ, xi w ≠ 0

-- Tendsto of logarithmic derivative to zero multiplicity
theorem xi_log_derivative_order (s : ℂ) :
    Filter.Tendsto (fun w => (w - s) * logDeriv xi w) (nhdsWithin s {s}ᶜ)
      (nhds (analyticOrderNatAt xi s : ℂ))

theorem zeta_log_derivative_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    Filter.Tendsto (fun w => (w - s) * logDeriv riemannZeta w)
      (nhdsWithin s {s}ᶜ) (nhds (analyticOrderNatAt xi s : ℂ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the exact Archimedean scattering phase decomposition, the zero-order isomorphism $\operatorname{order}_s(\xi) = \operatorname{order}_s(\zeta)$, and the convergence of $(s-\rho)\frac{\zeta'(s)}{\zeta(s)} \to m_\rho$ at arbitrary zeros in the critical strip.
