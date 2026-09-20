# Ordered cross sums of localized Möbius histories

**Status:** unconditional finite real identity, 20 September 2026. The
pre-transform algebra is formalized in
[`ActualMobiusHistoryCrossSum.lean`](../../formalization/BuildingBlocks/ActualMobiusHistoryCrossSum.lean).
No analytic estimate or Riemann-hypothesis conclusion is claimed.

This note tests whether the exact prime-birth/complete-future law survives the
localized Möbius decomposition used at the critical all-unit endpoint. It
retains the actual identity

\[
 \sum_{m\mid d}\mu(m)\log(d/m)=\Lambda(d),
 \tag{1}
\]

including \(\Lambda(p^a)=\log p\) for every prime power.

## Localized histories and the exact quadratic law

Let \(\mathcal I\) be any finite partition of the divisor pairs \((m,r)\)
with \(mr=d\). The parts may be dyadic ranges, individual divisors, or any
other labels. Put

\[
 H_I(d)=\sum_{\substack{mr=d\\(m,r)\text{ labelled }I}}
          \mu(m)\log r.
 \tag{2}
\]

These are real histories before any Fourier or Poisson transform. Because
every divisor pair has exactly one label, (1) gives

\[
 \sum_{I\in\mathcal I}H_I(d)=\Lambda(d).
 \tag{3}
\]

Squaring (3) without discarding cross terms gives the exact **ordered
off-diagonal cross sum**

\[
 \boxed{
 \sum_{\substack{I,J\in\mathcal I\\I\ne J}}H_I(d)H_J(d)
 =\Lambda(d)^2-\sum_{I\in\mathcal I}H_I(d)^2.}
 \tag{4}
\]

Both orientations \((I,J)\) and \((J,I)\) occur. After choosing an order on
the labels, the corresponding unordered-pair formula is

\[
 2\sum_{I<J}H_I(d)H_J(d)
 =\Lambda(d)^2-\sum_I H_I(d)^2.
 \tag{5}
\]

For every integer which is not a prime power, \(\Lambda(d)=0\). Hence the
**aggregate** ordered off-diagonal cross sum satisfies

\[
 \boxed{
 \sum_{I\ne J}H_I(d)H_J(d)
 =-\sum_I H_I(d)^2.}
 \tag{6}
\]

This does not assert that each individual cross product is negative. It is a
finite signed conservation law for the complete aggregate, not an
RH-equivalent estimate.

For \(d=pq\), with distinct primes and the four individual divisor labels,
the history values are

\[
 \log(pq),\qquad-\log q,\qquad-\log p,\qquad0.
 \tag{7}
\]

They sum to zero, and their aggregate ordered off-diagonal products sum to
the negative of their squared norms. At \(d=p^a\), only the \(m=1,p\)
histories survive; their values \(a\log p\) and \(-(a-1)\log p\) sum to the
required \(\log p\).

## Test against the critical endpoint decomposition

The current K3 all-unit coefficient does not contain the full family (2).
At \(pq\) it is

\[
 \tau(pq)-3=-1+(\tau(pq)-2)=-1+2=1,
 \tag{8}
\]

as recorded in the
[K3 bottom-slice note](actual-mobius-k3-bottom-slice-saving.md#exact-mixed-semiprime-history-count).
The zero in (7) appears only after restoring the external \(\log r\) future
factor and all divisor choices. Consequently, grouping the K3 all-unit
histories by product does not by itself inherit (6).

Before Poisson summation the actual prime row has exactly the required real
form:

\[
 \sum_m\mu(m)L_m(T)
 =\sum_{m,r}\mu(m)\log r\,g_N(mr)
 =\sum_d\Lambda(d)g_N(d).
 \tag{9}
\]

Poisson summation in \(r\) for each fixed \(m\) is exact and invertible, but
it sends common-product histories to different complex reciprocal phases.
The real identity (4) does not apply unchanged to those complex amplitudes.
For a finite complex family \((A_I)\), the Hermitian counterpart is

\[
 \sum_{I\ne J} A_I\overline{A_J}
 =\left|\sum_I A_I\right|^2-\sum_I|A_I|^2.
 \tag{10}
\]

The later \(n,r\) variables in the double-Q Gram reduction have not been
identified with a complete product-indexed family of transformed histories.
Therefore (4) does not locate a first irreversible loss at that Cauchy step
and does not by itself supply a signed estimate for its Gram matrix.

## What the identity does and does not supply

Equation (6) constrains the aggregate of a complete real divisor history.
An individual dyadic block is incomplete and has no fixed sign, as (7)
already shows. Regrouping all labels before transformation recovers exactly
the original actual-\(\Lambda\) packet in (9), so the identity gives no new
upper bound. Retaining transformed oscillation while proving a useful
complete Hermitian cross-sum estimate remains an open analytic problem; the
finite identity and its Lean formalization do not prove such an estimate.
