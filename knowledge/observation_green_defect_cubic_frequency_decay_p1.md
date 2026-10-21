# Cubic Frequency Dissipation of Conformal Half-Plane Green's Zero Defect

Type: observation
Confidence: high
Source: Candidate 27 (Level 0, Exploration Round 3)
Relevant to: Half-plane Green's function potentials, Poisson-Jensen identities, Carleman dispersion

## Statement
In any buffered lower half-plane domain $\Omega_\delta = \{z \in \mathbb{C} \mid \operatorname{Im}(z) < -\delta\}$ with $\delta > 0$ under the conformal quadratic uniformization $z(s) = s(1-s)$, the Dirichlet Green's function with fixed evaluation pole $z_0 = x_0 + i y_0 \in \Omega_\delta$ is:
$$G_{\Omega_\delta}(z, z_0) = \frac{1}{2\pi} \log \left| \frac{z - \bar{z}_0 - 2i\delta}{z - z_0} \right|$$
For a hypothetical off-line zero $\rho_0 = \beta_0 + i\gamma_0$ with $\beta_0 > 1/2$ and $\gamma_0 \gg 1$, its conformal image $\lambda_0 = u_0 - i v_0$ has coordinates:
$$u_0 = \beta_0(1-\beta_0) + \gamma_0^2 \approx \gamma_0^2, \qquad v_0 = \gamma_0(2\beta_0 - 1) > 0$$
Because the horizontal coordinate $u_0$ scales quadratically as $\gamma_0^2$ while the vertical distance $v_0$ scales only linearly as $\gamma_0$, the Dirichlet Green's potential at any fixed pole $z_0$ satisfies the asymptotic expansion as $\gamma_0 \to \infty$:
$$G_{\Omega_\delta}(\lambda_0, z_0) = \frac{(2\beta_0 - 1)(-y_0 - \delta)}{\pi \gamma_0^3} + O\left(\frac{1}{\gamma_0^4}\right)$$
Consequently, the discrete Green's energy defect collapses cubically to zero as $O(\gamma_0^{-3})$.

## Evidence
1. Exact symbolic Taylor expansion of $\log|\frac{\lambda_0 - \bar{z}_0 - 2i\delta}{\lambda_0 - z_0}|$ with $\lambda_0 = \gamma_0^2 - i\gamma_0(2\beta_0-1)$ as $\gamma_0 \to \infty$:
   $$\left|\frac{\lambda_0 - \bar{z}_0 - 2i\delta}{\lambda_0 - z_0}\right|^2 = 1 + \frac{4(v_0 - \delta)(-y_0 - \delta)}{(u_0 - x_0)^2 + (v_0 + y_0 + 2\delta)^2} \approx 1 + \frac{4\gamma_0(2\beta_0-1)(-y_0-\delta)}{\gamma_0^4} = 1 + \frac{4(2\beta_0-1)(-y_0-\delta)}{\gamma_0^3}$$
   Taking $\frac{1}{4\pi}\log(1 + \dots)$ yields the leading coefficient $\frac{(2\beta_0-1)(-y_0-\delta)}{\pi\gamma_0^3}$.
2. Arbitrary-precision evaluation in mpmath (30 dps) at $z_0 = -10 - 2i, \delta = 1.0, \beta_0 = 0.75$:
   - $\gamma_0 = 14.135$: $G = 4.38 \times 10^{-5}$
   - $\gamma_0 = 50$: $G = 1.21 \times 10^{-6}$
   - $\gamma_0 = 100$: $G = 1.56 \times 10^{-7}$
   - $\gamma_0 = 500$: $G = 1.27 \times 10^{-9}$
   - $\gamma_0 = 1000$: $G = 1.59 \times 10^{-10}$

## Implications
Strategies proposing to exclude off-line zeros by detecting an interior Green's potential defect in Poisson-Jensen or Carleman integral balances fail completely for high-frequency zeros. The defect vanishes as $O(\gamma_0^{-3})$, rendering it infinitesimally small ($1.59 \times 10^{-10}$ at $\gamma_0 = 1000$) and irrevocably swamped by $O(\log \gamma_0)$ Selberg argument fluctuations, numerical truncation tails, and boundary oscillation leakage.

## Caveats
This cubic dissipation specifically applies when evaluating Green's functions at a fixed pole $z_0$ in the lower half-plane. A moving pole $z_0(\gamma_0)$ tracking the ordinate would require $x_0 \sim \gamma_0^2$, but this moves the pole into the high-frequency oscillation region where boundary evaluation error grows as $O(\log \gamma_0)$.
