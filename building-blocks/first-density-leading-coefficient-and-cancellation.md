# Leading first-density coefficient and its cancellation

## Result

Let

\[
 C_P=-4\langle F_P,J_P\rangle
\]

be the coefficient of `1/log X` in the simultaneous energy expansion.  At a
natural prime admission,

\[
 \boxed{C_p-C_{p^-}=e^{-2p}\{1+o(1)\}.}                               \tag{1}
\]

The coefficient is positive and equals `1`.  Therefore the finite-horizon
admission has the scaled form

\[
 \boxed{
 pe^{2p}\Delta_{X,p}
 =-T(p)+R_p+\frac p{\log X}\{1+o(1)\}
   +\mathcal R_{X,p}.}                                                \tag{2}
\]

Here `|R_p|<13/6`, and `mathcal R_(X,p)` contains the directly differenced
second-log, PNT, sampling, rough-composite, and endpoint rows.  No sign
relation exists in the current argument between `T(p)` and the positive
density drift.

The sharper coefficient already puts the drift below the known oscillatory
margin in the range below.  Subtracting the exact counterterm `C_P/log X`, or
taking a two-horizon Richardson combination, cancels it identically.  For the
original and corrected observables, both fixed-profile oscillatory signs
transfer in the larger range

\[
 \boxed{p\le(3/5-\eta)\log X}                                        \tag{3}
\]

for every fixed `eta>0`, along the corresponding prime subsequences.  The
constant `3/5` comes from the full growing-divisor endpoint packet.  Thus
counterterm or Richardson cancellation does not pass `3/5` with the current
endpoint input.  The non-endpoint errors alone permit a wider range.

A plain adjacent-prime sum cannot cancel (1), since both leading correction
increments are positive.  A weighted cancellation needs a negative weight
and replaces the known oscillatory source by an uncontrolled linear
combination of `T(p)` and `T(q)`.

## Derivation of the coefficient

Before admitting `p`, put

