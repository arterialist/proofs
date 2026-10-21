# Master Logarithmic Derivative Conformal Coupling Identity

Type: theorem
Confidence: high
Source: Aggregators L02_N03, L02_N04, L02_N05, L02_N06 (Level 2); r2_L03_N00, r2_L03_N01, r2_L03_N02, r2_L03_N03 (Level 3); r2_L04_N00 (Level 4 Root)
Relevant to: Connecting the logarithmic derivative of the completed Riemann xi function on the critical strip to the conformal variable $z(s) = s(1-s)$ and the boundary value on the critical line.

## Statement
Let $\xi(s) = \frac{1}{2} s(s-1) \pi^{-s/2} \Gamma(s/2) \zeta(s)$ be the completed Riemann xi function, satisfying $\xi(s) = \xi(1-s)$. Let $z(s) = s(1-s)$ be the quadratic conformal invariant map from the critical strip $\mathbb{S} = \{s \in \mathbb{C} : 0 < \operatorname{Re}(s) < 1\}$ to the slit complex plane $\mathbb{C} \setminus [1/4, \infty)$. Let $\Xi_*(z)$ be the entire function of order $1/2$ such that $\xi(s) = \Xi_*(z(s))$, and define the meromorphic logarithmic derivative field
$$F(z) := -\frac{\Xi_*'(z)}{\Xi_*(z)}.$$
Then for all $s \in \mathbb{C}$ away from the zeros of $\xi(s)$:
1. The logarithmic derivative of $\xi(s)$ satisfies the exact chain rule coupling:
   $$\frac{\xi'(s)}{\xi(s)} = (2s - 1) F(z(s)).$$
2. In Cartesian coordinates $s = \sigma + it$ with $z(s) = \sigma(1-\sigma) + t^2 - i(2\sigma - 1)t$, the real and imaginary parts decompose explicitly as:
   $$\operatorname{Re}\left(\frac{\xi'(s)}{\xi(s)}\right) = 2\left(\sigma - \frac{1}{2}\right) \operatorname{Re}(F(z(s))) - 2t \operatorname{Im}(F(z(s))),$$
   $$\operatorname{Im}\left(\frac{\xi'(s)}{\xi(s)}\right) = 2t \operatorname{Re}(F(z(s))) + 2\left(\sigma - \frac{1}{2}\right) \operatorname{Im}(F(z(s))).$$
3. On the critical line $\sigma = 1/2$, $z(1/2+it) = 1/4 + t^2 \in \mathbb{R}$, so $F(z(1/2+it)) \in \mathbb{R}$. Consequently:
   $$\operatorname{Re}\left(\frac{\xi'(1/2 + it)}{\xi(1/2 + it)}\right) \equiv 0 \quad \text{for all } t \in \mathbb{R} \setminus \{\gamma_n\}.$$

## Proof
By the reflection symmetry $\xi(s) = \xi(1-s)$, $\xi(s)$ is an even function of $s - 1/2$. Since $z(s) = s(1-s) = 1/4 - (s - 1/2)^2$, every even entire function of $s - 1/2$ can be expressed uniquely as an entire function $\Xi_*(z)$ of $z$. Differentiating $\xi(s) = \Xi_*(z(s))$ with respect to $s$ via the chain rule:
$$\xi'(s) = \Xi_*'(z(s)) \cdot \frac{d z}{ds} = \Xi_*'(z(s)) \cdot (1 - 2s) = -(2s - 1) \Xi_*'(z(s)).$$
Dividing by $\xi(s) = \Xi_*(z(s))$ yields:
$$\frac{\xi'(s)}{\xi(s)} = -(2s - 1) \frac{\Xi_*'(z(s))}{\Xi_*(z(s))} = (2s - 1) F(z(s)).$$
Writing $2s - 1 = 2(\sigma - 1/2) + 2it$ and $F(z) = \operatorname{Re}(F(z)) + i \operatorname{Im}(F(z))$, multiplication of complex numbers yields:
$$(2s - 1) F(z) = [2(\sigma - 1/2) + 2it] [\operatorname{Re}(F(z)) + i \operatorname{Im}(F(z))]$$
$$= [2(\sigma - 1/2)\operatorname{Re}(F(z)) - 2t\operatorname{Im}(F(z))] + i [2t\operatorname{Re}(F(z)) + 2(\sigma - 1/2)\operatorname{Im}(F(z))].$$
Taking real and imaginary parts proves the coordinate decomposition.
Setting $\sigma = 1/2$, the factor $\sigma - 1/2$ vanishes, and $z(1/2+it) = 1/4 + t^2 \in [1/4, \infty) \subset \mathbb{R}$. Since $\xi(s)$ is real-valued on the critical line, $\Xi_*(x)$ is real-valued for all $x \in \mathbb{R}$, which implies $\Xi_*'(x) \in \mathbb{R}$ and thus $F(x) \in \mathbb{R}$ (so $\operatorname{Im}(F(z(1/2+it))) = 0$). Hence $\operatorname{Re}(\xi'/\xi) = -2t \cdot 0 = 0$.

## Hypotheses / Conditions
- $s$ is not a zero of $\xi(s)$, so that the logarithmic derivative is well-defined and finite.
- $z(s) = s(1-s)$. Note that for $\sigma > 1/2$ and $t > 0$, $\operatorname{Im}(z(s)) = -(2\sigma - 1)t < 0$, so the right half of the critical strip maps into the lower half-plane $\mathbb{C}^-$.

## How It Applies
This identity is the central bridge coupling the de Bruijn-Newman / Herglotz spectral analysis of $\Xi_*(z)$ on the cut plane $\mathbb{C} \setminus [1/4, \infty)$ to the transverse growth and de Branges contractivity of $\xi(s)$ across the critical line. It makes transparent the exact contributions of $\operatorname{Re}(F(z))$ and $\operatorname{Im}(F(z))$ to the horizontal derivative $\partial_\sigma \log |\xi(s)| = \operatorname{Re}(\xi'(s)/\xi(s))$.

## Caveats
- While the boundary term vanishes identically on $\sigma = 1/2$, off the critical line ($\sigma > 1/2$), the two terms $2(\sigma - 1/2)\operatorname{Re}(F(z))$ and $-2t\operatorname{Im}(F(z))$ have opposing signs near critical zeros, creating sign competition rather than monotonic reinforcement (see observation on polarization decomposition sign competition).
