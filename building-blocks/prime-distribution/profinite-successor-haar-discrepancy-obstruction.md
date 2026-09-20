# Profinite Haar independence does not control the finite prime successor orbit

**Status:** unconditional written obstruction, 20 September 2026.

This note tests a direct dynamical model of the arithmetic intuition behind
the project. Addition by one is the odometer on the profinite integers, while
divisibility by distinct primes is independent under Haar measure. That
independence is spatial. It does not make successive points of the odometer
independent. At the sieving depth needed to detect primes, the Haar mean and
the finite-orbit mean differ by a nonzero constant. The resulting
twice-integrated discrepancy has the full elementary scale $X^5$.

The result rules out a power-saving argument based only on replacing the
finite successor orbit by Haar measure. It does not rule out an argument that
adds a new signed arithmetic correlation estimate. The related
[finite-prefix refinement](../successor-and-division/actual-prefix-refinement.md)
computes the same change of measure at the level of residue towers.

## The successor operator

Let $G=\widehat{\mathbb Z}$, let $\mu_G$ be its Haar probability measure, and
put

$$
 Uf(x)=f(x+1).
$$

For an integer $X\ge1$, define the double-prefix operator

$$
 (\mathcal K_Xf)_m(x)
 =\sum_{k=X}^{X+m-1}\sum_{n=1}^{k}f(x+n),
 \qquad 1\le m\le X,
$$

and write

$$
 A_m=\sum_{k=X}^{X+m-1}k
 =mX+\frac{m(m-1)}2.
 \tag{1}
$$

For the arithmetic forcing $b(n)=\Lambda(n)-1$, the integer primitive in the
coarse-energy problem satisfies the exact identity

$$
 P(m)=(\mathcal K_Xb)_m(0)-\frac m2.
 \tag{2}
$$

The last term is the integral of $\lfloor t\rfloor-t$ across $m$ unit
intervals.

## Sharp $X^5$ norm on mean-zero cylinders

The continuous characters of $G$ are

$$
 \chi_\alpha(x)=e(\alpha x),
 \qquad \alpha\in\mathbb Q/\mathbb Z.
$$

They diagonalize $U$. On $\chi_\alpha$, the multiplier of the $m$-th
component of $\mathcal K_X$ is

$$
 H_{X,m}(\alpha)
 =\sum_{k=X}^{X+m-1}\sum_{n=1}^{k}e(n\alpha).
 \tag{3}
$$

Since $|H_{X,m}(\alpha)|\le A_m$, orthogonality of the characters gives

$$
 \|\mathcal K_X\|_{L^2_0(G)\to L^2(G;\ell^2_m)}^2
 \le \sum_{m=1}^{X}A_m^2.
$$

Conversely, the nontrivial rational characters $\chi_{1/q}$ are mean zero
and $H_{X,m}(1/q)\to A_m$ as $q\to\infty$. Hence

$$
 \boxed{
 \|\mathcal K_X\|_{L^2_0(G)\to L^2(G;\ell^2_m)}^2
 =\sum_{m=1}^{X}A_m^2
 =\frac{19}{30}X^5+O(X^4).}
 \tag{4}
$$

Thus Haar mean zero, by itself, gives exactly the exponent that must be
improved.

## A prime-detecting cylinder with $X^5$ discrepancy

Put

$$
 z=\sqrt{2X},\qquad Q=\prod_{p\le z}p,
 \qquad
 F_X(x)=(\log X)\mathbf 1_{(x,Q)=1}.
$$

The divisibility events indexed by the primes in $Q$ are independent under
Haar measure. Mertens' product theorem gives

$$
 c_X:=\int_G F_X\,d\mu_G
 =(\log X)\prod_{p\le z}\left(1-\frac1p\right)
 =2e^{-\gamma}+o(1).
 \tag{5}
$$

The finite successor orbit has a different mean. Every composite $n\le2X$
has a prime factor at most $\sqrt{2X}=z$. Therefore, for $1\le t\le2X$, the
integers selected by the cylinder are exactly $1$ and the primes greater
than $z$:

$$
 \sum_{n\le t}F_X(n)
 =(\log X)\bigl(1+\pi(t)-\pi(z)\bigr).
 \tag{6}
