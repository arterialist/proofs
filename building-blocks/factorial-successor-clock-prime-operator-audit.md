# What the factorial successor clock changes in the prime operator

The factorial clock $k(n)=n-n\log n+\log(n!)$ records cumulative $+1$ arrivals. This note **directly transports** that scalar clock onto the prime-log shift coefficients and compares the resulting operator with the actual odd Weil prime-shift operator. This transported operator is not identified with the original factorial two-body Möbius energy. The comparison retains every admitted prime power and gives no RH estimate.

Put $X=e^{2a}$, $N=\max\{n\in\mathbb N:n<X\}$, and let $U_{n,a}f(x)=f(x+\log n)+f(x-\log n)$ on $L^2(-a,a)$, using zero extension. Define
\[
P_a=\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}U_{n,a},\quad
P_{\log,a}=\sum_{2\le n\le N}\frac{\Lambda(n)\log n}{\sqrt n}U_{n,a},\quad
P_{k,a}=\sum_{2\le n\le N}\frac{\Lambda(n)k(n)}{\sqrt n}U_{n,a}.
\]
All three commute with reflection and thus restrict to the odd sector.

**Bounded-residual identity.** Let $c=\tfrac12\log(2\pi)$. The elementary sharp Stirling remainder
\[
k(n)=\tfrac12\log n+c+\frac1{12n}+r_n,
\qquad -\frac1{360n^3}<r_n<0
\]
gives the exact identity
\[
P_{k,a}=\tfrac12P_{\log,a}+cP_a+B_a,
\qquad
\|B_a\|\le\frac16\sum_{n\ge2}\frac{\Lambda(n)}{n^{3/2}}
=\frac16\left(-\frac{\zeta'}{\zeta}\right)(3/2).
\tag{1}
\]
Indeed every coefficient of $B_a$ lies strictly between $0$ and $\Lambda(n)/(12n^{3/2})$, and $\|U_{n,a}\|\le2$. The bound is uniform in the window $a$. Thus this direct clock transport is, at leading scale, a logarithmic reweighting plus a constant multiple of the original prime operator; its Stirling correction is bounded.

The exact successive admission is
\[
k(n)-k(n-1)=1-(n-1)\log\frac n{n-1}
=\int_0^1\frac{u}{n-1+u}\,du
\asymp n^{-1}.
\tag{2}
\]
If the quantity in (2) itself weights each prime shift, the resulting operator is uniformly bounded, since $\sum_{n\ge2}\Lambda(n)n^{-3/2}<\infty$. That direct one-step lift loses the growing $e^a$ prime interaction.

The cumulative lift does retain it, but not as a small successor correction. Abel summation gives
\[
R_a:=k(N)P_a-P_{k,a}
=\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}
\bigl(k(N)-k(n)\bigr)U_{n,a},
\qquad
k(N)-k(n)=\tfrac12\log(N/n)+O(1/n).
\tag{3}
\]
Prime-number-theorem partial summation gives
\[
\sum_{n<X}\frac{\Lambda(n)}{\sqrt n}\bigl(k(N)-k(n)\bigr)
=(2+o(1))e^a,
\]
so $\|R_a\|\le(4+o(1))e^a$. This is the correct full-prime scale, not a bounded error.

It is also a lower bound up to a constant. For $\phi(x)=\cosh(x/2)$, $Z_a=\|\phi\|_2^2=a+\sinh a\sim e^a/2$, and $y_n=\log(X/n)$, direct overlap integration gives
\[
\int_{-a}^{a-\log n}\phi(x)\phi(x+\log n)dx
=\sinh(y_n/2)+(y_n/2)\cosh((\log n)/2).
\]
The PNT moment $\sum_{n<X}\Lambda(n)y_n^2=(2+o(1))X$ then yields
\[
\frac{\langle\phi,R_a\phi\rangle}{Z_a}=(1+o(1))e^a,
\qquad
(1+o(1))e^a\le\|R_a\|\le(4+o(1))e^a.
\tag{4}
\]
The lower test is even; the [finite-shift parity-spectrum theorem](prime-shift-parity-spectrum-recurrence-no-go.md) transfers the same spectral edge to the odd restriction, including the pole-null class after a negligible high-frequency correction. Likewise $\|P_{k,a}\|=(1+o(1))a e^a$, using $k(N)=a+c+o(1)$, the weighted Schur bound for $P_a$, and the preceding positive even test followed by parity transfer.

Finally, the clock reweighting does not preserve the sign of a prime correlation. Fix $\tfrac12\log3<a<\log2$, so only the actual $n=2,3$ shifts occur. Write $w_j=(\log j)/\sqrt j$, choose $k(2)/k(3)<q<1$, and place three sufficiently narrow equal smooth bumps at generic positions $x_0,x_0+\log2,x_0+\log3$ inside $(-a,a)$, with coefficients $1,1,-q w_2/w_3$. Oddify their sum, choosing $x_0$ to avoid all unintended reflected shift coincidences. The only remaining correlations give
\[
\langle F,P_aF\rangle=4w_2(1-q)\|\eta\|_2^2>0,
\qquad
\langle F,P_{k,a}F\rangle=4w_2(k(2)-qk(3))\|\eta\|_2^2<0.
\tag{5}
\]
A fourth generic isolated odd bump has zero prime-shift self- and cross-correlations and nonzero pole moment; adding its unique multiple makes $F$ exactly pole-null without changing (5). This uses the actual weights $\Lambda(2),\Lambda(3)$. It rules out transferring a positive prime correlation to the factorial-weighted one by a bare monotonicity argument.

The $+1$ clock remains a useful structural coordinate, but (1)--(5) show that an RH advance from it must exploit a signed interaction beyond this direct weighting. In particular, the Binet residual cannot itself supply a missing order-$e^a$ cancellation. These conclusions do not apply directly to the distinct factorial two-body Möbius form.
