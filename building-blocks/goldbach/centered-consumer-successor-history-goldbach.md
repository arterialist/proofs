# Centered consumer: successor, histories, and Goldbach coupling

## Exact centered row

Let

\[
 q=e^{-2/X},\qquad
 A_n(q)=\sum_{k\le n}\mu(k)q^k,
\]

and retain the centered original complete-admission row

\[
 \widetilde U_X(j)=-q^{-j/2}A_{j-1}(q).
\tag{1}
\]

Its finite energy is

\[
 \mathfrak C_X=(1-q)\sum_{j=2}^{X}q^{-j}|A_{j-1}(q)|^2.
\tag{2}
\]

All endpoints in (1)--(2) are literal. Prime powers remain in `mu`; those
with exponent at least two have coefficient zero.

## Successor anchor `S(n)=n+1`

The weighted prefix has the exact successor increment

\[
 A_{n+1}(q)-A_n(q)=\mu(n+1)q^{n+1}.
\tag{3}
\]

Equivalently, the centered clock row obeys

\[
 \boxed{
 \widetilde U_X(j+1)=q^{-1/2}\widetilde U_X(j)
 -\mu(j)q^{(j-1)/2}.}
\tag{4}
\]

Thus the exact innovation is

\[
 \widetilde U_X(j+1)-q^{-1/2}\widetilde U_X(j)
 =-\mu(j)q^{(j-1)/2}.
\tag{5}
\]

Its squared norm is unconditionally `O(X)`, since `|mu(j)|<=1`. A
Poincare estimate with the ordinary path spectral gap loses two powers of
the horizon and gives only the trivial bound

\[
 \mathfrak C_X=O(X^2),
\]

also obtained directly from `|A_n(q)|<=n`. This is the strongest estimate
available from successor energy without arithmetic cancellation. The genuinely useful target
would be the actual-Möbius observability inequality

\[
 \boxed{
 \mathfrak C_X\ll_\varepsilon X^\varepsilon
 \sum_{j<X}\mu(j)^2q^{j-1}.}
\tag{6}
\]

Because the right side is `O(X^(1+epsilon))`, (6) proves the desired bound.
It is also RH-equivalent: the right side has order `X`, while
`C_X` is comparable to `X^(-1) sum_(n<X)M(n)^2`.

For arbitrary innovations (6) is false. Taking every innovation equal to
one gives prefix size `n`, innovation energy `X`, and prefix energy of order
`X^3`. Hence (6) cannot follow from the successor geometry or positivity
alone; it must use the actual multiplicative signs.

The exact horizon and dyadic recursions are simply

\[
 \sum_{n<N}w_nA_n^2=sum_{n<J}w_nA_n^2
 +\sum_{J\le n<N}w_nA_n^2.
\tag{7}
\]

There is no martingale orthogonality between the two blocks. On the second
block, every state contains the inherited boundary value `A_(J-1)`.
Discarding that common mode is exactly the invalid step exposed by the
cross-horizon audits.

## Complete multiplicative histories

The complete divisor history is

\[
 H(n)=\sum_{d\mid n}\mu(d)\log(n/d).
\]

Dirichlet convolution gives the exact identity

\[
 \boxed{H(n)=\Lambda(n).}
\tag{8}
\]

This retains every prime power: `Lambda(p^k)=log p`, although
`mu(p^k)=0` for `k>=2`. It yields the unconditional positive history energy

\[
 \mathcal H_X=\sum_{n\le X}\Lambda(n)^2.
\tag{9}
\]

A clean sufficient target is

\[
 \boxed{\mathfrak C_X\ll_\varepsilon X^\varepsilon\mathcal H_X.}
\tag{10}
\]

The elementary bound `H_X=O(X log^2 X)` makes (10) sufficient for
`C_X=O_epsilon(X^(1+epsilon))`. Conversely, RH supplies (10), after changing
epsilon, because `H_X` has order at least `X` and the centered criterion is
RH-equivalent. Thus (10) is an exact positive reformulation, but not a
logically weaker theorem.

The obstruction is operator-theoretic. Equation (8) observes `mu` through a
multiplicative convolution, whereas (2) measures additive prefixes. A
uniform finite inverse estimate from (9) to (2) is precisely the missing
half-plane control of `1/zeta`; treating convolution as an isometry silently
assumes the desired spectral bound.

## Additive and Goldbach coupling

Squaring one prefix gives the exact additive identity

\[
 \boxed{
 A_N(q)^2=\sum_{a,b\le N}\mu(a)\mu(b)q^{a+b}.}
\tag{11}
\]

Grouping by `s=a+b` produces the signed additive Möbius coefficients. They
are not nonnegative. The separate complete Goldbach packet is positive:

\[
 \mathcal G_X=sum_{a,b\le X}\Lambda(a)\Lambda(b)
 =\left(\sum_{n\le X}\Lambda(n)\right)^2\ge0.
\tag{12}
\]

Since `G_X` has order `X^2`, the Goldbach domination

\[
 \boxed{
 \mathfrak C_X\ll_\varepsilon X^{-1+\varepsilon}\mathcal G_X}
\tag{13}
\]

would also prove the desired centered bound. As with (10), standard prime
prefix bounds plus the centered criterion show that the all-epsilon family
(13) is RH-equivalent. No finite positivity principle compares the signed
kernel in (11) with (12): they use different coefficients and the Green
maximum kernel is still present after summing (11) over horizons.

This sharply separates a Goldbach candidate from a Goldbach solution. Any
proof of (13) must introduce a genuine comparison between additive Möbius
correlations and positive von Mangoldt correlations; merely replacing the
former by the latter assumes the conclusion.

## Three equivalent targets and the obstruction

Up to harmless logarithms and an epsilon adjustment, each of the following
all-epsilon families is equivalent to the centered Abel-Mertens criterion:

1. successor observability (6);
2. complete-history observability (10);
3. positive Goldbach domination (13).

They are structurally different possible proof routes, but none is currently
an unconditional weakening. Their exact finite identities explain what a
successful argument must add:

* the successor route needs cancellation of inherited boundary states;
* the history route needs a stable inverse from multiplicative observations
  to additive prefixes;
* the Goldbach route needs a signed-to-positive additive comparison.

The adversarial constant-innovation sequence falsifies the first route for
generic coefficients. Aligned divisor histories falsify an abstract
isometry in the second. Replacing `mu(a)mu(b)` by its absolute value in (11)
falsifies the third by returning the trivial `X^2` prefix scale. These
failures occur before any analytic continuation claim.

## Lean scope

`CenteredConsumerStructuralFinite.lean` proves the actual weighted-Mobius
successor recursion, scaled clock recursion, exact horizon and dyadic splits,
the complete-history identity `mu * log = Lambda`, the additive prefix-square
identity, positivity and square structure of the complete Goldbach mass, and
the abstract positive-observability consumer. It introduces no new axiom or
analytic estimate.
