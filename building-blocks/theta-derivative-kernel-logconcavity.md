# Strict log-concavity of the derivative of the square-root theta kernel

For the complete Riemann theta kernel, the function
$g(v)=-\frac{d}{dv}\Phi(\sqrt v)$ is positive and strictly log-concave on $[0,\infty)$. The proof below combines an Arb certificate on a compact interval with an analytic estimate on the entire remaining half-line. Applying normalized Mellin log-concavity to this derivative extends a variance bound, and its associated zero-free region, by one unit to the left.

## Definitions and theorem

Use the normalization

$$
\Phi(u)=\sum_{n=1}^{\infty}
\left(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2}\right)
e^{-\pi n^2e^{2u}},
\qquad Z=2\int_0^\infty\Phi(u)\,du>0.
\tag{1}
$$

The complete kernel is even and analytic near zero. Its series and all its derivatives converge locally uniformly for real $u\ge0$, and its real derivatives decay faster than every Gaussian as $u\to\infty$. These facts and the complex-disk estimates used below are established in the [theta Mellin obstruction note](theta-mellin-bernstein-obstruction.md).

Put $f(v)=\Phi(\sqrt v)$. Evenness gives an analytic extension of $f$ to a neighborhood of zero. Thus

$$
g(v)=-f'(v)=
\begin{cases}
-\Phi'(\sqrt v)/(2\sqrt v),&v>0,\\
-\Phi''(0)/2,&v=0
\end{cases}
\tag{2}
$$

is smooth on $[0,\infty)$; derivatives at zero refer to this analytic extension.

**Theorem 1.** For every $v\ge0$,

$$
g(v)>0,
\qquad
(\log g)''(v)<0.
\tag{3}
$$

The certificate for the compact part is [theta_derivative_kernel_logconcavity.py](certificates/theta_derivative_kernel_logconcavity.py). It evaluates the complete kernel using explicit bounds for every omitted theta term and Taylor coefficient.

## A regular curvature expression away from zero

Write $u=\sqrt v>0$ and abbreviate derivatives of $\Phi$ by primes. Direct differentiation of (2), wherever $\Phi'<0$, gives

$$
4u^4\Phi'(u)^2(\log g)''(u^2)
=u^2\Phi'\Phi'''-u^2(\Phi'')^2-u\Phi'\Phi''+2(\Phi')^2.
\tag{4}
$$

Denote the right side by $E(u)$. Proving $\Phi'(u)<0$ and $E(u)<0$ proves (3) for that value of $u$. Near zero, Taylor expansion avoids the cancellations in (4).

## Certification on $0\le v\le1$

The certificate uses 160-bit Arb arithmetic. An interval comparison is accepted only when the entire enclosing ball has the asserted strict sign.

### The endpoint interval $0\le v\le1/100$

Write

$$
\Phi(u)=\sum_{m\ge0}a_m u^{2m}.
$$

On $|u|\le1/2$, the bounds from the obstruction note are

$$
|\Phi(u)|<10000,
\qquad
\left|\sum_{n\ge25}\Phi_n(u)\right|\le
D_{\rm disk}:=952\,25^4e^{-625/2}.
\tag{5}
$$

For completeness, each theta summand on this disk is bounded by
$476n^4e^{-n^2/2}$. This follows from
$\Re(e^{2u})\ge e^{-1}\cos1>1/6$,
$3<\pi<22/7$, and elementary bounds on the two exponential prefactors. The full sum is less than 10000. For $n\ge25$, the ratio of successive $n^4e^{-n^2/2}$ terms is less than $1/2$, proving the second bound in (5).

The finite sum over $1\le n\le24$ supplies even coefficients through degree 40. To compute a summand, set $p=\pi n^2$, expand

$$
b_j=-p\,2^j/j!,\qquad c_0=e^{-p},\qquad
c_j=\frac1j\sum_{k=1}^j k b_k c_{j-k},
\tag{6}
$$

and multiply $\sum_jc_ju^j$ by
$4p^2e^{9u/2}-6pe^{5u/2}$. Cauchy's estimate adds an error radius $D_{\rm disk}4^m$ to the resulting coefficient of $u^{2m}$. The finite theta sum need not be even; only the complete kernel's evenness is used to identify these coefficients with those of $f$.

For $j=0,1,2$, differentiate the degree-20 polynomial for $f$ a total of $j+1$ times, with a minus sign. This gives polynomial enclosures for $g^{(j)}$. The remaining series is bounded uniformly on the whole interval by

$$
\varepsilon_j=
10000\,4^{j+1}21^{j+1}
\frac{q^{20-j}}{1-2q},
\qquad q=\frac1{25}.
\tag{7}
$$

