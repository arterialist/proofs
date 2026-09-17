# Uniform partial prime-cosine bounds for fixed Cauchy observation

These are written applications of the classical quantitative PNT, with no Lean formalization or priority claim. They supply the global envelope in the [fixed-observation prime-heat theorem](fixed-observation-prime-heat.md).

For real $P\ge2$ and $\nu\in\mathbb R$, set
$$
S_P(\nu)=\sum_{p\le P}\frac{\cos(2\nu\log p)}p.
$$
The following estimates are unconditional and uniform in the actual partial cutoff $P$:
$$
\boxed{\displaystyle
S_P(\nu)=\log\min\{\log P,|\nu|^{-1}\}+O(1)
\quad(0<|\nu|\le1/4),}
\tag{1}
$$
$$
\boxed{\displaystyle
|S_P(\nu)|\le2\log\log(3+2|\nu|)+C
\quad(|\nu|\ge1/4).}
\tag{2}
$$
The constant in (2) can be increased to cover any fixed interval bounded away from zero. At zero, the separate formula is
$$
S_P(0)=\log\log P+O(1).
\tag{3}
$$
The prime $2$ and a prime equal to the final cutoff are included throughout.

## A uniform partial-summation lemma

The only prime-distribution input is
$$
\theta(x)=x+E(x),\qquad
|E(x)|\le C_0x e^{-c_0\sqrt{\log x}}\quad(x\ge2),
\tag{4}
$$
for some absolute positive constants. One explicit primary source is Tim Trudgian,
[Updating the error term in the prime number theorem, Theorem 1](https://arxiv.org/pdf/1401.2689).
That theorem bounds the error by a constant times
$x(\log x)^{1/4}\exp(-\sqrt{\log x/6.455})$ for $x\ge149$.
Reducing the exponential constant absorbs the power of $\log x$; increasing the multiplicative constant covers $2\le x<149$. No hypothesis about unverified zeros is used.

For $2\le Y\le Z$ and real $\tau$, Stieltjes partial summation gives the exact identity
$$
\sum_{Y<p\le Z}p^{-1+i\tau}
=\int_Y^Z\frac{x^{-1+i\tau}}{\log x}\,dx
+f_\tau(Z)E(Z)-f_\tau(Y)E(Y)
-\int_Y^Z E(x)f_\tau'(x)\,dx,
\tag{5}
$$
where
$$
f_\tau(x)=\frac{x^{-1+i\tau}}{\log x},\qquad
f_\tau'(x)=x^{-2+i\tau}
\left(\frac{-1+i\tau}{\log x}-\frac1{\log^2x}\right).
$$
The use of $(Y,Z]$ in the Stieltjes integral is essential when an endpoint is prime.
Writing $V=\log Y$, (4) gives the uniform estimate
$$
\boxed{\displaystyle
\sum_{Y<p\le Z}p^{-1+i\tau}
=\int_{\log Y}^{\log Z}\frac{e^{i\tau v}}v\,dv
+O\!\left((1+|\tau|)
\frac{e^{-c_0\sqrt V}}{\sqrt V}\right).}
\tag{6}
$$
Both endpoint errors have this bound. For the integral error, use
$$
\int_V^\infty \frac{e^{-c_0\sqrt v}}v\,dv
=2\int_{\sqrt V}^\infty\frac{e^{-c_0 z}}z\,dz
\le\frac{2e^{-c_0\sqrt V}}{c_0\sqrt V}.
$$
The extra $v^{-2}$ term is bounded by a fixed multiple of the same quantity, since $V\ge\log2$. This proves (6) for every final cutoff, without passing first to an infinite Euler product.

## The small-frequency logarithm

Take $Y=2$, $Z=P$, and add the omitted prime $2$ explicitly. For $|\tau|\le1$, (6) implies
$$
\sum_{p\le P}p^{-1+i\tau}
=\frac{2^{i\tau}}2+
\int_{\log2}^{\log P}\frac{e^{i\tau v}}v\,dv+O(1).
\tag{7}
$$
Let $W=\log P$, $a=\log2$, and $0<|\tau|\le1/2$.
If $W\le1/|\tau|$, then
$$
\int_a^W\frac{\cos(\tau v)}v\,dv
=\log(W/a)+O(1),
$$
because the error is bounded by
$\frac12\tau^2\int_a^Wv\,dv\le1/4$.
If $W>1/|\tau|$, the same calculation up to $1/|\tau|$, followed by integration by parts on $[1/|\tau|,W]$, gives
$$
\int_a^W\frac{\cos(\tau v)}v\,dv
=\log\frac1{a|\tau|}+O(1).
$$
The oscillatory remaining integral is uniformly bounded, including its upper endpoint. Combining the two cases and putting $\tau=2\nu$ proves (1). Replacing $1/(2|\nu|)$ by $1/|\nu|$ changes the logarithm by at most $\log2$.
Putting $\tau=0$ in (7) gives (3). The compact range $1/2\le|\tau|\le1$ is also uniformly bounded by (7).

## Large frequency with an arbitrary prime cutoff

Suppose $|\tau|\ge1$. Choose a fixed constant $C_1\ge1$ so large that $c_0\sqrt{C_1}\ge3$, and set
$$
V=C_1\log^2(3+|\tau|),\qquad Y=e^V.
\tag{8}
$$
When $P>Y$, (6) bounds the error for the entire interval $(Y,P]$ by an absolute constant. Its main integral satisfies
$$
\left|\int_V^{\log P}\frac{e^{i\tau v}}v\,dv\right|
\le\frac{3}{|\tau|V}.
\tag{9}
$$
Hence the full tail $\sum_{Y<p\le P}p^{-1+i\tau}$ is $O(1)$, uniformly in $P$.
The prefix obeys
$$
\left|\sum_{p\le\min(P,Y)}p^{-1+i\tau}\right|
\le\sum_{p\le Y}\frac1p
\le\log\log Y+C
=2\log\log(3+|\tau|)+C.
\tag{10}
$$
Here the ordinary reciprocal-prime bound follows already from (7) at zero. If $P\le Y$, (10) handles the whole sum and no tail is introduced. This proves (2), including arbitrary real cutoffs and all lower-endpoint contributions.

## The resulting heat envelope

The estimates above imply a direct domination statement. Suppose a real centered observable has the exact decomposition
$$
M_P(\nu)=-2S_P(\nu)+E_P(\nu),
\qquad \sup_{P,\nu}|E_P(\nu)|<\infty.
\tag{11}
$$
For a compact set $K\subset\{s\in\mathbb C:\Re s<1/2\}$, put
$$
\sigma_+=\max\{0,\sup_{s\in K}\Re s\}<1/2,
\qquad B=\sup_{s\in K}|\Re s|.
$$
Then uniformly in $P\ge2$ and $s\in K$,
$$
\boxed{\displaystyle
|e^{-sM_P(\nu)}|
\le C_K
\begin{cases}
1+|\nu|^{-2\sigma_+},&0<|\nu|\le1/4,\\
[\log(3+|\nu|)]^{4B},&|\nu|>1/4.
\end{cases}}
\tag{12}
$$
For negative real parts of $s$, use the lower bound in (1), not just its upper bound: $\min(\log P,|\nu|^{-1})\ge\log2$ on the small-frequency range. Thus negative real parts cause no additional singularity at zero.

The right side is integrable for any fixed Cauchy observation measure, whose density is bounded near zero and $O(|\nu|^{-2})$ at infinity. The point $\nu=0$, where (3) grows with $P$, is null for this measure. Choosing $r>1$ with $r\sigma_+<1/2$ also gives a uniform $L^r$ bound by applying the same estimate to $rs$. This yields uniform integrability on compact subcritical parameter sets.

For the actual local multipliers, the elementary expansion of
$|u_p(\nu)-1|^2$ about its first $p^{-1}$ term has a uniform $O(p^{-3/2})$ remainder. Hence the centered heat observable in the stated application has (11); its separate exact zeta and higher-power identification is not needed for these partial-cutoff bounds. No assertion is made at the critical parameter $\Re s=1/2$, where the displayed majorant ceases to be integrable.
