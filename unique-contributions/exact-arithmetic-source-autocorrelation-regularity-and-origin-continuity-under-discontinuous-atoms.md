# Unique Contribution 224: Exact Arithmetic Source Autocorrelation Regularity and Origin Continuity Under Discontinuous Atoms

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean`](../../formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean), [`building-blocks/charge/charge-frozen-fourier-norm.md`](../../building-blocks/charge/charge-frozen-fourier-norm.md)  
**Classification:** Harmonic Analysis / Measure Theory / Autocorrelation / Discontinuous Step Functions / Dominated Convergence / Fourier Inversion Criteria

---

## 1. Executive Summary and Mathematical Statement

In establishing Fourier inversion and Plancherel identities for arithmetic systems, the underlying signals are intrinsically discontinuous: $\text{causalSource}(N, v)$ contains step-function jumps at $v = \log n$ for all integers $2 \le n \le N$. Proving that the continuous autocorrelation function:
\[
\text{autocorrelation}(N, h) = \int_{-\infty}^\infty \text{causalSource}(N, v+h) \text{causalSource}(N, v) \, dv
\]
is continuous at the origin $h = 0$ cannot rely on uniform continuity or differentiability of the source.

This contribution proves:

1. **Almost-Everywhere Continuity of Jump-Discontinuous Prime Sources:**  
   The arithmetic causal source $\text{causalSource}(N, \cdot)$ is continuous almost everywhere with respect to the Lebesgue measure on $\mathbb{R}$:
   \[
   \forall^m v \in \mathbb{R}, \quad \text{ContinuousAt}(\text{causalSource}(N, \cdot), v).
   \]
   The exceptional discontinuity set is exactly the measure-zero set of atomic jump boundaries $\{ \log n \mid 2 \le n \le N \} \cup \{ 0, \log N \}$.
2. **Dominated Majorant for Translate Products:**  
   For all $h \in \mathbb{R}$ and all $v \in \mathbb{R}$:
   \[
   |\text{causalSource}(N, v+h) \text{causalSource}(N, v)| \le (\psi(N) + N) |\text{causalSource}(N, v)|,
   \]
   where the right-hand side is in $L^1(\mathbb{R})$.
3. **Continuity of Autocorrelation at the Inversion Origin:**  
   By the Lebesgue Dominated Convergence Theorem applied to almost-everywhere continuous functions, the autocorrelation is continuous at zero:
   \[
   \lim_{h \to 0} \text{autocorrelation}(N, h) = \text{autocorrelation}(N, 0) = \int_{-\infty}^\infty (\text{causalSource}(N, v))^2 \, dv.
   \]
4. **Global $L^1$ Convolution Regularity:**  
   The autocorrelation function is globally integrable on the real line:
   \[
   \text{autocorrelation}(N, \cdot) \in L^1(\mathbb{R}).
   \]
5. **Harmonic Angular-to-Mathlib Fourier Bridge:**  
   Exact identification between the unnormalized angular Fourier transform and Mathlib's unitary Fourier transform:
   \[
   \widehat{f}(\xi) = \mathcal{F}(f)\left(\frac{\xi}{2\pi}\right).
   \]

---

## 2. Mathematical Proof

### 2.1. Almost-Everywhere Continuity
The causal source decomposes into a finite linear combination:
\[
\text{causalSource}(N, v) = \sum_{n=2}^N \Lambda(n) \beta_n(v) - \text{centering}(N, v),
\]
where each atomic birth packet $\beta_n(v) = \mathbf{1}_{[\log n, \infty)}(v) e^{-v/2}$ and $\text{centering}(N, v) = \mathbf{1}_{[0, \infty)}(v) \min(e^v, N) e^{-v/2}$.
The indicator of a closed ray $[c, \infty)$ is continuous at every point except the boundary point $c$.
The singleton $\{c\}$ has Lebesgue measure 0.
A finite union of measure-zero sets has measure zero.
Therefore, outside this finite set of jump points, every term is continuous at $v$, so the finite sum is continuous at $v$.

### 2.2. Dominated Convergence and Continuity at Zero
For any $v \in \mathbb{R}$ and $h \in \mathbb{R}$:
\[
|\text{causalSource}(N, v+h)| \le \psi(N) + N.
\]
Hence the integrand is dominated by $(\psi(N) + N) |\text{causalSource}(N, v)|$, which is independent of $h$ and belongs to $L^1(\mathbb{R})$ since $\text{causalSource}(N, \cdot) \in L^1(\mathbb{R})$ (Contribution 214).
As $h \to 0$, for almost every $v$, $\text{causalSource}(N, v+h) \to \text{causalSource}(N, v)$ by almost-everywhere continuity.
By the Dominated Convergence Theorem:
\[
\lim_{h \to 0} \int_{-\infty}^\infty \text{causalSource}(N, v+h) \text{causalSource}(N, v) \, dv = \int_{-\infty}^\infty (\text{causalSource}(N, v))^2 \, dv.
\]

### 2.3. Global Integrability via Young's Inequality
Since $\text{causalSource}(N, \cdot) \in L^1(\mathbb{R})$ and the reflection $\tilde{f}(v) = f(-v) \in L^1(\mathbb{R})$, their convolution $f * \tilde{f} \in L^1(\mathbb{R})$ by Young's convolution inequality.
Since $\text{autocorrelation}(N, h) = (f * \tilde{f})(-h)$, it follows immediately that $\text{autocorrelation}(N, \cdot) \in L^1(\mathbb{R})$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenFourierNorm` in `formalization/BuildingBlocks/ChargeFrozenFourierNorm.lean`):
```lean
theorem memLp_complexSource {N : ℕ} (hN : 2 ≤ N) :
    MemLp (complexSource N) 2 volume

theorem hat_eq_mathlib_fourier (N : ℕ) (ξ : ℝ) :
    hat N ξ = 𝓕 (complexSource N) (ξ / (2 * Real.pi))

theorem ae_continuous_causalSource {N : ℕ} (hN : 2 ≤ N) :
    ∀ᵐ v : ℝ, ContinuousAt (causalSource N) v

theorem continuousAt_autocorrelation_zero {N : ℕ} (hN : 2 ≤ N) :
    ContinuousAt (autocorrelation N) 0

theorem integrable_autocorrelation (N : ℕ) :
    Integrable (autocorrelation N)

theorem autocorrelation_zero (N : ℕ) :
    autocorrelation N 0 = ∫ v : ℝ, (causalSource N v) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Autocorrelation functions of step processes, Wiener-Khinchin theory, and dominated convergence for translated $L^p$ functions (Hewitt-Stromberg 1965, Rudin 1987). Formal machine verification of almost-everywhere continuity, dominated translate limits, and origin continuity for prime counting step functions in Lean 4 is new.
- **Advancement:** Overcomes the jump-discontinuity obstacle in arithmetic signal processing by proving rigorous origin continuity of the prime autocorrelation function in Lean 4.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Fourier Analysis and Applications*.
