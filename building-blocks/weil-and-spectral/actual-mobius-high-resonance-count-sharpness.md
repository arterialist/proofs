# Average-center sharpness of the high product-resonance count

**Status:** unconditional written counting theorem, 20 September 2026.
The exponent ledger is Lean-verified in
[`ActualMobiusDoubleQFourfoldResonanceBound.lean`](../../formalization/BuildingBlocks/ActualMobiusDoubleQFourfoldResonanceBound.lean).
The coprime-pair count and averaging proof below are written mathematics.
This result proves no cancellation, does not extend the Möbius cutoff, and
does not imply the Riemann hypothesis.

## The resonance count

The high double-\(Q\) completion leaves variables

\[
 q,r,n,n'\asymp Q,\qquad \ell,\ell'\asymp Q^2,
\]

and products

\[
 A=\ell n,\qquad A'=\ell'n'.
\]

For a fixed integer center \(N\), its two resonance windows are

\[
 |A-A'|\ll \frac QP,
 \qquad
 \left|\frac N{qr}-\frac{A+A'}2\right|
 \ll \frac{Q^3}{F}.
 \tag{1}
\]

The fourfold upper bound counts

\[
 O_\varepsilon\!\left(T^\varepsilon\frac{Q^6}{PF}\right)
 \tag{2}
\]

tuples in (1). The next theorem shows that this order is attained for some
center. Thus no uniform improvement of (2) can come from integrality,
coprimality, or a thinner count of the determinant equation.

**Theorem.** Fix sufficiently small absolute constants \(c_0,c_1>0\).
For all large \(Q\), suppose

\[
 1\le P\le c_0Q,
 \qquad Q^2\le F\le P Q^2.
 \tag{3}
\]

There is an integer \(N\asymp Q^5\) for which at least

\[
 \boxed{\quad c_1\frac{Q^6}{PF}\quad}
 \tag{4}
\]

tuples \((q,r,n,n',\ell,\ell')\) in fixed subintervals of the displayed
dyadic ranges satisfy

\[
 1\le \ell n-\ell'n'\le c_0\frac QP,
 \qquad
 \left|\frac N{qr}-\frac{\ell n+\ell'n'}2\right|
 \le c_0\frac{Q^3}{F}.
 \tag{5}
\]

All constants are independent of \(P,F,Q\).

## Proof

Put

\[
 H=\left\lfloor c_0\frac QP\right\rfloor,
 \qquad W=c_0\frac{Q^3}{F}.
 \tag{6}
\]

The upper bound for \(P\) in (3) ensures \(H\ge1\). Choose \(n\) and
\(n'\) in two fixed intervals inside \([Q,2Q]\), with

\[
 Q\le n\le \frac65Q,
 \qquad \frac75Q\le n'\le\frac85Q.
 \tag{7}
\]

Möbius inversion gives \(\gg Q^2\) coprime pairs in (7). Indeed, the
number is

\[
 \sum_{d\le2Q}\mu(d)
 \left(\frac{Q}{5d}+O(1)\right)^2
 =cQ^2+O(Q\log Q)
 \tag{8}
\]

for an absolute \(c>0\). The unequal interval lengths only change \(c\).

Fix one such pair and one integer \(1\le h\le H\). Since
\((n,n')=1\), the congruence

\[
 \ell n\equiv h\pmod {n'}
 \tag{9}
\]

has one residue class modulo \(n'\). Restrict \(\ell\) to a fixed interval
inside \([17Q^2/10,9Q^2/5]\). It contains \(\gg Q\) solutions of (9).
For each of them set

\[
 \ell'=\frac{\ell n-h}{n'}.
 \tag{10}
\]

The margins in (7), the chosen \(\ell\)-interval, and \(h\ll Q\) put
\(\ell'\) in a fixed subinterval of \([Q^2,2Q^2]\). Therefore (9)--(10)
produce \(\gg Q\) solutions for every coprime pair and every \(h\).
Summing gives

\[
 \#\{(n,n',\ell,\ell'):1\le \ell n-\ell'n'\le H\}
 \gg H Q^3\gg \frac{Q^4}{P}.
 \tag{11}
\]

Now choose \(q,r\) in fixed intervals inside \([Q,2Q]\), giving
\(\gg Q^2\) choices. For each tuple counted in (11), let

\[
 X_0=qr\frac{\ell n+\ell'n'}2.
 \tag{12}
\]

Every integer \(N\) with

\[
 |N-X_0|\le qrW
 \tag{13}
\]

satisfies the second inequality in (5). There are \(\gg Q^2W=Q^5/F\)
such integers. Condition (3) makes this interval contain many integers.
All centers produced by (12)--(13) lie in one fixed interval of length
\(O(Q^5)\).

Count incidences between the resonance tuples and these integer centers.
Equations (11)--(13) give at least

\[
 \frac{Q^4}{P}\cdot Q^2\cdot\frac{Q^5}{F}
 =\frac{Q^{11}}{PF}
 \tag{14}
\]

incidences. Only \(O(Q^5)\) centers occur. Pigeonholing proves (4).

## Consequence at the critical scales

In the zeta application

\[
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},
 \qquad 2<\lambda<\frac{29}{14}.
 \tag{15}
\]

Thus \(P/Q=T^{1-3\lambda/5}\to0\), so (3) holds throughout the high
range \(Q^2\le F\le T=PQ^2\). The exponent in (4) is

\[
 6\frac\lambda5-\left(1-2\frac\lambda5\right)-f,
 \tag{16}
\]

exactly the exponent of the upper count (2). Multiplying by the size
\(P^2F/Q^2\) of one completed Fourier integral returns \(PQ^4\), whose
ratio to the Gram target \(P^3Q^3\) is

\[
 \frac Q{P^2}=T^{\lambda-2}>1.
 \tag{17}
\]

This is a count-sharpness result, not a lower bound for the signed Gram
block. The actual Fourier kernels and restricted divisor coefficients may
still cancel. Equation (4) proves that they must cancel collectively:
another absolute count, gcd restriction, or unit-residual condition cannot
remove the loss in (17).

## Fast falsifier

Any proposed sparsity estimate of the form

\[
 \#\mathcal R_N=o\!\left(\frac{Q^6}{PF}\right)
\]

uniformly for every integer \(N\asymp Q^5\) contradicts (4). A candidate
high-block argument must therefore display a signed oscillatory quantity
before taking absolute values. If it ends with a uniform count of (1), the
averaging theorem falsifies the required saving.
