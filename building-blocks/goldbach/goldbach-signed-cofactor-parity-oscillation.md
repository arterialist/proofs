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

The [exact alternating parity main term](goldbach-alternating-parity-main-term.md)
sharpens these absolute bounds. The even von Mangoldt row consists
only of powers of two, so $P(-r)\sim-t^{-1}$. The centered Abel
identity then gives

\[
A_2(-e^{-t})\sim-\tfrac12\log(1/t),\qquad
F(-e^{-t})\sim\frac{\log(1/t)}{2t}>0.
\tag{5a}
\]

The finite power-of-two parity identity is Lean-compiled; the PNT
boundary limits and integration yielding (5a) remain written
analysis. The positive sign concerns this Abel sum, not the
individual signed coefficients.

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
Equation (5a) says $t^{1+\theta}F(-e^{-t})\to0$.
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
[Johnston's Corollary 2.3](https://arxiv.org/pdf/2411.13791),
combined with the [asymptotic Vinogradov--Korobov zero-free
region](https://arxiv.org/pdf/2306.10680), gives for every
$\eta>0$

\[
|E_x|\ll_\eta x e^{-(d-\eta)\Phi(x)},\qquad
\Phi(x)=(\log x)^{3/5}(\log\log x)^{-1/5},
\quad d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5},
\quad A_0=1/48.0718.
\]

The zero-free region permits any fixed constant below $A_0$
for all sufficiently large heights; the polynomial factor in
Johnston's estimate is absorbed by $e^{\eta\Phi(x)}$.
The resulting bound transfers to the complete row without
further loss of the chosen exponent:

\[
\boxed{|Q_s|\ll_\eta s e^{-(d-\eta)\Phi(s)}
\qquad\text{for every fixed }\eta>0.}
\tag{9}
\]

To check the endpoints, put
$\omega_\eta(x)=(d-\eta)\Phi(x)$ and
$H=\lceil se^{-\omega_\eta(s)}\rceil$.
Then $H=o(s)$, and the prime-error bound at every $x\in[s/2,s]$
gives $E_x=O(H)$ because
$\omega_\eta(s)-\omega_\eta(s/2)=o(1)$. For $2\le y\le H$,
$|q_y|\ll1$, while the outer $\Lambda$ mass in the interval
$s-H\le s-y\le s-2$ is
$\psi(s-2)-\psi(s-H-1)\ll H$. This part is $O(H)$.
For $y\ge s/2$, Chebyshev gives outer mass $O(s)$ and
$|q_y|\ll_\eta e^{-\omega_\eta(s/2)}
=O_\eta(e^{-\omega_\eta(s)})$.
Finally, divide $H<y<s/2$ into intervals
$Y\le y<2Y$, $Y=2^jH$, truncating the last interval.
Each outer $\Lambda$ mass is $O(Y+H)=O(Y)$ by
$\psi(x)=x+E_x$ at the two endpoints, and its contribution
is $O_\eta(Ye^{-\omega_\eta(Y)})$. Since the logarithmic slope of
$\omega_\eta$ tends to zero, these terms form a geometric sum
dominated by $O_\eta(se^{-\omega_\eta(s)})$. The $\psi$ bounds include
every proper prime power, and the range begins at the
actual complementary endpoint $y=2$.

Here $d\approx0.2126$. The simpler split at $\sqrt s$
retains only $2^{-3/5}(d-\eta)$ in its leading exponent.
Equation (9) approaches the independently supported $d$
as $\eta\downarrow0$; it does not improve the prime-error
theorem or give an RH-scale bound. The stronger $\eta=0$
estimate asserted in
[Bellotti's 2025 preprint](https://arxiv.org/pdf/2508.02041)
is not used here: its posted proof in §3.1.1 identifies
$(\psi*\theta*1)(n)$ with $(\psi*1)(n)(\theta*1)(n)$,
which is false even at a prime $n\le\min(U,W)$. This
observation does not disprove the preprint's claimed theorem.

The finite Abel and alternating bounds (2)–(3), the sharpened
quadratic one-step bound, the one-sided odd-total logarithmic
step, the earlier explicit two-step envelope, the
infinite convergent-series identities,
and both parity projections in (6) are Lean-compiled with
standard axioms. The stronger interval-sieve step bound,
the logarithmic boundary estimates in (4)–(5a),
PNT input in (5), Landau oscillation transfer, the
coefficient and crossing conclusions (7)–(8), and the
quantitative transfer (9) remain written
analysis; their Lean formalization remains open.
