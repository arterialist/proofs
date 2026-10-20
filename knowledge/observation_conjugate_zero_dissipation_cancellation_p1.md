# Conjugate Zero Dissipation Kernel Cancellation on the Real Axis

Type: observation
Confidence: high
Source: explore_merger_L01_N08, explore_merger_L01_N09, explore_falser_L01_N09
Relevant to: Dissipation-based, resolvent-based, and Herglotz/spectral operator refutation strategies of off-line zeros

## Statement
For any hypothetical off-line zero $s = \sigma + it$ with $\sigma \in (1/2, 1)$ and $t \in \mathbb{R}$, Riemann's functional equation and Schwarz reflection force zeros of $\xi(s)$ to occur in conjugate pairs $\{s, \bar{s}\} = \{\sigma + it, \sigma - it\}$ (and quadruplets with $1-s, 1-\bar{s}$). For any standard resolvent or Cauchy dissipation kernel $D(s, x) := \operatorname{Im}\left(\frac{1}{x - s}\right) = \frac{t}{(x - \sigma)^2 + t^2}$ on the real axis $x \in \mathbb{R}$, the sum over the conjugate pair cancels identically:
$$D(s, x) + D(\bar{s}, x) = \frac{t}{(x - \sigma)^2 + t^2} + \frac{-t}{(x - \sigma)^2 + (-t)^2} \equiv 0 \quad \text{for all } x \in \mathbb{R}.$$

## Evidence
- Symbolically exact identity: $\operatorname{Im}\left(\frac{1}{x-s} + \frac{1}{x-\bar{s}}\right) = \operatorname{Im}\left(\frac{2x - 2\sigma}{(x-\sigma)^2 + t^2}\right) = 0$ since $x, \sigma, t \in \mathbb{R}$.
- Falser report for `explore_merger_L01_N09` verified this algebraic cancellation, showing that the candidate's claim of positive physical dissipation $D(s, x) > 0$ on $\mathbb{R}$ failed to account for the pairing of roots $\rho$ and $\bar{\rho}$.
- In `explore_merger_L01_N08`, the candidate's attempted coordinate dissipation kernel $D(s, x) = t(2\sigma - 1)$ similarly reduced to an uninformative coordinate condition that vanishes identically under symmetrization.

## Implications
Any proof route attempting to extract a strictly positive dissipation anomaly, entropy production rate, or coercive energy strictly from an off-line zero fails if the evaluation functional preserves real symmetry or sums over the completed zero spectrum $\sum_\rho D(\rho, x)$. Net dissipation on $\mathbb{R}$ can only be extracted if the test functional breaks conjugate symmetry $t \mapsto -t$, or if an asymmetric contour in the complex plane is chosen.

## Caveats
This cancellation applies specifically to symmetric evaluations along the real axis. It does not preclude asymmetric resolvent estimates in the upper half-plane $\mathbb{H}^+$ where $\operatorname{Im}(s) > 0$ is isolated, provided that the partner zero at $\bar{s} \in \mathbb{H}^-$ is not implicitly included with equal weight.
