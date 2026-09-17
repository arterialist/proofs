# A classical PNT-rate bound for the complete successor-cell Weil negative part

The [complete successor-cell Weil matrix](compact-weil-successor-cell-refinement.md)
retains every admitted von Mangoldt prime power, the gamma integral, and both
poles. The earlier [negative-part bound](compact-weil-successor-cell-negative-part-bound.md)
uses a twisted prime estimate up to polynomial frequencies and has a
\((\log N)^{1/3}\) saving in its exponent. A physical split of the cells
allows the classical prime-number-theorem error to give the stronger
\((\log N)^{3/5}\) saving. This is an unconditional written analytic proof,
not a Lean formalization. Its negative allowance still grows, so it proves
neither full Weil positivity nor RH.

Set \(X=N+1\), \(L=\tfrac12\log X\), and
\[
 \Phi(X)=\frac{(\log X)^{3/5}}{(\log\log X)^{1/5}}.
\]
For the Hermitian form \(Q_L\) of the refinement note, there are absolute
\(c,C>0\) such that, for all sufficiently large \(N\) and all complex
\(f\in S_N\),
\[
 \boxed{\quad Q_L(f)\ge
 -C\sqrt X\,e^{-c\Phi(X)}\|f\|_2^2.\quad}                    \tag{1}
\]
Equivalently, the operator norm of the negative part of its \(N\times N\)
matrix is \(O(\sqrt N e^{-c\Phi(N)})\).

## Prime discrepancy at subexponential frequencies

The exact pole–continuous-prime cancellation in the earlier note gives
\[
 Q_L(f)=\frac1{2\pi}\int_{\mathbb R}b(t)|\widehat f(t)|^2dt-D_X[f],
 \qquad b(t)=\operatorname{Re}\psi_{\rm digamma}
              \left(\frac54+\frac{it}{2}\right)-\log\pi
              \ge b_*>-\infty,                              \tag{2}
\]
where \(D_X=K_L-P_{L,\mathrm{cont}}\) and
\[
 D_X[f]=\frac1{2\pi}\int_{\mathbb R}
          2\operatorname{Re}\Delta_X(t)|\widehat f(t)|^2dt,
 \qquad
 \Delta_X(t)=\sum_{n<X}\frac{\Lambda(n)}{\sqrt n}n^{it}
           -\int_1^X x^{-1/2+it}dx.                         \tag{3}
\]
The continuous prime operator has kernel \(e^{|x-y|/2}\) on the window.
Equation (2) includes the complete gamma multiplier and both pole moments.
Chebyshev's \(\psi(x)\ll x\) gives \(|\Delta_X(t)|\ll\sqrt X\) for every
real \(t\).

The classical Vinogradov–Korobov PNT error, in the form
\[
 E(x):=\psi(x)-(x-1)\ll x e^{-A\Phi(x)}
 \qquad(x\ge x_0),                                         \tag{4}
\]
holds with some absolute \(A>0\); see the primary results of
[Bellotti](https://arxiv.org/abs/2508.02041) and
[Johnston](https://arxiv.org/abs/2411.13791). We need only this
unconditional consequence, with no assertion about zeros on the critical
line. For sufficiently small fixed \(\eta>0\), put
\(T=\exp(\eta\Phi(X))\). Then
\[
 \epsilon_T(X):=X^{-1/2}\sup_{|t|\le T}|\Delta_X(t)|
 \ll e^{-c_0\Phi(X)}                                      \tag{5}
\]
for some \(c_0>0\).

Here is the endpoint and uniformity check. Replace the integer \(X\) by
\(Y=X-\tfrac12\) in the integral, retaining the same strict prime sum;
the integral changes by \(O(X^{-1/2})\), uniformly in \(t\).
Stieltjes integration by parts against \(dE\) bounds the discrepancy by
\[
 C\sqrt X e^{-A\Phi(X)}
 +C(1+|t|)\int_1^X x^{-3/2}|E(x)|dx+O(X^{-1/2}).
\]
For \(x\le\sqrt X\), Chebyshev makes the integral \(O(X^{1/4})\).
For \(x\ge\sqrt X\), \(\Phi(x)\ge c_1\Phi(X)\) for an absolute \(c_1>0\),
and the integral is \(O(\sqrt X e^{-Ac_1\Phi(X)})\).
Since \(1+T\ll e^{\eta\Phi(X)}\), choosing \(\eta<Ac_1/2\)
proves (5), after decreasing \(c_0\).

## A coarse/fine cell estimate

For integers \(1\ll M<N\) and \(T\gg M^2\), split
\(f=f_c+f_f\) orthogonally into the first \(M\) cells and the remaining
cells. The zero-extended coarse function has
\[
 \operatorname{TV}(f_c)\le2\sum_{n\le M}|z_n|
 \ll M\|f_c\|_2,\qquad
 \frac1{2\pi}\int_{|t|>T}|\widehat f_c(t)|^2dt
 \ll\frac{M^2}{T}\|f_c\|_2^2.                         \tag{6}
\]
The coarse–fine high-frequency pairing is at most
\(C\sqrt X\,M T^{-1/2}\|f_c\|_2\|f_f\|_2\), by Cauchy–Schwarz
and the global bound on \(\Delta_X\).

The support of \(f_f\) is the interval
\((-L,L-\log(M+1)]\), of length
\[
 W=\log\frac{X}{M+1}.
\]
Two points in it have separation at most \(W\). Hence only shifts
\(d<e^W=X/(M+1)\) contribute to its *quadratic* prime term. Each
compressed shift has norm at most one, so the triangle inequality and
Chebyshev's bound give
\[
 |K_L[f_f]|
 \le2\sum_{d<e^W}\frac{\Lambda(d)}{\sqrt d}\|f_f\|_2^2
 \ll e^{W/2}\|f_f\|_2^2.
\]
Likewise the continuous kernel \(e^{|x-y|/2}\), restricted to this
interval, has row integral \(O(e^{W/2})\). Thus
\[
 |D_X[f_f]|\ll\sqrt{\frac{X}{M+1}}\|f_f\|_2^2.       \tag{7}
\]
This is a bound on the full fine quadratic. To bound its
*high-frequency* portion in (3), subtract its low-frequency portion,
whose absolute value is at most \(2\epsilon_T(X)\sqrt X\|f_f\|_2^2\).
The support estimate (7) is not applied to a Fourier projection.

Splitting (3) at \(T\), then expanding only its high-frequency part
into coarse–coarse, coarse–fine, and fine–fine pieces, proves
\[
 |D_X[f]|\ll
 \sqrt X\left(\epsilon_T(X)+M^{-1/2}
       +\frac{M}{\sqrt T}+\frac{M^2}{T}\right)\|f\|_2^2.
                                                               \tag{8}
\]
Now take \(M=\lfloor T^{1/3}\rfloor\). All terms after
\(\epsilon_T\) are \(O(T^{-1/6})\), so (5) and (2) give
\(Q_L(f)\ge(b_*-C\sqrt X e^{-c\Phi(X)})\|f\|_2^2\).
The error coefficient tends to infinity, allowing the fixed \(b_*\)
to be absorbed for sufficiently large \(N\). This proves (1).

The cell-average projections onto \(S_N\) converge to every fixed compact
smooth test in form topology, but the negative allowance in (1) is
\(X^{1/2-o(1)}\). This improvement of a quantitative unconditional bound
does not supply the sign required by Weil's criterion.
