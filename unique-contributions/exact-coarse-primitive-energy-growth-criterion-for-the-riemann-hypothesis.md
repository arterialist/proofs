# Unique Contribution 221: Exact Coarse Primitive Energy Growth Criterion for the Riemann Hypothesis

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean`](../../formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean), [`building-blocks/coarse/coarse-primitive-criterion.md`](../../building-blocks/coarse/coarse-primitive-criterion.md)  
**Classification:** Analytic Number Theory / Riemann Hypothesis / Coarse Energy Bounds / Mellin Continuation / Equivalent Criteria / Formal Proof Engineering

---

## 1. Executive Summary and Mathematical Statement

A central objective in the spectral and energetic reformulation of the Riemann Hypothesis is reducing the complex analytic assertion that $\zeta(s) \ne 0$ for $\text{Re}(s) > 1/2$ to a verifiable growth bound on the real line. The dyadic coarse primitive energy measures the $L^2$ dispersion of the smoothed prime counting error over dyadic scales:
\[
\text{coarsePrimitiveSquare}(X) = \int_0^X \left( \int_0^y (\psi(t) - t) dt \right)^2 dy.
\]
This contribution proves that if the coarse primitive energy satisfies the polynomial growth condition:
\[
\forall \epsilon > 0, \; \exists C_\epsilon > 0, \; \forall k \in \mathbb{N}, \quad \text{coarsePrimitiveSquare}(2^k) \le C_\epsilon (2^k)^{4+\epsilon},
\]
then:
1. **Holomorphic Prime Extension:**  
   The normalized dyadic Mellin series $G(s) = s \cdot \text{coarseMellinSum}(s)$ is analytic on the open half-plane $\{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ and matches $-\zeta'(s)/\zeta(s) - s/(s-1)$ on the half-plane of absolute convergence $\{s \in \mathbb{C} \mid \text{Re}(s) > 1\}$.
2. **Conditional Analytic Sufficiency for the Riemann Hypothesis:**  
   This coarse primitive growth condition rigorously implies the Riemann Hypothesis:
   \[
   \text{CoarsePrimitiveBound} \implies \text{Target},
   \]
   where $\text{Target}$ is Mathlib's formal statement of the Riemann Hypothesis (`∀ s : ℂ, riemannZeta s = 0 → 0 < s.re → s.re < 1 → s.re = 1/2`).

---

## 2. Mathematical Proof

### 2.1. Construction of the Holomorphic Extension
Assume $\text{CoarsePrimitiveBound}$.
By Contribution 219 (`coarseMellinSum_analytic`), the dyadic sum $\text{coarseMellinSum}(s)$ is analytic on $\{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.
Since $s \mapsto s$ is entire, the product $G(s) = s \cdot \text{coarseMellinSum}(s)$ is analytic on $\text{Re}(s) > 1/2$.
By Contribution 220 (`coarseMellinSum_eq_logDerivative`), for every $s$ with $\text{Re}(s) > 1$:
\[
G(s) = s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
\]
Thus $G$ is a valid `HolomorphicPrimeExtension`.

### 2.2. Deduction of the Riemann Hypothesis
By the standard analytic continuation bridge (`RHContinuation.target_of_holomorphicPrimeExtension`), if $-\zeta'(s)/\zeta(s) - s/(s-1)$ extends holomorphically to $\text{Re}(s) > 1/2$, then $\zeta(s)$ cannot vanish in the half-plane $\text{Re}(s) > 1/2$.
Any hypothetical non-trivial zero $\rho_0 = \beta_0 + i\gamma_0$ with $\beta_0 > 1/2$ would produce a simple pole of $\zeta'(s)/\zeta(s)$ with residue equal to its multiplicity $m \ge 1$, directly contradicting the analyticity of $G(s)$ at $\rho_0$.
Since non-trivial zeros are symmetric about the critical line $\text{Re}(s) = 1/2$, this implies all non-trivial zeros satisfy $\text{Re}(s) = 1/2$, establishing $\text{Target}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean`):
```lean
theorem primeExtension_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) :
    HolomorphicPrimeExtension

theorem target_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) :
    Target
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Equivalent criteria for the Riemann Hypothesis based on error integrals and Riesz/Báez-Duarte/Páley-Wiener frames (Titchmarsh 1986, Báez-Duarte 2003, Broughan 2017). Machine formalization connecting dyadic $L^2$ primitive energy bounds to Mathlib's formal `riemannZeta` zero criterion in Lean 4 is new.
- **Advancement:** Establishes a completely formalized criterion reducing the Riemann Hypothesis in Mathlib to a purely real-variable dyadic primitive energy growth bound.
- **Target Venues:** *Journal of Functional Analysis* or *Bulletin of the London Mathematical Society*.
