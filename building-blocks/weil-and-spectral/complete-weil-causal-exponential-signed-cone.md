# A signed actual-prime residual on a causal exponential cone

**Status:** independently audited written analytic proof (17 September 2026). The form-domain
and asymptotic claims below are not Lean formalized. This signs a concrete
family of tests, not the complete Weil form, and does not prove RH.

The [complete successor-cell identity](compact-weil-successor-cell-negative-part-bound.md)
can be stated on compactly supported tests on the real log line as
\[
 Q(f)=\frac1{2\pi}\int_{\mathbb R}
 b(t)|\widehat f(t)|^2\,dt-\langle f,(K-P)f\rangle,
 \qquad b(t)=\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi.       \tag{1}
\]
Here \(K\) contains every actual shift \(\Lambda(p^j)/\sqrt{p^j}\),
\(j\ge1\), at its literal support endpoint; \(P\) has kernel
\(e^{|x-y|/2}\). Equation (1) has already combined the two poles with
the continuous density by the exact digamma recurrence. No pole or
proper prime power is suppressed.
Explicitly, the pole kernel \(2\cosh((x-y)/2)\) minus \(P\) is
\(e^{-|x-y|/2}\), whose Fourier multiplier
\((t^2+1/4)^{-1}\) shifts the digamma argument from \(1/4\) to
\(5/4\).

