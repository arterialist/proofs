# High-frequency laws for the actual theta radial cutoff

The positive radial weights of the full theta correlation define a random arithmetic cutoff. Its logarithm has a uniform limit at fixed positive vertical parameter, and a different limit when that parameter approaches zero. A quantitative argument also transfers the complete signed arithmetic sum to a finite logarithmically weighted sum. This transfer requires more than convergence in distribution.

## Normalization and conclusions

Retain the actual radial weights from [the Abel/Bessel positivity theorem](theta-radial-positivity.md):

```math
W_y(k,x)=8\pi^2k^2\int_0^\infty e^{5a/2}
\big[f_y''(a)-f_y'(a)+(1/4+x^2)f_y(a)\big]
K_{ix}(2\pi ke^a)\,da,\qquad f_y(a)=a\sinh(ya).
```

Here $k\ge1$, $y>0$, and $x\in\mathbb R$. With

```math
D_k(x)=\sum_{d\mid k}e^{ix\log(d^2/k)},
\qquad \mathcal K_y(x)=\sum_{k\ge1}D_k(x)W_y(k,x),
```

one has $\mathcal K_y(x)=\partial_y|\Xi(x+iy)|^2$ in the normalization $\Xi(z)=\xi(1/2+iz)$. All prime powers are included. Write $X=|x|$, $\sigma=1/2+y$, $L_k=\log(X/(2\pi k))$, and $N_X=\lfloor X/(2\pi)\rfloor$.

The [strict radial comparison](theta-radial-arithmetic-sign.md) gives a probability law on the positive integers with

```math
S_k=\mathbb P_{y,x}(J\ge k)
=\frac{k^{\sigma}W_y(k,x)}{W_y(1,x)}.
```

At $y=0$, use $V(k,x)=\partial_yW_y(k,x)|_{y=0}>0$ and $S_k=k^{1/2}V(k,x)/V(1,x)$. The same comparison follows from the Abel weight $f(a)=a^2$. Define

```math
\mathcal A_y(x)=\begin{cases}
\mathcal K_y(x)/W_y(1,x),&y>0,\\
\partial_y\mathcal K_y(x)|_{y=0}/V(1,x),&y=0.
\end{cases}
```

For each fixed $y>0$,

```math
\frac{\log J}{\log X}\Longrightarrow\operatorname{Uniform}[0,1],
\qquad
\mathbb E\left(\frac{\log J}{\log X}\right)^r\longrightarrow\frac1{r+1}\quad(r>0).
\tag{1}
```

More generally, if $y=y_X\ge0$ and $y_XL_1\to\lambda\in[0,\infty)$, the limit has survival function, for $0<t<1$,

```math
G_\lambda(t)=
\begin{cases}
\displaystyle\frac{(1-t)(1-e^{-2\lambda(1-t)})}{1-e^{-2\lambda}},&\lambda>0,\\
(1-t)^2,&\lambda=0.
\end{cases}
\tag{2}
```

Every fixed positive moment converges too. At $\lambda=0$ the limit is $\operatorname{Beta}(1,2)$, with moments $2/((r+1)(r+2))$.

The stronger arithmetic conclusions are, for each fixed $0<y<1/2$,

```math
\mathcal A_y(x)=
\frac{\sum_{k\le N_X}D_k(x)k^{-1/2-y}
[1-(2\pi k/X)^{2y}]L_k}
{[1-(2\pi/X)^{2y}]L_1}
+O_y(X^{-1/6-y}),
\tag{3}
```

and, for every fixed finite $B>0$, uniformly over $0\le y\le B/\log X$,

```math
\mathcal A_y(x)=
\sum_{k\le N_X}\frac{D_k(x)}{\sqrt k}
\frac{L_k\sinh(yL_k)}{L_1\sinh(yL_1)}
+O_B\left(\frac{X^{-1/6}}{\log X}\right).
\tag{4}
```

The quotient in (4) is $(L_k/L_1)^2$ at $y=0$. All errors are uniform in real $x$ with $|x|\to\infty$; no avoidance of Bessel zeros is required. Neither formula establishes the sign of its finite sum.

## Uniform incomplete Mellin control

Put $R=2\pi k$ and

```math
J_\rho=R^{-\rho}\int_R^\infty r^{\rho-1}K_{iX}(r)\,dr.
```

The exact expression for $W$ is

```math
W_y=4\pi^2k^2\partial_y
\left\{[X^2+(y-1/2)^2]J_{5/2+y}
+[X^2+(y+1/2)^2]J_{5/2-y}\right\}.
\tag{5}
```

