# Contribution 53: Universal Dual Autocorrelation Trace Pairing for Discrete Prime Packets

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/AutocorrelationRegularity.lean`](../../formalization/BuildingBlocks/AutocorrelationRegularity.lean), [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean)  
**Classification:** Analytic Number Theory / Trace Formulas / Harmonic Analysis / Functional Analysis

---

## 1. Executive Summary and Mathematical Statement

In classical analytic number theory, the Guinand–Weil explicit formula equates weighted prime sums $\sum_{n=1}^\infty \Lambda(n) F(\log n)$ to spectral sums over the non-trivial zeros $\sum_\rho \hat{F}(\gamma)$ plus Archimedean terms. This connection relies on global meromorphic continuation, functional equations, and contour integration in the complex plane.

This contribution establishes an exact, non-asymptotic **real-space physical duality** connecting discrete prime sums directly to the continuous $L^2$ causal prime source without passing through the complex zeros:

1. **Autocorrelation Smooth Windowing:**  
   For any smooth test bump $f \in C_c^\infty(\mathbb{R})$ with $\operatorname{supp} f \subseteq [-r, r]$, its continuous autocorrelation $A_f(x) = \int_{\mathbb{R}} f(v+x)f(v)dv$ is in $C_c^\infty(\mathbb{R})$ with $\operatorname{supp} A_f \subseteq [-2r, 2r]$. The corresponding logarithmic prime window is:
   $$
   W_{A_f}(s, x) := x^{-1/2} A_f(\log x - s).
   $$
2. **Exact Differential Kernel Identification:**  
   The derivative of the window function satisfies:
   $$
   \frac{d}{dx} W_{A_f}(s, x) = x^{-3/2} K_{A_f, A_f'}(\log x - s), \quad \text{where } K_{A_f, A_f'}(y) := A_f'(y) - \frac{1}{2} A_f(y).
   $$
3. **Physical Moment Factorization:**  
   The main term of the windowed prime sum factors into the product of two physical exponential moments of the underlying test bump:
   $$
   \int_{-\infty}^\infty e^{y/2} A_f(y) dy = \hat{f}(1/2) \hat{f}(-1/2), \quad \text{where } \hat{f}(p) := \int_{-\infty}^\infty e^{pv} f(v) dv.
   $$
4. **Exact Universal Trace Pairing Identity:**  
   For any finite family of window centers $s_i$ and coefficients $c_i$, under the support confinement $2r < d$, $d \le s_i \le \log N - d$, and $N \le C$:
   $$
   \sum_{i \in T} c_i \left( \sum_{n=2}^N \Lambda(n) W_{A_f}(s_i, n) - e^{s_i/2} \hat{f}(1/2) \hat{f}(-1/2) \right) = - \int_{\mathbb{R}} a_C(v) \sum_{i \in T} c_i K_{A_f, A_f'}(v - s_i) dv.
   $$
   Here $a_C(v)$ is the causal frozen prime source. The equality is exact, non-asymptotic, and contains no remainder terms.

---

## 2. Mathematical Proof

### 2.1. Window Differentiation
By Leibniz's rule and the chain rule:
$$
\frac{d}{dx}\left[ x^{-1/2} A_f(\log x - s) \right] = -\frac{1}{2} x^{-3/2} A_f(\log x - s) + x^{-1/2} A_f'(\log x - s) \frac{1}{x} = x^{-3/2} \left[ A_f'(\log x - s) - \frac{1}{2} A_f(\log x - s) \right].
$$
Setting $K(y) = A_f'(y) - \frac{1}{2} A_f(y)$, this identifies the differential kernel.

### 2.2. Autocorrelation Moment Factorization
Using Fubini's theorem:
$$
\int_{-\infty}^\infty e^{y/2} A_f(y) dy = \int_{-\infty}^\infty e^{y/2} \left( \int_{-\infty}^\infty f(v+y) f(v) dv \right) dy.
$$
Substituting $u = v+y$ (so $y = u - v$):
$$
\int_{-\infty}^\infty \int_{-\infty}^\infty e^{(u-v)/2} f(u) f(v) du dv = \left( \int_{-\infty}^\infty e^{u/2} f(u) du \right) \left( \int_{-\infty}^\infty e^{-v/2} f(v) dv \right) = \hat{f}(1/2) \hat{f}(-1/2).
$$

### 2.3. Summation by Parts and Source Integration
Summing by parts against the Chebyshev step function $\psi(x) = \sum_{n \le x} \Lambda(n)$ on $[1, N]$:
Since $W_{A_f}(s, 1) = 0$ (as $s \ge d > 2r$) and $W_{A_f}(s, N) = 0$ (as $\log N - s \ge d > 2r$), the boundary terms vanish:
$$
\sum_{n=2}^N \Lambda(n) W_{A_f}(s, n) = - \int_1^N \psi(x) \frac{d}{dx} W_{A_f}(s, x) dx.
$$
Splitting $\psi(x) = x + (\psi(x) - x)$:
1. The linear term yields:
   $$
   - \int_1^N x \cdot x^{-3/2} K(\log x - s) dx = - \int_1^N x^{-1/2} K(\log x - s) dx.
   $$
   Substituting $x = e^v$:
   $$
   - \int_0^{\log N} e^{-v/2} K(v - s) e^v dv = - e^{s/2} \int_{-s}^{\log N - s} e^{y/2} \left( A_f'(y) - \frac{1}{2} A_f(y) \right) dy.
   $$
   Integrating by parts: $\int e^{y/2} A_f'(y) dy = [e^{y/2} A_f(y)] - \frac{1}{2} \int e^{y/2} A_f(y) dy = - \frac{1}{2} \int e^{y/2} A_f(y) dy$.  
   Thus:
   $$
   - e^{s/2} \left( - \int_{-\infty}^\infty e^{y/2} A_f(y) dy \right) = e^{s/2} \hat{f}(1/2) \hat{f}(-1/2).
   $$
2. The error term gives precisely:
   $$
   - \int_1^N (\psi(x) - x) x^{-3/2} K(\log x - s) dx = - \int_0^{\log N} a_N(v) K(v - s) dv = - \int_{\mathbb{R}} a_C(v) K(v - s) dv,
   $$
   because $K(v - s) = 0$ outside $[s - d, s + d] \subset [0, \log N]$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.AutocorrelationRegularity`):
```lean
theorem actual_packet_signed_windows {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {f : ℝ → ℝ} {r d : ℝ} {N C : ℕ}
    (hf : ContDiff ℝ ∞ f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hrd : 2*r < d)
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      LogarithmicPrimeWindow.window (LogarithmicPrimeWindow.autocorrelation f) (s i) n) -
      Real.exp (s i / 2) *
        (LogarithmicPrimeWindow.physicalMoment f (1/2) *
         LogarithmicPrimeWindow.physicalMoment f (-(1/2))))) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * LogarithmicPrimeWindow.sourceKernel
          (LogarithmicPrimeWindow.autocorrelation f)
          (deriv (LogarithmicPrimeWindow.autocorrelation f)) (v - s i)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior literature comparison:** The Guinand–Weil explicit formula is a standard comparison point. This audit did not establish that the stated real-space pairing is absent from the literature; priority remains provisional.
- **Advancement:** Proves the exact non-asymptotic pairing identity without complex zeros or remainder terms, machine-verified in Lean 4.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Annalen*.
