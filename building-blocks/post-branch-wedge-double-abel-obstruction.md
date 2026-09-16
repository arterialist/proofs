# Post-branch wedge and double Abel reduction

## Result

Let `p` be the newly admitted prime, `D=(p^-)#`, `q=e^(-2/X)`, and
`L=log X`.  When `D>X`, the mixed endpoint term no longer lies entirely on
the first branch.  Grouping each old endpoint divisor `a` with the new
divisor `pa` turns the two post-branch regions into the literal cones

\[
 a>Xp e,
 \qquad a>Xe,                                                       \tag{1}
\]

respectively.  The second cone is the larger one; its factor `p` cancels
exactly between the new endpoint and the admitted nonendpoint face.

Two-dimensional finite Abel summation converts the combined post-branch
mixed term and endpoint quadratic into a mixed second difference weighted by
two copies of the finite primorial Mertens prefix.  No one-variable zero
moment controls that expression.  The complete-admission background
cancellation is a level identity after all prime layers are assembled; it
does not cancel the present individual prime layer.  The precise missing
estimate is (17) below.

No wider sign-transfer range is proved.

## Exact post-branch residual

For the main nonendpoint profile, the sampled pairing with one endpoint face
is

\[
 H_{X,q}(d,n)
 ={q^n\over2d}\left[
 e^{-2d}(q^{-m}-1)+(1-q)(n-m)
 \right],
 \qquad m=\min(n,Xd).                                               \tag{2}
\]

If `n<=Xd`, this is the complete first-branch value

\[
 H^{(0)}_{X,q}(d,n)={e^{-2d}\over2d}(1-q^n).                        \tag{3}
\]

For `n>Xd`, put `r=n-Xd`.  Since `e^(-2d)=q^(Xd)`, subtraction of (3)
gives

\[
\boxed{
 H_{X,q}(d,n)-H^{(0)}_{X,q}(d,n)
 ={q^n\over2d}\{1-q^{-r}+(1-q)r\}.}                               \tag{4}
\]

For `0<q<1` and `r>0`, the braces are negative.  This sign does not sign the
Möbius sum because every ordered pair still carries `mu(e)mu(a)`.

Group the endpoint divisors as `n=a` and `n=pa`, `a|D`.  Their Möbius
orientations are opposite, so the mixed main row is exactly

\[
 2{L\over X}\sum_{e,a\mid D}\mu(e)\mu(a)
 \{H_{X,q}(pe,a)-H_{X,q}(pe,pa)\}.                                 \tag{5}
\]

The residual of the first kernel in (5) is supported on `a>Xp e`.  The
residual of the second is supported on

\[
 pa>Xp e\quad\Longleftrightarrow\quad a>Xe.                         \tag{6}
\]

Thus (1) has no rounded or omitted boundary.

## GCD reparameterization

For each ordered pair `a,e|D`, write

\[
 g=(a,e),\qquad a=gu,\qquad e=gv,qquad (u,v)=1.                    \tag{7}
\]

Because all divisors of `D` are squarefree,

\[
 \mu(a)\mu(e)=\mu(u)\mu(v).                                       \tag{8}
\]

The common-factor sign disappears as `mu(g)^2=1`, but the common factor
remains inside the radial weight.  The cones become

\[
 u>Xp v,
 \qquad u>Xv.                                                       \tag{9}
\]

Consequently the post-branch sum has the exact form

\[
 \sum_{\substack{uv\mid D\\(u,v)=1}}\mu(u)\mu(v)
 \sum_{g\mid D/(uv)} \mathcal W_{X,p}(g;u,v),                      \tag{10}
\]

with the indicators in (9) retained inside `mathcal W`.  The inner
`g`-sum has no zero-mass identity: its factors include `q^(pgu)/g` and the
distance `g(u-Xv)` from the moving boundary.  Common-factor or LCM grouping
therefore reorganizes the obstruction but does not cancel it.

## Combined kernel with the endpoint quadratic

Let

\[
 G_q(x,y)=q^{\max(x,y)}-q^{x+y}.                                   \tag{11}
\]

The exact endpoint quadratic is

