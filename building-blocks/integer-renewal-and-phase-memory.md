# Literal integer renewal and phase memory

Consider states $1,\ldots,N$, successor moves $n\to n+1$, and every strict division $n\to n/d$. This note derives a positive rod determinant from signed division weights and an exact interference example after retaining path order. Neither construction produces the required zeta prime-power coefficients. The results are written proofs using classical determinant and Schrödinger-representation methods; publication priority is not asserted.

## The rod determinant

Give each successor weight $x$ and each division by $d$ weight $-d^{-s}$. Let $S$ be the row-source successor matrix and $L_s(n,m)=\mathbf1_{m\mid n,\,m<n}(n/m)^{-s}$. Set

```math
D_N(s,x)=\det(I+L_s-xS).
```

A vertex-simple directed cycle must consist of a successor run $m,m+1,\ldots,n$ followed by the division $n\to m$, with $m\mid n$. Indeed, start the cycle at its smallest vertex. Its first downward move must return there, since any other permitted lower vertex in the cycle has already been visited. In the determinant expansion each such cycle contributes $x^{n-m}(n/m)^{-s}$: the cycle sign and the negative division sign cancel. Therefore

```math
D_N=\sum_{\mathcal R}\prod_{[m,n]\in\mathcal R}
x^{n-m}(n/m)^{-s},
```

where $\mathcal R$ ranges over collections of vertex-disjoint integer intervals $[m,n]$ with $m<n$ and $m\mid n$. The empty collection contributes 1. Splitting according to the rightmost occupied endpoint proves

```math
D_N=D_{N-1}+\sum_{\substack{m\mid N\\m<N}}
(N/m)^{-s}x^{N-m}D_{m-1},\qquad D_0=D_1=1.
```

If disjoint rods are ordered left to right, their quotient product $r$ is at most $N$: between successive rods $n_j<m_{j+1}$, so $\prod_j n_j/m_j\le n_k/m_1\le N$. Thus for real $x\ge0$,

```math
D_N(s,x)=\sum_{r\le N}A_{N,r}(x)r^{-s},\qquad A_{N,r}(x)\ge0.
```

For $N\ge2$, this implies $D_N(s,x)\ne0$ whenever $|\Im s|<\pi/\log N$: after rotating by half the maximal phase, all nonzero summands have strictly positive real part. This finite strip shrinks as $N$ increases; it is not a zeta zero-free region.

For real $s$, the limit in $N$ exists and is finite when $0\le x<1$. More generally, convergence is locally uniform in $s$ and $|x|<1$. A rod of length $a$ has $m\mid a$ and quotient at most $a+1$. On $|\Re s|\le M$, the sum of absolute rod weights is at most

```math
\sum_{a\ge1}\tau(a)(a+1)^M|x|^a<\infty.
```

The sum over disjoint collections is bounded by the product over all rods of one plus their absolute weight, itself bounded by the exponential of this sum. At $x=1$, the partition diverges for every real $s$: the pairwise disjoint rods $[3^j,2\cdot3^j]$ each have weight $2^{-s}$, and their subsets contribute arbitrarily large powers of $1+2^{-s}$.

Positivity does not remove mixed prime terms. With independent markers $u=2^{-s},v=3^{-s}$, for every $N\ge3$,

```math
[x^3uv]\log D_N=-1.
```

The rods $[1,2]$ and $[1,3]$ have weights $xu$ and $x^2v$ and overlap. There is no degree-three rod collection of product 6; the negative cross term in the logarithm therefore survives. In contrast, the formal Euler logarithm has zero coefficient at the mixed product 6.

## Arithmetic path memory

For a based history from 1 back to 1, let $A$ count successors, let $r$ be the product of all division quotients, and let $r_{\rm before}(e)$ be the quotient product accumulated before successor $e$. Tracking the current state times the accumulated quotient gives the exact identity

```math
r=1+\sum_{e\text{ successor}}r_{\rm before}(e).
```

In particular $A\le r-1$, and every visited state is at most $A+1\le r$. Thus histories of fixed product $r$ stabilize once $N\ge r$. There are finitely many: their successor count is at most $r-1$, and their division count is at most $\log_2r$.

Retain order through the Heisenberg law

```math
(a,b,c)(a',b',c')=(a+a',b+b',c+c'+ab').
```

A successor has increment $(1,0,0)$ and a division by $d$ has increment $(0,\log d,0)$. A history then has lift $(A,\log r,\log w)$, where $w=\prod_jd_j^{A_j}$ and $A_j$ is the successor count before its $j$th division. The division signs and $x^Ar^{-s}$ are retained as scalar coefficients.

