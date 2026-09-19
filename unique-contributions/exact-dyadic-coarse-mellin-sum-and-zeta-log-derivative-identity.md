# Unique Contribution 119: Exact Dyadic Coarse-Mellin Sum and Zeta Log-Derivative Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean), [`formalization/BuildingBlocks/CoarseDyadicBase.lean`](../../formalization/BuildingBlocks/CoarseDyadicBase.lean), [`building-blocks/prime-distribution/coarse-initial-identity.md`](../../building-blocks/prime-distribution/coarse-initial-identity.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Dyadic Decompositions / Mellin Transforms / Logarithmic Derivatives

---

## 1. Executive Summary and Mathematical Statement

In the analytical study of the Chebyshev prime-power error function $E(x) = \psi(\lfloor x \rfloor) - x$, decomposing the half-line $(1, \infty)$ into dyadic intervals $I_k = (2^k, 2^{k+1}]$ gives rise to the dyadic Mellin blocks:
\[
M_k(s) = \int_{2^k}^{2^{k+1}} (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx.
\]

This contribution proves:

1. **Unconditional Integrability in the Half-Plane:**  
   For any complex $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1$, the function $(\psi(\lfloor x \rfloor) - x) x^{-(s+1)}$ is unconditionally integrable on $(1, \infty)$ under the standard Lebesgue measure without requiring any unproved bounds, relying solely on Chebyshev's elementary upper bound $\psi(x) \le (4 \log 2) x$.
2. **Exact Dyadic Partition and Summation:**  
   The half-line $(1, \infty)$ is partitioned into countably many disjoint dyadic intervals $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$, and the series of dyadic blocks converges unconditionally to the global improper Mellin integral:
   \[
   \sum_{k=0}^\infty M_k(s) = \int_1^\infty (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx.
   \]
3. **Exact Closed Zeta Logarithmic Derivative Identity:**  
   For all $\operatorname{Re}(s) > 1$, the dyadic Mellin sum $\mathcal{M}_{\text{dyad}}(s) = \sum_{k=0}^\infty M_k(s)$ satisfies the exact arithmetic identity:
   \[
   s \cdot \mathcal{M}_{\text{dyad}}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1},
   \]
   or equivalently:
   \[
   \mathcal{M}_{\text{dyad}}(s) = -\frac{\zeta'(s)}{s \zeta(s)} - \frac{1}{s - 1}.
   \]

---

## 2. Mathematical Proof

### 2.1. Integrability
For $x > 1$, $0 \le \lfloor x \rfloor \le x$. By Chebyshev's theorem, $\psi(\lfloor x \rfloor) \le (4 \log 2) \lfloor x \rfloor \le (4 \log 2) x$.
Since $s = \sigma + it$ with $\sigma > 1$:
\[
|x^{-(s+1)}| = x^{-(\sigma+1)}.
\]
Then $|(\psi(\lfloor x \rfloor) - x) x^{-(s+1)}| \le (4 \log 2 + 1) x^{-\sigma}$.
Since $\sigma > 1$, $\int_1^\infty x^{-\sigma} dx = \frac{1}{\sigma - 1} < \infty$, establishing dominated integrability.

### 2.2. Dyadic Partition Sum
The intervals $J_k = (2^k, 2^{k+1}]$ for $k \in \mathbb{N}$ are pairwise disjoint and satisfy $\bigcup_{k=0}^\infty J_k = (1, \infty)$. By the countable additivity of the Lebesgue integral for integrable functions:
\[
\int_1^\infty (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx = \sum_{k=0}^\infty \int_{2^k}^{2^{k+1}} (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx = \sum_{k=0}^\infty M_k(s).
\]

### 2.3. Zeta Logarithmic Derivative Identity
Splitting the integrand:
\[
\int_1^\infty (\psi(\lfloor x \rfloor) - x) x^{-(s+1)} dx = \int_1^\infty \psi(\lfloor x \rfloor) x^{-(s+1)} dx - \int_1^\infty x \cdot x^{-(s+1)} dx.
\]
The second integral is:
\[
\int_1^\infty x^{-s} dx = \left[ \frac{x^{-(s-1)}}{-(s-1)} \right]_1^\infty = \frac{1}{s-1}.
\]
The first integral is the classical Dirichlet series Mellin representation:
\[
s \int_1^\infty \psi(\lfloor x \rfloor) x^{-(s+1)} dx = \sum_{n=1}^\infty \Lambda(n) n^{-s} = -\frac{\zeta'(s)}{\zeta(s)}.
\]
Multiplying the whole expression by $s$:
\[
s \cdot \mathcal{M}_{\text{dyad}}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive`):
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

- **Prior Literature:** Classical Mellin inversion and prime number theorem (Ingham 1932, Titchmarsh 1986). The rigorous formal verification connecting dyadic partitions of discontinuous Chebyshev prime error integrals directly to $-\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ in Lean 4 is novel.
- **Advancement:** Establishes machine-verified dyadic decomposition of the Chebyshev prime error Mellin transform and its equivalence to the zeta logarithmic derivative.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
