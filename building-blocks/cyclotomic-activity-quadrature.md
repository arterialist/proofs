# Clipped cyclotomic activity and a controlled geometric remainder

For the complete cyclotomic prefix $F_N=\prod_{n\le N}\Phi_n$, this note separates the exact old-root derivative-deficit update into a signed angular correlation and an explicitly bounded geometric remainder. A cumulative bound of order $\sqrt X$ times logarithmic factors holds for the remainder and for two reduced-denominator boundary ranges. The actual signed correlation remains unbounded.

The [angular height and insertion theorem](angular-height-boundary.md) supplies the height consumer and positive-birth allowance. Here all derivatives retain the full monic polynomial, including $\Phi_1$. All angular coordinates belong to $\mathbb R/\mathbb Z$, with total length one. Define

```math
b_N(x)=[-\log|F_N'(e^{2\pi ix})|]_+,\qquad
O_N=\sum_{x\text{ old}}w_N(x)[b_N(x)-b_{N-1}(x)].
```

The weight $w_N$ is half the sum of the two incident gaps in the final order-$N$ Farey mesh. The result is a written proof, with no Lean formalization or originality claim.

## Exact clipping and the new mesh

For $N\ge3$, retain the complete monic product $F_{N-1}=\prod_{n\le N-1}\Phi_n$, including $\Phi_1$, and define
```math
\ell_x=\log|F_{N-1}'(e^{2\pi ix})|,\qquad
h(x)=\log|\Phi_N(e^{2\pi ix})|.
```
Here x runs over old Farey roots. No scalar has been divided out. Put
```math
A_x=\int_0^1{\bf1}_{\{\ell_x+t h(x)<0\}}\,dt,\qquad 0\le A_x\le1.
```
The absolutely continuous function $y\mapsto[-y]_+$ gives the exact identity
```math
[-\ell_x-h(x)]_+-[-\ell_x]_+=-A_xh(x).
\tag{1}
```
This includes crossings and $h(x)=0$; no differentiability at the clipping threshold is assumed.

Take the final order-N Farey mesh. If the adjacent gaps at an old root x are $q_-(x),q_+(x)$, define its Voronoi cell using linear lifts across zero:
```math
C_x=[x-l_x,x+r_x],\quad l_x=q_-/2,\quad r_x=q_+/2.
```
The cell length is exactly the final weight $w_N(x)=l_x+r_x$. The full collection of old and new cells partitions the circle up to endpoints. Crucially, no new root lies in the closed cell of an old root. Thus h is smooth there, despite its logarithmic singularities at the new roots.

Define $\rho_N=A_x$ on each old cell and 0 on every new cell. Then
```math
0\le\rho_N\le1,\quad m_N=\int_0^1\rho_N=\sum_{\rm old}w_NA_x,
\quad V_N=\int_0^1(\rho_N-m_N)^2
=\sum_{\rm old}w_NA_x^2-m_N^2\le m_N(1-m_N).
\tag{2}
```
This activity depends on the actual previous derivative and the actual new factor jointly. It is not an independent phase model or just the old negative-deficit support.

## 2. An exact quadrature identity with a favorable curvature term

Set
```math
\mu_x=\frac{r_x^2-l_x^2}{2}=\frac{q_+^2-q_-^2}{8}.
```
On an old cell,
```math
-h''(y)=\pi^2\sum_{a\in(\mathbb Z/N)^\times}
\csc^2\!\bigl(\pi(y-a/N)\bigr)>0.
```
The factor is $\pi^2$, since the coordinate is fractional angle, not radians.
Taylor's formula with an integral remainder, integrated separately on the two sides of x, gives
```math
\int_{C_x}h=w_N(x)h(x)+\mu_xh'(x)-K_x,
```
where
```math
K_x=\frac12\int_{-l_x}^0(y+l_x)^2[-h''(x+y)]\,dy
+\frac12\int_0^{r_x}(r_x-y)^2[-h''(x+y)]\,dy\ge0.
\tag{3}
```
All terms are finite. Multiplying by $-A_x$, summing old cells and using $\int_0^1h=0$ proves
```math
\boxed{O_N=-\int_0^1(\rho_N-m_N)h
+J_N-\mathcal K_N,}
\tag{4}
```
```math
J_N=\sum_{\rm old}A_x\mu_x h'(x),\qquad
\mathcal K_N=\sum_{\rm old}A_xK_x\ge0.
```
Thus the loss of mean-zero cancellation is precisely the activity correlation, together with a mesh flux; neither is omitted. A simple explicit curvature gain is
```math
\mathcal K_N\ge\frac{\pi^2\varphi(N)}{48}
\sum_{\rm old}A_x(q_-^3+q_+^3).
\tag{5}
```
The stronger expression (3) retains every actual birth phase.

