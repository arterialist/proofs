# Actual cutoff extrema of the finite centered heat Gram

Independently reviewed written proof, 2026-09-17. The finite centered heat Gram is positive,
but it is not eventually monotone in its arithmetic cutoff. Its first strict
local maximum is forced by the actual von Mangoldt jump at 19, and it has
infinitely many later strict local extrema. The statement
concerns the cutoff energy below, not the accumulated positive heat
energy in the RH-equivalent Lyapunov criterion. It proves no RH estimate.

Let \(\psi(x)=\sum_{n\le x}\Lambda(n)\), \(E(x)=\psi(x)-x\), with
\(E(1)=-1\). For each real \(X>1\) use the complete compact source
\[
 d\sigma_X=\mathbf1_{[1,X]}d\psi-\mathbf1_{[1,X]}dx
              -\delta_1-E(X)\delta_X.                    \tag{1}
\]
The arrival at a prime-power endpoint \(X\) is included *before* the
terminal compensation. The source has total mass zero, and Stieltjes
integration by parts gives, for \(t>0\),
\[
 C_X(t):=\int e^{-tx}d\sigma_X(x)
       =t\int_1^X E(x)e^{-tx}dx.                         \tag{2}
\]
In particular \(C_X(t)\) is continuous when \(X\) passes a prime
power: the newly included atom and the jump in the terminal
compensation cancel. Define
\[
 \mathcal H(X)=\int_0^\infty C_X(t)^2dt
 =2\int_1^X\!\int_1^X
   \frac{E(x)E(y)}{(x+y)^3}\,dxdy\ge0.                    \tag{3}
\]
The second identity follows from \(\int_0^\infty t^2e^{-t(x+y)}dt
=2/(x+y)^3\). It is exactly \(H_{\log X}\) in the [moving actual-core
heat theorem](actual-moving-core-centered-heat-gram.md),
with the initial atom, continuous density, all proper powers and
terminal correction retained.

On every open interval containing no prime-power integer, \(E\) is
continuous and the Leibniz rule in (3) gives the exact flow
\[
 \boxed{\quad
 \mathcal H'(X)=4E(X)\int_1^X\frac{E(y)}{(X+y)^3}dy.
 \quad}                                                    \tag{4}
\]
The integral factor is continuous across every cutoff. Thus at a
prime-power threshold the right and left derivatives differ only
through the genuine jump of \(E\); there is no jump of \(\mathcal H\).

