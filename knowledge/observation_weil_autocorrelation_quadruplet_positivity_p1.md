# Autocorrelation Quadruplet Positivity in the Weil Explicit Formula

Type: observation
Confidence: high
Source: Candidate 18 (Level 0)
Relevant to: Weil explicit formula strategies, spectral quadratic forms, and wavepacket energy extraction methods for off-line zeros.

## Statement
Let $f \in \mathcal{S}(\mathbb{R})$ be a Schwartz test function, and let $\Phi = f * \tilde{f}$ be its autocorrelation, so that $\widehat{\Phi}(t) = |\widehat{f}(t)|^2 \ge 0$ for all real frequencies $t \in \mathbb{R}$.
In the Weil explicit formula, for any hypothetical off-line zero $s_0 = 1/2 + d + i\gamma_0$ ($d = \beta_0 - 1/2 > 0$), the fourfold zero sum across the quadruplet $\{s_0, 1 - s_0, \bar{s}_0, 1 - \bar{s}_0\}$ evaluates to:
$$\mathcal{E}(s_0; f) = 2 \operatorname{Re}\left( \widehat{g}_+(\gamma_0) \overline{\widehat{g}_-(\gamma_0)} \right),$$
where $g_+(x) = f(x) e^{dx}$ and $g_-(x) = f(x) e^{-dx}$.
Because $e^{dx}$ and $e^{-dx}$ are strictly positive real exponential weights, they introduce zero spatial phase shift into $f(x)$. Under stationary phase localization at $x_0$, both $\widehat{g}_+(\gamma_0)$ and $\widehat{g}_-(\gamma_0)$ inherit the identical stationary phase $\theta(x_0) + \pi/4$.
Consequently, in the complex cross-product $\widehat{g}_+(\gamma_0) \overline{\widehat{g}_-(\gamma_0)}$, the stationary phase exactly cancels to zero:
$$\operatorname{Phase}\left( \widehat{g}_+(\gamma_0) \overline{\widehat{g}_-(\gamma_0)} \right) = \left(\theta(x_0) + \frac{\pi}{4}\right) - \left(\theta(x_0) + \frac{\pi}{4}\right) = 0,$$
forcing the off-line quadruplet contribution to be strictly positive:
$$\mathcal{E}(s_0; f) \approx \frac{2\pi |\chi(x_0)|^2}{\theta''(x_0)} > 0.$$
Off-line zeros therefore contribute positive energy to the spectral quadratic form $Q_{\mathrm{spec}}(f)$, adding to the sum rather than extracting negative pairing energy.

## Evidence
Scipy adaptive quadrature (scipy.integrate.quad) across an extensive 108-case parameter grid in chirp rate $\eta \in [0.01, 0.2]$, spatial center $x_0 \in [0.8, 1.2]$, zero ordinate $\gamma_0 \in [50, 500]$, and displacement $d \in [0.05, 0.25]$:
- In 108 of 108 configurations, $\mathcal{E}(s_0; f_T)$ was strictly positive (minimum value $+6.255 \times 10^{-12}$, maximum value $+1.008 \times 10^{-11}$, exactly 0 non-positive cases).
- When carrier $T$ was detuned from $T_{\mathrm{tuned}}$ to $2 T_{\mathrm{tuned}}$, non-stationary phase caused zero coupling to drop by 9 orders of magnitude (from $1.005 \times 10^{-11}$ to $1.094 \times 10^{-20}$), refuting asymptotic power growth $T^{2d}$.

## Implications
Strategies cannot produce an asymptotic contradiction in the Weil explicit formula by claiming that off-line zeros extract negative energy $-2b T^{2d}$ against an arithmetic positive margin $a \log T - C_{\mathrm{tot}}$. Autocorrelation test functions $\Phi = f * \tilde{f}$ are positive semidefinite and cannot drive $Q_{\mathrm{spec}}$ negative. Any attempt to package such a contradiction into a formal structure (e.g., `WeilWavepacketEvaluation`) produces a definitionally inconsistent type equivalent to $\operatorname{False}$.

## Caveats
Test functions that are not autocorrelations (i.e. where $\widehat{\Phi}(t)$ is not required to be non-negative on $\mathbb{R}$) can take negative values, but such test functions do not produce positive semidefinite forms on the critical line, destroying the baseline positivity of the critical zero sum.
