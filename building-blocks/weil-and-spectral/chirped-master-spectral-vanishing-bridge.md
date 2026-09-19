# conditional vanishing-envelope contradiction

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedMasterSpectralVanishingBridge.lean`](../../formalization/BuildingBlocks/ChirpedMasterSpectralVanishingBridge.lean)
**Classification:** conditional scalar contradiction
**Priority status:** no priority claim; this is a building block

## What Lean proves

The module defines a nonresonant tail envelope, proves that it tends to zero, and gives an explicit threshold below which it is smaller than a chosen positive epsilon.

A `VanishingBridgeSystem` stores scalar functions `Q_spec` and `Q_arith`, an exact equality between them, an arithmetic lower bound, and a spectral upper bound with a negative power term. `vanishing_bridge_refutation` chooses a scale and derives `False` from these fields. The zero-free and RH theorems require a witness assigning such a system to every candidate zero.

## Boundary of the result

The module does not derive the system from the explicit formula, construct the scalar functions, or prove the supplied estimates for zeta. The record contains the decisive analytic claims. Its emptiness is a conditional result, not a global spectral-vanishing theorem.

No custom axioms or `sorry` placeholders are used.
