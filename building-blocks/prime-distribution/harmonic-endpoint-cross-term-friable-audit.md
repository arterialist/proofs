# Harmonic--endpoint cross term: exact friable reduction and metric obstruction

The degree-zero valuation harmonic vector is the normalized Riesz representative of the coefficient-sum functional.  Consequently its cross term with the moving admission boundary is independent of the detailed vertex metric except for one positive capacity factor.  The arithmetic numerator is exactly the signed (P)-friable Abel tail, with its literal lower and upper Stieltjes endpoints.  No positive choice of valuation-Hodge metric can make this cross term vanish or acquire a fixed sign unless the friable tail itself does so.

## 1. Metric-independent harmonic pairing

Fix a finite terminal-vertex graph
\[
 \Gamma_L=\{V_n:1\le n\le L\},
\]
with an edge (V_n\to V_{np}) whenever (np\le L).  All vertices are retained, including prime powers and nonsquarefree integers.  Let (B) be its incidence matrix.  Since the graph is connected,
\[
 \operatorname{im}B=\ker(\mathbf1^*).
 \tag{1}
\]
Let (G_L) be any positive definite vertex metric.  This includes the actual central clock-angle Gram (G_{0,L}), the finite centered Green Gram, and any other legitimate positive valuation-Hodge vertex metric.  The normalized degree-zero harmonic vector is
\[
 h_L={G_L^{-1}\mathbf1\over D_L},
 \qquad
 D_L:=\mathbf1^*G_L^{-1}\mathbf1>0,
 \qquad
 \mathbf1^*h_L=1.
 \tag{2}
\]
Thus
\[
 G_Lh_L={\mathbf1\over D_L},
 \qquad
 \|h_L\|_{G_L}^2={1\over D_L}.
 \tag{3}
\]
For every vertex vector (b), one therefore has the exact identity
\[
 \boxed{
 \langle h_L,b\rangle_{G_L}
 ={\mathbf1^*b\over D_L}.}
 \tag{4}
\]
The choice of positive edge metric is irrelevant: it changes the weighted adjoint on edges but not (1), the harmonic line, or (4).

More generally, if (x=x_0+m h_L) and (b=b_0+s h_L) are the Hodge decompositions, where
\[
 m=\mathbf1^*x,\qquad s=\mathbf1^*b,
 \qquad x_0,b_0\in\operatorname{im}B,
\]
then
\[
 \boxed{
 \langle x,b\rangle_{G_L}
 =\langle x_0,b_0\rangle_{G_L}
 +{\overline m s\over D_L}.}
 \tag{5}
\]
Hodge orthogonality kills only the cross terms between the exact and harmonic summands.  It does not kill the harmonic part of the boundary; that part is exactly (s h_L).

## 2. The moving admission boundary as a vertex vector

