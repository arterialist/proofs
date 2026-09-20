# Double-\(Q\) weighted Cauchy and the full-rank Gram kernel

**Status:** independently audited unconditional written estimate,
20 September 2026. The Lean companion checks only the scale and exponent
algebra. The double Cauchy step, determinant count, two-dimensional
Poisson summation, and uniform oscillatory-integral estimate remain written
mathematics. This estimate does not imply the Riemann hypothesis.

## Double weighted Cauchy

Use the notation of the
[one-\(Q\) endpoint](actual-mobius-critical-one-q-poisson-endpoint.md):
\[
 q_0=\lambda/5,\qquad p=1-2\lambda/5,\qquad
 Q=T^{q_0},\quad P=T^p,\quad N=Q^5,\quad PQ^2=T,
\tag{1}
\]
where \(2<\lambda<29/14\). Its leading sum is
\[
 \mathcal S_{\mathrm{lead}}
 =P^{-1/2}
 \sum_{\substack{k\asymp P,\ m\asymp PQ\\n,r\asymp Q}}
 a_kb_m\beta(n)\delta(r)V_{k,m,n,r}
 e\!\left(-2\sqrt{\frac{kNm}{nr}}\right).
\tag{2}
\]
For each fixed history and separator component,
\[
 \sum_{n\asymp Q}|\beta(n)|^2+
 \sum_{r\asymp Q}|\delta(r)|^2
 \ll_\varepsilon T^\varepsilon Q.
\tag{3}
\]

Put
\[
 \mathcal D=P^{1/2}\mathcal S_{\mathrm{lead}}
 =\sum_{n,r}\beta(n)\delta(r)B_{n,r}.
\]
Cauchy's inequality in the pair \((n,r)\) gives
\[
 |\mathcal D|^2
 \ll_\varepsilon T^\varepsilon Q^2\,\mathcal J,
\qquad
 \mathcal J=\sum_{n,r}|B_{n,r}|^2.
\tag{4}
\]
Thus
\[
 |\mathcal S_{\mathrm{lead}}|^2
 \ll_\varepsilon T^\varepsilon\frac{Q^2}{P}\mathcal J.
\tag{5}
\]
The target
\(\mathcal S_{\mathrm{lead}}\ll T^\varepsilon P Q^{5/2}\)
is reduced exactly to
\[
 \mathcal J\ll_\varepsilon T^\varepsilon P^3Q^3.
\tag{6}
\]

Expanding \(\mathcal J\) removes both restricted-divisor coefficients:
\[
\begin{aligned}
 \mathcal J={}&
 \sum_{n,r\asymp Q}
 \sum_{\substack{k,k'\asymp P\\m,m'\asymp PQ}}
 a_k\overline{a_{k'}}b_m\overline{b_{m'}}
 V_{k,m,n,r}\overline{V_{k',m',n,r}}\\
 &\quad\times
 e\!\left(-2\sqrt{\frac N{nr}}
 \left[\sqrt{km}-\sqrt{k'm'}\right]\right).
\end{aligned}
\tag{7}
\]

## Difference representations

