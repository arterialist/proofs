# Contribution 222: Exact Plancherel Identity for Frozen Arithmetic Sources and Terminal Error Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenPlancherel.lean`](../../formalization/BuildingBlocks/ChargeFrozenPlancherel.lean), [`building-blocks/charge/charge-frozen-plancherel.md`](../../building-blocks/charge/charge-frozen-plancherel.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Fourier Transforms / Plancherel Theorems / Autocorrelation Convolutions / Prime Error Integrals

---

## 1. Executive Summary and Mathematical Statement

In the spectral energy formulation of arithmetic sources, connecting the frequency-domain total mass:
$$
\text{mass}(N) = \int_{-\infty}^\infty \rho_N(\xi) \, d\xi = \int_{-\infty}^\infty \|\widehat{\text{causalSource}}(N, \xi)\|^2 \, d\xi
$$
to physical-space dispersion requires establishing an exact real-line Plancherel theorem for the discontinuous, exponentially damped arithmetic step function $\text{causalSource}(N, v)$. Because the source function is neither smooth nor Schwartz-class, classical Plancherel formulas cannot be applied naively; instead, the identity must be established rigorously via the autocorrelation function and Fourier inversion at the origin.

This contribution proves:

1. **Autocorrelation Convolution Identification:**  
   The complex autocorrelation $\text{complexCorrelation}(N, h) = \int_{-\infty}^\infty \text{causalSource}(N, v) \text{causalSource}(N, v+h) dv$ equals the convolution of $\text{complexSource}(N)$ with its time-reversal:
   $$
   \text{complexCorrelation}(N, h) = (\text{complexSource}(N) * \widetilde{\text{complexSource}}(N))(-h).
   $$
2. **Spectral Density Identification:**  
   The angular Fourier transform of the autocorrelation is identically equal to the arithmetic spectral density:
   $$
   \mathcal{F}_{\text{ang}}(\text{complexCorrelation}(N))(\xi) = \rho_N(\xi) = \|\widehat{\text{causalSource}}(N, \xi)\|^2.
   $$
3. **Exact Real-Line Plancherel Identity:**  
   For all $N \ge 2$, the total spectral mass equals $2\pi$ times the physical $L^2$ energy:
   $$
   \text{mass}(N) = 2\pi \int_{-\infty}^\infty (\text{causalSource}(N, v))^2 \, dv.
   $$
4. **Exact Terminal Prime Error Decomposition:**  
   The total spectral mass splits into an interior prefix integral and an explicit boundary terminal error term:
   $$
   \text{mass}(N) = 2\pi \left( \int_0^{\log N} (\text{causalSource}(N, v))^2 \, dv + \frac{(\psi(N) - N)^2}{N} \right).
   $$
5. **Physical Layer-Cake Logarithmic Moment Bound:**  
   The critical logarithmic moment $\int_\mathbb{R} \rho_N(\xi) \log(2+|\xi|) d\xi$ is non-asymptotically bounded purely in terms of the physical $L^2$ norm of the arithmetic source without any frequency cutoffs.

---

## 2. Mathematical Proof

### 2.1. Autocorrelation and Convolution
Let $f(v) = \text{causalSource}(N, v)$ and $\tilde{f}(v) = f(-v)$.
The convolution is:
$$
(f * \tilde{f})(-h) = \int_{-\infty}^\infty f(u) \tilde{f}(-h - u) \, du = \int_{-\infty}^\infty f(u) f(u + h) \, du = \text{complexCorrelation}(N, h).
$$
By the convolution theorem for $L^1$ functions (`transform_convolution`), taking the angular Fourier transform yields:
$$
\widehat{f * \tilde{f}}(\xi) = \widehat{f}(\xi) \cdot \widehat{\tilde{f}}(\xi) = \widehat{f}(\xi) \cdot \overline{\widehat{f}(\xi)} = |\widehat{f}(\xi)|^2 = \rho_N(\xi).
$$

### 2.2. Fourier Inversion at the Origin and Plancherel
The autocorrelation function is continuous at $h = 0$ (`continuousAt_autocorrelation_zero`) and both $f * \tilde{f}$ and its Fourier transform $\rho_N$ are in $L^1(\mathbb{R})$.
By the Fourier inversion theorem (`fourier_inversion`):
$$
\text{complexCorrelation}(N, 0) = \mathcal{F}^{-1}(\mathcal{F}(\text{complexCorrelation}(N)))(0) = \int_{-\infty}^\infty \mathcal{F}(\text{complexCorrelation}(N))(y) \, dy.
$$
Substituting the angular Jacobian scaling $\xi = 2\pi y$ and $\text{complexCorrelation}(N, 0) = \int_{-\infty}^\infty f(v)^2 dv$:
$$
\int_{-\infty}^\infty f(v)^2 \, dv = \frac{1}{2\pi} \int_{-\infty}^\infty \rho_N(\xi) \, d\xi = \frac{1}{2\pi} \text{mass}(N).
$$
Multiplying by $2\pi$ yields the exact Plancherel identity.

### 2.3. Terminal Error Decomposition
On the tail region $v > \log N$, the frozen arithmetic source is constant:
$$
\text{causalSource}(N, v) = (\psi(N) - N) e^{-v/2}.
$$
Integrating the squared tail on $(\log N, \infty)$:
$$
\int_{\log N}^\infty (\psi(N) - N)^2 e^{-v} \, dv = (\psi(N) - N)^2 \left[ -e^{-v} \right]_{\log N}^\infty = \frac{(\psi(N) - N)^2}{N}.
$$
Adding the prefix integral over $(0, \log N]$ gives the exact decomposition.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenPlancherel` in `formalization/BuildingBlocks/ChargeFrozenPlancherel.lean`):
```lean
theorem transform_complexCorrelation (N : ℕ) (ξ : ℝ) :
    transform (complexCorrelation N) ξ = (density N ξ : ℂ)

theorem mass_eq_physical_norm {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2

theorem mass_eq_prefix_terminal {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) *
      ((∫ v in Set.Ioc 0 (Real.log (N : ℝ)), (causalSource N v) ^ 2) +
        (CoarsePrimitive.psi N - (N : ℝ)) ^ 2 / (N : ℝ))

theorem actual_log_moment_physical {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2) *
        (Real.log 2 + Real.log (1 + envelope N /
          ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2)) + 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical Plancherel theorems, Wiener-Khinchin theorem for stationary processes, and Chebyshev error integrals (Wiener 1930, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes a completely formalized, non-asymptotic Plancherel identity and terminal boundary decomposition for arithmetic prime sources.
- **Target Venues:** *Journal of Functional Analysis* or *Journal of Mathematical Analysis and Applications*.
