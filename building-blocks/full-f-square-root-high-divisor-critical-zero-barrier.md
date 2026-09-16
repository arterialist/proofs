# A critical-zero barrier for the square-root high-divisor block

2026-09-16. Written mathematics, independently checkable from the exact
Type-I identity. This is a **conditional-on-RH lower bound** for the
complete actual-$F$ first-clock high-divisor block, plus an
**unconditional** oscillation theorem for its governing truncated Möbius
moment. The lower bound does not assert RH or estimate the complete
prime-minus-density score unconditionally.

Fix a finite first-block clock $s$ with $p_s>0$. Let
$$
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad F(x)\longrightarrow\kappa_F>0,
$$
and use the actual first-block weight
$$
w_Y(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}
             \mathbf1_{[Y,2Y)}(x).
$$
For $D\ge1$, put
$$
a_D(n)=\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d),
\quad t_D(n)=\Lambda(n)-a_D(n),
\quad T_D(Y)=\sum_n t_D(n)w_Y(n),
$$
and $B(Y)=\sum_n\Lambda(n)w_Y(n)-\int_Y^{2Y}w_Y(x)dx$.
All prime powers, the actual ground, and the half-open upper endpoint
are retained.

Set
$$
A_D=\sum_{d\le D}\frac{\mu(d)}d,
\qquad B_D^{\mu}=\sum_{d\le D}\frac{\mu(d)\log d}{d},
\qquad C_j=\int_1^2\frac{\log^{j+2}v}{v^2}\,dv
\quad(j=0,1),
\qquad c_* = C_1/C_0.
$$
The scalar $C_0$ is strictly positive. Define for real $u\ge1$
$$
\mathscr C(u)
=(2\log u+c_*)A_u-B_u^{\mu}-1.                 \tag{1}
$$
Here $A_u,B_u^{\mu}$ use the literal integer cutoff $d\le u$.

**Theorem.** The truncated moment has the unconditional lower order
$$
\boxed{\quad
\mathscr C(N)=\Omega\!\left(N^{-1/2}\log N\right)
\quad(N\to\infty\text{ through integers}),\quad}       \tag{2}
$$
where $\Omega$ means
$\limsup_{N\to\infty}N^{1/2}|\mathscr C(N)|/\log N>0$.
If RH holds, then for every $\varepsilon>0$ the actual high-divisor
score at the square-root cutoff obeys
$$
\boxed{\quad
T_N(N^2)=-\frac{p_s^2C_0}{\kappa_F}\mathscr C(N)
                  +O_{s,\varepsilon}(N^{-1+\varepsilon}),
\qquad
T_N(N^2)=\Omega_s(N^{-1/2}\log N).\quad}              \tag{3}
$$
The conditional conclusion also holds for the **whole shell energy**:
writing $\|T_N\|_{N^2}^2=\int_{N^2}^{2N^2}|T_N(Y)|^2dY/Y$,
$$
\boxed{\quad
\|T_N\|_{N^2}^2=\Omega_s(N^{-1}\log^2N).
\quad}                                                     \tag{3a}
$$
Equivalently, the high block has an $X^{-1/4}\log X$ lower order along
square shells $X=N^2$, conditional on RH. Thus an estimate of
$T_{\lfloor\sqrt X\rfloor}(X)=o(X^{-1/4}\log X)$, in particular an
RH-scale $O_\varepsilon(X^{-1/2+\varepsilon})$ estimate, is incompatible
with RH. This concerns the *high block separately*; the complete score
$B$ is expected to be smaller because the low and high blocks cancel.

## Unconditional Mellin pole of the truncated moment

