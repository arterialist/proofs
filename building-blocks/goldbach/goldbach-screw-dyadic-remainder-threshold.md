# Dyadic Goldbach screw remainder threshold

## Three different remainders

This calculation keeps three quantities separate.

1. In Matsumoto--Suzuki Section 7, write the RH-derived Fujii formula as
   \[
   G(X)=\sum_{n\le X}r_2(n)
   =\frac{X^2}{2}-2X^{3/2}H(X)+R_F(X).
   \]
   Their weighted-prefix remainder is then
   \[
   E_W(X)=\frac{R_F(X)}{X^2}
      -2\int_X^\infty R_F(y)y^{-3}\,dy.                 \tag{1}
   \]
   This derivation, including the convergent tail and its useful estimate,
   is made under RH in that paper.

2. Goldston--Suriajaya's exact unconditional Fujii formula has a different
   remainder, an oscillatory circle integral denoted `E(N)` in their Theorem
   1.  Their Theorem 2 bounds its absolute value by a nonnegative variance
   majorant `mathcal E(N)`.  The theorem supplies no sign or correlation
   between scales `N` and `N^2`.

3. Billington--Cheng--Schettler--Suriajaya study the total main-term error
   `G(N)-N^2/2`.  This contains the zero contribution `2R_1(N)` as well as a
   centered additive correlation.  It is not the `R_F` in (1).

The primary sources are [Matsumoto--Suzuki, arXiv:2409.00888v2](https://arxiv.org/abs/2409.00888), [Goldston--Suriajaya, arXiv:2110.14250](https://arxiv.org/abs/2110.14250), and [Billington--Cheng--Schettler--Suriajaya, arXiv:2306.09102](https://arxiv.org/abs/2306.09102).

## Exact two-scale consumer

Put

\[
A(X)=\sum_{n\le X}\frac{r_2(n)}{n^2},\qquad
U_X=A(X)-\log X-c_2.
\]

If the weighted formula

\[
U_X=\frac{2H_1(X)}{\sqrt X}+E_W(X)                    \tag{2}
\]

is available at `N` and `N^2`, the dyadic screw inequality is exactly

\[
2\sqrt N\{U_N-E_W(N)\}
-\frac N2\{U_{N^2}-E_W(N^2)\}\le3H_1(1).            \tag{3}
\]

Thus the only error combination that matters is

\[
\Delta_E(N)=2\sqrt N E_W(N)-\frac N2E_W(N^2).        \tag{4}
\]

Separate absolute estimates give only

\[
|\Delta_E(N)|\le
2\sqrt N\,|E_W(N)|+\frac N2|E_W(N^2)|.              \tag{5}
\]

They give no preferred side of (3).

## Sharp power threshold for the published partial summation

Assume for some `theta<2` and every `y>=N` that

\[
|R_F(y)|\le C y^\theta.
\]

Equation (1) gives, with no hidden exponent loss,

\[
|E_W(X)|\le C_\theta X^{\theta-2},\qquad
C_\theta=C\left(1+\frac2{2-\theta}\right)
=C\frac{4-\theta}{2-\theta}.                         \tag{6}
\]

Substitution in (5) gives

\[
|\Delta_E(N)|\le
2C_\theta N^{\theta-3/2}
+\frac{C_\theta}{2}N^{2\theta-3}.                   \tag{7}
\]

Both terms tend to zero exactly when

\[
\boxed{\theta<\frac32}.                              \tag{8}
\]

At the critical exponent `theta=3/2`, (6) has
`C_theta=5C`, and (7) becomes the non-vanishing budget

\[
|\Delta_E(N)|\le10C+\frac52C=\frac{25}{2}C.          \tag{9}
\]

Any logarithmic growth multiplying `X^(3/2)` makes this budget grow.
Therefore a raw finite-prefix inequality proves the corrected screw
inequality only if it beats `3H_1(1)` by the full budget in (7).  Conversely,
the corrected inequality implies only the raw inequality enlarged by that
budget.

## Comparison with the strongest cited inputs

Under RH, Fujii's original `R_F(X)=O(X^(4/3)(log X)^(4/3))` is below the
threshold.  The later RH bounds `O(X(log X)^5)` and
`O(X(log X)^3)` are farther below it.  These are conditional estimates.

Goldston--Suriajaya also record the conditional bound

\[
\mathcal E(X)\ll X^{2\Theta}(\log X)^5,
\qquad
\Theta=\sup\{\Re\rho:\zeta(\rho)=0\}.
\]

The power threshold `theta<3/2` becomes

\[
\boxed{\Theta<\frac34}.                              \tag{10}
\]

Their corollary uses exactly this frontier to make the error `o(X^(3/2))`.
It is a strong unproved zero-free strip, weaker than RH but far beyond the
known unconditional zero-free region.  At `Theta=3/4`, the displayed
logarithm already prevents a bounded dyadic budget.  The RH-scale estimate
used by Matsumoto--Suzuki, `R_F(X)=O_epsilon(X^(1+epsilon))`, gives
`E_W(X)=O_epsilon(X^(-1+epsilon))` and a vanishing budget for every fixed
`epsilon<1/2`.

Unconditionally, Billington--Cheng--Schettler--Suriajaya obtain from the
Vinogradov--Korobov region a total main-term error of shape

\[
G(X)-\frac{X^2}{2}
=O\!\left(X^2\exp\{-c(\log X)^{3/5}
                  (\log\log X)^{-1/5}\}\right).      \tag{11}
\]

This is `X^(2-o(1))`, not a bound for `R_F`, and it includes the zero term
that (1) separates.  Even if one incorrectly granted (11) as a bound for
`R_F`, the resulting weighted error would be only subpolynomially small;
the factors `sqrt N` and `N` in (5) would make its dyadic budget diverge.
The actual unconditional result is therefore still farther from a signed
conclusion.

Goldston--Suriajaya's exact circle-integral remainder and variance majorant
do not repair this: they are unsigned at each scale and contain no estimate
for the signed correlation in (4).  Classical Goldbach existence likewise
controls individual positive coefficients, not this two-scale centered
combination.

## Conclusion

The strongest unconditional Fujii/Goldston--Suriajaya inputs prove no new
one-sided dyadic screw inequality.  The precise absolute-error frontier is
`R_F=o(X^(3/2))`, or `Theta<3/4` for the quoted zero-strip bound.  Crossing
that frontier only makes the finite Goldbach prefix faithfully approximate
the screw consumer; the one-sided sign still comes from screw-kernel
positivity, which for the actual `H_1` is RH-equivalent.

[`GoldbachScrewRemainderThresholdFinite.lean`](../../formalization/BuildingBlocks/GoldbachScrewRemainderThresholdFinite.lean)
formalizes (5), the exact critical constant `25C/2`, and the two robust
one-sided implications.  It assumes the error bounds explicitly and makes
no unconditional estimate for either published remainder.
