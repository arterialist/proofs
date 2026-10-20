# Completed Zeta Displacement Numerator Sign Reversal at Critical Strip Boundary

Type: observation
Confidence: high
Source: Candidate 3 (Level 0), explore_falser_L00_N03, Candidate L01_N01, explore_falser_L01_N01
Relevant to: Proof strategies utilizing Module 317 completed zeta displacement rigidity or transversal disparity inequalities.

## Statement
In the completed zeta displacement identity (Module 317) for $\Lambda_0(s) = \xi_0(s)$:
$$(2d)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s)) = \frac{2d(1/4 - d^2)}{|s(s-1)|^2}, \quad s = \frac{1}{2} + d + it,$$
the numerator polynomial $P(d) = 2d(1/4 - d^2)$ satisfies:
1. $P(d) > 0$ strictly for $0 < d < 1/2$ (the critical strip interior $1/2 < \operatorname{Re}(s) < 1$).
2. $P(1/2) = 0$ at $d = 1/2$ ($\operatorname{Re}(s) = 1$).
3. $P(d) < 0$ strictly for $d > 1/2$ ($\operatorname{Re}(s) > 1$).
4. $P(0) = 0$ at $d = 0$ ($\operatorname{Re}(s) = 1/2$, the critical line).

Furthermore, on the critical boundary $d \to 0^+$, dividing both sides by $2d$ yields the boundary transverse derivative identity:
$$J_{\mathrm{true}}(t) := \lim_{d \to 0^+} \frac{(2d)\operatorname{Re}(\Lambda_0(s)) - t \operatorname{Im}(\Lambda_0(s))}{2d} = \frac{1}{2} \int_0^\infty [\Phi(u) - u \Phi'(u)] \cos(ut) \, du,$$
$$\operatorname{Pole}(t) := \lim_{d \to 0^+} \frac{2d(1/4 - d^2)}{2d |s(s-1)|^2} = \frac{1/4}{(t^2 + 1/4)^2}.$$
By Cauchy-Riemann equations and the completed zeta relation $\Lambda_0(1/2+it) = (1 - 2\Xi(t))/(t^2+1/4)$, the boundary transverse difference satisfies the exact analytical identity:
$$J_{\mathrm{true}}(t) - \operatorname{Pole}(t) = -\frac{t \Xi'(t)}{2(t^2 + 1/4)}.$$
Consequently, by Rolle's theorem applied to $\Xi(t)$ between consecutive critical zeros (such as $t_1 \approx 14.1347$ and $t_2 \approx 21.0220$), there exists a local extremum $t_* \approx 15.585944$ where $\Xi'(t_*) = 0$, causing $J_{\mathrm{true}}(t_*) - \operatorname{Pole}(t_*) = 0$ to vanish identically.

## Evidence
1. Symbolic calculation in sympy:
   $(2d)(t^2 - \sigma(\sigma-1)) - t(2\sigma-1)t = 2d(1/4 - d^2)$ identically with $t^2$ terms cancelling.
2. Exact numerical evaluations of $P(d)$:
   - $d = 0.25$ ($\sigma = 0.75$): $P(0.25) = +0.09375 > 0$.
   - $d = 0.5$ ($\sigma = 1.0$): $P(0.5) = 0.0$.
   - $d = 0.6$ ($\sigma = 1.1$): $P(0.6) = -0.132 < 0$.
   - $d = 1.0$ ($\sigma = 1.5$): $P(1.0) = -1.5 < 0$.
3. Exact boundary vanishing at Rolle extremum:
   - Evaluated via mpmath (30 dps): at $t_* \approx 15.5859441589$, $\Xi'(t_*) = 0$ and $J_{\mathrm{true}}(t_*) = \operatorname{Pole}(t_*) = 4.2277968 \times 10^{-6}$ identically.

## Implications
1. Any strategy asserting that all points in $\mathrm{RightOfflineSupport}$ satisfy the displacement inequality $t \operatorname{Im}(\Lambda_0(s)) < (2d) \operatorname{Re}(\Lambda_0(s))$ must incorporate an explicit upper bound $\operatorname{Re}(s) < 1$. Because $\mathrm{RightOfflineSupport}$ definitionally only imposes $\operatorname{Re}(s) > 1/2$, unconditioned applications of displacement rigidity to the entire right off-line support are mathematically invalid on $\operatorname{Re}(s) \ge 1$.
2. Boundary transversality of displacement rigidity fails as an obstruction to off-line zeros in the transition band $(7.465, 16]$: because $J_{\mathrm{true}}(t) - \operatorname{Pole}(t)$ changes sign and vanishes at Rolle extrema $\Xi'(t_*) = 0$, displacement rigidity provides zero boundary barrier near $t_* \approx 15.586$.

## Caveats
Mathlib proves $\zeta(s) \ne 0$ for $\operatorname{Re}(s) \ge 1$ via `riemannZeta_ne_zero_of_one_le_re`, so no zeros exist in the regime $\operatorname{Re}(s) \ge 1$ where the sign flips. However, this zero-freeness must be explicitly supplied as an auxiliary input to restrict the support to $\operatorname{Re}(s) < 1$. Furthermore, the vanishing of $J_{\mathrm{true}}(t) - \operatorname{Pole}(t)$ at $\Xi'(t_*)=0$ occurs on the boundary $d=0$ and does not by itself construct an off-line zero ($d > 0$), but refutes boundary-limit transversality arguments.
