# Compact local scattering has both signs of physical energy change

RH Agent3 developed the written calculation and the finite-phase formalization. RH Proof independently reviewed the polynomial and physical-test argument, and formalized the dictionary to the original complex-power multiplier and its two frequency signs on 16 September 2026.

[CompactLocalScatteringSigns.lean](BuildingBlocks/CompactLocalScatteringSigns.lean) compiles twenty-three printed declarations with only `propext`, `Classical.choice`, and `Quot.sound`. These include the exact finite history factorization, unit scattering phase, actual prime reciprocal-square-root bounds, both finite-phase signs, positive-base complex-power identification, the complete original multiplier dictionary, and strict attenuation/amplification jointly at the original frequencies for every prime and integer depth M ≥ 1. The compact pole-null wave-packet and Plancherel limit below remain written mathematics. This limits a proposed local contraction mechanism in the original physical L2 metric; it does not sign an actual-source work increment or the full Weil form.

For an actual prime p and integer M >= 1 put r = p^(-1/2), and use
the unchanged multipliers

\[
u_p(z)=\frac{1-p^{z-1/2}}{1-p^{-z-1/2}},\qquad
v_{p,M}(z)=-p^{z-1/2}+(1-p^{-1})\sum_{j=0}^{M-1}p^{-j(z+1/2)}.
\]

The finite geometric sum gives v = u(1-d), where

\[
d(it)=\frac{(1-r^2)r^M e^{-iMt\log p}}{1-r e^{it\log p}}.
\]

Since |u(it)| = 1, the exact squared-norm multiplier change is

\[
|v(it)|^2-1=-2\Re d(it)+|d(it)|^2.
\]

At t = 0, d = (1+r)r^M lies strictly between 0 and 2:
r <= 1/sqrt(2) and (1+r)r^M <= r+r^2 < 2.
Consequently |v(0)|^2-1 < 0.

At t_* = pi/(M log p), set theta = pi/M and a = (1-r^2)r^M > 0.
The numerator phase is -1, so

\[
\Re d(it_*)=-a\frac{1-r\cos\theta}{|1-r e^{i\theta}|^2}<0,
\qquad |v(it_*)|^2-1>0.
\]

Thus every depth M has both attenuation and amplification frequencies.
This remains true when M grows with the transport scale. Smallness of
the multiplier error does not give it a fixed sign.

Both signs can be realized by smooth compact tests with the literal
two pole moments zero. Choose a nonzero eta in C_c^infinity(R), and
at either frequency t_0 above set

\[
f_L(v)=L^{-1/2}\eta(v/L)e^{-it_0v},\qquad
h_L=(D^2-1/4)f_L.
\]

Integration by parts gives M_(+/-1/2) h_L = 0. In the angular Fourier
convention int h(v)e^{itv}dv, the transform of f_L concentrates at t_0,
and that of h_L is -(t^2+1/4) times it. Plancherel and dominated
convergence therefore give

\[
\lim_{L\to\infty}\frac{\|V_{p,M}h_L\|_2^2}{\|h_L\|_2^2}
=|v_{p,M}(it_0)|^2.
\]

For completeness, domination after t = t_0 + s/L follows from the
bounded finite translation multiplier and
(1+|t_0+s/L|^2)^2 <= C_(t_0)(1+|s|^4), L >= 1;
the Schwartz transform of eta makes this integrable. The limiting
denominator is (t_0^2+1/4)^2 times the positive Fourier mass of eta.
For sufficiently large finite L, the energy change has the indicated
strict sign. A common translation places the test and all its finite
history translates in nonnegative physical age, preserving both norms
and pole nulls.

Scope: this refutes uniform local contraction of the finite compact
history approximation even on the pole-null compact physical core.
It does not refute contraction on a particular actual-source family,
give a dyadic block sign, or change the already proved absolute transport
error. Full prime-power arithmetic and gamma terms in the Weil form
remain mandatory and unestimated for the RH consumer.

## Exact finite physical construction, avoiding the Fourier limit

Write L=log p and tau_s eta(v)=eta(v-s). Choose a nonzero nonnegative
smooth bump kappa supported in an interval of diameter strictly less
than L and set eta=(D^2-1/4)kappa. Its two pole moments vanish, while
int eta=-(1/4)int kappa<0, so eta is nonzero. Distinct integer-L
translates of eta have disjoint supports and are orthogonal in the
original physical L2 metric.

The unchanged finite history operator is exactly

\[
V\eta=-r\tau_L\eta+(1-r^2)\sum_{m=0}^{M-1}r^m\tau_{-mL}\eta.
\]

For this single bump its norm is the exact diagonal sum

\[
\|V\eta\|_2^2=
\left[r^2+(1-r^2)^2\sum_{m=0}^{M-1}r^{2m}\right]\|\eta\|_2^2
=\left[1-(1-r^2)r^{2M}\right]\|\eta\|_2^2<\|\eta\|_2^2.
\]

For amplification, take theta=pi/M, q=exp(i theta), and the FINITE test

\[
h_J=\sum_{j=0}^{J-1}q^{-j}\tau_{jL}\eta.
\]

Each translate is pole-null, so h_J is pole-null. Orthogonality gives
||h_J||_2^2=J||eta||_2^2. In Vh_J, the coefficient of tau_(kL) eta,
for each integer 1 <= k <= J-M, is exactly

\[
q^{-k}\left[-r q+(1-r^2)\sum_{m=0}^{M-1}r^m q^{-m}\right]
=q^{-k}v_{p,M}(i\theta/L).
\]

All indices are inside the original box: the positive shift uses
j=k-1 and each negative shift uses j=k+m. The remaining output
coefficients occupy disjoint translates too and contribute nonnegative
squared norms; no boundary term is discarded with a negative sign.
With G=|v_(p,M)(i theta/L)|^2>1, this proves

\[
\|Vh_J\|_2^2\ge(J-M)G\|\eta\|_2^2>J\|\eta\|_2^2
=\|h_J\|_2^2
\]

for any integer J>MG/(G-1). This also implies J>M. Thus one FINITE
compact pole-null test attenuates and another amplifies, with no
asymptotic test limit, Fourier decay, or Plancherel prerequisite.
The output shifts range from -(M-1)L to JL. A common sufficiently
large translation makes all supports causal and preserves the norms
and pole nulls. This exact construction is written mathematics; its
physical orthogonality and operator-coefficient identification are not
yet formalized in Lean. It retains only the local history operator and
does not replace the gamma/full-prime-power Weil consumer.
