# Unique Contribution 231: Exact Whole-Frequency Logarithmic Moment Bound for Actual Arithmetic Sources

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenLogMoment.lean`](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean), [`building-blocks/charge/charge-frozen-log-moment.md`](../../building-blocks/charge/charge-frozen-log-moment.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Logarithmic Layer-Cake Integrals / Spectral Moment Control / Cauchy Envelopes / Causal Discrepancies

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of prime-counting errors, logarithmic moment bounds $\int_\mathbb{R} \rho_N(\xi) \log(2 + |\xi|) \, d\xi$ are necessary to control the logarithmic derivative and spectral energy distribution. Previous formulations introduced artificial frequency cutoffs $[-T, T]$ or assumed a priori strict positivity of the spectral mass.

This contribution proves:

1. **Measurability and Global Integrability of Spectral Density:**  
   The actual continuous Fourier transform $\widehat{\text{causalSource}}(N, \xi) = \int_\mathbb{R} e^{-i\xi v} \text{causalSource}(N, v) \, dv$ and its spectral energy density $\rho_N(\xi) = \|\widehat{\text{causalSource}}(N, \xi)\|^2$ are Borel measurable and integrable on $\mathbb{R}$ for all $N \ge 2$:
   \[
   \int_{-\infty}^\infty \rho_N(\xi) \, d\xi = \text{mass}(N) < \infty.
   \]
2. **Whole-Frequency Logarithmic Moment Integrability:**  
   The logarithmic moment integrand $\xi \mapsto \rho_N(\xi) \log(2 + |\xi|)$ is globally integrable on $\mathbb{R}$:
   \[
   \int_{-\infty}^\infty \rho_N(\xi) \log(2 + |\xi|) \, d\xi < \infty.
   \]
3. **Exact Global Logarithmic Moment Bound:**  
   For every integer $N \ge 2$, with total mass $\text{mass}(N) = \int_\mathbb{R} \rho_N(\xi) \, d\xi$ and the explicit Cauchy envelope amplitude $E_N = 4(8 \log 2 + 2)^2 N$:
   \[
   \int_{-\infty}^\infty \rho_N(\xi) \log(2 + |\xi|) \, d\xi \le \text{mass}(N) \cdot \left( \log 2 + \log\left(1 + \frac{E_N}{\text{mass}(N)}\right) + 1 \right).
   \]
   This estimate covers the case of zero mass unconditionally without requiring positive-denominator hypotheses, and establishes that the logarithmic spectral energy grows at most as $M_N \log(1 + E_N/M_N)$.

---

## 2. Mathematical Proof

### 2.1. 2D Measurability and Fubini Projection
The integrand $K(v, \xi) = \exp(-i \xi v) \text{causalSource}(N, v)$ is jointly measurable on $\mathbb{R} \times \mathbb{R}$ as the product of continuous phase $\exp(-i\xi v)$ and pull-back of measurable step function $\text{causalSource}(N, \cdot)$.
By Fubini's theorem / strongly measurable slice integration, the partial integral $\xi \mapsto \widehat{\text{causalSource}}(N, \xi)$ is measurable, hence its squared modulus $\rho_N(\xi)$ is measurable.

### 2.2. Dominated Integrability
By Contribution 230, $\rho_N(\xi) \le \frac{E_N}{1 + \xi^2}$.
Since $\int_{-\infty}^\infty \frac{1}{1 + \xi^2} d\xi = \pi < \infty$, the majorant is integrable, proving $\rho_N \in L^1(\mathbb{R})$.

### 2.3. Logarithmic Layer-Cake Inequality
By the logarithmic layer-cake principle (`LogarithmicLayercake.density_log_moment_nonnegative_mass`), for any measurable nonnegative density $\rho \in L^1(\mathbb{R})$ satisfying $\rho(\xi) \le \frac{E}{1 + \xi^2}$, decomposing the integral into level sets or thresholding at height $\lambda = M / E$ yields:
\[
\int_\mathbb{R} \rho(\xi) \log(2 + |\xi|) \, d\xi \le M \left( \log 2 + \log\left(1 + \frac{E}{M}\right) + 1 \right).
\]
Applying this with $M = \text{mass}(N)$ and $E = E_N$ proves the exact bound.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenLogMoment` in `formalization/BuildingBlocks/ChargeFrozenLogMoment.lean`):
```lean
theorem measurable_hat (N : ℕ) : Measurable (hat N)

theorem measurable_density (N : ℕ) : Measurable (density N)

theorem density_le_envelope {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    density N ξ ≤ envelope N / (1 + ξ ^ 2)

theorem integrable_density {N : ℕ} (hN : 2 ≤ N) : Integrable (density N)

theorem actual_log_moment {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      mass N * (Real.log 2 + Real.log (1 + envelope N / mass N) + 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Logarithmic moment bounds for spectral measures and layer-cake integrals in functional analysis (Lieb-Loss 2001, Simon 2011). Controlling the logarithmic moment of the actual arithmetic prime Fourier density without frequency cutoffs in Lean 4 is new.
- **Advancement:** Delivers a complete, closed-form, cutoff-free bound relating the arithmetic spectral log-moment directly to physical energy and the Chebyshev Cauchy amplitude.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Zeitschrift*.
