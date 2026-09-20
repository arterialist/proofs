# One-\(Q\) Poisson recovery at the all-unit endpoint

**Status:** unconditional endpoint estimate, 20 September 2026. This
recovers the equality scale at the all-unit contact. It does not give a
strict power saving, extend the Möbius prefix, or imply RH.

## Scope and statement

The [three-factor prefix theorem](actual-mobius-k3-bottom-slice-saving.md)
stops at \(d=3\lambda/5\). Its exact endpoint residual has unrestricted
integer free factors with local coefficient \(1\). After the second \(K=3\)
expansion, the one-nonunit histories cancel and the surviving two-free
all-unit history has positive restricted divisor coefficients. No Möbius
sign remains in the sum below.

Put
\[
 q=\lambda/5,\quad p=(5-2\lambda)/5,\quad
 a=3\lambda/5-1,\qquad Q=T^q,\ P=T^p,\ A=T^a,\ N=Q^5.
\tag{1}
\]
For \(2<\lambda<29/14\),
\[
 0<p<a<q,\qquad PA=Q,\qquad PQ^2=T.               \tag{2}
\]
Fix one dyadic history and one finite Fourier--Mellin separator. Its contact
sum is
\[
 \mathcal S_0=\sum_{k\asymp P}\alpha_k
 \sum_{x\asymp Q}w_0(x)
 \sum_{q_1,q_2\asymp Q}\beta(q_1)\delta(q_2)
 W(k,x,q_1,q_2)e\!\left(-\frac{kN}{xq_1q_2}\right). \tag{3}
\]
All coefficients are divisor bounded, and
\[
 \sum_{q\asymp Q}|\beta(q)|^2+
 \sum_{q\asymp Q}|\delta(q)|^2\ll T^\varepsilon Q. \tag{4}
\]
Before separator weights, \(\beta,\delta\) are nonnegative restricted
divisor counts. The endpoint estimate is
\[
 \boxed{\mathcal S_0\ll_\varepsilon T^\varepsilon P Q^{5/2}.} \tag{5}
\]

## Poisson summation in one \(Q\)-factor

Fix \(k,q_1,q_2\) and set
\[
 \mathcal A=kN/(q_1q_2)\asymp P Q^3.              \tag{6}
\]
Poisson summation in \(x\) gives phase
\[
 f_m(x)=-\mathcal A/x-mx.                         \tag{7}
\]
Only \(m>0\) has a stationary point:
\[
 x_m=\sqrt{\mathcal A/m},\qquad m\asymp PQ.       \tag{8}
\]
At this point,
\[
 f_m(x_m)=-2\sqrt{\mathcal A m},\qquad
 |f_m''(x_m)|=2m^{3/2}/\mathcal A^{1/2},           \tag{9}
\]
and the leading term is
\[
 \frac{\mathcal A^{1/4}}{\sqrt{2}\,m^{3/4}}
 e\!\left(-2\sqrt{\mathcal A m}-\frac18\right)V(x_m/Q). \tag{10}
\]
Its amplitude is \(\asymp P^{-1/2}\).

The weights are smoothed before Poisson and vanish with the required
derivatives at each separated endpoint. Repeated integration by parts
removes the zero and negative modes. A fixed finite stationary expansion
gives finitely many separated sums with the phase in (10); the leading
amplitude is displayed there, and every later amplitude is smaller. Each
finite term is bounded by the same double-large-sieve argument below.
Choosing the expansion order after the finite number of outer variables
leaves a power-small remainder.

Starting instead with a half-weighted hard interval produces the endpoint
terms in Huxley's van der Corput transform, recorded as Theorem 1.1 of
Vandehey, [*Error term improvements for van der Corput
transforms*](https://arxiv.org/abs/1205.0090). With \(M=Q\) and Huxley's
phase parameter \(T=PQ^2\), its error per fixed \((k,q_1,q_2)\) is
\[
 O\!\left(T^\varepsilon(P^{-1/2}+\log T)\right).   \tag{11}
\]
Summing every outer tuple gives \(O(T^\varepsilon P Q^2)\). Relative to
the target in (5), this saves \(Q^{-1/2}=T^{-\lambda/10}\). The
bounded-variation partition assigns all endpoint pieces before smoothing;
none is discarded.

The leading separated contribution is
\[
 \mathcal S_{0,\mathrm{lead}}=\frac{e(-1/8)}{\sqrt{2P}}
 \sum_{\substack{k\asymp P,\ m\asymp PQ\\q_1,q_2\asymp Q}}
 a_kb_m\beta(q_1)\delta(q_2)V_{k,m,q_1,q_2}
 e\!\left(-2\sqrt{\frac{kNm}{q_1q_2}}\right).      \tag{12}
\]
The finitely many lower stationary terms have the same form with smaller
inert amplitudes. All dyadic, divisor, separator, and endpoint costs are
\(T^\varepsilon\).

## Exact product spacing

Apply the Bombieri--Iwaniec double large sieve in Robert and Sargos,
[*Three-dimensional exponential sums with monomials*, Lemma
8](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf).
Normalize
\[
 X_{k,m}=\sqrt{km/(P^2Q)},\qquad
 Y_{q_1,q_2}=Q/\sqrt{q_1q_2}.                     \tag{13}
\]
The phase is \(e(-2T X_{k,m}Y_{q_1,q_2})\). On fixed compact supports, an
\(O(T^{-1})\) spacing window in \(X\) implies
\[
 |km-k'm'|\ll P^2Q/T=P/Q<1,                       \tag{14}
\]
and hence \(km=k'm'\) for all large \(T\). Similarly,
\[
 |q_1q_2-q_1'q_2'|\ll Q^2/T=1/P<1,               \tag{15}
\]
so \(q_1q_2=q_1'q_2'\). Fixed divisor moments give the weighted spacing
energies
\[
 \mathcal E_X\ll T^\varepsilon P^2Q,\qquad
 \mathcal E_Y\ll T^\varepsilon Q^2.              \tag{16}
\]
Indeed, grouping the first energy by \(n=km\) bounds the square of a
restricted divisor coefficient over \(P\cdot PQ=P^2Q\) original pairs; the
second is identical. The restricted coefficients in (4) cost only another
fixed divisor moment.

Lemma 8 gives
\[
 |\text{inner sum in (12)}|^2
 \ll T^{1+\varepsilon}\mathcal E_X\mathcal E_Y
 \ll T^\varepsilon P^3Q^5,                       \tag{17}
\]
because \(T=PQ^2\). Taking square roots and restoring \(P^{-1/2}\) proves
(5), term by term in the finite stationary expansion.

## Sharpness and formal ledger

Both energies in (16) contain their full product diagonal. Thus this large
sieve proves exactly saving exponent \(\rho=0\). A strict improvement must
use cancellation in the Gram kernel after retaining the product diagonals.
The result improves the direct Robert--Sargos monomial bound by \(T^{p/4}\),
but supplies no endpoint power margin.

[ActualMobiusCriticalOneQPoissonEndpoint.lean](../../formalization/BuildingBlocks/ActualMobiusCriticalOneQPoissonEndpoint.lean)
checks the scale identities, spacing exponents, large-sieve exponent, and
stationary normalization. Its
[axiom audit](../../formalization/verification/ActualMobiusCriticalOneQPoissonEndpointAudit.lean)
checks the declaration set and transitive axioms. The analytic Poisson,
stationary-phase, and double-large-sieve inputs remain external.
