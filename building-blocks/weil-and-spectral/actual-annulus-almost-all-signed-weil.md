# Almost-all signed Weil positivity across a growing annulus interval

**Status:** unconditional written analytic proof, 18 September 2026.
RH Agent 2 supplied the high-moment prime-phase idea and the
fixed-separation exponent. RH Agent 1 independently audited the
Dirichlet-polynomial normalization and proves the uniform-in-separation
version below by an exact diagonal bound and a small net. This is a
signed cancellation result for almost all carrier frequencies, not a
uniform sign, a Lean formalization, or RH. No literature-priority claim
is made.

Fix `0<w<log 2` and a real nonnegative
`phi in C_c^infinity((0,w))`, normalized by `||phi||_2=1`.
Use the [complete actual-zeta two-bump form](actual-signed-annulus-bump-gram.md):
for `L>2w` and `t>0`, put

\[
u_t(x)=e^{-itx}\phi(x),\qquad
v_{t,L}(x)=e^{-itx}\phi(x-L),\qquad
C_\phi(y)=\int\phi(x+y)\phi(x)\,dx,
\]

and retain the *entire* finite prime-power annulus

\[
P_L(t)=\sum_{\substack{n\ge2\\|\log n-L|\le w}}
 \frac{\Lambda(n)}{\sqrt n}
 C_\phi(\log n-L)e^{-it\log n}.                 \tag{1}
\]

At an annulus boundary `C_phi(+-w)=0`, so the inclusive convention
keeps the endpoint without changing the value. Write `Q` for the
complete Weil form, including both poles and the gamma factor.

**Theorem.** Fix `alpha>=2`, `c in R`, and `0<eta<1`. Let
`H_X=alpha log log X+c`. As `X` tends to infinity,

\[
\boxed{\quad
\operatorname{meas}\left\{t\in[X,2X]:
 \sup_{2w<L\le H_X}|P_L(t)|\ge\eta\log X\right\}
 \le X^{1-1/\alpha+o_{\phi,w,\alpha,c,\eta}(1)}.
\quad}                                                    \tag{2}
\]

Consequently, outside a set of that measure, **simultaneously for
every** `2w<L<=H_X` and every complex `a,b`, the complete actual-zeta
form satisfies, for all sufficiently large `X`,

\[
Q(a u_t+b v_{t,L})\ge
 \frac{1-\eta}{2}\log X\,(|a|^2+|b|^2).             \tag{3}
\]

There is also a longer, though weaker-density, uniform range. Put
`H=log X`, `h=log H`, and fix `0<kappa<sqrt(2)`. Then

\[
\boxed{\quad
\operatorname{meas}\left\{t\in[X,2X]:
 \sup_{2w<L\le\kappa\sqrt{Hh}}|P_L(t)|\ge\eta H\right\}
 \le X\exp\left[-\left(\frac1\kappa-\frac\kappa2+o(1)\right)
       \sqrt{Hh}\right].\quad}                    \tag{S}
\]

Outside that set, (3) holds simultaneously for all
`2w<L<=kappa sqrt(Hh)`. The coefficient
`1/kappa-kappa/2` is positive exactly in the stated range. The
proof below audits Agent 2's stretched-window observation with the
same exact diagonal bound used for (2).

For `alpha=2`, the exceptional measure is `X^(1/2+o(1))`, including
fixed additive separations beyond the unsigned-mass threshold in the
linked theorem. For any fixed `alpha>2`, the same conclusion holds
through separations `alpha log log X+c`; the unsigned mass there can
exceed the gamma diagonal by a power of `log X`. Statement (2) is a
genuine signed phase saving **in measure**. It permits every zeta-zero
ordinate to lie in the exceptional set and therefore gives no
zero-free conclusion.

## Uniform prime-power and variance bounds

Split (1) as `P_L=F_L+R_L`, with

\[
F_L(t)=\sum_p a_p(L)e^{-it\log p},\qquad
a_p(L)=\frac{\log p}{\sqrt p}C_\phi(\log p-L),
\]

and `R_L` containing all powers `p^j`, `j>=2`, with their exact
von Mangoldt coefficients. The elementary Chebyshev bound
`theta(y)=sum_{p<=y}log p << y` and partial summation imply

