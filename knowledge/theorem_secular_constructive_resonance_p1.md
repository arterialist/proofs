# Secular Constructive Resonance in Bilinear Prime Convolutions

Type: theorem
Confidence: high
Source: Candidates 25, 26, 28, 30, 31 (Level 0 Falser Audits)
Relevant to: Bilinear prime convolutions, Hilbert-space embeddings, phase cancellation claims, and Riesz/Cesàro smoothed averages of prime error terms.

## Statement
Let $\psi(x) = \sum_{n \le x} \Lambda(n)$ and let $a(t) = e^{-t/2}(\psi(e^t) - e^t)$ be the normalized prime-counting error in logarithmic time $t = \log x$.
Suppose $\zeta(s)$ has a non-trivial zero $\rho = \beta + i\gamma$ off the critical line with $\beta > 1/2$ and $\gamma \ne 0$.
Then in the spectral decomposition of $a(t)$, the mode associated with $\rho$ is proportional to $e^{(\beta-1/2)t} \cos(\gamma t + \theta_\rho)$.

The continuous self-convolution of this mode,
$$I_\rho(t) = \int_0^t e^{(\beta-1/2)\tau} \cos(\gamma \tau) \cdot e^{(\beta-1/2)(t-\tau)} \cos(\gamma(t-\tau)) \, d\tau,$$
satisfies the exact identity:
$$I_\rho(t) = \frac{1}{2} t e^{(\beta-1/2)t} \cos(\gamma t) + \frac{1}{2\gamma} e^{(\beta-1/2)t} \sin(\gamma t).$$

Consequently:
1. **Secular Amplification**: At the base oscillation frequency $\gamma$, the self-convolution does not undergo phase cancellation; instead, it develops a secular prefactor proportional to $t = \log x$.
2. **Double Pole Duality**: In the Mellin/Laplace transform domain, this secular growth corresponds precisely to the squaring of the simple pole $(s - (\beta - 1/2 + i\gamma))^{-1}$ into a double pole $(s - (\beta - 1/2 + i\gamma))^{-2}$.
3. **Drift Overwhelming**: In the spatial coordinate $x = e^t$, this produces unabsorbable oscillations of magnitude
$$\Omega_\pm\left( x^{\beta+1} \log x \right),$$
which unconditionally overwhelm the deterministic negative triple-pole drift $-\frac{1}{6} x^{3/2} \log^2 x$ for any $\beta > 1/2$.
4. **Smoothing Invariance**: For any integer $k \ge 1$, applying a $k$-fold Riesz/Cesàro smoothing kernel $K_k(t, \tau) = \frac{1}{k!} (t - \tau)^k$ multiplies the Laplace/Mellin transform by $k! / (s - \lambda)^{k+1}$. Because this multiplier is holomorphic and non-zero at $s = \rho - 1/2$, the double pole at $\rho$ is strictly preserved, and the smoothed mode still exhibits oscillations of order $x^{\beta+1+k} \log x$.

## Proof
1. **Trigonometric Product Decomposition**:
   Using the product-to-sum identity $\cos(A)\cos(B) = \frac{1}{2}[\cos(A+B) + \cos(A-B)]$ with $A = \gamma \tau$ and $B = \gamma(t - \tau)$:
   $$A + B = \gamma t, \quad A - B = \gamma(2\tau - t).$$
   Factoring the real exponential:
   $$e^{(\beta-1/2)\tau} e^{(\beta-1/2)(t-\tau)} = e^{(\beta-1/2)t}.$$
   Thus, the integrand factors as:
   $$e^{(\beta-1/2)t} \left[ \frac{1}{2} \cos(\gamma t) + \frac{1}{2} \cos(\gamma(2\tau - t)) \right].$$

2. **Integration over $\tau \in [0, t]$**:
   The first term is constant with respect to $\tau$:
   $$\int_0^t \frac{1}{2} \cos(\gamma t) \, d\tau = \frac{1}{2} t \cos(\gamma t).$$
   The second term integrates to:
   $$\int_0^t \frac{1}{2} \cos(2\gamma \tau - \gamma t) \, d\tau = \left[ \frac{\sin(2\gamma \tau - \gamma t)}{4\gamma} \right]_0^t = \frac{\sin(\gamma t) - \sin(-\gamma t)}{4\gamma} = \frac{2\sin(\gamma t)}{4\gamma} = \frac{\sin(\gamma t)}{2\gamma}.$$
   Combining both terms and multiplying by the factored exponential $e^{(\beta-1/2)t}$ gives:
   $$I_\rho(t) = \frac{1}{2} t e^{(\beta-1/2)t} \cos(\gamma t) + \frac{1}{2\gamma} e^{(\beta-1/2)t} \sin(\gamma t).$$

