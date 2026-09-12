# The centered full-prime multiplier and its original Hilbert-space domain

This written proof applies classical multiplication-operator and PNT methods to the exact centered prime symbol. It complements the [fixed-observation heat theorem](fixed-observation-prime-heat.md) by identifying the maximal self-adjoint domain, a sufficient vector-convergence domain, and strong resolvent convergence. These are different assertions. No analytic theorem in this note is formalized in Lean.

This construction takes place in the original $L^2(\mathbb R,dv)$, not in the additive mixed completion. Use the unitary Fourier transform
$\widehat f(\nu)=(2\pi)^{-1/2}\int e^{-iv\nu}f(v)dv$.
For $E_hf(v)=f(v+h)$, the Fourier symbol is $e^{i\nu h}$. Retain the complete local operators
$$
 L_p=\frac2p I+p^{-3/2}(E_{\log p}+E_{-\log p})
 -(1-p^{-1})\sum_{j\ge2}p^{-j/2}
                  (E_{j\log p}+E_{-j\log p}).
$$
Their infinite depth sums converge in operator norm. Set
$$
 C_P=\sum_{p\le P}L_p-2\left(\sum_{p\le P}\frac1p\right)I.
\tag{1}
$$
Each $C_P$ is a bounded self-adjoint Fourier multiplier. No growing-prime convergence is assumed in defining it.

## 1. Separate the only conditionally summable prime term

The exact real even symbol is
$$
 c_P(\nu)=2\sum_{p\le P}p^{-3/2}\cos(\nu\log p)
 -2\sum_{p\le P}(1-p^{-1})\sum_{j\ge2}p^{-j/2}
                                 \cos(j\nu\log p).
\tag{2}
$$
Isolating the depth-two leading coefficient gives
$$
 \boxed{c_P(\nu)=-2\sum_{p\le P}\frac{\cos(2\nu\log p)}p+R_P(\nu),}
\tag{3}
$$
where
$$
 R_P(\nu)=2\sum_{p\le P}\left[
 p^{-3/2}\cos(\nu\log p)+p^{-2}\cos(2\nu\log p)
 -(1-p^{-1})\sum_{j\ge3}p^{-j/2}\cos(j\nu\log p)\right].
\tag{4}
$$
For every fixed derivative order $m\ge0$, the absolute derivative sum is bounded by a constant times
$\sum_p p^{-3/2}(\log p)^m$, which converges. For the depth sum use $\sum_{j\ge3}j^mp^{-j/2}\le C_mp^{-3/2}$, uniformly over primes. Consequently $R_P\to R$ uniformly with every fixed derivative on the entire real axis; $R$ and all of its fixed derivatives are bounded.

At zero there is an exact additional cancellation. With $r=p^{-1/2}$, the summand of $R_P(0)/2$ is
$r^3+r^4-(1-r^2)r^3/(1-r)=0$. Thus
$$
 R_P(0)=R(0)=0,\qquad c_P(0)=-2\sum_{p\le P}p^{-1}.
\tag{5}
$$
The latter diverges to negative infinity. The single frequency zero is null for $L^2$ multiplication; its neighborhood will determine a logarithmic domain condition.

## 2. An actual PNT proof of the boundary prime sum

Use the unconditional estimate
$$
 \vartheta(x)=x+E_\vartheta(x),\qquad
 |E_\vartheta(x)|\le Cxe^{-c\sqrt{\log x}},\quad x\ge2.
