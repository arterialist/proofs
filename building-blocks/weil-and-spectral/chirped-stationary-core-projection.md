# identities for a modeled stationary-core weight

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedStationaryCoreProjection.lean`](../../formalization/BuildingBlocks/ChirpedStationaryCoreProjection.lean)
**Classification:** definitional scalar identities with conditional modular assembly
**Priority status:** no priority claim; this is a building block

## What Lean proves

The module defines `delta T = 2 / sqrt T`, `L T = 4 / sqrt T`, `A a T = 2 * a / sqrt T`, and `W a T = 4 * a ^ 2 / T`.

It proves identities among these definitions under the needed sign or nonzero assumptions. It also defines the normalized quantity `4 * a ^ 2` and compares it with the configured coupling `2 * a ^ 2`.

`canonicalComplexWeight` is defined from that scalar. `makeCanonicalPairedZeroData` assembles the conditional record used by the pair-energy module, provided the caller supplies the scalar functions, analytic estimates, and exact equality.

## Boundary of the result

`coherentCoreAmplitude` and `coherentSpectralWeight` are formulas, not values obtained by integrating an envelope. The module contains no integral and proves no stationary-phase lower bound for an actual wavepacket. It does not derive the modular estimates from a zeta zero.

The RH theorem requires low-frequency zero-freeness and a witness producing `PairedZeroData` for each remaining candidate zero.

No custom axioms or `sorry` placeholders are used.
