# Parity of the compact Weil ground state: one certificate and a signed identity

[Zhu's compact-window study, Theorem 6.2](https://arxiv.org/html/2608.24827v2)
certifies a simple even ground state at one scale. The numerical values
reported there at larger scales do not have the same status. This note
checks the normalization against the complete Weil form and gives an
exact parity comparison that explains why a direct form-order argument
does not extend the certificate. It proves no new positive window.

## The certified scale

Write $a=\log\lambda$. At $a=0.8$, one has
$\lambda^2=e^{1.6}\in(4,5)$, so the admitted prime powers are
$2,3,4$. In the normalization of the real Weil quadratic form,
Zhu's Theorem 6.2 states

\[
8.9\cdot10^{-18}\le E_{1}^{\rm even}
 \le2.523\cdot10^{-16},\qquad
E_{2}^{\rm even}\ge2.085\cdot10^{-12},
\]
\[
8.206\cdot10^{-15}\le E_{1}^{\rm odd}
 \le2.347\cdot10^{-14}.                                      \tag{1}
\]

Since the odd upper bound is below the second-even lower bound, the
second eigenvalue of the full operator is the first odd eigenvalue.
The certified full spectral gap therefore obeys

\[
E_1-E_0=E_{1}^{\rm odd}-E_{1}^{\rm even}
 \ge 8.206\cdot10^{-15}-2.523\cdot10^{-16}
 =7.9537\cdot10^{-15}.                                    \tag{2}
\]

This uses Zhu's reported interval arithmetic and finite-matrix
verification. I have not independently rerun its archived verifier.
The claim is a fixed-scale result, not the all-scale hypothesis in
[Connes, Section 6.6](https://arxiv.org/html/2602.04022).

Here is the normalization check. For real $f$ supported in $(-a,a)$,
put $F(t)=\int f(x)e^{itx}\,dx$, $d_n=\log n$,
$w_n=\Lambda(n)/\sqrt n$, and
$m(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi$. The
[Connes--Consani complete form, equations (2.6)--(2.12)](https://arxiv.org/html/2106.01715)
becomes

\[
q_a(f)=2M_+(f)M_-(f)
 +\frac1{2\pi}\int_{\mathbb R}m(t)|F(t)|^2dt
 -2\sum_{d_n<2a}w_n\int_{\mathbb R}f(x+d_n)f(x)\,dx,
\quad M_\pm(f)=\int_{-a}^{a}e^{\pm x/2}f(x)\,dx.             \tag{3}
\]

Zhu's symbol is $m(t)-2\sum_{d_n<2a}w_n\cos(td_n)$.
Plancherel changes its cosine integral into the last term of (3),
while its pole term is $2M_+M_-$. Thus (1) compares the same full
operator, including both poles, the gamma factor, and every admitted
prime power. The endpoint convention at $d_n=2a$ has no effect because
the translation overlap then has measure zero.

## What is known at the next primes

At $a=1$, the admitted prime powers are $2,3,4,5,7$.
Zhu's Table 1 gives reference values from a converged exact assembly,
but explicitly calls them **not certificates**:

\[
E_{1}^{\rm even}\approx5.88\cdot10^{-30},\qquad
E_{1}^{\rm odd}\approx1.49\cdot10^{-26},\qquad
E_{2}^{\rm even}\approx2.18\cdot10^{-23}.                  \tag{4}
\]

Those values suggest the same parity order, but no rigorous odd lower
bound at $a=1$ follows from them. Zhu also retracts an earlier
support-$2.38$ positive certificate in Section 7; its revised matrix
there is exploratory.

The next threshold after $a=0.8$ is
$a_5=\tfrac12\log5=0.804718956\ldots$. In Zhu's one-stroke method the
prime-comb mass and mandatory envelope frequency are

\[
A_a=2\sum_{d_n<2a}\frac{\Lambda(n)}{\sqrt n},
\qquad T_1(a)=2\pi e^{A_a}.                                \tag{5}
\]

Immediately before and after $a_5$, the exact masses are
$A_-=2.941973525\ldots$ and
$A_+=A_-+2\log5/\sqrt5=4.381498556\ldots$. Hence
$T_1$ jumps from $119.0865\ldots$ to $502.3894\ldots$.
This explains why simply reusing the $200$-mode certificate at
$a=0.8$ does not certify a point after the $n=5$ threshold. It says
nothing against a different method.

## Exact half-window parity difference

For real $g\in C_c^\infty(0,a)$, define two unitary parity copies
on $(-a,a)$ by

\[
f_e(x)=2^{-1/2}g(|x|),\qquad
f_o(x)=2^{-1/2}\operatorname{sgn}(x)g(|x|).
\]

They have the same $L^2$ norm. The off-diagonal archimedean kernel in
(3) is $-r(s)$ for $s>0$, where
$r(s)=e^{-s/2}/(1-e^{-2s})$; the pole contributes
$2\cosh(s/2)$. Splitting (3) into positive-positive and
positive-negative pairs gives the exact identity

\[
\begin{split}
q_a(f_e)-q_a(f_o)
={}&2\int_0^a\!\int_0^a
 g(x)g(y)K(x+y)\,dx\,dy\\
 &-2\sum_{d_n<2a}w_n
   \int_0^a g(x)g(d_n-x)\,dx,\\
K(s)={}&2\cosh(s/2)-\frac{e^{-s/2}}{1-e^{-2s}}.
\end{split}                                                   \tag{6}
\]

The zero extension of $g$ is understood in the last integral.
For example, the pole part of (6) is
$4(C^2+S^2)$, where
$C=\int_0^ag(x)\cosh(x/2)dx$ and
$S=\int_0^ag(x)\sinh(x/2)dx$; direct evaluation gives pole energies
$4C^2$ and $-4S^2$ in the two sectors. Each reflected prime edge has
the negative coefficient shown in (6).

The difference takes both signs for every
$a>\tfrac12\log(4/3)$, even if no prime is yet admitted. Exact
arithmetic gives

\[
K(\log(4/3))=\frac1{14\sqrt3}>0,\qquad
K(\log(6/5))=-\frac{59}{11\sqrt{30}}<0.                  \tag{7}
\]

Choose a nonnegative smooth bump $g$ narrowly centered at
$\tfrac12\log(4/3)$ or $\tfrac12\log(6/5)$. In either case all sums
$x+y$ in its support are below $\log2$, so the prime term in (6)
vanishes at every window size. Continuity of $K$ makes the first bump
give $q_a(f_e)-q_a(f_o)>0$ and the second give a negative difference.
Thus neither parity sector dominates the other as a quadratic form
under this same-half identification. Formula (6) does not compare
their lowest eigenvalues: those minima use different profiles.

At $a=0.8$, (1) resolves that comparison by a full spectral
certificate. Beyond the $n=5$ threshold, (4) is numerical evidence,
and a new odd-sector lower bound plus an even trial upper bound would
be required to certify the order. No RH conclusion follows from the
finite gap in (2).
