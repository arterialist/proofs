# Double-Pole Persistence Under Finite-Order Riesz Smoothing

Type: theorem
Confidence: high
Source: Candidates 00, 01, 04, 05, 06, Falsers 00, 01, 04, 05, 06 (Level 1)
Relevant to: Ruling out Riesz and Cesàro smoothing as a bypass for the critical sign criterion.

## Statement
Let $\mathcal{M}_W(s) = \frac{\zeta(s+1/2)}{s(s+1)}(G(s)^2 - H(s))$ be the Mellin transform of the critical observable $W(x)$.
For any integer $k \ge 0$, define the $k$-th order Riesz smoothed arithmetic observable:
$$W_k(x) := \frac{1}{k!} \int_1^x \left(\log\frac{x}{y}\right)^k W(y) y^{-3} \, dy, \qquad (x \ge 1).$$
Then:
1. The Mellin transform of $W_k(x)$ on $\Re s > 0$ is:
   $$\mathcal{M}_{W_k}(s) := \int_1^x W_k(x) x^{-s-2} \, dx = \frac{\mathcal{M}_W(s+1)}{s^{k+1}}.$$
2. For any non-trivial zero $\rho = \beta + i\gamma$ of $\zeta(s)$ with $\beta > 1/2$ and multiplicity $m \ge 1$, $\mathcal{M}_{W_k}(s)$ possesses an isolated double pole at the shifted point $s = \rho - 1$ with leading Laurent coefficient:
   $$\lim_{s \to \rho - 1} (s - (\rho - 1))^2 \mathcal{M}_{W_k}(s) = \frac{m^2 \zeta(\rho + 1/2)}{(\rho - 1)^{k+1} \rho (\rho + 1)} \ne 0.$$
3. Consequently, if RH is false, $W_k(x)$ undergoes unbounded two-sided power oscillations:
   $$\limsup_{x \to \infty} \frac{W_k(x)}{x^{k+1+\beta}} > 0, \qquad \liminf_{x \to \infty} \frac{W_k(x)}{x^{k+1+\beta}} < 0.$$
   In particular, eventual nonpositivity of $W_k(x)$ is strictly equivalent in analytical depth to the full Riemann Hypothesis for every finite order $k \ge 0$.

## Proof
1. By Fubini's theorem and the classical identity $\int_y^\infty \frac{1}{k!}(\log(x/y))^k x^{-s-2} dx = y^{-s-1} (s+1)^{-(k+1)}$ for $\Re s > -1$:
   $$\int_1^\infty W_k(x) x^{-s-2} \, dx = \int_1^\infty W(y) y^{-3} \left[ \int_y^\infty \frac{1}{k!}\left(\log\frac{x}{y}\right)^k x^{-s-2} dx \right] dy = \frac{1}{(s+1)^{k+1}} \int_1^\infty W(y) y^{-(s+1)-2} dy.$$
   Under the change of variable $w = s+1$, this evaluates to $s^{-(k+1)} \mathcal{M}_W(s+1)$ for $\Re s > 0$.
2. In a punctured neighborhood of $s = \rho - 1$, write $w = s+1$ near $\rho$. Since $\mathcal{M}_W(w) = \frac{m^2 \zeta(\rho+1/2)}{\rho(\rho+1)} (w-\rho)^{-2} + O(|w-\rho|^{-1})$, substituting $w = s+1$ gives:
   $$\mathcal{M}_{W_k}(s) = s^{-(k+1)} \left[ \frac{m^2 \zeta(\rho+1/2)}{\rho(\rho+1)} (s - (\rho-1))^{-2} + O(|s-(\rho-1)|^{-1}) \right].$$
   Evaluating the rational multiplier $s^{-(k+1)}$ at $s = \rho - 1$: since $\gamma = \Im \rho \ne 0$, $\rho - 1 = (\beta - 1) + i\gamma \ne 0$. Thus $(\rho - 1)^{-(k+1)} \ne 0$ is finite and non-zero.
   Multiplying yields the non-zero leading Laurent coefficient:
   $$\lim_{s \to \rho - 1} (s - (\rho - 1))^2 \mathcal{M}_{W_k}(s) = \frac{m^2 \zeta(\rho + 1/2)}{(\rho - 1)^{k+1} \rho (\rho + 1)} \ne 0.$$
3. By Landau's theorem on Laplace-Mellin transforms of positive measures, if $W_k(x) \le 0$ for all $x > A$, the transform must be holomorphic on $\Re s > \beta - 1$. But the point $s = \rho - 1$ has $\Re(\rho - 1) = \beta - 1$, where $\mathcal{M}_{W_k}(s)$ possesses an uncancelable double pole. Contradiction.
   Landau's oscillation theorem then dictates two-sided power oscillations of amplitude $x^{k+1+\beta}$, which strictly dominates the $k$-fold integrated drift $x^{k+3/2} (\log x)^{k+2}$ because $k+1+\beta > k+3/2$ for all $\beta > 1/2$.

## Hypotheses / Conditions
- $\rho = \beta + i\gamma$ is a zero of $\zeta(s)$ with $\beta > 1/2$ and multiplicity $m \ge 1$.
- Smoothing order $k$ is any non-negative integer ($k \in \mathbb{N}$).
- $\Im \rho = \gamma \ne 0$, which holds for all nontrivial zeta zeros.

## How It Applies
This theorem definitively refutes all proposals to circumvent the circularity of Frontier 1 by applying Riesz, Cesàro, or logarithmic smoothing to $W(x)$. Because polynomial smoothing preserves the pole order and non-vanishing residue, smoothed sign criteria remain strictly equivalent to the Riemann Hypothesis.

## Caveats
Applies to finite-order polynomial/logarithmic smoothing kernels. Infinite-order exponential cutoffs (e.g. $e^{-t^2}$) eliminate poles by introducing essential singularities, but destroy the positive-measure representation required by Landau's theorem.
