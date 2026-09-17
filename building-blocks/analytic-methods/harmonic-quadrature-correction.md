# Harmonic quadrature for the actual two-history convolution

This written proof gives an exact harmonic quadrature identity and a classical-PNT-size unconditional bound for the actual two-history convolution. It complements the [mean-cancellation theorem](harmonic-convolution.md), whose stronger asymptotic conclusion uses separate hypotheses. The causal atom and all prime powers remain explicit.

Let $e(x)=\psi(x)-x$, $a(t)=e^{-t/2}e(e^t)$ for $t\ge0$, and extend $a$ by zero to negative times. Thus $a(0)=-1$. Let
$$
g=a*a,\qquad k(t)=e^{-3t/2}\mathbf1_{t\ge0},\qquad
(\mathcal Hf)(t)=\sum_{n\le e^t}\frac{f(t-\log n)}n.
$$
All sums involving $\Lambda$ retain proper prime powers. Convolutions below are causal.

## The exact endpoint-sensitive identity

Write $H_N=\sum_{n=1}^N1/n$ and let $\gamma$ be Euler's constant. Put $R(v)=H_{\lfloor e^v\rfloor}-v-\gamma$ for $v\ge0$, and zero for $v<0$. Elementary harmonic-sum estimates give $R(v)=O(e^{-v})$. Its distributional derivative on the whole line is
$$
DR=\eta-\mathbf1_{[0,\infty)}\,dv-\gamma\delta_0,
\qquad \eta=\sum_{n\ge1}\frac1n\delta_{\log n}.
\tag{1}
$$
Indeed, the jump at zero is $R(0)=1-\gamma$, the jump at $\log n$, $n\ge2$, is $1/n$, and its derivative between jumps is $-1$. This proves (1), including the harmonic atom at $n=1$.

