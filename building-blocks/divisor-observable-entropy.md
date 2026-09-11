# Entropy of the cyclic divisor observable

Use uniform probability on $\mathbb Z/n\mathbb Z$, natural logarithms, and

```math
f_n(r)=\tau(\gcd(n,r)),\qquad
\operatorname{Ent}(Z)=\mathbb E[Z\log Z]-\mathbb EZ\log\mathbb EZ,
\qquad \mathcal E_n=\tfrac12\mathbb E|f_n(r+1)-f_n(r)|^2.
```

The shift includes the cyclic endpoint. If energy is defined without the factor $1/2$, all energy values below double and entropy-to-energy ratios halve.

## Exact CRT formulas

Write $n=\prod_{p\mid n}p^{a_p}$. The CRT makes the local variables
$J_p=\min(v_p(r),a_p)$ independent, with

```math
\mathbb P(J_p=j)=
\begin{cases}(1-p^{-1})p^{-j},&0\le j<a_p,\\p^{-a_p},&j=a_p.\end{cases}
```

Here $f_n=\prod_p(J_p+1)$. Put

```math
A_p=\sum_{j=0}^{a_p}p^{-j},\quad
B_p=\sum_{j=0}^{a_p}(2j+1)p^{-j},\quad
L_p=\sum_{j=0}^{a_p}\mathbb P(J_p=j)(j+1)^2\log((j+1)^2).
```

Then $A=\mathbb Ef_n=\sigma(n)/n$ and $B=\mathbb Ef_n^2=\prod_pB_p$.
Independence and $\log f_n^2=\sum_p\log(J_p+1)^2$ give the exact tensor identity

```math
\boxed{\quad \frac{\operatorname{Ent}(f_n^2)}B
 =\sum_{p\mid n}\left(\frac{L_p}{B_p}-\log B_p\right).\quad}
\tag{1}
```

At each prime, the two positive valuations of $r$ and $r+1$ cannot occur simultaneously. Thus the adjacent correlation gives

```math
\boxed{\quad \frac{\mathcal E_n}{B}
 =1-\prod_{p\mid n}\frac{2A_p-1}{B_p}.\quad}
\tag{2}
```

This uses the same normalization as $\mathcal E_n=B-\mathbb E[f_n(r)f_n(r+1)]$.
These formulas do not require a log-Sobolev theorem for a general cyclic random walk.

