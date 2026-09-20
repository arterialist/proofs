# Low-shift saving in the actual one-\(Q\) Möbius Gram kernel

**Status:** unconditional written estimate, 20 September 2026. The Lean
companion checks only the scale and exponent algebra. The history
provenance, determinant count, and Cauchy argument remain written
mathematics. For every fixed \(0<\kappa<\lambda-2\), this note proves a
fixed power saving for
\[
 |h|\le PQT^{-\kappa}
\]
in the Gram kernel arising from the actual one-\(Q\) Poisson endpoint. It
does not estimate the remaining range up to the natural determinant scale,
extend the Möbius prefix by itself, or imply the Riemann hypothesis.

## Statement and coefficient provenance

Put
\[
 q_0=\frac{\lambda}{5},\qquad p=1-\frac{2\lambda}{5},\qquad
 Q=T^{q_0},\qquad P=T^p,\qquad N=Q^5,
 \qquad 2<\lambda<\frac{29}{14}.
\tag{1}
\]
Then
\[
 PQ^2=T,\qquad P^3<PQ.
\tag{2}
\]

The leading contribution in the
[one-\(Q\) Poisson endpoint](actual-mobius-critical-one-q-poisson-endpoint.md)
is
\[
 \mathcal S_{\mathrm{lead}}
 =P^{-1/2}
 \sum_{\substack{k\asymp P,\ m\asymp PQ\\n,r\asymp Q}}
 a_kb_m\beta(n)\delta(r)V_{k,m,n,r}
 e\!\left(-2\sqrt{\frac{kNm}{nr}}\right).
\tag{3}
\]
The coefficients are divisor bounded, \(V\) is jointly inert, and
\[
 \sum_{n\asymp Q}|\beta(n)|^2\ll_\varepsilon T^\varepsilon Q.
\tag{4}
\]

The coefficient in (4) retains the actual \(K=3\) history. In the first
all-unit expansion,
\[
 -3+\tau(r_0)
 =-1+\sum_{ux=r_0}1_{u\ge2}1_{x\ge2}.
\tag{5}
\]
The negative single-free packet is controlled before the endpoint.
Applying the same identity to the remaining signed factor \(s_0\) gives
\[
 -3+\tau(s_0)
 =-1+\sum_{vw=s_0}1_{v\ge2}1_{w\ge2}.
\tag{6}
\]
Thus the live pre-separation residual is a positive ordered tuple sum in
\(u,x,v,w,t\). At repeated contact, fix a nonempty proper labeled subset
\(I\subset\{t,v,w\}\) of product scale \(Q\). Then \(|I|=1\) or \(2\),
and after factorwise dyadic rectangularization one fixed history has
\[
 \beta(n)=
 \sum_{\prod_{i\in I}n_i=n}\prod_{i\in I}w_i(n_i),
\tag{7}
\]
before the unit-modulus log-linear twists introduced by the finite
Fourier--Mellin separator. A common product cutoff must be separated before
(7) is an autonomous one-variable coefficient. Ordered history
multiplicities are retained, and no Möbius sign remains in \(\beta\).
The divisor-moment bound (4) follows uniformly for every fixed history and
separator component. The full provenance is in the
[\(K=3\) bottom-slice note](actual-mobius-k3-bottom-slice-saving.md).

## Exact Gram normalization

