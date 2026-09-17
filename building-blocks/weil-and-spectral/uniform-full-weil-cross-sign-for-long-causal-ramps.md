# Uniform full Weil cross sign for long causal ramps

**Status:** independently audited written analytic proof (18 September
2026), developed by RH Agent 2 and checked by RH Agents 1 and 3. The
analytic theorem is not Lean formalized. This is an infinite
two-parameter family of complete actual-prime Weil cross values. It uses
the unconditional [corrected Johnston--Ramaré--Trudgian Lemma 10](https://arxiv.org/html/2303.13785)
and the [sharp all-`x` Mangoldt gap](sharp-mangoldt-harmonic-gap-and-weil-residual.md)
from commit `6f85b03`; it uses no RH or unverified zero assertion. The
[Arb scalar certificate](../../certificates/mixed_ramp_high_support_certificate.py)
checks the final strict margin. This result is restricted to the
positive long-ramp cone and does not imply RH. No literature-priority
claim is made for the inequality.

For `L>0`, let `f_L(x)=e^(-x/2)1_[0,L](x)` and let `Q(f_L,f_M)`
be the real polarization of the [complete Weil form](complete-weil-causal-exponential-signed-cone.md)
with every prime power, both poles and the gamma term. Then

\[
\boxed{Q(f_L,f_M)>0.0086\quad\text{whenever}\quad
\min(L,M)\ge10.}                                      \tag{1}
\]

By symmetry take `L<=M`. Put
`H(y)=log y-sum_{n<=y}Lambda(n)/n`,
`gamma=EulerGamma`, `kappa=(log2)/2`. Exact Stieltjes
polarisation of the causal residual gives

\[
R_{L,M}:=\langle f_L,(P-K)f_M\rangle
=e^{-L}\int_0^L e^uH(e^u)\,du
 +e^{-M}\int_{M-L}^M e^uH(e^u)\,du.                \tag{2}
\]

The first integral is the ordinary finite-ramp residual half;
the second is its translated cross. Equation (2) retains literal
prime-power endpoints: the correlation vanishes when a shift hits
the support endpoint. Indeed, for `u>=0` the two oriented
correlation weights before Stieltjes integration are
`w_{L,M}(e^u)=1-exp(-min(M,(L-u)_+))` and
`w_{M,L}(e^u)=1-exp(-min(L,(M-u)_+))`. For `M>=L`, their
negative derivatives are respectively `e^{u-L}du` on `(0,L)`
and `e^{u-M}du` on `(M-L,M)`, and zero elsewhere.

Define the nonnegative nondecreasing lower envelope

\[
h(u)=\begin{cases}
\min(u,\kappa),&0\le u<3,\\
\gamma-1.3/u^2,&u\ge3.
\end{cases}                                               \tag{3}
\]

For `u<log2`, `H(e^u)=u`. For `u>=log2`, the sharp gap linked above
gives `H(e^u)>=kappa`; for `u>=3`, corrected JRT gives
`H(e^u)>=gamma-1.3/u^2`. The jump at `u=3` points upward because
`gamma-1.3/9>kappa`. Hence `H(e^u)>=h(u)` for every `u>=0`.
Write `r(L)=int_0^L e^{-v}h(L-v)dv`. Since `h` is nonnegative
and nondecreasing, `r(L)` is nondecreasing. Both integrals in
(2) are at least `r(L)` when `M>=L`, so

\[
R_{L,M}\ge2r(L)\ge2r(10).                            \tag{4}
\]

To certify `r(10)`, integrate exactly on `[0,kappa]` and
`[kappa,3]`, then divide `[3,10]` into ten intervals of width
`7/10` and replace the increasing `h(u)` on each by its left
endpoint value, while integrating `e^{u-10}` exactly. Arb gives

\[
r(10)>0.55842534990154227.                            \tag{5}
\]

For the shifted gamma multiplier after the exact pole-density
cancellation and digamma recurrence,
`b(t)=Re psi(5/4+it/2)-log pi`, define its Poisson-smoothed
Fourier kernel

\[
g(u)=\frac1{2\pi}\int_{\mathbb R}
 \frac{b(t)e^{itu}}{t^2+1/4}\,dt.
\]

The digamma partial-fraction series and the Fourier transform
of `(t^2+a^2)^(-1)` give the absolutely convergent expansion

\[
g(u)=C e^{-|u|/2}+\sum_{n\ge0}d_n e^{-\lambda_n|u|},
\quad C=1-\gamma-\log(2\pi),\quad
d_n=\frac1{(2n+2)(2n+3)},\quad
\lambda_n=2n+5/2.                                     \tag{6}
\]

Here `sum d_n=1-log2` and
`g(0)=g_0=2-gamma-log(4pi)=-1.1082399118708...`.
Indeed, in each digamma summand the coefficient of
`e^{-|u|/2}` is
`1/(n+1)-2lambda_n/(lambda_n^2-1/4)=d_n`, and the
second exponential has coefficient `d_n` as well.

The Fourier transforms of the ramps give the exact gamma cross

\[
G_{L,M}=g(0)-e^{-L/2}g(L)-e^{-M/2}g(M)
                 +e^{-(L+M)/2}g(M-L).                   \tag{7}
\]

For `M>=L`, the `C` part of (7) is `C(1-e^{-L})`.
The `d_n` part exceeds `d_n(1-e^{-(lambda_n+1/2)L})`, since
its difference is
`d_n e^{-(lambda_n+1/2)M}(e^{(lambda_n-1/2)L}-1)>0`.
Consequently

\[
G_{L,M}>g_0+e^{-L}\bigl(-C-\sum_nd_n e^{-2L}\bigr)>g_0,
\tag{8}
\]

because `-C>sum d_n` (equivalently `g_0<0`) and
`lambda_n+1/2>=3`. Combining (4), (5), (8),

\[
Q(f_L,f_M)=R_{L,M}+G_{L,M}
>2(0.55842534990154227)-1.10823991187082366
>0.0086107879>0.0086.
\]

The family has arbitrarily large supports and cross terms, and
the proof's prime input is weaker than RH. More precisely, for any
finite positive measure `mu` with compact support in `[10,infinity)`,
with `mu` nonzero, the form-domain mixture `f_mu=int f_L mu(dL)` satisfies
`Q(f_mu)>0.0086 mu([10,infinity))^2` by bilinearity and (1).
Thus an infinite-dimensional cone of growing-support tests is
positive. The Fourier transforms obey
`|hat f_L(t)|<=2/sqrt(t^2+1/4)` uniformly in `L`, so the gamma
integral is dominated by an integrable logarithmic weight for these
compactly supported mixtures. The pole and prime-shift forms are
bounded on their common finite support. This justifies bilinear
integration and approximation by smooth compactly supported tests in
the logarithmic form norm. Arbitrary signed combinations do not follow.

## Countermodel scope

The sign is compatible with a formal high off-line-zero perturbation
model. If two verified line pairs at ordinates `>=R`
are replaced by one off-line quartet with horizontal displacement
`<=1/4`, each affected spectral factor satisfies
`|int_0^L e^{-x/2}e^{izx}dx|<=2/R` for all `L>=0`.
The four old and four new zero occurrences change any mixed-ramp
Weil value by at most `32/R^2`. For `R>=1000`, this is below
`0.000032`, much smaller than (1)'s margin. The same bound scales
by `mu([10,infinity))^2` for a positive mixture. Thus the whole
high-support cone sign persists in these off-line models.
It is a real actual-Λ restricted-cone theorem, not a criterion
forcing RH. The 2-Euler prime perturbation is a different model
and may change the large-ramp constant; it does not affect the
proof for actual `Lambda`.
