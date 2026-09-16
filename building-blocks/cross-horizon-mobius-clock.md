# Cross-horizon identities for the hard Möbius reserve

Fix one scale $X>0$ and retain its literal moving window

\[
 D=D_X=\lceil\sqrt X\rceil,
 \qquad T=T_X=\lceil X\log X\rceil.
\]

For an integer horizon $N\ge0$, set

\[
 B_N=\sum_{\substack{D<d<T\\d\le N}}\mu(d).
\]

Then the exact one-step and annular identities are

\[
 \boxed{B_{N+1}-B_N
 =\mu(N+1)1_{\{D<N+1<T\}},}                            \tag{1}
\]

\[
 \boxed{B_{2N}-B_N
 =\sum_{\substack{N<d\le2N\\D<d<T}}\mu(d).}           \tag{2}
\]

For the capacity function

\[
 \Psi_N(x)=
 \frac{((|x|-N^{-1})_+)^2}
 {\log(eN/(|x|+N^{-1}))},
\]

the exact differences are therefore

\[
 \boxed{
 \Psi_{N+1}(B_N+\mu(N+1)1_{\{D<N+1<T\}})-\Psi_N(B_N)} \tag{3}
\]

and, with

\[
 A_N=\sum_{\substack{N<d\le2N\\D<d<T}}\mu(d),
\]

\[
 \boxed{\Psi_{2N}(B_N+A_N)-\Psi_N(B_N).}               \tag{4}
\]

These are identities, not monotonicity statements.  The change of the
threshold $N^{-1}$ and of the logarithmic denominator is part of (3)--(4).

If the outer scale changes as well, no endpoint may be suppressed.  For two
windows $W_X=\{D_X<d<T_X\}$, $W_Y=\{D_Y<d<T_Y\}$,

