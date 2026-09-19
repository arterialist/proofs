# Contribution 125: Exact Archimedean Scattering Phase and Xi-Zeta Zero-Multiplicity Equivalence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualArchimedeanFactor.lean`](../../formalization/BuildingBlocks/ActualArchimedeanFactor.lean), [`building-blocks/complex-analysis/actual-archimedean-factor.md`](../../building-blocks/complex-analysis/actual-archimedean-factor.md)  
**Classification:** Analytic Number Theory / Riemann Xi Function / Archimedean Factors / Gamma Function Log-Derivatives / Zero Multiplicities / Residue Limits

---

## 1. Executive Summary and Mathematical Statement

The Archimedean gamma factor $\Gamma_{\mathbb{R}}(s) = \pi^{-s/2} \Gamma(s/2)$ completes the Riemann zeta function into the entire function $\xi(s) = \frac{1}{2} s(s-1) \Gamma_{\mathbb{R}}(s) \zeta(s)$. On the critical line $s = 1/2 + it$, the Archimedean contribution generates the scattering phase multiplier.

This contribution proves:

1. **Exact Logarithmic Derivative of $\Gamma_{\mathbb{R}}$:**  
   For all $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 0$:
   $$
   (\log \Gamma_{\mathbb{R}})'(s) = -\frac{\log \pi}{2} + \frac{1}{2} (\log \Gamma)'(s/2).
   $$