Put
\[
 q_X=e^{-2/X},\qquad P^\#=\prod_{p\le P}p.
\]
For (1\le j\le L\), define the truncated moving endpoint vector
\[
 \mathfrak b_{X,P;j,L}
 :=q_X^{-j/2}
 \sum_{\substack{d\mid P^\#\\j\le d\le L}}
 \mu(d)q_X^dV_d.
 \tag{6}
\]
Every endpoint and sign in the prime-admission face is literal.  Prime powers remain as vertices of (Gamma_L); their coefficient in (6) is zero because of the actual Möbius source, not because they were removed from the geometry.

Its coefficient mass is
\[
 E_{X,P}(j;L)
 :=\mathbf1^*\mathfrak b_{X,P;j,L}
 =q_X^{-j/2}
 \sum_{\substack{d\mid P^\#\\j\le d\le L}}
 \mu(d)q_X^d.
 \tag{7}
\]
Combining (4) and (7) proves the exact harmonic--boundary law
\[
 \boxed{
 \langle h_L,\mathfrak b_{X,P;j,L}\rangle_{G_L}
 ={E_{X,P}(j;L)\over D_L}.}
 \tag{8}
\]
If the harmonic component of another source is (m h_L), its cross term with the endpoint is
\[
 \boxed{
 2\operatorname{Re}
 \langle m h_L,\mathfrak b_{X,P;j,L}\rangle_{G_L}
 ={2\operatorname{Re}\{\overline m E_{X,P}(j;L)\}\over D_L}.}
 \tag{9}
\]
For real arithmetic sources this is (2mE_{X,P}(j;L)/D_L).  Formula (9), rather than zero, is the rank-one Schur term that must be paid.

Taking (L=P^\#) gives the complete admission endpoint (E_{X,P}(j)).  Equivalently, the Hodge decomposition of the boundary itself is
\[
 \boxed{
 \mathfrak b_{X,P;j,P^\#}
 =\bigl(\mathfrak b_{X,P;j,P^\#}-E_{X,P}(j)h_{P^\#}\bigr)
 +E_{X,P}(j)h_{P^\#}.}
 \tag{10}
\]
The first summand is an exact vertex boundary and is orthogonal to (h_{P^\#}); the second is the surviving harmonic endpoint.

This endpoint mode is a genuine commutator with the moving cut.  Let
\[
 a_P=\sum_{d\mid P^\#}\mu(d)V_d,
 \qquad
 Q_{X,j}V_d=q_X^{d-j/2}V_d,
 \qquad
 \Pi_{\ge j}V_d=1_{d\ge j}V_d.
 \tag{10a}
\]
For every nonempty admitted prime set, \(\mathbf1^*a_P=0\), so
\(P_{\mathcal H}a_P=0\).  Nevertheless
\[
 \mathfrak b_{X,P;j,P^\#}=\Pi_{\ge j}Q_{X,j}a_P
\]
and therefore
\[
 \boxed{
 [P_{\mathcal H},\Pi_{\ge j}Q_{X,j}]a_P
 =E_{X,P}(j)h_{P^\#}.}
 \tag{10b}
\]
Thus decomposing the unsliced admitted source first would miss the entire
harmonic endpoint.  The Abel weight and moving lower face do not commute
with the Hodge projection.

## 3. Exact signed-friable Stieltjes numerator

Let
\[
 M(t,P)=\sum_{\substack{n\le t\\P^+(n)\le P}}\mu(n).
 \tag{11}
\]
On the support of (mu), (P^+(n)\le P) is equivalent to (n\mid P^\#).  For finite (L\), Stieltjes summation with both endpoints retained gives
\[
\begin{aligned}
 q_X^{j/2}E_{X,P}(j;L)
 &=\int_{[j,L]}e^{-2t/X}\,dM(t,P)\\
 &=e^{-2L/X}M(L,P)-e^{-2j/X}M(j-1,P)\\
 &\quad+{2\over X}\int_j^Le^{-2t/X}M(t,P)\,dt.
\end{aligned}
 \tag{12}
\]
At (L=P^\#) and for a nonempty admitted prime set,
\[
 M(P^\#,P)=\sum_{d\mid P^\#}\mu(d)=0.
\]
Hence (12) becomes
\[
 \boxed{
 q_X^{j/2}E_{X,P}(j)
 =-e^{-2j/X}M(j-1,P)
 +{2\over X}\int_j^\infty e^{-2t/X}M(t,P)\,dt.}
 \tag{13}
\]
Combining (8) and (13) is the requested exact arithmetic evaluation of the cross term.  It is a friable Mertens observable, not a new positive Hodge contribution.

For (j\le P), friability is void in the lower endpoint and (M(j-1,P)=M(j-1)).  At full admission (P=X), every squarefree integer below the first horizon is included, and one may also write
\[
 E_{X,X}(j)=q_X^{-j/2}
 \left\{Z_X(q_X)-\sum_{d<j}\mu(d)q_X^d\right\},
 \qquad 1\le j\le X,
 \tag{14}
\]
where
\[
 Z_X(q_X)=\sum_{d\mid X^\#}\mu(d)q_X^d.
\]
There is no additive Euler-product factorization of (Z_X).

## 4. Quantitative consequences

The established signed-friable estimate gives, under
\[
 {\log P\over\sqrt{\log X}}\longrightarrow\infty,
 \qquad {P^2\log P\over X}\longrightarrow0,
 \tag{15}
\]
the uniform bounds
\[
 |E_{X,P}(j)|\ll
 \begin{cases}
 e^{j/X}X/(\log P)^2,&j<P^2,\\[3pt]
 e^{-j/X}(j+X)/(\log P)^2,&P^2\le j\le X\log X.
 \end{cases}
 \tag{16}
\]
Thus every legitimate vertex Hodge metric satisfies
\[
 \boxed{
 |\langle h_{P^\#},\mathfrak b_{X,P;j,P^\#}\rangle_{G_{P^\#}}|
 \ll {1\over D_{P^\#}}
 \begin{cases}
 e^{j/X}X/(\log P)^2,&j<P^2,\\[3pt]
 e^{-j/X}(j+X)/(\log P)^2,&P^2\le j\le X\log X.
 \end{cases}}
 \tag{17}
\]
The arithmetic saving in (17) is sharp relative to the cited friable input.  Hodge theory contributes only the positive capacity factor (D_{P^\#}^{-1}); without an independent capacity estimate it supplies no further decay.

At complete admission, the proved first-horizon asymptotic instead gives
\[
 E_{X,X}(j)
 =(\kappa+o(1)){X\over\log X}e^{j/X}
 \qquad(1\le j\le X),
 \tag{18}
\]
uniformly in (j), with (kappa>0).  Therefore
\[
 \boxed{
 \langle h_{X^\#},\mathfrak b_{X,X;j,X^\#}\rangle_{G_{X^\#}}
 =(\kappa+o(1)){X e^{j/X}\over D_{X^\#}\log X}.}
 \tag{19}
\]
The coherent endpoint is present in every positive vertex metric; only its capacity normalization changes.

## 5. No vanishing or sign law from the metric

Equation (8) rules out a metric-created cancellation.  Since (D_L>0),
\[
 \langle h_L,\mathfrak b_{X,P;j,L}\rangle_{G_L}=0
 \quad\Longleftrightarrow\quad E_{X,P}(j;L)=0.
 \tag{20}
\]
It also rules out a universal sign.  Already for (P=2), (L=2),
\[
 E_{X,2}(1;2)=q_X^{1/2}(1-q_X)>0,
 \qquad
 E_{X,2}(2;2)=-q_X<0.
 \tag{21}
\]
Thus the same admitted prime set produces both signs as the moving endpoint crosses the lower face.  No positive choice of (G_L), and no positive edge metric defining the Hodge adjoint, can change those signs.

One could force orthogonality by declaring a different linear functional to define the harmonic line, but then (operatorname{im}B\ne\ker(\text{that functional})); it would no longer be the degree-zero Hodge decomposition of the connected valuation graph.  On the full cubical cell space the actual observation Gram is only semidefinite and has no compatible boundary adjoint, so that space supplies no alternative legitimate cancellation either.

## 6. Sharp obstruction

For an arbitrary source (x), (5) applied to the endpoint gives
\[
 \boxed{
 \langle x,\mathfrak b_{X,P;j,L}\rangle_{G_L}
 =\left\langle x-(\mathbf1^*x)h_L,
 \mathfrak b_{X,P;j,L}-E_{X,P}(j;L)h_L\right\rangle_{G_L}
 +{\overline{(\mathbf1^*x)}E_{X,P}(j;L)\over D_L}.}
 \tag{22}
\]
The first term is a signed exact--exact covariance.  The second is the explicit friable/Mertens rank-one mode.  Hodge orthogonality removes neither one: it merely separates them.  Any proposed valuation-Hodge estimate for the admission boundary must therefore control the signed covariance in (22) and the exact Stieltjes observable (13), while paying the actual capacity.  No choice of natural positive metric supplies a vanishing or one-sided cross term by itself.

## 7. Finite formalization

[HarmonicEndpointCrossFinite.lean](../../formalization/BuildingBlocks/HarmonicEndpointCrossFinite.lean) formalizes the finite Gram--Riesz identity behind (4), the moving-cut projection commutator (10b), and the opposite signs in the two-face example (21). The graph connectivity, Stieltjes identity, and analytic friable estimates remain written inputs.
