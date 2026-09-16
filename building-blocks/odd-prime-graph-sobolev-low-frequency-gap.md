# A uniform odd prime-graph gap below the PNT Sobolev frequency scale

RH Agent3, 2026-09-17; independently audited. This gives a general-function counterpart to the [moderate-carrier theorem](odd-weil-terminal-prime-carrier-gap.md). It controls every actual prime power and uses the exact continuous-prime odd square. It does not sign the full Weil form or prove RH.

Let \(a\ge1\), \(I_a=(-a,a)\), \(N=e^{2a}\), and let \(P_a\) be the actual zero-extended prime shift operator
\[
 (P_aF)(x)=\sum_{n<N}\frac{\Lambda(n)}{\sqrt n}
 \bigl(F(x+\log n)+F(x-\log n)\bigr).
\tag{1}
\]
Put \(\phi(x)=\cosh(x/2)\), \(R_a=P_a\phi/\phi\), and
\[
 D_a[F]=\int_{I_a}R_a(x)|F(x)|^2dx-\langle F,P_aF\rangle.
\tag{2}
\]
The weighted graph identity makes \(D_a\ge0\). Define the explicit PNT error at this window by
\[
 \eta_a=e^{-a/2}+
 \sup_{e^a\le u\le e^{2a}}
 \frac{|\psi(u)-(u-1)|}{u},
 \qquad
 r_a=\sup_{x\in I_a}|R_a(x)/e^a-1|.
\tag{3}
\]
The prime number theorem and the [spatial Schur theorem](https://github.com/arterialist/proofs/blob/main/building-blocks/prime-shift-weighted-schur-window-asymptotic.md) give \(\eta_a,r_a\to0\).

**Theorem.** An absolute \(C>0\) exists such that every real odd \(F\in H_0^1(I_a)\) satisfies
\[
 \boxed{\quad
 D_a[F]\ge e^a(1-r_a)\|F\|_2^2
 -Ce^a\eta_a\bigl(\|F\|_2^2+\|F\|_2\|F'\|_2\bigr).
 \quad}
\tag{4}
\]
Consequently, if a sequence of nonzero odd tests has
\(\|F_a'\|_2/\|F_a\|_2=o(\eta_a^{-1})\), then
\[
 \liminf_{a\to\infty}
 \frac{D_a[F_a]}{e^a\|F_a\|_2^2}\ge1.
\tag{5}
\]
This is a genuine uniform graph gap on a Sobolev-low-frequency class. Its derivative hypothesis is much stronger than a logarithmic archimedean energy cap of size \(e^a\).

Equivalently, a normalized odd \(H_0^1\) test whose **positive signed prime pairing** satisfies
\(\langle F,P_aF\rangle\ge\kappa e^a\|F\|_2^2\) for fixed \(\kappa>0\) must obey
\[
 \frac{\|F'\|_2}{\|F\|_2}\ge\frac{\kappa}{C\eta_a}-1.
\tag{5a}
\]
Thus an odd test near the positive spectral edge must leave the PNT-controlled Sobolev-frequency range. This is compatible with the [published odd upper spectral edge](https://github.com/arterialist/proofs/blob/main/building-blocks/odd-prime-terminal-band-phase-transfer.md), which uses arbitrarily high Kronecker carriers.

**Proof.** Extend \(F\) by zero to the real line. Since \(F\in H_0^1(I_a)\), the real autocorrelation
\[
 C_F(\ell)=\operatorname{Re}\int_{\mathbb R}\overline{F(x)}F(x+\ell)dx
\]
is absolutely continuous, obeys \(|C_F(\ell)|\le\|F\|_2^2\) and \(|C_F'(\ell)|\le\|F\|_2\|F'\|_2\) almost everywhere, and vanishes for \(\ell\ge2a\). With \(E(u)=\psi(u)-(u-1)\), the difference between the actual prime form and its continuous-prime analogue is exactly
\[
 \langle F,(P_a-P_{a,\mathrm{cont}})F\rangle
 =2\int_{[1,N)}u^{-1/2}C_F(\log u)\,dE(u).
\tag{6}
\]
The endpoints vanish: \(E(1)=0\) and \(C_F(\log N)=C_F(2a)=0\). Stieltjes integration by parts therefore gives
\[
 \left|\langle F,(P_a-P_{a,\mathrm{cont}})F\rangle\right|
 \le2\bigl(\tfrac12\|F\|_2^2+\|F\|_2\|F'\|_2\bigr)
 \int_1^N|E(u)|u^{-3/2}du.
\tag{7}
\]
Chebyshev's \(\psi(u)=O(u)\) bounds the part \(u\le e^a\) by \(O(e^{a/2})\). Definition (3) bounds the remainder by \(O(\eta_a e^a)\). Hence the right side of (7) is at most
\(Ce^a\eta_a(\|F\|_2^2+\|F\|_2\|F'\|_2)\).

For odd \(F\), write \(u(x)=\sqrt2 F(x)\) on \((0,a)\). The exact [continuous-prime square](https://github.com/arterialist/proofs/blob/main/building-blocks/suzuki-odd-continuum-prime-square-and-arithmetic-remainder.md) is
\[
 -\langle F,P_{a,\mathrm{cont}}F\rangle
 =\int_0^a e^{-s}\left|\int_s^a e^{x/2}u(x)dx\right|^2ds\ge0.
\tag{8}
\]
Therefore \(\langle F,P_aF\rangle\le Ce^a\eta_a(\|F\|_2^2+\|F\|_2\|F'\|_2)\). The definition of \(r_a\) gives \(\int R_a|F|^2\ge e^a(1-r_a)\|F\|_2^2\), proving (4). \(\square\)

The theorem quantifies precisely what the PNT supplies to a graph argument. If an explicit PNT estimate gives \(\eta_a\ll a^C e^{-c\sqrt a}\), then every derivative ratio \(\|F_a'\|/\|F_a\|\le e^{c'\sqrt a}\) with \(c'<c\) satisfies (5). The published moderate-carrier theorem uses one such explicit estimate. In contrast, a bound on the logarithmic archimedean form \(H_a[F]\lesssim e^a\|F\|^2\) does not bound \(\|F'\|/\|F\|\) at this scale: it permits Fourier mass at frequencies exponentially larger than \(e^{c\sqrt a}\). The gap between (4) and the full Weil sign is a quantitative, not a domain, issue.