For the classical arithmetic Fourier framework, see Tóth and Haukkanen, [*The discrete Fourier transform of r-even functions*, §§2–4 and Application 8](https://arxiv.org/html/1009.5281). That framework supplies the divisor and Ramanujan-sum decomposition. Formula (1) instead uses CRT independence of the multiplicative observable; no entropy bound is imported from its Fourier identities.

## Primorials rule out a uniform observable log-Sobolev bound

Let $n_y=\prod_{p\le y}p$, $y\ge2$. Each local factor is 1 with probability $1-1/p$ and 2 with probability $1/p$. Hence

```math
B_p=1+3/p,\qquad L_p=8\log2/p,
```

and exactly

```math
H_y:=\frac{\operatorname{Ent}(f_{n_y}^2)}B
 =\sum_{p\le y}\left(\frac{8\log2}{p+3}-\log(1+3/p)\right),
\tag{3}
```

```math
\frac{\mathcal E_{n_y}}B
 =1-\prod_{p\le y}\frac{p+2}{p+3}.
\tag{4}
```

Set $c=8\log2-3>0$. The summand in (3) is $c/p+O(p^{-2})$. Also

```math
\log\frac{p+2}{p+3}=-1/p+O(p^{-2}).
```

The classical Mertens reciprocal-prime theorem now gives constants $C_0\in\mathbb R$ and $K>0$ with

```math
H_y=c\log\log y+C_0+o(1),\qquad
\frac{\mathcal E_{n_y}}B=1-\frac{K}{\log y}(1+o(1)).
\tag{5}
```

For a primary quantitative version of the input, see Rosser and Schoenfeld, [*Approximate formulas for some functions of prime numbers*, Theorem 5, equations (3.17)-(3.18), p. 70](https://denisevellachemla.eu/Rosser-Schoenfeld-1962.pdf), [publisher record](https://doi.org/10.1215/ijm/1255631807). Their Theorem 4 also gives $\vartheta(y)\sim y$. Since $\log n_y=\vartheta(y)$, this implies

```math
\boxed{\quad
\frac{\operatorname{Ent}(f_{n_y}^2)}{\mathcal E_{n_y}}
 =c\log\log\log n_y+C_0+o(1).
\quad}\tag{6}
```

The denominator correction in (5) changes (6) by $o(1)$, since
$\log\log y/\log y\to0$.
There is therefore no constant independent of $n$ satisfying
$\operatorname{Ent}(f_n^2)\le C\mathcal E_n$ even just on the actual primorial sequence. The optimal constant for this single observable at $n_y$ has precisely the growth in (6). This says nothing about the much larger optimal constant for all functions on the cycle.

The energy and variance do not share the entropy obstruction: on primorials $A^2/B$ tends to zero, so both $\operatorname{Var}(f_n)/B$ and $\mathcal E_n/B$ tend to 1. Their bounded comparison leaves the growing entropy unconstrained.

For finite examples, the exact energy ratios for $n=6,30,210$ are respectively $1/3$, $5/12$, $19/40$. Formula (3) gives entropy ratios about $0.423794$, $0.646937$, $0.844780$. Direct enumeration on the actual cycles reproduces these values. The asymptotic obstruction is proved by (3)-(6), not inferred from those examples.

## A normalization-sensitive relation to the mean

There is an absolute, effectively bounded remainder connecting the normalized entropy to the actual divisor mean, uniformly over all prime exponents. Define

```math
e_p(a)=\frac{L_p(a)}{B_p(a)}-\log B_p(a),\qquad
r_p(a)=e_p(a)-c\log A_p(a).
```

Then, for every $n\ge1$,

```math
\boxed{\quad
\frac{\operatorname{Ent}(f_n^2)}{\mathbb Ef_n^2}
 =c\log\frac{\sigma(n)}n+R(n),\qquad
R(n)=\sum_{p\mid n}r_p(a_p),\qquad |R(n)|\le C_*<\infty.
\quad}\tag{7}
```

Here one can take the explicit convergent constant

```math
C_*:=\sum_p\sup_{a\ge1}|r_p(a)|
 \le512\sum_p p^{-2}<512.
\tag{8}
```

The last numerical bound is deliberately coarse. The next argument proves convergence uniformly in the exponents rather than assuming it.

Put $z=1/p\le1/2$ and $k=8\log2<6$, so $c=k-3<3$. Uniformly in $a\ge1$,

```math
|\log A_p-z|\le z^2,\quad
B_p=1+3z+R_B,\quad 0\le R_B\le14z^2,\quad B_p-1\le10z.
```

The first bound follows by comparing $A_p$ with $1+z$ and $(1-z)^{-1}$. The second follows from
$\sum_{j\ge2}(2j+1)2^{-(j-2)}=14$.
Consequently
$|\log B_p-3z|\le64z^2$, using $0\le t-\log(1+t)\le t^2/2$.

For $\Phi(j)=(j+1)^2\log((j+1)^2)$, discrete summation by parts gives

```math
L_p=\sum_{j=1}^{a}(\Phi(j)-\Phi(j-1))z^j
 =kz+R_L,\qquad 0\le R_L\le376z^2.
```

Indeed, $\Phi(j)-\Phi(j-1)\le\Phi(j)\le2(j+1)^3$ and
$\sum_{j\ge2}2(j+1)^3 2^{-(j-2)}=376$.
Since $B_p\ge1$,

```math
|L_p/B_p-kz|\le(376+10k)z^2<436z^2.
```

Combining these three estimates yields
$|r_p(a)|<503z^2\le512/p^2$, proving (7)-(8).

In particular, an independently proved upper bound $H(n)$ on normalized entropy would give the actual inequality

```math
\boxed{\qquad \frac{\sigma(n)}n
 \le\exp\!\left(\frac{H(n)+C_*}{8\log2-3}\right).\qquad}
\tag{9}
```

This uses the fixed arithmetic normalization $f_n(1)=1$. Under a rescaling $f_n\mapsto t f_n$, normalized entropy and normalized shift energy are unchanged while the mean multiplies by $t$. Thus (7) or (9) cannot be asserted with the rescaled mean. The scale-invariant version would involve $\mathbb E(tf_n)/(tf_n)(1)=\sigma(n)/n$. The canonical anchor must be retained.

Formula (7) also identifies the remaining issue. Merely allowing a log-Sobolev constant of order $\log\log\log n$ gives the right rough logarithmic scale, but not a sharp divisor-sum inequality. A sharp comparison must control the exact signed remainder $R(n)$ together with normalized entropy. Substituting an RH-equivalent bound for that missing upper estimate would not prove it. The useful repair is to replace the false uniform entropy-to-energy hypothesis by the exact CRT entropy formula and this anchored comparison; the Mertens step and divisor products are established mathematics, not new RH progress.

These are written mathematical deductions using the cited classical identities, with exact priority unresolved. No Lean formalization or RH conclusion is claimed.