Put
\[
 A(y)=\sum_{d\le y}\frac{\Lambda(d)}d,\qquad
 F(y)=A(y)-\log y\quad(y\ge1).                              \tag{2}
\]
[Ramaré--Zuniga-Alterman, Theorem 1.3, with Balazard's appendix](https://arxiv.org/html/2312.05138)
proves the unconditional all-\(y\) inequality \(F(y)\le0\).
This arithmetic input is strictly weaker than RH.

**Signed cone theorem.** Let \(h:[0,\infty)\to[0,\infty)\) be bounded,
nonincreasing, of bounded variation, and supported in \([0,L]\).
Extend \(f(x)=e^{-x/2}h(x)\) by zero for \(x<0\). Then
\[
 \boxed{\qquad \langle f,(K-P)f\rangle\le0. \qquad}          \tag{3}
\]
The assertion concerns the full arithmetic-minus-continuum residual,
including both small and large prime powers. It gives a lower bound
\(Q(f)\ge(2\pi)^{-1}\int b|\widehat f|^2\); the shifted gamma
symbol is not everywhere nonnegative, so (3) alone is not a full-cone
Weil-positivity theorem.

To prove (3), write the real autocorrelation
\[
 C_f(u)=\int_{\mathbb R}f(x+u)f(x)\,dx
 =e^{-u/2}\int_0^\infty e^{-x}h(x+u)h(x)\,dx
 \quad(u\ge0).
\]
For \(y\ge1\), set
\[
 w_h(y)=\sqrt y\,C_f(\log y)
       =\int_0^\infty e^{-x}h(x+\log y)h(x)\,dx.           \tag{4}
\]
It is nonnegative, nonincreasing, and zero for \(y\ge e^L\).
Changing variables \(y=e^u\) in the exact quadratic forms gives
\[
 \frac12\langle f,(K-P)f\rangle
 =\sum_{d\le e^L}\frac{\Lambda(d)}d\,w_h(d)
       -\int_1^{e^L}w_h(y)\frac{dy}{y}
 =\int_{(1,e^L]}w_h(y)\,dF(y).                            \tag{5}
\]
Since \(F(1)=0\), \(F\le0\), \(w_h(e^L)=0\), and \(dw_h\le0\),
Stieltjes integration by parts makes the last expression
\(-\int F\,dw_h\le0\). The value at a prime-power endpoint is exact:
if \(d=e^L\), its correlation weight is zero.

## A growing-support full-form test

For \(L>0\), take \(h=\mathbf1_{[0,L]}\),
\(f_L=e^{-x/2}\mathbf1_{[0,L]}(x)\), and \(X=e^L\).
Then \(w_h(y)=(1-y/X)_+\). Equation (5) specializes to the
strict signed identity
\[
 \boxed{\quad
 \langle f_L,(K-P)f_L\rangle
 =\frac2X\int_1^X\bigl(A(y)-\log y\bigr)\,dy
 =2\left(A(X)-\frac{\psi(X)}X-\log X+1-\frac1X\right)
 <0.
 \quad}                                                    \tag{6}
\]
Strictness holds for every \(X>1\), since \(F(y)=-\log y<0\)
on \(1<y<\min(X,2)\). Classical PNT/Mertens asymptotics
\(A(X)=\log X-\gamma+o(1)\) and \(\psi(X)/X=1+o(1)\)
give
\[
 \langle f_L,(K-P)f_L\rangle\longrightarrow-2\gamma.
 \tag{7}
\]
The constant in \(A(X)\) can also be identified directly:
partial summation expresses it through
\(1+\int_1^\infty(\psi(y)-y)y^{-2}dy\); the classical
zero-free-region PNT error makes this integral convergent, and
the Laurent expansion of \(-\zeta'/\zeta(s)\) at \(s=1\)
identifies it with \(-\gamma\).
These asymptotics are unconditional and weaker than RH; the
all-\(X\) sign in (6) uses the stronger one-sided input (2).

The Fourier transform is
\[
 \widehat f_L(t)
 =\frac{1-e^{(-1/2+it)L}}{1/2-it}.
 \tag{8}
\]
The logarithmic gamma weight is integrable against
\((t^2+1/4)^{-1}\), and
\(\widehat f_L\) differs from \((1/2-it)^{-1}\) by a term of
absolute value \(e^{-L/2}/\sqrt{t^2+1/4}\).
Consequently the gamma term in (1) converges to
\[
 \frac1{2\pi}\int_{\mathbb R}
 \frac{\Re\psi_{\rm digamma}(5/4+it/2)-\log\pi}
      {t^2+1/4}\,dt
 =\psi_{\rm digamma}(3/2)-\log\pi
 =2-\gamma-\log(4\pi).                                    \tag{9}
\]
For the first equality on the second line, the probability
measure \(dt/[2\pi(t^2+1/4)]\) becomes the Poisson kernel of
scale \(1/4\) after \(t=2v\); averaging
\(\Re\psi_{\rm digamma}(5/4+iv)\) gives
\(\psi_{\rm digamma}(3/2)\). The last equality uses the
[digamma half-integer value](https://dlmf.nist.gov/5.4.E13)
and [recurrence](https://dlmf.nist.gov/5.5.E2).

Combining (1), (7), and (9) yields the complete signed limit
\[
 \boxed{\qquad
 \lim_{L\to\infty}Q(f_L)
 =2+\gamma-\log(4\pi)
 =0.0461914179\ldots>0.
 \qquad}                                                   \tag{10}
\]
The sign needs no numerical assumption: \(\gamma>
H_{20}-\log21>0.55\), while \(\pi<22/7\) gives
\(\log(4\pi)<\log(88/7)<2.54\).
Thus \(Q(f_L)>0\) for all sufficiently large \(L\), with
every actual prime power, both poles, and the full gamma factor.
The positive margin is small; the constant and sign in (10)
depend on the exact normalization in (1).

Each \(f_L\) has bounded variation and finite logarithmic Fourier
energy, so (1) is defined on its form-domain extension.
Convolution with a smooth approximate identity converges in that
logarithmic form norm: the Fourier multipliers are bounded by one
and converge pointwise, while
\(\log(2+|t|)|\widehat f_L(t)|^2\) is integrable. On a fixed
slightly enlarged support, the pole and finitely many prime-shift
terms are bounded \(L^2\) forms. Therefore each sufficiently large
\(L\) also has nearby \(C_c^\infty\) tests with positive complete
Weil value. The limit in (10) is taken along the nonsmooth
form-domain family \(f_L\); it is not a value assigned to the
noncompact \(f_\infty=e^{-x/2}\mathbf1_{[0,\infty)}\).

This is a signed consumer of the same complete actual-prime
residual decomposed as \(K_{\le D}+(K_{>D}-P)\) in the
[full-space residual theorem](compact-weil-successor-cell-signed-residual-hs.md).
The sign here comes from the independent one-sided inequality (2),
not from the Hilbert--Schmidt norm bound. A hypothetical fixed
off-critical-line zero remains compatible with (3) and (10):
they control one monotone causal cone and one growing-support
family, not arbitrary compact tests. No literature-priority claim
is made beyond the stated arithmetic and digamma inputs.
