# Unique Contribution 273: Exact Logarithmic Prime Window Residual and Autocorrelation Mellin Factorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean), [`building-blocks/spectral/logarithmic-prime-window.md`](../../building-blocks/spectral/logarithmic-prime-window.md)  
**Classification:** Analytic Number Theory / Prime Distribution / Windowed Readouts / Autocorrelation / Mellin Transforms / Frozen Causal Sources / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of the Riemann Hypothesis, smooth localized window functions $W_s(x) = x^{-1/2} R(\log x - s)$ are paired against the prime counting measure $\sum \Lambda(n) \delta_n$ to isolate discrete spectral modes from the continuous background. A central obstacle in existing approaches has been the presence of unmanageable boundary terms when converting prime sums into continuous integrals of causal sources.

This contribution proves:

1. **Exact Logarithmic Prime Residual / Frozen Source Identity:**  
   Let $R \in C^1(\mathbb{R})$ be supported in $[-d, d]$ with derivative $D = R'$, and let $s \ge d$. For any cutoffs $N \ge e^{s+d}$ and $C \ge N$:
   \[
   \sum_{n=2}^N \Lambda(n) W_s(n) - e^{s/2} \int_{-\infty}^\infty e^{y/2} R(y) dy = - \int_{-\infty}^\infty S_C(v) K_{R, D}(v - s) dv,
   \]
   where $K_{R, D}(y) = D(y) - R(y)/2$, and $S_C(v)$ is the charge-frozen causal logarithmic source.
2. **Autocorrelation Density Moment Factorization:**  
   When the window envelope is an autocorrelation $R = f * \widetilde{f}$ of a compactly supported continuous test function $f$ (where $\widetilde{f}(x) = f(-x)$), the continuous density moment factorizes identically into two opposite-sign physical Mellin moments:
   \[
   \int_{-\infty}^\infty e^{y/2} (f * \widetilde{f})(y) dy = \mathcal{M}f(1/2) \cdot \mathcal{M}f(-1/2),
   \]
   where $\mathcal{M}f(a) = \int_{-\infty}^\infty f(v) e^{av} dv$.
3. **Multi-Window Signed Arithmetic Assembly:**  
   For any finite collection of window weights $\{c_i\}_{i \in T}$ and shift centers $\{s_i\}_{i \in T}$:
   \[
   \sum_{i \in T} c_i \left( \sum_{n=2}^N \Lambda(n) W_{s_i}(n) - e^{s_i/2} \int_\mathbb{R} e^{y/2} R(y) dy \right) = - \int_{-\infty}^\infty S_C(v) \left( \sum_{i \in T} c_i K_{R, D}(v - s_i) \right) dv.
   \]
   The assembly commutes exactly with the frozen causal source, retaining every window coefficient without truncation loss.
4. **Jacobian Integration Bridge:**  
   Under the change of variables $x = e^v$, the derivative of $W_s(x) = x^{-1/2} R(\log x - s)$ combines with the prime error step function via:
   \[
   \int_1^N E_\pi(x) W_s'(x) dx = \int_0^{\log N} S(v) K_{R, D}(v - s) dv.
   \]

---

## 2. Mathematical Proof

### 2.1. Window Differentiation
By the product rule on $W_s(x) = x^{-1/2} R(\log x - s)$:
\[
W_s'(x) = -\frac{1}{2} x^{-3/2} R(\log x - s) + x^{-1/2} R'(\log x - s) x^{-1} = x^{-3/2} \left( D(\log x - s) - \frac{1}{2} R(\log x - s) \right).
\]
Letting $K_{R, D}(y) = D(y) - R(y)/2$, we have $W_s'(x) = x^{-3/2} K_{R, D}(\log x - s)$.

### 2.2. Prime Error Integration by Parts
Integrating $\sum_{n \le N} \Lambda(n) W_s(n)$ against the continuous density $\int_1^N W_s(x) dx$:
\[
\sum_{n=2}^N \Lambda(n) W_s(n) - \int_1^N W_s(x) dx = - \int_1^N (\psi(x) - x) W_s'(x) dx.
\]
Because $s \ge d$ and $s + d \le \log N$, the boundary terms $W_s(1) = 0$ and $W_s(N) = 0$ vanish identically.

### 2.3. Jacobian Substitution
Setting $x = e^v$, $dx = e^v dv$:
\[
- \int_1^N (\psi(x) - x) x^{-3/2} K_{R, D}(\log x - s) dx = - \int_0^{\log N} (\psi(e^v) - e^v) e^{-v/2} K_{R, D}(v - s) dv.
\]
Recognizing $S(v) = e^{-v/2}(\psi(e^v) - e^v)$, this equals $-\int_0^{\log N} S(v) K_{R, D}(v - s) dv$.

### 2.4. Autocorrelation Mellin Factorization
Using Fubini's theorem on $(f * \widetilde{f})(y) = \int f(v+y) f(v) dv$:
\[
\int_\mathbb{R} e^{ay} \left( \int_\mathbb{R} f(v+y) f(v) dv \right) dy = \int_\mathbb{R} f(v) \left( \int_\mathbb{R} f(v+y) e^{ay} dy \right) dv.
\]
Substituting $u = v + y$, $y = u - v$:
\[
\int_\mathbb{R} f(v) e^{-av} \left( \int_\mathbb{R} f(u) e^{au} du \right) dv = \left( \int_\mathbb{R} f(u) e^{au} du \right) \left( \int_\mathbb{R} f(v) e^{-av} dv \right) = \mathcal{M}f(a) \mathcal{M}f(-a).
\]
Setting $a = 1/2$ yields the exact density moment formula.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`LogarithmicPrimeWindow` in `formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`):
```lean
theorem window_residual_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        Real.exp (s / 2) * densityMoment R =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s))

theorem densityMoment_autocorrelation {f : ℝ → ℝ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    densityMoment (autocorrelation f) =
      physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2)

theorem autocorrelation_residual_frozen_source {f D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hf : Continuous f) (hfc : HasCompactSupport f) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → autocorrelation f y = 0)
    (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt (autocorrelation f) (D y) y)
    (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window (autocorrelation f) s n) -
        Real.exp (s / 2) *
          (physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel (autocorrelation f) D (v - s))

theorem signed_windows_frozen_source {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {R D : ℝ → ℝ} {d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y)
    (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window R (s i) n) - Real.exp (s i / 2) * densityMoment R)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * sourceKernel R D (v - s i)))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Explicit formulas in prime number theory (Riemann 1859, Weil 1952, Guinand 1948). Converting smoothed prime sums into exact causal integral pairings without boundary artifacts via 1-D Jacobian transforms and formalizing the autocorrelation moment factorization in Lean 4 is new.
- **Advancement:** Connects discrete prime counting atoms directly to causal logarithmic sources and factorizes autocorrelation density moments into opposite-sign physical Mellin transforms.
- **Target Venues:** *Journal of Functional Analysis* or *Mathematische Zeitschrift*.
