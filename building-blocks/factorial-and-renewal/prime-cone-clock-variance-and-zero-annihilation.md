# Prime cones, a positive clock budget, and its exact limit

This note tests the idea that the additive clock $1,2,\ldots$ and the future
cones $d\mathbb N$ of new multiplicative coordinates obey a conservation law
strong enough to restrict zeta zeros. The finite positive law below is valid.
Its apparent prime-error gain disappears under divisor convolution. No RH
estimate follows from it.

## A finite order law for every divisibility cone

Let $X\ge 1$, $1\le d\le X$, and $U_X$ be uniform on
$\{1,\ldots,X\}$. Put $q=\lfloor X/d\rfloor$ and let $V_{X,d}$ be uniform
on the multiples $d,2d,\ldots,qd$. Then, for every increasing concave
function $f$ on $[1,X]$,

\[
\boxed{\quad \mathbb E f(V_{X,d})\ge\mathbb E f(U_X).\quad}       \tag{1}
\]

This is increasing-concave stochastic dominance, a finite statement that
can be falsified by a single $X,d,f$. It uses the hard successor cutoff;
it does not posit independent prime coordinates.

Here is a direct proof. Write $X=dq+r$, $0\le r<d$. It suffices to prove
(1) for $f_t(n)=\min(n,t)$, all real $t$, because the nonnegative,
decreasing first differences of any increasing concave $f$ express it as
a nonnegative combination of these capped ramps and an affine function.
Both sides are piecewise linear in $t$, so integer $t$ suffices. For
$1\le t\le X$, write $t=dm+s$, $0\le s<d$, and set

\[
B=\sum_{n\le X}(t-n)_+=\frac{t(t-1)}2,\qquad
C=\sum_{k\le q}(t-dk)_+=\frac{dm(m-1)}2+ms.
\]

Since $\mathbb E\min(Y,t)=t-\mathbb E(t-Y)_+$, the desired inequality is
$qB-XC\ge0$. Direct block counting gives

\[
B-dC=\frac{md(d-1)+s(s-1)}2=:E,
\qquad qB-XC=qE-rC.                                      \tag{2}
\]

If $m\le q-1$, use $q\ge m+1$, $r\le d-1$ and $E,C\ge0$. The resulting
lower bound is

\[
(m+1)E-(d-1)C
=\frac{m\{d(d-1)+(d-s)(d-s-1)\}+s(s-1)}2\ge0.
\]

If $m=q$, then $s\le r$, and the lower bound obtained by setting
$r=d-1$ is $q(d-s)(d-s-1)/2\ge0$. For $t\ge X$, (1) reduces to
$\mathbb E V_{X,d}-\mathbb E U_X=(d-r-1)/2\ge0$. This completes the proof.

The corresponding first-order stochastic order is false. For example,
with $X=7,d=3$, at $t=3$ the conditional cone has probability $1/2$
of being at most $t$, while the full clock has probability $3/7$.
The concavity qualification matters.

## Exact positive prime-power variance budget

Let

\[
\ell_X=\frac{\log(X!)}X,\quad
q_X(d)=\lfloor X/d\rfloor,\quad
K_X(d)=q_X(d)\left(\log d+\frac{\log(q_X(d)!)}{q_X(d)}-\ell_X\right).
\tag{3}
\]

Applying (1) to $f(n)=\log n$ gives $K_X(d)\ge0$. More explicitly,
$K_X(d)=X\operatorname{Cov}(\mathbf1_{d\mid U_X},\log U_X)$. The exact
divisor identity $\log n=\sum_{p^k\mid n}\log p$ now yields

\[
\boxed{\quad
\sum_{p^k\le X}(\log p)K_X(p^k)
=\sum_{n\le X}(\log n-\ell_X)^2
=X+O(\log^2 X).\quad}                                    \tag{4}
\]

Every term on the left is nonnegative. Thus any selected collection of
actual prime-power arrivals has weighted budget at most the right side.
This is a positive, finite arithmetic constraint, but it is not a bound
on $\psi(X)-X$.

For fixed $0<\alpha<\beta\le1$, the prime number theorem gives a scale
limit. Define $j(u)=\lfloor1/u\rfloor$ and

\[
g(u)=j(u)\left(1+\log u+\frac{\log(j(u)!)}{j(u)}\right),
\qquad 0<u\le1.                                             \tag{5}
\]

Then

\[
\frac1X\sum_{\alpha X<p^k\le\beta X}(\log p)K_X(p^k)
\longrightarrow\int_\alpha^\beta g(u)\,du.              \tag{6}
\]

Prime powers with $k\ge2$ contribute $o(1)$ after normalization.
The limit follows by $\ell_X=\log X-1+o(1)$, uniform convergence of
$K_X(d)$ to (5) on each of the finitely many reciprocal-integer
intervals meeting $[\alpha,\beta]$, and the PNT in the form
$X^{-1}\sum_{p\le X}(\log p)h(p/X)\to\int_0^1h(u)du$ for bounded
piecewise continuous $h$. No prime-error rate better than the input PNT
is claimed. The density is nonnegative by (1). Direct integration on
($1/(j+1),1/j]$ gives

\[
\int_{1/(j+1)}^{1/j}g(u)du
=\log(1+1/j)-(\ell_{j+1}-\ell_j),
\]

so $\int_{1/(J+1)}^1g=\log(J+1)-\ell_{J+1}\to1$.
The macroscopic prime arrivals account for asymptotically all of the
variance budget as the lower scale tends to zero. This is a description
of the budget, not independent evidence for RH.

