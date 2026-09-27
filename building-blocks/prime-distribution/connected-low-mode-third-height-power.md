# A third-height-power bound for the actual connected prime-error modes

This is an unconditional estimate for a proper part of the connected prime-error primitive energy. It is an improvement for fixed nonzero modes and for a sufficiently small growing block, while the terminal and centered zero modes retain their previously published bounds. The zero estimate is a written analytic argument; the exact finite arithmetic reduction is formalized separately in Lean.

Let `X>e` be real, `j` a nonzero integer, `E(t)=psi(t)-t` with every `Lambda(p^k)=log p`, and `e(v)=exp(2 pi i v)`. Define

\[
C_j(X)=\int_X^{2X}E(t)\{e(-jt/X)-1\}\,dt.
\tag{1}
\]

At integer dyadic `X`, this is exactly the connected mode in `coarse-primitive-low-mode-fourier-reduction.md`, (14a)--(14b):

\[
C_j(X)=\frac{X}{2\pi i j}B_j(X)-M(X),\qquad
\mathcal L_J(X)=\sum_{1\le j\le J}|C_j(X)|^2/j^2.
\tag{2}
\]

Use the certified zero-free coefficient `A_0=1/48.0712256382`, `d=0.212580726073117...`, and `Phi(X)=(log X)^(3/5)/(loglog X)^(1/5)`. For each `epsilon>0`, all large real `X`, and **uniformly in every nonzero integer j**,

\[
\boxed{|C_j(X)|\ll_\epsilon (1+j^2)X^2
 \exp[-(3^{2/5}d-\epsilon)\Phi(X)].}
\tag{3}
\]

The constant `3^(2/5)d=0.329892458856...` is larger than the already published terminal `c_M=2^(2/5)d=0.280501949731...` and the direct PNT constant `d`. Thus, for every integer `J>=1`, uniformly even when `J=J(X)` grows,

\[
\boxed{\mathcal L_J(X)\ll_\epsilon
 J^3X^4\exp[-2(3^{2/5}d-\epsilon)\Phi(X)].}
\tag{4}
\]

The [current best published uniform bound](coarse-primitive-low-mode-fourier-reduction.md) is
`L_J(X) ≪_ε X⁴ exp[-2(c_M−ε)Φ(X)]` with `c_M=2^(2/5)d`, for all `J`.
Consequently (4) strictly improves that bound on the growing range
`J≤exp(κΦ(X))` whenever
`κ<2(3^(2/5)d−c_M)/3=0.0329270061…`.
The larger range `κ<2(3^(2/5)d−d)/3` only improves the older direct-PNT
baseline. Neither range reaches `J=X^(1/4)` or supplies a terminal or
centered zero-mode estimate at the scale required by `CoarsePrimitiveBound`.

## Proof of (3)

Set `w_j(u)=e(-ju)-1`. Its two endpoint values vanish exactly: `w_j(1)=w_j(2)=0`. The published first-Riesz explicit formula, valid for all real `t>1`, is

\[
D(t):=\int_0^tE(v)\,dv
=-\sum_\rho\frac{t^{\rho+1}}{\rho(\rho+1)}
-t\log(2\pi)+c_0-\sum_{m\ge1}\frac{t^{1-2m}}{2m(2m-1)}.
\tag{5}
\]

The zero series is absolutely and locally uniformly convergent on `t>1`, since `N(T)=O(T log T)` and its shell has `O(log T/T)` absolute mass. Therefore ordinary Stieltjes integration by parts and termwise integration are valid:

\[
C_j(X)=-\int_1^2D(Xu)w_j'(u)\,du.
\tag{6}
\]

The constant `c_0` drops out because `int_1^2 w'_j=0`. The linear archimedean term contributes exactly `X log(2 pi)` because `int_1^2 u w'_j= -int_1^2 w_j=1`; the trivial-zero series contributes `O((1+|j|)/X)` by absolute convergence. Thus those terms are below the asserted right side.

For each nontrivial zero `rho`, its coefficient in (6) is

\[
\frac{X^{\rho+1}}{\rho(\rho+1)}J_j(\rho),\qquad
J_j(s)=\int_1^2u^{s+1}w_j'(u)\,du.
\tag{7}
\]

One further integration by parts gives

\[
J_j(s)=\frac{[u^{s+2}w_j'(u)]_1^2
-\int_1^2u^{s+2}w_j''(u)\,du}{s+2}.
\tag{8}
\]

Since `|w'_j|=2 pi |j|`, `|w''_j|=4 pi^2j^2`, and every nontrivial zero has `0<Re rho<1`, (8) proves `|J_j(rho)|<< (|j|+j^2)/|rho|` for `|Im rho|>=3`. Consequently the zero part of `C_j` is bounded by

\[
O((1+j^2)X^2)\sum_\rho\frac{X^{\Re\rho-1}}{|\rho|^3}.
\tag{9}
\]

The zero-sum estimate with **three** powers of height is proved in [the actual prime-error convolution theorem](actual-prime-error-convolution-global-cesaro-gain.md), (6)--(8), from the certified zero-free region and classical Ingham density. Replacing its earlier `A_0=1/48.0718` by the independently certified `1/48.0712256382` changes only `d`, and yields

\[
\sum_\rho X^{\Re\rho-1}/|\rho|^3
\ll_\epsilon \exp[-(3^{2/5}d-\epsilon)\Phi(X)].
\tag{10}
\]

The finitely many low zeros have a fixed power saving and are harmless. Equations (6)--(10) give (3); summing `(1+j^2)^2/j^2<<j^2` gives (4). All prime powers remain in `psi`, and the integer or prime-power endpoint has measure zero in (1), while the smooth endpoint factor `w_j` vanishes there. No half-weight or deleted-power convention enters.

## Verification and scope

The exact finite prime-power weighted integral is kernel checked in
[`ConnectedLowModeFinite.lean`](../../formalization/BuildingBlocks/ConnectedLowModeFinite.lean).
Its analytic specialization to the exponential weight and the first-Riesz
formula (5), the zero-free/density estimate (10), and the integration in
(6)--(9) remain written arguments; the Lean theorem makes no analytic or
RH claim. An independent audit checked the Riesz normalization, endpoints,
third height power, and comparison with the existing `c_M` bound.

As a normalization falsifier only, a separate finite sieve evaluated (1)
by analytic integration on unit cells and (2) by the complete prime-power
sum at `X=16,64,256,1024`, `j=1,2,3`; discrepancies were below `5e-10`
in double precision. The exact analytic derivation, not this computation,
supports the theorem. It gives no improvement to `M(X)` or the centered
zero mode, no full-energy estimate at RH scale, and no proof of RH.
