# A stronger global signed bound for the actual prime-error convolution

Let Λ retain every prime power, let

$$
\psi(x)=\sum_{n\le x}\Lambda(n),\qquad E(x)=\psi(x)-x,
\qquad e_h=\frac{E(h)}h\quad(h\ge2),
$$

and define the finite additive convolution

$$
Q_s=\sum_{\substack{m,h\ge2\\m+h=s}}\Lambda(m)e_h
\qquad(s\ge4).
\tag{1}
$$

Write

$$
\Phi(x)=\frac{(\log x)^{3/5}}{(\log\log x)^{1/5}},\qquad
d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5},\qquad
A_0=\frac1{48.0718}.
\tag{2}
$$

Thus $d=0.212579202\ldots$. Bellotti's [Theorem 1.5](https://arxiv.org/html/2508.02041) supplies

$$
|E(x)|\ll x e^{-d\Phi(x)}.
\tag{3}
$$

The same paper gives the zero-free region $\beta\le1-A_0u(|\gamma|)$ for large zero ordinates, where $u(t)=(\log t)^{-2/3}(\log\log t)^{-1/3}$, and [Corollary 1.4](https://arxiv.org/html/2508.02041) gives

$$
N(1-Au(T),T)\ll_A1\qquad(A>A_0\text{ fixed}).
\tag{4}
$$

**Theorem.** For each fixed $\varepsilon>0$ and integer $X\ge4$,

$$
\boxed{\displaystyle
\left|\sum_{s=4}^{X}Q_s\right|
\ll_\varepsilon X^2
\exp\!\left[-\bigl(3^{2/5}d-\varepsilon\bigr)\Phi(X)\right].}
\tag{5}
$$

The exponent constant is $3^{2/5}d=0.329890093\ldots$, strictly larger than the constant $d$ inherited by summing the pointwise PNT bound. Equation (5) is a signed cumulative assertion. It does not imply a pointwise bound or a mean-square bound for $Q_s$.

**Proof status.** The analytic bound (5) is a written proof, not a Lean theorem. The exact finite convolution identity in (9) has a separate Lean verification; the zero-sum estimate and analytic exponent remain written arguments. This note makes no RH claim.

## A zero-sum estimate with three powers of the ordinate

The nontrivial zeros $\rho=\beta+i\gamma$ of $\zeta$ satisfy, for every $\varepsilon>0$,

$$
\sum_\rho\frac{x^{\beta-1}}{|\rho|^3}
\ll_\varepsilon
\exp\!\left[-\bigl(3^{2/5}d-\varepsilon\bigr)\Phi(x)\right].
\tag{6}
$$

Here and below zeros are counted with multiplicity. To prove (6), fix a large dyadic height $T$ and split $T\le|\gamma|<2T$ at $\beta=1-2A_0u(2T)$. By (4), the group above this line contains $O(1)$ zeros. The zero-free region bounds their real parts by $1-A_0u(2T)$. The group below the line has $O(T\log T)$ zeros by the ordinary zero-counting formula. Hence this height block contributes at most

$$
O\!\left(
\frac{x^{-A_0u(2T)}}{T^3}
+\frac{(\log T)x^{-2A_0u(2T)}}{T^2}
\right).
\tag{7}
$$

For fixed $A,k>0$, minimizing $Au(t)\log x+k\log t$ gives

$$
\min_{t\ge t_0}\{Au(t)\log x+k\log t\}
=\left[\left(\frac A{A_0}\right)^{3/5}k^{2/5}d+o(1)\right]\Phi(x).
\tag{8}
$$

The first term in (7) therefore has exponent constant $3^{2/5}d$. The second has constant $2^{3/5}2^{2/5}d=2d$, which is larger. There are only $O(\Phi(x))$ dyadic blocks up to height $\exp(C\Phi(x))$; their polynomial factor is absorbed by $\varepsilon\Phi(x)$. Above that height the powers $T^{-3}$ and $T^{-2}$ give a geometric tail. The finitely many lower zeros contribute $O(x^{-c})$ after normalizing by $x$. This proves (6).

## Exact convolution split and its quadratic remainder

All rearrangements here are finite. Summing (1) and then using $\psi(y)=y+E(y)$ gives

$$
\begin{aligned}
\sum_{s=4}^{X}Q_s
&=\sum_{h=2}^{X-2}\frac{E(h)}h\,\psi(X-h)\\
&=L_X+V_X,\\
L_X&=\sum_{h=2}^{X-2}\frac{E(h)}h(X-h),\\
V_X&=\sum_{h=2}^{X-2}\frac{E(h)}h E(X-h).
\end{aligned}
\tag{9}
$$

Put $\eta(x)=e^{-d\Phi(x)}$, extended by a bounded positive value on a fixed initial interval. The slow variation of $\eta$ gives $\eta(y)\ll\eta(X)$ for $X/2\le y\le X$, as well as $\sum_{n\le X}\eta(n)\ll X\eta(X)$ and $\sum_{n\le X}n\eta(n)\ll X^2\eta(X)$. For example, $(x\eta(x))'=\eta(x)(1-dx\Phi'(x))\ge\eta(x)/2$ once $x$ is large, since $x\Phi'(x)=o(1)$; the other estimates follow similarly. Split $V_X$ at $h=X/2$ and apply (3) on both sides. This yields

