# Subconvexity Boundary Restriction and Critical Strip Zero-Exclusion Category Error

Type: observation
Confidence: high
Source: explore_merger_L03_N02, explore_falser_L03_N02 (Level 3)
Relevant to: Subconvexity bounds, analytic zero-free regions, transition-band zero exclusion strategies $[7.465, T_0]$, and zero-density estimates.

## Statement
Sub-Weyl subconvexity estimates:
$$|\zeta(1/2 + it)| \ll_\varepsilon |t|^{1/6 + \varepsilon}$$
(and more generally any critical-line subconvexity estimate $|\zeta(1/2 + it)| \ll |t|^\theta$ with $\theta < 1/4$) govern exclusively the supremum growth rate of the Riemann zeta function along the critical line $\operatorname{Re}(s) = 1/2$. They do not establish zero-freeness in the open critical strip interior $1/2 < \operatorname{Re}(s) < 1$:
1. **Classical Zero-Free Boundary**: Classical zero-free regions established by Hadamard, de la Vallée Poussin, and Vinogradov-Korobov derive from non-negative trigonometric polynomial identities (e.g. $3 + 4\cos\theta + \cos 2\theta \ge 0$) coupled with upper bounds on $\zeta(s)$ and $|\zeta'(s)|$. These regions take the asymptotic shape:
   $$\sigma \ge 1 - \frac{c}{(\log |t|)^{2/3} (\log\log |t|)^{1/3}} \quad (|t| \ge 3),$$
   which progressively narrows toward $\sigma = 1$ as $|t| \to \infty$. They leave the entire interior half-strip $1/2 < \operatorname{Re}(s) < 1 - c/(\log |t|)^{2/3}$ completely unconstrained.
2. **Zero-Density vs Pointwise Zero-Freeness**: Turán power-sum inequalities and zero-density estimates (e.g. $N(\sigma, T) \ll T^{A(\sigma)(1-\sigma)} \log^C T$) provide quantitative upper bounds on the number of possible zeros in $\operatorname{Re}(s) \ge \sigma$. However, because $A(\sigma)(1-\sigma) > 0$ for all $\sigma < 1$, they strictly cannot prove $N(\sigma, T) = 0$ for any $\sigma \in (1/2, 1)$.
3. **Category Error**: Claiming that subconvexity bounds on $\operatorname{Re}(s) = 1/2$ can establish zero-freeness on an intermediate transition band $[1/2, 1] \times [7.465, T_0]$ is a mathematical category error: controlling growth on the boundary line does not preclude interior zeros off the boundary.

## Evidence
- Mathematical consensus in analytic number theory literature (Iwaniec-Kowalski 2004, Montgomery-Vaughan 2007, Conrey-Iwaniec 2000): subconvexity bounds on the critical line have never yielded an off-line zero-free region penetrating the critical strip $1/2 < \sigma < 1$.
- Falser report audit on explore_merger_L03_N02 confirming that subconvexity bounds cannot exclude off-line zeros in the transition band $[7.465, 50]$.

## Implications
Strategies attempting to bridge low-frequency certificates (such as $[0, 7.465]$) to high-frequency asymptotic operators by proving zero-freeness on transition bands $[7.465, T_0]$ cannot rely on subconvexity estimates or Turán power sums. Any affirmative closure across $1/2 < \operatorname{Re}(s) < 1$ requires genuine non-vanishing mechanisms, not critical-line supremum estimates.

## Caveats
Subconvexity bounds are mathematically profound and essential for estimating moments, subconvex bounds on $L$-functions, and Lindelöf-type behavior, but their logical output is an upper bound on function values on a 1D line, not a lower bound away from zero in a 2D strip.
