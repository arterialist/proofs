# Dirichlet dual cancellation of proper cofactors for an actual Weil packet

**Status:** incomplete written reduction, 19 September 2026, corrected in the
segment-3 history audit.
This reformulates part of the small-cofactor barrier ($k=2$) identified in
[the reciprocal-prime saving note](actual-reciprocal-prime-high-cofactor-saving.md#a-saved-high-cofactor-subrange).
The underlying finite hyperbola algebra is compiled in
[ActualPrimeCofactorFutureFinite.lean](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean).
The exact Mellin scaling across cofactors and the individual-zero approximate
functional equation are useful identities. They do not bound the resulting dual
Dirichlet polynomial, justify the exchange with the full zero sum, control the
omitted cofactor tail, or prove that the smooth explicit-formula remainder is
small uniformly in the parameters. The note therefore does not resolve the
small-cofactor barrier or prove a new signed estimate for the actual prime row.

## Background: The small-cofactor barrier

In [the high-cofactor saving](actual-reciprocal-prime-high-cofactor-saving.md),
Vaughan's identity combined with the Robert–Sargos third-derivative test established
a genuine power saving $O(T^{-(29-14\lambda)/60})$ on the high-cofactor slice
$d \le H T^{\delta_*}$, where $k \ge T^{1-\delta_*}$.
However, equation (14) of that note left the proper future
\[
 \sum_{d > H T^{\delta_*}} \Lambda(d) \sum_{k \ge 2} g_N(dk)
 \tag{1}
\]
uncontrolled. In particular, the $k=2$ term
\[
 \sum_d \Lambda(d) g_N(2d)
 \tag{2}
\]
is a signed prime correlation centered at $N/2$. Bounding it termwise by absolute values
gave the coarse scale $O(H/\sqrt N) = O(T^{\lambda/2 - 1})$, which is the original
row scale and exceeds the $O(\log T)$ budget of the complete Weil form.

Across a finite family of cofactors, the formal zero-side contribution contains
the partial Dirichlet series $\sum_{k=2}^K k^{-\rho}$. At an individual zero,
the approximate functional equation rewrites this as $-1$ plus a dual
Dirichlet polynomial of length comparable to $T^{\delta_*}$ and an error. The $-1$
term formally cancels the corresponding $k=1$ factor. This observation is a
reduction, not a cancellation estimate for the complete explicit formula.

## Factorization of the zero-side cofactor transform

Let $u_T(x) = a(x) e^{i\eta T x^2 - iTx}$ with $a \in C_c^\infty((0, w))$,
$0 < w < \log 2$, and $0 < \eta < 1/(8w)$, and let
\[
 q_T = \frac{(\partial_x^2 - 1/4)u_T}{\|(\partial_x^2 - 1/4)u_T\|_2}
\]
be the exact pole-null packet. For $N = T^\lambda$ ($\lambda > 2$), $H = N/T$,
and $g_N(x) = x^{-1/2} C_T(\log(x/N))$, recall that
\[
 G_T(v) = \sqrt N g_N(N + Hv)
\]
is uniformly Schwartz in $T$, with $\int_{-\infty}^\infty G_T(v)\,dv = \widehat G_T(0) = 0$
by the exact moment vanishing $\int_0^\infty g_N(x)\,dx = 0$.

For each fixed integer $k \ge 1$, consider the dilated kernel $x \mapsto g_N(kx)$.
Its effective center is $X_k = N/k$, and its effective width is $h_k = H/k$.
Notice the crucial scale-invariance:
\[
 \frac{h_k}{X_k} = \frac{H/k}{N/k} = \frac{H}{N} = \frac{1}{T}
 \quad\text{for every } k \ge 1.
 \tag{3}
\]
Writing $x = X_k(1 + v/T)$, we have
\[
 g_N(kx) = \frac{1}{\sqrt N} G_T\left( \frac{kx - N}{H} \right)
 = \frac{1}{\sqrt N} G_T(v).
 \tag{4}
\]

**Lemma 1 (Exact cofactor factorization).** Let $\rho = \beta + i\gamma$ be any
nontrivial zero of $\zeta(s)$. The Mellin transform of $x \mapsto g_N(kx)$ satisfies
\[
 \boxed{\quad
 \int_0^\infty x^{\rho-1} g_N(kx)\,dx = k^{-\rho} J(\rho, T),
 \quad}
 \tag{5}
\]
where the factor
\[
 J(\rho, T) := \frac{N^\rho}{T\sqrt N} \int_{-\infty}^\infty \left(1 + \frac{v}{T}\right)^{\rho-1} G_T(v)\,dv
 \tag{6}
\]
is **strictly independent of the cofactor $k$**.

*Proof.* In the integral $\int_0^\infty x^{\rho-1} g_N(kx)\,dx$, substitute $u = kx$,
so $x = u/k$ and $dx = du/k$:
\[
 \int_0^\infty x^{\rho-1} g_N(kx)\,dx
 = \int_0^\infty (u/k)^{\rho-1} g_N(u)\,\frac{du}{k}
 = k^{-\rho} \int_0^\infty u^{\rho-1} g_N(u)\,du.
\]
Now substitute $u = N(1 + v/T)$, so $du = (N/T) dv$ and $g_N(u) = N^{-1/2} G_T(v)$:
\[
 \int_0^\infty u^{\rho-1} g_N(u)\,du
 = \int_{-\infty}^\infty N^{\rho-1}\left(1 + \frac{v}{T}\right)^{\rho-1} N^{-1/2} G_T(v)\,\frac{N}{T}\,dv
 = J(\rho, T).
\]
Pulling out $k^{-\rho}$ gives (5). $\blacksquare$

## Dual Dirichlet polynomial of the cofactor ensemble

Now sum the explicit formula over all proper cofactors $2 \le k \le K$, where
$K = N / (H T^\delta) = T^{1-\delta}$ with $0 < \delta < 1$:
\[
 \sum_{2 \le k \le K} \sum_d \Lambda(d) g_N(kd)
 = - \sum_\rho J(\rho, T) \left( \sum_{2 \le k \le K} k^{-\rho} \right) + R_{\rm smooth},
 \tag{7}
\]
where $R_{\rm smooth}$ denotes the pole, archimedean, truncation, and interchange
remainders. The two moment vanishings alone do not prove $R_{\rm smooth}=o(1)$
uniformly. That estimate is an open obligation in this reduction.

Notice that the sum over cofactors is
\[
 \sum_{2 \le k \le K} k^{-\rho} = \sum_{k=1}^K k^{-\rho} - 1.
 \tag{8}
\]
For $|\gamma| \asymp T$, the Dirichlet polynomial $\sum_{k=1}^K k^{-\rho}$ is
governed by the approximate functional equation for the Riemann zeta function.

**Theorem (Proper-cofactor dual Dirichlet cancellation).** Let $\rho = \beta + i\gamma$
be a zero of $\zeta(s)$ with $|\gamma| \asymp T$. For $K = T^{1-\delta}$ with $0 < \delta < 1/2$,
let
\[
 y_\rho=\frac{|\gamma|}{2\pi K}\asymp T^\delta.
\]
Then
\[
 \boxed{\quad
 \sum_{2 \le k \le K} k^{-\rho}
 = - 1 - \chi(\rho) \sum_{1 \le n \le y_\rho} n^{\rho-1}
 + O\left( T^{-(1-\delta)\beta}
   +T^{1/2-\beta-\delta(1-\beta)}\right).
 \quad}
 \tag{9}
\]
When $\beta\ge 1/2$, this implies the weaker but simpler bound
\[
 O\!\left(T^{-(1-\delta)\beta}+T^{-\delta(1-\beta)}\right).
 \tag{9a}
\]
In particular, for the critical line $\beta = 1/2$:
\[
 \sum_{2 \le k \le K} k^{-1/2 - i\gamma}
 = - 1 - \chi(1/2+i\gamma) \sum_{1 \le n \le y_\rho} n^{-1/2 + i\gamma} + O(T^{-\delta/2}).
 \tag{10}
\]

*Proof.* By the Riemann–Siegel / Hardy–Littlewood approximate functional equation
for $\zeta(s)$ in the critical strip (see Titchmarsh, *The Theory of the Riemann
Zeta-Function*, equation (4.12.4) and Theorem 4.15), for $2\pi x y = |t|$
with $x = K$:
\[
 \zeta(s) = \sum_{k \le x} k^{-s} + \chi(s) \sum_{n \le y} n^{s-1} + O(x^{-\sigma} + |t|^{1/2-\sigma} y^{\sigma-1}).
\]
Because $\rho$ is a nontrivial zero, $\zeta(\rho) = 0$. Hence
\[
 0 = \sum_{k \le K} k^{-\rho} + \chi(\rho) \sum_{n \le y_\rho} n^{\rho-1}
   + O(K^{-\beta} + |\gamma|^{1/2-\beta} y_\rho^{\beta-1}).
\]
Rearranging and subtracting $1$ (for $k=1$) yields (9). $\blacksquare$

## Cancellation against the prime row

Combining Lemma 1 and the theorem displays a formal cancellation between the
$k=1$ factor and the truncated proper-cofactor factors. The following equations
are valid only after the explicit-formula sum, truncation, and remainder terms
have been justified uniformly. In particular, let $\mathcal Z_T$ denote a fixed
height band on which $|\gamma|\asymp T$; the contribution of zeros outside this
band must be placed in the remainders below unless it is bounded separately.

1. **The $k=1$ prime row:**
   \[
    \sum_n \Lambda(n) g_N(n) = - \sum_{\rho\in\mathcal Z_T} J(\rho, T) \cdot 1^{-\rho} + R_1
    = - \sum_{\rho\in\mathcal Z_T} J(\rho, T) + R_1.
    \tag{11}
   \]

2. **The proper cofactor future:**
   Substituting (9) into (7):
   \[
    \sum_{2 \le k \le K} \sum_d \Lambda(d) g_N(kd)
    = - \sum_{\rho\in\mathcal Z_T} J(\rho, T) \left( - 1 - \chi(\rho) \sum_{n \le y_\rho} n^{\rho-1} \right) + R_2
    = + \sum_{\rho\in\mathcal Z_T} J(\rho, T)
      + \sum_{\rho\in\mathcal Z_T} J(\rho, T) \chi(\rho) \sum_{n \le y_\rho} n^{\rho-1} + R_2.
    \tag{12}
   \]

3. **The complete sum:**
   Adding (11) and (12):
   \[
    \boxed{\quad
    \sum_n \Lambda(n) g_N(n) + \sum_{2 \le k \le K} \sum_d \Lambda(d) g_N(kd)
    = \sum_{\rho\in\mathcal Z_T} J(\rho, T) \chi(\rho)
      \sum_{1 \le n \le y_\rho} n^{\rho-1} + R(T).
    \quad}
    \tag{13}
   \]

Here $R(T)$ includes the accumulated approximate-functional-equation errors,
the explicit-formula remainder, the complementary zero ranges, and any error
from exchanging the cofactor and zero sums. No bound adequate for the Weil
problem is proved here.

## What the reduction does and does not show

1. **Termwise estimates lose the cofactor phase:**
   The apparent $O(H/\sqrt N)$ barrier arose strictly from bounding $|\sum_d \Lambda(d) g_N(2d)|$
   by $\sum_d \Lambda(d) |g_N(2d)|$. On the critical line,
   $\sum_{k=2}^K |k^{-\rho}| \asymp K^{1/2} = T^{(1-\delta)/2}$,
   termwise bounding introduces a spurious loss of $T^{(1-\delta)/2}$.
   The approximate functional equation transfers this phase to the dual sum. It
   does not by itself prove square-root cancellation or an $O(\log T)$ bound.

2. **Shorter dual length:**
   Instead of summing over $K = T^{1-\delta}$ cofactors, the dual Dirichlet polynomial
   has length, for zeros with $|\gamma|\asymp T$,
   \[
    y_\rho = \frac{|\gamma|}{2\pi K}\asymp T^\delta.
   \]
   This is shorter than $K=T^{1-\delta}$ when $\delta<1/2$, but for every fixed
   $\delta>0$ one has $T^\delta/\log T\to\infty$. Thus the dual polynomial is
   not asymptotically sub-logarithmic. At finite heights where $y_\rho<2$, it has only
   the $n=1$ term, which does not supply an asymptotic estimate.

3. **Structural origin of cancellation:**
   This cancellation is the spectral reflection of the elementary identity $\Lambda * 1 = \log$.
   The arithmetic function $\log n$ has Dirichlet series $-\zeta'(s)$, which has a double pole
   at $s=1$ but **no poles at the nontrivial zeros $\rho$** of $\zeta(s)$.
   The complete convolution has no pole at a nontrivial zero after multiplication
   by $\zeta(s)$. Turning that global analytic identity into a bound for this
   truncated, packet-weighted cofactor sum still requires uniform tail and
   remainder estimates.
