# Temporal centering of the actual divisor-history kernel

Dyadic averaging does not orthogonalize the actual divisor-history columns, even after their means are removed. This note evaluates an actual positive prime subblock and the equally large negative contribution from its complement. Their smaller remaining signed sum is not estimated at the RH scale. The argument uses finite integration and the classical quantitative prime number theorem; it is written mathematics, not a Lean formalization or a priority claim.

For a positive integer $X$, let $H$ be the actual centered divisor forcing from [the integrated-history note](integrated-divisor-history.md), set $h=H(1)=2\gamma-1>0$, and define on $[X,2X)$

```math
f_n(x)=H(\lfloor x/n\rfloor),\quad
F(x)=\sum_{n\le2X}\mu(n)f_n(x),\quad
L_n=\int_X^{2X}f_n(x)dx,\quad
K_{nm}=\int_X^{2X}f_n(x)f_m(x)dx.
```

The actual error is $e(x)=\psi(\lfloor x\rfloor)-x=F(x)-2\gamma-\{x\}$. In particular the fractional-part correction cannot be omitted. Each column is constant on unit cells, giving the exact finite formulas

```math
K_{nm}=\sum_{j=X}^{2X-1}H(\lfloor j/n\rfloor)H(\lfloor j/m\rfloor),
\qquad L_n=\sum_{j=X}^{2X-1}H(\lfloor j/n\rfloor).
```

Define $g_n=f_n-L_n/X$, $K^c_{nm}=K_{nm}-L_nL_m/X$, and

```math
\bar F=X^{-1}\sum_n\mu(n)L_n,\quad
D_X^c=\sum_n\mu(n)^2K^c_{nn},\quad
C_X^c=\sum_{n\ne m}\mu(n)\mu(m)K^c_{nm}.
```

Off-diagonal sums are ordered. The centered step functions are exactly orthogonal to $\{x\}-1/2$, and both have mean zero. Therefore

```math
I_X:=\int_X^{2X}e(x)^2dx
=D_X^c+C_X^c+X(\bar F-2\gamma-1/2)^2+X/12.
```

This is the genuine unit-cell orthogonality. It does not eliminate correlations between different columns. The diagonal is bounded by

```math
0\le D_X^c\le D_X:=\sum_n\mu(n)^2K_{nn}
\le\frac{507}{2}X^2\sum_{n\le2X}\frac1n,
```

using $|H(q)|\le13\sqrt q$ and $\int_X^{2X}x\,dx=3X^2/2$.

## The terminal columns

For $X<n,m<2X$, $f_n(x)=h\mathbf1_{[n,2X)}(x)$, so direct integration gives

```math
K^c_{nm}=\frac{h^2}{X}(\min(n,m)-X)(2X-\max(n,m)).
```

Every entry is positive. For indices in $[5X/4,7X/4]$ it is at least $h^2X/16$, and the normalized correlation is at least $1/4$. Thus these actual columns are not even asymptotically orthogonal.

For $A(x)=M(\lfloor x\rfloor)-M(X)$ and its dyadic mean $\bar A$, their complete signed form is exactly

```math
\sum_{X<n,m<2X}\mu(n)\mu(m)K^c_{nm}
=h^2\int_X^{2X}(A(x)-\bar A)^2dx.
```

Its ordered off-diagonal part is this integral minus
$h^2X^{-1}\sum_{X<n<2X}\mu(n)^2(n-X)(2X-n)$. The weights have been evaluated; the actual Möbius variance has not been bounded.

## A positive actual subblock and its negative complement

Restrict both terminal indices to primes, whose Möbius signs are all $-1$. Let

```math
\mathcal P_X^c=\sum_{\substack{X<p,q<2X\\p,q\ {
m prime},\ p\ne q}}K^c_{pq},
\qquad P(x)=\pi(\lfloor x\rfloor)-\pi(X).
```

Then

```math
\mathcal P_X^c=h^2\int_X^{2X}(P-\bar P)^2dx
-\frac{h^2}{X}\sum_{X<p<2X}(p-X)(2X-p).
```

The ordinary prime number theorem gives, uniformly for $1\le t\le2$,
$P(Xt)=X(t-1)/\log X+o(X/\log X)$. This is a fixed-ratio interval statement, not a short-interval hypothesis. The removed diagonal is $O(X^2/\log X)$, so

```math
\mathcal P_X^c\sim\frac{h^2}{12}\frac{X^3}{\log^2X}.
```

The constant is $\int_1^2(t-3/2)^2dt=1/12$. Without temporal centering the corresponding constant is $\int_1^2(t-1)^2dt=1/3$. Centering changes the constant, not the power.

Set $\mathcal R_X^c=C_X^c-\mathcal P_X^c$. This includes every other ordered pair, including all cross terms with smaller labels. The unconditional quantitative PNT implies, with some fixed $c>0$ and $\omega(X)=(\log X)^{3/5}(\log\log X)^{-1/5}$,

```math
I_X\ll X^3e^{-c\omega(X)}.
```

For an explicit primary input see [Johnston–Yang, Theorem 1.4](https://arxiv.org/pdf/2204.01980v2), [published in 2023](https://doi.org/10.1016/j.jmaa.2023.127460). Its logarithmic prefactors are absorbed by reducing $c$; only the sufficiently large range is used here. The bound is for $\psi$, including proper prime powers. Since the centered variance is nonnegative and at most $I_X$,

```math
|C_X^c|\le I_X+D_X^c=o(X^3/\log^2X),
\qquad
\boxed{\mathcal R_X^c\sim-\frac{h^2}{12}\frac{X^3}{\log^2X}}.
```

Thus actual cross terms already cancel at this coarse accuracy. Neither large subblock is a lower bound for the full signed form. An $I_X\ll_\varepsilon X^{2+\varepsilon}$ conclusion would still require both an upper bound on $\mathcal P_X^c+\mathcal R_X^c$ at that scale and a bound on $X(\bar F-2\gamma-1/2)^2$. The diagonal is already affordable. These concern the unintegrated error energy $I_X$; they are not estimates for the two-sided primitive energy with its different $X^{4+\varepsilon}$ normalization.


## The uncentered overlap formula

For positive integers $a,b$, the exact intersection length is

$$
\ell_{nm}(a,b)=
[\min(2X,n(a+1),m(b+1))-\max(X,na,mb)]_+.
$$

Consequently the same full kernel also has the finite geometric expression

$$
K_{nm}=\sum_{a=1}^{\lfloor2X/n\rfloor}
 \sum_{b=1}^{\lfloor2X/m\rfloor}H(a)H(b)\ell_{nm}(a,b).
$$

Upper-endpoint values contribute intervals of zero length. This proof by intersection lengths is distinct from summing unit cells; both show exactly why integration produces an overlap kernel rather than a Kronecker delta.

For $B_X=\sum_n\mu(n)L_n$ and $C_X=\sum_{n\ne m}\mu(n)\mu(m)K_{nm}$, direct expansion before temporal centering gives

$$
I_X=D_X+C_X-(4\gamma+1)B_X
 +X(4\gamma^2+2\gamma+1/3).
$$

Indeed every $f_n$ is constant on unit cells and the mean of $2\gamma+\{x\}$ on each is $2\gamma+1/2$. The centered decomposition above is its exact orthogonal regrouping, with the squared mean retained. This finite calculation adds no RH-scale cancellation estimate.
