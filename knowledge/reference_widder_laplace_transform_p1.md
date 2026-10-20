# Widder (1941) — The Laplace Transform (Landau's Singularity Theorem)

Type: reference
Confidence: high
Source: Candidates 00, 01, 05, 06, 07 (Level 0)
Relevant to: Landau positive-measure singularity transfer in Frontier 1

## Bibliographic Info
- Authors: David Vernon Widder
- Title: The Laplace Transform
- Year: 1941
- ArXiv/DOI: Princeton Mathematical Series, Vol. 6, Princeton University Press
- Theorem/Lemma Number: Chapter II, Theorem 5b (p. 58)
- Verified via web search: yes

## Key Result
Theorem 5b: If $\alpha(t)$ is a real non-decreasing function on $[0, \infty)$ such that the Laplace-Stieltjes integral
$$f(s) = \int_0^\infty e^{-st} d\alpha(t)$$
converges for $\Re s > \sigma_c$, where $\sigma_c < \infty$, then the real point $s = \sigma_c$ is a singularity of $f(s)$. That is, $f(s)$ cannot be continued analytically across the real boundary point of its half-plane of convergence.

## Hypotheses / Conditions
- The measure $d\alpha(t)$ must be non-negative (i.e. $\alpha(t)$ non-decreasing).
- The abscissa of convergence $\sigma_c$ must be finite.

## How It Applies
This is the foundational analytic theorem used in `BuildingBlocks.LandauSingularity.lean` and `ActualCriticalConvergence.lean`. By applying Widder's Theorem 5b to the measure $d\mu_A(x) = \mathbf{1}_{x>A}(-W(x))x^{-2}dx$ (which is non-negative when $W(x) \le 0$ for $x > A$), the abscissa of convergence $\sigma_c$ must be a singularity on the real line. Since the Mellin transform has no real singularities in $(1/2, \infty)$, $\sigma_c \le 1/2$, forcing holomorphy throughout $\Re s > 1/2$.

## Caveats
Applies exclusively to non-negative measures. Any sign change in the tail invalidates the theorem.
