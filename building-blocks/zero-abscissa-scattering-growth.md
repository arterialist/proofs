# The zero abscissa calibrates the signed relative norm

Let
$$
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad
\Theta=\sup\{\Re\rho:\zeta(\rho)=0,  0<\Re\rho<1\}.
$$
Zeros are counted with multiplicity. The functional equation and the existence of nontrivial zeros give $1/2\le\Theta\le1$. No maximum is assumed to exist.

The classical input needed by the operator construction is
$$
\boxed{\psi(x)-x=O\bigl(x^\Theta(\log x)^2\bigr),\qquad x\ge2.}
\tag{1}
$$
In particular it implies $O_\epsilon(x^{\Theta+\epsilon})$ for every positive $\epsilon$. This is a bound in terms of the unknown actual zero abscissa, not an unconditional assertion that $\Theta=1/2$.

## Primary explicit formula and the cutoff convention

Use Adrian Dudek, *An Explicit Result for Primes Between Cubes*, [Theorem 2.1, equation (2)](https://arxiv.org/pdf/1401.4233), PDF page 4. For a half-integer $y>e^{60}$, and $50<T<y$ avoiding zero ordinates, it states
$$
\psi(y)=y-\sum_{|\Im\rho|<T}\frac{y^\rho}{\rho}
 +O^*\!\left(\frac{2y\log^2 y}{T}\right).
\tag{2}
$$
Here $\Lambda(p^k)=\log p$ for every $k\ge1$, and the sum is over both signs of the zero ordinates. The bounded pole and trivial-zero terms in the full explicit formula are absorbed in this remainder. Equivalently one can retain them as
$$
-\log(2\pi)-\tfrac12\log(1-y^{-2})
$$
and change the remainder by their opposite; its order is unchanged in the range used below. This does not discard any prime powers or residues from the identity.

Only the order estimate in (2) is used, not its numerical constant or its stated finite threshold. The same source records $N(T)=O(T\log T)$ in section 3, PDF page 17. This also follows from its local zero-count estimate (16). All finitely many low zeros can be included in constants.

## Proof of the discrepancy estimate

For $T\ge2$, the zero-count bound gives
$$
\sum_{|\Im\rho|<T}\frac1{|\rho|}
 =O\bigl((1+\log T)^2\bigr).
\tag{3}
$$
Indeed, the finitely many zeros with $|\Im\rho|<1$ contribute a constant. On each dyadic range $2^j\le|\Im\rho|<2^{j+1}$, the contribution is at most $2^{-j}$ times its zero count, hence $O(j+1)$. Summing over $j\le\log_2 T$ proves (3). There is no zero at $\rho=0$, and no limiting assertion about the location of the rightmost zeros is needed.

Choose any $T\in(y/2,3y/4)$ which is not a zero ordinate. Such a choice exists since zero ordinates form a discrete set in every bounded interval. By the definition of a supremum, every zero satisfies $\Re\rho\le\Theta$. Therefore
$$
\left|\sum_{|\Im\rho|<T}\frac{y^\rho}{\rho}\right|
 \le y^\Theta\sum_{|\Im\rho|<T}\frac1{|\rho|}
 =O(y^\Theta\log^2y).
\tag{4}
$$
The remainder in (2) is $O(\log^2y)$. Equations (2)--(4) prove (1) for sufficiently large half-integers.

For arbitrary real $x\ge2$, set
$$
y=\lfloor x\rfloor+\tfrac12.
$$
The sets of positive integers at most $x$ and at most $y$ are identical. Thus
$$
\psi(x)=\psi(y),\qquad
\psi(x)-x=\psi(y)-y+(y-x),\qquad |y-x|\le\tfrac12.
\tag{5}
$$
This is exact when $x$ is itself a prime power as well. Since $y\asymp x$, (1) follows, with the finite initial range absorbed in its constant. No midpoint version of $\psi$ is substituted for the right-continuous function used by the arithmetic measure.

## Consequence for the actual observed multiplier

Retain the exact definitions of $\widehat U_X=U_X R V_{\log X}^{+}$, the negative-frequency Hardy projection $P$, and
$$
N_\chi(\widehat U_X)=\|M_\chi(P-\widehat U_X^*P\widehat U_X)\|_1
$$
from [the single-observation theorem](single-observation-scattering-criterion.md). In particular $U_X$ contains every local power for every admitted prime $p\le X$, as well as the gamma factor. Let $\chi$ be any one fixed real, strictly positive Schwartz function.

Applying the proved mapping theorem in [the discrepancy-to-norm theorem](prime-discrepancy-scattering-norm.md), with (1), gives
$$
N_\chi(\widehat U_X)=
\begin{cases}
O_\chi\bigl(X^{\Theta-1/2}(\log X)^{7/2}+\log X+1\bigr),&\Theta>1/2,\\
O_\chi\bigl((\log X)^{9/2}+\log X+1\bigr),&\Theta=1/2.
\end{cases}
\tag{6}
$$
The constants may depend on the fixed actual abscissa in the first case. The separate $O(\log X)$ term retains the actual-place tail $p\le X,  p^k>X$; it has not been absorbed into a truncated Euler product. The Stieltjes proof in the linked discrepancy theorem includes the lower endpoint and fixed origin.

Combining (6) with the companion norm-to-zero-free theorem proves the exact calibration
$$
\boxed{
\limsup_{X\to\infty}
\frac{\log\bigl(1+N_\chi(\widehat U_X)\bigr)}{\log X}
=\Theta-\tfrac12.}
\tag{7}
$$
For completeness, the upper bound follows from (6). If the limsup were some $\ell<\Theta-1/2$, choose $\sigma$ strictly between them. The definition of limsup gives $N_\chi(\widehat U_X)=O(X^\sigma)$. The companion converse would then put every zero in $\Re\rho\le1/2+\sigma<\Theta$, contradicting the defining supremum. When $\Theta=1/2$, the nonnegativity of $\log(1+N_\chi)$ supplies the lower bound zero. This proof never selects a globally rightmost zero.

Equation (7) is an unconditional written identity between the actual zero abscissa and the growth exponent of the specified operator norm. Its analytic dependencies are the proved mapping and converse theorems linked above. It does not evaluate that exponent as zero and is not yet a Lean theorem.

In particular, for every $0\le\tau<\Theta-1/2$, the ratio $N_\chi(\widehat U_X)/X^\tau$ is unbounded. This is not a lower bound at every cutoff. The exponent is the same for all fixed everywhere-positive Schwartz observations, without asserting pointwise equivalence of their norms. The [explicit compact pole-null observation](compact-positive-scattering-observation.md) realizes this theorem on an actual compact test.
