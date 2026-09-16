# A moving actual-ground core recovers the complete centered heat Gram

This written theorem lets the arithmetic source cutoff and the actual killed-ground radius grow together. It strengthens the fixed-packet ground readout in [the heat-to-scaling bridge](actual-heat-scaling-derivative-bridge.md) for one specified cutoff schedule. It retains every prime power, the initial density atom, the continuous density and the terminal compensation. This compact cumulative-error source differs from the purely discrete coefficient packet $\Lambda(n)-1$; their exact comparison appears below. The result is a norm identity, not a bound on that norm or a proof of RH.

Let \(U>0\), \(X=e^U\), and \(E(x)=\psi(x)-x\). Define the finite signed measure
\[
d\sigma_U=1_{[1,X]}d\psi-1_{[1,X]}dx-\delta_1-E(X)\delta_X.
\tag{1}
\]
The cutoff convention includes any prime-power atom at \(X\) before inserting the terminal compensation. Its total mass is exactly zero. Put
\[
C_U(t)=\int e^{-tx}\,d\sigma_U(x),\qquad
b_U(v)=e^{-v/2}C_U(e^{-v}),
\qquad H_U=\|b_U\|_{L^2(\mathbb R)}^2.
\tag{2}
\]
Equivalently, with \(a(u)=e^{-u/2}E(e^u)1_{u\ge0}\), \(a_U=a1_{[0,U]}\), and \(k(y)=e^{-3y/2}e^{-e^{-y}}\), the exact Stieltjes identity gives
\[
C_U(t)=t\int_1^X E(x)e^{-tx}dx,
\qquad b_U=k*a_U.
\tag{3}
\]
The initial value \(E(1)=-1\) is the \(-\delta_1\) in (1). Both descriptions retain the terminal value \(E(X)\).
At every integer cutoff \(X=N\ge1\), [ActualCompactHeatEndpoint.lean](BuildingBlocks/ActualCompactHeatEndpoint.lean)
now compiles the exact first identity in (3), identifies the compact source
with the existing finite source minus its frozen terminal charge, and proves
zero total charge at \(t=0\). The real-cutoff, ground, and asymptotic steps
below remain written mathematics.

For each sufficiently large radius \(R\), let \(G_R\) be the actual positive even physical killed ground, \(m_R=\int G_R>0\), and
\[
\mathcal A_Rf(v)=\frac1{m_R}\int G_R(u)[f(v+u)+f(v-u)]du.
\tag{4}
\]
The [physical concentration theorem](theta-ground-physical-mass-concentration.md) gives \(w_R=e^{-\sqrt R/8}\), \(T_R=R+6w_R\), and a probability tail
\[
\eta_R:=m_R^{-1}\int_{|u|>T_R}G_R(u)du
\ll\exp[-c e^{2R}w_R+Ce^R]
\tag{5}
\]
for fixed positive constants and all large \(R\). In particular \(\eta_R\) decays faster than \(e^{-R}\).

**Moving-core theorem.** For the actual cutoff \(b_U\), take \(R=2U\). Then
\[
\boxed{\quad
\|\mathcal A_{2U}b_U\|_2^2
=\left[2+O\!\left(Ue^{-\sqrt{2U}/8}+e^{-U/4}\right)\right]H_U
\qquad(U\to\infty).
\quad}
\tag{6}
\]
The constants are independent of \(U\). Moreover the finite centered additive Gram is exactly
\[
\boxed{\quad
H_U=\int_0^\infty C_U(t)^2dt
=\iint_{[1,X]^2}\frac{d\sigma_U(x)d\sigma_U(y)}{x+y}\ge0.
\quad}
\tag{7}
\]
Thus one growing actual core recovers twice the **complete finite centered heat energy**, without averaging radii or freezing the arithmetic cutoff. The normalization \(m_R\) belongs inside (4); (6) does not bound the unnormalized ground row.

