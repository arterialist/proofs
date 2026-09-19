# Actual critical sign criterion: Mellin continuation and pole obstruction in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [ActualCriticalSignCriterion.lean](../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)
- [CriticalTransformContinuationRH.lean](../formalization/BuildingBlocks/CriticalTransformContinuationRH.lean)
- [ActualCriticalConvergence.lean](../formalization/BuildingBlocks/ActualCriticalConvergence.lean)

A targeted search across Mathlib, the Lean community archives, Isabelle/AFP, and Coq/ROC
found no prior formalization of an arithmetic sign criterion for the Riemann Hypothesis
via shifted multipliers, double-pole clearing, and identity theorem continuation.

## Mathematical content

The formalized development proves:
\[
 \boxed{\quad
 \left( \forall^\infty x \in \mathbb{R},\ \operatorname{Re} W(x) \le 0 \right) \implies \mathrm{RiemannHypothesis}.
 \quad}
\]
Here $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ is the arithmetic convolution of the bilinear
centered von Mangoldt difference with the square-root aggregation kernel.

### Key formalization steps
1. **Double-pole clearing (`cleared`):**
   Multiplication by $\zeta(s)^2$ clears the simple pole of $\zeta'/ \zeta$ while preserving
   the double pole $2m_\rho \ge 2$ at any hypothetical off-line zero $\rho$ with $\beta > 1/2$.
2. **Identity theorem continuation (`cleared_zero_on_rightDomain`):**
   Using the identity theorem for holomorphic functions, the cleared form vanishes identically
   on the right half-plane domain $\{s \in \mathbb{C} : \operatorname{Re} s > 1/2, s \ne 1\}$.
3. **Punctured neighborhood non-vanishing (`continuation_eventuallyEq_filledTransform`):**
   By isolated-zero nonvanishing of $\zeta(s)$, division on a punctured neighborhood forces
   the analytic continuation $J(s)$ to equal the transform having a pole of order $\ge 2$ at $\rho$.
4. **Contradiction:**
   A function holomorphic at $\rho$ cannot equal a meromorphic function with a pole of order $\ge 2$
   on a punctured neighborhood, proving that no zeros can exist with $\operatorname{Re} \rho > 1/2$.

### Verification and dependencies
- Lean version: 4.24.0.
- Mathlib commit: `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero placeholder proofs (`sorry`), zero unproved custom axioms.
