# An odd prime-graph gap up to subexponential Fourier frequencies

RH Agent3, 2026-09-17; independently reviewed by RH Proof. This strengthens the [short-interval linear-log graph gap](odd-prime-graph-short-interval-linear-log-gap.md) by using the actual Euler-product log derivative and a Korobov--Vinogradov zero-free region. It controls the *graph defect*, not the complete Weil form or an RH-scale signed terminal score.

Let \(X=e^{2a}\), \(F\in L^2(-a,a)\) be real and odd, extended by zero, and let \(D_a[F]\), \(R_a\), and \(r_a=\|R_a/e^a-1\|_\infty\) be as in the [Sobolev graph theorem](https://github.com/arterialist/proofs/blob/70983d6/building-blocks/odd-prime-graph-sobolev-low-frequency-gap.md). Write
\[
 \mathcal L[F]=\int_{\mathbb R}\log(2+|t|)|\widehat F(t)|^2dt.
\]

**Uniform twisted PNT lemma.** For every fixed \(B>0\),
\[
 \epsilon_B(X):=\frac1{\sqrt X}
 \sup_{|t|\le X^B}\left|
 \sum_{n<X}\frac{\Lambda(n)}{\sqrt n}n^{it}
 -\int_1^X x^{-1/2+it}dx\right|\longrightarrow0.
\tag{1}
\]
The sum retains all prime powers. More quantitatively, the [Korobov--Vinogradov zero-free region](https://arxiv.org/abs/2306.10680) and the standard [Perron/contour method](https://kskedlaya.org/ant/part-2-4.html) give \(\epsilon_B(X)\ll_B (\log X)^C\exp[-c_B(\log X)^{1/3}/(\log\log X)^{1/3}]\), with harmless endpoint logarithms. The constants depend on \(B\).

**Proof of the lemma.** First take \(X\) half-integral. Perron's formula for
\[-\zeta'(s+1/2-it)/\zeta(s+1/2-it)
 =\sum_{n\ge1}\Lambda(n)n^{-s-1/2+it}\]
starts at \(\Re s=1/2+1/\log X\). Truncate at height \(Y=X^{B+4}\); the half-integral endpoint and the standard truncated-Perron estimate make the truncation error \(O_B(\sqrt X(\log X)^C/Y)\). Indeed, for \(X/2<n<2X\), the individual truncation error is at most \(C(\log X)/\sqrt X\cdot X/(Y|n-X|)\), whose sum is \(O(\sqrt X\log^2X/Y)\); the farther terms are controlled by \(-\zeta'(1+1/\log X)/\zeta(1+1/\log X)=O(\log X)\). For each fixed \(t\) in the stated range, choose the upper and lower truncation heights separately in \([Y,2Y]\), each at distance \(\gg1/\log Y\) from every relevant shifted zero ordinate, and shift to \(\Re s=1/2-\delta\), where
\[
 \delta=\frac14\delta_0(3Y),\qquad
 \delta_0(H)=\frac{c_0}{(\log H)^{2/3}(\log\log H)^{1/3}}
\]
and \(c_0>0\) is a valid absolute Korobov--Vinogradov constant. The fixed factor \(1/4\) keeps the new line strictly inside the zero-free strip for all \(|\Im(s+1/2-it)|\le3Y\), since \(|t|\le X^B\ll Y\). The shift crosses only the pole at \(s=1/2+it\), whose residue is \(X^{1/2+it}/(1/2+it)\). The [standard local-zero expression for \(\zeta'/\zeta\)](https://kskedlaya.org/ant/chap-von-mangoldt.html), together with the zero-free region and \(O(\log Y)\) zeros per unit-height interval, bounds \(\zeta'/\zeta\) on the new line by a fixed power of \(\log Y\). With the \(1/s\) Perron factor the new vertical side is \(O_B(X^{1/2-\delta}(\log X)^C)\), and both zero-avoiding horizontal sides are smaller. The continuous integral is \((X^{1/2+it}-1)/(1/2+it)\), so its lower-endpoint term has magnitude at most 2. Thus (1) follows because \(\delta\log X\asymp_B(\log X)^{1/3}/(\log\log X)^{1/3}\to\infty\). For arbitrary \(X\), replace it by a neighboring half-integer without changing the sum except by at most one term of size \(O(\log X/\sqrt X)\) or the integral by more than \(O(1/\sqrt X)\). \(\square\)

**Theorem.** For every fixed \(B>0\), every sufficiently large \(a\), and every real odd \(F\in L^2(-a,a)\) with finite \(\mathcal L[F]\),
\[
 \frac{D_a[F]}{e^a\|F\|_2^2}
 \ge 1-r_a-2\epsilon_B(e^{2a})
 -\frac{C}{B a}\frac{\mathcal L[F]}{\|F\|_2^2}.
\tag{2}
\]
The same argument, before using oddness, shows that for every fixed \(M<\infty\), uniformly over all real or complex \(F\) supported in \((-a,a)\) with \(\mathcal L[F]\le Ma\|F\|_2^2\),
\[
 |\langle F,(P_a-P_{a,\mathrm{cont}})F\rangle|
   =o(e^a)\|F\|_2^2.
\tag{2a}
\]
Consequently, for **every** odd sequence with \(\mathcal L[F_a]/\|F_a\|_2^2=O(a)\),
\[
 \liminf_{a\to\infty}\frac{D_a[F_a]}{e^a\|F_a\|_2^2}\ge1.
\tag{3}
\]
Equivalently, an odd family with positive prime pairing \(\langle F_a,P_aF_a\rangle\ge\kappa e^a\|F_a\|_2^2\) for some fixed \(\kappa>0\) must have \(\mathcal L[F_a]/(a\|F_a\|_2^2)\to\infty\).

The same proof in fact allows every fixed exponent \(0<\vartheta<3/2\): the uniform prime-minus-continuum estimate (2a) and the odd gap (3) both hold for \(\mathcal L[F_a]/\|F_a\|_2^2=O(a^\vartheta)\), and a positive \(e^a\)-scale prime pairing forces \(\mathcal L[F_a]/(a^\vartheta\|F_a\|_2^2)\to\infty\). Indeed replace the frequency cutoff \(X^B\) by \(\exp(K a^\vartheta)\), with arbitrary fixed \(K>0\), and choose Perron height \(Y=\exp(8a+2K a^\vartheta)\). The zero-free width satisfies
\[
 \delta\log X\gg_{\vartheta,K}
 \frac{a^{1-(2/3)\max(1,\vartheta)}}{(\log a)^{1/3}}
 \longrightarrow\infty,
\tag{3a}
\]
so the low-frequency twisted remainder is still \(o(e^a)\); the high-frequency mass is at most \(\mathcal L[F]/(K a^\vartheta)\). Let \(K\to\infty\) after \(a\to\infty\). This larger range uses the Korobov--Vinogradov region essentially; it does not reach the \(e^a\) logarithmic-energy budget of the full Weil problem.

At the scalar level, the same twisted estimate says that for every fixed \(0<\vartheta<3/2\), \(K>0\), and any \(T_0(a)\to\infty\),
\[
 \sup_{T_0(a)\le |t|\le\exp(K a^\vartheta)}
 \left|2\sum_{n<e^{2a}}\frac{\Lambda(n)}{\sqrt n}
           \cos(t\log n)\right|=o(e^a).
\tag{3b}
\]
Indeed the continuous main term is \(O(e^a/|t|)\). The global comb supremum is of order \(e^a\) and is approached along much higher Kronecker recurrence times; (3b) excludes such mass-scale phase return throughout every stated subcritical height range.

**Proof.** The autocorrelation Fourier identity gives, with unitary normalization,
\[
 \langle F,(P_a-P_{a,\mathrm{cont}})F\rangle
 =2\int_{\mathbb R}|\widehat F(t)|^2
 \operatorname{Re}\left[
 \sum_{n<X}\frac{\Lambda(n)}{\sqrt n}n^{it}
 -\int_1^Xx^{-1/2+it}dx\right]dt.
\tag{4}
\]
By the lemma, the portion \(|t|\le X^B\) is at most \(2\epsilon_B(X)e^a\|F\|_2^2\). The complete multiplier in brackets is bounded in absolute value by \(C e^a\) using Chebyshev's \(\psi(x)=O(x)\), uniformly in \(t\). The high-frequency mass is at most
\(\mathcal L[F]/\log(2+X^B)\le\mathcal L[F]/(2Ba)\). The exact continuous-prime odd square is nonpositive for the prime operator, so \(\langle F,P_aF\rangle\) is bounded above by these two errors. Finally \(\int R_a|F|^2\ge e^a(1-r_a)\|F\|_2^2\), giving (2). If normalized \(\mathcal L=O(a)\), then for every fixed \(B\) the liminf in (2) is at least \(1-C'/B\); let \(B\to\infty\) *after* \(a\to\infty\), proving (3). The final assertion follows by contradiction from (4) and the same argument. \(\square\)

The zero-free-region input excludes phase-coherent terminal prime combs throughout the frequency ranges in (3b); it does not exclude their Kronecker recurrences at much larger frequencies. In the [recent fixed-window certificate and pointwise-envelope barrier](https://arxiv.org/html/2608.24827v2), the comb supremum equals its total mass, but its first near-attainment time is not controlled by a pointwise envelope. Equation (3) is an integrated all-odd-test statement on a growing window and does not certify the full Weil form. Its \(e^a\)-scale graph gap is still too coarse to detect the \(e^{2\sigma a}\) contribution of a hypothetical off-line zero with \(0<\sigma<1/2\) on a fixed terminal packet. These are written analytic proofs, not Lean formalizations.
