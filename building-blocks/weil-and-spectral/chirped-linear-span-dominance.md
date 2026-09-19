# linear power dominance and a conditional bridge

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedLinearSpanDominance.lean`](../../formalization/BuildingBlocks/ChirpedLinearSpanDominance.lean)
**Classification:** explicit real-algebra threshold with a conditional zeta interface
**Priority status:** no priority claim; this is a building block

## What Lean proves

For nonzero displacement `d`, the definition `spanDilationLinear d = 1 / d` gives exponent `2 * spanDilationLinear d * d - 1 = 1`. The module proves the corresponding power identity and an explicit threshold above which `2 * b * T` dominates `A * log T + C`.

A `LinearVanishingBridgeSystem` stores `Q_spec`, `Q_arith`, their equality, and opposing spectral and arithmetic estimates. `linear_vanishing_bridge_refutation` proves this record empty. The RH theorem assumes a witness producing one for every candidate zero.

## Boundary of the result

The span dilation is a scalar definition. The module does not build a family of chirped wavepackets with this span, prove uniform analytic control as `d` varies, or derive the bridge fields from a zeta zero. The global conclusion remains conditional on the witness.

No custom axioms or `sorry` placeholders are used.
