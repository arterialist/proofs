# Symmetrized Resolvent Invariant Mapping and Off-Critical Pole Collapse

Type: observation
Confidence: high
Source: Candidate 29 (Level 0 falser report), Candidate L01_N06, explore_falser_L01_N06, explore_merger_L02_N01, explore_merger_L02_N02, explore_falser_L02_N01, explore_falser_L02_N02; Aggregator and Falser r2_L04_N00 (Level 4 Root)
Relevant to: Invariant quadratic spectral parameter $z(s) = s(1-s)$, resolvent expansions, Hadamard product phase envelopes, and Herglotz-Pick dispersion relations

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
In the half-plane of absolute convergence $\operatorname{Re}(s) > 1$:
$$\operatorname{Im}\left(-\frac{\zeta'(s)}{\zeta(s)}\right) = -\sum_{n=1}^\infty \frac{\Lambda(n)}{n^\sigma} \sin(t \log n),$$
which takes strictly negative values for small $t > 0$. Furthermore, near critical zeros $\rho_n = 1/2 + i\gamma_n$, $-\zeta'/\zeta$ has simple poles with residue $-1$, causing $\operatorname{Im}(-\zeta'/\zeta)$ to diverge to $-\infty$ on neighborhoods in the upper half-plane.

5. In the complex $s$-plane, the real part of the completed zeta logarithmic derivative admits the Hadamard zero sum:
$$\operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right) = \operatorname{Re}(B) + \sum_\rho \frac{\sigma - \beta}{(\sigma - \beta)^2 + (t - \gamma)^2}.$$
For any hypothetical off-line zero $\rho_0 = \beta_0 + i\gamma_0$ with $\beta_0 > 1/2$, the corresponding summand at $t = \gamma_0$ is strictly negative for all $\sigma \in (1/2, \beta_0)$, diverging to $-\infty$ as $\sigma \to \beta_0^-$. Thus, asserting positivity on $\sigma > 1/2$ requires already assuming $\beta \le 1/2$ for all zeros (circularity with RH). Furthermore, the difference:
$$R(s) := \frac{\xi'(s)}{\xi(s)} - \frac{\zeta'(s)}{\zeta(s)} = -\frac{1}{2}\log\pi + \frac{1}{2}\psi(s/2)$$
is holomorphic and bounded across the critical strip ($|R(0.7 + 14.135i)| \approx 0.893$). Thus any pole in $\xi'/\xi$ at an off-line zero is identically matched by a pole in $\zeta'/\zeta$, creating zero residual barrier to constrain zero locations.

## Evidence
1. Exact evaluation of $F(z)$ on $\mathbb{C}^-$ at $s = 0.75 + 10.0i$ ($z = 100.1875 - 5.0i$, $\operatorname{Im}(z) = -5.0$):
   - Analytic formula: $F(z) = 0.02953185 - 0.00058684 i$
   - 99-zero resolvent sum: $F_{99}(z) = 0.02640150 - 0.00058676 i$
2. Off-critical zero perturbation:
   - For hypothetical zero $\rho_0 = 0.6 + 14.134725i$, $\bar{\lambda}_0 = 200.0305 + 2.8269i \in \mathbb{C}^+$.
   - At probe point $z_{\mathrm{probe}} = \bar{\lambda}_0 - 0.001i \in \mathbb{C}^+$:
     - Background field from critical zeros: $+0.0199 + 0.3539 i$
     - Off-critical pole contribution: $-1000.0 i$
     - Total imaginary part: $\operatorname{Im}(F(z_{\mathrm{probe}})) = -999.646 < 0$.
   - Synthetic off-line zero probe in Aggregator and Falser r2_L04_N00: for $\rho_0 = 0.65 + 14.135i$ ($\lambda_0 \approx 200.018 - 4.240i \in \mathbb{C}^-$), evaluating at $z = \lambda_0 + i\varepsilon$ confirms that the pole term $\operatorname{Im}(1/(\lambda_0 - z)) = +1/\varepsilon \to +\infty$ evaluates to $+10, +100, +1000, +10000$ for $\varepsilon \in \{0.1, 0.01, 0.001, 0.0001\}$, violently destroying Herglotz phase rigidity in $\mathbb{C}^-$.
3. Numerical falsification of Herglotz property for $-\zeta'(s)/\zeta(s)$ (mpmath, 25 dps):
   - At $s = 1.5 + 0.5i$: $\operatorname{Im}(-\zeta'/\zeta) = -0.928515 < 0$.
   - At $s = 0.6 + 14.0i$: $\operatorname{Im}(-\zeta'/\zeta) = -4.699338 < 0$.
4. Hadamard summand evaluation for off-line zero $\beta_0 = 0.70, \gamma_0 = 14.135$ (falser L02_N01):
   - At $\sigma = 0.51$: summand is $-5.26 < 0$
   - At $\sigma = 0.60$: summand is $-10.0 < 0$
   - At $\sigma = 0.699$: summand is $-1000.0 < 0$
   - At $\sigma = 0.701$: summand is $+1000.0 > 0$.
5. Regular term boundedness:
   - $R(0.7 + 14.1347i) = 0.405 + 0.796i$, $|R| \approx 0.893$, confirming identical pole cancellation.

## Implications
1. Herglotz positivity of $F(z)$ on $\mathbb{C}^+$ is strictly equivalent to the Riemann Hypothesis; proving Herglotz positivity directly requires knowing that $\zeta'/\zeta$ has no poles in $\sigma > 1/2$, which is circularly equivalent to RH.
2. Hadamard product logarithmic phase envelopes cannot prove RH because off-line zeros produce negative summands on $(1/2, \beta_0)$, and poles of $\xi'/\xi$ match poles of $\zeta'/\zeta$ identically without creating an excess barrier.
3. Proving RH via Herglotz/Pick mapping of $-\zeta'(s)/\zeta(s)$ is blocked because $-\zeta'/\zeta$ fails Herglotz sign definiteness across the upper half-plane.

## Caveats
The quadratic mapping $z(s) = s(1-s)$ is a 2-to-1 conformal branched covering ramified at $s = 1/2$ ($z = 1/4$).
