# Unit-residual survivor audit at the critical Möbius scales

**Status:** exact survivor formula and exponent audit, 20 September 2026.
The gcd normalization and unit-residual conclusions are Lean-verified in
[`ActualMobiusReciprocalCorrelation.lean`](../../formalization/BuildingBlocks/ActualMobiusReciprocalCorrelation.lean).
The survivor sum and exponent comparison below are written mathematics.
No bound for that sum is proved. This note does not extend the Möbius
cutoff or prove the Riemann hypothesis.

## Exact survivor sum and count

Let \(\mathscr I\subset[D,2D]\), let \(\mathcal K\) be an integer interval
of length \(L\), and write

\[
 K_{\mathcal K}(x)=\sum_{k\in\mathcal K}e(-kx).
\]

In each ordered off-diagonal pair, write

\[
 n=ga,\qquad m=gb,\qquad a<b,\qquad (a,b)=1.
\]

For a positive integer center \(N\), put

\[
 c=(N,ab),\qquad N=cN',\qquad ab=cq.
\]

The surviving nonzero near-resonance contribution is the restriction of
the exact mean-square expansion to tuples satisfying

\[
 N'(b-a)=\ell gq+\sigma s,
 \qquad \sigma\in\{-1,1\},qquad \ell\ge1,
 \tag{1}
\]

where the equation is read as \(N'(b-a)+s=\ell gq\) when
\(\sigma=-1\), and

\[
 0<s<\frac{gq}{L},\qquad (s,q)=1.                 \tag{2}
\]

Thus, up to the conjugate orientation, the literal sum is

\[
 \boxed{
 \mathcal E_{\rm surv}=
 \sum_{\substack{g,a,b,\ell,s,\sigma\\
                  ga,gb\in\mathscr I,\ a<b, (a,b)=1\\
                  c=(N,ab),\ q=ab/c\\
                  N'(b-a)=\ell gq+\sigma s\\
                  0<s<gq/L,\ (s,q)=1}}
 A(ga)\overline{A(gb)}
 K_{\mathcal K}\!\left(\frac{\sigma s}{gq}\right).}
 \tag{3}
\]

Equation (3) retains the actual coefficient
\(A(n)=\mu(n)d_{R,S}(n)\), or the separate recombined coefficient
\((\mu*\mu)(n)W(n/D)\), according to the partition being estimated. The
endpoint conditions \(ga,gb\in\mathscr I\) remain inside the sum.

Let \(\mathscr N_{\rm surv}\) be the same sum with every weight replaced by
one. The currently certified bounds are

\[
 \mathscr N_{\rm surv}\le D^2,
 \qquad
 |\mathcal E_{\rm surv}|
 \ll_\varepsilon T^\varepsilon L D^2,             \tag{4}
\]

using the fixed divisor bound for \(A\) and
\(|K_{\mathcal K}|\le L\). The unit condition in (2) has not yet improved
(4).

## Old bound and required saving

At the unresolved critical contact,

\[
 2<\lambda<\frac{29}{14},\qquad
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},
 \tag{5}
\]

and

\[
 N=Q^5=T^\lambda,\qquad D=Q^3=T^{3\lambda/5},
 \qquad L=\frac{DT}{N}=P,
 \qquad PQ^2=T.                                    \tag{6}
\]

Consequently, (4) is

\[
 |\mathcal E_{\rm surv}|
 \ll_\varepsilon T^\varepsilon P Q^6.             \tag{7}
\]

The bare threshold in the reciprocal second moment is \(P Q^5\). To leave
a fixed margin for every dyadic, divisor, separator, and smoothing loss,
one needs, for some \(\kappa>0\),

\[
 \boxed{
 |\mathcal E_{\rm surv}|
 \ll_\varepsilon T^\varepsilon P Q^5T^{-\kappa}.}
 \tag{8}
\]

This asks for a factor \(QT^\kappa\) beyond the present absolute bound.
In the notation
\(D^2T^{-\rho}\) of the reciprocal mean-square target, (8) is

\[
 \rho=\frac{3\lambda}{5}-1+\kappa.                \tag{9}
\]

The full exponent window is

