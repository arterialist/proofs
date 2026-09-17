# A full-divisor decoder for adjacent integer births

For an integer $n\ge2$, define

```math
B_n(d)=\mathbf1_{d\mid n-1}-\mathbf1_{d\mid n+1}\qquad(d\ge1).
```

The classical identity $\sum_{d\mid m}\varphi(d)=m$ immediately gives

```math
\sum_{d\ge1}\varphi(d)B_n(d)=-2.                       \tag{1}
```

See [DLMF 27.6.1](https://dlmf.nist.gov/27.6.E1). Equation (1) is also formalized as `sum_weightedCurrent` in [BirthDivisorCoupling](../../formalization/BuildingBlocks/BirthDivisorCoupling.lean). The coordinates $d=1,2$ vanish identically, since $n-1$ and $n+1$ have the same parity.

Fix an integer $X\ge1$ and retain labels $X<n\le2X$. All their nonzero coordinates lie in $3\le d\le2X+1$. On this coordinate space use

```math
\langle u,v\rangle_\varphi=\sum_{d=3}^{2X+1}\varphi(d)u_dv_d,
\quad W_X=\sum_{d=3}^{2X+1}\varphi(d),
\quad L(v)=-\frac12\sum_{d=3}^{2X+1}\varphi(d)v_d.
```

Then $L(B_n)=1$. Cauchy–Schwarz, with equality on constant vectors, gives

```math
\|L\|^2=W_X/4,
\qquad r_d=-2/W_X,
\qquad L(r)=1,\qquad \|r\|_\varphi^2=4/W_X.            \tag{2}
```

Thus $r$ is the unique minimum-norm vector decoded as one. The $\Theta(X^2)$ size of $W_X$ concerns the unrestricted coordinate-space norm of this decoder. It is not a lower bound for the decoder restricted to the span of the actual arithmetic vectors $B_n$.

## The exact arithmetic Gram matrix

For integers $n,m\ge2$, divisor intersection and the same totient identity give

```math
\begin{aligned}
\langle B_n,B_m\rangle_\varphi={}&\gcd(n-1,m-1)-\gcd(n-1,m+1)\\
&-\gcd(n+1,m-1)+\gcd(n+1,m+1).                       \tag{3}
\end{aligned}
```

The finite coordinate range above contains every divisor involved. In particular

```math
\|B_n\|_\varphi^2=2n-2\gcd(n-1,n+1)
=\begin{cases}2n-4,&n\text{ odd},\\2n-2,&n\text{ even}.
\end{cases}
```

Write $B_n=r+z_n$. Equations (1)–(2) imply $L(z_n)=0$ and $r\perp z_n$. For example $B_3$ has only coordinate $B_3(4)=-1$, and its squared norm is $\varphi(4)=2$, agreeing with (3).

## Retaining the density and endpoint source

Let $\mathcal H$ be any real Hilbert space, let $k_n\in\mathcal H$, and let $E_0\in\mathcal H$ represent a density or endpoint contribution. For arbitrary real coefficients $c_n$, set

```math
E=E_0+\sum_{X<n\le2X}c_nk_n,
\qquad
J=r\otimes E_0+\sum_{X<n\le2X}c_nB_n\otimes k_n.
```

The orthogonal decomposition is exact:

```math
J=r\otimes E+\sum_nc_nz_n\otimes k_n,
\qquad
\|J\|^2=\frac4{W_X}\|E\|^2+
\left\|\sum_nc_nz_n\otimes k_n\right\|^2.             \tag{4}
```

Consequently $\|E\|^2\le(W_X/4)\|J\|^2$. The surplus term in (4) is nonnegative; a large value of that term does not imply a large value of $\|E\|$.

For the actual prime-error primitive on $[X,2X]$, take $\mathcal H=L^2([X,2X];\mathbb R^2)$ and

```math
k_y(t)=\bigl((t-y)_+,\;2X-y-(t-y)_+\bigr),\quad
h(t)=(t-X,2X-t),\quad
E_0=e(X)h-\int_X^{2X}k_y\,dy,
```

with $c_n=\Lambda(n)$. Then $E(t)=(\int_X^t e,\int_t^{2X}e)$. This identity follows by integrating $e(t)=e(X)+\sum_{X<n\le t}\Lambda(n)-(t-X)$. It retains all prime powers, the continuous density, the left endpoint error and the inclusive right endpoint; the latter has $k_{2X}=0$. Thus (4) is an exact transfer for the centered arithmetic input, rather than a statement about an uncentered random sample.

Only (1) is claimed here as a linked Lean formalization. Equations (2)–(4) are the written Hilbert-space calculation. Their usefulness is to expose the decoder cost and orthogonal surplus that a quantitative arithmetic estimate must control. No bound for that surplus, mathematical novelty or RH conclusion is asserted.
