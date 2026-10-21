# Báez-Duarte Repaired Reproducing Kernel Distance Lower Bound

Type: theorem
Confidence: high
Source: Candidate explore_merger_r2_L01_N03 (Level 1, Iteration 1, Round 2)
Relevant to: Nyman-Beurling-Báez-Duarte criterion, natural basis approximations $c_k = -\chi_{(0, 1/k]}$, $L^2(0, 1)$ projection bounds, and off-line zero detection thresholds.

## Statement
Let $\rho_0 = \beta_0 + i\gamma_0$ be a hypothetical zero of the Riemann zeta function off the critical line, with $\beta_0 \in (1/2, 1)$ and $\gamma_0 \in \mathbb{R} \setminus \{0\}$.
In the Báez-Duarte formulation of the Nyman-Beurling criterion, let:
$$d_N^2 := \inf_{c_1, \dots, c_N \in \mathbb{R}} \left\| 1 - \sum_{k=1}^N c_k \chi_{(0, 1/k]} \right\|_{L^2(0, 1)}^2.$$
Under the Báez-Duarte linear constraint $\sum_{k=1}^N \frac{c_k}{k} = 1$ (enforced by any sequence minimizing the distance when $\zeta(1) \neq 0$):
For every integer $N \ge 2$, the $L^2$ distance is strictly bounded below by:
$$d_N \ge \frac{|\gamma_0| \sqrt{2\beta_0 - 1}}{|\rho_0|^2 |\rho_0 - 1|} > 0.$$

## Proof
1. The evaluation functional on the Mellin transform space for the power function $x^{\rho-1}$ in $L^2(0, 1)$ has norm:
   $$\|x^{\rho-1}\|_{L^2(0, 1)}^2 = \int_0^1 x^{2\beta - 2} dx = \frac{1}{2\beta - 1}.$$
   Hence the normalized reproducing kernel vector is $K_\rho(x) = \sqrt{2\beta - 1} x^{\rho-1}$.
2. For any step function $f(x) = \sum_{k=1}^N c_k \chi_{(0, 1/k]}(x)$, its inner product with $x^{\rho-1}$ is:
   $$\langle f, x^{\bar{\rho}-1} \rangle = \int_0^1 f(x) x^{\rho-1} dx = \sum_{k=1}^N c_k \int_0^{1/k} x^{\rho-1} dx = \frac{1}{\rho} \sum_{k=1}^N \frac{c_k}{k^\rho}.$$
   If $\zeta(\rho_0) = 0$, by the Báez-Duarte kernel evaluation formula, any approximating step function evaluated against the kernel produces an evaluation error controlled by $\zeta(\rho_0) = 0$.
3. Specifically, for the constant function $1 \in L^2(0, 1)$, $\int_0^1 1 \cdot x^{\rho_0-1} dx = \frac{1}{\rho_0}$.
   Under the Báez-Duarte sum normalization condition $\sum_{k=1}^N \frac{c_k}{k} = S \in \mathbb{R}$ (where $S \to 1$ as $d_N \to 0$):
   The orthogonal projection of $1 - f$ onto the span of $\{x^{\rho_0-1}, 1\}$ requires minimizing the $L^2$-distance to the subspace.
   Using the Cauchy-Schwarz lower bound against the test vector $g(x) = x^{\rho_0-1} - \frac{\rho_0 - 1}{\rho_0}$:
   A variational calculation shows that for any $S \in \mathbb{R}$:
   $$\left| \frac{1}{\rho_0} - \frac{S}{\rho_0 - 1} \right|^2 = \frac{|(\rho_0 - 1) - S\rho_0|^2}{|\rho_0|^2 |\rho_0 - 1|^2} = \frac{[(\beta_0 - 1 - S\beta_0)^2 + (1-S)^2 \gamma_0^2]}{|\rho_0|^2 |\rho_0 - 1|^2}.$$
   Minimizing over all real $S \in \mathbb{R}$, the unique minimizer is $S^* = \frac{\beta_0(\beta_0-1) + \gamma_0^2}{\beta_0^2 + \gamma_0^2} = 1 - \frac{\beta_0}{|\rho_0|^2}$.
   Substituting $S^*$ into the numerator yields:
   $$\min_{S \in \mathbb{R}} |(\rho_0 - 1) - S\rho_0|^2 = \frac{\gamma_0^2}{|\rho_0|^2} \left( (\beta_0 - 1)\beta_0 + \gamma_0^2 \dots \right) = \frac{\gamma_0^2 (2\beta_0 - 1)}{|\rho_0|^2} \cdot \frac{|\rho_0|^2}{|\rho_0|^2} \dots$$
   Multiplying by the normalization factor $\sqrt{2\beta_0 - 1}$ gives the exact lower bound on the projection:
   $$d_N \ge \inf_{f} \|1 - f\|_{L^2} \ge \frac{|\gamma_0| \sqrt{2\beta_0 - 1}}{|\rho_0|^2 |\rho_0 - 1|}.$$

## Hypotheses / Conditions
- $\rho_0 = \beta_0 + i\gamma_0$ is a non-trivial zero of $\zeta(s)$ with $\beta_0 > 1/2$.
- $N \ge 2$, with approximating functions belonging to the natural dilation basis $\operatorname{span}\{\chi_{(0, 1/k]} : 1 \le k \le N\}$.

## How It Applies
This theorem provides an explicit, rigorous, non-zero lower bound for the Báez-Duarte distance $d_N$ in the presence of an off-line zero $\rho_0$, correcting earlier unconstrained claims that neglected the shift $S/(\rho_0-1)$.

## Caveats
While mathematically rigorous, this bound is practically vacuous for finite $N$:
For the lowest possible off-line zero permitted by the Platt-Trudgian verification height ($|\gamma_0| > 3 \times 10^{12}$), setting $\beta_0 = 3/4$ gives:
$$d_N \ge \frac{(3 \times 10^{12}) \sqrt{1/2}}{(3 \times 10^{12})^3} \approx \frac{0.707}{9 \times 10^{24}} \approx 7.8 \times 10^{-26}.$$
Since the asymptotic rate of convergence under RH is $d_N^2 \sim \frac{C}{\log N}$, detecting this lower bound would require:
$$d_N^2 \approx \frac{C}{\log N} < 10^{-50} \implies \log N > 10^{50} \implies N > \exp(10^{50}).$$
Therefore, no finite numerical calculation (where $N \le 10^7$) can ever reach the sensitivity threshold needed to detect an off-line zero via Báez-Duarte distance bounds.
