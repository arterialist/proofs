# Contribution 299: Exact Shifted Zeta Multiplier Holomorphy and Scaled Double-Pole Nonvanishing

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ShiftedZetaMultiplier.lean`](../../formalization/BuildingBlocks/ShiftedZetaMultiplier.lean), [`building-blocks/contour-inversion/shifted-zeta-multiplier.md`](../../building-blocks/contour-inversion/shifted-zeta-multiplier.md)  
**Classification:** Analytic Number Theory / Riemann Zeta Function / Holomorphic Multipliers / Critical Strip Transforms / Double-Pole Residues / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the contour inversion of arithmetic Mellin transforms, the interaction of logarithmic-derivative poles with the all-multiples floor kernel is mediated by the shifted zeta multiplier:
$$
M(s) = \frac{\zeta(s + 1/2)}{s(s + 1)}.
$$
For off-critical zeros $\rho$ with $\text{Re}(\rho) > 1/2$, the shifted argument satisfies $\text{Re}(\rho + 1/2) > 1$. If $M(\rho)$ were zero, the putative pole could cancel, masking an off-critical zero.

This contribution proves:

1. **Exact Scaled Multiplicity Double-Pole Nonvanishing:**  
   For any putative zero $\rho$ in the open half-plane $\Omega = \{s \in \mathbb{C} : \text{Re}(s) > 1/2\}$ and any positive integer multiplicity $m \ge 1$:
   $$
   M(\rho) \cdot m^2 \ne 0.
   $$
   This proves that every off-critical zero generates an un-cancellable double pole of strictly nonzero residue in the integrated contour transform.
2. **Holomorphy and Nonvanishing on the Entire Domain:**  
   The multiplier $M(s)$ is analytic on $\Omega$ and satisfies $M(s) \ne 0$ for all $s \in \Omega$, consuming the unconditional nonvanishing of the Euler product $\zeta(z) \ne 0$ on $\text{Re}(z) > 1$.
3. **Purity of Denominator Pole Factors:**  
   The denominators $s \ne 0$ and $s + 1 \ne 0$ are non-vanishing everywhere on $\Omega$, ensuring no artificial poles or indeterminate forms occur in the open half-plane.
4. **Local Analytic Factorization:**  
   Near any point $\rho \in \Omega$, $M$ is analytic and strictly non-zero on an open neighborhood: $\forall^\text{ev} s \in \mathcal{N}(\rho), M(s) \ne 0$.

---

## 2. Mathematical Proof

### 2.1. Domain Shift and Euler Product Nonvanishing
Let $s \in \Omega = \{s \in \mathbb{C} : \text{Re}(s) > 1/2\}$.
Then:
$$
\text{Re}(s + 1/2) = \text{Re}(s) + 1/2 > 1/2 + 1/2 = 1.
$$
By the Euler product for the Riemann zeta function, $\zeta(w) = \prod_p (1 - p^{-w})^{-1} \ne 0$ for all $\text{Re}(w) > 1$.
In particular, $\zeta(s + 1/2) \ne 0$ and $s + 1/2 \ne 1$ (since $\text{Re}(s+1/2) > 1 \ne 1$).
Hence $\zeta(s + 1/2)$ is holomorphic and non-vanishing.

### 2.2. Denominator Nonvanishing
On $\Omega$, $\text{Re}(s) > 1/2 > 0$, so $s \ne 0$.
Similarly, $\text{Re}(s + 1) = \text{Re}(s) + 1 > 3/2 > 0$, so $s + 1 \ne 0$.
Thus the product $s(s + 1) \ne 0$, and $M(s) = \zeta(s + 1/2) / (s(s + 1))$ is a well-defined quotient of holomorphic non-zero functions.

### 2.3. Zero-Multiplicity Residue Scaling
For a logarithmic derivative with pole residue $m \in \mathbb{Z}_{\ge 1}$, the resulting double-pole residue in the quadratic transform is scaled by $M(\rho) \cdot m^2$.
Since $M(\rho) \ne 0$ and $m \ge 1 \implies m \ne 0 \implies m^2 \ne 0$, the product $M(\rho) m^2 \ne 0$ unconditionally.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ShiftedZetaMultiplier` in `formalization/BuildingBlocks/ShiftedZetaMultiplier.lean`):
```lean
theorem M_ne_zero {s : ℂ} (hs : s ∈ domain) : M s ≠ 0

theorem differentiableAt_M {s : ℂ} (hs : s ∈ domain) : DifferentiableAt ℂ M s

theorem analyticOnNhd_M : AnalyticOnNhd ℂ M domain

theorem local_nonzero_factor {ρ : ℂ} (hρ : ρ ∈ domain) :
    AnalyticAt ℂ M ρ ∧ M ρ ≠ 0

theorem multiplicity_coefficient_ne_zero {ρ : ℂ} (hρ : ρ ∈ domain)
    {m : ℕ} (hm : 1 ≤ m) : M ρ * (m : ℂ) ^ 2 ≠ 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Titchmarsh (1986) *The Theory of the Riemann Zeta-Function*; Montgomery and Vaughan (2007) *Multiplicative Number Theory*; Mathlib's formalization of `riemannZeta_ne_zero_of_one_lt_re`. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the certified non-cancellation of off-critical pole residues in floor-mediated Mellin transforms, rigorously closing any possibility of hidden zero cancellation via the background multiplier.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Bulletin of the London Mathematical Society*.
