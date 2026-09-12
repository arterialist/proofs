# The coherent division lattice remainder, with its causal endpoint

The exact coherent sum below retains all successor histories and the physical lower-boundary correction. Its weighted-variation input is proved in the [Mellin-kernel chapter](actual-Abel-feedback-Mellin-kernel.md); the absolute moment cancellations are proved in the [division-kernel chapter](successor-division-kernel-moments.md). The final sign comparison remains unproved.

The parameter t below is -log r for a geometric successor average. It is not the positive prime-process time previously denoted by t in other notes.

## Exact coherent summation

Use the actual prime kernel d_r, continuous scaling kernel k, and division weights

$$
\varphi_r(m)=\sum_{l\ge1}\mu(l)d_r(lm),\qquad
L(z)=\sum_{l\ge1}\mu(l)k(lz).
$$

For fixed z>0 the latter sum is absolutely convergent. Its tail is O(z^(-3/2)) at infinity. For each fixed 0<t<=1 define

$$
\mathcal Q(t)=\sqrt t\sum_{m\ge1}\log m\,L(tm).
\tag{1}
$$

The complete double sum converges absolutely. To see this, combine terms n=lm before estimating absolute values. The divisor log sum is at most tau(n)log n, and k(tn)=O_t(n^(-3/2)) for large n. Even the elementary divisor bound tau(n)<=C_epsilon n^epsilon with epsilon<1/2 suffices. Equivalently one may factor the double Dirichlet tail directly as sum_l l^(-3/2) times sum_m log(m)m^(-3/2), avoiding a divisor bound entirely.

The exact integer identity sum_(m|n)mu(n/m)log m=Lambda(n) therefore gives

$$
\boxed{\mathcal Q(t)=\sqrt t\sum_{n\ge2}\Lambda(n)k(tn).}
\tag{2}
$$

Thus the cancellation is between the actual log-weighted division histories, not between arbitrary inverse coefficients. Absolute error estimates for each fixed m are not summed in place of (2).

## The exact endpoint collapse

Let M_mu(y)=sum_(l<=y)mu(l) and b_j=atan(j^(-1/2))/sqrt j. The complete physical lower-boundary correction for each inverse weight is

$$
C_m(t)=\frac{1-r}{r}\sum_{j\ge m}r^j b_j
M_\mu(\lfloor j/m\rfloor),\qquad r=e^{-t}.
\tag{3}
$$

At EACH finite j, exact divisor summation gives

$$
\sum_{m\le j}\log m\,M_\mu(\lfloor j/m\rfloor)
=\sum_{n\le j}\sum_{m\mid n}\mu(n/m)\log m
=\psi(j).
\tag{4}
$$

For fixed r, the j sum of the absolute log-weighted terms in (3) converges: use |M_mu(j/m)|<=j/m, b_j<=1/j, and the convergent geometric series against log^2(2+j). Hence (4) proves

$$
\boxed{\sum_{m\ge1}\log m\,C_m(t)
=\frac{1-r}{r}\sum_{j\ge2}r^j b_j\psi(j)=C(t)>0.}
\tag{5}
$$

The exact initial value psi(1)=0 and the prime-two term j=2 are included. The sum (5) is bounded by Chebyshev and tends to 1 by PNT. This finite correction must not be deleted merely because a fixed-m correction can be small.

## An exact signed quadrature error

Put U(u,n)=q^0(u,n)-n^(-1/2), where q^0 is the continuous birth mass in the Mellin-kernel note. Define the actual signed error

$$
\mathcal R(t)=\sum_{n\ge2}\Lambda(n)
\left\{\frac{1-r}{r}\sum_{j\ge0}r^j U(j,n)
-t\int_0^\infty e^{-tu}U(u,n)du\right\}.
\tag{6}
$$

All differences and sums in (6) are absolutely defined. The subtraction of n^(-1/2) occurs before quadrature. Its exact role is to keep the infinite source and initial term in the same convergent expression. The proved Chebyshev summed-variation estimate gives an absolute constant C0 such that

$$
|\mathcal R(t)|\le C_0\sqrt t\quad(0<t\le1).
\tag{7}
$$

The numerical value of C0 has not been optimized or certified here. For a fully explicit finite certificate it must be propagated from that proof. This is a uniform error estimate, not an assertion that R(t) has a favorable sign.

Equations (2), (5) and the literal discrete birth masses give the exact source identity

$$
\boxed{E(e^{-t})+C(t)=\mathcal Q(t)+\mathcal R(t).}
\tag{8}
$$

Every ordinary successor history, all prime powers, and the lower-boundary returns are retained. There is no separate divergent absolute inverse-weight error on the right.

## Cancel the two continuum moments before separating budgets

The checked inverse-kernel theorem proves absolute convergence and

$$
\int_0^\infty L(z)dz=0,\qquad
\int_0^\infty L(z)\log z\,dz=0.
\tag{9}
$$

Therefore the exact continuous comparison for (1) is zero:

$$
\sqrt t\int_0^\infty\log x\,L(tx)dx
=t^{-1/2}\int_0^\infty[\log z-\log t]L(z)dz=0.
\tag{10}
$$

Combining (1) and (10) yields a fully convergent cell expression

$$
\begin{split}
\mathcal Q(t)={}&\sqrt t\sum_{m\ge1}
\left[\log m\,L(tm)
-\int_m^{m+1}\log x\,L(tx)dx\right]\\
&-\sqrt t\int_0^1\log x\,L(tx)dx.
\end{split}
\tag{11}
$$

The sum of absolute values of the displayed cell terms is finite for each t: the sample sum is absolutely convergent and the integral is absolutely convergent by the moment theorem. No derivative, fixed sign, or convexity of L is used. The final fractional cell is part of the expression, and is distinct from the physical return correction C(t).

This cancels the leading opposite logarithmic budgets before estimating a remainder. It does not bound that remainder. In particular, the known ordered positive-negative-positive values of L and the first surviving curved-log moment do not establish a sign for the lattice expression (11).

## The quantitative target

The exact sufficient target near t=0 is

$$
\mathcal Q(t)+\mathcal R(t)\ge C(t).
\tag{12}
$$

A stronger sufficient target using only the established unsigned error is

$$
\mathcal Q(t)\ge C(t)+C_0\sqrt t.
\tag{13}
$$

The weaker comparison Q(t)>=C(t) alone does not prove the source sign. Equations (12)--(13) are presently unproved. They preserve the actual finite remainder after the leading core/exterior cancellation, the unit endpoint, and the sign of the quadrature error. By the independently checked feedback theorem, an eventual source sign on the entire parameter interval would have the RH consequence already identified there. This note establishes the exact remainder to be estimated, not that missing arithmetic estimate.

This chapter contains written analysis, with no Lean claim for the quadrature, dual series or arithmetic comparison. No priority claim is made.
