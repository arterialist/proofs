# Boundary leakage in smooth frequency cuts of the compact Weil form

A spatial bound for the prime-shift operator applies to functions supported in
the window. A smooth Fourier cutoff does not preserve that support. This note
computes the resulting boundary commutator for the **actual finite prime-power
sum**, gives an all-test phase-space inequality with the leakage retained, and
exhibits boundary packets on which the commutator has its full order of
magnitude. The result concerns a perturbative frequency-localization route; it
does not establish a new window of Weil positivity or a lower bound on every
possible certificate's frequency scale.

## Operators and the compact-support bound

Fix \(L>\frac12\log 2\), let \(I=[-L,L]\), and let \(M\) denote
multiplication by \(\mathbf 1_I\) on \(L^2(\mathbb R)\). Put
\[
 y_n=\log n,\qquad c_n=\frac{2\Lambda(n)}{\sqrt n},\qquad
 U_yh(x)=h(x-y),\qquad
 S_L=\frac12\sum_{2\le n<e^{2L}}c_n(U_{y_n}+U_{-y_n}),
 \qquad K_L=MS_LM\big|_{L^2(I)}.
 \tag{1}
\]
Thus the full-line symbol is
\(P_L(t)=\sum c_n\cos(t y_n)\), and
\(\|S_L\|=A_L:=\sum c_n=(4+o(1))e^L\).
For \(f\) supported in \(I\), the overlap of \(f(x)\) and
\(f(x+y)\) has real part at most \(\|f\|_2^2\), or at most
\(\|f\|_2^2/2\) when \(y\ge L\), because the two overlap intervals
are disjoint. Consequently
\[
 \langle f,K_Lf\rangle\le B_L\|f\|_2^2,\qquad
 B_L=\sum_{y_n<L}c_n+\frac12\sum_{L\le y_n<2L}c_n
 =(2+o(1))e^L.
 \tag{2}
\]
This collar bound is convenient but not best: the previously proved
[weighted spatial Schur theorem](prime-shift-weighted-schur-window-asymptotic.md)
gives \(\kappa_L:=\|K_L\|=(1+o(1))e^L\). Both bounds require compact
support. Neither may be applied directly to a full-line Fourier-cut piece.

