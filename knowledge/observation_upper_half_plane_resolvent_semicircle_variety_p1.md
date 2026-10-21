# Upper Half-Plane Resolvent Semicircle Variety

Type: observation
Confidence: high
Source: Aggregators L02_N01, L02_N02; Falsers L02_N01, L02_N02 (Iteration 1, Round 2, Level 2)
Relevant to: Resolvent positivity, Krein space / Pontryagin space operator models, and reproducing kernel Hilbert space approaches to the Riemann Hypothesis.

## Statement
Let $s = 1/2 + \delta \pm it$ with $\delta > 0$ and $t > 0$ be a hypothetical off-critical zero pair of $\xi(s)$, corresponding to quadratic conformal images $z = \lambda_\delta \mp i (2t\delta) \notin \mathbb{R}$, where $\lambda_\delta = 1/4 - \delta^2 + t^2$. Consider the imaginary part of the paired resolvent contribution on the upper half-plane $w = u + iv \in \mathbb{C}^+$ ($v > 0$):
$$R_{\text{pair}}(w) := \frac{1}{z - w} + \frac{1}{\bar{z} - w}.$$
The imaginary part $\operatorname{Im}(R_{\text{pair}}(w))$ has the exact algebraic representation:
$$\operatorname{Im}(R_{\text{pair}}(w)) = \frac{2v \left[ (u - \lambda_\delta)^2 + v^2 - (2t\delta)^2 \right]}{|(w - \lambda_\delta)^2 + (2t\delta)^2|^2}.$$
Consequently:
1. The sign of $\operatorname{Im}(R_{\text{pair}}(w))$ is determined entirely by the geometry of the circle centered at $(\lambda_\delta, 0)$ of radius $R = 2t\delta$.
2. On the upper semicircle $\mathcal{C}_s = \{w \in \mathbb{C}^+ : |w - \lambda_\delta| = 2t\delta\}$, $\operatorname{Im}(R_{\text{pair}}(w)) \equiv 0$.
3. Inside the semicircular disc $\mathcal{D}_s = \{w \in \mathbb{C}^+ : |w - \lambda_\delta| < 2t\delta\}$, $\operatorname{Im}(R_{\text{pair}}(w)) < 0$.
4. Outside the semicircular disc $|w - \lambda_\delta| > 2t\delta$, $\operatorname{Im}(R_{\text{pair}}(w)) > 0$.

## Evidence
Direct algebraic expansion:
$$\frac{1}{z - w} + \frac{1}{\bar{z} - w} = \frac{(z + \bar{z}) - 2w}{(w - z)(w - \bar{z})} = \frac{2(\lambda_\delta - w)}{(w - \lambda_\delta)^2 + (2t\delta)^2}.$$
Computing the imaginary part with $w = u + iv$:
$$\operatorname{Im}\left(\frac{2(\lambda_\delta - u - iv)}{((u - \lambda_\delta + iv)^2 + (2t\delta)^2)}\right) = \frac{2v \left[ (u - \lambda_\delta)^2 + v^2 - (2t\delta)^2 \right]}{|(w - \lambda_\delta)^2 + (2t\delta)^2|^2}.$$
This identity was independently derived and verified by Aggregators L02_N01 and L02_N02, and confirmed symbolically and numerically in Python by Falsers L02_N01 and L02_N02.

## Implications
- If off-line zeros exist, the Herglotz property ($\operatorname{Im}(F(w)) > 0$ for $w \in \mathbb{C}^+$) fails inside the semicircle $\mathcal{D}_s$, but holds outside it.
- In Krein space / Pontryagin space models with indefinite metric, the presence of negative norm states inside $\mathcal{D}_s$ is completely consistent with the ambient axioms: a Pontryagin space $\Pi_\kappa$ with $\kappa$ negative squares natively accommodates non-real eigenvalues without generating a logical contradiction.
- Claims that an off-line zero creates a contradiction merely because $\operatorname{Im}(R_{\text{pair}}(w)) < 0$ locally fail unless the ambient space is independently proven to be strictly positive-definite (which itself requires RH).

## Caveats
- The semicircle radius $2t\delta$ scales with the imaginary part $t$. For zeros with large $t$, the region of negativity is wide in the $u$-direction ($[-2t\delta, +2t\delta]$), but vanishes as $\delta \to 0$.
