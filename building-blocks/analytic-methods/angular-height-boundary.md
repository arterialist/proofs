# Angular height from Farey derivative deficits

This written theorem bounds the angular height of a cyclotomic prefix by its signed old-root interaction in an explicit interior region, with an error of order $`\sqrt X\log^3X`$. The interior interaction remains unbounded. The proof combines logarithmic chord concavity, exact Farey interpolation and elementary divisor sums. No originality or formal-verification claim is made.

The motivating question, how additive cutoff growth interacts with multiplicative cyclotomic structure, was proposed by the repository's author. The mathematical statements and proofs below give a specific consequence of studying that interaction.

## Definitions and theorem

Write $`[u]_+=\max(u,0)`$ and use natural logarithms. For an integer $`N\ge2`$, put

```math
F_N(z)=\prod_{n=1}^N\Phi_n(z),\qquad
D_N=\deg F_N=\sum_{n=1}^N\varphi(n),\qquad
\widetilde h(F)=\int_0^1\log^+|F(e^{2\pi ix})|\,dx.
```

The height has no division by degree. The root phases $`\mathcal R_N`$ are the reduced fractions in $`[0,1)`$ of denominator at most N. The root 1 is represented once by $`0/1`$. If $`q_-(x),q_+(x)`$ are the two adjacent cyclic gaps at cutoff N, define

```math
w_N(x)=\frac{q_-(x)+q_+(x)}2,\qquad
b_N(x)=[-\log|F_N'(e^{2\pi ix})|]_+,\qquad
B_N=\sum_{x\in\mathcal R_N}w_N(x)b_N(x).
```

For old roots $`x\in\mathcal R_{N-1}`$, let $`\Delta_N(x)=b_N(x)-b_{N-1}(x)`$. All derivatives are those of the full monic product, with no scalar factors removed. Set $`H_X=\sum_{j=1}^X1/j`$ for integer X.

**Theorem.** For every integer $`X\ge3`$, define the signed interior sum

```math
\mathcal O_X^{\mathrm{int}}=
\sum_{N=3}^X
\sum_{\substack{x=a/n\in\mathcal R_{N-1}\\
 n>\lfloor\sqrt X\rfloor\\N-n>\lfloor\sqrt N\rfloor}}
 w_N(x)\Delta_N(x).
```

Then

```math
\boxed{
\widetilde h(F_X)\le B_X+\log D_X+2
\le \mathcal O_X^{\mathrm{int}}
 +2\sqrt X\log X\,H_X(1+3H_X)
 +\tfrac12\log X(1+\log X)^3
 +\log D_X+2.}
\tag{1}
```

More precisely, for integers $`1\le Y\le X`$, the absolute old-root cost of conductors $`n\le Y`$ satisfies

```math
T_X(Y):=\sum_{N=3}^X
\sum_{\substack{x=a/n\in\mathcal R_{N-1}\\n\le Y}}
 w_N(x)|\Delta_N(x)|
\le2Y\log X\,H_X(1+H_X). \tag{2}
```

The absolute cost of the moving age band satisfies

```math
Q_X:=\sum_{N=3}^X
\sum_{\substack{x=a/n\in\mathcal R_{N-1}\\
1\le N-n\le\lfloor\sqrt N\rfloor}}
 w_N(x)|\Delta_N(x)|
\le4\sqrt X\,H_X^2\log X. \tag{3}
```

These are absolute bounds on actual old-root updates, including recovery from a deficit. They do not assume a favorable pointwise sign.

## Height inequality

Let F be any monic polynomial of degree $`D\ge2`$ with distinct unit-circle roots $`\alpha_j=e^{i\theta_j}`$ in cyclic order. Set $`q_j=(\theta_{j+1}-\theta_j)/(2\pi)`$, $`c_j=2\sin(\pi q_j)`$, $`\ell_j=\log|F'(\alpha_j)|`$ and $`b_j=[-\ell_j]_+`$. Then

```math
\widetilde h(F)\le
\sum_j\frac{q_{j-1}+q_j}{2}b_j
+\sum_jq_j\log^+(1/c_j)+2. \tag{4}
```

To prove this, remove the two endpoint chord factors on a gap. The remaining logarithm is finite at both endpoints and concave, since each other root contributes second angular derivative $`-\tfrac14\csc^2((\theta-\theta_k)/2)`$. At relative position $`0<t<1`$, sine concavity therefore gives

```math
\log|F(e^{i(\theta_j+t(\theta_{j+1}-\theta_j))})|
\ge(1-t)\ell_j+t\ell_{j+1}+\log c_j+\log(t(1-t)).
```

