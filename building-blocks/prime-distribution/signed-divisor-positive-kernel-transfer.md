# Positive-kernel transfer for the full signed divisor correction

Put $\kappa=2\gamma-1>0$ and, for real $x\ge1$, define

$$
M(x)=\sum_{n\le x}\mu(n),\qquad m(x)=\sum_{n\le x}\frac{\mu(n)}n,\qquad
\check m(x)=\sum_{n\le x}\frac{\mu(n)}n\log(x/n),
$$

$$
R(x)=x[1-\check m(x)-\kappa m(x)].
$$

This is an actual complete signed divisor correction. If $\mathcal D(x)=\sum_{n\le x}\tau(n)$ and $\Delta(x)=\mathcal D(x)-x\log x-\kappa x$, then finite Möbius inversion gives

$$
\sum_{d\le x}\mu(d)\Delta(x/d)=R(x)-\{x\}.
$$

Indeed, $\sum_{d\le x}\mu(d)\mathcal D(x/d)=\lfloor x\rfloor$, by grouping each divisor-count coefficient and using $\mu*\tau=1$. At an integer $N$, the sum is exactly $R(N)$. This is the full correction associated with the [variable divisor-block construction](global-divisor-blocks.md), rather than a bound on an individual block.

The kernel identities below are classical Balazard–Daval identities. Their application retains the direct signed Mertens term and transfers slowly varying decay profiles to $R$. Kernel positivity alone gives no sign for $R$.

## Kernel and exact arithmetic transfer

Define, for $t\ge1$,

$$
g(y)=4y(1-y^2),\quad
G(t)=1-\frac1t\sum_{n\le t}g(n/t),\quad
(\mathcal K v)(x)=\int_1^x v(x/t)G(t)\frac{dt}{t}.
$$

Here g is used only on $[0,1]$, and $\int_0^1g=1$. Finite power sums, with $q=\lfloor t\rfloor$, give

$$
G(t)=\left(1-\frac{q(q+1)}{t^2}\right)^2,
\qquad 0\le G(t)\le t^{-2}.
\tag{1}
$$

For the upper bound, $q\le t<q+1$ implies $-t\le t^2-q(q+1)\le t$. The square formula also agrees at integer endpoints. Set

$$
f(x)=M(x)/x,\quad
r(x)=\frac8{3x}-\frac4{x^2}+\frac4{3x^4},\quad
a(x)=\frac2{x^2}-\frac1{x^4}.
$$

The Balazard–Daval identities specialize to

$$
m=(I+\mathcal K)f+r,\qquad \check m-1=\mathcal K m-a.
\tag{2}
$$

For completeness, expand $G$ inside each integral. In $\mathcal Kf$, the constant part is $m-f$ by finite partial summation. The subtracted part is

$$
\frac1x\sum_{nd\le x}\mu(d)\int_n^{x/d}g(n/t)\frac{dt}{t}
=\frac1x\sum_{k\le x}\left(\sum_{d\mid k}\mu(d)\right)
\int_1^{x/k}g(1/u)\frac{du}{u}=r(x).
$$

For $\mathcal Km$, the constant part is $\check m$; its subtracted part is

$$
\sum_{k\le x}\frac1k\left(\sum_{d\mid k}\mu(d)\right)
\int_1^{x/k}g(1/u)\frac{du}{u^2}
=\int_{1/x}^1g(y)\,dy=1-a(x).
$$

