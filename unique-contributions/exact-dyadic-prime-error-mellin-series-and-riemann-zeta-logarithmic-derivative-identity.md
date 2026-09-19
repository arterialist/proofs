# Contribution 220: Exact Dyadic Prime Error Mellin Series and Riemann Zeta Logarithmic Derivative Identity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseInitialIdentity.lean`](../../formalization/BuildingBlocks/CoarseInitialIdentity.lean), [`building-blocks/coarse/coarse-initial-identity.md`](../../building-blocks/coarse/coarse-initial-identity.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Logarithmic Derivatives / Dyadic Decompositions / Mellin Transforms / Chebyshev Functions

---

## 1. Executive Summary and Mathematical Statement

The foundational link connecting discrete prime counting error distributions to complex analytic properties of the Riemann zeta function is the Mellin transform of the error term $\psi(x) - x$. While textbook treatments write this transform formally or conditionally, rigorous verification requires showing that the sum of dyadic Mellin blocks over disjoint intervals $(2^k, 2^{k+1}]$ converges unconditionally for $\text{Re}(s) > 1$ and reproduces the exact logarithmic derivative with the polar singularity $\frac{s}{s-1}$ explicitly subtracted.

This contribution proves:

1. **Unconditional Integrability of Prime and Error Kernels:**  
   For all $s \in \mathbb{C}$ with $\text{Re}(s) > 1$:
   $$
   \int_1^\infty |\psi(\lfloor x \rfloor) x^{-(s+1)}| \, dx < \infty \quad \text{and} \quad \int_1^\infty |(\psi(x) - x) x^{-(s+1)}| \, dx < \infty,
   $$
   derived unconditionally via Chebyshev's bound $\psi(x) \le (4\log 2) x$.
2. **Exact Dyadic Partition and Summation:**  
   The dyadic partition $\bigcup_{k=0}^\infty (2^k, 2^{k+1}] = (1, \infty)$ is pairwise disjoint, and the dyadic block series converges unconditionally:
   $$
   \sum_{k=0}^\infty \int_{2^k}^{2^{k+1}} (\psi(x) - x) x^{-(s+1)} \, dx = \int_1^\infty (\psi(x) - x) x^{-(s+1)} \, dx = \text{coarseMellinSum}(s).
   $$
3. **Exact Logarithmic Derivative Identity:**  
   For all $s \in \mathbb{C}$ with $\text{Re}(s) > 1$:
   $$
   s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
   $$
   This formula establishes the exact polar cancellation connecting the dyadic Mellin series to the meromorphic continuation of $\zeta'(s)/\zeta(s)$.

---

## 2. Mathematical Proof

### 2.1. Kernel Integrability
For $\text{Re}(s) > 1$, $\text{Re}(-(s+1)) = -\text{Re}(s) - 1 < -2$.
By Chebyshev's unconditional bound, $\psi(\lfloor x \rfloor) \le (4\log 2) x$.
Therefore:
$$
|\psi(\lfloor x \rfloor) x^{-(s+1)}| \le (4\log 2) x \cdot x^{-\text{Re}(s)-1} = (4\log 2) x^{-\text{Re}(s)}.
$$
Since $-\text{Re}(s) < -1$, the power function $x^{-\text{Re}(s)}$ is integrable on $(1, \infty)$.
The linear term $x \cdot x^{-(s+1)} = x^{-s}$ is also integrable on $(1, \infty)$ with exact integral $\int_1^\infty x^{-s} dx = \frac{1}{s-1}$. Subtracting the two gives absolute integrability of the error kernel.

### 2.2. Dyadic Decomposition
The intervals $I_k = (2^k, 2^{k+1}]$ are pairwise disjoint and cover $(1, \infty)$.
By the countable additivity of the Lebesgue integral for integrable functions (`hasSum_integral_iUnion`), the sum of integrals over $I_k$ converges to the total integral on $(1, \infty)$.

### 2.3. Logarithmic Derivative Identity
By Perron-Mellin theory for $\text{Re}(s) > 1$:
$$
-\frac{\zeta'(s)}{\zeta(s)} = s \int_1^\infty \psi(x) x^{-(s+1)} \, dx.
$$
Subtracting $s \int_1^\infty x \cdot x^{-(s+1)} dx = s \cdot \frac{1}{s - 1} = \frac{s}{s - 1}$ yields:
$$
s \int_1^\infty (\psi(x) - x) x^{-(s+1)} \, dx = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
$$
Multiplying the dyadic Mellin sum by $s$ gives the identity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseInitialIdentity.lean`):
```lean
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

- **Prior Literature:** Classical Mellin transform connections between $\psi(x) - x$ and $-\zeta'(s)/\zeta(s) - s/(s-1)$ (Ingham 1932, Davenport 2000). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects discrete dyadic block sums to the analytical logarithmic derivative of Mathlib's `riemannZeta` without conditional convergence hypotheses.
- **Target Venues:** *Journal of Number Theory* or *Ramanujan Journal*.
