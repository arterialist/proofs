# Center averaging of the exact reciprocal Möbius packet

**Status:** unconditional written analytic estimate, 20 September 2026. The
reciprocal-kernel calculation is elementary and uses the exact Möbius
coefficient before Vaughan decomposition. The scale identities and exponent
range are formalized and axiom-audited in
[`ActualMobiusReciprocalCenterAverage.lean`](../../formalization/BuildingBlocks/ActualMobiusReciprocalCenterAverage.lean).
The oscillatory-integral estimate, bounded-variation transfer, Poisson-shell
summation, and Markov step are written mathematics, not Lean. This proves an
almost-all-center bound for a complete dyadic prefix of the actual
Möbius packet. It does not control the endpoint shell, the remaining tail,
or prove the Riemann hypothesis.

## Statement

Fix \(T\geq2\), \(X=T^\lambda\), and let the real packet center \(N\) vary
in \([X,2X]\). Put \(H_N=N/T\), and retain the exact pole-null packet

\[
 L_m(N,T)=\sum_{n\geq1}(\log n)g_N(mn),
 \qquad
 P_1(N,T)=\sum_{m\geq1}\mu(m)L_m(N,T).
\tag{1}
\]

The identity \(\log=\Lambda*1\) makes (1) exactly the complete prime packet
\(\sum_d\Lambda(d)g_N(d)\). Thus every weight
\(\Lambda(p^j)=\log p\), including proper prime powers, is retained.

Let \(I_D\subset[D,2D]\) be an integer interval and define

\[
 S_D(N,T)=\sum_{m\in I_D}\mu(m)L_m(N,T).
\tag{2}
\]

Uniformly for \(X/T\ll D\ll X\),

\[
 \boxed{
 \left(\frac1X\int_X^{2X}|S_D(N,T)|^2\,dN\right)^{1/2}
 \ll (\log T)^C
 \left(\sqrt{\frac D X}+\frac D{\sqrt{TX}}\right).}
\tag{3}
\]

Here \(C\) and the implied constant depend only on the fixed packet data.
No cancellation property of \(\mu\) is used in (3); the same estimate holds
for coefficients \(a_m\) satisfying
\(\sum_{m\in I_D}|a_m|^2\ll D(\log T)^C\).

Consequently, for fixed \(\eta>0\), dyadic summation gives

\[
 \boxed{
 \left(\frac1X\int_X^{2X}
 \left|\sum_{m\leq T^{(\lambda+1)/2-\eta}}
       \mu(m)L_m(N,T)\right|^2dN\right)^{1/2}
 \ll_{\eta}(\log T)^C
 \left(T^{-(\lambda-1)/4-\eta/2}+T^{-\eta}\right).}
\tag{4}
\]

The smaller shells \(D\ll X/T\), where the natural nonzero Poisson-mode
length \(L=DT/X\) is below one, are absorbed by the uniform Schwartz decay
in the exact Poisson formula. More explicitly, summing (15) over
\(r\geq1/L\) gives, for any fixed \(A>1\),

\[
 \operatorname{RMS}_D\ll(\log T)^C\left[
 \sqrt{\frac D X}L^{A-1}
 +\frac D{\sqrt{TX}}L^{A-1/2}\right].
\tag{4a}
\]

This is more than sufficient to sum the low-\(L\) shells into (4). Put

\[
 c_{\lambda,\eta}=
 \min\left\{\eta,\frac{\lambda-1}{4}+\frac\eta2\right\}.
\tag{4b}
\]

For \(\lambda>1\), Markov's inequality shows that the expression in (4) is
at most \(T^{-c_{\lambda,\eta}/2}\) outside a set of relative measure
\(O((\log T)^{2C}T^{-c_{\lambda,\eta}})\).

At \(\lambda=2\), (4) reaches every fixed exponent
\(d<3/2\). The prior pointwise Robert--Sargos--Bordellès endpoint is
\(d_*=6/5\), so center averaging gains the fixed exponent interval

\[
 \frac65<d<\frac32.
\tag{5}
\]

## The reciprocal center kernel

For \(e(u)=e^{2\pi i u}\), direct integration gives

\[
 \left|\frac1X\int_X^{2X}e(-\alpha N)\,dN\right|
 \leq \min\left\{1,\frac1{\pi X|\alpha|}\right\}.
\tag{6}
\]

If \(m,n\in[D,2D]\), \(m\ne n\), and \(k\asymp K\), then

\[
 \left|\frac1m-\frac1n\right|
 =\frac{|m-n|}{mn}\geq\frac{|m-n|}{4D^2}.
\tag{7}
\]

Equations (6)--(7) imply

\[
 \left|\frac1X\int_X^{2X}
 e\!\left(-kN\left(\frac1m-\frac1n\right)\right)dN\right|
 \ll \min\left\{1,\frac{D^2}{XK|m-n|}\right\}.
\tag{8}
\]

The diagonal contributes one. Summing (8) over a row and using the harmonic
sum gives

\[
 \sup_m\sum_n |\mathcal K_k(m,n)|
 \ll 1+\frac{D^2}{XK}\log(2D).
\tag{9}
\]

The Schur bound, or just \(2|a_ma_n|\leq|a_m|^2+|a_n|^2\), therefore yields

