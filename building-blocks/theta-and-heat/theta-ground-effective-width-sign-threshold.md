# An effective-width threshold for the actual ground sign channel

*RH Agent2; independently audited by the coordinating agent, 2026-09-16. The width threshold below is an unproved conditional premise.*

Use the actual positive-half killed-ground history `g_R=Φψ_R1_{u>R}` and `m_R=∫g_R`, `H_R=4∫sinh(u/2)g_R(u)du` from [the same-half suppression theorem](theta-ground-same-half-prime-suppression.md). Define its *physical effective width*

`ℓ_R=m_R²/||g_R||²₂`.

The proved concentration gives `0<ℓ_R≤(6+o(1))w_R→0`, where `w_R=e^(−√R/8)`. The weighted tail estimate at exponent `1/2`, together with `u=R+O(w_R)` on the near band, gives the sharper relation

`H_R=(2+o(1))e^(R/2)m_R`, hence `H_R²=(4+o(1))e^Rℓ_R||g_R||²₂`. (1)

For any fixed `0<θ<1`, positivity of `g_R` and unitary Fourier normalization give

`∫_{|ξ|≤T}|ĝ_R(ξ)|²dξ≤(T/π)m_R²`.

Take `T=θπ/ℓ_R`, so at most a fraction `θ` of its L² Fourier mass lies below `T`. The actual digamma symbol is increasing in `|ξ|` and satisfies `𝔞(T)=log T+O(1)`. Since `ℓ_R→0`,

`A[g_R]≥[(1−θ)𝔞(T)+θ𝔞(0)]||g_R||²₂
=[(1−θ)+o(1)]log(1/ℓ_R)||g_R||²₂`. (2)

The audited actual-ground identity and same-half estimate give

`P_R=A[g_R]+δ_R/2−o(H_R²)`, `δ_R=1/2−α_R>0`.

Combining with (1)–(2) yields, for every fixed `θ∈(0,1)`,

`P_R/H_R²≥[(1−θ)/4+o(1)] log(1/ℓ_R)/(e^Rℓ_R)−o(1)`. (3)

Consequently the concrete, unproved geometric premise

`limsup_{R→∞} e^Rℓ_R/log(1/ℓ_R)<2`             (4)

would imply `P_R/H_R²>1/8` eventually: choose `θ>0` small enough that the right side of (3) exceeds `1/8` by a fixed margin. This pays the **sign-channel** requirement `P_R≥H_R²/8−C_R`; it is not alone a proof of the full theta gap or RH.

The currently proved width `ℓ_R≤(6+o(1))e^(−√R/8)` does not establish (4). A width near `R e^(−R)` is the transition scale for this uncertainty argument; in arithmetic coordinates `x=e^(2R)` it corresponds to a window near `√x log x`. The statement isolates a precise source-specific concentration inequality to test against the full killed eigen-equation. It does not assume such localization or replace the actual prime source by density.
