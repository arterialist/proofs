# Riemann Zeta Perron Holomorphy and Off-Line Double Pole Rigidity

**Status:** Formalized in Lean 4 and certified via in-kernel axiom check (`RiemannZetaPerronHolomorphyAudit.lean`), October 2026.
Module location:
- [`formalization/BuildingBlocks/RiemannZetaPerronHolomorphy.lean`](../BuildingBlocks/RiemannZetaPerronHolomorphy.lean)
- Audit: [`formalization/verification/RiemannZetaPerronHolomorphyAudit.lean`](../verification/RiemannZetaPerronHolomorphyAudit.lean)

Attribution: Arterialist RH Research Team, October 2026.

## Overview

This module formalizes the exact spectral holomorphy and pole rigidity structure of the Perron Mellin transform kernel `fullFactor(s)` across the critical strip $\operatorname{Re}(s) > 1/2$:
\[
 \operatorname{fullFactor}(s) := \zeta(s + 1/2) \frac{\operatorname{centeredZetaLogDerivative}(s)^2}{s(s+1)}
\]
where
\[
 \operatorname{centeredZetaLogDerivative}(s) := -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}.
\]

## Mathematical Highlights

1. **Holomorphy Off Zeros**:
   For every $s \in \mathbb{C}$ satisfying $\operatorname{Re}(s) > 1/2$, $s \ne 1$, and $\zeta(s) \ne 0$:
   \[
    \operatorname{AnalyticAt}\ \mathbb{C}\ \operatorname{fullFactor}\ s.
   \]
   The denominator $s(s+1) \ne 0$ for $\operatorname{Re}(s) > 0$. The shifted zeta factor $\zeta(s + 1/2)$ is analytic since $s + 1/2 \ne 1$ when $\operatorname{Re}(s) > 1/2$. The centered logarithmic derivative is analytic off the zeros and the pole at $s = 1$.

2. **Right-Half Zero-Freeness Transfer**:
   Under the right-half zero-free hypothesis $\operatorname{RightHalfZeroFree}$ ($\forall s, \operatorname{Re}(s) > 1/2 \to \zeta(s) \ne 0$), $\operatorname{fullFactor}(s)$ is holomorphic on the entire punctured half-plane:
   \[
    \{s \in \mathbb{C} \mid 1/2 < \operatorname{Re}(s),\ s \ne 1\}.
   \]

3. **Perron Singularity-Free Equivalence**:
   We establish the definitive equivalences:
   \[
    \operatorname{PerronSingularityFree} \iff \operatorname{RightHalfZeroFree} \iff \operatorname{RiemannHypothesis}.
   \]

4. **Off-Line Pole Domination**:
   For any hypothetical off-line zero $\rho = \beta + i\gamma$ with $\beta > 1/2$, the logarithmic derivative $-\zeta'/\zeta(s)$ possesses a simple pole of residue $m \ge 1$ at $s = \rho$. Its square creates a double pole with residue exponent:
   \[
    \beta + 1 > 3/2.
   \]
   This strictly exceeds the critical contour exponent $3/2$ by the strictly positive gap $\delta := \beta - 1/2 > 0$, forcing an oscillating Perron contribution $\sim x^{\beta + 1} \log x$ that violates the cubic fluctuation upper bound $O(x^{3/2} \log^2 x)$ of `RiemannZetaCubicFluctuationBound`.

## Verified Declarations

The following 13 theorems are verified in Lean 4 without `sorry` or `sorryAx`:

1. `centeredZetaLogDerivative_eq_sub`
2. `denominator_ne_zero`
3. `shifted_arg_ne_one`
4. `analyticAt_fullFactor_off_zeros`
5. `analyticAt_fullFactor_of_rightHalfZeroFree`
6. `analyticAt_fullFactor_of_RH`
7. `off_line_exponent_gt_three_halves`
8. `exponent_gap_pos`
9. `not_rightHalfZeroFree_of_zero`
10. `not_RiemannHypothesis_of_zero`
11. `perronSingularityFree_iff_rightHalfZeroFree`
12. `RiemannHypothesis_iff_perronSingularityFree`
13. `perronSingularityFree_of_highFrequencyContradictionSystem`

## Axiom Audit

All 13 theorems depend strictly on the standard foundational axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`

Exact 0 `sorry`, 0 `sorryAx`, 0 custom axioms.
