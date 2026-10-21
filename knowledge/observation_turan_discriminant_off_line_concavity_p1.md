# Turán Discriminant Off-Line Zero Quadruplet Concavity Inversion

Type: observation
Confidence: high
Source: explorer_r2_L00_N02, explore_falser_r2_L00_N02
Relevant to: Transverse modulus convexity, Laguerre-Pólya entire function theory, and Wronskian phase rigidity on the critical line

## Statement
1. On the critical line $\alpha = 0$, the transverse curvature of the completed zeta modulus $|\xi(1/2 + \alpha + it)|^2$ satisfies the exact identity:
$$\left.\frac{\partial^2}{\partial \alpha^2} |\xi(1/2 + \alpha + it)|^2\right|_{\alpha=0} = 2 [(\Xi'(t))^2 - \Xi(t)\Xi''(t)] = 2 \Delta_{\text{Turán}}(t),$$
where $\Xi(t) = \xi(1/2 + it)$.
2. Under the Riemann Hypothesis, $\Delta_{\text{Turán}}(t) > 0$ strictly for all $t \in \mathbb{R}$, ensuring strict transverse convexity at $\alpha = 0$.
3. If an off-line zero quadruplet exists at $\rho = 1/2 \pm \delta \pm i\gamma$ with $\delta > 0$, the second derivative $\frac{d^2}{dt^2} \log \Xi(t)$ receives an uncompensated positive pole contribution $+2/\delta^2$ at $t = \gamma$. This multiplies $-\Xi(\gamma)^2$ to inject a massive negative defect into the Turán discriminant:
$$\Delta_{\text{Turán}}(\gamma) \sim - \frac{2\Xi(\gamma)^2}{\delta^2} < 0 \quad \text{as } \delta \to 0^+.$$
Consequently, off-line zeros invert the critical-line transverse curvature from strictly convex ($\Delta_{\text{Turán}} > 0$) to strictly concave ($\Delta_{\text{Turán}} < 0$).

## Evidence
- Exact symbolic derivation from the Laplacian identity $(\partial_\alpha^2 + \partial_t^2)|\xi|^2 = 4|\xi'|^2$ combined with Cauchy-Riemann equations: $\partial_\alpha^2 |\xi|^2|_{\alpha=0} = 4(\Xi')^2 - \partial_t^2 (\Xi^2) = 2[(\Xi')^2 - \Xi\Xi''] = 2\Delta_{\text{Turán}}(t)$.
- Symbolic differentiation in SymPy of $\log \prod_{j=1}^4 (it - z_j)$ for an off-line quadruplet confirmed leading pole defect $+2/\delta^2$.
- Numerical evaluation for a mock off-line zero at $\delta = 0.1, \gamma = 14.135$ plunged the Turán discriminant to $\Delta_{\text{Turán}}(14.135) = -12774.35 < 0$, inverting transverse curvature across an entire collar around $\gamma$.

## Implications
Any proof route attempting to prove transverse modulus monotonicity $\partial_\alpha |\xi|^2 > 0$ or critical-line convexity $\Delta_{\text{Turán}}(t) > 0$ unconditionally from Fourier kernel positivity (e.g. Riemann's theta transform $\Xi(t) = 2\int_0^\infty \Phi(u)\cos(ut)du$) cannot succeed without already knowing zero reality: $\Delta_{\text{Turán}}(t) > 0$ is mathematically false in any neighborhood of an off-line zero.

## Caveats
Turán positivity $\Delta_{\text{Turán}}(t) > 0$ does hold on compact intervals $[0, T]$ where all zeros are already certified to lie on the critical line by explicit numerical computation (such as Platt-Trudgian 2021 up to $3 \times 10^{12}$).
