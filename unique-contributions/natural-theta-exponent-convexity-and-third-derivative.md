# Natural theta Mellin-ratio derivative signs

**Status:** computer-assisted mathematical proof with Arb interval certificates, September 2026.
Compact-range certificates:
- [theta_reciprocal_score_convexity.py](../certificates/theta_reciprocal_score_convexity.py)
- [theta_natural_exponent_third_derivative.py](../certificates/theta_natural_exponent_third_derivative.py)

Attribution: Arterialist RH research team, September 2026.
To the best of our knowledge, the strict concavity $\phi_{\rm nat}''(s) < 0$ and strictly positive
third derivative $\phi_{\rm nat}'''(s) > 0$ for the Mellin interpolant ratio of the complete
Riemann theta kernel have not appeared previously in the literature.

The bounded source comparison covers the DLMF theta/Mellin identities, the
Planat--Solé Laguerre-expression results, and public theta formalization
inventories as of September 2026. No exact match for this normalized ratio and
the simultaneous second- and third-derivative signs was found. This is an
honest best-knowledge statement about that search, not an absolute priority
claim and not an all-order complete-monotonicity claim.

## Statement

Let $\Phi(u) = \sum_{n=1}^\infty (4\pi^2 n^4 e^{9u/2} - 6\pi n^2 e^{5u/2}) e^{-\pi n^2 e^{2u}}$ be the
complete Riemann theta kernel. Set $h(v) = \Phi(\sqrt{v})$ for $v \ge 0$, and define the derivative kernel
and score:
\[
 g(v) = -h'(v), \qquad k(v) = -\frac{g'(v)}{g(v)}.
\]
Let $F(s+1) = \frac{\sqrt{\pi} 4^{-s}}{Z \Gamma(s+1/2)} \int_0^\infty u^{2s} \Phi(u)\,du$ be the normalized
Mellin interpolant of $\Phi$, and define the natural exponent for real $s > -3/2$:
\[
 \phi_{\rm nat}(s) := \frac{F(s)}{F(s+1)} = 4 \mathbb{E}_{s+3/2} k(V).
\]

**Theorem.**
1. **Reciprocal score convexity:** On the entire closed half-line $v \in [0, \infty)$,
   \[
    \boxed{\quad 2 k'(v)^2 - k(v) k''(v) > 0. \quad}
   \]
   Equivalently, the reciprocal score $1/k(v)$ is strictly convex on $[0, \infty)$.
2. **Strict concavity of $\phi_{\rm nat}$:** On the entire real domain $s \in (-3/2, \infty)$,
   \[
    \boxed{\quad \phi_{\rm nat}(s) > 0, \qquad \phi_{\rm nat}'(s) > 0, \qquad \phi_{\rm nat}''(s) < 0. \quad}
   \]
3. **Positive third derivative:** On the entire real domain $s \in (-3/2, \infty)$,
   \[
    \boxed{\quad \phi_{\rm nat}'''(s) > 0. \quad}
   \]

## Mathematical significance

The alternating signs $\phi_{\rm nat}'(s) > 0$, $\phi_{\rm nat}''(s) < 0$, and $\phi_{\rm nat}'''(s) > 0$
show that $\phi_{\rm nat}'(s)$ exhibits complete monotonicity up to third order on $(-3/2, \infty)$.
In the theory of entire functions and Turán inequalities, this establishes that the quotient of
consecutive Mellin moments of the Riemann theta kernel is a strictly concave operator on the critical
line interpolants, directly complementing the recent proof of the Csordas–Dimitrov conjecture
for the first Laguerre expression (Planat & Solé, arXiv:2608.19160, August 2026).

Full proof:
- [building-blocks/theta-and-heat/theta-natural-exponent-concavity.md](../building-blocks/theta-and-heat/theta-natural-exponent-concavity.md)
- [building-blocks/theta-and-heat/theta-natural-exponent-third-derivative.md](../building-blocks/theta-and-heat/theta-natural-exponent-third-derivative.md)
Certificates:
- [certificates/theta_reciprocal_score_convexity.py](../certificates/theta_reciprocal_score_convexity.py)
- [certificates/theta_natural_exponent_third_derivative.py](../certificates/theta_natural_exponent_third_derivative.py)
