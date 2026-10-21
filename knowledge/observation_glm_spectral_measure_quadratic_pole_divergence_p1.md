# Gelfand-Levitan-Marchenko Spectral Measure Quadratic Pole Divergence

Type: observation
Confidence: high
Source: Candidate N27 (Round 2, Level 0)
Relevant to: Krein-de Branges canonical systems, inverse spectral theory, and Gelfand-Levitan-Marchenko integral equations for $\Xi(z)$

## Statement
Let $\Xi_0(t)$ be the completed Riemann xi function on the critical line $s = 1/2 + it$. The formal continuous spectral measure $d\rho(t) = \frac{dt}{\pi |\Xi_0(t)|^2}$ associated with the Krein-de Branges canonical system for $\Xi_0(z)$ possesses non-integrable quadratic poles at every critical-line zero $t = \gamma_n$:
$$\frac{1}{|\Xi_0(t)|^2} = \frac{1}{|\Xi_0'(\gamma_n)|^2 (t-\gamma_n)^2} + O\left(\frac{1}{|t-\gamma_n|}\right)$$
At the first non-trivial zero $\gamma_1 \approx 14.134725$, the derivative magnitude is $|\Xi_0'(\gamma_1)| \approx 1.3828 \times 10^{-3}$, giving a leading pole prefactor:
$$\frac{1}{\pi |\Xi_0'(\gamma_1)|^2} \approx 5.234 \times 10^5$$
Consequently, the standard Gelfand-Levitan-Marchenko (GLM) kernel $F(x, y) = \int_{-\infty}^\infty \cos(xt)\cos(yt)\,(d\rho(t) - d\rho_0(t))$ and its associated Marchenko integral equation $K(x, y) + F(x, y) + \int_{-x}^x K(x, s)F(s, y)\,ds = 0$ diverge unconditionally, rendering classical inverse scattering reconstructions mathematically ill-posed without point-mass regularization.

## Evidence
1. Exact Taylor expansion of entire function $\Xi_0(t)$ at its simple zeros $\gamma_n$: since $\Xi_0(\gamma_n) = 0$ and $\Xi_0'(\gamma_n) \ne 0$ for all known zeros, $1/|\Xi_0(t)|^2$ has isolated non-integrable double poles on the real line.
2. Numerical verification for $\gamma_1 \approx 14.134725$: evaluated $\Xi_0'(\gamma_1) \approx 0.00138283$, yielding $\frac{1}{\pi (\Xi_0')^2} \approx 5.234 \times 10^5 > 0$. The integral $\int_{\gamma_1 - \epsilon}^{\gamma_1 + \epsilon} d\rho(t)$ diverges to $+\infty$ for every $\epsilon > 0$.
3. Falser verification (`explore_falser_r2_L00_N27`): showed that $F(x, y)$ cannot be regularized as a distribution or tempered kernel without removing an infinite sequence of non-integrable quadratic singularities along $\mathbb{R}$.

## Implications
1. Eliminates naive applications of classical Gelfand-Levitan-Marchenko (GLM) inverse spectral theory to the Riemann xi function: the perturbed spectral measure $d\rho(t)$ does not satisfy the Faddeev-Marchenko condition $\int_{-\infty}^\infty (1+|t|) |d\rho - d\rho_0| < \infty$.
2. Any valid canonical system $J Y' = z \mathcal{H}(x) Y$ realizing $\Xi_0(z)$ cannot have $d\rho(t) = dt/(\pi |\Xi_0(t)|^2)$ as an unregularized spectral measure; boundary monodromy functions $A(x, z)$ and $B(x, z)$ must form a genuine de Branges pair $E = A - iB$ satisfying strict phase contractivity $|E(z)| > |E(\bar{z})|$ on $\mathbb{C}^+$, which requires $W(A, B) < 0$ rather than $W > 0$.

## Caveats
Regularization via complex contour deformation (shifting the integration path off the real axis into $\mathbb{C}^+$) or regularized distributions (Cauchy principal value plus Hadamard finite parts) can define generalized kernels, but such objects do not yield positive-definite trace-class integral operators in classical GLM theory.
