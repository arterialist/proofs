# Moving actual grounds remain far from the centered heat-filter range at affordable cost

The [fixed-core heat-range obstruction](heat-to-killed-ground-range-obstruction.md)
shows that an exact killed ground has no $L^2$ preimage under the actual
Gamma heat filter. The result here quantifies that obstruction while
the core radius and arithmetic cutoff grow together. It applies on the
actual favorable radii where complete-prime critical-scale trials
concentrate the killed ground. The positive [moving finite Goldbach
readout](actual-moving-core-centered-heat-gram.md#direct-finite-goldbach-readout-without-a-terminal-atom)
is retained as a scalar norm identity; no theta source map or RH sign
is inferred from it.

Fix $d>2$. The [critical-collar theorem](theta-ground-critical-subsequence-prime-average.md)
provides an unbounded sequence of actual radii $R$ for which, with
$L=dRe^{-R}$, $T=R+L$, and
\[
G_R=\Phi\psi_R1_{|u|>R},\qquad
d\mu_R=\psi_R^2d\nu,\qquad
\omega^2=\Phi/b,\qquad b(u)=2\cosh(u/2),
\]
one has $\mu_R\{|u|>T\}=o(1)$. Every $R\to\infty$ limit below
runs along this selected sequence. The physical identity
$G_R(u)^2du=\omega(u)^2d\mu_R(u)$ and the eventual decrease of
$\omega(|u|)^2$ imply, for the two-collar set
$E_R=(R,T)\cup(-T,-R)$,
\[
\frac{\|1_{E_R^c}G_R\|_2^2}{\|G_R\|_2^2}
\le\frac{\mu_R(E_R^c)}{\mu_R(E_R)}=o(1).
\tag{1}
\]
The core contributes zero to the left side. Both exterior halves and
every prime-power edge used to obtain the actual concentration remain.

Let $g_R=G_R/\|G_R\|_2$ and let $P_{\le B}$ be the Fourier projection
to $|\xi|\le B$ in the unitary convention. For a function $h$ supported
in a set $E$ of finite measure, Cauchy--Schwarz and
$|\widehat h(\xi)|\le(2\pi)^{-1/2}\|h\|_1$ give
\[
\|P_{\le B}h\|_2^2\le\frac{B|E|}{\pi}\|h\|_2^2.
\tag{2}
\]
Choose
\[
B_R=\frac{\pi}{32L}=\frac{\pi e^R}{32dR}.
\tag{3}
\]
Since $|E_R|=2L$, (2) bounds the low-frequency norm of
$1_{E_R}g_R$ by $1/4$. Equation (1) makes the omitted tail norm at
most $1/4$ for all sufficiently large selected radii. Therefore
\[
\boxed{\quad
\|P_{\le B_R}g_R\|_2\le\tfrac12,
\qquad \|P_{>B_R}g_R\|_2\ge\tfrac{\sqrt3}{2}.
\quad}
\tag{4}
\]

The exact centered heat filter $Hf=k*f$ has
$k(v)=e^{-3v/2-e^{-v}}$ and Fourier multiplier
$m(\xi)=\Gamma(3/2+i\xi)$, with
\[
|m(\xi)|^2
=\frac{\pi(\xi^2+1/4)}{\cosh(\pi\xi)},
\qquad
\sup_{|\xi|>B}|m(\xi)|
\le C(1+B)e^{-\pi B/2}\quad(B\ge1).
\tag{5}
\]
If $f_R\in L^2(\mathbb R)$ satisfies
$\|Hf_R-g_R\|_2\le1/4$, then (4)--(5) give
\[
\boxed{\quad
\|f_R\|_2\ge
 c\frac{e^{\pi B_R/2}}{1+B_R}
 \ge\exp\!\left(c_d\frac{e^R}{R}\right)
\quad}
\tag{6}
\]
for all sufficiently large selected $R$ and any fixed
$0<c_d<\pi^2/(64d)$. Indeed the high-frequency norm of $Hf_R$
is at least $\sqrt3/2-1/4>1/2$, while its upper bound is the
supremum in (5) times $\|f_R\|_2$. The polynomial denominator is
absorbed in the final exponential. Thus even relative $L^2$
approximation of the normalized moving ground has a quantified
superexponential input cost.

This already separates the **complete compact arithmetic heat source**.
At $U=R/2$, the source $a_U(v)=e^{-v/2}E(e^v)1_{[0,U]}(v)$
and its filtered output $b_U=H a_U$ retain the initial density
atom, every prime-power arrival and the frozen terminal compensation.
The moving-core theorem proves $\|b_U\|_2\ge c_0>0$ for large $U$,
while Chebyshev gives $\|a_U\|_2\ll e^{U/2}=e^{R/4}$.
Thus (5) gives
\[
\left\|P_{>B_R}\frac{b_{R/2}}{\|b_{R/2}\|_2}\right\|_2
\ll (1+B_R)e^{R/4}e^{-\pi B_R/2}\longrightarrow0,
\quad
\liminf_R\left\|g_R-\frac{b_{R/2}}{\|b_{R/2}\|_2}\right\|_2
\ge\frac{\sqrt3}{2}.
\tag{6a}
\]
The limit runs through the selected radii. No compact-source endpoint
term has been dropped; its heat profile is the $b_U$ in this formula.

There is a direct finite-packet version. With
$N_R=\lfloor e^{R/2}\rfloor$, $U_R=\log N_R=R/2+O(e^{-R/2})$,
let $d_{N_R}$ be the actual centered discrete packet in (20) of the
moving-core note. Its logarithmic source measure has total variation
\[
M_N=\sum_{n\le N}\frac{|\Lambda(n)-1|}{\sqrt n}
\ll(1+U)e^{U/2},
\tag{7}
\]
and $\|d_N\|_2\ge c_0>0$ uniformly in $N$ because the $a_1=-1$
term dominates on a fixed sufficiently large heat-time interval.
The packet heat kernel $k_0(v)=e^{-v/2-e^{-v}}$ has Fourier multiplier
$\Gamma(1/2+i\xi)$ and squared modulus
$\pi/\cosh(\pi\xi)$. Consequently
\[
\left\|P_{>B_R}\frac{d_{N_R}}{\|d_{N_R}\|_2}\right\|_2
\le C(1+R)e^{R/4}e^{-\pi B_R/2}\longrightarrow0.
\tag{8}
\]
Translation preserves this estimate. Comparing (4) and (8) proves
\[
\liminf_R\left\|g_R-
 \frac{d_{N_R}(\cdot-s_R)}{\|d_{N_R}\|_2}\right\|_2
\ge\frac{\sqrt3}{2}
\quad\text{for every choice of real translations }s_R.
\tag{9}
\]

The same separation holds for the **normalized actual ground-averaged
readout** $\mathcal A_Rd_{N_R}/\|\mathcal A_Rd_{N_R}\|_2$. Its Fourier
multiplier has modulus at most two, so (8) pays its high-frequency
tail. Its norm is $(\sqrt2+o(1))\|d_{N_R}\|_2$: the proof of the
direct moving readout applies at $R=2U_R+O(e^{-U_R})$, since the
localized packet has support width $7U_R/2<2R$ and its derivative
ratio is $O(U_R)$. Hence (9) holds with this averaged packet in place
of the translated packet too.

## Cost of matching the full ground autocorrelation

The distinction between a scalar norm and a quadratic form can be
made quantitative. In the same unitary Fourier convention, let
$f_j,h_j\in L^2(\mathbb R)$ be any finite or countable family with
$\sum_j\|f_j\|_2\|h_j\|_2<\infty$. Suppose their signed heat-pair
spectrum matches the normalized actual ground autocorrelation on the
high band to $L^1$ error at most $1/4$:
\[
\int_{|\xi|>B_R}
\left||\widehat g_R(\xi)|^2
 -|m(\xi)|^2\sum_j\widehat f_j(\xi)
                       \overline{\widehat h_j(\xi)}\right|d\xi
\le\frac14.
\tag{10}
\]
The common Fourier-convolution normalization cancels between a
ground autocorrelation and each filtered heat pair. By (4), the
ground spectrum has high-band integral at least $3/4$. The triangle
inequality, (5), Cauchy--Schwarz and Tonelli therefore force
\[
\boxed{\quad
\sum_j\|f_j\|_2\|h_j\|_2
\ge c\frac{e^{\pi B_R}}{(1+B_R)^2}
\ge\exp\!\left(c_d'\frac{e^R}{R}\right)
\quad}
\tag{11}
\]
for every fixed $0<c_d'<\pi^2/(32d)$ and large selected $R$.
The same inequality with $h_j=f_j$ is the positive Gram-factor cost.
It covers signed two-source decompositions as well: cancellation
between pairs cannot reduce their total factor norm below (11) if
the full high-band autocorrelation is retained. Since $g_R$ is real
and even, its nonconjugated convolution has the same nonnegative
Fourier target; replacing $|m|^2$ by $m^2$ in (10) gives (11) again
because their moduli agree.

This is a shape and normalization obstruction for the specified heat
filter and positive ground average. It neither contradicts the exact
finite Goldbach Gram measurement nor bounds that Gram. A signed
complete-history operator linking the arithmetic heat response to
the odd affine theta residual would need additional information; the
scalar positive readout does not pay the costs in (6) or (11).
The displayed moving-ground separation is written analysis, not a
Lean formalization.
