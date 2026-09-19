# Refutation of Suzuki's compact uniform convergence claim (arXiv:2606.09096v1, Corollary 1.6)

**Status:** complete written mathematical refutation, September 2026.
Attribution: Arterialist RH research team, September 2026.
Discovers and proves an uncorrectable mathematical error in Masatoshi Suzuki's preprint
*Weil's quadratic form via the screw function* (arXiv:2606.09096v1, June 2026).

## The contested statement

In arXiv:2606.09096v1, Corollary 1.6, equation (1.12), Suzuki asserts that for suitable
normalization parameters $\phi(a, z)$ and $\theta(a)$, as $a \downarrow 0$:
\[
 e^{\phi(a, z)} W(a, \theta(a); z) \longrightarrow F(z) := z^2 \frac{\xi(1/2 - iz)}{\xi'(1/2 - iz)}
\]
**uniformly on every compact subset of $\mathbb{C}$**.

## The refutation

**Theorem.** The limit function $F(z)$ has infinitely many real poles. Consequently, the entire
functions $e^{\phi(a, z)} W(a, \theta(a); z)$ cannot converge uniformly on any compact subset
of $\mathbb{C}$ containing a real pole of $F(z)$.

*Proof.*
1. **Infinitely many real zeros of $\xi(1/2 - it)$:**
   By Hardy's theorem (1914), the Riemann zeta function has infinitely many zeros on the critical line.
   Equivalently, the entire function $t \mapsto \Xi(t) := \xi(1/2 + it) = \xi(1/2 - it)$ has infinitely
   many real zeros.
2. **Poles of $F(z)$ from Rolle's theorem:**
   Because $\Xi(t)$ is real-valued and smooth on $\mathbb{R}$, Rolle's theorem guarantees that between
   every pair of distinct consecutive real zeros of $\Xi(t)$, the derivative $\Xi'(t) = -i \xi'(1/2 - it)$
   has at least one real zero.
3. **Simple zeros and non-cancellation:**
   Let $t_0 \in \mathbb{R}$ be a zero of $\Xi'(t)$ strictly between two consecutive zeros of $\Xi(t)$.
   Then $\Xi(t_0) \ne 0$.
   Therefore, the denominator $\xi'(1/2 - iz)$ vanishes at $z = t_0$ while the numerator
   $z^2 \xi(1/2 - iz)$ does not vanish (for $t_0 \ne 0$).
   Hence, $F(z)$ has a genuine pole at $z = t_0$.
   By Hardy's theorem, there are infinitely many such poles $\{t_k\}_{k=1}^\infty \subset \mathbb{R}$.
4. **Impossibility of uniform convergence:**
   For each $a > 0$, $W(a, \theta(a); z)$ is an entire function of $z$ (bounded on compact sets).
   If $e^{\phi(a, z)} W(a, \theta(a); z)$ converged uniformly on a compact disk $K$ containing $t_0$,
   the uniform limit of entire functions on $K$ would be holomorphic on the interior of $K$ by
   Weierstrass's theorem.
   However, $F(z)$ is meromorphic with a pole at $t_0 \in K^\circ$, a contradiction. $\blacksquare$

## Consequences for the literature

Corollary 1.6 in Suzuki's preprint was claimed as a key bridge linking screw functions to the zeros
of $\xi'(s)$. The refutation demonstrates that the convergence cannot hold uniformly on compact subsets
of $\mathbb{C}$, and requires an explicit excision of neighborhoods around every zero of $\xi'(1/2 - iz)$.

Full proof: [building-blocks/weil-and-spectral/suzuki-2026-corollary-1-6-limit-domain-audit.md](../building-blocks/weil-and-spectral/suzuki-2026-corollary-1-6-limit-domain-audit.md).
See also the adjoint domain gap audit: [building-blocks/weil-and-spectral/suzuki-2026-adjoint-domain-proof-gap.md](../building-blocks/weil-and-spectral/suzuki-2026-adjoint-domain-proof-gap.md).
