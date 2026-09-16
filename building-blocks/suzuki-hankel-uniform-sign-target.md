# A quantitative sign target for Suzuki's arithmetic Hankel kernel

This note records an **unproved inequality** in the arithmetic kernel of [Suzuki's de Branges construction](https://arxiv.org/html/1204.1827v2). The functional equation fixes an operator boundary phase; the proposed step is a concrete, uniform arithmetic lower bound. The finite checks do not establish the inequality or RH.

## Kernel and target

For \(\omega>0\), put
\[
\Theta_\omega(z)
 =\frac{\xi(\frac12-\omega-iz)}{\xi(\frac12+\omega-iz)},
\qquad
c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}).
\tag{1}
\]
The functional equation and real symmetry give
\(\Theta_\omega(z)\Theta_\omega(-z)=1\) and
\(|\Theta_\omega(u)|=1\) on the real axis. Suzuki's explicit arithmetic kernel is
\[
h_\omega^{\langle1\rangle}(x)
 =\frac1x\sum_{n\le x}c_\omega(n)
       g_\omega^{\langle1\rangle}(n/x),
\qquad
g_\omega^{\langle1\rangle}(t)
 =\int_t^1\sqrt{\frac yt}\,g_\omega(y)\frac{dy}{y}
\quad(0<t<1),
\tag{2}
\]
where \(g_\omega\) is the explicit gamma/incomplete-beta function in [Suzuki, equations (2.2) and (A.1)--(A.2)](https://arxiv.org/html/1204.1827v2). We use \(g_\omega^{\langle1\rangle}(1)=0\). The unsmoothed kernel \(h_\omega\) gives the Hankel operator \((H_\omega f)(x)=\int_0^\infty h_\omega(xy)f(y)\,dy\). When \(\Theta_\omega\) is inner, Suzuki's model-space identity makes the **complementary** profile \(x^{-1/2}-h_\omega^{\langle1\rangle}(x)\) the inverse Mellin image of the reproducing kernel at zero, up to his factor \(1/(2\pi)\) [Theorem A.1(1)](https://arxiv.org/html/1204.1827v2).

The falsifiable target is the **uniform half bound**
\[
\boxed{\quad
\sqrt{x}\,h_\omega^{\langle1\rangle}(x)\ge\frac12
\quad\text{for every }0<\omega\le\frac12\text{ and }x\ge2.
\quad}
\tag{T}
\]
It is a proposed pointwise inequality for the actual Jordan-totient coefficients and the completed-zeta gamma kernel, with one constant and one start point independent of \(\omega\). No proof is known here.

## Exact implication and comparison

The functional equation makes boundary multiplication by \(\Theta_\omega\) unitary on \(L^2(\mathbb R)\), since \(|\Theta_\omega(u)|=1\) almost everywhere. The difficult operator condition is preservation of the upper-half-plane Hardy space: \(\Theta_\omega H^2\subset H^2\). When this holds, \(H^2\ominus\Theta_\omega H^2\) is a Hilbert model space with positive reproducing kernel
\[
K_\omega(z,w)=\frac{1-\overline{\Theta_\omega(z)}\Theta_\omega(w)}
 {2\pi i(\bar z-w)}.
\tag{3}
\]
This is Suzuki's operator route from the functional equation to a de Branges space. The boundary phase by itself does not give Hardy-space preservation.

If (T) holds, then \(h_\omega^{\langle1\rangle}\) has one sign eventually for each \(0<\omega\le1/2\). [Suzuki, Theorem A.1(3)](https://arxiv.org/html/1204.1827v2) then makes every corresponding \(\Theta_\omega\) a meromorphic inner function in the upper half-plane. Innerness is unconditional for \(\omega\ge1/2\); [Suzuki, Proposition 1.2](https://arxiv.org/html/1204.1827v2) therefore implies RH. This is only an implication from an unproved premise. A check at a single fixed \(\omega\), such as \(1/4\), does not supply the all-\(\omega\) hypothesis.

The target asks for more than the published innerness criterion: it specifies a positive pointwise margin for all \(x\ge2\), uniformly as \(\omega\downarrow0\). Under RH, Suzuki proves only \(\sqrt{x}h_\omega^{\langle1\rangle}(x)=1+o(1)\) **for each fixed** \(\omega>0\) [Theorem A.1(5)](https://arxiv.org/html/1204.1827v2); that does not give the stated uniform start point or margin. We do not claim that (T) follows from RH.

The sharp published local Weil result is in a different variable. [Zhu's certified theorem](https://arxiv.org/html/2608.24827v2) gives \(Q(f)\ge8.9\cdot10^{-18}\|f\|_2^2\) for all complex tests supported in \([-0.8,0.8]\). It provides no certificate for arbitrary larger windows; at support \([-1,1]\), the paper reports a certified **upper** bound and exploratory eigenvalues, not a positive lower certificate. Proving (T) would imply every-window Weil positivity through RH, but the finite checks below neither improve Zhu's certified window nor transfer a numeric \(x\) into a Weil support radius.

## Finite attempts to falsify the bound

At \(\omega=1/2\), \(c_{1/2}(n)=\varphi(n)/\sqrt n\), and Suzuki's incomplete-beta formula simplifies to
\[
\sqrt{x}h_{1/2}^{\langle1\rangle}(x)
 =2\sum_{n<x}\frac{\varphi(n)}n
 \left[2\sqrt{1-(n/x)^2}+\log(n/x)
 -\log\!\left(1+\sqrt{1-(n/x)^2}\right)\right].
\tag{4}
\]
This finite expression is the direct check at rational \(x\). At \(x=7\), interval evaluation at 50 decimal digits gives
\[
0.74611285168314512500150988640798210548843291559276
 <\sqrt7h_{1/2}^{\langle1\rangle}(7)
 <0.74611285168314512500150988640798210548843291559289.
\tag{5}
\]
Thus the otherwise tempting stronger bound \(\sqrt{x}h\ge3/4\) is **false**, already for the actual arithmetic kernel at \((\omega,x)=(1/2,7)\). The cutoff \(x\ge2\) also matters: the value at \((1/2,1.01)\) is about \(0.2788755\), and \(\sqrt{x}h_{1/2}^{\langle1\rangle}(x)\to0\) as \(x\downarrow1\).

An exploratory double-precision scan of (2) on \(x=2,2.25,\ldots,500\), with \(\omega\) in the table, found these minima:

| \(\omega\) | smallest sampled \(\sqrt{x}h_\omega^{\langle1\rangle}(x)\) | \(x\) |
| ---: | ---: | ---: |
| 0.01 | 0.987702 | 223 |
| 0.05 | 0.949334 | 223 |
| 0.10 | 0.920039 | 97 |
| 0.20 | 0.861105 | 7 |
| 0.25 | 0.834718 | 7 |
| 0.30 | 0.811408 | 7 |
| 0.40 | 0.773458 | 7 |
| 0.45 | 0.758532 | 7 |
| 0.49 | 0.748403 | 7 |
| 0.50 | 0.746113 | 7 |

An independent scan of every integer \(2\le x\le5000\) at \(\omega=1/2\) also attained its minimum at \(x=7\). The [reproducible scan](certificates/suzuki_hankel_uniform_sign_scan.py) contains both calculations and the interval check in (5). These finite samples are attempts to find a counterexample, not a lower certificate over a continuum or an asymptotic range.

The summands in (4) have mixed signs. If \(G(t)\) denotes the bracket, then
\(G'(t)=(1-2t^2)/(t\sqrt{1-t^2})\). Since \(G(t)\to-\infty\) as \(t\downarrow0\) and \(G(1)=0\), its one interior zero is \(0.2884199089\ldots\), with \(G(t)<0\) below it. At \(x=7\), the \(n=1,2\) terms are negative while later terms pay for them. Hence \(c_\omega(n)>0\) alone cannot prove (T); the missing estimate is uniform cancellation in this **specific** arithmetic Hankel kernel. A first analytic step would be a lower bound for the complete finite sum (2) that is uniform in \(x\) and in \(\omega\downarrow0\), retaining its negative small-\(n/x\) part. No such bound is supplied here.
