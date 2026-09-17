# Rational-cusp finite parts of a cyclotomic eta product

A finite product of cyclotomic polynomials determines an eta product whose rational-cusp finite constant is independent of the cusp denominator and numerator. The corresponding infinite tail retains the logarithm of the original cyclotomic derivative. The formulas below evaluate the normalization and specify exactly what remains in the tail.

Fix an integer $N\ge1$. Let $\mu$ be the Möbius function, $M(x)=\sum_{1\le m\le x}\mu(m)$, and

$$
c_d=M(\lfloor N/d\rfloor)\quad(1\le d\le N),\qquad
F_N(z)=\prod_{j=1}^N\Phi_j(z),\qquad
D_N=\sum_{j=1}^N\varphi(j).
$$

Here $\Phi_1(z)=z-1$. Write $\Lambda(p^r)=\log p$ for primes $p$ and integers $r\ge1$, with $\Lambda(m)=0$ otherwise, and put $\psi(N)=\sum_{m\le N}\Lambda(m)$. All logarithms of positive real numbers are natural logarithms.

For $\operatorname{Im}\tau>0$, define

$$
\eta(\tau)=e^{\pi i\tau/12}\prod_{k=1}^{\infty}(1-e^{2\pi i k\tau}),\qquad
E_N(\tau)=\prod_{d=1}^N\eta(d\tau)^{c_d},
$$

$$
T_N(\tau)=\prod_{d=1}^N\prod_{k=2}^{\infty}
(1-e^{2\pi i dk\tau})^{c_d}.
$$

These products converge locally uniformly and are nonzero in the upper half-plane. Indeed, on each compact subset the sums of $|e^{2\pi i dk\tau}|$ converge, and the corresponding logarithm series converge absolutely in their tails. There are only finitely many $d$. Negative integer exponents therefore give ordinary reciprocals of nonvanishing holomorphic functions, with no choice of fractional powers.

For integers $1\le n\le N$ and $\gcd(a,n)=1$, set

$$
\alpha=e^{2\pi i a/n},\qquad
L_{n,N}(a)=\log|F_N'(\alpha)|,\qquad
K_{N,n}=\sum_{d=1}^N\frac{c_d\gcd(d,n)^2}{n^2d}.
$$

**Theorem.** With $N,n,a$ fixed, the following limits hold as $y\downarrow0$:

$$
\lim_{y\downarrow0}\left(
\log|E_N(a/n+iy)|+
\frac{\pi K_{N,n}}{12y}+\frac12\log y\right)
=-\frac12\psi(N),
\tag{1}
$$

$$
\lim_{y\downarrow0}\left(
\log|T_N(a/n+iy)|+
\frac{\pi K_{N,n}}{12y}+\frac32\log y\right)
=-\frac12\psi(N)-\log(2\pi)-L_{n,N}(a).
\tag{2}
$$

No sign assumption on $K_{N,n}$ is required. These are fixed-$N$ limits; they assert no error estimate uniform as $N$ grows.

**Proof.** The finite divisibility identity is

$$
\sum_{\substack{d\le N\\ e\mid d}}c_d=1
\qquad(1\le e\le N).
\tag{3}
$$

To see this, put $Q=\lfloor N/e\rfloor\ge1$ and expand the Mertens function:

$$
\sum_{k\le Q}M(\lfloor Q/k\rfloor)
=\sum_{km\le Q}\mu(m)
=\sum_{r\le Q}\sum_{m\mid r}\mu(m)=1.
$$

This uses the classical identity $\sum_{m\mid r}\mu(m)=\mathbf 1_{\{r=1\}}$. Möbius inversion also gives

$$
\sum_{d\le N}c_d\log d
=\sum_{r\le N}\sum_{d\mid r}\mu(r/d)\log d
=\psi(N),\qquad
\sum_{d\le N}dc_d=D_N.
\tag{4}
$$