The flux also has a discrete divergence form. Extend $v_x=A_xh'(x)$ by zero at new nodes. For final gaps $q_j$ from node $x_j$ to $x_{j+1}$,
```math
J_N=\frac18\sum_jq_j^2(v_{x_j}-v_{x_{j+1}}).
\tag{6}
```
This is an exact signed boundary term. Replacing it by the sum of its absolute summands would discard possible cancellation. Symmetric cells have zero individual flux, but Farey cells generally are not symmetric.

For arithmetic evaluation, at an old root $x=a/b$, $b<N$, the logarithmic derivative has the finite formula
```math
h'(a/b)=\pi\sum_{\substack{d\mid N\\b\nmid d}}
\mu(N/d)d\cot(\pi da/b).
\tag{7}
```
In the Möbius formula, the omitted terms $b\mid d$ have cancelling $1/(x-a/b)$ residues and zero finite part; their total multiplicity is zero because $a/b$ is not a root of $\Phi_N$. Formula (7) is therefore valid also when some divisor factors individually vanish. It makes the flux depend on divisors and the actual root label, rather than an independent-root approximation.

## 3. Arithmetic variance control

Let $c_N(k)=\sum_{(a,N)=1}e^{2\pi ika/N}$, the real Ramanujan sum. The $L^2$ Fourier series is
```math
h(x)=-\sum_{k\ge1}\frac{c_N(k)}k\cos(2\pi kx).
```
Hence the signed correlation in (4) is
```math
-\int\rho_Nh=\sum_{k\ge1}\frac{c_N(k)}k
\Re\widehat\rho_N(k).
\tag{8}
```
There is no zero-frequency contribution. Each cell contributes explicitly
```math
\widehat\rho_N(k)=
\sum_{\rm old}A_xe^{-2\pi ikx}
\frac{e^{2\pi ikl_x}-e^{-2\pi ikr_x}}{2\pi ik}.
```
For fixed N the latter is $O_N(1/k)$, so (8) is absolutely convergent. This formula retains the clipping/phase correlation rather than asserting that it averages to zero.

There is an exact useful arithmetic norm:
```math
\boxed{\|h\|_2^2=\frac{\pi^2}{12}
2^{\omega(N)}\frac{\varphi(N)}N.}
\tag{9}
```
One proof uses $h=\sum_{d\mid N}\mu(N/d)\log|1-e^{2\pi idx}|$ and the elementary Fourier inner product
```math
\int_0^1\log|1-e^{2\pi idx}|\log|1-e^{2\pi iex}|\,dx
=\frac{\pi^2}{12}\frac{\gcd(d,e)^2}{de}.
```
The resulting divisor sum factors. At each prime power it equals $2-2/p$, independently of its exponent, proving (9). 

Cauchy–Schwarz applied only to the angular correlation now gives the proved bound
```math
\boxed{O_N\le
\frac{\pi}{\sqrt{12}}
\sqrt{2^{\omega(N)}\frac{\varphi(N)}N\,V_N}
+J_N-\mathcal K_N.}
\tag{10}
```
This controls interaction by an activity variance, actual gaps and a divisor factor. It neither takes $\sum_{\rm old}w_N|h(x)|$ nor replaces the derivative profile by a maximum.

A cumulative consequence, valid without any new hypothesis, is
```math
\sum_{N=3}^{\lfloor X\rfloor}O_N
\le\frac{\pi}{\sqrt{12}}
\sqrt{X(1+\log X)\sum_{N=3}^{\lfloor X\rfloor}V_N}
+\sum_{N=3}^{\lfloor X\rfloor}(J_N-\mathcal K_N).
\tag{11}
```
Here $\sum_{N\le X}2^{\omega(N)}\varphi(N)/N
\le\sum_{N\le X}d(N)\le X(1+\log X)$. Combining (11) with the $O(\log^4 X)$ positive-birth estimate gives an explicit upper bound for the angular deficit statistic.


