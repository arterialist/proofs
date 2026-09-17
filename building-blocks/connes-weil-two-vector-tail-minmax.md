# Two prolate vectors and the missing Weil first-gap estimate

[Connes--Consani, Section 3](https://arxiv.org/html/2106.01715) explains
small eigenvalues of the compact Weil form through truncations of
global radical vectors. The argument below makes a two-vector min--max
version precise. It bounds the *full* Weil form of each truncated
radical vector by a weighted Fourier tail, with the gamma term, both
poles, and every prime power retained. It does not establish the
uniform Fourier-tail or Gram estimates needed to bound the first
excited Weil eigenvalue at the prolate exponential scale.

## Exact two-constraint candidates

Put $a=\log\lambda$, $c=2\pi\lambda^2$, and let $p_j$ be the real,
$L^2[-\lambda,\lambda]$-normalized even prolate function of order $j$,
extended by zero. Its compressed Fourier eigenvalue is $\chi_j$:

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
applies. For a smooth version, take an even $C_c^\infty$ cutoff
$\rho_\lambda$ supported strictly inside $(-\lambda,\lambda)$,
equal to one near zero and on a nonempty interval
$(\lambda/2,\lambda-\eta)$, where $0<\eta<\lambda/2$. Choose an
even $b_\lambda\in C_c^\infty(-\lambda/4,\lambda/4)$ with
$b_\lambda(0)=0$ and $\int b_\lambda=1$. For each raw vector put

\[
 h_i=\rho_\lambda h_i^{\rm raw}
       -\left(\int\rho_\lambda h_i^{\rm raw}\right)b_\lambda,
 \qquad i=1,2.                                            \tag{3}
\]

Then $h_i\in\mathcal S_0^{\rm ev}$ and both constraints hold exactly.
The images $F_i=\mathcal E(h_i)$, where
$\mathcal E(h)(u)=u^{1/2}\sum_{n\ge1}h(nu)$, are linearly independent
after restriction to $[\lambda^{-1},\lambda]$. Indeed, for
$u\in(\lambda/2,\lambda-\eta)$, only $n=1$ contributes and
$F_i(u)=\sqrt u\,h_i^{\rm raw}(u)$. A linear combination vanishing
there vanishes analytically on $(-\lambda,\lambda)$ and, by the
disjoint prolate expansions, has both coefficients zero. This proves
positive definiteness of the finite-$\lambda$ Gram matrix; it gives
no uniform lower bound as $\lambda\to\infty$.

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
weighted pole integrals. For the prime pairings, the rapid lower
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

## Min--max consequence and remaining inputs

Let $A_a$ be the self-adjoint compact-window Weil operator with
eigenvalues $E_0(a)\le E_1(a)\le\cdots$, and let
$G=(\langle k_i,k_j\rangle)_{i,j=1}^2$. The previous construction
gives $g_a:=\lambda_{\min}(G)>0$ for each fixed $a$. If (7) holds
for $t_i$ with the same $B$ and constants $\epsilon_i$, then for
every $z_1,z_2\in\mathbb C$ the tail of $\sum z_i k_i$ has constant
at most $\sum|z_i|\epsilon_i$. Equations (5), (9), and the
two-dimensional min--max principle give the unconditional bound

\[
 \boxed{E_1(a)\le
    C_B\frac{\epsilon_1^2+\epsilon_2^2}{g_a}.}          \tag{13}
\]

Thus $g_a\ge c^{-K}$ and
$\epsilon_i\le c^K e^{-c}$ for a fixed $K$ would imply
$E_1(a)\le\operatorname{poly}(c)e^{-2c}$. Neither input is proved
here. [Fixed-index prolate asymptotics](https://doi.org/10.1002/sapm196544199)
suggest a route to the Gram
bound: after normalization, the first triple should approach the
Hermite combination of orders $0,4$ vanishing at zero, and the
second the corresponding combination of orders $2,6$. Their
$\mathcal E$ images are independent because the Mellin transform
of $\mathcal E(h)$ is $\zeta$ times that of $h$. A sufficient
quantitative version would be convergence of the smooth $h_i$ and
their Fourier transforms in a weighted sup norm
$\sup_{v\ge0}(1+v)^M(|h(v)|+|\widehat h(v)|)$ with $M>1$; this
norm controls $\|\mathcal E(h)\|_2$ by the direct sum for $u\ge1$
and Poisson summation for $u\le1$. Convergence to two independent
Hermite combinations in this norm would make $G$ converge to their
positive full-line Gram matrix. Such convergence, including the
effect of endpoint smoothing and normalization of (2), has not been
checked. The compressed finite-Fourier relation in (1) is not a
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
