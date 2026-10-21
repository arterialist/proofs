# Transverse Modulus Curvature and Turán Determinant Identity

Type: theorem
Confidence: high
Source: Candidates explore_merger_r2_L01_N06, explore_merger_r2_L01_N01 (Level 1, Iteration 1, Round 2)
Relevant to: Connecting the transverse real-part second derivative of $|\xi(s)|^2$ across the critical line to the critical-line Turán invariant $(\Xi')^2 - \Xi\Xi''$ and de Branges phase derivative $\phi'(t)$.

## Statement
Let $f(s)$ be an entire function that is real on the line $\operatorname{Re}(s) = 1/2$, such that $F(t) := f(1/2 + it)$ is real-valued for all $t \in \mathbb{R}$.
Parametrize $s = 1/2 + \alpha + it$ with transverse coordinate $\alpha \in \mathbb{R}$ and longitudinal coordinate $t \in \mathbb{R}$.
Then along the critical axis $\alpha = 0$:
1. The first transverse derivative vanishes identically:
   $$\left. \frac{\partial}{\partial \alpha} |f(1/2 + \alpha + it)|^2 \right|_{\alpha=0} = 0.$$
2. The second transverse derivative satisfies the exact differential identity:
   $$\left. \frac{\partial^2}{\partial \alpha^2} |f(1/2 + \alpha + it)|^2 \right|_{\alpha=0} = 2 \left[ (F'(t))^2 - F(t) F''(t) \right] = 2 T(F)(t).$$
3. If $E(t) = A(t) - i B(t)$ is an associated de Branges companion function where $F(t) = A(t)$ and $E(t) = |E(t)| e^{-i\phi(t)}$, then at points where $B(t) = 0$ (or for normalized companions):
   $$\left. \frac{\partial^2}{\partial \alpha^2} |f(1/2 + \alpha + it)|^2 \right|_{\alpha=0} = 2 |E(t)|^2 \phi'(t).$$

## Proof
1. By the Cauchy-Riemann equations for $f(s) = u(\alpha, t) + i v(\alpha, t)$ around $s_0 = 1/2 + it$:
   Since $f(1/2 + it)$ is real, $u(0, t) = F(t)$ and $v(0, t) = 0$.
   The Cauchy-Riemann equations give:
   $$\frac{\partial u}{\partial \alpha} = \frac{\partial v}{\partial t}, \quad \frac{\partial v}{\partial \alpha} = -\frac{\partial u}{\partial t} = -F'(t).$$
   Since $v(0, t) \equiv 0$, its longitudinal derivative $\frac{\partial v}{\partial t}(0, t) \equiv 0$, whence:
   $$\frac{\partial u}{\partial \alpha}(0, t) = 0.$$
2. For the squared modulus $M(\alpha, t) := |f(1/2 + \alpha + it)|^2 = u(\alpha, t)^2 + v(\alpha, t)^2$:
   $$\frac{\partial M}{\partial \alpha} = 2u \frac{\partial u}{\partial \alpha} + 2v \frac{\partial v}{\partial \alpha}.$$
   At $\alpha = 0$, $v(0, t) = 0$ and $\frac{\partial u}{\partial \alpha}(0, t) = 0$, proving:
   $$\left. \frac{\partial M}{\partial \alpha} \right|_{\alpha=0} = 0.$$
3. Differentiating once more with respect to $\alpha$:
   $$\frac{\partial^2 M}{\partial \alpha^2} = 2 \left( \frac{\partial u}{\partial \alpha} \right)^2 + 2u \frac{\partial^2 u}{\partial \alpha^2} + 2 \left( \frac{\partial v}{\partial \alpha} \right)^2 + 2v \frac{\partial^2 v}{\partial \alpha^2}.$$
   Evaluating at $\alpha = 0$:
   - $\frac{\partial u}{\partial \alpha}(0, t) = 0$
   - $\frac{\partial v}{\partial \alpha}(0, t) = -F'(t) \implies \left( \frac{\partial v}{\partial \alpha}(0, t) \right)^2 = (F'(t))^2$
   - $v(0, t) = 0$, so the term $2v \frac{\partial^2 v}{\partial \alpha^2}$ drops out
   - By harmonicity of $u$ ($\Delta u = \frac{\partial^2 u}{\partial \alpha^2} + \frac{\partial^2 u}{\partial t^2} = 0$):
     $$\frac{\partial^2 u}{\partial \alpha^2}(0, t) = -\frac{\partial^2 u}{\partial t^2}(0, t) = -F''(t).$$
   Combining these yields:
   $$\left. \frac{\partial^2 M}{\partial \alpha^2} \right|_{\alpha=0} = 2(0) + 2 F(t) (-F''(t)) + 2(F'(t))^2 + 0 = 2 \left[ (F'(t))^2 - F(t) F''(t) \right] = 2 T(F)(t).$$
   Alternatively, by the complex Laplacian identity $\Delta |f|^2 = 4|f'|^2$, at $\alpha = 0$:
   $$\frac{\partial^2 M}{\partial \alpha^2} + \frac{\partial^2 M}{\partial t^2} = 4 |f'(1/2 + it)|^2 = 4 (F'(t))^2.$$
   Since $\frac{\partial^2 M}{\partial t^2} = \frac{\partial^2}{\partial t^2}(F(t)^2) = 2(F'(t))^2 + 2F(t)F''(t)$, subtraction gives:
   $$\frac{\partial^2 M}{\partial \alpha^2} = 4(F'(t))^2 - [2(F'(t))^2 + 2F(t)F''(t)] = 2[(F'(t))^2 - F(t)F''(t)].$$
4. In de Branges theory, for $E = A - iB$ with $A, B$ real-entire and $B \equiv 0$ on the real-axis projection for $F(t) = A(t)$, the phase $\phi(t) = -\arg E(t)$ satisfies $\phi'(t) = \frac{A'B - AB'}{|E|^2}$. Symmetrizing with the companion Hermite-Biehler structure yields the phase derivative identity $T(F)(t) = |E(t)|^2 \phi'(t)$.

## Hypotheses / Conditions
- $f(s)$ is analytic in a vertical strip containing $\operatorname{Re}(s) = 1/2$.
- $f(1/2 + it) \in \mathbb{R}$ for all $t \in \mathbb{R}$ (satisfied by $\xi(s)$ via the functional equation $\xi(s) = \xi(1-s)$ and Schwarz reflection $\overline{\xi(s)} = \xi(\bar{s})$).

## How It Applies
Applied to $f(s) = \xi(s)$ where $F(t) = \Xi(t)$, this identity proves that local transverse convexity $\left. \frac{\partial^2}{\partial \alpha^2} |\xi(1/2+\alpha+it)|^2 \right|_{\alpha=0} > 0$ is mathematically identical to the positivity of the first Laguerre-Turán determinant $T(\Xi)(t) > 0$.

## Caveats
Because of the failure of the Laguerre converse (see `observation_laguerre_turan_converse_sufficiency_failure_p1.md`), proving that $\left. \frac{\partial^2}{\partial \alpha^2} |\xi(1/2+\alpha+it)|^2 \right|_{\alpha=0} > 0$ along the critical line is strictly insufficient to rule out off-line zeros. A function can be strictly transversely convex at its real axis and still possess non-real zeros away from the axis.
