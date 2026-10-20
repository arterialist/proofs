# Griffin, Ono, Rolen, Zagier (2019): Asymptotic Hyperbolicity of Jensen Polynomials

Type: reference
Confidence: high
Source: explore_merger_L02_N03, explore_falser_L02_N03, explore_merger_L03_N00, L03_N01, L03_N02, L03_N03, explore_falser_L03_N00, L03_N01, L03_N02, L03_N03, explore_merger_L04_N00, explore_falser_L04_N00
Relevant to: Pólya-Schur theory, Jensen polynomials, real-rootedness of completed zeta function, and de Bruijn-Newman parameter bounds

## Bibliographic Info
- Authors: Michael Griffin, Ken Ono, Larry Rolen, Don Zagier
- Title: Jensen polynomials for the Riemann zeta function and other sequences
- Year: 2019
- ArXiv/DOI: Proceedings of the National Academy of Sciences (PNAS), 116(23):11103–11110, 2019. DOI: 10.1073/pnas.1902575116
- Theorem/Lemma Number: Theorem 1 (Hyperbolicity of shifted Jensen polynomials)
- Verified via web search: yes

## Key Result
For each degree $d \ge 1$, the shifted Jensen polynomials:
$$J_d^{n, \Xi}(X) := \sum_{j=0}^d \binom{d}{j} \gamma_{\Xi}(n + j) X^j$$
associated with the Taylor coefficients $\gamma_\Xi(k)$ of the completed Riemann zeta function $\Xi(\sqrt{x})$ at the origin, are hyperbolic (i.e., have only real roots) for all sufficiently large shifts $n \ge n_0(d)$. As $n \to \infty$, after appropriate rescaling, the Jensen polynomials converge locally uniformly to the Hermite polynomials $H_d(X)$.

## Hypotheses / Conditions
- The result holds for the Riemann xi-function $\Xi(t)$ as well as broad classes of modular forms and partition generating functions possessing suitable asymptotics of their Taylor coefficients.
- The hyperbolicity is guaranteed only for shifts $n$ exceeding an explicit or effective threshold $n_0(d)$.

## How It Applies
- Connects to Pólya's 1927 classical theorem stating that the Riemann Hypothesis is strictly equivalent to the hyperbolicity of the unshifted Jensen polynomials $J_d^{0, \Xi}(X)$ (shift $n = 0$) for all degrees $d \ge 1$.
- Provides a potential discrete algebraic bridge to RH that bypasses continuous backward heat flow PDEs and Calogero-Moser multi-particle ODEs.

## Caveats
- **Solved Low-Degree Regimes vs Open Asymptotic Gap**: Hyperbolicity of $J_d^0(X)$ for $d \le 3$ was proved by Craven, Csordas, and Varga (1986), and for $d = 4$ by Csordas, Norfolk, and Varga (1986). Testing low degrees ($d \le 4$) is a 40-year-old solved problem that provides zero deduction for $d \ge 5$. For all degrees $d \ge 5$, descending from the asymptotic regime $n \ge n_0(d)$ to $n = 0$ carries 100% of the unsolved analytical depth of the Riemann Hypothesis.
- **Missing Lean 4 Formalization**: Mathlib 4 currently contains zero infrastructure for Jensen polynomials, Taylor coefficients of $\Xi$, or the Laguerre-Pólya class; repository file `ActualArchimedeanFactor.lean` contains only Archimedean log-derivatives and zero polynomial root certificates.