2. **Exact Archimedean Scattering Phase Multiplier:**  
   On the critical axis $s = 1/2 + it$, the real Archimedean multiplier decomposes in terms of the digamma function $\psi = \Gamma'/\Gamma$:
   $$
   \operatorname{archMultiplier}(t) := 2 \operatorname{Re}\left( (\log \Gamma_{\mathbb{R}})'(1/2 + it) \right) = -\log \pi + \operatorname{Re}\left( \psi(1/4 + it/2) \right).
   $$
3. **Exact Boundary Log-Derivative of Completed Zeta and Xi:**  
   For $\operatorname{Re}(s) > 1$:
   $$
   \frac{\Lambda'(s)}{\Lambda(s)} = -\frac{\log \pi}{2} + \frac{1}{2} \psi(s/2) - \sum_{n=1}^\infty \frac{\Lambda(n)}{n^s},
   $$
   and:
   $$
   \frac{\xi'(s)}{\xi(s)} = \frac{1}{s} + \frac{1}{s-1} - \frac{\log \pi}{2} + \frac{1}{2} \psi(s/2) - \sum_{n=1}^\infty \frac{\Lambda(n)}{n^s}.
   $$
4. **Exact Equivalence of Analytic Zero Orders:**  
   For every point $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 0$ and $s \ne 1$, the local zero order of the entire function $\xi$ is identical to the local zero order of $\zeta$:
   $$
   \operatorname{analyticOrderAt}(\xi, s) = \operatorname{analyticOrderAt}(\zeta, s) < \infty.
   $$
   Consequently, zeros of $\xi$ and $\zeta$ in the right half-plane (including the critical strip) are isolated.
5. **Exact Residue Limit of Logarithmic Derivatives:**  
   For any zero $\rho$ of $\zeta(s)$ with $\operatorname{Re}(\rho) > 0, \rho \ne 1$, with local multiplicity $m_\rho \in \mathbb{N}$:
   $$
   \lim_{w \to \rho, w \ne \rho} (w - \rho) \frac{\zeta'(w)}{\zeta(w)} = m_\rho, \quad \lim_{w \to \rho, w \ne \rho} (w - \rho) \frac{\xi'(w)}{\xi(w)} = m_\rho.
   $$

---

## 2. Mathematical Proof

### 2.1. Gamma Factor Derivative
Using $\Gamma_{\mathbb{R}}(s) = \exp((-s/2)\log \pi) \Gamma(s/2)$, and since $\Gamma(s/2) \ne 0$ for $\operatorname{Re}(s) > 0$:
$$
\frac{\Gamma_{\mathbb{R}}'(s)}{\Gamma_{\mathbb{R}}(s)} = \frac{d}{ds} \left( -\frac{s}{2} \log \pi \right) + \frac{1}{\Gamma(s/2)} \frac{d}{ds} \Gamma(s/2) = -\frac{\log \pi}{2} + \frac{1}{2} \frac{\Gamma'(s/2)}{\Gamma(s/2)}.
$$

### 2.2. Scattering Multiplier
Evaluating at $s = 1/2 + it$:
$$
\frac{s}{2} = \frac{1}{4} + i \frac{t}{2}.
$$
Then:
$$
2 \operatorname{Re}\left( -\frac{\log \pi}{2} + \frac{1}{2} \psi(1/4 + it/2) \right) = -\log \pi + \operatorname{Re}(\psi(1/4 + it/2)).
$$

### 2.3. Zero Multiplicity Equivalence
For $\operatorname{Re}(s) > 0, s \ne 1$, $\xi(w) = u(w) \zeta(w)$ where $u(w) = \frac{1}{2} w(w-1)\Gamma_{\mathbb{R}}(w)$.
Since $w \ne 0$, $w \ne 1$, and $\Gamma_{\mathbb{R}}(w) \ne 0$ for $\operatorname{Re}(w) > 0$, $u(s)$ is analytic and non-zero: $u(s) \ne 0$.
Thus $\operatorname{order}_s(u) = 0$. By the valuation law of analytic orders:
$$
\operatorname{order}_s(\xi) = \operatorname{order}_s(u) + \operatorname{order}_s(\zeta) = 0 + \operatorname{order}_s(\zeta) = \operatorname{order}_s(\zeta).
$$
Since $\xi(0) = 1/2 \ne 0$ and $\mathbb{C}$ is preconnected, $\xi \not\equiv 0$ and $\operatorname{order}_s(\xi) < \infty$.

### 2.4. Logarithmic Derivative Residues
Factoring $f(w) = (w - \rho)^m g(w)$ with $g(\rho) \ne 0$ and $g$ analytic:
$$
(w - \rho) \frac{f'(w)}{f(w)} = m + (w - \rho) \frac{g'(w)}{g(w)}.
$$
Taking $w \to \rho$, since $g'/g$ is continuous at $\rho$, the second term tends to $0$, proving the limit is exactly $m$.

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

theorem completed_zeta_prime_boundary (s : ℂ) (hs : 1 < s.re) :
    logDeriv completedRiemannZeta s = -(Real.log Real.pi : ℂ) / 2 +
      logDeriv Complex.Gamma (s / 2) / 2 -
        ∑' n : ℕ, (ArithmeticFunction.vonMangoldt n : ℂ) / (n : ℂ) ^ s

theorem xi_entire : Differentiable ℂ xi

theorem xi_functional_equation (s : ℂ) : xi (1 - s) = xi s

theorem xi_zeta_zero_order (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    analyticOrderAt xi s = analyticOrderAt riemannZeta s

theorem xi_zeros_isolated (s : ℂ) :
    ∀ᶠ w in nhdsWithin s {s}ᶜ, xi w ≠ 0

theorem xi_log_derivative_order (s : ℂ) :
    Filter.Tendsto (fun w => (w - s) * logDeriv xi w) (nhdsWithin s {s}ᶜ)
      (nhds (analyticOrderNatAt xi s : ℂ))

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

- **Prior Literature:** Classical theory of the Riemann $\xi$ function (Riemann 1859, Edwards 1974, Titchmarsh 1986). The rigorous formalization of exact Archimedean log-derivatives, non-vanishing of $\Gamma_{\mathbb{R}}$, analytic zero-order equivalence, and logarithmic residue limits in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact Archimedean scattering representations and local zero-order preservation between $\xi$ and $\zeta$.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
