# Actual clocked compact-window transfer from finite odd heat energy

Developed by RH Agent3, with independent mathematical review by RH Proof. This is a written, independently audited finite-source estimate. It does
not establish RH, a bound on the heat energy, or a Lean theorem.
The semigroup below is the complete causal prime-history process, rather
than the unitary local scattering operator.

Let (N\ge2), (L=\log2), and let the fixed real smooth window (Z)
have compact support in ((0,L)). Put
\[
a_n=\Lambda(n)-2\quad(n\text{ odd}),\qquad
\mu_N=\sum_{\substack{n\le N\\n\text{ odd}}}
 a_n n^{-1/2}\delta_{\log n},
\]
\[
O_N(t)=\sum_{\substack{n\le N\\n\text{ odd}}}a_ne^{-nt},\qquad
J_N(P)=\sum_{\substack{n\le N\\n\text{ odd}}}
 a_n n^{-1/2}Z(\log(n/P)).
\]
In particular (a_1=-2). These are literal finite sums, with every odd
prime power in the von Mangoldt coefficient retained.

## Exact source profiles

Use the Fourier convention \(\widehat f(\xi)=\int e^{-i\xi U}f(U)dU\)
and translation \(\tau_b f(U)=f(U-b)\). Define
\[
j_N(U)=J_N(e^U),\qquad
y_N(U)=e^{-U/2}O_N(e^{-U}).
\]
Writing \(Z^\vee(w)=Z(-w)\) and
\(k(w)=e^{-w/2}\exp(-e^{-w})\), direct substitution gives
\[
j_N=Z^\vee*\mu_N,\qquad y_N=k*\mu_N,
\qquad \widehat k(\xi)=\Gamma(1/2+i\xi).
\tag{1}
\]
The gamma identity follows by (t=e^{-w}) in the absolutely convergent
Fourier integral. Both profiles are in (L^2(\mathbb R)).
The support of (j_N) lies in ([-L,\log N]), so (	au_Lj_N)
is a causal input. The heat profile need not be causal.

## Complete process comparison

For the established complete causal semigroup write
\[
\widehat{T_sf}(\xi)=e^{-s\Phi(i\xi)}\widehat f(\xi),
\qquad \rho(\xi)=\operatorname{Re}\Phi(i\xi).
\]
Its previously established finite-activity properties give (
ho\ge0),
strict positivity off zero, continuity, and (
ho(\xi)\to\lambda>0)
as (|\xi|\to\infty). Consequently, for each fixed (R>0),
\[
\delta_R=\inf_{|\xi|>R}\rho(\xi)>0.
\]
Gamma has no zeros, and therefore
\[
C_R=\sup_{|\xi|\le R}
 \frac{|\widehat{Z^\vee}(\xi)|^2}
 {|\Gamma(1/2+i\xi)|^2}<\infty.
\]
Split the exact Plancherel integral for (T_sj_N) at (R). On the
inner band use (1) and (e^{-2s\rho}\le1); on the outer band use the
gap. Translation commutes with this convolution semigroup and preserves
the norm. Thus
\[
\boxed{\|T_s\tau_Lj_N\|_2^2
 \le C_R\|y_N\|_2^2+e^{-2\delta_Rs}\|j_N\|_2^2.}
\tag{2}
\]
This uses no comparison between observation after evolution and evolution
after observation: the literal cutoff window is fixed before (T_s).

Chebyshev's bound \(\psi(x)\le Cx\), followed by partial summation,
gives
\[
\sum_{n\le N}\frac{\Lambda(n)}{\sqrt n}
 =\frac{\psi(N)}{\sqrt N}
   +\frac12\int_1^N\frac{\psi(x)}{x^{3/2}}dx
 \le C\sqrt N.
\]
Together with \(\sum_{n\le N}n^{-1/2}\le2\sqrt N\), this proves
\(\|\mu_N\|_{\rm TV}\le C\sqrt N\). Minkowski's inequality in (1)
then gives \(\|j_N\|_2^2\le C_ZN\).

Changing variables (t=e^{-U}) gives the exact full-line heat norm
\[
\|y_N\|_2^2=\int_0^\infty O_N(t)^2dt.
\tag{3}
\]
For (t\ge1), the elementary coefficient bound
\(|a_n|\le\log n+2\) yields
\[
|O_N(t)|\le e^{-t}\sum_{n\ge1}(\log n+2)e^{-(n-1)}
 \le C e^{-t}.
\]
Hence the port \(\int_1^\infty O_N(t)^2dt\) has a bound independent
of (N). Combining this with (2), for any (A>0) and
\(c>(1+A)/(2\delta_R)\), proves
\[
\boxed{\|T_{c\log N}\tau_Lj_N\|_2^2
 \le C_R\int_0^1 O_N(t)^2dt+C+C_ZN^{-A}.}
\tag{4}
\]
The constants depend on the fixed window, band, and process, not on (N).

## Exact paired history form

Define \(C_Z(u)=\int Z(v+u)Z(v)dv\). Let (A_s,B_s) be independent
complete process ages and (D_s=B_s-A_s). Fubini applied to the finite
source sum and the probability measures gives
\[
\boxed{\|T_sj_N\|_2^2
 =\sum_{\substack{m,n\le N\\m,n\text{ odd}}}
 \frac{a_ma_n}{\sqrt{mn}}
 \mathbb E\,C_Z(\log(n/m)+D_s).}
\tag{5}
\]
For example the inner product of shifts with centers
\(\log m+A_s\) and \(\log n+B_s\) gives exactly this correlation;
real (C_Z) is even. The relative-age characteristic function is
\(e^{-2s\rho(\xi)}\). Its no-jump atom of mass (e^{-2\lambda s})
and all continuous history terms remain in (5).

The heat norm in (3) is also exactly the finite signed pair sum
\(\sum_{m,n\le N,\;m,n\text{ odd}}a_ma_n/(m+n)\).
Neither this identity nor positivity of its total permits dropping
individual signed pairs. The original terminal window (N/2\le P\le N)
and seed are retained before evolution. Equation (4) is one directional:
it does not bound the unclocked window, preserve a signed Weil row, or
prove a uniform or subpower heat estimate. Those bounds, actual RH, and
the required complete Lean formalization remain unresolved.

The [original frozen-metric map](odd-cutoff-heat-original-frozen-metric-map.md) gives a further one-direction upper estimate for the same literal heat source, retaining the density and powers-of-two correction. The required original frozen-source subpower estimate remains open.
