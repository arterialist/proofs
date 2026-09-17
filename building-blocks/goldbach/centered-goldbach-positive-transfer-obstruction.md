# Centered Goldbach positivity: a finite parity obstruction

Let

\[
a_n=\Lambda(n)-1,
\qquad
D_Y(t)=\sum_{1\le n\le Y}a_ne^{-nt},
\]

with `a_1=-1` and the complete von Mangoldt function, including every prime
power.  Its finite square is

\[
D_Y(t)^2=\sum_{N=2}^{2Y}c_N^{(Y)}e^{-Nt},
\qquad
c_N^{(Y)}=\sum_{\substack{m+n=N\\1\le m,n\le Y}}a_ma_n.
\tag{1}
\]

This is the finite arithmetic side of the centered Mellin--Barnes and
Matsumoto--Suzuki heat identity.  The square is nonnegative at every real
`t`, but its additive coefficients and its Hankel kernel need not be
nonnegative.

## The first even obstruction

At `Y=3`, the complete coefficient at total four retains the three ordered
pairs `(1,3)`, `(2,2)`, `(3,1)`:

\[
\boxed{
c_4^{(3)}=(\log2-1)^2-2(\log3-1)<0.}
\tag{2}
\]

The inequality follows, for example, from the certified rational bounds

\[
0.69<\log2<0.7,
\qquad
1.09<\log3.
\]

For the last bound, write `1.09=1+0.09`, use
`e<2.7182818286` and `exp(0.09)≤1/(1-0.09)`, and compare the product with
three.  Thus (2) does not use decimal evaluation as an axiom.

The uncentered coefficient at the same total is

\[
R_4=\Lambda(2)^2=(\log2)^2>0.
\]

Consequently no coefficientwise positive comparison can pass from complete
Goldbach coefficients to centered coefficients, even after restricting to
even totals.  The centered Hankel matrix also fails positivity: its `(2,2)`
diagonal entry is exactly (2).  This does not contradict positivity of (1),
which comes from cancellation among different totals after evaluation at
the exponential character.

Parity does not repair the issue.  If a finite heat is split into its even
and odd index parts `E` and `O`, then

\[
(E+O)^2=E^2+O^2+2EO,
\qquad
(E-O)^2=E^2+O^2-2EO.
\tag{3}
\]

The odd-total packet is the signed cross `2EO`; the even-total packet is
`E²+O²`.  Formula (2) shows that even-total *coefficients* can still be
negative.  Neither parity packet inherits coefficientwise positivity from
the complete square.

## Test of the sparse Dirichlet future family

For positive odd `q`, the exact sparse family from the future-observation
audit satisfies

\[
a_e^{(q)}=1_{q\mid e}\mu(e/q),
\qquad
(A_La^{(q)})_d=1_{q\mid d}\Lambda(2d/q).
\tag{4}
\]

The right side is supported at `d=q2^j`.  It supplies a positive sparse
observation and proves that the inverse of `A_L` has polynomial norm loss.
Pulling a positive additive heat kernel back through this map gives the
positive matrix `A_L^* H A_L`, but the centered heat kernel is a different
matrix.  Equation (4) supplies no Loewner comparison between them.  The
inverse-norm loss rules out a scale-uniform argument that treats the
Dirichlet observation as a boundedly invertible coordinate change.

There is a necessary qualification: the Hilbert heat kernel does not
uniformly dominate the ordinary coefficient `ℓ²` norm.  Therefore the
sparse family alone is not a counterexample to every conceivable
source-specific heat comparison.  It is a counterexample to the proposed
bounded-inverse route, while (2) independently rules out coefficientwise and
Hankel-positive routes.

## Test of the successor identity

The exact successor transport gives

\[
C_S(t)=e^t\left(C(t)-t\int_t^\infty C(u)\frac{du}{u}\right).
\tag{5}
\]

After logarithmic critical normalization, the successor profile differs
from the original profile by an unconditional `L²` function.  Hence their
upper Lyapunov exponents and polynomial-doubling criteria agree.  This is an
exact finite-energy bridge, but it cannot be a genuinely weaker route to the
target estimate: a target-scale successor bound is equivalent to the
original RH-equivalent positive norm bound.  Expanding the successor's
positive measure square also restores a signed baseline cross, so positivity
of the transported atomic measure does not remove centering.

## Outcome

The unconditional information obtained here is a sharp finite no-go:

* full heat-square positivity does not imply coefficientwise positivity;
* the failure occurs in the first nontrivial even coefficient and retains
  both additive endpoints;
* the Matsumoto--Suzuki screw form cannot be inserted as globally positive,
  since that condition is itself RH-equivalent;
* sparse future observations obstruct bounded inversion but do not estimate
  the actual centered source;
* successor transport preserves, rather than weakens, the critical growth
  obligation.

Thus these mechanisms yield no new unconditional target-scale Goldbach
comparison.  They do isolate exactly what a useful weaker theorem must add:
a source-specific quantitative cancellation estimate for the centered
cross, with the complete prime powers, endpoints, and parity terms retained.
No RH progress is claimed.

## Lean scope

[CenteredGoldbachPositiveTransferObstruction.lean](../../formalization/BuildingBlocks/CenteredGoldbachPositiveTransferObstruction.lean)
proves (2), the failure of all-even coefficientwise nonnegativity, the
negative Hankel diagonal, and the parity square algebra.  It relies on the
existing literal finite heat and complete centered coefficient definitions.
