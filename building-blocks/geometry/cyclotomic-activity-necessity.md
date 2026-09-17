# Why the angular correlation needs actual derivative history

The unrestricted-activity shortcut fails quantitatively on the actual Farey meshes and actual prime cyclotomic factors. There is a single sequence of cell activities, taking only the values 0 and 1 and respecting complex-conjugation symmetry, such that its correlation on the prescribed interior satisfies

```math
\boxed{\sum_{N=3}^X C_N^{(X)}\ge
\frac{\log2}{96}\frac X{\log X}
\qquad\text{for every integer }X\ge2^{23}.} \tag{1}
```

The activities depend only on the current mesh and factor, not on future cutoffs. They are not required to equal the occupation determined by the previous full derivative. Thus geometry, boundedness, symmetry and this weak causality cannot by themselves give the desired square-root upper bound. This tests a proposed shortcut only; it supplies no lower bound for the actual clipping activities or the actual RH-facing statistic.

## Exact setting and choice

Let $C_{x,N}$ be the Voronoi cell of a root $x=a/n$ in the final order-N Farey mesh. Its endpoints are the midpoints of the two adjacent gaps, and its length is $w_N(x)$. New and old cells partition the circle up to endpoints. Put $h_N(t)=\log|\Phi_N(e^{2\pi it})|$, an integrable function of mean zero.

For each prime p, retain the old nodes in the slightly smaller region

```math
n>\lfloor\sqrt{2p}\rfloor,\qquad
p-n>\lfloor\sqrt p\rfloor. \tag{2}
```

On those nodes choose

```math
A_{x,p}=\mathbf1_{\{\int_{C_{x,p}}h_p(t)\,dt<0\}};
```

set A to zero on every other node and at every composite cutoff. This defines one sequence independently of the eventual horizon X. A tie is assigned zero. On old cells the integral is finite and has no cyclotomic root singularity; all global integrals below are also well-defined.

At horizon X, let $\rho_N^{(X)}$ equal $A_{x,N}$ on cells whose old conductor additionally satisfies

```math
n>\lfloor\sqrt X\rfloor,\qquad
N-n>\lfloor\sqrt N\rfloor,
```

and zero elsewhere. Set $C_N^{(X)}=-\int_0^1\rho_N^{(X)}h_N$. Every selected cell contribution is nonnegative. If $X/2<p\le X$, condition (2) already implies this horizon's interior restrictions. Hence $C_p^{(X)}$ equals the full sign-selected correlation on (2).

The construction respects reflection $x\mapsto1-x$, because the mesh, factors, conductor restrictions and cell integrals all do. It assumes no random phases or equidistribution.

## Fixed negative intervals for a prime factor

For prime p and $0<t<1$,

```math
h_p(t)=\log\frac{|\sin(\pi pt)|}{\sin(\pi t)}. \tag{3}
```

Let $\delta=1/16$ and take the intervals

```math
E_{j,p}=\left[\frac{j-\delta}{p},\frac{j+\delta}{p}\right]
\subset[1/4,3/4],\qquad E_p=\bigcup_jE_{j,p}.
```

They are disjoint and each has length $1/(8p)$. On them, $|\sin(\pi pt)|\le\pi/16<1/4$ while $\sin(\pi t)\ge1/2$. Therefore $h_p\le-\log2$ almost everywhere on $E_p$. The values $-\infty$ at the new roots cause no problem for the integrals.

The allowed integers j form an interval of length $p/2-1/8$. Their number K is at least $p/2-2$ and at most $p/2+1$. Consequently

```math
|E_p|\ge\frac1{16}-\frac1{4p},\qquad
\#\partial E_p=2K\le p+2. \tag{4}
```

This elementary interval construction replaces any proposed independence or limiting equidistribution argument.

## How much of those intervals survives the actual mesh

Let $Y_p=\lfloor\sqrt{2p}\rfloor$ and let $U_p$ be the union of cells satisfying (2). The exact sector-mass formula in the [quadrature and boundary proof](cyclotomic-activity-quadrature.md) gives the following elementary mass loss, for $p>2Y_p$:

```math
|U_p^c|\le\frac{2Y_p}{p}
+\frac{2H_p}{\sqrt p}+\frac{H_p}{p}. \tag{5}
```

The first term covers old conductors at most $Y_p$; the second covers old ages at most $\lfloor\sqrt p\rfloor$; the last covers new cells, whose total mass is $H_{p-1}/p$ for prime p. Overlap in this upper bound is harmless. These are lengths of complete actual cells, not counts of rational points.

Every selected node has $n>\sqrt p$ and $r=p-n>\sqrt p$. An adjacent Farey denominator b satisfies $b>p-n=r$, hence its gap is less than $1/(nr)$. Since $n+r=p$,