\[
 \left({L\over X}\right)^2
 \sum_{e,a\mid D}\mu(e)\mu(a)
 \{G_q(pe,pa)-2G_q(e,pa)\}.                                       \tag{12}
\]

Combining (5) and (12) gives one ordered kernel

\[
\boxed{\begin{aligned}
 \mathcal K_{X,p}(e,a)={}&
 2{L\over X}\{H_{X,q}(pe,a)-H_{X,q}(pe,pa)\}\\
 &+\left({L\over X}\right)^2
 \{G_q(pe,pa)-2G_q(e,pa)\}.
\end{aligned}}                                                     \tag{13}
\]

The main mixed-plus-quadratic remainder is exactly

\[
 \mathcal R^G_{X,p}
 =\sum_{e,a\mid D}\mu(e)\mu(a)\mathcal K_{X,p}(e,a).              \tag{14}
\]

The `J`, second-log, PNT, lower-atom, and rough-source mixed rows add their
own explicit kernels to (13).  They do not alter the endpoint quadratic.

There is an elementary square interpretation.  Pointwise in the endpoint
Hilbert space,

\[
 2\langle\Delta Z,E_p\rangle+|E_p\|^2-\|E_{p^-}\|^2
 =\|\Delta Z+E_p\|^2-\|\Delta Z\|^2-\|E_{p^-}\|^2.                \tag{15}
\]

This identity supplies no sign: it is a difference of three positive
quantities.

## Exact two-dimensional Abel summation

Extend the divisor coefficients to the integer interval `1<=n<=D` by

\[
 c_D(n)=\mu(n)1_{n\mid D},
 \qquad
 M_D(t)=\sum_{n\le t}c_D(n).                                       \tag{16}
\]

Since `D>1`, `M_D(D)=sum_(n|D)mu(n)=0`.  Applying finite Abel summation in
both variables to (14) gives the exact identity

\[
\boxed{
 \mathcal R^G_{X,p}
 =\sum_{u<D}\sum_{v<D}M_D(u)M_D(v)
 \Delta_1\Delta_2\mathcal K_{X,p}(u,v),}                           \tag{17}
\]

where

\[
 \Delta_1\Delta_2K(u,v)
 =K(u,v)-K(u+1,v)-K(u,v+1)+K(u+1,v+1).                             \tag{18}
\]

All terminal terms vanish because both complete divisor sums are zero, not
because a boundary was discarded.  The slanted wedge in (1) remains in the
mixed difference.  Formula (4) vanishes at the wedge boundary, but its first
normal difference does not; double Abel therefore places mass in the one-cell
strip along `a≈Xe` as well as in the wedge interior.

Equation (17) is the exact two-point friable Mertens norm required by this
method.  A sufficient estimate at the fixed-profile admission scale is

\[
\boxed{
 \left|\sum_{u<D}\sum_{v<D}M_D(u)M_D(v)
 \Delta_1\Delta_2\mathcal K^{\rm full}_{X,p}(u,v)\right|
 =o\{e^{-2p}p^{\delta-1}\},}                                      \tag{19}
\]

where `K^full` includes the additional literal mixed-row kernels just listed.
The available second-Abel theorem controls a one-variable linear functional
of `M_D`.  It does not imply the bilinear estimate (19).  Cauchy reduces (19)
to endpoint level energies, which are far larger than an individual
fixed-profile admission near `p~log X`.

## Mixed difference on the slanted boundary

The scalar residual has an exact boundary-strip decomposition.  This gives
more information than its sign before double Abel, but it does not sign the
bilinear form.

For the old endpoint face in (5), set

\[
 s=a-Xpe,
 \qquad
 F_o(s)=1_{s>0}\{1-q^{-s}+(1-q)s\}.
\]

After taking the forward difference in `a`, define

\[
 B_o(s)=F_o(s)-qF_o(s+1).
\]

The endpoint convention is literal: `F_o(0)=0`.  Direct cancellation of the
two exponential terms gives

\[
 B_o(s)=
 \begin{cases}
 0,&s\le-1,\\
 (1-q)^2(s+1),&s\ge0.
 \end{cases}                                                       \tag{20}
\]