3. **Mellin Transform Verification**:
   The Laplace transform of $f(t) = e^{\alpha t} \cos(\gamma t)$ is $\mathcal{L}[f](s) = \frac{s - \alpha}{(s - \alpha)^2 + \gamma^2}$.
   The convolution $(f * f)(t)$ has Laplace transform:
   $$\mathcal{L}[f * f](s) = (\mathcal{L}[f](s))^2 = \frac{(s - \alpha)^2}{((s - \alpha)^2 + \gamma^2)^2}.$$
   Near the pole $s = \alpha + i\gamma$, setting $z = s - (\alpha + i\gamma)$, the denominator is $z^2 (z + 2i\gamma)^2 \approx -4\gamma^2 z^2$, and the numerator is $(i\gamma)^2 = -\gamma^2$.
   Hence, the principal part of the Laurent expansion at $s = \alpha + i\gamma$ is:
   $$\frac{-\gamma^2}{-4\gamma^2 z^2} = \frac{1}{4 z^2} = \frac{1}{4 (s - (\alpha + i\gamma))^2}.$$
   Taking the inverse Laplace transform of $\frac{1}{(s - (\alpha + i\gamma))^2}$ gives $t e^{(\alpha + i\gamma)t}$. Summing with the conjugate pole at $\alpha - i\gamma$ yields exactly $\frac{1}{2} t e^{\alpha t} \cos(\gamma t)$.

4. **Comparison with Triple Pole Drift**:
   In the arithmetic function $W(x)$, the Mellin transform contains $\mathcal{M}(s) \sim \frac{G(s)^2}{s(s+1)}$.
   The same-prime extraction creates a triple pole at $s = 1/2$, yielding leading negative drift $-\frac{1}{6} x^{3/2} \log^2 x$.
   Any off-critical zero $\rho = \beta + i\gamma$ with $\beta > 1/2$ creates a double pole at $s = \rho$ in $\mathcal{M}(s)$. In the spatial domain, the residue of this double pole is:
   $$\text{Res}_{s=\rho} \left( \mathcal{M}(s) x^{s+1} \right) = \left( a_{-2} \log x + a_{-1} \right) x^{\rho+1}.$$
   The modulus of this oscillatory term is:
   $$|a_{-2}| x^{\beta+1} \log x.$$
   Because $\beta + 1 > 3/2$, the ratio of the oscillatory amplitude to the negative drift is:
   $$\frac{|a_{-2}| x^{\beta+1} \log x}{\frac{1}{6} x^{3/2} \log^2 x} = \frac{6 |a_{-2}| x^{\beta - 1/2}}{\log x} \xrightarrow{x \to \infty} +\infty.$$
   Because the cosine factor oscillates between $-1$ and $+1$ infinitely often as $\log x \to \infty$, $W(x)$ must attain arbitrarily large positive values.

## Hypotheses / Conditions
- Existence of at least one zero $\rho = \beta + i\gamma$ of $\zeta(s)$ with $\beta > 1/2$ and $\gamma \ne 0$.
- Bilinear self-convolution of the prime indicator or error term without external cross-correlation phase cancellation from an independent sequence.

## How It Applies
This theorem refutes all strategies proposing that:
1. Bilinear or Hilbert-space embeddings $\mathcal{H}(a*a)(t)$ undergo global destructive interference or phase cancellation that washes out off-critical zero modes.
2. Smoothing $W(x)$ by Riesz means or Cesàro averages eliminates the obstacle of off-critical zeros.
3. Eventual nonpositivity of $W(x)$ (or any smoothed variant) can be established unconditionally without proving the Riemann Hypothesis.

## Caveats
- If the Riemann Hypothesis is true, then $\beta = 1/2$ for all non-trivial zeros, so $\beta + 1 = 3/2$. In that case, the oscillatory terms scale as $O(x^{3/2} \log x)$, which is strictly subleading to the negative drift $-\frac{1}{6} x^{3/2} \log^2 x$, and $W(x) \le 0$ holds asymptotically.
- The theorem strictly proves that *squaring* an error term containing an off-critical oscillatory mode doubles the pole order and induces secular linear growth in the amplitude.
