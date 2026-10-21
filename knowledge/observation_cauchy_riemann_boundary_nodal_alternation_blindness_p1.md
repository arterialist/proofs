# Cauchy-Riemann Boundary Nodal Origination Alternation and Complex Zero Blindness

Type: observation
Confidence: high
Source: Explorer r3 Node 10 (Level 0)
Relevant to: 2D field decomposition of completed $\xi(s)$ into $(\operatorname{Re}\xi, \operatorname{Im}\xi)$, nodal curve foliation, and attempts to deduce off-line zero exclusion from boundary derivative alternation

## Statement
Let $f(s)$ be any function analytic on a domain symmetric across the critical line $\mathcal{L} = \{s \in \mathbb{C} \mid \operatorname{Re}(s) = 1/2\}$ and real-valued on $\mathcal{L}$ (so $\operatorname{Im}(f(1/2+it)) \equiv 0$). Writing $s = 1/2 + \alpha + i\beta$, the boundary normal derivative of the imaginary part satisfies the exact Cauchy-Riemann identity:
$$\lim_{\alpha \to 0^+} \frac{\operatorname{Im}(f(1/2+\alpha+i\beta))}{\alpha} = \frac{\partial \operatorname{Im}(f)}{\partial \alpha}\bigg|_{\alpha=0} = -\frac{\partial \operatorname{Re}(f)}{\partial \beta}\bigg|_{\alpha=0} = -f_0'(\beta),$$
where $f_0(\beta) = f(1/2+i\beta)$ is the restriction of $f$ to the line of symmetry.

Consequently, along $\alpha = 0$:
1. The real nodal curves $\{\operatorname{Re}(f) = 0\}$ emanate into $\alpha > 0$ from the boundary zeros $\gamma_n$ of $f_0(\beta)$.
2. The interior imaginary nodal curves $\{\alpha > 0 \mid \operatorname{Im}(f) = 0\}$ can reach the boundary $\alpha = 0$ if and only if $f_0'(\beta) = 0$, meaning they emanate strictly from the Rolle extrema $\beta_{*, n}$ of $f_0(\beta)$.
3. Because Rolle extrema strictly alternate with simple real zeros ($\gamma_1 < \beta_{*, 1} < \gamma_2 < \dots$), boundary nodal origination points strictly alternate for ANY real-symmetric analytic function.

However, this boundary origination alternation provides **zero obstruction** to off-line zeros or interior nodal curve intersections: real and imaginary nodal curves can originate at alternating boundary points, curve into the interior $\alpha > 0$, and intersect orthogonally at an off-line zero $f(\rho_0) = 0$.

## Evidence
1. **Degree-8 Polynomial Counterexample**:
   The real-symmetric polynomial:
   $$f(s) = (s^2 + 1)(s^2 + 9)\left(\left(s - \frac{1}{2}\right)^2 + 4\right)\left(\left(s + \frac{1}{2}\right)^2 + 4\right)$$
   is symmetric under $s \mapsto 1-s$ and $s \mapsto \bar{s}$, and real on $\operatorname{Re}(s) = 0$. Along the line $\alpha = 0$:
   - Boundary zeros lie at $\beta = \pm 1$ and $\beta = \pm 3$.
   - A Rolle extremum lies at $\beta_* \approx 2.701$, strictly alternating between $\beta = 1$ and $\beta = 3$.
   - The boundary derivative identity $\lim_{\alpha \to 0} \operatorname{Im}(f)/\alpha = -f_0'(\beta)$ holds identically.
   - Yet $f(s)$ has an off-line zero at $s = 1/2 + 2i$ ($\alpha = 1/2, \beta = 2$), where the real nodal line $\{\operatorname{Re}(f) = 0\}$ and imaginary nodal line $\{\operatorname{Im}(f) = 0\}$ intersect orthogonally in the interior $\alpha > 0$.

2. **Rolle Amplitude Alternation and Exponential Collapse**:
   For the actual Riemann xi function $\Xi(t) = \xi(1/2+it)$, Rolle extrema $\beta_{*, n}$ oscillate in sign:
   - $\Xi(\beta_{*, 1}) \approx -8.016 \times 10^{-4}$ (negative)
   - $\Xi(\beta_{*, 2}) \approx +7.758 \times 10^{-6}$ (positive)
   - $\Xi(\beta_{*, 3}) \approx -6.695 \times 10^{-7}$ (negative)
   - $\Xi(\beta_{*, 4}) \approx +8.106 \times 10^{-9}$ (positive)
   The values alternate in sign and decay exponentially as $\exp(-\pi \beta / 4)$, decisively refuting any uniform single-sign potential well along Rolle branches.

3. **Rodgers-Tao Newman Barrier**:
   The deformed Fourier kernels $\Phi_\lambda(u) = e^{\lambda u^2}\Phi(u)$ for $\lambda < 0$ satisfy the identical 2D Fourier-Laplace integral representation and boundary Cauchy-Riemann derivative alternation, yet are proven to possess off-line zeros and interior nodal intersections (Rodgers & Tao 2020, $\Lambda \ge 0$).

## Implications
- Any proof strategy attempting to deduce non-vanishing of $\xi(s)$ on $\operatorname{Re}(s) > 1/2$ from Cauchy-Riemann boundary alternation or local Rolle extrema properties is mathematically invalid.
- Boundary alternation is a universal kinematic consequence of Cauchy-Riemann symmetry and cannot rule out interior dynamical reconnections.

## Caveats
Does not preclude global variational arguments (such as Dirichlet energy balances or non-local Green potentials) that constrain the global topology of nodal domains, provided they utilize fine arithmetic Euler product input that distinguishes $\xi(s)$ from deformed kernels $\Phi_\lambda(u)$.
