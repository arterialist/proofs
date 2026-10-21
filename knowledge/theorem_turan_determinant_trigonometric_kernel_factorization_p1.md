# Turán Determinant Trigonometric Kernel Factorization for Even Fourier Transforms

Type: theorem
Confidence: high
Confidence: high
Source: Candidate explore_merger_r2_L01_N01 (Level 1, Iteration 1, Round 2)
Relevant to: Transverse convexity, Turán determinants, Laguerre-Pólya class testing for Fourier transforms of positive even rapidly decaying kernels, including $\Xi(t)$.

## Statement
Let $\Phi(u)$ be a real, even, positive, smooth function on $\mathbb{R}$ with rapid decay at infinity, and let:
$$F(t) = \int_{-\infty}^\infty \Phi(u) \cos(tu) du$$
be its Fourier transform. Then the first Turán determinant (Laguerre invariant) of $F(t)$:
$$T(F)(t) := (F'(t))^2 - F(t) F''(t)$$
admits the exact double-integral representation:
$$T(F)(t) = \int_{-\infty}^\infty \mathcal{K}(x) \cos(tx) dx$$
where the effective convolution kernel $\mathcal{K}(x)$ is defined by:
$$\mathcal{K}(x) := \frac{1}{4} \int_{-\infty}^\infty y^2 \Phi\left(\frac{y+x}{2}\right) \Phi\left(\frac{y-x}{2}\right) dy.$$
In particular, $\mathcal{K}(x) > 0$ strictly for all $x \in \mathbb{R}$, is even, and inherits rapid decay from $\Phi$.

## Proof
1. Express $F(t)$, $F'(t)$, and $F''(t)$ as cosine and sine integrals:
   $$F(t) = \int_{-\infty}^\infty \Phi(u) \cos(tu) du, \quad F'(t) = -\int_{-\infty}^\infty u \Phi(u) \sin(tu) du, \quad F''(t) = -\int_{-\infty}^\infty u^2 \Phi(u) \cos(tu) du.$$
2. Form the product difference $(F'(t))^2 - F(t)F''(t)$:
   $$(F'(t))^2 = \int_{-\infty}^\infty \int_{-\infty}^\infty uv \Phi(u) \Phi(v) \sin(tu) \sin(tv) du dv$$
   $$-F(t) F''(t) = \int_{-\infty}^\infty \int_{-\infty}^\infty v^2 \Phi(u) \Phi(v) \cos(tu) \cos(tv) du dv.$$
   Symmetrizing in $u$ and $v$ yields:
   $$T(F)(t) = \int_{-\infty}^\infty \int_{-\infty}^\infty \Phi(u) \Phi(v) \left[ \frac{u^2 + v^2}{2} \cos(tu) \cos(tv) + uv \sin(tu) \sin(tv) \right] du dv.$$
3. Apply the exact trigonometric product-to-sum identity:
   $$(u^2 + v^2) \cos(tu) \cos(tv) + 2uv \sin(tu) \sin(tv) = \frac{1}{2} (u+v)^2 \cos(t(u-v)) + \frac{1}{2} (u-v)^2 \cos(t(u+v)).$$
4. Substitute new integration coordinates $x = u - v$ and $y = u + v$ (Jacobian determinant $J = 1/2$):
   Then $u = (y+x)/2$ and $v = (y-x)/2$. Since $\Phi$ is even, symmetry under $x \mapsto -x$ and $y \mapsto -y$ reduces the integral to:
   $$T(F)(t) = \int_{-\infty}^\infty \left[ \frac{1}{4} \int_{-\infty}^\infty y^2 \Phi\left(\frac{y+x}{2}\right) \Phi\left(\frac{y-x}{2}\right) dy \right] \cos(tx) dx = \int_{-\infty}^\infty \mathcal{K}(x) \cos(tx) dx.$$
   Since $y^2 > 0$ almost everywhere and $\Phi > 0$, the inner integrand is strictly positive, hence $\mathcal{K}(x) > 0$ for all $x \in \mathbb{R}$.

## Hypotheses / Conditions
- $\Phi \in C^2(\mathbb{R})$, real, even ($\Phi(-u) = \Phi(u)$), and strictly positive everywhere.
- $\int_{-\infty}^\infty (1 + u^4) \Phi(u) du < \infty$ to ensure absolute convergence and interchange of integrals and derivatives.

## How It Applies
For the Riemann $\Xi$-function, $\Xi(t) = \int_{-\infty}^\infty \Phi(u) \cos(tu) du$ where:
$$\Phi(u) = 2\pi e^{9u/2} \sum_{n=1}^\infty (2\pi n^2 e^{2u} - 3) n^2 e^{-n^2 \pi e^{2u}} > 0.$$
The kernel factorization shows that the Turán determinant $T(\Xi)(t)$ is itself the Fourier cosine transform of the positive kernel $\mathcal{K}(x)$.

## Caveats
While $\mathcal{K}(x) > 0$ everywhere, the Fourier transform of a strictly positive function is NOT necessarily positive everywhere (e.g. Bochner's theorem requires positive-definiteness, not merely point positivity of the kernel). Thus $T(\Xi)(t) > 0$ does not follow automatically from $\mathcal{K}(x) > 0$, nor does $T(\Xi)(t) > 0$ suffice to prove real-rootedness due to the Laguerre converse failure.
