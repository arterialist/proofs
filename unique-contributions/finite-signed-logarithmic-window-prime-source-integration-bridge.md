# Unique Contribution 70: Finite Signed Logarithmic Window Prime-Source Integration Bridge

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean)  
**Classification:** Analytic Number Theory / Trace Formulas / Causal Prime Dynamics / Non-Asymptotic Integration Bridges

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of the Riemann zeta function, Guinand–Weil explicit formulas link sums over prime powers $\sum_n \Lambda(n) h(\log n)$ to sums over non-trivial zeros $\sum_\rho \hat{h}(\rho)$. However, classical explicit formulas rely on meromorphic continuation, Cauchy residue calculus, and infinite contour integrals.

This contribution proves:

1. **Exact Differentiable Critical Logarithmic Window:**  
   For any smooth, compactly supported test function $R: \mathbb{R} \to \mathbb{R}$ with support in $[-d, d]$ and derivative $D = R'$, the critical-line window $W_s(x) = x^{-1/2} R(\log x - s)$ has exact derivative:
   \[
   W_s'(x) = x^{-3/2} \mathcal{K}_{R, D}(\log x - s), \quad \text{where } \mathcal{K}_{R, D}(y) = D(y) - \frac{1}{2} R(y).
   \]
2. **Exact Non-Asymptotic Window Residual Formula:**  
   For any truncation $N \ge e^{s+d}$ and any source cutoff $C \ge N$, the physical Chebyshev prime sum minus the continuous density moment:
   \[
   \sum_{n=2}^N \Lambda(n) n^{-1/2} R(\log n - s) - e^{s/2} \int_{-\infty}^\infty e^{y/2} R(y) \, dy
   \]
   **EQUALS EXACTLY** the continuous integral of the complete frozen causal prime source $S_C(v)$ against the shifted kernel:
   \[
   - \int_{-\infty}^\infty S_C(v) \mathcal{K}_{R, D}(v - s) \, dv.
   \]
3. **Finite Signed Window Linear Superposition Bridge:**  
   For any finite index set $T$, arbitrary shifts $s_i \ge d$, and arbitrary real coefficients $c_i \in \mathbb{R}$:
   \[
   \sum_{i \in T} c_i \left( \sum_{n=2}^N \Lambda(n) n^{-1/2} R(\log n - s_i) - e^{s_i/2} \int_{-\infty}^\infty e^{y/2} R(y) \, dy \right) = - \int_{-\infty}^\infty S_C(v) \left( \sum_{i \in T} c_i \mathcal{K}_{R, D}(v - s_i) \right) dv.
   \]
4. **Foundational Significance:**  
   Establishes an unconditional, non-asymptotic bridge directly equating linear combinations of discrete prime power evaluations to continuous projections of the causal source field $S_C$, without invoking the Riemann zeta function, complex contours, or the Riemann Hypothesis.

---

## 2. Mathematical Proof

### 2.1. Window Differentiation
Let $W_s(x) = x^{-1/2} R(\log x - s)$. Differentiating with respect to $x > 0$:
\[
W_s'(x) = -\frac{1}{2} x^{-3/2} R(\log x - s) + x^{-1/2} R'(\log x - s) \frac{1}{x} = x^{-3/2} \left( R'(\log x - s) - \frac{1}{2} R(\log x - s) \right).
\]
Setting $\mathcal{K}_{R, D}(y) = D(y) - \frac{1}{2} R(y)$ where $D = R'$, this is $x^{-3/2} \mathcal{K}_{R, D}(\log x - s)$.

### 2.2. Summation by Parts and Source Identification
The prime counting sum with critical weight is integrated by parts against the Chebyshev step function $\theta(x) = \sum_{p^k \le x} \log p$:
\[
\sum_{n=2}^N \Lambda(n) W_s(n) = - \int_1^N \theta(x) W_s'(x) \, dx,
\]
since the boundary terms vanish ($W_s(1) = 0$ because $s \ge d$, and $W_s(N) = 0$ because $\log N \ge s+d$).
Substituting $x = e^v$, $dx = e^v dv$:
\[
\int_1^N \theta(x) x^{-3/2} \mathcal{K}_{R, D}(\log x - s) \, dx = \int_0^{\log N} \theta(e^v) e^{-v/2} \mathcal{K}_{R, D}(v - s) \, dv.
\]
Subtracting the continuous density integral:
\[
e^{s/2} \int_{-\infty}^\infty e^{y/2} R(y) \, dy = \int_{-\infty}^\infty e^{v/2} \left( R'(v-s) - \frac{1}{2} R(v-s) \right) dv.
\]
Combining terms gives the exact integral against the causal source $S_C(v) = \theta(e^v) e^{-v/2} - e^{v/2}$.

### 2.3. Linearity and Superposition
Since integration against $S_C \in L^1(\mathbb{R})$ is linear and the sum over $T$ is finite, exchanging summation and integration holds unconditionally.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`LogarithmicPrimeWindow`):
```lean
theorem window_hasDerivAt {R D : ℝ → ℝ} {s x : ℝ} (hx : 0 < x)
    (hR : HasDerivAt R (D (Real.log x - s)) (Real.log x - s)) :
    HasDerivAt (window R s) (windowDerivative R D s x) x

theorem window_residual_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
      Real.exp (s / 2) * densityMoment R) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel R D (v - s))

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
Strict dependence on foundational axioms:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Guinand (1948) and Weil (1952) established explicit formulas relating prime sums and zeros via Fourier transforms. A non-asymptotic, real-coordinate integration bridge expressing finite signed prime sums as continuous causal source integrals had not been formalized in Lean 4.
- **Advancement:** Establishes the exact identity equating finite signed window sums to the causal source field without complex residues or analytic continuation.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
