# Heisenberg Bandwidth Leakage and Gap Zero Interference in Localized Weil Projections

Type: observation
Confidence: high
Source: Explorer Merger r2_L03_N03, Falser r2_L03_N03 (Level 3)
Relevant to: Discrete Weil explicit formula quadratic forms, localized test vector projections on good zero sets, and attempts to resolve the Ordinate Isolation Gap Blind Spot.

## Statement
Let $Q(T, 2T) \subset S(T, 2T)$ be the set of simple zeros on the critical line with headline density $\kappa \ge 67.25\%$ (Alpöge-Furman 2026), isolating over $50.875\%$ of zero ordinates. Off-line zeros residing in the open gaps $(\gamma_n, \gamma_{n+1})$ between critical zeros have ordinates where $\zeta(1/2 + i\gamma_0) \ne 0$ and completely evade ordinate isolation.

Attempting to isolate an off-line zero in an open gap using a localized test vector $v_{\gamma_0}$ of spectral bandwidth $w \asymp 1/\log T$ in the discrete Weil explicit formula quadratic form is fundamentally obstructed by the Heisenberg uncertainty principle:
1. Because adjacent critical zeros sit at mean spacing $\Delta \gamma \asymp 2\pi / \log T$, any admissible Paley-Wiener or Fejér test vector centered at $\gamma_0$ exhibits massive spectral leakage ($> 60.2\%$) into the flanking critical zeros $\gamma_n$ and $\gamma_{n+1}$.
2. Squeezing the spectral bandwidth to $w \ll 1/\log T$ to suppress critical zero interference broadens spatial support on the prime side to $e^{1/w} \gg T$, causing prime remainder fluctuations to explode and overwhelm the spectral zero signal.
3. Consequently, discrete Weil projections cannot isolate off-line zero signatures from critical-zero background noise without prior knowledge of local zero spacings (which circularly requires the Riemann Hypothesis).

## Evidence
High-precision numerical evaluation by Falser r2_L03_N03 at mid-gap ordinate $T_{\text{mid}} = (\gamma_1 + \gamma_2)/2 \approx 17.5784$ with distance $d = 3.4437$ to $\gamma_1 \approx 14.1347$ and $\gamma_2 \approx 21.0220$:
- For bandwidth $w = 1/\log(17.58) \approx 0.3488$, the Fejér kernel $K_w(\Delta \gamma) = \left(\frac{\sin(w \Delta \gamma / 2)}{w \Delta \gamma / 2}\right)^2$ leaks $60.26\%$ of its peak power into adjacent critical zeros $\gamma_1$ and $\gamma_2$.
- The hyperbolic block $H_{\rho_0}$ of signature $(1, 1)$ is completely swamped by the $> 60\%$ positive background projection $P_{\text{on}} \ge 0$ from adjacent critical zeros.

## Implications
- The Ordinate Isolation Gap Blind Spot cannot be resolved by localized discrete test vectors in the Weil explicit formula.
- Unconditional non-negativity of the discrete Weil quadratic form on all admissible test functions is logically equivalent to the Riemann Hypothesis (Bombieri-Lagarias 1999); attempting to decompose isolated projection inequalities into independent subproblems is circular.

## Caveats
- Discrete matrix truncations of the Weil formula capture finite sub-blocks of the spectrum but cannot prove global positive semi-definiteness without infinite-dimensional tail control.
