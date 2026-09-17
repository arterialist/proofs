# Original-L² domain and invertibility of the actual factorial ground-state form

The local ground-state identity is classical; see [Lenz, Stollmann and Veselić, Theorem 2.3](https://arxiv.org/abs/0811.2135) for a primary measure-potential formulation. Its local positive-solution and bounded-inverse hypotheses apply on compact subsets of (1,infinity). The closed domain, singular endpoint, explicit inverse and actual-source extension below are proved separately.

Let the actual factorial potential be
$$
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad x>1.
\tag{1}
$$
It is positive and continuous, $F(1)=0$, $F(x)=\log x$ for $1<x\le2$, and locally absolutely continuous. Its exact distributional equation is
$$
F'(x)=\frac{x-\psi(x)}{x^2}\quad\text{a.e.},\qquad
(x^2F')'=dx-\sum_{n\ge2}\Lambda(n)\delta_n.
\tag{2}
$$
All prime powers and right-continuous values of $\psi$ are retained. We use the compact ground-state identity proved from (2), and establish its closed domain and actual-source meaning. The ambient Hilbert space throughout is the original $L^2((1,\infty),dx)$, identified by zero extension with the causal closed subspace $\mathbf1_{[1,\infty)}L^2((0,\infty),dx)$. No dense-domain or coercivity assertion is made here for arbitrary functions supported below one.

Define
$$
b_F(x)=\frac{xF'(x)}{F(x)},\qquad
A_Fh=xh'-b_Fh=xF(h/F)'.
\tag{3}
$$
The minimal test core is $\mathcal C=C_c^\infty(1,\infty)$. The resulting closed form has precisely the domain
$$
\boxed{\mathcal D=
\{h\in L^2(dx):h\in AC_{\rm loc}(1,\infty),\
xh'\in L^2(dx),\ h(1+)=0\}.}
\tag{4}
$$
Its arithmetic terms are separately finite on this whole domain. Moreover, after the original Hardy pullback
$$
Hg(x)=\frac1x\int_1^xg(u)\,du,
\tag{5}
$$
the factor $R_F=A_FH$ is a boundedly invertible operator on the original $L^2(dx)$. This gives uniform coercivity, not a spectral identification with zeta.

## 1. Elementary bounds for the actual coefficients

It is useful to keep explicit, nonoptimized constants:
$$
\boxed{\frac1{12}\le F(x)\le5,\qquad |b_F(x)|\le48
\quad(x\ge2),\qquad b_F(x)=1/\log x\quad(1<x<2).}
\tag{6}
$$
Here is an elementary justification. The standard binomial argument gives
$\psi(2n)-\psi(n)\le2n\log2$: the exponent of each prime in $\binom{2n}{n}$ includes every power in $(n,2n]$, and all remaining terms are nonnegative. Summing at powers of two, then enlarging a real $x$ to the next power of two, yields
$$
\psi(x)\le4x\log2<3x,\qquad x\ge1.
\tag{7}
$$
No PNT is needed.

The actual factorial identity, including its endpoint terms, is
$$
xF(x)=x\log x-\log(\lfloor x\rfloor!)
+\sum_{n\le x}\Lambda(n)\left(1-\left\{\frac xn\right\}\right).
\tag{8}
$$
Put $m=\lfloor x\rfloor\ge2$. Integral bounds for $\log(m!)$ show that the first two terms on the right, divided by $x$, lie between
$$
\frac{m-1-\log m}{m+1}\quad\text{and}\quad2.
$$
The lower expression is at least $1/12$: at $m=2$, use $\log2<3/4$, and the derivative of
$m-1-\log m-(m+1)/12$ is positive for $m\ge2$.
The last term of (8) is nonnegative and at most $\psi(x)$. Thus (7) proves the bounds for $F$. Equation (2) then gives
$|b_F|\le(1+\psi(x)/x)/F\le48$. This proves (6).
Values of $b_F$ at its jump points are immaterial as multiplication coefficients in $L^2$.

## 2. The Hardy map is an isomorphism onto the proposed form domain

The ordinary Hardy inequality, with zero extension below one, gives
$$
\|Hg\|_2\le2\|g\|_2.
\tag{9}
$$
There is also an exact normalization:
$$
\boxed{x(Hg)'=g-Hg,\qquad
\|x(Hg)'\|_2=\|g\|_2.}
\tag{10}
$$
For compactly supported $g$, integration of
$\left|\int_1^xg\right|^2/x^2$ by parts gives
$2\operatorname{Re}\langle g,Hg\rangle=\|Hg\|_2^2$.
Its boundary at one is zero; at infinity the numerator is eventually constant. This identity proves both (9) and (10). Approximation in $L^2$, using (9), extends the identities to every $g\in L^2$.

The trace of $Hg$ at one is zero by Cauchy--Schwarz on $(1,x)$, so $Hg\in\mathcal D$. Conversely, if $h\in\mathcal D$, then
$$
g=xh'+h\in L^2,\qquad
xh(x)=\int_1^xg(u)\,du,
$$
and $h=Hg$. Thus $H:L^2\to\mathcal D$ is a topological isomorphism, with inverse $h\mapsto xh'+h$. In particular the domain in (4) is complete in
$\|h\|_2^2+\|xh'\|_2^2$.

## 3. The ground-state factor has a bounded inverse after pullback

On the entire original $L^2$, define
$$
\boxed{R_Fg=g-(1+b_F)Hg.}
\tag{11}
$$
It is bounded, including at the singular endpoint. For $1<x<2$,
$$
|b_F(x)Hg(x)|
\le\frac1{x-1}\int_1^x|g(u)|\,du,
$$
since $x\log x\ge x-1$. The finite-interval Hardy inequality bounds its $L^2(1,2)$ norm by $2\|g\|_2$. On $x\ge2$, (6) and (9) bound it by $96\|g\|_2$. Hence, for example,
$$
\|R_Fg\|_2\le101\|g\|_2.
\tag{12}
$$

There is an explicit inverse. Given arbitrary $\eta\in L^2(dx)$, set
$$
\boxed{
h_\eta(x)=-F(x)\int_x^\infty\frac{\eta(u)}{uF(u)}\,du,\qquad
g_\eta(x)=\eta(x)+(1+b_F(x))h_\eta(x).}
\tag{13}
$$
For every $x>1$, the integral converges absolutely by Cauchy--Schwarz, compact positivity of $F$, and (6) at infinity. Local differentiation gives
$$
x h_\eta'-b_Fh_\eta=\eta.
\tag{14}
$$

The dual Hardy inequality is
$$
\left\|\int_x^\infty\frac{v(u)}u\,du\right\|_{L^2(dx)}
\le2\|v\|_2,
$$
and its finite-interval version has the same constant. On $x\ge2$, (6) therefore gives
$$
\|h_\eta\|_{L^2(2,\infty)}\le120\|\eta\|_2,\qquad
\|b_Fh_\eta\|_{L^2(2,\infty)}\le5760\|\eta\|_2.
\tag{15}
$$
For $1<x<2$, write
$$
\frac{h_\eta(x)}{\log x}
=-\int_x^2\frac{\eta(u)}{u\log u}\,du-T_\eta,\qquad
T_\eta=\int_2^\infty\frac{\eta(u)}{uF(u)}\,du.
$$
Since $u\log u\ge u-1$, the first term is bounded by the finite dual Hardy operator in the variable $u-1$. Also
$$
|T_\eta|\le\frac{12}{\sqrt2}\|\eta\|_{L^2(2,\infty)}<9\|\eta\|_2.
$$
Consequently
$$
\|b_Fh_\eta\|_{L^2(1,2)}\le11\|\eta\|_2,\qquad
\|h_\eta\|_{L^2(1,2)}\le11\|\eta\|_2.
\tag{16}
$$
The estimates deliberately use coarse absolute constants.

Near one, the same integral and Cauchy--Schwarz give
$$
|h_\eta(x)|\le C\sqrt{x-1}\|\eta\|_2+(x-1)|T_\eta|\longrightarrow0.
$$
Equations (14)--(16) show $h_\eta\in\mathcal D$, $g_\eta\in L^2$, and
$$
\|g_\eta\|_2\le5903\|\eta\|_2<6000\|\eta\|_2.
\tag{17}
$$
Since $(xh_\eta)'=g_\eta$ and $h_\eta(1)=0$, $h_\eta=Hg_\eta$. Thus $R_Fg_\eta=\eta$.

Injectivity is equally important. If $R_Fg=0$, then $h=Hg$ satisfies $(h/F)'=0$, hence $h=cF$. The bound $F\ge1/12$ at infinity excludes $c\ne0$ in $L^2$. Therefore
$$
\boxed{R_F:L^2(dx)\longrightarrow L^2(dx)
\text{ is boundedly invertible},\qquad
\|R_F^{-1}\|\le6000.}
\tag{18}
$$
There is no chosen arbitrary integration constant or unretained boundary state in (13).

## 4. Endpoint, maximal domain, and density of the compact core

The endpoint condition in (4) is also forced by the maximal first-order domain. Suppose merely that $h\in L^2$, $h\in AC_{\rm loc}$, and $\eta=A_Fh\in L^2$. The differential equation implies
$$
h(x)/F(x)=c-\int_x^\infty\frac{\eta(u)}{uF(u)}\,du
$$
for a constant $c$: the integral is absolutely convergent at infinity. If $c\ne0$, the integral tends to zero and $F\ge1/12$ makes $h\notin L^2$. Thus $c=0$, and the preceding inverse estimates prove $h\in\mathcal D$. Hence
$$
\boxed{\mathcal D(A_{F,\max})=\mathcal D.}
\tag{19}
$$
In particular $h(1)=0$ is automatic in this maximal domain. There is no additional requirement that $h/F$ vanish at one. Such a requirement would wrongly exclude the actual integrated sources below.

The core $\mathcal C=C_c^\infty(1,\infty)$ is dense in $\mathcal D$ for the weighted Sobolev norm. Here are the endpoint details. Near one, cut off on $(1+\epsilon,1+2\epsilon)$. The derivative error is bounded by the tail of
$$
\int_1^2\frac{|h(x)|^2}{(x-1)^2}\,dx
\le4\int_1^2|h'(x)|^2\,dx<\infty,
\tag{20}
$$
so it tends to zero as $\epsilon\downarrow0$. At infinity, use a cutoff equal to one up to $R$, zero beyond $2R$, with $|x\chi_R'|\le C$; its derivative error is controlled by the $L^2$ tail of $h$, while the other error is the tail of $xh'$. Finally mollify on the remaining compact interior interval, where the weight $x$ is bounded. This proves the asserted density.

By (10), (11), and (18), the graph norm of $A_F$ is equivalent to the weighted Sobolev norm on $\mathcal D$. Therefore the closure of $A_F$ initially defined on $\mathcal C$ is exactly its maximal realization (19). No unspecified endpoint extension is being used.

## 5. The arithmetic measure terms are globally legitimate

For every $h\in\mathcal D$, the continuum term is finite:
$$
\boxed{\int_1^\infty\frac{|h(x)|^2}{F(x)}\,dx
\le12\|h\|_2^2+8\|xh'\|_2^2.}
\tag{21}
$$
On $x\ge2$, use $1/F\le12$. On $(1,2)$, use
$1/\log x\le2/(x-1)\le2/(x-1)^2$ and (20).

For the atomic term, let $I_j=[2^j,2^{j+1}]$, $j\ge1$, of length $a=2^j$. The scaled one-dimensional trace estimate is
$$
\sup_{I_j}|h|^2
\le\frac2a\int_{I_j}|h|^2\,dx
+2a\int_{I_j}|h'|^2\,dx.
$$
Assign integer atoms to the half-open versions of these intervals. The total $\Lambda$-mass on a block is at most $\psi(2a)\le6a$, and $1/F(n)\le12$. Summing disjoint blocks gives
$$
\boxed{\sum_{n\ge2}\frac{\Lambda(n)|h(n)|^2}{F(n)}
\le144\bigl(\|h\|_2^2+\|xh'\|_2^2\bigr).}
\tag{22}
$$
Point evaluations use the continuous representative of $h$. Every prime power remains in this sum. There is no atom at one, and no undefined expression $\Lambda(1)/F(1)$ is introduced.

Both observations in (21)--(22) are bounded linear maps from the weighted Sobolev domain into their respective $L^2$ spaces. Thus their squares and all polarized cross terms converge under core approximation. The compact identity consequently extends to every $h\in\mathcal D$:
$$
\boxed{
q_F[h]=\|A_Fh\|_2^2
=\int_1^\infty x^2|h'|^2\,dx
+\int_1^\infty\frac{|h|^2}{F}\,dx
-\sum_{n\ge2}\frac{\Lambda(n)|h(n)|^2}{F(n)}.}
\tag{23}
$$
Each displayed term is separately finite. This is a densely defined closed nonnegative form on the original $L^2(dx)$, namely the closure of the specified compact core.

It is in fact coercive. With $g=xh'+h$, equations (10) and (18) give
$$
q_F[h]\ge6000^{-2}\|g\|_2^2
=6000^{-2}\|xh'\|_2^2
\ge(4\cdot6000^2)^{-1}\|h\|_2^2.
\tag{24}
$$
These constants are not optimized. This closed-form conclusion makes no assertion about a zeta spectral correspondence.

## 6. The bounded pulled-back operator on original L²

For $g\in L^2$, define the two bounded observation maps
$$
J_{\rm cont}g=\frac{Hg}{\sqrt F}\in L^2(dx),\qquad
(J_{\rm ar}g)_n=\sqrt{\frac{\Lambda(n)}{F(n)}}\,Hg(n)
\in\ell^2(n\ge2).
\tag{25}
$$
Their boundedness follows from (9)--(10) and (21)--(22). Hence the expression
$$
\boxed{\mathcal K_F
=I+J_{\rm cont}^*J_{\rm cont}-J_{\rm ar}^*J_{\rm ar}
=R_F^*R_F}
\tag{26}
$$
is a literal bounded self-adjoint operator on the original $L^2(dx)$, not a formal product with an unbounded signed measure. The equality follows from (23) with $h=Hg$, and the exact derivative normalization (10).

In particular
$$
\boxed{
6000^{-2}\|g\|_2^2
\le\langle g,\mathcal K_Fg\rangle
=\|R_Fg\|_2^2
\le57\|g\|_2^2.}
\tag{27}
$$
For the upper bound, drop the nonnegative atomic term in (23), then use (21), $\|Hg\|\le2\|g\|$, and $\|x(Hg)'\|=\|g\|$.
This supplies a boundedly invertible positive pulled-back operator with explicit absolute bounds. It does not identify it with any earlier theta or Weil operator.

## 7. Actual integrated frozen sources

For every actual finite integer $N\ge2$, let
$$
g_N(x)=\mathbf1_{x\ge1}\frac{E_\psi(\min(x,N))}{x},
\qquad h_N=Hg_N.
\tag{28}
$$
The finite source is in $L^2$, and therefore
$$
h_N\in\mathcal D,\qquad
\|h_N\|_2\le2\|g_N\|_2,\qquad
xh_N'=g_N-h_N,\qquad
\|xh_N'\|_2=\|g_N\|_2.
\tag{29}
$$
On $1<x\le2$, the actual source is $-1$ almost everywhere, so
$$
h_N(x)=-(x-1)/x,\qquad
h_N(x)/F(x)\longrightarrow-1\quad(x\downarrow1).
\tag{30}
$$
Thus the true form domain permits the nonzero ratio at the singular endpoint.

Let $J_N=\int_1^N g_N(u)\,du$. The exact frozen tail is
$$
h_N(x)=\frac{J_N+E_\psi(N)\log(x/N)}x,\qquad x\ge N.
\tag{31}
$$
In particular all continuum and derivative integrals converge at infinity, while (21)--(22) prove the same globally without splitting terms. The observing arithmetic measure does not stop at the source cutoff: its exact tail is
$$
\sum_{n>N}\Lambda(n)
\frac{|J_N+E_\psi(N)\log(n/N)|^2}{n^2F(n)}<\infty.
\tag{32}
$$
The atom at $n=N$ is retained in the core sum $2\le n\le N$; formula (31) agrees there.

Thus the identity and its polarization are legitimate on these actual finite sources, with no omitted tail, endpoint counterterm, or assumption of a global $L^2$ completed source. Quantitatively,
$$
6000^{-2}\|g_N\|_2^2\le q_F[h_N]\le57\|g_N\|_2^2.
\tag{33}
$$
The separate finite-source and birth-polarization formulas are supplied by [the finite-source Picone proof](../dynamics-and-feedback/picone-frozen-source-work.md). Positivity of the form does not assign signs to its individual mixed arithmetic contributions.

## Arithmetic consumers and formal scope

The [growing-clock loading theorem](factorial-source-clock-loading.md) applies these bounded forms to every actual evolved birth. It keeps the full observing prime sum even beyond each source cutoff. Hardy inequalities, graph closure and the local ground-state transformation are classical tools; this chapter supplies the explicit arithmetic domain and inverse. This is a written proof, with no Lean formalization or identification of this positive operator with the theta/Weil form.

The [additive successor transport](../goldbach/goldbach-literal-successor-counting-transport.md) identifies this same $F$ with the classical $H_1$ explicit formula and retains the causal derivative atom. Its counting kernel gives a separate additive constraint on the source; the original-$L^2$ operator here is unchanged.

The [finite screw-configuration pullback](factorial-ground-screw-increment-consumer.md) turns each zero-mass configuration into an explicit original-$L^2$ source. The screw form is twice this ground square plus a complete residual, whose origin contact is essential.