The actual $a$ is locally bounded and of bounded variation. Its causal derivative is
$$
Da=-\delta_0+\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}\delta_{\log n}
-\left(\frac12a(t)+e^{t/2}\right)dt.
\tag{2}
$$
Therefore $g=a*a$ is locally absolutely continuous, $g(0)=0$, and $Dg=(Da)*a=g'(t)dt$. These statements also follow directly by finite-interval Fubini from (2). Convolving (1) with $g$ gives
$$
\boxed{\mathcal Hg(t)=\int_0^t g(s)\,ds+\gamma g(t)
+\int_0^t R(v)g'(t-v)\,dv.}
\tag{3}
$$
The derivative in the last integral is the almost-everywhere derivative of the locally absolutely continuous function $g$. No continuity of $g'$ is assumed. A terminal harmonic scale contributes zero in (3), since $g(0)=0$.

There is a useful exact factorization that avoids a total-variation bound:
$$
h=\mathcal Ha-1*a-\gamma a=R*Da,
\qquad R*g'=a*h.
\tag{4}
$$
Here $1(t)=\mathbf1_{t\ge0}$. All identities follow from locally finite convolutions of causal distributions, or from finite sums and finite-interval integration by parts. The terminal term of $\mathcal Ha$ cannot be dropped: it equals $-1/n$ when $t=\log n$.

Applying the complete filter gives
$$
\mathcal Hg-k*\mathcal Hg
=(I-k*)[1*g+\gamma g]+\mathcal E,
\qquad
\boxed{\mathcal E=(I-k*)a*h.}
\tag{5}
$$

## A concrete unconditional bound without variation norms

Johnston and Yang, *Some explicit estimates for the error term in the prime number theorem*, Theorem 1.1, prove
$$
|\psi(x)-x|\le9.39x(\log x)^{1.515}e^{-0.8274\sqrt{\log x}}
\quad(x\ge2).
$$
See [Johnston–Yang, Theorem 1.1](https://arxiv.org/html/2204.01980), arXiv:2204.01980v2, also used in the [division-renewal theorem](../factorial-and-renewal/division-renewal-dyadic-average.md).

Set $C=9.39$, $b=1.515$, $c=0.8274$, and
$$
w(t)=(1+t)^b e^{t/2-c\sqrt t}.
$$
Then $|a(t)|\le Cw(t)$ for every $t\ge0$. Above $\log2$ this follows from the cited theorem; below it, $a(t)=-e^{t/2}$, and the displayed bound follows immediately from $C>3$, $c<1$, and $\log2<1$.

For $0\le u\le t$,
$$
\frac{w(t-u)}{w(t)}\le e^{-u/2+c\sqrt u}.
\tag{6}
$$
Consequently the following constants give weighted operator bounds:
$$
Z_c=\sum_{n\ge1}n^{-3/2}e^{c\sqrt{\log n}},\quad
J_c=\int_0^\infty e^{-u/2+c\sqrt u}\,du,\quad
K_c=\int_0^\infty e^{-2u+c\sqrt u}\,du.
$$
If $|f|\le Mw$, then
$$
|\mathcal Hf|\le MZ_cw,\qquad |1*f|\le MJ_cw,\qquad |k*f|\le MK_cw.
\tag{7}
$$
These are actual discrete harmonic sums, not continuum replacements. All three constants are finite. For example, $c\sqrt u\le u/4+c^2$ gives
$$
Z_c\le e^{c^2}\zeta(5/4),\qquad J_c\le4e^{c^2},\qquad K_c\le\tfrac47e^{c^2}.
$$

The same weight is closed under causal convolution up to a constant:
$$
w*w\le2Bw,\qquad
B=\int_0^\infty(1+v)^b e^{-c\sqrt v/2}\,dv<\infty.
\tag{8}
$$
To prove this, split at $t/2$ and reflect the second half. On the first half,
$$
\sqrt t-\sqrt{t-v}
=\frac{v}{\sqrt t+\sqrt{t-v}}
\le\frac{\sqrt v}{\sqrt2+1}<\frac12\sqrt v.
$$
The polynomial factor $(1+t-v)^b$ is at most $(1+t)^b$, so the integrand divided by $w(t)$ is at most $(1+v)^be^{-c\sqrt v/2}$. This proves (8). An entirely explicit bound is available: since $b<2$, with $\lambda=c/2$,
$$
B\le2\lambda^{-2}+24\lambda^{-4}+240\lambda^{-6}.
$$

Combining (4), (5), (7), and (8) yields
$$
\boxed{|\mathcal E(t)|\le
2C^2B(Z_c+J_c+|\gamma|)(1+K_c)w(t).}
\tag{9}
$$
The complete readout itself also satisfies
$$
|\mathcal Hg-k*\mathcal Hg|
\le2C^2BZ_c(1+K_c)w.
\tag{10}
$$
No RH, Besicovitch approximation, or mean-square premise enters these bounds. At $X=e^t$, multiplying (9) by $e^{3t/2}$ gives
$$
O\!\left(X^2(1+\log X)^{1.515}e^{-0.8274\sqrt{\log X}}\right).
$$
This preserves a classical PNT saving but is still larger than the critical $X^{3/2}\log^2X$ scale. It supplies no eventual sign of the actual residual.

## Actual mixed derivative jumps

Expanding the finite arithmetic convolution gives, for $x=e^t\ge1$,
$$
g(t)=x^{-1/2}\left[
\sum_{ab\le x}\Lambda(a)\Lambda(b)\log\frac{x}{ab}
-2x\sum_{n\le x}\frac{\Lambda(n)}n+2\psi(x)+x\log x
\right].
\tag{11}
$$
The pair summand vanishes at its birth, and the jumps in the two single-prime terms cancel, verifying continuity directly. Differentiating between births and taking one-sided limits gives
$$
\Delta g'(\log n)=\frac{(\Lambda*\Lambda)(n)-2\Lambda(n)}{\sqrt n}.
\tag{12}
$$
Thus the jump is negative at $n=2$, positive at $n=6$, and the prime-power contribution at $n=4$ is $((\log2)^2-2\log2)/2$. Neither monotonicity direction of $g'$ is available. This rules out a monotone summation-by-parts shortcut; it does not rule out collective cancellation in (3)–(5).
