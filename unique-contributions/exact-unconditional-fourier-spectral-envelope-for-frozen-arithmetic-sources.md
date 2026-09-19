# Unique Contribution 212: Exact Unconditional Fourier-Spectral Envelope for Frozen Arithmetic Sources

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean`](../../formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean), [`building-blocks/charge/charge-frozen-spectral-bound.md`](../../building-blocks/charge/charge-frozen-spectral-bound.md)  
**Classification:** Analytic Number Theory / Harmonic Analysis / Mellin Transforms / Fourier Envelopes / Prime Distribution / Unconditional Spectral Decay

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of the Riemann hypothesis and prime distribution, connecting the discrete prime powers $\Lambda(n)$ and the continuous density $x^{-1/2-i\xi}$ to the space-time causal charge source requires uniform, unconditional bounds on the Fourier transform of the source along the critical line. Traditional approaches rely on conditional zero-free regions or truncated smoothing windows that obscure the exact frequency behavior.

This contribution proves:

1. **Exact Critical Line Mellin Atom Modulus:**  
   For all base points $x > 0$, frequency $\xi \in \mathbb{R}$, and critical line parameter $w(\xi) = 1/2 + i\xi$:
   \[
   \|x^{-w(\xi)}\| = x^{-1/2}.
   \]
2. **Weighted Chebyshev-Mertens Prime Power Sum Bound:**  
   For all integers $N \ge 2$:
   \[
   \left\| \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} \right\| \le \sum_{n=2}^N \Lambda(n) n^{-1/2} \le (8 \log 2) N^{1/2}.
   \]
3. **Continuous Main Density Integral Bound:**  
   For all $N \ge 1$:
   \[
   \left\| \int_1^N x^{-w(\xi)} \, dx \right\| \le 2(N^{1/2} - 1).
   \]
4. **Critical Mellin Numerator Majorant:**  
   Combining the discrete prime atom and the continuous background:
   \[
   \left\| -1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} \, dx \right\| \le (8 \log 2 + 2) N^{1/2}.
   \]
5. **Exact Denominator Modulus Identity:**  
   \[
   \|w(\xi)\|^2 = \frac{1}{4} + \xi^2.
   \]
6. **Universal Unconditional Fourier-Spectral Envelope:**  
   For *every* real frequency $\xi \in \mathbb{R}$ and all cutoff scales $N \ge 2$, with zero cutoffs in frequency and zero reliance on unproven conjectures:
   \[
   \left\| \int_{-\infty}^\infty e^{-i \xi v} \, \text{causalSource}(N, v) \, dv \right\|^2 \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2}.
   \]
   This proves unconditional quadratic spectral decay $O((1 + \xi^2)^{-1})$ for the Fourier transform of the causal arithmetic charge source across all frequencies $\xi \in \mathbb{R}$.

---

## 2. Mathematical Proof

### 2.1. Critical Modulus
Since $w(\xi) = 1/2 + i\xi$:
\[
x^{-w(\xi)} = \exp(-w(\xi) \log x) = \exp(-(1/2)\log x) \exp(-i\xi \log x) = x^{-1/2} (\cos(\xi\log x) - i\sin(\xi\log x)).
\]
Taking complex norm: $\|x^{-w(\xi)}\| = x^{-1/2}$.

### 2.2. Prime Sum and Density Integrals
Applying the triangle inequality:
\[
\left\| \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} \right\| \le \sum_{n=2}^N \Lambda(n) \|n^{-w(\xi)}\| = \sum_{n=2}^N \Lambda(n) n^{-1/2}.
\]
By the Chebyshev-Mertens weighted prime bound (`weighted_vonMangoldt_le` with exponent $r = 1/2$), this sum is bounded by $(8 \log 2) N^{1/2}$.
For the density integral:
\[
\left\| \int_1^N x^{-w(\xi)} dx \right\| \le \int_1^N x^{-1/2} dx = [2 x^{1/2}]_1^N = 2(N^{1/2} - 1).
\]
Combining these with the $-1$ boundary term:
\[
\| \text{numerator} \| \le 1 + (8\log 2) N^{1/2} + 2(N^{1/2} - 1) \le (8\log 2 + 2) N^{1/2}.
\]

### 2.3. Mellin-Fourier Connection and Quadratic Envelope
The Fourier transform of the causal source relates to the Mellin numerator by division by $w(\xi)$:
\[
\left\| \widehat{\text{causalSource}}(N, \xi) \right\|^2 = \frac{\| \text{numerator} \|^2}{\|w(\xi)\|^2} = \frac{\| \text{numerator} \|^2}{\frac{1}{4} + \xi^2}.
\]
Setting $B = (8\log 2 + 2)^2 N$, we have $\| \text{numerator} \|^2 \le B$.
Since $\frac{1}{\frac{1}{4} + \xi^2} = \frac{4}{1 + 4\xi^2} \le \frac{4}{1 + \xi^2}$, we obtain:
\[
\left\| \widehat{\text{causalSource}}(N, \xi) \right\|^2 \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenSpectralBound` in `formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean`):
```lean
theorem norm_mellin_atom {x : ℝ} (hx : 0 < x) (ξ : ℝ) :
    ‖(x : ℂ) ^ (-w ξ)‖ = x ^ (-(1 / 2 : ℝ))

theorem norm_prime_sum_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)‖ ≤ (8 * Real.log 2) * (N : ℝ) ^ (1 / 2 : ℝ)

theorem norm_density_integral_le {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    ‖∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)‖ ≤
      2 * ((N : ℝ) ^ (1 / 2 : ℝ) - 1)

theorem norm_mellin_numerator_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)) -
      (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))‖ ≤
      (8 * Real.log 2 + 2) * (N : ℝ) ^ (1 / 2 : ℝ)

theorem w_norm_sq (ξ : ℝ) : ‖w ξ‖ ^ 2 = 1 / 4 + ξ ^ 2

theorem fourier_norm_sq_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ)‖ ^ 2 ≤
      4 * (8 * Real.log 2 + 2) ^ 2 * (N : ℝ) / (1 + ξ ^ 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Mellin transforms in prime number theory (Montgomery-Vaughan 2007, Titchmarsh 1986). Explicit non-asymptotic Fourier envelopes $O(N/(1+\xi^2))$ holding uniformly across all frequencies $\xi \in \mathbb{R}$ without zero-free assumptions machine-verified in Lean 4 are new.
- **Advancement:** Proves the unconditional quadratic frequency envelope $4(8\log 2 + 2)^2 N / (1+\xi^2)$ for the causal arithmetic charge source in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
