# Li's Criterion for the Riemann Hypothesis

Type: reference
Confidence: high
Source: Candidate explorer_r2_L00_N10 (Iteration 1, Round 2, Level 0); explore_merger_r2_L01_N07 (Level 1)
Relevant to: Conformal mapping, disk foliation $w = 1 - 1/s$, Keiper-Li coefficients, and polynomial positivity criteria for RH.

## Bibliographic Info
- Authors: Xian-Jin Li
- Title: The positivity of a sequence of numbers and the Riemann hypothesis
- Year: 1997
- ArXiv/DOI: Journal of Number Theory, Vol. 65, No. 2, pp. 325–333.
- Theorem/Lemma Number: Theorem 1
- Verified via web search: yes

## Key Result
Let $\lambda_n$ be the sequence of real numbers defined by:
$$\lambda_n = \sum_\rho \left[ 1 - \left(1 - \frac{1}{\rho}\right)^n \right]$$
where the sum runs over all non-trivial zeros $\rho$ of the Riemann zeta function, paired as $\lim_{T \to \infty} \sum_{|\operatorname{Im}\rho| \le T}$. Equivalently:
$$\lambda_n = \frac{1}{(n-1)!} \left. \frac{d^n}{ds^n} \left[ s^{n-1} \log \xi(s) \right] \right|_{s=1}$$
The Riemann Hypothesis is true if and only if $\lambda_n > 0$ for all integers $n = 1, 2, 3, \dots$.

## Hypotheses / Conditions
- The coefficients $\lambda_n$ are evaluated at the base point $s=1$ (or mapped via conformal transformation $w = 1 - 1/s$ from the right half-plane $\operatorname{Re}(s) > 1/2$ onto the open unit disk $|w| < 1$).
- Zeros $\rho$ must be paired symmetrically by height.

## How It Applies
The criterion converts the critical line condition $\operatorname{Re}(\rho) = 1/2$ into the condition that all zeros of $\xi(s)$ lie on the circle $|1 - 1/s| = 1$, which corresponds to $|w| = 1$. The coefficients $\lambda_n$ are positive if and only if no zeros lie inside the unit disk in the $w$-variable.
Bombieri and Lagarias (1999) generalized this to any system of points in $\mathbb{C}$.

For critical line zeros $\rho = 1/2 + i\gamma$, $|1 - 1/\rho| = 1$, so $1 - 1/\rho = e^{i\theta_\gamma}$. Under conjugate pairing:
$$\operatorname{Re}\left[ \left(1 - \left(1 - \frac{1}{\rho}\right)^n\right) + \left(1 - \left(1 - \frac{1}{\bar{\rho}}\right)^n\right) \right] = 2 - 2\cos(n\theta_\gamma) = 4\sin^2(n\theta_\gamma / 2) \ge 0.$$
Hence every critical line zero contributes a strictly non-negative amount to $\lambda_n$. Positivity fails if and only if an off-line zero $\rho_0$ with $|1 - 1/\rho_0| > 1$ generates an exponentially growing negative oscillation $-(1 - 1/\rho_0)^n$ that eventually overwhelms the sum.

## Caveats
1. Proving $\lambda_n > 0$ unconditionally carries 100% of the analytical depth of RH.
2. The arithmetic representation of $\lambda_n = \sum_{j=1}^n \binom{n}{j} b_j$ involves alternating binomial sums with catastrophic numerical cancellation (coefficients exceed $10^{26.6}$ at $n=100$, and $10^{146}$ at $n=500$). Termwise arithmetic positivity bounds are mathematically impossible without non-trivial global phase cancellation.
3. Low-index verification $n \le 1000$ only tests the immediate vicinity of $s=1$. To detect an off-critical zero at the Platt-Trudgian verified height $\gamma_0 \approx 3 \times 10^{12}$, one requires $n \ge 2\gamma_0^2 \approx 1.8 \times 10^{25}$, meaning finite numerical testing is blind by over 22 orders of magnitude.
4. Representations asserting that $\lambda_n = \int_0^\infty (1 - e^{-nt}) d\mu(t)$ for a positive measure $d\mu \ge 0$ are mathematically refuted: Bernstein's theorem on completely monotonic functions would require the second forward difference $\Delta^2 \lambda_n = \lambda_{n+2} - 2\lambda_{n+1} + \lambda_n \le 0$ (concavity), whereas the true Keiper-Li sequence is strictly convex at the base: $\Delta^2 \lambda_1 = \lambda_3 - 2\lambda_2 + \lambda_1 \approx +0.04604 > 0$.
5. Explicit formulas expanding $\lambda_n = \sum_{j=1}^n \binom{n}{j} b_j$ require the exact Keiper normalization $b_j = \frac{(-1)^{j-1}}{(j-1)!} \left. \frac{d^j}{ds^j} \log \xi(s) \right|_{s=1}$; misindexing the shift $s^{n-1}$ leads to catastrophic formula invalidation.
