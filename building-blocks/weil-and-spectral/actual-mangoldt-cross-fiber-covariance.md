# The complete Mangoldt cross-fiber covariance gate

**Status:** exact recombination, quantitative stopping obstruction, and
unit-twist falsifier, 20 September 2026. The divisor-fiber identity is
Lean-verified in
[`ActualMobiusHistoryCrossSum.lean`](../../formalization/BuildingBlocks/ActualMobiusHistoryCrossSum.lean).
The scale, target, and loss ledger is Lean-verified in
[`ActualMangoldtCrossFiberCovariance.lean`](../../formalization/BuildingBlocks/ActualMangoldtCrossFiberCovariance.lean).
The reciprocal large-sieve reduction and aligned-twist estimate below are
written mathematics. No new upper bound or Riemann-hypothesis conclusion is
claimed.

## Exact packet and target

At the critical contact, put

\[
 D=Q^3,\qquad N=Q^5,\qquad T=PQ^2,
 \tag{1}
\]

where

\[
 P=T^{1-2\lambda/5},\qquad Q=T^{\lambda/5},
 \qquad 2<\lambda<\frac{29}{14}.
 \tag{2}
\]

Complete every divisor fiber before taking a norm:

\[
 \sum_{m\ell=d}\mu(m)\log\ell=\Lambda(d).
 \tag{3}
\]

This retains \(\Lambda(p^a)=\log p\) for every prime power. The resulting
live packet is

\[
 \mathcal S=
 \sum_{k\asymp P}a_k
 \sum_{d\asymp D}\Lambda(d)W_k(d/D)
 e\!\left(-\frac{kN}{d}\right),
 \qquad |a_k|\le1,
 \tag{4}
\]

where the packet supplies smooth weights with uniformly bounded inert
seminorms. Its exact pre-norm covariance is

\[
 \boxed{
 |\mathcal S|^2=
 \sum_{k,k'\asymp P}a_k\overline{a_{k'}}
 \sum_{d,d'\asymp D}\Lambda(d)\Lambda(d')
 W_k(d/D)\overline{W_{k'}(d'/D)}
 e\!\left(-N\left(\frac kd-\frac{k'}{d'}\right)\right).}
 \tag{5}
\]

No Cauchy step has split a product fiber in (5). The zero-saving endpoint
and a strict target are

\[
 |\mathcal S|\ll_\varepsilon T^\varepsilon P Q^{5/2},
 \qquad
 |\mathcal S|\ll_\varepsilon
 T^\varepsilon P Q^{5/2}T^{-\rho}
 \quad(\rho>0).
 \tag{6}
\]

Thus the covariance in (5) must be at most

\[
 \boxed{T^\varepsilon P^2Q^5T^{-2\rho}.}
 \tag{7}
\]

## Diagonal and coefficient-blind bound

Put

\[
 \Delta=kd'-k'd.
 \tag{8}
\]

The equal-slope solutions \(\Delta=0\), including nonprimitive rational
representations and proper prime powers, contribute

\[
 \mathcal C_{\Delta=0}\ll_\varepsilon T^\varepsilon PD
 =T^\varepsilon P Q^3.
 \tag{9}
\]

Relative to (7) with \(\rho=0\), this saves

\[
 \frac{P Q^3}{P^2Q^5}=\frac1{PQ^2}=\frac1T.
 \tag{10}
\]

The obstruction is the signed \(\Delta\ne0\) covariance. Cauchy in the
outer modes and the reciprocal large sieve give the coefficient-blind bound

\[
 |\mathcal S|^2
 \le \left(\sum_k|a_k|^2\right)
 \sum_{k\asymp P}\left|
   \sum_d\Lambda(d)W_k(d/D)e(-kN/d)
 \right|^2
 \ll_\varepsilon T^\varepsilon P D^2
 =T^\varepsilon P Q^6.
 \tag{11}
\]