Set
\[
 u=km,\qquad u'=k'm',\qquad u,u'\asymp U:=P^2Q,\qquad
 g=u-u'.
\tag{8}
\]
For fixed \(g\), there are \(O(U)\) possible pairs \((u,u')\). Restoring
the restricted factorizations \(u=km,\ u'=k'm'\) and divisor-bounded
coefficients costs \(T^\varepsilon\), so
\[
 R(g)\ll_\varepsilon T^\varepsilon P^2Q.
\tag{9}
\]
For \(g\ne0\), rationalization gives
\[
 \sqrt u-\sqrt{u'}=\frac{g}{\sqrt u+\sqrt{u'}},
\tag{10}
\]
and the phase in the \((n,r)\)-sum has magnitude
\[
 F\asymp \frac{Q|g|}{P}.
\tag{11}
\]
Since \(Q/P=T^{3\lambda/5-1}\) is a positive power, \(F\gg1\) for every
nonzero integral \(g\).

## Full-rank two-dimensional Poisson bound

For each fixed outer tuple, scaling \(n=Qx,\ r=Qy\) reduces the smooth
kernel to
\[
 \mathcal K_2(F)=
 \sum_{n,r\asymp Q}W_{\mathrm{out}}(n/Q,r/Q)
 e\!\left(-F(nr/Q^2)^{-1/2}\right).
\tag{12}
\]
The normalized phase is
\[
 \phi(x,y)=(xy)^{-1/2}.
\]
On every fixed positive compact support,
\[
 \det\nabla^2\phi(x,y)
 =\frac12x^{-3}y^{-3}>0,
\tag{13}
\]
and both eigenvalues of the Hessian are bounded above and below by
positive constants.

Two-dimensional Poisson summation gives integrals
\[
 Q^2\int_{\mathbb R^2}W_{\mathrm{out}}(x,y)
 e\!\left(-F\phi(x,y)-Q(jx+\ell y)\right)\,dx\,dy.
\tag{14}
\]
Repeated integration by parts makes modes outside
\[
 |j|+|\ell|\ll 1+F/Q
\tag{15}
\]
power-small. For every remaining mode, the Hessian in (14) is
\(-F\nabla^2\phi\). Thus the linear Poisson twist does not alter the
uniform definiteness of the Hessian. A compactly supported uniform
stationary-phase estimate bounds the normalized integral by \(O(F^{-1})\).
One precise reference for the \(d\)-dimensional \(F^{-d/2}\) estimate,
with controlled remainder under smooth perturbation, is Gressman,
[Lemma 2](https://arxiv.org/abs/1411.4680), which explicitly relates its
formulation to Hörmander's Theorem 7.7.5. In the present case strict
convexity gives at most one critical point; a fixed partition separates its
neighborhood from the region where integration by parts applies. The
amplitude is smooth and compactly supported, so no boundary critical point
occurs in (14). Hence
\[
 \boxed{\;
 |\mathcal K_2(F)|
 \ll_\varepsilon T^\varepsilon
 \frac{Q^2}{F}\left(1+\frac FQ\right)^2
 \ll_\varepsilon T^\varepsilon
 \left(\frac{Q^2}{F}+Q+F\right).
 \;}
\tag{16}
\]
All weights in (14) are jointly inert. The public endpoint assigns hard
endpoints before smoothing, so no unassigned boundary term is introduced
here.

## Dyadic difference blocks

Let \(\mathcal J_G\) be the part of (7) with
\(|g|\asymp G\), and put
\[
 F=\frac{QG}{P}.
\tag{17}
\]
There are \(O(G)\) shifts, each with representation count (9).
Equations (9) and (16) yield
\[
 |\mathcal J_G|
 \ll_\varepsilon
 T^\varepsilon G P^2Q
 \left(\frac{Q^2}{F}+Q+F\right).
\tag{18}
\]
Since \(G=FP/Q\), division by the target \(P^3Q^3\) gives
\[
 \frac{|\mathcal J_G|}{P^3Q^3}
 \ll_\varepsilon T^\varepsilon
 \left(
 \frac1Q+\frac F{Q^2}+\frac{F^2}{Q^3}
 \right).
\tag{19}
\]

Fix
\[
 0<\kappa<\frac{q_0}{2}.
\tag{20}
\]
If
\[
 F\le Q^{3/2}T^{-\kappa},
 \qquad\text{equivalently}\qquad
 |g|\le P Q^{1/2}T^{-\kappa},
\tag{21}
\]
then every term in (19) is
\(O(T^{-2\kappa})\): the first because \(2\kappa<q_0\), the second because
\(F/Q^2\le Q^{-1/2}T^{-\kappa}\), and the third by (21). Therefore
\[
 |\mathcal J_G|
 \ll_\varepsilon
 T^\varepsilon P^3Q^3T^{-2\kappa}.
\tag{22}
\]
This is a signed Gram-block estimate. The restriction on \(g\) is imposed
only after squaring and does not define a linear subsum of
\(\mathcal S_{\mathrm{lead}}\). If all remaining Gram blocks had the same
relative saving, (5) would convert \(T^{-2\kappa}\) to the square-root
scale \(T^{-\kappa}\); this note does not assert that complete bound.

The hard-endpoint pieces are independent linear errors separated in the
public one-\(Q\) endpoint theorem before the smoothing that leads to (12).
Their saving remains \(Q^{-1/2}=T^{-q_0/2}\); it is not used to turn the
partial Gram estimate (22) into a linear-sum estimate.

For \(g=0\), (9) and the trivial \(Q^2\) kernel give
\[
 \mathcal J_0\ll_\varepsilon T^\varepsilon P^2Q^3,
\tag{24}
\]
below the target by \(P^{-1}\).

The canonical choice \(\kappa=q_0/4\) reaches
\[
 F\le Q^{5/4},\qquad |g|\le P Q^{1/4},
\tag{25}
\]
with Gram saving \(Q^{-1/2}\) and conditional square-root scale
\(Q^{-1/4}\).
In the determinant notation \(h\asymp Qg\), this corresponds to
\(H\le P Q^{5/4}\).

The remaining range begins near \(F=Q^{3/2}\). No estimate for it is
asserted here.

## Formal status

[ActualMobiusDoubleQFullRankGram.lean](../../formalization/BuildingBlocks/ActualMobiusDoubleQFullRankGram.lean)
checks the double-Cauchy target, the three terms in (19), the
parameterized and canonical savings, and the relation between \(g,F,h\).
Lean does not formalize Cauchy's inequality in this application, Poisson
summation, the two-dimensional oscillatory-integral lemma, or the
determinant representation count.
