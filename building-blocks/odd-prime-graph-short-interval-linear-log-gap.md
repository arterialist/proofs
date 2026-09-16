# Short-interval prime asymptotics extend the odd graph gap to linear logarithmic energy

RH Proof, 17 September 2026. This is an unconditional, source-specific refinement of the [odd Sobolev graph gap](odd-prime-graph-sobolev-low-frequency-gap.md) and its [logarithmic-energy version](odd-prime-graph-logarithmic-uncertainty.md). It uses the uniform short-interval prime asymptotic of [Guth and Maynard, Corollary 1.3](https://arxiv.org/html/2405.20552), rather than a global prime-number-theorem remainder. Every prime power stays in the actual shift operator. The conclusion controls the leading \(e^a\) graph scale on a substantially larger class of tests; it does **not** prove the order-one sign required by Weil positivity or RH.

Let \(I_a=(-a,a)\), \(X=e^{2a}\), \(\psi(x)=\sum_{n\le x}\Lambda(n)\), and extend \(F\in H_0^1(I_a)\) by zero. Write
\[
 (P_aF)(x)=\sum_{n<X}\frac{\Lambda(n)}{\sqrt n}
       \bigl(F(x+\log n)+F(x-\log n)\bigr),\qquad
 \phi(x)=\cosh(x/2),\quad R_a=\frac{P_a\phi}{\phi},
\]
\[
 S_a[F]=\int_{I_a}R_a|F|^2,\qquad
 D_a[F]=S_a[F]-\langle F,P_aF\rangle,\qquad
 \rho_a=\sup_{I_a}|R_a/e^a-1|.
 \tag{1}
\]
The [weighted Schur theorem](prime-shift-weighted-schur-window-asymptotic.md) gives \(\rho_a\to0\), \(\|P_a\|_{2\to2}\le\|R_a\|_\infty=O(e^a)\), and \(D_a\ge0\). Let \(P_{a,\mathrm{cont}}\) replace \(d\psi\) by \(dx\) in this same full shift pairing. For odd \(F\), with \(u=\sqrt2F|_{(0,a)}\), the [exact continuum square](suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md) is
\[
 -\langle F,P_{a,\mathrm{cont}}F\rangle
 =\int_0^a e^{-s}\left|\int_s^a e^{x/2}u(x)\,dx\right|^2ds\ge0.
 \tag{2}
\]

**Uniform power-frequency theorem.** For every fixed \(0<\tau<13/15\), there is a function \(\epsilon_\tau(a)\to0\) such that every nonzero real \(F\in H_0^1(I_a)\) with
\(\|F'\|_2\le e^{\tau a}\|F\|_2\) satisfies
\[
 \left|\langle F,(P_a-P_{a,\mathrm{cont}})F\rangle\right|
 \le\epsilon_\tau(a)e^a\|F\|_2^2.
 \tag{3}
\]
For odd \(F\), equations (1)–(3) give the actual-prime-power gap
\[
 \boxed{\quad D_a[F]\ge e^a
       (1-\rho_a-\epsilon_\tau(a))\|F\|_2^2.\quad}
 \tag{4}
\]
The exponent \(13/15=2(1-17/30)\) is the direct conversion of the published uniform short-interval exponent. It is an admissible range for this proof, not a claimed sharp threshold for the graph.

**Proof of (3).** Choose \(\max(\tau,1/20)<b<13/15\), then choose \(\theta>17/30\) sufficiently close to \(17/30\) and \(\delta>0\) sufficiently small so that
\[
 b<(2-\delta)(1-\theta).
 \tag{5}
\]
Such choices exist for every \(\tau<13/15\). Guth–Maynard give, uniformly for \(x^\theta\le h\le x^{0.99}\),
\(\pi(x+h)-\pi(x)=h/\log x+O_\theta(h e^{-(\log x)^{1/4}})\). Multiplying each prime by its logarithm changes the main term by \(O(h^2/x)\); proper prime powers in any such interval contribute at most \(O(\sqrt x\log^2x)=o(h)\), because \(\theta>1/2\). Hence there is a function \(\omega_\theta(Y)\to0\) such that
\[
 |\psi(x+h)-\psi(x)-h|\le\omega_\theta(Y)h
 \quad(x\ge Y,\ x^\theta\le h\le x^{0.99}).
 \tag{6}
\]
For example, \(\omega_\theta(Y)\) may dominate the supremum over \(x\ge Y\) of
\(C_\theta(\log x\,e^{-(\log x)^{1/4}}+x^{-0.01}+x^{1/2-\theta}\log^2x)\).
This conversion retains all powers of each prime; it does not silently replace \(\psi\) by \(\vartheta\). Equivalently, the proof of Guth–Maynard's corollary in their §13.2 first establishes the corresponding \(\Lambda\)-weighted estimate.

Put \(x_0=e^{(2-\delta)a}\) and \(q=e^{-ba}\). Partition \((x_0,\infty)\) into multiplicative cells \((x_j,x_j(1+q)]\) until the first endpoint above \(X\); include the possible atom at \(x_0\) in the low range. For all large \(a\), (5) makes their lengths \(h_j=qx_j\) at least \(x_j^\theta\), and \(b>1/20\) makes them at most \(x_j^{0.99}\). The last complete cell may extend beyond \(X\); its contribution past \(X\) is zero because the autocorrelation below vanishes there.

Let \(C_F(\ell)=\int_\mathbb R F(t)F(t+\ell)dt\). Zero extension and Cauchy–Schwarz give
\[
 |C_F(\ell)|\le\|F\|_2^2,\qquad
 |C_F'(\ell)|\le\|F\|_2\|F'\|_2
 \le e^{\tau a}\|F\|_2^2
 \quad\text{a.e.},\qquad C_F(\ell)=0\ (\ell\ge2a).
\]
Consequently \(f(x)=x^{-1/2}C_F(\log x)\) obeys, on each cell,
\[
 |f(x)-f(x_j)|\le C(1+e^{\tau a})q\,x_j^{-1/2}\|F\|_2^2.
 \tag{7}
\]
Subtract the cell's \(dx\) integral from its \(d\psi\) integral. Its constant part is bounded by (6), and its varying part by (7) times the positive total masses \(\psi(x_j+h_j)-\psi(x_j)+h_j\). Summing the cells and using \(\sum_j h_jx_j^{-1/2}=O(e^a)\) gives
\[
 \left|\int_{(x_0,\infty)} f(x)(d\psi(x)-dx)\right|
 \ll e^a\|F\|_2^2
 \left(\omega_\theta(x_0)+e^{(\tau-b)a}+e^{-ba}\right).
 \tag{8}
\]
For \(1\le x\le x_0\), Chebyshev's \(\psi(x)=O(x)\) and partial summation give
\(\int_{(1,x_0]}x^{-1/2}d\psi(x)+\int_1^{x_0}x^{-1/2}dx=O(\sqrt{x_0})\). This adds only \(O(e^{(1-\delta/2)a}\|F\|_2^2)\). Finally
\(\langle F,(P_a-P_{a,\mathrm{cont}})F\rangle
=2\int_1^\infty f(x)(d\psi(x)-dx)\); the endpoint \(x=X\) contributes zero since \(C_F(2a)=0\). All terms in (8), and the low-range term divided by \(e^a\), tend to zero. This proves (3).

The positive continuous square (2) gives \(\langle F,P_{a,\mathrm{cont}}F\rangle\le0\) for odd \(F\). Thus (3) bounds its actual prime pairing above by \(\epsilon_\tau(a)e^a\|F\|^2\); (1) then proves (4). \(\square\)

## Consequence for the full logarithmic form domain

Use the unitary whole-line Fourier transform and set
\[
 \mathcal L[F]=\int_\mathbb R\log(2+|\xi|)|\widehat F(\xi)|^2d\xi.
 \tag{9}
\]
The positive normalized odd archimedean form \(H_a\) in [the two-prime graph analysis](odd-prime-graph-logarithmic-uncertainty.md), equation (3), has symbol \(h(t)\ge1+\frac12\log(1+4t^2/25)\). Sine Plancherel therefore gives \(\mathcal L[F]\le C H_a[\sqrt2F|_{(0,a)}]\) for odd \(F\).

**Logarithmic-energy theorem.** There are an absolute constant \(C\) and \(\varepsilon(a)\to0\) such that every nonzero real odd \(F\in L^2(I_a)\) with finite \(\mathcal L[F]\) satisfies
\[
 \boxed{\quad
 \frac{D_a[F]}{e^a\|F\|_2^2}
 \ge1-\rho_a-\varepsilon(a)
 -C\left(\frac{\mathcal L[F]/\|F\|_2^2+1}{a}\right)^{1/2}.
 \quad}
 \tag{10}
\]
In particular, normalized logarithmic energy \(o(a)\) forces \(\liminf D_a[F_a]/(e^a\|F_a\|^2)\ge1\). There is also a fixed \(\kappa>0\) such that \(H_a[\sqrt2F|_{(0,a)}]\le\kappa a\|F\|^2\) forces \(D_a[F]\ge\tfrac12e^a\|F\|^2\) for all sufficiently large \(a\). These are unconditional constraints on the **actual** prime-power graph.

Here are the approximation details for (10). For \(T\ge4\), let \(V\) be the whole-line Fourier cutoff of the zero-extended \(F\) to \(|\xi|\le T\). Choose an even smooth \(\chi\), supported in \((-a,a)\), equal to one on \(|x|\le a-T^{-1}\), with \(\|\chi'\|_\infty\le CT\), and put \(G=\chi V\). It is real, odd, belongs to \(H_0^1(I_a)\), and \(\|G'\|_2\le CT\|F\|_2\). The high-frequency tail has squared norm at most \(\mathcal L[F]/\log(2+T)\). On the boundary strips of total length \(O(T^{-1})\), split \(F\) at frequency \(\sqrt T\): the low part has \(L^\infty\) norm squared at most \(C\sqrt T\|F\|_2^2\), while the high part has squared norm at most \(C\mathcal L[F]/\log T\). The strip norm of \(V\) is at most twice the strip norm of \(F\) plus twice \(\|F-V\|_2^2\). Inside \(I_a\),
\(F-G=(F-V)+(1-\chi)V\), and \((1-\chi)V\) is supported in those strips **inside** \(I_a\); outside \(I_a\), both \(F\) and \(G\) vanish. Therefore
\[
 \|F-G\|_2^2\le C\left(\frac{\mathcal L[F]}{\log T}
             +T^{-1/2}\|F\|_2^2\right).
 \tag{11}
\]
Take \(T=e^{a/2}\). If the right side of (11) is at most \(\|F\|_2^2/4\), then \(\|G\|_2\ge\|F\|_2/2\) and \(\|G'\|_2/\|G\|_2\le e^{2a/3}\) for large \(a\). Apply (3)–(4) to \(G\) with \(\tau=2/3\). The Schur norm \(\|P_a\|=O(e^a)\) makes the prime-pairing difference between \(F\) and \(G\) at most \(Ce^a\|F-G\|_2(\|F\|_2+\|G\|_2)\), yielding (10). If the right side of (11) exceeds \(\|F\|_2^2/4\), enlarge \(C\) so the right side of (10) is nonpositive and use \(D_a\ge0\). This completes the proof.

The estimate is deliberately at the leading \(e^a\) scale. In the exact odd Weil form, the graph deficit is paired with the equally large Schur row and with a positive continuous-prime/pole operator. An \(o(e^a)\) estimate for their signed difference can still be far larger than the archimedean cost \(O(a)\). Thus (10) neither signs the full Weil form nor bounds the fixed pole-null terminal-prime statistic at RH scale. A new cancellation specific to the exact \(\Lambda(p^r)=\log p\) amplitudes is still needed. The analytic short-interval and Fourier estimates here are written proofs, not Lean formalizations.
