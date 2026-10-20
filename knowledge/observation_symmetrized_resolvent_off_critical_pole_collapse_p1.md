# Symmetrized Resolvent Invariant Mapping and Off-Critical Pole Collapse

Type: observation
Confidence: high
Source: Candidate 29 (Level 0 falser report), Candidate L01_N06, explore_falser_L01_N06
Relevant to: Invariant quadratic spectral parameter $z(s) = s(1-s)$, resolvent expansions, and Herglotz-Pick dispersion relations

## Statement
1. The reflection-invariant quadratic parameter $z(s) := s(1-s)$ maps the critical strip to the complex spectral plane as follows:
   - The critical line $\operatorname{Re}(s) = 1/2$ maps strictly to the real half-line $\lambda = 1/4 + t^2 \in [1/4, \infty) \subset \mathbb{R}$.
   - Points off the critical line with $\sigma > 1/2$ and $t > 0$ map to $\operatorname{Im}(z) = -t(2\sigma - 1) < 0$ (lower half-plane $\mathbb{C}^-$).
   - Conjugate points with $\sigma > 1/2$ and $t < 0$ map to $\operatorname{Im}(z) = -t(2\sigma - 1) > 0$ (upper half-plane $\mathbb{C}^+$).

2. Factoring the completed Riemann zeta function $\xi(s) = \Xi_*(s(1-s))$ yields an entire function $\Xi_*(z)$ of order $1/2 < 1$ (genus 0). Its negative logarithmic derivative $F(z) := -\Xi_*'(z)/\Xi_*(z) = \sum_{n=1}^\infty \frac{1}{\lambda_n - z}$ has imaginary part:
$$\operatorname{Im}(F(z)) = \sum_{n=1}^\infty \frac{\operatorname{Im}(z) - \operatorname{Im}(\lambda_n)}{|\lambda_n - z|^2}.$$
For any Herglotz function, Schwarz reflection $F(\bar{z}) = \overline{F(z)}$ forces $\operatorname{Im}(F(z)) > 0$ on $\mathbb{C}^+$ and $\operatorname{Im}(F(z)) < 0$ on $\mathbb{C}^-$.

3. While critical zeros produce a strictly negative imaginary field on $\mathbb{C}^-$ (e.g. $-0.0005868$ at $z = 100.1875 - 5.0i$), a single hypothetical off-critical zero $\rho_0 = \beta_0 + i\gamma_0$ with $\beta_0 > 1/2, \gamma_0 > 0$ introduces a pole in $\Xi_*(z)$ at $\bar{\lambda}_0 = z(\bar{\rho}_0) \in \mathbb{C}^+$ with residue $-m$. Evaluating near this pole at $z = \bar{\lambda}_0 - i\epsilon \in \mathbb{C}^+$ yields $\operatorname{Im}(F(z)) \to -\infty$, completely collapsing Herglotz positivity.

4. The uncompleted logarithmic derivative $-\zeta'(s)/\zeta(s)$ is **not** a Herglotz/Pick function:
Attempting to treat $-\zeta'(s)/\zeta(s)$ as a Herglotz function mapping the upper half-plane to itself is mathematically false. In the half-plane of absolute convergence $\operatorname{Re}(s) > 1$:
$$\operatorname{Im}\left(-\frac{\zeta'(s)}{\zeta(s)}\right) = -\sum_{n=1}^\infty \frac{\Lambda(n)}{n^\sigma} \sin(t \log n),$$
which takes strictly negative values for small $t > 0$. Furthermore, near critical zeros $\rho_n = 1/2 + i\gamma_n$, $-\zeta'/\zeta$ has simple poles with residue $-1$, causing $\operatorname{Im}(-\zeta'/\zeta)$ to diverge to $-\infty$ on neighborhoods in the upper half-plane.

## Evidence
1. Exact evaluation of $F(z)$ on $\mathbb{C}^-$ at $s = 0.75 + 10.0i$ ($z = 100.1875 - 5.0i$, $\operatorname{Im}(z) = -5.0$):
   - Analytic formula: $F(z) = 0.02953185 - 0.00058684 i$
   - 99-zero resolvent sum: $F_{99}(z) = 0.02640150 - 0.00058676 i$
   - Confirms that $\operatorname{Im}(F(z)) < 0$ on $\mathbb{C}^-$, refuting candidate 29's claim that critical zeros produce a positive imaginary field on $\mathbb{C}^-$.
2. Off-critical zero perturbation:
   - For hypothetical zero $\rho_0 = 0.6 + 14.134725i$, $\bar{\lambda}_0 = 200.0305 + 2.8269i \in \mathbb{C}^+$.
   - At probe point $z_{\mathrm{probe}} = \bar{\lambda}_0 - 0.001i \in \mathbb{C}^+$ ($\operatorname{Im}(z_{\mathrm{probe}}) = +2.8259 > 0$):
     - Background field from critical zeros: $+0.0199 + 0.3539 i$
     - Off-critical pole contribution: $-1000.0 i$
     - Total imaginary part: $\operatorname{Im}(F(z_{\mathrm{probe}})) = -999.646 < 0$.
3. Numerical falsification of Herglotz property for $-\zeta'(s)/\zeta(s)$ (mpmath, 25 dps):
   - At $s = 1.5 + 0.5i$ (inside $\operatorname{Re}(s) > 1$): $\operatorname{Im}(-\zeta'/\zeta) = -0.928515 < 0$.
   - At $s = 2.0 + 3.0i$ (inside $\operatorname{Re}(s) > 1$): $\operatorname{Im}(-\zeta'/\zeta) = -0.050953 < 0$.
   - At $s = 0.6 + 1.0i$: $\operatorname{Im}(-\zeta'/\zeta) = -0.646862 < 0$.
   - At $s = 0.6 + 14.0i$: $\operatorname{Im}(-\zeta'/\zeta) = -4.699338 < 0$.

## Implications
1. Herglotz positivity of $F(z)$ on $\mathbb{C}^+$ is strictly equivalent to the Riemann Hypothesis; proving Herglotz positivity directly from $F(z)$ requires proving that $\zeta'/\zeta$ has no poles in $\sigma > 1/2$, which is circularly equivalent to RH.
2. Numerical testing over finite sets of critical zeros trivially produces Herglotz signs because $\lambda_n \in \mathbb{R}$, demonstrating extreme blindness to hypothetical off-critical poles.
3. Proving RH via Herglotz/Pick mapping of $-\zeta'(s)/\zeta(s)$ is completely blocked because $-\zeta'/\zeta$ fails Herglotz sign definiteness across the upper half-plane.

## Caveats
The quadratic mapping $z(s) = s(1-s)$ is a 2-to-1 conformal branched covering ramified at $s = 1/2$ ($z = 1/4$).
