# Lowest screw and moment minors: exact Goldbach audit

## Scope and source convention

The source is Kohji Matsumoto and Masatoshi Suzuki, *M-functions and screw functions: applications to Goldbach's problem and zeros of the Riemann zeta-function*, arXiv:2409.00888v2 (20 October 2025), especially Theorem 1.3, equation (1.6), and Proposition 6.1, equation (6.2).

Their convention is

\[
H_1(X)=\sum_\rho\frac{X^{\rho-1/2}}{\rho(1-\rho)},\qquad
g_{H_1}(t)=H_1(e^t)-H_1(1),
\]

and the screw kernel is

\[
G_g(t,u)=g(t-u)-g(t)-g(-u)+g(0).
\]

Theorem 1.3 says that `g_H1` is a screw function on the whole real line if and only if RH.  Thus the positivity hypotheses below are not unconditional sign assertions.

Proposition 6.1 is unconditional for `X>1` and uses the following sign convention:

\[
\begin{aligned}
H_1(X)={}&\sum_{n\le X}\frac{\Lambda(n)}{\sqrt n}
 \left(\sqrt{\frac Xn}-\sqrt{\frac nX}\right)
-\sqrt X(\log X-C_0-1)\\
&-\frac{\log(2\pi)}{\sqrt X}
-\frac1{\sqrt X}\left\{
 \frac12\log(1-X^{-2})
 +\frac X2\log\frac{X+1}{X-1}-1\right\}.
\end{aligned}
\]

Here `C_0` is Euler's constant.  `hOneArithmetic N` in the Lean file is exactly “prime row minus archimedean correction” with these signs.  The endpoint is explicitly present.  Its summand is zero when `n=N`, so ordinary and half-weight endpoint conventions agree for this particular row.  Every prime power is retained through Mathlib's actual `vonMangoldt`.

## Lowest screw minor

Let `g` be real and even, and put

\[
a=g(t)-g(0),\qquad b=g(2t)-g(0).
\]

On the two points `t,2t`, the screw matrix is

\[
\begin{pmatrix}
-2a&-b\\
-b&-2b
\end{pmatrix}.
\]

Its one-point minors give `a<=0` and `b<=0`, while its determinant is

\[
b(4a-b).
\]

Positive semidefiniteness therefore gives the exact lowest nontrivial inequality

\[
4\{g(t)-g(0)\}\le g(2t)-g(0)\le0.
\]

For `g(t)=H_1(e^t)-H_1(1)`, `g(0)=0`.  Taking `t=log N` translates the inequality into the two finite Proposition 6.1 rows at `N` and `N^2`.  `hOne_dyadic_finite_consumer` formalizes precisely this implication, with both diagonal signs and the determinant sign explicit.  It does not prove those signs.

## Exact additive Goldbach translation and its remainder

Write

\[
r_2(n)=\sum_{m+k=n}\Lambda(m)\Lambda(k),\qquad
A(N)=\sum_{n\le N}\frac{r_2(n)}{n^2}.
\]

The Lean definition `inverseSquareGoldbachPrefix` is this complete finite ordered-pair sum.  It includes all prime powers and both additive endpoints.  Equation (1.6) has the form

\[
A(N)=\log N+c_2+\frac{2H_1(N)}{\sqrt N}+E(N).
\]

In the cited paper this formula is derived from the Goldbach summatory
asymptotic under RH. It is an exact unconditional identity only if `E(N)`
is defined to be the displayed residual; none of the paper's useful bounds
for that residual may then be imported unconditionally.

Retaining the error exactly, set `R_N=A(N)-log N-c_2-E(N)`.  The dyadic screw inequality becomes

\[
2\sqrt N\,R_N-\frac N2R_{N^2}\le3H_1(1).
\]

This algebra is `goldbach_prefix_dyadic_translation`.  Dropping `E(N)` or controlling the difference between its two scales is an additional analytic theorem; the screw minor itself does not provide it.

## Lowest ordinary moment minor

For a positive measure, the first Hankel moment condition is

\[
M_1^2\le M_0M_2.
\]

In the absolutely convergent region `Re(s)>2`, the Goldbach Dirichlet weights `r_2(n)n^{-sigma}` are nonnegative, so this follows from Cauchy--Schwarz.  `finite_moment_minor_nonnegative` proves the finite weighted statement without continuation or an infinite-series premise.

This does not extend by treating the raw coefficients `r_2(n)` as the moments.  The first three consecutive nonzero coefficients are

\[
\begin{aligned}
r_2(4)&=(\log2)^2,\\
r_2(5)&=2\log2\log3,\\
r_2(6)&=2(\log2)^2+(\log3)^2.
\end{aligned}
\]

The term `2(log 2)^2` in `r_2(6)` contains both ordered pairs `2+4` and `4+2`; `Lambda(4)=log 2`, so the prime power is essential.  Their Hankel determinant is

\[
r_2(4)r_2(6)-r_2(5)^2
=(\log2)^2\{2(\log2)^2-3(\log3)^2\}<0.
\]

This is the smallest consecutive Hankel minor whose three entries are all nonzero.  The Lean certificate proves the strict sign from `log 2<0.7` and `log 3>1`.

## What existing Goldbach results do and do not prove

Classical Goldbach existence supplies positivity of selected even `r_2(n)`.  Positivity of individual coefficients gives neither the screw determinant nor a Hankel determinant; the explicit `4,5,6` minor shows that the latter implication is false even at the first eligible location.

Selberg and Fujii average formulas concern cumulative additive sums.  Matsumoto--Suzuki's equation (1.6) makes the missing information visible as `E(N)` at both `N` and `N^2`.  An average main term alone has no sign control strong enough to remove those two errors from the dyadic inequality.

The unconditional explicit formula in Proposition 6.1 evaluates each finite `H_1(N)` row exactly, so isolated values can be checked.  A uniform positive-definiteness statement for the resulting kernel is a different assertion: by Theorem 1.3, it is equivalent to RH.  Consequently this route supplies the standard nonnegative moment inequality in the absolute-convergence half-plane and exact finite consumers outside it, but no unconditional inequality beyond `Re(s)>2` from the cited Goldbach existence or average results.

## Formal scope

[`GoldbachScrewMinorFinite.lean`](BuildingBlocks/GoldbachScrewMinorFinite.lean) proves:

- the diagonal and dyadic cross entries of the screw kernel;
- the exact determinant and its PSD consequence;
- the literal Proposition 6.1 integer row and an explicit finite consumer under PSD hypotheses;
- finite weighted moment Cauchy--Schwarz;
- the exact additive Goldbach prefix translation with both error terms retained;
- the values at totals `4,5,6` and the strict negative Hankel determinant.

All public conclusions print only Lean's standard logical axioms.  The module asserts no RH consequence, analytic continuation, error estimate, or screw positivity for the actual arithmetic function.
