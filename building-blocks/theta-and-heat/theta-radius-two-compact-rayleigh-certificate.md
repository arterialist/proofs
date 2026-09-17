# A compact triangular Rayleigh certificate at radius two

This note gives one explicit even compact trial for the actual killed theta
form on

\[
 O_2=(-\infty,-2)\cup(2,\infty).
\]

It retains the continuous kernel, the killing term, both prime orientations,
and every prime power.  The calculation proves a strict Rayleigh quotient
below \(1/2\).  It does not concern the two pole corrections in the complete
Weil form and makes no assertion of RH.

## 1. Trial and norm

Let

\[
 \eta(x)=\sqrt {30}\,x(1-x)1_{(0,1)}(x),\qquad w=\frac12,
\]

and put

\[
 g(u)=w^{-1/2}\eta\!\left(\frac{u-2-w}{w}\right)
     =\sqrt2\,\eta(2u-5),
 \qquad f=g+g^\vee,
 \qquad h=\frac f\Phi .                                      \tag{1}
\]

Thus the positive support is \((5/2,3)\), the negative support is
\((-3,-5/2)\), and the zero extension has no boundary atom.  The exact bump
data are

\[
 \|g\|_2=1,\qquad \|g'\|_2^2=40.                              \tag{2}
\]

With \(J=b/\Phi\), the actual theta norm is

\[
 N:=\|h\|_\nu^2
   =2\int_{5/2}^{3}J(u)g(u)^2\,du
   =2\int_0^1J\!\left(\frac{x+5}{2}\right)\eta(x)^2\,dx .    \tag{3}
\]

In particular, monotonicity of \(J\) on the positive half-line gives

\[
                         0<N\le 2J(3).                         \tag{4}
\]

## 2. Exact killed-form decomposition

Let \(q=q_{\rm c}+q_{\rm p}\) be the full symmetric jump conductance, with
the continuous Carleman part and the atomic prime-power part.  If
\(S=\operatorname{supp}h\), extension by zero gives the exact direct split

\[
\begin{aligned}
 E_{O_2}[h]
 ={}&\frac12\iint_{S\times S}|h(u)-h(v)|^2q(du,dv)\\
 &+\int_S |h(u)|^2q\bigl(u,O_2\setminus S\bigr)\,\nu(du)
 +\int_S |h(u)|^2q\bigl(u,[-2,2]\bigr)\,\nu(du).              \tag{5}
\end{aligned}
\]

The first line contains the continuous internal energy and every internal
prime-power edge.  The second line is the departure energy inside \(O_2\)
plus the killing energy into the core.  Formula (5) includes both directed
orientations.  For the atomic part, it includes the complete sum over
\(n=p^k\), including those for which one shifted endpoint lies outside
\(S\).  Thus the prime departure tail is present in (5), even though only
finitely many prime powers can join two points of \(S\).

The established exact physical relation regroups all three terms in (5):

\[
 E_{O_2}[h]=\frac12N+\mathscr K[f],
 \qquad
 \mathscr K[f]=2\mathscr A[g]-2C-2P.                          \tag{6}
\]

Here

\[
 \mathscr A[g]=\int_{\mathbb R}\mathfrak a(\xi)
                         |\widehat g(\xi)|^2\,d\xi,
 \quad
 \mathfrak a(\xi)=\Re\psi_{\rm digamma}
             \!\left(\frac14+\frac{i\xi}{2}\right)-\log\pi,\tag{7}
\]

\[
 C=\int_5^6r(v)H(2v-10)\,dv\ge0,                              \tag{8}
\]

and

\[
 P=\sum_{149\le n\le403}\frac{\Lambda(n)}{\sqrt n}
                              H(2\log n-10).                  \tag{9}
\]

As usual, \(\Lambda(n)=0\) unless \(n\) is a prime power, so (9) retains
all proper powers in this interval.  The bounds \(149\le n\le403\) follow
from \(e^5<n<e^6\).  Endpoint equality would contribute zero.

There is no same-half prime correlation: every prime displacement is at
least \(\log2>w\).  The opposite-half convolution is exactly

\[
 (g*g)(v)=H(2v-10),
\]

where direct polynomial integration gives

\[
 H(x)=
 \begin{cases}
 x^3(x^2-5x+5),&0\le x\le1,\\
 -(x-2)^3(x^2+x-1),&1\le x\le2,\\
 0,&\text{otherwise}.
 \end{cases}                                                  \tag{10}
\]

Equations (3), (7), (8), (9), and (10) are an exact finite formula apart
from the single positive continuous integral (8).  The infinite departure
tail in the direct representation (5) has not been deleted; it is included
in the exact physical regrouping (6).

## 3. A rational upper bound for the archimedean energy

The convergent digamma series is

