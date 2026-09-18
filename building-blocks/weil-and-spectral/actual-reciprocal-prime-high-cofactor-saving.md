# A reciprocal-prime saving for high cofactors of an actual Weil packet

**Status:** independently audited written analytic proof, 18 September 2026.
The finite complex-weighted divisor identity and hard-cutoff rearrangement
are [Lean-compiled](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean);
the reciprocal-phase, packet, Poisson, and asymptotic estimates remain
written mathematics. The estimate retains the actual von Mangoldt function,
including prime powers, and uses the exactly pole-null compact packet from the
[critical-span construction](chirped-critical-span-constellation.md). It
controls one proper subrange of its signed prime row. Neither a full
prime-row bound nor RH follows. The
Vaughan/van der Corput mechanism is classical; no priority claim is made.
RH Agent 2 proposed the reciprocal-phase route; RH Proof independently
checked the bilinear exponents, sharp cutoff, packet rescaling, and divisor
transfer.

Write `e(t)=exp(2πit)` and let `||W||_{BV}=||W||_∞+Var(W)`. Functions of
bounded variation are extended by zero outside their stated compact annulus;
the variation counts endpoint jumps.

## Weighted reciprocal-phase estimate

**Lemma.** Fix `0<κ<1/2` and `0<c<C<∞`. For `D` sufficiently large,
`D^κ≤F≤D^(1−κ)`, either sign `ε∈{−1,1}`, and every complex BV weight
`W` supported in `[c,C]`,

\[
 \left|\sum_{n\ge1}\Lambda(n)W(n/D)e(\varepsilon FD/n)\right|
 \ll_{\kappa,c,C} D^{1-\kappa/40}\|W\|_{BV}.             \tag{1}
\]

In particular, (1) is uniform for a family of smooth weights whose BV norms
are uniformly bounded. The BV formulation also allows a sharp interval
cutoff in `n`; a smooth dyadic partition alone would not handle that cutoff.

**Proof.** Take `U=V=D^(κ/8)` in Vaughan's exact identity

\[
 \Lambda=\mu_{\le U}*\log
 -\mu_{\le U}*\Lambda_{\le V}*1
 +\mu_{>U}*\Lambda_{>V}*1+\Lambda_{\le V}.                \tag{2}
\]

The final term vanishes on `n∈[cD,CD]` for large `D`. In the first two
terms, group the short factors into `a≤UV=D^(κ/4)`. Their coefficients are
`O(τ(a)log D)=D^{o(1)}`; the remaining factor is either `1` or `log b`.
For `b∼B∼D/a`, the phase `f(b)=ε FD/(ab)` has
`|f''(b)|∼F/B²`. The second-derivative test, uniformly on every
subinterval of that dyadic block, gives

\[
 \sum_{b\in I}e(f(b))\ll\sqrt F+B/\sqrt F.               \tag{3}
\]

Abel summation pays `||W||_{BV}` for `W(ab/D)` and at most `log D` for
`log b`. Summing the short variable and the `O(log D)` blocks yields

\[
 |S_{\rm I}|\ll D^{o(1)}\|W\|_{BV}
   \left(D^{\kappa/4}\sqrt F+D/\sqrt F\right)
 \ll D^{1-\kappa/2+o(1)}\|W\|_{BV}.                           \tag{4}
\]

For the third term of (2), use the bilinear grouping
`μ_{>U}(a)(Λ_{>V}*1)(b)` and dyadic `ab∼D`. Both variables exceed
`D^(κ/8)` and both coefficients are `D^{o(1)}`. Orient them so
`A≥B`, `AB∼D`, `B≥D^(κ/8)`. Cauchy in `a` produces a diagonal
`O(D^{o(1)}||W||_{BV}² A²B)`. For `b₁≠b₂`, put
`h=|b₁−b₂|`; the phase in `a` is
`ε FD(1/b₁−1/b₂)/a`, with

\[
 |f''(a)|\asymp Fh/(BA²),\qquad
 \sum_{a\sim A}e(f(a))
 \ll \sqrt{Fh/B}+A\sqrt{B/(Fh)}.                              \tag{5}
\]

For fixed `b₁,b₂`, the product
`W(ab₁/D)\overline{W(ab₂/D)}` has variation at most
`2||W||_∞Var(W)` (with the harmless endpoint values included). Thus Abel
summation applies to (5), even when `W` has jumps. There are `O(B)` ordered
pairs for each `1≤h≪B`. Summing them gives

\[
 |S_{\rm II}|²\ll D^{o(1)}\|W\|_{BV}²
 \left(A²B+AB²\sqrt F+D²/\sqrt F\right),
\]