The frequencies \(N/d\) traverse \(N/D=Q^2\) integer branches. On each
branch the \(1/P\) coherence condition restricts \(d'\) to an interval of
length

\[
 \frac{D^2}{NP}=\frac QP.
 \tag{12}
\]

There are \(D/P\) near aliases per row, each with kernel height \(P\).
Together with
\(\sum_{d\asymp D}\Lambda(d)^2\ll D\log D\), the reciprocal large-sieve
spacing argument proves (11). Its ratio to the zero-saving target is

\[
 \frac{P Q^6}{P^2Q^5}=\frac QP
 =T^{3\lambda/5-1}.
 \tag{13}
\]

Complete recombination therefore reveals the actual prime weights but does
not recover the endpoint.

## Exact determinant fibers

Fix \(k,k'\) and \(\Delta\ne0\), and put \(g=(k,k')\). Each determinant
fiber is

\[
 d=d_0+\frac kg t,
 \qquad
 d'=d'_0+\frac{k'}g t,
 \tag{14}
\]

on an interval of length \(Y\asymp gD/P\). The arithmetic coefficient on
this fiber is the actual two-linear-form product

\[
 \Lambda\!\left(d_0+\frac kg t\right)
 \Lambda\!\left(d'_0+\frac{k'}g t\right),
 \tag{15}
\]

and its phase is

\[
 e\!\left(-\frac{N\Delta}{dd'}\right).
 \tag{16}
\]

For a typical determinant \(|\Delta|\asymp PD\), the derivative of (16)
in \(t\) has size \(P^2/(gQ)\). A bounded-variation phase cell consequently
has length

\[
 Y_0\asymp\frac{gQ}{P^2}.
 \tag{17}
\]

The numerous coprime fibers have

\[
 Y_0=\frac Q{P^2}=T^{\lambda-2}.
 \tag{18}
\]

Its exponent ranges from \(0\) to \(1/14\) in (2). A prime-specific
estimate would have to control (15), with the phase (16), on these
prescribed short cells and then average it over \(k,k',\Delta\). Cauchy,
Plancherel, or a one-prime progression variance drops one copy of
\(\Lambda\) and returns (11).

## Completely multiplicative twist falsifier

Let \(\chi\) be completely multiplicative with \(|\chi(n)|=1\). The
complete-fiber identity is equivariant:

\[
 \sum_{m\ell=d}\mu(m)\chi(m)\log\ell\,\chi(\ell)
 =\chi(d)\Lambda(d).
 \tag{19}
\]

Fix one allowed mode \(k_0\), choose a nonnegative smooth \(W\) supported
inside \((1,2)\), and prescribe

\[
 \chi(p)=e(k_0N/p)
 \tag{20}
\]

on every prime. Extend \(\chi\) completely multiplicatively and support
the outer coefficients at \(k_0\). Every ordinary-prime term in the twisted
packet then has positive real phase. The prime number theorem, together
with the elementary total weight of proper prime powers, gives

\[
 \left|\sum_d\chi(d)\Lambda(d)W(d/D)e(-k_0N/d)\right|
 \ge c_WD-O(\sqrt D\log D)\gg_WD.
 \tag{21}
\]

Its covariance is therefore \(\gg D^2=Q^6\). Relative to the squared
zero-saving target, the ratio is

\[
 \frac{Q^6}{P^2Q^5}=\frac Q{P^2}
 =T^{\lambda-2}>1.
 \tag{22}
\]

Hence no proof of (7) can be uniform in the outer sequence and depend on
the prime coefficient only through complete convolution identities,
support, magnitudes, or positive norms. Such a proof would also apply to
(20), which violates even \(\rho=0\) by a fixed power. The falsifier does
not construct a large value for the fixed physical outer coefficients. It
does not apply to an argument that evaluates their untwisted prime main term
or uses another property destroyed by (20).

## Literature comparison and next admissible input

The reciprocal large sieve in (11) is the same coefficient-blind mechanism
used at the
[one-\(Q\) endpoint](actual-mobius-critical-one-q-poisson-endpoint.md#exact-product-spacing).
The standalone
[reciprocal-prime derivative estimates](actual-reciprocal-prime-high-cofactor-saving.md#weighted-reciprocal-phase-estimate)
are pointwise in the outer mode. Squaring those estimates does not beat
(11) in the range (2). Standard prime-pair theorems do not give a uniform
asymptotic for two affine prime forms on every prescribed interval of length
\(T^{\lambda-2}\).

The next admissible input is an untwisted main-term identity, a
non-twist-equivariant arithmetic constraint before Cauchy, or a new average
estimate for the phase-weighted two-linear-form fibers (15). Another
coefficient-uniform norm or spacing estimate cannot close (13).
