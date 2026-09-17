# Effective killed-ground bound at radius two: missing spectral direction

This note attempts to make the normalized killed-ground bound effective at R=2. The published estimates contain a quantitative spectral statement, but it has the wrong direction for the L-infinity barrier:

\[
\alpha_2\ge\frac12-10^{-20}.
\tag{1}
\]

Thus the actual gap d=1/2-alpha_2 satisfies

\[
0<d\le10^{-20}.
\tag{2}
\]

The barrier needs a positive lower bound d≥d_0>0, equivalently an explicit Rayleigh trial with quotient at most 1/2-d_0. No such bound is currently evaluated at R=2. Consequently no numerical upper bound for P_infinity follows from the published hypotheses.

The normalization direction is essential. Equation (1) cannot be substituted for the missing upper bound on alpha_2.

## The exact barrier dependence

The bounded-ground proof constructs an auxiliary Dirichlet generator A_epsilon and obtains

\[
(A_\varepsilon-\alpha_2)w\ge\delta w,
\qquad \delta=\frac{1/2-\alpha_2}{8}=\frac d8.
\tag{3}
\]

Its resolvent estimate is

\[
\|\psi_2\|_\infty
\le\frac{M C_\varepsilon}{\delta}
=\frac{8M C_\varepsilon}{d}.
\tag{4}
\]

Even if M and C_epsilon were numerically bounded, (4) requires a lower bound on d. The explicit exterior estimate (1) only says that the denominator in (4) is at most 10^-20. It gives no finite upper bound for the quotient.

This is the first missing datum.

## The existing explicit trial does not certify R=2

The shrinking physical trial uses

\[
w_R=e^{-\sqrt R/8}
\]

and Trudgian's unconditional full-Chebyshev remainder

\[
\epsilon_R=\sqrt{\frac8{17\pi}}
\left(\frac{2R}{6.455}\right)^{1/4}
\exp\left[-\sqrt{\frac{2R}{6.455}}\right].
\]

Its prime quadrature step requires

\[
\epsilon_R\le\frac{w_R}{7e^2}.
\tag{5}
\]

At R=2, direct outward evaluation gives

\[
0.8379<w_2<0.8380,
\]
\[
0.1562<\epsilon_2<0.1564,
\qquad
0.0161<\frac{w_2}{7e^2}<0.0163.
\tag{6}
\]

Thus (5) fails by a factor greater than 9.5. Also w_2>log2, so the trial's simplifying assertion that no same-half prime shift connects the bump to itself is unavailable. The large-R spectral-distance formula from that note cannot be applied at R=2.

This is a failure of that sufficient trial estimate, not evidence that d=0.

## Why normalization and theta tails do not give P-infinity

The ground is normalized by

\[
\int_{O_2}\psi_2^2d\nu=1,
\]

and the accepted theta bound is

\[
\nu(O_2)<10^{-47}.
\]

Therefore

\[
P_\infty=\|\psi_2\|_\infty
\ge\nu(O_2)^{-1/2}>10^{23.5}.
\tag{7}
\]

This is a lower bound. It is consistent with a highly concentrated normalized ground and supplies no upper enclosure. A tail upper bound for ν cannot reverse (7).

The ground equation does not change this without quantitative resolvent control. The exact equation

\[
L_{O_2}\psi_2=\alpha_2\psi_2
\]

has a pole at alpha_2. Any L²-to-L-infinity estimate at that spectral value must pay either a spectral separation in an auxiliary operator, as in (3), or another explicitly coercive denominator.

## A concrete route to certify the missing gap

A finite Rayleigh certificate can provide the needed direction without approximating the ground eigenfunction pointwise.

Choose S>2 and an even compactly supported physical trial f on

\[
[2,S]\cup[-S,-2]
\]

whose zero extension has no hard-boundary trace. Put h=f/Φ. The exterior variational principle gives

\[
\alpha_2\le\frac{E_{O_2}[h]}{\|h\|_\nu^2}.
\tag{8}
\]

To certify d≥d_0 it is enough to prove

\[
E_{O_2}[h]\le(1/2-d_0)\|h\|_\nu^2.
\tag{9}
\]

All terms in (9) are finite and explicitly enumerable:

