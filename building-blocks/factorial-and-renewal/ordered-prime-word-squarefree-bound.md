# Ordered prime words: a weighted squarefree bound and the actual inverse

3 October 2026. For ordinary integers, let
\[
 C(n)=\frac{\Omega(n)!}{\prod_p v_p(n)!},\qquad
 g=(\omega+\mathbf 1)^{-1},\qquad
 P(s)=\sum_p p^{-s}\quad(\Re s>1).
\]
Here the inverse and the star below mean Dirichlet convolution, while \(\mathbf 1\) is the constant-one function on positive integers. Let \(\sigma_*\) be the unique real solution of \(P(\sigma_*)=1\). The following unconditional written bound holds for every fixed \(0<\delta<\sigma_*-1\): there is \(K_\delta<\infty\) such that, for **every real \(x\ge1\)**,
\[
 \frac{\sum_{1\le n\le x}\mu(n)^2C(n)}{\sum_{1\le n\le x}C(n)}
 \le K_\delta x^{-\delta},\qquad
 \frac{\sum_{1\le n\le x}\mu(n)^2|g(n)|}{\sum_{1\le n\le x}|g(n)|}
 \le eK_\delta x^{-\delta}.
\]
The constants depend on \(\delta\); no bound at \(\delta=\sigma_*-1\) or effective optimized constant is claimed. These are probabilities under the displayed positive weights. They improve the trivial bound one for those probabilities and do not improve the signed Mertens or prime-error bound.

