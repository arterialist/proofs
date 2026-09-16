# Critical-scale actual-ground collars along favorable core radii

*RH Agent2; independently audited by RH Proof, 2026-09-16. Written analysis, not Lean.*

Ordinary PNT, averaged over a short interval of core radii, supplies positive prime returns at the critical physical trial width `h_R=cR e^(−R)` along an unbounded sequence. The actual killed ground then concentrates in collars of any width `dR e^(−R)` with `d>2`, along a suitable unbounded sequence of radii. This reaches the coefficient `2` from above in a subsequential limit but does **not** reach the strict `<2` effective-width premise or prove RH. No pointwise prime theorem in intervals of length `√x log x` is assumed.

Fix `c>1`. Choose a nonnegative smooth `η∈C_c^∞(0,1)` with `||η||₂=1` and `M=(∫η)^2>1/c`; such shapes approximate the constant function in `L²(0,1)`. Put `H=η*η`, so `H≥0`, `supp H⊂[0,2]`, and `∫_0²H=M`. For `R` large let

`h(R)=cR e^(−R)`,

`g_R^tr(u)=h(R)^(−1/2)η((u−R)/h(R))`, `f_R^tr=g_R^tr+(g_R^tr)^∨`.

The exact opposite-half prime return of this **trial** is

`P^tr(R)=Σ_{n≥2}Λ(n)n^(−1/2)
             H((log n−2R)/h(R))`.                    (1)

The sum includes every prime power. Its density value is

`D^tr(R)=e^R h(R)(∫_0¹e^{h(R)y/2}η(y)dy)^2
          =(cM+o(1))R`,                              (2)

but (2) is not substituted pointwise for (1).

## PNT after averaging over core radius

Let `r→∞`, `Δ=1/r`, `x=e^(2r)`, and average (1) over `R∈[r,r+Δ]`. Only finitely many `n` occur, so exchange the sum and integral. An index can contribute only if

`x<n<x exp(2Δ+2h_max)`, `h_max=max_[r,r+Δ]h(R)∼cr e^(−r)`.

The two boundary bands of log length `O(h_max)` near `2r` and `2(r+Δ)` have at most `O(xh_max+1)` integers. Using `Λ(n)≤log n=O(r)` and `∫_r^{r+Δ}H((log n−2R)/h(R))dR=O_η(h_max)` shows their total contribution to `∫P^tr(R)dR` is `O_η(r√x h_max²+r h_max/√x)=o(1)`. This is a purely elementary boundary bound; it does not require prime counts in those tiny bands.

For each remaining interior `n`, set `v=(log n)/2`. The change of variable `y=(log n−2R)/h(R)` maps its full support in the averaging interval to `0≤y≤2`. Since `h'(R)=h(R)(1/R−1)`,

`|dR/dy|=h(R)/(2+y h'(R))=h(v)(1+O(h_max))/2`

uniformly. Hence

`∫_r^{r+Δ} n^(−1/2)H((log n−2R)/h(R))dR
  =(M+O_η(h_max))h(v)/(2√n)
  =(cM+o(1))v/(2n)`.                          (3)

The complete PNT `ψ_Ch(Y)=Y+O(Y exp(−a√log Y))`, with a harmless polynomial absorbed into `a>0`, gives by partial summation

`Σ_{x<n<xe^(2Δ)}Λ(n)/n=2Δ+o(Δ)`.             (4)

Removing the two boundary bands from (4) costs `o(Δ)` by the same elementary integer count. Also `v=r+O(Δ)`. Summing (3), using (4), and restoring the negligible boundaries gives

`(1/Δ)∫_r^{r+Δ}P^tr(R)dR=(cM+o(1))r`.       (5)

The finite continuous sum in (1) attains its maximum. Thus for every sufficiently large `r` there is a radius `R∈[r,r+1/r]` with

`P^tr(R)≥(cM−o(1))R`.                         (6)

This is an existence statement for favorable radii, not a pointwise short-interval prime theorem for all radii. It remains valid with every prime power because (4) uses the complete Chebyshev function.

## Negative trial and actual-ground concentration

The same-half prime return of `f_R^tr` vanishes for large `R` because `h(R)<log2`; the continuous opposite-half return is nonnegative. The fixed-shape Fourier scaling gives

`A[g_R^tr]=log(1/h(R))+O_η(1)=R−log R+O_η(1)`.  (7)

Since `cM>1`, equations (6)–(7) make the complete physical trial form `K[f_R^tr]=2A[g_R^tr]−2P^tr(R)−2C^tr(R)` at most `−ε R` for some `ε>0` at every selected radius. The actual exterior variational principle and `||f_R^tr/Φ||_ν²≤2ω(R+h(R))^(−2)` yield

`δ_R=1/2−α_R≥ε' R ω(R+h(R))²`.               (8)

Fix any `d>2`. Choose `c∈(1,d/2)` and then `η` with `M>1/c` as above. Put `T=R+L`, `L=dR e^(−R)`, for selected radii. The full two-endpoint crossing estimate and exterior restriction bound, retaining continuous and every prime-power edge, have respectively the exponential factors

`||B_(T;R)||/δ_R
 ≤exp{(π+o(1))e^(2R)(2h(R)−L)+O(R)}`,

`δ_T^sharp/δ_R
 ≤exp{−(2π+o(1))e^(2R)(L−h(R))+O(R)}`. (9)

Here the trial denominator uses the **actual support endpoint** `R+h(R)`. Because `d>2c`, both ratios in (9) tend to zero superexponentially on the selected radii; in particular `δ_T^sharp≤δ_R/2`. The exact hard-split ground equation then gives

`||ψ_R1_{|u|>T}||_ν
 ≤exp{−(π(d−2c)+o(1))R e^R}`.             (10)

The physical-mass conversion from the proved theta-ground concentration theorem remains valid here. Its lower mass cost is `exp(−C e^R)ω(T)`; the weighted theta tail above `T` supplies `ω(T)` times the normalized tail (10), up to `exp(O(R))`. Since `R e^R≫e^R`, for every fixed `B≥0`,

`∫_T^∞e^{B(u−R)}g_R(u)du / ∫_R^∞g_R(u)du→0` (11)

along these radii. Cauchy–Schwarz on `(R,T)` therefore gives the actual physical effective-width bound

`ℓ_R=(∫_R^∞g_R)^2/||g_R||₂²≤(d+o(1))R e^(−R)`. (12)

Thus, for every fixed `d>2` and every sufficiently large starting `r`, some `R∈[r,r+1/r]` satisfies (12). A diagonal choice `d_j↓2` yields an unbounded sequence with `limsup e^Rℓ_R/R≤2`.

There is a corresponding **threshold-scale actual prime-return corollary**. The previously proved actual-ground sign convolution and effective-width uncertainty give, for every fixed `0<θ<1`,

`P_R/H_R²≥[(1−θ)/4+o(1)]
                 log(1/ℓ_R)/(e^Rℓ_R)−o(1)`.

Because `ℓ_R≤(2+o(1))R e^(−R)` along the diagonal sequence and `log(1/ℓ)/ℓ` decreases for small `ℓ`, its last ratio has lower limit at least `1/2`. Letting `θ↓0` after taking the sequence lower limit proves

`liminf_(j→∞) P_(R_j)/H_(R_j)² ≥1/8`.       (13)

This width argument by itself reaches the threshold only from above. The [gap-or-collar dichotomy](theta-ground-first-order-gap-collar-dichotomy.md) uses the trial gap (8) and the actual ground mass to prove a strict sign-channel excess on favorable radii. Neither result establishes the full affine estimate or RH.