- the continuous jump double integral on the compact support, with its diagonal singularity canceled by |h(u)-h(v)|²;
- the complete killing contribution from jumps leaving the support;
- every prime-power displacement with log n≤2S;
- the tail prime departure terms with one endpoint outside the support;
- both orientations and the two compression endpoints.

For a piecewise polynomial f, interval arithmetic can enclose the continuous integral after splitting a narrow diagonal strip. On that strip, a Lipschitz bound for h cancels r(t)~1/(2t). Off the strip, ordinary interval quadrature applies. The prime sum is finite for internal pairs. The remaining departure tail can use the explicit theta envelope and Lambda(n)≤log n without omitting proper powers.

A practical generalized eigenvalue version chooses several such basis functions h_j and encloses

\[
A_{ij}=E_{O_2}(h_j,h_i),
\qquad G_{ij}=\langle h_j,h_i\rangle_\nu.
\]

Any rational coefficient vector c with

\[
c^TAc<(1/2)c^TGc
\tag{10}
\]

provides the needed d_0 from its enclosed quotient. Only an upper Rayleigh bound is required; no complement estimate is needed for this step.

## Turning a certified gap into P-infinity

Suppose (9) supplies d≥d_0. The existing barrier can then be made effective in the following order.

1. Choose S_0 so the explicit theta tail satisfies

\[
\nu(|u|>S_0)<d_0/2.
\]

2. Set

\[
M>\max(1,2\nu(O_2)/d_0)
\]

with a rational margin and choose the stated smooth barrier w.

3. Replace the qualitative prime-return limit for Dw by an effective PNT partial-summation remainder for this fixed piecewise smooth w. This gives a numerical U and a positive tail lower bound for (D-alpha_2)w.

4. Enclose the bounded-strip negative part of (D-alpha_2)w on 2<|u|≤U, retaining every finite prime-power shift and bounding the remaining tail by the same PNT remainder.

5. Choose epsilon so the explicit continuous rate

\[
q_\varepsilon(u)=\frac1{b(u)}
\int_{\substack{v\in O_2\\|u-v|\ge\varepsilon}}
 r(|u-v|)\Phi(v)dv
\]

pays that negative strip bound. The logarithmic divergence can be bounded below uniformly on the compact strip.

6. Evaluate

\[
C_\varepsilon^2
\le\frac14\sup_{u\in O_2}
\int_{\substack{v\in O_2\\|u-v|\ge\varepsilon}}
 r(|u-v|)^2\frac{\Phi(v)}{b(v)}dv.
\tag{11}
\]

Then (4) yields the certified constant

\[
\boxed{\quad P_\infty\le 8MC_\varepsilon/d_0.\quad}
\tag{12}
\]

Every choice in this list is constructive once d_0 is known. The effective prime-return remainder is the second required calculation; it is not supplied by the current qualitative barrier proof.

## Tail bounds after P-infinity

With (12), the ground equation gives for T>2

\[
\|\Phi\psi_2 1_{u<-T}\|_{\mathcal H}
\le
\left[C_\theta\{(\alpha_2+1)P_\infty^2\nu(O_T)
+b_TP_\infty\sqrt{\nu(O_T)}\}\right]^{1/2}.
\tag{13}
\]

A numerical tail still requires an explicit C_theta, but (12) removes the first non-effective ground factor. It can then feed the complete prime-profile split.

## Exact status

The published hypotheses at R=2 prove

\[
0<1/2-\alpha_2\le10^{-20}
\]

and P_infinity<∞, but they do not provide a positive numerical lower bound for 1/2-alpha_2 or a numerical upper bound for P_infinity.

The exact missing spectral datum is

\[
\boxed{\quad \alpha_2\le1/2-d_0\text{ for one explicit }d_0>0.\quad}
\]

A compactly supported Rayleigh trial with certified full continuous and prime-power energy is the shortest constructive route. After that, the barrier needs an effective fixed-function prime-return remainder to produce the explicit P_infinity in (12).

No numerical P_infinity is claimed here. Doing so from (1), (6), or (7) would use an inequality in the wrong direction.

This is written analysis. The compact Rayleigh certificate and effective barrier constants remain Lean and numerical certification obligations.
