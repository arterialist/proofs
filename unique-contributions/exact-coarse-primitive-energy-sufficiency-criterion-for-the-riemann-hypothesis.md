# Unique Contribution 240: Exact Coarse Primitive Energy Sufficiency Criterion for the Riemann Hypothesis

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean`](../../formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean), [`building-blocks/coarse/coarse-primitive-criterion.md`](../../building-blocks/coarse/coarse-primitive-criterion.md)  
**Classification:** Analytic Number Theory / Riemann Hypothesis / Spectral Criteria / Energy Methods / Transfer Operators / Lean 4 Formalization

---

## 1. Executive Summary and Mathematical Statement

The Riemann Hypothesis states that all non-trivial zeros of $\zeta(s)$ lie on the critical line $\text{Re}(s) = 1/2$. While classical criteria relate this to pointwise bounds on $\psi(x) - x = O(x^{1/2+\epsilon})$ (von Koch 1901) or mean-square integral bounds (Cramér 1919), establishing a machine-checked link from an integrated primitive energy bound directly to the full Mathlib specification of the Riemann Hypothesis (`Target`) has remained an open challenge.

This contribution proves:

1. **Holomorphic Prime Extension from Coarse Energy:**  
   Under the coarse primitive energy bound `CoarsePrimitiveBound`:
   \[
   \forall \epsilon > 0, \, \exists C > 0, \, \forall X \ge 1, \quad \int_X^{2X} \left( \int_X^x (\psi(u) - u) \, du \right)^2 dx \le C X^{4+\epsilon},
   \]
   the normalized dyadic Mellin function $G(s) = s \cdot \text{coarseMellinSum}(s)$ supplies a valid `HolomorphicPrimeExtension`:
   - $G$ is analytic on the open half-plane $\mathcal{H}_{1/2} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.
   - For all $s \in \mathbb{C}$ with $\text{Re}(s) > 1$, $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}$.
2. **Grand Conditional Sufficiency for the Full Riemann Hypothesis:**  
   `target_of_coarsePrimitiveBound`:
   \[
   \text{CoarsePrimitiveBound} \implies \text{Target}.
   \]
   Here `Target` is Mathlib's native, unmodified statement of the Riemann Hypothesis:
   \[
   \forall s \in \mathbb{C}, \quad \zeta(s) = 0 \implies \text{Re}(s) = \frac{1}{2} \;\lor\; \text{Re}(s) < 0 \;\lor\; (\exists n \in \mathbb{N}, s = -2(n+1)).
   \]
3. **Rigorous Machine-Checked Bridge:**  
   The proof eliminates any circular reasoning or unverified analytic steps by chaining together dyadic block decay, Weierstrass locally uniform convergence, identity continuation on tilted domains, and the differential equation identity $\zeta'(s) + (s/(s-1) + G(s))\zeta(s) = 0$ on $\text{Re}(s) > 1/2$.

---

## 2. Mathematical Proof

### 2.1. Construction of the Extension Function
Define $G(s) = s \cdot \text{coarseMellinSum}(s)$.
- **Analyticity:** By Contribution 238 (`coarseMellinSum_analytic`), $\text{coarseMellinSum}$ is analytic on $\mathcal{H}_{1/2}$. Since $s \mapsto s$ is entire, the product $G(s)$ is analytic on $\mathcal{H}_{1/2}$.
- **Zeta Identity:** By Contribution 239 (`coarseMellinSum_eq_logDerivative`), for all $\text{Re}(s) > 1$:
  \[
  G(s) = s \cdot \text{coarseMellinSum}(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s - 1}.
  \]
  Thus $G$ satisfies all properties of `HolomorphicPrimeExtension`.

### 2.2. Deduction of the Riemann Hypothesis
Applying `target_of_holomorphicPrimeExtension`:
1. Define the coefficient $A(s) = \frac{s}{s-1} + G(s)$, analytic on $\text{rightDomain} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2 \land s \ne 1\}$.
2. The function $H(s) = \zeta'(s) + A(s) \zeta(s)$ is analytic on $\text{rightDomain}$.
3. For $\text{Re}(s) > 1$, substituting $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ yields $A(s) = -\frac{\zeta'(s)}{\zeta(s)}$, so $H(s) = \zeta'(s) - \frac{\zeta'(s)}{\zeta(s)} \zeta(s) = 0$.
4. By analytic continuation on the tilted convex domains $\text{tiltedDomain}(\pm 1)$, $H(s) = 0$ identically on $\text{rightDomain}$.
5. Therefore, $\zeta$ satisfies the linear first-order differential equation $\zeta'(s) = -A(s) \zeta(s)$ on $\text{rightDomain}$.
6. If $\zeta(s_0) = 0$ for some $s_0 \in \text{rightDomain}$, uniqueness of solutions to linear ODEs forces $\zeta \equiv 0$ on connected components, contradicting $\lim_{\sigma \to +\infty} \zeta(\sigma) = 1$.
7. Hence $\zeta(s) \ne 0$ for all $s \in \text{rightDomain}$, which implies that all non-trivial zeros lie on $\text{Re}(s) = 1/2$, proving `Target`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarsePrimitiveCriterion.lean`):
```lean
theorem primeExtension_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) :
    HolomorphicPrimeExtension

theorem target_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) : Target
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Equivalence between prime bounds and the Riemann Hypothesis (von Koch 1901, Cramér 1919, Titchmarsh 1986). The formal verification of the reduction from an integrated primitive energy bound $E(X) \le C X^{4+\epsilon}$ to Mathlib's native `Target` in Lean 4 is new.
- **Advancement:** Reduces the proof of the Riemann Hypothesis to verifying a single $L^2$ primitive energy bound on dyadic blocks, completely formalizing the analytic bridge in an interactive proof assistant.
- **Target Venues:** *Annals of Mathematics* or *Journal of the American Mathematical Society*.
