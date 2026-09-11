# Undamped prime products in Nyman–Beurling approximation

Successive undamped prime-division factors fail to approximate the Nyman–Beurling target in its required Hilbert norm, even after optimal scalar normalization. This is a test of one explicit construction, not a failure of the Nyman–Beurling criterion.

Work in $L^2((0,\infty),dx)$. Put $\chi=1_{(0,1]}$, $f(x)=\{1/x\}$, and $D_pf(x)=f(px)$. For
```math
P=\prod_{p\le y}p,\qquad
\delta=\frac{\phi(P)}P=\prod_{p\le y}(1-1/p),
```
the exact finite Euler product is
```math
g_P(x)=\prod_{p\le y}(I-D_p)f(x)
=\sum_{d\mid P}\mu(d)\{1/(dx)\}.
\tag{1}
```
With $t=1/x$, inclusion-exclusion gives
```math
g_P(x)=\delta t-C_P(t),\qquad
C_P(t)=\#\{n\le t:(n,P)=1\}.
\tag{2}
```
This includes the empty divisor history $d=1$. The divisions are literal dilations $t\mapsto t/d$; the additive clock reveals the integers counted by $C_P$.

Let $q$ be the first prime greater than $y$. For $0<t<1$, the count in (2) is zero; for $1\le t<q$, it is one. Every integer in $[2,q)$ has a prime divisor already in $P$. Therefore
```math
g_P(x)=\delta/x-\chi(x)\qquad(x>1/q).
\tag{3}
```
The single endpoint $x=1/q$ does not affect an $L^2$ integral.

Define
```math
B=1-1/q,\quad A=q\delta^2-2\delta\log q+B,
\quad D=B-\delta\log q.
```
For every complex scalar $a$, direct integration of (3) yields
```math
\begin{aligned}
\|ag_P+\chi\|_2^2
&\ge\int_{1/q}^\infty|a\delta/x+(1-a)\chi(x)|^2dx\\
&=A|a|^2-2D\Re a+B\\
&\ge B-D^2/A.
\end{aligned}
\tag{4}
```
Here $A>0$, since it is the squared norm of $g_P$ on that region. The optimized restricted lower bound is exactly
```math
B-\frac{D^2}{A}
=\frac{\delta^2[q-1-(\log q)^2]}
{q\delta^2-2\delta\log q+1-1/q}.
\tag{5}
```
Mertens' product theorem gives $\delta\sim e^{-\gamma}/\log y$; PNT gives $q\sim y$. Hence $A\sim q\delta^2\to\infty$ and $D\to1-e^{-\gamma}$. Since $a=0$ has squared error one, (4) proves
```math
\boxed{\inf_{a\in\mathbb C}\|ag_P+\chi\|_2^2\longrightarrow1.}
\tag{6}
```
The lower bound in (5) is more precisely
```math
1-[(e^\gamma-1)^2+o(1)]\frac{\log^2y}{q}.
```

On every fixed compact interval away from zero, (3) eventually holds and $g_P\to-\chi$ locally in $L^2$. If a scalar-normalized sequence $a_Pg_P$ also tends locally to $-\chi$, its behavior on $[1/2,1]$ forces $a_P\to1$. Equation (4) then gives
```math
\boxed{\|a_Pg_P+\chi\|_2^2\ge(1+o(1))q\delta^2\longrightarrow\infty.}
\tag{7}
```
Conversely, bounded global error in (4) forces $a_P\to0$. Thus multiplying by scalar normalizers at prime arrivals cannot repair this product.

There is a related rigidity statement for fixed local Euler weights. Suppose
```math
h_y=a_y\prod_{p\le y}(I-w_pD_p)f,
```
where each $w_p$ is independent of $y$. On $1<t<2$, this is the affine function
```math
\beta_y t-a_y,\qquad
\beta_y=a_y\prod_{p\le y}(1-w_p/p).
```
Local convergence to $-1$ forces $a_y\to1$ and $\beta_y\to0$. At any fixed prime $p$, once $y\ge p$, the jump at $t=p$ is $-a_y(1-w_p)$. The functions on the fixed open intervals immediately to either side have common slope $\beta_y$, so local convergence forces this jump to tend to zero. Consequently every $w_p=1$, returning to (1) and its obstruction. Cutoff-dependent weights are outside this statement.

The distinction between local convergence and convergence in the full Hilbert norm is established in the literature. Báez-Duarte's [arithmetic Nyman–Beurling paper, Section 4.2](https://arxiv.org/html/math/0011254#S4.SS2) proves divergence for the usual integer-cutoff sequence $S_n=\sum_{k\le n}\mu(k)\{1/(kx)\}$ and its normalized variant $V_n$. Our support in (1) consists of all divisors of a primorial, rather than all integers up to a cutoff; (4) supplies a direct quantitative test for that support and for arbitrary scalar normalizers. We do not claim priority for prime-product divergence. The [strengthened criterion](https://arxiv.org/abs/math/0205003) also supplies, under RH, a convergent family with damping depending on the cutoff. That established conditional result is not contradicted or proved unconditionally here.

The failed step is now specific: over the growing interval before the next coprime arrival, the count in (2) remains one while the density term $\delta t$ accumulates excessive norm. A successful use of the criterion must control this behavior through a different approximation, with an unconditional argument for its full norm. Equations (6) and (7) do not provide that argument or prove RH.

The asymptotic inputs are classical [Mertens product asymptotics](https://dlmf.nist.gov/27.12) and the prime number theorem. The finite lower bound (4) is a direct Hilbert-space projection calculation. This note is a building block for testing approximants, with exact priority unresolved and no Lean formalization.
