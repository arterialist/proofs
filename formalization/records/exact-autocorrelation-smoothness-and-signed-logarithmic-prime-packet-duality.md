# Contribution 160: Exact Autocorrelation Smoothness and Signed Logarithmic Prime Packet Duality

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/AutocorrelationRegularity.lean`](../../formalization/BuildingBlocks/AutocorrelationRegularity.lean), [`building-blocks/packets/autocorrelation-regularity.md`](../../building-blocks/packets/autocorrelation-regularity.md)  
**Classification:** Harmonic Analysis / Analytic Number Theory / Group Convolutions / Wave Packets / Prime Windows / Duality Formulas

---

## 1. Executive Summary and Mathematical Statement

In the localization of the explicit formula onto compact energy windows, wave packets formed from smooth compactly supported seeds $f \in C^\infty_c(\mathbb{R})$ generate positive-definite autocorrelations $A(f)(x) = \int_{\mathbb{R}} f(v+x) f(v) dv$.

This contribution proves:

1. **Exact Group Convolution Representation and Smoothness:**  
   The continuous autocorrelation $A(f)$ is identically equal to the group convolution of the reflected function $\check{f}(v) = f(-v)$ with $f$:
   $$
   A(f) = \check{f} * f.
   $$
   Consequently, if $f \in C^\infty_c(\mathbb{R})$ with $\text{supp}(f) \subseteq [-r, r]$, then $A(f) \in C^\infty_c(\mathbb{R})$ with $\text{tsupp}(A(f)) \subseteq [-2r, 2r]$.
2. **Exact Boundary-Clamping Regularity:**  
   For any distance parameter $d > 2r$, both the autocorrelation and its first derivative vanish identically outside the open interval $(-d, d)$:
   $$
   |y| \ge d \implies A(f)(y) = 0 \quad \text{and} \quad A(f)'(y) = 0.
   $$
3. **Exact Signed Logarithmic Prime Packet Duality:**  
   For any smooth compactly supported seed $f$, any finite packet index set $T$, shift centers $s_i \ge d$, and signed coefficients $c_i \in \mathbb{R}$, provided $s_i + d \le \log N$:
   $$
   \sum_{i \in T} c_i \left[ \sum_{n=2}^N \Lambda(n) W_{A(f), s_i}(n) - e^{s_i/2} \mathcal{M}_f(1/2) \mathcal{M}_f(-1/2) \right] = -\int_{\mathbb{R}} S_C(v) \left( \sum_{i \in T} c_i K_{A(f)}(v - s_i) \right) dv.
   $$
   This formula rigorously translates discrete signed prime packet sums into continuous functional pairings against the causal charge source $S_C(v)$.

---

## 2. Mathematical Proof

### 2.1. Group Convolution Identity and Smoothness
By definition of autocorrelation:
$$
A(f)(x) = \int_{\mathbb{R}} f(v + x) f(v) dv.
$$
Substituting $u = -v$:
$$
A(f)(x) = \int_{\mathbb{R}} f(x - u) f(-u) du = \int_{\mathbb{R}} \check{f}(u) f(x - u) du = (\check{f} * f)(x).
$$
Since $f \in C^\infty_c(\mathbb{R})$, the reflected function $\check{f} \in C^\infty_c(\mathbb{R})$ as well. By the standard convolution theorem for smooth compactly supported distributions (`HasCompactSupport.contDiff_convolution_right`), the convolution $\check{f} * f$ is infinitely differentiable on $\mathbb{R}$.

### 2.2. Compact Support and Boundary Clamping
If $f(v) = 0$ for $|v| \ge r$, the integrand $f(v+x) f(v)$ can only be non-zero when both $|v| < r$ and $|v+x| < r$.
By the triangle inequality:
$$
|x| = |(v+x) - v| \le |v+x| + |v| < r + r = 2r.
$$
Thus, if $|x| \ge 2r$, the integrand vanishes everywhere, and $A(f)(x) = 0$.
Since $A(f)$ vanishes on $(-\infty, -2r] \cup [2r, \infty)$, its derivative $A(f)'(x)$ also vanishes on $(-\infty, -2r) \cup (2r, \infty)$. Choosing $d > 2r$ ensures $A(f)(y) = 0$ and $A(f)'(y) = 0$ for all $|y| \ge d$.

### 2.3. Signed Packet Duality Formula
By linearity of finite sums, combining the individual window identities from `LogarithmicPrimeWindow.signed_windows_frozen_source` with the moment identity:
$$
\mathcal{M}_{A(f)}(1/2) = \mathcal{M}_f(1/2) \mathcal{M}_f(-1/2)
$$
evaluated in `LogarithmicPrimeWindow.densityMoment_autocorrelation`, the signed sum of discrete prime window sums minus their leading exponential drift terms equals the negative integral of the causal frozen source against the linear combination of localized kernels $K_{A(f)}(v - s_i)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.AutocorrelationRegularity` in `formalization/BuildingBlocks/AutocorrelationRegularity.lean`):
```lean
theorem autocorrelation_eq_convolution (f : ℝ → ℝ) :
    LogarithmicPrimeWindow.autocorrelation f =
      convolution (fun v => f (-v)) f (ContinuousLinearMap.mul ℝ ℝ) volume

theorem autocorrelation_contDiff {f : ℝ → ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f) :
    ContDiff ℝ ∞ (LogarithmicPrimeWindow.autocorrelation f)

theorem autocorrelation_tsupport_subset {f : ℝ → ℝ} {r : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) :
    tsupport (LogarithmicPrimeWindow.autocorrelation f) ⊆ Set.Icc (-2*r) (2*r)

theorem source_packet_regular {f : ℝ → ℝ} {r d : ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hd : 2*r < d) :
    Continuous (LogarithmicPrimeWindow.autocorrelation f) ∧
    Continuous (deriv (LogarithmicPrimeWindow.autocorrelation f)) ∧
    (∀ y, HasDerivAt (LogarithmicPrimeWindow.autocorrelation f)
      (deriv (LogarithmicPrimeWindow.autocorrelation f) y) y) ∧
    (∀ y, d ≤ |y| → LogarithmicPrimeWindow.autocorrelation f y = 0) ∧
    (∀ y, d ≤ |y| → deriv (LogarithmicPrimeWindow.autocorrelation f) y = 0)

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

- **Prior Literature:** Smooth cutoff techniques in explicit formulas (Iwaniec-Kowalski 2004, Conrey 2003). Machine formalization of exact signed logarithmic window packet duality and $C^\infty_c$ support bounds has not been previously achieved in Lean 4.
- **Advancement:** Establishes the exact identity between signed discrete prime window sums and continuous causal source integrals with machine-verified support clamping.
- **Target Venues:** *Journal of Fourier Analysis and Applications* or *Forum of Mathematics, Sigma*.
