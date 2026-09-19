# First Formalization: Exact Entire Riemann Xi Factorization and Analytic Vanishing Orders

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualArchimedeanFactor.lean`](../../formalization/BuildingBlocks/ActualArchimedeanFactor.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the entire Riemann $\xi$ function, its functional equation $\xi(1-s) = \xi(s)$, the exact equality of analytic vanishing orders between $\xi$ and $\zeta$, and the logarithmic derivative residue theorem in Lean 4:

1. **Entirety and Functional Equation:**
   Formal proofs of `xi_entire` (`Differentiable ℂ xi`) and `xi_functional_equation` ($\xi(1 - s) = \xi(s)$).
2. **Completed Zeta and Non-Trivial Zero Equivalence:**
   Formal proofs of `xi_completed_relation` and `xi_zero_iff_zeta`: $\xi(s) = 0 \iff \zeta(s) = 0$ for $\text{Re}(s) > 0, s \ne 1$.
3. **Exact Vanishing Order Identity:**
   Formal proofs of `xi_zeta_zero_order` and `xi_zero_order_finite`: $\text{analyticOrderAt}(\xi, s) = \text{analyticOrderAt}(\zeta, s) < \infty$.
4. **Universal Residue Theorem for Logarithmic Derivatives:**
   Formal proofs of `analytic_log_derivative_order`, `xi_log_derivative_order`, and `zeta_log_derivative_order`: $(w - s) f'(w)/f(w) \to \text{ord}_s(f)$ as $w \to s$.
5. **Prime-Power and Gamma Boundary Expansion:**
   Formal proof of `xi_prime_boundary`: Explicit expansion of $\xi'/\xi$ into rational terms, gamma digamma terms, and von Mangoldt Dirichlet series.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Entirety of the Riemann xi function
theorem xi_entire : Differentiable ℂ xi

-- Exact symmetric functional equation
theorem xi_functional_equation (s : ℂ) : xi (1 - s) = xi s

-- Exact matching of zero vanishing orders with the Riemann zeta function
theorem xi_zeta_zero_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    analyticOrderAt xi s = analyticOrderAt riemannZeta s

-- Logarithmic derivative representation on the half-plane Re(s) > 1
theorem xi_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv xi s = 1 / s + 1 / (s - 1) - (Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s

-- Universal residue limit for logarithmic derivatives
theorem analytic_log_derivative_order (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    Filter.Tendsto (fun w => (w - s) * logDeriv f w) (nhdsWithin s {s}ᶜ)
      (nhds (analyticOrderNatAt f s : ℂ))

-- Zeta logarithmic derivative order limit
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

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 connecting the entire Riemann $\xi$ function and its functional equation directly to the vanishing orders and logarithmic derivative residues of Mathlib's native `riemannZeta`.