Use the standard unitary representation and normalized Gaussian

```math
(\rho(a,b,c)f)(t)=e^{i(c+bt)}f(t+a),\qquad
\varphi(t)=\pi^{-1/4}e^{-t^2/2}.
```

Direct Gaussian integration yields

```math
\langle\rho(g_i)\varphi,\rho(g_j)\varphi\rangle
=e^{-((a_j-a_i)^2+(b_j-b_i)^2)/4}
e^{i(c_j-c_i-(a_i+a_j)(b_j-b_i)/2)}.
```

Consecutive division chains of total quotient $d$ have the same lift. Their alternating sum is still $\mu(d)$, by ordinary incidence inversion. The lift therefore retains this cancellation and also distinguishes the order of separated successor/division runs.

## A complete product-6 calculation

Write $U_{A,r,w}=\rho(A,\log r,\log w)$ and let $[r]F_N$ denote the first-return operator of total quotient $r$, with the common scalar $r^{-s}$ removed. For $N\ge6$,

```math
[2]F_N=-xU_{1,2,2},\qquad
[3]F_N=-x^2U_{2,3,9},\qquad
[4]F_N=0,
```

```math
[6]F_N=x^4U_{4,6,648}+x^5U_{5,6,7776}.
```

For product 6, the first term is the path $1,2,3,4,2,3,1$. The direct path up to 6 and back to 1 and its two strict-chain refinements have the same second lift and signs $-,+,+$, leaving one copy. These exhaust the possibilities: a single division must be by 6; two divisions must have quotients $(2,3)$ or $(3,2)$, and the state immediately after the first division must exceed 1. Solving the resulting successor counts gives exactly the listed paths. The two product-4 paths have equal lift and opposite signs.

Consequently, for real $x>0$,

```math
\|[6]F_N\varphi\|^2
=x^8+x^{10}+2x^9e^{-1/4}\cos(\log12).
```

The cross term is strictly negative because $\pi/2<\log12<\pi$. Nevertheless

```math
\|[6]F_N\varphi\|^2\ge
(1-e^{-1/4})(x^8+x^{10})>0.
```

The formal renewal logarithm is $\log(I-F_N)^{-1}=\sum_{k\ge1}F_N^k/k$. Its mixed-product coefficient includes

```math
[6]\log(I-F_N)^{-1}
=[6]F_N+\frac{x^3}{2}(U_{3,6,54}+U_{3,6,72}).
```

The last pair has squared Gaussian norm, after removing $x^3$, equal to $(1+\cos(\log(4/3)))/2>0$. Its lower clock degree prevents cancellation by the first-return terms. Negative interference in one selected norm has therefore not removed the mixed term in the complete logarithm.

## Attribution and limits

The determinant argument is the elementary cycle expansion used in directed graph generating functions; incidence-chain cancellation is classical, as illustrated by [Wilf](https://arxiv.org/html/math/0408263). The Heisenberg action and Gaussian kernel are standard; see [Abreu–Gröchenig–Romero](https://arxiv.org/abs/1704.03042). The specific integer-history identities and witnesses are recorded as reusable applications. These finite unitary sums require no unbounded generators or infinite-dimensional trace. Their Gram positivity supplies neither a zeta determinant correspondence nor an RH bound.


## Lowest-clock extraction and its logarithmic defect

For disjoint ordered rods with total additive degree a and integer product r of division ratios,

$$
 r\le a+1. \tag{A15}
$$

For a single rod [m,n], r=1+(n-m)/m<=a+1, with equality exactly when m=1. For an additional rod starting at m, the previous product is at most the previous additive degree plus one, at most the previous right endpoint, and therefore strictly less than m. Multiplying by 1+(n-m)/m then gives a strict version of A15 for two or more rods. Apart from the empty configuration, equality occurs only for the single rod [1,r].

Thus the lowest-clock coefficient of the rod partition at energy r is canonically 1: [x^(r-1)]A_(infinity,r)=1. Extracting those coefficients produces the ordinary unit-coefficient Dirichlet series. This is a diagonal extraction, not an inherited positivity or logarithmic-trace identity. It does not commute with taking the logarithm. The exact N=6 polynomial gives diagonal-of-log coefficient 0 at energy 4 and -1 at energy 6, whereas log-of-diagonal has coefficients 1/2 and 0. The [exact certificate](certificates/integer-affine-cells.py) verifies these finite discrepancies and the equality cases.


The [affine-class minimum clock](prime-clique-cutoff.md#the-minimum-successor-clock-in-each-directed-class) is a different optimization over equivalent directed histories. Both preserve exact arithmetic costs, but neither supplies the missing signed analytic correspondence.