Negating and taking positive parts bounds the negative logarithm by
$`(1-t)b_j+tb_{j+1}+\log^+(1/c_j)-\log(t(1-t))`$.
Its last term integrates to 2 on $`[0,1]`$. Each nodal deficit receives its two adjacent half-gap weights. The angular mean of $`\log|F|`$ is zero for this monic unit-root polynomial, so the positive and negative means coincide. The logarithmic root singularities are integrable. This proves (4), including the cyclic gap and degree two.

If every $`q_j\le1/2`$, then $`c_j\ge4q_j`$ and
$`\sum_jq_j\log^+(1/c_j)\le\sum_jq_j\log(1/q_j)\le\log D`$.
For $`F_N`$, the roots are simple and include 1 and −1, so the maximum-gap hypothesis holds. This proves the first inequality in (1).

## Exact insertion and positive births

For $`N\ge3`$, a new root $`a/N`$ lies between old Farey neighbors $`c/b<e/d`$ with $`be-cd=1`$, $`b+d=N`$ and $`a=c+e`$. Its relative position from the left is $`t=d/N`$. The old linear interpolant and new weight are

```math
I_{N-1}(a/N)=\frac bN b_{N-1}(c/b)+\frac dN b_{N-1}(e/d),
\qquad w_N(a/N)=\frac1{2bd}.
```

At the cyclic endpoint, $`1/1`$ denotes the same value as $`0/1`$. The integral of the periodic linear interpolant is exactly $`B_{N-1}`$. Inserting knots does not change that integral, giving

```math
B_N-B_{N-1}=
\sum_{x\in\mathcal R_{N-1}}w_N(x)\Delta_N(x)
+\sum_{x\in\mathcal R_N\setminus\mathcal R_{N-1}}
 w_N(x)(b_N(x)-I_{N-1}(x)). \tag{5}
```

The weights in both sums are at cutoff N. There is no additional weight-change term.

The cumulative positive part of the second sum obeys

```math
\sum_{N=3}^X\sum_{x\text{ born at }N}
 w_N(x)[b_N(x)-I_{N-1}(x)]_+
\le\tfrac12\log X(1+\log X)^3. \tag{6}
```

Here are the derivative and geometry details behind (6). For a new root $`\alpha`$ and old endpoints $`z_L,z_R`$, deleting the two endpoints as in (4) gives

```math
[b_N(\alpha)-I_{N-1}(\alpha)]_+
\le[-\log C_N(\alpha)]_+,\qquad
C_N(\alpha)=|\Phi_N'(\alpha)|
 \frac{|\alpha-z_L||\alpha-z_R|}{|z_L-z_R|}
\ge\frac4{N^2}|\Phi_N'(\alpha)|.
```

The last bound uses $`t(1-t)=bd/N^2`$ and $`|z_L-z_R|\ge4/(bd)`$. For $`r=\omega(N)`$, the differentiated Möbius product gives

```math
|\Phi_N'(\alpha)|=
N\prod_{\substack{k\mid\operatorname{rad}(N)\\k>1}}
 |1-\alpha^{N/k}|^{\mu(k)}
\ge N(4/N)^{2^{r-1}-1}2^{-2^{r-1}}.
```

There are $`2^{r-1}-1`$ positive exponents and $`2^{r-1}`$ negative exponents. The nonzero chords lie between $`4/k`$ and 2. Hence the positive birth defect is at most $`2^{\omega(N)-1}\log(N/2)`$. The total birth weight is exactly

```math
\sum_{x\text{ born at }N}w_N(x)
=\frac1N\sum_{\substack{1\le b<N\\(b,N)=1}}\frac1b
\le\frac{H_{N-1}}N.
```

Finally $`\sum_{n\le X}2^{\omega(n)}/n\le\sum_{ab\le X}1/(ab)\le H_X^2`$ and $`H_X\le1+\log X`$ prove (6). Since $`B_2=0`$, equations (5)–(6) give an upper bound for $`B_X`$ by the signed old sum plus this birth allowance. The negative birth contribution has not been bounded or discarded from the exact identity.

## Two absolute boundary estimates

The complete mass of conductor n at cutoff $`N\ge\max(n,2)`$ is

```math
A(n,N)=\sum_{(a,n)=1}w_N(a/n)
=\frac1n\sum_{\substack{N-n<b\le N\\(b,n)=1}}\frac1b. \tag{7}
```

