# Exact common-divisor cancellation in coherent arithmetic bands

These are written finite-history identities using classical Ramanujan sums, geometric series and finite differences. No Lean formalization or priority claim is made.

Fix a finite set $S$ of actual primes, put $P=\prod_{p\in S}p$, and restrict every integer sum below to $S$-smooth positive integers. The causal coefficients at coupling $1/2$ are
$$
a(n)=\frac{(-1)^{|S|}}{\sqrt{Pn}}b(n),\qquad
b(n)=\prod_{p\mid n}(1-p)=\sum_{d\mid n}\mu(d)d.
\tag{1}
$$
In particular, the numerator includes every squarefree divisor with its sign. Unique factorization gives the exact Ramanujan-sum identification
$$
a(n)=\frac{c_P(n)}{\sqrt{Pn}},\qquad
c_P(n)=\sum_{\substack{h\bmod P\\(h,P)=1}}e^{2\pi ihn/P}.
\tag{2}
$$
Indeed $c_P(n)=\prod_{p\mid n}(p-1)\prod_{p\nmid n}(-1)$. The smoothness restriction in (1) cannot be removed when using (2).

The local coefficient sequence is
$$
\alpha_p(0)=-r_p,\qquad
\alpha_p(k)=(1-q_p)r_p^{k-1}\quad(k\ge1),
\qquad r_p=p^{-1/2},\quad q_p=p^{-1}.
\tag{3}
$$
Thus $a(n)=\prod_p\alpha_p(v_p(n))$. For fixed finite $S$, its absolute sum and every logarithmically weighted absolute sum converge.

## The exact reduced-ratio correlation

Let $u,v$ be coprime $S$-smooth integers. Define
$$
D=\{p:p\mid uv\},\quad d=|D|,\qquad
C(u,v)=\frac{\prod_{p\in D}(1-q_p)}{\sqrt{uv}}.
$$
For $p\in D$, let $J_p$ be independent positive geometric variables,
$$
\Pr(J_p=k)=(1-q_p)q_p^{k-1},\qquad k\ge1.
$$
For $p\notin D$, let $K_p$ be independent variables with
$$
\Pr(K_p=0)=q_p,\qquad
\Pr(K_p=k)=(1-q_p)^2q_p^{k-1}\quad(k\ge1).
$$
All these variables are independent, and $G_0=\prod_{p\notin D}p^{K_p}$.
Write $\mathsf T_h f(x)=f(x+h)$. For every bounded $f$, and also for every $f$ of polynomial growth, one has
$$
\boxed{\displaystyle
\sum_g a(gu)a(gv)f(\log g)
=C(u,v)\,
\mathbb E\!\left[
\prod_{p\in D}(\mathsf T_{J_p\log p}-I)f(\log G_0)
\right].}
\tag{4}
$$
This includes $u=v=1$, when the product of differences is empty.

To prove (4), put $e=v_p(uv)\ge1$ at a prime in $D$. The exact local signed correlation is
$$
\alpha_p(k+e)\alpha_p(k)
=(1-q_p)r_p^e
\left[-1_{\{k=0\}}+
 (1-q_p)q_p^{k-1}1_{\{k\ge1\}}\right].
\tag{5}
$$
At a prime outside $D$, the local correlation is $\alpha_p(k)^2$, exactly the probability law of $K_p$. Multiply these finitely many measures and use absolute convergence. This proves (4) without discarding any proper-power history.

Equation (4) is a cancellation after completing all common-multiple histories of one reduced ratio. If $u\ne v$, it gives
$$
\sum_g a(gu)a(gv)=0.
\tag{6}
$$
More precisely, its logarithmic moments satisfy
$$
\sum_g a(gu)a(gv)(\log g)^j=0\quad(0\le j<d),
$$
$$
\boxed{\displaystyle
\sum_g a(gu)a(gv)(\log g)^d
=\frac{d!}{\sqrt{uv}}\prod_{p\in D}\log p.}
\tag{7}
$$
Repeated finite differences annihilate every lower-degree polynomial; on $x^d$ they equal $d!\prod_p J_p\log p$. Since $\mathbb E J_p=(1-q_p)^{-1}$, the remaining local factors cancel exactly.

For $f\in C^d(\mathbb R)$ with bounded $d$-th derivative, the integral formula for repeated finite differences instead gives
$$
\boxed{\displaystyle
\left|\sum_g a(gu)a(gv)f(\log g)\right|
\le \frac{\prod_{p\in D}\log p}{\sqrt{uv}}\,
\|f^{(d)}\|_\infty.}
\tag{8}
$$
The left series is absolutely convergent because such an $f$ has at most polynomial growth. This per-ratio bound contains no primorial factor. It does not yet bound the sum over all reduced ratios.

## The complete window identity

