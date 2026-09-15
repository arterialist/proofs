# Physical norm and autocorrelation prerequisites

[ChargeFrozenFourierNorm](BuildingBlocks/ChargeFrozenFourierNorm.lean)
continues the exact frozen-source Fourier formalization. It uses the
existing literal `causalSource N` and its complex embedding, with N ≥ 2
for the L² and continuity statements.

The module proves global integrability of a_N² and actual `MemLp` membership
at exponent two for the complex source. It passes from the existing
half-line square estimate to the entire real line by the source's exact
causal indicator. No global L² statement about the unfrozen source is made.

It also certifies the frequency convention. If 𝓕 is mathlib's transform
with exp(−2π i v y), then

\[
 \widehat a_N(\xi)=\mathcal F(a_N)(\xi/(2\pi)).
\]

The proof checks the integrands directly, including the nonzero factor π.
This equality does not itself prove the Jacobian or a Plancherel identity.
The exact physical whole-line square norm remains

\[
 \int_{\mathbb R}|a_N(v)|^2\,dv
 =\int_{(0,\log N]}a_N(v)^2\,dv
             +\frac{|\psi(N)-N|^2}{N}.
\]

For the autocorrelation

\[
 C_N(h)=\int_{\mathbb R}a_N(v+h)a_N(v)\,dv,
\]

the module proves integrability for every natural N, continuity at h = 0
for N ≥ 2, and C_N(0) = ∫ a_N². Integrability follows from its exact
reflected-convolution representation and the literal source's L¹ theorem.

Continuity at zero is proved by dominated convergence. Each birth atom is
continuous away from its logarithmic threshold; the clipped centering is
continuous away from the causal origin. Countably many measure-zero
exceptions and the exact finite atom decomposition yield almost-everywhere
continuity of the source. The bound |a_N(v)| ≤ ψ(N)+N gives the integrable
majorant (ψ(N)+N)|a_N(v)| for the autocorrelation integrand.

All eight printed declarations compile with only propext, Classical.choice
and Quot.sound. The pinned mathlib version supplies real-line Fourier
inversion, rather than a ready-made real-line Plancherel theorem. The
subsequent [ChargeFrozenPlancherel proof](frozen-source-exact-plancherel.md)
now certifies the Fourier transform of this autocorrelation, its actual
spectral-density identification, and inversion at zero with the frequency
Jacobian. Those steps are in the separate module. Quantitative PNT, the complete admission conclusion and
the original RH energy/sign bounds also remain unfinished.
