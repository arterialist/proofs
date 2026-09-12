# Derivative equality directions exclude positive finite-path comparison

This is an obstruction to a specified comparison method for the actual theta jump form. It is not a disproof of its sharp gap, RH, or a signed coupling. The only analytic input beyond positivity and decay of the actual theta kernel is the unconditional derivative radical identity established in [the ground-state chapter](theta-weil-jump-form.md).

## Exact measures and equality directions

Write unordered edges as pairs $(u,v)$ with $u<v$. With the normalization of that note, define

$$
dC_P(u,v)=2\cosh((v-u)/2)\Phi(u)\Phi(v)\,du\,dv,
$$
$$
dC_J^{\mathrm{ac}}(u,v)=r(v-u)\Phi(u)\Phi(v)\,du\,dv,
\qquad r(a)=\frac{e^{-a/2}}{1-e^{-2a}},
$$

and include in $C_J$ every prime-power line $v=u+\log q$ with measure
$\Lambda(q)\Phi(u)\Phi(u+\log q)\,du/\sqrt q$. These are the complete pole and jump conductance measures. Both are sigma-finite off the diagonal. Put

$$
E_C(h)=\int_{u<v}|h(v)-h(u)|^2\,dC(u,v),
\qquad s_j(u)=\frac{\Phi^{(j)}(u)}{\Phi(u)}\quad(j\ge0).
$$

The previously proved unconditional identity gives

$$
E_{C_J}(s_j)=E_{C_P}(s_j)<\infty \qquad(j\ge0).
\tag{1}
$$

Indeed $\Phi s_j=\Phi^{(j)}$ is in the full Weil radical, and the ground-state identity is $Q(\Phi h)=E_{C_J}(h)-E_{C_P}(h)$. This is the full pole comparison, including its odd term; it is not an assertion that every odd score attains the ordinary Poincare quotient.

## Finite evaluation independence

For distinct real points $x_1,\ldots,x_k$, the vectors

$$
\big(s_j(x_i)\big)_{j\ge0},\qquad i=1,\ldots,k,
$$

are linearly independent. To prove this, suppose
$\sum_i c_i s_j(x_i)=0$ for every $j\ge0$, and put $a_i=c_i/\Phi(x_i)$. The real analytic function

$$
F(z)=\sum_i a_i\Phi(x_i+z)
$$

has every derivative zero at zero. Real analyticity first gives zero near zero and then on the whole real axis. Real analyticity here follows directly from locally normally convergent theta series in a complex neighborhood of every real point (or from the even theta continuation on the negative half-axis). Taking the Fourier transform gives

$$
\widehat\Phi(t)\sum_i a_i e^{-itx_i}=0 \qquad(t\in\mathbb R).
$$

Since $\widehat\Phi(0)=\int\Phi>0$, the finite exponential polynomial vanishes on an interval. Its derivatives of orders $0,\ldots,k-1$ at any point in that interval give an invertible Vandermonde system. Thus all $a_i$, and hence all $c_i$, vanish. This proof needs no claim about zeros of $\widehat\Phi$ away from zero.

## The comparison class

A positive finite-path routing is a positive measure $\Pi$ on paths

$$
\gamma=(x_0,\ldots,x_m;\theta_1,\ldots,\theta_m),\qquad
m\ge1,\quad x_{i-1}\ne x_i,\quad
\theta_i>0,\quad\sum_i\theta_i=1.
$$

Its endpoint map to the unordered pair $\{x_0,x_m\}$ has pushforward $C_P$. Intermediate vertices, path length and weights may depend arbitrarily on the endpoints and on auxiliary random marks. Backtracking and repeated nonadjacent vertices are allowed. Consecutive zero edges are omitted. The induced edge load is

$$
L=\int\sum_{i=1}^m\theta_i^{-1}
\delta_{\{x_{i-1},x_i\}}\,d\Pi(\gamma).
$$

The usual capacity-one hypothesis is the measure inequality $L\le C_J$. Weighted Cauchy--Schwarz then proves the desired comparison:

$$
|h(x_m)-h(x_0)|^2
\le\sum_i\frac{|h(x_i)-h(x_{i-1})|^2}{\theta_i},
\qquad E_{C_P}(h)\le E_L(h)\le E_{C_J}(h).
\tag{2}
$$

This includes arbitrary positive edge resistances after normalization by their total. The route measure is allowed to have unbounded path lengths, provided every individual path is finite. It is a single comparison valid for all test functions, not a route chosen separately for each test function.

## Rigidity of equality

For a fixed path define the nonnegative Cauchy defect

$$
D_\gamma(h)=\sum_i\frac{|h(x_i)-h(x_{i-1})|^2}{\theta_i}
-|h(x_m)-h(x_0)|^2.
$$

If $m\ge2$, this defect cannot vanish for every score $s_j$. Equality in weighted Cauchy--Schwarz requires

$$
\frac{s_j(x_1)-s_j(x_0)}{\theta_1}
=\frac{s_j(x_2)-s_j(x_1)}{\theta_2}
\qquad\hbox{for every }j.
\tag{3}
$$

The signed evaluation measure in (3) is

$$
-\theta_1^{-1}\delta_{x_0}
+(\theta_1^{-1}+\theta_2^{-1})\delta_{x_1}
-\theta_2^{-1}\delta_{x_2}.
$$

It is nonzero: if $x_2=x_0$, its endpoint coefficients add with the same sign; otherwise the three points are distinct. Consecutive vertices are distinct by definition. Finite evaluation independence contradicts (3). Hence each path with at least two edges has $D_\gamma(s_j)>0$ for at least one integer $j$.

Suppose a capacity-one routing existed. Applying (2) and (1) gives

$$
0=E_{C_J}(s_j)-E_{C_P}(s_j)
=E_{C_J-L}(s_j)+\int D_\gamma(s_j)\,d\Pi(\gamma).
$$

Both terms are nonnegative and finite, so $D_\gamma(s_j)=0$ for almost every path, for each $j$. There are only countably many scores; intersecting these full-measure sets forces $m=1$ almost everywhere. All steps use nonnegative integration, so sigma-finiteness of the total route measure causes no subtraction of infinities. For single-edge paths, $\theta_1=1$, and the endpoint condition then forces $L=C_P$.

## Direct domination fails for the actual measures

For $a\ge\log2$,

$$
\frac{r(a)}{2\cosh(a/2)}
=\frac{1}{(1-e^{-2a})(e^a+1)}
\le\frac49<1.
$$

Take a bounded open rectangle of edges with $v-u>\log2$ and remove every prime-power line $v-u=\log q$. The removed set has two-dimensional Lebesgue measure zero, while all prime atoms are removed. Positivity of $\Phi$ then gives strictly more $C_P$ mass than $C_J$ mass on the remaining set. Therefore $C_P$ is not dominated by $C_J$, contradicting $L=C_P\le C_J$.

No positive finite-path routing with weighted Cauchy--Schwarz and capacity-one domination can prove the actual full pole-to-jump comparison. This excludes all such random or endpoint-dependent routes, including paths of unbounded finite length, not merely the previously tested factorization path. It leaves signed identities, comparisons on a quotient, test-dependent constructions, infinite-path limits, and other methods outside this precise class open. A proof of the ordinary sharp Poincare gap might also use its score projection in a way that is not a positive routing of the full pole conductance; that is not excluded here.
