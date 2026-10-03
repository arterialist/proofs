# Coefficients, convergence and sampling in arXiv:2604.23517v1

3 October 2026. This audit checks the actual arithmetic definitions and two generating-function claims in [Maxie Dion Schmidt's version-specific preprint](https://arxiv.org/pdf/2604.23517v1). It also gives an independently checked weighted-squarefree corollary. The audit does not certify or refute every theorem in the paper. Its independence assertions are not used as hypotheses for the results here.

The inspected arXiv record lists only v1, submitted 26 April 2026, with no journal reference. The PDF and HTML have different internal dates but agree on the inspected formulas. Internal date stamps do not establish a later arXiv revision. Locations below are printed PDF page numbers.

| Source location | Checked claim | Qualification |
| --- | --- | --- |
| Definition 1.5, Eq. 2, p. 3 | \(g=(\omega+\mathbf1)^{-1}\) | Literal Dirichlet inverse; constant-one function differs from the convolution unit. |
| Definition 1.6, Eq. 3, p. 4 | \(C(n)=\Omega(n)!/\prod_pv_p(n)!\) | Exactly the number of ordered prime words with product \(n\), including repeated primes. |
| Theorem 1.7, Eq. 4a–4c, p. 4 | \(|g|=\mu^2*C\) and squarefree coefficients | Correct, with Dirichlet convolution on the right. |
| Theorem 1.9, Eq. 6b, p. 4 | Complete \(M\)/\(G\) cofactor identity | Every prime cofactor must remain. |
| Abstract, p. 1; paragraph after Eq. 6b, p. 4 | Unsigned generating function | Requires an additional numerator \(\zeta(s)\). |
| Same paragraph, p. 4 | Literal generating series on every \(\Re s>1\) | Initial absolute domain is \(\Re s>\sigma_*\); both convergence abscissae of \(g\) equal \(\sigma_*\), where \(P(\sigma_*)=1\). |

## A coefficient test fixes the unsigned normalization

For every actual prime \(p\), the inverse equation gives \(g(p)=-2\) and \(|g(p)|=2\). At \(p^2\), it gives \(g(p^2)=2\). Thus the auxiliary inverse is different from \(\mu*\mu\), despite their agreement at primes.

Since \(|g|=\mu^2*C\), its absolutely convergent generating series is
\[
 \sum_n|g(n)|n^{-s}
 =\frac{\zeta(s)}{\zeta(2s)}\frac1{1-P(s)},\qquad
 P(s)=\sum_pp^{-s},\quad\Re s>\sigma_*.
\]
The source's printed expression omits \(\zeta(s)\). It has prime coefficient one; the definition and Eq. 4a both give two. This finite coefficient check does not rely on numerics, a probabilistic approximation or an RH premise.

## The literal series has a different wall from its continuation

The retained actual prime alphabet \(\{2,3,5\}\) proves \(P(101/100)>1\), while \(P(2)<1\). Positivity and strict decrease give a unique \(\sigma_*\in(101/100,2)\). Above this wall, the word series is the convergent geometric sum in \(P(s)\), and the corrected unsigned series converges absolutely.

For every real \(\sigma<\sigma_*\), choose \(\max(1,\sigma)<\beta<\sigma_*\) and a finite actual prime alphabet \(A\) with \(\sum_{p\in A}p^{-\beta}>1\). Its all-real word recurrence yields at least \(c_Ax^\beta\) mass on only \(O_A((\log x)^{|A|})\) labels. Some actual coefficient consequently has \(|g(n)|n^{-\sigma}\) unbounded along a subsequence. The signed series terms do not tend to zero there. Both convergence abscissae are therefore exactly \(\sigma_*\); signed endpoint convergence is not claimed.

The meromorphic expression \(1/[\zeta(s)(1+P(s))]\) can still be considered in \(\Re s>1\). Its auxiliary poles are canceled by the complete factor \(1+P\), leaving \(1/\zeta\). They are not zeta zeros. The [supporting proof](../../building-blocks/factorial-and-renewal/ordered-prime-word-squarefree-bound.md) pays the full prime tails in its pole statement and gives the all-real cutoff counterpart.

## Ordinary integer sampling does not pay factorial weights

The independently proved law, for every fixed \(0<\delta<\sigma_*-1\) and every real \(x\ge1\), is
\[
 \frac{\sum_{n\le x}\mu(n)^2|g(n)|}{\sum_{n\le x}|g(n)|}
 =O_\delta(x^{-\delta}).
\]
The same conclusion holds for \(C\). In contrast, ordinary uniform-integer squarefree density tends to \(6/\pi^2\). There is also an explicit low-length bound: for every real \(x\ge\exp(e)\), the weighted probability of \(\Omega(n)\le\lfloor\log x/(200\log\log x)\rfloor\) is at most \(5^{101/100}x^{-1/200}\). The definitions fix the measure; an unweighted tail count cannot be used to discard the whole weighted tail.

[Hwang–Janson's ordered-factorization model](https://arxiv.org/pdf/0902.3419v1) already supplies the \(C\)-weighted marginal when the alphabet consists of primes. Its length scale is \(\log x\). The [official 2013 erratum](https://doi.org/10.1214/EJP.v18-2297) repairs an odd-moment argument. The positive estimates here use neither that CLT nor an extension of it to parity or complex frequencies. No priority claim is made.

## Review and limits

Separate GPT-6.1 Sol/xhigh agent contexts reconstructed the factorial/Tonelli law, real-cutoff growth, abscissae, full-tail pole construction, low-length bound and source qualifications. The coordinator read those proofs and the inspected primary formulas and reconstructed their arguments. These are disclosed mathematical checks, not a human referee report. The [finite arithmetic verification record](../../formalization/verification/actual-omega-inverse/README.md) separately records the canonical inverse, prime and prime-square coefficients and complete cutoff identities: 28 exact standard-axiom rows and the current full 8053-job build. It does not formalize the analytic estimates or their source comparison.

The analytic squarefree bound, tail estimates, convergence and pole arguments remain written. No stronger ordinary Mertens or prime-error bound, complete signed energy comparison, eventual \(W\) sign, fixed zeta strip or RH result follows from this audit. No later Schmidt repair, source-wide false theorem, or novelty is claimed. Failed transfers from normalized rare mass to the full signed metric remain private.
