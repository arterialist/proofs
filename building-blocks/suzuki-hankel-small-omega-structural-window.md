# A polynomial small-parameter window for Suzuki's arithmetic Hankel kernel

This note supplies an unconditional analytic lower bound on a growing part of the [proposed uniform Suzuki sign target](suzuki-hankel-uniform-sign-target.md). The proof uses the actual Jordan-totient coefficients, Suzuki's gamma kernel, and the prime number theorem. It does not settle the target at any fixed positive parameter for all large \(x\), and it gives no RH or new local Weil positivity theorem.

Write \(k_\omega=g_\omega^{\langle1\rangle}\) and
\[
R_\omega(x):=\sqrt{x}\,h_\omega^{\langle1\rangle}(x)
 =\frac1{\sqrt x}\sum_{n\le x}c_\omega(n)k_\omega(n/x),
\qquad
c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}),
\tag{1}
\]
with \(k_\omega(1)=0\). These are [Suzuki's equations (2.1), (A.1), and (A.2)](https://arxiv.org/html/1204.1827v2). His Mellin identity also gives, initially for real \(s>1/2+\omega\),
\[
\int_1^\infty R_\omega(x)x^{-s-1}\,dx
 =\frac1s\Theta_\omega(is)
 =\frac1s\frac{\xi(s+1/2-\omega)}{\xi(s+1/2+\omega)}.
\tag{2}
\]
The ratio tends to \(1\) as \(\omega\downarrow0\), but pointwise convergence of this transform alone gives no uniform inverse-Mellin bound. The following theorem gives one such bound on a polynomial range.

The functional equation gives \(\xi(1/2-\omega)=\xi(1/2+\omega)\), so the meromorphic continuation of (2) has residue exactly \(1\) at \(s=0\). This fixes the baseline in (3). It does not control the inverse-Mellin remainder or exclude poles away from \(s=0\); the proof below retains the actual prime-power terms that compensate the gamma contribution on the stated range.

## Uniform theorem at the first gamma sign scale

**Theorem.** For every fixed \(C>0\),
\[
\boxed{\quad
\lim_{\omega\downarrow0}
\sup_{2\le x\le C/\omega^2}|R_\omega(x)-1|=0.
\quad}
\tag{3}
\]
In particular, for each \(C\) there is an \(\omega_C>0\) such that
\(R_\omega(x)>1/2\) whenever \(0<\omega<\omega_C\) and
\(2\le x\le C/\omega^2\). The constant \(\omega_C\) is not made effective here. [Suzuki's one-sign hypothesis](https://arxiv.org/html/1204.1827v2) concerns the entire tail \(x\ge x_\omega\) at each fixed \(\omega\); (3) does not meet it.

### Gamma kernel

For \(0<\omega<1/2\), Suzuki's incomplete-beta formula can be expanded at \(t=0\) as
\[
k_\omega(t)=B_\omega t^{-1/2}
              -A_\omega t^{\omega-1}+O(t^{2-\omega})
\qquad(0<t\le1/2),
\tag{4}
\]
where the error is uniform for \(0<\omega\le1/4\), and
\[
A_\omega=\frac{4\omega}{1-2\omega}\,\pi^\omega
             \frac{\Gamma(3/2-\omega)}{\Gamma(3/2)},
\qquad
B_\omega=\frac{1+2\omega}{1-2\omega}\,\pi^\omega
             \frac{\Gamma(5/4-\omega/2)}{\Gamma(5/4+\omega/2)}.
\tag{5}
\]
Thus \(A_\omega=4\omega+O(\omega^2)\) and \(B_\omega=1+O(\omega)\). The same beta formula supplies the uniform majorant
\[
|k_\omega(t)|\le K\left(t^{-1/2}+\omega t^{\omega-1}\right)
\qquad(0<t<1,\ 0<\omega\le1/4),
\tag{6}
\]
and \(k_\omega(t)\to t^{-1/2}\) uniformly on each compact subinterval of \((0,1)\). To obtain (4)--(6), replace each complementary incomplete beta integral by its complete beta value minus its integral from \(0\) to \(t^2\). The complete beta terms give (5); on \(t\le1/2\), the omitted integrals contribute \(O(t^{2-\omega})\). Complete beta bounds give (6) on the full interval.

The two leading terms in (4) change dominance around
\(t^{1/2-\omega}=A_\omega/B_\omega\), whose small-\(\omega\) scale is \(t\asymp16\omega^2\). Thus \(x\asymp\omega^{-2}\) is exactly where the \(n=1\) summand first exposes the gamma factor's negative small-\(t\) side.

### Actual arithmetic compensation

Let \(\omega\downarrow0\) and \(x=x_\omega\to\infty\) with
\(\omega\sqrt x\) bounded. Then \(\omega\log x\to0\). For every
\(2\le n\le x\), the actual coefficients satisfy, uniformly in \(n\),
\[
c_\omega(n)=2\omega\Lambda(n)
                   +O\bigl(\omega^2(\log n)^2\bigr).
\tag{7}
\]
For a prime power this follows by expanding
\(n^\omega(1-p^{-2\omega})\); for an integer with at least two distinct prime factors, two of the factors \(1-p^{-2\omega}\) already supply \(O(\omega^2(\log n)^2)\). The bound \(n^\omega=O(1)\) is uniform because \(\omega\log x\to0\).
The [coefficient-variation note](suzuki-coefficient-prime-history-variation.md)
identifies \(c'_0(n)=2\Lambda(n)\) exactly, with a compiled Lean proof.
That pointwise derivative does not itself give the uniform remainder in
(7); the prime-power and two-factor estimates above supply it.

By (6), the contribution of the error in (7) to (1) is
\[
O\left(\omega^2\sqrt x(\log x)^2
       +\omega^3\sqrt x(\log x)^3\right)=o(1).
\tag{8}
\]
The \(n=1\) term has the exact two-term expansion (4), so
\[
\frac{k_\omega(1/x)}{\sqrt x}
 =B_\omega-A_\omega x^{1/2-\omega}+o(1)
 =1-4\omega\sqrt x+o(1).
\tag{9}
\]

The [prime number theorem](https://dlmf.nist.gov/25.16.i), in the form \(\psi(y)=\sum_{n\le y}\Lambda(n)\sim y\), gives the weighted limit
\[
\frac1x\sum_{n\le x}\Lambda(n)k_\omega(n/x)
 \longrightarrow\int_0^1t^{-1/2}\,dt=2.
\tag{10}
\]
Here is the needed uniform-integrability check. On \([\delta,1-\delta]\), the kernel converges uniformly and the rescaled prime measure \(x^{-1}\sum\Lambda(n)\delta_{n/x}\) converges weakly to Lebesgue measure. By (6) and \(\psi(y)\ll y\), the small-\(t\) contribution from \(t^{-1/2}\) is \(O(\sqrt\delta)\). The contribution from \(\omega t^{\omega-1}\) is \(O(\omega(1+\log x))=o(1)\), by partial summation. Near \(t=1\), the kernel is bounded and the prime mass is \(O(\delta)+o(1)\). Letting \(\delta\downarrow0\) proves (10).

The prime-power part of (1) is therefore
\[
\frac{2\omega}{\sqrt x}
 \sum_{n\le x}\Lambda(n)k_\omega(n/x)
 =4\omega\sqrt x+o(1),
\tag{11}
\]
which cancels the loss in (9). Equations (8)--(11) prove
\(R_\omega(x)\to1\) along every sequence with \(x\to\infty\) and
\(\omega\sqrt x\) bounded. On every fixed interval \(2\le x\le X\), the \(n=1\) term tends uniformly to \(1\), while all \(n\ge2\) terms are \(O_X(\omega)\). A sequence contradiction combines these two cases and proves (3).

## Fixed endpoint and global limit

At \(\omega=1/2\), \(c_{1/2}(n)=\varphi(n)/\sqrt n\) and (1) becomes
\[
R_{1/2}(x)=2\sum_{n<x}\frac{\varphi(n)}nG(n/x),
\quad
G(t)=2\sqrt{1-t^2}+\log t
       -\log(1+\sqrt{1-t^2}).
\tag{12}
\]
Here \(G'(t)=(1-2t^2)/(t\sqrt{1-t^2})\), so \(G\) is negative near \(0\) and positive near \(1\). Its mean vanishes **exactly**:
\[
\int_0^1G(t)\,dt
 =-\int_0^1tG'(t)\,dt
 =-\int_0^{\pi/2}\cos(2\theta)\,d\theta=0.
\tag{13}
\]
Thus replacing \(\varphi(n)/n\) by its average removes the leading mass; the positive value of (12) depends on the arithmetic remainder. The finite \((\omega,x)=(1/2,7)\) value and its limitation are recorded in the [target note](suzuki-hankel-uniform-sign-target.md).

For every fixed \(0<\omega<1/2\), (4) makes \(k_\omega(t)<0\) for sufficiently small \(t\), while Suzuki's \(g_\omega(t)\sim(2\pi)^\omega\Gamma(\omega)^{-1}(1-t)^{\omega-1}\) gives
\[
k_\omega(t)\sim\frac{(2\pi)^\omega}{\Gamma(1+\omega)}
                    (1-t)^\omega>0\qquad(t\uparrow1).
\tag{14}
\]
The gamma summands therefore have both signs, so coefficient positivity cannot prove the sign target term by term. A positive representation for the **complete** arithmetic sum remains possible, but (7)--(11) show that it must retain prime compensation.

For fixed \(\omega>0\), [Suzuki, Theorem A.1(5)](https://arxiv.org/html/1204.1827v2) gives \(R_\omega(x)=1+o(1)\) as \(x\to\infty\) **under RH**. That statement is not uniform as \(\omega\downarrow0\); (3) covers only \(x=O(\omega^{-2})\). At \(\omega=1/2\), innerness of \(\Theta_{1/2}\) is unconditional, but innerness alone is no pointwise lower bound for (12). The global half bound for all \(x\) and all \(0<\omega\le1/2\) remains unproved.

The proof's scale restriction is substantive. The negative gamma component in (4) contains \(\omega t^{\omega-1}\); its integral over the sampled range \(1/x<t<1\) is \(1-x^{-\omega}\), which becomes order one when \(\omega\log x\) is of order one. On such exponential scales, the coefficient expansion (7) also loses its uniform small error. The present argument supplies no sign there.

Even on polynomial scales \(x=\omega^{-a}\) with a fixed \(a>2\),
the cancellation in (9)--(11) needs more than the qualitative limit
(10): its error is multiplied by \(\omega\sqrt{x}=\omega^{1-a/2}\to\infty\).
Thus (10) alone gives an \(o(\omega\sqrt{x})\) remainder, not the
\(o(1)\) remainder used in (11). Extending this first-order argument
requires a quantitative weighted prime-discrepancy bound at that scale
or a different exact cancellation. This is a limitation of the stated
proof, not a claim that the wider sign target is false.
