# Contradiction from supplied modular scalar components

**Classification:** conditional data assembly

**Lean module:** [`ChirpedLinearCarrierAssembly.lean`](../formalization/BuildingBlocks/ChirpedLinearCarrierAssembly.lean)

`ChirpedModularComponents` packages the arithmetic and spectral functions and the component bounds needed by the canonical contradiction. The module maps that record to `CanonicalEvaluationSystem` and `LinearVanishingBridgeSystem`, then reuses their inconsistency.

The RH theorem requires a witness assigning this full component record to every high-frequency off-line zero, together with low-height zero-freeness. The module does not derive the record's fields from prime sums or zeta zeros.

This is a machine-checked constructor between assumption packages. It is largely duplicative of the surrounding certificate layers and could be simplified by exposing one core scalar contradiction and one evaluator interface.