The actual factorial ground is
\[
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x.
\]
Its two jump terms cancel, so \(F\) is continuous. Away from prime
powers, \(F'(x)=-E(x)/x^2\). Consequently (3)--(4) also read
\[
 \mathcal H(X)
 =2\int_1^X\!\int_1^X
 \frac{x^2y^2F'(x)F'(y)}{(x+y)^3}dxdy,
 \qquad
 \mathcal H'(X)=4X^2F'(X)
 \int_1^X\frac{y^2F'(y)}{(X+y)^3}dy.                 \tag{5}
\]
This is a positive Gram with a signed derivative: the new ground slope
is paired with all earlier slopes.

Here the first sign change can be checked with small exact integers.
For integer \(n\), put \(P_n=\prod_{p^k\le n}p\), so
\(\psi(n)=\log P_n\). The only arrival indices below 19 and their
products are
\[
\begin{array}{c|rrrrrrrrrrr}
 n&2&3&4&5&7&8&9&11&13&16&17\\ \hline
 P_n&2&6&12&60&420&840&2520&27720&360360&720720&12252240.
\end{array}                                                \tag{6}
\]
For every listed pair, the integer inequality
\(10^nP_n<27^n\) holds. Since
\(e>1+1+1/2+1/6+1/24=65/24>27/10\), we have
\(E(n)=\log P_n-n<0\) at every arrival below 19. Between arrivals
\(\psi\) is constant and \(E(x)\) strictly decreases; also
\(E(x)=-x<0\) on \([1,2)\). Therefore
\[
 E(x)<0\qquad(1\le x<19).                            \tag{7}
\]
At 19 the next actual prime arrives and
\[
 P_{19}=19P_{18}=232792560,
 \qquad 232792560\cdot4^{19}=63989531644935536640
           >61159090448414546291=11^{19}.               \tag{8}
\]
The elementary exponential series gives \(e<11/4\), hence
\(E(19)=\log P_{19}-19>0\). More explicitly,
\(\sum_{k=0}^4 1/k!=65/24\), and the tail is at most
\((1/120)\sum_{j\ge0}6^{-j}=1/100\), so
\(e<65/24+1/100<11/4\). Let
\[
 I_{19}=\int_1^{19}\frac{E(y)}{(19+y)^3}dy<0.
\]
The one-sided flow derivatives are
\[
 \mathcal H'_-(19)=4(\log P_{18}-19)I_{19}>0,
 \qquad
 \mathcal H'_+(19)=4(\log P_{19}-19)I_{19}<0.           \tag{9}
\]
Since \(E\) is affine between arrivals and the integral in (4) is
continuous, \(\mathcal H\) is strictly increasing immediately before
19 and strictly decreasing immediately after it. Thus 19 is a strict
local maximum of the *actual* complete finite centered heat Gram.
Equation \(F'=-E/x^2\) shows that the actual factorial ground \(F\)
has a strict local maximum there as well.

## Infinitely many actual cutoff extrema

The memory integral in (4) cannot vanish at *any* integer cutoff.
For an integer \(n\ge2\), expand the actual step function \(\psi\)
before integrating:
\[
\begin{split}
 I_n:=\int_1^n\frac{E(y)}{(n+y)^3}dy
 &=\sum_{2\le m<n}\Lambda(m)
    \left[\frac1{2(n+m)^2}-\frac1{8n^2}\right]-R_n,\\
 R_n&=\int_1^n\frac{y}{(n+y)^3}dy
     =\frac{(n-1)(n+3)}{8n(n+1)^2}>0.              \tag{10}
\end{split}
\]
The finite sum includes every prime power below \(n\), each with
\(\Lambda(p^k)=\log p\); its coefficients are rational. If \(I_n=0\),
clear all rational denominators in (10). There would be an integer
\(A=\prod_{p<n}p^{b_p}\ge1\) and a positive integer \(q\) such that
\(\log A=q\), so \(A=e^q\). This contradicts [Hermite's theorem that
\(e\) is transcendental](https://www.e-rara.ch/zut/content/titleinfo/27940137):
if \(e^q\) were algebraic, then \(e\) would be algebraic as a root of
\(z^q-e^q\). Therefore
\[
 I_n\ne0\qquad\hbox{for every integer }n\ge2.      \tag{11}
\]
For the same reason, \(E(n^-)=\log P_{n-1}-n\) and
\(E(n)=\log P_n-n\) never vanish at an integer \(n\ge2\).

[Littlewood's unconditional oscillation theorem](https://projecteuclid.org/journals/acta-mathematica/volume-41/issue-none/Contributions-to-the-theory-of-the-riemann-zeta-function-and/10.1007/BF02422942.pdf)
gives \(E(x)=\Omega_\pm(\sqrt{x}\log\log\log x)\), so arbitrarily
late negative values are followed by positive values. Between
prime-power arrivals, \(E(x)\) decreases with slope \(-1\).
Consequently every such negative-to-positive passage contains a
prime-power integer \(n\) with \(E(n^-)<0<E(n)\); the strictness uses
the nonvanishing just proved. There are infinitely many distinct such
\(n\). Equations (4) and (11) give one-sided derivatives of opposite
nonzero signs at each one:
\[
 \mathcal H'_-(n)=4E(n^-)I_n,
 \qquad \mathcal H'_+(n)=4E(n)I_n.                     \tag{12}
\]
The sign is stable on a short interval on either side, so every one
of these thresholds is a strict local maximum or minimum of the
*actual* finite centered heat Gram. In particular \(\mathcal H(X)\)
is not eventually monotone, despite being a positive Gram at each
cutoff. This argument gives no size estimate for the extrema or
RH-scale control of \(\mathcal H\).

This rules out an eventual monotone-cutoff or nonnegative-energy-flow
argument for \(\mathcal H(X)\), even though each value is a positive
quadratic Gram and the exact source is the true \(\Lambda\) source.
It does not disprove monotonicity of
\(1+\int_0^T|b(v)|^2dv\), whose variable \(T\) is an observation
horizon rather than an arithmetic source cutoff. Nor does it estimate
\(\mathcal H(X)\) at RH scale or control the signed factorial Picone
score. No Lean formalization is claimed.
