# Bidirectional Equivalence of Critical Sign Criterion

Type: theorem
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07 (Level 0), Aggregator Nodes L01_N01, L02_N00, L03_N00..N04 (Levels 1-3), Master Aggregator L04_N00 (Level 4)
Relevant to: Characterizing the exact relationship between RH and the sign of W(x)

## Statement
The Riemann Hypothesis is strictly equivalent to the eventual nonpositivity (and eventual strict negativity) of the critical arithmetic sum $W(x)$:
$$\mathrm{RH} \iff \exists A \ge 1, \forall x > A, W(x) \le 0 \iff \exists A \ge 1, \forall x > A, W(x) < 0.$$
Moreover, under RH, $W(x)$ satisfies the asymptotic law:
$$W(x) = -\frac{1}{6} x^{3/2} \log^2 x + O(x^{3/2} \log x).$$
Conversely, if RH is false and there exists an off-critical zero $\rho_0 = \beta_0 + i\gamma_0$ with $\beta_0 > 1/2$, then for every $\eta \in (0, \beta_0 - 1/2)$:
$$\limsup_{x \to \infty} \frac{W(x)}{x^{3/2 + \eta}} = +\infty, \qquad \liminf_{x \to \infty} \frac{W(x)}{x^{3/2 + \eta}} = -\infty.$$

## Proof
1. Forward Direction $[\exists A, \forall x > A, W(x) \le 0 \implies \mathrm{RH}]$:
   Formally proved in Lean 4 without sorries (`BuildingBlocks.ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos`) using Landau's singularity transfer theorem and double-pole preservation under shifted multiplier $\zeta(s+1/2)$.
2. Reverse Direction $[\mathrm{RH} \implies W(x) \sim -\frac{1}{6}x^{3/2}\log^2 x < 0]$:
   Under RH, all zeros lie on $\Re \rho = 1/2$. Perron inversion of $N_*(x) = \sum_{d \le x} \sqrt{d} N(x/d)$ with contour shifted to $\Re s = 1/2 + 1/\log x$ is evaluated by partitioning the vertical line:
   (a) Central window $|t| \le 1$: isolating the simple pole of $\zeta(s+1/2)$ at $t=0$ yields $O(x^{3/2} \log\log x) = o(x^{3/2}\log x)$ (see `theorem_central_window_pole_isolation_p1.md`).
   (b) Oscillatory tails $|t| \ge 1$: Selberg zero-avoiding horizontal segments (`reference_titchmarsh_zeta_zero_spacing_p1.md`) and local Cauchy-Schwarz Hadamard zero-grouping against Montgomery-Vaughan zero density yield $O(x^{3/2}\log x)$.
   Combining with the unconditional same-prime asymptotic $T_*(x) = \frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x)$ gives $W(x) = N_*(x) - T_*(x) = -\frac{1}{6}x^{3/2}\log^2 x + O(x^{3/2}\log x) < 0$ for all sufficiently large $x$.
3. Off-Critical Excursion Obstruction $[\neg \mathrm{RH} \implies \text{two-sided unbounded oscillations}]$:
   If an off-critical zero $\rho_0 = \beta_0 + i\gamma_0$ ($\beta_0 > 1/2$) exists, the double pole of $\mathcal{M}_W(s)$ at $\rho_0$ has non-vanishing residue. By the Landau oscillation theorem applied to $C x^\alpha \pm W(x)$ with $\alpha = 3/2 + \eta < 1 + \beta_0$, no one-sided bound can hold, forcing $\limsup W(x)/x^{3/2+\eta} = +\infty$ and $\liminf W(x)/x^{3/2+\eta} = -\infty$.

## Hypotheses / Conditions
- Definition of $W(x) = \sum_{d \le x} \sqrt{d} V(x/d)$ from the repository building blocks.

## How It Applies
This theorem demonstrates that the Critical Sign Criterion is an exact, unslack characterization of the Riemann Hypothesis. It explains both why $W(x)$ is negative at large scales (governed by the same-prime drift) and why proving $W(x) \le 0$ unconditionally is of the exact same mathematical depth as proving RH itself.

## Caveats
While the forward direction is completely formalized in Lean 4 without sorries, the reverse contour shift is established in written analytic prose and not yet formalized in Mathlib 4. In Level 4 synthesis, the bidirectional equivalence was certified to be an impassable circular barrier for affirmative proof: because any hypothetical off-line zero forces power blowup $\Omega_\pm(x^{\beta+1}\log x) \gg x^{3/2}\log^2 x$, establishing $W(x) \le 0$ unconditionally requires excluding all off-line zeros in advance. Sieve methods hit the Selberg parity barrier with wrong-sided positive quadratic defects $+2.612\varepsilon x^2$, leaving the unconditional sign criterion as an undecomposable fatal blocker (ready_for_decomposition: false).

