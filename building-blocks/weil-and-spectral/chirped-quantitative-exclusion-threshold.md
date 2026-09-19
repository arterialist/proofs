# an explicit power-log threshold and conditional exclusion

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedQuantitativeExclusionThreshold.lean`](../../formalization/BuildingBlocks/ChirpedQuantitativeExclusionThreshold.lean)
**Classification:** explicit real-algebra threshold with a conditional zeta interface
**Priority status:** no priority claim; this is a building block

## What Lean proves

For positive `d` and `b`, the module defines an explicit threshold and proves a power-log domination inequality above it. `quantitative_coercive_exclusion` combines that inequality with supplied arithmetic and spectral estimates.

`QuantitativeCoerciveSystem` requires, for each candidate right-half-plane zeta zero, scalar functions and all decisive facts: equality of the two sides, the arithmetic lower bound, the spectral upper bound, and sign conditions. The zero-free and RH theorems assume this proposition.

## Boundary of the result

Lean proves the threshold calculation. It does not derive the analytic estimates from a zeta zero or a constructed operator. The certificate builder records parameters and properties of the real threshold. It is not a finite verification of zeta zeros above a numerical height.

Representative declarations are `quantitative_power_dominance`, `quantitative_offline_refutation`, `QuantitativeCoerciveSystem`, and `RiemannHypothesis_of_quantitative_system`.

No custom axioms or `sorry` placeholders are used.