With the same mixed-difference convention as (18),

\[
 \Delta_1\Delta_2R_o(e,a)
 ={q^a\over2p}\left{{B_o(s)\over e}
 -{B_o(s-Xp)\over e+1}\right}.                                   \tag{21}
\]

Thus the value one lattice cell before the boundary is zero, while at the
boundary and one cell beyond it the values are

\[
 {q^a(1-q)^2\over2pe},
 \qquad
 {2q^a(1-q)^2\over2pe}.                                            \tag{22}
\]

For the entire boundary strip `0<=s<Xp`, only the first fraction in (21)
is present.  In the interior `s>=Xp`, the two affine terms collapse to

\[
 \boxed{
 \Delta_1\Delta_2R_o(e,a)
 ={q^a(1-q)^2(a+1)\over2p,e(e+1)}>0.}                             \tag{23}
\]

For the new endpoint face, put `s=a-Xe` and

\[
 F_n(s)=1_{s>0}\{1-q^{-ps}+(1-q)ps\},
 \qquad B_n(s)=F_n(s)-q^pF_n(s+1).
\]

For `s>=0`,

\[
 B_n(s)=A_{p,q}+C_{p,q}s,                                          \tag{24}
\]

where

\[
 A_{p,q}=1-q^p-pq^p(1-q)>0,
 \qquad C_{p,q}=p(1-q)(1-q^p)>0.                                  \tag{25}
\]

The strict positivity of `A_(p,q)` follows from
`q^(-p)-1>p(1-q)` for `0<q<1`.  Also `B_n(s)=0` for `s<=-1`.  Hence

\[
 \Delta_1\Delta_2R_n(e,a)
 ={q^{pa}\over2p}\left{{B_n(s)\over e}
 -{B_n(s-X)\over e+1}\right}.                                    \tag{26}
\]

At `s=0` and `s=1`, this is respectively

\[
 {q^{pa}A_{p,q}\over2pe},
 \qquad
 {q^{pa}(A_{p,q}+C_{p,q})\over2pe}.                                \tag{27}
\]

On `0<=s<X`, equation (26) is one positive affine strip.  For `s>=X`,

\[
 \boxed{
 \Delta_1\Delta_2R_n(e,a)
 ={q^{pa}\{A_{p,q}+C_{p,q}a\}\over2p,e(e+1)}>0.}                 \tag{28}
\]

Each unoriented residual therefore has a positive mixed difference.  The
orientation in (5) is `R_o-R_n`.  On the intermediate cone

\[
 Xe\le a<Xpe,                                                       \tag{29}
\]

the old mixed difference is zero and the new one is positive.  The oriented
mixed difference is strictly negative there.  Past the second boundary it is
a difference of the two positive quantities (23) and (28), with no fixed
sign.  This is an exact counterexample to a global positive-kernel reading of
the post-branch mixed row.

Equations (21) and (26) do give a strip/interior decomposition.  It is not a
bounded-rank reduction: the strip widths are `Xp` and `X`, and the interior
terms retain the triangular masks `a>=Xp(e+1)` and `a>=X(e+1)`.  After
factoring their scalar weights, the strip algebra supplies no rank bound
independent of `X`; the growing triangular masks remain.  The endpoint
quadratic has order breaks at numerical maxima rather than at these two
slanted lines, so no support-matched pointwise cancellation follows from the
finite algebra.

## Exact smallest nontrivial matrix test

The first nondegenerate post-branch zero-total test is

\[
 p=5,\qquad D=2\cdot3=6,\qquad X=2,
 \qquad q=e^{-1},\qquad L=\log2.                                    \tag{30}
\]

For `p=3`, the condition `D>X` with integral `X` forces `X=1`, hence
`L=0` and the normalized kernel vanishes.  At (30), order the old divisors as

\[
 (1,2,3,6).
\]

Use the full kernel (13), including both ordered mixed orientations and the
max-based endpoint quadratic.  It is not symmetric, but its quadratic form
depends only on

\[
 S={1\over2}(\mathcal K+\mathcal K^{\mathsf T}).
\]

