# Mollified Möbius Neutral Constraint Failure

Type: observation
Confidence: high
Source: Falser L02_N07; Aggregator L02_N07 (Iteration 1, Round 2, Level 2)
Relevant to: Nyman-Beurling dilation approximation, Báez-Duarte step-function approximation in $L^2(0, 1)$, and arithmetic Dirichlet polynomial mollifiers.

## Statement
In the Nyman-Beurling / Báez-Duarte framework, approximating the indicator function $\chi_{(0, 1)}$ by linear combinations of dilated fractional parts $\sum_{k=1}^N c_k \rho(1/k x)$ requires that the coefficients $c_k$ satisfy the neutral linear constraint
$$\sum_{k=1}^N \frac{c_k}{k} = 0$$
in order to cancel the simple pole of the Riemann zeta function $\zeta(s)$ at $s = 1$ in the Mellin transform $M[f](s) = -\frac{\zeta(s)}{s} \sum_{k=1}^N \frac{c_k}{k^s}$.
Commonly proposed smooth regularized arithmetic weights, such as Selberg-type smoothed Möbius weights $c_k = -\mu(k) \left(1 - \frac{\log k}{\log N}\right)^2$, fail this neutral constraint completely. Consequently, the Mellin transform possesses an uncancelled simple pole at $s = 1$, preventing $M[f](s)$ from lying in the Hardy space $H^2$ of the half-plane $\operatorname{Re}(s) > 1/2$ and causing the $L^2(0, 1)$ approximation error to diverge rather than vanish.

## Evidence
Explicit numerical evaluation of the sum $\sum_{k=1}^N \frac{c_k}{k}$ with $c_k = -\mu(k)\left(1 - \frac{\log k}{\log N}\right)^2$ carried out by Falser L02_N07:
- For $N = 100$: $\sum_{k=1}^{100} \frac{c_k}{k} \approx +0.3798 \neq 0$.
- For $N = 500$: $\sum_{k=1}^{500} \frac{c_k}{k} \approx +0.2919 \neq 0$.
The uncancelled residue at $s = 1$ is $\approx 0.3$, causing an infinite $H^2$ norm along $\operatorname{Re}(s) = 1/2$.

## Implications
- Standard arithmetic mollifiers from sieve theory or zero-density theorems cannot be directly plugged into the Nyman-Beurling or Báez-Duarte variational problems without adding an explicit Lagrange multiplier or projection step to enforce $\sum_{k=1}^N c_k/k = 0$.
- Unconstrained choices of coefficients that omit the exact zero-sum constraint fail to yield valid approximations in the Hilbert space $L^2(0, 1)$.

## Caveats
- Exact solutions to the Gram system $G c = b$ in $N$ dimensions automatically enforce the constraint as $N \to \infty$, but closed-form arithmetic approximations must explicitly project onto the codimension-1 hyperplane $\sum c_k/k = 0$.
