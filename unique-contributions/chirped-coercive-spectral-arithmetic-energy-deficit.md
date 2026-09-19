# Contribution 354: conditional scalar coercive exclusion

**Module:** [`formalization/BuildingBlocks/ChirpedCoerciveSpectralExclusion.lean`](../formalization/BuildingBlocks/ChirpedCoerciveSpectralExclusion.lean)
**Classification:** conditional contradiction theorem with auxiliary real inequalities
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

The module proves cancellation and comparison lemmas for a nonzero finite coefficient vector, then establishes eventual incompatibility between a logarithmic lower bound and a negative power term.

`coercive_offline_zero_refutation` accepts arbitrary scalar functions `W_arith` and `W_spec`. It derives `False` only after receiving their pointwise equality, a coercive arithmetic lower bound, a spectral upper bound containing the negative power term, and the required sign assumptions.

`CoerciveSystem` requires every candidate right-half-plane zeta zero to yield those same decisive functions, identities, and inequalities. `RiemannHypothesis_of_coercive_system` is an implication from that proposition.

## Boundary of the result

The module does not construct a Weil form, a chirped operator, or the analytic estimates needed to inhabit `CoerciveSystem`. It does not prove that a zeta zero supplies the assumed spectral deficit. `makeCanonicalCoerciveCertificate` packages constants only.

The unconditional content is scalar and finite-dimensional algebra. The RH conclusion remains conditional on the full analytic system.

No custom axioms or `sorry` placeholders are used.