The arithmetic definitions and coefficient identities occur in [Schmidt, arXiv:2604.23517v1](https://arxiv.org/pdf/2604.23517v1), Definitions 1.5–1.6 and Theorem 1.7. The derivation here uses no independence assertion from that paper. The prime specialization of [Hwang–Janson's ordered-factorization model](https://arxiv.org/pdf/0902.3419v1) already gives the weight \(C(n)\), with word length of order \(\log x\). Their [2013 erratum](https://doi.org/10.1214/EJP.v18-2297) corrects an odd-moment argument; neither the CLT nor its correction is used below. No priority claim is made. The proofs below have separate mathematical checks and a coordinator reconstruction. Their analytic scope is written, not kernel checked.

## The exact positive weight and full cofactor identity

Let \(\chi_{\mathbb P}\) be the actual prime indicator and \(\varepsilon\) the convolution unit. There are exactly \(C(n)\) ordered words of primes whose product is \(n\): each is a permutation of the prime-factor multiset. Thus \(C(1)=1\) and
\[
 C=(\varepsilon-\chi_{\mathbb P})^{-1},\qquad
 C(n)=\sum_{p\mid n}C(n/p)\quad(n>1).
\]
Repeated letters and every proper prime power are included. Since \(\omega=\mathbf1*\chi_{\mathbb P}\),
\[
 g=\mu*(\lambda C),\qquad
 \mu=g*(\varepsilon+\chi_{\mathbb P}).
\]
The product \(\lambda C\) here is pointwise. Twisting convolution by the completely multiplicative \(\lambda\), whose convolution inverse is \(\mu^2\), gives
\[
 \boxed{|g|=\lambda g=\mu^2*C.}
\]
This last star is convolution: \(|g(n)|=\sum_{d\mid n}\mu(n/d)^2C(d)\). It is different from the pointwise products in the theorem's numerators. Positivity proves \(|g(n)|\ge C(n)\ge1\). For squarefree \(n\) with \(k=\Omega(n)\),
\[
 |g(n)|=\sum_{j=0}^k\binom{k}{j}(k-j)!
 =k!\sum_{j=0}^k\frac1{j!}\le eC(n).
\]
The complete real-cutoff identity is
\[
 M(x)=G(x)+\sum_{p\le x}G(x/p),\qquad
 G(y)=\sum_{1\le n\le y}g(n),\quad x\ge1.
\]
All prime cofactors and real floors are retained. This identity must be used before identifying a statement about \(G\) with one about the actual Mertens sum \(M\).

## The squarefree numerator has every exponent above one

For each real \(\sigma>1\), define
\[
 B_\sigma=\sum_{n\ge1}\mu(n)^2C(n)n^{-\sigma}.
\]
Expansion over finite prime subsets and nonnegative Tonelli summation give
\[
 B_\sigma=\int_0^\infty e^{-t}\prod_p(1+tp^{-\sigma})\,dt<\infty.
\]
Indeed the product converges at each finite \(t\). Choose a finite head of \(h\) primes with reciprocal-power tail at most \(1/2\). The tail product is at most \(e^{t/2}\), and the head product is at most \((1+t)^h\), so
\[
 B_\sigma\le\int_0^\infty e^{-t/2}(1+t)^h\,dt
 =\sum_{j=0}^h\binom hj 2^{j+1}j!.
\]
The empty subset supplies the unit. Every infinite prime tail is paid. Positivity consequently gives, for all real \(x\ge1\),
\[
 \sum_{n\le x}\mu(n)^2C(n)\le B_\sigma x^\sigma,
 \qquad
 \sum_{n\le x}\mu(n)^2|g(n)|\le eB_\sigma x^\sigma.
\]

## The complete positive denominator grows faster

Fix \(1<\beta<\sigma_*\). Some finite alphabet \(A\) of actual primes has \(\sum_{p\in A}p^{-\beta}>1\). Let \(q=\max A\), and let \(T_A(x)\) count all ordered words over \(A\) with product at most \(x\), including the empty word. Then
\[
 T_A(x)=0\quad(x<1),\qquad
 T_A(x)=1+\sum_{p\in A}T_A(x/p)\quad(x\ge1).
\]
On \([1,q]\), the unit proves \(T_A(x)\ge q^{-\beta}x^\beta\). Above \(q\), every child is at least one and at most \(x/2\). Induction on the bands ending at \(q,2q,4q,\ldots\) and the exact recurrence prove
\[
 T_A(x)\ge q^{-\beta}x^\beta\quad\text{for every real }x\ge1.
\]
The full \(C\) and \(|g|\) masses are both at least this retained positive mass. Given \(0<\delta<\sigma_*-1\), choose \(1<\sigma<\beta<\sigma_*\) with \(\beta-\sigma=\delta\). Combining numerator and denominator bounds proves the theorem, with \(K_\delta=q^\beta B_\sigma\).

An explicit conservative specialization uses only \(A=\{2,3,5\}\). With \(\alpha=101/100\), the rational binomial certificate
\[
 (51/50)^{100}>1+2+99/50+1617/1250=3921/625>5
\]
implies \(\sum_{p\in A}p^{-\alpha}>155/153>1\). Taking \(\sigma=201/200\) gives, for every real \(x\ge1\),
\[
 \frac{\sum_{n\le x}\mu(n)^2|g(n)|}{\sum_{n\le x}|g(n)|}
 \le e5^{101/100}B_{201/200}x^{-1/200}.
\]
The same bound without \(e\) holds for \(C\). This is a proved full-range inequality, not a finite experiment.

## Most weighted mass escapes the ordinary central window

There is also an explicit finite-coefficient bound. For every real \(x\ge\exp(e)\), put \(L=\log x\), \(R=\log\log x\), and \(K=\lfloor L/(200R)\rfloor\). Under either displayed weighted measure,
\[
 \Pr[\Omega(n)\le K]\le5^{101/100}x^{-1/200}.
\]
To prove it, write \(k=\Omega(n)\). The multinomial definition gives \(C(n)\le k!\). The positive convolution has exactly \(2^{\omega(n)}\) eligible squarefree divisors, so \(|g(n)|\le2^k k!\), including proper powers. If \(K\ge1\), then \(2K\le L/(100R)<L\), hence
\[
 2^K K!\le(2K)^K\le e^{KR}\le x^{1/200}.
\]
If \(K=0\), the event consists of the unit, with weight one. At most \(\lfloor x\rfloor\) labels contribute, so each low-length mass is at most \(x^{201/200}\). Divide by the already proved complete denominator \(5^{-101/100}x^{202/200}\).

For every fixed \(r>0\), eventually \(r\log\log x\le L/(200R)\); therefore the weighted probability of \(\Omega(n)\le r\log\log x\) tends to zero. A tail that is small under ordinary integer counting can contain most of this weighted mass. This does not bound the corresponding signed tail or contradict an ordinary-integer central limit theorem.

## Literal generating functions and their convergence domain

The prime sum is strictly decreasing on the real interval \((1,\infty)\). The preceding certificate gives \(P(101/100)>1\), while \(P(2)\le1/4+\int_2^\infty t^{-2}dt=3/4<1\). Therefore \(\sigma_*\in(101/100,2)\) exists and is unique. In the initial absolute half-plane \(\Re s>\sigma_*\),
\[
 \sum_n C(n)n^{-s}=\frac1{1-P(s)},\qquad
 \sum_n|g(n)|n^{-s}=\frac{\zeta(s)}{\zeta(2s)(1-P(s))},\qquad
 \sum_ng(n)n^{-s}=\frac1{\zeta(s)(1+P(s))}.
\]
The \(\zeta(s)\) numerator in the unsigned formula is essential. The inspected source's abstract and the paragraph following Theorem 1.9 omit it; the definition gives \(|g(p)|=2\), whereas the printed expression has prime coefficient one. The corrected factor follows directly from its own positive convolution identity. This is a specific version-bound normalization correction.

Both ordinary and absolute convergence abscissae of the literal \(g\) series are exactly \(\sigma_*\). To see the lower bound, fix any \(1<\sigma<\beta<\sigma_*\) and use the finite alphabet above. Only \((1+\log x/\log2)^{|A|}\) integers up to \(x\) use that alphabet, so some \(n_x\le x\) has
\[
 |g(n_x)|\ge C(n_x)\ge
 \frac{q^{-\beta}x^\beta}{(1+\log x/\log2)^{|A|}}.
\]
The labels tend to infinity along a subsequence, and \(|g(n_x)|n_x^{-\sigma}\) is unbounded. The terms therefore fail to tend to zero below the wall; the same direct argument works at smaller real coordinates. Absolute convergence above the wall gives the upper bound. No signed endpoint convergence is claimed. A meromorphic continuation of a displayed formula is different from convergence of its defining series.

## Auxiliary poles and complete cancellation

The meromorphic expression \(\mathcal G(s)=1/[\zeta(s)(1+P(s))]\) agrees with the series above the wall and is defined on \(\Re s>1\). There are simple poles \(\rho_j\) with \(1<\Re\rho_j<\sigma_*\), \(\Re\rho_j\to\sigma_*\), and \(\Im\rho_j\to+\infty\).

For completeness, unique factorization makes the logarithms of finitely many distinct primes rationally independent. Continuous-time Kronecker approximation gives arbitrarily late times with each retained prime phase close to \(-1\); [Sargent, arXiv:1704.00093v3, Lemma 2](https://arxiv.org/pdf/1704.00093v3) states this form. On any compact subset of \(\Re s>1\), first pay the two absolute prime tails. A diagonal compact exhaustion then gives \(1+P(s+it_j)\to1-P(s)\) locally uniformly. The limit has a simple zero at \(\sigma_*\), since \(P'(\sigma_*)<0\). Rouché's theorem on shrinking disks gives simple zeros of the actual complete prime sum at increasingly large heights.

No zero lies on or to the right of the wall: strict modulus excludes \(\Re s>\sigma_*\); equality at the wall would force both the prime-two and prime-three phases to be \(-1\), contradicting the irrationality of \(\log2/\log3\). Zeta is nonzero throughout \(\Re s>1\), so these are auxiliary poles. The exact full factor cancels every one:
\[
 (1+P(s))\mathcal G(s)=1/\zeta(s).
\]
They are not zeta zeros and do not constrain their location. The cutoff identity above is the arithmetic counterpart of this cancellation.

## Limits and analytic obligations

The weighted squarefree event is polynomially rare, while ordinary uniform-integer squarefree density tends to \(6/\pi^2\). Changing the measure changes the relevant probability. None of the estimates supplies a stronger signed bound on \(M\), a complete prime-error energy inequality, eventual \(W\le0\), or RH. The full prime-cofactor sum cannot be replaced by an ordinary-density expectation without a separately proved signed comparison.

The ordered-word identification, factorial integral, Tonelli/product-tail argument, all-real growth induction, Dirichlet-series convergence proof, Kronecker approximation and Rouché argument remain written. The [native arithmetic companion](../../formalization/BuildingBlocks/ActualOmegaInverse.lean) constructs the literal inverse recursively and proves its global inverse equation, prime value -2, prime-square value 2, actual omega/prime-indicator identity, and complete cofactor formulas for every natural and real cutoff, including x<1. It supplies no inverse or analytic-estimate premise to those final targets. The [verification record](../../formalization/verification/actual-omega-inverse/README.md) separately covers this arithmetic leaf; it does not confer kernel status on the weighted, convergence or pole results. There is no assumed target inequality in the proofs above, no novelty claim, and no claimed RH-frontier advance.
