# Platt & Trudgian (2021) — Verification of the Riemann Hypothesis to $3 \times 10^{12}$

Type: reference
Confidence: high
Source: Candidates 04, 06 (Level 0)
Relevant to: Sensitivity horizon of finite numerical testing for off-critical zeros

## Bibliographic Info
- Authors: David J. Platt and Timothy S. Trudgian
- Title: The Riemann hypothesis has been verified to $3 \cdot 10^{12}$
- Year: 2021
- ArXiv/DOI: Bulletin of the London Mathematical Society, 53(3), 790–801. arXiv:2004.09765
- Theorem/Lemma Number: Theorem 1
- Verified via web search: yes

## Key Result
Theorem 1: All non-trivial zeros $\rho = \beta + i\gamma$ of the Riemann zeta function $\zeta(s)$ with $0 < \gamma \le 3 \cdot 10^{12}$ satisfy $\beta = 1/2$. In particular, the first $12,363,153,437,138$ non-trivial zeros lie strictly on the critical line.

## Hypotheses / Conditions
Rigorous interval arithmetic verification using Arb and the Turing / Gourdon-Dethloff-van de Lune verification method.

## How It Applies
This result provides the exact sensitivity horizon for finite numerical checks of $W(x)$. Any hypothetical off-critical zero $\rho = \beta + i\gamma$ ($\beta > 1/2$) must have imaginary part $|\gamma| > 3 \cdot 10^{12}$. In the arithmetic sum $W(x)$ evaluated for $x \le 3000$, such a mode has oscillation frequency $\gamma / (2\pi) > 4.7 \times 10^{11}$ oscillations per unit of $\log x$ and amplitude suppressed by $|\rho(\rho+1)| > 9 \times 10^{24}$. Consequently, finite numerical computations on $x \le 3000$ have literally zero sensitivity to off-critical zeros, invalidating empirical negativity as evidence for eventual nonpositivity.

## Caveats
Verified rigorously by certified interval arithmetic. Does not rule out zeros off the critical line above height $3 \cdot 10^{12}$.
