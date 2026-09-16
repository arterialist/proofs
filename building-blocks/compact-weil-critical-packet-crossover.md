# A critical-scale crossover for compact Weil divisor packets

The [positive boundary-packet theorem](compact-weil-boundary-packet-growing-positive-space.md)
uses frequencies above \(e^{2L}\), and its
[divisor-matrix addendum](compact-weil-divisor-matrix-sharpness.md)
shows that the prime cost has leading size \(2L\). This note holds
the ratio of packet frequency to the number of divisor labels fixed.
It keeps the signed gamma kernel and both pole moments. The result is
a form limit on specified log-shell profiles and a finite, positive
residual for the Perron profile. It is not a full-window estimate.

Fix \(0<\delta<1\), a real \(p\in C_c^\infty(-\delta,0)\) with
\(\|p\|_2=1\), and \(c>4\). For integers \(N\to\infty\), put
\[
 L_N=\tfrac12\log(N+1),\quad R_N=\log N,\quad T_N=cN,\quad
 x_n=L_N-\log n,\quad
 p_n(x)=\sqrt{T_N}\,p(T_N(x-x_n)).
 \tag{1}
\]
For all sufficiently large \(N\), the \(p_n\), \(1\le n\le N\),
are orthonormal and supported in \((-L_N,L_N)\). Their prime
compression is exactly the matrix \(A_N\) in the addendum.
For \(h\in C[0,1]\), define
\[
 W_{N,h}=\sum_{n=1}^N n^{-1/2}
 h\!\left(\frac{\log n}{R_N}\right)p_n,\qquad
 F_N=\frac{W_{N,1}}{\sqrt{H_N}},
 \quad H_N=\sum_{n\le N}\frac1n.
 \tag{2}
\]
Let \(Q_{L_N}\) be the complete compact Weil form (2) in the
boundary-packet theorem, with the actual pole, gamma multiplier,
and all admitted von Mangoldt prime powers.

**Theorem.** For each fixed \(h\in C[0,1]\),
\[
 \lim_{N\to\infty}\frac{Q_{L_N}(W_{N,h})}{R_N^2}
 =\int_0^1|h(s)|^2ds-\left|\int_0^1h(s)ds\right|^2.
 \tag{3}
\]
Thus the leading log-shell form is \(I-|1\rangle\langle1|\).
Its constant profile is the only null direction within this
fixed-profile limit.

Write
\[
 \mu_p=\int_{\mathbb R}p(s)ds,\qquad
 g_p=\frac1{2\pi}\int_{\mathbb R}
   \log\frac{|u|}{2\pi}\,|\widehat p(u)|^2du.
 \tag{4}
\]
The normalized constant profile has the finite residual
\[
 \boxed{\quad
 \lim_{N\to\infty}Q_{L_N}(F_N)
 =\log c+\gamma+g_p+\frac{\mu_p^2}{c}>0.
 \quad}
 \tag{5}
\]
Indeed the support-width bound
\[
 g_p\ge\log\frac1{2\delta}-1
 \tag{6}
\]
makes the right side of (5) greater than
\(\log 2+\gamma-1>0\) for \(c>4\) and \(\delta<1\).

## Prime and leading log-shell limit

The packets are disjoint because their centers have minimum
separation \(\log(N/(N-1))\sim1/N\), their support width is
less than \(\delta/(cN)\), and the last center is
\(\log((N+1)/N)\sim1/N\) from the left endpoint. The sufficient
condition \(T_N>4(N+1)\) from the preceding theorem holds for
large \(N\).

Let \(\nu_N\) be \(R_N^{-1}\) times the harmonic point measure
\(\sum_{n\le N}n^{-1}\delta_{\log n/R_N}\), and let \(\eta_N\)
be \(R_N^{-1}\sum_{2\le d\le N}(\Lambda(d)/d)
\delta_{\log d/R_N}\). The elementary factorial/Chebyshev
estimate in the addendum gives, uniformly for \(0\le s\le1\),
\[
 \nu_N([0,s])=s+O(R_N^{-1}),\qquad
 \eta_N([0,s])=s+O(R_N^{-1}).
 \tag{7}
\]
Both measures therefore converge weakly to Lebesgue measure
on \([0,1]\). The exact divisor edges give
\[
 \begin{aligned}
 \langle W_{N,h},K_{L_N}W_{N,h}\rangle
 =2\Re\sum_{\substack{n\ge1,\ d\ge2\\nd\le N}}
 \frac{\Lambda(d)}{nd}\,
 \overline{h(\log n/R_N)}
 h((\log n+\log d)/R_N).
 \end{aligned}
 \tag{8}
\]
The triangular boundary has zero limiting product measure.
Changing variables from \((s,t)\) to \((s,s+t)\) gives
\[
 R_N^{-2}\langle W_{N,h},K_{L_N}W_{N,h}\rangle
 \longrightarrow
 2\Re\int_{0\le s<u\le1}\overline{h(s)}h(u)\,ds\,du
 =\left|\int_0^1h\right|^2.
 \tag{9}
\]
Similarly \(\|W_{N,h}\|_2^2/R_N\to\int_0^1|h|^2\).

## Signed gamma and pole correction

