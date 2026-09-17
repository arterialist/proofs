# A moving arithmetic-gap arrival inequality for the actual killed ground

*RH Agent2; independently audited by the coordinating agent, 2026-09-16. This is an unconditional actual-ground incoming-energy inequality, not an RH proof.*

This note quantifies what the full killed eigen-equation forces when the actual physical ground places mass in one logarithmic gap between consecutive integers. It keeps every prime power, the signed killing term, and the archimedean crossing at the artificial gap boundary. The conclusion is a lower bound on *incoming prime energy*, not a bound on the outside mass or the full RH sign channel.

Use the actual normalized even positive exterior ground `ψ_R`, its physical history `G_R=Φψ_R1_{|u|>R}`, and `δ_R=1/2−α_R>0`. Its weak exterior equation is

`A G_R=S G_R−δ_R JG_R`, `J=b_θ/Φ`,                       (1)

where `S` is the complete `Σ_{n≥2}Λ(n)n^(−1/2)` translation operator. Let `t_R=R e^(−R)` and choose an integer `N_R` nearest `e^(2(R+t_R))`. Put

`u_R=(log N_R+log(N_R+1))/4`,

`ε_R=(log(N_R+1)−log N_R)/16`,

`I_R=(u_R−ε_R,u_R+ε_R) ∪ (−u_R−ε_R,−u_R+ε_R)`.

Then `u_R=R+t_R+O(e^(−2R))`, `ε_R≍e^(−2R)`, and the positive and negative components of `I_R` lie outside the core for large `R`. The sum of any two positive coordinates in `I_R` lies strictly between `log N_R` and `log(N_R+1)`. Hence no prime-power displacement connects the two components. Same-half displacements cannot connect points within one component because its diameter is below `log2`.

Define the hard pieces `F_R=1_{I_R}G_R` and `Q_R=G_R−F_R`. The proved hard-interval form localization applies to these two moving intervals at each fixed `R`. Their supports are disjoint up to endpoints, and the complete self-prime sample is exactly

`⟨F_R,SF_R⟩=0`.                                            (2)

All terms in `⟨F_R,S Q_R⟩` are nonnegative. More explicitly it is the absolutely defined form pairing

`Σ_{n≥2} Λ(n)n^(−1/2) ∫_{I_R}F_R(u)[Q_R(u+log n)+Q_R(u−log n)]du`.

The endpoints of the gap cause no omitted prime-power atom: the self-test vanishes there almost everywhere.

## Archimedean cost and the exact incoming requirement

The support measure of `F_R` is `4ε_R`. With unitary Fourier normalization, `|F̂_R(ξ)|²≤(2ε_R/π)||F_R||₂²`. Thus the Fourier mass on `|ξ|≤π/(16ε_R)` is at most one quarter of `||F_R||₂²`. The digamma multiplier `𝔞(ξ)` is increasing in `|ξ|` and satisfies `𝔞(T)=log T+O(1)`. Since `log(1/ε_R)=2R+O(1)`, there is a fixed `C_A` such that

`⟨F_R,AF_R⟩ ≥ (3R/2−C_A)||F_R||₂²`.                    (3)

For a single interval, `||[A,1_I]||≤2π`. Here is the complete bound: the jump representation of `A` has off-diagonal kernel `−r(|u−v|)`, where `r(s)=e^(−s/2)/(1−e^(−2s))≤1/s`. For a half-line indicator, the commutator has only two off-diagonal blocks; after translating the boundary and reflecting one side, each is dominated by the Carleman kernel `1/(x+y)`, whose `L²(0,∞)` norm is `π`. The half-line commutator norm is at most `π`. An interval indicator is a difference of two half-line indicators, hence its commutator norm is at most `2π`. The union `I_R` of two intervals therefore has `||[A,1_{I_R}]||≤4π` by the triangle inequality. This same bounded form crossing justifies hard projection of `G_R` into the logarithmic form domain. Because `F_R` and `Q_R` are disjoint,

`|⟨F_R,A Q_R⟩|≤4π||F_R||₂||Q_R||₂`.                     (4)

One way to justify (4) without assuming `Q_R∈D(A)` globally is to use the bounded commutator as a form crossing: the diagonal part of `[A,1_{I_R}]` has zero pairing with `F_R`, and its off-diagonal block is precisely the cross form. The ground and its hard pieces belong to the logarithmic form domain.

