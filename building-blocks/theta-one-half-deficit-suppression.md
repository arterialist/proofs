# The one-half-line theta deficit is negligible beside the even ground gap

This note proves an **all-radius spectral separation** for the actual killed theta operator. Let `α_R` be its even two-half-line ground eigenvalue, `β_R` the bottom of its positive-half-line killed restriction, and `λ=1/2`. Both lie below `λ` for every finite radius. Nevertheless, as `R→∞`,

`0<λ−β_R ≤ δ_R exp(−κe^{2R})`, `δ_R=λ−α_R`,             (1)

for some absolute `κ>0` and all sufficiently large `R`. Hence

`β_R−α_R≥δ_R[1−exp(−κe^{2R})]`.                         (2)

The claim retains the complete archimedean multiplier, same-half prime powers, boundary killing, and the two-half-line prime trial. It does not bound `δ_R/H_R²`, the full affine covariance residual, or RH.

## The one-half-line form and its ground

The [threshold-index transport theorem](theta-exterior-threshold-index-transport.md) proves `β_R<λ` for each finite `R`: a compact negative physical test can be translated into the positive far half-line, with exact prime-power translation invariance and the true theta norm. The essential-spectrum lower bound makes `β_R` an isolated eigenvalue. The modulus contraction of the killed jump form supplies a nonnegative ground eigenfunction; strict positivity or simplicity is not needed below. Denote a normalized choice by `ϕ_R∈L²((R,∞),ν)`. Its physical history `g_R=Φϕ_R` lies in `L¹∩L²` and the logarithmic form domain. Normalize `||ϕ_R||_ν=1`, and put `q_R=||g_R||₂²`, `m_R=∫_R^∞g_R`, `ℓ_R=m_R²/q_R`.

The exact physical threshold identity [Eq. (11.1) of the Weil jump form](theta-weil-jump-form.md) applies to every full form-domain function. Extend `ϕ_R` by zero outside the positive half-line; then every prime autocorrelation whose endpoints lie on opposite halves vanishes. Its identity is therefore

`β_R−λ=A[g_R]−S_same[g_R]`,                       (3)

where `A` is the actual digamma multiplier and `S_same` is the complete same-half prime-power return. Core and opposite-half departures remain in the killed generator and are already accounted for by the full physical identity; no crossing arrival is included in `S_same` because the test vanishes on the other half.

## Uniform same-half prime ceiling and a Fourier-width split

The operator estimate underlying [same-half prime suppression](theta-ground-same-half-prime-suppression.md), equation (3), uses only normalized theta mass and support, not the two-half-line ground equation. Thus it applies to `ϕ_R` and gives

`0≤S_same[g_R]≤ε_R`,

`ε_R=C e^{5R}exp[−(5π/2)e^{2R}]+C e^{5R}exp[−4πe^{2R}]`. (4)

Indeed split at `U=R+log2`. The near/near prime block vanishes because every prime-power shift has length at least `log2`; the near/far and far/far block norms from the complete exterior prime operator have the two displayed exponents. Cauchy–Schwarz bounds their quadratic pairings using only `||ϕ_R||_ν=1`. No pointwise bound on this new half-line ground is needed for (4).

The first coefficient may be enlarged to absorb the one-half-line normalization. Choose once and for all `a>0` with `a<1/10` so small that the nonnegative Fourier low-mass argument in the [effective-width theorem](theta-ground-effective-width-sign-threshold.md) gives

`A[g]/||g||₂²≥1` whenever `g≥0` and `(∫g)²/||g||₂²≤4a`. (5)

The argument applies to any nonnegative `g∈L¹∩L²` in the form domain, not only the two-half-line ground: `|ĝ(ξ)|≤m/√(2π)` gives spectral mass at most `(T/π)m²` on `|ξ|≤T`. At `T=π/(2ℓ)`, at least half the mass has symbol value at least `𝔞(T)`, and the other half has value at least `𝔞(0)`; their average tends to infinity as `ℓ↓0`. Thus such a fixed `a` exists. There are two cases.

* If `ℓ_R≤4a`, then (3), `β_R<λ`, and (5) imply `q_R≤S_same[g_R]≤ε_R`.
* If `ℓ_R>4a`, Cauchy–Schwarz on `(R,R+a)` gives `∫_R^{R+a}g_R≤√(a q_R)`, whereas `m_R>2√(a q_R)`. Hence `∫_{R+a}^∞g_R≥√(a q_R)`. Since `g_R=ω(ϕ_R√{bΦ})` and `||ϕ_R||_ν=1`, another Cauchy–Schwarz inequality gives

  `q_R≤a^(−1)∫_{R+a}^∞ω(u)²du`.               (6)

In either case, `q_R≤ε_R+a^(−1)∫_{R+a}^∞ω²`. The actual digamma symbol has a finite lower value `𝔞(0)<0`, so `A[g_R]≥𝔞(0)q_R`. Equation (3) now yields

`0<λ−β_R=S_same[g_R]−A[g_R]
             ≤(1+|𝔞(0)|)ε_R+(|𝔞(0)|/a)∫_{R+a}^∞ω²`. (7)

The two-sided first-theta envelope gives `ω(u)²≍e^{4u}exp[−πe^{2u}]` for large `u`; elementary endpoint integration therefore bounds the last integral by `exp[−πe^{2(R+a)}+O(R)]`. Since `a<1/10` ensures `e^{2a}<5/2`, equation (4) is smaller, and

`λ−β_R≤exp[−πe^{2a}e^{2R}+O(R)]`.           (8)

## Comparison with the actual even gap

The established unconditional [shrinking even trial](theta-shrinking-even-negative-trial.md) gives, for `w_R=exp(−√R/8)`,

`δ_R≥(5/24)e^Rw_Rω(R+2w_R)²
     ≥exp[−πe^{2R}(1+o(1))]`.                  (9)

Dividing (8) by (9) proves (1) for any fixed `0<κ<π(e^{2a}−1)`, after increasing the starting radius. Equation (2) follows from `β_R−α_R=δ_R−(λ−β_R)`.

Let `ψ_R` be the normalized even two-half-line ground, and put `φ=√2 ψ_R1_{u>R}`. The positive-half diagonal compression `D_{+,R}` includes every outgoing holding and core killing; the bounded opposite-half arrival `B_R^×` includes the continuous kernel and all prime powers. Reflection of the exact ground equation gives `(D_{+,R}−α_R)φ=B_R^×φ`. By the [sign-convolution identity](theta-ground-sign-prime-convolution.md), `⟨φ,B_R^×φ⟩=2(C_R+P_R)`. The variational definition of `β_R` therefore gives

`C_R+P_R≥(β_R−α_R)/2≥(1−e^{−κe^{2R}})δ_R/2`. (10)

This is an all-radius lower bound on complete opposite-half arrival **relative to the actual eigenvalue distance**. It does not pay the pole normalization `H_R²`. A further source-specific comparison of `δ_R` with `H_R²`, or of the complete cross profile with the odd affine source, remains necessary.
