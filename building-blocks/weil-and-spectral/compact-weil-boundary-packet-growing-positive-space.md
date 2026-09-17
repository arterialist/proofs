# A growing positive boundary-packet space for the complete Weil form

The [smooth-frequency leakage theorem](compact-weil-smooth-frequency-boundary-leakage.md)
produces an order-\(L\) commutator when a Fourier cutoff is compressed
to a Weil window. Here the incoming endpoint packet and translated copies
of a profile detected in that commutator generate a growing subspace.
On this subspace the complete von Mangoldt prime-power operator is an
**exact divisor matrix**, while the gamma energy has a larger
logarithmic scale. Keeping the pole and the mixed boundary block gives
an unconditional positive lower bound at every window size. This is a
signed theorem on a specified subspace, not positivity on the full
window.

## Setup and theorem

Use the Fourier convention \(\widehat f(t)=\int f(x)e^{itx}dx\).
For \(L>\frac12\log2\), let \(I=[-L,L]\), let \(M\) multiply by
\(\mathbf1_I\), and set
\[
 U_yf(x)=f(x-y),\quad c_n=\frac{2\Lambda(n)}{\sqrt n},\quad
 S_L=\frac12\sum_{2\le n<e^{2L}}c_n(U_{\log n}+U_{-\log n}),
 \quad K_L=MS_LM\big|_{L^2(I)}.
 \tag{1}
\]
The complete geometric Weil form for a compactly supported complex
smooth test is
\[
 Q_L(f)=2\Re\bigl(E_+(f)\overline{E_-(f)}\bigr)
 +\frac1{2\pi}\int_{\mathbb R}H(t)|\widehat f(t)|^2dt
 -\langle f,K_Lf\rangle,
 \quad E_\pm(f)=\int_I f(x)e^{\pm x/2}dx,
 \quad H(t)=\Re\psi\!\left(\frac14+\frac{it}{2}\right)-\log\pi.
 \tag{2}
\]
This is the normalization in [Suzuki, Section 2.4](https://arxiv.org/html/2606.09096v2)
and [Zhu, Sections 1.2 and 6.1](https://arxiv.org/html/2608.24827v2).
In particular, the pole has either sign on general tests.

Fix the real even smooth low-frequency cutoff \(\chi\) from the
[leakage note](compact-weil-smooth-frequency-boundary-leakage.md),
with convolution kernel \(k=\mathcal F^{-1}\chi\) and \(k(0)>0\).
Choose a small fixed \(0<\delta<1\) and a nonnegative real
\(\phi\in C_c^\infty(0,\delta)\), \(\|\phi\|_2=1\), so that
\[
 h(v)=\int_0^\delta k(v+u)\phi(u)du>0
 \quad\hbox{for all sufficiently small }v>0.
 \tag{3}
\]
Choose nonnegative real \(\eta\in C_c^\infty(0,\delta)\),
\(\|\eta\|_2=1\), supported where \(h>0\), and put
\(a=\int_0^\infty h(v)\eta(v)dv>0\). The two fixed local
profiles are \(p_-(s)=\phi(-s)\) and \(p_+(s)=\eta(s)\);
they are orthonormal and supported on opposite sides of zero.

For \(\varepsilon>0\), choose a constant \(C_\varepsilon\) as in the
proof below. At every \(L>\frac12\log2\), set
\[
 X=e^{2L},\qquad N=\lfloor X-1\rfloor,\qquad
 T=\exp\bigl(C_\varepsilon+(2+\varepsilon)L\bigr),\qquad
 x_n=L-\log n,
 \tag{4}
\]
and define packets
\[
 f_{n,\sigma}(x)=\sqrt T\,p_\sigma(T(x-x_n)),\qquad
 \begin{cases}
 \sigma=-,&1\le n\le N,\\
 \sigma=+,&2\le n\le N.
 \end{cases}
 \quad
 V_{L,\varepsilon}=\operatorname{span}\{f_{n,\sigma}\}.
 \tag{5}
\]
For sufficiently large fixed \(C_\varepsilon\), all these packets
belong to \(C_c^\infty(I)\) and form an orthonormal family. The
\(+\) packet at \(n=1\) is omitted because it would extend beyond
the right endpoint.

**Theorem.** For every \(\varepsilon>0\) there is a fixed
\(C_\varepsilon\), depending only on \(\varepsilon,\phi,\eta\),
such that for **every** \(L>\frac12\log2\) and every complex
\(f\in V_{L,\varepsilon}\),
\[
 \boxed{\quad Q_L(f)\ge\frac{\varepsilon L}{2}\|f\|_2^2.\quad}
 \tag{6}
\]
The dimension is \(2\lfloor e^{2L}-1\rfloor-1\sim2e^{2L}\).
Writing \(E_{L,T}=M\chi(D/T)M\) and \(\Pi_V\) for the orthogonal
projection onto \(V_{L,\varepsilon}\), the space also captures the
boundary flux quantitatively:
\[
 \left\|\Pi_V[K_L,E_{L,T}]f_{1,-}\right\|_2
 \ge\frac a2\left(\sum_{2\le n\le N}c_n^2\right)^{1/2}-o(1)
 =(a\sqrt2+o(1))L
 \quad(L\to\infty).
 \tag{7}
\]
Thus the positive subspace contains the incoming endpoint packet and
detects a fixed fraction of the order-\(L\) commutator from the
previous note. The choice of \(T\) is singly exponential in \(L\).

## The exact divisor matrix

Because \(N\le X-1\), the leftmost \(-\) packet has distance at
least \(\log(X/N)\ge1/X\) from the left endpoint; every \(+\)
packet has distance at least \(\log2\) from the right endpoint.
For \(T>4(N+1)\), the support widths are smaller than these margins
and than the separation
\[
 |x_n-x_m|=|\log(n/m)|\ge\frac1{N+1}
 \qquad(n\ne m).
 \tag{8}
\]
The packets are therefore supported in \(I\) and orthonormal.

After a prime-power shift by \(\log d\), two packet supports can
overlap only when their integer labels satisfy \(m=dn\) or \(n=dm\).
Indeed, for unequal positive integers \(m,dn\) with \(m\le N\),
\(|\log(m/(dn))|\ge1/(N+1)>2/T\). At exact equality,
same-profile packets coincide after translation; opposite profiles
remain disjoint. Hence the **compression** of \(K_L\) to the
orthonormal basis (5), without asserting invariance of \(V_{L,\varepsilon}\),
is exactly
\[
 \Pi_VK_L\Pi_V\big|_V=A_N\oplus A_N^{[2,N]},
 \qquad
 (A_N)_{n,m}=
 \begin{cases}
 \Lambda(m/n)/\sqrt{m/n},&m/n\in\mathbb Z_{>1},\\
 \Lambda(n/m)/\sqrt{n/m},&n/m\in\mathbb Z_{>1},\\
 0,&\text{otherwise}.
 \end{cases}
 \tag{9}
\]
Here \(A_N^{[2,N]}\) is the principal submatrix on labels
\(2,\ldots,N\); \(\Lambda\) automatically retains precisely the
prime powers. No prime sum is replaced by a continuous density.

Take the positive Schur weight \(w_n=n^{-1/2}\). The identity
\(\sum_{d\mid n}\Lambda(d)=\log n\) gives the *exact* row ratio
\[
 \frac{(A_Nw)_n}{w_n}
 =\log n+\sum_{2\le d\le N/n}\frac{\Lambda(d)}d.
 \tag{10}
\]
The elementary Chebyshev bound \(\psi(x)=\sum_{d\le x}\Lambda(d)\le Cx\)
implies \(\sum_{d\le x}\Lambda(d)/d\le\log x+C'\): indeed
\(x\sum_{d\le x}\Lambda(d)/d\le\log(\lfloor x\rfloor!)+\psi(x)\)
by \(\sum_{d\mid m}\Lambda(d)=\log m\). Since \(A_N\) is symmetric
with nonnegative entries, weighted Schur and the principal-submatrix
bound yield
\[
 \|A_N\|,\ \|A_N^{[2,N]}\|\le\log N+C_0.
 \tag{11}
\]
This is the source-specific gain: the prime operator on these
resolved packets costs only \(\log N\sim2L\), while its norm on the
whole compact window is \((1+o(1))e^L\) by the
[spatial Schur theorem](../prime-distribution/prime-shift-weighted-schur-window-asymptotic.md).

## Gamma, pole, and the retained mixed block

For \(\sigma,\tau\in\{-,+\}\), Plancherel gives the exact gamma
matrix entry
\[
 G_{(n,\sigma),(m,\tau)}(T)
 =\frac1{2\pi}\int_{\mathbb R}H(Tu)
 \widehat p_\sigma(u)\overline{\widehat p_\tau(u)}
 e^{iTu(x_n-x_m)}du.
 \tag{12}
\]
At one center, the full \(2\times2\) profile matrix satisfies
\[
 G_{\mathrm{loc}}(T)=(\log T)I_2+G_\infty+o(1),\qquad
 (G_\infty)_{\sigma\tau}
 =\frac1{2\pi}\int_{\mathbb R}
 \log\frac{|u|}{2\pi}\,
 \widehat p_\sigma(u)\overline{\widehat p_\tau(u)}du.
 \tag{13}
\]
The integrals are finite: the Fourier transforms are Schwartz and
\(\log|u|\) is locally integrable. This follows by dominated
convergence from \(H(t)=\log(|t|/(2\pi))+O(t^{-2})\) at infinity
and the orthonormality of \(p_-,p_+\). Continuity on \(1\le T<\infty\)
then supplies a constant \(C_1\) with
\(\|G_{\mathrm{loc}}(T)-(\log T)I_2\|\le C_1\) for every \(T\ge1\).
The mixed same-center entry is included in this matrix; it is not
discarded as leakage.

For distinct centers, differentiation of the digamma series gives
\(|H'(t)|\le C/(1+|t|)\), and
\(|H(t)|\le C+\log(2+|t|)\). Therefore, for the fixed Schwartz
product \(F_{\sigma\tau}(u)=\widehat p_\sigma(u)
\overline{\widehat p_\tau(u)}\),
\[
 \left\|\frac d{du}[H(Tu)F_{\sigma\tau}(u)]\right\|_1
 \le C_2\log(2+T).
\]
One integration by parts in (12) yields
\[
 |G_{(n,\sigma),(m,\tau)}(T)|
 \le\frac{C_2\log(2+T)}{T|\log(n/m)|}\quad(n\ne m).
 \tag{14}
\]
Splitting the sum into \(|m-n|\le n/2\) and its complement proves
\(\sup_n\sum_{m\ne n}|\log(n/m)|^{-1}\le C N\log(2N)\).
Schur on the full matrix, including both profiles, bounds the
off-center gamma operator by
\[
 \rho_{N,T}=C_3\frac{N\log(2N)\log(2+T)}{T}.
 \tag{15}
\]

For each packet, changing variables gives
\[
 E_\pm(f_{n,\sigma})
 =T^{-1/2}e^{\pm x_n/2}
   \int p_\sigma(s)e^{\pm s/(2T)}ds.
\]
The last integrals are uniformly bounded for \(T\ge1\). Since
\(\sum_{n\le N}e^{x_n}=e^L\sum_{n\le N}n^{-1}\ll e^L\log(2N)\)
and \(\sum_{n\le N}e^{-x_n}=e^{-L}\sum_{n\le N}n\ll e^{-L}N^2\),
Cauchy--Schwarz bounds the entire rank-at-most-two pole matrix by
\[
 \pi_{N,T}=C_4\frac{N\sqrt{\log(2N)}}{T}.
 \tag{16}
\]
No sign assumption on the pole is used.

In the \(-\oplus+\) packet ordering, the **exact** matrix of (2)
has the block form
\[
 \mathcal Q_{L,T}=
 \begin{pmatrix}D_-&B\\B^*&D_+\end{pmatrix}.
 \tag{17}
\]
When \(N=1\), the \(+\) block is empty and the estimate below uses
only \(D_-\).
The diagonal blocks contain their full gamma blocks, the actual
divisor matrices in (9), and their pole blocks. The mixed block \(B\)
contains the same-center and off-center gamma couplings and the mixed
pole coupling; there is no mixed prime term. Equations (11)--(16)
give, with constants depending only on the fixed profiles,
\[
 D_-,D_+\succeq d_{N,T}I,
 \quad\|B\|\le b_{N,T},\qquad
 d_{N,T}=\log T-\log N-C_5-\rho_{N,T}-\pi_{N,T},
 \quad b_{N,T}=C_5+\rho_{N,T}+\pi_{N,T}.
 \tag{18}
\]
When \(d_{N,T}>b_{N,T}\), the exact Schur complement satisfies
\(D_+-B^*D_-^{-1}B\succeq(d_{N,T}-b_{N,T}^2/d_{N,T})I>0\).
Also, the block quadratic form is bounded below by
\((d_{N,T}-b_{N,T})\|f\|_2^2\). In particular the concrete estimate
\[
 Q_L(f)\ge\left[
 \log\frac TN-C_6
 -C_6\frac{N\log(2N)\log(2+T)}T
 -C_6\frac{N\sqrt{\log(2N)}}T
 \right]\|f\|_2^2
 \quad(f\in V_{L,\varepsilon})
 \tag{19}
\]
retains the mixed boundary block through its norm rather than
replacing a frequency-cut piece by a compactly supported one.

For \(T\) in (4), \(\log(T/N)\ge C_\varepsilon+\varepsilon L\).
The two error fractions in (19) are at most
\(C e^{-C_\varepsilon-\varepsilon L}\) times, respectively,
\((1+L)(1+C_\varepsilon+L)\) and \(\sqrt{1+L}\).
Their suprema over \(L>\frac12\log2\) tend to zero as
\(C_\varepsilon\to\infty\). Choose \(C_\varepsilon\) large enough
to ensure \(T>4(N+1)\) and make the bracket at least
\(\varepsilon L/2\) for every such \(L\). This proves (6).

## The commutator is present in this positive space

The packet \(f_{1,-}\) lies against the right endpoint. If
\(P_T=\chi(D/T)\), then, exactly for \(v>0\),
\((P_Tf_{1,-})(L+v/T)=\sqrt T\,h(v)\). The term
\(U_{-\log n}\) in (1) returns this right exterior leakage to
\(x_n\), with coefficient \(c_n/2\). Its inner product with the
outgoing \(f_{n,+}\) is \(ac_n/2\). For \(m\ne n\), the center
separation is at least \(1/X\), so Schwartz decay bounds the total
projection error by
\(O_M(\sqrt N A_L(1+T/X)^{-M})=o(1)\) for a sufficiently
large fixed \(M\); here \(A_L=\sum c_n=O(e^L)\).

The left exterior leakage of \(P_Tf_{1,-}\) is Schwartz-small across
the \(2L\) window. In the adjoint flux
\(C_T^*=MP_T(1-M)S_LM\), right-shifted exterior packets start at
least \(\log2-O(T^{-1})\) beyond \(I\), so smoothing them back is
also negligible. Every left-shifted packet with \(n\le N\) stays
inside \(I\), since its center is at least \(1/X\gg1/T\) from
\(-L\). There is at most one admitted integer \(N<n<X\); its
coefficient is \(O(Le^{-L})\), so a possible left-boundary overlap
still contributes \(o(1)\). The exact commutator identity
\([K_L,E_{L,T}]=C_T^*-C_T\) from the leakage note now gives (7),
because the prime number theorem yields
\[
 \sum_{2\le n\le N}c_n^2
 =4\sum_{n\le N}\frac{\Lambda(n)^2}{n}
 =8L^2+o(L^2).
 \tag{20}
\]

## Resolution limit of this packet architecture

The proof of (19) works with any integer
\(1\le M\le\lfloor e^{2L}-1\rfloor\) in place of \(N\), provided
\(T>4(M+1)\): use the same two profiles at labels \(1,\ldots,M\).
For example, if \(0<\beta<\alpha<2\), then
\(T=e^{\alpha L}\) and \(M=\lfloor e^{\beta L}\rfloor\) give
\[
 Q_L(f)\ge\bigl((\alpha-\beta)L-O(1)\bigr)\|f\|_2^2
 \quad\text{on that smaller space, for large }L.
 \tag{21}
\]
Likewise \(T=L^q\), \(M=\lfloor L^r\rfloor\) with
\(0<r<q\) give a positive
\((q-r)\log L-O(1)\) margin for large \(L\). These smaller spaces
detect only the prime-power returns with labels at most \(M\).
For exponential \(M=e^{\beta L}\), the coefficient square sum on
these labels is still of order \(L^2\), with a smaller leading
constant; for polynomial \(M\) it is only of order \((\log L)^2\).

Keeping the full \(N\asymp e^{2L}\) labels requires resolution of
their closest centers. If instead \(T=e^{(2-\delta)L}\) for a fixed
\(0<\delta<2\), then
\[
 T|x_N-x_{N-1}|=T\log\frac N{N-1}\asymp\frac TN
 =e^{-\delta L+o(L)}\longrightarrow0.
 \tag{22}
\]
Translation continuity in \(L^2\) gives
\(\langle f_{N,-},f_{N-1,-}\rangle\to1\); the packet family is not
uniformly separated or orthonormal, and the exact divisor-matrix
compression (9) no longer applies. Moreover the last incoming
packet spills across \(-L\), since its endpoint margin is only
\(\asymp1/N\) while its width is \(\asymp1/T\). The formal diagonal surplus also
has \(\log(T/N)=-\delta L+o(L)\). This is a quantitative
obstruction **within this resolved-packet proof**, not a negative
Weil test or a lower bound on all possible phase-space methods.

The spaces do not approximate the entire compact-test class as
\(L\to\infty\). If \(E_{L,\varepsilon}\) is the union of their packet
supports, then
\[
 |E_{L,\varepsilon}|
 \le\frac{2\delta(2N-1)}T
 \ll e^{-C_\varepsilon-\varepsilon L}.
 \tag{23}
\]
For every fixed \(g\in C_c^\infty(\mathbb R)\), embedded in
\(L^2(I)\) for large \(L\),
\(\|\Pi_V g\|_2\le\|\mathbf1_{E_{L,\varepsilon}}g\|_2
\le\|g\|_\infty|E_{L,\varepsilon}|^{1/2}\to0\).
Each \(V_{L,\varepsilon}\) is finite dimensional, and this expanding
sequence is asymptotically orthogonal to fixed tests in \(L^2\),
hence cannot approximate them in any form topology that dominates
\(L^2\).

## Relation to other routes and limits

The result is a signed, unconditional theorem for a family of
dimensions growing like \(e^{2L}\), with the exact pole, gamma
multiplier and every admitted prime power present. It gives no bound
on the full-window ground value and no proof of RH. The packet space
depends on \(\varepsilon\), and its Fourier scale
\(T=e^{C_\varepsilon+(2+\varepsilon)L}\) is above the resolution
height \(e^{2L}\). The theorem is a tailored high-frequency
diagonal-dominance argument with an exact source-specific divisor
block, not an arithmetic cancellation theorem or an approach to
all-window positivity.

Our [support-onset note based on Suzuki's form](suzuki-prime-power-support-spectral-flow.md)
controls individual newborn collar shifts by their logarithmic gamma
cost; Suzuki's [Fourier formula (2.8)](https://arxiv.org/html/2606.09096v2)
also records the general high-frequency \(\log|t|\) dominance at a
fixed window. Equations (9)--(19) quantify that mechanism uniformly
in growing \(L\) for a collective arithmetic packet graph.
[Zhu's one-stroke reduction and failed routes](https://arxiv.org/html/2608.24827v2)
concern whole-window certificates and hard order cuts, respectively;
our theorem supplies neither such certificate nor a contradiction to
Zhu's pointwise-comb barrier. The
[theta-jump formulation](../theta-and-heat/theta-weil-jump-form.md) is a global
RH-equivalent energy comparison; its domain results do not imply
(6). The time-frequency boundary transition is familiar from
[Slepian--Pollak](https://www.math.ucdavis.edu/~saito/data/ONR15/PSWF-I.pdf)
and [Landau--Pollak](https://www.math.ucdavis.edu/~saito/data/ONR15/PSWF-II.pdf);
the exact divisor and pole/gamma blocks in (17) are the feature
specific to this Weil calculation. This is independently audited
written mathematics, not a Lean formalization or a priority claim.