Test (1) by `F_R`, use (2), and retain the killing term. Equations (3)–(4) give the **actual-source inequality**

`⟨F_R,S Q_R⟩ ≥ (3R/2−C_A)||F_R||₂²
                     −4π||F_R||₂||Q_R||₂
                     +δ_R∫_{I_R}J F_R²`.                    (5)

For example, if `||Q_R||₂≤||F_R||₂`, then for sufficiently large `R`

`⟨F_R,S Q_R⟩ ≥ R||F_R||₂²`.                              (6)

This is a relative prime-arrival requirement at the arithmetic gap scale. The archimedean crossing cannot by itself pay a cost proportional to `R` when the outside physical `L²` mass is at most the gap mass. Equation (5) is stronger than simply saying that a compact one-gap bump is not an eigenfunction: it quantifies the missing incoming source for any actual ground restriction.

There is a further explicit leakage dichotomy. Fix `β<19/20`, let `w=e^(−βR)`, `L=6w<log2`, and split `Q_R=Q_near+Q_far` at the symmetric collar `R<|u|<R+L`. The whole of `I_R` lies inside this collar for large `R`. No same-half prime displacement fits inside it. The opposite-half sum uses only `e^(2R)<n<e^(2R+2L)`. Therefore translation Cauchy–Schwarz gives

`⟨F_R,S Q_near⟩ ≤ 2W_(R,L)||F_R||₂||Q_near||₂`,

`W_(R,L)=Σ_{e^(2R)<n<e^(2R+2L)}Λ(n)n^(−1/2)
          ≤32R e^R L+4R e^(−R)`.                           (7)

For the last inequality, use `Λ(n)≤log n≤2(R+L)`, `n^(−1/2)≤e^(−R)`, and at most `e^(2R)(e^(2L)−1)+1` integers in the interval. Since `R≥1`, `L<log2`, `e^(2L)−1≤2Le^(2L)≤8L`, and `R+L≤2R`, the displayed bound follows with the deliberately loose constant `32`. Thus all powers and interval endpoints remain covered. If `||Q_R||₂≤||F_R||₂` and the far prime arrival is less than `(R/2)||F_R||₂²`, then (6)–(7) imply

`||Q_near||₂/||F_R||₂ ≥ R/(4W_(R,L))
                         ≥ c exp(−(1−β)R)`                  (8)

for a fixed positive `c` and all large `R`. Thus either the far complete-prime arrival alone carries at least half the required `R`-scale energy, or the ground has a quantified amount of physical `L²` mass outside the gap but within the BHP collar. The lower bound in (8) decays and does not control `P_R/H_R²` by itself.

## Why the new power-scale collar does not resolve this source

The center `u_R−R≈R e^(−R)` is inside every fixed power-scale collar `R+6e^(−βR)`, `β<19/20`, from [the Baker–Harman–Pintz concentration result](theta-ground-power-scale-prime-concentration.md). A smooth comparison bump of width `ε_R` centered there has zero prime self-sample and archimedean cost `O(R)` times its physical norm. It therefore still satisfies the *coarse* collar and relative logarithmic-energy bounds after theta normalization. The actual equation rejects exact one-gap support by (5), but these bounds alone do not quantify its outside mass.

To see the specific normalization loss, set `w=e^(−βR)` and `T=R+6w`. The sharper proved ground tail after this collar has `ν`-norm at most `Cw^(−1)exp(−2πe^(2R)w)`. Across the collar the physical conversion factor changes by

`log[ω(R)²/ω(R+6e^(−βR))²]
   =(12π+o(1))e^(2R)e^(−βR)`.

More directly, the all-power theta crossing estimate between `O_T` and the inner exterior is at most `C exp(O(R))exp[−π(e^(2R)+e^(2T))/2]`. Multiplying by the proved `ν`-tail and dividing by the available physical lower norm `||G_R||₂²≥cω(T)²` gives an upper estimate with exponential factor

`exp{(π/2)(e^(2T)−e^(2R))−2πe^(2R)w}
 = exp{(4π+o(1))e^(2R)w}`.

It grows, so this operator-norm route cannot make the far prime-arrival term in (5) small relative to physical mass, even if `F_R` carries a fixed fraction of that mass. This is an obstruction to that *specific* normalization step, not evidence that the far arrival actually dominates. A proof of the effective-width sign premise needs a stronger source comparison or a signed cancellation that controls this complete arrival term at the physical normalization.
