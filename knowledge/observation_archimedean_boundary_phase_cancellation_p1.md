# Archimedean Phase Velocity Boundary Cancellation and Negative Normal Curvature

Type: observation
Confidence: high
Source: explorer_r2_L00_N06, explore_falser_r2_L00_N06
Relevant to: Logarithmic derivative positivity, phase rigidity, and Archimedean digamma baseline estimates for the completed zeta function

## Statement
1. In the decomposition of the completed zeta logarithmic derivative real part:
$$\operatorname{Re}\left(\frac{\xi'}{\xi}(\sigma+it)\right) = P(\sigma, t) + A(\sigma, t) + Z(\sigma, t),$$
where $P$ is the pole term, $A(\sigma, t) = \frac{1}{2}\operatorname{Re}\psi(s/2) - \frac{1}{2}\log\pi$ is the Archimedean digamma term, and $Z(\sigma, t) = \operatorname{Re}(\zeta'/\zeta(\sigma+it))$ is the arithmetic term:
The functional reflection identity $\xi(1-s) = \xi(s)$ combined with Schwarz reflection $\xi(\bar{s}) = \overline{\xi(s)}$ forces $\xi(1/2+it) \in \mathbb{R}$ for all $t \in \mathbb{R}$. Consequently:
$$\operatorname{Re}\left(\frac{\xi'}{\xi}(1/2+it)\right) \equiv 0 \quad \text{for all } t \in \mathbb{R} \setminus \{\gamma_n\}.$$
This forces an exact algebraic cancellation $Z(1/2, t) = -(P(1/2, t) + A(1/2, t))$ on the boundary, so the Archimedean baseline $A \sim \frac{1}{2}\log(t/2\pi) > 0$ provides zero positive margin at $\sigma = 1/2$.
2. Furthermore, the transverse normal derivative of the Archimedean term at the critical line is strictly negative for all large $t$:
$$\left.\frac{\partial}{\partial \sigma} A(\sigma, t)\right|_{\sigma=1/2} = \frac{1}{4}\operatorname{Re}\psi'\left(\frac{1}{4} + i\frac{t}{2}\right) \sim -\frac{1}{4t^2} < 0.$$
Rather than pushing phase velocity into the positive half-plane, the Archimedean factor exerts a negative downward pull on $\operatorname{Re}(\xi'/\xi)$ away from $\sigma = 1/2$.

## Evidence
- High-precision numerical evaluation (30 dps in mpmath) verified that $\operatorname{Re}(\xi'/\xi(1/2+it))$ has maximum absolute value $1.61 \times 10^{-26} \approx 0$ across all tested ordinates $t \in [14.135, 25.0]$.
- Asymptotic expansion of $\psi'(z) = 1/z + 1/(2z^2) + \dots$ at $z = 1/4 + it/2$ gives $\operatorname{Re}\psi'(1/4+it/2) = -1/t^2 + O(1/t^4)$, confirmed numerically to 4 digits across $t \in [14, 100]$ (e.g. at $t=15$, $\partial_\sigma A \approx -1.11 \times 10^{-3} < 0$).
- Positive transverse curvature $\partial_\sigma \operatorname{Re}(\xi'/\xi)|_{\sigma=1/2} = \sum_\rho 1/(t-\gamma)^2 > 0$ under RH is generated entirely by the zeros through the arithmetic term $Z$, not by the Archimedean factor.

## Implications
Proof strategies claiming that the Gamma-factor digamma term $A(\sigma, t) \sim \frac{1}{2}\log(t/2\pi)$ provides an affirmative positive barrier dominating arithmetic fluctuations across the critical strip are structurally flawed: the positive margin collapses to zero at $\sigma \to 1/2^+$, and the Gamma factor has wrong-sided normal curvature ($\partial_\sigma A < 0$). Any valid proof of $\operatorname{Re}(\xi'/\xi) > 0$ must rely entirely on non-Archimedean zero-spacing or global entire function properties.

## Caveats
Deep inside the right half-plane (e.g. $\sigma \ge 1$), Dirichlet series convergence bounds $|Z(\sigma, t)| \le -\zeta'/\zeta(\sigma) < \infty$, so the logarithmic growth of $A(\sigma, t)$ does eventually dominate at high frequencies for $\sigma \ge 1$. The boundary cancellation applies specifically to the critical strip boundary $\sigma \to 1/2^+$.