## Restricting to the geometric interior

Fix real $X\ge3$ and integer $3\le N\le\lfloor X\rfloor$. Let $I_{N,X}$ be any subset of old roots $x=a/n$ satisfying

```math
n>\sqrt X,\qquad N-n>\sqrt N.
```

Keep their final-mesh cells and arbitrary activities $0\le A_x\le1$. Write $e_x(h)=\int_{C_x}(h(y)-h(x))\,dy$. The identity above gives $J_N-\mathcal K_N=\sum_x A_xe_x(h_N)$ on this subset. The following proof establishes the stronger activity-independent inequality

```math
\sum_{N=3}^{\lfloor X\rfloor}\sum_{x\text{ selected}}[e_x(h_N)]_+
\le12\sqrt X\log\left(\frac{3\pi}{4}X^2\right).
```

Here $h_N(y)=\log|\Phi_N(e^{2\pi iy})|=\sum_{(a,N)=1}g_{a/N}(y)$ and $g_\beta(y)=\log|e^{2\pi iy}-e^{2\pi i\beta}|$. The proof allows discarded cells and asymmetric remaining cells.
## A general cyclic-cell lemma

Fix one point $\beta$ of the unit circle. Let $C_x=[x-l_x,x+r_x]$ be finitely many disjoint cells, with
```math
0\le l_x,r_x\le\delta/2,\qquad
0<\eta\le\delta\le1/3,\qquad
d_x=\operatorname{dist}(x,\beta)\ge\eta.
```
Write $g=g_\beta$. Then
```math
\sum_x\left[\int_{C_x}(g(y)-g(x))\,dy\right]_+
\le3\delta\log\!\left(\frac{3\pi/4}{\eta}\right).
\tag{G5}
```
Logarithmic singularities, if present in the cells, are integrable. The actual old Farey cells avoid them entirely.

To prove this, split the nodes according to $d_x\le\delta$ or $d_x>\delta$. The cells in the first class lie in the circular ball of radius $3\delta/2$ around $\beta$. Their total length is at most $3\delta$. For $0\le d\le1/2$,
```math
4d\le2\sin(\pi d)\le2\pi d.
```
Consequently every point of such a cell satisfies
```math
g(y)-g(x)\le\log\!\left(\frac{3\pi\delta}{4\eta}\right).
```
The right side is positive since $\eta\le\delta$. Summing the positive cell errors in the near class gives at most
```math
3\delta\log\!\left(\frac{3\pi\delta}{4\eta}\right).
\tag{G6}
```
This is the step that handles highly asymmetric cells. It uses their total length and a logarithmic ratio, rather than a derivative evaluated at the nearest singularity.

For a far node, every point of the segment from $x$ to $x+s$, with $-l_x\le s\le r_x$, has distance at least $d_x-\delta/2>d_x/2$ from $\beta$. The elementary derivative estimate
```math
|g'(y)|=\pi|\cot(\pi\operatorname{dist}(y,\beta))|
\le\frac1{\operatorname{dist}(y,\beta)}
```
therefore gives
```math
|g(x+s)-g(x)|\le\frac{2|s|}{d_x}.
```
It is valid also when a segment crosses the antipode, where $g$ is smooth and its derivative is zero. Integrating the displacement, rather than replacing it by its maximum, gives
```math
|e_x(g)|\le\frac{l_x^2+r_x^2}{d_x}
\le\frac{\delta w_x}{2d_x}.
\tag{G7}
```
For $y\in C_x$ in this class, its distance $d_y$ satisfies
$\delta/2<d_y<3d_x/2$. Thus
```math
\sum_{d_x>\delta}\frac{w_x}{d_x}
\le\frac32\int_{\operatorname{dist}(y,\beta)>\delta/2}
\frac{dy}{\operatorname{dist}(y,\beta)}
=3\log(1/\delta).
```
Disjointness justifies the integral comparison even if many other mesh cells were discarded. Equations (G7) and this bound give a total far contribution at most
```math
\frac{3\delta}{2}\log(1/\delta).
\tag{G8}
```
Adding (G6) and (G8) yields
```math
3\delta\log\!\left(\frac{3\pi/4}{\eta}\right)
+\frac{3\delta}{2}\log\delta
\le3\delta\log\!\left(\frac{3\pi/4}{\eta}\right),
```
which proves the cyclic-cell bound. No comparison of the two incident gaps was used.