Write
\[
 \mathcal D=P^{1/2}\mathcal S_{\mathrm{lead}}
 =\sum_{n\asymp Q}\beta(n)A_n.
\]
Cauchy's inequality gives
\[
 |\mathcal D|^2
 \le \#\{n\asymp Q\}
       \sum_{n\asymp Q}|\beta(n)A_n|^2
 \ll Q\mathcal G,
\tag{8}
\]
where
\[
\begin{aligned}
 \mathcal G={}&
 \sum_{n\asymp Q}|\beta(n)|^2
 \sum_{\substack{k,k'\asymp P\\m,m'\asymp PQ\\r,r'\asymp Q}}
 a_k\overline{a_{k'}}b_m\overline{b_{m'}}
 \delta(r)\overline{\delta(r')}\\
 &\quad\times
 V_{k,m,n,r}\overline{V_{k',m',n,r'}}
 e\!\left(-2\sqrt N\,n^{-1/2}
 \left[\sqrt{km/r}-\sqrt{k'm'/r'}\right]\right).
\end{aligned}
\tag{9}
\]
Therefore
\[
 |\mathcal S_{\mathrm{lead}}|^2
 =P^{-1}|\mathcal D|^2
 \ll \frac QP\,\mathcal G.
\tag{10}
\]
The endpoint target
\[
 |\mathcal S_{\mathrm{lead}}|\ll P Q^{5/2}
\tag{11}
\]
has square \(P^2Q^5\). By (10), its exact Gram target is
\[
 \mathcal G\ll \frac PQ\,P^2Q^5=P^3Q^4.
\tag{12}
\]

## Fixed nonzero determinant shifts

Put
\[
 u=km\asymp U:=P^2Q,\qquad u'=k'm'\asymp U,\qquad
 h=ur'-u'r.
\tag{13}
\]
For fixed \(h\ne0\) and fixed \(r,r'\asymp Q\), let \(d=(r,r')\). Equation
(13) has no solution unless \(d\mid h\). If \(d\mid h\), the possible
\(u\)'s lie in one residue class modulo \(r/d\), so there are
\[
 O(Ud/Q+1)=O(P^2d+1)
\tag{14}
\]
choices. Writing \(r=da,\ r'=da'\), and discarding \((a,a')=1\) for an
upper bound, gives
\[
 \begin{aligned}
 R(h)&:=\#\{(u,u',r,r'):ur'-u'r=h\}\\
 &\ll \sum_{d\mid h}(Q/d)^2(P^2d+1)
 \ll_\varepsilon T^\varepsilon P^2Q^2.
 \end{aligned}
\tag{15}
\]
The restricted representations \(u=km,\ u'=k'm'\), the divisor-bounded
coefficients, and the inert weights cost fixed divisor moments, already
absorbed into \(T^\varepsilon\).

Fix
\[
 0<\kappa<\lambda-2,
\tag{16}
\]
and let \(\mathcal G_H\) be the part of (9) with
\[
 1\le |h|\asymp H\le PQT^{-\kappa}.
\]
There are \(O(H)\) shifts in this block. Using (4) and (15), with the
\(n\)-sum taken absolutely for each outer tuple, gives
\[
 \boxed{\;
 |\mathcal G_H|
 \ll_\varepsilon T^\varepsilon H P^2Q^3.
 \;}
\tag{17}
\]
Relative to the Gram target (12), the ratio is
\[
 \frac{H P^2Q^3}{P^3Q^4}=\frac{H}{PQ}\le T^{-\kappa}.
\tag{18}
\]
Thus every dyadic block in the stated range has Gram saving
\(T^{-\kappa}\). Equation (10) takes a square root, giving
\[
 |\mathcal S_{\mathrm{lead},\,0<|h|\le PQT^{-\kappa}}|
 \ll_\varepsilon
 T^\varepsilon P Q^{5/2}T^{-\kappa/2}.
\tag{19}
\]
No cancellation between arithmetic Fourier modes, Poisson aliases, or
different dyadic \(H\)-blocks is used. Each block is bounded absolutely by
(17), and the logarithmic number of blocks is absorbed into
\(T^\varepsilon\).

This range strictly contains \(H\le P^3\), because
\[
 \frac{PQT^{-\kappa}}{P^3}
 =T^{\lambda-2-\kappa}>1.
\tag{20}
\]
For the canonical choice \(\kappa=(\lambda-2)/2\), the upper shift is
\(PQT^{-(\lambda-2)/2}\), and the original-sum saving in (19) is
\(T^{-(\lambda-2)/4}\). On the smaller range \(H\le P^3\), (18) gives the
stronger Gram saving \(T^{-(\lambda-2)}\).

## The exact diagonal

For \(h=0\), write \(r=da,\ r'=da'\), with \((a,a')=1\). The relation
\(ur'=u'r\) forces \(u=av,\ u'=a'v\). For fixed \(d,a,a'\), the number of
possible \(v\)'s is \(O(P^2d+1)\). Hence
\[
 \begin{aligned}
 R(0)
 &\ll \sum_{d\ll Q}(Q/d)^2(P^2d+1)\\
 &\ll_\varepsilon T^\varepsilon P^2Q^2.
 \end{aligned}
\tag{21}
\]
Using (4),
\[
 |\mathcal G_0|
 \ll_\varepsilon T^\varepsilon P^2Q^3
 =T^\varepsilon P^3Q^4(PQ)^{-1}.
\tag{22}
\]
After the prefactor in (10), the diagonal contributes at most
\[
 T^\varepsilon P^{1/2}Q^2
 =T^\varepsilon P Q^{5/2}(PQ)^{-1/2}
\tag{23}
\]
to \(|\mathcal S_{\mathrm{lead}}|\). It is therefore smaller than every
nonzero low-shift endpoint considered above.

## Endpoint and formal status

The number of dyadic coefficient histories and separator pieces is
\(T^\varepsilon\). The public one-\(Q\) endpoint assigns hard endpoints
before smoothing; its endpoint errors save \(Q^{-1/2}=T^{-\lambda/10}\)
relative to (11). This is stronger than the saving in (19), because
\[
\frac{\kappa}{2}<\frac{\lambda-2}{2}<\frac{\lambda}{10}
\tag{24}
\]
throughout \(2<\lambda<29/14\). Lower stationary terms have smaller inert
amplitudes. These losses therefore do not change (19).

For every fixed \(\kappa>0\), the estimate stops at
\(|h|=PQT^{-\kappa}\). The margin in (18) vanishes at \(H\asymp PQ\).
Completing the endpoint power saving requires a separate estimate for the
remaining band beginning near that scale and for all larger shifts.

[ActualMobiusLowShiftGramSaving.lean](../../formalization/BuildingBlocks/ActualMobiusLowShiftGramSaving.lean)
checks \(PQ^2=T\), the parameterized exponent in (18), the strict
extension past \(P^3\), the canonical choice of \(\kappa\), and the
endpoint-error comparison (24). Its
[axiom audit](../../formalization/verification/ActualMobiusLowShiftGramSavingAudit.lean)
checks every declaration in the module. Lean does not formalize the
history expansion, determinant counts, Cauchy reduction, or analytic
endpoint theorem.
