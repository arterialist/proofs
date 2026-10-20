# Completed Zeta Displacement Numerator Sign Reversal at Critical Strip Boundary

Type: observation
Confidence: high
Source: Candidate 3 (Level 0), explore_falser_L00_N03
Relevant to: Proof strategies utilizing Module 317 completed zeta displacement rigidity or transversal disparity inequalities.

## Statement
In the completed zeta displacement identity (Module 317) for $\Lambda_0(s) = \xi_0(s)$:
$$(2d)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) = \frac{2d(1/4 - d^2)}{|s(s-1)|^2}, \quad s = \frac{1}{2} + d + it,$$
the numerator polynomial $P(d) = 2d(1/4 - d^2)$ satisfies:
1. $P(d) > 0$ strictly for $0 < d < 1/2$ (the critical strip interior $1/2 < \operatorname{Re}(s) < 1$).
2. $P(1/2) = 0$ at $d = 1/2$ ($\operatorname{Re}(s) = 1$).
3. $P(d) < 0$ strictly for $d > 1/2$ ($\operatorname{Re}(s) > 1$).
4. $P(0) = 0$ at $d = 0$ ($\operatorname{Re}(s) = 1/2$, the critical line).

Consequently, the transversal displacement inequality:
$$t \operatorname{Im}(\Lambda_0(s)) < (2d) \operatorname{Re}(\Lambda_0(s))$$
holds on zero loci strictly within the interior of the critical strip $1/2 < \operatorname{Re}(s) < 1$, and fails (vanishes or reverses sign) for $\operatorname{Re}(s) \ge 1$.

## Evidence
Symbolic calculation in sympy:
$(2d)(t^2 - \sigma(\sigma-1)) - t(2\sigma-1)t = 2d(1/4 - d^2)$ identically with $t^2$ terms cancelling.
Exact numerical evaluations:
- $d = 0.25$ ($\sigma = 0.75$): $P(0.25) = +0.09375 > 0$.
- $d = 0.5$ ($\sigma = 1.0$): $P(0.5) = 0.0$.
- $d = 0.6$ ($\sigma = 1.1$): $P(0.6) = -0.132 < 0$.
- $d = 1.0$ ($\sigma = 1.5$): $P(1.0) = -1.5 < 0$.

## Implications
Any strategy asserting that all points in $\mathrm{RightOfflineSupport}$ satisfy the displacement inequality $t \operatorname{Im}(\Lambda_0(s)) < (2d) \operatorname{Re}(\Lambda_0(s))$ must incorporate an explicit upper bound $\operatorname{Re}(s) < 1$. Because $\mathrm{RightOfflineSupport}$ definitionally only imposes $\operatorname{Re}(s) > 1/2$, unconditioned applications of displacement rigidity to the entire right off-line support are mathematically invalid on $\operatorname{Re}(s) \ge 1$.

## Caveats
Mathlib proves $\zeta(s) \ne 0$ for $\operatorname{Re}(s) \ge 1$ via `riemannZeta_ne_zero_of_one_le_re`, so in fact no zeros exist in the regime $\operatorname{Re}(s) \ge 1$ where the sign flips. However, this zero-freeness must be explicitly supplied as an auxiliary input to restrict the support to $\operatorname{Re}(s) < 1$.
