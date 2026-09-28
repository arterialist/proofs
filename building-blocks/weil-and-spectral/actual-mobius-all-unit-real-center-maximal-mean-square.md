# A maximal real-center mean square for the displayed all-unit row

**Status:** unconditional written estimate for the row defined below, 28
September 2026. The analytic maximal inequality and van der Corput
transform are proved or cited below; they are not Lean-formalized. The
Lean companion
[`ActualMobiusAllUnitRealCenterScale.lean`](../../formalization/BuildingBlocks/ActualMobiusAllUnitRealCenterScale.lean)
checks only scale and exponent algebra. This is a
real-\(Q\) average, not a bound at the prescribed \(Q\), and the dual row
defined here is not identified with the published separated
\(J_{\rm all}\). No RH implication is claimed.

Put \(P=Q^\alpha\), \(12/29<\alpha<1/2\), \(T=PQ^2\),
\(N=Q^5\), \(H=N/T=Q^3/P\). The exact packet formula in
[the three-dimensional tail note](actual-mobius-tail-three-dimensional-saving.md)
is
\[
L_d(T)=\frac{H}{d\sqrt N}\sum_{k\ne0}
\mathfrak A_T(k,d)e(-Nk/d),\quad
\mathfrak A_T(k,d)=\log(N/d)\widehat G_T(kH/d)
                    +\widehat Q_T(kH/d).
\tag{1}
\]
We select the negative Fourier shell \(k=-j\), \(j\asymp P>0\).
Conjugating the complete row changes its phase to \(e(-Nj/d)\)
without changing its square. The same estimate applies to either
signed shell.

Apply the all-unit identity
\(-3+\tau(r)=-1+\sum_{ux=r,\ u,x\ge2}1\) from
[the K3 source](actual-mobius-k3-bottom-slice-saving.md), Eq. (27c),
to each of the two complementary Möbius factors. The positive cross
has labeled ordered \(u,x,v,w\ge2,t\ge1\); the negative single-free
terms are separate and are not included in this row. In that
combinatorial skeleton,
fix the labeled outer atoms \(\omega=(u,v,w,t)\), put
\(s_\omega=uvwt\asymp Q^2\), and let \(n=x\asymp Q\) be the free
factor. The displayed hard product, Type-II, orientation and dyadic
conditions select an interval \(I_\omega(Q)\) in \(n\). Retain only
compatible assignments \(\omega\mapsto(q,r)\) with
\(q,r\asymp Q\), \(qr=s_\omega\), preserving ordered multiplicities.
On one smooth contact shell \(\psi_Q(j)\) of bounded variation, define
\[
\widetilde D_{qr}(Q)=
\sum_{\omega\mapsto(q,r)}
\sum_{n\in I_\omega(Q)}\sum_{j\asymp P}
\frac{H}{s_\omega n}
\overline{\mathfrak A_T(-j,s_\omega n)}
\psi_Q(j)e\!\left(-\frac{Nj}{s_\omega n}\right).
\tag{2}
\]
An additional common weight in \(n\) is allowed if, after the outer
atoms are fixed, its total variation is \(O(T^\varepsilon)\).
Independence from \(j\) alone does not imply that condition; the
unitemized abstract \(W\) of the separated endpoint is not assumed
to satisfy it. Thus (2) is a specified direct row, not an asserted
reconstruction of every weight in the original packet.

For every fixed \(Q_0\) and \(P_0=Q_0^\alpha\),
\[
\boxed{\displaystyle
\int_{Q_0}^{Q_0+1}\sum_{q,r}
|\widetilde D_{qr}(Q)|^2\,dQ
\ll_\varepsilon T_0^\varepsilon\frac{Q_0^3}{P_0}.}
\tag{3}
\]
The implied constant may depend on the fixed contact supports,
\(\alpha\), and the stated variation bound.

## Two-parameter maximal center lemma

Here is the coefficient-independent analytic input. Let at most
\(CQ^2\) labeled rows have fixed integers \(s_\nu\asymp Q^2\).
On common boxes \(n\asymp Q,\ j\asymp P\), take coefficients
\(a^{(\nu)}_{n,j}\) independent of the real center \(X\) and bounded
by \(A/P\). For integer intervals \(I,J\), set
\[
F_\nu(X;I,J)=
\sum_{n\in I}\sum_{j\in J}a^{(\nu)}_{n,j}
e(-Xj/(ns_\nu)).
\]
For \(Y\ge1\),
\[
\frac1Y\int_{X_0}^{X_0+Y}\sum_\nu
\sup_{I,J}|F_\nu(X;I,J)|^2\,dX
\ll A^2\frac{Q^3}{P}(\log(2Q))^5
\left(1+\frac{Q^4}{Y}\right).
\tag{4}
\]
In particular the parenthesized factor is bounded for \(Y\gg Q^4\).

