# A fixed-window residual test for Connes's prolate vector

[The exact compact Weil operator and jump formula](connes-weil-prolate-actual-residual.md)
leave a numerical question at $a=\log\lambda=4/5$: are the prolate
endpoint coefficients large enough, relative to Zhu's certified Weil
gap, to make the residual criterion ineffective? They are. The
calculation below uses the prolate differential equation, rational
finite-matrix checks, and an analytic endpoint-collar estimate. It
does not decide whether the vector itself is close to the Weil ground
state, and it says nothing about other windows.

Normalize each even prolate function $h_j$ ($j=0,4$) by
$\int_{-\lambda}^{\lambda}h_j(v)\,dv=1$, and set $h=h_4-h_0$.
This is a nonzero scalar multiple of Connes's zero-integral choice;
all residual-to-gap ratios are unchanged by that scalar. Put
$c=2\pi\lambda^2$ and $t=v/\lambda$. The angular functions solve

\[
 -\big((1-t^2)y'(t)\big)'+c^2t^2y(t)=\kappa y(t),
 \qquad -1<t<1.                                      \tag{1}
\]

The first and third even eigenfunctions of (1) are $h_0$ and $h_4$.
Here $\lambda^2=e^{8/5}\in(4,5)$, so the summation vector has only
the four $n=1,2,3,4$ terms. The endpoint formulas in the preceding
note become

\[
 B_+=\sqrt\lambda\,h(\lambda),\qquad
 B_-=\lambda^{-1/2}\sum_{n=1}^4h(n/\lambda).          \tag{2}
\]

The rational certificate
[`connes_prolate_zhu_window.py`](../../certificates/connes_prolate_zhu_window.py)
gives, with deliberately wide outward bounds,

\[
 1.60\cdot10^{-8}<B_+<1.62\cdot10^{-8},\qquad
 1.85\cdot10^{-8}<B_-<1.88\cdot10^{-8},\qquad
 \|k\|_{L^2(-4/5,4/5)}<4/5.                           \tag{3}
\]

Here is how the certificate controls the *infinite* ODE, rather than
merely a floating-point matrix. Expand in even Legendre polynomials
$P_{2j}$ and truncate after $j=35$. Multiplication by $t^2$ is a
Jacobi matrix with exact rational entries apart from the single
parameter $c^2$. Alternating arctangent series for Machin's formula
for $\pi$, and positive Taylor series for $e^{4/5}$ and $e^{16/5}$,
enclose those parameters by rational intervals of width below
$10^{-60}$. The multiprecision eigensolver only *proposes* rational
vectors. Exact rational arithmetic then checks their ODE residuals
are below $10^{-21}$ and their squared norms lie in
$(0.999,1.001)$.

Exact tridiagonal Sturm counts at $90\pm20$, $210\pm20$, and
$325\pm20$ are respectively $1,2,3$. These counts hold at both
endpoints of the $c^2$ interval. The omitted tail starts at Legendre
degree $72$, so its quadratic form is at least $72\cdot73$; the
Schur correction below $345$ is less than $20$. Thus the full even
operator has exactly one eigenvalue in each of
$(-\infty,90)$, $(90,210)$, and $(210,325)$.
The candidate eigenvalues are enclosed near
$30.3645377007103$ and $268.870041474256$. Their residuals and the
spectral separation give an $L^2$ eigenvector error below
$5\cdot10^{-23}$. For the point evaluation, write the normalized
Legendre basis as $p_{2j}$. The sum of $p_{2j}(1)^2$ through $j=35$
is $1278$, so the finite-component endpoint error is below
$\sqrt{1278}\,5\cdot10^{-23}$. In the tail, the eigenvalue equation,
the diagonal bound $72\cdot73-325=4931$, and neighboring Jacobi
entries below $250$ give the weighted $\ell^1$ estimate

\[
 \sum_{j\ge36}|p_{2j}(1)v_j|<0.5|v_{35}|.
\]

The candidate $v_{35}$ is below $2\cdot10^{-25}$, and its true value
differs by less than $5\cdot10^{-23}$. The same recurrence with
$p_{2j}'(1)$ and $p_{2j}''(1)$ weights bounds derivative evaluation
errors. After division by the nonzero integral coefficient, each
integral-normalized endpoint value used by the certificate has error
below $10^{-16}$, and the derivative errors are below $10^{-12}$.
These loose errors are already far smaller than the margins in (3).

The certificate evaluates the finite Legendre polynomials at $1$ and
$n/\lambda^2$ to obtain (2). It also evaluates $\|k\|_2^2$ by exact
polynomial integration. With $u=e^x/\lambda$,

\[
 \|k\|_2^2=\lambda\sum_{m=1}^4
 \int_{I_m}\left(\sum_{n=1}^m h(n\lambda u)\right)^2du,
 \quad I_4=[\lambda^{-2},1/4],\ I_3=[1/4,1/3],\
 I_2=[1/3,1/2],\ I_1=[1/2,1].                    \tag{4}
\]

The rational polynomial value is in $(0.604,0.606)$; the eigenvector
error changes its norm by less than $10^{-14}$. In (4), $h(n\lambda u)$
has angular argument $nu$. The certificate's Legendre polynomial
uses that angular argument directly.

To turn $B_+$ into an actual Weil residual lower bound, use the
upper endpoint collar $x=a-s$, $0<s<\delta=10^{-10}$. The preceding
note's full operator formula gives, for
$g=(A_a-R)k$ and any $0\le R<E_1$,

\[
 g(a-s)=\frac{B_+}{2}\log(1/s)+G(s),
 \qquad \sup_{0<s<\delta}|G(s)-G(0)|<48\delta.        \tag{5}
\]

For completeness, the modulus in (5) can be bounded term by term
without evaluating the Weil Rayleigh quotient. Let
$F(s)=k(a-s)$, $h_*=1/10$, and split the archimedean integral in the
boundary formula at $s$-distance $h_*$. The endpoint Taylor series
from (1), writing $z=1-t$, satisfies

\[
 a_{n+1}=\frac{[n(n+1)+c^2-\kappa]a_n
                 -2c^2a_{n-1}+c^2a_{n-2}}{2(n+1)^2}.
                                                               \tag{6}
\]

Rational interval propagation of (6) through $n=100$, followed by
the monotone coefficient majorant for $n\ge100$, gives for the
*sum of the absolute Taylor coefficients* of $h_0$ and $h_4$ on
$0\le z\le0.1$ the respective zeroth, first, and second derivative
bounds $0.00013$, $0.0065$, and $0.29$. Consequently

\[
 |F|<10^{-3},\qquad |F'|<10^{-2},\qquad |F''|<1/2
 \quad(0\le s\le0.1).                              \tag{7}
\]

For the near part of the archimedean integral, split at $t=s$.
Using $r(t)\le1/t$ and $r(0.1-s)<6$, differentiation of the two
integrals bounds its variation by $0.067\delta$.
For the far part, $H(0.1-s)<3$,
$-r'(t)\le2/t^2$ on $0<t\le1.6$, and $\|k\|_2<0.8$ give a
variation below $29.3\delta$. The last kernel inequality follows
from $e^{2t}\ge1+2t$ in the differentiated formula for
$r(t)=e^{-t/2}/(1-e^{-2t})$: indeed

\[
 t^2(-r'(t))\le
 \frac{e^{-t/2}t(1+2t)}4+
 \frac{e^{-5t/2}(1+2t)^2}2<0.76+0.61<2
 \quad(0<t\le1.6).
\]

The pole derivative is below $2$ by Cauchy--Schwarz. The three
one-sided translated derivatives at $a-\log n$, $n=2,3,4$, have
absolute value below $10$ each by rational Legendre evaluation;
their total shift weight is below $1.5$, so the prime term contributes
less than $15\delta$. The remaining constant, far-end kernel, and
regular part of $H(s)$ contribute less than $0.2\delta$.
Finally $(F(s)-B_+)\log(1/s)/2$ contributes at most
$0.005\delta\log(1/\delta)<0.116\delta$. These bounds total less
than $48\delta$. Only the case $R<E_1$ is used here; Zhu's positivity
and upper bound for $E_1$ then give $0\le R<2.347\cdot10^{-14}$.

Pair (5) with the mean-zero collar function
$\rho_\delta(s)=\log(\delta/s)-1$. The exact integrals
$\int\rho_\delta^2=\delta$,
$\int\log(1/s)\rho_\delta=\delta$, and
$\int|\rho_\delta|=2\delta/e$ give

\[
 \frac{\|(A_a-R)k\|_2}{\|k\|_2}
 \ge\frac{\sqrt\delta}{\|k\|_2}
       \left(\frac{B_+}{2}-\frac2e\,48\delta\right)
 >5.5\cdot10^{-14}.                                  \tag{8}
\]

[Zhu's certified parity theorem](https://arxiv.org/html/2608.24827v2)
places the full next eigenvalue at
$E_1\le2.347\cdot10^{-14}$ and the ground eigenvalue at
$E_0\ge8.9\cdot10^{-18}$. If $R<E_1$, then
$E_1-R\le2.34611\cdot10^{-14}$. Therefore

\[
 \frac{\|(A_a-R)(k/\|k\|_2)\|_2}{E_1-R}>2.3.    \tag{9}
\]

If $R\ge E_1$, the location hypothesis of the
[residual-transfer criterion](connes-weil-gap-residual-transfer.md)
fails instead. Thus at this certified window the residual criterion
cannot even give a nontrivial angle bound for this particular
Connes vector. This is a failure of that **sufficient test**, not a
lower bound on its true angle from the Weil ground state. The
calculation is written analysis plus a rational computational
certificate. It is not a Lean formalization and has no all-window
or RH consequence.
