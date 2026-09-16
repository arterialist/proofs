# The first late-prime Goldbach residual cancels exactly

**Status:** written analytic proof by RH Agent2, independently audited by RH Proof. The explicit secondary term and exact cancellation are unconditional; they do not establish an RH-scale bound.

Fix `1/2≤α<1`, a large horizon `X`, and `z=X^α`. Use the finite nonnegative coefficient channels from [the macroscopic rough Möbius–Goldbach note](macroscopic-rough-mobius-goldbach-channel.md):

`B_z(n)=Σ_{p>z,\,pm=n}Λ(m)`, `A_z(n)=Λ(n)+B_z(n)` for `n≤X`.

They satisfy `Λ=A_z−B_z` on the whole additive triangle `a+b≤X`, with every prime power retained. Write `h=log(1/α)` and `L=log X`.

## A universal first correction to the late-prime channel

For `z<x≤X`, reversing the sum gives

`B_z^Σ(x):=Σ_{n≤x}B_z(n)=Σ_{m≤x/z}Λ(m)[π(x/m)−π(z)]`.       (1)

Fix `K>3` and restrict for now to `X/L^K≤x≤X`. Uniform prime-number-theorem partial summation replaces `π` by `li` in (1) with error `O_{α,K,A}(x/L^(A−1))` for any fixed `A`: the `π(x/m)` errors sum using `Σ_{m≤x/z}Λ(m)/m=O(L)`, and the `π(z)` error is multiplied by `ψ(x/z)=O(x/z)`. For `Y=x/z`, the smooth endpoint function `f(u)=li(x/u)−li(z)` has `f(Y)=0`, so Abel summation gives exactly

`B_z^Σ(x)=x∫_1^Y ψ(u)/[u²(log x−log u)]du+O_{α,K,A}(x/L^(A−1))`. (2)

Put `E(u)=ψ(u)−u`. The contribution of `ψ(u)=u` is

`x∫_1^Y du/[u(log x−log u)]=x log(log x/log z)`.

Classical zero-free-region PNT gives `E(u)≪_B u/(log(2u))^B` for every fixed `B`, so every fixed logarithmic moment `∫_1^∞E(u)(log u)^j/u²du` converges absolutely. The Mellin identity

`∫_1^∞ψ(u)u^(−s−1)du=[−ζ'(s)/ζ(s)]/s` for `Re s>1`

and `−ζ'/ζ(s)=1/(s−1)−γ+O(s−1)` at `s=1` give

`∫_1^∞E(u)/u²du=−(1+γ)`.                           (3)

Expanding the denominator of the `E` integral in (2), with the endpoint `Y≥X^(1−α)/L^K`, gives uniformly

`B_z^Σ(x)=x log(log x/log z)−(1+γ)x/log x+O_{α,K}(x/L²)`. (4)

In particular,

`B_z^Σ(X)=hX−(1+γ)X/L+O_α(X/L²)`.                      (5)

For `x=θX`, `L^(−K)≤θ≤1`, formula (4) reads

`B_z^Σ(θX)/X=hθ+θ(log θ−1−γ)/L+O_{α,K}(θ(log L)²/L²)`. (6)

The omitted range `θ<L^(−K)` carries `O(X/L^K)` total `A_z` or `B_z` mass by `ψ(x)=O(x)` and `B_z^Σ(x)≪_α x`. Thus (6) gives a first-order weak-measure expansion on `[0,1]`:

`X^(−1)Σ_{n≤X}B_z(n)δ_{n/X}=h du+L^(−1)(log u−γ)du+o_{BL}(L^(−1))`,

`X^(−1)Σ_{n≤X}A_z(n)δ_{n/X}=(1+h)du+L^(−1)(log u−γ)du+o_{BL}(L^(−1))`. (7)

Here `o_{BL}` means that the cumulative-distribution error is `o(1/L)` uniformly, hence the same error against bounded-variation tests. The two channels have the *same* first correction. The second line uses the strong PNT for `ψ(θX)` on `θ≥L^(−K)`.

## Ordered Goldbach triangle and exact cancellation

Let `S_{CD}(X)=Σ_{a+b≤X}C(a)D(b)` for `C,D∈{A_z,B_z}`. Inserting (7) into the triangle, with the monotone cumulative of the other positive channel as test, yields an `o(X²/L)` error. Put

`J=∫_0^1(1-u)(log u−γ)du=−3/4−γ/2`.

The three channel asymptotics through their first residual are

`S_AA(X)=[(1+h)²/2+2(1+h)J/L+o(1/L)]X²`,

