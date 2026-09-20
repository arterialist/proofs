# Additive Fourier saving for the critical localized divisor box

**Status:** unconditional written estimate for the exact positive all-unit
coefficient, 20 September 2026.  The companion Lean file checks the scale
and exponent ledger only.  The residue-class argument below is written
mathematics.  This is an additive linear-twist estimate; it does not bound
the reciprocal phase and does not imply the Riemann hypothesis.

## Exact box and statement

At the critical all-unit contact use

\[
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},\qquad
 A=Q/P,\qquad N=Q^5,
 \tag{1}
\]

so that \(PA=Q\), \(PQ^2=T\), and \(2<\lambda<29/14\).
The second \(K=3\) expansion leaves the positive coefficient-one history

\[
 x\asymp Q,\qquad p\asymp P,\qquad s\asymp A,
 \qquad r\asymp Q.
 \tag{2}
\]

Thus \(xpsr\asymp Q^3\).  For coprime integers \(a,M\), \(M>1\), put

\[
 \mathcal L(a,M)=
 \sum_{x\asymp Q}\sum_{p\asymp P}
 \sum_{s\asymp A}\sum_{r\asymp Q}
 e\!\left(\frac{a xpsr}{M}\right),
 \tag{3}
\]

with any fixed dyadic subintervals.  Then

\[
 \boxed{
 |\mathcal L(a,M)|
 \ll_\varepsilon T^\varepsilon
 \left(\frac{Q^3}{M}+M+Q^2\right).}
 \tag{4}
\]

The same estimate holds for separated bounded coefficients in \(p,s,r\).
A smooth or bounded-variation weight in \(x\) costs its total variation,
which is \(T^\varepsilon\) for the packet separators used here.  A hard
product cutoff only clips the \(x\)-sum to another interval and does not
change the argument.

For \(M\asymp Q\), (4) becomes

\[
 |\mathcal L(a,M)|\ll_\varepsilon T^\varepsilon Q^2,
 \tag{5}
\]

a factor \(Q\) below the \(Q^3\) mass of the exact box.

## Residue-class proof

Collapse only the three variables not named \(x\):

\[
 b(t)=\#\{(p,s,r):psr=t\}.
 \tag{6}
\]

The support has \(t\asymp PAQ=Q^2\), and the fixed divisor bound gives
\(b(t)\ll_\varepsilon T^\varepsilon\).  For each \(t\), the elementary
geometric-sum estimate gives

\[
 \left|\sum_{x\asymp Q}e(a t x/M)\right|
 \ll \min\!\left(Q,\frac1{2\|at/M\|}\right).
 \tag{7}
\]

Because \((a,M)=1\), multiplication by \(a\) permutes the residue classes
modulo \(M\).  On one complete residue block,

\[
 \sum_{u\bmod M}
 \min\!\left(Q,\frac1{2\|au/M\|}\right)
 \ll Q+M\log(2M).
 \tag{8}
\]

There are \(O(Q^2/M+1)\) blocks in the \(t\)-support.  Equations
(6)--(8), with logarithms absorbed into \(T^\varepsilon\), give

\[
 |\mathcal L(a,M)|
 \ll_\varepsilon T^\varepsilon
 \left(\frac{Q^3}{M}+Q^2+Q+M\right),
 \tag{9}
\]

which is (4).

This is the asymmetric-box version of the elementary argument in
Coppola--Laporta,
[*A note on the exponential sums of the localized divisor functions*](https://arxiv.org/abs/1512.01128).
Their general \(k=4\) theorem gives a localization-uniform boundary term
\((Q^3)^{3/4}=Q^{9/4}\).  Here the known \(Q\)-long coordinate in (2)
reduces that boundary term to \(Q^2\).  No priority beyond this direct
specialization is claimed.

## Endpoint comparison and limitation

The estimate is uniform in the numerator \(a\).  Summing (5) over the
\(P\) physical modes would give \(P Q^2\), which is \(Q^{-1/2}\) below
the unnormalized endpoint target \(P Q^{5/2}\).  This comparison explains
why additive Fourier control of the exact coefficient is strong enough in
scale.

There is also no hidden coprimality loss for the physical numerators.
Start with a modulus \(M_0\asymp Q\) and numerator \(k\asymp P\), and
reduce the fraction.  Since \((k,M_0)\leq k\ll P\), its reduced denominator
satisfies \(M\gg Q/P\).  Formula (4) is then at most

\[
 T^\varepsilon P Q^2
 \tag{10}
\]

per \(k\).  Summing all \(P\) modes gives \(P^2Q^2\), whose ratio to the
endpoint target is

\[
 \frac{P^2Q^2}{P Q^{5/2}}
 =\frac{P}{\sqrt Q}
 =T^{-(\lambda-2)/2}<1.
 \tag{11}
\]

Thus the complete additive family has a fixed saving even after the worst
possible gcd reduction.

The actual phase is

\[
 e\!\left(-\frac{kN}{xpsr}\right),
 \tag{12}
\]

not \(e(a xpsr/M)\).  Fourier-expanding the reciprocal chirp has a large
Fourier-algebra cost, so (4) cannot simply be integrated against such an
expansion.  A valid next theorem must transfer the additive saving to the
curved reciprocal phase with loss strictly below the worst-gcd margin
\(\sqrt Q/P=T^{(\lambda-2)/2}\).  No such transfer is proved here.

[`ActualMobiusLocalizedDivisorFourier.lean`](../../formalization/BuildingBlocks/ActualMobiusLocalizedDivisorFourier.lean)
checks \(PA=Q\), the three terms in (4) at \(M=Q\), the factor-\(Q\)
box saving, the \(Q^{-1/2}\) coprime comparison, and the worst-gcd saving
\((\lambda-2)/2\).  The analytic residue-class estimate remains a written
proof.
