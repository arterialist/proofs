# Euler-prime phase winding defeats every fixed positive xi shift

[Conrey–Li](https://arxiv.org/pdf/math/9812166), §3.1, found `Re[ξ(1+282i)/ξ(2+282i)]<0`, refuting the uncorrected `+1` de Branges/Pick positivity test. Their closing remark records Sarnak's nonnumerical phase argument for that test in `Re s>1/2`. The calculation below keeps the complete Euler product, works **inside `Re s>1`**, and applies to **every fixed real shift `c>0`**. It is an obstruction to this uncorrected shift test, not an RH result or a novelty claim.

**Claim.** For each fixed `c>0`, there is `σ_c>1` such that, for every `1<σ≤σ_c`, the set

`{t≥0 : Re[ξ(σ+it)/ξ(σ+c+it)]<0}`                         (0)

has positive lower asymptotic density. In particular, it contains arbitrarily large `t`.

Use `ξ(s)=s(s−1)π^(−s/2)Γ(s/2)ζ(s)/2`. For `Re s>1`, write

`ξ(s)/ξ(s+c)=A_c(s) Z_c(s)`,

`A_c(s)=π^(c/2) [s(s−1)/((s+c)(s+c−1))] Γ(s/2)/Γ((s+c)/2)`,

`Z_c(s)=ζ(s)/ζ(s+c)`.

Both zeta factors are nonzero there. Their absolutely convergent Euler logarithms give, retaining every prime power,

`log Z_c(s)=Σ_p Σ_{k≥1} [(1−p^(−kc))/k] p^(−ks)`.           (1)

Put `C_{≥2}(c)=Σ_pΣ_{k≥2}[(1−p^(−kc))/k]p^(−k)<∞`. For fixed `c>0`,

`B_c(σ):=Σ_p(1−p^(−c))p^(−σ)→∞` as `σ↓1`,             (2)

because `Σ_p 1/p` diverges whereas `Σ_p p^(−1−c)` converges. Let `θ_c=π+cπ/4` and choose `η=1/20`. For every `σ>1` sufficiently close to one, choose a finite prime cutoff `P=P(c,σ)` such that

`S_{c,σ,P}:=Σ_{p≤P}(1−p^(−c))p^(−σ)>θ_c+C_{≥2}(c)+2`,

`T_{c,σ,P}:=Σ_{p>P}Σ_{k≥1}[(1−p^(−kc))/k]p^(−kσ)<η`.       (3)

These conditions are compatible: (2) makes the complete first-prime sum larger than the displayed threshold, while the complete Euler logarithm has a vanishing tail for each fixed `σ>1`.

For phase vectors `φ=(φ_p)_{p≤P}` on the finite prime torus, define

`H(φ)=Im Σ_{p≤P}Σ_{k≥1}[(1−p^(−kc))/k]p^(−kσ)e^(ikφ_p)`.

On the diagonal `φ_p=λ`, the continuous function `h(λ)=H((λ)_p)` satisfies `h(0)=0` and

`h(π/2)≥S_{c,σ,P}−C_{≥2}(c)>θ_c+2`.

The `k=1` terms contribute exactly `S_{c,σ,P}` at `λ=π/2`; the remaining terms have total absolute value at most `C_{≥2}(c)`. By the intermediate value theorem, some `λ₀∈(0,π/2)` has `h(λ₀)=θ_c`. By continuity one may choose a small nonempty product box `U` about `(λ₀)_p`, with Haar-null boundary, such that `|H(φ)−θ_c|<η` for all `φ∈U`.

Unique factorization makes `{log p:p≤P}` linearly independent over the rationals. Weyl's criterion therefore gives equidistribution of `t↦(−t log p mod 2π)_{p≤P}` on this torus. In particular, the set of `t≥0` whose prime phase vector enters `U` has positive asymptotic density. For all such `t`, (3) bounds the omitted complete-prime-power contribution to `Im log Z_c(σ+it)` by `η`, so

`|Im log Z_c(σ+it)−θ_c|<2η`.                          (4)

Stirling's ratio asymptotic, with `c` and `σ` fixed, yields

`A_c(σ+it)=π^(c/2)((σ+it)/2)^(−c/2)(1+O_{c,σ}(1/t))`.

The rational factor in `A_c` is included in the `1+O(1/t)` term. Hence a continuous argument of `A_c(σ+it)` tends to `−cπ/4` as `t→+∞`. After discarding a finite initial interval, its error is below `η`. Combining this with (4), the ratio's argument lies within `3η<π/2` of

`θ_c−cπ/4=π` modulo `2π`.

Thus its real part is negative on a positive-lower-density set of arbitrarily large `t`, proving the claim. The finite-prime equidistribution gives the density strengthening; mere Kronecker recurrence would already give unbounded examples.

The exact source of the obstruction is the first-prime channel. In (1), the `k≥2` sum converges absolutely and defines a holomorphic function throughout `Re s>1/2`; its size remains bounded as `σ↓1`. By contrast, the first-prime sum in (2) supplies arbitrarily much phase budget. Cancelling that phase in `Re s>1` by a factor built from the first-prime sum is formal, but extending such a correction into the critical strip with the needed zero control is a separate arithmetic problem. This theorem only rules out a direct, uncorrected positive-real condition on `ξ(s)/ξ(s+c)` for a fixed positive shift. It does not rule out a differently normalized spectral observable or a genuinely source-specific compensator, and it supplies no RH-scale bound.
