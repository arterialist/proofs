# A zero-mean packet bound does not control coarse primitive energy

## Scope

This note tests a proposed functional bridge from the live prime-packet estimate
to `CoarsePrimitiveBound`. It gives a continuous error term that satisfies the
full live packet decay, both pole-null moments, and the qualitative prime number
theorem condition $E(x)=o(x)$, but violates the coarse primitive bound.

The example is not the actual von Mangoldt measure. It does not refute a bridge
that uses an additional identity specific to the actual function $\Lambda$.
It proves that the packet estimate and its analytic normalization alone do not
supply that bridge.

## The packet and the coarse energy

Let $G_T$ be the actual compact packet profile and set

$$
H=\frac NT,
\qquad
g_{N,T}(x)=N^{-1/2}G_T\!\left(\frac{x-N}{H}\right).
\tag{1}
$$

For fixed $0<w<\log 2$, the defining packet has

$$
\operatorname{supp}G_T
\subset [T(e^{-w}-1),T(e^w-1)]\subset(-T/2,T),
\tag{2}
$$

uniformly bounded Schwartz seminorms, and the two pole-null relations

$$
\int_{\mathbb R}G_T(v)\,dv=0,
\qquad
\int_{\mathbb R}\log(1+v/T)G_T(v)\,dv=0.
\tag{3}
$$

In particular,

$$
\sup_T\int_{\mathbb R}(1+|v|^2)|G_T(v)|\,dv<\infty.
\tag{4}
$$

For a locally bounded-variation error $E$, define the Stieltjes response

$$
\mathcal R_E(N,T)=\int_{(0,\infty)}g_{N,T}(x)\,dE(x).
\tag{5}
$$

For the actual error $E(x)=\psi(x)-x$, the first relation in (3) removes the
Lebesgue term and leaves the normalized von Mangoldt packet.

The proposed estimate, with $N=T^\lambda$, is

$$
|\mathcal R_E(T^\lambda,T)|
\ll T^{-\rho+\varepsilon},
\qquad
2<\lambda<\frac{29}{14},
\tag{6}
$$

for some fixed $\rho>0$.

For a real error $E$, define

$$
P_X(t)=\int_X^tE(x)\,dx,
\qquad
Q_X(t)=\int_t^{2X}E(x)\,dx,
$$

and

$$
S_X(E)=\int_X^{2X}\left(P_X(t)^2+Q_X(t)^2\right)dt.
\tag{7}
$$

The generic analogue of `CoarsePrimitiveBound` requires, for every
$\varepsilon>0$, a constant $C_\varepsilon>0$ such that

$$
S_{2^k}(E)\le C_\varepsilon(2^k)^{4+\varepsilon}
\qquad(k\ge0).
\tag{8}
$$

## A PNT-compatible countermodel

Choose a smooth extension on a bounded initial interval and set

$$
E_0(x)=\frac{x}{\log x}
\qquad(x\ge e^2).
\tag{9}
$$

Then $E_0(x)=o(x)$. On this range,

$$
h(x):=E_0'(x)=\frac1{\log x}-\frac1{(\log x)^2},
\qquad
|h'(x)|\le\frac1{x(\log x)^2}.
\tag{10}
$$

For sufficiently large $N$, the support condition (2) keeps
$x=N+Hv$ inside $[N/2,2N]$. Changing variables in (5) and using the first
relation in (3) gives

$$
\mathcal R_{E_0}(N,T)
=\frac H{\sqrt N}\int_{\mathbb R}G_T(v)
\bigl(h(N+Hv)-h(N)\bigr)\,dv.
\tag{11}
$$

The mean value theorem yields

$$
|h(N+Hv)-h(N)|
\ll \frac{|v|}{T(\log N)^2}.
\tag{12}
$$

Equations (4), (11), and $H=N/T$ imply

$$
\boxed{
|\mathcal R_{E_0}(N,T)|
\ll \frac{\sqrt N}{T^2(\log N)^2}.}
\tag{13}
$$

The second relation in (3) cancels the first logarithmic Taylor term as well
and improves (13) to
$O(\sqrt N/(T^3(\log N)^3))$. The weaker bound (13) already suffices.

For $N=T^\lambda$ throughout the complete live range,

$$
\frac{\sqrt N}{T^2}
=T^{\lambda/2-2}\le T^{-27/28}.
\tag{14}
$$

Thus the countermodel satisfies (6), uniformly, for every fixed
$0<\rho<27/28$.

Its coarse energy is much larger. For every sufficiently large $X$ and every
$t\in[3X/2,2X]$,

$$
P_X(t)\ge\int_X^{3X/2}\frac{x}{\log x}\,dx
\ge\frac{X^2}{2\log(2X)}.
\tag{15}
$$

Consequently,

$$
\boxed{
S_X(E_0)\ge
\int_{3X/2}^{2X}P_X(t)^2\,dt
\ge\frac{X^5}{8\log^2(2X)}.}
\tag{16}
$$

For any fixed $0<\varepsilon<1$, the ratio of (16) to
$X^{4+\varepsilon}$ tends to infinity, including along $X=2^k$. Therefore
(8) fails.

## What the example proves

The zero-mean packet suppresses a slowly varying local density. The coarse
primitive energy sees the large low-frequency value of $E_0$ itself. Even both
pole-null moments leave this separation intact.

The countermodel has the exact packet profile, support, normalization and
moments. It has a nonnegative eventual source density and satisfies
$E_0(x)=o(x)$. It therefore refutes any implication based only on those
functional premises.

It does not have the arithmetic identities of the actual von Mangoldt measure:
integer support, prime-power weights, Möbius convolution, the Euler product,
or the zeta explicit formula. A future actual-source bridge could still use
such information. That bridge must independently recover the full coarse
energy, including the low-frequency and constant directions missed by the
packet. A complete translated and dilated frame is one possible method, but
this note does not claim that it is necessary.

## Conclusion

A fixed-power estimate for the current zero-mean packet does not imply the
generic coarse primitive bound, even when it holds over the complete live
parameter range and the error satisfies qualitative PNT. The current packet
program is therefore not connected to the kernel-verified conditional RH chain
without an additional theorem specific to the actual $\Lambda$ sequence.
