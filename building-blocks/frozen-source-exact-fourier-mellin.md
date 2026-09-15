# Exact Fourier–Mellin identity of the frozen arithmetic source

[ChargeFrozenFourier](BuildingBlocks/ChargeFrozenFourier.lean) formalizes the
Fourier transform of the existing literal `ChargeFrozenSource.causalSource`.
No source definition is replaced by its proposed transform.
Use angular frequency and w = 1/2 + iξ. For every natural N ≥ 2,

\[
 \int_{\mathbb R}e^{-i\xi v}a_N(v)\,dv
 =\frac{-1+\sum_{n=2}^N\Lambda(n)n^{-w}
                -\int_1^N x^{-w}\,dx}{w}.
\]

The Λ is mathlib's actual von Mangoldt function, so the finite sum includes
every prime power. The density is a genuine interval integral, and −1 is
the original causal seed. The transform converges absolutely by
[ChargeFrozenIntegrability](BuildingBlocks/ChargeFrozenIntegrability.lean).

The proof first establishes an exact pointwise decomposition on the entire
real line, including v = 0,

\[
 a_N(v)=\sum_{n=2}^N\Lambda(n)e^{-v/2}1_{v\ge\log n}
       -e^{-v/2}\min(e^v,N)1_{v\ge0}.
\]

Both the finite atoms and the clipped centering are integrable separately.
This avoids integrating the nonintegrable growth term and its compensating
tail separately. The threshold equivalence n ≤ eᵛ iff log n ≤ v is proved
for positive n. Each atom has transform e⁻ʷˡᵒᵍⁿ/w, from the complex exponential
integral on the half-line. Closed endpoints have zero Lebesgue measure.

For the centering, the proof retains the full two pieces on [0,log N] and
(log N,∞), giving

\[
 \frac{e^{(1-w)\log N}-1}{1-w}
       +\frac{N e^{-w\log N}}{w}.
\]

It proves N e⁻ʷˡᵒᵍᴺ = e⁽¹⁻ʷ⁾ˡᵒᵍᴺ, evaluates the actual continuous Mellin
integral by mathlib's complex-power integration theorem, and combines the
finite sum with the centering. The real parts of w and 1−w are both 1/2,
so every denominator is nonzero, including at ξ = 0.

This is a formalization of the exact finite-source identity used in the
[growing-product admission bound](compact-euler-growing-product-admission-bound.md).
It supplies its source-identification obligation. The [uniform spectral
majorant and actual logarithmic moment](frozen-source-spectral-logarithmic-bound.md)
are now formalized separately. [Physical Plancherel identification](frozen-source-exact-plancherel.md)
is also compiled. The actual PNT estimate has further formalization obligations.
The identity itself does not prove the original subpower energy bound,
the signed successor-work bound, or RH.