Write $G(z)=1/\zeta(z)$. For $\Re z>0$, absolute convergence and
integration of each cutoff indicator give
$$
\int_1^\infty A_u u^{-z-1}du=\frac{G(z+1)}z,
\qquad
\int_1^\infty B_u^{\mu}u^{-z-1}du=-\frac{G'(z+1)}z.
$$
Differentiating the first identity in $z$ gives the exact transform
$$
\mathcal C(z):=\int_1^\infty\mathscr C(u)u^{-z-1}du
=-\frac{G'(z+1)}z+\frac{2G(z+1)}{z^2}
  +c_*\frac{G(z+1)}z-\frac1z,
\qquad\Re z>0.                                         \tag{4}
$$
The right side is meromorphic throughout the plane. At every nontrivial
zero $\rho$ of $\zeta$ of multiplicity $m\ge1$, its point
$z_\rho=\rho-1\ne0$ is a pole of order $m+1$: the term
$-G'(z+1)/z$ has that order and nonzero leading coefficient; all
other terms have order at most $m$. Hardy's theorem supplies at least
one zero $\rho=1/2+i\gamma$ on the critical line.

Suppose, toward a contradiction, that
$\mathscr C(N)=o(N^{-1/2}\log N)$ at the integers. For
$N\le u<N+1$, only $2\log u$ changes in (1), and
$$
|\mathscr C(u)-\mathscr C(N)|
\le 2|A_N|\log(1+1/N)
\ll \frac{\log(2N)}N=o(N^{-1/2}\log N).
$$
Thus $\mathscr C(u)=o(u^{-1/2}\log u)$ on all real $u$. The integral
defining $\mathcal C(z)$ then converges absolutely and locally
uniformly on $\Re z>-1/2$. It is holomorphic there and agrees with the
meromorphic right side of (4) by continuation from $\Re z>0$. In
particular the right side can have no pole in that half-plane.

At the critical zero from Hardy's theorem, approach the boundary point
$z_\rho=-1/2+i\gamma$ through $z=z_\rho+h$, $h>0$. The assumed little-$o$
bound implies
$$
h^2\mathcal C(z_\rho+h)\longrightarrow0.       \tag{5}
$$
Indeed, after multiplication by $h^2$, any fixed compact part of the
integral vanishes, and the tail is an arbitrarily small multiple of
$h^2\int_1^\infty u^{-1-h}\log u\,du=1$.
But the pole of order $m+1\ge2$ in (4) makes the left side of (5)
converge to a nonzero constant when $m=1$, or diverge in modulus when
$m>1$. This contradiction proves (2), without assuming RH.

## Transfer to the actual high block under RH

The exact Type-I lattice identity from
[the full-factorial score note](factorial-f-ground-type-i-lattice-payment.md)
specializes to
$$
B(Y)-T_D(Y)
=A_D\int_Y^{2Y}w_Y(x)\log x\,dx
 -(B_D^{\mu}+1)\int_Y^{2Y}w_Y(x)dx
 +\mathcal E_D(Y),
\qquad
|\mathcal E_D(Y)|\ll_s\frac{D\log(2Y)}Y.       \tag{6}
$$
This is a literal divisor identity followed by a lattice-versus-integral
comparison. It includes the density $-dx$, every prime power in the
combined source, and the full $F$ in $w_Y$. At $Y=N^2$, $D=N$,
$\mathcal E_N(N^2)\ll_s N^{-1}\log N$.

Under RH the classical bound
$E(x):=\psi(x)-x=O_\varepsilon(x^{1/2+\varepsilon})$
and $F'(x)=-E(x)/x^2$ imply, by integration from $x$ to infinity,
$$
F(x)^{-1}=\kappa_F^{-1}+O_\varepsilon(x^{-1/2+\varepsilon}).
                                                               \tag{7}
$$
Changing variables $x=Yv$ in the two integrals of (6) therefore gives
$$
\int_Y^{2Y}w_Y(x)dx
=\frac{p_s^2C_0}{\kappa_F}
 +O_{s,\varepsilon}(Y^{-1/2+\varepsilon}),
$$
$$
\int_Y^{2Y}w_Y(x)\log x\,dx
=\frac{p_s^2}{\kappa_F}(C_0\log Y+C_1)
 +O_{s,\varepsilon}(Y^{-1/2+\varepsilon}\log Y).
                                                               \tag{8}
$$
The elementary bounds $|A_N|\ll\log(2N)$ and
$|B_N^{\mu}+1|\ll\log^2(2N)$ absorb the actual-ground errors in
(8) into $O_{s,\varepsilon}(N^{-1+\varepsilon})$ at $Y=N^2$.
Stieltjes integration by parts for $B(Y)=\int_{[Y,2Y)}w_YdE$ gives
$B(N^2)=O_{s,\varepsilon}(N^{-1+\varepsilon})$: the lower endpoint
weight vanishes, and the upper prime-power atom is excluded.
Substitution in (6), using $\log Y=2\log N$, yields the first equation
of (3).

The same calculation is uniform for $Y=vN^2$, $1\le v\le2$, because
all weights lie in $[N^2,4N^2)$ and the lattice estimate in (6) is
uniform. Thus
$$
T_N(vN^2)=-\frac{p_s^2C_0}{\kappa_F}
       \bigl(\mathscr C(N)+A_N\log v\bigr)
       +O_{s,\varepsilon}(N^{-1+\varepsilon})
\quad(1\le v\le2).                                      \tag{9}
$$
For any real $C,A$, completing the square gives the sharp elementary
inequality
$$
\int_0^{\log2}|C+Au|^2du\ge\frac{\log2}{4}|C|^2.
                                                               \tag{10}
$$
The error in (9) has $L^2(du)$ norm $O(N^{-1+\varepsilon})$, which is
$o(N^{-1/2}\log N)$. Along the integer subsequence from (2), (9)--(10)
prove the shell-energy lower order (3a).

The pointwise error in (3) is $o(N^{-1/2}\log N)$, so (2) also proves
the pointwise lower order in (3). The argument uses RH only for the prime error and ground
approximation in (7)--(8), not for the Mellin-pole theorem (2).

The result rules out treating the complete high-divisor block as an
RH-sized error, even in a world where RH holds. An RH-scale estimate
must retain cancellation with the matching low-divisor main or use a
different decomposition. The theorem does not exclude a distinct
unconditional power saving of order $X^{-\delta}$ with
$0<\delta\le1/4$ for $T_D$; no such estimate is proved here.
