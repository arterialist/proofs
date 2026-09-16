# Actual ground concentration suppresses its same-half prime energy

*RH Agent2; independently audited by the coordinating agent, 2026-09-16. This is an unconditional source-specific estimate, not an RH proof.*

Use the actual normalized even killed ground `ψ_R` and positive-half physical history `g_R=Φψ_R1_{u>R}` from [the sign-prime convolution](theta-ground-sign-prime-convolution.md). Let `w_R=e^(−√R/8)`, `T_R=R+6w_R`, and `U_R=R+log2`. Write `m_R=∫_R^∞g_R`, `H_R=4∫_R^∞sinh(u/2)g_R(u)du`, and let `A` and `S` denote the full physical archimedean and prime forms. These are the actual ground quantities, not a comparison profile.

The [physical mass concentration theorem](theta-ground-physical-mass-concentration.md) proves that the physical mass outside `T_R` is `o(m_R)`, and gives

`m_R≥c e^(−C e^R)ω(T_R)`, `ω²=Φ/b≍e^(4u)e^(−πe^(2u))` for large `u`. (1)

It also proves the complete normalized prime-operator bounds, for `U>R`,

`||1_{O_U}K_p1_{O_R\O_U}||≤C e^(2R+3U)exp[−π(e^(2R)+e^(2U))/2]`,

`||1_{O_U}K_p1_{O_U}||≤C e^(5U)exp[−πe^(2U)]`. (2)

Every integer prime-power shift has length at least `log2`. Thus the positive-half restriction of the complete prime form has **zero** overlap between two points of `(R,U_R)`; equality at the endpoint contributes no Lebesgue mass. Decompose the normalized ground vector into this near band and its far complement. Cauchy--Schwarz for the two operator blocks in (2), with `U=U_R` and ground norm one, bounds the entire positive-half same-side sample by

`0≤S_same(R):=2Σ_{n≥2}Λ(n)n^(−1/2)∫_R^∞g_R(u)g_R(u+log n)du`

`≤C e^(5R)exp[−(5π/2)e^(2R)]+C e^(5R)exp[−4πe^(2R)]`. (3)

No power or orientation has been dropped. On the other hand `H_R≥2(e^(R/2)−e^(−R/2))m_R`, so (1) gives

`H_R²≥c e^R e^(−2Ce^R)ω(T_R)²`. (4)

Since `e^(2T_R)=e^(2R)e^(12w_R)=(1+o(1))e^(2R)`, comparison of the exponents in (3)–(4) yields the actual relative estimate

`S_same(R)/H_R²≤exp[−(3π/2+o(1))e^(2R)]→0`. (5)

The same concentration also forces positive archimedean energy on `g_R`. The near physical mass lies in an interval of length `6w_R`; hence `m_R≤(1+o(1))√(6w_R)||g_R||₂`. In unitary Fourier normalization,

`∫_{|ξ|≤T}|ĝ_R(ξ)|²dξ≤(T/π)m_R²`.

Choose `T=π/(48w_R)`. At most `(1/8+o(1))||g_R||²₂` lies below that frequency. The actual digamma symbol `𝔞(ξ)` is increasing in `|ξ|`, has finite minimum `𝔞(0)`, and tends to `+∞` like `log|ξ|`. Therefore

`A[g_R]≥[(1/8+o(1))𝔞(0)+(7/8−o(1))𝔞(T)]||g_R||²₂>0` (6)

for all sufficiently large `R`. In particular exact ground concentration excludes a pure low-frequency positive-half history; this uses the actual physical mass bound, not a generic support assertion.

The exact ground identity in the linked sign-prime theorem is

`P_R=A[g_R]−S_same(R)+(1/2)δ_R−C_R`,

where `δ_R=1/2−α_R>0`, `P_R` is the complete opposite-half prime sample, and `C_R` is the positive continuous cross term. Its established bound `C_R/H_R²=O(e^(−2R))` and (5) yield

`P_R=A[g_R]+δ_R/2−o(H_R²)`.                 (7)

Consequently the sign-channel target `P_R≥H_R²/8−C_R` reduces, up to a vanishing relative error, to the explicit scalar comparison

`A[g_R]+δ_R/2 ≥ (1/8+o(1))H_R²`.          (8)

Equations (5)–(7) are unconditional actual-ground estimates, but (8) is **not proved**. The uncertainty argument supplies `A[g_R]≫log(1/w_R)||g_R||²₂`. The weighted version of the concentration theorem, with exponential weight `B=1/2`, gives `H_R≤(2+o(1))e^(R/2+3w_R)m_R`, hence `H_R²≪e^Rw_R||g_R||²₂` by the same near-mass Cauchy estimate. As (3)–(4) make `S_same(R)/H_R²` superexponentially small, and the linked continuous bound gives `C_R/H_R²=O(e^(−2R))`, both errors are smaller than `log(1/w_R)/(e^Rw_R)`. Equation (7) therefore proves the quantitative actual-ground lower bound

`P_R/H_R² ≫ log(1/w_R)/(e^Rw_R)
= (√R/8)e^(−R+√R/8)`.                    (9)

This is a **relative** prime-arrival bound derived from the full ground equation and complete arithmetic shifts, but it tends to zero; the required sign channel asks for `P_R/H_R²≥1/8−o(1)`. The new bound rules out exact or excessively severe prime-gap avoidance by the actual ground. It does not pay the fixed pole normalization. A stronger source-specific comparison between archimedean energy, eigenvalue distance and odd pole mass is still needed.

The width calculation identifies the limit of this particular uncertainty argument. Replacing `w_R` by a hypothetical narrower proved concentration width `w`, its guaranteed ratio would still have size only `log(1/w)/(e^Rw)`. A fixed lower bound from that chain would require roughly `w≲R e^(−R)`. At the corresponding arithmetic scale `x=e^(2R)`, this is a window of length `xw≲√x log x`. The present proven `w_R=e^(−√R/8)` is vastly broader. This is a requirement of the **method**, not a claim that the actual ground has such a width or that a short-interval prime bound alone proves the sign channel.
