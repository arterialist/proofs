# Uniform spectral envelope and actual logarithmic moment

[ChargeFrozenSpectralBound](../../formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean)
and [ChargeFrozenLogMoment](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean)
apply the existing arithmetic bounds and general logarithmic-moment lemma
to the literal frozen source. Every result below is for natural N ≥ 2
and every real angular frequency ξ, with w = 1/2 + iξ.

Write â_N(ξ) = ∫ e⁻ⁱξᵛ a_N(v)dv. The actual transform is identified in
[ChargeFrozenFourier](../../formalization/BuildingBlocks/ChargeFrozenFourier.lean), including
the full Mangoldt sum, seed and continuous density. The new envelope is

\[
 |\widehat a_N(\xi)|^2\le\frac{A_N}{1+\xi^2},\qquad
 A_N=4(8\log2+2)^2N.
\]

The proof reuses the repository's unconditional
`CoarsePrimitive.psi_le_linear` and `BuildingBlocks.weighted_vonMangoldt_le`.
The latter gives, by full Abel summation,

\[
 \sum_{n=2}^N\frac{\Lambda(n)}{\sqrt n}\le8\log2\sqrt N.
\]

For x > 0, the module proves |x⁻ʷ| = x⁻¹ᐟ². The genuine density integral
has norm at most ∫₁ᴺ x⁻¹ᐟ²dx = 2(√N−1). The norm of the seed −1 is one.
The complete Mellin numerator therefore has norm at most
(8 log2+2)√N. Finally |w|² = 1/4+ξ², and
(1+ξ²)/(1/4+ξ²) ≤ 4. All prime powers and all frequencies remain in
these estimates. No RH hypothesis is used.

Define the actual spectral density r_N(ξ) = |â_N(ξ)|² and its mass
H_N = ∫ r_N(ξ)dξ. The second module proves measurability directly from
the jointly measurable integral defining â_N. The envelope, compared
with the integrable function (1+ξ²)⁻¹, then proves r_N is integrable.
It applies the complete compiled
[LogarithmicLayercake](../../formalization/BuildingBlocks/LogarithmicLayercake.lean) theorem to obtain
logarithmic integrability and, when H_N > 0,

\[
 \int r_N(\xi)\log(2+|\xi|)\,d\xi
 \le H_N\left[\log2+\log\left(1+\frac{A_N}{H_N}\right)+1\right].
\]

The Lean theorem also covers zero mass by the existing separate proof
that a nonnegative integrable density of zero mass vanishes almost
everywhere. It does not use a positive-denominator argument at zero.

This H_N is the actual spectral integral with angular-frequency measure
dξ. The [separate Plancherel module](../dynamics-and-feedback/frozen-source-exact-plancherel.md) now
proves its identification with 2π times the physical dv norm and the
logarithmic-moment bound with that physical mass. The quantitative PNT source
estimate and the complete operator admission conclusion remain further
formalization obligations in the
[growing-product argument](../prime-history/compact-euler-growing-product-admission-bound.md).
The original subpower energy and arithmetic signed-work estimates remain
unproved. These bounds formalize the unconditional envelope and its
logarithmic consumer; they do not establish RH.
