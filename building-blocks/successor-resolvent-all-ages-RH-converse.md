# Positivity at every positive age for the actual resolvent under RH

Assume RH. There is an $r_0<1$ such that the literal completed successor resolvent satisfies
$$
\boxed{\overline P_r(v)>0\qquad(v>0,\ r_0<r<1).}
\tag{1}
$$
Here $\overline P_r=\int_0^v(\overline a_r-a)$ is the difference primitive from [the completed resolvent construction](actual-successor-resolvent-boundary-criterion.md). Its value at $v=0$ is exactly zero. The proof fills the bounded initial interval left by [the common-halfline theorem](successor-resolvent-common-halfline-RH-converse.md), using the actual source and the full critical-zero expansion. It makes no claim that RH or (1) has been proved unconditionally.

## 1. The actual limiting primitive is strictly positive

For $x=e^v\ge1$, write
$$
a(v)=\frac{\psi(x)}{\sqrt x}-\sqrt x,\qquad
F(v)=-\int_0^v a(u)du,
\quad M(x)=\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}-2\sqrt x+1.
$$
Literal finite-sum integration gives the exact identity
$$
\boxed{F(\log x)=2[a(\log x)-M(x)].}
\tag{2}
$$
Indeed each $n\le x$ contributes
$\Lambda(n)\int_n^x y^{-3/2}dy=2\Lambda(n)(n^{-1/2}-x^{-1/2})$.
The $n=x$ term vanishes, so (2) holds at prime-power endpoints with the ordinary inclusive convention. All powers and the initial constant $1$ in $M$ are retained.

Before the first prime arrival,
$$
\boxed{F(\log x)=2(\sqrt x-1)\quad(1\le x\le2),}
\tag{3}
$$
where the endpoint $x=2$ follows by continuity. We anchor the integrated explicit formula there, rather than bounding its individual terms close to $x=1$.

Under RH, write each distinct nontrivial zero as $\rho=1/2+i\gamma$ with multiplicity $m_\rho$, including both signs of $\gamma$. The [classical explicit formula, Suzuki equation (36)](https://link.springer.com/article/10.1007/s11139-025-01238-9#Equ36), integrated as in Section 2 of the common-halfline proof, gives exactly for $x\ge2$
$$
\boxed{F(\log x)=2(\sqrt2-1)
+\sum_\rho\frac{m_\rho}{\rho i\gamma}
\left(x^{i\gamma}-2^{i\gamma}\right)+D(x),}
\tag{4}
$$
$$
D(x)=\int_2^x y^{-3/2}
\left[\log(2\pi)+\frac12\log(1-y^{-2})\right]dy.
\tag{5}
$$
The zero series in (4) converges absolutely and uniformly. Equation (5) retains the constant term and all trivial-zero terms of the explicit formula; it is not a PNT error term. For every $x\ge2$,
$$
D'(x)\ge x^{-3/2}\log(\pi\sqrt3)>0,
\qquad D(2)=0.
\tag{6}
$$
This follows from $1-x^{-2}\ge3/4$.

The already established functional-equation sum and height bound give
$$
S_2=\sum_\rho\frac{m_\rho}{1/4+\gamma^2}
=2+\gamma_E-\log(4\pi)<.05,\qquad |\gamma|>6.
$$
Consequently
$$
\sum_\rho\frac{m_\rho}{|\rho\gamma|}
\le1.01S_2<.0505<.051.
\tag{7}
$$
Equations (4)–(7) imply
$$
\boxed{F(\log x)>2(\sqrt2-1)-.102>.72
\quad(x\ge2).}
\tag{8}
$$
Thus $F(v)>0$ at every $v>0$. This step uses no selected zero ordinates or finite zero fixture. It uses the full summable zero contribution and the positive sign of the literal deterministic integral.

## 2. Uniform control at the initial endpoint

The completed-source theorem proves unconditionally that
$$
\epsilon_r:=\sup_{x\ge1}|\overline g_r(x)|\longrightarrow0,
\qquad \overline a_r(\log x)=\sqrt x\,\overline g_r(x).
\tag{9}
$$
Therefore, for every $x\ge1$, the exact identity
$\overline P_r(\log x)=F(\log x)+\int_0^{\log x}\overline a_r(u)du$
gives
$$
\boxed{|\overline P_r(\log x)-F(\log x)|
\le2\epsilon_r(\sqrt x-1).}
\tag{10}
$$
This bound is normalized at the endpoint. Local uniform convergence alone would not justify positivity throughout an interval whose left endpoint is zero.

Choose $r$ sufficiently close to one that $\epsilon_r<1/400$. For $1<x\le2$, (3) and (10) give
$$
\overline P_r(\log x)\ge2(1-\epsilon_r)(\sqrt x-1)
\ge(1-\epsilon_r)\log x>\frac12\log x.
\tag{11}
$$
For $2\le x\le10000$, (8) and (10) instead give
$$
\overline P_r(\log x)>.72-\frac{198}{400}>\frac15.
\tag{12}
$$
The prime arrivals do not create gaps in these bounds: the primitives are continuous, and all inclusive endpoint terms in (2) cancel exactly.

## 3. Combination with the unbounded-age estimate

Increase the same $r_0$ so that the common-halfline theorem also applies. For $n=(1-r)^{-1}$, it gives
$$
\overline P_r(\log x)\ge\frac1{100}\min(1,\sqrt{n/x})>0
\qquad(x\ge10000,\ r_0<r<1).
\tag{13}
$$
Equations (11)–(13) cover every $x>1$ and prove (1). They give the more explicit conditional bounds
$$
\overline P_r(v)\ge
\begin{cases}
v/2,&0<v\le\log2,\\
1/5,&\log2\le v\le\log10000,\\
\frac1{100}\min(1,\sqrt n\,e^{-v/2}),&v\ge\log10000,
\end{cases}
\tag{14}
$$
for all sufficiently large $r<1$. At the overlapping endpoints either corresponding bound is valid.

The forward theorem already proves that a common final interval of nonnegativity along a sequence $r\uparrow1$ implies RH. Hence RH is also equivalent to (1), or to the weaker assertion of global nonnegativity along such a sequence. The completed source, density, compensation, and prime-power coefficients have not changed. This fills the initial-age gap in the conditional converse; it does not establish the required sign without RH or extend positivity to every parameter $0<r<1$.

## Proof and formal scope

This is a written proof for the literal completed arithmetic source. The [formal feedback source and clock chain](successor-feedback-tail-Abel-poles.md#formal-positive-age-laplace-profile) proves its stated source, relative-charge and initial transform identities. It does not formalize this critical-zero expansion, its uniform resolvent estimates or the RH equivalence.
