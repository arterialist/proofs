# Shifted Fourier correlations and a density criterion

The location of the hyperbolic factor in a correlation kernel determines which complex Fourier quantity it represents. This note gives the exact identities, a counterexample to the kernel displayed in Dimitrov–Xu's [arXiv:1606.05011v1, Theorem 3.2](https://arxiv.org/pdf/1606.05011v1), and a corrected density criterion. The counterexample concerns that general theorem. It does not refute RH or decide the specialized assertion about the Riemann xi function. No originality or Lean formalization claim is made.

## Exact identities

Let $K$ be a real, even, strictly positive Schwartz function such that

$$
\int_{\mathbb R}(1+u^2)e^{b|u|}K(u)\,du<\infty
\qquad\text{for every }b>0.
$$

Use the convention

$$F(z)=\int_{\mathbb R}K(u)e^{-izu}\,du.$$

For real $y$, define

$$
\begin{aligned}
C_y(t)&=\cosh(yt)\int_{\mathbb R}(t-2s)^2K(t-s)K(s)\,ds,\\
L_y(t)&=\int_{\mathbb R}(t-2s)^2\cosh\bigl(y(t-2s)\bigr)K(t-s)K(s)\,ds,\\
D_y(t)&=\frac12\int_{\mathbb R}a\sinh(ya)
 K((a+t)/2)K((a-t)/2)\,da.
\end{aligned}
$$

All three kernels belong to $L^1(\mathbb R)$. Their transforms satisfy