\[
 \mathfrak a(\xi)-a_0
 =\sum_{j\ge0}
 \frac{(\xi/2)^2}
 {(j+1/4)((j+1/4)^2+(\xi/2)^2)},                              \tag{11}
\]

where

\[
 a_0=-\gamma-\frac\pi2-3\log2-\log\pi.                       \tag{12}
\]

For each \(c>0\), the map \(y\mapsto y/(c(c^2+y))\) is concave on
\([0,\infty)\).  Tonelli and Jensen, followed by (2), therefore give

\[
 \mathscr A[g]
 \le a_0+\sum_{j\ge0}
       \frac{10}{(j+1/4)((j+1/4)^2+10)}
 =\mathfrak a(\sqrt {40}).                                   \tag{13}
\]

This scalar bound has a short rational certificate.  The summand is
decreasing, and hence

\[
\begin{aligned}
 \sum_{j\ge0}\frac{10}{(j+1/4)((j+1/4)^2+10)}
 &\le
 \sum_{j=0}^{15}\frac{10}{(j+1/4)((j+1/4)^2+10)}
   +\int_{61/4}^{\infty}\frac{10\,dx}{x(x^2+10)}\\
 &<
 \sum_{j=0}^{15}\frac{10}{(j+1/4)((j+1/4)^2+10)}
   +\frac5{(61/4)^2}\\
 &<\frac{269}{50}.                                            \tag{14}
\end{aligned}
\]

The last comparison is exact rational arithmetic.  The elementary bounds

\[
 \gamma>\frac{57}{100},\qquad \pi>3,
 \qquad \log2>\frac{69}{100},\qquad \log\pi>1                \tag{15}
\]

give \(a_0<-257/50\).  Combining (13)--(15),

\[
                         \boxed{\mathscr A[g]<\frac6{25}.}    \tag{16}
\]

All transcendental premises in (15) have standard finite certificates:
the first follows from a finite harmonic-sum enclosure for \(\gamma\), the
second is Archimedes' bound, the third follows from the positive atanh
series for \(\log2\), and the fourth follows from \(e<3<\pi\).  Thus
(16) needs no decimal oracle.

## 4. One actual prime already pays the kinetic bound

The integer \(241\) is prime.  Finite exponential-series bounds give

\[
                    \frac{219}{40}<\log241<\frac{11}{2},      \tag{17}
\]

so

\[
             \frac{19}{20}<x_{241}:=2\log241-10<1.            \tag{18}
\]

On this interval, (10) gives

\[
 H(x_{241})=x_{241}^3(x_{241}^2-5x_{241}+5)
             >\left(\frac{19}{20}\right)^3,                  \tag{19}
\]

because the second factor is at least one.  Also
\(\log241>5\) and \(\sqrt{241}<16\).  Every term in (9) is
nonnegative, including every proper-power term.  Keeping only \(n=241\)
therefore proves

\[
 P>\frac5{16}\left(\frac{19}{20}\right)^3
   =\frac{6859}{25600}.                                      \tag{20}
\]

The full finite sum is not needed for the proof.  As a reproducibility
diagnostic, direct high-precision summation of all 51 nonzero prime-power
terms in (9) gives

\[
 P=6.5592548974641011795\ldots,
\]

of which the six proper powers are
\(169,243,256,289,343,361\).  This decimal is not used in any inequality.

## 5. Strict Rayleigh certificate

From \(C\ge0\), (16), and (20),

\[
 \mathscr K[f]
 <2\left(\frac6{25}-\frac{6859}{25600}\right)
 =-\frac{143}{2560}.                                         \tag{21}
\]

Consequently

\[
 \boxed{
 \frac{E_{O_2}[h]}{\|h\|_\nu^2}
 <\frac12-\frac{143}{2560N}
 \le\frac12-\frac{143}{5120J(3)}<\frac12.}                  \tag{22}
\]

Thus this single piecewise-polynomial trial certifies

\[
 \alpha_2<\frac12,
 \qquad
 \frac12-\alpha_2>\frac{143}{5120J(3)}.                      \tag{23}
\]

The certified gap is extremely small because \(J(3)\) is extremely large,
but it has the correct direction needed by the earlier normalized-ground
argument.  The favorable terms omitted from the last comparison are the
whole continuous crossing \(C\) and all prime powers other than 241.  No
positive retained term causes failure: this trial succeeds before either
of those extra payments is used.

The remaining task for an effective numerical ground bound is now narrower:
obtain a rigorous numerical upper enclosure for the already explicit scalar
\(J(3)=b(3)/\Phi(3)\), then propagate (23) through the resolvent/barrier
constants.  That step concerns normalization size, not the sign of the
Rayleigh trial.


This is an independently audited written certificate. Its finite rational, digamma-series and exact-form steps remain Lean formalization obligations.
