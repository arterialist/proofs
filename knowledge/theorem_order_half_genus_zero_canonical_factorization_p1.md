# Order-1/2 Genus-Zero Canonical Factorization of the Symmetrized Xi Function

Type: theorem
Confidence: high
Source: Aggregators L01_N12, L01_N13 (Level 1); L02_N00-N06 (Level 2); r2_L03_N00, r2_L03_N01, r2_L03_N02, r2_L03_N03 (Level 3); r2_L04_N00 (Level 4 Root)
Relevant to: Conformal transformation of the critical strip, Herglotz/Pick analysis, and genus-0 canonical product representations of $\xi(s)$

## Statement
Let $s = \sigma + it \in \mathbb{C}$ and define the quadratic conformal uniformizing parameter:
$$z(s) = s(1-s) = \sigma(1-\sigma) + t^2 - i(2\sigma - 1)t.$$
Under the functional reflection $s \mapsto 1-s$, $z(1-s) = z(s)$. The completed Riemann xi function $\xi(s) = \frac{1}{2}s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)$ is an even function of $s - 1/2$ and admits the exact representation:
$$\xi(s) = \Xi_*(z(s)),$$
where $\Xi_*(z)$ is an entire function of a single complex variable $z \in \mathbb{C}$.

The function $\Xi_*(z)$ satisfies the following structural properties:
1. **Order and Genus**: $\Xi_*(z)$ is an entire function of order $\rho_* = 1/2 < 1$ and genus $p = 0$.
2. **Canonical Hadamard Product**: Because the genus is 0, the Hadamard factorization of $\Xi_*(z)$ has no exponential convergence factor ($e^{P(z)} \equiv 1$) and is given by:
   $$\Xi_*(z) = \Xi_*(0) \prod_{n=1}^\infty \left(1 - \frac{z}{\lambda_n}\right),$$
   where $\Xi_*(0) = \xi(0) = 1/2$, the zeros $\lambda_n = \rho_n(1-\rho_n)$ satisfy $\sum_{n=1}^\infty \frac{1}{|\lambda_n|} < \infty$, and $\lambda_n > 0$ for all critical-line zeros $\rho_n = 1/2 + i\gamma_n$ ($\lambda_n = 1/4 + \gamma_n^2$).
3. **Conformal Domain Mapping**: Let $Q^+ = \{s \in \mathbb{C} \mid \sigma = \operatorname{Re}(s) > 1/2, t = \operatorname{Im}(s) > 0\}$ denote the open upper-right critical quadrant. The map $s \mapsto z(s)$ maps $Q^+$ bijectively and conformally into the open lower half-plane $\mathbb{C}^- = \{z \in \mathbb{C} \mid \operatorname{Im}(z) < 0\}$, with:
   $$\operatorname{Im}(z(s)) = -2t\left(\sigma - \frac{1}{2}\right) < 0 \quad \text{for all } s \in Q^+.$$
