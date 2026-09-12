# The natural arrival cutoff converges in the mixed energy

This is a written proof of the literal frozen-tail cutoff convergence, including every prime power and the inclusive endpoint. It complements the earlier smooth-cutoff completion; no analytic claim here is formalized in Lean.

Write $E(x)=\psi(x)-x$, with $\psi(x)=\sum_{n\le x}\Lambda(n)$. Extend functions by zero to $x<1$, and set
$$
g(x)=E(x)/x,\qquad g_N(x)=E(\min(x,N))/x\quad(x\ge1),\qquad N\ge2.
\tag{1}
$$
Thus $g_N=g$ through $N$ and $g_N(x)=E(N)/x$ afterwards. Each $g_N$ is in $L^2(\mathbb R)$. No $L^2$ assumption is made about $g$ or their difference.

Use the [additive mixed energy](actual-source-mixed-dirichlet-completion.md):
$$
\mathcal E(f)=\int_0^1\|f(\cdot+h)-f\|_2^2dh+
\int_1^\infty\|f(\cdot+h)-f\|_2^2\frac{dh}{h^2},
\qquad \|f\|_{\mathcal E}=\mathcal E(f)^{1/2}.
\tag{2}
$$
Its increment expression is also meaningful for locally bounded functions outside $L^2$. There are fixed constants $C,b>0$ such that
$$
\boxed{\mathcal E(g-g_N)\le C(1+\sqrt{\log N})e^{-b\sqrt{\log N}}.}
\tag{3}
$$
Consequently the natural cutoffs converge to the actual causal representative $g$ in the mixed-energy completion, with norm error at most
$$
C(1+\log N)^{1/4}e^{-(b/2)\sqrt{\log N}}.
\tag{4}
$$
The proof works also for real cutoffs $N\ge2$, retaining the inclusive integer convention.

## Exact seed, jumps, and cutoff boundary

The complete finite source is
$$
g_N(x)=\frac1x\sum_{2\le n\le N}\Lambda(n)1_{x\ge n}
-\frac{\min(x,N)}x1_{x\ge1}.
\tag{5}
$$
Every prime power and the continuous density term remain in this formula. Its distributional derivative is the locally finite measure
$$
Dg_N=-\delta_1+\sum_{2\le n\le N}\frac{\Lambda(n)}n\delta_n
-1_{1<x<N}\frac{\psi(x)}{x^2}dx
-1_{x>N}\frac{E(N)}{x^2}dx.
\tag{6}
$$
The seed is exactly $-\delta_1$. At an integer cutoff the actual atom $\Lambda(N)/N$ is included; there is no additional atom from attaching the tail, whose value at $N$ matches the inclusive source value.

Put $q_N=g-g_N$. Then
$$
q_N(x)=0\ (x\le N),\qquad
q_N(x)=\frac{E(x)-E(N)}x\ (x>N),
$$
and
$$
\boxed{Dq_N=\sum_{n>N}\frac{\Lambda(n)}n\delta_n
-1_{x>N}\frac{\psi(x)-E(N)}{x^2}dx.}
\tag{7}
$$
In particular $q_N(N)=0$, both one-sided limits there are zero, and there is no cutoff atom. At integer $N$, the two actual $N$-th atoms cancel. Away from the future integers its derivative also equals $-1/x-q_N(x)/x$; this derivative need not be PNT-small. The jumps are retained alongside it.

## A uniform PNT envelope

