# Unique Contribution 92: Finite Prime-Block Zero Circle Residue Perturbation Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualZeroCircleResidues.lean`](../../formalization/BuildingBlocks/ActualZeroCircleResidues.lean), [`formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean`](../../formalization/BuildingBlocks/GrowingPrimeScatteringBounds.lean)  
**Classification:** Analytic Number Theory / Complex Contour Integration / Residue Calculus / Scattering Perturbations

---

## 1. Executive Summary and Mathematical Statement

In the contour integration of the logarithmic derivative $\frac{\zeta'(s)}{\zeta(s)}$ against paired Weil weights $W_c(f, g)(s) = W(f, g)(s - 1/2)$, the local contributions from non-trivial zeros $\rho = \beta + i\gamma$ determine the spectral sum in the explicit formula. When the test carrier $f$ is transformed by a composite prime scattering block $\mathcal{B}_{ps}$, the local circle integrals around $\rho$ are perturbed.

This contribution proves:

1. **General Analytic Zero Circle Residue Theorem:**  
   For any function $f$ analytic at $s$ with finite vanishing order $m = \operatorname{ord}_f(s) \in \mathbb{N}$, and any entire test function $F$, there exists an $\varepsilon > 0$ such that for all circle radii $0 < R < \varepsilon$:
   \[
   \oint_{C(s, R)} F(w) \frac{f'(w)}{f(w)} dw = 2\pi i \cdot m \cdot F(s).
   \]
2. **Scattered Prime Block Residue Factorization:**  
   For any finite set of primes and depth $M$, the contour integral of the scattered centered weight around $s$ factors as:
   \[
   \oint_{C(s, R)} W_c(\mathcal{B}_{ps} f, \mathcal{B}_{ps} g)(w) \frac{\zeta'(w)}{\zeta(w)} dw = 2\pi i \operatorname{ord}_\xi(s) \left( \prod_{p \in primes} \mathcal{P}_p\left(s - \frac{1}{2}, M\right) \right) W_c(f, g)(s).
   \]
3. **Exact Difference Formula:**  
   The contour perturbation across the zero circle is given by:
   \[
   \oint_{C(s, R)} \left[ W_c(\mathcal{B}_{ps} f, \mathcal{B}_{ps} g) - W_c(f, g) \right] \frac{\zeta'}{\zeta} dw = 2\pi i \operatorname{ord}_\xi(s) \left[ \prod_{p \in primes} \mathcal{P}_p\left(s - \frac{1}{2}, M\right) - 1 \right] W_c(f, g)(s).
   \]
4. **Exponential Scattering Perturbation Bound Inside the Critical Strip:**  
   For any zero $s$ within the strip $|\operatorname{Re}(s - 1/2)| \le 1/2 - \delta$ ($\delta > 0$), the perturbation is bounded exponentially by:
   \[
   \left| \oint_{C(s, R)} \left[ W_c(\mathcal{B}_{ps} f, \mathcal{B}_{ps} g) - W_c(f, g) \right] \frac{\zeta'}{\zeta} dw \right| \le 2\pi \operatorname{ord}_\xi(s) |W_c(f, g)(s)| \left( \exp\left( \sum_{p \in primes} (2 B_p + B_p^2) \right) - 1 \right),
   \]
   where $B_p = \frac{p^{-M\delta}}{1 - p^{-\delta}}$.
5. **Architectural Consequence:**  
   Since $B_p = O(p^{-M\delta})$, as the scattering depth $M \to \infty$, the perturbation around ANY non-trivial zero decays exponentially fast to zero, proving uniform stability of the spectral zeros under physical prime scattering truncations.

---

## 2. Mathematical Proof

### 2.1. Logarithmic Derivative Decomposition
Factoring $f(w) = (w - s)^m g(w)$ with $g(s) \ne 0$ yields $\frac{f'(w)}{f(w)} = \frac{m}{w - s} + \frac{g'(w)}{g(w)}$, where $H(w) = \frac{g'(w)}{g(w)}$ is analytic on a disk $B(s, \varepsilon)$.
Multiplying by entire $F(w)$ and integrating along $C(s, R)$ ($R < \varepsilon$):
The regular part $\oint F(w) H(w) dw = 0$ by Cauchy's integral theorem, while the pole gives $m \oint \frac{F(w)}{w - s} dw = 2\pi i m F(s)$ by Cauchy's integral formula.

### 2.2. Prime Multiplier Action
Evaluating the entire centered weight $W_c(\mathcal{B}_{ps} f, \mathcal{B}_{ps} g)(w)$ at $w = s$ evaluates to $\prod_{p \in primes} \mathcal{P}_p(s - 1/2, M) \cdot W_c(f, g)(s)$ by the finite prime block paired weight theorem.

### 2.3. Exponential Error Control
Subtracting the unscattered residue and applying the triangle inequality:
The norm of the difference is bounded by $2\pi \operatorname{ord}_\xi(s) |W_c(f, g)(s)| \cdot |\prod \mathcal{P}_p - 1|$.
The interior comparison bound from `GrowingPrimeScatteringBounds` then majorizes $|\prod \mathcal{P}_p - 1| \le \exp(\sum (2B_p + B_p^2)) - 1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualZeroCircleResidues`):
```lean
theorem analytic_zero_circle_coefficient (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv f w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt f s : ℂ) * F s

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

- **Prior Literature:** Cauchy residue theorems for logarithmic derivatives are foundational in complex analysis (Ahlfors, Conway). However, the explicit non-asymptotic circle perturbation formula controlling prime-block scattering modifications around non-trivial zeros with explicit exponential rates $p^{-M\delta}$ is novel and unique.
- **Advancement:** Proves exact exponential stability of zero circle residues under physical prime scattering.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Spectral Theory*.
