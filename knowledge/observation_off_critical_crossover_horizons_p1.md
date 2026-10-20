# Off-Critical Zero Excursion Crossover Horizons and Haselgrove Blindness

Type: observation
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07, Falsers 00, 01, 02, 03, 04, 05, 06, 07 (Level 1), Aggregator Nodes L02_N01, L02_N03, L02_N06, Falsers L02_N01, L02_N03 (Level 2), Master Falser L04_N00 (Level 4)
Relevant to: Understanding finite verification limits and the failure of numerical testing to detect off-critical zeros.

## Statement
In the critical arithmetic observable $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$, any hypothetical off-critical zero $\rho = \beta + i\gamma$ ($\beta > 1/2$) of $\zeta(s)$ induces an oscillatory excursion of peak amplitude:
$$\Delta W_{\rho}(x) = \frac{2 |\zeta(\beta + 1/2 + i\gamma)|}{|\rho(\rho+1)|} x^{\beta+1} \log x.$$
The crossover scale $x_c$ where this excursion overcomes the deterministic negative drift $T_*(x) \sim \frac{1}{6} x^{3/2} \log^2 x$ (i.e. where $\frac{12 |\zeta(\beta+1/2+i\gamma)|}{|\rho(\rho+1)|} \frac{x^{\beta-1/2}}{\log x} = 1$) satisfies:
1. For low-height hypothetical zeros ($\gamma \approx 14.1347$):
   - For $\beta = 0.70$: $|C| \approx 2.105 \times 10^{-3}$, crossover occurs at $\log x \approx 36.36 \implies x_c \approx 10^{15.8}$.
   - For $\beta = 0.60$: $|C| \approx 1.874 \times 10^{-3}$, crossover occurs at $\log x \approx 82.02 \implies x_c \approx 10^{35.6}$.
   - For $\beta = 0.55$: $|C| \approx 1.751 \times 10^{-3}$, crossover occurs at $\log x \approx 181.25 \implies x_c \approx 10^{78.7}$.
2. For zeros above the Platt-Trudgian (2021) verified critical line height $T_0 = 3 \times 10^{12}$:
   - Any off-critical zero must have $|\gamma| > 3 \times 10^{12}$. The denominator $|\rho(\rho+1)|^{-1} < 10^{-24}$ severely suppresses the oscillation amplitude.
   - For $\beta = 0.60, \gamma = 3 \times 10^{12}$: crossover requires $\log_{10} x_c \approx 263.53 \implies x_c > 10^{263.5}$.
   - For $\beta = 0.55, \gamma = 3 \times 10^{12}$: crossover requires $\log_{10} x_c \approx 533.07 \implies x_c > 10^{533.0}$.
3. On all computationally accessible ranges ($x \le 20000$):
   - For Platt-Trudgian zeros, the excursion perturbation is $< 7.33 \times 10^{-25}$ of the deterministic drift at $x = 20000$, rendering finite computation mathematically blind.
   - Near the crossover point ($x \approx 184.31$), stability is structurally fragile: an off-critical zero at $\beta=0.55, \gamma \approx 14.1347$ adds $+59.72$ at $x=185$, flipping $W(185) = -22.58$ to positive $+37.14$, even though it is masked to $< 0.8\%$ of drift at $x \ge 1000$.
   - The positive subleading Laurent coefficient $A_2 = -\frac{1}{3}\gamma_0 + \frac{8}{9} \approx +0.6965$ at $s = 1/2$ cancels $80.05\%$ of the negative drift at $x=185$, $78.87\%$ at $x=200$, $53.41\%$ at $x=2500$, and $45.37\%$ at $x=10000$, explaining why asymptotic negativity emerges so slowly.

## Evidence
- Computed via 35-digit, 45-digit, and 50-digit arbitrary precision mpmath across Level 1, Level 2, and Level 4 aggregator and falser audits (specifically Falser L04_N00 probe).
- Direct root-finding of the Lambert W branch -1 equation $\frac{x^{\beta-1/2}}{\log x} = \frac{|\rho(\rho+1)|}{12 |\zeta(\beta+1/2+i\gamma)|}$ matched numerical integration of the inverse Mellin transform to within $10^{-10}$ relative error.

## Implications
1. Numerical verification of $W(x) < 0$ on finite windows such as $[185, 3000]$ or $[185, 20000]$ provides strictly zero diagnostic power or statistical evidence for eventual asymptotic nonpositivity.
2. The empirical negativity of $W(x)$ on $[185, 20000]$ is entirely governed by verified critical-line zeros and the macroscopic drift $T_*(x)$, perfectly replicating the classical Polya and Mertens phenomena (Haselgrove blindness).
3. Hybrid verification schemes attempting to combine numerical certificates on $[185, X_0]$ with analytic tail bounds cannot succeed without an unconditional zero-free region reaching $\Re s > 1/2$.

## Caveats
Applies to isolated zeros or finite zero clusters. In hypothetical infinite zero constellations, destructive interference could delay crossover further, but constructive interference (by Dirichlet's approximation theorem) guarantees that excursions attain their full peak amplitude along unbounded sequences of $x$.

