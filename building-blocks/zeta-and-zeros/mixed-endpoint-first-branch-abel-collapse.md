# Mixed endpoint terms before Cauchy

## Result

Let `p` be newly admitted, `D=(p^-)#`, `q=e^(-2/X)`, and `L=log X`.
After subtracting the old-nonendpoint/new-endpoint cross, the two mixed terms
containing the nonendpoint admission are

\[
 2\langle\Delta Z,E\rangle+2\langle\Delta Z,W\rangle
 =2\langle\Delta Z,E+W\rangle.                                    \tag{1}
\]

Before Cauchy, (1) has an exact Abel-polynomial collapse on the complete
first branch.  The correct branch condition is

\[
 \boxed{D\le X,}                                                    \tag{2}
\]

which is weaker than the earlier sufficient condition `pD<X`.  Under (2),
every newly admitted nonendpoint face stays on its first branch throughout
the full endpoint support.  If

\[
 \Delta Z(j)=b_{X,p}q^{-j/2}\qquad(1\le j\le pD),                   \tag{3}
\]

then the exact mixed sum is

\[
\boxed{
 2\langle\Delta Z,E+W\rangle
 =2b_{X,p}{L\over X}\{Z_D(q^p)-Z_D(q)\},}                          \tag{4}
\]

where `Z_D(r)=sum_(e|D) mu(e)r^e`.  No endpoint orientation is omitted.

The first nonzero moment of (4) is the primorial first moment, multiplied by
`p-1`.  In the uniform Taylor region `pD=o(X)`,

\[
 Z_D(q^p)-Z_D(q)
 =-{2(p-1)\over X}\prod_{\ell<p}(1-\ell)
 +O\!\left({p^2\over X^2}\prod_{\ell<p}(1+\ell^2)\right).          \tag{5}
\]

This term is far smaller than the fixed-profile admission throughout its
domain.  Thus the mixed terms do not create an additional wall on the
`D<=X` side of `p~log X`.  Once `D>X`, the post-branch wedge is an exact
ordered two-point divisor correlation.  Subtracting it defines another
observable but does not bound the endpoint quadratic, so no wider complete
sign-transfer range follows.

## Why the complete endpoint support is still a first branch

The continuous prime profile is

\[
 G_d(y)=
 \begin{cases}
 e^{y-2d}/(2d),&y\le d,\\
 e^{-y}/(2d),&y>d.
 \end{cases}                                                       \tag{6}
\]

The first density profile and every higher logarithmic profile have the same
lower-limit geometry: on `y<=d` they equal `e^y` times a scalar depending on
`d`.  The PNT and closed-lower-atom rows also retain this common sampled
factor before their moving lower limit changes.

A newly admitted face has index `d=pe`, `e|D`.  The endpoint after admission
is supported on `j<=pD`.  If `D<=X` and `e>=1`, then

\[
 j\le pD\le pX\le Xpe.                                              \tag{7}
\]

Hence `y=j/X<=pe`, proving (3) simultaneously for every new face and every
endpoint index.  The common scalar `b_(X,p)` includes the main, density,
second-log, PNT, sampling, lower-atom, and rough-source coefficients; (4)
uses no asymptotic description of that scalar.

For the continuous main row specifically,

\[
 b^{G}_{p}
 ={1\over2p}\sum_{e\mid D}{\mu(e)\over e}e^{-2pe}
 ={e^{-2p}\over2p}\{1+O(e^{-2p})\}.                               \tag{8}
\]

The first density contribution has first-branch scalar

\[
 b^{J}_{p}
 ={1\over2p}\sum_{e\mid D}{\mu(e)\over e}E_1(2pe)
 =O(e^{-2p}/p^2).                                                    \tag{9}
\]

With the row convention `-F+J/L+R`, the admitted scalar begins
`b^G_p-b^J_p/L`; the remaining component scalars keep their literal signs.

## Exact Abel reversal

The endpoint after admission is

\[
 (E+W)(j)={L\over X}q^{-j/2}
 \sum_{\substack{n\mid pD\\n\ge j}}\mu(n)q^n.                     \tag{10}
\]

Insert (3) and reverse the finite triangular sum.  For each `n`,

\[
 (1-q)\sum_{j=1}^nq^{-j}=q^{-n}-1.                                 \tag{11}
\]

Since `sum_(n|pD)mu(n)=0`, equations (10)--(11) give

\[
 2\langle\Delta Z,E+W\rangle
 =-2b_{X,p}{L\over X}Z_{pD}(q).                                    \tag{12}
\]

Unique prime-face orientation gives

\[
 Z_{pD}(q)=Z_D(q)-Z_D(q^p),                                        \tag{13}
\]

and (4) follows.  Separately, the two original mixed terms are