Use the unconditional [successor/source envelope](successor-collective-prime-compatibility.md), equation (28):
$$
|E(x)|/x\le C_0 e^{-c\sqrt{\log x}},\qquad x\ge1.
\tag{8}
$$
That note identifies Trudgian, *Updating the error term in the prime number theorem*, [Theorem 1](https://arxiv.org/pdf/1401.2689), as a primary input. Reducing its positive exponent absorbs the logarithmic prefactor and the initial compact interval. We may take $0<c\le1$.

For $x>N$, put $t=\log x,\ s=\log N,\ v=t-s$. Since $\sqrt t-\sqrt s\le\sqrt v$ and $c\sqrt v-v\le c^2/4$,
$$
|g_N(x)|\le C_0e^{-v-c\sqrt s}
\le C_0e^{c^2/4}e^{-c\sqrt t}.
$$
For $x\le N$, use equality with $g$. Thus
$$
\boxed{|g_N(x)|+|g(x)|\le C e^{-c\sqrt{\log x}}\quad(x\ge1),}
\tag{9}
$$
uniformly in $N$. The attached continuous density satisfies the sharper tail estimate
$$
|E(N)|/x^2\le C N e^{-c\sqrt{\log N}}/x^2\quad(x>N).
\tag{10}
$$
For the difference density in (7), Chebyshev's bound and $|E(N)|\le CN$ give
$$
\left|1_{x>N}\frac{\psi(x)-E(N)}{x^2}\right|\le \frac Cx1_{x>N},
\qquad
\left\|1_{x>N}\frac{\psi(x)-E(N)}{x^2}\right\|_2^2\le C/N.
\tag{11}
$$

## A tail increment estimate without an $L^2$ source assumption

Integrating (7) over $(x,x+h]$ gives, for almost every $x$,
$$
q_N(x+h)-q_N(x)=
\sum_{\substack{n>N\\x<n\le x+h}}\frac{\Lambda(n)}n
-\int_x^{x+h}1_{u>N}\frac{\psi(u)-E(N)}{u^2}du.
\tag{12}
$$
An interval of length $h$ contains at most $h+1$ integers. Cauchy--Schwarz on this finite sum and Tonelli give
$$
\begin{aligned}
\int_{\mathbb R}\left|\sum_{\substack{n>N\\x<n\le x+h}}\frac{\Lambda(n)}n\right|^2dx
&\le h(h+1)\sum_{n>N}\frac{\Lambda(n)^2}{n^2}\\
&\le C h(h+1)\frac{\log^2(2N)}N.
\end{aligned}
\tag{13}
$$
The last step uses only $\Lambda(n)\le\log n$. Each fixed atom is sampled on a set of $x$'s of length exactly $h$. The continuous integral in (12) has squared $L^2$ norm at most $Ch^2/N$, by (11) and the convolution bound.

The two terms in (12) are not asserted orthogonal. Bounding the square of their difference by twice the sum of their squares proves
$$
\boxed{\|q_N(\cdot+h)-q_N\|_2^2
\le C h(h+1)\frac{\log^2(2N)}N\quad(h>0).}
\tag{14}
$$
Only a locally finite derivative measure and square-summable jump coefficients were used. No finite total variation on the full line or short-interval prime theorem is required.

## A global increment modulus for the natural cutoffs

For either $f=g_N$ or $f=g$, uniformly in $N$,
$$
\boxed{\|f(\cdot+h)-f\|_2^2\le
\begin{cases}
Ch,&0<h\le1,\\
Ch e^{-c_1\sqrt{\log h}},&h\ge2,
\end{cases}}
\tag{15}
$$
where one can take $c_1=c/8$ after enlarging constants. The interval $1<h<2$ has a uniform bounded estimate.

For small $h$, the derivative (6) and its full-source counterpart have uniformly square-summable atomic coefficients, including the seed $-1$. Their continuous densities have uniformly bounded $L^2$ norms: $\psi(x)/x^2\le C/x$, and the squared norm of the attached tail is $E(N)^2/(3N^3)\le C/N$. The same proof as (13) gives atomic energy $Ch$, and the continuous contribution is $Ch^2$. Both upper joins are accounted for by (6), with no artificial cutoff atom.

For large $h$, first (9), split at $\sqrt Z$, gives
$$
\int_1^Z |f(x)|^2dx\le C Z e^{-c\sqrt{\log Z}}\quad(Z\ge2).
\tag{16}
$$
Indeed the lower part is $O(\sqrt Z)$; the squared envelope on the upper part is at most $e^{-\sqrt2c\sqrt{\log Z}}$.

The distant-increment bound follows from an exact identity across the cutoff. Set $b_N(x)=E(\min(x,N))$. Then
$$
g_N(x+h)-g_N(x)=
\frac{b_N(x+h)-b_N(x)}{x+h}
-\frac{h\,b_N(x)}{x(x+h)},
\tag{17}
$$
where
$$
b_N(x+h)-b_N(x)=
\sum_{\min(x,N)<n\le\min(x+h,N)}\Lambda(n)
-\bigl[\min(x+h,N)-\min(x,N)\bigr].
\tag{18}
$$
Thus the density change and the denominator change are both retained. These equations include intervals crossing $N$ and the inclusive atom at an integer cutoff. Since $|b_N(x)|\le Cx$, the sum has at most $h+1$ terms, and its density length is at most $h$, for $h\ge1,\ x\ge2h$ they imply
$$
|g_N(x+h)-g_N(x)|\le C h\log x/x.
\tag{19}
$$
The same proof without the minimum gives (19) for $g$.

For sufficiently large $h$, put
$$
L=\log h,\qquad Y=h e^{(c/4)\sqrt L}\ge2h.
$$
On $-h\le x\le Y$, the energy is bounded by a constant times $\int_1^{Y+h}|f|^2$. Equation (16), together with $Y+h\le2Y$ and $\log(Y+h)\ge L$, bounds it by
$$
Ch e^{-(3c/4)\sqrt L}.
$$
On $x\ge Y$, (19) gives
$$
\int_Y^\infty|f(x+h)-f(x)|^2dx
\le C\frac{h^2\log^2Y}{Y}
\le Ch e^{-(c/8)\sqrt L}.
\tag{20}
$$
The last inequality absorbs the fixed logarithmic polynomial into half the exponent $c/4$. For $x<-h$, both source values vanish. Increasing constants handles the remaining bounded $h$, proving (15).

Since both increments in (15) are now proved to be in $L^2$, their difference satisfies
$$
\|q_N(\cdot+h)-q_N\|_2^2
\le Ch e^{-c_1\sqrt{\log h}}\quad(h\ge2),
\tag{21}
$$
uniformly in $N$. This does not bound $q_N$ through an unweighted $L^2$ norm.

## Quantitative mixed-energy convergence

For $N\ge4$, split the energy at $H=\sqrt N$. On $0<h\le1$, (14) contributes at most $C\log^2(2N)/N$. On $1<h\le H$, after division by $h^2$, it contributes at most
$$
C H\log^2(2N)/N=C N^{-1/2}\log^2(2N).
\tag{22}
$$
For $h>H$, (21) gives the explicit integral
$$
\begin{aligned}
\int_H^\infty e^{-c_1\sqrt{\log h}}\frac{dh}{h}
&=2\int_{\sqrt{\log H}}^\infty t e^{-c_1t}dt\\
&=2\left(\frac{\sqrt{\log H}}{c_1}+\frac1{c_1^2}\right)
e^{-c_1\sqrt{\log H}}.
\end{aligned}
\tag{23}
$$
Consequently
$$
\boxed{\mathcal E(q_N)\le C\left[
N^{-1/2}\log^2(2N)
+(1+\sqrt{\log N})e^{-(c_1/\sqrt2)\sqrt{\log N}}
\right].}
\tag{24}
$$
The first term is bounded by a constant times the second. This proves (3)--(4) with $b=c_1/\sqrt2$. Constants can be enlarged to cover $2\le N<4$.

The global modulus (15) also proves uniformly bounded mixed energies of $g_N$ and finite increment energy for $g$. The $L^2$ functions $g_N$ are Cauchy in the mixed norm by (3). Their limit has exactly the actual representative $g$: each fixed compact interval agrees with that source once $N$ passes it, and the common zero extension below one pins the constant-distribution ambiguity. This is the same representative identified by the earlier smooth logarithmic cutoffs.

The result includes the exact seed, every admitted $\Lambda(n)$, and the full density and tail $E(N)/x$. It proves neither $g\in L^2$ nor positivity of a subsequent signed readout, and makes no RH claim. The convergence in the mixed completion is the written theorem proved above.

