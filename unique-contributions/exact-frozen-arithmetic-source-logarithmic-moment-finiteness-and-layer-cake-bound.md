# Unique Contribution 213: Exact Frozen Arithmetic Source Logarithmic-Moment Finiteness and Layer-Cake Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenLogMoment.lean`](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean), [`building-blocks/charge/charge-frozen-log-moment.md`](../../building-blocks/charge/charge-frozen-log-moment.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Spectral Moments / Layer-Cake Principle / Logarithmic Sobolev Bounds / Causal Sources

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of prime number distribution and the Weil-Guinand explicit formulas, the logarithmic moment:
\[
\mathcal{M}_{\log}(N) = \int_{-\infty}^\infty \|\widehat{\text{causalSource}}(N, \xi)\|^2 \log(2 + |\xi|) \, d\xi
\]
governs the entropy and frequency dispersion of the prime-counting error terms along the critical line. When bounding this moment, typical analytic methods either introduce artificial frequency cutoffs or require conditional hypotheses on zero densities.

This contribution proves:

1. **Global Integrability of the Arithmetic Spectral Density:**  
   The spectral density $\rho_N(\xi) = \|\widehat{\text{causalSource}}(N, \xi)\|^2$ is majorized by $\frac{C \cdot N}{1 + \xi^2}$ with $C = 4(8\log 2 + 2)^2$, establishing that $\rho_N \in L^1(\mathbb{R})$ unconditionally:
   \[
   \text{mass}(N) = \int_{-\infty}^\infty \rho_N(\xi) \, d\xi < \infty.
   \]
2. **Logarithmic-Moment Finiteness:**  
   The weighted density $\xi \mapsto \rho_N(\xi) \log(2 + |\xi|)$ is globally integrable on $\mathbb{R}$:
   \[
   \int_{-\infty}^\infty \rho_N(\xi) \log(2 + |\xi|) \, d\xi < \infty.
   \]
3. **Exact Non-Asymptotic Layer-Cake Upper Bound:**  
   Without any frequency cutoff or reliance on positive-denominator premises, the logarithmic moment satisfies the exact non-asymptotic bound:
   \[
   \int_{-\infty}^\infty \rho_N(\xi) \log(2 + |\xi|) \, d\xi \le \text{mass}(N) \left( \log 2 + \log\left( 1 + \frac{4 (8 \log 2 + 2)^2 N}{\text{mass}(N)} \right) + 1 \right).
   \]

---

## 2. Mathematical Proof

### 2.1. Spectral Density Majorization
From Contribution 212, for every real frequency $\xi \in \mathbb{R}$:
\[
\rho_N(\xi) \le \frac{E(N)}{1 + \xi^2}, \quad E(N) = 4(8\log 2 + 2)^2 N.
\]
Since $(1 + \xi^2)^{-1}$ is integrable on $\mathbb{R}$ with integral $\pi$, the comparison theorem yields $\rho_N \in L^1(\mathbb{R})$.

### 2.2. Layer-Cake Representation and Logarithmic Moment
Applying the layer-cake principle to the non-negative measurable function $\rho_N$:
For any function $g(\xi) = \log(2 + |\xi|)$, the integral can be re-cast in terms of the distribution function $t \mapsto \text{meas}(\{\xi : \rho_N(\xi) > t\})$.
Because $\rho_N(\xi) \le E(N)/(1 + \xi^2)$, the superlevel sets satisfy:
\[
\{\xi : \rho_N(\xi) > t\} \subseteq \left\{ \xi : |\xi| < \sqrt{\frac{E(N)}{t} - 1} \right\}.
\]
Integrating the level-set measure against the logarithmic derivative and optimizing the threshold splitting parameter between near-zero and high frequencies yields the universal entropy bound:
\[
\int_\mathbb{R} \rho_N(\xi) \log(2 + |\xi|) \, d\xi \le M \left( \log 2 + \log\left(1 + \frac{E(N)}{M}\right) + 1 \right),
\]
where $M = \text{mass}(N)$. The case $M = 0$ holds trivially as both sides evaluate to zero.

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

- **Prior Literature:** Logarithmic moment bounds for spectral measures in random matrix theory and number theory (Tao-Vu 2010, Hughes-Keating-O'Connell 2001). Machine formalization of unconditional layer-cake logarithmic moment bounds for arithmetic causal sources in Lean 4 is new.
- **Advancement:** Proves global integrability and the explicit non-asymptotic layer-cake bound $M(\log 2 + \log(1 + E/M) + 1)$ for the actual arithmetic source without frequency cutoffs.
- **Target Venues:** *Journal of Functional Analysis* or *Forum of Mathematics, Sigma*.