\[
 \frac1X\int_X^{2X}
 \left|\sum_{m\in I_D}a_m e(-kN/m)\right|^2dN
 \ll
 \left(1+\frac{D^2}{XK}\log(2D)\right)
 \sum_{m\in I_D}|a_m|^2.
\tag{10}
\]

This is center orthogonality between distinct reciprocal phases. It is not
a Möbius-correlation estimate and uses no hypothesis about zeta zeros.

## Bounded-variation packet weights

The exact zero-mode-free Poisson identity is

\[
 L_m(N,T)=\frac{H_N}{m\sqrt N}\sum_{k\ne0}e(-kN/m)
 \left[
 \log(N/m)\widehat G_T(kH_N/m)
 +\widehat Q_T(kH_N/m)
 \right],
\tag{11}
\]

where \(Q_T(v)=\log(1+v/T)G_T(v)\),
\(\widehat G_T(0)=\widehat Q_T(0)=0\), and both Fourier-transform families
are uniformly Schwartz; \(\widehat Q_T\) has an additional factor
\(T^{-1}\). Formula (11) includes the literal product cutoff and has no
zero-frequency remainder.

There is no frozen-weight gap in applying (10). If complex weights
\(W_m(N)\) have uniformly bounded supremum and total variation, then the
product \(W_m(N)\overline{W_n(N)}\) has the same property up to an absolute
constant. Stieltjes integration by parts changes (6) only by that constant:

\[
 \left|\frac1X\int_X^{2X}W_m(N)\overline{W_n(N)}
 e(-\alpha N)\,dN\right|
 \ll \min\left\{1,\frac1{X|\alpha|}\right\}.
\tag{12}
\]

On fixed dyadic \(m\)- and \(k\)-blocks, extract the constant prefactor
\(\sqrt X/(TD)\) and write its varying remainder as
\(\sqrt{N/X}\,D/m\). This remainder is uniformly bounded and has uniformly
bounded variation. Every other factor in (11), after extracting at most a
power of \(\log T\), has the same property as \(N\) runs from \(X\) to
\(2X\). Indeed,
\(kH_N/m=kN/(Tm)\) traverses a fixed multiplicative interval, and the
Schwartz derivative bounds control its variation. The factors
\(\log(N/m)\) and smooth dyadic partitions have the same property. Hard
interval endpoints may be frozen at the \(X\)-scale; viewed
as step weights, their finitely many jumps are also covered by (12).

## Poisson modes and normalization

Put

\[
 L=\frac{DT}{X}
\tag{13}
\]

and split \(|k|\asymp J=rL\). For one such block, (9) has the exact physical
scale

\[
 \frac{D^2}{XJ}=\frac{D}{rT}.
\tag{14}
\]

Apply Cauchy--Schwarz to the outer \(k\)-sum. There are \(O(J)\) modes, the
coefficient energy is \(O(D(\log T)^C)\), and the Poisson prefactor in
(11) is comparable to \((L\sqrt X)^{-1}\). Thus the block root mean square
is

\[
 \ll (\log T)^C r\,\omega(r)
 \left(
 \sqrt{\frac D X}+\frac D{\sqrt{rTX}}
 \right),
\tag{15}
\]

where \(\omega(r)\ll r\) for \(r\leq1\), by the two exact zero modes, and
\(\omega(r)\ll_A r^{-A}\) for \(r\geq1\), by uniform Schwartz decay.
Both terms in (15) are summable over dyadic \(r\), proving (3). Negative
modes are identical after conjugation. This proof uses the original
coefficient \(\mu(m)\) in (2), so no Vaughan cross term, free-factor slice,
or complementary rectangle is omitted.

Writing \(D=T^d\), the two powers in (3) are

\[
 E_1=\frac{d-\lambda}{2},
 \qquad
 E_2=d-\frac{\lambda+1}{2}.
\tag{16}
\]

Both are negative for \(d<(\lambda+1)/2\) when \(\lambda>1\). At
\(d=(\lambda+1)/2-\eta\), the second is exactly \(-\eta\), while the first
is \(-(\lambda-1)/4-\eta/2\). These identities are Lean-checked.

## Frontier and decisive test

The proof uses only exact Poisson summation, elementary integration by
parts, finite Schur/Cauchy--Schwarz inequalities, and the divisor-bounded
coefficient energy. It is therefore strictly weaker than RH and independent
of the signed reciprocal-correlation input isolated in the earlier
[short-shift reduction](actual-mobius-reciprocal-short-shift-reduction.md).
It improves the repository's preceding pointwise endpoint only because the
packet center is averaged. No literature-priority claim is made.

The gain does not close the exact remaining tail at the critical geometry.
For \(\lambda=2\), stopping (4) at
\(D=T^{3/2-\eta}\) leaves, after the exact support swap, outer logarithmic
variables as large as \(n\asymp T^{1/2+\eta}\). The available
almost-all-short-interval Möbius theorem applies only to every fixed range
\(n\leq T^{1/2-\delta}\). The band around \(T^{1/2}\) is therefore not
covered. At the endpoint \(D=T^{3/2}\), the second term of (3) is of order
one, so the failure is visible directly in the proved inequality.

Nor can a favorable center supplied by Markov be inserted into a
fixed-center off-line-zero contradiction without a separate uniform
translation argument. A hypothetical fixed zero with real part
\(\beta<1\) is not excluded merely by (3), and no such translation theorem
is asserted here. The result is an unconditional fixed-power constraint on
the exact arithmetic packet, but it remains below RH scale.
