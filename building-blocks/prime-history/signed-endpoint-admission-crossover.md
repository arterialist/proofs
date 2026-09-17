# Signed endpoint admission and the near-complete crossover

## Result

Let `p` be the newly admitted prime, let

\[
 D=(p^-)^\#=\prod_{\ell<p}\ell,
 \qquad q=e^{-2/X},\qquad r=q^p=e^{-2p/X},
\]

and assume `p<(1-eta)log X`, so `pD<X` for large `X`.  The endpoint packet
added at `p` is

\[
 W_{X,p}(j)=-q^{-j/2}
 \sum_{\substack{e\mid D\\pe\ge j}}\mu(e)q^{pe}.                      \tag{1}
\]

All Möbius orientations, integer cutoffs, and the last divisor `D` are
present in (1).

Evaluating the cross with the old nonendpoint constant mode before taking
absolute values improves the corrected sign-transfer range from
`p<(3/5)log X` to

\[
 \boxed{p\le(2/3-\eta)\log X.}                                      \tag{2}
\]

The second-Abel cancellation does not extend (2).  At this scale the endpoint
is in its near-complete Taylor regime, and the surviving first moment is

\[
 \sum_{e\mid D}\mu(e)e=\prod_{\ell<p}(1-\ell).                       \tag{3}
\]

It is nonzero and has alternating primorial parity.  Beyond `2/3`, fixed-
profile sign transfer requires a new correlation between this explicit term
and `T(p)`.  The available one-point Mertens estimates do not supply it.

## Exact endpoint increment

Let `Z` be the old normalized nonendpoint row, `Delta Z` its prime-admission
increment, `E` the old normalized endpoint, and `W` the normalized version of
(1), including its factor `L/X`, where `L=log X`.  Direct expansion gives

\[
\begin{aligned}
 &\{\|Z+\Delta Z+E+W\|^2-\|Z+E\|^2\}
 -\{\|Z+\Delta Z\|^2-\|Z\|^2\}\\
 &\quad=2\langle Z,W\rangle
 +2\langle\Delta Z,E\rangle
 +2\langle\Delta Z,W\rangle
 +2\langle E,W\rangle+\|W\|^2.                                    \tag{4}
\end{aligned}
\]

No cross term is assigned a sign or discarded.

## Exact dilation to the smaller horizon

Put `Y=X/p`.  If

\[
 A(k)=\sum_{\substack{e\mid D\\e\ge k}}\mu(e)r^e,
\]

then `ceil(j/p)=k` exactly on

\[
 p(k-1)<j\le pk.
\]

Grouping these literal integer blocks gives

\[
\begin{aligned}
 \|W_{X,p}^{\rm raw}\|_{G,X}^2
 &=(1-q)\sum_{j\ge1}q^{-j}|A(\lceil j/p\rceil)|^2\\
 &=(1-q^p)\sum_{k\ge1}q^{-pk}|A(k)|^2.                              \tag{5}
\end{aligned}
\]

The last line is exactly the endpoint norm at horizon `Y`, cutoff `p^-`, and
Abel ratio `r`.  Thus prime dilation is an isometry after the natural Green
normalization.  There is no sampling loss in (5).

The second-Abel theorem applies to this separated horizon.  It gives useful
levelwise endpoint decay, but an individual admission must be compared with
the much smaller margin `e^(-2p)p^(delta-1)`.  That comparison is decided by
the cross term below.

## Constant-mode collapse

For `0<j/X<1`, every divisor profile and every actual rough-source row has a
lower cutoff independent of `j`; the ceiling condition is still literal, but
`j/d<X` for every `d>=1`.  Hence the complete old normalized nonendpoint row,
including its density correction and assembled remainder, is exactly

\[
 Z_{X,p^-}(j)=a_{X,p^-}q^{-j/2},
 \qquad a_{X,p^-}=-\kappa_{p^-}+O(1/L).                               \tag{6}
\]

For its limiting main profile,

\[
 F_{p^-}(j/X)=\kappa_{p^-}q^{-j/2},
 \qquad
 \kappa_{p^-}=\frac12\sum_{d\mid D}\frac{\mu(d)e^{-2d}}d.             \tag{7}
\]

The constants `kappa_(p^-)` converge to a positive limit.  Since the support
of (1) ends at `pD<X`, both formulas hold on the entire endpoint support.

Use the old model row `Z=-F_(p^-)`.  Reversing the finite triangular sum,

\[
 (1-q)\sum_{j=1}^{pe}q^{-j}=q^{-pe}-1.                               \tag{8}
\]

Since `sum_(e|D) mu(e)=0`, equations (1), (6), and (8) give the exact collapse

\[
 \boxed{
 2\langle Z_{X,p^-},W\rangle_{G,X}
 =2a_{X,p^-}\frac LX Z_D(r),}
 \qquad
 Z_D(r)=\sum_{e\mid D}\mu(e)r^e.                                   \tag{9}
\]

Thus the collapse is exact for the actual row, not only for its limiting
Green model.  Substituting `a_(X,p^-)=-kappa_(p^-)+O(1/L)` recovers the main
coefficient below; the correction changes it only by a relative `O(1/L)`.

This is an additive Abel polynomial.  It is not the false product
`product_(ell<p)(1-r^ell)`.

## Near-complete Taylor term

Because `(1-r)D<=2pD/X=o(1)`, Taylor expansion is uniform over every divisor
of `D`:

\[
 Z_D(r)=-(1-r)\sum_{e\mid D}\mu(e)e
 +O\!\left((1-r)^2\sum_{e\mid D}e^2\right).                          \tag{10}
\]

The two finite products are exact:

