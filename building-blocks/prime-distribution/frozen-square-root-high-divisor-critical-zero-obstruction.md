# A critical-zero obstruction for the frozen high-divisor block

2026-09-16. This is an unconditional lower-order result for the
square-root high-divisor block with the factorial ground replaced by the
constant $1$. It is an obstruction to bounding that block separately
at the $X^{-1/2}$ scale. The theorem does not transfer to the actual
ground without a bound for the ground perturbation, and it gives no
estimate for the coupled prime-minus-density score. The Mellin-pole
argument for weighted reciprocal Möbius sums is classical.

Fix $p_s>0$. For $Y>1$, let
$$
w_Y^0(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2}
                  \mathbf1_{[Y,2Y)}(x),
\qquad
B_0(Y)=\int_{[Y,2Y)}w_Y^0(x)\,dE(x),
\quad E(x)=\psi(x)-x.
$$
All prime powers occur in $\psi$, and the upper endpoint is excluded.
For an integer $D\ge1$, set
$$
a_D(n)=\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d),
\qquad
T_D^0(Y)=\sum_n\bigl(\Lambda(n)-a_D(n)\bigr)w_Y^0(n).
$$
Put
$$
A_u=\sum_{d\le u}\frac{\mu(d)}d,
\quad B_u^\mu=\sum_{d\le u}\frac{\mu(d)\log d}{d},
\quad C_j=\int_1^2\frac{\log^{j+2}v}{v^2}\,dv\quad(j=0,1),
$$
and
$$
\mathscr C(u)=\left(2\log u+\frac{C_1}{C_0}\right)A_u-B_u^\mu-1.
$$

**Theorem.** As $N\to\infty$ through integers,
$$
\boxed{\quad T_N^0(N^2)=\Omega_s(N^{-1/2}\log N).\quad}       \tag{1}
$$
Here $\Omega$ means
$\limsup_{N\to\infty}N^{1/2}|T_N^0(N^2)|/\log N>0$.
No RH assumption enters the proof.

The exact Type-I lattice comparison, now with $F=1$, gives uniformly
for real $u\ge4$ and $D=\lfloor u\rfloor$,
$$
T_D^0(u^2)=B_0(u^2)-p_s^2C_0\mathscr C(u)
                         +O_s(\log(2u)/u).               \tag{2}
$$
Indeed the low-divisor lattice error is
$O_s(D\log(2u)/u^2)$, while direct substitution $x=u^2v$ gives
$\int w_{u^2}^0=p_s^2C_0$ and
$\int w_{u^2}^0\log x=p_s^2(2C_0\log u+C_1)$.