```math
nr>\sqrt p(p-\sqrt p),\qquad
|C_{x,p}|<\frac1{nr}\le\frac2{p^{3/2}}\quad(p\ge4). \tag{6}
```

Let $V_p$ be the union of selected cells wholly contained in $E_p$. A selected cell that meets $E_p$ in positive measure but is not contained in it must straddle a boundary point. At most one cell has a given boundary point in its interior. Thus (4)–(6) give

```math
|V_p|\ge |E_p|-|U_p^c|-(p+2)\frac2{p^{3/2}}
\ge\frac1{16}-\frac{2H_p+6}{\sqrt p}
-\frac{H_p+1/4}{p}. \tag{7}
```

For the final simplification, $2Y_p/p<3/\sqrt p$ and $2(p+2)/p^{3/2}\le3/\sqrt p$ for $p\ge4$. Endpoints have measure zero. No upper bound for the negative logarithm is used to estimate the removed cells; we count the lengths of cells known to lie in a region where the logarithm has a fixed negative upper bound.

Using $H_p\le1+\log p$, both error terms in (7) decrease for $p\ge1$. At $p_0=2^{22}$, the inequality $\log2<7/10$ gives the rational upper bound

```math
\frac{8+2\log p_0}{\sqrt{p_0}}
+\frac{5/4+\log p_0}{p_0}
<\frac{1589581}{83886080}<\frac1{32}.
```

Thus $|V_p|\ge1/32$ for every prime $p\ge2^{22}$. Each cell in $V_p$ has a negative integral and is activated by the sign choice. All other activated cells also contribute nonnegatively. Therefore

```math
C_p^{(X)}\ge(\log2)|V_p|\ge\frac{\log2}{32}
\quad\text{when }X/2<p\le X,\ X\ge2^{23}. \tag{8}
```

## Counting prime cutoffs with explicit constants

Rosser and Schoenfeld's Corollary 1, equations (3.5)–(3.6), states

```math
\pi(u)>u/\log u\quad(u\ge17),\qquad
\pi(u)<1.25506\,u/\log u\quad(u>1).
```

For $X\ge2^{23}$, $\log X/\log(X/2)\le23/22$, so

```math
\pi(X)-\pi(X/2)
>\frac X{\log X}\left(1-1.25506\frac{23}{44}\right)
=\frac{756681}{2200000}\frac X{\log X}
>\frac13\frac X{\log X}. \tag{9}
```

Combining (8)–(9) proves (1), since every other cutoff contributes nonnegatively. The prime-count theorem is unconditional. See printed p. 69. [Rosser–Schoenfeld, *Approximate formulas for some functions of prime numbers*, 1962, primary scan](https://denisevellachemla.eu/Rosser-Schoenfeld-1962.pdf), [publisher record](https://doi.org/10.1215/ijm/1255631807).

The growth in (1) rules out a square-root upper bound for this correlation uniformly over unrestricted activities. A one-sided upper bound for a separate remainder supplies no lower bound for the complete old-root update.

For the actual activity, at each fixed old root $\alpha=\zeta_n^a$ one must use

```math
\ell_{n,N-1}(a)=\log|\Phi_n'(\alpha)|
+\sum_{\substack{j\le N-1\\j\ne n}}\log|\Phi_j(\alpha)|,
\qquad
A_{n,N}(a)=\int_0^1\mathbf1_{\ell_{n,N-1}(a)+t h_N(a/n)<0}\,dt. \tag{10}
```

This includes every prebirth factor in the initial derivative and every subsequent factor and scalar. Writing $b_{n,N}=[-\ell_{n,N}]_+$, it imposes the exact temporal constraint

```math
-A_{n,N}(a)h_N(a/n)=b_{n,N}(a)-b_{n,N-1}(a). \tag{11}
```

For a fixed root and $n<L\le R$, summation by parts gives

```math
\sum_{N=L}^R-w_N A_{n,N}h_N(a/n)
=w_R b_{n,R}-w_L b_{n,L-1}
+\sum_{N=L}^{R-1}(w_N-w_{N+1})b_{n,N}. \tag{12}
```

The same deficit profile determines entry, occupation and recovery; the weights change only when a Farey neighbor changes. Restriction to an interior time window introduces its endpoint terms, which cannot be omitted. Equations (10)–(12) are a precise history constraint unavailable to arbitrary sign-selected cell activities. A useful estimate must exploit it, or a rigorously derived consequence controlling this occupation's correlation. Merely assuming an activity is bounded, symmetric or based on present information does not do so: the construction above already has those properties.

No claim is made that a selected assignment differs from the actual activity at every individual cell. No actual activity bound follows from this diagnostic. Its proved consequence is that a universal estimate for all admissible bounded cell fields is too strong. A proof using this correlation must retain actual derivative history, or some other specifically arithmetic restriction that excludes this unrestricted selection.

This is a written application of Farey geometry and explicit prime counting, with exact priority unresolved and no Lean formalization.
