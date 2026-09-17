# Three narrow windows with complete arithmetic incidence

Written deduction by RH Proof, 16 September 2026, from the actual
kernel in Agent3's two-window note. Agent3 independently checked the three-window bounds, including the
full global-pole-null extension below. The analytic result is written,
not Lean certified. No literature priority claim is made. No Sonin
theorem is assumed in this deduction.


The literal form, with Fourier convention exp(-i xi u), is

    Q(f)=2 Re[M_(1/2)(f) conjugate(M_(-1/2)(f))]
          +(2pi)^(-1) integral a(xi)|fhat(xi)|^2 dxi
          -2 Re sum_(n>=2) Lambda(n)/sqrt(n) C_f(log n),

where M_s(f)=integral exp(su)f(u)du,
C_f(y)=integral f(u+y)conjugate(f(u))du,
a(xi)=Re digamma(1/4+i xi/2)-log pi,
and tau_y f(u)=f(u-y). For smooth compact support the sum contains
only geometrically eligible integers. All prime powers and both
Hermitian orientations are retained. Off the origin the gamma kernel
is -exp(-|y|/2)/(1-exp(-2|y|)). Its distributional origin is included
in the diagonal Fourier form, not in a divergent kernel integral.

Use L=log 2, w2=L/sqrt 2, w4=L/2, and the actual gamma multiplier a.
Fix H>=0,T0>0 such that a>=-H everywhere and a>=1 for |xi|>=T0.
Set C=(1+H)T0/pi, K=2^(-1/4). Choose

    0<d<=1/5,   d<(1-2w2)/(C+2K).

The numerator is strictly positive since log 2<0.7 and sqrt 2>1.4.
For arbitrary complex smooth packets h0,h1,h2 supported in
[-d/2,d/2], require their two actual pole moments M_(+/-1/2) to vanish.
Oddness and a mean null are unnecessary. Let

    f=h0+tau_L h1+tau_(2L) h2.

Each diagonal gamma form is at least (1-Cd)||hi||_2^2, from
|hat hi|<=sqrt(d)||hi||_2 and Plancherel. No diagonal arithmetic
term survives because d<log 2. All pole terms, including translated
cross terms, vanish exactly.

For adjacent windows only n=2 survives; for the distance-2L pair
only n=4 survives, with its full coefficient Lambda(4)/sqrt(4)=L/2.
Indeed d<=1/5 excludes log(3/2), log(4/3), and log(5/4):
log(3/2)>=1/3, log(4/3)>=1/4, and log(5/4)>1/5.
Larger or smaller integers are farther away. Both arithmetic
orientations enter the Hermitian cross form. Their exact matrix is

    T = [[0,w2,w4],[w2,0,w2],[w4,w2,0]].

Its row-sum norm is at most 2w2, because w4<w2. Thus the full
negative arithmetic quadratic is bounded below by
-2w2 sum_i ||hi||_2^2. In particular the proper-power edge cannot
be dropped to claim a nearest-neighbor matrix.

For every separated pair the actual gamma cross expansion has
kernel -sum_(r>=0) exp(-(2r+1/2)a). The r=0 term vanishes through
the two pole moments. The remaining absolute kernel is

    exp(-5a/2)/(1-exp(-2a)).

For separation a>=L-d>=L/2 its maximum is at most K. Each cross
operator therefore has norm at most dK, by the two finite support
lengths and Cauchy-Schwarz. This argument does not assert a sign
for the cross operator on arbitrary packets. There are at most
two such neighbors per row, so the combined gamma cross quadratic
is bounded below by -2dK sum_i ||hi||_2^2.

Consequently the complete actual form obeys

    Q(f)>=[1-2w2-d(C+2K)]sum_i ||hi||_2^2>0

for every nonzero triple. This is a three-window theorem on a narrow
pole-null subspace using actual diagonal coercivity, complete prime
power geometry, and the exact compensated gamma kernel. A two-window
version follows by replacing 2w2,2K with w2,K.

