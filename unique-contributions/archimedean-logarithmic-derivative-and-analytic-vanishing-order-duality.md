# Unique Contribution 61: Archimedean Logarithmic Derivative and Analytic Vanishing Order Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualArchimedeanFactor.lean`](../../formalization/BuildingBlocks/ActualArchimedeanFactor.lean)  
**Classification:** Complex Analysis / Analytic Number Theory / Entire Function Theory / Spectral Multipliers

---

## 1. Executive Summary and Mathematical Statement

Connecting continuous trace formulas to discrete zero sums requires exact representation of the logarithmic derivative of the completed Riemann zeta function $\xi(s)$ and its Archimedean gamma factor $\Gamma_{\mathbb{R}}(s) = \pi^{-s/2}\Gamma(s/2)$, as well as rigorous recovery of discrete zero multiplicities from logarithmic residues.

This contribution proves:

1. **Exact Archimedean Logarithmic Derivative and Spectral Multiplier:**  
   On the half-plane $\operatorname{Re}(s) > 0$, the logarithmic derivative of $\Gamma_{\mathbb{R}}$ satisfies:
   \[
   \frac{\Gamma_{\mathbb{R}}'(s)}{\Gamma_{\mathbb{R}}(s)} = -\frac{\log \pi}{2} + \frac{1}{2} \frac{\Gamma'(s/2)}{\Gamma(s/2)}.
   \]
   On the critical line $s = 1/2 + i t$, the real spectral multiplier evaluates to:
   \[
   \operatorname{archMultiplier}(t) = 2 \operatorname{Re}\left( \frac{\Gamma_{\mathbb{R}}'}{\Gamma_{\mathbb{R}}}\left( \frac{1}{2} + i t \right) \right) = -\log \pi + \operatorname{Re}\left( \frac{\Gamma'}{\Gamma}\left( \frac{1}{4} + \frac{i t}{2} \right) \right).
   \]
2. **Boundary Logarithmic Derivative of Completed Zeta and Xi:**  
   For $\operatorname{Re}(s) > 1$, the logarithmic derivative of $\xi(s) = \frac{1}{2} s(s-1) \Gamma_{\mathbb{R}}(s) \zeta(s)$ satisfies the exact prime-series identity:
   \[
   \frac{\xi'(s)}{\xi(s)} = \frac{1}{s} + \frac{1}{s - 1} - \frac{\log \pi}{2} + \frac{1}{2} \frac{\Gamma'(s/2)}{\Gamma(s/2)} - \sum_{n=1}^\infty \frac{\Lambda(n)}{n^s}.
   \]
3. **General Analytic Logarithmic Residue Duality:**  
   For ANY complex analytic function $f$ with finite vanishing order $m \in \mathbb{N}$ at $s \in \mathbb{C}$:
   \[
   \lim_{\substack{w \to s \\ w \ne s}} (w - s) \frac{f'(w)}{f(w)} = m.
   \]
4. **Exact Order Identification of Zeta and Xi:**  
   For every $s$ in the half-plane $\operatorname{Re}(s) > 0$ with $s \ne 1$, the vanishing order of $\xi$ equals the vanishing order of $\zeta$:
   \[
   \operatorname{ord}_s(\xi) = \operatorname{ord}_s(\zeta) < \infty,
   \]
   and consequently:
   \[
   \lim_{\substack{w \to s \\ w \ne s}} (w - s) \frac{\zeta'(w)}{\zeta(w)} = \operatorname{ord}_s(\xi) = \operatorname{ord}_s(\zeta).
   \]

---

## 2. Mathematical Proof

### 2.1. Gamma Factor Derivative
Since $\Gamma_{\mathbb{R}}(s) = \exp((-s/2)\log \pi) \Gamma(s/2)$:
Applying the product rule for logarithmic derivatives $\operatorname{logDeriv}(fg) = \operatorname{logDeriv}(f) + \operatorname{logDeriv}(g)$:
\[
\operatorname{logDeriv}(\exp((-s/2)\log \pi)) = -\frac{\log \pi}{2}, \quad \operatorname{logDeriv}(\Gamma(s/2)) = \frac{1}{2} \frac{\Gamma'(s/2)}{\Gamma(s/2)}.
\]
Taking real parts at $s = 1/2 + it$ yields the critical line multiplier.

### 2.2. Analytic Logarithmic Residue
Let $f$ be analytic at $s$ with order $m$. By Weierstrass factorization in a punctured disk:
\[
f(w) = (w - s)^m g(w), \quad \text{with } g(s) \ne 0.
\]
Then:
\[
\frac{f'(w)}{f(w)} = \frac{m}{w - s} + \frac{g'(w)}{g(w)}.
\]
Multiplying by $(w - s)$:
\[
(w - s) \frac{f'(w)}{f(w)} = m + (w - s) \frac{g'(w)}{g(w)}.
\]
Since $g$ is analytic and $g(s) \ne 0$, $g'/g$ is continuous at $s$, so $(w - s) g'(w)/g(w) \to 0$ as $w \to s$. Thus the limit is precisely $m$.

### 2.3. Zero Equivalence
Since $u(w) = \frac{1}{2} w (w-1) \Gamma_{\mathbb{R}}(w)$ is analytic and non-zero everywhere on $\{\operatorname{Re}(w) > 0, w \ne 1\}$, $\operatorname{ord}_s(u) = 0$. By multiplicativity of vanishing orders $\operatorname{ord}_s(u \zeta) = \operatorname{ord}_s(u) + \operatorname{ord}_s(\zeta) = \operatorname{ord}_s(\zeta)$, so $\operatorname{ord}_s(\xi) = \operatorname{ord}_s(\zeta)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualArchimedeanFactor`):
```lean
theorem gamma_factor_log_derivative (s : ℂ) (hs : 0 < s.re) :
    logDeriv Complex.Gammaℝ s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2

theorem actual_arch_multiplier (t : ℝ) :
    archMultiplier t = -Real.log Real.pi +
      (logDeriv Complex.Gamma ((1 / 4 : ℂ) + Complex.I * (t : ℂ) / 2)).re

theorem xi_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv xi s = 1 / s + 1 / (s - 1) - (Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s

theorem analytic_log_derivative_order (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    Filter.Tendsto (fun w => (w - s) * logDeriv f w) (nhdsWithin s {s}ᶜ)
      (nhds (analyticOrderNatAt f s : ℂ))

theorem xi_zeta_zero_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    analyticOrderAt xi s = analyticOrderAt riemannZeta s

theorem zeta_log_derivative_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    Filter.Tendsto (fun w => (w - s) * logDeriv riemannZeta w)
      (nhdsWithin s {s}ᶜ) (nhds (analyticOrderNatAt xi s : ℂ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** The logarithmic derivative formula for $\xi(s)$ is classical (Riemann 1859). The general theorem connecting filter limits of $(w-s) f'/f$ to `analyticOrderNatAt` in Mathlib and establishing exact order equality with `riemannZeta` has not previously been formalized in Lean 4.
- **Advancement:** Connects Mathlib's topological filters and analytic order definitions directly to the completed zeta function and von Mangoldt series.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Archive for Mathematical Logic / Formalized Mathematics*.
