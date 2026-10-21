# Polarization Decomposition Sign Competition

Type: observation
Confidence: high
Source: Falsers L02_N04, L02_N05, L02_N06; Aggregators L02_N04, L02_N06 (Level 2); Aggregator and Falser r2_L04_N00 (Level 4 Root)
Relevant to: De Branges space companion contractivity, Herglotz/spectral representation of $\Xi_*(z)$, and logarithmic derivative positivity arguments for $\operatorname{Re}(\xi'(s)/\xi(s))$.

## Statement
In the coordinate decomposition of the logarithmic derivative
$$\operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right) = 2\left(\sigma - \frac{1}{2}\right) \operatorname{Re}(F(z(s))) - 2t \operatorname{Im}(F(z(s))),$$
where $z(s) = s(1-s)$ and $F(z) = -\Xi_*'(z)/\Xi_*(z)$, the real part $\operatorname{Re}(F(z))$ is strictly negative in regions of the critical strip near critical zeros (where $\sigma > 1/2$). Consequently, the term $2(\sigma - 1/2)\operatorname{Re}(F(z))$ is negative and actively opposes the positivity of the transverse term $-2t\operatorname{Im}(F(z))$, creating severe cancellation rather than cooperative reinforcement.

## Evidence
Explicit numerical evaluation near the first critical zero $\gamma_1 \approx 14.13472514$ (re-verified to 35 dps in Aggregator and Falser r2_L04_N00):
- At $\sigma = 0.51, t = 14.2$: $\operatorname{Re}(F(z)) = -0.506438 < 0$, making $2(\sigma - 1/2)\operatorname{Re}(F(z)) = -0.010129 < 0$.
- At $\sigma = 0.51, t = 14.5$: $\operatorname{Re}(F(z)) = -0.073469 < 0$, making $2(\sigma - 1/2)\operatorname{Re}(F(z)) = -0.001469 < 0$.
In both cases, $\operatorname{Re}(F(z))$ is strictly negative, refuting the assumption made in several candidate strategies that both terms $2(\sigma - 1/2)\operatorname{Re}(F)$ and $-2t\operatorname{Im}(F)$ are individually positive and reinforce each other.

## Implications
- Proof strategies attempting to establish $\operatorname{Re}(\xi'(s)/\xi(s)) > 0$ for $\sigma > 1/2$ by bounding $2(\sigma - 1/2)\operatorname{Re}(F(z))$ and $-2t\operatorname{Im}(F(z))$ separately from below by 0 are fundamentally flawed.
- Any valid positivity proof must establish that the transverse drive $-2t\operatorname{Im}(F(z))$ strictly dominates the negative drag $2(\sigma - 1/2)\operatorname{Re}(F(z))$, or must operate on an integrated/global level where cancellation cannot occur.

## Caveats
- While the terms compete locally, the net sum $\operatorname{Re}(\xi'(s)/\xi(s))$ remains positive at all numerically tested points in $\sigma > 1/2$, consistent with the Riemann Hypothesis; however, separate component-wise positivity is false.