Indeed, $|a_m|\le10000\,4^m$. For the first omitted index $m=21$, bound the relevant falling factorial by $m^{j+1}$ and use $4v\le q$. The ratio of subsequent majorants is at most
$q((m+1)/m)^{j+1}<2q$. This proves (7), including at $v=0$.

Horner evaluation on an enclosing ball for $[0,1/100]$, followed by addition of the radii (7), gives enclosing balls $G,G_1,G_2$ for $g,g',g''$. The certificate establishes

$$
G>0,\qquad GG_2-G_1^2<0.
\tag{8}
$$

These are interval statements over the entire endpoint interval. Since
$(\log g)''=(gg''-(g')^2)/g^2$, they prove both inequalities in (3) there.

### The interval $1/10\le u\le1$

Set $y_n=\pi n^2e^{2u}$. The summands and their first three derivatives have the form

$$
\Phi_n^{(j)}(u)=e^{u/2-y_n}Q_j(y_n),\qquad
Q_0(y)=4y^2-6y,
$$

$$
Q_{j+1}(y)=(1/2-2y)Q_j(y)+2yQ_j'(y).
\tag{9}
$$

For $0\le j\le3$, their degrees are at most five and their coefficient absolute sums are less than 5000. On the stated interval, $e^{u/2}<2$ and $y_n\ge3n^2$. For $n\ge9$, monotonicity of $x^5e^{-x}$ for $x\ge5$ therefore gives

$$
|\Phi_n^{(j)}(u)|
\le2\cdot5000\,(3n^2)^5e^{-3n^2}.
$$

The ratio of consecutive $n^{10}e^{-3n^2}$ terms is less than $1/2$ for $n\ge9$. A common error bound after the first eight summands is consequently

$$
T=4\cdot5000\cdot3^5\cdot9^{10}e^{-243}<10^{-80}.
\tag{10}
$$

The certificate encloses each of $\Phi,\Phi',\Phi'',\Phi'''$ by evaluating (9) for $1\le n\le8$ and adding a radius $T$. It begins with exact rational endpoints $1/10$ and $1$, bisects rational intervals, and accepts an interval only if its full enclosures establish

$$
\Phi'<0,\qquad E<0.
\tag{11}
$$

Each midpoint and radius is itself enclosed in Arb, so rounding cannot leave gaps between adjacent intervals. If a sign is not established, the interval is subdivided. A width guard causes failure instead of accepting an unresolved interval. The completed run establishes (11) on a finite covering of $[1/10,1]$.

This is a proof by interval enclosure, rather than a test at finitely many sample points. Together, (8), (11), and (4) prove (3) on $0\le v\le1$. Their ranges meet at $u=1/10$, or $v=1/100$, with both endpoints included.

## The complete analytic tail $u\ge1$

Put $y=\pi e^{2u}>20$ and

$$
P(y)=8y^2-30y+15=8(y-a)(y-b),
\qquad
a=\frac{15-\sqrt{105}}8,
\quad b=\frac{15+\sqrt{105}}8.
\tag{12}
$$

In particular $0<a<b<4$. Differentiating a summand gives

$$
-\Phi_n'(u)=e^{u/2}n^2yP(n^2y)e^{-n^2y}>0.
$$

Thus all summands of $g(u^2)$ are positive on this range. Let

$$
g_1(u^2)=\frac{e^{u/2}yP(y)e^{-y}}{2u},
\qquad
g(u^2)=g_1(u^2)(1+R),
\qquad R=\sum_{n\ge2}r_n,
\tag{13}
$$

where

$$
r_n=\frac{n^2P(n^2y)}{P(y)}e^{-(n^2-1)y}.
\tag{14}
$$

### Curvature of the first summand

For $h(u)=\log g_1(u^2)$, differentiation of (12)–(13) gives

$$
uh''-h'=-(4u-2)y-\frac52+\frac2u
-\sum_{c\in\{a,b\}}
\frac{2y^2+(4u-2)cy}{(y-c)^2}
\le-2uy.
\tag{15}
$$

Here $u\ge1$, so the displayed sum has positive terms,
$-5/2+2/u<0$, and $4u-2\ge2u$. Since differentiation with respect to $v=u^2$ gives
$(\log g_1)''=(uh''-h')/(4u^3)$, it follows that

$$
(\log g_1)''(v)\le-\frac{y}{2u^2}.
\tag{16}
$$

### Bounds for every remaining summand

Since $y>20$ and $a,b<4$,

$$
\frac{P(n^2y)}{P(y)}
\le n^4\left(\frac{y}{y-4}\right)^2<2n^4,
\qquad
0<r_n\le2n^6e^{-(n^2-1)y}.
\tag{17}
$$

Write $\ell_n=\log r_n$, with subscripts $y$ denoting derivatives in $y$. Then

$$
\ell_{n,y}=-(n^2-1)
-\sum_{c\in\{a,b\}}
\frac{c(n^2-1)}{(n^2y-c)(y-c)},
\tag{18}
$$

$$
\ell_{n,yy}=
\sum_{c\in\{a,b\}}
\left(\frac1{(y-c)^2}
-\frac{n^4}{(n^2y-c)^2}\right).
\tag{19}
$$

Each summand of (19) is positive, since
$n^2y-c>n^2(y-c)$. The same elementary bounds imply

$$
|\ell_{n,y}|\le2n^2,
\qquad 0<\ell_{n,yy}<\frac{16}{y^2}.
\tag{20}
$$

Also

$$
y_v=\frac yu,
\qquad y_{vv}=\frac{y(2u-1)}{2u^3},
\qquad 0<y_{vv}\le\frac y{u^2}.
$$

Combining these bounds with
$r_{n,vv}=r_n[(\ell_{n,y}^2+\ell_{n,yy})y_v^2+
\ell_{n,y}y_{vv}]$ gives, for $n\ge2$,

$$
|r_{n,vv}|
\le\frac{2n^6}{u^2}
\left(4n^4y^2+16+2n^2y\right)e^{-(n^2-1)y}
\le\frac{11n^{10}y^2}{u^2}e^{-(n^2-1)y}.
\tag{21}
$$

The last inequality follows already from $n\ge2$ and $y\ge20$.
For these same values,

$$
\frac{(n+1)^{10}e^{-((n+1)^2-1)y}}
{n^{10}e^{-(n^2-1)y}}
=\left(1+\frac1n\right)^{10}e^{-(2n+1)y}
\le(3/2)^{10}e^{-100}<\frac12.
$$

Consequently,

$$
|R_{vv}|\le
\frac{22528y^2e^{-3y}}{u^2}
<\frac{y}{2u^2}.
\tag{22}
$$

For the final strict inequality, $ye^{-3y}$ decreases for $y\ge20$ and
$45056\cdot20e^{-60}<1$. For example,
$e^{60}>60^6/6!>901120$.

The series defining $R$, $R_v$, and $R_{vv}$ converge uniformly on every compact subinterval of $u\ge1$. This follows from (17), (20), and (21), which bound them by polynomial factors in $n$ times $e^{-20(n^2-1)}$. Termwise differentiation and the identity

$$
(\log g)''=(\log g_1)''
+\frac{R_{vv}}{1+R}-\frac{R_v^2}{(1+R)^2}
\tag{23}
$$

are therefore justified. Since $R\ge0$, (16) and (22) make (23) strictly negative. This proves (3) for $v\ge1$. The analytic tail and the compact certificate both include $v=1$, completing the proof of Theorem 1.

## A shifted Mellin representation

Define

$$
A(p)=\int_0^\infty v^{p-1}f(v)\,dv
\quad(\Re p>0),
\qquad
B(q)=\int_0^\infty v^{q-1}g(v)\,dv
\quad(\Re q>0).
\tag{24}
$$

Both integrals are holomorphic on their indicated half-planes. At zero the kernels are bounded; at infinity their decay dominates every power. The same bounds, with arbitrary fixed powers of $|\log v|$, justify differentiation on compact subsets of these half-planes.

Use the entire auxiliary function from the obstruction note,

$$
L(z)=F(z+1)
=\frac{\sqrt\pi\,4^{-z}}{Z}
\frac{A(z+1/2)}{\Gamma(z+1/2)},
\qquad \Re z>-1/2.
\tag{25}
$$

**Proposition 2.** On the larger half-plane $\Re z>-3/2$,

$$
L(z)=\frac{\sqrt\pi\,4^{-z}}{Z}
\frac{B(z+3/2)}{\Gamma(z+3/2)}.
\tag{26}
$$

**Proof.** For $\Re p>0$, integration by parts is legitimate at both endpoints and gives

$$
B(p+1)=-\int_0^\infty v^pf'(v)\,dv=pA(p).
$$

The gamma recurrence proves (26) initially for $p=z+1/2$ with $\Re p>0$. Its right side is holomorphic for $\Re p>-1$. The identity theorem, using the established entire continuation of $L$, proves (26) throughout that connected half-plane.

In particular $p=0$ causes no exception. The original $A(p)$ has a simple pole with residue $f(0)$; its product with $1/\Gamma(p)$ has the finite value $f(0)$. The new formula gives the same value because
$B(1)=\int_0^\infty g(v)\,dv=f(0)$.

## Variance and zero-free consequences

For real $q>0$, let

$$
d\nu_q(v)=\frac{v^{q-1}g(v)}{B(q)}\,dv,
\qquad Y=\log v.
$$

Theorem 1 and the normalized Mellin log-concavity theorem imply that
$B(q)/\Gamma(q)$ is log-concave. The result used is Proposition 3.2 at concavity parameter zero in [Fradelizi, Li and Madiman, *Concentration of information content for convex measures*](https://arxiv.org/html/1512.01490). Differentiation under the integral therefore gives

$$
\operatorname{Var}_{\nu_q}(Y)=(\log B)''(q)\le\psi_1(q),
\tag{27}
$$

where $\psi_1$ is the trigamma function.

The finite-variance speed inequality proved in the [quantum speed note](theta-mellin-quantum-speed-bound.md) states that, for any real random variable of variance $\Delta^2$,

$$
|\mathbb E e^{itY}|\ge\cos(|t|\Delta)
\qquad\text{if }|t|\Delta\le\pi/2.
\tag{28}
$$

One can obtain (28) directly by centering $Y$, writing its characteristic function as $\chi$, and using
$|\chi'|\le\Delta\sqrt{1-|\chi|^2}$. Integrating the resulting inequality for $\arccos|\chi|$, with a regularization at modulus one, proves (28).

Take $q=\sigma+3/2>0$. Equations (26)–(28) yield

$$
|L(\sigma+it)|\ge
L(\sigma)\frac{\Gamma(q)}{|\Gamma(q+it)|}
\cos\!\left(|t|\sqrt{\psi_1(q)}\right)
\tag{29}
$$

whenever the cosine argument is at most $\pi/2$. Since $L(\sigma)>0$ and $\Gamma$ is finite and nonzero on $\Re q>0$,

$$
\boxed{\quad
\sigma>-3/2,\qquad
t^2\psi_1(\sigma+3/2)<\frac{\pi^2}{4}
\quad\Longrightarrow\quad L(\sigma+it)\ne0.
\quad}
\tag{30}
$$

For $\sigma>-1$, apply the strict midpoint inequality to the strictly convex function $x\mapsto x^{-2}$ on each interval of length one, starting at $\sigma+1$. Summing gives

$$
\psi_1(\sigma+3/2)
=\sum_{n=0}^\infty\frac1{(n+\sigma+3/2)^2}
<\int_0^\infty\frac{dx}{(x+\sigma+1)^2}
=\frac1{\sigma+1}.
$$

Thus a simpler region, including its parabolic boundary, is

$$
\boxed{\quad
\sigma>-1,\qquad
t^2\le\frac{\pi^2}{4}(\sigma+1)
\quad\Longrightarrow\quad L(\sigma+it)\ne0.
\quad}
\tag{31}
$$

The strict trigamma comparison explains why equality is allowed in (31), whereas the variance-only condition in (30) is strict.

## Attribution, reproducibility, and scope

The classical theorem of Csordas proves that $v\mapsto\Phi(\sqrt v)$ is strictly convex for $v>0$, so $g$ is decreasing there. See [*Convexity and the Riemann ξ-function*, Theorem 2.12](https://web.math.pmf.unizg.hr/glasnik/33.1/33105.pdf), *Glasnik matematički* 33, 1998, pp. 37–50. In that paper's normalization, $\Phi(u)=2\Phi_{\rm C}(u/2)$, so the change of variable preserves convexity. The earlier [Csordas–Varga paper, *Moment inequalities and the Riemann Hypothesis*](https://www.math.kent.edu/~varga/pub/paper_161.pdf), *Constructive Approximation* 4, 1988, pp. 175–198, establishes theta-kernel log-concavity. Neither of these cited properties alone supplies the derivative log-concavity asserted in Theorem 1.

Recent adjacent work is Planat and Solé's [*Second-Level Concavity of the Riemann Ξ Kernel*](https://arxiv.org/abs/2608.19160). Their Theorem 1.1 concerns log-concavity of
$s'(t)^2-s(t)s''(t)$, where $s(t)=\Phi_{\rm C}(\sqrt t)$.
The present theorem concerns $-s'(t)$, after the normalization change. These are different expressions, and no implication between the two assertions is used here. Their use of a compact-interval proof and a first-summand estimate for the infinite tail is also prior methodological context for that proof structure.

To reproduce the compact certificate from the repository root with Python 3 and python-flint 0.9.0 available, run

```sh
python3 building-blocks/certificates/theta_derivative_kernel_logconcavity.py
```

Run without Python's `-O` option, because the proof checks use assertions. The certificate computes its coefficients directly and requires no precomputed numerical table. Its accepted interval comparisons establish the compact part of Theorem 1; equations (12)–(23) establish the unbounded part. The proof relies on Arb's enclosing arithmetic and on the explicit error estimates (5), (7), and (10).

No publication-priority claim is made. This is a computer-assisted mathematical proof, not a Lean formalization. The zero-free regions concern the auxiliary Mellin function $L$. They imply neither the Riemann hypothesis nor membership of a coefficient interpolation in a Bernstein-function class.
