# Unique Contribution 214: Exact Causal Arithmetic Source Exponential Majorant and Global Fourier Integrability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenIntegrability.lean`](../../formalization/BuildingBlocks/ChargeFrozenIntegrability.lean), [`building-blocks/charge/charge-frozen-integrability.md`](../../building-blocks/charge/charge-frozen-integrability.md)  
**Classification:** Real Analysis / Measure Theory / Fourier Analysis / Causal Wave Sources / Prime Distribution / Exponentially Decaying Majorants

---

## 1. Executive Summary and Mathematical Statement

The space-time causal source $\text{causalSource}(N, v)$ models the prime counting error $\psi(\lfloor x \rfloor) - x$ accelerated by logarithmic coordinates $x = \min(e^v, N)$ and damped by the half-line factor $e^{-v/2}$. In the physical scattering formulation of the Riemann hypothesis, asserting the absolute convergence and Bochner integrability of the Fourier transform across the entire real axis requires an unconditional, non-asymptotic exponentially decaying majorant on $[0, \infty)$ and vanishing on $(-\infty, 0)$.

This contribution proves:

1. **Exact Exponential Decay Majorant:**  
   For every cutoff scale $N \in \mathbb{N}$ and coordinate $v \ge 0$:
   \[
   |\text{causalSource}(N, v)| \le (\psi(N) + N) e^{-v/2}.
   \]
2. **Global $L^1$ Bochner Membership:**  
   The causal source $\text{causalSource}(N, \cdot)$ is globally integrable on the entire real line:
   \[
   \int_{-\infty}^\infty |\text{causalSource}(N, v)| \, dv < \infty.
   \]
3. **Absolute Convergence of the Angular Fourier Integral:**  
   For every real frequency $\xi \in \mathbb{R}$:
   \[
   v \mapsto e^{-i \xi v} \text{causalSource}(N, v) \in L^1(\mathbb{R}, \mathbb{C}),
   \]
   proving the unconditional existence of the continuous Fourier transform $\widehat{\text{causalSource}}(N, \xi)$ across all frequencies without principal-value regularization.

---

## 2. Mathematical Proof

### 2.1. Coordinate Truncation and Chebyshev Bound
For $v \ge 0$, let $x = \min(e^v, N)$.
Then $0 \le x \le N$, which implies $0 \le \lfloor x \rfloor \le N$.
By monotonicity of the Chebyshev function $\psi$, $0 \le \psi(\lfloor x \rfloor) \le \psi(N)$.
Therefore:
\[
|\psi(\lfloor x \rfloor) - x| \le \max(\psi(\lfloor x \rfloor), x) \le \psi(N) + N.
\]
Since $\text{causalSource}(N, v) = e^{-v/2} (\psi(\lfloor x \rfloor) - x)$:
\[
|\text{causalSource}(N, v)| \le (\psi(N) + N) e^{-v/2}.
\]

### 2.2. Global Bochner Integrability
On $(-\infty, 0)$, $\text{causalSource}(N, v) = 0$.
On $[0, \infty)$, the majorant $(\psi(N) + N) e^{-v/2}$ has finite integral:
\[
\int_0^\infty (\psi(N) + N) e^{-v/2} \, dv = 2(\psi(N) + N) < \infty.
\]
By the Lebesgue dominated convergence/comparison theorem for Bochner integrals, $\text{causalSource}(N, \cdot) \in L^1(\mathbb{R})$.

### 2.3. Fourier Integrand Integrability
The character $v \mapsto e^{-i \xi v}$ has constant complex norm $\|e^{-i\xi v}\| = 1$.
Thus $\|e^{-i\xi v} \text{causalSource}(N, v)\| = |\text{causalSource}(N, v)|$.
Bounded multiplication preserves Bochner integrability, establishing that the Fourier integrand is in $L^1(\mathbb{R}, \mathbb{C})$ for every $\xi \in \mathbb{R}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenIntegrability` in `formalization/BuildingBlocks/ChargeFrozenIntegrability.lean`):
```lean
theorem source_abs_le {N : ℕ} (v : ℝ) (hv : 0 ≤ v) :
    |causalSource N v| ≤ (psi N + (N : ℝ)) * Real.exp (-v / 2)

theorem integrable_causalSource (N : ℕ) : Integrable (causalSource N)

theorem integrable_fourier_integrand (N : ℕ) (ξ : ℝ) :
    Integrable (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Causal filters, Laplace-Fourier transforms, and renewal sources in analytic number theory (Balazard-Saias 2000, Soundararajan 2009). Machine-checked proofs of unconditional $L^1$ integrability and exponential majorization for truncated prime causal sources in Lean 4 are new.
- **Advancement:** Establishes the exact non-asymptotic decay bound $|\text{causalSource}(N, v)| \le (\psi(N)+N)e^{-v/2}$ and verifies global Fourier Bochner integrability in Lean 4.
- **Target Venues:** *Real Analysis Exchange* or *Monatshefte für Mathematik*.