`S_AB(X)=[h(1+h)/2+(1+2h)J/L+o(1/L)]X²`,

`S_BB(X)=[h²/2+2hJ/L+o(1/L)]X²`.                    (8)

The `X²/L` coefficients satisfy `2(1+h)J−2(1+2h)J+2hJ=0`, just as the `X²` coefficients do. This is forced by the exact identity `Λ=A_z−B_z`, not an extra cancellation theorem for the actual Goldbach error.

To locate the surviving source, let `ν_X=Σ_{n≤X}Λ(n)δ_n`, let `λ` be Lebesgue measure on `[0,X]`, and set `η=ν_X−λ`. For the triangle form `Q_X(σ,τ)=∫_{u+v≤X}dσ(u)dτ(v)`, the exact centered identity is

`S_Λ(X)−X²/2=2Q_X(λ,η)+Q_X(η,η)`

`=2∫_0^X[ψ(u)−u]du+Q_X(η,η)`.                        (9)

If `β_z=ΣB_z(n)δ_n` and `ξ=β_z−hλ`, then `A_z` has measure `(1+h)λ+η+ξ`, while `B_z` has measure `hλ+ξ`. Expanding `Q_X(A_z−B_z,A_z−B_z)` cancels **every** occurrence of `ξ`, not only the first two asymptotic orders. Thus the late-prime packet theorem by itself cannot determine the sign or `X^(3/2+ε)` scale in the [one-sided cumulative Goldbach criterion](goldbach-one-sided-cumulative-rh-criterion.md); that scale lies in the centered complete-prime measure `η` and its self-convolution. A new arithmetic relation between `ξ` and `η` would be needed for the packet decomposition to help. Equation (9) is an exact obstruction to inferring the sign solely from the packet profile.

For scale calibration, RH would give `sup_{u≤X}|ψ(u)−u|=O_ε(X^(1/2+ε))`. Since the total variation of `η` on `[0,X]` is `O(X)`, both terms in (9) are then `O_ε(X^(3/2+ε))`. The unconditional packet asymptotic controls neither term separately; the one-sided bound on their **sum** is exactly the unresolved arithmetic input.

## The packet's exact causal range

There is an exact relation between the packet error and the centered prime history, but it points only toward earlier scales. With `h=log(1/α)` and `ξ([0,x])=B_z^Σ(x)−hx`, write `ψ(u)=u+E(u)` in the prime form of (1):

`ξ([0,x])=x[Σ_{z<p≤x}1/p−h]+Σ_{z<p≤x}E(x/p)` for `x≤X`. (10)

Every argument in the second sum satisfies `x/p≤X/z=X^(1−α)≤√X`. At `x=X`, the prime-harmonic bracket is smaller than any fixed inverse power of `log X` by the classical PNT error, while the dilation sum supplies the universal `−(1+γ)X/log X` term in (5). Equation (10) is a genuine source relation, but its packet side does not observe the newly arriving centered prime error at scales above `√X`.

One can make this information limit exact in an abstract nonnegative-coefficient model. Keep the coefficients `Λ(m)` unchanged for `m≤√X`, but add weight `Δ=X^β`, with any fixed `1/2<β<1`, at one integer `n₀∈(3X/4,4X/5)`. If the packet is defined by the same dilation rule `B_z(n)=Σ_{p>z,pm=n}Λ(m)`, then `B_z(n)` for every `n≤X` is unchanged, because its cofactor is at most `√X`. Yet the ordered additive triangle changes by

`2Δ ψ(X−n₀)=(2(1−n₀/X)+o(1))X^(1+β)`;

the self-pair `2n₀` lies above `X`. For any `ε<β−1/2`, this exceeds `X^(3/2+ε)` and is a countermodel to deducing an RH-scale Goldbach remainder from the packet data *alone*. To keep each new coefficient of logarithmic size, spread total weight `Δ` over `⌈X^β/log X⌉` integers in the same late interval, each with added weight at most `log X`; all pairwise sums of new support points still exceed `X`, and the total triangle change remains `Θ(X^(1+β))`. This is not a perturbation of the actual von Mangoldt function and makes no claim that actual arithmetic permits such independent changes. An additional relation coupling the early cofactor history to the late prime arrivals would be required.

The retrospective match to [de la Bretèche–Tenenbaum, Corollary 1.3](https://arxiv.org/pdf/2207.04777) in the completed-packet note is used only away from its integer-transition endpoint: for fixed `α>1/2`, `u=log x/log z<2`; at `α=1/2, x=X`, that paper requires a transition correction. Equations (1)–(6) use the direct PNT/Abel argument and do not rely on the transition formula.
