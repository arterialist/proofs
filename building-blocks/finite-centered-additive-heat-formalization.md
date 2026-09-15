# Finite centered additive heat formalization

Lean 4.24.0 formalization by RH Proof, 16 September 2026, with
independent mathematical support from RH Agent3. The results certify
finite analytic identities and a classical gamma comparison. They
do not prove an arithmetic error estimate or RH. No literature
priority claim is made.

All six canonical modules built successfully with pinned Lean
4.24.0. All 43 printed theorem declarations report only propext,
Classical.choice and Quot.sound. No mathematical axiom or admitted
proof was added.

The literal source is

    C_N(t) = sum_(n<=N) Lambda(n)exp(-nt)
               - integral_1^N exp(-tx)dx - exp(-t),   N>=1.

Lambda is mathlib's actual von Mangoldt function, including every
proper prime power. The finite sum includes indices zero and one,
whose Lambda coefficients vanish. The last term is the negative
origin atom. The density is the genuine interval integral, also
identified with the Lebesgue integral on [1,N]. For t!=0 the compiled
formula evaluates it as [exp(-t)-exp(-Nt)]/t. At t=0 the source is
sum_(n<=N)Lambda(n)-N; the proof never divides by zero. At N=1 it
is -exp(-t).

`ActualFiniteHeatSource.source_successor` certifies

    C_(N+1)(t)-C_N(t)
      = Lambda(N+1)exp(-(N+1)t)-integral_N^(N+1)exp(-tx)dx.

The compiled variation envelope

    |C_N(t)| <= [sum_(n<=N)Lambda(n)+N]exp(-t),   t>=0,

proves square integrability at every finite cutoff. This envelope
establishes membership, not the required subpower bound as N grows.

The complete finite heat Gram is compiled in
`ActualHeatDensityPairing.actual_source_gram`. Put c_1=-1,
c_n=Lambda(n) for 2<=n<=N. Its equivalent positive-coordinate
implementation keeps a dummy c_0=0 at coordinate max(0,1)=1;
the exact source profile equality is proved separately. In the
ordinary coordinates the identity is

    integral_(t>0) C_N(t)^2 dt
      = sum_(i,j=1)^N c_i c_j/(i+j)
        -2 sum_(i=1)^N c_i log((i+N)/(i+1))
        +2N log(2N)-2(N+1)log(N+1)+2log2.

All diagonals, both mixed orientations, the seed and the density
square remain. Rectangular Fubini is justified by proved joint
integrability. The atom-density norm-fiber is 1/(x+y)<=1/2;
the second joint integrand has the envelope (N-1)exp(-2t).
The density itself is strongly measurable through its actual
parameter integral. No point evaluation of an L2 equivalence class
or replacement of the density by atoms occurs in the proof.

The supporting modules are:

| Module | Certified scope |
| --- | --- |
| [AdditivePairBalance](BuildingBlocks/AdditivePairBalance.lean) | Physical=twice additive minus balance kernel and complete finite signed Gram; balance quadratic has both signs. |
| [AdditiveHeatWeight](BuildingBlocks/AdditiveHeatWeight.lean) | Positive cosh-series bound and pi/4 comparison of the heat and physical Fourier weights. |
| [AdditiveHeatGamma](BuildingBlocks/AdditiveHeatGamma.lean) | Classical gamma modulus squared pi/cosh(pi xi), via reflection and conjugation. |
| [AdditiveHeatPairing](BuildingBlocks/AdditiveHeatPairing.lean) | Exponential integrability/pairing, signed finite heat Gram, actual L2 classes and LipschitzWith 1/2 on x>=1. |
| [ActualFiniteHeatSource](BuildingBlocks/ActualFiniteHeatSource.lean) | Literal Lambda source, continuum cutoff, origin, successor and finite square membership. |
| [ActualHeatDensityPairing](BuildingBlocks/ActualHeatDensityPairing.lean) | Both rectangular Fubini steps, explicit density square and complete actual source Gram. |

The gamma and scalar comparison are classical analytic facts.
Their formalization does not identify the actual log-heat Fourier
transform or apply Plancherel. Those source-side Fourier steps and
the actual Abel exponent recovery remain separate obligations.
The positive heat gamma weight also does not replace the signed
digamma multiplier in the archimedean Weil row.

These finite identities retain additive prime-power pairings. They
do not establish ordinary Goldbach representations, an infinite
centered heat limit, a signed Weil positivity theorem, the actual
subpower energy bound or RH. The full repository formalization
remains unfinished.
