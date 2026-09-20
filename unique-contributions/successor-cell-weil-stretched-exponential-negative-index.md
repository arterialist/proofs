# Stretched-exponential negative index bound for discretized Weil form

**Status:** unconditional written analytic proof, September 2026.
Attribution: Arterialist RH research team, September 2026.
To the best of our knowledge, an unconditional upper bound on the negative index of
inertia for physical-space discretizations of the complete Weil quadratic form has not
previously appeared in the literature.

The source comparison covered Bombieri's 2000 finite/infinite-dimensional Weil
truncation results and the recent Galerkin comparison cited in the audit ledger.
No matching quantitative successor-cell estimate was located in that bounded
search. The statement is therefore a provisional best-knowledge comparison for
this specific discretization and rate, not a claim about all Weil truncations.

## Statement

Let $S_N = \operatorname{span}\{ \mathbf{1}_{I_n} : 1 \le n \le N \}$ be the $N$-dimensional
physical discretization space on successor cells $I_n = [\log n, \log(n+1))$, with
orthonormal basis $e_n = \mathbf{1}_{I_n} / \sqrt{\ell_n}$ where $\ell_n = \log((n+1)/n)$.
Let $Q_N$ denote the complete $N$-cell Weil form, including all prime powers $\Lambda(p^j)$,
the complete digamma multiplier, and both pole projections.

**Theorem.** There exist absolute constants $c, C > 0$ and an integer $N_0$ such that,
for all $N \ge N_0$, there exists a subspace $V_N \subseteq S_N$ satisfying:
\[
 \boxed{\quad
 \operatorname{codim}_{S_N} V_N \le C N \exp\left( - c \sqrt{\log N \log\log N} \right), \qquad
 Q_N(f) \ge c \log N \|f\|_2^2 \quad (f \in V_N).
 \quad}
\]
In particular, the negative index of inertia of the complete discretized Weil form satisfies:
\[
 \boxed{\quad
 \operatorname{ind}_{\le 0}(Q_N) \ll N \exp\left( - c \sqrt{\log N \log\log N} \right) = o(N).
 \quad}
\]

## Mathematical comparison

- **Bombieri's conditional result (2000):** Bombieri studied truncations of the infinite-dimensional
  Fourier matrix of Weil's functional and showed that *if RH is false with only finitely many off-line zeros*,
  the negative index equals half the number of exceptional zeros.
- **The successor-cell result:** Proves an **unconditional upper bound** on the negative index of the
  specified discretization $Q_N$. The fraction of nonpositive directions in that finite-dimensional
  space tends to zero at the stretched-exponential rate
  $\exp(-c\sqrt{\log N \log\log N})$. This statement does not bound off-line zeta zeros or establish
  positivity of the full Weil form.

Full proof: [building-blocks/weil-and-spectral/compact-weil-successor-cell-negative-index-stretched-exponential.md](../building-blocks/weil-and-spectral/compact-weil-successor-cell-negative-index-stretched-exponential.md).
