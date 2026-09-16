# A covariance load in the rough future cone

Let $N\ge2$, $\rho_N=e^{-2/N}$, and

$$
\langle f,g\rangle_N=(1-\rho_N)\sum_{m=1}^N\rho_N^m f(m)g(m),
\qquad Z_N(f)=\langle f,f\rangle_N.
$$

For a fixed cutoff $y$, put
$F_y(x)=\sum_{n\le x,\,P^+(n)\le y}\mu(n)$ and
$M(x)=\sum_{n\le x}\mu(n)$. The cutoff stays fixed throughout each
energy sum. Write

$$
\mathcal R_y(N)=\{d\le N:\mu(d)^2=1,\ P^-(d)>y\},\qquad
g_d(m)=F_y(\lfloor m/d\rfloor),
$$

with $1\in\mathcal R_y(N)$, $P^-(1)=\infty$, and $g_1=F_y$.
The disjoint smooth/rough factorization of each squarefree integer gives
the exact finite future-cone identity

$$
M(m)=\sum_{d\in\mathcal R_y(N)}\mu(d)g_d(m)\quad(1\le m\le N).
\tag{1}
$$

Consequently, if $T_N(y)=Z_N(M)-Z_N(F_y)$, then

$$
T_N(y)=B_N(y)+C_N(y),\qquad
B_N(y)=\sum_{\substack{d\in\mathcal R_y(N)\\d>1}}Z_N(g_d)\ge0,
\tag{2}
$$

$$
C_N(y)=2\!\sum_{\substack{d,e\in\mathcal R_y(N)\\d<e}}
\mu(d)\mu(e)\langle g_d,g_e\rangle_N.
\tag{3}
$$

If a prime $p$ lies in $(y,N]$, then $g_p(p)=F_y(1)=1$, so $B_N(y)>0$.
These are complete rough-cofactor blocks: each $g_d$ retains every
signed smooth prefix coefficient. In particular, $T_N(y)\le0$ requires
the off-diagonal covariance $C_N(y)\le-B_N(y)$. If independent
Rademacher signs are assigned to the primes above $y$, and their
products multiply the corresponding $\mu(d)g_d$ in (1), averaging the
resulting energy gives exactly $Z_N(F_y)+B_N(y)$. Thus prime-phase
orthogonality has the opposite mean sign from the desired transport
inequality.

## A superlinear load at square horizons

Set $N=H^2$, with $H\to\infty$ through integers, and
$y=(\log N)^2=4(\log H)^2$. For every prime $H/2<p\le H-1$,
eventually $p>y$, so $p\in\mathcal R_y(N)$. For every
$1\le u\le H$, the entire interval $pu\le m\le p(u+1)-1$
lies below $H^2$, and on it $g_p(m)=F_y(u)$. Since
$\rho_N^m\ge e^{-2}$,

$$
Z_N(g_p)\ge e^{-2}p(1-e^{-2/N})
               \sum_{u=1}^{H}F_y(u)^2
\ge e^{-2}p\frac{1-e^{-2/N}}{1-e^{-2/H}}Z_H(F_y).
\tag{4}
$$

The ratio in (4) is $H^{-1}(1+o(1))$, so each indicated prime
contributes at least $(e^{-2}/2+o(1))Z_H(F_y)$. By the prime number
theorem there are $(1+o(1))H/(2\log H)$ such primes. Hence

$$
B_{H^2}((\log H^2)^2)
\ge \left(\frac{e^{-2}}4+o(1)\right)
       \frac{H}{\log H}\,Z_H(F_{4(\log H)^2}).
\tag{5}
$$

The independently audited [exact-horizon signed smooth-energy theorem](signed-smooth-exact-horizon-energy.md),
applied at horizon $H$ with its fixed constant $c=4$, says

$$
Z_H(F_{4(\log H)^2})\ge
H\exp\!\left[\left(1+2\log2+o(1)\right)
               \frac{\log H}{\log\log H}\right].
\tag{6}
$$

Combining (5)–(6), and writing $L=\log N$, $\ell=\log L$, yields

$$
\boxed{\displaystyle
\log\frac{B_N((\log N)^2)}N\ge
\left(\frac12+\log2+o(1)\right)\frac L\ell
\qquad(N=H^2\to\infty).}
\tag{7}
$$

Thus an eventual nonpositive transport at $y=(\log N)^2$ would
force $C_N(y)\le-B_N(y)$, with a superlinear cancellation load of
the size in (7), at every sufficiently large square horizon. This is
an obstruction to blockwise orthogonality or independent-prime-phase
arguments. It does not establish the transport sign or RH.

## No universal contractive metric

There is also a finite-dimensional obstruction independent of the
special arithmetic source. For any prefix vector $f(1),\ldots,f(N)$,
extend $f$ by $f(0)=0$ and define

$$
(U_y f)(m)=
\sum_{\substack{d\le m\\\mu(d)^2=1,\ P^-(d)>y}}
\mu(d)f(\lfloor m/d\rfloor),\qquad 1\le m\le N.
\tag{8}
$$

Equation (1) is $U_yF_y=M$. In the standard basis of prefix vectors,
$U_y$ is lower triangular with every diagonal entry equal to $1$:
the $d=1$ term is $f(m)$, while every $d>1$ uses
$\lfloor m/d\rfloor<m$. If a prime $p\in(y,N]$ exists, the
coefficient of $f(1)$ in $(U_yf)(p)$ is $-1$, so $U_y\ne I$.

Suppose a positive-definite inner product made $U_y$ a contraction.
All singular values in that metric would be at most $1$, but their
product is $|\det U_y|=1$. Therefore all singular values equal $1$ and
$U_y$ is an isometry. A finite-dimensional isometry is diagonalizable
over $\mathbb C$, whereas a diagonalizable unipotent matrix is the
identity, a contradiction. Thus no positive-definite finite-horizon
metric makes this nontrivial future-cone operator contractive on every
prefix vector. This does not rule out a source-specific inequality for
$F_y$.
