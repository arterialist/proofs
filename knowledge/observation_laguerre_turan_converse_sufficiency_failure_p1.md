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
   - Degree 6 counterexample defeating both $L_0$ and $L_2$:
     $$f_6(t) = ((t-1)^2 + 1/4)((t+1)^2 + 1/4)(t^2 - 1.21) = t^6 - \frac{271}{100}t^4 + \frac{1351}{400}t^2 - \frac{121}{64}$$
     has non-real roots $\pm 1 \pm 0.5i$ and real roots $\pm 1.1$, while exact symbolic evaluation confirms:
     $$\min_{t \in \mathbb{R}} L_0[f_6](t) \approx +2.266687 > 0, \qquad \min_{t \in \mathbb{R}} L_2[f_6](t) \approx +228.612419 > 0,$$
     where $L_2[f](t) := (f'''(t))^2 - f''(t)f^{(4)}(t)$ is the second Laguerre differential invariant. Both $L_0$ and $L_2$ remain strictly positive everywhere on $\mathbb{R}$ despite the 4 non-real roots.
   - Higher Hankel-Turan counterexample defeating $H_1$ and $H_2$:
     The polynomial $f(t) = t^6 + t^4 + t^2 + 1$ has 6 non-real roots ($\pm i, \pm \sqrt{2}/2 \pm i\sqrt{2}/2$), yet its Hankel-Turan determinants satisfy:
     $$H_1[f](0) = 2 > 0, \qquad H_2[f](0) = 40 > 0,$$
     where $H_m[f](t) := \det[f^{(j+k)}(t)]_{j,k=0}^m$.
    - Degree 6 counterexample defeating $L_0, L_1, L_2, L_3$ (Explorer r3 Node 08):
      $$P(t) = (t^2+9)(t^2-1)(t^2-4) = t^6 + 4t^4 - 41t^2 + 36$$
      has non-real roots $\pm 3i$ and real roots $\pm 1, \pm 2$. Invariants are all strictly positive everywhere on $\mathbb{R}$:
      $$L_0[P](0) = 2952, \quad L_1[P](0) = 6724, \quad L_2[P](0) = 7872, \quad L_3[P](0) = 9216,$$
      with $\min_{t \in \mathbb{R}} L_2[P](t) = 7872 > 0$, demonstrating that $L_2$ is blind to off-line roots whenever the vertical scale $M > \sqrt{12}$.
    - Degree 6 counterexample defeating $L_0, L_1, L_2, L_3$ (Explorer r3 Node 15):
      $$P(t) = (t^2 - 1)(t^2 - 2)(t^2 + 10) = t^6 + 7t^4 - 28t^2 + 20$$
      has non-real roots $\pm i\sqrt{10}$ and real roots $\pm 1, \pm\sqrt{2}$. All first four Laguerre invariants are globally positive on $\mathbb{R}$:
      $$\min L_0 \approx 360.57 > 0, \quad \min L_1 = 3136 > 0, \quad \min L_2 = 9408 > 0, \quad \min L_3 = 28224 > 0.$$
    - Transcendental counterexample defeating $L_2$ (Explorer r3 Node 08):
      $$h(t) = \cos(t)(t^2 + 16)$$
      has non-real roots $\pm 4i$, yet $\min_{t \in \mathbb{R}} L_2[h](t) \ge 56.0 > 0$.
    - Degree-2 Taylor moment truncation discriminant failure (Explorer r3 Node 12):
      For the Taylor coefficients of $\Xi_*(1/4 - w)$, $c_0 \approx 0.248560, c_1 \approx 0.001436, c_2 \approx 0.00000386$. The second-order Turán minor is positive ($c_1^2 - c_0 c_2 = +1.102 \times 10^{-6} > 0$), but the true polynomial discriminant is strictly negative ($\Delta = c_1^2 - 4c_0 c_2 = -1.776 \times 10^{-6} < 0$), giving complex conjugate roots $w \approx -186 \pm 173i \in \mathbb{C}^\mp$.
    - The degree-6 polynomial $P(x) = (x^2 - 9)(x^2 - 1/4)(x^2 + 4)$ has non-real roots $\pm 2i$ yet $L[P](x) \ge 625.5 > 0$ everywhere on $\mathbb{R}$.
    - Degree-4 counterexample defeating ALL higher Turán differential inequalities $T_k(f)(t) \ge 0$ for all $k \ge 1$ (Explorer r3 Node 16):
      $$f(t) = (t - 2)\left(t + \frac{7}{4}\right)\left(\left(t + \frac{19}{10}\right)^2 + \left(\frac{3}{5}\right)^2\right) = t^4 + \frac{71}{20}t^3 - \frac{12}{25}t^2 - \frac{5717}{400}t - \frac{2779}{200}$$
      has non-real roots $-1.9 \pm 0.6i$, yet satisfies $T_k(f)(t) := (f^{(k)}(t))^2 - f^{(k-1)}(t)f^{(k+1)}(t) \ge 0$ for ALL $k \ge 1$ globally on $\mathbb{R}$:
      $$\min_{t \in \mathbb{R}} T_1(f)(t) \approx 1.39 > 0, \quad \min_{t \in \mathbb{R}} T_2(f)(t) \approx 190.68 > 0, \quad T_3(f) \approx 249.88 > 0, \quad T_4(f) \equiv 576 > 0, \quad T_{\ge 5} \equiv 0.$$
      This disproves the conjecture that global non-negativity of all higher Turán operators $T_k(f) \ge 0$ ($k \ge 1$) forces $f \in \mathcal{LP}$.
    - Degree-6 and Degree-8 counterexamples defeating higher Laguerre invariants up to $L_5$ (Explorer r3 Node 28):
      The polynomial $P_6(t) = (t^2-1)(t^2-4)(t^2+25)$ has non-real roots $\pm 5i$, yet its higher Laguerre invariants at the origin are strictly positive:
      $$L_0[P_6](0) = 24200 > 0, \quad L_1[P_6](0) = 58564 > 0, \quad L_2[P_6](0) = 116160 > 0, \quad L_3[P_6](0) = 230400 > 0.$$
      Even more decisively, the degree-8 polynomial $P_8(t) = (t^2-1)(t^2-4)(t^2-9)(t^2+100)$ has non-real roots $\pm 10i$, yet satisfies:
      $$L_0(0) > 0, \quad L_1(0) > 0, \quad L_2(0) > 0, \quad L_3(0) > 0, \quad L_4(0) > 0, \quad L_5(0) > 0$$
      all strictly positive, refuting the claim that testing $L_2(0) < 0$ or any small finite number of Laguerre invariants can detect non-real roots or verify $\Xi \in \mathcal{LP}$.

2. **Transcendental Genus-1 Counterexample and Companion Hermite-Biehler Failure**:
   In `explore_merger_r2_L01_N06`, consider the transcendental genus-1 even function:
   $$g(t) = \cos(t)(t^2 + 4).$$
   Its zeros include non-real roots $t = \pm 2i$. Its first Laguerre-Turán invariant satisfies:
   $$T(g)(t) = (t^2 + 4)^2 + 2(t^2 - 4)\cos(2t) - 4t\sin(2t) \ge 8 > 0 \quad \text{for all } t \in \mathbb{R}.$$
   Moreover, the associated de Branges companion function $E_g(z) = g(z) - i g'(z)$ has a zero in the upper half-plane at $z \approx +1.544418i \in \mathbb{C}^+$, refuting the conjecture that phase monotonicity $\phi'(t) = T(g)(t)/|E_g(t)|^2 > 0$ on $\mathbb{R}$ forces $E \in \mathcal{HB}$.

## Evidence
- Exact symbolic evaluation via SymPy and Sturm sequence real root isolation for $f(t)$, $f_6(t)$, and $P(x)$.
- Symbolically confirmed $\min L_0[f_6] \approx 2.2667 > 0$ and $\min L_2[f_6] \approx 228.6124 > 0$ for $f_6$.
- Symbolic evaluation of $H_1(0) = 2$ and $H_2(0) = 40$ on $t^6+t^4+t^2+1$.
- For $g(t) = \cos(t)(t^2+4)$, certified lower bound $T(g)(t) \ge 8 > 0$ on $\mathbb{R}$, while companion root isolation confirmed $E_g(1.544418i) = 0$.

## Implications
Establishing that $L_0[\Xi](t) > 0$ along the critical line (or ascending to $L_2[\Xi] \ge 0$ or $H_2[\Xi] \ge 0$) provides only a necessary condition for the Riemann Hypothesis, not a sufficient one. Any reduction claiming that evaluating finitely many Laguerre or Hankel invariants implies RH is based on a false converse to Laguerre's theorem. Full real-rootedness requires the entire infinite hierarchy of higher Laguerre invariants $L_k[f] \ge 0$ for ALL $k \ge 0$ or the hyperbolicity of all Jensen polynomials across all degrees $d \ge 1$.

## Caveats
For polynomials of degree $\le 3$, $L_1[f] \ge 0$ is sufficient for real-rootedness. But for degree $\ge 4$ and transcendental entire functions of order 1 (like $\Xi$), checking finitely many higher invariants ($L_0, L_1, L_2$ or $H_1, H_2$) cannot guarantee real-rootedness.
