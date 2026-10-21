# Conjugate Zero Dissipation Kernel Cancellation on the Real Axis

Type: observation
Confidence: high
Source: explore_merger_L01_N08, explore_merger_L01_N09, explore_falser_L01_N09, explore_merger_L04_N00, explore_falser_L04_N00, explore_merger_r2_L01_N02
Relevant to: Dissipation-based, resolvent-based, and Herglotz/spectral operator refutation strategies of off-line zeros

## Statement
For any hypothetical off-line zero $s = \sigma + it$ with $\sigma \in (1/2, 1)$ and $t \in \mathbb{R}$, Riemann's functional equation and Schwarz reflection force zeros of $\xi(s)$ to occur in conjugate pairs $\{s, \bar{s}\} = \{\sigma + it, \sigma - it\}$ (and quadruplets with $1-s, 1-\bar{s}$).
1. For any standard linear resolvent dissipation kernel $D(s, x) := \operatorname{Im}\left(\frac{1}{x - s}\right) = \frac{t}{(x - \sigma)^2 + t^2}$ on the real axis $x \in \mathbb{R}$, the sum over the conjugate pair cancels identically:
$$D(s, x) + D(\bar{s}, x) = \frac{t}{(x - \sigma)^2 + t^2} + \frac{-t}{(x - \sigma)^2 + (-t)^2} \equiv 0 \quad \text{for all } x \in \mathbb{R}.$$

2. In the reflection-invariant quadratic spectral parameter $z(s) := s(1-s)$, since $z(\bar{s}) = \bar{s}(1 - \bar{s}) = \overline{s(1 - s)} = \overline{z(s)}$, the characteristic resolvent sum:
$$\mathcal{D}(s, x) + \mathcal{D}(\bar{s}, x) := \operatorname{Im}\left(\frac{1}{z(s) - x}\right) + \operatorname{Im}\left(\frac{1}{z(\bar{s}) - x}\right) = \operatorname{Im}\left(\frac{2(\operatorname{Re}(z(s)) - x)}{|z(s) - x|^2}\right) \equiv 0 \quad \text{for all } x \in \mathbb{R}.$$

3. In the upper complex half-plane with probe frequency $w = u + iv \in \mathbb{C}^+$ ($v > 0$), for an off-line conjugate pair $s = 1/2 + \delta + it$ and $\bar{s} = 1/2 + \delta - it$ ($\delta > 0, t \ge \gamma_1$), the net imaginary resolvent sum in the quadratic parameter $z(s) = \lambda_\delta - 2it\delta$ (where $\lambda_\delta = 1/4 + t^2 - \delta^2$) satisfies:
$$\Sigma(s, w) := \operatorname{Im}\left(\frac{1}{z(s) - w}\right) + \operatorname{Im}\left(\frac{1}{z(\bar{s}) - w}\right) = \frac{2v\left[(\lambda_\delta - u)^2 + v^2 - (2t\delta)^2\right]}{\left[(\lambda_\delta - u)^2 + (2t\delta + v)^2\right] \left[(\lambda_\delta - u)^2 + (2t\delta - v)^2\right]}.$$
Consequently, $\Sigma(s, w)$ vanishes identically along the upper half-plane algebraic semicircle $(u - \lambda_\delta)^2 + v^2 = (2t\delta)^2$ ($v > 0$), and is strictly negative inside it ($(u - \lambda_\delta)^2 + v^2 < 4t^2\delta^2$).

## Evidence
- Symbolically exact identity: $\operatorname{Im}\left(\frac{1}{x-s} + \frac{1}{x-\bar{s}}\right) = \operatorname{Im}\left(\frac{2x - 2\sigma}{(x-\sigma)^2 + t^2}\right) = 0$ since $x, \sigma, t \in \mathbb{R}$.
- In `explore_merger_L04_N00` / `explore_falser_L04_N00`, SymPy confirmed $\operatorname{Im}\left(\frac{1}{z(s)-x} + \frac{1}{z(\bar{s})-x}\right) = 0$ identically on $\mathbb{R}$ for real $\sigma, t, x$.
- Falser report for `explore_merger_L01_N09` verified this algebraic cancellation, showing that the candidate's claim of positive physical dissipation $D(s, x) > 0$ on $\mathbb{R}$ failed to account for the pairing of roots $\rho$ and $\bar{\rho}$.
- In `explore_merger_L01_N08`, the candidate's attempted coordinate dissipation kernel $D(s, x) = t(2\sigma - 1)$ similarly reduced to an uninformative coordinate condition that vanishes identically under symmetrization.
- In `explorer_r2_L00_N05` and `explore_falser_r2_L00_N05`, evaluating $\Sigma(s, w)$ across the upper half-plane confirmed that at $(u - \lambda_\delta)^2 + v^2 = (2t\delta)^2$, $\Sigma \equiv 0$ identically (evaluated to $6.24 \times 10^{-18} \approx 0$ at 25 dps), and inside the semicircle evaluates to $-0.17656 < 0$.

## Implications
Any proof route attempting to extract a strictly positive dissipation anomaly, entropy production rate, or coercive energy strictly from an off-line zero fails if the evaluation functional preserves real symmetry or sums over the completed zero spectrum $\sum_\rho D(\rho, x)$. Furthermore, shifting probe frequencies into the upper half-plane $\mathbb{C}^+$ does not eliminate conjugate cancellation; it merely relocates the nodal set from the real axis to an algebraic semicircle of radius $2t\delta$ centered at $\lambda_\delta$, inside of which candidate off-line zeros actively oppose Herglotz positivity by contributing negative imaginary parts.

## Caveats
This cancellation applies to symmetric resolvent sums pairing $s$ and $\bar{s}$. It does not preclude single-zero chiral projections where the partner zero $\bar{s}$ is strictly excluded by an asymmetric directional cutoff, though such cutoffs must avoid introducing non-analytic boundary discontinuities.