\[
\sum_{A\le p\le B}\frac{\log p}{p}
 \ll 1+\log(B/A)\qquad(1\le A\le B).             \tag{4}
\]

For squares in (1), `p` lies in
`[e^((L-w)/2),e^((L+w)/2)]`, a fixed-ratio interval. Thus their
total absolute contribution is `O_phi(1)` uniformly in `L`.
For `j>=3`, the global series
`sum_p sum_{j>=3}(log p)/p^(j/2)` converges, so

\[
\sup_{L>2w,\,t\in\mathbb R}|R_L(t)|=O_\phi(1).         \tag{5}
\]

The same fixed-ratio estimate, with `log p<=L+w` on the annulus,
gives the uniform prime variance bound

\[
V_2(L):=\sum_p|a_p(L)|^2
 \ll_\phi 1+L.                                         \tag{6}
\]

No prime number theorem or zero-location assumption is needed for
(4)--(6). The full `Lambda(p^j)=log p` source remains present in (1),
and (5) is a bound on those genuine terms, not their deletion.

## High moments at a fixed separation

For a given `X`, set

\[
H=H_X,\qquad
\varepsilon_X=(\log\log X)^{-1/2},\qquad
k=\left\lfloor\frac{(1-\varepsilon_X)\log X}{H+w}\right\rfloor.
\tag{7}
\]

