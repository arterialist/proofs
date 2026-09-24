# Two prolate vectors and the missing Weil first-gap estimate

[Connes--Consani, Section 3](https://arxiv.org/html/2106.01715) explains
small eigenvalues of the compact Weil form through truncations of
global radical vectors. The argument below makes a two-vector min--max
version precise. It bounds the *full* Weil form of each truncated
radical vector by a weighted Fourier tail, with the gamma term, both
poles, and every prime power retained. The two vectors have a
uniformly positive Gram matrix. The companion
[prolate ODE estimate](connes-prolate-weighted-fourier-tail-ode.md)
supplies the weighted Fourier-tail input below and gives the resulting
one-sided upper bound for the first excited Weil eigenvalue. A positive
Weil gap and control of Connes's specific trial vector remain open.

## Exact two-constraint candidates

Put $a=\log\lambda$, $c=2\pi\lambda^2$, and let $p_j$ be the real,
$L^2[-\lambda,\lambda]$-normalized prolate function of order $j$,
extended by zero. It is even for even $j$. For the even orders used
below, its compressed Fourier eigenvalue is $\chi_j$:

\[
 \widehat p_j(v)=\chi_jp_j(v)\quad(|v|<\lambda),\qquad
 \alpha_j=p_j(0),\qquad
 \int_{-\lambda}^{\lambda}p_j(v)\,dv=\chi_j\alpha_j.
 \tag{1}
\]

Here the additive Fourier transform is
$\widehat h(v)=\int h(q)e^{2\pi iqv}\,dq$, so $\chi_j$ includes its
sign. The orders $(0,4,8)$ have the same positive Fourier sign, and
$(2,6,10)$ the same negative sign. For either ordered triple
$(j_1,j_2,j_3)$, set

\[
\begin{aligned}
d_1&=\alpha_{j_2}\alpha_{j_3}(\chi_{j_2}-\chi_{j_3}),\\
d_2&=\alpha_{j_3}\alpha_{j_1}(\chi_{j_3}-\chi_{j_1}),\\
d_3&=\alpha_{j_1}\alpha_{j_2}(\chi_{j_1}-\chi_{j_2}),
\qquad h^{\rm raw}=\sum_{r=1}^3d_rp_{j_r}.
\end{aligned}                                                    \tag{2}
\]

The two scalar identities
$\sum d_r\alpha_{j_r}=\sum d_r\chi_{j_r}\alpha_{j_r}=0$
give $h^{\rm raw}(0)=\int h^{\rm raw}=0$ exactly. The vector is
nonzero because the compressed eigenvalues are distinct and every
$\alpha_j\ne0$. Normalize it to unit $L^2$ norm. The two choices
use disjoint orthogonal prolate spans and hence give independent raw
functions. Their coefficients must be normalized before taking
$c\to\infty$: all $\chi_j$ in one sign family approach the same
limit, so the unnormalized determinant in (2) becomes small.

The zero extensions of these prolate functions jump at
$\pm\lambda$. Thus they are not in the even Schwartz space
$\mathcal S_0^{\rm ev}$ to which the global radical assertion
applies. For $\lambda\ge2$, take an even $C_c^\infty$ cutoff
$\rho_\lambda$ with $0\le\rho_\lambda\le1$, supported strictly
inside $(-\lambda,\lambda)$ and equal to one on
$[-3\lambda/4,3\lambda/4]$. Its terminal collar can be as narrow
as the later Fourier-tail estimate permits. Fix an even
$b\in C_c^\infty(-1/4,1/4)$ with $b(0)=0$ and $\int b=1$.
For each raw vector put

\[
 h_i=\rho_\lambda h_i^{\rm raw}
       -\left(\int\rho_\lambda h_i^{\rm raw}\right)b,
 \qquad i=1,2.                                            \tag{3}
\]

Then $h_i\in\mathcal S_0^{\rm ev}$ and both constraints hold exactly.
The images $F_i=\mathcal E(h_i)$, where
$\mathcal E(h)(u)=u^{1/2}\sum_{n\ge1}h(nu)$, are linearly independent
after restriction to $[\lambda^{-1},\lambda]$. Indeed, for
$u\in(\lambda/2,3\lambda/4)$, only $n=1$ contributes and
$F_i(u)=\sqrt u\,h_i^{\rm raw}(u)$. A linear combination vanishing
there vanishes analytically on $(-\lambda,\lambda)$ and, by the
disjoint prolate expansions, has both coefficients zero. This proves
positive definiteness of the finite-$\lambda$ Gram matrix. A
uniform lower bound follows below without resolving the nearly
equal Fourier eigenvalues in (2).

## A uniform Gram lower bound

The [prolate differential operator, (3.3)](https://arxiv.org/html/2106.01715)
provides the needed compactness. After dividing it by $\lambda^2$,
its quadratic form on $[-\lambda,\lambda]$ is

\[
 \mathfrak t_\lambda(f)=
 \int_{-\lambda}^{\lambda}
 \left[\left(1-\frac{q^2}{\lambda^2}\right)|f'(q)|^2
             +4\pi^2q^2|f(q)|^2\right]dq.              \tag{G1}
\]

Write $\beta_{j,\lambda}$ for its ordered eigenvalues, with
$p_j$ as corresponding normalized eigenfunctions. For every fixed
$j$, the first $j+1$ Hermite functions, approximated by compactly
supported smooth test functions, give
$\limsup_{\lambda\to\infty}\beta_{j,\lambda}
\le 2\pi(2j+1)$ by min--max. In particular,

\[
 \sup_{\lambda\ge\lambda_0}
 \int_{\mathbb R}q^2|p_j(q)|^2dq<\infty
 \qquad(0\le j\le10).                                    \tag{G2}
\]

These estimates also prove convergence to the Hermite modes, up to
sign. On each fixed compact $q$-interval, (G1) bounds the derivatives
of the $p_j$; (G2) makes their $L^2$ mass tight. Rellich compactness
therefore gives strong $L^2(\mathbb R)$ subsequential limits. Passing
the weak eigenvalue equation to the limit gives
$(-\partial_q^2+4\pi^2q^2)p=\beta p$. The limits of the first
$j+1$ prolate eigenfunctions remain orthonormal. The oscillator
eigenvalues are the simple numbers $2\pi(2m+1)$, so the ordered
upper bound above and orthogonality identify each limit as the
$j$th Hermite function. This proves convergence for every fixed
$j$, with its irrelevant sign chosen along each subsequence.

The arithmetic map $\mathcal E$ is continuous on a fixed
multiplicative interval under just these moment bounds. For
$I=[1,2]$, every sufficiently regular $h$ with finite second
moment satisfies

\[
 \left\|u^{1/2}\sum_{n>N}h(nu)\right\|_{L^2(I,du/u)}^2
 \le \frac{C}{N}\int_0^\infty q^2|h(q)|^2dq .
                                                               \tag{G3}
\]

Indeed, apply Cauchy--Schwarz with weights $n^{-3/4}$ and
$n^{3/4}$, use $\sum_{n>N}n^{-3/2}=O(N^{-1/2})$, and then substitute
$q=nu$. For each $q$, the overlapping indices lie in
$q/2\le n\le q$, so
$\sum_{q/2\le n\le q}n^{1/2}=O(q^{3/2})$; on $q>N$ this is at most
$O(N^{-1/2}q^2)$. For the finite part, the elementary bound is

\[
 \left\|u^{1/2}\sum_{n\le N}g(nu)\right\|_{L^2(I,du/u)}
 \le 2\sqrt N\,\|g\|_{L^2(\mathbb R)}.                 \tag{G4}
\]

Equations (G3)--(G4) show that strong $L^2$ convergence plus a
uniform second moment implies convergence of the $\mathcal E$
images in $L^2(I,du/u)$. Hence $\mathcal E(p_j)$ converges there
to $\mathcal E(H_j)$ for the corresponding Hermite function $H_j$,
up to sign.

The six functions $\mathcal E(H_j)$, $j\in
\{0,2,4,6,8,10\}$, are linearly independent on $I$. A finite
Hermite combination $H$ is a polynomial times a Gaussian, so
$\mathcal E(H)$ is real analytic for $u>0$. Vanishing almost
everywhere on $I$ forces it to vanish for every $u>0$. For
real $s>1$, absolute convergence then gives

\[
 0=\int_0^\infty\mathcal E(H)(u)u^{s-1/2}\frac{du}{u}
  =\zeta(s)\int_0^\infty H(q)q^{s-1}dq.              \tag{G5}
\]

Mellin uniqueness gives $H=0$. Thus the map from their
six-dimensional span into $L^2(I,du/u)$ has a positive minimum
singular value. By the convergence just proved, there are
$m>0$ and $\lambda_0$ such that, for every $\lambda\ge\lambda_0$
and every $f$ in the span of the six $p_j$,

\[
 \|\mathcal E(f)\|_{L^2(I,du/u)}
 \ge m\|f\|_{L^2[-\lambda,\lambda]}.                   \tag{G6}
\]

Indeed, failure would give a sequence of unit coefficient vectors
whose image norms tend to zero. A subsequence of the coefficients
and the six prolate signs converges; (G3)--(G4) then give a nonzero
Hermite combination with zero image, contradicting (G5).

It remains to check that smoothing does not erase this bound.
For any $f$ in that span with $\int f=0$, put
$S_\lambda f=\rho_\lambda f-(\int\rho_\lambda f)b$ as in (3).
The uniform second moment, $0\le\rho_\lambda\le1$, and
$\rho_\lambda=1$ on $|q|\le3\lambda/4$ give

\[
 \|(1-\rho_\lambda)f\|_2=O(\lambda^{-1})\|f\|_2,\qquad
 \left|\int\rho_\lambda f\right|
 =\left|\int(\rho_\lambda-1)f\right|
 =O(\lambda^{-1/2})\|f\|_2.                           \tag{G7}
\]

The second estimate uses Cauchy--Schwarz with $q$ and $q^{-1}$
on $|q|>3\lambda/4$. Consequently
$\|S_\lambda f-f\|_2=O(\lambda^{-1/2})\|f\|_2$, while
the second moment of this difference stays bounded by
$O(\|f\|_2^2)$. Applying (G3)--(G4) with
$N\asymp\sqrt\lambda$ gives

\[
 \|\mathcal E(S_\lambda f)-\mathcal E(f)\|_{L^2(I,du/u)}
 =O(\lambda^{-1/4})\|f\|_2.                           \tag{G8}
\]

The two normalized raw vectors in (2) are orthogonal. Apply
(G6)--(G8) to their arbitrary linear combination. Since
$I\subset[\lambda^{-1},\lambda]$ for $\lambda\ge2$, their
smoothed window restrictions $k_1,k_2$ have Gram matrix
$G=(\langle k_i,k_j\rangle)$ satisfying

\[
 \boxed{\lambda_{\min}(G)\ge g_0>0
        \quad\text{for all sufficiently large }\lambda,}
                                                               \tag{G9}
\]

where $g_0$ is independent of the cutoff collar width. This proof
does not need the asymptotic ratios of the nearly equal $\chi_j$.

## The full Weil form of the lower tail

Use $x=\log u$ and write $F_i(x)=\mathcal E(h_i)(e^x)$. Since the
$h_i$ are smooth, compactly supported, and satisfy both vanishing
conditions, Poisson summation gives rapid decay of $F_i(x)$ as
$x\to-\infty$; also $F_i(x)=0$ for $x\ge a$. Split

\[
 k_i=F_i\mathbf1_{[-a,a]},\qquad t_i=F_i\mathbf1_{(-\infty,-a)}.
 \tag{4}
\]

The [global radical identity](https://arxiv.org/html/2106.01715)
$q(F_i,g)=0$ follows from the zeta factor in the Mellin transform of
$\mathcal E(h_i)$ and is unconditional on RH. It applies to the
piecewise smooth $k_i,t_i$ by approximation in the archimedean form
norm and in the weighted pole and prime pairings. A jump at $-a$ is
allowed: its Fourier transform is $O(1/|t|)$, while the gamma
multiplier is $O(\log(2+|t|))$. The lower tails decay faster than
every exponential. More explicitly, truncate a tail far below
$-a$ and mollify each cutoff. These approximants converge in
$\int(1+\log(1+t^2))|\widehat g(t)|^2dt$ and in both exponentially
weighted pole integrals. The gamma cross form passes to the limit
by Cauchy--Schwarz after adding a constant to its lower-bounded
multiplier. For the prime pairings, the rapid lower
decay supplies a uniform majorant
$C\Lambda(n)n^{-B-1/2}$ for any chosen $B>1/2$.
Thus the full prime series converges through the approximation.
Polarizing $q(F_i,k_j)=q(F_i,t_j)=0$ gives

\[
 \boxed{q(k_i,k_j)=q(t_i,t_j)\quad(i,j=1,2).}            \tag{5}
\]

For a real function $t$ supported on $x<-a$, the full form is

\[
\begin{aligned}
 Q(t)={}&m_0\|t\|_2^2
 +\int_0^\infty r(s)\int_{\mathbb R}
                 |t(x+s)-t(x)|^2\,dx\,ds\\
 &+2M_+(t)M_-(t)
 -2\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
       \int_{\mathbb R}t(x)t(x+\log n)\,dx,                 \tag{6}\\
 r(s)={}&\frac{e^{-s/2}}{1-e^{-2s}},\quad
 m_0=\psi(1/4)-\log\pi,\quad
 M_\pm(t)=\int e^{\pm x/2}t(x)\,dx.
\end{aligned}
\]

Equation (6) uses the same normalization as
[Connes--Consani, (2.11)--(2.12)](https://arxiv.org/html/2106.01715)
and the [operator formula](connes-weil-prolate-actual-residual.md).
In particular, the pole contribution is $2M_+M_-$ and the prime
term includes every $n=p^m$. For complex functions, insert the
conjugates and real parts in the last two terms; all estimates below
are unchanged.

Here is an explicit tail estimate. Suppose $B>1/2$ and, for
$x<-a$,

\[
 |t(x)|\le\epsilon e^{B(x+a)},\qquad
 |t'(x)|\le\epsilon e^{B(x+a)}.                         \tag{7}
\]

Then $\|t\|_2^2\le\epsilon^2/(2B)$ and
$|2M_+M_-|\le2\epsilon^2/(B^2-1/4)$. The prime term is at most

\[
 \frac{\epsilon^2}{B}
 \sum_{n\ge2}\frac{\Lambda(n)}{n^{B+1/2}}
 =\frac{\epsilon^2}{B}
   \left(-\frac{\zeta'}{\zeta}\right)(B+1/2).             \tag{8}
\]

For $0<s\le1$, split the inner integral in (6) into the region
where both arguments lie below $-a$ and the collar crossing $-a$.
The derivative bound and the value bound give, respectively,
$\epsilon^2s^2/(2B)$ and
$\epsilon^2(1-e^{-2Bs})/(2B)$. For $s\ge1$, the corresponding
bounds are $\epsilon^2(1+e^{-2Bs})/B$ and the same collar term.
Therefore

\[
 |Q(t)|\le C_B\epsilon^2,\qquad
 C_B=\frac{|m_0|}{2B}+J_B+
       \frac{2}{B^2-1/4}+
       \frac1B\left(-\frac{\zeta'}{\zeta}\right)(B+1/2), \tag{9}
\]

where the finite positive integral is

\[
\begin{aligned}
 J_B={}&\int_0^1r(s)
       \frac{s^2+1-e^{-2Bs}}{2B}\,ds\\
 &+\int_1^\infty r(s)
       \left[\frac{1+e^{-2Bs}}{B}
       +\frac{1-e^{-2Bs}}{2B}\right]ds.                \tag{10}
\end{aligned}
\]

All constants in (9) are independent of $a$; this estimate has not
dropped the terms whose cancellations make the compact Weil form
small.

There is a direct sufficient condition on the Fourier side. For
$M>1$, suppose

\[
 D_M(h)=\sup_{v\ge\lambda}(v/\lambda)^M
      \bigl(|\widehat h(v)|+v|\widehat h'(v)|\bigr)<\infty.
 \tag{11}
\]

Poisson summation gives, with $v=e^{-x}>\lambda$,
$t(x)=v^{1/2}\sum_{n\ge1}\widehat h(nv)$. Differentiating this
absolutely convergent series yields (7) with

\[
 B=M-\tfrac12,\qquad
 \epsilon=\tfrac32\zeta(M)\sqrt\lambda\,D_M(h).         \tag{12}
\]

The factor $\sqrt\lambda$ and the derivative in (11) matter.
$L^2$ prolate concentration leakage by itself does not give (11).

There is a weaker weighted $L^2$ criterion. For $P>1$ set
$s_P=(P+1)/2$ and

\[
 \mathcal A_P(h)^2=
 \int_\lambda^\infty(v/\lambda)^P
 \left(|\widehat h(v)|^2
       +|v\widehat h'(v)|^2\right)dv.                 \tag{H1}
\]

Write $g(u)=t(-a-u)$ for $u\ge0$ and
$\mathcal T_P(g)^2=
\int_0^\infty e^{Pu}(|g(u)|^2+|g'(u)|^2)du$.
The dilation sum $Tf(v)=\sum_{n\ge1}f(nv)$ obeys

\[
 \|Tf\|_{L^2((v/\lambda)^Pdv)}
 \le\zeta(s_P)\|f\|_{L^2((v/\lambda)^Pdv)},
 \qquad
 \mathcal T_P(g)^2\le
       2\zeta(s_P)^2\mathcal A_P(h)^2.               \tag{H2}
\]

For the first inequality, change variables $w=nv$ in each
summand: its norm is at most
$n^{-(P+1)/2}\|f\|$. For the second, use
$g(u)=\sqrt v\,T\widehat h(v)$ and
$g'(u)=\sqrt v[(T\widehat h)(v)/2+
T(v\widehat h')(v)]$, with $v=\lambda e^u$.

The full source formula (6) now gives

\[
\begin{aligned}
 |Q(t)|&\le C_P^{(2)}\mathcal T_P(g)^2
       \le2C_P^{(2)}\zeta(s_P)^2\mathcal A_P(h)^2,\\
 C_P^{(2)}={}&|m_0|
  +\int_0^1r(s)(s+s^2)\,ds
  +5\int_1^\infty r(s)\,ds\\
 &+\frac{2}{\sqrt{P^2-1}}
  +2\left(-\frac{\zeta'}{\zeta}\right)(s_P).
\end{aligned}                                                    \tag{H3}
\]

To verify the archimedean term, for $0<s\le1$ the interior
translation costs at most $s^2\|g'\|_2^2$, while the cutoff collar
costs at most $s\|g\|_{H^1}^2$ by the one-dimensional Sobolev
supremum bound. For $s\ge1$ the two costs total at most
$5\|g\|_2^2$. Weighted Cauchy--Schwarz bounds the pole product by
$2\mathcal T_P(g)^2/\sqrt{P^2-1}$. The prime correlation at
$d=\log n$ is at most
$e^{-Pd/2}\mathcal T_P(g)^2$, giving the displayed complete
logarithmic derivative. The condition $P>1$ makes both the pole
integral and prime series finite. The weight and derivative in
(H1) are supplied for a specified Gevrey smoothing by the
[prolate ODE estimate](connes-prolate-weighted-fourier-tail-ode.md);
unweighted concentration leakage alone is insufficient. For an
individual raw zero-extended prolate $p_j$, the nonzero endpoint
value produces the leading boundary term
$[p_j(\lambda)e^{2\pi i\lambda v}
-p_j(-\lambda)e^{-2\pi i\lambda v}]/(2\pi i v)$
in its Fourier transform. This is an oscillatory $1/v$ tail, and
$v\widehat p_j'(v)$ does not decay. Thus
$\mathcal A_P(p_j)=\infty$ for $P>1$. Smoothing at
$\pm\lambda$ is essential here, not a cosmetic domain change.

## Min--max consequence and remaining inputs

Let $A_a$ be the self-adjoint compact-window Weil operator with
eigenvalues $E_0(a)\le E_1(a)\le\cdots$, and let
$G=(\langle k_i,k_j\rangle)_{i,j=1}^2$. The previous construction
gives $g_a:=\lambda_{\min}(G)\ge g_0>0$ for all sufficiently
large $a$ by (G9). If (7) holds
for $t_i$ with the same $B$ and constants $\epsilon_i$, then for
every $z_1,z_2\in\mathbb C$ the tail of $\sum z_i k_i$ has constant
at most $\sum|z_i|\epsilon_i$. Equations (5), (9), and the
two-dimensional min--max principle give the unconditional bound

\[
 \boxed{E_1(a)\le
    C_B\frac{\epsilon_1^2+\epsilon_2^2}{g_a}.}          \tag{13}
\]

The weighted $L^2$ version is
$E_1(a)\le
2C_P^{(2)}\zeta(s_P)^2
(\mathcal A_P(h_1)^2+\mathcal A_P(h_2)^2)/g_a$.
By (G9), the denominator $g_a$ is already bounded below
independently of $c$. The companion
[prolate ODE estimate](connes-prolate-weighted-fourier-tail-ode.md)
proves $D_M(h_i)\le Cc^K e^{-c}$ for the normalized exact triples
with a specified Gevrey endpoint cutoff. Inserting it in (12)--(13)
gives $E_1(a)\le\operatorname{poly}(c)e^{-2c}$ for the *actual*
compact Weil operator. For the weighted $L^2$ route, choose
$2M>P+1$; direct integration of (H1) gives
$\mathcal A_P(h_i)^2\le\lambda D_M(h_i)^2/(2M-P-1)$ and the same
one-sided bound. This does not give $E_1>0$, a lower bound on the
Weil gap, or control of Connes's separate two-mode Rayleigh
quotient. The compressed finite-Fourier relation in (1) is not a
global Fourier eigenrelation, so inversion parity is only
approximate.

For comparison, Connes's specific trial vector uses a two-mode
zero-integral combination $h_\lambda$ that has
$h_\lambda(0)\ne0$ and endpoint jumps; it is not one of the
$\mathcal S_0^{\rm ev}$ vectors above. For real $k_\lambda$, its
Rayleigh quotient in the same normalization as (6) is exactly

\[
\begin{aligned}
R_\lambda={}&m_0+\|k_\lambda\|_2^{-2}
 \left\{\int_0^\infty r(s)
       \|k_\lambda(\cdot+s)-k_\lambda\|_2^2\,ds
       +2M_+(k_\lambda)M_-(k_\lambda)\right.\\
&\left.\hspace{18mm}
       -2\sum_{2\le n<\lambda^2}
       \frac{\Lambda(n)}{\sqrt n}
       \int_{\mathbb R}
           k_\lambda(x)k_\lambda(x+\log n)\,dx\right\}.
\end{aligned}                                                    \tag{14}
\]

This expression gives no separate $e^{-2c}$ bound: the pole and
gamma/prime terms are individually large and must cancel. If a
smooth radical vector
$F^\sharp=k^\sharp+t^\sharp$ approximates $k_\lambda$ and
$e=k_\lambda-k^\sharp$, the exact comparison is

\[
 Q(k_\lambda)=Q(t^\sharp)-2\Re q(t^\sharp,e)+Q(e).
 \tag{15}
\]

Controlling (15) requires $e$ in a Weil form norm at the required
scale, as well as a lower bound on the actual Rayleigh quotient
$R_\lambda=Q(k_\lambda)/\|k_\lambda\|_2^2$ if one wants an upper
bound on $E_1-R_\lambda$. The two-vector bound (13) alone does not
give the positive gap or the residual comparison required in
[the spectral transfer diagnostic](connes-weil-gap-residual-transfer.md).
These are written analytic reductions, not Lean formalizations.