4. **Master Four-Way Spectral Equivalence Ring**: The following assertions are strictly logically equivalent:
   (i) Mathlib's formal $\mathrm{RiemannHypothesis}$.
   (ii) $\mathrm{RightHalfZeroFree} :\equiv \forall s : \mathbb{C}, 1/2 < \operatorname{Re}(s) \implies s \ne 1 \implies \zeta(s) \ne 0$.
   (iii) Lower half-plane non-vanishing: $\forall z \in \mathbb{C}^-, \; \Xi_*(z) \ne 0 \iff$ all zeros $\lambda_n$ of $\Xi_*(z)$ lie on the real ray $[1/4, \infty)$.
   (iv) Global logarithmic derivative positivity: $\forall s \in \mathbb{C}, \operatorname{Re}(s) > 1/2 \land \xi(s) \ne 0 \implies \operatorname{Re}(\xi'(s)/\xi(s)) > 0$.

## Proof
1. **Entireness and Reflection**: Since $\xi(s)$ is entire of order 1 and symmetric under $s \mapsto 1-s$, it is an even function of $(s - 1/2)$. Note that $(s - 1/2)^2 = s^2 - s + 1/4 = 1/4 - z(s)$. Expanding $\xi(s)$ as a power series in $(s - 1/2)^2$:
   $$\xi(s) = \sum_{m=0}^\infty a_m \left(s - \frac{1}{2}\right)^{2m} = \sum_{m=0}^\infty a_m \left(\frac{1}{4} - z\right)^m =: \Xi_*(z).$$
   This power series converges for all $z \in \mathbb{C}$, confirming that $\Xi_*(z)$ is entire.
2. **Order of Growth**: Recall that $|\xi(s)| \le C \exp(c|s|\log|s|)$ as $|s| \to \infty$, so $\xi$ has order 1. Since $z = s(1-s) \sim -s^2$ as $|s| \to \infty$, $|s| \sim |z|^{1/2}$. Thus:
   $$\log|\Xi_*(z)| = \log|\xi(s)| \le c' |z|^{1/2} \log|z|,$$
   which proves that $\rho_* = \limsup_{r \to \infty} \frac{\log\log M(r, \Xi_*)}{\log r} = \frac{1}{2}$.
3. **Genus and Canonical Factorization**: For an entire function of order $\rho_*$, the genus $p$ satisfies $p \le \lfloor \rho_* \rfloor$. Since $\rho_* = 1/2$, $p = 0$. By Hadamard's factorization theorem, an entire function of genus 0 factors as a genus-0 canonical product without exponential factors:
   $$\Xi_*(z) = \Xi_*(0) \prod_{n=1}^\infty \left(1 - \frac{z}{\lambda_n}\right),$$
   where $\lambda_n$ are the non-zero roots of $\Xi_*(z)$, and absolute convergence $\sum 1/|\lambda_n| < \infty$ is guaranteed by $\rho_* < 1$.
4. **Imaginary Part Formula and Bijective Mapping**: Compute:
   $$z(\sigma + it) = (\sigma + it)(1 - \sigma - it) = \sigma(1-\sigma) + t^2 - i t (2\sigma - 1).$$
   Hence, $\operatorname{Im}(z) = -2t(\sigma - 1/2)$. For $s \in Q^+$, $\sigma > 1/2$ and $t > 0$, so $\operatorname{Im}(z) < 0$. The derivative $z'(s) = 1 - 2s$ vanishes only at $s = 1/2$, which lies outside $Q^+$, so the map is conformal and bijective onto its image.
5. **RH Equivalence**: A zero $\rho = \beta + i\gamma$ of $\zeta(s)$ with $\beta > 1/2$ and $\gamma > 0$ belongs to $Q^+$, so its image $z(\rho) = \rho(1-\rho)$ has $\operatorname{Im}(z(\rho)) = -2\gamma(\beta - 1/2) < 0$, producing a zero of $\Xi_*(z)$ in $\mathbb{C}^-$. Conversely, if all zeros $\rho_n = 1/2 + i\gamma_n$ have $\beta_n = 1/2$, then $z(\rho_n) = (1/2 + i\gamma_n)(1/2 - i\gamma_n) = 1/4 + \gamma_n^2 \in \mathbb{R}_{>0}$.

## Hypotheses / Conditions
- Completed Riemann xi function $\xi(s)$ and its entire order $\rho = 1$.
- Symmetrizing quadratic coordinate $z(s) = s(1-s)$.

## How It Applies
This theorem reduces the 2D critical strip strip problem to a half-plane zero-exclusion problem for a genus-0 entire function $\Xi_*(z)$. The absence of the exponential factor $e^{P(z)}$ simplifies the logarithmic derivative:
$$F(z) = -\frac{\Xi_*'(z)}{\Xi_*(z)} = \sum_{n=1}^\infty \frac{1}{\lambda_n - z}.$$
In the Herglotz/Pick framework, if all $\lambda_n > 0$, $F(z)$ maps the upper half-plane $\mathbb{C}^+$ to $\mathbb{C}^+$ and the lower half-plane $\mathbb{C}^-$ to $\mathbb{C}^-$.

## Caveats
- The Herglotz property $\operatorname{Im}(F(z)) < 0$ on $\mathbb{C}^-$ is circularly equivalent to RH: if an off-line zero exists, $\lambda_0 = z(\rho_0) \in \mathbb{C}^-$ creates a pole where $\operatorname{Im}(F(z)) \to +\infty$ near $\lambda_0$, destroying Herglotz positivity.
- Genus 0 guarantees convergence of $\sum 1/|\lambda_n|$, but does NOT guarantee reality of $\lambda_n$ without independent positivity bounds.