For comparison with the literal finite Goldbach coefficients, let $N\ge2$ be an integer, set $U=\log N$, $a_n=\Lambda(n)-1$, and write
\[
D_N(t)=\sum_{n=1}^Na_ne^{-nt},\qquad
H_N^{\rm disc}=\int_0^\infty D_N(t)^2dt
=\sum_{m,n\le N}\frac{a_ma_n}{m+n}.
\]
The [exact density-cell decomposition](goldbach-additive-source-consumer.md#4-preserve-continuous-density-cells-before-entering-the-source-norm) gives
\[
C_U(t)=D_N(t)+R_N(t)-E(N)e^{-Nt},\qquad
R_N(t)=-t\int_1^N\{x\}e^{-tx}dx.
\]
Indeed the signed cell correction has cumulative mass $-\{x\}$ on $1\le x<N$ and zero after $N$. Thus $|R_N(t)|\le e^{-t}$, and the $L^2(dt)$ triangle inequality yields the explicit endpoint payment
\[
\boxed{\quad
\left|\sqrt{H_{\log N}}-\sqrt{H_N^{\rm disc}}\right|
\le\frac1{\sqrt2}+\frac{|\psi(N)-N|}{\sqrt{2N}}.
\quad}
\tag{7a}
\]
Equation (7a) keeps the density cells and frozen terminal charge separate. Neither term may be silently deleted when relating the moving-core identity to the ordered discrete Goldbach sum.

## Proof of the moving limit

Chebyshev gives \(|a(u)|\ll e^{u/2}\), hence \(\|a_U\|_2\ll e^{U/2}\). The Gamma multiplier of \(k\), in the unitary Fourier convention, is \(\Gamma(3/2+i\omega)\). Its [exact modulus](https://dlmf.nist.gov/5.4) and the recurrence imply, for \(\Omega\ge2\),
\[
\|b_U'\|_2\le\Omega\|b_U\|_2
+C(1+\Omega)^2e^{-\pi\Omega/2}\|a_U\|_2.
\tag{8}
\]
The full heat profile \(b=k*a\) is nonzero: as \(t\to\infty\), its unnormalized source satisfies \(C(t)=-(1+t^{-1})e^{-t}+O(e^{-2t})\), since \(\Lambda(1)=0\). The superexponential negative-age tail of \(k\) makes \(b_U\to b\) locally in \(L^2\). Therefore \(\|b_U\|_2\ge c_0>0\) for all large \(U\). Taking \(\Omega=2U/\pi\) in (8) gives
\[
\|b_U'\|_2/\|b_U\|_2\ll U.
\tag{9}
\]

Write \(B_Rf(v)=f(v+R)+f(v-R)\). For \(|u|\in[R,T_R]\), translation continuity in \(H^1\) gives
\(\|[f(\cdot+u)+f(\cdot-u)]-B_Rf\|_2\le12w_R\|f'\|_2\). On the remaining physical probability mass the same difference is at most \(4\|f\|_2\). Hence
\[
\|\mathcal A_Rf-B_Rf\|_2
\le12w_R\|f'\|_2+4\eta_R\|f\|_2.
\tag{10}
\]
Equation (9) makes this \(O(Uw_{2U}+\eta_{2U})\|b_U\|_2\) at \(R=2U\).

For separation of the two pure shifts, set \(L=U/2\) and let \(f_U^0=b_U1_{[-L,U+L]}\). The support of \(a_U\) is \([0,U]\), while
\[
\int_L^\infty |k(y)|dy\ll e^{-3L/2},
\qquad
\int_{-\infty}^{-L}|k(y)|dy\ll e^{-e^L/2}.
\]
Young's inequality gives
\[
\|b_U-f_U^0\|_2\ll e^{U/2}e^{-3U/4}
=e^{-U/4}.
\tag{11}
\]
At \(R=2U\), the supports of \(f_U^0(\cdot+R)\) and \(f_U^0(\cdot-R)\) are disjoint. Since \(\|b_U\|_2\ge c_0\), (11) implies
\[
\|B_{2U}b_U\|_2^2
=\bigl(2+O(e^{-U/4})\bigr)\|b_U\|_2^2.
\tag{12}
\]
Both \(\mathcal A_R\) and \(B_R\) have operator norm at most two. Combining (10), (12), and the superexponential tail (5) proves (6).

For (7), change variables \(t=e^{-v}\) in (2). The finite signed measure \(\sigma_U\) has compact support in \([1,X]\), so Fubini applies absolutely to \(\int_0^\infty C_U(t)^2dt\), and \(\int_0^\infty e^{-t(x+y)}dt=1/(x+y)\). This proves both equalities and nonnegativity without dropping any signed cross term.

## Exact growth exponent and remaining obstacle

Let \(\Theta=\sup\{\Re\rho:\zeta(\rho)=0,\ 0<\Re\rho<1\}\). The [actual zero-abscissa estimate](zero-abscissa-scattering-growth.md) gives
\(|a(u)|\ll e^{(\Theta-1/2)u}(1+u)^2\); Young's inequality yields
\[
H_U\ll(1+U)^5e^{(2\Theta-1)U}.
\tag{13}
\]
For the reverse exponential rate, the full heat profile obeys the exact tail estimate from [the heat-to-scaling bridge](actual-heat-scaling-derivative-bridge.md):
\[
|b(v)-b_U(v)|\ll e^{v/2}(1+e^{U-v})e^{-e^{U-v}}
\qquad(v\le U).
\tag{14}
\]
Taking \(0\le v\le U-\log U\), its \(L^2\) norm is \(O(Ue^{-U/2})\). The original accumulated energy \(\mathscr A(T)=1+\int_0^T|b(v)|^2dv\) therefore satisfies
\[
\mathscr A(U-\log U)\le1+2H_U+O(U^2e^{-U}).
\tag{15}
\]
The [critical heat theorem](critical-heat-lyapunov-exponent.md) proves \(\limsup_{T\to\infty}T^{-1}\log\mathscr A(T)=2\Theta-1\). Since \(U-\log U\sim U\), equations (13)--(15), then (6), give the exact actual-ground calibration
\[
\boxed{\quad
\limsup_{U\to\infty}\frac1U
\log\!\bigl(1+\|\mathcal A_{2U}b_U\|_2^2\bigr)
=2\Theta-1.
\quad}
\tag{16}
\]
No maximum zero is assumed.

## An odd companion needs only a logarithmic-squared radius

The [actual sign-weighted odd channel](actual-heat-scaling-derivative-bridge.md#the-odd-companion-recovers-the-phase-at-each-large-core) uses the same positive ground:
\[
\mathcal A_R^-f(v)=m_R^{-1}\int\operatorname{sgn}(u)G_R(u)
 [f(v+u)-f(v-u)]du,
\qquad \mathcal A_R^+=\mathcal A_R.
\tag{17}
\]
Let \(p_R\) be the probability density \(2G_R(u)1_{u>R}/m_R\), and set
\(\zeta_R^2=\int_{u>R}(u-R)^2dp_R(u)\). The exact even-plus-odd Fourier identity and physical concentration prove, for every \(f\in H^1(\mathbb R)\),
\[
0\le4\|f\|_2^2-\|\mathcal A_R^+f\|_2^2
-\|\mathcal A_R^-f\|_2^2
\le4\zeta_R^2\|f'\|_2^2,
\qquad
\zeta_R^2\le36w_R^2+O(\eta_R^{\rm wt}),
\tag{18}
\]
where \(\eta_R^{\rm wt}:=m_R^{-1}\int_{|u|>T_R}e^{|u|-R}G_R(u)du\). This is bounded by (13) of the physical concentration theorem with weight exponent one and is superexponentially smaller than \(w_R^2\). Equation (9) therefore lets the radius grow far more slowly when both channels are retained. For example, take
\[
R(U)=100\log^2(2+U),\qquad w_{R(U)}=(2+U)^{-5/4}.
\]
Then \(U^2\zeta_{R(U)}^2=O(U^{-1/2})\), so the **complete moving arithmetic source** satisfies
\[
\boxed{\quad
0\le4H_U-\bigl(\|\mathcal A_{R(U)}^+b_U\|_2^2
                 +\|\mathcal A_{R(U)}^-b_U\|_2^2\bigr)
\le C U^{-1/2}H_U.
\quad}
\tag{19}
\]
This two-channel readout recovers four times the finite centered Gram at a logarithmic-squared core and has the same exact growth exponent \(2\Theta-1\). It does not identify the odd translation norm with the conditional theta covariance residual.

Both (16) and (19) are RH-equivalent **measurement criteria**, not unconditional bounds showing that their exponent vanishes. Neither estimates the actual full Weil affine residual nor turns killed-ground positivity into a prime-error sign. Apart from the integer-cutoff endpoint identity noted after (3), the analytic theorems and ground concentration remain written mathematics, not Lean formalizations.

## Direct finite Goldbach readout without a terminal atom

The terminal payment in (7a) belongs to the comparison between the
compact cumulative-error source and the discrete packet. The finite
Goldbach energy itself has a direct moving-core readout. For integer
$N\ge2$ and $U=\log N$, retain every $a_n=\Lambda(n)-1$ for $n\le N$,
including $a_1=-1$, and put
\[
d_N(v)=e^{-v/2}\sum_{n=1}^Na_ne^{-ne^{-v}},\qquad
H_N^{\rm disc}=\|d_N\|_2^2
=\sum_{m,n\le N}\frac{a_ma_n}{m+n}.
\tag{20}
\]
For the same actual ground and normalization as (4),
\[
\boxed{\quad
\|\mathcal A_{2U}d_N\|_2^2
=\left[2+O\!\left((1+U)e^{-\sqrt{2U}/8}
                  +(1+U)e^{-U/8}\right)\right]H_N^{\rm disc}
\qquad(N\to\infty).
\quad}
\tag{21}
\]
No $E(N)\delta_N$ is inserted into (20). This bypasses (7a) for a
measurement of $H_N^{\rm disc}$; it does not estimate the energy.

Here are the cutoff and endpoint estimates. With
$k_0(y)=e^{-y/2}e^{-e^{-y}}$,
\[
d_N=k_0*\sum_{n\le N}\frac{a_n}{\sqrt n}\delta_{\log n},
\qquad
M_N:=\sum_{n\le N}\frac{|a_n|}{\sqrt n}
\ll (1+U)e^{U/2}.
\tag{22}
\]
The last bound uses only $\Lambda(n)\le\log n$. The norm has an
$N$-independent lower bound: for a fixed sufficiently large $t_0$,
\[
\left|\sum_{n=2}^Na_ne^{-nt}\right|
\le\sum_{n=2}^\infty(1+\log n)e^{-nt}
\le\tfrac12e^{-t}\quad(t\ge t_0),
\]
so $|\sum_{n\le N}a_ne^{-nt}|\ge e^{-t}/2$ there and
$H_N^{\rm disc}\ge e^{-2t_0}/8>0$.

The unitary Fourier transform of $k_0$ is
$(2\pi)^{-1/2}\Gamma(1/2+i\omega)$, whose squared modulus is
$1/(2\cosh(\pi\omega))$. Frequency splitting therefore gives, for
$\Omega\ge1$,
\[
\|d_N'\|_2\le\Omega\|d_N\|_2
 +C M_N(1+\Omega)e^{-\pi\Omega/2}.
\tag{23}
\]
At $\Omega=2U/\pi$, (22) and the lower bound imply
$\|d_N'\|_2/\|d_N\|_2\ll U$.

Set $L=5U/4$ and $d_N^0=d_N1_{[-L,U+L]}$. Both packet tails are paid:
\[
\|k_0 1_{y>L}\|_2\le e^{-L/2},\qquad
\|k_0 1_{y<-L}\|_2=2^{-1/2}e^{-e^L},\qquad
\|d_N-d_N^0\|_2\ll(1+U)e^{-U/8}.
\tag{24}
\]
The support interval has width $U+2L=7U/2<4U$, so the shifts
$d_N^0(\cdot+2U)$ and $d_N^0(\cdot-2U)$ are disjoint. The lower norm
bound and (24) give
$\|B_{2U}d_N\|_2^2=[2+O((1+U)e^{-U/8})]H_N^{\rm disc}$.
Finally apply the physical-ground translation estimate (10), (23) and
the tail (5) at $R=2U$ to obtain (21).

The two-channel identity (18) also applies directly to $d_N$.
At $R(U)=100\log^2(2+U)$, the same derivative estimate yields
\[
0\le4H_N^{\rm disc}
-\bigl(\|\mathcal A_{R(U)}^+d_N\|_2^2
       +\|\mathcal A_{R(U)}^-d_N\|_2^2\bigr)
\le C U^{-1/2}H_N^{\rm disc}.
\tag{25}
\]
Both readouts retain the exact ordered Goldbach Gram. Neither is a
prime-error upper bound or a sign for the full Weil row. The
[moving frequency-separation theorem](actual-moving-heat-ground-frequency-separation.md)
quantifies why this positive scalar readout does not approximate the
actual killed ground in physical $L^2$ at an affordable heat-input cost.
