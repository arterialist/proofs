# Complete actual-prime Weil positivity for every pair of causal ramps

**Status:** independently audited written analytic proof (18 September
2026), developed by RH Agents 2 and 3 and checked by RH Agent 1. This
is an unconditional restricted-cone result for the complete Weil form.
It is not an RH criterion. All prime-power endpoints, both poles, and
the gamma factor are retained. The analytic proof and interval
certificates are not Lean formalized. No literature-priority claim is
made for the all-length ramp cross sign.

Let `f_L(x)=e^{-x/2}1_[0,L](x)` for `L>0`. For every `L,M>0`,

\[
\boxed{Q(f_L,f_M)>0.0024\min\{L,M,1\}>0.}                 \tag{1}
\]

Consequently every nonzero finite positive Borel measure `mu` with
compact support in `(0,infinity)` gives a mixture
`f_mu=int f_L mu(dL)=e^{-x/2}h(x)1_{x>=0}` with
`h(x)=mu([x,infinity))`, satisfying

\[
Q(f_\mu)>0.0024\iint\min\{L,M,1\}\,\mu(dL)\mu(dM)
       =0.0024\int_0^1 h(t)^2\,dt>0.                 \tag{2}
\]

This is an infinite-dimensional cone with unbounded allowable support
as the measure varies. No positivity for signed mixtures or arbitrary
compact tests is asserted.
The equality in (2) follows from
`min(L,M,1)=int_0^1 1_{t<=L}1_{t<=M}dt` and Tonelli; it gives
quantitative coercivity on this cone of nonnegative nonincreasing
compact profiles.
For any fixed compact support of `mu`, the ramp Fourier transforms
obey `|hat f_L(t)|<=2/sqrt(t^2+1/4)` uniformly in `L`, so their gamma
forms admit bilinear integration under the finite measure. The pole
and finitely many admitted prime-shift forms are bounded on that
common support. Thus (2) holds on the logarithmic form-domain
extension, and its positive values persist under sufficiently close
smooth compactly supported approximation.

## Exact identities

Assume `L<=M`, put `Delta=M-L`,
`H(y)=log y-sum_{n<=y} Lambda(n)/n`, and `gamma=EulerGamma`. Exact
Stieltjes polarization yields

\[
R(L,M)=e^{-L}\int_0^L e^uH(e^u)du
       +e^{-M}\int_{M-L}^{M}e^uH(e^u)du.                \tag{3}
\]

At an outer support endpoint, each oriented ramp correlation vanishes;
the internal transition at `u=Delta` is continuous and may have
nonzero prime weight. Formula (3) keeps the inclusive
prime-power convention at that transition. Define

\[
T(u)=\sum_{n\ge0}\frac{e^{-(2n+3)u}}{(2n+2)(2n+3)},\quad
S=T(0)=1-\log2,\quad C=1-\gamma-\log(2\pi)<0.       \tag{4}
\]

For `u>0`, with `q=e^{-u}`,
`T(u)=q-atanh(q)-(q/2)log(1-q^2)`.
The digamma Fourier kernel gives the exact gamma cross

\[
G(L,M)=C(1-e^{-L})+S-T(L)
       +e^{-L}[T(\Delta)-e^L T(\Delta+L)].            \tag{5}
\]

The last bracket is strictly positive for finite `M`; each term is
`d_n(1-e^{-(2n+2)L})e^{-(2n+3)Delta}`. Write the first three terms
of (5) as `G_inf(L)`. Then `G(L,M)>G_inf(L)>g0`, where
`g0=C+S=2-gamma-log(4pi)`.

## Certified covering of the parameter plane

The following five bounds overlap at their boundaries and cover all
`0<L<=M`:

