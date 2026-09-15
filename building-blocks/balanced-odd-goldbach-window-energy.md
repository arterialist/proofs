# Balanced odd Goldbach pairs in the actual window energy

Developed in the RH Agent3 branch, with independent mathematical review by RH Proof. The analytic conclusions remain written proofs; no novelty claim is made.

Written mathematics. The infinite identity in its absolute-convergence
range, angular factor, and origin correction were independently audited
by the Sol medium math worker. This identifies the actual positive
window energy with balanced weighted additive pairs. It supplies no
RH-strength bound or Lean theorem.

Let \(Z\) be the fixed real packet correlation, smooth and compactly
supported in \((0,L)\), \(L=\log2\). Let
\(a_n=\Lambda(n)-2\) for odd \(n\ge1\), including \(a_1=-2\),
and use the actual readout

\[
J(P)=\sum_{n\ge1,\ n\text{ odd}}a_n n^{-1/2}Z(\log(n/P)).
\]

No prime-only replacement is made. Odd proper powers and every ordered
pair are retained.

## Finite positive energy with the horizon retained

For finite \(X\ge1\) and real \(\eta\ge0\), define

\[
\mathcal E_\eta(X)=\int_1^X P^{-\eta-1}J(P)^2dP.
\]

The readout observes only \(P<n<2P\). Expanding this finite sum,
putting \(N=m+n\), \(r=m/N\), and \(t=P/N\), gives exactly

\[
\mathcal E_\eta(X)=
\sum_{\substack{N\le4X\,,\ N\text{ even}}}N^{-\eta-1}
\sum_{\substack{m+n=N\,,\ m,n\text{ odd}}}
a_m a_n H_{\eta;N,X}(m/N),
\]

where

\[
H_{\eta;N,X}(r)=[r(1-r)]^{-1/2}
\int_{1/N}^{X/N}t^{-\eta-1}
Z(\log(r/t))Z(\log((1-r)/t))dt.
\]

The clipping limits preserve both the initial state and the observation
horizon. Terms at support endpoints are zero by the actual smooth
test; no nonzero boundary is dropped. This is a positive integral
and a finite Gram expansion for every \(\eta\ge0\). It is not
an infinite signed-series claim in the critical range.

## Full angular factor and the absolute-convergence range

Set

\[
H_\eta(r)=[r(1-r)]^{-1/2}
\int_0^\infty t^{-\eta-1}
Z(\log(r/t))Z(\log((1-r)/t))dt.
\]

Nonzero integrands require both \(r/t\) and \((1-r)/t\) in
\((1,2)\). Hence \(H_\eta\) is smooth, symmetric, and supported
compactly inside \((1/3,2/3)\). For odd \(m,n\ge3\), they also
require \(P>\max(m,n)/2\ge3/2\). Thus extending the lower
endpoint to zero does not alter these pairs.

For \(\eta>1\), absolute convergence follows from bounded
\(H_\eta\), \(O(N)\) pairs of total \(N\), and
\(|a_n|\ll1+\log n\). The majorant is
\(\sum_N O(N^{-\eta}\log^2N)<\infty\). Therefore

\[
\mathcal E_\eta(\infty)=
\sum_{\substack{N\ge6\,,\ N\text{ even}}}N^{-\eta-1}
\sum_{\substack{m+n=N\,,\ m,n\text{ odd}}}
a_m a_n H_\eta(m/N).
\]

The original state-one coefficient is present in the source but its
test vanishes for \(P\ge1\). In a fully extended \(P>0\)
expansion, its only nonzero pairing is \((1,1)\), contributing

\[
4\int_0^L e^{\eta v}Z(v)^2dv.
\]

This is exactly the \(N=2\) term and must be subtracted when using
that extended expansion. At \(N=4\), the pairs \((1,3)\) and
\((3,1)\) have ratios \(1/4\) and \(3/4\), outside the angular
support, so their contributions are zero.

## Exact angular autocorrelation

Put \(Z_\eta(v)=e^{\eta v/2}Z(v)\). The substitution
\(t=\sqrt{r(1-r)}e^{-u}\) gives

\[
H_\eta(r)=[r(1-r)]^{-(\eta+1)/2}
\int Z_\eta(u+d/2)Z_\eta(u-d/2)du,
\qquad d=\log\frac r{1-r}.
\]

In particular
\(H_\eta(1/2)=2^{\eta+1}\|Z_\eta\|_2^2>0\) for nonzero
\(Z\), and the angular factor is positive near equal endpoints.
An autocorrelation is positive definite, but that fact supplies no
global pointwise sign. The centered products \(a_m a_n\) can
have either sign, so the angular factor cannot be removed by an
entrywise comparison with the unweighted additive heat kernel.

The actual balanced coefficient can also be expanded finitely as

\[
\sum_{m+n=N\,,\ m,n\text{ odd}}a_m a_n H_\eta(m/N)
=R_{H,\rm odd}(N)
-4\sum_{m<N\,,\ m\text{ odd}}\Lambda(m)H_\eta(m/N)
+4\sum_{m<N\,,\ m\text{ odd}}H_\eta(m/N),
\]

where \(R_{H,\rm odd}\) retains the full two-Mangoldt product
with the same angular weight. Symmetry of \(H_\eta\) gives the
coefficient \(-4\); the ordered-pair convention is unchanged.

The positive window energy and the branch's positive additive heat
energy use the same actual odd-centered coefficients, with different
pair kernels. The finite formula above makes their difference
explicit. No infinite expansion for \(0\le\eta\le1\), bounded
critical energy, comparison of the two norms, or upper signed-work
budget is proved here. Those actual quantitative estimates remain
necessary for the RH objective.
