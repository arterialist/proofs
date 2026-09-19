# pointwise second-order decay algebra for a quadratic phase

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedQuadratureDecay.lean`](../../formalization/BuildingBlocks/ChirpedQuadratureDecay.lean)
**Classification:** conditional pointwise real inequalities
**Priority status:** no priority claim; this is a building block

## What Lean proves

The module defines the third derivative of its quadratic phase to be zero and verifies that identity. It introduces a scalar expression `secondOrderIBPOperator` and a coefficient built from supplied upper bounds for an amplitude and its first two derivatives.

Given explicit hypotheses on those quantities and on the phase derivative, `second_order_ibp_pointwise_bound` bounds the scalar expression. Further scale inequalities yield `second_order_decay_bound` and `fourth_power_energy_decay`.

## Boundary of the result

Lean does not define an oscillatory integral or perform integration by parts on one. The amplitude derivative bounds and phase separation are inputs. The final fourth-power estimate concerns the modeled bound, not a proved spectral energy integral or dyadic zero sum.

No exhaustive priority search is documented for this formalization.

No custom axioms or `sorry` placeholders are used.