\[
 U_p^G=\sum_{e\mid(p^-)^\#}\mu(e)G_{pe},\qquad
 U_p^J=\sum_{e\mid(p^-)^\#}\mu(e)J_{pe}.
\]

The exact bilinear increment is

\[
 C_p-C_{p^-}=4\{\langle U_p^G,J_{p^-}\rangle
 +\langle F_{p^-},U_p^J\rangle
 -\langle U_p^G,U_p^J\rangle\}.                                     \tag{4}
\]

All three orientations and the new-new corner remain present.

### The zero mode of `J`

Let

\[
 A(y)=\sum_{d<y}\frac{\mu(d)}d,
 \qquad
 B(y)=\sum_{d<y}\frac{\mu(d)}d\log(y/d).
\]

Classical zero-free Mertens estimates and partial summation give

\[
 A(y)\ll e^{-c\sqrt{\log y}},\qquad
 B(y)=1+O\!\left((1+\log y)^k e^{-c\sqrt{\log y}}\right)              \tag{5}
\]

with fixed positive constants.  The constant in `B` is the derivative of
`1/zeta(s)` at `s=1`.

The exact profile formula is

\[
 J_d(y)=
 \begin{cases}
 e^yE_1(2d)/(2d),&y\le d,\\
 \{e^{-y}\log(y/d)+e^yE_1(2y)\}/(2d),&y>d.
 \end{cases}
\]

Summing it with the actual Möbius coefficients gives

\[
\begin{aligned}
 2e^yJ_\infty(y)={}&B(y)+e^{2y}E_1(2y)A(y)\\
 &+e^{2y}\sum_{d\ge y}\frac{\mu(d)E_1(2d)}d.                         \tag{6}
\end{aligned}
\]

The last term is `O(y^(-2))`, and
`e^(2y)E_1(2y)=O(1/y)`.  Equations (5)-(6) prove

\[
 \boxed{e^yJ_\infty(y)=\frac12+o(1).}                                \tag{7}
\]

No positivity of the individual Möbius faces was used.

### The new `G_p` face

For `y<=p`,

\[
 G_p(y)=\frac1{2p}e^{y-2p}.
\]

The old packet contains every nonzero Möbius coefficient below `p`.  Enlarging
the missing delayed faces to all integers `d>=p` shows that replacing
`J_(p^-)` by `J_infinity` changes

\[
 \int_0^p e^yJ_{p^-}(y)\,dy
\]

by `o(p)`.  Cesaro integration of (7) therefore gives

\[
 \int_0^p e^yJ_{p^-}(y)\,dy=\frac p2+o(p).                            \tag{8}
\]

The tail `y>p` is `o(e^(-2p))` after multiplication by
`G_p(y)=e^(-y)/(2p)`.  Thus

\[
 \langle G_p,J_{p^-}\rangle
 =\frac{e^{-2p}}{2p}\left\{\frac p2+o(p)\right\}
 =\frac14e^{-2p}\{1+o(1)\}.                                         \tag{9}
\]

The cofactor faces `G_(pe)`, `e>=2`, are exponentially smaller.

### The other orientations

The analogous exact formula for `F_infinity` gives

\[
 e^yF_\infty(y)
 =\frac12A(y)+O(1/y).                                                 \tag{10}
\]

For `y<=p`,

\[
 J_p(y)=\frac{e^yE_1(2p)}{2p}
 \ll p^{-2}e^{y-2p}.
\]

Equations (5) and (10), with the delayed-face tail retained, imply

\[
 \langle F_{p^-},U_p^J\rangle=o(e^{-2p}),\qquad
 \langle U_p^G,U_p^J\rangle=o(e^{-2p}).                              \tag{11}
\]

Substitution of (9)-(11) in (4) proves (1), including its sign and factor.

## Comparison with the fixed-profile source

The exact fixed-profile formula is

\[
 pe^{2p}\Delta_p=-T(p)+R_p,
 \qquad |R_p|<13/6.                                                   \tag{12}
\]

Since the simultaneous energy is

\[
 \mathcal E_X(P)=E_P+\frac{C_P}{L}+\text{higher rows},
 \qquad L=\log X,
\]

equation (1) contributes

\[
 pe^{2p}\frac{C_p-C_{p^-}}L
 =\frac pL\{1+o(1)\}.                                                \tag{13}
\]

This proves (2).  On a prime subsequence with
`|T(p)|` of order at least `p^delta` times an unbounded factor, the drift is
smaller when `p^(1-delta)=o(L)`.  This already improves the earlier absolute
bound `p^(2-delta)=o(L)`, even without changing the observable.

The direct component errors from the preceding audit remain smaller in this
range until the endpoint packet becomes relevant.

## Exact counterterm observable

Define

\[
 \widetilde{\mathcal E}_X(P)
 :=\mathcal E_X(P)-\frac{C_P}{L}.                                     \tag{14}
\]

This is explicit: `C_P` is the finite full-face sum of the known kernels
`G_d` and `J_e`.  Differencing (14) cancels `(C_p-C_(p^-))/L` exactly.  It
does not rely on the asymptotic (1) or its sign.

The remaining non-endpoint increment errors are

\[
 e^{-2p}O\!\left(p^2/L^2+p^2Le^{-c\sqrt L}\right)
 +O\!\left(e^{-p}/(pX)+Le^{-p}/X+Le^{-pX}\right).                    \tag{15}

For every fixed `c<1`, these are smaller than the oscillatory margin when
`p<=cL`.

## Two-horizon Richardson observable

Fix `a>1` and compare horizons `X` and `X^a`, whose logarithms are `L` and
`aL`.  Put

\[
 \mathcal R_{X,a}(P)
 :=\frac{a\mathcal E_{X^a}(P)-\mathcal E_X(P)}{a-1}.                  \tag{16}
\]

The fixed profile has coefficient `1`, while

\[
 \frac1{a-1}\left\{a\frac{C_P}{aL}-\frac{C_P}{L}\right\}=0.          \tag{17}
\]

Thus (16) cancels the first density correction without evaluating `C_P`.
Both endpoint packets, both moving ceilings, and both sampling lattices remain
in the remainder.  Since `a` is fixed, the smaller horizon `X` determines the
uniform range.

## Endpoint range for the corrected observables

For `p=cL` with fixed `c<1`, every old divisor satisfies

\[
 e\le(p^-)^\#=\exp\{\vartheta(p^- )\}=\exp\{p+o(p)\}<X.
\]

The exact endpoint face norm gives

\[
 \|v_{pe}\|_{G,X}^2=q^{pe}-q^{2pe}\le 2pe/X.
\]

Consequently the normalized newly admitted endpoint packet satisfies

\[
\begin{aligned}
 \xi_{X,p}
 &\le \frac LX\sqrt{\frac{2p}{X}}
   \sum_{e\mid(p^-)^\#}\sqrt e\\
 &=\frac LX\sqrt{\frac{2p}{X}}
   \prod_{\ell<p}(1+\sqrt\ell)\\
 &=\exp\{-\tfrac32L+\tfrac12p+o(L)\}.                               \tag{18}
\end{aligned}
\]

After division by the fixed-profile margin
`e^(-2p)p^(delta-1)`, the exponential part is

\[
 \exp\{-\tfrac32L+\tfrac52p+o(L)\}.                                 \tag{19}
\]

It tends to zero uniformly for `p<=(3/5-eta)L`.  The old endpoint and every
cross term obey the same bound after polarization.  Equations (15) and
(18)-(19) prove (3) for both corrected observables.

This `3/5` is a rigorous sign-free endpoint frontier for the local increment,
not a claim that the actual signed endpoint becomes large immediately after
it.  Improving it requires signed control of the new endpoint packet at the
exponentially small admission scale.

## Adjacent-prime pairing

Let `q` be the prime after `p`.  Equation (1) gives

\[
 (C_p-C_{p^-})+(C_q-C_{q^-})
 =e^{-2p}\{1+o(1)\}+e^{-2q}\{1+o(1)\}>0                              \tag{20}
\]

for large `p`.  An unweighted pair reinforces the drift.

Weights `w_p,w_q` cancel the leading terms only if

\[
 w_q=-w_p e^{2(q-p)}\{1+o(1)\}.                                     \tag{21}
\]

The paired fixed source then becomes

\[
 -w_p\frac{e^{-2p}}pT(p)
 -w_q\frac{e^{-2q}}qT(q),                                            \tag{22}
\]

which is an opposite-sign combination of two unrelated Mertens values.
Landau oscillation supplies no lower bound or sign for (22).  Prime gaps also
make the weight in (21) nonuniform.  Adjacent pairing therefore produces no
rigorous sign transfer beyond the corrected observables above.

## Conceptual tests

### Counterterm subtraction

This is exact finite renormalization.  It removes the known mixed-density
coefficient before taking an admission difference.  Subtracting only the
leading approximation `e^(-2p)/L` is weaker and must retain the quantitative
error in (1).

The counterterm does change the observable.  A sign theorem for
`tilde(mathcal E)` is not automatically a sign theorem for the original
finite energy.

### Richardson cancellation

The two clocks see the same fixed profile and the same `C_P`, with reciprocal
logarithmic coefficients.  This makes (17) algebraic rather than asymptotic.

The endpoint and sampling rows depend on the horizon and do not cancel by
(17).  Keeping both is what limits the proved range to (3).  Treating them as
common errors would be false.

### Adjacent-prime coboundary

Admission pairing is local in the Boolean divisor cube, but the leading
density faces at consecutive primes have the same orientation.  There is no
coboundary cancellation in an unweighted sum.

Forcing cancellation with a negative weight also cancels the only source for
which an oscillation theorem is known separately.  It trades a controlled
drift for an uncontrolled two-point Möbius correlation.

### Endpoint zero mode

The second-Abel endpoint theorem cancels a complete Mertens moment over a long
cofactor interval.  The density coefficient in (4) is a mixed Green inner
product and has the nonzero limit (1).  Applying the endpoint zero-moment
argument to it would contradict the computed coefficient.

## RH scope

The corrected observables give a larger finite-horizon sign-transfer range,
but they do not estimate complete admission `P=X`.  The exact counterterm and
Richardson combination remove a known prime-density artifact; neither bounds
the remaining full endpoint Mertens prefix.  Adjacent pairing exposes a new
two-point correlation rather than proving it.  No RH implication follows.

## Lean formalization

[FirstDensityCorrectionCancellationFinite.lean](BuildingBlocks/FirstDensityCorrectionCancellationFinite.lean) proves:

1. exact level-counterterm cancellation in an admission difference;
2. exact two-horizon Richardson cancellation;
3. the scaled leading-coefficient algebra behind (13);
4. positivity of an unweighted sum of same-sign drifts; and
5. the unique opposite-sign weight relation needed for pair cancellation.

The module compiles under Lean 4.24 without `sorry`, `admit`, or new axioms.
Every printed theorem depends only on `propext`, `Classical.choice`, and
`Quot.sound`.
