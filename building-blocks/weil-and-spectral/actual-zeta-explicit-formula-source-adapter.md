# Actual-zeta explicit formula in Fourier and Laplace conventions

The [standalone Lean package](../../formalization/integrations/anthropic-weil/README.md)
adapts the proved actual-zeta explicit formula from
[Anthropic's zeta23 library](https://github.com/anthropics/formal-math/tree/fbdc36bbf17d20af3fd0447c6d1a8a02773c9844/zeta23).
It exposes the complete arithmetic and spectral expressions in the
Fourier and bilateral Laplace conventions used in this repository.
This is an integration of existing mathematics, with source attribution;
it is not a new zero bound or a proof of RH.

For every complex \(k\in C_c^2(\mathbb R)\), put
\[
F_k^-(z)=\int_{\mathbb R}k(u)e^{-izu}\,du,
\qquad M_k(w)=\int_{\mathbb R}k(u)e^{wu}\,du,
\qquad h(t)=\operatorname{Re}\psi(1/4+it/2)-\log\pi.
\]
The adapter proves, for the actual nontrivial zeros of Mathlib's
\(\zeta\) and their analytic multiplicities \(m_\rho\),
\[
\begin{aligned}
\sum_\rho m_\rho M_k(\rho-1/2)
={}&M_k(1/2)+M_k(-1/2)\\
&-\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
                 [k(\log n)+k(-\log n)]\\
&+\frac1{2\pi}\int_{\mathbb R}M_k(it)h(t)\,dt .
\end{aligned} \tag{1}
\]
The zero series is absolutely convergent. The gamma integral has an
explicit integrability theorem, and compact support makes the prime row
finite. Every \(\Lambda(p^j)=\log p\) is retained. The source convention
uses \(F_k^+(z)=\int k(u)e^{izu}du\); the verified dictionaries are
\(F_k^-(z)=F_k^+(-z)\) and \(M_k(w)=F_k^+(w/i)\).
In particular the minus-transform zero frequency is
\(-(\rho-1/2)/i\), rather than \((\rho-1/2)/i\).

For arbitrary complex \(f,g\in C_c^2(\mathbb R)\), set
\[
K_{f,g}(x)=\int_{\mathbb R}f(u)\overline{g(u-x)}\,du.
\]
The Hermitian version of (1) has the absolutely convergent zero side
\[
\sum_\rho m_\rho
 M_f(\rho-1/2)\overline{M_g(1/2-\overline\rho)}, \tag{2}
\]
and the right side of (1) with \(k=K_{f,g}\).
The reflected conjugate argument in (2) matters: it gives an absolute
square for \(f=g\) at a critical-line zero, while an off-line term retains
two different arguments. The adapter preserves this distinction.

The [proof module](../../formalization/integrations/anthropic-weil/ActualWeil.lean)
contains `actual_explicit_formula`, `actual_hermitian_explicit_formula`,
`actual_laplace_explicit_formula`, and
`actual_laplace_hermitian_formula`, together with convergence and
normalization lemmas. Its pair-density theorem also proves integrability
of \(M_f(it)\overline{M_g(it)}\nu_{e^L}(t)\) for a shared support
interval of length \(L>0\). Read those support conditions with that
theorem; the cutoff is \(X=e^L\).

The package pins the upstream source commit, Lean 4.33.0-rc2 and its
Mathlib revision. Its proof closure and adapter were checked locally at
that pin, and the audited adapter declarations use only `propext`,
`Classical.choice`, and `Quot.sound`. The repository's primary Lean 4.24
package remains separate; the integration has its own build instructions.
The [upstream paper](https://www-cdn.anthropic.com/95c246936988e43127bc6b2ceb7077c1dad2d68e.pdf)
and the package's NOTICE record provenance.

This supplies an actual identity and convergence component for compact
test families. Quantitative spectral and arithmetic inequalities,
extensions to noncompact or step-function tests, and the repository's
full prime-error bounds remain additional obligations. Importing (1)
does not construct the full `UniversalWeilSystem` or discharge RH.
