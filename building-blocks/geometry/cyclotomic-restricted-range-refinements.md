# Absolute refinements for restricted cyclotomic updates

The [angular-height boundary theorem](../analytic-methods/angular-height-boundary.md) proves the small-conductor and recent-conductor bounds. The [activity-quadrature theorem](cyclotomic-activity-quadrature.md) proves the broader reduced-conductor and reduced-age bounds. This note preserves additional estimates from those constructions: uniform temporal mass, final small-conductor deficit, arbitrary age bands, proper-divisor events, and exact gcd moments. Their proofs use the actual circular Farey weights and the complete cyclotomic prefix. None bounds the remaining signed interior interaction.

## Common definitions and estimates

Let $\Phi_1(z)=z-1$, $F_N=\prod_{j=1}^N\Phi_j$, and

$$
b_{n,N}(a)=[-\log|F_N'(\zeta_n^a)|]_+,
\qquad (a,n)=1,\quad n\le N.
$$

The root of order one is represented by zero once. Write $w_N(a/n)$ for half the sum of its two neighboring circular Farey gaps and $\Delta b_{n,N}(a)=b_{n,N}(a)-b_{n,N-1}(a)$ for an old root, $n<N$. Both terms of this difference receive the new-cutoff weight $w_N$. Births and changes in weights belong to separate terms.

The exact sector mass and complete factor estimate are

$$
A(n,N)=\sum_{(a,n)=1}w_N(a/n)
=\frac1n\sum_{\substack{N-n<d\le N\\(d,n)=1}}\frac1d,
\qquad
A(n,N)\le\frac1{N-n}\quad(n<N),
\tag{1}
$$

$$
\sum_{n\le N}A(n,N)=1,
\qquad |\Delta b_{n,N}(a)|\le\tau(N)\log N.
\tag{2}
$$

For (1), the neighboring denominators are the largest representatives at most $N$ of the two inverse residue classes modulo $n$. The half-gap formula sums to (1); at $n=1$ it gives $1/N$, and both incident gaps are counted at $n=2$.

For (2), the Möbius product gives at an old root $\alpha$

$$
\log|\Phi_N(\alpha)|=\sum_{d\mid N}\mu(N/d)h_{n,a}(d),
\qquad
h_{n,a}(d)=
\begin{cases}\log d,&n\mid d,\\
\log|1-\zeta_n^{ad}|,&n\nmid d.
\end{cases}
\tag{3}
$$

The total order of the vanishing factors is zero because $n<N$. Their radial leading coefficients therefore leave $\log d$, not zero. Nonzero chords lie between $4/n$ and $2$, so each term has magnitude at most $\log N$. Now use $F_N'(\alpha)=F_{N-1}'(\alpha)\Phi_N(\alpha)$ and the one-Lipschitz negative-part function. Only squarefree quotients $N/d$ contribute, so the optional sharper factor count is $2^{\omega(N)}\log N$. The rational roots $n=1,2$ have zero deficit because their full derivatives are nonzero integers.

Throughout, $X\ge3$, $H_X=\sum_{j=1}^X1/j$ and $H_0=0$.

## Uniform temporal mass and an endpoint deficit bound

For every $1\le n<X$,

$$
\sum_{N=n+1}^X A(n,N)\le H_X-1\le\log X.
\tag{4}
$$

Indeed, interchange the sums in (1). An integer $d\ge2$ occurs for

$$
N\in[n+1,X]\cap[d,d+n-1],
$$

at most $n$ times. Its coefficient after the factor $1/n$ is at most $1/d$. The integer $d=1$ never occurs. Dropping coprimality proves (4).

For $1\le Y\le X/2$, the final weighted deficit in small conductors satisfies

$$
B_X^{\le Y}:=\sum_{n\le Y}\sum_{(a,n)=1}w_X(a/n)b_{n,X}(a)
\le2YH_X\log X.
\tag{5}
$$

The complete product is

$$
F_X(z)=\prod_{d\le X}(z^d-1)^{M(\lfloor X/d\rfloor)}.
$$

It has a simple zero at $\alpha=\zeta_n^a$. The radial simple-zero limit, with the net vanishing exponent one, yields

$$
\log|F_X'(\alpha)|
=\sum_{d\le X}M(\lfloor X/d\rfloor)h_{n,a}(d).
\tag{6}
$$

Before taking absolute values, the regularized product equals $\alpha F_X'(\alpha)$; its phase has modulus one. Thus every derivative scalar remains present. Since $|h_{n,a}(d)|\le\log X$ and $|M(j)|\le j$,

$$
|\log|F_X'(\alpha)||
\le\log X\sum_{d\le X}\lfloor X/d\rfloor
\le XH_X\log X.
$$

Equation (1) bounds the mass of $n\le Y$ by $2Y/X$, proving (5). For $Y=\lfloor\sqrt X\rfloor$ and $X\ge4$, this gives $O(\sqrt X\log^2X)$. It concerns the endpoint deficit, separately from the cumulative old-update bound.

## Arbitrary age bands

For any integer $0\le h\le N-1$,

$$
\sum_{r=1}^h A(N-r,N)
\le\min\left\{1,
\frac{hH_N-(h+1)H_h+h}{N-h}\right\}.
\tag{7}
$$

Equation (1) gives $A(N-r,N)\le(H_N-H_r)/(N-r)$. Replace the denominator by $N-h$ and use $\sum_{r=1}^hH_r=(h+1)H_h-h$. The other upper bound is total mass one. At $h=0$, the left side and the numerator are zero. For $h\ge1$, the fraction is at most

$$
\frac{h}{N-h}\left(1+\log\frac Nh\right),
$$

since $H_N-H_h\le\log(N/h)$.

For a specified sequence of integer widths $h_N$ with $2h_N\le N$, the total absolute old cost in the band $1\le N-n\le h_N$ is consequently at most

$$
2H_X\log X\sum_{N=3}^X\frac{\tau(N)h_N}{N}.
\tag{8}
$$

Without the half-width restriction, multiply (7) by $\tau(N)\log N$ and sum. These are estimates for the chosen widths, not square-root estimates for arbitrary bands. The choice $h_N=\lfloor\sqrt N\rfloor$ recovers the previously proved bound $4\sqrt XH_X^2\log X$.

## All proper-divisor events have polylogarithmic cost

Define the full rootwise absolute cost

$$
D_X=\sum_{N=3}^X\sum_{\substack{n\mid N\\n<N}}
\sum_{(a,n)=1}w_N(a/n)|\Delta b_{n,N}(a)|.
$$

Then

$$
D_X\le2\log X\,H_X^4.
\tag{9}
$$

Each proper divisor obeys $n\le N/2$, so (1) gives $A(n,N)\le2/N$. There are at most $\tau(N)$ such sectors. Combining this with (2) proves

$$
D_X\le2\log X\sum_{N\le X}\frac{\tau(N)^2}{N}.
$$

If $d_4$ counts ordered quadruples with product $N$, then

$$
\tau(p^a)^2=(a+1)^2\le\binom{a+3}{3}=d_4(p^a).
$$

The difference is $a(a-1)(a+1)/6\ge0$ for integer $a\ge0$. Multiplicativity gives $\tau(N)^2\le d_4(N)$, and

$$
\sum_{N\le X}\frac{d_4(N)}N
=\sum_{abcd\le X}\frac1{abcd}\le H_X^4.
$$

This proves (9), including every proper power and removable scalar. Retaining the sharper factor count in (3) instead gives the finite majorant $2\sum_{N\le X}2^{\omega(N)}\tau(N)\log N/N$.

The classical resultant formula for $N>n$ is

$$
|\operatorname{Res}(\Phi_n,\Phi_N)|=
\begin{cases}
 p^{\varphi(n)},&N/n=p^a\text{ for a prime }p, a\ge1,\\
 1,&\text{otherwise}.
\end{cases}
\tag{10}
$$

For $n>1$, see [Bzdęga, Herrera-Poyatos and Moree, Theorem 9](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf), which attributes the formula to its classical predecessors. The case $n=1$ is the familiar value $\Phi_N(1)=e^{\Lambda(N)}$, their Lemma 4. Thus every update with resultant magnitude greater than one is included in (9). This bounds the whole clipped event, rather than its scalar term alone. Nondivisor events can still increase deficit: [the exact delayed-inverse certificate](cyclotomic-old-inverse-pairs.md) gives such an increase at $8/19$ and cutoff $33$.

## Reduced index and weighted gcd moments

Write each old pair uniquely as

$$
g=(n,N),\qquad n=qg,\qquad N=mg,
\qquad1\le q<m,\quad(q,m)=1.
$$

Define $H^*(m)=\sum_{1\le j<m,\ (j,m)=1}1/j$. Equation (1) gives the exact-class bound

$$
\sum_{\substack{1\le q<m\\(q,m)=1}}A(qg,mg)
\le\frac{H^*(m)}g.
\tag{11}
$$

Consequently the absolute old cost restricted to $m=N/(n,N)\le Y$, where $1\le Y\le X$, is at most

$$
\begin{aligned}
T_X^{\mathrm{index}}(Y)
&\le\log X\sum_{m=2}^Y H^*(m)
       \sum_{g\le X/m}\frac{\tau(mg)}g\\
&\le H_X^2\log X\sum_{m=2}^Y\tau(m)H^*(m)
\le YH_Y^2H_X^2\log X.
\end{aligned}
\tag{12}
$$

Here $\tau(mg)\le\tau(m)\tau(g)$, $\sum_{g\le X}\tau(g)/g\le H_X^2$, $H^*(m)\le H_Y$, and $\sum_{m\le Y}\tau(m)\le YH_Y$. The empty case $Y=1$ is allowed. The coprime harmonic sum can be retained when its finite arithmetic value is useful.

At a fixed cutoff, $g>\sqrt N$ is equivalent to $m<\sqrt N$. Therefore

$$
\sum_{\substack{1\le n<N\\(n,N)>\sqrt N}}A(n,N)
\le\frac1N\sum_{\substack{m\mid N\\2\le m<\sqrt N}}mH^*(m)
\le\frac{\tau(N)H_N}{\sqrt N}.
\tag{13}
$$

The square-root boundary is strict, and $m=1$ would be a birth. Cumulatively, (12) with $Y=\lfloor\sqrt X\rfloor$ bounds this large-gcd range by $\lfloor\sqrt X\rfloor H_{\lfloor\sqrt X\rfloor}^2H_X^2\log X$. This proof separates the reduced index from the common factor before summing; it avoids a squared-divisor majorant.

There is also a full weighted moment bound:

$$
\begin{aligned}
\mathcal M_N:=\sum_{n=1}^{N-1}(n,N)A(n,N)
&\le\sum_{\substack{m\mid N\\m>1}}H^*(m)\\
&=\sum_{j=1}^{N-1}\frac{(j,N)}j
\le\tau(N)H_N.
\end{aligned}
\tag{14}
$$

The inequality is (11) multiplied by its class gcd. The equality is a second exact gcd partition, now of the reciprocal-distance sum. It is not an equality for the actual Farey moment. Dividing (14) by $\sqrt N$ also bounds the large-gcd mass, but includes extra small-gcd classes and is weaker than the truncated expression in (13).

At $N=12$, the strict large-gcd old conductors are $4,6,8$, with total actual mass $26/165$. They lie outside both the small-conductor and recent-age boundaries at this cutoff. The family $N=6t,n=4t$, $t\ge2$, gives unbounded examples with the same range distinction. No sign of their particular clipped increments is inferred.

## Relation to the remaining interaction

For $Y=\lfloor\sqrt X\rfloor$, the already proved reduced-conductor region $q\le Y$ contains $n\le Y$, every proper-divisor event, the reduced-index region $m\le Y$, and every pair with $(n,N)>\sqrt N$. The reduced-age bound removes another region. Thus these refinements preserve sharper constants, endpoint estimates and alternative counting proofs; they do not enlarge the final range removal already stated in the [activity-quadrature chapter](cyclotomic-activity-quadrature.md). That chapter's remaining actual signed correlation is still unbounded at the required scale.

All results here are written proofs, using classical Farey-neighbor, Möbius-product and elementary divisor identities. The exact common identities are also covered by the existing [boundary checker](../../formalization/verification/check-angular-boundary.py). No Lean formalization or priority claim is made for these additional estimates.
