# Central Window Pole Isolation for Critical Contour Shifts

Type: theorem
Confidence: high
Source: Aggregator Nodes L03_N00, L03_N01, L03_N02, L03_N03, L03_N04 (Level 3)
Relevant to: Bounding bilinear distinct-prime fluctuations $N_*(x)$ under RH and isolating the real pole of the shifted multiplier $\zeta(s+1/2)$ at $t=0$.

## Statement
Let $s = \sigma + it$ with $\sigma = 1/2 + \varepsilon_x$ and $\varepsilon_x = 1/\log x$ for real $x > e^4$.
Let $\mathcal{M}_{N_*}(s) = \frac{\zeta(s+1/2) G(s)^2}{s(s+1)}$ be the Mellin transform of the square-root aggregated bilinear fluctuation $N_*(x)$, where $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$.
Then on the central window $|t| \le 1$ around the real pole of $\zeta(s+1/2)$ at $s = 1/2$:
$$\int_{-1}^1 \left| \frac{\zeta(1+\varepsilon_x+it) G(1/2+\varepsilon_x+it)^2}{(1/2+\varepsilon_x+it)(3/2+\varepsilon_x+it)} \right| dt \ll \log\log x.$$
Consequently, multiplying by $|x^{s+1}| = e x^{3/2}$, the contribution of the central window to the truncated Perron inversion of $N_*(x)$ satisfies:
$$\frac{1}{2\pi i} \int_{1/2+\varepsilon_x-i}^{1/2+\varepsilon_x+i} \mathcal{M}_{N_*}(s) x^{s+1} ds = O(x^{3/2} \log\log x) = o(x^{3/2} \log x).$$
In particular, the simple pole of $\zeta(s+1/2)$ at $t=0$ does not generate a $\log^2 x$ fluctuation, leaving the macroscopic negative drift $-\frac{1}{6} x^{3/2} \log^2 x$ strictly dominant under the Riemann Hypothesis.

## Proof
1. **Regularity of $G(s)$ at $s = 1/2$**:
   Since $\zeta(1/2) \approx -1.4603544 \ne 0$, $\zeta(s)$ has no zeros on $|t| \le 1$ for $\Re s \in [1/2, 1]$. Furthermore, the pole of $-\zeta'/\zeta(s)$ at $s=1$ is removable in $G(s) = -\zeta'/\zeta(s) - s/(s-1)$, with $G(1) = -1 - \gamma_0$. Hence $G(s)$ is holomorphic on the compact rectangle $\mathcal{K} = \{s : \Re s \in [1/2, 3/4], |t| \le 1\}$, so:
   $$\sup_{|t| \le 1} |G(1/2+\varepsilon_x+it)|^2 \le M_0 < \infty.$$

2. **Geometric Denominator Lower Bound**:
   For $|t| \le 1$ and $\varepsilon_x \in (0, 1/4]$,
   $$|(1/2+\varepsilon_x+it)(3/2+\varepsilon_x+it)| \ge (1/2)(3/2) = \frac{3}{4}.$$

3. **Zeta Simple Pole Majorant**:
   At $w = 1 + \varepsilon_x + it$, the Laurent expansion of $\zeta(w)$ at $w=1$ gives:
   $$\zeta(1+\varepsilon_x+it) = \frac{1}{\varepsilon_x+it} + O(1) \implies |\zeta(1+\varepsilon_x+it)| \le \frac{1}{\sqrt{\varepsilon_x^2+t^2}} + C_0.$$

4. **Integration Across the Central Window**:
   Integrating across $|t| \le 1$:
   $$\int_{-1}^1 \frac{dt}{\sqrt{\varepsilon_x^2+t^2}} = 2\operatorname{arsinh}(1/\varepsilon_x) = 2\log\left(\frac{1}{\varepsilon_x} + \sqrt{1 + \frac{1}{\varepsilon_x^2}}\right) = 2\log(2/\varepsilon_x) + O(\varepsilon_x^2).$$
   Substituting $\varepsilon_x = 1/\log x$:
   $$\int_{-1}^1 \frac{dt}{\sqrt{\varepsilon_x^2+t^2}} = 2\log(2\log x) + O(1) = O(\log\log x).$$

5. **Inverse Mellin Scale**:
   Multiplying by $|x^{s+1}| = x^{3/2+\varepsilon_x} = x^{3/2} e^{\varepsilon_x \log x} = e x^{3/2}$, the central window contribution to $N_*(x)$ is $O(x^{3/2}\log\log x)$.
   Since $\lim_{x \to \infty} \frac{\log\log x}{\log x} = 0$, this contribution is strictly $o(x^{3/2}\log x)$.

## Hypotheses / Conditions
- $\zeta(1/2) \ne 0$ (verified: $\zeta(1/2) \approx -1.4603544$).
- Shifted contour ordinate $\varepsilon_x = 1/\log x$ with $x > e^4$.
- Standard Laurent expansion of $\zeta(s)$ at $s=1$.

## How It Applies
This theorem resolves the critical technical objection raised in Level 1 and Level 2 reviews (`category_perron_contour_divergence.md`, entry 10), which observed that shifting the Perron contour to $\Re s = 1/2 + 1/\log x$ encounters the pole of $\zeta(s+1/2)$ at $t=0$ where $\zeta(1+1/\log x) \sim \log x$, invalidating naive claims of uniform logarithmic bounds $|\zeta(1+\varepsilon+it)| \ll \log(|t|+2)$ without local pole isolation.
By establishing that the $t=0$ pole integrates to $\log\log x$ rather than $\log x$, this result confirms that central-window growth cannot spoil the $O(x^{3/2}\log x)$ fluctuation bound or compete with the $-\frac{1}{6} x^{3/2}\log^2 x$ drift.

## Caveats
This theorem controls only the central window $|t| \le 1$. Bounding the oscillatory tails $|t| \ge 1$ requires Hadamard local zero product bounds, Selberg zero-avoiding horizontal segments, and vertical zero density estimates under RH.
