# The actual quadratic logarithmic readout at the parameter endpoint

For the complete division weights
$\varphi_r(m)=\sum_{k\ge1}\mu(k)W_r(km)$, define
$$
E_2(r)=\sum_{m\ge2}\varphi_r(m)(\log m)^2.
$$
Every fixed-parameter series here converges absolutely. We prove
$$
\boxed{\lim_{h\downarrow0}\sqrt h\,E_2(1-h)=\pi^{3/2}.}
\tag{1}
$$
This is an unconditional positive asymptotic for the actual signed
successor coefficients. The proof treats this logarithmic endpoint
directly. It does not differentiate the nonuniform positive-power
limit in the curved-log comparison.

## The arithmetic weight is the existing Selberg weight

Put
$$
\Lambda_2(n)=\sum_{d\mid n}\mu(n/d)(\log d)^2
=\Lambda(n)\log n+\sum_{ab=n}\Lambda(a)\Lambda(b)\ge0.
\tag{2}
$$
The second sum is ordered and includes same-prime pairs. This is the
classical Selberg identity, already formalized by
[`BuildingBlocks.SelbergIdentity.selbergWeight_eq_moebius_logSquare`](BuildingBlocks/SelbergIdentity.lean)
and `selbergWeight_apply` in that module. It is an input
here, not a new identity claimed by this note.
Absolute divisor regrouping gives
$$
\boxed{E_2(r)=\sum_{n\ge2}\Lambda_2(n)W_r(n).}
\tag{3}
$$
Indeed $W_r(n)=O_r(n^{-3/2})$, and the sum over $k,m$ is
dominated by a constant times
$\sum k^{-3/2}\sum m^{-3/2}(\log m)^2<\infty$.
The terminal state contributes zero.

For clarity, the actual pointwise weights in (2) are
$$
\Lambda_2(p^a)=(2a-1)(\log p)^2,
\qquad
\Lambda_2(p^a q^b)=2\log p\log q\quad(p\ne q),
\tag{4}
$$
and zero at integers with at least three distinct prime factors.
All positive exponents in (4) are retained. Thus (3) is not just the
distinct-prime coefficient used in the original W criterion.

## A summatory estimate with the linear term retained