$$
\boxed{\widehat C_y(x)=2\operatorname{Re}\bigl((F')^2-FF''\bigr)(x+iy),}
\tag{1}
$$

$$
\boxed{\widehat D_y(x)=\partial_y|F(x+iy)|^2,\qquad
\widehat L_y(x)=\partial_y^2|F(x+iy)|^2.}
\tag{2}
$$

In particular,

$$
\widehat L_y(x)=2\left(|F'(x+iy)|^2-
\operatorname{Re}\bigl(F(x+iy)\overline{F''(x+iy)}\bigr)\right),
\qquad \partial_yD_y=L_y.
\tag{3}
$$

To prove (1), set $u=t-s$, $v=s$. The transform of the integral without $\cosh(yt)$ is

$$
\iint(u-v)^2K(u)K(v)e^{-ix(u+v)}\,du\,dv
=2\bigl((F'(x))^2-F(x)F''(x)\bigr).
$$

Multiplication by $\cosh(yt)$ averages this entire function at $x+iy$ and $x-iy$, proving (1). For (2), write

$$
|F(x+iy)|^2=\iint K(u)K(v)e^{-ix(u-v)}e^{y(u+v)}\,du\,dv.
$$

Set $a=u+v$, $t=u-v$, whose Jacobian is $1/2$. Evenness of $K$ makes the product even in $a$. Differentiating once gives $D_y$; differentiating twice and then substituting $a=t-2s$ gives $L_y$. The exponential moment assumption justifies Fubini and differentiation.

The distinction is also visible before taking a Wronskian. If $\psi(x,y)=\operatorname{Im}F(x+iy)$, then

$$
\widehat{\sinh(y\,\cdot)K}(x)=i\psi(x,y).
\tag{4}
$$

Dimitrov–Xu's Lemma 3.3 identifies these two functions without the factor $i$. A quadratic Wronskian changes sign under multiplication by $i$. Thus the convexity calculation requires the difference of the correlations of $\cosh(y\,\cdot)K$ and $\sinh(y\,\cdot)K$, which places $\cosh(y(t-2s))$ inside the integral. The same outside-$\cosh$ formula appears in the [author's published offprint](https://www.researchgate.net/publication/386702813_Wronskians_of_Fourier_and_Laplace_Transforms), Theorem 3.2 and Lemma 3.3, printed pages 4119–4120.

## A strictly positive analytic counterexample

Fix $a>0$ and put

$$
k_a(t)=e^{-a\cosh t},\qquad K=k_a*k_a,\qquad
G(z)=\widehat{k_a}(z)=2\mathrm K_{iz}(a),\qquad F(z)=G(z)^2,
\tag{5}
$$

where $\mathrm K_\nu$ is the modified Bessel function. Its [integral representation](https://dlmf.nist.gov/10.32.E9) gives the transform identity and

$$K(t)=2\mathrm K_0\bigl(2a\cosh(t/2)\bigr).$$

The kernel $K$ is strictly positive, even, real analytic and Schwartz, with all exponential moments. These properties also follow from its convolution representation; real analyticity follows by extending the integrand to a sufficiently small complex strip and using locally uniform integrable bounds.

The function $G$ has only simple real zeros. This is a known result on zeros with respect to order of the modified Bessel function; see [Bagirova–Khanmamedov](https://www.mathnet.ru/eng/zvmmf11078). The following argument records the needed hypotheses. If $G(z)=0$, the function

$$u(x)=\mathrm K_{iz}(ae^x),\qquad x\ge0,$$

is a nonzero square-integrable solution of

$$-u''+a^2e^{2x}u=z^2u,\qquad u(0)=0.$$

The Bessel differential equation gives this identity, and its large-argument decay eliminates the boundary term at infinity. Integration against $\overline u$ yields

$$
z^2=\frac{\int_0^\infty(|u'|^2+a^2e^{2x}|u|^2)\,dx}
{\int_0^\infty|u|^2\,dx}>a^2.
$$

Hence $z$ is real and nonzero. This exponential-potential correspondence is described in [Krynytskyi–Rovenchak, §3](https://sigma-journal.com/2021/057/sigma21-057.pdf). To check simplicity, write $\lambda=z^2$ and differentiate the decaying solution in $\lambda$ at an eigenvalue. Green's identity gives

$$\int_0^\infty u(x)^2\,dx=-u'(0)\,\partial_\lambda u(0).$$

Since $u'(0)\ne0$, the derivative $\partial_\lambda u(0)$ is nonzero. Since $z\ne0$, the zero of $G$ is simple as a zero in $z$ as well.

The defining integral bounds $\max_{|z|\le R}|G(z)|$ by a constant multiple of $(2/a)^R\Gamma(R)$ for large $R$. Thus $G$ has order at most one. It is even, $G(0)>0$, and $G(x)\to0$ on the real axis. Hadamard factorization shows it has infinitely many zeros: otherwise $G=e^{Az+B}P$; evenness forces $A=0$, and a nonzero polynomial cannot tend to zero along the real axis. Pairing the real zeros gives

$$
F(z)=F(0)\prod_{j\ge1}\left(1-\frac{z^2}{r_j^2}\right)^2,
\qquad r_j>0,\quad\sum_jr_j^{-2}<\infty.
\tag{6}
$$

This meets the Schwartz, horizontal-strip and paired-product hypotheses of the cited Theorem 3.2 for every strip half-width $\alpha>0$. It is a Laguerre–Pólya function with double real zeros.

Choose a positive zero $r$ of $G$. Then

$$F(r+w)=c w^2+O(w^3),\qquad c=G'(r)^2>0.$$

Equation (1) therefore implies

$$\widehat C_y(r)=-4c^2y^2+O(y^4)<0$$

for all sufficiently small nonzero real $y$. In contrast, $\widehat C_y(0)=\int C_y>0$. Its real continuous Fourier transform consequently vanishes at some real $\xi$ between $0$ and $r$.

The nonzero bounded functional

$$f\longmapsto\int_{\mathbb R}f(t)e^{-i\xi t}\,dt$$

annihilates every translate of $C_y$. Their span is not dense in $L^1(\mathbb R)$. This disproves the general necessity assertion with the printed kernel, without weakening its positivity, decay, genus or strip hypotheses.

## The repaired criterion

**Theorem.** Suppose $K$ satisfies the assumptions above, $F$ has order at most one, and every zero of $F$ lies in $|\operatorname{Im}z|<\alpha$, where $\alpha>0$. Then all zeros of $F$ are real if and only if the translates of $L_y$ span a dense subspace of $L^1(\mathbb R)$ for every $0<y<\alpha$. No simplicity assumption is needed.

**Proof.** Suppose first that all zeros $r_j$ are real, listing both signs and counting multiplicity. The order and evenness assumptions give the paired canonical product. For fixed $x$ and $y>0$, put $h(y)=|F(x+iy)|^2$ and $a_j=(x-r_j)^2+y^2$. Logarithmic differentiation gives

$$
h''(y)=h(y)\left(2\sum_j\frac1{a_j}
+8y^2\sum_{i<j}\frac1{a_i a_j}\right)>0.
\tag{7}
$$

The sums converge locally uniformly for $y>0$. Strictness follows because there is at least one zero, by the same Hadamard argument used above. Thus $\widehat L_y$ never vanishes. Wiener's $L^1$ Tauberian theorem gives density.

Conversely, density implies that $\widehat L_y$ has no real zeros. It is real and continuous, and $\widehat L_y(0)=\int L_y>0$, so it is positive everywhere. For every fixed $x$, equations (2) and (3) give $h''(y)>0$ on $(0,\alpha)$. Real symmetry gives $h'(0)=0$, whence $h(y)>h(0)\ge0$ there. There are no zeros in the upper half-strip. Conjugation and the assumed zero strip exclude every nonreal zero. $\square$

For the usual normalization $\Xi(z)=\xi(1/2+iz)=\widehat\Phi(z)$, the hypotheses hold with $\alpha=1/2$. The corrected $L_y$ criterion therefore applies to the full Riemann kernel, including possible multiple zeros. Establishing its Fourier positivity remains the substantive condition. Although $L_y(t)\ge0$ and $D_y(t)\ge0$ for $y>0$, those pointwise inequalities do not imply positivity of their Fourier transforms.

## Mathematical use and precedent

The result separates an analytic Wronskian from the vertical derivatives of a squared modulus. It prevents replacing the latter by a different positive spatial kernel. The corrected criterion is an application of classical Jensen convexity and Wiener density, with the identities and the counterexample proved explicitly above. Its relation to earlier formulations carries no priority claim.

Dimitrov–Xu is published as [*Wronskians of Fourier and Laplace transforms*, Transactions of the AMS 372 (2019), 4107–4125](https://doi.org/10.1090/tran/7809). Their Theorem A states the Jensen convexity criterion, and Theorem B states the Wiener theorem used here. The Bessel zero theorem is [Bagirova–Khanmamedov, *On zeros of the modified Bessel function of the second kind*, Computational Mathematics and Mathematical Physics 60 (2020), 817–820](https://doi.org/10.1134/S0965542520050048). The counterexample to their general kernel assertion supplies no conclusion about the truth or falsity of RH.
