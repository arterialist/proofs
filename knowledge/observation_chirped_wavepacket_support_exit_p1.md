# Chirped Wavepacket Stationary Phase Support Exit and Weil Bilinear Form Exponent Halving

Type: observation
Confidence: high
Source: Candidate 28 (Level 0 falser report)
Relevant to: Weil explicit formula, chirped wavepacket constellations, and stationary phase coupling to non-trivial zeta zeros

## Statement
1. In a chirped wavepacket family $u_T(x) = a(x) \exp(i(\eta T x^2 - T x))$ supported on $(0, w)$ with admissibility condition $0 < \eta < 1/(8w)$ (ensuring $1 - 2\eta x > 0$), the stationary phase point for coupling to a fixed zero ordinate $\gamma_0$ is:
$$x_{\mathrm{stat}}(T) := \frac{T - \gamma_0}{2\eta T} = \frac{1 - \gamma_0/T}{2\eta}.$$
As $T \to \infty$ with $\gamma_0$ fixed, $x_{\mathrm{stat}}(T) \to \frac{1}{2\eta} > 4w > w$. Consequently, for all carriers:
$$T > T_{\mathrm{exit}} := \frac{\gamma_0}{1 - 2\eta w},$$
the stationary phase point lies strictly outside the compact support $[0, w]$. Across $[0, w]$, the phase derivative satisfies $|\Phi'(x)| \ge (1 - 2\eta w)T - \gamma_0 \to \infty$, causing the zero coupling $\widehat{u}_T(\gamma_0)$ to decay super-polynomially ($O_N(T^{-N})$ for all $N \ge 1$) by non-stationary phase, rather than sustaining an asymptotic power deficit $b T^{2d}$ along $\operatorname{atTop}$.

2. In the Weil explicit formula for quadratic forms $g = f * \widetilde{f}$, the spectral contribution of an off-line zero quadruplet $\{\beta_0 \pm i\gamma_0, 1 - \beta_0 \pm i\gamma_0\}$ (with displacement $d = \beta_0 - 1/2$) across a spatial constellation $f = \sum_{j=1}^M c_j \tau_{x_j} q_T$ of span $D$ is governed by the bilinear cross-term:
$$4 \operatorname{Re}\left( F(d + i\gamma_0) \overline{F(-d + i\gamma_0)} \right),$$
where $F(s) = \sum c_j e^{s x_j}$. By the Cauchy-Schwarz inequality, the maximum possible amplification is bounded by:
$$|F(d + i\gamma_0) F(-d + i\gamma_0)| \le \sqrt{\sum e^{2d x_j}} \sqrt{\sum e^{-2d x_j}} \le C e^{d D},$$
because $x_j \ge 0 \implies \sum e^{-2d x_j} = O(1)$. The amplification scales as $e^{d D}$, exactly halving the exponent relative to the claimed $e^{2d D} = T^{2\lambda d}$.

## Evidence
Adversarial falser code execution on Candidate 28 evaluated:
1. Wavepacket Fourier transform decay at $\gamma_0 = 14.134725$, $w = 0.5$, $\eta = 0.2$ ($T_{\mathrm{exit}} = 17.668$):
   - At $T = 17.7$: $|\widehat{u}_T(\gamma_0)| \approx 0.380$
   - At $T = 50.0$: $|\widehat{u}_T(\gamma_0)| \approx 0.021$
   - At $T = 100.0$: $|\widehat{u}_T(\gamma_0)| \approx 8.5 \times 10^{-4}$
   - At $T = 200.0$: $|\widehat{u}_T(\gamma_0)| \approx 3.2 \times 10^{-7}$
   - At $T = 500.0$: $|\widehat{u}_T(\gamma_0)| \approx 5.0 \times 10^{-14}$
2. Bilinear constellation matrix eigenvalue:
   - For constellation parameters $D = 20$, $d = 0.25$, the maximum eigenvalue of the rank-2 form $\frac{1}{2}(u v^T + v u^T)$ is $\lambda_{\max} \approx 316.0$, matching $C e^{d D} = e^5 \approx 148.4$ (ratio 2.13), whereas the claimed $e^{2d D} = e^{10} \approx 22026.5$ overestimates the coupling by a factor of 70 (ratio $\lambda_{\max}/e^{2d D} \approx 0.014 \to 0$).

## Implications
1. The hypothesis that chirped wavepackets produce an asymptotic power deficit $E_{\mathrm{pair}}(T) \ge 2b T^{2d}$ along $\operatorname{atTop}$ is definitively falsified for any fixed zero ordinate $\gamma_0$.
2. Expanding constellation span $D \to \infty$ at finite tuned carrier $T = T(\gamma_0)$ causes prime errors to grow as $e^{D/2}$, which exponentially overpowers the off-line zero coupling $e^{d D}$ (since $d = \beta_0 - 1/2 < 1/2$), precluding any asymptotic sign contradiction.

## Caveats
Applies to static wavepacket parameterizations where $\eta$ and $w$ are fixed as $T \to \infty$. Dynamic tuning of $w(T)$ or $\eta(T)$ would alter the admissibility and prime-power localization conditions.
