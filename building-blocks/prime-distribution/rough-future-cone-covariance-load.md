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

The square case extends to a family of exact cutoffs without a
uniform-in-$c$ input. Fix an integer $m\ge1$, let $A\to\infty$ through
integers, and set $H=A^m$, $N=A^{m+1}=AH$. Then
$y=(\log N)^2=((m+1)/m)^2(\log H)^2$. For primes
$A/2<p\le A-1$ and every $u\le H$, the full block from $pu$
to $p(u+1)-1$ lies below $N$, because
$p(H+1)-1\le(A-1)(A^m+1)-1\le A^{m+1}=N$.
Repeating (4) and using the prime
number theorem gives

$$
B_N(y)\gg \frac{A}{\log A}\,Z_H(F_y).
$$

Applying the same signed smooth-energy theorem at $H$ with the fixed
constant $c=((m+1)/m)^2$ yields

$$
\log\frac{B_N((\log N)^2)}N
\ge(\beta_m+o(1))\frac{\log N}{\log\log N},
\qquad
\beta_m=\frac{m}{m+1}
\left(1+\log2+\log\frac{m+1}{m}\right).
\tag{8}
$$

The coefficients $\beta_m$ increase to $1+\log2$: for
$q=1+1/m$, the function
$(1+\log2+\log q)/q$ has derivative
$-(\log2+\log q)/q^2<0$, while $q\downarrow1$. Therefore, for
every fixed $\eta>0$, some fixed $m$ gives an infinite perfect-power
subsequence with the exponent $1+\log2-\eta$. This still estimates
the positive block load, not the sign of the complete transport.

## Nearby rough primes reinforce the positive load

The same square horizons show why a local prime-pair sign will not
cancel the blocks. If $p,q\in(H/2,H-1]$ and
$\Delta=|p-q|$, then for $x\le H^2$,

$$
\left|\left\lfloor\frac{x}{p}\right\rfloor-
       \left\lfloor\frac{x}{q}\right\rfloor\right|
\le \frac{H^2\Delta}{pq}+1\le4\Delta+1.
$$

Each jump of $F_y$ has absolute size at most $1$. Thus
$|g_p(x)-g_q(x)|\le4\Delta+1$ and
$Z_N(g_p-g_q)\le(4\Delta+1)^2$, since the Abel weights sum to
less than $1$. For $\Delta\le3\log H$, polarization and (4) give

$$
\langle g_p,g_q\rangle_N
=\tfrac12\bigl(Z_N(g_p)+Z_N(g_q)-Z_N(g_p-g_q)\bigr)
\ge\left(\frac{e^{-2}}2+o(1)\right)Z_H(F_y)
      -O((\log H)^2)>0.
\tag{9}
$$

The final inequality uses (6), which makes $Z_H(F_y)\gg H$.
There are $\asymp H/\log H$ primes in $(H/2,H-1]$ by the prime
number theorem, and their consecutive gaps have average
$(1+o(1))\log H$. At least a fixed positive fraction of these
consecutive gaps are at most $3\log H$. Since
$\mu(p)\mu(q)=+1$, their contribution to the off-diagonal
covariance in (3) is positive and
$\gg (H/\log H)Z_H(F_y)$. Thus a negative total covariance
would have to overcome this positive near-prime contribution as well
as $B_N(y)$. The estimate identifies a further local obstruction;
it does not locate the compensating negative terms.

## Local bilinear signs already vary

At the actual cutoff $N=97$, $y=(\log97)^2\in(20,21)$, the two
adjacent rough primes $23$ and $29$ give opposite signs. Put

$$
S_p(t)=\sum_{m=1}^{97}F_y(m)F_y(\lfloor m/p\rfloor)t^m,\qquad
V_p(t)=\sum_{m=1}^{97}F_y(\lfloor m/p\rfloor)^2t^m.
$$

The elementary exponential bounds
$1-x\le e^{-x}\le1-x+x^2/2$ give
$979/1000<\rho_{97}<980/1000$. Compute $F_y$ by the finite
Möbius sieve over the primes $2,3,5,7,11,13,17,19$.
For each positive polynomial coefficient use the lower endpoint to
bound below and the upper endpoint to bound above; reverse endpoints
for negative coefficients. These rational calculations give

$$
-21<S_{23}(\rho_{97})<-17,\qquad
16<S_{29}(\rho_{97})<20,
$$

$$
16<V_{23}(\rho_{97})<18,\qquad
13<V_{29}(\rho_{97})<15.
$$

