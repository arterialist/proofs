# Exact centering of the high product-divisor kernel

**Status:** unconditional written identity for the canonical fourfold
product kernel, 20 September 2026.  The finite double-centering algebra is
Lean-checked.  The Poisson support argument, divisor Fourier expansion, and
periodic variance formula remain written mathematics.  No local covariance
estimate or Riemann-hypothesis conclusion is proved.

## The completed kernel

Continue from the
[fourfold high-block completion](actual-mobius-double-q-fourfold-resonance-bound.md),
with

\[
 T=PQ^2,\qquad N=Q^5,\qquad C_0=\frac N{qr},
 \qquad Q^2\le F\le T^{1-\kappa}.
 \tag{1}
\]

After the exact \(m,m'\) transforms, put

\[
 s=\frac12\left(\frac{k}{n}+\frac{k'}{n'}\right),
 \qquad z=\frac{k}{n}-\frac{k'}{n'}.
 \tag{2}
\]

The physical phase is exactly \(-C_0z\).  Poisson summation in \(k,k'\)
introduces \(A=\ell n\) and \(A'=\ell'n'\).  A separated component has the
form

\[
 \sum_{A,A'\in\mathbb Z}d_\theta(A)d_{\theta'}(A')I(A,A'),
 \tag{3}
\]

where

\[
 \begin{aligned}
 I(A,A')=\iint K(s,z)e\!\left(
  -C_0z-A(s-z/2)+A'(s+z/2)\right)\,ds\,dz,\\
 d_\theta(A)=\sum_{n\mid A}\theta(n/Q).
 \end{aligned}
 \tag{4}
\]

Here \(K\) is smooth and compactly supported, and the sums defining
\(d_\theta\) retain only the finite support \(n\asymp Q\).  The whole
integer lattice in (3), including rapidly decreasing tails, is essential.
A hard truncation to the two resonance windows does not preserve the next
identity.

## Exact zero rows and columns

On the support,

\[
 s\asymp \frac P Q,\qquad |z|\ll\frac F{Q^3},
 \qquad \frac{|z|}{s}\ll\frac FT\le T^{-\kappa}.
 \tag{5}
\]

Thus, for large \(T\), both \(s-z/2\) and \(s+z/2\) lie strictly between
zero and one.  Summing (4) over the full \(A\)-lattice inserts the Dirac
comb at \(s-z/2\in\mathbb Z\), which misses the support.  Summing over
\(A'\) gives the same conclusion at \(s+z/2\).  Absolute rapid decay of
the Fourier coefficients justifies the rearrangements, so

\[
 \sum_A I(A,A')=0,
 \qquad
 \sum_{A'}I(A,A')=0.
 \tag{6}
\]

Set

\[
 c_\theta=\sum_n\frac{\theta(n/Q)}n,
 \qquad E_\theta(A)=d_\theta(A)-c_\theta.
 \tag{7}
\]

Applying both identities in (6) gives the exact signed constraint

\[
 \boxed{
 \sum_{A,A'}d_\theta(A)d_{\theta'}(A')I(A,A')
 =\sum_{A,A'}E_\theta(A)E_{\theta'}(A')I(A,A').}
 \tag{8}
\]

The constants in (7) could be replaced by arbitrary constants.  Their
chosen values are the exact periodic means of the restricted divisor
coefficients.

The theorem
[`kernelPairing_centered`](../../formalization/BuildingBlocks/ActualMobiusProductDivisorCentering.lean)
formalizes the finite algebra behind (8) over an arbitrary commutative ring:
zero row and column sums make double centering exact.  Its companion
[axiom audit](../../formalization/verification/ActualMobiusProductDivisorCenteringAudit.lean)
checks the entire module and finds only `propext`, `Classical.choice`, and
`Quot.sound`.  Lean does not formalize the analytic Poisson argument proving
(6).

## The centered coefficient is still large globally

For integer \(A\), finite character orthogonality gives

\[
 E_\theta(A)=
 \sum_n\frac{\theta(n/Q)}n
 \sum_{h=1}^{n-1}e(hA/n).
 \tag{9}
\]

The removed \(h=0\) mode is inactive already: the support in (5) selects
physical rational frequencies of size \(P/Q\), away from zero.  Centering
therefore exposes the covariance but does not itself create a saving.

This obstruction is quantitative.  Let \(L\) be a common multiple of every
\(n\) in the support and take real weights.  Exact counting of simultaneous
divisibility classes yields

\[
 \frac1L\sum_{A\bmod L}E_\theta(A)^2
 =\sum_{n,m}\theta(n/Q)\theta(m/Q)
   \frac{\gcd(n,m)-1}{nm}.
 \tag{10}
\]

For nonnegative \(\theta\), every term is nonnegative.  If \(\theta\) is
bounded below on a fixed interval inside \(n\asymp Q\), the diagonal
\(n=m\) alone makes (10) bounded below by a positive constant.  Hence mean
subtraction does not make the coefficient power-small over a full period.
Equation (10) does not rule out cancellation in the particular short moving
windows imposed by \(C_0=N/(qr)\).

## Precise remaining estimate

Normalize each Fourier integral by its natural size

\[
 M=\frac{P^2F}{Q^2}
 \tag{11}
\]

and let \(R_F\) denote the centered sum in (8), including \(q,r\asymp Q\)
and the finitely separated smooth components.  Absolute resonance counting
gives

\[
 |R_F|\ll_\varepsilon T^\varepsilon\frac{Q^6}{PF}.
 \tag{12}
\]

To place the leading Gram block a fixed power below its target, it would
suffice to prove, uniformly in the range (1),

\[
 \boxed{
 |R_F|\ll_\varepsilon T^\varepsilon
 \frac{P Q^5}{F}T^{-\delta}}
 \qquad(\delta>0).
 \tag{13}
\]

Relative to (12), this requires the factor

\[
 \frac{P^2}{Q}T^{-\delta}
 =T^{-(\lambda-2)-\delta}
 \tag{14}
\]

at the critical parametrization.  Neither (8) nor (10) proves (13).  They
identify the legitimate signed object: a local covariance of centered,
positive restricted-divisor fluctuations against the actual Fourier kernel.
There is no Möbius coefficient left in this canonical residual, and no
complete-fiber \(\Lambda(d)e(-kN/d)\) representation is used.
