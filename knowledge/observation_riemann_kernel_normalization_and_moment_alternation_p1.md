# Riemann Kernel Normalization Factor and Moment Alternation Root Blindness

Type: observation
Confidence: high
Source: Aggregators L01_N08, L01_N12, L01_N13 (Level 1); L02_N00-N06 (Level 2); r2_L03_N00, r2_L03_N01, r2_L03_N02, r2_L03_N03 (Level 3); r2_L04_N00 (Level 4 Root)
Relevant to: Theta-Mellin transform representations of $\Xi(t)$, moment problem approaches, and sign-alternation arguments for Taylor coefficients

## Statement
1. **Riemann Kernel Prefactor Normalization**:
   In the classical Fourier cosine transform representation:
   $$\Xi(t) = C \int_0^\infty \Phi(u) \cos(ut)\, du,$$
   where $\Phi(u) = \sum_{n=1}^\infty (2\pi^2 n^4 e^{9u} - 3\pi n^2 e^{5u}) \exp(-\pi n^2 e^{4u})$, the exact prefactor is $C = 4$.
   Under this normalization:
   $$\int_0^\infty \Phi(u)\, du = \frac{1}{4} \Xi(0) = \frac{1}{4} \xi\left(\frac{1}{2}\right) \approx 0.124282,$$
   while $\Phi(0) \approx 0.89339$ (distinct from $\xi(1/2) \approx 0.49712$). Using the common erroneous prefactor $C = 2$ yields $2 \int_0^\infty \Phi(u) du = \frac{1}{2}\xi(1/2)$, which introduces a factor-of-2 defect in Fourier inversion formulas.

2. **Moment Alternation Blindness to Complex Zeros**:
   Because $\Phi(u) > 0$ for all $u \ge 0$, the even moments $\mu_{2m} = \int_0^\infty u^{2m} \Phi(u) du > 0$ are all strictly positive. Expanding $\Xi(t) = \sum_{m=0}^\infty \frac{(-1)^m}{(2m)!} \mu_{2m} t^{2m}$, the Taylor coefficients alternate in sign.
   Writing $z = 1/4 + t^2 = s(1-s)$ and defining $g(w) = \Xi_*(w + 1/4) = \sum_{m=0}^\infty c_m w^m$, the coefficients satisfy $c_m (-1)^m > 0$. This alternation rigorously proves that $g(w) > 0$ for all real $w \le 0$ (corresponding to the real segment $s \in [0, 1]$ where $\Xi(it) > 0$).
   However, strictly alternating Taylor coefficients $c_m (-1)^m > 0$ do **not** imply that all roots of the function are real. In particular, moment alternation is completely blind to non-real complex zeros.

## Evidence
- **Numerical Integral Verification**:
  Direct high-precision numerical integration of $\Phi(u)$ over $[0, \infty)$ confirms:
  $$\int_0^\infty \Phi(u)\, du = 0.124282098... = \frac{0.49712079...}{4} = \frac{\xi(1/2)}{4}.$$
  Setting $C = 4$ yields $4 \int_0^\infty \Phi(u) du = 0.49712079... = \Xi(0) = \xi(1/2)$.
- **Polynomial Counterexample to Root Reality**:
  Consider the quadratic polynomial:
  $$P(w) = w^2 - 2w + 2.$$
  Its coefficients are $c_0 = 2 > 0$, $c_1 = -2 < 0$, and $c_2 = 1 > 0$, so they strictly alternate in sign ($(-1)^m c_m > 0$ for $m=0, 1, 2$).
  For all real $w \le 0$, $P(w) = w^2 - 2w + 2 = (w-1)^2 + 1 \ge 2 > 0$, so $P(w)$ has no real negative roots.
  However, the roots of $P(w)$ are $w = 1 \pm i$.
  Under the correspondence $w = s(1-s) - 1/4 = 1/4 - (s - 1/2)^2$, we have:
  $$\left(s - \frac{1}{2}\right)^2 = \frac{1}{4} - (1 \pm i) = -\frac{3}{4} \mp i.$$
  Solving for $s = \sigma + it$:
  $$s - \frac{1}{2} = \pm (0.45509 - 1.09868i) \implies \sigma \approx 0.95509 \ne \frac{1}{2}, \quad t \approx \pm 1.09868.$$
  This produces a quadruplet of off-line roots in the critical strip with real part $\beta \approx 0.955 > 1/2$.
  Thus, moment alternation and positive kernel positivity alone cannot rule out off-line zeros.

## Implications
- Any proof attempt that relies solely on the positivity of $\Phi(u) > 0$ and the resulting sign-alternation of moments $\mu_{2m}$ can only prove that $\zeta(s)$ has no zeros on the real line segment $s \in [0, 1]$.
- Claims that "positive kernels imply real zeros" conflate Pólya frequency functions (which require total positivity of minors of all orders) with simple 1D kernel positivity.
- Normalization constants in theta-Mellin transforms must use prefactor 4; using 2 invalidates quantitative contour inequalities by factor 2.

## Caveats
- The Riemann xi function has additional symmetries and growth constraints beyond simple moment alternation (e.g. genus 0 under $z(s)$, functional equation, and Hadamard factorization). While $P(w)$ proves that moment alternation does not suffice, $\Xi(t)$ is not a low-degree polynomial. However, any proof of zero-reality must invoke properties beyond positivity of the Fourier kernel $\Phi(u)$.