Let \(H(t)=\Re\psi(1/4+it/2)-\log\pi\) as before, and
\(q(t)=H(t)-\log(|t|/(2\pi))\) for \(t\ne0\).
The [digamma asymptotic](https://dlmf.nist.gov/5.11.E2) gives
\(q\in L^1(\mathbb R)\).
For \(\kappa_p(s)=(2\pi)^{-1}\int
\log(|u|/(2\pi))|\widehat p(u)|^2e^{isu}du\),
the gamma matrix on these packets has entries
\[
 G_{nm}=(\log T_N)\delta_{nm}
        +\kappa_p(T_N\log(m/n))
        +O(T_N^{-1}),
 \tag{10}
\]
where the error is uniform in \(n,m\). The constant
\(\log T_N\) has zero off-center overlap because the packets
are disjoint. Abel regularization of the Fourier transform of
\(\log|u|\) gives, whenever \(|s|>\delta\),
\[
 \kappa_p(s)
 =-\frac12\iint_{\mathbb R^2}
       \frac{p(v)p(w)}{|s+v-w|}\,dv\,dw.
 \tag{11}
\]
No contact term contributes in (11).

For \(n<m\), \(s=T_N\log(m/n)>c+o(1)>\delta\).
The two elementary sums
\[
 \begin{aligned}
 B_N&=\sum_{n<m\le N}
       \frac1{\sqrt{nm}\log(m/n)}
       =N\log N+O(N),\\
 C_N&=\sum_{n<m\le N}
       \frac1{\sqrt{nm}\log^2(m/n)}
       =O(N^2)
 \end{aligned}
 \tag{12}
\]
show, by expanding the denominator in (11), that
\[
 \sum_{n\ne m}\frac{\kappa_p(T_N\log(m/n))}{\sqrt{nm}}
 =-\frac{\mu_p^2}{T_N}B_N+O(C_N/T_N^2)
 =-\frac{\mu_p^2}{c}\log N+O(1).
 \tag{13}
\]
For (12), compare the first summand with \(1/(m-n)\)
when \(m\le2n\): the error is \(O(1/n)\).
The region \(m>2n\) contributes \(O(N)\) to \(B_N\);
\(\sum_{n<m}1/(m-n)=N\log N+O(N)\).
The same near/far split gives \(C_N=O(N^2)\).
The uniform \(O(T_N^{-1})\) error in (10) contributes
\(O((\sum n^{-1/2})^2/T_N)=O(1)\) to the unnormalized
quadratic form. Therefore, on \(F_N\),
\[
 \Gamma(F_N)=\log T_N+g_p-\frac{\mu_p^2}{c}+o(1).
 \tag{14}
\]
For general fixed \(h\), (10)--(12) give
\(\Gamma(W_{N,h})=(\log T_N)\|W_{N,h}\|_2^2+O_h(R_N)\).

The two pole moments of \(F_N\) are exact up to the fixed profile
integrals \(\mu_\pm(T)=\int p(s)e^{\pm s/(2T)}ds\):
\[
 E_+(F_N)=\frac{e^{L_N/2}\sqrt{H_N}}{\sqrt{T_N}}\mu_+(T_N),
 \qquad
 E_-(F_N)=\frac{e^{-L_N/2}N}{\sqrt{T_NH_N}}\mu_-(T_N).
 \tag{15}
\]
Thus
\[
 2\Re(E_+(F_N)\overline{E_-(F_N)})
 =\frac{2N}{T_N}\mu_+(T_N)\mu_-(T_N)
 \longrightarrow\frac{2\mu_p^2}{c}.
 \tag{16}
\]
For general fixed \(h\), the pole form is \(O_h(R_N)\).
The addendum gives the exact-prime Rayleigh value
\[
 \langle F_N,K_{L_N}F_N\rangle
 =\frac{2\sum_{m\le N}(\log m)/m}{H_N}
 =\log N-\gamma+o(1).
 \tag{17}
\]
Combining (14), (16), and (17) proves (5);
combining (9) with the leading gamma estimate proves (3).

Finally, \(|\widehat p(u)|\le\|p\|_1\le\sqrt\delta\),
so the probability density
\((2\pi)^{-1}|\widehat p(u)|^2\) is bounded by
\(\delta/(2\pi)\). Put \(A=\pi/\delta\). The product of
\(\log(|u|/A)\) with the difference between this density and
\(\frac{\delta}{2\pi}\mathbf1_{\{|u|\le A\}}\) is nonnegative
pointwise, and both densities have total mass one. Integrating
proves that filling the ceiling on \(|u|\le A\) minimizes the
logarithmic moment. Direct integration gives (6).
The inequality \(\gamma>1-\log2\) follows, for instance, from
\(H_n-\log(n+1)>1-\log2\) for \(n>1\).

## Scope

Equation (3) is convergence on each fixed continuous log-shell
profile, not uniform convergence of the full growing packet matrix.
Its leading null direction has the positive finite residual (5);
the estimate does not bound arbitrary vectors in the packet span.
The scale \(T_N=cN\) is the resolved transition \(T\asymp e^{2L_N}\),
not the lower-frequency regime \(T/N\to0\). No negative test for the
actual von Mangoldt Weil form or full compact-test positivity follows.