For a real \(f\in C_c^\infty(I)\), the geometric Weil form in
[Zhu's normalization](https://arxiv.org/html/2608.24827v2) is
\[
 Q_L(f)=2E_+(f)E_-(f)
 +\frac1{2\pi}\int_{\mathbb R}H(t)|\widehat f(t)|^2\,dt
 -\langle f,K_Lf\rangle,
 \quad E_\pm(f)=\int_I f(x)e^{\pm x/2}\,dx,
 \quad H(t)=\Re\psi\!\left(\frac14+\frac{it}{2}\right)-\log\pi.
 \tag{3}
\]
Here \(\widehat f(t)=\int f(x)e^{itx}dx\). The pole term
\(2E_+E_-\) is kept intact throughout. It changes sign on odd real
tests and must not be silently dropped.

## Exact leakage and a phase-space inequality

Choose a smooth even angle \(\theta\), equal to \(0\) on \([-1,1]\)
and \(\pi/2\) outside \([-2,2]\), with values in \([0,\pi/2]\).
Set \(m_0=\cos\theta\), \(m_1=\sin\theta\), and
\(P_{j,T}=m_j(D/T)\). Thus \(m_0^2+m_1^2=1\), while
\(P_{0,T}\) is a smooth low-frequency multiplier. For a supported
\(f\), define
\[
 u_j=MP_{j,T}f,\quad v_j=(1-M)P_{j,T}f,\quad
 D_T(f)=\sum_{j=0}^1\|v_j\|_2^2,\quad
 R_L=\left(\sum_{2\le n<e^{2L}}c_n^2\right)^{1/2}.
 \tag{4}
\]
The full-line Fourier split and its compressed norm defect are exact:
\[
 \sum_j\|u_j\|_2^2=\|f\|_2^2-D_T(f),\qquad
 \langle f,K_Lf\rangle=\sum_j\langle P_{j,T}f,S_LP_{j,T}f\rangle.
 \tag{5}
\]
Writing \(C_{j,T}=MS_L(1-M)P_{j,T}M\), expansion of the second
identity gives
\[
 \langle f,K_Lf\rangle
 =\sum_j\left\{\langle u_j,K_Lu_j\rangle
   +2\Re\langle u_j,C_{j,T}f\rangle
   +\langle v_j,S_Lv_j\rangle\right\}.
 \tag{6}
\]
For \(j=1\), the exterior part of the identity multiplier vanishes,
so \(C_{1,T}\) has the Schwartz kernel of \(m_1-1\). The
Hilbert--Schmidt estimate proved below for either kernel gives, for
\(T\ge e^{2L}\),
\(\|C_{j,T}\|\le C_\theta R_L\). Cauchy--Schwarz in (6),
\(\langle u_j,K_Lu_j\rangle\le\kappa_L\|u_j\|_2^2\), and
\(\|S_L\|=A_L\) yield the concrete all-test bound
\[
 \boxed{\quad
 \langle f,K_Lf\rangle\le
 \kappa_L(\|f\|_2^2-D_T(f))+A_LD_T(f)
 +C_\theta R_L\|f\|_2
       \sqrt{\|f\|_2^2-D_T(f)}.
 \quad}
 \tag{7}
\]
One may replace \(\kappa_L\) by the elementary \(B_L\) from (2).
The generic constant \(C_\theta\) absorbs the factor \(2\sqrt2\)
from the two cross terms and is independent of \(L,T,f\). Inequality
(7) holds for every \(f\in L^2(I)\). The formula
keeps the leaked mass instead of pretending that the compressed pieces
form an orthogonal partition.

The gamma contribution splits exactly because the multipliers commute
with \(H(D)\):
\[
 Q_L(f)=2E_+(f)E_-(f)
 +\sum_j\frac1{2\pi}\int_{\mathbb R}
       H(t)|\widehat{P_{j,T}f}(t)|^2\,dt
 -\sum_j\left\{\langle u_j,K_Lu_j\rangle
 +2\Re\langle u_j,C_{j,T}f\rangle
 +\langle v_j,S_Lv_j\rangle\right\}.
 \tag{8}
\]
The projected pieces have Schwartz spatial tails, which need not be
integrable against \(e^{|x|/2}\); the pole in (8) is therefore
evaluated on the original compactly supported \(f\), not on the pieces.
Combining (7) and (8) gives a lower bound for \(Q_L(f)\) with exactly
the displayed pole and gamma terms and with the negative of the
right-hand side of (7) as its prime contribution.

## A sharp boundary commutator

Write \(P_T=P_{0,T}\), \(E_{L,T}=MP_TM|_{L^2(I)}\), and
\(C_T=MS_L(1-M)P_TM\). Since \(S_L\) and \(P_T\) commute on the
whole line, multiplication by \(M+(1-M)=1\) gives the exact identity
\[
 \boxed{\quad [K_L,E_{L,T}]=C_T^*-C_T.\quad}
 \tag{9}
\]
The two terms are the flux through the window boundary; they cannot be
removed by commuting full-line Fourier multipliers before compression.

Let \(k=\mathcal F^{-1}m_0\), so \(P_T\) has convolution kernel
\(T k(Tx)\). Since \(m_0\ge0\) is not zero, \(k(0)>0\). Choose a
nonnegative real \(\phi\in C_c^\infty(0,1)\) with \(\|\phi\|_2=1\),
supported sufficiently close to zero, and put
\[
 h(v)=\int_0^1 k(v+u)\phi(u)\,du,\qquad
 d^2=\int_0^\infty|h(v)|^2\,dv>0,\qquad
 f_{T,L}^{R}(x)=\sqrt T\,\phi(T(L-x)).
 \tag{10}
\]
For \(T>1/(2L)\), this is a norm-one smooth packet inside \(I\).
At \(x=L+v/T\), \(v>0\), direct scaling gives
\((P_Tf_{T,L}^{R})(x)=\sqrt T\,h(v)\), and hence the *exact*
leakage identity
\[
 \|(1-M)P_Tf_{T,L}^{R}\|_2^2\ge
 \|\mathbf1_{(L,\infty)}P_Tf_{T,L}^{R}\|_2^2=d^2.
 \tag{11}
\]
In particular \(\|[M,P_T]\|\ge d\), and \(D_T(f_{T,L}^{R})\ge d^2\),
independently of the cutoff height.

For every fixed \(L\), the same packet gives
\[
 \boxed{\quad
 \lim_{T\to\infty}
 \|[K_L,E_{L,T}]f_{T,L}^{R}\|_2^2
 =\frac{d^2}{4}\sum_{2\le n<e^{2L}}c_n^2.
 \quad}
 \tag{12}
\]
Indeed, \(C_Tf_{T,L}^{R}\) receives the right exterior leakage in
(11). Its \(U_{-y_n}\) term places it at the interior center
\(L-y_n\), with local profile
\((c_n/2)\sqrt T\,h(v)\mathbf1_{v>0}\). The \(U_{y_n}\) term
cannot carry this right exterior packet back into \(I\). Conversely
\(C_T^*f_{T,L}^{R}\to0\) faster than any power of \(T^{-1}\):
\(S_Lf_{T,L}^{R}\) has right exterior packets centered at
\(L+y_n\), a fixed positive distance from \(I\); its other packets
are strictly inside \(I\) because \(y_n<2L\). Distinct interior
centers \(L-y_n\) remain separated for fixed \(L\), so their
\(L^2\) cross terms vanish by Schwartz decay. Squaring the surviving
profiles proves (12).

The witness exists in both parity sectors. Let \(Jf(x)=f(-x)\) and,
for large \(T\), set
\(f_{T,L}^{\pm}=(f_{T,L}^{R}\pm Jf_{T,L}^{R})/\sqrt2\).
They are normalized real smooth even/odd packets. The commutator
commutes with \(J\). If a right output center coincides with a
reflected left output center, their limiting local profiles lie on
opposite sides of that center; otherwise their centers are separated.
Thus the reflected cross term tends to zero, and (12) holds with
\(f_{T,L}^{\pm}\) in place of \(f_{T,L}^{R}\).

## Uniform upper bound and its scale

For \(y>0\), the kernel of \(MU_y(1-M)P_TM\) is
\[
 \mathbf1_I(x)\mathbf1_{x-y<-L}\mathbf1_I(z)
 \;T k(T(x-y-z)).
 \tag{13}
\]
If \(y\ge y'>0\), changing variables at the left boundary and
extending the resulting nonnegative integral gives
\[
 \left|\left\langle MU_y(1-M)P_TM,
                    MU_{y'}(1-M)P_TM\right\rangle_{HS}\right|
 \le\Phi\bigl(T(y-y')\bigr),\qquad
 \Phi(a)=\int_0^\infty r|k(r+a)k(r)|\,dr.
 \tag{14}
\]
Indeed, if \(x=-L+s\), \(z=-L+u\), then on the common kernel support
\(0\le s\le y'\), \(u\ge0\); with
\(r=T(y'+u-s)\), the other kernel argument is \(r+T(y-y')\).
The available \(s\)-length at fixed \(r\) is at most \(r/T\),
which proves (14) with no extra \(T\) or \(L\) factor. The right
boundary and \(U_{-y}\) have the reflected bound. Since \(k\) is
Schwartz, \(\Phi(a)\ll_{\theta,N}(1+a)^{-N}\) for every \(N\).

For distinct integers \(n,m<e^{2L}\),
\(|\log n-\log m|\ge |n-m|e^{-2L}\). Thus if \(T\ge e^{2L}\),
the Gram matrix \(\Phi(T|y_n-y_m|)\) has uniformly bounded row sums.
Schur's inequality applies to each shift orientation separately;
the two orientation norms are then combined by the triangle inequality.
The same proof works with the Schwartz kernel of \(m_1-1\), and yields
\[
 \|C_{j,T}\|\le\|C_{j,T}\|_{HS}\le C_\theta R_L,
 \qquad
 \|[K_L,E_{L,T}]\|\le 2C_\theta R_L
 \quad(T\ge e^{2L}).
 \tag{15}
\]
By the prime number theorem and convergence of the higher-prime-power
square sum,
\[
 R_L^2=4\sum_{n<e^{2L}}\frac{\Lambda(n)^2}{n}
 =8L^2+o(L^2).
 \tag{16}
\]
Equations (12), (15), and (16) give the matching bounds
\[
 \frac d2 R_L\le
 \liminf_{T\to\infty}\|[K_L,E_{L,T}]\|
 \le\limsup_{T\to\infty}\|[K_L,E_{L,T}]\|
 \le 2C_\theta R_L.
 \tag{17}
\]
Their scale is linear in \(L\). The lower limit is taken at each
fixed \(L\); it is not claimed uniform for merely \(T\ge e^{2L}\)
while \(L\) varies, because a shift may lie arbitrarily close to
\(2L\).

## What this rules out

The deficit in (5) is order one on the constructed smooth packets,
and the compressed prime-shift commutator has order \(L\), even on
real even packets. Therefore a scalar perturbation argument that
replaces the actual prime term by compact-support bounds on its
frequency-cut pieces **with an \(o(1)\) interface error** is false.
If (7) is reduced to a scalar bound by allowing
\(D_T(f)\le\|f\|_2^2\), it still contains \(A_L\); that step alone
does not lower Zhu's pointwise-envelope threshold
\(2\pi\exp(A_L)=2\pi\exp((4+o(1))e^L)\). This does not prove that
every phase-space certificate has that threshold. A treatment that
keeps and resolves the boundary transition operator could, in
principle, use the smaller spatial norm \(\kappa_L\); no such
all-window positivity certificate is supplied here.

The boundary transition is the same time--frequency concentration
phenomenon studied by [Slepian and Pollak](https://www.math.ucdavis.edu/~saito/data/ONR15/PSWF-I.pdf)
and [Landau and Pollak](https://www.math.ucdavis.edu/~saito/data/ONR15/PSWF-II.pdf),
here coupled to the finite prime shifts. Zhu's
[failed-routes discussion, Section 15](https://arxiv.org/html/2608.24827v2)
reports order-one coupling across hard Legendre-order cuts; (9)--(16)
give an exact smooth-frequency counterpart and quantify its dependence
on the complete prime-power coefficients. These are written operator
estimates, not Lean formalizations or a claim of literature priority.
