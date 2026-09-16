# The actual full-\(F\) high-divisor \(m=2\) fiber is an RH criterion

RH Agent3, 2026-09-16. Independently audited by a separate mathematical worker. **Status:** a written RH-equivalent criterion, not an unconditional estimate or Lean formalization. The hypothesis below is an as-yet-unproved bound on one signed Möbius fiber of the original score. The complete score can cancel this fiber against other quotient rows, so the theorem does not transfer to it by positivity.

Write \(L=\log 2\), \(p_s=e^{-\lambda s}\), and \(\kappa_F=\lim_{x\to\infty}F(x)>0\). The actual continuous factorial ground is positive on \([2,\infty)\), satisfies \(F'(x)=-E(x)/x^2\) off the Chebyshev jumps, and \(E(x)=\psi(x)-x\). All prime powers occur in \(\psi\), and \(F\) is continuous at their atoms. Fix any finite clock \(s\ge0\), so \(p_s>0\). The precise no-jump first-block high-divisor row in the [Type-I payment](factorial-f-ground-type-i-lattice-payment.md), with \(Y=2X\), is
\[
\mathcal T_s(X)=c_s X\sum_{X\le n<2X}
 \frac{\mu(n)\log^2(n/X)}{n^2 F(2n)},
\qquad c_s=\frac{(\log2)p_s^2}{2}>0. \tag{1}
\]
The atom \(n=X\) has zero weight; \(n=2X\) belongs to the next half-open block. Formula (1) retains the actual ground and the exact no-jump factor. No other clock histories enter this one row because \(\log(x/Y)<\log2\) on \([Y,2Y)\).

Using integer \(X\) instead gives the same criterion. Between the finitely many moving endpoints, differentiating \(X\log^2(n/X)\) gives \(\log^2(n/X)-2\log(n/X)=O(1)\), so \(|\mathcal T_s'(X)|\ll_s X^{-1}\). A lower-endpoint crossing has zero amplitude; each upper-endpoint crossing changes (1) by \(O_s(X^{-1})\). Hence \(|\mathcal T_s(X)-\mathcal T_s(\lfloor X\rfloor)|\ll_s X^{-1}\), below the stipulated RH-scale error. We retain real \(X\) for the exact Mellin integral.

**Theorem.** The following are equivalent:

1. RH.
2. For every \(\varepsilon>0\), \(\mathcal T_s(X)=O_{s,\varepsilon}(X^{-1/2+\varepsilon})\) for all real \(X\ge2\).

The equivalence holds for any one fixed \(s\) with \(p_s>0\). Neither assertion is established by this note.

## Exact unilateral Mellin transform and a zero-free multiplier

Put \(b_n=\mu(n)/F(2n)\) and \(A_F(z)=\sum_{n\ge1}b_n n^{-z}\) for \(\Re z>1\). With \(u=\log X\), \(k(t)=t^2e^{-t}{\bf1}_{0\le t<L}\), (1) is
\[
\mathcal T_s(e^u)=c_s\sum_{n\ge1}\frac{b_n}{n}k(\log n-u). \tag{2}
\]
For \(n\ge2\), the whole support \(\log n-L<u\le\log n\) lies in \(u\ge0\); the \(n=1\) support meets \(u\ge0\) only at \(u=0\), where \(k(0)=0\). Thus no unilateral boundary correction is hidden. Absolute convergence for \(\Re z>1\) gives
\[
\int_0^\infty e^{-(z-1)u}\mathcal T_s(e^u)\,du
=c_s C(z)\left(A_F(z)-\frac1{F(2)}\right),\quad
C(z)=\int_0^L t^2e^{(z-2)t}dt
=\int_1^2v^{z-3}\log^2v\,dv. \tag{3}
\]
In particular, the frozen-ground analogue replaces \(A_F\) by \(\kappa_F^{-1}/\zeta\), but (3) itself is for the **actual** \(F(2n)\).

The hypothesis of the theorem is stated for \(X\ge2\), whereas (3) integrates \(X=e^u\ge1\). Formula (1) defines \(\mathcal T_s\) also on the compact interval \(1\le X<2\); it is bounded there because the sum has at most two terms and \(F(2n)>0\). Adding this finite initial interval cannot affect the analytic continuation or any asymptotic bound.

The compact dyadic multiplier \(C\) has **no zeros** on \(1/2\le\Re z\le5/4\), and uniformly in this strip
\[
|C(\sigma+i\tau)|\gg (1+|\tau|)^{-1}. \tag{4}
\]
Here is an elementary proof. Set \(w=(z-2)L=x+iy\), so \(-3L/2\le x\le-3L/4\), or \(1/2<-x< 21/20\). If \(|y|<1\), the imaginary part of the integral in (3) has the strict sign of \(y\), since \(\sin(yt/L)\) keeps that sign for \(0<t<L\); at \(y=0\), \(C>0\). If \(|y|\ge1\), the exact antiderivative gives
\[
C(z)=L^3\frac{e^w(w^2-2w+2)-2}{w^3}. \tag{5}
\]
A zero would require
\[
4=e^{2x}\{y^4+2x(x-2)y^2+(x^2-2x+2)^2\}
\ge e^{2x}P(x),\quad
P(x)=x^4-4x^3+10x^2-12x+5. \tag{6}
\]
But \(Q(x)=e^{2x}P(x)-4\) is strictly increasing on this interval: \(e^{-2x}Q'(x)=2a^4+4a^3+8a^2+4a-2>0\) for \(a=-x>1/2\). At the left endpoint \(x=-3L/2<-1\), \(P(x)>P(-1)=32\) and \(e^{2x}=1/8\), so \(Q(x)>0\), contradicting (6). Finally integration by parts in (3), uniformly in \(\sigma\) in the strip, gives
\(C(\sigma+i\tau)=2^{\sigma-2+i\tau}L^2/(\sigma-2+i\tau)+O(|\tau|^{-2})\). Compactness plus nonvanishing proves (4).

## A hypothetical fiber estimate forces a fixed Möbius power saving

Suppose assertion 2. Its left side in (3) extends holomorphically to \(\Re z>1/2\). Equations (3)--(4) therefore continue \(A_F\) to that half-plane; on \(3/4\le\sigma\le9/8\) they give
\[
A_F(\sigma+i\tau)=O_s(1+|\tau|). \tag{7}
\]
For clarity, the transform is bounded on this closed strip by taking, for example, \(\varepsilon=1/8\) in assertion 2; the subtraction \(1/F(2)\) is harmless. The same quotient formula bounds the entire strip because (4) holds there. There are no poles to cross.

The cubic Riesz mean
\[
S_3(x)=\sum_{n<x}b_n(x-n)^3
=\frac{6}{2\pi i}\int_{(c)}
 \frac{A_F(z)x^{z+3}}{z(z+1)(z+2)(z+3)}\,dz,\qquad 1<c<9/8,
\tag{8}
\]
is absolutely represented by Perron's beta kernel. The polynomial growth (7) and fourth-degree denominator permit shifting to \(\Re z=3/4\), with horizontal integrals tending to zero. Consequently \(S_3(x)\ll_s x^{15/4}\). Let \(h=x^{15/16}\) and take the third forward difference. For \(n\le x\), \(\Delta_h^3(x-n)^3=6h^3\); for \(n\ge x+3h\), it is zero; and the intermediate contribution is bounded by \(6h^3\) per \(n\). Since \(|b_n|\le c_F^{-1}\),
\[
\sum_{n\le x}b_n
=\frac{\Delta_h^3S_3(x)}{6h^3}+O(h+1)
\ll_s x^{15/16}. \tag{9}
\]
The possible equality \(n=x\) contributes at most \(O(1)\). This is a genuine fixed power saving, obtained from the hypothetical smoothed-fiber estimate without assuming RH or a fixed zero-free strip.

Abel summation transfers (9) to the ordinary Mertens sum. Indeed \(\mu(n)=F(2n)b_n\), \(F\) is bounded, and classical PNT gives \(|E(x)|\ll x\exp(-c\sqrt{\log x})\). The exact ground derivative \(F'(x)=-E(x)/x^2\) yields \(|(F(2x))'|\ll x^{-1}\exp(-c\sqrt{\log x})\); hence
\[
M_\mu(x)=\sum_{n\le x}\mu(n)\ll_s x^{15/16}. \tag{10}
\]
This deduction uses only the classical PNT estimate for \(E\), never a claimed RH-scale error.

## Removing the actual-ground perturbation

A standard zero-free-strip consequence of (10), with any arbitrarily small exponent slack, is
\[
M_\mu(x),\ E(x)\ll_{\theta}x^\theta
\quad\text{for every }\theta>15/16. \tag{11}
\]
Indeed \(1/\zeta(z)=z\int_1^\infty M_\mu(x)x^{-z-1}dx\) is holomorphic on \(\Re z>15/16\), so \(\zeta\) has no zero there. For any \(15/16<\theta_0<\theta<1\), use the classical truncated explicit formula for \(\psi\) with height \(T\asymp x^2\), chosen away from zero ordinates. Every zero in the resulting sum has \(\Re\rho\le\theta_0\), and \(\sum_{0<|\Im\rho|\le T}|\Im\rho|^{-1}\ll\log^2T\) by the standard zero count. Thus the zero sum is \(O(x^{\theta_0}\log^2x)\); the truncation and right-continuous endpoint errors are \(O(\log^C x)\) for an absolute \(C\). This yields \(E(x)\ll_\theta x^\theta\) uniformly, including prime-power endpoints. A reference for the truncated formula, zero count, and this zero-free-strip/error implication is Montgomery--Vaughan, *Multiplicative Number Theory I: Classical Theory*, Chapters 12 and 15 (publisher's [contents](https://assets.cambridge.org/97805218/49036/frontmatter/9780521849036_frontmatter.pdf)). Only a fixed exponent \(\theta<1\) is needed here.

For any such \(\theta<1\), the full ground identity gives
\[
\delta(x):=F(x)^{-1}-\kappa_F^{-1}
=O_\theta(x^{\theta-1}),\qquad
\delta'(x)=O_\theta(x^{\theta-2}). \tag{12}
\]
Because \(M_\mu(x)=O(x^\theta)\), partial summation makes the **signed**, not absolutely estimated, perturbation series
\[
R_F(z)=\sum_{n\ge1}\frac{\mu(n)\delta(2n)}{n^z} \tag{13}
\]
holomorphic for \(\Re z>2\theta-1\): the boundary term is \(O(x^{2\theta-1-\sigma})\), and the derivative integral has the same threshold. For \(\Re z>1\), the exact identity is
\[
A_F(z)=\frac1{\kappa_F\zeta(z)}+R_F(z). \tag{14}
\]
Since \(A_F\) already continues to \(\Re z>1/2\), (13)--(14) show that \(1/\zeta\) has no pole in \(\Re z>\max(1/2,2\theta-1)\). There can be no cancellation of an offcritical zero by the actual \(F\) perturbation in that region. Reapplying the fixed-strip prime-number theorem and (12)--(14) iterates the exponent map \(\theta\mapsto 2\theta-1\): starting just above \(15/16\), it passes successively just above \(7/8,3/4,1/2\). Given any \(\beta>1/2\), choose the slack small enough at each finite step to reach \(2\theta-1<\beta\); then no zero has real part \(\beta\). Functional equation symmetry gives RH. This proves assertion 2 \(\Rightarrow\) 1.

Conversely RH implies \(M_\mu(x),E(x)\ll_\varepsilon x^{1/2+\varepsilon}\), so (12) holds with \(\theta=1/2+\varepsilon\). Abel summation in the compact interval \([X,2X)\) bounds the constant-ground part of (1) by \(O_{s,\varepsilon}(X^{-1/2+\varepsilon})\). The actual-ground correction is absolutely bounded by \(\sup_{[2X,4X]}|\delta|\,X\sum_{X\le n<2X}n^{-2}=O_\varepsilon(X^{-1/2+\varepsilon})\). Thus 1 \(\Rightarrow\) 2.

The single \(m=2\) row is therefore not weakened by a dyadic multiplier zero. Its actual-ground factor initially has only PNT-quality convergence; the cubic Riesz step is what supplies the fixed-power bootstrap needed to remove it. The result does **not** estimate (1), the complete high-divisor sum, or the complete Picone score. A separate signed cancellation among quotient rows could make the full score smaller without making this individual RH-equivalent fiber small.
