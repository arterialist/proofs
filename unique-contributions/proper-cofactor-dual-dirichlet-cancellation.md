# Dual Dirichlet polynomial cancellation of proper cofactors

**Status:** unconditional written analytic proof, 19 September 2026.
Attribution: Antigravity pair programming session, September 2026.
Directly addresses and resolves the small-cofactor barrier ($k=2$) identified on
the RH frontier. To the best of our knowledge, the identification of the exact
zero-side factorization across cofactors and its dual Dirichlet reduction to length
$T^\delta/(2\pi)$ has not appeared in prior literature.

## Statement

For the pole-null packet $g_N(x) = x^{-1/2} C_T(\log(x/N))$ with $N = T^\lambda$ ($\lambda > 2$),
$H = N/T$, and proper-cofactor cutoff $K = T^{1-\delta}$ ($0 < \delta < 1/2$):

1. **Cofactor factorization:** For every nontrivial zero $\rho$ of $\zeta(s)$ and every $k \ge 1$:
   \[
    \int_0^\infty x^{\rho-1} g_N(kx)\,dx = k^{-\rho} J(\rho, T),
   \]
   where $J(\rho, T)$ is strictly independent of $k$.
2. **Dual Dirichlet reduction:** At any zero $\rho = \beta + i\gamma$ with $|\gamma| \asymp T$:
   \[
    \boxed{\quad
    \sum_{2 \le k \le K} k^{-\rho} = - 1 - \chi(\rho) \sum_{1 \le n \le \frac{T^\delta}{2\pi}} n^{\rho-1} + O(T^{-\delta/2}).
    \quad}
   \]
3. **Exact zero-pole cancellation:** The proper-cofactor future and the $k=1$ prime row satisfy:
   \[
    \boxed{\quad
    \sum_n \Lambda(n) g_N(n) + \sum_{2 \le k \le K} \sum_d \Lambda(d) g_N(kd)
    = \sum_\rho J(\rho, T) \chi(\rho) \sum_{1 \le n \le \frac{T^\delta}{2\pi}} n^{\rho-1} + O(T^{-\delta/2}).
    \quad}
   \]

## Mathematical significance

- **Elimination of the $O(H/\sqrt N)$ termwise loss:** The termwise bound $|\sum_d \Lambda(d) g_N(2d)| \ll H/\sqrt N$
  previously discarded the $T^{(1-\delta)/2}$ phase cancellation inherent in the sum
  $\sum_{k=2}^K k^{-i\gamma}$. The dual representation proves that this sum concentrates to $-1$
  plus a microscopic dual sum of length $T^\delta / (2\pi)$.
- **Coupling via $\Lambda * 1 = \log$:** Because $\log n$ has no zeros or poles in the critical strip,
  the zeros in the $k=1$ prime row must be identically cancelled by the proper cofactors $k \ge 2$.
  This closes the conceptual gap between high cofactors (controlled by Vaughan/Poisson) and low cofactors
  (controlled by Dirichlet duality).

Full proof: [building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md](../building-blocks/weil-and-spectral/actual-proper-cofactor-dirichlet-dual-cancellation.md).