For reference, the rigorously enclosed matrix has the following displayed
central decimals:

\[
S\approx10^{-4}\begin{pmatrix}
-2.2044436&-6.9803116&-7.6755896&-2.9415535\\
-6.9803116&-0.0397739&-0.0517667&-0.0543958\\
-7.6755896&-0.0517667&-0.0003308&-0.0003665\\
-2.9415535&-0.0543958&-0.0003665&-0.0000000001
\end{pmatrix}.                                                     \tag{31}
\]

The exact certificate does not use these rounded decimals.  Every ordered
entry is constructed as

\[
 \mathcal K(e,a)={L\over2}A_{e,a}(q)+{L^2\over4}B_{e,a}(q),         \tag{32}
\]

where `A` and `B` are rational polynomials generated directly from (2) and
(11).  Rational alternating-series bounds enclose `e^(-1)`, and the positive
atanh series encloses `log 2`; interval evaluation then proves

\[
\begin{aligned}
 v_+&=(-1,1,0,0),&quad v_+^{\mathsf T}Sv_+
 &\in[0.00117164056413210,0.00117164056413212],\\
 v_-&=(-1,0,-1,2),&quad v_-^{\mathsf T}Sv_-
 &\in[-0.00057882736028920,-0.00057882736028917].                \tag{33}
\end{aligned}
\]

Both vectors have coordinate sum zero.  Therefore the full finite kernel is
neither conditionally positive semidefinite nor conditionally negative
semidefinite on the zero-total divisor subspace.

The counterexample is stronger than the boundary-strip sign test: every
entry displayed in (31) is negative, yet the zero-total form takes both
signs.  Entrywise sign therefore cannot replace the bilinear Mertens
estimate.  It also rules out a reusable positive/negative spectral
decomposition for this kernel family without an additional correction.

[The exact interval runner](verification/post_branch_kernel_p5_x2.py)
constructs all sixteen ordered polynomial entries and certifies (33) using
only rational arithmetic.  This is a finite counterexample.  It gives no
asymptotic information about growing `p`, `D`, or `X`.

## Complete admission does not localize the cancellation

At complete admission, the assembled endpoint and nonendpoint backgrounds
have the known level cancellation `K_1=F_infinity`.  That statement includes
all prime layers, the full density correction, and the coherent endpoint
mode.  It is not an identity for the single layer (13).

Summing prime admissions telescopes the corresponding full energies.  The
individual terms can exchange energy through their ordered crosses, and the
centered complete-admission remainder is the Mertens prefix square rather
than zero.  Therefore the complete background cancellation cannot be
differentiated into a favorable sign or bound for (14).  Doing so would
amount precisely to assuming (19).

Subtracting (14) as a counterterm is algebraically legitimate, but it changes
the observable and leaves the other post-branch kernels unless the full
quantity in (19) is subtracted.  Such subtraction evaluates the obstruction;
it does not estimate the original energy.

## Formal finite scope

[PostBranchDoubleAbelFinite.lean](BuildingBlocks/PostBranchDoubleAbelFinite.lean)
proves finite Abel summation with its terminal prefix, the zero-total
two-dimensional identity (17), exact prime-orientation grouping, the
post-branch residual algebra (4), and the combined-square identity (15).
The companion
[PostBranchBoundaryStripFinite.lean](BuildingBlocks/PostBranchBoundaryStripFinite.lean)
proves the affine forward coefficients (20), (24), their boundary and
one-cell values, the interior collapse, positivity under the explicit
elementary hypotheses, and the negative oriented one-wedge test.
[PostBranchKernelIndefiniteFinite.lean](BuildingBlocks/PostBranchKernelIndefiniteFinite.lean)
defines the literal matrix (30), the two zero-total vectors in (33), and
proves that their opposite strict values exclude both conditional signs.
The rational runner discharges those two strict numerical premises.  All
three modules compile without `sorry` or new axioms.  Printed dependencies
are only `propext`, `Classical.choice`, and `Quot.sound`.

No analytic estimate corresponding to (19), wider sign-transfer range, or
RH conclusion is asserted.
