# Signed Goldbach cofactor oscillation on each parity

The signed cofactor has arbitrarily large positive and negative
excursions separately at **even** and **odd** additive cutoffs. Thus
the even-cutoff Goldbach channel cannot make this cofactor eventually
one-signed. This concerns a centered error convolution, not the
existence of a two-prime representation.

Keep the [actual cofactor](goldbach-signed-cofactor-oscillation.md)

\[
E_y=\psi(y)-y,\qquad q_y=E_y/y,\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)q_{s-m}\quad(s\ge4).
\tag{1}
\]

Every proper prime power and the new two-leg endpoint are included.

## Alternating source cancellation

Put $r=e^{-t}$, with $0<r<1$, and
$A_2(z)=\sum_{y\ge2}q_yz^y$. The exact finite Abel identity is

\[
(1-z)\sum_{y=2}^{N}q_yz^y
=q_2z^2+\sum_{y=3}^{N}(q_y-q_{y-1})z^y
-q_Nz^{N+1}\qquad(N\ge2).
\tag{2}
\]

The last term is essential at finite cutoff. The compiled
[finite Abel module](../../formalization/BuildingBlocks/GoldbachCofactorParityFinite.lean)
proves (2), its alternating absolute-value bound, and the
following explicit coefficient estimate, using the actual
von Mangoldt successor law:

\[
|q_y|\le C_0,\qquad
|q_y-q_{y-1}|\le\frac{\log y+C_0+1}{y}
\quad(y\ge3),\qquad C_0=4\log2+1.
\tag{3}
\]

For $0\le r\le1$ the precise compiled finite bound is

\[
\left|\sum_{y=2}^{N}q_y(-r)^y\right|
\le |q_2|+\sum_{y=3}^{N}
 \frac{\log y+C_0+1}{y}r^y+C_0r^{N+1}.
\]

At $z=-r$, (2) and (3) yield

\[
|A_2(-r)|\le |q_2|
 +\sum_{y\ge3}\frac{\log y+C_0+1}{y}r^y
 =O\!\left(\log^2(2/t)\right)
 \quad(t\downarrow0).
\tag{4}
\]

For fixed $r<1$, the terminal term in (2) tends to zero
because $q_N$ is bounded. For the final estimate, split the
sum at $N=\lceil1/t\rceil$: the initial harmonic-logarithmic
sum is $O(\log^2(2/t))$; comparing the decreasing tail with
its integral after $u=tx$ gives $O(\log(2/t))$.

Let $P(z)=\sum_{m\ge1}\Lambda(m)z^m$ and
$F(z)=\sum_{s\ge4}Q_sz^s=P(z)A_2(z)$ for $|z|<1$.
The bounds $|q_y|\le C_0$ and $\Lambda(m)\le\log m$
make this convolution absolutely convergent there.
Since $\Lambda\ge0$ and the prime number theorem gives
$P(r)\sim t^{-1}$, (4) proves

\[
|F(-r)|=|P(-r)A_2(-r)|
\le P(r)|A_2(-r)|
=O\!\left(t^{-1}\log^2(2/t)\right).
\tag{5}
\]

The two parity projections are exact:

\[
F_0(r)=\sum_{\substack{s\ge4\\s\ \mathrm{even}}}Q_sr^s
 =\frac{F(r)+F(-r)}2,\qquad
F_1(r)=\sum_{\substack{s\ge4\\s\ \mathrm{odd}}}Q_sr^s
 =\frac{F(r)-F(-r)}2.
\tag{6}
\]

The finite version of (6), for any coefficient sequence and
cutoff, is compiled in the same Lean module.

The [actual-zero/Landau argument](goldbach-signed-cofactor-oscillation.md)
already proves that for every $0<\theta<1/2$,
$t^{1+\theta}F(e^{-t})$ has unbounded excursions of both signs.
Equation (5) says $t^{1+\theta}F(-e^{-t})\to0$.
Hence the same two-sided excursions hold for each of $F_0$ and
$F_1$.

Fix $0\le\alpha<1/2$ and choose
$\alpha<\theta<1/2$. If, for one parity $p$, the coefficients
were eventually bounded above by $Cs^\alpha$, then the
elementary bound
$\sum_{s\ge1}s^\alpha e^{-st}=O_\alpha(t^{-1-\alpha})$
would make $t^{1+\theta}F_p(e^{-t})$ bounded above near zero.
This contradicts its positive excursions. Apply the same
argument to an eventual lower bound. Therefore, for each
$p\in\{0,1\}$,

\[
\boxed{\limsup_{\substack{s\to\infty\\s\equiv p\ (2)}}
       \frac{Q_s}{s^\alpha}=+\infty,
\qquad
\liminf_{\substack{s\to\infty\\s\equiv p\ (2)}}
       \frac{Q_s}{s^\alpha}=-\infty
\quad(0\le\alpha<1/2).}
\tag{7}
\]

The [compiled one-step bound](../../formalization/BuildingBlocks/GoldbachCofactorSuccessorFinite.lean)
gives $|Q_{s+2}-Q_s|\ll\log^3(2s)$; the explicit sum of the
two one-step envelopes is also compiled in the finite parity
module. Between opposite signs on either parity lattice there
is an adjacent parity
crossing, so each parity has infinitely many cutoffs with

\[
|Q_s|\ll\log^3(2s).
\tag{8}
\]

For any fixed $0<\alpha<1/2$, (7) and the two-step bound also
give arbitrarily late positive and negative runs of
$\gg_\alpha s^\alpha/\log^3(2s)$ consecutive cutoffs **of that
parity**, each at magnitude at least $s^\alpha$. The result
does not place a crossing in every dyadic interval, give a
uniform upper bound, prove binary Goldbach, or exclude an
off-critical zeta zero.

The finite Abel and alternating bounds (2)–(3), the finite
parity projection behind (6), and the exact two-step envelope
are Lean-compiled with standard axioms. The infinite limits,
parity oscillation, and crossing conclusions (4)–(8) are
written analysis; their Lean formalization remains open.