The second pair alone is too coarse to certify the $p=29$
increment, but the same rational endpoint calculation gives
$V_{29}(\rho_{97})-2S_{29}(\rho_{97})<-19$.
For $p=23$ it gives
$V_{23}(\rho_{97})-2S_{23}(\rho_{97})>50$.
Multiplication by $1-\rho_{97}>0$ yields
$\langle F_y,g_{23}\rangle_{97}<0<
\langle F_y,g_{29}\rangle_{97}$ and opposite signs for
$Z_{97}(g_p)-2\langle F_y,g_p\rangle_{97}$.
Thus neither a termwise bilinear sign nor a one-prime transport sign
holds for the actual smooth source.

## The weaker RH-scale target

The strict sign $C_N(y)\le-B_N(y)$ is one route to RH, but it is
stronger than the energy bound needed for a proof. Let
$P_y=\prod_{p\le y}(1+p^{-1/2})$. Rankin's finite inequality gives

$$
|F_y(u)|\le\sqrt u\sum_{P^+(n)\le y}\frac{\mu(n)^2}{\sqrt n}
=P_y\sqrt u.
$$

At $y=(\log N)^2$, the prime number theorem gives
$\log P_y=O(\log N/\log\log N)=o(\log N)$. Therefore

$$
Z_N(F_y)\ll NP_y^2=N^{1+o(1)},
\qquad
B_N(y)\ll NP_y^2\sum_{d\le N}\frac1d
=N^{1+o(1)}.
\tag{10}
$$

Indeed, $|g_d(m)|\le P_y\sqrt{m/d}$ and
$(1-\rho_N)\sum_{m\le N}m\rho_N^m\ll N$. From (2), a **one-sided upper**
bound

$$
C_N((\log N)^2)\le C_\varepsilon N^{1+\varepsilon}
\quad\text{for every }\varepsilon>0
\tag{11}
$$

already implies $Z_N(M)\ll_\varepsilon N^{1+\varepsilon}$ and thus RH.
Conversely, RH implies (11): the classical bound
$M(x)\ll_\varepsilon x^{1/2+\varepsilon}$ gives
$Z_N(M)\le N^{1+o(1)}$, and (10) bounds the other terms in
$C_N=Z_N(M)-Z_N(F_y)-B_N$. For completeness, the energy condition
$Z_N(M)\le N^{1+o(1)}$ gives
$\sum_{m\le N}M(m)^2\ll_\varepsilon N^{2+\varepsilon}$; dyadic
Cauchy–Schwarz makes the partial-summation integral for $1/\zeta(s)$
converge on $\Re s>1/2$, and the functional equation yields RH.

Thus (11) is another RH-equivalent criterion, but it asks for no
negative sign. The lower bounds for $B_N$ above quantify a cancellation
that RH would force in this decomposition; proving RH through (11)
would not require establishing that exact cancellation first. Neither
(11) nor the stricter sign has been proved here.

## No universal contractive metric

There is also a finite-dimensional obstruction independent of the
special arithmetic source. For any prefix vector $f(1),\ldots,f(N)$,
extend $f$ by $f(0)=0$ and define

$$
(U_y f)(m)=
\sum_{\substack{d\le m\\\mu(d)^2=1,\ P^-(d)>y}}
\mu(d)f(\lfloor m/d\rfloor),\qquad 1\le m\le N.
\tag{12}
$$

Equation (1) is $U_yF_y=M$. In the standard basis of prefix vectors,
$U_y$ is lower triangular with every diagonal entry equal to $1$:
the $d=1$ term is $f(m)$, while every $d>1$ uses
$\lfloor m/d\rfloor<m$. If a prime in $(y,N]$ exists, let $p$
be the least such prime. At $m=p$, the only rough squarefree
indices are $d=1,p$, so the coefficient of $f(1)$ in
$(U_yf)(p)$ is $-1$ and $U_y\ne I$.

Suppose a positive-definite inner product made $U_y$ a contraction.
All singular values in that metric would be at most $1$, but their
product is $|\det U_y|=1$. Therefore all singular values equal $1$ and
$U_y$ is an isometry. A finite-dimensional isometry is diagonalizable
over $\mathbb C$, whereas a diagonalizable unipotent matrix is the
identity, a contradiction. Thus no positive-definite finite-horizon
metric makes this nontrivial future-cone operator contractive on every
prefix vector. This does not rule out a source-specific inequality for
$F_y$.
