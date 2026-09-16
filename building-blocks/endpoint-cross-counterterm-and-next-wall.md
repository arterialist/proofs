# Endpoint Abel counterterm and the next admission wall

## Result

Let `p` be the newly admitted prime, `D=(p^-)#`, `q=e^(-2/X)`, and
`L=log X`.  The preceding crossover theorem identifies the exact dominant
endpoint cross

\[
 B_{X,p}:=2\langle Z_{X,p^-},W_{X,p}\rangle_{G,X}
 =2a_{X,p^-}\frac LX Z_D(q^p),                                      \tag{1}
\]

where

\[
 Z_D(r)=\sum_{e\mid D}\mu(e)r^e,
 \qquad a_{X,p^-}=-\kappa_{p^-}+O(1/L).
\]

Subtracting (1) from the admission is a legitimate finite counterterm.  It
defines a new observable; it is not a statement about the sign of the
original energy.  For this cross-corrected observable, the fixed-profile
prime signs transfer throughout

\[
 \boxed{p\le(1-\eta)\log X}                                         \tag{2}
\]

for every fixed `eta>0`, along the known positive and negative prime
subsequences.

The next wall is at `p~log X`.  It comes from the endpoint quadratic

\[
 2\langle E_{X,p^-},W_{X,p}\rangle+\|W_{X,p}\|^2,
\]

equivalently from a weighted square of smooth Möbius tails.  Its terminal
largest-divisor interval is positive and cannot be canceled by the one-point
second-Abel zero moment.

A two-horizon combination that cancels the exact first Taylor coefficient of
(1), including the horizon-dependent scalar `a_(X,p)log X`, extends the
uncorrected `2/3` frontier to `3/4`.  Weights based only on `X^(-2)` leave a
relative `O(1/log X)` mismatch at the original exponential scale and do not
pass `2/3`.  Canceling (1) exactly at two horizons requires the actual values
`Z_D(q_1^p)` and `Z_D(q_2^p)` in the weights.  Algebraically, that is the same
information as evaluating and subtracting (1); it is not a source-free
Richardson improvement.

## Exact cross-corrected increment

Write the old nonendpoint row as `Z`, its admission as `Delta Z`, the old
endpoint as `E`, and the new endpoint packet as `W`.  The full endpoint
contribution is

\[
\begin{aligned}
 \mathcal I_{X,p}={}&2\langle Z,W\rangle
 +2\langle\Delta Z,E\rangle+2\langle\Delta Z,W\rangle\\
 &+2\langle E,W\rangle+\|W\|^2.                                    \tag{3}
\end{aligned}
\]

Define

\[
 \widetilde{\mathcal I}_{X,p}
 :=\mathcal I_{X,p}-B_{X,p}.                                        \tag{4}
\]

Since `B_(X,p)=2<Z,W>` exactly, not asymptotically,

\[
 \boxed{
 \widetilde{\mathcal I}_{X,p}
 =2\langle\Delta Z,E\rangle+2\langle\Delta Z,W\rangle
  +2\langle E,W\rangle+\|W\|^2.}                                   \tag{5}
\]

Every old/new endpoint orientation remains in (5).

## Bounds below the primorial crossover

Assume `p=cL` with fixed `c<1`.  Then

\[
 pD=X^{c+o(1)}<X,
\]

so every endpoint face stays on its small-argument branch.  The exact face
norm and the divisor product give

\[
 \|E\|,\|W\|
 \le \exp\{-\tfrac32L+\tfrac12p+o(L)\}.                              \tag{6}
\]

The nonendpoint admission has global norm `O(e^(-p)/p)`.  Therefore

\[
 |\langle\Delta Z,E\rangle|+|\langle\Delta Z,W\rangle|
 \le \exp\{-\tfrac32L-\tfrac12p+o(L)\},                              \tag{7}
\]

and

\[
 |2\langle E,W\rangle+\|W\|^2|
 \le \exp\{-3L+p+o(L)\}.                                            \tag{8}
\]

Relative to the fixed-profile oscillatory margin
`e^(-2p)p^(delta-1)`, the exponential ratios in (7)-(8) are

\[
 \exp\{-\tfrac32L+\tfrac32p+o(L)\},
 \qquad
 \exp\{-3L+3p+o(L)\}.                                                \tag{9}
\]

Both tend to zero uniformly in (2).  The directly differenced nonendpoint
rows and sampling term obey the same `c<1` restriction.  This proves the
cross-corrected transfer range.

## The terminal quadratic reserve

At the original horizon, retain `q=e^(-2/X)` and put

\[
 A_-(k)=\sum_{\substack{e\mid D\\e\ge k}}\mu(e)q^e,
 \qquad
 A_p(k)=A_-(k)-\sum_{\substack{e\mid D\\pe\ge k}}\mu(e)q^{pe}.
\]

The endpoint-only admission is the exact weighted two-point expression

\[
 (1-q)\sum_{k\ge1}q^{-k}
 \{|A_p(k)|^2-|A_-(k)|^2\}.                                         \tag{10}
\]

This is the Möbius correlation left in (5).  It contains every diagonal and
ordered cross term.

Let `D_2` be the second-largest divisor of `pD`.  On

\[
 D_2<k\le pD,
\]

the new tail consists only of the largest divisor `pD`, whose Möbius
coefficient has absolute value one.  Hence this interval contributes exactly

\[
 (1-q)\sum_{D_2<k\le pD}q^{-k}q^{2pD}>0.                             \tag{11}
\]