\[
 \sum_{e\mid D}\mu(e)e=\prod_{\ell<p}(1-\ell),
 \qquad
 \sum_{e\mid D}e^2=\prod_{\ell<p}(1+\ell^2).                        \tag{11}
\]

Moreover,

\[
 \log\prod_{\ell<p}(\ell-1)
 =\vartheta(p^-)+\sum_{\ell<p}\log(1-1/\ell)
 =p-\log\log p+O(1)+o(p).                                           \tag{12}
\]

The error in (10) is smaller than its main term by
`O((pD/X)e^(o(p)))`.  Substituting `1-r=2p/X+O(p^2/X^2)` into (9) yields

\[
 \boxed{
 2\langle Z_{X,p^-},W\rangle_{G,X}
 =4\kappa_{p^-}\frac{Lp}{X^2}
   \prod_{\ell<p}(1-\ell)\{1+o(1)\}.}                               \tag{13}
\]

This term retains its sign.  Its parity changes at every prime admission.

## The other endpoint terms

The face norm `q^d-q^(2d)` and `pe<=pD<X` give

\[
 \|W\|_{G,X},\ \|E\|_{G,X}
 \le \exp\{-\tfrac32L+\tfrac12p+o(L)\}.                             \tag{14}
\]

The nonendpoint admission has norm `O(e^(-p)/p)`.  Therefore the last four
terms in (4) are bounded by combinations with exponential sizes

\[
 e^{-3L/2-p/2+o(L)},\qquad e^{-3L+p+o(L)}.                            \tag{15}
\]

Near the new frontier these are smaller than (13).  There is no omitted old
nonendpoint-remainder cross: it is already included exactly in the scalar
`a_(X,p^-)` in (9).  The directly differenced new analytic rows are part of
`Delta Z` and hence occur only in the three smaller terms containing
`Delta Z` in (4).

## Comparison with the oscillatory margin

The magnitude of (13) is

\[
 \exp\{-2L+p+o(L)\}                                                   \tag{16}
\]

up to powers of `L` and `p`.  The fixed-profile oscillatory admission has
magnitude at least

\[
 e^{-2p}p^{\delta-1}
\]

times an unbounded subsequence factor.  Their ratio has exponential part

\[
 \exp\{-2L+3p+o(L)\}.                                                \tag{17}
\]

It tends to zero uniformly in (2).  This proves the improved sign transfer.

For `p>(2/3+eta)L`, the endpoint crossover term is exponentially larger than
the fixed-profile margin.  Its sign is

\[
 \operatorname{sgn}\prod_{\ell<p}(1-\ell)=(-1)^{\pi(p^-)}.           \tag{18}
\]

Thus it cannot be hidden inside an unsigned error estimate.

## Precise obstruction beyond `2/3`

After scaling an admission by `pe^(2p)`, the endpoint term (13) becomes

\[
 4\kappa_{p^-}(-1)^{\pi(p^-)}
 \frac{L p^2e^{2p}}{X^2}
 \prod_{\ell<p}(\ell-1)\{1+o(1)\}.                                  \tag{19}
\]

Fixed-profile sign transfer beyond `2/3` requires control of

\[
 \boxed{
 -T(p)+4\kappa_{p^-}\frac{L p^2e^{2p}}{X^2}
       \prod_{\ell<p}(1-\ell)}                                      \tag{20}
\]

with all smaller row terms restored.  This is a correlation between the
Mertens-derived value `T(p)` and primorial parity at a horizon-dependent
weight.  Landau oscillation of `T(p)` supplies no such correlation.

Equivalently, before Taylor expansion the exact obstruction is the additive
Abel value `Z_D(e^(-2p/X))` in (9).  A claimed improvement must either bound
its correlation with the fixed-profile source or subtract (9) as a new
observable counterterm.  The second-Abel zero moment does neither.

## Adversarial tests

### Second-Abel cancellation

The second-Abel step kills the complete moment
`integral M(u)u^(-2)du`.  Here the support is shorter than the new horizon and
the Abel polynomial is near `r=1`.  Its constant term vanishes, but its first
derivative is the nonzero product (3).  Claiming a second cancellation would
force `product_(ell<p)(1-ell)=0`, which is false.

### Dilation isometry

Equation (5) is exact and useful, but an isometry supplies no favorable sign.
The top interval `D/2<k<=D` contains only the terminal divisor and gives a
positive reserve in the endpoint norm.  Orthogonalizing the divisor faces
would erase this interval.

### Hodge or constant projection

Projection onto the constant mode does not remove the endpoint.  It produces
exactly `Z_D(r)` through (9).  The moving Abel cutoff and the projection do not
commute.

### Cross-term omission

The previous `3/5` estimate used Cauchy on `2<Z,W>`.  Evaluating that cross
term improves the range to `2/3`.  Dropping it would appear still better, but
would delete the dominant signed crossover term (13).

## RH scope

This is a finite partial-admission calculation with `p<log X`.  It neither
controls complete admission nor bounds the weighted Mertens endpoint at
`P=X`.  Formula (20) identifies an additional correlation needed for fixed-
profile sign transfer; it does not estimate that correlation.  No RH result
follows.

## Lean formalization

`EndpointAdmissionIncrementFinite.lean` proves:

1. the exact five-term endpoint increment (4);
2. the finite constant-mode collapse using zero total coefficient mass;
3. the exact Boolean orientation of newly admitted faces; and
4. the five-term Cauchy bound with all endpoint crosses retained.

The module compiles under Lean 4.24 without `sorry`, `admit`, or new axioms.
Printed dependencies are only `propext`, `Classical.choice`, and `Quot.sound`;
the Boolean orientation theorem does not require `Classical.choice`.
