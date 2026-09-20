# Joint outer/alias spacing beyond the double-\(Q\) transition

**Status:** written Gram estimate with two independent audit passes,
20 September 2026. The Lean companion checks only exponent algebra. The
uniform parameter-symbol stationary transform is proved below as written
analysis from a standard parameter-dependent stationary-phase theorem; it
is not formalized in Lean. This result does not control the remaining high
Gram blocks and does not imply the Riemann hypothesis.

## Scope

Continue from the
[double-\(Q\) Gram estimate](actual-mobius-double-q-full-rank-gram.md).
Write
\[
 U=P^2Q,\qquad u=km,\quad u'=k'm',\quad g=u-u',
 \qquad F=\frac{QG}{P}
\tag{1}
\]
on a block \(g\asymp G>0\). The conjugate block is identical. Throughout
the range considered below, \(F<T=PQ^2\), so \(G/U=F/T\) is a fixed
negative power on every fixed-margin block.

The exact phase magnitude in the \((n,r)\)-kernel is
\[
 F_{u,u'}=2Q^{3/2}(\sqrt u-\sqrt{u'}),
 \qquad F_{u,u'}\asymp F.
\tag{2}
\]
Two-dimensional Poisson summation and stationary phase give dual indices
\[
 j,\ell\asymp L:=F/Q
\tag{3}
\]
and exact leading phase
\[
 -2\sqrt{2QF_{u,u'}}\,(j\ell)^{1/4}.
\tag{4}
\]
The leading stationary amplitude is \(Q^2/F\) times a jointly inert
weight. We first supply the uniform analytic statement required to retain
the outer variables through the dual large sieve.

### Smooth weighted Gram reduction

Fix a nonnegative \(C_c^\infty\) function \(\chi\) which equals one on a
fixed enlargement of every normalized \(n,r\)-support occurring in the
finite history and separator decomposition. Scale the outer variables by
\[
 \mathbf z_{\rm out}
 =\left(k/P,k'/P,u/U,g/G\right),
 \qquad m=u/k,\quad m'=(u-g)/k'.
\]
Together with \(x=n/Q,y=r/Q\), every exact cross amplitude
\(W=V_{k,m,n,r}\overline{V_{k',m',n,r}}\) in the expanded Gram is a
smooth function on a fixed compact box, with derivative seminorms
\(O_\varepsilon(T^\varepsilon)\). Since \(\chi=1\) on its support, write
it as \(\chi(x)\chi(y)\widetilde W\), extend \(\widetilde W\) smoothly to
a fixed torus, and take its ordinary Fourier series. First fix a symbol
budget \(M_1\) larger than the dimension of the later parameter torus. Then
choose an amplitude budget \(M_0\) large enough that the two-term stationary
expansion controls every resulting symbol through order \(M_1\), and that the
nonstationary integrations by parts and their parameter derivatives use at
most \(M_0\) amplitude derivatives. Integration by parts in the initial
Fourier coefficients past the total dimension plus \(2M_0\) gives an exact
expansion
\[
 W(\mathbf z_{\rm out},x,y)
 =\sum_\nu c_\nu A_\nu(\mathbf z_{\rm out})B_\nu(x,y),
 \qquad
 \sum_\nu |c_\nu|
 \|A_\nu\|_{C^{M_0}}\|B_\nu\|_{C^{M_0}}
 \ll_\varepsilon T^\varepsilon,
\tag{5}
\]
where every \(B_\nu\) contains the factor \(\chi(x)\chi(y)\) and is supported
there. Equivalently, absorb the two displayed seminorms into \(c_\nu\) and
normalize the factors so that every \(A_\nu,B_\nu\) has \(C^{M_0}\)-norm at
most one. Apply this exact separation after expanding the weighted Cauchy
Gram. By the triangle inequality it is enough to bound one resulting smooth
Gram component, denoted \(\mathcal J_G^\chi\), uniformly for these normalized
factors.
This transfers the estimate back to the original Cauchy form with only a
\(T^\varepsilon\) cost. It does **not** replace an oscillatory amplitude
by a pointwise majorant.

### Uniform stationary-symbol lemma

Each stationary mode admits, uniformly in the outer tuple and in
\(j,\ell\asymp L\), the two-term expansion
of the form
\[
 I_{j,\ell}=
 e\!\left(-2\sqrt{2QF_{u,u'}}(j\ell)^{1/4}+\vartheta\right)
 \frac{Q^2}{F}
 \sum_{r=0}^{1}F^{-r}
 A_r(\mathbf z_{\mathrm{out}};\alpha,\beta)
 + \mathcal R_2,
\tag{6}
\]
where \(\vartheta=-1/4\) for the displayed Fourier convention and
\(\mathbf z_{\mathrm{out}}\) denotes all normalized outer variables. The
symbol may depend separately on \(\alpha\) and \(\beta\); only the phase
collapses them to \(Y_{j,\ell}\). Each smooth \(A_r\) has a
Fourier--Mellin separated representation whose nuclear
\(L^1\) norm is \(O_\varepsilon(T^\varepsilon)\), uniformly in all history
and separator parameters. A sufficient per-mode remainder is
\[
 \mathcal R_2\ll_\varepsilon T^\varepsilon Q^2F^{-3}.
\tag{7}
\]
Indeed there are \(O(T^\varepsilon GU)\) weighted outer tuples and
\(O(L^2)\) stationary modes, so (7) sums exactly to
\[
 O_\varepsilon(T^\varepsilon P^3),
\tag{8}
\]
which is \(Q^{-3}\) below the \(P^3Q^3\) Gram target.

To prove the lemma, normalize
\[
 A=F_{u,u'}/F,\qquad \alpha=j/L,\qquad \beta=\ell/L.
\]
On each fixed stationary partition these parameters range over positive
compact sets, and the scaled Poisson phase is
\[
 \Phi_{A,\alpha,\beta}(x,y)
 =-A(xy)^{-1/2}-\alpha x-\beta y.
\tag{9}
\]
Its Hessian is \(-A\nabla^2(xy)^{-1/2}\), uniformly definite on the
fixed positive support. The linear twists do not affect it. The critical
point, when it meets the support, is unique and is the smooth function of
\((A,\alpha,\beta)\) given explicitly by
\[
 x_*=\sqrt{A/2}\,\beta^{1/4}\alpha^{-3/4},
 \qquad
 y_*=\sqrt{A/2}\,\alpha^{1/4}\beta^{-3/4}.
\tag{10}
\]
All derivatives of this map are uniformly bounded on the fixed positive
parameter boxes. Substitution gives critical value
\(-2\sqrt{2A}(\alpha\beta)^{1/4}\); the negative-definite Hessian has
signature \(-2\), producing the factor \(e(-1/4)\).

Apply the parameter-uniform stationary-phase expansion in Gressman,
[*Damping oscillatory integrals by the Hessian determinant via
Schrödinger*, Lemma 2](https://arxiv.org/abs/1411.4680), which also records
its relation to Hörmander's Theorem 7.7.5. Compactness, uniform Hessian
definiteness, and the inert derivative bounds give (6)--(7), term by term,
with constants uniform in all normalized parameters. Extend every smooth
amplitude by zero before applying the theorem. Because the separated
cutoffs are \(C^\infty_c\), this also covers a critical point approaching
or crossing a smooth support boundary; all amplitude jets then vanish on
the exterior side. A finite partition covers the full stationary parameter
set.

For the complement, the phase gradient is uniformly separated from zero.
Repeated application of the standard adjoint vector field
\[
 \frac{\nabla\Phi\cdot\nabla}
 {2\pi iF|\nabla\Phi|^2}
\]
gives arbitrary inverse powers of \(F\). The same argument sums the wrong
signs and modes outside \(j,\ell\asymp L\), because their gradient
separation grows with the distance from the stationary rectangle. Choosing
the integration-by-parts order after the finite outer dimensions makes
their total \(O_\varepsilon(T^\varepsilon P^3)\), after taking enough
integrations by parts.

It remains to justify the separated coefficient form used below. Each
stationary coefficient is a compactly supported smooth function of the
normalized outer parameters and \((\alpha,\beta)\). Extend it to a fixed
torus and take its ordinary Fourier series. By the choice of \(M_0\), the
stationary construction gives a uniform \(C^{M_1}\) bound for this coefficient.
Since \(M_1\) exceeds the parameter dimension, integration by parts makes the
resulting Fourier coefficients \(d_\omega\) absolutely summable:
\[
 \sum_\omega |d_\omega|\ll_\varepsilon T^\varepsilon.
\]
No derivative weight is needed in this second separation: after it, the
double large sieve uses only the bounded outer and alias characters. Every
character factors into one outer character and one alias character, proving
the separation asserted in (6) with summable constants and without feeding a
new derivative demand back into \(M_0\). The \(r=1\) stationary term carries
the additional factor \(F^{-1}\) and is bounded by the same large-sieve
argument.

This proof concerns the smoothed Poisson integrals. Its stationary-phase,
integration-by-parts, and Fourier-separation steps remain written
mathematics; Lean checks none of them.

The only hard endpoint pieces imported here are those from the initial
one-variable \(x\)-transform which creates the leading sum. They are
assigned before that smoothing and are controlled by equation (11) of the
[public one-\(Q\) endpoint theorem](actual-mobius-critical-one-q-poisson-endpoint.md),
which gives the independent linear error saving \(Q^{-1/2}\). The present
note imports that earlier bound; it does not rederive or strengthen it.
The later \(n,r\) dyadic supports used in (6) are \(C_c^\infty\), so they
have no hard physical edges or corners. Their smooth support boundaries
are handled by the zero extension and uniform stationary proof above.

## Double-large-sieve normalization

Using the stationary-symbol lemma, set
\[
 X_{u,u'}=\sqrt{F_{u,u'}/F},\qquad
 Y_{j,\ell}=\frac{(j\ell)^{1/4}}{L^{1/2}}.
\tag{11}
\]
Both variables lie on fixed compact intervals, and (4) is
\(e(cF X_{u,u'}Y_{j,\ell})\) for a fixed nonzero constant \(c\).
Apply the Bombieri--Iwaniec double large sieve in Robert and Sargos,
[*Three-dimensional exponential sums with monomials*, Lemma
8](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf).
It reduces the dual form to spacing energies at resolution \(F^{-1}\):
\[
 |\mathcal T_G|^2
 \ll_\varepsilon T^\varepsilon F\,\mathcal E_X\mathcal E_Y.
\tag{12}
\]
Restricted factorizations of \(u\) and \(u'\) cost only fixed divisor
moments.

## Alias spacing

If
\(|Y_{j,\ell}-Y_{j',\ell'}|\ll F^{-1}\), the mean-value theorem gives
\[
 |j\ell-j'\ell'|\ll \frac{L^2}{F}=\frac{F}{Q^2}.
\tag{13}
\]
In the range used below,
\[
 \frac{F}{Q^2}\le
 T^{-\eta},\qquad
 \eta:=\frac{\lambda-2}{3}+\kappa>0.
\tag{14}
\]
Thus for the fixed constant \(C\) implicit in (13), one has
\(CF/Q^2<1\) once \(T\) is sufficiently large. Integrality then forces
\(j\ell=j'\ell'\). The restricted divisor second moment gives
\[
 \mathcal E_Y\ll_\varepsilon T^\varepsilon L^2.
\tag{15}
\]

## Exact outer spacing

Write \(u'=u-g\) and
\[
 \Delta_g(u)=\sqrt u-\sqrt{u-g}.
\tag{16}
\]
On \(u\asymp U,\ g\asymp G\ll U\),
\[
 |\Delta_g'(u)|\asymp \frac{G}{U^{3/2}},
 \qquad \Delta_g(u)\asymp\frac{G}{\sqrt U}.
\tag{17}
\]
The condition
\(|X_{u,u-g}-X_{v,v-h}|\ll F^{-1}\) implies, again by the
mean-value theorem on fixed compact supports,
\[
 |\Delta_g(u)-\Delta_h(v)|
 \ll \frac{G}{\sqrt U F}=Q^{-3/2}.
\tag{18}
\]
For fixed \((g,h,u)\), monotonicity in \(v\) and (17) leave at most
\[
 O\!\left(1+\frac{U}{F}\right)
\tag{19}
\]
integer choices for \(v\). There are \(O(G^2U)\) choices of
\((g,h,u)\), hence
\[
 \mathcal E_X
 \ll_\varepsilon T^\varepsilon
 \left(G^2U+\frac{G^2U^2}{F}\right).
\tag{20}
\]
This count uses the exact square-root difference (16); it does not replace
it by the first term of a Taylor expansion at the fine spacing scale.

## Resulting Gram range

Restoring the stationary prefactor in the dual form gives
\[
 |\mathcal J_G^\chi|
 \ll_\varepsilon T^\varepsilon
 \frac{Q^2}{F}\sqrt{F\mathcal E_X\mathcal E_Y}
 \ll_\varepsilon T^\varepsilon
 Q\sqrt{F\mathcal E_X}.
\tag{21}
\]
Using \(G=PF/Q\) and \(U=P^2Q\), (20)--(21), and the total error (8)
yield
\[
 \boxed{\quad
 \frac{|\mathcal J_G^\chi|}{P^3Q^3}
 \ll_\varepsilon T^\varepsilon
 \left(
 \frac{F}{Q^2}
 +\frac{F^{3/2}}{P Q^{5/2}}
 +\frac1{Q^3}
 \right).
 \quad}
\tag{22}
\]

Define
\[
 f_*=\frac{2p+5q}{3}=\frac{2+q}{3}.
\tag{23}
\]
For fixed \(\kappa>0\), the stationary expansion is uniform on
\[
 Q\le F\le T^{f_*-\kappa}.
\tag{24}
\]
At \(F\asymp Q\), the dual length \(L\asymp1\) and there are only
\(O(1)\) transition modes. The same uniform compact-parameter two-term
expansion and its \(Q^2F^{-3}\) remainder give (8) there. A trivial bound for
those modes would be too large after summing the outer tuples. Modes outside
the stationary rectangle are included in the nonstationary argument above.
The second term in (22) saves \(T^{-3\kappa/2}\). Since
\[
 2q-f_*=\frac{q-2p}{3}=\frac{\lambda-2}{3},
\tag{25}
\]
the first term saves
\(T^{-(\lambda-2)/3-\kappa}\). Thus the Gram saving is
\[
 \delta_G=min\!\left\{
 \frac{3\kappa}{2},\frac{\lambda-2}{3}+\kappa
 \right\},
\tag{26}
\]
The remainder term saves \(T^{-3q}\). This is only a saving for the signed
Gram contribution in (24). The
frequency restriction is imposed after squaring and therefore defines no
linear subsum. Only after every remaining Gram block is controlled may a
complete Gram saving be converted to a square-root scale for the original
sum.

The new endpoint lies strictly between the previous transition and the
square-root-kernel barrier:
\[
 \frac{3q}{2}<f_*<2q
 \qquad(2<\lambda<29/14).
\tag{27}
\]
The band in (24) is nonempty whenever
\[
0<\kappa<f_*-q.
\tag{28}
\]
To assemble the lower transition, choose a low-range margin \(\rho\) with
\[
 0<\rho<q/2.
\tag{29}
\]
The preceding full-rank Gram note controls
\(F\le Q^{3/2}T^{-\rho}\), while
\[
 Q<Q^{3/2}T^{-\rho}
\]
by (29). Hence the two written estimates overlap and cover every nonzero
dyadic Gram block through \(F\le T^{f_*-\kappa}\). Summing the logarithmic
number of nonzero blocks preserves the saving
\[
 \min\!\left\{2\rho,\delta_G,3q\right\}.
\tag{30}
\]
The diagonal block has relative size \(P^{-1}=T^{-p}\), so the complete
prefix including \(g=0\) has saving
\[
 \min\!\left\{p,2\rho,\delta_G,3q\right\}.
\tag{31}
\]
This still does not define a linear subsum or control the joint high range
\(F>T^{f_*-\kappa}\).

## Formal status and remaining checks

[ActualMobiusDoubleQDualSpacingSaving.lean](../../formalization/BuildingBlocks/ActualMobiusDoubleQDualSpacingSaving.lean)
checks the exponent algebra in (22)--(31), including both Gram-ratio
savings, the \(Q^{-3}\) remainder, the stationary window, and its overlap
with the full-rank range.
It does not
formalize the stationary transform, inert
separation, the two spacing counts, or the Bombieri--Iwaniec double large
sieve.

Two independent audits have verified the written stationary-symbol proof,
including uniformity at smooth support boundaries, the weighted Fourier
separations, the summed nonstationary remainders, both spacing energies, and
the prefactor and overlap ledger. The result remains written analysis rather
than a Lean formalization, and it depends on the stated inherited inert packet
bounds and imported one-\(Q\) hard-endpoint estimate. No claim for the remaining
range \(F>T^{f_*-\kappa}\) is made here.