| Region | Certified bound | Certificate |
|---|---:|---|
| `0<L<=2/25`, any `M>=L` | `Q>0.02647 L` | [Short-ramp proof](complete-weil-cross-sign-for-one-short-causal-ramp.md), [Arb scalar certificate](../../certificates/mixed_ramp_small_length_certificate.py) |
| `2/25<=L<=7`, `0<=Delta<=6` | `Q>0.005` | [Middle-box Arb certificate](../../certificates/mixed_ramp_middle_arb_certificate.py), explained below |
| `2/25<=L<=7`, `Delta>=6` | `Q>0.0050526` | [Transition proof](certified-mixed-ramp-transition-regions.md), [tail certificate](../../certificates/mixed_ramp_tail_scalar_certificate.py) |
| `7<=L<=10`, any `M>=L` | `Q>0.0024486` | [Transition proof](certified-mixed-ramp-transition-regions.md), [seven-plus certificate](../../certificates/mixed_ramp_seven_plus_certificate.py) |
| `L>=10`, any `M>=L` | `Q>0.0086` | [Long-ramp proof](uniform-full-weil-cross-sign-for-long-causal-ramps.md), [Arb scalar certificate](../../certificates/mixed_ramp_high_support_certificate.py) |

The short-ramp proof uses `H>=0`, the gamma series, and strict
concavity of `G_inf` on `(0,2/25]`. The `L>=7` proof uses the
nondecreasing all-source lower envelope for `H`, exact `r0` prime
powers through `e^10`, and `G>g0`. The separated middle proof uses
corrected [Johnston--Ramaré--Trudgian Lemma 10](https://arxiv.org/html/2303.13785) (JRT),
`H(e^u)>=gamma-1.3/u^2` for `u>=6`, then a one-dimensional Arb
bound for the remaining `L` expression. An
[independent compact-box certificate](../../certificates/mixed_ramp_compact_box_certificate.py)
by Agent 3 uses exact prime powers through `e^13` and direct monotone
corner bounds, obtaining `Q>1e-8` on the same rectangle. Its corner
monotonicity and endpoint handling were separately audited. The
primary certificate below gives a stronger margin using fewer exact
prime powers and JRT for `u>10`.

## Primary compact-box certificate

Let `U=10`. Define a pointwise lower source

\[
\widetilde H(u)=\begin{cases}
H(e^u),&0\le u\le10,\\
\gamma-1.3/u^2,&u>10,
\end{cases}
\quad
\widetilde B(u)=e^{-u}\int_0^u e^v\widetilde H(v)dv. \tag{6}
\]

The exact prime-power list through `floor(e^10)=22026` shows
`0<=H(e^u)<0.752039` for `0<=u<=10`; the maximum occurs just
before the prime power `3` and Arb bounds it by
`0.75203869838813704`. For `u>10`, JRT makes
`0<\widetilde H(u)<gamma<0.753`. Thus
`0<=\widetilde B(u)<0.753` and, from
`\widetilde B'=\widetilde H-\widetilde B` almost everywhere,
`|\widetilde B'(u)|<=0.753` globally. At `u<=10`, it has the exact
complete-prime-power form

\[
\widetilde B(u)=u-1+e^{-u}
 -\sum_{n\le e^u}\frac{\Lambda(n)}n
 +e^{-u}\sum_{n\le e^u}\Lambda(n).                  \tag{7}
\]

For `u>10`, its exact lower-source continuation is

\[
\widetilde B(u)=e^{-u}\left[e^{10}\widetilde B(10)
 +\gamma(e^u-e^{10})
 -1.3\left(\operatorname{Ei}(u)-\frac{e^u}{u}
  -\operatorname{Ei}(10)+\frac{e^{10}}{10}\right)\right].\tag{8}
\]

For the actual source, (3) gives exactly
`R(L,M)=B(L)+B(M)-e^{-L}B(Delta)`, with
`B(u)=e^{-u}int_0^u e^v H(e^v)dv`. In this compact box
`Delta<=6<10`, so `B̃(Delta)=B(Delta)`. The lower-source inequality
`H(e^u)>=H̃(u)` can therefore be applied to the two positive
integrals without reversing the subtracted term:
`R(L,M)>=B̃(L)+B̃(M)-e^{-L}B̃(Delta)`. Independently, `H>=0`
in (3) gives `R>=0`.
For a rational box `a<=L<=b`, `c<=Delta<=d`, let
`l=(a+b)/2`, `delta=(c+d)/2`, `m=l+delta`, and `K=0.753`.
Lipschitz bounds give the certified residual lower

\[
R\ge\max\left\{0,
\widetilde B(l)-K(b-a)/2
+\widetilde B(m)-K[(b-a)+(d-c)]/2
-e^{-a}[\widetilde B(\delta)+K(d-c)/2]\right\}.       \tag{9}
\]

The bracket in (5) is the positive series
`sum_n d_n exp(-(2n+3)Delta)*(1-exp(-(2n+2)L))`; it increases
with `L` and decreases with `Delta`. Since `C<0`, the exact gamma
identity gives

\[
G\ge C(1-e^{-b})+S-T(a)
 +e^{-b}[T(d)-e^aT(d+a)].                            \tag{10}
\]

[The middle-box certificate](../../certificates/mixed_ramp_middle_arb_certificate.py)
checks (9)+(10)
adaptively on the entire rational rectangle
`[2/25,7]x[0,6]`: 56,379 accepted boxes, each lower ball strictly
above `0.005`, with minimum accepted lower
`0.00500020778316167...`. All prime-power integer cutoffs are
certified by Arb balls, and the global source upper bound used by
the Lipschitz step is checked over every exact prime-power gap.
There is no sampling inference.
The [independent exact-prime certificate](../../certificates/mixed_ramp_compact_box_certificate.py)
checks the same rectangle with a separate monotone-corner proof and
returns a least accepted lower ball above `9.04537e-8`.

For that cross-check, write `r0=B0-P0` as in the
[transition proof](certified-mixed-ramp-transition-regions.md). The
second residual has the exact continuum and prime parts
\[
\begin{aligned}
B_1(L,\Delta)&=L+\Delta-1-e^{-L}(\Delta-1),\\
P_1(L,\Delta)&=A(e^{L+\Delta})-e^{-L}A(e^\Delta)
 -e^{-(L+\Delta)}\bigl(\psi(e^{L+\Delta})-\psi(e^\Delta)\bigr),
\end{aligned}
\]
where `A(y)=sum_{n<=y}Lambda(n)/n`. The four nonnegative
correlation pieces `B0,P0,B1,P1` increase separately with `L`
and, where applicable, `Delta`. A prime term starts at zero weight
when the outer shift reaches it, while a prime at `e^Delta` switches
between the two formulas for `P1` with the same nonzero value.
Hence a box
`[a,b]x[c,d]` has residual lower bound
`B0(a)-P0(b)+B1(a,c)-P1(b,d)` using exact primes through `e^13`.
In (5), the positive excess `D(L,M)=e^{-L}T(M-L)-T(M)` increases
with `L` at fixed `M` and decreases with `M` at fixed `L`, term by
term. Therefore its box lower bound is `D(a,b+d)`; the other gamma
terms are bounded by `C(1-e^{-b})+S-T(a)`. The independent script
verifies positivity of the sum on an adaptive exact-rational cover,
with Arb-proved prime-power cutoffs.

Taking the minimum of the five regional margins yields (1) with the
conservative coefficient `0.0024`.

## Scope and off-line perturbation

The positive pairwise ramp kernel is a strong actual-`Lambda` sign,
but it does not imply RH. In a hypothetical high-zero modification,
replace two line pairs above ordinate `R` by an off-line quartet of
horizontal displacement at most `1/4`. For every ramp and each old
or new zero factor,

\[
|F_L(z)|=\left|\int_0^L e^{-x/2}e^{izx}dx\right|
\le\min\{L,2/R\}.
\]

Four old and four new zero occurrences then change a mixed value by
at most `16 R^{-1} min{L,M,1}` for `R>=2`. At `R>=10000` this is
`<=0.0016 min{L,M,1}`, below (1)'s margin. Hence even the full
positive ramp cone can coexist with high off-line zeros in such a
model. This is separate from the actual-zeta proof and from Polson's
Gaussian heat-trace positivity.

It also differs from [Suzuki's pointwise screw-function condition,
Theorem 1.7](https://londmathsoc.onlinelibrary.wiley.com/doi/10.1112/jlms.12785).
Suzuki identifies `Psi(t)=W(Delta_t)` with the triangular
autocorrelation `Delta_t(x)=(t-|x|)_+/2` of an **undamped constant
rectangle**; nonnegativity for every `t` is RH-equivalent. Our ramps
carry the factor `e^{-x/2}`, and their diagonal Weil values have a
bounded long-length limit. Equation (1) neither proves nor assumes
Suzuki's undamped sign.