## The apparent sub-square-root prime-error estimate

The cone kernel has the alternative form

\[
K_X(d)=\sum_{m\le X/d}(\log(dm)-\ell_X).              \tag{7}
\]

Consequently the weighted error $E_X=\sum_{d\le X}(\Lambda(d)-1)K_X(d)$
is exactly

\[
E_X=\sum_{n\le X}(\log n-\tau(n))(\log n-\ell_X).    \tag{8}
\]

Indeed $\sum_{d\mid n}\Lambda(d)=\log n$ and
$\sum_{d\mid n}1=\tau(n)$. If
$D(t)=\sum_{n\le t}\tau(n)=t\log t+(2\gamma-1)t+\Delta(t)$, partial
summation in (8), Stirling, and
$\sum_{n\le X}(\log n-\ell_X)^2=X+O(\log^2X)$ give

\[
E_X=O\!\left(\log^2X+|\Delta(X)|+
                   \int_1^X\frac{|\Delta(t)|}{t}dt\right). \tag{9}
\]

Dirichlet's hyperbola estimate $\Delta(t)=O(\sqrt t)$ therefore proves
the unconditional $E_X=O(\sqrt X)$. Huxley's published exponent
$131/416$ transfers to $E_X=O_\varepsilon(X^{131/416+\varepsilon})$.
This is an estimate for the particular positive kernel (3), not a new
estimate for the unsmoothed Chebyshev function. The stronger
$517/1648$ exponent sometimes quoted from Bourgain--Watt's
arXiv:1709.04340 must **not** be used: the authors withdrew that paper
and explicitly removed theorem status from its main claims.

The exact obstruction is algebraic. Divisor convolution by the constant
function (1) sends

\[
(\Lambda-1)*1=\log-\tau.
\]

Its Dirichlet series is $ -\zeta'(s)-\zeta(s)^2$, holomorphic at every
nontrivial zero of $\zeta$. The poles of
$-\zeta'(s)/\zeta(s)-\zeta(s)$, which would carry zero information,
have canceled. Equation (7) is precisely this convolution in finite form.
It explains why (9) can be much stronger than known pointwise prime-error
bounds without saying anything about the zeros.

## General covariance family and inverse test

For any real clock observable $f(1),\ldots,f(X)$, put
$\bar f=X^{-1}\sum_{n\le X}f(n)$ and

\[
K_{X,f}(d)=\sum_{m\le X/d}(f(dm)-\bar f).
\]

If $f$ is increasing and concave, (1) makes every $K_{X,f}(d)\ge0$.
For *every* $f$, however,

\[
\sum_{d\le X}(\Lambda(d)-1)K_{X,f}(d)
=\sum_{n\le X}(\log n-\tau(n))(f(n)-\bar f).       \tag{10}
\]

Thus the entire positive covariance family has the same divisor
convolution and zero annihilation. Changing a concave clock probe cannot
repair the loss.

The uncentered cone transform $T_Xh(d)=\sum_{m\le X/d}h(dm)$ has the
exact inverse

\[
T_X^{-1}a(n)=\sum_{m\le X/n}\mu(m)a(nm).             \tag{11}
\]

To make a sharp birth test $a(d)=\mathbf1_{2\le d\le y}$, with $X=y$,
the required centered clock probe is

\[
h(1)=M(y)-1,\qquad h(n)=M(\lfloor y/n\rfloor)
\quad(2\le n\le y),                                    \tag{12}
\]

where $M(v)=\sum_{m\le v}\mu(m)$. Its mean is zero because
$a(1)=T_Xh(1)=0$. Already at $y=8$, (12) gives
$(-3,-1,0,0,1,1,1,1)$, whose first differences $2,1,0,1,0,0,0$
are not decreasing. The sharp test has left the concave positivity
cone, and its probe explicitly contains the Mertens sums whose
square-root bound is RH-equivalent. This is a discriminating failure of
the proposed route, not an assumption that every future-cone method must
fail.

## Literature and scope

The stochastic-order term in (1) is standard; the finite arithmetic
inequality is proved here, without an originality claim. The independent
prime-coordinate model is the classical Kubilius model, and its useful
range concerns small prime factors of a uniform integer. It does not
capture the hard-cutoff correlation in (4). The parity obstruction to
cone-only sieves is discussed by Friedlander and Iwaniec. Bost--Connes
already exhibits a zeta partition function and a phase transition at
inverse temperature (1); that transition alone says nothing about the
critical line. The present finite law identifies exactly which positive
information the literal integer clock supplies and where it is lost.

Primary sources inspected:

- Huxley, [*Exponential sums and lattice points III*](https://doi.org/10.1112/S0024611503014485), *Proc. London Math. Soc.* 87 (2003), abstract giving $131/416$.
- Bourgain and Watt, [withdrawal record for arXiv:1709.04340](https://arxiv.org/abs/1709.04340), 2023 revision.
- Friedlander and Iwaniec, [*Asymptotic sieve for primes*](https://annals.math.princeton.edu/articles/13036), *Annals of Mathematics* 148 (1998), introduction and parity discussion.
- Bost and Connes, [*Hecke algebras, type III factors and phase transitions with spontaneous symmetry breaking in number theory*](https://repo-archives.ihes.fr/FONDS_IHES/I_Prepublications/CONNES/1994-1998/M_95_38/M_95_38_web.pdf), 1995.
- Nendel, [*A note on stochastic dominance, uniform integrability and lattice properties*](https://doi.org/10.1112/blms.12371), 2020, §3.2 for the standard increasing-concave order criterion.