$$

The prime number theorem makes (6) equal to $t+o(X)$, uniformly for
$X\le t\le2X$. For the Haar-centered cylinder $f_X=F_X-c_X$, it follows
uniformly for $m\le X$ that

$$
 (\mathcal K_Xf_X)_m(0)
 =(1-2e^{-\gamma})A_m+o(X^2).
$$

Together with (4), this proves

$$
 \boxed{
 \sum_{m=1}^{X}|(\mathcal K_Xf_X)_m(0)|^2
 =\frac{19}{30}(1-2e^{-\gamma})^2X^5+o(X^5).}
 \tag{7}
$$

Meanwhile,

$$
 \|f_X\|_{L^2(G)}^2=O(\log X).
$$

The logarithmic size of the spatial $L^2$ norm cannot compensate for the
fixed-power failure in (7). The modulus

$$
 Q=\exp\bigl((1+o(1))\sqrt{2X}\bigr)
$$

is also far larger than the observed orbit.

## Exact von Mangoldt cylinder and the surviving signed sum

For $Y=2X$, the finite cylinder

$$
 L_Y(x)=-\sum_{d\le Y}\mu(d)\log d\,\mathbf 1_{d\mid x}
 \tag{8}
$$

agrees with $\Lambda(n)$ at every integer $n\le2X$. Its Haar mean is

$$
 a_Y=-\sum_{d\le Y}\frac{\mu(d)\log d}{d}.
$$

Set

$$
 R_d(k)=\left\lfloor\frac kd\right\rfloor-\frac kd,
 \qquad
 B_d(m)=\sum_{k=X}^{X+m-1}R_d(k).
$$

Expanding the divisibility cylinders gives the exact identity

$$
 \boxed{
 P(m)=-\sum_{d\le2X}\mu(d)\log d\,B_d(m)
 +(a_{2X}-1)A_m-\frac m2.}
 \tag{9}
$$

Since $|B_d(m)|\le m$, absolute summation in (9) gives only the elementary
$X^5$ energy scale, up to logarithms. Truncation does not fix the problem.
If $D<2X$ and

$$
 r_D(n)=\Lambda(n)+\sum_{\substack{d\mid n\\d\le D}}
 \mu(d)\log d,
$$

then every prime $p>D$ satisfies $r_D(p)=\log p$, and consequently

$$
 \sum_{n\le2X}|r_D(n)|
 \ge \vartheta(2X)-\vartheta(D).
 \tag{10}
$$

For any finitely supported remainder $r$, direct summation gives

$$
 \sum_{m\le X}|(\mathcal K_Xr)_m(0)|^2
 \le X^3\left(\sum_{n\le2X}|r(n)|\right)^2.
 \tag{11}
$$

When $D\le X$, the right side of (10) is of order $X$. An absolute
truncation estimate therefore again permits the full $X^5$ scale.

## Consequence

Prime coordinates are independent under Haar measure, but the successor
odometer has pure point spectrum and no mixing. At the depth required to
recognize primes, the finite orbit does not approximate Haar measure with a
power saving. Formula (9) shows what remains after the geometric lift: the
same signed Möbius divisor sum that the arithmetic formulation must control.

The obstruction is scoped. It excludes a proof based only on profinite
independence, generic $L^2$ control, or absolute truncation. A proof may still
combine this geometry with a new estimate that preserves the actual signed
divisor correlations.

## Sources

- J. B. Rosser and L. Schoenfeld, [*Approximate formulas for some functions of prime numbers*](https://projecteuclid.org/journals/illinois-journal-of-mathematics/volume-6/issue-1/Approximate-formulas-for-some-functions-of-prime-numbers/10.1215/ijm/1255631807.full), Illinois Journal of Mathematics 6 (1962), 64--94.
- T. Trudgian, [*Updating the error term in the prime number theorem*](https://arxiv.org/abs/1401.2689), Ramanujan Journal 39 (2016), 225--234.

The analytic inputs used above are the classical prime number theorem,
Mertens' product theorem, and the elementary identity
$\Lambda(n)=-\sum_{d\mid n}\mu(d)\log d$. No novelty or
first-formalization claim is made.
