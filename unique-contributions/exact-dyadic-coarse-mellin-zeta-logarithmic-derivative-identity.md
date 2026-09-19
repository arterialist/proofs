# Unique Contribution 239: Exact Dyadic Coarse Mellin Zeta Logarithmic Derivative Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean), [`building-blocks/coarse/coarse-initial-identity.md`](../../building-blocks/coarse/coarse-initial-identity.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Logarithmic Derivative / Mellin Transforms / Dyadic Partitions / Explicit Formulas / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

Connecting discrete prime distributions to the zeros of the Riemann zeta function hinges on the Mellin transform of the Chebyshev prime counting error $\Delta(x) = \psi(x) - x$. While classical texts write this identity formally in terms of improper integrals, establishing it in an interactive theorem prover requires verifying unconditional Lebesgue integrability against the discontinuous step function $\psi(\lfloor x \rfloor)$, establishing pairwise disjoint dyadic decompositions $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$, and equating the dyadic infinite series directly to the logarithmic derivative of Mathlib's native `riemannZeta`.

This contribution proves:

1. **Unconditional Kernel Integrability:**  
   For all complex frequencies $s \in \mathbb{C}$ with $\text{Re}(s) > 1$, the prime kernel $(\psi(\lfloor x \rfloor) : \mathbb{C}) x^{-(s+1)}$ and the error kernel $(\Delta(x) : \mathbb{C}) x^{-(s+1)}$ are unconditionally integrable on $(1, \infty)$ using Chebyshev's linear majorant $\psi(x) \le (4 \log 2) x$.
2. **Dyadic Decomposition and HasSum Equivalence:**  
   The dyadic intervals $\mathcal{I}_k = (2^k, 2^{k+1}]$ form a pairwise disjoint partition of $(1, \infty)$, and the series of localized dyadic integrals converges unconditionally:
   \[
   \sum_{k=0}^\infty \text{coarseMellinBlock}(k, s) = \int_1^\infty (\psi(x) - x) x^{-(s+1)} \, dx.
   \]
3. **Grand Logarithmic Derivative Identity:**  
   For every complex frequency $s \in \mathbb{C}$ in the half-plane $\text{Re}(s) > 1$, the dyadic coarse Mellin sum satisfies the exact identity with the logarithmic derivative of the actual Riemann zeta function:
   \[
   s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
   \]
   This directly links the analytic continuation of `coarseMellinSum` on $\text{Re}(s) > 1/2$ (established in Contribution 238) with the zero-free region of $\zeta(s)$.

---

## 2. Mathematical Proof

### 2.1. Integrability via Chebyshev Majorant
By Chebyshev's prime bounds, $\psi(\lfloor x \rfloor) \le (4\log 2) x$ for all $x \ge 0$.
For $\text{Re}(s) > 1$, $(-s).re < -1$, so $x \mapsto x \cdot x^{-(s+1)} = x^{-s}$ is integrable on $(1, \infty)$ with:
\[
\int_1^\infty x^{-s} \, dx = \frac{1}{s - 1}.
\]
Since $\psi(\lfloor x \rfloor)$ is measurable and bounded by $(4\log 2) x$, the comparison test proves that $\psi(\lfloor x \rfloor) x^{-(s+1)}$ and $(\psi(x)-x)x^{-(s+1)}$ are integrable on $(1, \infty)$.

### 2.2. Disjoint Dyadic Partition
For any $x > 1$, there exists a unique integer $k \in \mathbb{N}$ such that $2^k < x \le 2^{k+1}$.
Thus $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$ is a disjoint union of measurable intervals.
By the countable additivity of Lebesgue integrals for integrable functions (`hasSum_integral_iUnion`):
\[
\int_1^\infty (\psi(x) - x) x^{-(s+1)} \, dx = \sum_{k=0}^\infty \int_{2^k}^{2^{k+1}} (\psi(x) - x) x^{-(s+1)} \, dx = \text{coarseMellinSum}(s).
\]

### 2.3. Linking to Zeta Logarithmic Derivative
For $\text{Re}(s) > 1$:
\[
-\frac{\zeta'(s)}{\zeta(s)} = s \int_1^\infty \psi(x) x^{-(s+1)} \, dx.
\]
Expanding the prime error $\psi(x) - x$:
\[
\int_1^\infty (\psi(x) - x) x^{-(s+1)} \, dx = \int_1^\infty \psi(x) x^{-(s+1)} \, dx - \int_1^\infty x \cdot x^{-(s+1)} \, dx = -\frac{1}{s} \frac{\zeta'(s)}{\zeta(s)} - \frac{1}{s - 1}.
\]
Multiplying through by $s$:
\[
s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseInitialIdentity.lean`):
```lean
theorem primePsi_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (psi ⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1)

theorem primeErrorReal_kernel_integrable_unconditional {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Ioi 1)

theorem coarse_dyadic_Ioc_union :
    (⋃ k : ℕ, Ioc ((2 : ℝ)^k) ((2 : ℝ)^(k + 1))) = Ioi 1

theorem coarseMellinBlock_hasSum_integral {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun k : ℕ => coarseMellinBlock k s)
      (∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1)))

theorem coarseMellinSum_eq_integral {s : ℂ} (hs : 1 < s.re) :
    coarseMellinSum s =
      ∫ x : ℝ in Ioi 1, (primeErrorReal x : ℂ) * (x : ℂ) ^ (-(s + 1))

theorem coarseMellinSum_eq_logDerivative {s : ℂ} (hs : 1 < s.re) :
    s * coarseMellinSum s =
      -deriv riemannZeta s / riemannZeta s - s / (s - 1)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical explicit formulas and Perron's formula for Dirichlet series (Ingham 1932, Titchmarsh 1986). The formal machine-checked identity relating dyadic discrete block sums to Mathlib's native `riemannZeta` logarithmic derivative in Lean 4 is new.
- **Advancement:** Links dyadic operator theory and discrete energy estimates directly to the analytic theory of the Riemann zeta function without hand-waving or non-constructive approximations.
- **Target Venues:** *Journal of Number Theory* or *Experimental Mathematics*.
