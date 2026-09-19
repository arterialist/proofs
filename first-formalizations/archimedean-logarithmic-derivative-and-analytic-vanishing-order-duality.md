# First Formalization: Archimedean Logarithmic Derivative and Analytic Vanishing Order Duality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualArchimedeanFactor.lean`](../../formalization/BuildingBlocks/ActualArchimedeanFactor.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the connection between logarithmic derivatives, Archimedean gamma factors, and analytic zero multiplicities in Lean 4:

1. **Archimedean Gamma Logarithmic Derivative:**
   Formal proof of $\operatorname{logDeriv} \Gamma_{\mathbb{R}}(s) = -\frac{\log \pi}{2} + \frac{1}{2} \operatorname{logDeriv} \Gamma(s/2)$ (`gamma_factor_log_derivative`) and the critical-line spectral multiplier evaluation (`actual_arch_multiplier`).
2. **Completed Zeta and Xi Logarithmic Derivatives:**
   Formal boundary formula for $\operatorname{logDeriv} \xi(s)$ on $\operatorname{Re}(s) > 1$ with explicit von Mangoldt Dirichlet series (`xi_prime_boundary`).
3. **Analytic Logarithmic Residue Theorem:**
   Formal proof that for any analytic function $f$ with finite order, the punctured filter limit of $(w - s) \operatorname{logDeriv} f(w)$ evaluates to the vanishing order $\operatorname{ord}_s(f)$ (`analytic_log_derivative_order`).
4. **Order Equivalence of Zeta and Xi:**
   Formal proof that $\operatorname{ord}_s(\xi) = \operatorname{ord}_s(\zeta) < \infty$ on $\operatorname{Re}(s) > 0, s \ne 1$ (`xi_zeta_zero_order`, `zeta_zero_order_finite`), and that $\lim (w-s) \zeta'/ \zeta = \operatorname{ord}_s(\xi)$ (`zeta_log_derivative_order`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Archimedean log-derivative
theorem gamma_factor_log_derivative (s : ℂ) (hs : 0 < s.re) :
    logDeriv Complex.Gammaℝ s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2

-- Xi prime boundary series
theorem xi_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv xi s = 1 / s + 1 / (s - 1) - (Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s

-- General analytic logarithmic residue theorem
theorem analytic_log_derivative_order (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    Filter.Tendsto (fun w => (w - s) * logDeriv f w) (nhdsWithin s {s}ᶜ)
      (nhds (analyticOrderNatAt f s : ℂ))

-- Zeta order identification
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

This formalization provides the bridge in Lean 4 between topological neighborhood filters, analytic vanishing order definitions, and the classical logarithmic derivative representations of Riemann's zeta and xi functions.
