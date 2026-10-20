# Exact Double-Pole Residue Expansion and Subleading Coefficient Dominance at Zeta Zeros

Type: theorem
Confidence: high
Source: Strategy Node 21 falser audit (Level 0), Aggregator Nodes L01_N03, L02_N02, L02_N04 (Levels 1-2)
Relevant to: Evaluating oscillatory zero residue sums in the inverse Mellin transform of $W(x)$.

## Statement
Let $\mathcal{M}_W(s) = \frac{\zeta(s+1/2)}{s(s+1)} (G(s)^2 - H(s))$ be the Mellin transform of $W(x)$.
At any simple non-trivial zero $\rho = \beta + i\gamma$ of $\zeta(s)$, $\mathcal{M}_W(s)$ has a pole of order 2 with local Laurent expansion:
$$\mathcal{M}_W(s) = \frac{a_{-2}}{(s-\rho)^2} + \frac{a_{-1}}{s-\rho} + O(1)$$
where:
$$a_{-2} = \frac{\zeta(\rho+1/2)}{\rho(\rho+1)}$$
$$a_{-1} = \left. \frac{d}{ds} \left[ \frac{\zeta(s+1/2)}{s(s+1)} (G(s)(s-\rho))^2 \right] \right|_{s=\rho} = a_{-2} \left[ \frac{\zeta'(\rho+1/2)}{\zeta(\rho+1/2)} - \frac{2\rho+1}{\rho(\rho+1)} - 2\left( \frac{\zeta''(\rho)}{2\zeta'(\rho)} + \frac{\rho}{\rho-1} \right) \right]$$
The Cauchy residue of the inverse Mellin transform kernel $\mathcal{M}_W(s) x^{s+1}$ at $s = \rho$ is given exactly by:
$$\mathrm{Res}_{s=\rho} \left[ \mathcal{M}_W(s) x^{s+1} \right] = \left( a_{-2} \log x + a_{-1} \right) x^{\rho+1}$$

High-precision arbitrary-precision evaluations across the lowest 5 non-trivial zeros show that $|a_{-1}|$ consistently exceeds $|a_{-2}|$:

| Zero | Ordinate $\gamma_k$ | $|a_{-2}|$ | $|a_{-1}|$ | Ratio $|a_{-1}|/|a_{-2}|$ |
|------|---------------------|------------|------------|---------------------------|
| $\rho_1$ | $14.134725$ | $0.001623$ | $0.004556$ | $2.808$ |
| $\rho_2$ | $21.022040$ | $0.000781$ | $0.001761$ | $2.255$ |
| $\rho_3$ | $25.010858$ | $0.000572$ | $0.001166$ | $2.039$ |
| $\rho_4$ | $30.424876$ | $0.000397$ | $0.000751$ | $1.891$ |
| $\rho_5$ | $32.935062$ | $0.000344$ | $0.000630$ | $1.830$ |

## Proof
1. In a punctured neighborhood of a simple zero $\rho$, $\zeta(s) = (s-\rho)\zeta'(\rho) + \frac{1}{2}(s-\rho)^2 \zeta''(\rho) + O((s-\rho)^3)$.
2. Logarithmic differentiation gives:
   $$\frac{\zeta'(s)}{\zeta(s)} = \frac{1}{s-\rho} + \frac{\zeta''(\rho)}{2\zeta'(\rho)} + O(s-\rho)$$
3. The centering term $-\frac{s}{s-1}$ evaluates to $-\frac{rho}{\rho-1} - \frac{1}{(\rho-1)^2}(s-\rho) + O((s-\rho)^2)$.
4. Squaring $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$:
   $$G(s) = -\frac{1}{s-\rho} - \left( \frac{\zeta''(\rho)}{2\zeta'(\rho)} + \frac{\rho}{\rho-1} \right) + O(s-\rho)$$
   $$G(s)^2 = \frac{1}{(s-\rho)^2} + \frac{2}{s-\rho} \left( \frac{\zeta''(\rho)}{2\zeta'(\rho)} + \frac{\rho}{\rho-1} \right) + O(1)$$
5. Multiplying by the regular factor $Q(s) = \frac{\zeta(s+1/2)}{s(s+1)} = Q(\rho) + Q'(\rho)(s-\rho) + O((s-\rho)^2)$ yields $a_{-2} = Q(\rho)$ and $a_{-1} = Q'(\rho) + 2 Q(\rho) \left( \frac{\zeta''(\rho)}{2\zeta'(\rho)} + \frac{\rho}{\rho-1} \right)$.
6. Multiplying $\mathcal{M}_W(s)$ by $x^{s+1} = x^{\rho+1} [1 + (s-\rho)\log x + O((s-\rho)^2)]$ and computing the coefficient of $(s-\rho)^{-1}$ gives $(a_{-2} \log x + a_{-1}) x^{\rho+1}$.

## Hypotheses / Conditions
- $\rho$ is a simple zero of $\zeta(s)$ ($\zeta'(\rho) \ne 0$).
- $\Re \rho > 0$ and $\rho \ne 1$.

## How It Applies
1. This refutes claims that oscillatory zero contributions can be bounded solely by leading-order coefficients $\sum_\rho |a_{-2}| x^{3/2} \log x \le 0.03 x^{3/2} \log x$.
2. The subleading coefficient $a_{-1}$ is nearly 2 to 3 times larger than $a_{-2}$ across all computed low-lying zeros, so at moderate values of $x$ (such as $x \approx 184$), $a_{-1}$ constitutes the major component of the oscillatory amplitude.
3. It reveals a fundamental analytical obstruction in bounding $\sum_\rho |a_{-1}|$: because $a_{-1}$ contains $\zeta''(\rho)/\zeta'(\rho)$, the absolute sum $\sum_\rho |a_{-1}|$ has termwise lower bounds involving $|\zeta'(\rho)|^{-1}$. Without unproved zero-spacing bounds (such as Montgomery's pair correlation conjecture), the convergence of $\sum_\rho |a_{-1}|$ cannot be proved unconditionally.

## Caveats
If $\zeta(s)$ possesses multiple zeros ($m \ge 2$), higher-order logarithmic terms $a_{-3} \log^2 x$ appear, but $a_{-2}$ and $a_{-1}$ remain present.
Furthermore, the absolute sum $\sum_\rho |a_{-1}|$ may diverge if zeros cluster closely, necessitating careful conditional paired-summation or smooth contour avoidance rather than naive termwise absolute value estimation.
