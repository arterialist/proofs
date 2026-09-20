# Contribution 230: Exact Unconditional Cauchy-Lorentz Spectral Envelope for Arithmetic Sources

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean`](../../formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean), [`building-blocks/charge/charge-frozen-spectral-bound.md`](../../building-blocks/charge/charge-frozen-spectral-bound.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Fourier Spectral Bounds / Cauchy-Lorentz Decay / Prime Fluctuations / Chebyshev Explicit Formulas

---

## 1. Executive Summary and Mathematical Statement

In establishing quantitative decay of arithmetic Fourier transforms $\widehat{\text{causalSource}}(N, \xi)$, unconditional bounds across all frequencies $\xi \in \mathbb{R}$ are essential to prevent spectral concentration or divergence without assuming the Riemann Hypothesis.

This contribution proves:

1. **Exact Critical Pointwise Mellin Atom Modulus:**  
   For any positive base $x > 0$ and any real frequency $\xi \in \mathbb{R}$, with the critical-line Mellin weight $w(\xi) = 1/2 + i\xi$:
   $$
   \|x^{-w(\xi)}\| = \|x^{-(1/2 + i\xi)}\| = x^{-1/2}.
   $$
2. **Unconditional Chebyshev Weighted Sum Bound:**  
   For every integer $N \ge 2$ and every $\xi \in \mathbb{R}$:
   $$
   \left\| \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} \right\| \le \sum_{n=1}^N \frac{\Lambda(n)}{\sqrt{n}} \le (8 \log 2) N^{1/2}.
   $$
3. **Continuous Background Density Integral Bound:**  
   For every integer $N \ge 1$ and every $\xi \in \mathbb{R}$:
   $$
   \left\| \int_1^N x^{-w(\xi)} \, dx \right\| \le \int_1^N x^{-1/2} \, dx = 2(N^{1/2} - 1).
   $$
4. **Uniform Discrepancy Numerator Bound:**  
   The total critical Mellin numerator satisfies:
   $$
   \left\| -1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} \, dx \right\| \le (8 \log 2 + 2) N^{1/2}.
   $$
5. **Unconditional Cauchy-Lorentz Spectral Envelope:**
   For every integer $N \ge 2$ and every frequency $\xi \in \mathbb{R}$:
   $$
   \left\| \int_{-\infty}^\infty e^{-i \xi v} \text{causalSource}(N, v) \, dv \right\|^2 \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2}.
   $$
   This proves that the physical Fourier spectral density $\rho_N(\xi) = \|\widehat{\text{causalSource}}(N, \xi)\|^2$ is bounded globally and unconditionally by an explicit integrable Cauchy-Lorentz envelope decaying as $O((1 + \xi^2)^{-1})$.

---

## 2. Mathematical Proof

### 2.1. Critical Modulus
Using the complex power definition:
$$
x^{-w(\xi)} = \exp(-w(\xi) \log x) = \exp(-(1/2 + i\xi) \log x) = \exp(-\tfrac{1}{2} \log x) \cdot \exp(-i \xi \log x).
$$
Taking absolute values:
$$
\|x^{-w(\xi)}\| = \exp(-\tfrac{1}{2}\log x) = x^{-1/2}.
$$

### 2.2. Discrete and Continuous Sums
By the triangle inequality:
$$
\left\| \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} \right\| \le \sum_{n=2}^N \Lambda(n) \|n^{-w(\xi)}\| = \sum_{n=2}^N \frac{\Lambda(n)}{\sqrt{n}}.
$$
By Chebyshev's weighted prime power estimate (`weighted_vonMangoldt_le`), $\sum_{n \le N} \Lambda(n) n^{-1/2} \le (8 \log 2) \sqrt{N}$.
For the continuous term:
$$
\left\| \int_1^N x^{-w(\xi)} dx \right\| \le \int_1^N \|x^{-w(\xi)}\| dx = \int_1^N x^{-1/2} dx = \left[ 2x^{1/2} \right]_1^N = 2(\sqrt{N} - 1).
$$
Combining these with $|-1| = 1$:
$$
1 + (8 \log 2)\sqrt{N} + 2(\sqrt{N} - 1) = (8 \log 2 + 2)\sqrt{N} - 1 \le (8 \log 2 + 2)\sqrt{N}.
$$

### 2.3. Division by the Critical Weight
By the Fourier-Mellin representation (Contribution 225):
$$
\widehat{\text{causalSource}}(N, \xi) = \frac{-1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} dx}{w(\xi)}.
$$
The modulus squared of the denominator is:
$$
\|w(\xi)\|^2 = |1/2 + i\xi|^2 = 1/4 + \xi^2.
$$
Squaring the numerator bound:
$$
\left\| \text{Numerator} \right\|^2 \le (8 \log 2 + 2)^2 N.
$$
Dividing by $1/4 + \xi^2$:
$$
\frac{(8 \log 2 + 2)^2 N}{1/4 + \xi^2} = \frac{4 (8 \log 2 + 2)^2 N}{1 + 4\xi^2} \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2},
$$
since $1 + \xi^2 \le 1 + 4\xi^2$.

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

- **Prior Literature:** Anticoncentration and high-frequency bounds for Dirichlet polynomials, stationary phase estimates in prime number theory (Montgomery 1971, Soundararajan 2009, Harper 2019). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes uniform spectral decay $O(N/(1+\xi^2))$ holding across the entire continuous frequency spectrum without conditional assumptions.
- **Target Venues:** *Journal of Fourier Analysis and Applications* or *Mathematika*.
