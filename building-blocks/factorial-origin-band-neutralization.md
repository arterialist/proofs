# Unconditional factorial origin-band energy payment

For the actual response and compensated clock density, keep every finite Möbius quotient history:

\[
g_N(t)=\sum_{n=1}^N\mu(n)(1-e^{-\lfloor N/n\rfloor t}),\qquad
w(t)=t^{-2}-\frac1{t(e^t-1)}.
\]

For N≥1 and U≥0 define the full origin-band energy

\[
Q_{\rm origin}(N,U)=\int_{(0,U/N]}g_N(t)^2w(t)\,dt.
\]

The unconditional bounds are

\[
|g_N(u/N)|\le u/N+u^2\quad(u\ge0),
\]

\[
Q_{\rm origin}(N,U)\le \frac{U^2}{4N^2}+\frac{U^3}{3N}+\frac{U^4}{8},
\]

and, for each integer X≥1,

\[
\sum_{N=X}^{2X-1}Q_{\rm origin}(N,U)
\le \frac{U^2}{4X}+\frac{U^3}{3}+\frac{U^4X}{8}.
\]

Thus this entire clock band costs O_U(X) on a dyadic block for fixed U. Its endpoint U/N is retained separately for every actual horizon. These bounds leave the original energy on t>U/N uncontrolled. Allowing U to grow with X costs the explicit U⁴ factor; no uniform large-U estimate or RH conclusion is supplied.

## Neutralization before absolute values

The actual integer divisor identity gives

\[
\sum_{n=1}^N\mu(n)\lfloor N/n\rfloor=1.
\]

Consequently the exact response identity is

\[
g_N(t)=t+\sum_{n=1}^N\mu(n)
\left(1-e^{-q_nt}-q_nt\right),\qquad q_n=\lfloor N/n\rfloor.
\]

For v≥0, the global scalar estimate

\[
|1-e^{-v}-v|\le v^2/2
\]

follows from e^{-v}≥1−v and e^{-v}≤1−v+v²/2. For the latter, the derivative of 1−v+v²/2−e^{-v} is v−1+e^{-v}≥0, and the function vanishes at zero.

Using |μ(n)|≤1, q_n≤N/n and the elementary finite inverse-square budget Σ_{n≤N}n^{-2}≤2 yields

\[
\sum_{n=1}^N|\mu(n)|q_n^2\le2N^2,
\qquad |g_N(t)|\le t+N^2t^2.
\]

Setting t=u/N proves the claimed uniform scaled response bound. The exact linear arithmetic cancellation occurs before absolute values; the remaining square budget uses no unknown Möbius cancellation estimate.

## Full density and integration

For all t>0 the original compensated density satisfies

\[
0<w(t)\le\frac1{2t}.
\]

The upper bound is equivalent to (t−2)e^t+t+2≥0. The function t−2+(t+2)e^{-t} vanishes at zero and has derivative 1−(t+1)e^{-t}≥0, by e^t≥t+1. Multiplication by e^t gives the required inequality without dropping the compensating density term.

Therefore the scaled actual energy density obeys

\[
\frac{g_N(u/N)^2w(u/N)}{N}
\le\frac{u}{2N^2}+\frac{u^2}{N}+\frac{u^3}{2}\quad(u>0).
\]

The polynomial is integrable at zero. Integrating it through U and using the exact substitution t=u/N proves the origin-band estimate. The actual energy integrability is reused from the existing full-clock theorem. For X≤N<2X the bound is at most U²/(4X²)+U³/(3X)+U⁴/8. There are exactly X horizons, giving the displayed dyadic bound.

## Attribution and formal status

The neutralization and origin-band mechanism was developed in RH Agent2's dyadic mean-energy work and independently reviewed and formalized by root. This is an elementary arithmetic upper estimate for the specified band; no novelty claim is made.

[FactorialOriginNeutralization.lean](BuildingBlocks/FactorialOriginNeutralization.lean) proves twelve public theorems covering the scalar remainder, inverse-square sum, exact actual neutralization, quotient square budget, unscaled and scaled response estimates, complete compensated density upper bound, scaled energy row, polynomial integral, scaled origin-band integral, original moving-endpoint integral, and entire dyadic origin-band payment. The full umbrella build passes. Printed assumptions are only propext, Classical.choice and Quot.sound. Fixed-band limiting profiles, Hilbert-valued Mellin consumers and the full RH-scale dyadic energy upper estimate are not established by this module.

## Compiled actual fixed-scale profile

[FactorialOriginProfile.lean](BuildingBlocks/FactorialOriginProfile.lean) adds seven compiled theorems. For each fixed u≥0 the actual response satisfies

\[
g_N(u/N)\longrightarrow F(u):=\sum_{n\ge1}\mu(n)(1-e^{-u/n}-u/n).
\]

The coefficient series is absolutely convergent. Its coefficient norm is bounded by (u²/2)n^{-2}. At each positive fixed n the normalized natural quotient floor(N/n)/N tends to 1/n: the exact integer remainder identity expresses the difference through (N mod n)/N, which tends to zero. Continuity of the scalar exponential remainder then gives coefficient convergence. The finite actual response is exactly u/N plus an infinite series with finite support in 1≤n≤N; every n>N coefficient vanishes because its actual quotient is zero. The n=0 term is explicitly zero by μ(0)=0. The majorant holds uniformly for all N≥1. Dominated convergence for the complete series and u/N→0 prove the stated original-response limit.

The seven formal results are the normalized quotient limit, finite coefficient limit, uniform finite coefficient bound, limiting coefficient bound, absolute summability, original finite-support series identity, and actual profile limit. The full umbrella build passes with only propext, Classical.choice and Quot.sound. No model response is substituted for g_N. The limit is for fixed u; uniform approximation on expanding u intervals, the integral limit of the original origin-band energy, the entire zeta-coefficient expansion and large-u decay remain separate obligations. This convergence statement alone supplies no full-clock energy upper bound or RH conclusion.
