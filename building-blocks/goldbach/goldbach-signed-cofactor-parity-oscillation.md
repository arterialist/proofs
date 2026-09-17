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
For even $s\ge4$, the
[finite odd-total theorem](../../formalization/BuildingBlocks/GoldbachCofactorOddStepFinite.lean)
gives $Q_{s+1}\le Q_s+2\log(s+1)$. Thus an upper estimate on
the even cutoffs transfers to the following odd cutoffs with only
a logarithmic cost. The reverse one-step direction has no such
one-sided bound here.

The parity conclusion (7) also follows directly from the earlier
all-cutoff $\Omega_\pm$ theorem and the one-step bound. For a
target $0\le\alpha<1/2$, choose $\alpha<\beta<1/2$ and take
excursions with $|Q_s|/s^\beta\to\infty$. Moving at most one
integer step reaches either chosen parity and changes $Q_s$
by only $O(\log(2s)[\log\log(3s)]^2)=o(s^\beta)$. The calculation below
gives a separate source-level account of that parity transfer;
it does not strengthen the uniform upper bound.

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
The [complete interior-series module](../../formalization/BuildingBlocks/GoldbachCofactorParitySeries.lean)
also proves absolute convergence for real $|z|<1$, the
infinite Abel identity obtained from (2), the exact
$F(z)=P(z)A_2(z)$ convolution with $\Lambda(1)=0$, and both
infinite parity projections in (6). Thus the passage from
finite endpoints to the convergent generating functions is
Lean-certified. The quantitative $t\downarrow0$ estimates
remain separate.

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

The [sharpened compiled one-step bound](../../formalization/BuildingBlocks/GoldbachCofactorSuccessorQuadratic.lean)
gives $|Q_{s+2}-Q_s|\ll\log^2(2s)$ by summing two neighboring
steps. The stronger [written interval-sieve bound](goldbach-signed-cofactor-sieve-step.md)
improves this to
$|Q_{s+2}-Q_s|\ll\log(2s)[\log\log(3s)]^2$.
The earlier explicit sum of the cubic one-step envelopes is
also compiled in the finite parity module. Between opposite
signs on either parity lattice there is an adjacent parity
crossing, so each parity has infinitely many cutoffs with

\[
|Q_s|\ll\log(2s)[\log\log(3s)]^2.
\tag{8}
\]

For any fixed $0<\alpha<1/2$, (7) and the two-step bound also
give arbitrarily late positive and negative runs of
$\gg_\alpha s^\alpha/[\log(2s)(\log\log(3s))^2]$
consecutive cutoffs **of that
parity**, each at magnitude at least $s^\alpha$. The result
does not place a crossing in every dyadic interval, give a
uniform upper bound, prove binary Goldbach, or exclude an
off-critical zeta zero.

An upper bound from nearby crossings needs a quantitative
gap input. At a cutoff $u$ with
$|Q_u|\ll\log(2X)[\log\log(3X)]^2$ and
$s,u\in[X/2,2X]$, telescoping the one-step law gives

\[
|Q_s|\ll(1+|s-u|)\log(2X)[\log\log(3X)]^2.
\]

To obtain an RH-scale $O_\varepsilon(X^{1/2+\varepsilon})$
estimate solely from this inequality, it would suffice to
place a crossing within
$O_\varepsilon(X^{1/2+\varepsilon}/[\log X(\log\log X)^2])$
of **every**
cutoff. The Landau argument supplies only infinitely many
crossings, with no maximum-gap bound. For comparison,
[Bellotti's Theorem 1.5](https://arxiv.org/pdf/2508.02041)
gives $|E_y|\ll y e^{-\omega(y)}$ with the full
Vinogradov--Korobov leading exponent

\[
\omega(x)=\min_{t\ge t_0}\{\nu(t)\log x+\log t\},\qquad
\nu(t)=A_0(\log t)^{-2/3}(\log\log t)^{-1/3},
\]

where the fixed lower cutoff $t_0$ lies in the range of the
zero-free region. This bound transfers to the complete row
without loss of its leading constant:

\[
\boxed{|Q_s|\ll s e^{-\omega(s)}.}
\tag{9}
\]

To check the endpoints, put $H=\lceil se^{-\omega(s)}\rceil$.
Then $H=o(s)$, and Bellotti's bound at every $x\in[s/2,s]$
gives $E_x=O(H)$ because
$\omega(s)-\omega(s/2)=o(1)$. For $2\le y\le H$,
$|q_y|\ll1$, while the outer $\Lambda$ mass in the interval
$s-H\le s-y\le s-2$ is
$\psi(s-2)-\psi(s-H-1)\ll H$. This part is $O(H)$.
For $y\ge s/2$, Chebyshev gives outer mass $O(s)$ and
$|q_y|\ll e^{-\omega(s/2)}=O(e^{-\omega(s)})$.
Finally, divide $H<y<s/2$ into intervals
$Y\le y<2Y$, $Y=2^jH$, truncating the last interval.
Each outer $\Lambda$ mass is $O(Y+H)=O(Y)$ by
$\psi(x)=x+E_x$ at the two endpoints, and its contribution
is $O(Ye^{-\omega(Y)})$. Since the logarithmic slope of
$\omega$ tends to zero, these terms form a geometric sum
dominated by $O(se^{-\omega(s)})$. The $\psi$ bounds include
every proper prime power, and the range begins at the
actual complementary endpoint $y=2$.

Here $\omega(s)\sim d(\log s)^{3/5}(\log\log s)^{-1/5}$,
where $d=(5^6A_0^3/(2^2 3^4))^{1/5}$ (about $0.2126$
when $A_0=1/48.0718$). The simpler split at $\sqrt s$
retains only $2^{-3/5}d$ in its leading exponent. Equation
(9) preserves Bellotti's leading exponential constant $d$;
it does not improve the prime-error theorem or give an
RH-scale bound.

The finite Abel and alternating bounds (2)–(3), the sharpened
quadratic one-step bound, the one-sided odd-total logarithmic
step, the earlier explicit two-step envelope, the
infinite convergent-series identities,
and both parity projections in (6) are Lean-compiled with
standard axioms. The stronger interval-sieve step bound,
the logarithmic boundary estimate in (4),
PNT input in (5), Landau oscillation transfer, the
coefficient and crossing conclusions (7)–(8), and the
quantitative transfer (9) remain written
analysis; their Lean formalization remains open.
