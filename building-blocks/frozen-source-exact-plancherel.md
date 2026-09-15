# Exact Plancherel identity for the literal frozen source

[ChargeFrozenPlancherel](BuildingBlocks/ChargeFrozenPlancherel.lean)
formalizes the real-line mass identity for the existing literal arithmetic
source. For every natural N ≥ 2, with angular-frequency transform
â_N(ξ) = ∫ e⁻ⁱξᵛ a_N(v)dv, it proves

\[
 H_N:=\int_{\mathbb R}|\widehat a_N(\xi)|^2\,d\xi
     =2\pi\int_{\mathbb R}a_N(v)^2\,dv.
\]

It also proves the exact terminal contribution is retained:

\[
 H_N=2\pi\left[\int_{(0,\log N]}a_N(v)^2\,dv
                    +\frac{|\psi(N)-N|^2}{N}\right].
\]

The actual source, density, origin and every prime power are unchanged.
The result uses neither RH nor an additional arithmetic estimate.

The proof uses the already certified source's L¹ membership and the
[autocorrelation prerequisites](frozen-source-plancherel-prerequisites.md).
The auxiliary [AngularFourierConvolution](BuildingBlocks/AngularFourierConvolution.lean)
proves the full convolution theorem for arbitrary integrable complex
functions on the real line. Its joint absolute-integrability bound comes
from mathlib's L¹ convolution integrand theorem. Multiplication by the
Fourier phase preserves that bound because the phase has norm one.
Fubini and translation invariance therefore apply to the full double
integral. No observing cutoff or truncated spectral integral is used.

For C_N(h) = ∫ a_N(v+h)a_N(v)dv, the exact reflected-convolution identity,
reflection of angular frequency and conjugation of a real source give

\[
 \widehat C_N(\xi)
   =\widehat a_N(-\xi)\widehat a_N(\xi)
   =|\widehat a_N(\xi)|^2.
\]

The source's real-valuedness is used explicitly. The right side is the
actual spectral density, whose integrability was proved in
[ChargeFrozenLogMoment](BuildingBlocks/ChargeFrozenLogMoment.lean).
In mathlib's convention this reads 𝓕 C_N(y) = |â_N(2πy)|². Scaling proves
integrability of this transform. Mathlib's existing
`MeasureTheory.Integrable.fourier_inversion` applies at zero because C_N
is integrable and continuous there. The inverse transform at zero is
its full integral, and the Lebesgue scaling factor is 1/(2π). Combining
this with C_N(0) = ∫ a_N² proves the displayed Plancherel identity.

The module finally applies this identity to the
[actual logarithmic-moment bound](frozen-source-spectral-logarithmic-bound.md).
Its RHS now uses H_N = 2π ∫ a_N² and A_N = 4(8 log2+2)²N:

\[
 \int|\widehat a_N(\xi)|^2\log(2+|\xi|)\,d\xi
 \le H_N[\log2+\log(1+A_N/H_N)+1]\quad(H_N>0).
\]

The Lean statement also covers zero mass through the separate
zero-density proof already supplied by the general logarithmic-moment
theorem. It does not assume a positive denominator in that case.

All ten printed declarations across the two new modules compile with
only propext, Classical.choice and Quot.sound. This is a formalization
of the classical Plancherel mechanism for the literal finite source,
not a new RH energy estimate. Quantitative PNT, the complete depth-four
operator admission conclusion and the original arithmetic sign/subpower
bounds remain unfinished.