Let $S_2(x)=\sum_{n\le x}\Lambda_2(n)$, using the ordinary
right-continuous convention. We need the classical consequence
$$
S_2(x)=2x\log x-(2+2\gamma_E)x+o(x).
\tag{5}
$$
Here is a direct derivation sufficient for this consumer.
The unconditional estimate
$\psi(x)=x+O(x/\log^3 x)$ follows from
[Dusart, Theorem 5.2](https://arxiv.org/pdf/1002.0442), the row with
$k=3$, together with the complete identity
$\psi(x)=\sum_{j\ge1}\vartheta(x^{1/j})$.
Chebyshev bounds put all $j\ge2$ terms into
$O(\sqrt x\log x)$, which is smaller than the needed error.

Writing $g(x)=\psi(x)/x-1$, Abel summation gives
$$
\sum_{n\le y}\frac{\Lambda(n)}n
=\log y+1+g(y)+\int_1^y g(u)\frac{du}{u}
=\log y-\gamma_E+O(\log^{-2}y).
\tag{6}
$$
To identify the constant without suppressing the initial density,
use, for real $\epsilon>0$,
$$
-\frac{\zeta'}\zeta(1+\epsilon)
=(1+\epsilon)\left[\frac1\epsilon+
\int_1^\infty g(u)u^{-1-\epsilon}du\right].
$$
The weighted integral of $|g|$ is finite by the stated error.
The [Laurent expansion at one](https://dlmf.nist.gov/25.2.E4)
therefore gives $1+\int_1^\infty g(u)du/u=-\gamma_E$, proving
the constant and the error in (6).

The exact hyperbola identity with $y=\sqrt x$ is
$$
\sum_{ab\le x}\Lambda(a)\Lambda(b)
=2\sum_{a\le\sqrt x}\Lambda(a)\psi(x/a)-\psi(\sqrt x)^2.
\tag{7}
$$
It includes the square boundary exactly. Since $x/a\ge\sqrt x$
in the first sum, the same prime-number estimate is uniform there.
Equations (6)--(7) give
$$
\sum_{ab\le x}\Lambda(a)\Lambda(b)
=x\log x-(1+2\gamma_E)x+O(x/\log^2x).
$$
Also
$$
\sum_{n\le x}\Lambda(n)\log n
=\psi(x)\log x-\int_1^x\frac{\psi(u)}u\,du
=x\log x-x+O(x/\log^2x).
$$
Adding proves (5), in fact with error $O(x/\log^2x)$.
This uses classical prime-number estimates, not an RH premise.

## Summing the actual coefficient error

The [uniform successor scaling theorem](successor-feedback-kernel-scaling.md)
gives, for $0<h\le1/2$ and every integer $n\ge2$,
$$
W_{1-h}(n)=\sqrt h K(hn)-hE_1(hn)+\mathcal E_h(n),
$$
$$
|\mathcal E_h(n)|\le C\left[
h^{3/2}\frac{(hn)^{-1/2}}{1+hn}
+h^2\frac{e^{-hn/2}}{hn}\right].
\tag{8}
$$
All three terms are summed against $\Lambda_2(n)$, not only
against $\Lambda(n)$. From (5), positivity and compact initial
control give $S_2(x)\le Cx\log(2x)$. Partial summation against
the decreasing kernels in (8) consequently yields
$$
\sum_{n\ge2}\Lambda_2(n)|\mathcal E_h(n)|
\le C\left[\sqrt h\log(2/h)+h\log^2(2/h)\right],
\tag{9}
$$
$$
h\sum_{n\ge2}\Lambda_2(n)E_1(hn)=O(\log(2/h)).
\tag{10}
$$
For the first kernel in (9), both its integral and logarithmic moment
are finite. For the second, the interval $2h\le t\le1$ gives
the displayed extra logarithm; its tail is exponential. Equation
(10) follows in the same way since $E_1$ is decreasing with finite
integral and logarithmic moment. Thus the full endpoint correction
and the full error vanish after multiplying (3) by $\sqrt h$.

## The principal signed limit

Extend $S_2(x)=0$ to $0<x<1$ and set
$$
R_2(x)=S_2(x)-2x\log x+(2+2\gamma_E)x.
$$
Then $R_2(x)=o(x)$ at infinity and
$R_2(x)=O(x(1+|\log x|))$ at zero.
The exact moments of $K$ are
$\int K=0$ and $\int K\log t=\pi^{3/2}/2$.
Consequently
$$
h\int_0^\infty K(hx)(2\log x-2\gamma_E)dx=\pi^{3/2}.
\tag{11}
$$
Stieltjes integration by parts leaves the exact remainder
$$
h\sum_{n\ge2}\Lambda_2(n)K(hn)-\pi^{3/2}
=-\int_0^\infty hR_2(t/h)K'(t)dt.
\tag{12}
$$
Both boundary products vanish. For fixed $t>0$,
$hR_2(t/h)=o(t)$. Uniformly in $0<h\le1/2$, its absolute
value is at most $Ct(1+|\log t|)$: for $t/h\ge1$ use the
global bound $|R_2(x)|\le Cx$, and for $t/h<1$ use the
explicit initial expression above. This dominates (12) by an
integrable function, since
$$
\int_0^\infty t|K'(t)|(1+|\log t|)dt<\infty.
$$
Dominated convergence proves that (12) tends to zero.
Combining (8)--(12) with (3) proves (1).

The positive constant comes from the logarithmic term in the
classical summatory weight (5). It calibrates the second logarithmic
readout, including its same-prime loading. It supplies no inequality
for the first readout $E(r)=\sum\varphi_r(m)\log m$, and no sign
for the original distinct-prime W after its full density and
same-prime subtraction. Those cancellations remain part of the
unproved RH estimate.

The [fixed-exponent curved-log comparison](successor-division-curved-log-comparison.md) is a distinct proof. Its nonuniform exponent limit remains undifferentiated; (1) instead resolves the actual second logarithmic readout through the full Selberg summatory weight. Only the stated Selberg identity is already formalized here; this asymptotic and its prime-number input are written analysis.
