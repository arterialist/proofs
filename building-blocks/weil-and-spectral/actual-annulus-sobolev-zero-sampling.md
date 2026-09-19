# Uniform signed Weil positivity at almost all carriers and zero ordinates

**Status:** unconditional written analytic proof, 18 September 2026. This
sharpens the separation range in
[the high-moment annulus theorem](actual-annulus-almost-all-signed-weil.md)
and samples it at the ordinates of *actual* zeta zeros. The linked
[finite Hermitian Gram inequality](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean)
is Lean-checked; the analytic estimates in this note are not. The
separation-variable Sobolev step and zero-sampling argument are written
analysis. No literature-priority claim or RH conclusion is made.

Fix `0<w<log 2` and a real nonnegative
`phi in C_c^infinity((0,w))` with `||phi||_2=1`. Use the
[complete actual-zeta two-bump Weil form](actual-signed-annulus-bump-gram.md).
For `L>2w`, let

\[
\begin{split}
u_t(x)&=e^{-itx}\phi(x),\qquad
v_{t,L}(x)=e^{-itx}\phi(x-L),\\
C_\phi(y)&=\int\phi(x+y)\phi(x)\,dx,\\
P_L(t)&=\sum_{\substack{n\ge2\\|\log n-L|\le w}}
 \frac{\Lambda(n)}{\sqrt n}C_\phi(\log n-L)e^{-it\log n}.
\end{split}                                                    \tag{1}
\]

The inclusive annulus convention retains all prime powers, including
endpoints where `C_phi(+-w)=0`. Let `Q` include the pole and gamma
terms as well as the prime side.

**Theorem.** Put `H=log X` and `h=log H`. Let `R=R(X)` satisfy
`R->infinity` and `R=o(H)`. Fix `0<eta<1`, and set

\[
E_X(R,\eta)=\{t\in[X,2X]:
       \sup_{2w<L\le R}|P_L(t)|\ge\eta H\}.
\]

Then, as `X->infinity`,

\[
\boxed{\quad
\operatorname{meas}E_X(R,\eta)
 \le X\exp\left[-(1+o(1))\frac{Hh}{R}\right].
\quad}                                                        \tag{2}
\]

Let `Z_X(R,eta)` be the multiset of nontrivial zeta zeros
`rho=beta+i gamma`, counted with multiplicity, for which
`X<=gamma<=2X` and the same supremum at `t=gamma` is at least
`eta H`. Unconditionally,

\[
\boxed{\quad
\# Z_X(R,\eta)
 \le X\exp\left[-(1+o(1))\frac{Hh}{R}\right].
\quad}                                                        \tag{3}
\]

Outside `E_X(R,eta)`, and at every zero ordinate outside
`Z_X(R,eta)`, simultaneously for all `2w<L<=R` and all complex
`a,b`, the *complete* Weil form has the positive margin

\[
Q(a u_t+b v_{t,L})\ge
 \frac{1-\eta}{2}H(|a|^2+|b|^2)                    \tag{4}
\]

for all sufficiently large `X`. In particular, for every fixed
`kappa>0`, taking `R=kappa sqrt(Hh)` makes the exceptional measure
and exceptional-zero count at most

\[
X\exp\left[-\left(\frac1\kappa+o(1)\right)\sqrt{Hh}\right].
                                                               \tag{5}
\]

This removes the `kappa<sqrt(2)` restriction and the `kappa/2` loss
in the earlier grid proof. With `R=alpha h+c`, fixed `alpha>=2`,
both exceptions are at most `X^(1-1/alpha+o(1))`.

## Two prime-polynomial moments

