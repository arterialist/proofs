# Cutoff transfer for proper cofactors of an actual Weil packet

**Status:** corrected unconditional written estimate, 19 September 2026.
The earlier version of this note incorrectly applied one approximate functional
equation, with one fixed dual cutoff, inside a sum over every zeta zero.  The
cutoff is instead
$$
 y_\rho=\frac{|\Im\rho|}{2\pi K},
$$
the approximation error depends on $\rho$, and its weighted sum cannot be
discarded.  The corrected result below keeps the omitted $k>K$ tail and
transfers to it the saved small-prime prefix from the
[reciprocal-prime estimate](actual-reciprocal-prime-high-cofactor-saving.md).
It gives a power saving for the **combined** prime row and truncated proper
cofactor head.  It does not bound either row separately and supplies no Weil
sign or RH conclusion.

The finite rearrangements are compiled in
[ActualPrimeCofactorFutureFinite.lean](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean).
The packet estimates, Poisson summation, and reciprocal-prime input remain
written analysis.

The ingredients have classical provenance.  Poisson summation and
$\Lambda*1=\log$ are standard; the reciprocal-prime input assembles
Vaughan's identity with the Robert--Sargos third-derivative test, as documented
in the companion note.  The cutoff-transfer lemma below is elementary
hyperbola bookkeeping, and no novelty claim is made for it in isolation.  For
comparison, Brun--Titchmarsh gives only the absolute
$O(H/\sqrt N)$ scale for a separated fixed-cofactor row.  The
[Guth--Maynard short-interval prime theorem](https://annals.math.princeton.edu/2026/203-2/p06)
requires $h\ge x^{17/30+\varepsilon}$; at $x\asymp N$ and
$h\asymp H$, this would require $\lambda\ge30/13$, outside the range
$\lambda<29/14$ used here.

## 1. Packet and notation

Let
$$
 u_T(x)=a(x)e^{i\eta Tx^2-iTx},\qquad
 q_T=\frac{(\partial_x^2-1/4)u_T}{\|(\partial_x^2-1/4)u_T\|_2},
$$
where $a\in C_c^\infty((0,w))$, $0<w<\log2$, and
$a\ne0$, $0<\eta<1/(8w)$.  Put
$$
 C_T(y)=\int q_T(x+y)\overline{q_T(x)}\,dx,
 \qquad
 g_N(x)=x^{-1/2}C_T(\log(x/N))
$$
for $x>0$, and set $g_N(x)=0$ for $x\le0$.  As before,
$N=T^\lambda$, $H=N/T$, and
$$
 G_T(v)=\sqrt N\,g_N(N+Hv).
$$
All implicit constants may depend on the fixed packet data $a,w,\eta$, on
$\lambda$, and on displayed fixed decay indices such as $A,M$, but not on
$T$.  All asymptotic estimates below are for sufficiently large $T$.

The pole-null identities imply the two exact moments
$$
 \int_0^\infty g_N(x)\,dx=0,
 \qquad
 \int_0^\infty(\log x)g_N(x)\,dx=0.                 \tag{1}
$$
The family $G_T$ is uniformly Schwartz.  There is no hidden loss from the
$T$-dependent phase.  Indeed,
$$
 (\partial_x^2-1/4)u_T=e^{i(\eta Tx^2-Tx)}
 \left[-T^2(1-2\eta x)^2a+O_{C^m}(T)\right],
$$
while the normalizing denominator is $T^2(A+O(T^{-1}))$, $A>0$.
Thus
$q_T=e^{i(\eta Tx^2-Tx)}b_T$, where every fixed derivative of $b_T$
is bounded uniformly in $T$.  With
$$
 y=\log(1+v/T),\qquad z=Ty,
$$
the correlation is an oscillatory integral with phase $2\eta xz$.
On its support, $z\asymp v$; fixed $v$-derivatives of $z$ and of the
outer phase are bounded.  Repeated integration by parts in $x$ proves
$$
 \sup_v(1+|v|)^M|G_T^{(r)}(v)|\ll_{M,r}1.             \tag{2}
$$

For integers $k\ge1$, write
$$
 P_k(T)=\sum_{d\ge1}\Lambda(d)g_N(kd),\qquad
 B_K(T)=\sum_{k>K}P_k(T).
$$
The combined truncated packet is
$$
 \mathcal A_K(T)=P_1(T)+\sum_{2\le k\le K}P_k(T).     \tag{3}
$$

## 2. The complete convolution is rapidly sampled

The exact identity $\Lambda*1=\log$ gives
$$
 \mathcal A_K(T)+B_K(T)
 =\sum_{n\ge1}(\log n)g_N(n).                         \tag{4}
$$
This is a lattice sum, so the continuous moment (1) does not make it exactly
zero.  It does, however, remove its Poisson zero mode.

Put
$$
 F_T(v)=\log(N+Hv)G_T(v).
$$
By (2), $H/N=1/T$, and
$\log(N+Hv)=\log N+\log(1+v/T)$,
$$
 |\widehat F_T(\xi)|\ll_A\log N(1+|\xi|)^{-A}.       \tag{5}
$$
Poisson summation, with $e(t)=e^{2\pi it}$, gives
$$
 \sum_n(\log n)g_N(n)
 =\frac{H}{\sqrt N}\sum_{m\in\mathbb Z}
   e(-mN)\widehat F_T(mH).
$$
The $m=0$ term vanishes by (1).  Hence for every fixed $A>1$,
$$
 \boxed{\displaystyle
 \sum_n(\log n)g_N(n)
 \ll_A \frac{H^{1-A}\log N}{\sqrt N}.}              \tag{6}
$$
This improves the earlier Euler-summation bound for the complete convolution.
It is an enabling estimate only: (4) still requires control of the literal
cutoff tail $B_K$.

## 3. A sharp cutoff-transfer lemma

Fix $0<\delta<1$ and set
$$
 D=HT^\delta,\qquad Q=\frac ND=T^{1-\delta},
 \qquad K=\lfloor Q\rfloor.
$$
Let
$$
 A_D(T)=\sum_{d\le D}\Lambda(d)\sum_{k\ge1}g_N(dk). \tag{7}
$$

**Lemma (cutoff transfer).** For every fixed $M>1$,
$$
 \boxed{\displaystyle
 B_K(T)=A_D(T)
 +O\!\left(\frac{\log N}{\sqrt N}
               \left(1+\frac HK\right)\right)
 +O_M\!\left(\frac{H\log N}{\sqrt N}
                    (1+T^\delta)^{1-M}\right).}       \tag{8}
$$

*Proof.* Cancelling the common quadrant $d\le D,k>K$ gives
$$
 B_K-A_D
 =\sum_{\substack{d>D\\k>K}}\Lambda(d)g_N(dk)
  -\sum_{\substack{d\le D\\k\le K}}\Lambda(d)g_N(dk).       \tag{9}
$$
Remove the row $k=K+1$ from the first sum and the row $k=K$ from the
second.  In the remaining upper quadrant, $k\ge K+2$, so
$$
 dk>D(K+2)>D(Q+1)=N+D.
$$
In the remaining lower quadrant, $k\le K-1$, so
$$
 dk\le D(K-1)\le D(Q-1)=N-D.
$$
Group these terms by $n=dk$.  Since
$\sum_{d\mid n}\Lambda(d)=\log n$, their total absolute value is at most
$$
 \sum_{|n-N|\ge D}(\log n)|g_N(n)|
 \ll_M\frac{H\log N}{\sqrt N}(1+D/H)^{1-M},           \tag{10}
$$
which is the last error in (8).

For either removed row, (2), $\Lambda(d)\le\log d$, and a lattice sum
with normalized spacing $k/H$ give
$$
 \sum_d\Lambda(d)|g_N(kd)|
 \ll_M\frac{\log N}{\sqrt N}
       \sum_d\left(1+\frac{|kd-N|}{H}\right)^{-M}
 \ll_M\frac{\log N}{\sqrt N}\left(1+\frac Hk\right).
 \tag{11}
$$
Since $k\in\{K,K+1\}$, (8) follows. $\square$

## 4. The unconditional combined estimate

For $2<\lambda<29/14$, put
$$
 \delta_*=\min\left\{\frac{\lambda-2}{100},
                     \frac{3-\lambda}{100},
                     \frac{29-14\lambda}{3000}\right\}>0. \tag{12}
$$
The saved-prefix theorem in the reciprocal-prime note is exactly
$$
 A_{HT^{\delta_*}}(T)
 \ll T^{-(29-14\lambda)/60}.                            \tag{13}
$$
Taking $D=HT^{\delta_*}$ and
$K=\lfloor T^{1-\delta_*}\rfloor$ in (8), and choosing $M$ large,
gives
$$
 \boxed{\displaystyle
 B_K(T)\ll T^{-(29-14\lambda)/60}
 +T^{\lambda/2-2+\delta_*}\log T+O_A(T^{-A}).}        \tag{14}
$$
The second exponent is negative throughout this range and is smaller than the
first displayed saving.  Combining (4), (6), and (14) proves
$$
 \boxed{\displaystyle
 \mathcal A_K(T)
 =P_1(T)+\sum_{2\le k\le K}P_k(T)
 \ll T^{-(29-14\lambda)/60}.}                          \tag{15}
$$
This is stronger than an $O(\log T)$ bound for the combined expression.
It says only that the prime row and the proper cofactor head cancel to this
accuracy; it does not bound either one in isolation.

## 5. Correct zero-side accounting

The Mellin factorization from the earlier version remains valid:
$$
 \int_0^\infty x^{\rho-1}g_N(kx)\,dx
 =k^{-\rho}J(\rho,T),                                  \tag{16}
$$
where
$$
 J(\rho,T)=\int_0^\infty x^{\rho-1}g_N(x)\,dx.
$$
What failed was the subsequent uniform use of one approximate functional
equation inside the full zero sum.

For $\rho=\beta+i\gamma$, define
$$
 S_K(\rho)=\sum_{k\le K}k^{-\rho},\qquad
 y_\rho=\frac{|\gamma|}{2\pi K},\qquad
 D_K(\rho)=\sum_{n\le y_\rho}n^{\rho-1}.              \tag{17}
$$
When $y_\rho\ge1$, the standard two-polynomial approximate functional
equation at the zero $\rho$ is the log-free form in Titchmarsh,
*The Theory of the Riemann Zeta-Function*, second edition, equation (4.12.4),
p. 79, as justified in the proof of Theorem 4.15; it is also recorded as
DLMF 25.9.1.  It gives
$$
 S_K(\rho)=-\chi(\rho)D_K(\rho)+r_K(\rho),           \tag{18}
$$
with
$$
 r_K(\rho)
 \ll K^{-\beta}
 +|\gamma|^{1/2-\beta}y_\rho^{\beta-1}.              \tag{19}
$$
For $|\gamma|<2\pi K$, the dual length is below one and this form of the
formula is not available; those zeros form a separate complementary range.
For high ordinates, decay of $J(\rho,T)$ must be proved and used.  The
weighted errors $J(\rho,T)r_K(\rho)$ must be summed; a per-zero error cannot
be written once outside the zero sum.

For any selected central zero range $\mathcal Z_0$, the honest bookkeeping
therefore has the form
$$
 \begin{aligned}
 \sum_{\rho}J(\rho,T)S_K(\rho)
 ={}&-\sum_{\rho\in\mathcal Z_0}
       J(\rho,T)\chi(\rho)D_K(\rho)\\
 &+\sum_{\rho\in\mathcal Z_0}J(\rho,T)r_K(\rho)
  +\sum_{\rho\notin\mathcal Z_0}J(\rho,T)S_K(\rho).
 \end{aligned}                                          \tag{20}
$$
The full signed sums remain intact.  Neither zero pairing nor the functional
equation supplies a favorable sign for the first term.  On the critical line,
$$
 J(1/2+i\gamma,T)=N^{i\gamma}|E_{i\gamma}(q_T)|^2,
$$
and it is still multiplied by $\chi(\rho)D_K(\rho)$.

A local band hypothesis allowing
$|\Re\rho-1/2|\le\Delta$, with $\Delta>0$ small enough relative to
$\lambda$ and $\delta$, would be weaker than RH and could control the
absolute approximate-functional-equation errors together with a suitable
weighted zero-correlation estimate.  No such pointwise estimate follows from
the classical zero-free region, including the modern explicit
Vinogradov--Korobov form in Bellotti, *Explicit bounds for the Riemann zeta
function and a new zero-free region* (JMAA 536, 2024), or from standard
zero-density bounds.  Thus (20) is a corrected representation, not an
independent proof of (15).  The
unconditional bound (15) comes from the arithmetic cutoff transfer (8).

## 6. What is and is not resolved

- The complete all-cofactor logarithmic convolution has the rapid Poisson
  bound (6).
- The literal omitted $k>K$ tail is retained and bounded by (14).
- The combined prime row and proper cofactor head satisfies the power saving
  (15) for $2<\lambda<29/14$.
- The prime row alone, the proper head alone, and the complete Weil sign remain
  unresolved.
- The zero-dependent cutoff, complementary zero ranges, weighted AFE errors,
  and cofactor tail cannot be suppressed in a spectral rewrite.
