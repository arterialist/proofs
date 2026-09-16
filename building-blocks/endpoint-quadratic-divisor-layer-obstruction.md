# Endpoint quadratic by exact divisor layers

## Verdict

Let `p` be the newly admitted prime, `D=(p^-)#`, `q=e^(-2/X)`, and
`L=log X`.  After subtracting the exact old-nonendpoint/new-endpoint Abel
cross, the remaining endpoint quadratic is

\[
 \mathcal Q_{X,p}
 :=2\langle E_{X,p^-},W_{X,p}\rangle+\|W_{X,p}\|^2.                 \tag{1}
\]

Expanding (1) by literal divisor layers gives an exact ordered two-point
Möbius sum.  The positive largest-divisor interval is only one summand of
that expression.  Lower intervals contain both orientations of the old/new
cross and the off-diagonal new/new terms, so neither positivity nor a
one-variable second-Abel estimate controls their cancellation.

No wider sign-transfer range follows from the present inputs.  Removing the
endpoint-quadratic obstruction at the crossover `p~L` requires the weighted
two-point estimate (18) below.  At the same crossover, the previously smaller
terms containing the nonendpoint admission `Delta Z` also lose their fixed
`eta` exponential margin.  Thus (18) is the exact missing endpoint-quadratic
input, not by itself a theorem beyond `p=L`.  It is stronger than the
available levelwise endpoint decay and is not supplied by LCM grouping or by
the complete-admission centered identity.

## Exact kernel and layer expansion

For positive integers `x,y`, put

\[
 G_q(x,y):=q^{\max(x,y)}-q^{x+y}.                                   \tag{2}
\]

The endpoint face at location `x` has Gram pairing `G_q(x,y)` with the face
at `y`.  This follows from the exact finite reversal

\[
 (1-q)q^{x+y}\sum_{1\le k\le\min(x,y)}q^{-k}
 =q^{\max(x,y)}-q^{x+y}.                                            \tag{3}
\]

Write

\[
 A_-(k)=\sum_{\substack{d\mid D\\d\ge k}}\mu(d)q^d,
 \qquad
 B_p(k)=\sum_{\substack{e\mid D\\pe\ge k}}\mu(e)q^{pe}.
\]

The new endpoint is `A_p=A_--B_p`.  Consequently

\[
 \mathcal Q_{X,p}^{\rm raw}
 =(1-q)\sum_{k\ge1}q^{-k}
 \{B_p(k)^2-2A_-(k)B_p(k)\}.                                      \tag{4}
\]

Reversing every finite tail gives

\[
\boxed{\begin{aligned}
 \mathcal Q_{X,p}^{\rm raw}
={}&\sum_{e,f\mid D}\mu(e)\mu(f)G_q(pe,pf)\\
 &-2\sum_{d,e\mid D}\mu(d)\mu(e)G_q(d,pe).
\end{aligned}}                                                     \tag{5}
\]

Both sums in (5) are ordered.  In particular, no off-diagonal orientation
has been folded into a diagonal or assigned a sign.  Splitting at the
literal order break gives

\[
 G_q(d,pe)=
 \begin{cases}
 q^{pe}(1-q^d),&d\le pe,\\
 q^d(1-q^{pe}),&d>pe.
 \end{cases}                                                       \tag{6}
\]

The self-layer has the analogous formula

\[
 G_q(pe,pf)=q^{p\max(e,f)}(1-q^{p\min(e,f)}).                       \tag{7}
\]

Equations (5)--(7) are the requested divisor-layer expansion with every
Möbius sign and integer order boundary retained.

## What happens to the terminal reserve

Let `D_2` be the second-largest divisor of `pD`.  Since `p>2`, for a
primorial `D_2=pD/2>D`.  On the literal interval

\[
 D_2<k\le pD,                                                       \tag{8}
\]

the old tail vanishes and the new tail consists only of the coefficient
`mu(pD)q^(pD)`.  Thus (4) contains the exact positive piece

\[
 R_{X,p}^{\rm top}
 =(1-q)\sum_{D_2<k\le pD}q^{-k}q^{2pD}>0.                           \tag{9}
\]

This positivity is local to (8).  On `k<=D_2`, the new tail has several
oppositely signed divisor faces and the old tail is generally nonzero.  The
rest of (4) is

\[
 (1-q)\sum_{k\le D_2}q^{-k}
 \{B_p(k)^2-2A_-(k)B_p(k)\},                                      \tag{10}
\]

which has no fixed sign.  Therefore (9) cannot be promoted to a lower bound
for the whole admission without proving a bound on (10).  Such a bound is
already the two-point problem in (5); deleting (10) would omit actual
ordered pairs.

## Why second Abel does not close the square

The Stieltjes formula expresses each tail linearly through the smooth
Mertens prefix `M(t,p^-)`.  Applying it to both factors in (4) produces a
double Stieltjes integral of the form

\[
 \iint K_{X,p}(u,v)M(u,p^-)M(v,p^-)\,du\,dv                         \tag{11}
\]

together with the literal left endpoints.  The second-Abel identity