Let $w$ have bounded support in a finite positive integer interval, and define
$$
Z_w(t)=\sum_n a(n)w(n)n^{-it}.
$$
For real $T$ and $H>0$, put
$$
\omega_{T,H}(r)=
e^{-i(T+H/2)\log r}\,
\operatorname{sinc}\!\left(\frac H2\log r\right),
\qquad \operatorname{sinc}(0)=1.
$$
Expanding the finite square and uniquely writing $n=gu,m=gv$, with $(u,v)=1$, proves
$$
\boxed{\displaystyle
\frac1H\int_T^{T+H}|Z_w(t)|^2dt
=\sum_n a(n)^2|w(n)|^2+
2\Re\sum_{\substack{u>v\\(u,v)=1}}
\omega_{T,H}(u/v)\,\mathcal C_w(u,v),}
\tag{9}
$$
where all integers are still $S$-smooth and
$$
\mathcal C_w(u,v)=
\sum_g a(gu)a(gv)w(gu)\overline{w(gv)}.
\tag{10}
$$
Only finitely many reduced ratios contribute. Formula (4) applies exactly to (10) with
$$
f_{u,v}(x)=w(ue^x)\overline{w(ve^x)}.
\tag{11}
$$
For a log-smooth weight it gives (8) with this specific function. For the sharp-minus-smoothed weight in the sharp-port problem, (11) still has the actual sharp boundary; it is not legitimate to apply a smooth derivative bound across that jump.

The carrier $e^{it\Theta}$ and division by the unit-modulus $U_S(t)$ disappear from this squared modulus. They remain in the complex amplitude. Equation (9) retains the observation center, every endpoint and every signed cross term.

## A sharp band leaves explicit boundary masses

Take $w(n)=1_{\{L<n\le U\}}$, where $0<L<U$. For $u>v$, (11) becomes
$$
f_{u,v}(\log g)=1_{\{L/v<g\le U/u\}}.
\tag{12}
$$
It is zero if $u/v\ge U/L$. Both the strict lower endpoint and the weak upper endpoint in (12) are exact.

For the single-prime reduced ratio $u=p^e,v=1$, $e\ge1$, assume $\ell=L<h=U/p^e$. The other primes have the complete squared-coefficient law defining $G_0$. Formula (4) reads
$$
\boxed{\displaystyle
\mathcal C_w(p^e,1)
=(1-p^{-1})p^{-e/2}\,
\mathbb E_{J_p}\!\left[
\Pr(\ell/p^{J_p}<G_0\le\ell)
-\Pr(h/p^{J_p}<G_0\le h)
\right].}
\tag{13}
$$
To check the endpoints, subtract
$1_{\{G_0\le h\}}-1_{\{G_0\le\ell\}}$
from
$1_{\{G_0\le h/p^{J_p}\}}-1_{\{G_0\le\ell/p^{J_p}\}}$.
The result is the lower boundary mass minus the upper boundary mass in (13).
When $\ell\ge h$, (12) is empty and the correlation is zero; formula (13) is not asserted for that case.

For several primes in the reduced ratio, the exact remainder is the corresponding product of finite differences of (12). Complete-history cancellation gives zero on the constant weight, but does not order the two cutoff boundaries or give a sign to their complex window-weighted aggregate.

As a small exact check, take $S=\{2\}$ and $u=2,v=1$. Then $G_0=1$ and $C(u,v)=1/(2\sqrt2)$. For $1/2<n\le2$, the only pair is $n=2,m=1$, and (13) gives $-1/(2\sqrt2)$. For $1<n\le4$, the only pair is $n=4,m=2$, and (13) gives $+1/(4\sqrt2)$, because $\Pr(J_2=1)=1/2$. These are actual coefficient products from (3), not a relaxed-kernel example.

## The surviving sharp-port obligation

For $S=\{p\le X\}$, put $\Theta_X=\sum_{p\le X}\log p$ and $P_X=e^{\Theta_X}$. Fix $c\ge0$ and a smooth nonnegative probability mollifier $\rho_\varepsilon$ supported on $[-\varepsilon,\varepsilon]$. Define the actual sharp-minus-smoothed weight

$$
b_{c,\varepsilon}(y)=1_{y<-c}-\int\rho_\varepsilon(v-c)1_{y<-v}\,dv.
$$

It has modulus at most one. The sharp-port smoothing error uses precisely
$$
w(n)=b_{c,\varepsilon}
\!\left(\frac{\Theta_X-\log n}{\log X}\right),
$$
supported inside $P_XX^{c-\varepsilon}\le n\le P_XX^{c+\varepsilon}$.
Its diagonal term in (9) is bounded by the corresponding spectral-band probability and tends to zero after $X\to\infty$, then $\varepsilon\downarrow0$, by the [continuous limiting history law](../dynamics-and-feedback/haar-profile-all-order-moments.md#6-the-continuous-limiting-law-and-thin-fixed-bands).
Thus a sufficient remaining arithmetic estimate is
$$
\lim_{\varepsilon\downarrow0}\limsup_{X\to\infty}\sup_T
\left|
\sum_{\substack{u>v\\(u,v)=1}}
\omega_{T,H_X}(u/v)\,
C(u,v)\,
\mathbb E\!\left[
\prod_{p\mid uv}(\mathsf T_{J_p\log p}-I)
f_{u,v}(\log G_0)
\right]\right|=0.
\tag{14}
$$
All smoothness restrictions and weights in (14) are those in (9)--(11).

The exact cancellation (4), its moment and derivative consequences (7)--(8), and the boundary representation (13) reorganize the actual arithmetic mixed term before any absolute estimate. They do not prove (14), improve the total sharp-band Montgomery--Vaughan window scale, or give a sign to the full cross term. Bounding all the remaining boundary differences and near-resonant reduced ratios collectively is still necessary.

The elementary Ramanujan-sum divisor formula is recorded in [DLMF 27.10.5](https://dlmf.nist.gov/27.10.E5). The moment identity (7), smooth difference bound (8) and signed window decomposition (9) are proved here with their complete arithmetic coefficients.