## Apply the lemma to the actual Farey denominators

Write $r=N-n$ for a selected node. Every neighbor denominator $b$ in the final Farey mesh satisfies
$b+n>N$, and the corresponding gap is $1/(nb)$. Hence
```math
q_\pm<\frac1{n(N-n)}.
```
Selection implies both $n>\sqrt N$ and $N-n>\sqrt N$. Such a node cannot exist for $N\le4$. For $N\ge5$, the concave quadratic $n(N-n)$ has its minimum on the permitted interval at its endpoints, giving
```math
n(N-n)>\sqrt N(N-\sqrt N)\ge\tfrac12N^{3/2}.
```
We may therefore choose
```math
\delta_N=2N^{-3/2},\qquad q_\pm<\delta_N,\qquad
l_x,r_x<\delta_N/2.
\tag{G9}
```
For any old root $a/n$ and any new root $b/N$, their circular distance is at least $1/(nN)$. The fractions are distinct, including modulo 1. Thus
```math
\operatorname{dist}(a/n,b/N)\ge N^{-2}=\eta_N.
\tag{G10}
```
For $N\ge5$, $0<\eta_N\le\delta_N<1/3$. Apply the cyclic-cell bound separately to each of the $\varphi(N)$ new roots. The elementary positive-part inequality $[\sum_\beta t_\beta]_+\le\sum_\beta[t_\beta]_+$ gives
```math
\sum_{x\in I_{N,X}}[e_x(h_N)]_+
\le3\delta_N\varphi(N)\log\!\left(\frac{3\pi/4}{\eta_N}\right)
=\frac{6\varphi(N)}{N^{3/2}}\log\!\left(\frac{3\pi}{4}N^2\right).
\tag{G11}
```
Use $\varphi(N)\le N$, monotonicity of the logarithm, and
$\sum_{N\le\lfloor X\rfloor}N^{-1/2}\le2\sqrt X$. This proves the cumulative bound stated above, including real $X\ge3$. Initial empty selections contribute zero. Neither a coprimality condition on $n,N$ nor a restriction to prime conductors is needed: the factorization of $h_N$ into the new log-chords has no removable divisor singularities at old roots.


## Two reduced-coordinate boundary ranges

For integers $X\ge3$ and $1\le Y\le X$, put

```math
g=\gcd(n,N),\qquad q=n/g,\qquad r=(N-n)/g.
```

The total rootwise absolute old-update cost over $q\le Y$ is at most $4YH_X^4\log X$. Over $r\le Y$ it is at most $4YH_X^3\log X+2YH_X^4(\log X)^2$, where $H_X=\sum_{j=1}^X1/j$.

Here are the complete estimates. At every old primitive root $\alpha$ of order $n<N$,

```math
F_N'(\alpha)=F_{N-1}'(\alpha)\Phi_N(\alpha),\qquad
|b_N(\alpha)-b_{N-1}(\alpha)|\le|\log|\Phi_N(\alpha)||\le\tau(N)\log N.
```

The last bound retains the removable zeros of the Möbius product. Its terms with $n\mid d$ have total multiplicity zero and contribute their finite radial values $\log d$. The others are chord logarithms with magnitude at most $\log n\le\log N$. There are at most $\tau(N)$ terms. At orders one and two the actual deficit is zero, since the full derivative is a nonzero integer.

The exact total sector mass is

```math
A(n,N)=\sum_{(a,n)=1}w_N(a/n)
=\frac1n\sum_{\substack{N-n<b\le N\\(b,n)=1}}\frac1b
\le\frac1{N-n}.
```

Each neighbor denominator is the largest representative at most $N$ of one of the inverse classes modulo $n$. Summing the two half-gaps proves the identity. At $n=2$ the classes coincide but represent two incident sides. At $n=1$ the cyclic root has mass $1/N$, also given by the sum.

Write $n=qg,N=mg$, with $1\le q<m$, $(q,m)=1$ and $g\le X/m$. This parametrization is unique. Since $\tau(mg)\le\tau(m)\tau(g)$ and $\sum_{g\le X/m}\tau(g)/g\le H_X^2$, dropping coprimality only in a nonnegative majorant gives