In particular the derivative of the second Mellin order has a minus sign. The complete integral is [DLMF 10.43.19](https://dlmf.nist.gov/10.43.E19),

```math
M_\rho=2^{\rho-2}\Gamma((\rho+iX)/2)\Gamma((\rho-iX)/2),
\qquad J_\rho=R^{-\rho}M_\rho+e_\rho,
```

```math
e_\rho=-\int_0^1u^{\rho-1}K_{iX}(Ru)\,du\quad(\rho>0).
```

For $0<\eta<1$, uniformly for $0<r\le\eta X$,

```math
|K_{iX}(r)|\le C_\eta e^{-\pi X/2}X^{-1/2},\qquad
|rK'_{iX}(r)|\le C_\eta e^{-\pi X/2}X^{1/2}.
\tag{6}
```

Here is a direct proof of the needed uniformity. Shift the integral $2K_{iX}(r)=\int_{\mathbb R}e^{-r\cosh t+iXt}dt$ to height $\beta=\pi/2-\epsilon$. After taking out $e^{-X\beta}$, the phase is $Xt-p\sinh t$, $p=r\cos\epsilon\le\eta X$. Its amplitude is bounded by one and has uniformly bounded variation on each half-line. Split each half-line at $|X-p\cosh t|=\alpha X$, where $\alpha=(1-\eta)/2$. On the outer intervals the first derivative is monotone and bounded away from zero; in the middle interval the second derivative has magnitude at least $X\sqrt{(1-\alpha)^2-\eta^2}$. The elementary first- and second-derivative oscillatory estimates give $O_\eta(X^{-1/2})$, also after inserting $e^{-|t|}$.

For the derivative, put $q(t)=e^{-r\cosh(t+i\beta)+iXt}$. On the positive and negative half-lines respectively,

```math
r\partial_rq=q'-iXq-re^{-(t+i\beta)}q,
\qquad
r\partial_rq=-q'+iXq-re^{t+i\beta}q.
```

Their integrated endpoint terms are bounded. The remaining terms are $X$ or $r$ times the preceding oscillatory integrals. Let $\epsilon\downarrow0$ after these absolutely convergent contour calculations to obtain (6). This remains uniform as the saddles move toward infinity when $r\downarrow0$.

The Bessel equation gives a stronger bound for the incomplete integral than taking its absolute integrand. With $D=r\partial_r$ and $w(r)=r^\rho/(X^2-r^2)$,

```math
\int_0^Rr^{\rho-1}K_{iX}(r)\,dr
=-w(R)DK_{iX}(R)+\int_0^Rw'(r)DK_{iX}(r)\,dr.
```

The lower boundary vanishes and $w'\ge0$. For order derivatives, use $w(r)\log^j(r/R)$ and

```math
\int_0^R|(w\log^j(r/R))'|\,dr
\le\frac{2j!R^\rho}{\rho^j(X^2-R^2)}\quad(j\ge1).
```

Consequently, uniformly on compact positive order intervals and $R\le\eta X$,

```math
\partial_\rho^je_\rho=O_{j,\eta}(e^{-\pi X/2}X^{-3/2}),
\qquad j=0,1,2.
\tag{7}
```

For a compact real order set not contained in $(0,\infty)$, keep $e_\rho=J_\rho-R^{-\rho}M_\rho$ and use the exact normalized recurrence

```math
e_\rho=\frac{R^2e_{\rho+2}+DK_{iX}(R)-\rho K_{iX}(R)}{\rho^2+X^2}.
```

Shift to positive orders and descend a fixed number of times. Since $R^2/(\rho^2+X^2)\le\eta^2$, this extends (7), including its fixed order derivatives, to every compact real order set. It uses the convergent integral from $R$ to infinity and the gamma recurrence, not a divergent lower-endpoint integral. This extension permits every fixed $y>0$ in (1); (3) retains its narrower stated range. The imaginary-order setting has established stronger asymptotic predecessors, including [Dunster, 1990](https://doi.org/10.1137/0521055) and [Dunster, 2025, §§2–4](https://arxiv.org/html/2412.12595v4). The elementary estimates above suffice here and do not apply real-order formulas in an imaginary-order regime.

## Two Mellin orders give the cutoff laws

Uniform complex Stirling estimates and their order derivatives give

```math
M_\rho=\pi X^{\rho-1}e^{-\pi X/2}(1+O(X^{-1})),
\qquad \partial_\rho\log M_\rho=\log X+O(X^{-1}).
\tag{8}
```

The estimates follow from [DLMF §5.11](https://dlmf.nist.gov/5.11); Cauchy's estimate on a fixed larger order neighborhood bounds two derivatives of the relative remainder. For fixed $y>0$, put $\rho=5/2+y$ and $C_y=4\pi^3(2\pi)^{-\rho}$. Equations (5)–(8) yield, uniformly for $1\le k\le X^\theta$, every fixed $0<\theta<1$,

```math
W_y(k,x)=C_yk^{-\sigma}X^{\rho+1}e^{-\pi X/2}
\left[L_k+O_{y,\theta}\left(
X^{-1}\log X+X^{-2y(1-\theta)}\log X
+X^{-1/2-\rho(1-\theta)}\right)\right].
\tag{9}
```

In particular $W_y(1,x)\sim C_yX^{7/2+y}e^{-\pi X/2}\log X$ and $S_{\lfloor X^t\rfloor+1}\to1-t$ for every $0<t<1$. Monotonicity supplies tightness and the endpoints, proving the weak limit in (1).

When $0<y\le B/L_1$, the two orders must instead be combined before estimating. Put $B_k=4\pi^3(2\pi)^{-5/2}k^{-1/2}X^{7/2}e^{-\pi X/2}$. The complete contribution divided by $B_k$ is $\partial_y[Q(y)+Q(-y)]$, where

```math
Q(y)=e^{yL_k}\left(1+\frac{(y-1/2)^2}{X^2}\right)
[1+\epsilon(5/2+y,X)],\qquad \partial_\rho^j\epsilon=O(X^{-1}),\ 0\le j\le2.
```

For $q(y)=Q(y)-e^{yL_k}$, one has $|q''(y)|\le C_B(L_k^2+1)/X$. Thus $q'(y)-q'(-y)$ has an explicit factor $y$. Equation (7) gives the same odd factor in the incomplete contribution. Uniformly for $k\le X^\theta$,

```math
W_y(k,x)=2B_kL_k\sinh(yL_k)(1+o(1)),
\qquad V(k,x)=2B_kL_k^2(1+o(1)).
\tag{10}
```

The errors are relative, even for arbitrarily small $y>0$. More quantitatively they are $O_B(X^{-1}+k^{5/2}X^{-3}/L_k^2)$. Taking ratios gives

```math
S_k=\frac{L_k}{L_1}\frac{1-e^{-2yL_k}}{1-e^{-2yL_1}}(1+o(1)),
\tag{11}
```

with $(L_k/L_1)^2$ at zero. The factor $k^y$ in the survival cancels the corresponding exponential in the ratio of hyperbolic sines. This proves (2).

The original full radial integral, including its mixed polynomial, gives

```math
0<W_y(k,x)\le C_y\sqrt{k}e^{-2\pi k},
\qquad W_y(k,x)/y\le C_B\sqrt{k}e^{-2\pi k}\quad(0<y\le1).
\tag{12}
```

For example, the inner Fourier integral has absolute value at most $Ct^{3/2}e^{-2t}$, $t=\pi ke^a$. Use $a\sinh(ya)\le ya^2e^{ya}$ and $e^a-1\ge a$; the remaining integral is $\int_0^\infty a^2e^{-(2\pi k-y-4)a}da$. This proves (12) for large $k$ uniformly in $x$, and the finite initial range follows from the same convergent integral. Together with (9) or (10), (12) makes $\mathbb E[(\log J/\log X)^r;J>X]$ exponentially small for every fixed $r>0$. Apply weak convergence to the bounded part to prove all stated moment limits.

One arithmetic consequence is

```math
\mathbb E\sum_{n^2\le J}n^{-1-2y}\longrightarrow\zeta(1+2y)
```

for fixed $y>0$. In regime (2), that expectation divided by $\log X$ tends to $\frac12\int_0^1e^{-\lambda t}G_\lambda(t)dt$, in particular $1/6$ at $\lambda=0$. This follows from the uniform integral comparison $(1-J^{-y})/(2y)+O(1)$, interpreted as $\tfrac12\log J+O(1)$ at zero, and the proved uniform integrability.

## Cancellation of the actual endpoint error

Let $W_y^{\rm comp}$ denote (5) with $J_\rho$ replaced by $R^{-\rho}M_\rho$. It is only a comparison expression. Write $\mathcal B(a)=K_{iX}(Re^a)$, and $T[h]=\int_{-\infty}^0h(a)\mathcal B(a)da$. Combining the mixed theta terms first gives the exact identity

```math
W_y^{\rm comp}-W_y=8\pi^2k^2T[w],
\qquad
w=e^{5a/2}[(R^2e^{2a}-6)f_y-6f_y'].
\tag{13}
```

In particular $w(0)=0$, $w'(0)=-12y$, and $w''(0)=2y(R^2-36)$. For $R<X$, set $Q(a)=X^2-R^2e^{2a}$, $v=w/Q$, $z=v''/Q$. Since $\mathcal B''=-Q\mathcal B$, two integrations by parts give

```math
T[w]=z(0)DK_{iX}(R)+(v'(0)-z'(0))K_{iX}(R)+T[z''],
\tag{14}
```

```math
v'(0)=-12y/Q_0,\qquad
z(0)=2y(R^2-36)/Q_0^2-48yR^2/Q_0^3,
\qquad Q_0=X^2-R^2.
```

Every lower boundary vanishes. At a fixed distance below the turning point, one more Bessel-equation integration for $T[z'']$ and (6) imply

```math
|W_y^{\rm comp}-W_y|
\le C_{\eta,y_0}y e^{-\pi X/2}
(k^2X^{-5/2}+k^4X^{-7/2}),
\quad R\le\eta X,\quad0<y\le y_0<1/2.
\tag{15}
```

The explicit $y$ factor is retained throughout.

For completeness, the gap dependence needed for summation is as follows. If $R\le(1-\delta)X$, $0<\delta\le1/2$, the proof of (6) gives the bounds there with $C\delta^{-1}$. For fixed derivative orders, $(Q^{-1})^{(j)}=O(X^{-2}\delta^{-j-1})$. With the integrable envelope $E(a)=(1+a^2)e^{(5/2-y_0)a}$, product differentiation gives

```math
v^{(j)}=O(y(R^2+1)X^{-2}\delta^{-j-1}E),\quad
z^{(j)}=O(y(R^2+1)X^{-4}\delta^{-j-4}E),
```

```math
(z''/Q)'=O(y(R^2+1)X^{-6}\delta^{-8}E).
```

Use the exact value of $v'(0)$ and integrate $T[z'']$ once more against the Bessel equation. Equation (14) then gives

```math
\begin{aligned}
|W_y^{\rm comp}-W_y|\le Cy e^{-\pi X/2}\big(&
k^4X^{-7/2}\delta^{-5}+k^2X^{-5/2}\delta^{-2}\\
&+k^4X^{-9/2}\delta^{-6}+k^4X^{-11/2}\delta^{-9}\big).
\end{aligned}
\tag{16}
```

This bound uses neither a sign nor a lower bound for an individual Bessel value.

## The turning tail and signed arithmetic transfer

Choose $\delta=X^{-1/3}$ and $k_0=\lfloor(1-\delta)X/(2\pi)\rfloor$. Retaining the actual floor, its gap lies between $\delta$ and $\delta+2\pi/X$. The leading two-order shape is

```math
F_y(r)=(1-r^{2y})\log(1/r)\le C_{y_0}y(1-r)^2
\quad(1/2\le r\le1).
```

The complete expression at $k_0$ is therefore $O(y e^{-\pi X/2}X^{7/3})$. The four error powers in (16) are $X^{13/6}$, $X^{1/6}$, $X^{3/2}$, $X^{3/2}$, all smaller. Hence $W_y(k_0,x)\le Cy e^{-\pi X/2}X^{7/3}$.

The strict radial comparison bounds every later weight by $W_y(k_0,x)$. Using $|D_k|\le\tau(k)$, $\sum_{k\le X}\tau(k)\ll X\log(2X)$, and (12) beyond $X$, one obtains

```math
\sum_{k\ge k_0}|D_k|W_y(k,x)
\ll y e^{-\pi X/2}X^{10/3}\log(2X)+yX^2e^{-2\pi X}.
\tag{17}
```

Summing (16) over $k<k_0$ similarly gives

```math
\sum_{k<k_0}|D_k|\,|W_y^{\rm comp}-W_y|
\ll y e^{-\pi X/2}X^{19/6}\log(2X).
\tag{18}
```

The complete leading terms between $k_0$ and $N_X$ satisfy the same bound as (17). Thus no estimate through the zero of $Q$ is needed: monotonicity controls the entire turning and post-turning tail.

For fixed $y$, Stirling to the next order replaces the complete expression by $C_yk^{-\sigma}X^{7/2+y}e^{-\pi X/2}F_y(2\pi k/X)$; its normalized arithmetic error is smaller than (17). At $k=1$ its normalizer is $C_yX^{7/2+y}e^{-\pi X/2}F_y(2\pi/X)$ with relative error $O_y(X^{-2})$. Dividing (17)–(18) by it proves (3). Keeping $F_y(2\pi/X)$ matters: its term of size $X^{-2y}\log X$ cannot simply be dropped at this accuracy.

For $0<y\le B/\log X$, the paired gamma argument above instead gives, for all $k\le N_X$,

```math
W_y^{\rm comp}(k,x)=2B_kL_k\sinh(yL_k)
+O_B\big(B_k y(L_k^2+1)/X\big),
```

and $W_y(1,x)\gg_B yX^{7/2}e^{-\pi X/2}(\log X)^2$. The elementary dyadic divisor bound

```math
\sum_{k\le N_X}\tau(k)k^{-1/2}(L_k^2+1)\ll\sqrt X\log(2X)
```

shows that the gamma errors and denominator replacement contribute $O_B(X^{-1/2}/\log X)$. Equations (17)–(18) contribute respectively $O_B(X^{-1/6}/\log X)$ and $O_B(X^{-1/3}/\log X)$. Divide by $y$ and take the continuous limit for $y=0$, justified by (12). This proves (4), including its boundary normalization.

## Linear-scale expansion and restricted events

A further explicit consequence concerns $k\asymp X$ below the turning point. Put $r=2\pi k/X$, $\rho_\pm=5/2\pm y$, $a=y-1/2$, $b=y+1/2$, and $c(\rho)=\rho(\rho-1)(\rho-2)/6$. Stirling yields

```math
G_y(r)=[a^2+c(\rho_+)]\log(1/r)+c'(\rho_+)+2a
-r^{2y}\{[b^2+c(\rho_-)]\log(1/r)+c'(\rho_-)-2b\}.
```

For $r$ in a fixed compact subinterval of $(0,1)$,

```math
W_y(k,x)=C_yk^{-\sigma}X^{7/2+y}e^{-\pi X/2}
\big[F_y(r)+X^{-2}G_y(r)+O_y(X^{-5/2})\big].
\tag{19}
```

Equation (15) supplies the endpoint part of this error. The denominator at $k=1$ has the same bracket with $r=2\pi/X$ and remainder $O_y(X^{-4}\log X)$. Thus if $k/X\to u\in(0,1/(2\pi))$, then
$\log X\,S_k\to[1-(2\pi u)^{2y}]\log(1/(2\pi u))$. The fixed-product limit is $W_y(k,x)/W_y(1,x)\to k^{-1/2-y}$, showing sharpness of the radial comparison exponent.

For a restricted cutoff event, the terminal mass must be retained. Fix $0<b<1$, $R=\lfloor X^b\rfloor$, and $0\le y\le B/L_1$. Define $\widetilde S_j$ by the right side of (11) without its error, and $\widetilde q_j=\widetilde S_j-\widetilde S_{j+1}$ for $j\le R$. With $P_\sigma(j,x)=\sum_{k\le j}D_k(x)k^{-\sigma}$, the bound following (10), using $\theta=(1+b)/2$, gives

```math
\mathbb E[P_\sigma(J,x)1_{J\le R}]
=\sum_{k\le R}D_k(x)k^{-\sigma}
(\widetilde S_k-\widetilde S_{R+1})
+O_{B,b}\left(X^{-1+b/2}\log X+
\frac{X^{-7(1-b)/4}}{\log X}\right).
\tag{20}
```

Indeed, for $e_j=S_j-\widetilde S_j$, finite summation by parts makes the error $\sum_{j=2}^Re_jD_jj^{-\sigma}-e_{R+1}P_\sigma(R,x)$. Its absolute value is at most $2\sup|e_j|\sum_{j\le R}\tau(j)j^{-\sigma}$. The boundary term is essential. At $y=0$ the finite weight in (20) is $(L_k^2-L_{R+1}^2)/L_1^2$. If $y\log X\to0$, the restricted positive diagonal divided by $\log X$ tends to $b^2/2-b^3/3$.

These formulas apply classical Mellin, oscillatory-integral, Stirling and Abel-summation methods to the specified complete radial weights. The logarithmic finite sums are Riesz/Perron-type arithmetic means; related product approximate-functional-equation machinery is given in [Rane, Theorem 1](https://arxiv.org/pdf/math/0502126). No priority claim is made. Convergence in (1)–(2) permits fixed bounded continuous tests and, by the tail bound, fixed polynomial-growth tests. The moving arithmetic prefix requires the quantitative estimates (3), (4), or (20). Its phase depends on the same $x$ as the cutoff law, and its full signed positivity remains unproved.
