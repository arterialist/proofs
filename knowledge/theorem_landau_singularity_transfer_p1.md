# Landau Singularity Transfer for Shifted Mellin Transform

Type: theorem
Confidence: high
Source: Candidates 00, 01, 02, 03, 04, 05, 06, 07 (Level 0)
Relevant to: Proving RH from eventual nonpositivity of W(x) in Frontier 1

## Statement
Let $d\mu_A(x) = \mathbf{1}_{x > A} (-W(x)) x^{-2} dx$ be a non-negative Borel measure on $[A, \infty)$ for some $A \ge 1$, where $W(x) = O(x^2 \log x)$. Then the Laplace-Mellin transform
$$\mathcal{L}_{\mu_A}(s) = \int_A^\infty (-W(x)) x^{-s-2} dx = -\int_1^\infty W(x) x^{-s-2} dx + \int_1^A W(x) x^{-s-2} dx = -\mathcal{M}_W(s) + E_A(s)$$
has a finite real abscissa of convergence $\sigma_c \le 1$. If $\sigma_c > 1/2$, then $s = \sigma_c$ must be a singularity of the analytic continuation of $\mathcal{L}_{\mu_A}(s)$.
Since $\mathcal{M}_W(s) = \frac{\zeta(s+1/2)}{s(s+1)}(G(s)^2 - H(s))$ has no real singularities in $(1/2, \infty)$ and $E_A(s)$ is entire, $\mathcal{L}_{\mu_A}(s)$ has no real singularity in $(1/2, \infty)$. Therefore, $\sigma_c \le 1/2$, which forces $\mathcal{L}_{\mu_A}(s)$ and $\mathcal{M}_W(s)$ to be holomorphic throughout the entire open half-plane $\Re s > 1/2$.

## Proof
1. Nonnegative Measure: The assumption $\exists A \ge 1, \forall x > A, W(x) \le 0$ ensures $-W(x) \ge 0$, so $d\mu_A$ is a nonnegative Radon measure.
2. Splitting and Entire Part: For $\Re s > 1$, $\int_1^\infty W(x) x^{-s-2} dx = \int_1^A W(x) x^{-s-2} dx + \int_A^\infty W(x) x^{-s-2} dx$. The integral $E_A(s) = \int_1^A W(x) x^{-s-2} dx$ is over a compact interval $[1, A]$ of a bounded, piecewise continuous function, so differentiation under the integral sign proves $E_A(s)$ is entire on $\mathbb{C}$.
3. Real Singularity via Landau: By Landau's classical theorem (Widder, 1941, Thm 5b; formalized in Lean 4 via Taylor expansions with nonnegative coefficients $\frac{(2\varepsilon)^k}{k!} \int v^k e^{-cv} d\nu(v) \ge 0$), the real point on the boundary of convergence $s = \sigma_c$ must be a singularity.
4. Singularity Audit on $(1/2, \infty)$:
   - At $s=1$: $G(s) = -\zeta'/\zeta(s) - s/(s-1)$. The simple pole $(s-1)^{-1}$ of $-\zeta'/\zeta$ cancels identically with $-s/(s-1) = -1 - 1/(s-1)$, yielding $G(1) = -\gamma - 1$.
   - On $(1/2, 1)$: $\zeta(s) < 0$ vanishes nowhere on $(0, 1)$, so $G(s)$ has no real poles.
   - $H(s) = \sum_p (\log p)^2 p^{-2s}/(1-p^{-s})^2$ converges absolutely for $\Re s > 1/2$.
   - $\zeta(s+1/2)$ has its pole at $s=1/2$, and is holomorphic and positive on $(1/2, \infty)$.
   - $s(s+1) > 0$ for $s > 1/2$.
5. Contradiction if $\sigma_c > 1/2$: If $\sigma_c \in (1/2, 1]$, then $\sigma_c$ is a singularity, contradicting the holomorphy of $-\mathcal{M}_W(s) + E_A(s)$ at all real points in $(1/2, \infty)$. Hence $\sigma_c \le 1/2$.
6. Holomorphic Extension: Holomorphy of the Laplace transform on $\Re s > \sigma_c$ implies holomorphy of $\mathcal{M}_W(s)$ on $\Re s > 1/2$.

## Hypotheses / Conditions
- $W(x) \le 0$ for all $x > A$ (eventual nonpositivity).
- $|W(x)| = O(x^2 \log x)$ (polynomial growth bound, standard from Chebyshev $\psi(x) = O(x)$).

## How It Applies
This is the core analytical engine of Frontier 1. In `formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`, the theorem `RiemannHypothesis_of_eventually_nonpos` uses this transfer to prove that any off-line zero would create an uncancelable double pole, which contradicts holomorphy in $\Re s > 1/2$.

## Caveats
The theorem requires strict pointwise eventual nonpositivity $W(x) \le 0$ for all $x > A$. It does NOT apply if $W(x)$ has even sparse positive spikes or excursions as $x \to \infty$.
