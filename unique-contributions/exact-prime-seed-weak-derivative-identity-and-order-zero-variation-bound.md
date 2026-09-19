# Unique Contribution 195: Exact Prime Seed Weak Derivative Identity and Order-Zero Variation Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSeedWeakDerivative.lean`](../../formalization/BuildingBlocks/PrimeSeedWeakDerivative.lean), [`building-blocks/primes/prime-seed-weak-derivative.md`](../../building-blocks/primes/prime-seed-weak-derivative.md)  
**Classification:** Distribution Theory / Sobolev Spaces / Weak Derivatives / Integration by Parts / Boundary Telescoping / Total Variation Duality

---

## 1. Executive Summary and Mathematical Statement

The prime renewal seed $\text{seed}_L(v)$ is a piecewise smooth function discontinuous across countably many points. In distribution theory, computing the action of its weak derivative on smooth test functions requires an explicit infinite boundary-telescoping identity that accounts simultaneously for the continuous intra-cell drift, the positive birth jump at arrival age $v = L$, and the infinite sum of negative proper-power step jumps.

This contribution proves:

1. **Intra-Cell Integration by Parts:**  
   On each clock interval $I_j = [(j+1)L, (j+2)L)$, for any $C^1$ test function $\phi$:
   \[
   \int_{(j+1)L}^{(j+2)L} \text{seed}_L(v) \left( \phi'(v) + \frac{1}{2}\phi(v) \right) dv = e^{-(j+2)L/2} \phi((j+2)L) - e^{-(j+3)L/2} \phi((j+1)L).
   \]
2. **Infinite Telescoping Weak Derivative Identity:**  
   Summing over all cells $j \in \mathbb{N}$, the boundary evaluations telescope unconditionally:
   \[
   \int_{-\infty}^\infty \text{seed}_L(v) \phi'(v) \, dv = -\frac{1}{2} \int_{-\infty}^\infty \text{seed}_L(v) \phi(v) \, dv - e^{-3L/2}\phi(L) + \sum_{j=0}^\infty (1 - e^{-L}) e^{-(j+2)L/2} \phi((j+2)L).
   \]
   The telescoping boundary sum decomposes precisely into:
   - Negative continuous drift: $-\frac{1}{2}\int \text{seed}_L \phi$,
   - Isolated positive birth jump at arrival $v = L$: $-e^{-3L/2}\phi(L)$,
   - Infinite series of negative proper-power step jumps: $\sum_{j=0}^\infty (1 - e^{-L})e^{-(j+2)L/2}\phi((j+2)L)$.
3. **Order-Zero Distributional Estimate:**  
   For any bounded $C^1$ test function $\phi$ with $\|\phi\|_\infty \le M$:
   \[
   \left| \int_{-\infty}^\infty \text{seed}_L(v) \phi'(v) \, dv \right| \le \left( 2e^{-L} + 2e^{-3L/2} \right) M.
   \]
   The distributional derivative $D(\text{seed}_L)$ is a distribution of order 0 whose operator norm on $C_b^1(\mathbb{R})$ is bounded by the exact total variation budget $2e^{-L} + 2e^{-3L/2}$.

---

## 2. Mathematical Proof

### 2.1. Single Cell Integration by Parts
Within the cell $v \in ((j+1)L, (j+2)L)$, $\text{seed}_L(v) = \text{cellDensity}_L(j, v) = \exp(v/2 - (j+2)L)$.
Differentiating the product:
\[
(\text{cellDensity} \cdot \phi)' = (\text{cellDensity})' \phi + \text{cellDensity} \cdot \phi' = \text{cellDensity} \left(\phi' + \frac{1}{2}\phi\right).
\]
By the Fundamental Theorem of Calculus:
\[
\int_{(j+1)L}^{(j+2)L} \text{cellDensity}\left(\phi' + \frac{1}{2}\phi\right) = \text{cellDensity}((j+2)L)\phi((j+2)L) - \text{cellDensity}((j+1)L)\phi((j+1)L).
\]
Evaluating at the endpoints gives $e^{-(j+2)L/2}\phi((j+2)L) - e^{-(j+3)L/2}\phi((j+1)L) = A_j - B_j$.

### 2.2. Global Telescoping Summation
Summing across all $j \in \mathbb{N}$:
\[
\sum_{j=0}^\infty (A_j - B_j) = \sum_{j=0}^\infty (A_j - B_{j+1}) - B_0.
\]
Here $B_0 = e^{-3L/2}\phi(L)$.
For $j \ge 0$, $B_{j+1} = e^{-(j+4)L/2}\phi((j+2)L) = e^{-L} e^{-(j+2)L/2}\phi((j+2)L)$.
Thus:
\[
A_j - B_{j+1} = (1 - e^{-L}) e^{-(j+2)L/2}\phi((j+2)L).
\]
The integral of $\text{seed}_L(\phi' + \phi/2)$ on $[L, \infty)$ is $\int \text{seed}_L \phi' + \frac{1}{2}\int \text{seed}_L \phi$.
Rearranging yields the weak derivative identity.

### 2.3. Total Variation Operator Bound
Applying the triangle inequality:
\[
\left| \int \text{seed}_L \phi' \right| \le \frac{1}{2}\int \text{seed}_L |\phi| + e^{-3L/2}|\phi(L)| + \sum_{j=0}^\infty (1 - e^{-L})e^{-(j+2)L/2}|\phi((j+2)L)|.
\]
Bounding $|\phi| \le M$:
\[
\frac{1}{2} (2e^{-L}) M + e^{-3L/2}M + (e^{-L} + e^{-3L/2}) M = (2e^{-L} + 2e^{-3L/2}) M.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PrimeSeedMass` in `formalization/BuildingBlocks/PrimeSeedWeakDerivative.lean`):
```lean
theorem cellDensity_hasDerivAt (L : ℝ) (j : ℕ) (v : ℝ) :
    HasDerivAt (cellDensity L j) (cellDensity L j v / 2) v

theorem seed_cell_weak_derivative {L : ℝ} (hL : 0 < L) (j : ℕ)
    {φ φ' : ℝ → ℝ} (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ') :
    (∫ v in Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L),
      seed L v * (φ' v + φ v / 2)) =
      exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) -
        exp (-((j + 3 : ℝ) * L) / 2) * φ ((j + 1 : ℝ) * L)

theorem seed_weak_derivative {L : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, seed L v * φ' v) = -(1 / 2) * (∫ v, seed L v * φ v) -
      exp (-3 * L / 2) * φ L +
        ∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L)

theorem seed_weak_derivative_bound {L M : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∀ v, |φ v| ≤ M) (hb' : ∃ M', ∀ v, |φ' v| ≤ M') :
    |∫ v, seed L v * φ' v| ≤ (2 * exp (-L) + 2 * exp (-3 * L / 2)) * M
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Distributional derivatives of piecewise smooth functions and BV integration by parts (Schwartz 1950, Evans-Gariepy 2015, Leoni 2017). Machine formalization of cell-by-cell boundary telescoping and the exact order-zero bound for prime renewal seeds in Lean 4 is new.
- **Advancement:** Proves the exact identity for $\int \text{seed}_L \phi'$ and establishes the quantitative order-zero bound with coefficient $2e^{-L} + 2e^{-3L/2}$ in Lean 4.
- **Target Venues:** *Real Analysis Exchange* or *Journal of Functional Analysis*.