Write `P_L=F_L+R_L`, where `F_L` sums the `n=p` terms and `R_L`
sums **all** `n=p^j`, `j>=2`, with their genuine weights
`Lambda(p^j)=log p`. The elementary prime-power argument in the
[previous theorem](actual-annulus-almost-all-signed-weil.md#uniform-prime-power-and-variance-bounds)
gives, uniformly for `L>2w` and all real `t`,

\[
|R_L(t)|\le C_\phi.                                      \tag{6}
\]

The prime coefficients of `F_L` and its separation derivative are

\[
a_p(L)=\frac{\log p}{\sqrt p}C_\phi(\log p-L),\qquad
a'_p(L)=-\frac{\log p}{\sqrt p}C'_\phi(\log p-L).
\]

Their support is in `p<=N=floor(e^(R+w))`. Chebyshev's elementary
`theta(y)<<y` bound, partial summation, and `log p<=L+w` on the
fixed-ratio annulus imply

\[
\sum_p|a_p(L)|^2,
\quad\sum_p|a'_p(L)|^2\le K_\phi(1+R)
\quad(2w\le L\le R).                                     \tag{7}
\]

The smooth compactly supported correlation `C_phi` ensures that
`F_L(t)` is continuously differentiable even when a prime crosses
an annulus endpoint.

Take

\[
\epsilon=h^{-1/2},\qquad
k=\left\lfloor\frac{(1-\epsilon)H}{R+w}\right\rfloor,
\qquad M=N^k\le X^{1-\epsilon}.                       \tag{8}
\]

Because `R=o(H)`, `k->infinity`. For either
`A_L(t)=F_L(t)` or `A_L(t)=partial_L F_L(t)`, write
`A_L(t)=sum_p c_p(L)p^(-it)` and
`A_L(t)^k=sum_{m<=M}b_m m^(-it)`. Unique factorization gives the
*exact* diagonal estimate

\[
D_k(A_L):=\sum_m|b_m|^2
 \le k!\left(\sum_p|c_p(L)|^2\right)^k
 \le k![K_\phi(1+R)]^k.                              \tag{9}
\]

The [Montgomery--Vaughan mean-value theorem](https://doi.org/10.1112/jlms/s2-8.1.73)
on any interval of length `X+O(1)` gives

\[
\int |A_L(t)|^{2k}\,dt
 \le (X+C(M+1))k![K_\phi(1+R)]^k
 =:B_X,                                                  \tag{10}
\]

uniformly for `2w<=L<=R` and both choices of `A_L`.
Here and below an integral without limits in (10) may be over
`[X,2X]` or `[floor X,ceil(2X)]`; the latter has length `X+O(1)`.
The absolute constant `C` covers both choices of interval.

## Sobolev control of every separation

For any differentiable complex `G` on an interval `I` of length
`ell>0`, choose a point where `|G|^2` is no larger than its average
and integrate the derivative of `|G|^2`. This gives

\[
\sup_I|G|^2\le \ell^{-1}\int_I|G|^2
                  +2\int_I|G||G'|.                   \tag{11}
\]

Apply (11) on `[2w,R]` to `G_t(L)=F_L(t)^k`. Since
`G_t'=kF_L^(k-1)partial_L F_L`, Hölder in `t` and (10) yield

\[
\begin{split}
\int_X^{2X}\sup_{2w\le L\le R}|F_L(t)|^{2k}\,dt
&\le B_X+2k\int_{2w}^R
    \int_X^{2X}|F_L|^{2k-1}|\partial_LF_L|\,dt\,dL\\
&\le(1+2k(R-2w))B_X.                              \tag{12}
\end{split}
\]

The factor `1+2k(R-2w)=O(H)` is polynomial. No grid of
`e^(R/2)` points is needed. By (6), the event in (2) forces
`sup_L|F_L(t)|>=eta H/2` for large `X`. Markov applied to (12)
therefore gives

\[
\operatorname{meas}E_X(R,\eta)
 \le \frac{(1+2kR)B_X}{(\eta H/2)^{2k}}.         \tag{13}
\]

## Sampling at actual zeta-zero ordinates

The [Riemann--von Mangoldt zero count, in explicit form](https://arxiv.org/html/1208.5846v2)
gives `N(T)=T/(2pi) log(T/(2pi e))+O(log T)` without RH.
Consequently every unit interval in `[X-1,2X+1]` contains at most
`O(H)` nontrivial zeros, counted with multiplicity. This includes
zeros off the critical line.

Fix `L` and either choice of `A_L` above, and set
`g(t)=A_L(t)^k=sum_{m<=M}b_m m^(-it)`. On every unit interval
`J=[j,j+1]`, the elementary one-dimensional Sobolev estimate is

\[
\sup_J|g|^2\le2\int_J(|g|^2+|g'|^2).              \tag{14}
\]

Assign each zero ordinate `gamma in [X,2X]` to one of the unit
intervals containing it; boundary ordinates are assigned once.
Because `g'` has coefficients `-i(log m)b_m` and
`log m<=log M<=H`, applying Montgomery--Vaughan to `g` and `g'`
over their union gives

\[
\begin{split}
\sum_{\substack{\rho=\beta+i\gamma\\X\le\gamma\le2X}}
 |A_L(\gamma)|^{2k}
&\ll H\int_{\lfloor X\rfloor}^{\lceil2X\rceil}
       (|g(t)|^2+|g'(t)|^2)\,dt\\
&\ll XH^3 k![K_\phi(1+R)]^k
 =:B_X^{(0)}.                                          \tag{15}
\end{split}
\]

Every sum over zeros here and below counts multiplicities.
Apply (11) to `G_gamma(L)=F_L(gamma)^k`, sum over zeros, and use
Hölder in that finite zero multiset. The two fixed-`L` moment
bounds (15), for `F_L` and `partial_L F_L`, give

\[
\sum_{\substack{\rho=\beta+i\gamma\\X\le\gamma\le2X}}
 \sup_{2w\le L\le R}|F_L(\gamma)|^{2k}
 \le(1+2k(R-2w))B_X^{(0)}.                         \tag{16}
\]

The prime-power estimate (6) and counting Markov inequality now
prove

\[
\#Z_X(R,\eta)
 \le\frac{(1+2kR)B_X^{(0)}}{(\eta H/2)^{2k}}.    \tag{17}
\]

To extract (2)--(3), `k=(1+o(1))H/R`, and Stirling with
`log k+log(1+R)=h+o(1)` gives

\[
\log\frac{k![K_\phi(1+R)]^k}{(\eta H/2)^{2k}}
 \le-(1+o(1))\frac{Hh}{R}.                         \tag{18}
\]

The factors `1+2kR=O(H)` and `H^3` have logarithm `O(h)`, which
is `o((H/R)h)` because `H/R->infinity`. Also `M=o(X)` in
(10) and (15). This proves the stated exponents.

Finally, the [full-form calculation](actual-signed-annulus-bump-gram.md#exact-prime-orientation-and-analytic-remainder)
has diagonal `log(t/(2pi))+O_phi(X^-1)`, off-diagonal `-P_L(t)`
plus `O_phi(X^-1)`, and pole entries
`O_{phi,A}(e^(R/2)X^(-A))=o(1)` uniformly for `t in [X,2X]`
and `L<=R=o(H)`. The Lean-checked Hermitian inequality gives (4).

The zero-ordinate estimate controls *how many* ordinates can be
exceptional, not whether any off-line zero exists. Its bound remains
much larger than one in the stretched range, and it makes no claim
that the sampled ordinates are on the critical line. The input is
weaker than RH: elementary Chebyshev bounds, Montgomery--Vaughan,
the unconditional zero count, and the complete explicit formula.
The [fixed-window certificate of Zhu](https://arxiv.org/html/2608.24827v2)
signs all complex tests in its stated short window; (4) signs only a
specified two-dimensional family, though its separation can grow.
At the stretched scale a single off-line-zero mode can still occupy
the exceptional set in (3), so the theorem does not meet the
pointwise RH obstruction.