and hence

\[
 \frac{|S_{\rm II}|}{D\|W\|_{BV}}
 \ll D^{o(1)}\left(B^{-1/2}+F^{1/4}A^{-1/2}+F^{-1/4}\right)
 \ll D^{-\kappa/16+o(1)}.                                    \tag{6}
\]

Here `A≳D^(1/2)`, so the middle term is at most
`D^(−κ/4)`; the first uses `B≥D^(κ/8)`. Dyadic logarithms and the
divisor-bound `D^{o(1)}` fit inside the slack from `κ/16` to `κ/40`.
This proves (1). The exact Vaughan identity is recorded, for example, in
[Helfgott, *The ternary Goldbach problem*, §3.3.1](https://arxiv.org/pdf/1501.05438);
the uniform second-derivative test used in (3) and (5) is stated in
[Robert, *On van der Corput's k-th derivative test for exponential sums*, §3.1](https://perso.univ-st-etienne.fr/rool6510/robert-2015-indag.pdf).

## Exact pole-null divisor row

Fix the real bump `a∈C_c^∞((0,w))`, `0<w<log 2`, and
`0<η<1/(8w)` from the critical-span packet. Set

\[
 u_T(x)=a(x)e^{i\eta T x²-iTx},\qquad
 q_T=(\partial_x²-1/4)u_T/\|(\partial_x²-1/4)u_T\|_2,
\]

and define, for `N=T^λ`, `λ>2`, and `H=N/T`,

\[
 C_T(y)=\int q_T(x+y)\overline{q_T(x)}\,dx,\qquad
 g_N(x)=\begin{cases}x^{-1/2}C_T(\log(x/N)),&x>0,\\0,&x\le0.\end{cases}
\]

The packet is compact smooth and `E_{±1/2}(q_T)=0` exactly. For real `s`,

\[
 I_T(s):=\int e^{sy}C_T(y)\,dy
       =E_s(q_T)\overline{E_{-s}(q_T)}.
\]

Both factors vanish at `s=1/2`, so `I_T(1/2)=I_T'(1/2)=0`. After
`x=Ne^y`, this gives the two exact moment cancellations

\[
 \int_0^\infty g_N(x)\,dx=0,
 \qquad \int_0^\infty(\log x)g_N(x)\,dx=0.             \tag{7}
\]

Put `G_T(v)=√N g_N(N+Hv)`. It is uniformly Schwartz in `T`:
for every fixed `r,M≥0`,
`sup_v(1+|v|)^M|G_T^{(r)}(v)|≪_{r,M}1`. Here is the
uniformity check. Write `q_T(x)=e^{iηTx²-iTx}b_T(x)`; the critical-span
normalization proves that `b_T` has uniformly bounded derivatives of
every fixed order and fixed compact support. With `y=log(1+v/T)` and
`z=Ty`,

\[
 C_T(y)=e^{iηz²/T-iz}
       \int b_T(x+y)\overline{b_T(x)}e^{2iηxz}\,dx.
\]

Repeated integration by parts in `x` makes the internal integral and
all its fixed `y,z` derivatives `O_M((1+|z|)^(−M))`. On the support,
`|z|\asymp|v|`, `1+v/T` stays bounded away from zero, and every fixed
`v` derivative of `y`, `z`, and the outer phase is bounded. Multiplying
by `(1+v/T)^(−1/2)` proves the claimed Schwartz bounds. In particular,
the Fourier transforms `\widehat G_T` have uniform Schwartz bounds,
including derivatives.

Use `\widehat G(ξ)=\int G(v)e(−ξv)dv`. Poisson summation of the smooth
compactly supported `g_N`, with its zero mode killed by (7), is the exact
identity

\[
 \sum_{k\ge1}g_N(dk)
   =\frac{H}{d\sqrt N}\sum_{m\ne0}
      e(−mN/d)\widehat G_T(mH/d),\qquad d\ge1.             \tag{8}
\]

No prime power, cofactor, endpoint, or pole residue has been omitted.

## A saved high-cofactor subrange

**Theorem.** Fix `λ>2`, put `s=λ−1`, and choose

\[
 \kappa=\min\{1/(4s),(s-1)/(4s),1/8\},\quad
 \sigma=\kappa/40,\quad \delta=\sigma s/100.
\]

For the above packet and all sufficiently large `T`,

\[
 \boxed{\displaystyle
 \sum_{d\le HT^\delta}\Lambda(d)\sum_{k\ge1}g_N(dk)
 \ll_{\lambda,a,w,\eta}\frac{H}{\sqrt N}T^{-\sigma s/2}.}
                                                                  \tag{9}
\]

**Proof.** For `d≤H/T^δ`, (8), uniform Fourier decay, and Chebyshev's
`\psi(X)=\sum_{d≤X}\Lambda(d)\ll X` give, for every prescribed `B>0`,

\[
 \sum_{d\le H/T^\delta}\Lambda(d)
 \left|\sum_k g_N(dk)\right|\ll_B T^{-B}.              \tag{10}
\]

Indeed, for any `M>1`, the nonzero Fourier sum is
`O_M((d/H)^M)`, and the left side is
`O_M((H/√N)T^{-δM})`; choose `M` large.

On a dyadic block `d∼D=LH` in the remaining range,
`T^{-δ}\ll L\ll T^δ`, insert a smooth fixed annular partition and the
sharp restrictions on `d` into a BV weight in `u=d/D`. For each `m≠0`,
its weight, apart from `1/√N`, is

\[
 W_{m,L}(u)=\frac{\chi(u)}{Lu}
                   \widehat G_T\!\left(\frac{m}{Lu}\right).
\]

Uniform Fourier decay gives, for any fixed `M`,
`||W_{m,L}||_{BV}\ll_M L^{-1}(1+|m|/L)^{-M}`. The same holds after
either sharp restriction, because its endpoint jumps cost at most the
supremum of this smooth weight. Consequently

\[
 \sum_{m\ne0}\|W_{m,L}\|_{BV}\ll1                 \tag{11}
\]

uniformly for `T^{-δ}\ll L\ll T^δ`. Split at
`|m|≤LT^{2δ}`. The omitted modes contribute `O_B(T^{-B}D/√N)`
for any `B`, by taking enough Fourier decay in (11). For retained modes
the reciprocal parameter is
`F=|m|N/D=|m|T/L`, and
`T^{1-δ}\ll F\ll T^{1+2δ}`. The explicit choice of `κ,δ`
ensures

\[
 D^\kappa\le F\le D^{1-\kappa}                  \tag{12}
\]

for all large `T`: `κs≤1/4` gives a strict lower margin, while
`κs≤(s−1)/4` gives a strict upper margin. Apply (1) to each retained
mode and sum (11). This bounds the dyadic block by
`D^{1-σ}/√N` plus its negligible Fourier tail. Since
`D≤O(HT^δ)=O(T^{s+δ})`, summing `O(log T)` blocks gives

\[
 \frac{H}{\sqrt N}
   T^{\delta-\sigma(s+\delta)}\log T
 \ll \frac{H}{\sqrt N}T^{-\sigma s/2},
\]

which proves (9).

Finally, `\Lambda*1=\log` is an exact identity, not an asymptotic.
Equation (7) and one Euler-summation step give

\[
 \sum_{n\ge1}(\log n)g_N(n)
  =O\!\left(\int_0^\infty
          \left|\frac{d}{dx}\bigl((\log x)g_N(x)\bigr)\right|dx\right)
  =O(\log N/\sqrt N).                                  \tag{13}
\]

For large `T`, `HT^δ=o(N)` and lies below the support of `g_N`, so
`g_N(d)=0` when `d≤HT^δ`. Splitting the exact convolution sum at this
point therefore yields the *partial* reduction

\[
 \boxed{\displaystyle
 \sum_n\Lambda(n)g_N(n)
 =-\sum_{d>HT^\delta}\Lambda(d)\sum_{k\ge2}g_N(dk)
 +O\!\left(\frac{H}{\sqrt N}T^{-\sigma s/2}
               +\frac{\log N}{\sqrt N}\right).}        \tag{14}
\]

The [finite Lean theorem](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean)
proves the algebra of (14) for arbitrary complex weights and a literal hard
cutoff, assuming the weight vanishes below it. Choosing a finite horizon
beyond the compact support of `g_N` gives the displayed identity. The Lean
theorem does not prove (7), (8), (9), or the Euler error (13).

The `k=2` term on the right is still a signed prime correlation centered
at `N/2`. Its available absolute bound is `O(H/√N)`: the supporting
correlation decays outside width `O(H)`, and dyadic distance shells
combined with the all-prime-power short-interval Mangoldt bound in the
[Brun–Titchmarsh packet argument](chirped-brun-titchmarsh-span-constellation.md#short-interval-mass-with-all-prime-powers)
sum to `O(H)` since `H=N/T≫√N` for `λ>2`. This is the original row scale.
Equation (9) may itself exceed an `O(log T)` Weil budget because
`H/√N=T^{λ/2-1}`. Thus (14) isolates a genuine power saving for large
cofactors but does not close the required pointwise signed estimate.