\[
 0<\kappa<1-\frac\lambda5,
 \qquad
 0<\eta<\min\left\{\frac\kappa2,\frac\lambda5\right\}.
 \tag{10}
\]

The first upper bound keeps \(\rho<\lambda-3\lambda/5=2\lambda/5\), the
ceiling already used for the absolutely bounded zero branch. The condition
\(2\eta<\kappa\) gives the strict off-diagonal margin
\(\rho>3\lambda/5-1+2\eta\). The second bound on \(\eta\) is the diagonal
condition. Fixed-divisor estimates, \(O((\log T)^3)\) dyadic blocks,
finite Mellin separators, bounded-variation endpoint removal, and both
residual orientations cost \(T^\varepsilon\). Choosing
\(\varepsilon<\kappa-2\eta\) absorbs those losses.

## Unconditional inputs tested against the required saving

A direct Kloosterman-fraction completion does not currently lead to (8).
The obstruction already appears in the full all-unit contact sum. For
coprime \(q,r\), additive reciprocity gives

\[
 e\!\left(\frac{kN}{qr}\right)
 =e\!\left(\frac{kN\overline q}{r}
            +\frac{kN\overline r}{q}\right).
 \tag{11}
\]

Bettin and Chandee's unconditional Theorem 1 in
[*Trilinear forms with Kloosterman fractions*](https://arxiv.org/abs/1502.00769)
controls one separated inverse phase. The second inverse phase in (11)
still depends on all three variables. It cannot be put into their
coefficient sequences or into the smooth perturbation allowed by their
Remark 1. The same issue prevents a direct application of the earlier
Duke--Friedlander--Iwaniec bilinear bounds. The detailed calculation is in
the [critical all-unit alias audit](actual-mobius-critical-semiprime-alias-dispersion.md#5-check-against-available-primary-estimates).

The fractional-part estimates of Saffari and Vaughan also miss this scale.
Their [Theorem 1](https://www.numdam.org/article/AIF_1977__27_2_1_0.pdf)
for \(\{x/n\}\) has error \(O(x^{1/3}y^{-1}\log x)\) when \(n\le y\).
Here a fixed \(k,r\) gives \(x\asymp kN/r\asymp P Q^3\) and
\(y\asymp Q\). Hence

\[
 \frac{x^{1/3}}y\asymp P^{1/3},
 \tag{12}
\]

which grows at every critical \(\lambda\). This theorem does not give a
vanishing discrepancy in the required block.

The missing unconditional input must use the collective \(q\ne q'\)
aliases or the determinant-weighted product resonances. It must save a
fixed power beyond the \(Q/P\) multiplicity of admissible nonzero
differences. In the high Gram block, the best written fourfold completion
has the [normalized bound](actual-mobius-double-q-fourfold-resonance-bound.md#result-and-remaining-obstruction)

\[
 T^\varepsilon\left(
   \frac Q{P^2}+\frac{P Q^3}{F^2}+\frac1Q
 \right),
 \qquad F>Q^2T^{-\kappa}.
 \tag{13}
\]

Its first term is \(Q/P^2=T^{\lambda-2}>1\) throughout (5). Any new
estimate must remove that loss while retaining the signed arithmetic
coefficients and the endpoint intervals. Such a finite exponential-sum
estimate would be weaker than RH, but no cited theorem supplies it.

## Fast falsifier for unit-density arguments

The condition \((s,q)=1\) alone gives no power saving. Take \(q\) prime
and a range with

\[
 1\le \frac{gq}{P}<q,
 \quad\text{equivalently}\quad
 \frac Pq\le g<P.                                   \tag{14}
\]

Every integer \(1\le s<gq/P\) is then automatically coprime to \(q\).
The unit filter deletes no candidate residuals. The case \(q=1\) is even
more direct: \((s,q)=1\) is vacuous. Therefore replacing the residual count
by \(\varphi(q)/q\) cannot prove (8), and completing a Ramanujan sum without
tracking the zero Fourier mode cannot do so either.

The next viable step must create cancellation across distinct products or
moduli. Further congruence identities that leave the absolute count in
(4) unchanged do not move the critical estimate.