For one fixed row, equal rational frequencies \(j/n\) are grouped.
Distinct grouped frequencies divided by \(s_\nu\) are separated by
\(\gg Q^{-4}\). A smooth majorant of the center interval and Schur's
test bound the normalized integral of every rectangular block by
\((1+Q^4/Y)\) times its grouped coefficient square sum. The number of
ordered equal-frequency pairs in the full box is at most
\[
\sum_{n\asymp Q,\ j\asymp P}\gcd(n,j)
\ll PQ\log(2P).
\tag{5}
\]
Indeed \(n=dn_0,j=dj_0\), \((n_0,j_0)=1\), leaves at most
\(O(d)\) proportional partners; summing gcd by divisors gives the
last bound. With coefficients \(A/P\), (5) costs
\(O(A^2Q\log(2P)/P)\) per row.

Embed both boxes in dyadic trees. Every interval rectangle is a union
of \(O(\log Q\log P)\) tree rectangles. At each pair of tree levels,
the blocks partition the full pair box, so (5) is charged only once.
Cauchy, summation over level pairs, and the \(O(Q^2)\) rows give the
five logarithms in (4). The same argument handles either signed
\(j\)-shell and a Schwartz dyadic tail.

For (3), apply (4) with the genuinely center-independent base
coefficient \(1/P_0\). At each live \(Q\), put all packet dependence in
\[
W_Q^0(n,j;s)=\frac{P_0H}{sn}
\overline{\mathfrak A_T(-j,sn)}.
\]
With \(x=n/Q,\ y=j/P,\ z=s/Q^2\), this equals
\[
\frac{P_0}{P}\frac{1}{zx}
\left[(2\log Q-\log(zx))\,
\overline{\widehat G_T(-y/(zx))}
 +\overline{\widehat Q_T(-y/(zx))}\right].
\]
The packet's uniform Schwartz bounds give first and mixed
\((x,y)\)-derivatives \(O(\log T)\) on fixed contact boxes.
Rectangular Hardy–Krause variation is therefore \(O(\log T)\).
Twice applying Abel summation bounds each packet-weighted row by that
variation times the supremum in (4). The factor \(\psi_Q(j)\),
moving hard \(n\)-intervals, and other one-variable BV weights are
handled by separate Stieltjes summation, so their derivatives need
not be bounded. No derivative in \(Q\) is used. The map
\(Q\mapsto N=Q^5\) sends a unit \(Q\)-window to a
center interval of length \(\asymp Q_0^4\). At most
\(T^\varepsilon\) labeled outer histories share one \(s\) or one
\((q,r)\), by fixed divisor bounds. This proves (3).

## Exact hard-interval dual and limitation

Apply [Huxley's BV van der Corput transform as stated by
Vandehey, Theorem 1.1](https://arxiv.org/pdf/1205.0090) to
\(P\widetilde D_{qr}\), one \((j,\omega)\) term at a time, with
\(f(x)=-jN/(s_\omega x)\). Its phase parameter is
\(\asymp PQ^2\), curvature \(\asymp P\), and dual
\(m\asymp PQ\). Define \(B_{qr}\) to be the **complete leading hard
dual sum**, retaining its moving starred range
\(m\in f'(I_\omega(Q))\), the saddle amplitude, and the ordered
outer histories. The transform gives
\[
P\widetilde D_{qr}
=\frac{e(-1/8)}{\sqrt{2P}}B_{qr}+E_{qr},
\qquad
\sum_{q,r}|\sqrt P\,E_{qr}|^2
\ll_\varepsilon T^\varepsilon P^3Q^2.
\tag{6}
\]
The BV transform handles complex amplitudes by real and imaginary
parts. It is uniform for short atomwise intervals because its length
parameter may be \(Q\ge b-a\). Equations (3) and (6) yield
\[
\boxed{\displaystyle
\int_{Q_0}^{Q_0+1}\sum_{q,r}|B_{qr}(Q)|^2\,dQ
\ll_\varepsilon T_0^\varepsilon P_0^2Q_0^3.}
\tag{7}
\]
The error in (6) is below the right side since \(P<Q\).

The published one-\(Q\) endpoint writes a jointly inert smooth
\(V_{k,m,q,r}\) after smoothing and separator allocation; (6)
instead has moving hard dual-\(m\) endpoints. No real-\(x\),
coefficient-preserving equality, including endpoint allocation and
weighted separator variation, has been shown between this \(B\) and
the published full \(J_{\rm all}\). A reverse B-process also cannot
be used under that Gram's merely divisor-bounded \(b_m\)
hypothesis: choosing the unit-modulus
\(b_m=e(2\sqrt{kNm/(qr)})\) cancels the \(m\)-phase termwise.
Thus (7) is not a \(J_{\rm all}\) estimate.

Nor does a shrinking center window give the prescribed \(Q_0\).
The reciprocal phase changes at rate \(\asymp PQ\) as \(Q\) varies;
a phase-stable window of width \((PQ)^{-1}\) incurs the full
\(PQ\) short-window factor in (4). The fixed-center hard
\(s\)-Poisson modes and the separate transfer from any hypothetical
full \(J_{\rm all}\) saving to \(\mathrm{CoarsePrimitiveBound}\)
remain open.