These finite rearrangements prove both formulas, including their initial endpoints. Both identities concern the actual Möbius coefficients. Their finite sum–integral interchanges are valid on $[1,x]$; g is bounded there after the change of variables. The boundary terms are $r(x)=x^{-1}\int_{1/x}^1g(y)/y\,dy$ and $a(x)=\int_0^{1/x}g(y)\,dy$. These expressions in particular fix the signs. See [Daval, equations 10 and 55](https://arxiv.org/html/2006.01295).

Substitute (2) into the definition of $R$ before taking absolute values. The result is

$$
R(x)=-\kappa M(x)-x\bigl[(\kappa+1)\mathcal K+\mathcal K^2\bigr]f(x)+E(x),
\quad E(x)=x[a(x)-\kappa r(x)-(\mathcal K r)(x)].
\tag{3}
$$

The direct term $-\kappa M(x)$ is retained. The rest is a signed integral of f, even though G is nonnegative. Thus positivity of G does not assert positivity of this integral or of R.

The constants needed to use (3) follow from elementary integrals. On $[q,q+1]$, put $b=q(q+1)$. Antiderivatives of G and G/t are respectively

$$
t+\frac{2b}{t}-\frac{b^2}{3t^3},\qquad
\log t+\frac{b}{t^2}-\frac{b^2}{4t^4}.
$$

Consequently

$$
\int_q^{q+1}G(t)dt=\frac1{3q(q+1)},\quad
\int_q^{q+1}\frac{G(t)}t dt=
\log\frac{q+1}q-\frac1{2q}-\frac1{2(q+1)}
+\frac1{4q^2}-\frac1{4(q+1)^2}.
$$

Summation and the defining harmonic limit for $\gamma$ yield

$$
\int_1^\infty G(t)dt=\frac13,\qquad
g_1:=\int_1^\infty G(t)\frac{dt}t=\frac34-\gamma.
\tag{4}
$$

For example, the second partial integral up to integer N is $\log N-\sum_{n\le N}1/n+3/4+1/(2N)-1/(4N^2)$. This also checks the constant without analytic continuation. Daval's Remark 1 explicitly corrects the different value printed in Balazard's 2012 version. We use the corrected value. [Daval, Remark 1](https://arxiv.org/html/2006.01295).

As $0\le r(x)\le8/(3x)$ and $0\le a(x)\le2/x^2$, (4) gives

$$
|E(x)|\le\frac2x+\frac{8\kappa}3+\frac89.
\tag{5}
$$

The kernel of $\mathcal K^2$ is the multiplicative convolution
$G_2(t)=\int_1^tG(u)G(t/u)\,du/u$. Finite-interval Fubini is justified by boundedness of f on compact intervals and (1). Thus

$$
W(t):=(\kappa+1)G(t)+G_2(t)\ge0,\quad
W(t)\le[\kappa+1+\log t]t^{-2},\quad
\int_1^\infty W(t)\frac{dt}t=(\kappa+1)g_1+g_1^2.
\tag{6}
$$

The last identity uses Tonelli for nonnegative kernels. All integrals converge under (1). Formula (3), together with (5)–(6), now transfers independently available estimates on M to R without estimating each divisor block separately.

## Transfer without an exponential-constant loss

Let $P(u)>0$ be continuously differentiable for sufficiently large u, suppose

$$
(\log P)'(u)\longrightarrow0,\qquad
\limsup_{u\to\infty}\frac{|f(e^u)|}{P(u)}\le C<\infty.
$$

Here $C\ge0$ and $f$ is still the actual bounded function $M(x)/x$. Set $B_1=(\kappa+g_1)(1+g_1)$. Then

$$
\limsup_{u\to\infty}\frac{|R(e^u)|}{e^uP(u)}
\le C B_1
=C(\gamma-1/4)(7/4-\gamma).
\tag{7}
$$

To prove this, pass to logarithmic time. The kernel of $\mathcal K$ becomes $k(v)=G(e^v)$ for $v\ge0$, with $0\le k(v)\le e^{-2v}$ and mass $g_1$. The kernel of $\mathcal K^2$ is $k*k$, bounded by $v e^{-2v}$ and of mass $g_1^2$.

Fix $\delta>0$ and $0<\eta<2$. Choose U large enough that $|f(e^w)|\le(C+\delta)P(w)$ and $|(\log P)'(w)|\le\eta$ for $w\ge U$. For $0\le v\le u-U$, integration of the latter inequality gives

$$
\frac{P(u-v)}{P(u)}\le e^{\eta v}.
$$

For every fixed v this ratio tends to 1. Therefore dominated convergence, applied to the ratio times k or $k*k$ and the indicator of $v\le u-U$, gives limiting masses $g_1$ and $g_1^2$. The respective integrable dominators are $e^{-(2-\eta)v}$ and $v e^{-(2-\eta)v}$. Multiplying those mass bounds by $C+\delta$ bounds the large-w parts of the two convolutions of f.

On the initial segment $0\le u-v<U$, boundedness of f gives contributions $O_U(e^{-2u})$ and $O_U(u e^{-2u})$ before division by P(u). They vanish after that division: the logarithmic derivative assumption implies $\log P(u)=o(u)$ by integrating $|(\log P)'|\le\eta$ and then letting $\eta\downarrow0$. The same fact makes $E(e^u)/(e^uP(u))\to0$ by (5). In (3), apply these bounds, the given limsup for f, and finally $\delta\downarrow0$. The coefficient is

$$
\kappa+(\kappa+1)g_1+g_1^2
=(\kappa+g_1)(1+g_1)
=(\gamma-1/4)(7/4-\gamma),
$$

which proves (7). This proof does not assume that f/P has a limit or a sign. It supplies an asymptotic transfer, without an explicit new cutoff. The RH-scale profile $P(u)=e^{-(1/2-\varepsilon)u}$ for $0<\varepsilon<1/2$ does not satisfy the logarithmic derivative condition. Equation (7) therefore supplies no transfer at that power scale, and no Mertens input at that scale has been proved here.


The profiles $P(u)=u^{-j}$, $u e^{-c\sqrt u}$, $u e^{-c\sqrt{u\log u}}$, and $u e^{-cu^{3/5}(\log u)^{-1/5}}$, with fixed $c>0$, satisfy the derivative condition on their eventual domains. Whenever an independently proved Mertens estimate supplies the stated limsup hypothesis, the same profile transfers to the actual correction, with constant multiplier $(\gamma-1/4)(7/4-\gamma)$. This is a conditional transfer theorem, not a new bound for $M$.

The exact finite identities and the logarithmic-time dominated-convergence argument are written proofs. No Lean theorem for the integral transfer is asserted. The classical kernel construction is attributed to Balazard; [Daval, Theorem 1 and equation (55)](https://arxiv.org/html/2006.01295) gives the two identities in the form used here. Daval's Remark 1 corrects the kernel mass to $3/4-\gamma$; the finite interval calculation above proves that value directly. The direct term $-\kappa M$ and the signed convolution are both retained.