The relevant classical identities are recorded in [DLMF 27.5.2–27.5.5](https://dlmf.nist.gov/27.5), with attribution there to Apostol, *Introduction to Analytic Number Theory*, Chapter 2.

In particular, $\sum_dc_d=1$. Expanding the logarithm of a gcd into prime-power divisibility indicators and using (3) gives

$$
\begin{aligned}
\sum_{d\le N}c_d\log\gcd(d,n)
&=\sum_{p^j\mid n}(\log p)
  \sum_{\substack{d\le N\\p^j\mid d}}c_d\\
&=\sum_{p^j\mid n}\log p=\log n.
\end{aligned}
$$

The sums over $p^j\mid n$ have $p$ prime and $j\ge1$; for $n=1$ they are empty. The hypothesis $n\le N$ ensures that (3) applies to every such prime power. Thus

$$
\sum_{d\le N}c_d\log\frac{nd}{\gcd(d,n)}=\psi(N).
\tag{5}
$$

Next consider any reduced rational number $h/k$, with $k\ge1$. Choose integers $u,v$ satisfying $uh+vk=-1$. The determinant-one matrix with rows $(u,v)$ and $(k,-h)$ sends $z=h/k+it$ to

$$
\frac{uz+v}{kz-h}=\frac uk+\frac{i}{k^2t}.
$$

The eta transformation has a multiplier of modulus one and a square-root factor of modulus $|kz-h|^{1/2}$. Consequently

$$
|\eta(h/k+it)|=(kt)^{-1/2}
\left|\eta\!\left(u/k+i/(k^2t)\right)\right|.
$$

This is the modulus of the classical Dedekind transformation formula; see [Kong and Teo, *An elementary proof of the transformation formula for the Dedekind eta function*, Theorem 7.1](https://arxiv.org/pdf/2302.03280). The product defining eta at the transformed point now gives

$$
\log|\eta(h/k+it)|
=-\frac{\pi}{12k^2t}-\frac12\log(kt)
+O\!\left(e^{-2\pi/(k^2t)}\right).
\tag{6}
$$

For $d(a/n+iy)$, its reduced cusp denominator is $k=n/g_d$, where $g_d=\gcd(d,n)$, and its imaginary part is $t=dy$. Hence (6) becomes

$$
\log|\eta(d(a/n+iy))|
=-\frac{\pi g_d^2}{12n^2dy}
-\frac12\log\!\left(\frac{nd}{g_d}y\right)
+O\!\left(e^{-2\pi g_d^2/(n^2dy)}\right).
$$

Summing with the finite integer weights $c_d$, and using (5), proves (1). In fact its remainder is $O(e^{-\varepsilon/y})$ for fixed $N,n$, where one may take $\varepsilon=\min_{1\le d\le N}2\pi g_d^2/(n^2d)>0$.

It remains to separate the tail. The factorization $z^j-1=\prod_{d\mid j}\Phi_d(z)$ and multiplicative Möbius inversion give

$$
F_N(z)=\prod_{d\le N}(z^d-1)^{c_d},\qquad
P_N(z):=\prod_{d\le N}(1-z^d)^{c_d}=-F_N(z)
\quad(|z|<1).
$$

The minus sign follows from $\sum_dc_d=1$. Separating the $k=1$ factors in the eta products yields the exact identity

$$
E_N(\tau)=e^{2\pi i\tau D_N/24}
P_N(e^{2\pi i\tau})T_N(\tau).
\tag{7}
$$

The root $\alpha$ occurs only in $\Phi_n$ and is simple there. Taylor expansion along the radius therefore gives

$$
\log|P_N(\alpha e^{-2\pi y})|
=\log(1-e^{-2\pi y})+L_{n,N}(a)+o(1)
=\log y+\log(2\pi)+L_{n,N}(a)+o(1).
\tag{8}
$$

Taking absolute values in (7) gives

$$
\log|T_N(a/n+iy)|
=\log|E_N(a/n+iy)|+\frac{\pi D_Ny}{12}
-\log|P_N(\alpha e^{-2\pi y})|.
$$

Equations (1) and (8) prove (2). The same radial calculation in the finite product gives the explicit derivative formula

$$
L_{n,N}(a)
=\sum_{\substack{d\le N\\n\mid d}}c_d\log d
+\sum_{\substack{d\le N\\n\nmid d}}c_d\log|1-\alpha^d|.
\tag{9}
$$

Indeed, for $n\mid d$, the ratio $(1-r^d)/(1-r)$ tends to $d$ as $r\uparrow1$, and the total exponent of $1-r$ is one by (3). Every other factor has a nonzero limit. This also checks the simple-root normalization directly. ∎

For a small example, take $N=3$, $n=2$, and $a=1$. Then

$$
(c_1,c_2,c_3)=(-1,1,1),\qquad
F_3(z)=(z-1)(z+1)(z^2+z+1),
$$

so $|F_3'(-1)|=2$, $\psi(3)=\log6$, and $K_{3,2}=1/3$. Formula (1) subtracts the divergence $-\pi/(36y)-\tfrac12\log y$ and leaves $-\tfrac12\log6$. Formula (2) subtracts $-\pi/(36y)-\tfrac32\log y$ and leaves $-\tfrac12\log6-\log(4\pi)$.

The useful evaluated quantity is (5), or equivalently the cusp-independent constant in (1). If $\mathcal T_{n,N}(a)$ denotes the limit on the left of (2), then for any two primitive phases of order $n$,

$$
\mathcal T_{n,N}(a)-\mathcal T_{n,N}(b)
=-L_{n,N}(a)+L_{n,N}(b).
$$

Thus the tail preserves the entire phase dependence of the derivative. The eta transformation alone supplies no bound on those differences or on a weighted sum of them. This is a written building block using classical Möbius inversion and eta transformation; no Lean formalization or bound toward RH is asserted here.
