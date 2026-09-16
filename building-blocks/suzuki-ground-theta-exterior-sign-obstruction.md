# The theta radical has a sign-changing exterior residual in Suzuki's localized Weil form

This is an unconditional, source-specific obstruction to using the positive theta radical as a pointwise supersolution for the localized operator. It proves no sign for the lowest eigenvalue and does not prove or disprove RH. The normalization of the Weil form and theta radical is the one in [the theta jump-form note](theta-weil-jump-form.md); the localized operator is Suzuki's Friedrichs extension [\(A_a\), equations (1.1), (1.7), and (2.5)](https://arxiv.org/html/2606.09096v1).

## Exterior residual and the exact zero-mode flux

Put \(I_a=(-a,a)\), \(r(t)=e^{-t/2}/(1-e^{-2t})\) for \(t>0\), and \(w_n=\Lambda(n)/\sqrt n\). Let \(\Phi\) be the positive even smooth theta kernel whose Fourier transform is the completed zeta function (with \(\widehat\Phi(i/2)=1/2\)). Its full Weil pairing with every compact test vanishes unconditionally: the Fourier factor \(\widehat\Phi\) vanishes at each zero in the explicit formula. This is a distributional radical identity; no location of the zeros is assumed. Write \(F_a=\mathbf1_{I_a}\Phi\). Its zero extension has bounded variation and hence Fourier transform \(O((1+|\xi|)^{-1})\), so its logarithmic Fourier energy is finite. It belongs to the localized form domain by Suzuki's Fourier formula (2.7) and the boundedness of the prime and pole terms at fixed \(a\).

The archimedean multiplier has the compensated action

\[
 (\mathcal Af)(x)=a_*f(x)+\int_0^\infty r(t)[2f(x)-f(x+t)-f(x-t)]\,dt,
 \quad a_*=\psi(1/4)-\log\pi.
\]

The prime action is \(-\sum_{n\ge2}w_n[f(x+\log n)+f(x-\log n)]\), and the pole action has kernel \(2\cosh((x-y)/2)\). Since the sum of these three actions annihilates \(\Phi\) distributionally, its localized action on \(F_a\), at interior points away from the discrete prime-shift contacts, is precisely the **exterior residual**

\[
\begin{aligned}
 R_a(x):=(A_aF_a)(x)
 ={}&\int_{|y|>a}\bigl[r(|x-y|)-2\cosh((x-y)/2)\bigr]\Phi(y)\,dy\\
 &+\sum_{n\ge2}w_n\bigl[
 \mathbf1_{\{|x+\log n|>a\}}\Phi(x+\log n)
 +\mathbf1_{\{|x-\log n|>a\}}\Phi(x-\log n)\bigr].
\tag{1}
\end{aligned}
\]

The prime series converges locally uniformly away from those contacts because of theta decay. The right side has at most logarithmic growth at the endpoints, and hence is in \(L^2(I_a)\). The weak form identity on compact tests, their density in the form domain, and the representation theorem therefore give \(F_a\in\mathfrak D(A_a)\) with action (1) almost everywhere. If \(v_a\in\mathfrak D(A_a)\) is any hypothetical zero eigenvector, self-adjointness forces the exact ground-mode flux constraint

\[
 \boxed{\int_{-a}^a v_a(x)\,\overline{R_a(x)}\,dx=0.}
\tag{2}
\]

No positivity of \(v_a\) or simplicity is needed for (2).

## A rigorous negative value at the center

Choose \(a=\log(33/16)\), strictly between \(\log2\) and \(\log3\). Evenness of \(\Phi\) makes (1) at \(x=0\) equal

\[
 R_a(0)=2\int_a^\infty [r(t)-2\cosh(t/2)]\Phi(t)\,dt
 +2\sum_{n\ge3}\frac{\Lambda(n)}{\sqrt n}\Phi(\log n).
\tag{3}
\]

Both terms have their actual signs; the sum includes all prime powers. Here is a coarse proof that the first term dominates. For \(t\ge\log2\),

\[
 r(t)\le\tfrac43e^{-t/2},\qquad
 2\cosh(t/2)-r(t)\ge\tfrac23e^{-t/2}.
\tag{4}
\]

From the explicit positive theta series, with \(u=e^t\),

\[
 \Phi(\log u)
 =\sum_{k\ge1}2\pi k^2u^{5/2}(2\pi k^2u^2-3)e^{-\pi k^2u^2}.
\tag{5}
\]

For \(33/16\le u\le17/8\), every summand in (5) is positive and the \(k=1\) summand is \(>630e^{-15}>1.5\cdot10^{-4}\): use \(\pi>3\), \(u^{5/2}>5\), \(2\pi u^2-3>21\), and \(\pi u^2<15\). The final numerical inequality follows from \(e<11/4\) and \((11/4)^{15}<4\cdot10^6\). Also \(e^{-t/2}>2/3\) on this interval and \(\log(34/33)>1/34\). Thus the magnitude of the negative integral in (3) is greater than

\[
 2\cdot\tfrac23\cdot\tfrac23\cdot\tfrac1{34}\cdot1.5\cdot10^{-4}
 > 3.9\cdot10^{-6}.
\tag{6}
\]

For the positive sum, \(\Lambda(n)\le\log n\le n\). The theta series gives, for integers \(n\ge3\),

\[
 \Phi(\log n)
 \le4\pi^2 n^{9/2}e^{-\pi n^2}
 \sum_{k\ge1}k^4e^{-\pi(k^2-1)n^2}
 <80n^{9/2}e^{-3n^2}.
\tag{7}
\]

Indeed the series in (7) is \(<2\), since its \(k\ge2\) tail is bounded by \(\sum_{k\ge2}k^4e^{-27k}\), and \(8\pi^2<80\). For \(n\ge3\), the ratio of successive terms of \(n^5e^{-3n^2}\) is less than \(1/2\). Consequently the positive sum in (3) is less than

\[
 160\sum_{n\ge3}n^5e^{-3n^2}
 <320\cdot3^5e^{-27}<2\cdot10^{-7},
\tag{8}
\]

where the last inequality follows, for example, from \(e^3>20\). Equations (6)–(8) prove **\(R_{\log(33/16)}(0)<-3.7\cdot10^{-6}<0\)** without numerical assumptions. Direct quadrature merely indicates the size: archimedean \(+1.0346210\cdot10^{-4}\), pole \(-2.5398404\cdot10^{-4}\), prime-power tail \(+3.49670\cdot10^{-9}\), giving \(R_a(0)\approx-1.5051844\cdot10^{-4}\).

At the opposite end, as \(x\uparrow a\), the right-exterior archimedean integral in (1) diverges as \((\Phi(a)/2)\log(1/(a-x))+O(1)\), because \(r(t)\sim1/(2t)\). All pole and prime contributions remain bounded there. Thus \(R_a(x)>0\) sufficiently near \(a\), while it is negative at the center. Even if a hypothetical zero ground eigenfunction had one sign, (2) could balance these regions. Truncating the exact positive radical \(\Phi\) therefore supplies no pointwise nonnegative supersolution or no-crossing barrier for \(A_a\).
