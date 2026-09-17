# Suzuki's exponential boundary layer and an enlarged unconditional window

This note examines the [Suzuki sign target](suzuki-hankel-uniform-sign-target.md) at \(x=\exp(c/\omega)\), where the first-order expansion of the Jordan coefficients used in the [polynomial-window theorem](suzuki-hankel-small-omega-structural-window.md) no longer applies. An exact gamma-kernel moment cancels the smooth Jordan density. It leaves a signed arithmetic discrepancy, for which no unconditional pointwise sign or limiting profile at fixed \(c>0\) is proved here. A quantitative prime number theorem does extend the unconditional \(R_\omega(x)\to1\) window beyond every fixed multiple of \(\omega^{-2}\), while still short of the exponential scale.

Write
\[
k_\omega(t)=g_\omega^{\langle1\rangle}(t),\qquad
R_\omega(x)=\frac1{\sqrt x}\sum_{n\le x}c_\omega(n)k_\omega(n/x),\qquad
c_\omega(n)=n^\omega\prod_{p\mid n}(1-p^{-2\omega}),
\tag{1}
\]
with \(k_\omega(1)=0\), as in [Suzuki, (2.1) and (A.1)–(A.2)](https://arxiv.org/html/1204.1827v2).

## Exact cancellation of the smooth density

**Proposition 1 (zero moment).** For every \(0<\omega\le 1/2\),
\[
\boxed{\displaystyle\int_0^1t^\omega k_\omega(t)\,dt=0.}
\tag{2}
\]
All integrals in the following proof are absolutely convergent at fixed \(\omega>0\). From \(k_\omega(t)=t^{-1/2}\int_t^1y^{-1/2}g_\omega(y)\,dy\), Fubini gives
\[
\int_0^1t^\omega k_\omega(t)\,dt
=\frac1{\omega+1/2}\int_0^1y^\omega g_\omega(y)\,dy.
\tag{3}
\]
Use [Suzuki's explicit \(g_\omega\)](https://arxiv.org/html/1204.1827v2): after removing its common factor \(2\pi^\omega/\Gamma(\omega)\), the last integral is
\[
\int_0^1y^2(1-y^2)^{\omega-1}\,dy
-\omega\int_0^1y^{2\omega-1}
   \int_{y^2}^1u^{1/2-\omega}(1-u)^{\omega-1}\,du\,dy.
\tag{4}
\]
The first term is \(\tfrac12B(3/2,\omega)\). Reversing the order in the second makes it \(\tfrac12B(3/2,\omega)\) as well, proving (2).

This is also visible in the exact Mellin factorization. Put \(v=s+1/2\). Initially for \(\Re s>1/2+\omega\), [Suzuki's Proposition A.3](https://arxiv.org/html/1204.1827v2) and the Jordan Dirichlet series give
\[
\int_1^\infty R_\omega(x)x^{-s-1}\,dx
=\frac1s\frac{\xi(v-\omega)}{\xi(v+\omega)}
=\frac1s\frac{\zeta(v-\omega)}{\zeta(v+\omega)}G_\omega(s),
\tag{5}
\]
where
\[
G_\omega(s)=\pi^\omega
\frac{(v-\omega)(v-\omega-1)}{(v+\omega)(v+\omega-1)}
\frac{\Gamma((v-\omega)/2)}{\Gamma((v+\omega)/2)},\qquad
\int_0^1k_\omega(t)t^{s-1/2}\,dt=\frac{G_\omega(s)}s.
\tag{6}
\]
The last identity begins in a common convergence half-plane and extends to \(s=1/2+\omega\) by the convergent kernel integral. At that point \(v=1+\omega\), so the factor \(v-\omega-1\) vanishes. It cancels exactly the pole of \(\zeta(v-\omega)/\zeta(v+\omega)\) at the same point. The direct proof above does not depend on analytic continuation.

Set
\[
a_\omega=\frac1{\zeta(1+2\omega)},\quad
C_\omega(y)=\sum_{n\le y}c_\omega(n),\quad
E_\omega(y)=C_\omega(y)-\frac{a_\omega}{1+\omega}y^{1+\omega}\quad(y\ge0).
\tag{7}
\]
The subtracted term is the ordinary summatory main term at every fixed \(\omega>0\): \(a_\omega\) is the residue of \(\zeta(v-\omega)/\zeta(v+\omega)\) at \(v=1+\omega\). Directly, \(C_\omega(y)=\sum_{d\le y}\mu(d)d^{-\omega}\sum_{m\le y/d}m^\omega\sim a_\omega y^{1+\omega}/(1+\omega)\), by the power-sum asymptotic and absolute convergence of \(\sum_d\mu(d)d^{-1-2\omega}\). Equation (2) yields the **exact** signed-discrepancy representation
\[
\boxed{\displaystyle
R_\omega(x)=\frac1{\sqrt x}\int_{0^-}^{x}k_\omega(y/x)\,dE_\omega(y).}
\tag{8}
\]
Indeed \(dE_\omega=dC_\omega-a_\omega y^\omega dy\), and the smooth term equals \(a_\omega x^{1/2+\omega}\int_0^1t^\omega k_\omega(t)dt=0\). The integral at \(y=0\) converges because \(y^\omega k_\omega(y/x)=O(y^{2\omega-1})+O(y^{\omega-1/2})\). Thus replacing the Jordan coefficients by their positive smooth density gives **zero**, rather than a positive approximation to \(R_\omega\).

### The centered counting clock at the origin of the parameter

The exact discrepancy in (7) has the original centered prime-power
source as its first variation. Extend \(a_\omega\) to \(\omega=0\)
by \(a_0=0\). The pole of \(\zeta\) at one gives
\(a_\omega=2\omega+O(\omega^2)\). For each fixed \(y\ge0\),
\(C_\omega(y)\) is a finite sum, and the
[compiled coefficient identity](suzuki-coefficient-prime-history-variation.md)
gives \(c'_0(n)=2\Lambda(n)\). The finite prefix identity
\(C'_0(N)=2\psi(N)\) is also compiled in
[SuzukiCoefficientVariation.lean](../../formalization/BuildingBlocks/SuzukiCoefficientVariation.lean).
The derivative of \(a_\omega\) supplies the continuous centering.
Consequently the right derivative is
\[
\boxed{\quad
\left.\partial_{\omega+}E_\omega(y)\right|_{\omega=0}
  =2\bigl(\psi(y)-y\bigr),\qquad
\psi(y)=\sum_{n\le y}\Lambda(n).
\quad}
\tag{8a}
\]
The baseline is \(E_0(y)=\mathbf1_{\{y\ge1\}}\); its derivative,
not its value, is the centered Chebyshev discrepancy. Taking one
ordinary counting step yields the complete arrival law
\[
\left.\partial_{\omega+}
 \bigl(E_\omega(N+1)-E_\omega(N)\bigr)\right|_{\omega=0}
  =2\bigl(\Lambda(N+1)-1\bigr)
  \qquad(N\in\mathbb N).
\tag{8b}
\]
This retains every prime power and the \(N=0\) endpoint.
It does not sign \(E_\omega\) or \(R_\omega\): (8) pairs the signed
discrepancy with a gamma kernel that changes sign, and differentiating
\(R_\omega\) also differentiates that kernel. The analytic zeta-pole
normalizer and the full identities (8a)--(8b) are written, not Lean
formalized.

For \(x=e^{c/\omega}\), the exact scaled Laplace identity is
\[
\int_0^\infty R_\omega(e^{c/\omega})e^{-zc}\,dc
=\frac1z\frac{\xi(1/2+\omega(z-1))}{\xi(1/2+\omega(z+1))},
\qquad \Re z>1+\frac1{2\omega}.
\tag{9}
\]
The indicated half-plane is essential: it is where the defining integral is known to converge unconditionally. The right side tends to \(1/z\) at each fixed \(z\ne0\) after meromorphic continuation, but that fact alone cannot be inverted into a scaling limit, since fixed \(z\) lies outside the original convergence half-plane for small \(\omega\).

The first-order Jordan approximation fails precisely here. For a prime \(p\), put \(u=\omega\log p\). Its **exact** coefficient is \(c_\omega(p)=2\sinh u\), while \(2\omega\Lambda(p)=2u\). Likewise, the negative small-\(t\) gamma term has sampled mass proportional to
\[
\int_{1/x}^1\omega t^{\omega-1}dt=1-e^{-c}.
\tag{10}
\]
Both effects are order one for fixed \(c>0\). Formula (8) retains all distinct-prime orders and the full gamma factor.

If a simple zero \(\rho=\beta+i\gamma\) of \(\xi\) has \(\beta>1/2\), the meromorphic transform in (5) has, for sufficiently small \(\omega\), a pole at \(s_\rho=\rho-1/2-\omega\) with residue
\[
\frac{\xi(\rho-2\omega)}{s_\rho\xi'(\rho)}
=-\frac{2\omega}{\rho-1/2}+O(\omega^2).
\tag{11}
\]
Its **individual formal inverse-Mellin mode** at \(x=e^{c/\omega}\) has magnitude of order
\(\omega\exp(c(\beta-1/2)/\omega-c)\) and oscillating phase \(e^{i\gamma c/\omega}\). This is a pole obstruction, not a pointwise lower bound: other poles and the contour remainder can cancel it. No unconditional sign, divergence, or pointwise limit at fixed \(c>0\) follows from (11).

## A larger unconditional window

**Theorem 2.** Let \(L=\log(1/\omega)\). Then
\[
\boxed{\displaystyle
\lim_{\omega\downarrow0}\ \sup_{2\le x\le
\omega^{-2}\exp(\frac14\sqrt L)}|R_\omega(x)-1|=0.}
\tag{12}
\]
In particular, \(R_\omega(x)>1/2\) throughout this range for all sufficiently small \(\omega\). The upper endpoint exceeds every fixed multiple of \(\omega^{-2}\), while \(\omega\log x\to0\) uniformly throughout the range. It does not enter the fixed-\(c\) boundary layer.

**Proof.** We use the [explicit prime number theorem bound of Johnston–Yang](https://arxiv.org/abs/2204.01980),
\(
|\psi(y)-y|\le9.39y(\log y)^{1.515}e^{-0.8274\sqrt{\log y}}
\) for \(y\ge2\). Partial summation, splitting its error integral at \(\sqrt x\), gives, with an absolute constant,
\[
P_0(x):=\frac1x\sum_{n\le x}\Lambda(n)(n/x)^{-1/2}
=2+O(e^{-\frac15\sqrt{\log x}}).
\tag{13}
\]
For clarity, the part below \(\sqrt x\) is \(O(x^{-1/4})\); on \([\sqrt x,x]\), the logarithmic power is absorbed in the exponential, leaving a bound stronger than \(e^{-\frac15\sqrt{\log x}}\).

The two complementary incomplete-beta terms in [Suzuki's kernel (A.1)](https://arxiv.org/html/1204.1827v2) imply, uniformly for \(0<\omega\le1/4\) and \(0<t<1\),
\[
|k_\omega(t)-t^{-1/2}|
\le K\omega t^{-1/2}\bigl(1+|\log(1-t^2)|\bigr)
   +K\omega t^{\omega-1}.
\tag{14}
\]
Indeed the complete-beta coefficient of the positive term is \(B_\omega=1+O(\omega)\), while its missing lower beta fraction is at most \(K\omega|\log(1-t^2)|\); the entire negative term is at most \(K\omega t^{\omega-1}\). In the prime sum, at most one integer lies in \((x-1,x]\); its contribution to the difference between \(k_\omega\) and \(t^{-1/2}\) is \(O(\log(2x)/x)\). For the others, \(|\log(1-(n/x)^2)|\le\log x\). Using \(\psi(x)\ll x\) and partial summation for \(\sum_{n\le x}\Lambda(n)n^{\omega-1}\) gives
\[
\frac1x\sum_{n\le x}\Lambda(n)k_\omega(n/x)
=P_0(x)+O\!\left(\omega\log(2x)+\frac{\log(2x)}x\right).
\tag{15}
\]

For \(x\le\omega^{-2}e^{\sqrt L/4}\), we have \(\omega\log x=o(1)\). The exact Jordan coefficients consequently satisfy, uniformly for \(2\le n\le x\),
\[
c_\omega(n)=2\omega\Lambda(n)+O(\omega^2(\log n)^2).
\tag{16}
\]
The kernel majorant \(|k_\omega(t)|\le K(t^{-1/2}+\omega t^{\omega-1})\) bounds the resulting error in (1) by
\(O(\omega^2\sqrt x(\log x)^2+\omega^3\sqrt x(\log x)^3)\).
For \(x\ge\omega^{-1}\), the small-\(t\) beta expansion supplies
\[
\frac{k_\omega(1/x)}{\sqrt x}
=B_\omega-A_\omega x^{1/2-\omega}+O(x^{-5/2+\omega}),
\qquad B_\omega=1+O(\omega),\quad A_\omega=4\omega+O(\omega^2).
\tag{17}
\]
Combining (13)–(17), with \(\lambda=\omega\sqrt x\), proves uniformly on \(\omega^{-1}\le x\le\omega^{-2}e^{\sqrt L/4}\) that
\[
|R_\omega(x)-1|\ll
\omega+x^{-5/2+\omega}
+\lambda e^{-\frac15\sqrt{\log x}}
+\omega\lambda(\log x)^2
+\omega^2\lambda(\log x)^3.
\tag{18}
\]
Here \(\lambda\le e^{\sqrt L/8}\) and \(\log x\ge L\), so the prime-number-theorem term is at most \(e^{-3\sqrt L/40}\); all other terms vanish as well. On \(2\le x\le\omega^{-1}\), the [previous polynomial-window theorem](suzuki-hankel-small-omega-structural-window.md) applies with \(C=1\). This proves (12). ∎

## What RH would give on the exponential scale

Under RH, every \(\Theta_\omega\) is inner. In [Suzuki's boundary Fourier identity (A.5)](https://arxiv.org/html/1204.1827v2), innerness places the inverse Fourier transform of \((1-\Theta_\omega(u))/u\) on \(y=\log x\ge0\). Plancherel therefore gives
\[
\int_0^\infty|1-R_\omega(e^y)|^2\,dy
=\frac1{2\pi}\int_{\mathbb R}
 \left|\frac{1-\Theta_\omega(u)}u\right|^2du
\longrightarrow0\qquad(\omega\downarrow0).
\tag{19}
\]
For the limit, \(\Theta_\omega(u)\to1\) for almost every real \(u\). The quotient is uniformly \(O(\omega)\) near \(u=0\), because \(\xi'(1/2)=0\) and \(\xi(1/2)\ne0\); away from zero it is bounded by \(2/|u|\). Dominated convergence applies. With \(F_\omega(c)=R_\omega(e^{c/\omega})\), changing variables in (19) yields
\[
\int_0^\infty|F_\omega(c)-1|^2dc=o(\omega).
\tag{20}
\]
In particular, under RH the set of \(c>0\) with \(F_\omega(c)\le1/2\) has measure \(o(\omega)\), by Chebyshev's inequality. Thus RH supplies a controlled \(L^2\) scaling limit equal to \(1\), including every compact fixed-\(c\) interval. Equation (20) alone gives no pointwise convergence or pointwise positivity. Suzuki's separate \(R_\omega(x)\to1\) theorem is for each fixed \(\omega\) under RH and is likewise not uniform at \(x=e^{c/\omega}\). Unconditionally, (2), (8), and (12) are the conclusions established here; the fixed-\(c\) sign and pointwise limit remain open.

There is an exact converse at the level of **mean-square finiteness**:
\[
\boxed{\displaystyle
\mathrm{RH}\quad\Longleftrightarrow\quad
\exists\,\omega_0>0\ \forall\,0<\omega<\omega_0:
\int_0^\infty|F_\omega(c)-1|^2dc<\infty.}
\tag{21}
\]
Indeed, after \(c=\omega\log x\), finiteness is precisely [Suzuki's Theorem A.1(2)](https://arxiv.org/html/1204.1827v2) and makes \(\Theta_\omega\) inner. If RH fails at a zero \(\rho=\beta+i\gamma\) with \(\beta>1/2\), then for every sufficiently small \(0<\omega<\beta-1/2\), the denominator of \(\Theta_\omega\) vanishes at the upper-half-plane point \(z=i(\rho-1/2-\omega)\), while its numerator \(\xi(\rho-2\omega)\) is nonzero by isolation of zeros. Hence the integral in (21) is infinite. The forward implication follows from innerness under RH. The decay rate in (20) therefore describes an RH-strength family condition, not an unconditional estimate.