\[
 2\langle\Delta Z,E\rangle=-2b_{X,p}{L\over X}Z_D(q),
 \qquad
 2\langle\Delta Z,W\rangle=2b_{X,p}{L\over X}Z_D(q^p).             \tag{14}
\]

Thus their combination is essential; bounding them independently discards
the admitted endpoint polynomial (13).

## First nonzero moment and size

Put

\[
 S_1=\sum_{e\mid D}\mu(e)e=\prod_{\ell<p}(1-\ell),
 \qquad
 S_2=\sum_{e\mid D}e^2=\prod_{\ell<p}(1+\ell^2).                  \tag{15}
\]

The constant moment vanishes.  The exact derivative difference is

\[
 \sum_{e\mid D}\mu(e)(pe-e)=(p-1)S_1.                             \tag{16}
\]

Taylor expansion of `exp(-2e/X)` and `exp(-2pe/X)` yields (5).  Combining
(5) with (8), the main-row mixed contribution is

\[
 -{2L(p-1)\over pX^2}e^{-2p}
 \prod_{\ell<p}(1-\ell)\{1+o(1)\}.                                \tag{17}
\]

It has primorial parity, but its exponential magnitude is
`exp(-2L-p+o(p))`, well below `e^(-2p)` for `p<L`.

The Taylor expansion is unnecessary for a bound near the branch edge.
Equations (4), (8), and

\[
 |Z_D(q^p)-Z_D(q)|\le2^{\pi(p)}+2^{\pi(p)}=e^{o(p)}                \tag{18}
\]

give

\[
 |2\langle\Delta Z,E+W\rangle|_{\rm main}
 \ll {L\over Xp}e^{-2p+o(p)}.                                     \tag{19}
\]

After division by the fixed-profile margin
`e^(-2p)p^(delta-1)`, (19) has size
`L e^(o(p))/(X p^delta)`, which tends to zero uniformly for `p=O(L)`.
The established component remainder bounds are smaller on the same
first-branch region.

## The post-branch wedge

When `D>X`, only part of a face remains on (6)'s first branch.  For a main
profile face `G_d` paired with an endpoint face at `n`, put

\[
 m=\min(n,Xd).
\]

The literal sampled kernel is

\[
\boxed{
 H_{X,q}(d,n)
 ={q^n\over2d}\left[
 e^{-2d}(q^{-m}-1)+(1-q)(n-m)
 \right].}                                                         \tag{20}
\]

The first term is the initial geometric block; the second is the constant
product on `Xd<j<=n`.  Therefore the main-profile part of (1) becomes

\[
 2{L\over X}\sum_{e\mid D}\sum_{n\mid pD}
 \mu(e)\mu(n)H_{X,q}(pe,n).                                        \tag{21}
\]

If `D<=X`, then `n<=pD<=Xpe`, so (20) reduces to the Abel collapse above.
If `D>X`, the wedge

\[
 n>Xpe                                                            \tag{22}
\]

survives for the smaller cofactors `e`.  The boundary `n=Xpe` depends on
both divisor variables.  A one-variable Abel moment cannot remove (21), and
LCM grouping does not fix this order boundary.  The `J`, second-log, and PNT
profiles give analogous kernels with their actual post-branch weights.

Thus the post-branch remainder is another weighted two-point Möbius
correlation.  Exact subtraction of (21) is possible as a modified
observable, but the endpoint quadratic from the preceding audit remains.
No sign theorem for the original energy follows from that subtraction.

## Consequence for the endpoint-wall ledger

The earlier Cauchy estimate gave the mixed terms a ratio
`exp(-3L/2+3p/2+o(L))` and therefore made them appear to meet the
fixed-profile margin at `p=L`.  Equations (4) and (19) show that this is a
loss of the complete first-branch cancellation.  On the arithmetic side
`D<=X`, the mixed terms are negligible even at the crossover.

The remaining wall is the endpoint quadratic.  Crossing to `D>X` also
creates the post-branch correlation (21), so a theorem on the far side needs
both its control and the endpoint-quadratic two-point estimate.  The proved
`2/3` original and fixed-`eta` cross-corrected ranges are unchanged.

## Formal finite scope

[MixedEndpointFirstBranchFinite.lean](../../formalization/BuildingBlocks/MixedEndpointFirstBranchFinite.lean)
proves the zero-mass Abel collapse, the admitted endpoint polynomial, the
exact first moment `(p-1)S_1`, the support implication (7), and the
common-mode/residual split.  It compiles without `sorry`, new axioms, or an
analytic premise.  The printed theorem dependencies are only `propext`,
`Classical.choice`, and `Quot.sound`; the support theorem is axiom-free.

The post-branch estimate is deliberately not asserted.  No RH conclusion is
drawn.
