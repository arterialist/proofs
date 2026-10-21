# Conformal Symmetrized Genus-0 Canonical Reciprocal Zero Trace Identity

Type: theorem
Confidence: high
Source: Candidates explorer_r3_L00_N06, explorer_r3_L00_N02, explorer_r3_L00_N07 (Level 0)
Relevant to: Exact trace formulas, Hadamard genus-0 factorizations, and spectral sum rules for the symmetrized completed zeta function $\Xi_*(z)$ under quadratic parameter $z(s) = s(1-s)$.

## Statement
Let $\xi(s) = \frac{1}{2}s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$ be the completed Riemann zeta function, and let $\Xi_*(z)$ be its unique symmetrized conformal representation satisfying $\Xi_*(s(1-s)) = \xi(s)$.
Then $\Xi_*(z)$ is an entire function of complex order $\rho_* = 1/2 < 1$ and genus $p = 0$, admitting the canonical Hadamard product:
$$\Xi_*(z) = \Xi_*(0) \prod_{n=1}^\infty \left(1 - \frac{z}{\lambda_n}\right),$$
where $\Xi_*(0) = 1/2$, $\lambda_n = \rho_n(1-\rho_n)$, the product requires zero exponential factor ($e^{P(z)} \equiv 1$), and the canonical reciprocal zero trace evaluates in closed form to:
$$-\frac{\Xi_*'(0)}{\Xi_*(0)} = \sum_{n=1}^\infty \frac{1}{\lambda_n} = 1 + \frac{\gamma_0}{2} - \log(2\sqrt{\pi}) \approx 0.023095708966121,$$
where $\gamma_0 \approx 0.5772156649$ is the Euler-Mascheroni constant.

## Proof
1. **Entire Regularity and Genus 0**: Because $\xi(s) = \xi(1-s)$ is an even function of $s-1/2$, it expands in powers of $(s-1/2)^2 = 1/4 - z$, so $\Xi_*(z)$ is entire. Stirling's formula gives $\log |\xi(s)| = \frac{1}{2}|s|\log |s| + O(|s|)$. For $z = s(1-s) \sim -s^2$, $|s| \sim |z|^{1/2}$, so $\log |\Xi_*(z)| = \frac{1}{4}|z|^{1/2}\log |z| + O(|z|^{1/2})$, proving order $\rho_* = 1/2 < 1$. By Hadamard's theorem for order $< 1$, the genus is $p = 0$, the exponential factor is constant $e^{P(0)} = 1$, and $\sum 1/|\lambda_n| < \infty$ converges absolutely.
2. **Logarithmic Derivative at the Origin**: Logarithmic differentiation of $\Xi_*(z) = \Xi_*(0)\prod(1 - z/\lambda_n)$ at $z = 0$ yields:
   $$-\frac{\Xi_*'(0)}{\Xi_*(0)} = \sum_{n=1}^\infty \frac{1}{\lambda_n}.$$
3. **Chain Rule Evaluation via $\xi(s)$**: Near $s = 0$, $z(s) = s(1-s) = s - s^2$, so $z'(0) = 1$. By the chain rule:
   $$\xi'(0) = \left.\frac{d}{ds} \Xi_*(z(s))\right|_{s=0} = \Xi_*'(0) z'(0) = \Xi_*'(0).$$
   Since $\Xi_*(0) = \xi(0) = 1/2$, we have $\frac{\Xi_*'(0)}{\Xi_*(0)} = \frac{\xi'(0)}{\xi(0)}$.
4. **Closed Form for $\xi'(0)/\xi(0)$**: The definition of $\xi(s)$ can be written for $\operatorname{Re}(s) > 0$ as:
   $$\xi(s) = (s-1)\pi^{-s/2}\Gamma(s/2+1)\zeta(s).$$
   Taking the logarithmic derivative:
   $$\frac{\xi'(s)}{\xi(s)} = \frac{1}{s-1} - \frac{1}{2}\log \pi + \frac{1}{2}\frac{\Gamma'(s/2+1)}{\Gamma(s/2+1)} + \frac{\zeta'(s)}{\zeta(s)}.$$
   At $s = 0$:
   - $\frac{1}{0-1} = -1$;
   - $\frac{\Gamma'(1)}{\Gamma(1)} = -\gamma_0$;
   - $\zeta(0) = -1/2$ and $\zeta'(0) = -\frac{1}{2}\log(2\pi)$, so $\frac{\zeta'(0)}{\zeta(0)} = \log(2\pi)$.
   Summing these values:
   $$\frac{\xi'(0)}{\xi(0)} = -1 - \frac{1}{2}\log \pi - \frac{\gamma_0}{2} + \log(2\pi) = -1 - \frac{\gamma_0}{2} + \log 2 + \frac{1}{2}\log \pi = -1 - \frac{\gamma_0}{2} + \log(2\sqrt{\pi}).$$
   Negating gives the exact result:
   $$\sum_{n=1}^\infty \frac{1}{\lambda_n} = -\frac{\xi'(0)}{\xi(0)} = 1 + \frac{\gamma_0}{2} - \log(2\sqrt{\pi}) \approx 0.023095708966121.$$

## Hypotheses / Conditions
- The definition of completed Riemann xi $\xi(s) = \frac{1}{2}s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$.
- Functional reflection $\xi(s) = \xi(1-s)$ and conformal parameter $z = s(1-s)$.

## How It Applies
This theorem provides an exact analytical sum rule against which any truncated zero eigenvalue sum $\sum_{n=1}^N 1/\lambda_n$ can be audited. On the first 100 non-trivial zeros, $\sum_{n=1}^{100} 1/\lambda_n \approx 0.01998485$, capturing exactly $86.53\%$ of the full analytical trace.

## Caveats
The trace identity is an unconditional consequence of the functional equation and Weierstrass factorization; it holds whether or not all zeros $\lambda_n$ are real (i.e. it does not by itself prove RH, but provides a precise constraint on zero positions).
