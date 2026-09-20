# Fourfold completion of the high double-\(Q\) Gram block

**Status:** unconditional written estimate for the canonical all-unit
residual, with two independent audit passes, 20 September 2026.  The Lean
companion checks only the exponent ledger.  The Poisson and stationary-phase
arguments below remain written analysis.  The estimate still lies above the
Gram target and does not imply the Riemann hypothesis.

## Scope and coefficient provenance

Continue from the
[joint outer/alias spacing estimate](actual-mobius-double-q-dual-spacing-saving.md).
Thus
\[
 T=PQ^2,\qquad N=Q^5,\qquad U=P^2Q,\qquad
 G=\frac{PF}{Q},
\tag{1}
\]
and the block under consideration has
\[
 Q^2\leq F\leq T^{1-\kappa}
\tag{2}
\]
for a fixed \(\kappa>0\).  The upper margin keeps \(G/U=F/T\) a fixed
negative power.

The completion below is only asserted for the actual canonical all-unit
history.  In the exact packet formula
\[
 L_m(T)=\frac{H}{m\sqrt N}\sum_{k\ne0}e(-kN/m)
 \left[\log(N/m)\widehat G_T(kH/m)
       +\widehat Q_T(kH/m)\right],
\tag{3}
\]
the Poisson frequency has arithmetic coefficient \(1\).  At the all-unit
contact, the two unrestricted free factors likewise have coefficient \(1\);
the restricted divisor coefficients attach to the two \(Q\)-variables.
After the finite Fourier--Mellin separation, all remaining dependence on the
variable denoted \(k\) below is smooth and inert.  Consequently ordinary
Poisson summation in \(k,k'\) is legal for this canonical residual.

This provenance is stronger than the abstract divisor-bounded notation
\(a_k\) used in the public one-\(Q\) and Gram statements.  The argument below
is not valid for an arbitrary arithmetic sequence \(a_k\).

## Reversing the alias transform

Put
\[
 F_0=2Q^{3/2}(\sqrt{km}-\sqrt{k'm'}),\qquad c=QF_0.
\tag{4}
\]
The preceding two-dimensional stationary transform has phase
\[
 -2\sqrt{2c}\,(j\ell)^{1/4}
\tag{5}
\]
and amplitude \(Q^2/F\), up to an inert symbol.  Apply the \(B\)-process in
both \(j\) and \(\ell\).  The dual variables satisfy \(q,r\asymp Q\), the
critical phase is exactly
\[
 -\frac{c}{\sqrt{qr}}
 =-2\sqrt{\frac N{qr}}
   (\sqrt{km}-\sqrt{k'm'}),
\tag{6}
\]
and the new amplitude is \(F/Q^2\).  The two Hessian signatures are opposite.
Thus the amplitudes and signature factors cancel: this step is the inverse of
the preceding two-\(Q\) transform and creates no saving.

All alias cutoffs are smooth and compactly supported, so there are no hard
endpoint terms.  Taking sufficiently many stationary terms makes wrong modes
and remainders summable.  One retained correction contributes at most
\(O_\varepsilon(T^\varepsilon Q^{-1})\) after Gram normalization.

## The \(m,m'\) transforms

Fix \(q,r,k,k'\), and write
\[
 C_0=\frac N{qr}\asymp Q^3.
\tag{7}
\]
Poisson summation and the one-dimensional \(B\)-process in
\(m,m'\asymp PQ\) select \(n,n'\asymp Q\).  The critical points and phases
are
\[
 m_* = \frac{C_0k}{n^2},\qquad
 m'_* = \frac{C_0k'}{n'^2},
\tag{8}
\]
\[
 -\frac{C_0k}{n}+\frac{C_0k'}{n'}.
\tag{9}
\]
The two stationary amplitudes are
\[
 \frac{\sqrt{2C_0k}}{n^{3/2}},\qquad
 \frac{\sqrt{2C_0k'}}{n'^{3/2}},
\tag{10}
\]
so their product is \(\asymp P\), and the two signature factors cancel.

The difference cutoff must be retained.  At the critical point its argument
is
\[
 g_* = C_0\left(\frac{k^2}{n^2}-\frac{k'^2}{n'^2}\right),
 \qquad \chi(g_*/G).
\tag{11}
\]
One uniform justification is to Fourier-expand the original smooth cutoff
\(\chi((km-k'm')/G)\).  For Fourier variable \(\xi\), the exact critical
phases have denominators \(n+\xi k/G\) and \(n'+\xi k'/G\).  Since
\[
 \frac{\xi k/G}{n}\ll \frac{|\xi|}{F},
\tag{12}
\]
Taylor expansion recovers (9)--(11).  The quadratic phase error is
\(O(T\xi^2/F^2)\), while \(\widehat\chi(\xi)\) is Schwartz.  After summing
all variables, this replacement and the lower stationary terms contribute
the normalized error
\[
 O_\varepsilon\left(T^\varepsilon\frac{P Q^3}{F^2}\right).
\tag{13}
\]
For \(F\geq Q^2\), it is at most \(T^\varepsilon P/Q\).

The leading transformed block is therefore a finite sum of forms
\[
 \sum_{q,r,n,n'\asymp Q}\sum_{k,k'\asymp P}
 \mathcal A_*W_*
 \chi(g_*/G)
 e\!\left(C_0\left(\frac{k'}{n'}-\frac{k}{n}\right)\right),
 \qquad \mathcal A_*\asymp P,
\tag{14}
\]
with jointly inert \(W_*\).

## Exact two-dimensional completion

For fixed \(q,r,n,n'\), introduce
\[
 s=\frac12\left(\frac{k}{n}+\frac{k'}{n'}\right)
 \asymp\frac P Q,
 \qquad
 z=\frac{k}{n}-\frac{k'}{n'}\asymp\frac F{Q^3}.
\tag{15}
\]
Then
\[
 g_*=2C_0sz,qquad
 \text{phase}=-C_0z,qquad
 \left|\frac{\partial(k,k')}{\partial(s,z)}\right|=nn'\asymp Q^2.
\tag{16}
\]
Poisson summation in the smooth \(k,k'\)-variables gives integer modes
\(-\ell,+\ell'\).  In the coordinates (15), their phase is
\[
 -(\ell n-\ell'n')s
 -\left(C_0-\frac{\ell n+\ell'n'}2\right)z.
\tag{17}
\]
Repeated integration by parts leaves only \(\ell,\ell'\asymp Q^2\) with
\[
 |\ell n-\ell'n'|\ll \frac QP,
\tag{18}
\]
\[
 \left|C_0-\frac{\ell n+\ell'n'}2\right|
 \ll \frac{Q^3}{F}.
\tag{19}
\]
The smooth tails of these windows are summed dyadically.  From the Jacobian,
the support lengths in (15), and the amplitude \(\mathcal A_*\), every
surviving Fourier integral is at most
\[
 P\cdot Q^2\cdot\frac P Q\cdot\frac F{Q^3}
 =\frac{P^2F}{Q^2}.
\tag{20}
\]

Set \(A=\ell n\) and \(A'=\ell'n'\).  For fixed \(q,r\), conditions
(18)--(19) allow
\[
 O\!\left(\frac{Q^3}{F}\frac QP\right)
 =O\!\left(\frac{Q^4}{PF}\right)
\tag{21}
\]
integer pairs \((A,A')\).  Both window lengths are at least one because
\(F\leq T=PQ^2\) and \(Q>P\).  Restricted factorizations
\(A=\ell n\), \(A'=\ell'n'\) cost only \(T^\varepsilon\).  Summing
\(q,r\asymp Q\), the number of resonant tuples is therefore
\[
 O_\varepsilon\left(T^\varepsilon\frac{Q^6}{PF}\right).
\tag{22}
\]
Combining (20) and (22) proves
\[
 |\mathcal J_G|\ll_\varepsilon T^\varepsilon P Q^4
\tag{23}
\]
for the leading canonical block.

## Result and remaining obstruction

Together with (13) and the reversed-transform remainder,
\[
 \boxed{\quad
 \frac{|\mathcal J_G|}{P^3Q^3}
 \ll_\varepsilon T^\varepsilon
 \left(
   \frac Q{P^2}+\frac{P Q^3}{F^2}+\frac1Q
 \right).
 \quad}
\tag{24}
\]
For
\[
 p=1-\frac{2\lambda}{5},\qquad q=\frac\lambda5,
 \qquad 2<\lambda<\frac{29}{14},
\tag{25}
\]
the first exponent is
\[
 q-2p=\lambda-2>0.
\tag{26}
\]
It ranges from \(0\) to \(1/14\).  The other two terms save powers in
(2), but the leading resonance count remains above the Gram target for
every fixed \(\lambda>2\).

The diagonal \(A=A'\) costs only \(P^{-1}\) after normalization.  The loss
in (26) comes from the \(Q/P\) admissible nonzero differences in (18).
Since the Fourier transform of a nonnegative smooth shell is positive near
the origin, absolute counting of those modes cannot remove this factor.
A further advance requires cancellation in the determinant-weighted product
resonances (18)--(19), not another independent completion of the already
self-dual variables.

The companion
[ActualMobiusDoubleQFourfoldResonanceBound.lean](../../formalization/BuildingBlocks/ActualMobiusDoubleQFourfoldResonanceBound.lean)
checks (21)--(26) at the exponent level, including the error at
\(F=Q^2\).  It does not formalize the coefficient provenance, Poisson
summation, stationary phase, inert-symbol estimates, or resonance count.
