# Unconditional two-sided unboundedness of the critical natural prime charge

**Status:** rigorous analytic proof without RH or ordinate independence assumptions, September 2026.
Note location:
- [building-blocks/dynamics-and-feedback/critical-natural-charge-two-sided-unboundedness.md](../building-blocks/dynamics-and-feedback/critical-natural-charge-two-sided-unboundedness.md)

Attribution: Arterialist RH research team, September 2026.
Literature context:
Littlewood (1914) proved that $\psi(x) - x = \Omega_\pm(\sqrt{x}\log\log\log x)$. In modern analytic number theory,
oscillation theorems for critical-line normalized sums $\sum_{n \le x} \Lambda(n)n^{-1/2} - 2\sqrt{x}$ often invoke
Turán's power-sum method or assume the Linear Independence (LI) hypothesis for zero ordinates.
This theorem establishes the exact unconditional two-sided unboundedness of the natural critical charge $M(x)$
and its integer restriction $M(N)$ using an exact seeded Laplace transform paired with a positive compactly supported Fourier mollifier
and Dirichlet torus recurrence, bypassing all linear independence and simplicity hypotheses.

## Statement

Define the natural critical charge for $x \ge 1$:
\[
 M(x) := \sum_{n \le x} \frac{\Lambda(n)}{\sqrt{n}} - 2\sqrt{x} + 1.
\]

**Theorem (Unconditional Two-Sided Unboundedness).**
\[
 \boxed{\quad \limsup_{x \to \infty} M(x) = +\infty, \qquad \liminf_{x \to \infty} M(x) = -\infty. \quad}
\]
Furthermore, the unboundedness holds identically when restricted to integers $N \in \mathbb{N}$:
\[
 \boxed{\quad \limsup_{N \to \infty} M(N) = +\infty, \qquad \liminf_{N \to \infty} M(N) = -\infty. \quad}
\]
Neither the Riemann Hypothesis nor the linear independence of the zero ordinates $\gamma_\rho$ is assumed.

## Proof architecture

1. **Exact Seeded Laplace Transform:**
   Setting $m(v) = M(e^v)\mathbf{1}_{[0, \infty)}(v)$, the Laplace transform for $\Re z > 1/2$ evaluates exactly to:
   \[
    \mathcal{M}(z) = \int_0^\infty e^{-zv} m(v)\,dv = \frac{1}{z}\left[-1 - \frac{\zeta'}{\zeta}\left(z + \frac{1}{2}\right) - \frac{1}{z - 1/2}\right].
   \]
   The apparent pole at $z=1/2$ cancels identically. If $M(x)$ were eventually bounded on one side ($M(x) \le B$ or $M(x) \ge -B$),
   Landau's Laplace abscissa theorem would force $\mathcal{M}(z)$ to be holomorphic on $\Re z > 0$, forcing RH.
2. **Positive Fourier Smoothing under RH:**
   Under RH, choosing a positive Schwartz kernel $K$ with $\widehat{K} \in C_c^\infty((-1, 1))$, $\widehat{K} \ge 0$, and scaling $K_T(v) = T K(Tv)$ yields:
   \[
    (K_T * m)(v) = C - 2\sum_{0 < \gamma < T} \frac{m_\gamma \widehat{K}(\gamma/T)}{\gamma} \sin(\gamma v) + o_T(1) \qquad (v \to \infty).
   \]
3. **Dirichlet Torus Recurrence without Linear Independence:**
   At short times $v_T = b_0/T$, the trigonometric polynomial satisfies $P_T(v_T) \le C - c_1 \log T$ and $P_T(-v_T) \ge C + c_1 \log T$.
   By compactness of the torus $\mathbb{T}^J$, simultaneous recurrence $e^{i\gamma h_j} \to 1$ transfers these opposite $\pm c_1 \log T$ configurations
   arbitrarily far to the right, contradicting any one-sided bound and proving two-sided unboundedness unconditionally.

Full proof:
- [building-blocks/dynamics-and-feedback/critical-natural-charge-two-sided-unboundedness.md](../building-blocks/dynamics-and-feedback/critical-natural-charge-two-sided-unboundedness.md)