```math
T_q(Y)\le H_X^2\log X\sum_{m=2}^X\tau(m)
\sum_{q=1}^{\min(Y,m-1)}\frac1{m-q}.
```

For $m\le2Y$, the inner sum is at most $H_X$ and $\sum_{m\le2Y,\,m\le X}\tau(m)\le2YH_X$. This contributes at most $2YH_X^2$. For $m>2Y$, the inner sum is at most $2Y/m$, giving another $2YH_X^2$. This proves the $q$ bound, including an empty second range.

For reduced age, the sharper mass estimate is

```math
A((m-r)g,mg)\le\frac{H_{mg}-H_{rg}}{(m-r)g}
\le\frac{\log(m/r)}{(m-r)g}.
```

Thus

```math
T_r(Y)\le H_X^2\log X\sum_{m=2}^X\tau(m)
\sum_{r=1}^{\min(Y,m-1)}\frac{\log(m/r)}{m-r}.
```

The decreasing function $f(t)=-\log t/(1-t)$ has integral $\zeta(2)<2$ on $(0,1)$. Its right Riemann sum proves that the unrestricted inner sum is less than two. Therefore $m\le2Y$ contributes at most $4YH_X$. For $m>2Y$, its contribution is at most $2Y\log X\sum_{m\le X}\tau(m)/m\le2YH_X^2\log X$. Multiplication by the preceding factor proves the stated $r$ bound. All parameter ranges use integers. Adding the harmless $N=2$ majorant never adds an actual birth term.

Take $Y=\lfloor\sqrt X\rfloor$. Remove the disjoint union $\{q\le Y\}\sqcup\{q>Y,r\le Y\}$. The remaining roots obey $n>\sqrt X$ and $N-n>\sqrt X\ge\sqrt N$, so the geometric remainder bound applies unchanged. Their total signed old-update cost is at most their signed angular correlation plus

```math
4YH_X^4\log X+4YH_X^3\log X
+2YH_X^4(\log X)^2
+12\sqrt X\log\left(\frac{3\pi}{4}X^2\right).
```

The actual remaining correlation is still unproved at square-root scale. A bound uniform over all bounded activities is too strong, as shown in the [activity-selection counterexample](cyclotomic-activity-necessity.md).

## Temporal weight loss

For an old phase $a/n$, $n\ge2$, a side changes exactly when $Na\equiv1$ or $-1\pmod n$. Its denominator changes from $N-n$ to $N$, reducing the half-gap weight by $1/[2N(N-n)]$. Consequently

```math
w_{N-1}(a/n)-w_N(a/n)
=\frac{\mathbf1_{Na\equiv1\pmod n}+\mathbf1_{Na\equiv-1\pmod n}}{2N(N-n)}.
```

The two sides must both be counted at $n=2$. Reflection preserves the actual deficit, so

```math
R_N=\sum_{x\text{ old}}(w_{N-1}(x)-w_N(x))b_{N-1}(x)
=\sum_{\substack{2\le n<N\\(n,N)=1}}
\frac{b_{N-1}((N^{-1}\bmod n)/n)}{N(N-n)}\ge0.
```

The root at zero has deficit zero because $F_{N-1}'(1)=\operatorname{lcm}(1,\ldots,N-1)\ge1$; no ordinary inverse label modulo one is needed. If $P_N$ is the raw new-root deficit and $B_N=\sum_xw_N(x)b_N(x)$, then $B_N-B_{N-1}=O_N-R_N+P_N$. The insertion theorem already includes $P_N-R_N$ in its birth defect. The term $R_N$ must not be added to the quadrature remainder again.

The methods are classical Peano-kernel quadrature and logarithmic-potential analysis. [Komisarski and Wąsowicz](https://arxiv.org/abs/1612.08086) study one-sign quadrature remainders; [Erdélyi, Hardin and Saff, §§2.1 and 2.3](https://arxiv.org/abs/1307.4056) use the negative log-chord kernel and its curvature. [Herrera-Poyatos and Moree, §§2.3 and 3.1](https://arxiv.org/abs/1805.05207) give the Ramanujan/cyclotomic formulas. The cell estimate and reduced-coordinate sums above are proved here as applications of these established methods; exact priority is unresolved. They supply no proof of the remaining activity correlation or RH.
