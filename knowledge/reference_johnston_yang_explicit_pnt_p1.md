# Johnston & Yang (2023) Explicit Prime Number Theorem Bounds

Type: reference
Confidence: high
Source: Strategy Nodes 11, 15 falser reports (Level 0)
Relevant to: Evaluating whether explicit zero-free region error bounds can control arithmetic oscillations in $W(x)$.

## Bibliographic Info
- Authors: Daniel R. Johnston, Andrew Yang
- Title: Explicit bounds on $\psi(x)-x$ and related prime counting functions
- Year: 2023
- ArXiv/DOI: arXiv:2204.05545 [math.NT] / Math. Comp. 92 (2023), 2821-2850
- Theorem/Lemma Number: Theorem 1.1 & Table 1
- Verified via web search: yes

## Key Result
For all $x \ge x_0$, the prime error function satisfies unconditional explicit bounds of the form:
$$|\psi(x) - x| \le C x \left(\frac{\log x}{R}\right)^{1/4} \exp\left(-\sqrt{\frac{\log x}{R}}\right)$$
with explicit constants $R \approx 5.566$ (or simplified Korobov-Vinogradov forms). Over intermediate ranges (e.g. $x \le 10^{10}$), bounds give $|\psi(x) - x| \le \epsilon x$ with $\epsilon \sim 10^{-4}$ to $10^{-6}$.

## Hypotheses / Conditions
- $x \ge 2$, unconditional (uses classical zero-free regions and numerical zero verification up to height $H = 3 \times 10^{12}$).

## How It Applies
Used in nodes 11, 12, and 15 to test whether the arithmetic error term in $W(x)$ can be bounded by unconditional analytic number theory.
When applied to $W(x)$, the prime convolution error bound gives at best:
$$|E(x)| \le C x^2 \exp(-c\sqrt{\log x})$$
Dividing by the deterministic negative drift $(1/6) x^{3/2} \log^2 x$ yields:
$$\frac{|E(x)|}{|W_{\mathrm{drift}}(x)|} \ge \frac{6C x^{1/2} \exp(-c\sqrt{\log x})}{\log^2 x}$$
Because $x^{1/2}$ grows exponentially faster than $\exp(c\sqrt{\log x})$, this ratio diverges to $+\infty$ as $x \to \infty$. Specifically, at $x = 10^{10}$, the unconditional error bound is $> 3.5$ times the negative drift, and at $\log x = 100$, it exceeds the drift by $> 10^{14}$.
Consequently, explicit unconditional PNT bounds are mathematically incapable of proving eventual nonpositivity $W(x) \le 0$.

## Caveats
Unconditional bounds reflect the potential existence of off-critical zeros near the 1-line. They cannot prove $W(x) \le 0$ precisely because $W(x) \le 0$ is equivalent to the Riemann Hypothesis.
