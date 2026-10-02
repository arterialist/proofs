# A prefix-count comparison in arXiv:2509.18963v1

A cumulative lower proportion does not justify the moving-weight
comparison used in Section 3 of the
[Grigutis–Turčinskas paper, printed page 10](https://arxiv.org/pdf/2509.18963v1#page=10).
The weight increases below its center and decreases above it, so the
prefix inequality has opposite effects on the two sides.

This review grants the paper's all-prefix count assumption. It gives a
kernel-checked counterexample to that count-to-weight inference, with
every real cutoff and arbitrarily large translated centers covered.
The marked ordinates are synthetic. The review does not disprove
Theorem 6 for the actual zeta zeros or establish a new RH bound.

The reviewed PDF is arXiv:2509.18963v1, accessed 2 October 2026,
SHA-256
27bed6642d3a2c1fb964608b09aafb3e0dac42d67ac3696cd76fec2a0f1075d8.
The [arXiv record](https://arxiv.org/abs/2509.18963) links a related
journal DOI. The paper-specific claim here concerns this pinned PDF;
the journal text has not been compared.

## The questioned inference

Write \(N(u)\) for the total cumulative count and \(C(u)\) for the
selected cumulative count. Theorem 6 assumes \(C(u)\ge cN(u)\)
for every prefix. Its proof, after partial summation, uses
\[
 -\int_\alpha^\infty C(u)f_t'(u)\,du
 \ \ge\
 -c\int_\alpha^\infty N(u)f_t'(u)\,du,
 \qquad
 f_t(u)=\frac1{\log t\,[1+(t-u)^2]}.
 \tag{1}
\]
This is the first count comparison for \(S_1\) on printed page 10,
before the total-count estimate is inserted. Its derivative is
\[
 f_t'(u)=\frac{2(t-u)}
               {\log t\,[1+(t-u)^2]^2}.
\]
For \(t>1\), multiplication by \(-f_t'\) reverses the prefix
inequality below \(t\) and preserves it above \(t\).
Thus (1) needs additional information about the resulting signed
deficit. Prefix dominance alone does not imply it.

## An exact counterexample at every translated height

For any real \(A\), take total ordinates
\[
 A+1,\ A+2,\ A+3,\ A+4
\]
and select the first three. With strict cumulative counts,
\[
 C_A(u)=\#\{j\in\{1,2,3\}:A+j<u\},\qquad
 N_A(u)=\#\{j\in\{1,2,3,4\}:A+j<u\},
\]
one has
\[
 C_A(u)\ge\tfrac34N_A(u)\qquad\text{for every real }u.
 \tag{2}
\]
Before the last point the two counts agree; after it their ratio is
exactly \(3/4\). This also handles cutoffs equal to an ordinate.

At the moving center \(t=A+4\), the unnormalized weights are

| Ordinate | Selected? | \(1/[1+(t-\gamma)^2]\) |
| --- | --- | --- |
| \(A+1\) | Yes | \(1/10\) |
| \(A+2\) | Yes | \(1/5\) |
| \(A+3\) | Yes | \(1/2\) |
| \(A+4\) | No | \(1\) |

Consequently
\[
 \sum_{\rm selected}\frac1{1+(t-\gamma)^2}
       =\frac45,\qquad
 \frac34\sum_{\rm total}\frac1{1+(t-\gamma)^2}
       =\frac{27}{20},
\]
and the selected-minus-scaled-total difference is
\[
 \boxed{-\frac{11}{20}.}
 \tag{3}
\]
For \(A\ge0\), multiplying by \(1/\log(A+4)>0\) preserves the
failure. Translation puts it above any prescribed height.
The same family satisfies the prefix premise and violates the weighted
comparison for every \(4/9<c\le3/4\).

More generally, every fixed \(0<c<1\) permits such a count
counterexample. Take total indices \(1,\ldots,M\), select the first
\(q=\lceil cM\rceil\), and put the center at \(M\). Every prefix
dominates by \(c\), whereas the selected weight is at most
\[
 \frac{q}{1+(M-q)^2}\longrightarrow0.
\]
The scaled total weight is at least \(c\), from the point at the
center. Increasing a global fraction short of one does not repair
the general inference.

## Total-count growth and coarse intervals do not repair it

The finite model is enough to reject the comparison from prefix
dominance. The issue also persists in abstract infinite spectra with
Riemann–von Mangoldt leading growth
\[
 N(u)\sim\frac{u\log u}{2\pi}.
 \tag{4}
\]
Here is a family that even retains coarse dyadic proportion bounds.
It is a construction of markings, not a proposed zeta-zero spectrum.

Fix \(0<c<1\) and \(0<\delta<(1-c)/8\). In a locally finite
simple positive spectrum satisfying (4), choose centers
\(T=\gamma_k\to\infty\). Select every ordinate except those in
\([(1-\delta)T,(1+\delta)T]\).
The removed count is
\(2\delta T\log T/(2\pi)(1+o(1))\).
Any affected prefix has total count at least \(N((1-\delta)T)\).
Its lost proportion is therefore at most
\[
 \frac{2\delta}{1-\delta}+o(1)<1-c.
\]
Unaffected prefixes lose no points.

For an affected dyadic window \([Y,2Y)\), one has
\[
 \frac{Y}{T}\in[(1-\delta)/2,\,1+\delta].
\]
The count \(N(2Y)-N(Y)\sim Y\log Y/(2\pi)\) is uniform on this
compact range of \(Y/T\). The lost window proportion is at most
\[
 \frac{4\delta}{1-\delta}+o(1)<1-c.
\]
Hence, for sufficiently large centers, the selected count is at least
\(c\) times the total count in every prefix and every dyadic window.
Every fixed finite initial selected prefix is preserved as well.

Yet the selected Poisson sum at \(T\) is
\[
 \sum_{\rm selected}\frac1{1+(T-\gamma)^2}
       =O_\delta(\log T/T)\longrightarrow0,
 \tag{5}
\]
while the total sum is at least one at \(\gamma_k=T\).
For (5), the head has \(O(T\log T)\) points at distance at least
\(\delta T\); partial summation controls the entire far tail using
\(N(u)\ll u\log u\).

These markings depend on the chosen center. No single actual
critical-line subset is asserted to have these gaps.
The construction shows what the counting hypotheses by themselves
do not determine, even with the correct leading total density.
Its analytic estimates are written proofs, separate from the finite
Lean certificate below.

## The missing signed or local input

Set \(D(u)=C(u)-cN(u)\ge0\). With the usual vanishing boundary
terms, the exact weighted difference is
\[
 \Delta_t=-\int_\alpha^\infty D(u)f_t'(u)\,du
 =-\int_\alpha^t D(u)f_t'(u)\,du
  +\int_t^\infty D(u)(-f_t'(u))\,du.
 \tag{6}
\]
The first term is adverse. The supplied prefix lower bound gives no
ordering between these two terms.
For zero-like count growth, \(N(u)f_t(u)\to0\) at infinity;
strict or inclusive choices at isolated ordinates do not change
these integrals.

A sufficient additional hypothesis is selected-count dominance in
every symmetric window about the prescribed center. Define the
closed-window counts \(C_t(v)\) and \(N_t(v)\) on \([t-v,t+v]\).
The layer-cake identity is
\[
 \Delta_t=\int_0^\infty
     \frac{2v}{\log t\,(1+v^2)^2}
        [C_t(v)-cN_t(v)]\,dv.
 \tag{7}
\]
An independently proved nonnegative weighted deficit in (6) or (7)
would also suffice. No such actual-critical-zero estimate is supplied
by this review. The separately decreasing weight involving \(t+u\)
has a valid prefix comparison; it does not validate (1).

Asymptotic proportion theorems also retain their own height and
epsilon qualifiers. A liminf alone gives eventual lower bounds for
strictly smaller constants; it does not automatically give the
endpoint constant at every prefix. That separate issue is unnecessary
for this audit, which grants the stronger all-prefix assumption.
The infinite example above also distinguishes genuine coarse dyadic
data from the local information needed by the moving kernel.

## Formal certificate and limits

The [Lean module](../../../formalization/BuildingBlocks/PrefixPoissonComparisonAudit.lean)
checks (2)--(3), strict real-cutoff endpoints, all real translations,
positive logarithmic normalization and failure above any prescribed
height. It also checks the stated \(c\)-interval.
All audited declarations use only propext, Classical.choice and
Quot.sound, with no placeholders or custom axioms.
Run lake build BuildingBlocks.PrefixPoissonComparisonAudit.

The partial-summation and layer-cake identities and the infinite
growth construction remain written mathematics.
The critical-line component is also distinct from the complete
logarithmic derivative, whose remaining zero contributions still need
control. This review supplies no full signed zeta estimate or RH
implication. It identifies the additional justification needed at
the cited proof step; the actual-zeta conclusion remains unsettled
by this audit. No originality claim is made for these elementary
counting and integration facts.
