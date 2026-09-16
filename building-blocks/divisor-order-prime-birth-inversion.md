# Divisor order and the inverse prime-birth cone

Fix $N\ge3$, put $\rho=e^{-2/N}$, and give real prefixes on
$\{1,\ldots,N\}$ the Abel norm

$$
\|f\|_N^2=Z_N(f)=(1-\rho)\sum_{m=1}^N\rho^m f(m)^2.
$$

Write $M(t)=\sum_{n\le t}\mu(n)$, with $M(0)=0$. For a set $B$ of
admitted primes, let

$$
F_B(m)=\sum_{\substack{n\le m\\\operatorname{PrimeFac}(n)\subseteq B}}\mu(n),
\qquad
G_B(m)=\#\{r\le m:(r,\prod_{q\in B}q)=1\}.
$$

The empty product is $1$, and $r=1$ is counted. Define
$(Df)(m)=\sum_{k\le m}f(\lfloor m/k\rfloor)$ and
$(S_pf)(m)=f(\lfloor m/p\rfloor)$, extending every prefix by $f(0)=0$.

## Exact inversion and order

For arbitrary prefixes $f,g$, divisor convolution gives

$$
g=Df
\quad\Longleftrightarrow\quad
f(m)=\sum_{k\le m}\mu(k)g(\lfloor m/k\rfloor)
=\sum_{r\le m}\bigl(g(r)-g(r-1)\bigr)M(\lfloor m/r\rfloor).
\tag{1}
$$

Indeed, the floor-shift operators obey $S_aS_b=S_{ab}$, so
$D=\sum_{k\le N}S_k$ and
$D^{-1}=\sum_{k\le N}\mu(k)S_k$ by
$\sum_{d\mid n}\mu(d)=\mathbf1_{n=1}$. Expanding $g$ into its successive
increments proves the second equality in (1). In particular,

$$
DF_B=G_B,
\qquad
F_B(m)=\sum_{\substack{r\le m\\r\text{ has no prime factor in }B}}
M(\lfloor m/r\rfloor).
\tag{2}
$$

The first identity follows by collecting the coefficient of each
$r\le m$: it is $\prod_{q\mid r,\,q\in B}(1-1)$.
Thus $G_B$ decreases pointwise as $B$ grows, and $G_B(m)=1$ when all
primes through $N$ have been admitted. The inverse in (1) has signed
Möbius rows; pointwise order of the $G_B$ alone does not give pointwise
order of the $F_B$.

## A prime step with its full composite history

Let $p$ be prime with $\sqrt N<p\le N$, and admit primes in ascending order,
so $B=\{q\text{ prime}:q<p\}$. Then, for every $m\le N$,

$$
\boxed{\quad
G_B(m)-G_{B\cup\{p\}}(m)=\mathbf1_{m\ge p},
\qquad
F_B(m)-F_{B\cup\{p\}}(m)=M(\lfloor m/p\rfloor).
\quad}
\tag{3}
$$

To prove this, $D$ commutes with $S_p$ and prime admission is
$F_{B\cup\{p\}}=(I-S_p)F_B$, so the same rule holds for $G_B$.
Since $\lfloor m/p\rfloor<p$, every integer from $2$ through
$\lfloor m/p\rfloor$ has an admitted prime factor. Hence
$G_B(\lfloor m/p\rfloor)$ is $0$ below $p$ and $1$ from $p$ onward.
All prime factors of any integer $t<p$ also lie in $B$, so
$F_B(t)=M(t)$. This proves both parts of (3).

The positive unit step in $G$ therefore lifts to a cone containing all
the composite-cofactor effects encoded by $M(\lfloor m/p\rfloor)$.
It equals $1$ for $p\le m<2p$, $0$ for $2p\le m<3p$, and $-1$ for
$3p\le m<5p$. In particular, if $\sqrt N<p\le N/3$, then at $m=3p$
the admission strictly decreases $G$ but **increases** $F$, because
$M(3)=-1$. This is a counterexample to pointwise transfer of the
source-specific order law along the actual ascending-prime path.
There is also a fixed-energy increase on the same path. At $N=6$,
$B=\{2\}$ and $p=3$, one has
$F_B=\mathbf1_{m=1}$ and
$F_{B\cup\{3\}}=\mathbf1_{m=1}-\mathbf1_{3\le m\le5}$. Hence