For $`n\ge2`$, the adjacent denominators are the largest positive representatives at most N of $`a^{-1}`$ and $`-a^{-1}`$ modulo n. The two half-gap weights prove (7) by summing these classes. At $`n=1`$ the cyclic mass is $`1/N`$. Both gaps are counted at degree two even though the neighbor is the same physical root. In particular $`\sum_{n\le N}A(n,N)=1`$ and $`A(n,N)\le1/(N-n)`$ for old sectors.

For an old root $`\alpha=\zeta_n^a`$, Möbius inversion, including the removable zeros, gives

```math
\log|\Phi_N(\alpha)|=\sum_{d\mid N}\mu(N/d)h_{n,a}(d),\qquad
h_{n,a}(d)=\begin{cases}
\log d&n\mid d,\\
\log|1-\alpha^d|&n\nmid d.
\end{cases} \tag{8}
```

Indeed the total zero order is $`\sum_{d\mid N,\ n\mid d}\mu(N/d)=0`$ for $`n<N`$. Along a radius the vanishing factors have modulus asymptotic to $`d(1-r)`$, leaving the finite terms $`\log d`$. Each summand in (8) has absolute value at most $`\log N`$. Thus

```math
|\Delta_N(x)|\le|\log|\Phi_N(\alpha)||\le\tau(N)\log N. \tag{9}
```

This uses $`F_N'(\alpha)=F_{N-1}'(\alpha)\Phi_N(\alpha)`$ and the 1-Lipschitz property of the negative part. The birth case $`n=N`$ has zero order one and is excluded.

For $`N>2Y`$, (7) bounds the selected small-conductor mass by $`2Y/N`$; for $`N\le2Y`$ use mass at most one. Splitting the sum at $`\min(X,2Y)`$, applying (9), and using

```math
\sum_{m\le Z}\tau(m)\le ZH_Z,\qquad
\sum_{m\le X}\frac{\tau(m)}m\le H_X^2
```

proves (2), with an empty late range allowed.

For $`N\ge4`$, set $`h=\lfloor\sqrt N\rfloor\le N/2`$. For $`1\le r\le h`$, (7) gives $`A(N-r,N)\le H_N/(N-r)\le2H_N/N`$. Thus the selected mass is at most $`2H_N/\sqrt N`$. At $`N=3`$, the selected rational root has zero deficit. Now

```math
\sum_{N\le X}\frac{\tau(N)}{\sqrt N}
=\sum_{ab\le X}\frac1{\sqrt{ab}}
\le2\sqrt X H_X
```

proves (3). The small-conductor region with $`Y=\lfloor\sqrt X\rfloor`$ and this age band cover the complement of the stated interior. Count their union once; its absolute cost is bounded by their sum, at most $`2\sqrt X\log X H_X(1+3H_X)`$. Equations (4)–(6) now prove (1). ∎

## Use, sources and verification

An upper bound $`\mathcal O_X^{\mathrm{int}}\ll_\epsilon X^{1/2+\epsilon}`$ for every $`\epsilon>0`$ would give the same bound for $`\widetilde h(F_X)`$ by (1). Amoroso's Corollary 1 identifies this all-epsilon angular-height condition with RH. Such an interior estimate is not proved here; the boundary estimates do not control it. No converse for the spacing-weighted statistic is asserted. [Amoroso, *On the heights of a product of cyclotomic polynomials*, 1995, Corollary 1 and Theorem 4](https://seminariomatematico.polito.it/rendiconti/cartaceo/53-3/183.pdf).

The Farey determinant and denominator facts are classical and are stated in [Boca, Gologan and Zaharescu, *On the index of Farey sequences*, §1](https://arxiv.org/pdf/math/0201044). The cyclotomic Möbius product is recorded in [Bzdęga, Herrera-Poyatos and Moree, *Cyclotomic polynomials at roots of unity*, §2.2, equation (4)](https://archive.mpim-bonn.mpg.de/1705/1/preprint_2016_45.pdf). Related log-chord geometry appears in [Erdélyi, Hardin and Saff, *Inverse Bernstein inequalities and min-max-min problems on the unit circle*, §2](https://arxiv.org/pdf/1307.4056). These sources supply the methods; the complete specialized proof is given above.

The [exact checker](../../formalization/verification/check-angular-boundary.py) uses only the Python standard library. From the repository root run

```sh
python3 formalization/verification/check-angular-boundary.py
```

It checks cyclic weights, all nodal coefficients of the insertion identity, sector and boundary masses, and selected cleared cyclotomic polynomial identities. It performs no floating-point threshold tests. The inequalities involving logarithms and integrals are established by the written proof, not by the finite checks. [Recorded result](../../formalization/verification/angular-boundary-result.json) · [Provenance](../../formalization/verification/angular-boundary-provenance.json). This package contains no Lean formalization.