$$
|V_X|\ll X^2e^{-2d\Phi(X)}.
\tag{10}
$$

## The extra smoothing in the linear term

Define

$$
I_X=\int_1^X\frac{X-t}{t}E(t)\,dt.
\tag{11}
$$

On $h\le t<h+1$, one has $E(t)=E(h)-(t-h)$. The derivative of $(X-t)/t$ has absolute value $X/t^2$. Chebyshev's bound $E(h)=O(h)$ therefore shows that the sum-to-integral error per unit interval is $O(X/h)$. Including the two endpoint intervals,

$$
L_X=I_X+O(X\log X).
\tag{12}
$$

There is a direct way to justify the explicit formula here without exchanging a conditionally convergent series for $\psi(t)$ with an integral. Set

$$
R_0(y)=\int_1^y\frac{E(t)}t\,dt
=\sum_{n\le y}\Lambda(n)\log\frac yn-(y-1).
\tag{13}
$$

The second equality is a finite interchange. [Soundararajan, Lemma 1](https://annals.math.princeton.edu/wp-content/uploads/annals-v170-n2-p17-p.pdf), specialized to $s=0$, gives an exact formula for its logarithmically weighted prime sum. The underlying Perron integrand is $-\zeta'(w)\zeta(w)^{-1}y^w/w^2$: its residues at $w=1$ and at a nontrivial zero $\rho$ are $y$ and $-y^\rho/\rho^2$. The residue at $w=0$ is $O(1+\log y)$, and the sum of trivial-zero residues is $O(1)$. Thus, after subtracting $y-1$,

$$
R_0(y)=-\sum_\rho\frac{y^\rho}{\rho^2}+O(1+\log y).
\tag{14}
$$

The zero series is absolutely convergent for each fixed $y$, because $N(T)=O(T\log T)$ and $\sum_{T\le|\gamma|<2T}|\rho|^{-2}=O((\log T)/T)$. Soundararajan's explicit pole, $s=0$, and trivial-zero terms are all included in the $O(1+\log y)$ term. Fubini gives $I_X=\int_1^X R_0(y)\,dy$. Integrating the absolutely convergent series in (14), or first truncating it and then using absolute convergence at $X$, yields

$$
I_X=-\sum_\rho\frac{X^{\rho+1}}{\rho^2(\rho+1)}+O(X\log X).
\tag{15}
$$

For clarity, direct integration of the corresponding term in $E(t)$ gives

$$
-\frac1\rho\int_1^X(X-t)t^{\rho-1}\,dt
=-\frac{X^{\rho+1}}{\rho^2(\rho+1)}
+\frac X{\rho^2}-\frac1{\rho(\rho+1)}.
\tag{16}
$$

The last two zero sums converge absolutely and total $O(X)$. The direct logarithmic-prime formula above also avoids any pointwise convention at a prime power. Since $|\rho+1|\asymp|\rho|$, (6) and (15) give

$$
|L_X|\ll_\varepsilon X^2e^{-(3^{2/5}d-\varepsilon)\Phi(X)}.
\tag{17}
$$

Finally, $2d>3^{2/5}d$, so (9), (10), and (17) prove (5). The gain comes from the three powers of $\rho$ in the smoothed zero contribution; the quadratic term retains two independent Bellotti errors and is smaller.

The standard Goldbach average $G(X)=\sum_{s\le X}\sum_{m+h=s}\Lambda(m)\Lambda(h)$ has a different linear zero term, proportional to $X^{\rho+1}/[\rho(\rho+1)]$; see the [unconditional Fujii-formula study of Billington, Cheng, Schettler, and Suriajaya](https://arxiv.org/pdf/2306.09102). [Languasco and Zaccagnini](https://www.degruyterbrill.com/document/doi/10.1515/forum-2012-0100/html) also obtain explicit zero formulae for further Cesàro smoothing of that ordinary Goldbach average. In (1), the inner cumulative error $E(h)/h$ supplies an extra logarithmic smoothing before the outer sum and hence the extra reciprocal factor of $\rho$ without adding a Cesàro weight to $Q_s$. Bound (5) concerns this actual signed $Q$ convolution, not the ordinary Goldbach count.