The support width depends on the coercivity constants. This proves
no fixed-width induction, density of these tests in the full Weil
core, arbitrary growing-array domination, or bound on the actual
arithmetic source. As window separation grows, more integer
frequencies become eligible; the three-window row must not be used
for that geometry. The existing odd-subspace theorem has a stronger
cross sign at its stated width; this deduction trades that sign for
smaller support and applies to arbitrary pole-null packets.


## Retaining all global pole-moment carriers

The separate local nulls can be removed by a direct stronger version.
Require only M_(+/-1/2)(f)=0 for the whole three-window function.
Each packet may have arbitrary local moments. Its diagonal gamma
bound is unchanged, and the WHOLE pole form is now zero. Do not
assign zero poles to the separate diagonal or cross blocks.

Retain the full gamma cross kernel, including its r=0 term. At gap
at least L/2 its absolute value is bounded by

    K0=2^(3/4),

since exp(-a/2)<=2^(-1/4) and 1-exp(-2a)>=1/2. Thus each cross
operator has norm at most dK0, without any moment or oddness
assumption. The complete prime2/power4 matrix is unchanged.
For d<=1/5 and d<(1-2w2)/(C+2K0), the full form therefore obeys

    Q(f)>=[1-2w2-d(C+2K0)]sum_i||hi||_2^2>0.

This version includes inter-window transfer of pole moments. For
example, for a smooth bump eta with nonzero local moments,

    f=eta-(sqrt2+1/sqrt2)tau_L eta+tau_(2L)eta

has both global pole moments zero. Its coefficient polynomial is
(X-sqrt2)(X-1/sqrt2), evaluated at X=exp(sL), so the local moments
need not vanish. The exact arithmetic quadratic on these coefficients
is -5log2||eta||_2^2; the actual negative arithmetic row is therefore
+5log2||eta||_2^2. The restricted local-null direct sum misses this
function. The full-kernel estimate includes it explicitly.

This removes the finite-dimensional moment-carrier gap for THREE
narrow windows. It does not establish positivity at an unchanged
width or a covering of the full physical pole-null core. A growing
number of windows introduces new nearby integer frequencies and
long-distance error blocks. Shrinking support to exclude them is a
restricted theorem, not a solution to that covering problem.


## Attribution, primary scope and certificate

The supporting two-window actual-kernel calculation was developed by
RH Agent3. The three-window deduction and full moment-carrier extension
are by RH Proof, with independent mathematical review by RH Agent3.
These are restricted positive-form estimates, not an unconditional
RH advance. Smoothness, finite support and the pole-moment constraint
on the WHOLE function remain essential to the stated full version.

[Connes and Consani, Theorem 1](https://alainconnes.org/wp-content/uploads/Selecta.pdf)
compares the archimedean functional with a positive compressed Sonin
trace under its stated single multiplicative support interval and
transform nulls. In logarithmic coordinates that interval has width
log 2. That theorem is not used to justify these cross blocks or any
growing semilocal dominance. Our support estimate uses the actual
Fourier multiplier and elementary concentration directly.

[ThreeWindowIncidenceBudget](../../formalization/BuildingBlocks/ThreeWindowIncidenceBudget.lean)
compiles the seven scalar ingredients: nonnegative actual graph
weights, w4<=w2, 2w2<1, the complete three-edge quadratic budget,
the full gamma cross-product budget, and both exact carrier identities.
All printed declarations report only propext, Classical.choice and
Quot.sound. The scalar certificate does not formalize the Fourier
form, support incidence, gamma operator bounds or the analytic theorem.
Those remain written obligations; no axiom for them was introduced.

At a fourth window, packet width 1/5 admits n=7,8,9 at separation
log 8. The resonant n=8 is a proper power and n=9 is another proper
power. Cross operators no longer have the three-window scalar graph.
Agent3's actual two-copy odd-packet calculation can make that P3
arithmetic block negative by isolating the n=7 correlation. This
invalidates a universal negative-cross-block gluing invariant, while
leaving positivity of the full matrix undecided. Neither our narrower
three-window theorem nor an extrapolation of its graph proves a
uniform growing-family inequality or covers all physical pole-null
functions. The source-specific RH-strength energy bound remains open.