\[
 \int_1^\infty M(u)u^{-2}\,du=0                                   \tag{12}
\]

cancels a one-variable constant mode before absolute values are taken.  It
does not cancel (11): the kernel is not a rank-one constant, and the two
Mertens factors share the same divisor packet.  Applying (12) in one
variable leaves the variation of `K_(X,p)(u,v)` coupled to the other Mertens
factor.  Bounding that remainder is precisely a weighted two-point Mertens
estimate.

The existing second-Abel theorem bounds the endpoint level.  Subtracting two
such level bounds gives no estimate at the exponentially smaller scale of a
single prime admission.

## Why LCM grouping does not diagonalize (5)

The kernel in (5) depends on the ordinary order statistic `max(d,pe)`.
An LCM class does not determine that statistic.  Already

\[
 \operatorname{lcm}(1,6)=\operatorname{lcm}(2,3)=6,
 \qquad \max(1,6)=6,\quad\max(2,3)=3.                              \tag{13}
\]

Thus two pairs in one LCM class carry different radial weights.  Complete
hard-clock LCM coefficients cannot be imported into (5) without a distortion
remainder, and that remainder contains the same signed two-point sum.

## Exact centered decomposition

For any finite coefficient packet `c_n`, define its Abel total and strict
prefix by

\[
 C=\sum_n c_n,
 \qquad P_c(k)=\sum_{n<k}c_n.
\]

Its tail is exactly `C-P_c(k)`.  If `b` is the newly admitted packet, with
total `B` and prefix `P_b`, then pointwise

\[
\begin{aligned}
 &(C+B-P_c-P_b)^2-(C-P_c)^2\\
={}&(2CB+B^2)
 -2\{BP_c+CP_b+BP_b\}
 +\{2P_cP_b+P_b^2\}.                                               \tag{14}
\end{aligned}
\]

After summing with `(1-q)q^(-k)`, the last braces are exactly the increment
of the centered-prefix energy.  They retain the ordered two-point
correlation.  The first two braces expose the Abel common mode, but knowing
or subtracting them does not determine the last braces.

At complete admission, this centered-prefix energy is comparable to the
mean square of the ordinary Mertens function.  Telescoping all prime
admissions recovers the final centered energy, but it gives no sign or small
bound for an individual increment.  The complete-admission identity
therefore identifies the obstruction; it does not remove it.

## The precise missing estimate

The normalized endpoint term in the prime admission is

\[
 \mathcal Q_{X,p}=\left({L\over X}\right)^2
 \mathcal Q_{X,p}^{\rm raw}.                                      \tag{15}
\]

The fixed-profile oscillatory margin is

\[
 e^{-2p}p^{\delta-1}.                                               \tag{16}
\]

Hence the endpoint quadratic is negligible compared with the fixed-profile
margin only if one proves the uniform estimate

\[
 \boxed{
 |\mathcal Q_{X,p}^{\rm raw}|
 =o\!\left({X^2e^{-2p}p^{\delta-1}\over L^2}\right).}              \tag{17}
\]

Using (5), this is the explicit weighted two-point Möbius requirement

\[
\boxed{\left|
 \sum_{e,f\mid D}\mu(e)\mu(f)G_q(pe,pf)
 -2\sum_{d,e\mid D}\mu(d)\mu(e)G_q(d,pe)
 \right|
 =o\!\left({X^2e^{-2p}p^{\delta-1}\over L^2}\right).}             \tag{18}
\]

For `p=cL`, the right side has exponential scale `X^(2-2c)`.  At `c=1`
it has only a negative power of `L` for the usual fixed-profile exponents.
The current endpoint-level estimates are much larger and do not imply (18).

The subsequent
[first-branch audit](mixed-endpoint-first-branch-abel-collapse.md) evaluates
`2<Delta Z,E>+2<Delta Z,W>` before Cauchy.  As long as `D<=X`, those terms
collapse to `2b_(X,p)(L/X){Z_D(q^p)-Z_D(q)}` and remain negligible at the
crossover.  Once `D>X`, their explicit post-branch wedge is another weighted
two-point divisor correlation.  A theorem beyond the wall therefore needs
both (18) and control of that post-branch correlation; the former Cauchy
estimate was not sharp on the complete first branch.

Subtracting the whole quantity (5) would define another exact modified
observable, but that operation removes the object whose arithmetic size is
in question.  It gives no theorem for the original or the once-corrected
admission.  Without (18), the proved ranges therefore remain `2/3` for the
original observable and every fixed `1-eta` for the Abel-cross-corrected
observable.

## Formal finite scope

[EndpointQuadraticLayerFinite.lean](BuildingBlocks/EndpointQuadraticLayerFinite.lean)
proves the arbitrary weighted tail-pair reversal, the exact ordered
divisor-layer expansion, the endpoint square increment, tail-minus-total
centering, and (14).  The module uses actual finite index sets and introduces
no analytic or sign hypothesis.  Its printed dependencies are only
`propext`, `Classical.choice`, and `Quot.sound`.

The missing statement is the analytic estimate (18).  No RH conclusion or
unproved positivity is asserted.