For large `X`, `k>=1`, `k=(1/alpha+o(1))log X/log log X`, and every
prime in `F_L` for `L<=H` is at most `N=floor(e^(H+w))`.
The Dirichlet polynomial `F_L(t)^k=sum_{m<=N^k}b_m m^{-it}` therefore
has length `N^k<=X^(1-epsilon_X)`.
The [Montgomery--Vaughan mean-value theorem](https://doi.org/10.1112/jlms/s2-8.1.73)
gives uniformly in `L<=H`

\[
\int_X^{2X}|F_L(t)|^{2k}\,dt
 \le (X+C N^k)D_k(L),\qquad
D_k(L)=\sum_m|b_m|^2.                              \tag{8}
\]

Here `C` is an absolute mean-value constant, independent of `k`,
`L`, `X`, and the coefficients.

Unique factorization makes the diagonal bound especially simple.
For multiplicities `r_p>=0` summing to `k`, the coefficient of
`m=prod p^(r_p)` is `(k!/prod r_p!)prod a_p(L)^(r_p)`. Hence

\[
\begin{split}
D_k(L)&=\sum_{\sum r_p=k}
 \left(\frac{k!}{\prod r_p!}\right)^2
 \prod_p|a_p(L)|^{2r_p}\\
&\le k!\sum_{\sum r_p=k}
 \frac{k!}{\prod r_p!}\prod_p|a_p(L)|^{2r_p}
 =k!V_2(L)^k.                                      \tag{9}
\end{split}
\]

This inequality is exact; no unproved repeated-prime asymptotic is
used. By (6), `V_2(L)<<phi log log X` for every `2w<L<=H`.
Markov's inequality applied to (8)--(9) at any fixed threshold
`rho log X`, `rho>0`, yields

\[
\operatorname{meas}\{t\in[X,2X]:|F_L(t)|\ge\rho\log X\}
 \le X^{1-1/\alpha+o(1)},                          \tag{10}
\]

uniformly in `L`. Indeed
`log(k![K_phi log log X]^k)<=(1/alpha+o(1))log X`, while
`2k log(rho log X)=(2/alpha+o(1))log X`; the `C N^k` term in (8)
is `o(X)`. The prime-power remainder (5) is negligible against
`rho log X` for large `X`.

## A polylogarithmic separation net

Because `C_phi` is smooth and compactly supported, (1) is
differentiable in `L`. A second use of Chebyshev and partial
summation gives

\[
\sup_{\substack{2w<L\le H\\t\in\mathbb R}}
 |\partial_LP_L(t)|
 \le\|C'_\phi\|_\infty
 \sum_{n\le e^{H+w}}\frac{\Lambda(n)}{\sqrt n}
 \ll_\phi e^{H/2}
 \ll_{\phi,\alpha,c}(\log X)^{\alpha/2}.         \tag{11}
\]

Choose a grid of mesh `(log X)^(-alpha)` covering `[2w,H]`.
It has `O((log X)^alpha log log X)=X^o(1)` points, and (11) makes
the change in `P_L(t)` between a point and its nearest grid point
`O((log X)^(-alpha/2))=o(1)`, uniformly in `t`.
At each grid point apply (10) with `rho=eta/4`; outside the union
of its exceptional sets, `|F_L(t)|<eta log X/4` at every point.
The `O_phi(1)` prime-power remainder and the net error then give
`sup_{2w<L<=H}|P_L(t)|<eta log X` for large `X`. The grid has only
`X^o(1)` points, so the union retains the exponent in (2).

Finally, the linked full-form calculation gives the Gram entries
`log(t/(2pi))` on the diagonal and `-P_L(t)` off-diagonal, with
`o(1)` error uniformly for `t in [X,2X]` and `L<=H`.
The [Lean Hermitian algebra](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean)
checks the lower bound `d-|P|` for the ideal two-by-two matrix.
Since `log(t/(2pi))=log X+O(1)`, (2) implies (3), including both
pole moments, the gamma integral, all prime powers and their support
endpoints. The high-moment, prime-power and net estimates are written
mathematics, not Lean theorems.

## Stretched-window extension

To prove (S), write `H=log X`, `h=log H`,
`R=kappa sqrt(Hh)`, and

\[
k=\left\lfloor
 \frac{(1-h^{-1/2})H}{R+w}\right\rfloor.
\]

The prime polynomial at every `L<=R` has length at most
`N=floor(e^(R+w))`, so `N^k<=X^(1-h^(-1/2))` and the
Montgomery--Vaughan error is `o(X)` uniformly in `L`.
Equations (6), (8) and the *exact* bound (9) give

\[
\int_X^{2X}|F_L(t)|^{2k}dt
 \le(1+o(1))X\,k!\,[K_\phi(1+R)]^k.
\]

Here `k=(1/kappa+o(1))sqrt(H/h)` and
`log k+log(1+R)=h+O(1)`. Stirling and Markov therefore show,
for each fixed `rho>0`, uniformly in `2w<L<=R`,

\[
\operatorname{meas}\{t\in[X,2X]:|F_L(t)|\ge\rho H\}
 \le X\exp\left[-\left(\frac1\kappa+o(1)\right)
                  \sqrt{Hh}\right].                    \tag{12}
\]

Equation (11), with `R` in place of its earlier upper cutoff, gives
`|partial_L P_L(t)|<=K'_phi e^(R/2)`. Cover `[2w,R]` by a grid
of mesh `eta H/(8K'_phi e^(R/2))`. Its number of points is

\[
O\!\left(1+\frac{R e^{R/2}}{\eta H}\right)
 =\exp\left[\left(\frac\kappa2+o(1)\right)
              \sqrt{Hh}\right].                          \tag{13}
\]

Between a point and its nearest grid point, `P_L(t)` changes by at
most `eta H/8`. The prime-power remainder (5) is also below
`eta H/8` for large `X`. Hence if the supremum in (S) reaches
`eta H`, some grid point has `|F_L(t)|>=eta H/4`.
Apply (12) at every grid point with `rho=eta/4` and take a union
bound. Subtracting the grid exponent in (13) from the moment gain
in (12) gives exactly `1/kappa-kappa/2`, proving (S).
The full-form gamma remainder is `O_phi(X^-1)` and the polar
remainder is `O_{phi,A}(e^(R/2)X^-A)=o(1)` because `R=o(H)`;
therefore the same ideal-Gram inequality proves (3) uniformly in
this longer range. The exceptional-set exponent is positive only
for `kappa<sqrt(2)`.

The almost-all saving does not improve a pointwise prime-error bound.
Montgomery--Vaughan controls measure, and its exceptional set can
contain isolated off-line zero heights. Excluding even one such height
requires additional actual-arithmetic information at that carrier;
(2) supplies none. No equivalent criterion is treated as a proof.