\[
\begin{aligned}
 B_{Y,N'}-B_{X,N}
={}&\sum_{\substack{d\in W_Y\setminus W_X\\d\le N'}}\mu(d)
-\sum_{\substack{d\in W_X\setminus W_Y\\d\le N}}\mu(d)\\
&+\sum_{d\in W_X\cap W_Y}\mu(d)
 \bigl(1_{\{d\le N'\}}-1_{\{d\le N\}}\bigr).
                                                               \tag{5}
\end{aligned}
\]

The first two sums in (5) are the moving-$T$ and moving-$D$ commutator
faces.  Thus a dyadic comparison that freezes either endpoint is not the
actual scale difference.

## 1. Exact clock-field coboundary

Retain the future prefixes

\[
 F_a(N)=\sum_{\substack{D<d<T\\ad\le N}}\mu(d)
\]

and define, for $0\le q<1$,

\[
 G_N(q)=(1-q)\sum_{a\ge1}F_a(N)q^{a-1}.
\]

All sums at fixed $N$ are finite.  Reversing the finite divisor order gives

\[
 \boxed{G_N(q)=
 \sum_{\substack{D<d<T\\d\le N}}
 \mu(d)\bigl(1-q^{\lfloor N/d\rfloor}\bigr).}          \tag{6}
\]

Consequently

\[
 \boxed{
 \Delta_NG(q):=G_N(q)-G_{N-1}(q)
 =(1-q)\sum_{\substack{d\mid N\\D<d<T}}
 \mu(d)q^{N/d-1}.}                                      \tag{7}
\]

Equation (7) is the genuine cross-horizon boundary-of-boundary term.  It
contains every divisor face that reaches the horizon $N$, with its actual
Möbius sign.

For real $q$,

\[
 \boxed{
 |G_N(q)|^2-|G_{N-1}(q)|^2
 =2G_{N-1}(q)\Delta_NG(q)+|\Delta_NG(q)|^2.}            \tag{8}
\]

After integration against the original nonnegative clock measure, (8) remains
an exact Hilbert-space coboundary.  There is no automatic martingale sign.

## 2. Exact two-dimensional face cell

For a prime $p$ and $1\le N<T$, let $r_N=\lfloor N/p\rfloor$ and retain

\[
 U_p(N)=\sum_{\substack{\max(D,r_N)<m\le N\\p\nmid m}}\mu(m),
\quad
 L_p(N)=\sum_{\substack{\lfloor D/p\rfloor<m\le\min(D,r_N)\\p\nmid m}}
 \mu(m).
\]

Writing $\delta_N=1_{\{p\mid N\}}$, direct endpoint subtraction gives

\[
\begin{aligned}
 U_p(N)-U_p(N-1)
={}&\mu(N)1_{\{p\nmid N\}}\\
&-\delta_N\,1_{\{r_{N-1}\ge D\}}
 1_{\{p\nmid r_N\}}\mu(r_N),\\
 L_p(N)-L_p(N-1)
={}&\delta_N\,1_{\{r_{N-1}<D\}}
 1_{\{p\nmid r_N\}}\mu(r_N).                           \tag{9}
\end{aligned}
\]

The two moving cofactor faces in (9) combine exactly:

\[
 \boxed{
 \Delta_N(U_p-L_p)=\mu(N)1_{\{D<N\}}.}                 \tag{10}
\]

When $p\mid N$ and $p\nmid N/p$, this uses
$\mu(N)=-\mu(N/p)$; when $p^2\mid N$, both sides vanish.  Equation (10)
is a genuine boundary-of-boundary cancellation on each $(p,N)$ cell.  But
averaging it over primes repeats the same $\mu(N)$; it does not reduce its
size or sign the quadratic cross.

At $N=T$, the hard-window prefix saturates and the additional upper
boundary commutator must be retained separately.  This is the moving
(T)-face already displayed in (5).

## 3. A sufficient signed cross-horizon inequality

The exact grouping of the $y$-integral into the cells
([N/X,(N+1)/X)) gives

\[
 \mathfrak A_X^{\rm bulk}
 =\sum_{N\ge0}\omega_X(N)\,\|G_N\|_{\rm clock}^2,
 \qquad
 \omega_X(N)=e^{-2N/X}-e^{-2(N+1)/X}.                  \tag{11}
\]

Put

\[
 R_N=
 \left(2\langle G_{N-1},\Delta_NG\rangle_{\rm clock}
       +\|\Delta_NG\|_{\rm clock}^2\right)_+.
\]

Equations (8) and (11), followed only by finite Abel summation and monotone
convergence, give

\[
 \boxed{
 \mathfrak A_X^{\rm bulk}
 \le\sum_{N\ge1}e^{-2N/X}R_N.}                         \tag{12}
\]

Therefore the exact arithmetic inequality

\[
 \boxed{
 \sum_{N\ge1}e^{-2N/X}
 \left(2\langle G_{N-1},\Delta_NG\rangle_{\rm clock}
       +\|\Delta_NG\|_{\rm clock}^2\right)_+
 \ll_\varepsilon X^{1+\varepsilon}}                   \tag{13}
\]

is sufficient for the desired bulk bound.  In (13), $G$ is the complete
windowed expression (6) and $\Delta G$ is the complete divisor polynomial
(7).  This is stronger than the target, but it is a noncircular signed
cross-horizon condition: only positive energy admissions are charged, while
negative coboundary increments telescope for free.

## 4. Wavelet translation

For any real packet $x_0,\ldots,x_{2^k-1}$, the unnormalized Haar identity is

\[
 \boxed{
 \sum_nx_n^2=
 \frac{(\sum_nx_n)^2}{2^k}
 +\sum_{I\ {\rm dyadic}}
   \frac{(\sum_{n\in I_L}x_n-\sum_{n\in I_R}x_n)^2}{|I|}.} \tag{14}
\]

Applied to $x_n=B_{D,H+n}$, (14) is an exact Littlewood--Paley frame across
horizons.  Applied pointwise in $q$ to $G_{H+n}(q)$, then integrated in the
clock, it remains exact.  Every term on the right is nonnegative, however, and
the root mean is unavoidable.  The frame reorganizes the reserve but supplies
no signed cancellation by itself.  Moving from $X$ to $2X$ must additionally
include both commutator faces in (5).

## 5. Finite adversarial checks

Actual Möbius data reject a pointwise martingale or contractive-admission law.
At $X=100$, $D=10$, $q=1/2$, the exact rational clock field has

\[
 G_{100}=57/512,
 \qquad \Delta_{101}G=-1/2,
\]

so

\[
 2G_{100}\Delta_{101}G=-57/512,
 \qquad |\Delta_{101}G|^2=1/4,
\]

and the total energy increment is $71/512>0$.  At the next horizon,

\[
 G_{101}=-199/512,
 \qquad \Delta_{102}G=-9/64,
\]

so even the cross itself is unfavorable:

\[
 2G_{101}\Delta_{102}G=1791/16384>0.                  \tag{15}
\]

The same failure occurs at $q=1/4$ and $q=1/10$.  Thus neither the
one-step coboundary nor the two-dimensional cell identity supplies a uniform
negative sign.

For the dyadic block $128\le N<256$, with the actual fixed lower endpoint
$D=12$, direct exact arithmetic gives

\[
 \sum B_N^2=867,
 \qquad \frac{(\sum B_N)^2}{128}=\frac{2809}{128},
 \qquad \text{Haar details}=\frac{108167}{128}.         \tag{16}
\]

This verifies (14) and shows concretely that dropping the root coefficient is
already false.  The only surviving mechanism among the three tests is the
positive-variation inequality (13); proving it requires new arithmetic control
of the signed divisor polynomials (7).  No bulk estimate is claimed here.
