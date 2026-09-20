# Contribution 352: finite Gram coercivity and a separate scalar deficit bound

**Module:** [`formalization/BuildingBlocks/ChirpedGramDefiniteness.lean`](../../formalization/BuildingBlocks/ChirpedGramDefiniteness.lean)
**Classification:** classical finite-dimensional coercivity specialized to the module's scalar model
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

For a finite complex coefficient vector, the module defines its energy and a scalar lower form `gramLower`. Given row and column norm bounds on a matrix `p`, `gramLower_coercive` proves `(d - R) * energy c <= gramLower d p c`.
For a nonzero vector, `rayleighQuotient_ge_margin` gives the corresponding Rayleigh lower bound. If the supplied floor satisfies `C_tot < d - R` with `C_tot >= 0`, `gramLower_strictly_positive` proves strict positivity.

The module also proves the scalar identity obtained from the chosen buffer and the positivity of `c0 = 1 - exp (-1 / 2)`.
Its final eventual theorem compares a logarithmic expression with a negative power term. That theorem is real asymptotic algebra.

## Boundary of the result

Lean does not identify `p` or `gramLower` with a Gram matrix arising from an actual zeta test function. The row and column estimates are hypotheses. The scalar deficit theorem does not show that an off-critical zero supplies the modeled spectral expression, nor does it connect that expression to the finite Gram form. The certificate builder stores constants and their elementary sign conditions.

Accordingly, this module supplies reusable coercivity and growth lemmas. It does not prove zero-freeness or the Riemann hypothesis.

## Representative declarations

- `energy_pos_of_ne_zero`
- `canonical_margin_decomp`
- `gramLower_strictly_positive`
- `rayleighQuotient_ge_margin`
- `spectral_arithmetic_positivity_exclusion`
- `makeCanonicalGramDefinitenessCertificate`

No custom axioms or `sorry` placeholders are used.
