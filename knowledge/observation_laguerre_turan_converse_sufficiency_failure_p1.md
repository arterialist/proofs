# Laguerre-Turán Converse Sufficiency Failure and Counterexample

Type: observation
Confidence: high
Source: Candidates explorer_r2_L00_N16, explorer_r2_L00_N17, explorer_r2_L00_N23 (Level 0); explore_merger_r2_L01_N06 (Level 1); explore_merger_r2_L04_N00 (Level 4 Root)
Relevant to: Proof strategies attempting to deduce real-rootedness of $\Xi(t)$ or $\zeta(s)$ from the non-negativity of the first Laguerre-Turán invariant $L_1[f](t) := (f'(t))^2 - f(t)f''(t) \ge 0$.

## Statement
While Laguerre's classical theorem (1882) proves that every real-entire function in the Laguerre-Pólya class $\mathcal{LP}$ (having exclusively real zeros) satisfies $L_1[f](t) \ge 0$ for all $t \in \mathbb{R}$, the converse is mathematically FALSE.
Global strict positivity of the first Laguerre-Turán invariant $L_1[f](t) > 0$ on $\mathbb{R}$ is strictly insufficient to force all zeros of $f(t)$ to be real.

1. **Polynomial Counterexamples**:
   - Degree 4 counterexample (certified in Aggregator and Falser r2_L04_N00):
     $$f(t) = (t^2 - 1)(t^2 + 4) = t^4 + 3t^2 - 4.$$
     Its zeros are $t = \pm 1$ and non-real roots $t = \pm 2i$. Its Turán determinant is:
     $$T(f)(t) = (f'(t))^2 - f(t)f''(t) = 4t^6 + 6t^4 + 66t^2 + 24 \ge 24 > 0 \quad \text{for all } t \in \mathbb{R}.$$
     Furthermore, its companion function $E_+(z) = f(z) + i f'(z)$ has a root in the open upper half-plane at $z \approx +1.544337i \in \mathbb{C}^+$, refuting Hermite-Biehler contractivity.
   - Degree 6 counterexample:
     $$f_6(t) = ((t-1)^2 + 1/4)((t+1)^2 + 1/4)(t^2 - 1.21) = t^6 - \frac{271}{100}t^4 + \frac{1351}{400}t^2 - \frac{121}{64}$$
     has non-real roots $\pm 1 \pm 0.5i$ and real roots $\pm 1.1$, while $\min_{t \in \mathbb{R}} L[f_6](t) \approx +2.266687 > 0$.
   - The degree-6 polynomial $P(x) = (x^2 - 9)(x^2 - 1/4)(x^2 + 4)$ has non-real roots $\pm 2i$ yet $L[P](x) \ge 625.5 > 0$ everywhere on $\mathbb{R}$.

2. **Transcendental Genus-1 Counterexample and Companion Hermite-Biehler Failure**:
   In `explore_merger_r2_L01_N06`, consider the transcendental genus-1 even function:
   $$g(t) = \cos(t)(t^2 + 4).$$
   Its zeros include non-real roots $t = \pm 2i$. Its first Laguerre-Turán invariant satisfies:
   $$T(g)(t) = (t^2 + 4)^2 + 2(t^2 - 4)\cos(2t) - 4t\sin(2t) \ge 8 > 0 \quad \text{for all } t \in \mathbb{R}.$$
   Moreover, the associated de Branges companion function $E_g(z) = g(z) - i g'(z)$ has a zero in the upper half-plane at $z \approx +1.544418i \in \mathbb{C}^+$, refuting the conjecture that phase monotonicity $\phi'(t) = T(g)(t)/|E_g(t)|^2 > 0$ on $\mathbb{R}$ forces $E \in \mathcal{HB}$.

## Evidence
- Exact symbolic evaluation via SymPy and Sturm sequence real root isolation for $f(t)$ and $P(x)$.
- For $g(t) = \cos(t)(t^2+4)$, certified lower bound $T(g)(t) \ge 8 > 0$ on $\mathbb{R}$, while companion root isolation confirmed $E_g(1.544418i) = 0$.

## Implications
Establishing that $L[\Xi](t) = (\Xi'(t))^2 - \Xi(t)\Xi''(t) > 0$ along the critical line (or that the transverse curvature $\partial_{dd} \log |\xi(1/2+d+it)| > 0$, or that de Branges phase derivative $\phi'(t) > 0$) provides only a necessary condition for the Riemann Hypothesis, not a sufficient one. Any reduction claiming $\forall t \in \mathbb{R}, L[\Xi](t) > 0 \implies \text{RH}$ is based on a false converse to Laguerre's theorem. Full real-rootedness requires the entire infinite hierarchy of higher Laguerre invariants $L_k[f] \ge 0$ ($k \ge 0$) or the hyperbolicity of all Jensen polynomials across all degrees $d \ge 1$.

## Caveats
For polynomials of degree $\le 3$, $L_1[f] \ge 0$ is sufficient for real-rootedness. But for degree $\ge 4$ and transcendental entire functions of order 1 (like $\Xi$), higher-order invariants are indispensable. Counterexamples exist in both polynomial and transcendental genus-1 classes.