For a primorial, `D_2=pD/2`, so the interval has length `pD/2`.  In the
small-argument regime, `(1-q)~2/X` and every displayed power of `q` in
(11) is `1+o(1)`.  Thus (11) has raw scale `pD/X`; multiplying by the
endpoint normalization `(L/X)^2` gives

\[
 \frac{L^2pD}{X^3}=\exp\{-3L+p+o(L)\}.                               \tag{12}
\]

This meets the fixed-profile scale `e^(-2p)` at `p=L`.  The reserve proves
that a generic signed-tail norm estimate cannot move the wall past `1`.
Cancellation with the remaining part of (10) would be a new two-point
Möbius theorem, not a consequence of the second-Abel first moment.

## Two-horizon first-Taylor cancellation

Take horizons `X` and `rho X`, with fixed `rho>1`.  The first crossover term
has the Taylor expansion

\[
 B_{X,p}=2a_{X,p}L\left\{
 -\frac{2pS_1}{X^2}+O\!\left(\frac{p^2S_2}{X^3}\right)\right\}
 =-4a_{X,p}\frac{LpS_1}{X^2}
  +O\!\left(|a_{X,p}|\frac{Lp^2S_2}{X^3}\right).                  \tag{13}
\]

\[
 S_1=\prod_{\ell<p}(1-\ell),
 \qquad |S_2|\le\prod_{\ell<p}(1+\ell^2)=e^{2p+o(p)}.
\]

Here `a_(X,p)` abbreviates the old-row scalar `a_(X,p^-)` in (1).  Since
`a_(X,p)=-kappa_(p^-)+O(1/L)`, the leading term in (13) is
`+4 kappa_(p^-) LpS_1/X^2`, in agreement with the one-horizon crossover.

Choose the two horizon weights to preserve the fixed profile and cancel the
exact coefficients

\[
 s_{X,p}:=a_{X,p}\frac{L}{X^2},
 \qquad
 s_{\rho X,p}:=a_{\rho X,p}\frac{\log(\rho X)}{(\rho X)^2}.           \tag{14}
\]

Thus `w_1+w_2=1` and
`w_1s_(X,p)+w_2s_(rho X,p)=0`.  With these arithmetic-dependent weights, the
residual crossover has scale

\[
 \frac{Lp^2e^{2p+o(p)}}{X^3}.                                       \tag{15}
\]

Against `e^(-2p)`, this gives the wall

\[
 -3L+4p<0,
 \qquad p<(3/4-\eta)L.                                               \tag{16}
\]

Thus exact first-coefficient cancellation improves `2/3` to `3/4`, but is
weaker than exact subtraction of (1).

Fixed weights using only the ratio `rho^(-2)` leave

\[
 \{a_{\rho X,p}\log(\rho X)-a_{X,p}L\}\frac{pS_1}{X^2}.             \tag{17}
\]

The known row expansion controls the braces only to relative order `O(1/L)`.
That logarithmic saving does not alter the exponential comparison
`exp(-2L+3p)`, so these source-free weights remain at the `2/3` frontier.

For exact cancellation at two arbitrary horizons, let their crossover
coefficients be `b_1,b_2`.  Weights preserving the fixed profile must sum to
one, and canceling the cross requires

\[
 w_1b_1+w_2b_2=0.
\]

When `b_1!=b_2`, the unique solution is

\[
 w_1=\frac{b_2}{b_2-b_1},
 \qquad w_2=-\frac{b_1}{b_2-b_1}.                                   \tag{18}
\]

These weights depend on the actual additive Abel values.  They may be large
when the values are close or vanish.  Exact two-horizon cancellation therefore
does not avoid the arithmetic input in (1).

## Precise obstruction after the counterterm

Beyond `p~L`, transfer requires control of the signed difference (10) jointly
with the fixed-profile source.  In scaled form the unresolved object is

\[
 -T(p)+pe^{2p}\frac{L^2}{X^2}(1-q)
 \sum_{k\ge1}q^{-k}\{|A_p(k)|^2-|A_-(k)|^2\}.                        \tag{19}
\]

This is a weighted two-point friable Möbius correlation.  A pointwise bound
for `M(t,p)` or the complete zero moment
`integral M(u)u^(-2)du=0` does not determine its sign.  The positive terminal
reserve (11) also rules out deleting it as a lower-order boundary artifact.

One may subtract the entire expression (10), but then the observable has had
the full endpoint admission removed.  That is an algebraic redefinition, not
a theorem about the original energy.

## Adversarial checks

1. **Counterterm legitimacy.** Equation (1) is a finite, computable function
   of the actual packet.  Subtracting it is valid, but conclusions apply to
   the cross-corrected observable only.
2. **Two-horizon stability.** Geometric fixed weights do not cancel the
   horizon-dependent scalar.  First-Taylor cancellation needs the exact
   coefficients (14), while full cancellation needs the Abel-dependent
   weights (18).
3. **Terminal reserve.** The top interval in (11) has one live face, so neither
   Möbius orientation nor block orthogonality can cancel it internally.
4. **Second-Abel scope.** Second Abel controls a linear prefix.  Equation (10)
   is quadratic and retains off-diagonal two-point data.

## RH scope

The exact counterterm extends a modified admission sign observable to
`p<(1-eta)log X`.  It does not control the original endpoint quadratic at the
primorial crossover or complete admission.  The remaining two-point estimate
is not proved here and no RH implication follows.

## Lean formalization

[EndpointCrossCountertermFinite.lean](BuildingBlocks/EndpointCrossCountertermFinite.lean)
proves the exact four-term remainder after cross subtraction, the endpoint
quadratic admission, arbitrary two-horizon common-source cancellation, and
the positive terminal-square reserve.  It introduces no analytic axiom.