\tag{6}
$$
A precise primary source is Trudgian, *Updating the error term in the prime number theorem*, [Theorem 1, printed page 3](https://arxiv.org/pdf/1401.2689). Its explicit logarithmic prefactor is absorbed by decreasing $c>0$, and its initial finite interval is absorbed into $C$.

For $\tau\in\mathbb R\setminus\{0\}$, write
$Q_P(\tau)=\sum_{p\le P}p^{-1-i\tau}$. For $P>Y\ge e^2$, exact Stieltjes integration on $(Y,P]$ gives
$$
 \begin{aligned}
 Q_P(\tau)-Q_Y(\tau)
 ={}&\int_Y^P\frac{x^{-1-i\tau}}{\log x}dx
 +\left[\frac{E_\vartheta(x)x^{-1-i\tau}}{\log x}\right]_Y^P\\
 &-\int_Y^P E_\vartheta(x)
       \,d\left(\frac{x^{-1-i\tau}}{\log x}\right).
 \end{aligned}
\tag{7}
$$
Both endpoint values of $\vartheta$ are right-continuous, so the sum includes precisely the primes in $(Y,P]$, also when an endpoint is itself prime.

Put $L=\log Y$. The continuous integral is $\int_L^{\log P}e^{-i\tau u}du/u$. Integration by parts gives an absolute bound $3/(|\tau|L)$, uniform in the upper endpoint. The derivative in the error integral has absolute value at most
$$
 x^{-2}\left(\frac{1+|\tau|}{\log x}+\frac1{\log^2x}\right).
$$
Using (6) and $u=\sqrt{\log x}$ therefore gives the quantitative bound
$$
 \boxed{|Q_P(\tau)-Q_Y(\tau)|
 \le\frac3{|\tau|\log Y}
 +C(1+|\tau|)\frac{e^{-c\sqrt{\log Y}}}{\sqrt{\log Y}}.}
\tag{8}
$$
The error part in (7) converges absolutely as $P\to\infty$, while the continuous part converges by oscillation. Thus $Q(\tau)=\lim_PQ_P(\tau)$ exists for every $\tau\ne0$, locally uniformly away from zero. Its convergence is not absolute.

The same proof, replacing $x^{-1-i\tau}$ by $x^{-\sigma-i\tau}$, is uniform for $1\le\sigma\le2$ and $\tau$ in any compact set separated from zero. In the continuous integral the denominator after integration by parts is $\sigma-1+i\tau$, whose modulus is at least $|\tau|$. The error estimate is unchanged up to a fixed constant. Hence the boundary prime sum is also the Abel limit from $\sigma>1$.

## 3. Identify the zeta term only after taking that justified limit

For $\Re s>1$, the absolutely convergent Euler product gives
$$
 \log\zeta(s)=\sum_p p^{-s}+H(s),\qquad
 H(s)=\sum_p\sum_{k\ge2}\frac{p^{-ks}}k.
\tag{9}
$$
Here the logarithm is the Euler-product branch. The function $H$ is holomorphic on $\Re s>1/2$. On $s=1+i\tau$, its value and every fixed $\tau$-derivative are bounded by absolutely convergent prime-power sums, uniformly in $\tau$.

The usual Euler product and analytic continuation used in (9) are stated in [DLMF Section 25.2](https://dlmf.nist.gov/25.2). The boundary passage itself is supplied by (7)–(8), not by an assertion of absolute convergence at $\Re s=1$. Letting $\sigma\downarrow1$ in the exponential of (9) gives
$$
 \zeta(1+i\tau)=\exp(Q(\tau)+H(1+i\tau)),\qquad \tau\ne0.
$$
In particular this limit is nonzero. Taking real parts gives the branch-independent identity
$\Re Q(\tau)=\log|\zeta(1+i\tau)|-\Re H(1+i\tau)$.

Combining with (3) proves the centered symbol limit
$$
 \boxed{c_\infty(\nu)=\lim_{P\to\infty}c_P(\nu)
 =-2\log|\zeta(1+2i\nu)|+B(\nu),\qquad \nu\ne0,}
\tag{10}
$$
where
$$
 B(\nu)=R(\nu)+2\Re H(1+2i\nu).
$$
The remainder $B$ is real, even, smooth, bounded, and has bounded derivatives of every fixed order. The symbol $c_\infty$ is smooth away from zero. One must not obtain its derivatives by differentiating the conditional prime series term by term: those differentiated series need not converge ordinarily.

The Laurent expansion at the pole, also in [DLMF Section 25.2](https://dlmf.nist.gov/25.2), is $\zeta(1+z)=z^{-1}+\gamma_E+O(z)$. Since the Laurent coefficients are real, $\log|\zeta(1+i\tau)|=-\log|\tau|+O(\tau^2)$. Using (5) and even smoothness of $B$, the precise local expansion is
$$
 \boxed{c_\infty(\nu)=2\log|2\nu|+b_0+O(\nu^2),\qquad
 b_0=2H(1)
 =2\sum_p\left[-\log(1-p^{-1})-p^{-1}\right].}
\tag{11}
$$
The constant is finite and positive. This logarithmic singularity is the contribution of the actual pole at one, not a hypothesis about critical zeros.

## 4. A uniform envelope, including large Mellin frequency

The same PNT argument gives sufficient growth control without importing a separate bound for the reciprocal of zeta. Chebyshev's estimate and partial summation imply
$$
 \sum_{p\le Y}\frac1p\le C(1+\log\log Y),\qquad Y\ge e^2.
$$
For $\tau\ne0$, choose
$$
 \log Y=\max\{2,|\tau|^{-1},K\log^2(3+|\tau|)\},
$$
where the fixed $K$ is large enough in terms of $c$ in (6). If $P\le Y$, the harmonic-prime bound controls the sum directly. If $P>Y$, apply (8) to the remaining tail. Its first term is bounded because $|\tau|\log Y\ge1$; its second is bounded because $K$ was chosen large enough. Thus
$$
 \sup_P|Q_P(\tau)|
 \le C\left[1+\log_+\frac1{|\tau|}+\log\log(3+|\tau|)\right].
$$
Together with the uniform bound on $R_P$, this proves
$$
 \boxed{\sup_P|c_P(\nu)|+|c_\infty(\nu)|
 \le C\Omega(\nu),\quad
 \Omega(\nu)=1+\log_+\frac1{|\nu|}
                    +\log\log(3+|\nu|),\qquad \nu\ne0.}
\tag{12}
$$
In particular the growth at infinity is at most $O(\log\log|\nu|)$. The estimate is uniform in the actual prime cutoff, but is not a bounded multiplier estimate near frequency zero.

## 5. The exact maximal self-adjoint operator

Assign any finite value to $c_\infty(0)$; it makes no difference to an $L^2$ multiplier. Define
$$
 \boxed{\begin{aligned}
 \mathcal D(C_\infty)
 &=\{f\in L^2(\mathbb R,dv):
             c_\infty\widehat f\in L^2(\mathbb R,d\nu)\},\\
 \widehat{C_\infty f}(\nu)&=c_\infty(\nu)\widehat f(\nu).
 \end{aligned}}
\tag{13}
$$
This is the maximal multiplication domain. The operator is densely defined, closed, and self-adjoint because its symbol is real and measurable, finite almost everywhere. One can verify self-adjointness directly: for nonreal $z$, multiplication by $(c_\infty-z)^{-1}$ is bounded, and multiplication by $c_\infty/(c_\infty-z)$ is bounded, so it maps all $L^2$ onto the domain and inverts $C_\infty-z$. The inverse Fourier transforms of $C_c^\infty(\mathbb R\setminus\{0\})$ form a graph core, by first cutting off the frequency variable near zero and infinity and then approximating on the remaining compact sets.

By (11), the exact local domain requirement near zero is
$$
 \int_{|\nu|<\varepsilon}|\log|\nu||^2
                      |\widehat f(\nu)|^2d\nu<\infty.
\tag{14}
$$
There is no imposed pointwise value or vanishing condition at $\nu=0$. At infinity the exact requirement remains (13); replacing it by a logarithmic envelope would generally give only a sufficient condition. A useful sufficient subdomain is
$$
 \mathcal D_\Omega=\{f:\Omega\widehat f\in L^2\}
 \subset\mathcal D(C_\infty),
\tag{15}
$$
which includes every Schwartz function.

The finite operators converge to this realization in strong resolvent sense. Indeed, for nonreal $z$, their resolvent symbols converge almost everywhere to $(c_\infty-z)^{-1}$ and are bounded by $|\Im z|^{-1}$; dominated convergence proves the assertion. On the sufficient domain (15), the stronger vector statement also follows from (12):
$$
 \boxed{C_Pf\longrightarrow C_\infty f\quad\text{in }L^2,
                  \qquad f\in\mathcal D_\Omega.}
\tag{16}
$$
No claim of vector convergence on the entire maximal domain is obtained just from this envelope. Nor does strong resolvent convergence imply a bounded infinite-prime operator on all $L^2$; (11) already makes the limit unbounded below.

## 6. The actual Cauchy birth vector is in the domain

The negative-output birth vector from the actual first successor is
$$
 h_0(v)=-e^{v/2}1_{v<0},\qquad
 \widehat h_0(\nu)=-\frac1{\sqrt{2\pi}(1/2-i\nu)}.
\tag{17}
$$
Its squared norm is one. Near zero its Fourier transform is bounded, while $\log^2|\nu|$ is integrable. At infinity its squared modulus is $O(\nu^{-2})$, which remains integrable after multiplication by $\log^2\log(3+|\nu|)$. Therefore
$$
 h_0\in\mathcal D_\Omega\subset\mathcal D(C_\infty),\qquad
 C_Ph_0\longrightarrow C_\infty h_0\quad\text{in original }L^2(dv).
\tag{18}
$$
The same argument handles any fixed exponentially decaying half-line vector with positive decay parameter, including its physical translates and modulations: its Fourier transform is a fixed shifted Cauchy profile.

The scalar centering in (1), the conditionally convergent depth-two prime sum, and every remaining proper power are all retained. This constructs an unbounded self-adjoint centered operator on its explicit original-space domain and admits the actual birth vector. It does not assert that the old prime operators are unitary in the new mixed metric, perform the actual-source interchange owned by the separate argument, or settle the remaining RH comparison.