Write $G(s)=1/\zeta(s)$. For $\Re z>0$, termwise integration of the
cutoff sums gives
$$
\int_1^\infty\mathscr C(u)u^{-z-1}du
=-\frac{G'(z+1)}z+\frac{2G(z+1)}{z^2}
 +\frac{C_1G(z+1)}{C_0z}-\frac1z.                       \tag{3}
$$
At a zeta zero $\rho$ of multiplicity $m$, the right side has a pole
of order $m+1$ at $z=\rho-1$: the $-G'(z+1)/z$ term has this order,
and the other terms have order at most $m$.

The prime score in (2) cannot cancel that highest-order pole. Set
$$
C(s)=\int_0^{\log2}t^2e^{(s-2)t}dt,
\qquad
W_0(s)=\int_{[1,\infty)}x^{-s}dE(x)
=-\frac{\zeta'(s)}{\zeta(s)}-\frac1{s-1}
\quad(\Re s>1).
$$
The exact first-window Mellin calculation gives
$$
\int_1^\infty B_0(u^2)u^{-z-1}du
=\frac{p_s^2}{2}C(1+z/2)W_0(1+z/2)
       -\frac{p_s^2}{2}\mathcal B(1+z/2),              \tag{4}
$$
initially for $\Re z>0$. The correction $\mathcal B$ comes only from
$1\le x<2$ and is entire; it is the omitted part of the compact
$t$-integral when $Y\ge1$. The function $C$ is entire, whereas
$W_0$ has at most simple poles at zeta zeros. Therefore (4) has at
most a simple pole at any point $z=\rho-1$, even if another zero lies
at $1+z/2$.

The Mellin transform of the error in (2) is holomorphic for
$\Re z>-1$. Hardy's theorem supplies a zero
$\rho=1/2+i\gamma$; at $z_0=\rho-1$, equations (2)--(4) show that
the transform of $u\mapsto T_{\lfloor u\rfloor}^0(u^2)$ retains the
pole of order $m+1\ge2$ from (3). Suppose this high block were
$o(u^{-1/2}\log u)$ for all real $u$. Approach $z_0$ from the right
through $z=z_0+h$, $h>0$. Absolute integration and an Abelian tail
estimate would give
$$
h^2\int_1^\infty T_{\lfloor u\rfloor}^0(u^2)
                     u^{-z_0-h-1}du\longrightarrow0.
$$
The retained pole makes this limit nonzero when $m=1$ and unbounded
when $m>1$, a contradiction. Thus the real-variable high block has
the lower order in (1).

It remains to pass from real $u$ to integers. If $N\le u<N+1$, then
$\mathscr C(u)-\mathscr C(N)=2A_N\log(u/N)=O(\log(2N)/N)$.
Also $B_0(u^2)-B_0(N^2)=O_s(\log(2N)/N)$. To see this, between
window crossings the derivative of each atomic weight with respect to
$Y$ is $O_s(N^{-4})$ for $Y\asymp N^2$; summing at most $O(N^2)$
atoms with $\Lambda(n)\le\log(4N^2)$ and moving $Y$ by $O(N)$ costs
$O_s(\log N/N)$. The moving upper endpoint crosses $O(N)$ integers,
each with jump $O_s(\log N/N^2)$; the lower endpoint has zero weight.
The continuous-density integral is the constant $p_s^2C_0$.
Applying (2) at $u$ and $N$ now gives
$$
T_{\lfloor u\rfloor}^0(u^2)-T_N^0(N^2)
=O_s(\log(2N)/N)=o(N^{-1/2}\log N),
$$
so the real-variable lower order holds along integers as claimed.

## The coupled Mellin transform

The low/high compensation in (2) has an exact transform. Let
$\mathfrak T(z)$ be the Mellin transform of
$u\mapsto T_{\lfloor u\rfloor}^0(u^2)$, put
$\mathfrak P(z)=p_s^2C_0\int_1^\infty\mathscr C(u)u^{-z-1}du$, and
let $\mathfrak R(z)$ transform the error in (2). That error is
$O_s(\log(2u)/u)$, so $\mathfrak R$ is holomorphic on $\Re z>-1$.
Equations (2)--(4) give, first for $\Re z>0$ and then meromorphically,
$$
\boxed{\mathfrak T(z)+\mathfrak P(z)
=\frac{p_s^2}{2}C(1+z/2)W_0(1+z/2)
 -\frac{p_s^2}{2}\mathcal B(1+z/2)+\mathfrak R(z).}
\tag{5}
$$
The cutoff pole at $z=\rho-1$ cancels between the high block and its
low moment. The surviving prime-score pole associated with a zero
$\rho$ occurs at $z=2(\rho-1)$, the observation scale $Y=u^2$.
Coincident zero locations may leave a simple pole at a cutoff location,
but cannot restore the canceled higher-order pole.

If $\Re\rho>1/2$ and $\rho$ has multiplicity $m$, then
$z_\rho=2(\rho-1)$ lies in $\Re z>-1$. The compact multiplier
$C(\rho)$ is nonzero by the
[single-fiber multiplier calculation](../factorial-and-renewal/factorial-f-ground-m2-fiber-rh-criterion.md).
Thus (5) has a simple pole at $z_\rho$ with residue
$-p_s^2mC(\rho)\ne0$. This identifies the pole and its amplitude;
it is not a bound for the coupled score. For a critical-line zero,
$z_\rho$ lies on $\Re z=-1$, where the elementary error estimate
does not continue $\mathfrak R$.

The actual-ground high block is treated conditionally on RH in
[the companion note](../factorial-and-renewal/full-f-square-root-high-divisor-critical-zero-barrier.md).
Replacing $1/F$ by its limiting constant under only the prime number
theorem gives an error too large to transfer (1). The complete
low-plus-high score can cancel this high-block fluctuation.