$$
Z_6(F_{B\cup\{3\}})-Z_6(F_B)
=(1-\rho)\sum_{m=3}^5\rho^m>0,
$$

while $G_{B\cup\{3\}}\le G_B$ pointwise.

For $p>N/2$, the horizon cuts off every composite continuation and
$M(\lfloor m/p\rfloor)=\mathbf1_{m\ge p}$. More generally, $D$ and
$D^{-1}$ both act as the identity on the subspace of prefixes supported
on $\{\lfloor N/2\rfloor+1,\ldots,N\}$. If $H_N(m)$ counts primes in
$(N/2,m]$, then

$$
B_0=\{q\text{ prime}:q\le N/2\}
\quad\Longrightarrow\quad
G_{B_0}=\mathbf1+H_N,
\qquad F_{B_0}=M+H_N.
\tag{4}
$$

Consequently the late positive order decrement $H_N$ has exactly the
same Abel norm after inversion. Its energy is of order
$N^2/\log^2N$ by the prime number theorem; the exact constant and
the compensating covariance with $F_{B_0}$ are given in
[the upper-prime shell calculation](upper-prime-plaquette-and-shell-cancellation.md).
No bound for $Z_N(M)$ follows from the order decrement alone.

## Weighted singular distortion

The matrix rows of $D$ and its inverse are explicit:

$$
D_{m,j}=\left\lfloor\frac mj\right\rfloor
-\left\lfloor\frac m{j+1}\right\rfloor,
\qquad
(D^{-1})_{m,j}=
M\!\left(\left\lfloor\frac mj\right\rfloor\right)
-M\!\left(\left\lfloor\frac m{j+1}\right\rfloor\right).
\tag{5}
$$

These entries also quantify the failure of a uniform norm comparison.
Let $\sigma_{\max,N}$ and $\sigma_{\min,N}$ denote singular values in
the Abel norm at horizon $N$. Its weights lie between constant
multiples of $1/N$, uniformly in $1\le m\le N$. From
$D_{m,j}=m/[j(j+1)]+O(1)$, the rank-one main matrix has Euclidean
operator norm $\Theta(N^{3/2})$, while the error matrix has norm
$O(N)$ by its Frobenius norm. Thus

$$
\sigma_{\max,N}(D)=\Theta(N^{3/2}).
\tag{6}
$$

The inverse also expands some directions. In its row $m=N$, the
quotients $j_k=\lfloor N/k\rfloor$ are distinct for
$1\le k\le\lfloor\sqrt N\rfloor-1$; each such column has coefficient
exactly $\mu(k)$, since its floor preimage contains only $k$.
The elementary squarefree count
$\sum_{k\le x}\mu(k)^2=(6/\pi^2)x+O(\sqrt x)$ therefore gives a row
Euclidean norm $\gg N^{1/4}$. Uniform comparability of the Abel
weights yields

$$
\sigma_{\max,N}(D^{-1})\gg N^{1/4},
\qquad
\sigma_{\min,N}(D)\ll N^{-1/4}.
\tag{7}
$$

Equations (6)--(7) concern arbitrary prefixes, while (3)--(4)
identify what happens on actual admitted-prime histories. To expose
the missing estimate, put $a_B(r)=G_B(r)-G_B(r-1)\in\{0,1\}$. Equation
(1) gives the exact Gram expansion

$$
Z_N(F_B)=\sum_{r,s\le N}a_B(r)a_B(s)K_N(r,s),
\qquad
K_N(r,s)=\bigl\langle M(\lfloor\cdot/r\rfloor),
M(\lfloor\cdot/s\rfloor)\bigr\rangle_N.
\tag{8}
$$

This is a positive-semidefinite kernel, but its individual cross terms
need not be positive: at $N=6$,
$K_6(1,2)=(1-\rho)(\rho^6-\rho^3)<0$.
Pointwise deletion of positive $a_B(r)$ therefore has no automatic
quadratic-form sign. Neither (6)--(8) establishes an RH-scale estimate.
Such a transfer would need a new source-specific bound on these signed
cross-scale terms, especially the covariance between the upper-prime
cone and the earlier composite history in (4).
