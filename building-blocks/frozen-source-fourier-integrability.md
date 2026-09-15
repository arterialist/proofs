# Absolute convergence for the literal frozen source

The module [ChargeFrozenIntegrability](BuildingBlocks/ChargeFrozenIntegrability.lean)
uses the existing `ChargeFrozenSource.causalSource`, with the actual mathlib
Mangoldt sum, continuum centering and causal lower branch unchanged.
For every natural cutoff N and v ≥ 0 it proves

\[
 |a_N(v)|\le (\psi(N)+N)e^{-v/2}.
\]

Indeed, x = min(eᵛ,N) satisfies 0 ≤ x ≤ N, and monotonicity and
nonnegativity of ψ give |ψ(⌊x⌋)−x| ≤ ψ(N)+N. Multiplication by
e⁻ᵛᐟ² gives the estimate. The source vanishes for v < 0. The majorant
is integrable on the causal half-line, including its endpoint, so the
literal source belongs to L¹ on the whole real line. This holds also
for cutoffs 0 and 1.

For every real angular frequency ξ, the module also proves integrability
of e⁻ⁱξᵛ a_N(v), because its complex exponential has norm one. Thus the
ordinary Fourier integral is absolutely convergent. This is a prerequisite
for the explicit finite Mellin formula, not a formalization of that formula.
The density and origin contributions and the full frozen terminal tail
are retained through the literal source definition.

These are elementary finite-cutoff results. The constant depends on N;
they do not assert uniform Fourier decay, a subpower energy bound or L¹
membership of the unfrozen source. The original RH estimate remains open.
