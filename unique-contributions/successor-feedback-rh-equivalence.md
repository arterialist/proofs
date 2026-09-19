# Complete RH equivalence for the arithmetic successor feedback driver

**Status:** analytic proof with exact contour shift, September 2026.
Note locations:
- [building-blocks/successor-and-division/successor-feedback-tail-Abel-poles.md](../building-blocks/successor-and-division/successor-feedback-tail-Abel-poles.md)
- [building-blocks/successor-and-division/successor-feedback-RH-converse.md](../building-blocks/successor-and-division/successor-feedback-RH-converse.md)

Attribution: Arterialist RH research team, September 2026.
Classical Tauberian / Abel-type criteria for RH: Riesz (1916), Hardy–Littlewood (1918), Báez-Duarte (2003).
While many generating function criteria for RH exist, they typically exhibit rapid decay or lack an exact
non-zero positive margin under RH. This theorem establishes a complete equivalence between RH and
the eventual positivity of the literal arithmetic successor driver $E(r) = \sum_{j \ge 0} e_j r^j$,
with an explicit positive margin $E(r) > 5/3$.

## Statement

Let $e_j$ be the exact arithmetic successor driver sequence derived from the discrete-continuum
renewal balance of primes:
\[
 D_e(z) = \sum_{j=0}^\infty \frac{e_j}{(j+1)^z} = a_*(z) A(z) + R(z),
\]
where $A(z) = \frac{-\zeta'(z+1/2)}{(z+1/2)\zeta(z+1/2)} - \frac{1}{z-1/2}$, $a_*(z) = \frac{z-1/2}{2} \mathrm{B}(1-z, 1/2)$,
and $R(z)$ is the kernel remainder of the clipped birth cell.
Let $E(r) = \sum_{j=0}^\infty e_j r^j$ be its Abel generating function for $0 < r < 1$.

**Theorem.**
1. **Forward implication (Abel pole failure):**
   If RH fails, so that $\zeta(s_0) = 0$ with $\beta_0 = \operatorname{Re}(s_0) > 1/2$, then $D_e(z)$ has a pole
   in the half-plane $\operatorname{Re}(z) > 0$ at $z_0 = s_0 - 1/2$, causing $E(r)$ to oscillate with unbounded
   amplitude $(1-r)^{-\sigma_0}$, forcing $E(r)$ to take strictly negative values infinitely often as $r \to 1^-$.
2. **Converse implication (Conditional positive margin):**
   If RH holds, then:
   \[
    \boxed{\quad E(r) > \frac{5}{3} \quad \text{for all } r \in (r_0, 1) \text{ for some } r_0 < 1. \quad}
   \]
   In particular, the constant lead term is $\frac{5}{3} > 0$ and the oscillatory zero contributions
   decay on the scale $O((1-r)^{1/2} \log^2(1/(1-r)))$.

**Corollary (Exact RH Equivalence).**
\[
 \mathrm{RH} \iff \liminf_{r \to 1^-} E(r) \ge 0 \iff \liminf_{r \to 1^-} E(r) \ge \frac{5}{3}.
\]

## Mathematical significance

Unlike the classical Riesz criterion $R(x) = \sum_{k=1}^\infty \frac{(-1)^{k+1} x^k}{(k-1)! \zeta(2k)} = O(x^{1/4+\epsilon})$
or the Báez-Duarte formulation $c_k = \sum_{j=0}^k (-1)^j \binom{k}{j} \frac{1}{\zeta(2j+2)} \ll k^{-3/4+\epsilon}$,
which require testing high-order asymptotic decay, the successor feedback driver $E(r)$ is a
**one-sided sign criterion with a positive margin**: under RH it does not decay to zero, but stabilizes
above $5/3$. Any off-line zero produces an un-cancellable power-law blowup into the negative half-line.

Full proofs:
- Forward: [successor-feedback-tail-Abel-poles.md](../building-blocks/successor-and-division/successor-feedback-tail-Abel-poles.md)
- Converse: [successor-feedback-RH-converse.md](../building-blocks/successor-and-division/successor-feedback-RH-converse.md)
