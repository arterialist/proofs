# Exact doubling of the actual two-history harmonic convolution

This written proof gives unconditional finite-scale identities for the actual [harmonic convolution](harmonic-convolution.md). It derives no bound or sign for $W$, and uses no mean-square or Besicovitch approximation premise.

Let $e(x)=\psi(x)-x$ for $x\ge1$, with every prime power in $\psi$, and define

$$
a(t)=e^{-t/2}e(e^t),\qquad
g=a*a,\qquad
F(t)=Hg(t)=\sum_{d\le e^t}\frac{g(t-\log d)}d.
$$

All convolutions here are causal. Thus $a(0)=-1$, whereas $g(0)=F(0)=0$.
Set $L=\log2$ and $c=1/\sqrt2$. The next dyadic interval discrepancy is

$$
b_2(t)=a(t+L)-c a(t)
=\frac{\psi(2x)-\psi(x)-x}{\sqrt{2x}},\qquad x=e^t.
\tag{1}
$$

The contribution from the initial interval is exactly

$$
I(t)=\int_0^L a(u)a(t+L-u)\,du
=-\sqrt{2x}\int_x^{2x}\frac{e(y)}{y^2}\,dy.
\tag{2}
$$

The second equality uses $a(u)=-e^{u/2}$ for $0\le u<L$. The value at the
single prime-arrival endpoint $u=L$ has no effect on the integral.

Splitting the convolution integral at $u=L$ and substituting (1) on its
remaining part gives

$$
g(t+L)=c g(t)+(a*b_2)(t)+I(t).
\tag{3}
$$

Consequently the full harmonic scale sum obeys

$$
\boxed{F(t+L)-c F(t)
=H(a*b_2)(t)+HI(t)+B_2(t),}
\tag{4}
$$

where the newly admitted scales contribute

$$
B_2(t)=\sum_{x<d\le2x}\frac1d
\log\frac{2x}{d}\sqrt{\frac{2x}{d}}.
\tag{5}
$$

To prove (4), apply (3) to the terms $d\le x$. In the remaining terms,
$0\le t+L-\log d<L$, and $g(s)=se^{s/2}$. This proves (5), including every
boundary scale. A term with $d=2x$ is zero. $B_2$ is nonnegative and bounded for $x\ge1$, and positive for $x>1$; ordinary sum-integral comparison gives

$$
B_2(t)=4-4\sqrt2+2\sqrt2\log2+O(e^{-t}).
\tag{6}
$$

Equation (4) isolates a signed interaction between the cumulative
error and the error in its next doubled interval. In multiplicative
coordinates its cross term is the actual arithmetic expression

$$
H(a*b_2)(t)=\frac1{\sqrt{2x}}
\sum_{d\le x}\frac1{\sqrt d}
\int_1^{x/d}e(u)
\left[\psi\!\left(\frac{2x}{du}\right)
-\psi\!\left(\frac{x}{du}\right)-\frac{x}{du}\right]
\frac{du}{u}.
\tag{7}
$$

Both interval endpoints in (1) and (7) use the same right-continuous $\psi$. No prime-power arrival or density term has been removed.

The independent division of the harmonic scales into even and odd
integers gives a second exact identity:

$$
F(t+L)=\frac12F(t)
+\sum_{\substack{d\le2x\\d\ {\rm odd}}}
\frac{g(t+L-\log d)}d.
\tag{8}
$$

In (8) the even scale $d=2m$ becomes one half of the earlier scale $m$.
Comparing (4) and (8) expresses the same signed cross term through the
complete odd-scale contribution. Neither identity assigns it a sign.

## The complete W consumer and its initial filter contribution

Let $k(t)=e^{-3t/2}$, and use the exact [complete arithmetic reduction](harmonic-convolution.md)

$$
Y(t)=F(t)-(k*F)(t)
=e^{-3t/2}\widetilde N(e^t).
$$

Here $\widetilde N(x)=W(x)+S_{\rm crit}(x)$, with the full same-prime term defined below. Write $D(t)$ for the entire right side of (4). Splitting the convolution
for $Y(t+L)$ at $u=t$ gives

$$
\boxed{Y(t+L)-cY(t)
=D(t)-(k*D)(t)-C_2e^{-3t/2},}
\tag{9}
$$

with the retained initial contribution

$$
C_2=\int_0^L e^{-3v/2}F(L-v)\,dv
=\sqrt2\left(\frac L2-\frac3{16}\right).
\tag{10}
$$

Indeed $F(s)=se^{s/2}$ for $0\le s\le L$, because only $d=1$ can contribute
there. This proves (10) without any asymptotic replacement.

Finally retain the complete same-prime cost

$$
S_{\rm crit}(x)=\sum_{d\le x}\sqrt d
\sum_{p^j\le x/d}(x/d-p^j)(j-1)(\log p)^2,
\qquad s(t)=e^{-3t/2}S_{\rm crit}(e^t).
$$

For $w(t)=e^{-3t/2}W(e^t)=Y(t)-s(t)$, the exact consumer is

$$
\boxed{w(t+L)-c w(t)
=D(t)-(k*D)(t)-C_2e^{-3t/2}
-\bigl[s(t+L)-c s(t)\bigr].}
\tag{11}
$$

The [elementary same-prime asymptotic](harmonic-convolution.md) $s(t)=t^2/6+O(1+t)$ identifies the
size of this deterministic cost, but does not bound the signed cross
term in $D$. The next requirement is an arithmetic constraint on that
term or on the equivalent finite-frequency expression supplied by the
actual successor jumps. It is not available from the identity alone.
