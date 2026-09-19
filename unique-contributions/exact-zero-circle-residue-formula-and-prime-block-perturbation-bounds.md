# Contribution 130: Exact Zero-Circle Residue Formula and Prime-Block Perturbation Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualZeroCircleResidues.lean`](../../formalization/BuildingBlocks/ActualZeroCircleResidues.lean), [`building-blocks/complex-analysis/actual-zero-circle-residues.md`](../../building-blocks/complex-analysis/actual-zero-circle-residues.md)  
**Classification:** Complex Analysis / Riemann Xi Function / Contour Circle Integrals / Logarithmic Derivatives / Prime Scattering Perturbations

---

## 1. Executive Summary and Mathematical Statement

In the contour spectral analysis of non-trivial zeros $\rho$ of $\zeta(s)$ and $\xi(s)$, integrating an entire test weight $F(w)$ against the logarithmic derivative around a small circle $C(s, R) = \{w \in \mathbb{C} : |w - s| = R\}$ isolates the local zero multiplicity $m = \operatorname{ord}_s(f) \in \mathbb{N}$. Under prime-scattering perturbations $U_{\text{primes}} f, U_{\text{primes}} g$, the centered weight $W_{f, g}(w)$ is multiplied by the finite Euler-product factor $\prod_{p \in \text{primes}} \mathcal{P}_p(s - 1/2, M)$.

This contribution proves:

1. **Exact Circle Integral Residue Formula for Analytic Functions:**  
   If $f$ is analytic at $s$ with finite zero order $m = \operatorname{ord}_s(f) < \infty$, then for sufficiently small circle radius $R \in (0, \varepsilon)$ and any entire weight $F$:
   $$
   \oint_{C(s, R)} F(w) \frac{f'(w)}{f(w)} dw = 2\pi i \cdot m \cdot F(s).
   $$
2. **Exact Circle Integrals for $\xi$ and $\zeta$:**  
   For $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 0, s \ne 1$:
   $$
   \oint_{C(s, R)} F(w) \frac{\xi'(w)}{\xi(w)} dw = \oint_{C(s, R)} F(w) \frac{\zeta'(w)}{\zeta(w)} dw = 2\pi i \cdot \operatorname{ord}_s(\xi) \cdot F(s).
   $$
3. **Exact Physical Prime-Block Circle Residue:**  
   For test functions $f, g \in C_c(\mathbb{R})$, a finite set of primes, and scattering depth $M \ge 1$:
   $$
   \oint_{C(s, R)} W_{U_{\text{primes}} f, U_{\text{primes}} g}(w) \frac{\zeta'(w)}{\zeta(w)} dw = 2\pi i \cdot \operatorname{ord}_s(\xi) \cdot \left( \prod_{p \in \text{primes}} \mathcal{P}_p\left(s - \frac{1}{2}, M\right) \right) W_{f, g}(s).
   $$
4. **Exact Signed Prime-Block Perturbation Difference:**  
   $$
   \oint_{C(s, R)} \left( W_{U_{\text{primes}} f, U_{\text{primes}} g}(w) - W_{f, g}(w) \right) \frac{\zeta'(w)}{\zeta(w)} dw = 2\pi i \cdot \operatorname{ord}_s(\xi) \cdot \left( \prod_{p \in \text{primes}} \mathcal{P}_p\left(s - \frac{1}{2}, M\right) - 1 \right) W_{f, g}(s).
   $$
5. **Interior Strip Exponential Perturbation Bound:**  
   For zeros in the critical strip interior $|\operatorname{Re}(s - 1/2)| \le 1/2 - \delta$ with $\delta > 0$:
   $$
   \left\| \oint_{C(s, R)} (W_{\text{block}} - W) \frac{\zeta'}{\zeta} dw \right\| \le 2\pi \operatorname{ord}_s(\xi) |W_{f, g}(s)| \left( \exp\left( \sum_{p \in \text{primes}} (2 B_p + B_p^2) \right) - 1 \right),
   $$
   where $B_p = \frac{p^{-M\delta}}{1 - p^{-\delta}}$ decays exponentially with scattering depth $M$.

---

## 2. Mathematical Proof

### 2.1. Regular Part Decomposition
Since $f$ is analytic with finite order $m$ at $s$, $f(w) = (w - s)^m g(w)$ where $g(s) \ne 0$ and $g$ is analytic.
Then $\frac{f'(w)}{f(w)} = \frac{m}{w - s} + H(w)$ where $H(w) = \frac{g'(w)}{g(w)}$ is analytic in a ball $B(s, \varepsilon)$.

### 2.2. Circle Integration
For any entire function $F(w)$:
$$
\oint_{C(s, R)} F(w) \frac{f'(w)}{f(w)} dw = m \oint_{C(s, R)} \frac{F(w)}{w - s} dw + \oint_{C(s, R)} F(w) H(w) dw.
$$
By Cauchy's integral theorem, $\oint F H = 0$ since $F H$ is holomorphic inside the disk.
By Cauchy's integral formula, $\oint \frac{F(w)}{w - s} dw = 2\pi i F(s)$.
Thus the integral evaluates exactly to $2\pi i m F(s)$.

### 2.3. Prime-Block Centered Weight
Under physical prime-block action, the centered test weight is entire and satisfies:
$$
W_{U_{\text{primes}} f, U_{\text{primes}} g}(s) = \left( \prod_{p \in \text{primes}} \mathcal{P}_p(s - 1/2, M) \right) W_{f, g}(s).
$$
Evaluating the contour integral yields the exact factorization.

### 2.4. Interior Comparison Bound
Subtracting the unperturbed integral yields the factor $\left(\prod \mathcal{P}_p - 1\right)$. In the strip interior, each paired scattering factor satisfies $|\mathcal{P}_p - 1| \le 2 B_p + B_p^2$. Taking the product and bounding by the exponential of the sum yields the quantitative bound.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualZeroCircleResidues`):
```lean
theorem analytic_log_derivative_regular_part (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ H : ℂ → ℂ, AnalyticAt ℂ H s ∧
      ∀ᶠ w in nhds s, w ≠ s →
        logDeriv f w = (analyticOrderNatAt f s : ℂ) / (w - s) + H w

theorem analytic_zero_circle_coefficient (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv f w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt f s : ℂ) * F s

theorem xi_zero_circle_coefficient (s : ℂ) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv xi w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s

theorem zeta_zero_circle_coefficient (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s

theorem finite_prime_block_signed_circle_difference {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
            ((∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) - 1) *
              BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s

theorem finite_prime_block_circle_comparison {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1)
    (delta : ℝ) (hd : 0 < delta) (hz : |(s - 1 / 2).re| ≤ 1 / 2 - delta) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        ‖(∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w)‖ ≤
          ‖(2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ)‖ *
            ‖BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s‖ *
              (Real.exp (∑ p ∈ primes,
                let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
                  (1 - Real.exp (-delta * Real.log (p : ℝ)))
                2 * B + B ^ 2) - 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Residue calculus for logarithmic derivatives (Ahlfors 1979, Conway 1978). The explicit formalization of circle contour integrals for $\zeta$ and $\xi$ paired with prime-scattering test weights and exponential difference bounds in Lean 4 is novel.
- **Advancement:** Establishes machine-verified circle residue extraction of zero multiplicities and quantitative perturbation bounds for multi-prime scattering systems.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Functional Analysis*.
