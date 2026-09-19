# an inconsistent certificate type for a modeled off-line zero

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Module:** [`formalization/BuildingBlocks/ChirpedOfflineSingularCertificate.lean`](../../formalization/BuildingBlocks/ChirpedOfflineSingularCertificate.lean)
**Classification:** conditional certificate interface and real growth lemmas
**Priority status:** no priority claim; this is a building block

## What Lean proves

The module defines a scalar energy deficit and proves positivity, eventual positivity, and divergence under sign hypotheses.

An `OfflineSingularCertificate s` contains a zeta-zero assertion, scalar functions `Q_arith` and `Q_spec`, their equality, and bounds that make them incompatible beyond a stored threshold. `refute_singular_zero` proves that no inhabitant of this record can exist. The zero-free and RH theorems assume that every candidate zero yields such a record.

## Boundary of the result

The certificate is contradictory once all fields are supplied. Its builder requires the decisive equality and analytic bounds as arguments. It does not extract them from `riemannZeta s = 0`, build an operator, or prove an off-line zero impossible on its own.

No custom axioms or `sorry` placeholders are used.
