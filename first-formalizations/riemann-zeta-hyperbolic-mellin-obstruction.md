# First Formalization 376: Riemann Zeta Hyperbolic Mellin Obstruction and Normalized Ratio Bounds

## 1. Mathematical Summary

This module formalizes the exact differential, variational, and algebraic obstruction equations governing the imaginary part of the completed Riemann zeta function $\Lambda_0(s)$ at any hypothetical off-line zero $\rho = \beta + i\gamma$ in the open upper quadrant:
$$\beta \in (1/2, 1], \quad \gamma > 0.$$

### A. Symmetrized Hyperbolic Amplitudes and AM-GM Invariance
For any $x > 0$ and any $\beta \in \mathbb{R}$, the product of the dual power factors is invariant:
$$x^{\beta/2 - 1} \cdot x^{(1-\beta)/2 - 1} = x^{-3/2}.$$
Applying the AM-GM inequality $2\sqrt{uv} \le u + v$ yields the universal lower bound:
$$2 x^{-3/4} \le x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}.$$
On the critical strip $x \ge 1, \beta \in [1/2, 1]$, each exponent satisfies $\beta/2 - 1 \le 0$ and $(1-\beta)/2 - 1 \le 0$, yielding the sharp uniform upper bound:
$$x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1} \le 2.$$

### B. Exact Fréchet Differentiation of the Hyperbolic Amplitude
The hyperbolic difference amplitude:
$$\operatorname{powerDiff}(\beta, x) = x^{\beta/2 - 1} - x^{(1-\beta)/2 - 1}$$
is Fréchet differentiable with respect to $\beta$ at every $\beta \in \mathbb{R}$, with derivative:
$$\frac{\partial}{\partial \beta}\operatorname{powerDiff}(\beta, x) = \left(x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}\right) \frac{\log x}{2}.$$
Consequently, on $x \ge 1$ and $\beta \in [1/2, 1]$, the gradient is trapped between non-trivial powers of $x$:
$$x^{-3/4}\log x \le \frac{\partial}{\partial \beta}\operatorname{powerDiff}(\beta, x) \le \log x.$$

### C. Normalized Imaginary Ratio at Off-Line Zeros
Define the scale-free normalized imaginary ratio:
$$\operatorname{normImRatio}(s) := \frac{\operatorname{Im}(\Lambda_0(s))}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)}.$$
At any off-line zero $\rho = \beta + i\gamma$, the algebraic inversion $\Lambda_0(\rho) = -1 / (\rho(\rho - 1))$ established in Module 286 yields:
$$\operatorname{Im}(\Lambda_0(\rho)) = \frac{(2\beta - 1)\gamma}{|\rho(\rho - 1)|^2},$$
which collapses the normalized imaginary ratio to the pure reciprocal squared norm:
$$\operatorname{normImRatio}(\rho) = \frac{1}{|\rho(\rho - 1)|^2}.$$

### D. Coordinate Inversion Squeeze Bounds
Because $\beta \in [1/2, 1]$, the denominator $|\rho(\rho - 1)|^2 = (\beta^2 + \gamma^2)((\beta - 1)^2 + \gamma^2)$ is tightly bounded:
$$(1/4 + \gamma^2)\gamma^2 \le |\rho(\rho - 1)|^2 \le (1 + \gamma^2)(1/4 + \gamma^2).$$
Inverting these bounds traps $\operatorname{normImRatio}(\rho)$ in a two-sided coordinate squeeze:
$$\frac{1}{(1 + \gamma^2)(1/4 + \gamma^2)} \le \operatorname{normImRatio}(\rho) \le \frac{1}{(1/4 + \gamma^2)\gamma^2}.$$
In particular:
1. **Low frequencies** ($\gamma \le 1$):
   $$\operatorname{normImRatio}(\rho) \ge \frac{1}{2 \times (5/4)} = \frac{2}{5} = 0.4.$$
2. **High frequencies** ($\gamma \ge 1$):
   $$\operatorname{normImRatio}(\rho) \le \frac{1}{\gamma^4}.$$

---

## 2. Formalization Details

- **File**: `formalization/BuildingBlocks/RiemannZetaHyperbolicMellinObstruction.lean`
- **Module**: `BuildingBlocks.RiemannZetaHyperbolicMellinObstruction`
- **Axioms**: `[propext, Classical.choice, Quot.sound]` (zero sorries, zero external axioms)
- **Key Theorems**:
  - `am_gm_two`: $2\sqrt{ab} \le a + b$ for non-negative reals.
  - `rpow_beta_mul_rpow_one_sub_beta`: $x^{\beta/2 - 1} \cdot x^{(1-\beta)/2 - 1} = x^{-3/2}$.
  - `sqrt_rpow_neg_three_halves`: $\sqrt{x^{-3/2}} = x^{-3/4}$.
  - `rpow_beta_add_rpow_one_sub_beta_ge`: $2 x^{-3/4} \le x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}$.
  - `rpow_beta_add_rpow_one_sub_beta_le`: $x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1} \le 2$ on $x \ge 1, \beta \in [1/2, 1]$.
  - `hasDerivAt_rpow_beta`: Fréchet derivative of $x^{\beta/2 - 1}$.
  - `hasDerivAt_rpow_one_sub_beta`: Fréchet derivative of $x^{(1-\beta)/2 - 1}$.
  - `hasDerivAt_powerDiff`: Fréchet derivative of $\operatorname{powerDiff}(\beta, x)$.
  - `deriv_powerDiff_nonneg`: $\frac{\partial}{\partial \beta}\operatorname{powerDiff} \ge 0$ on $x \ge 1$.
  - `deriv_powerDiff_ge`: $\frac{\partial}{\partial \beta}\operatorname{powerDiff} \ge x^{-3/4}\log x$ on $x \ge 1$.
  - `deriv_powerDiff_le`: $\frac{\partial}{\partial \beta}\operatorname{powerDiff} \le \log x$ on $x \ge 1, \beta \in [1/2, 1]$.
  - `normSq_mul_sub_one_ge_quarter_gamma_sq`: $|\rho(\rho - 1)|^2 \ge (1/4 + \gamma^2)\gamma^2$.
  - `normSq_mul_sub_one_le_coords`: $|\rho(\rho - 1)|^2 \le (1 + \gamma^2)(1/4 + \gamma^2)$.
  - `inv_normSq_mul_sub_one_le`: $1 / |\rho(\rho - 1)|^2 \le 1 / ((1/4 + \gamma^2)\gamma^2)$.
  - `inv_normSq_mul_sub_one_ge`: $1 / ((1 + \gamma^2)(1/4 + \gamma^2)) \le 1 / |\rho(\rho - 1)|^2$.
  - `normImRatio`: Definition of normalized imaginary ratio.
  - `normImRatio_eq_inv_normSq_of_zero`: Exact collapse to reciprocal squared norm at zeros.
  - `normImRatio_ge_of_zero`: Two-sided coordinate lower bound at zeros.
  - `normImRatio_le_of_zero`: Two-sided coordinate upper bound at zeros.
  - `normImRatio_ge_two_fifths_of_zero`: Strict lower bound $\ge 0.4$ for $\gamma \le 1$.
  - `normImRatio_le_four_power_of_zero`: Quartic decay bound $\le 1/\gamma^4$ for $\gamma \ge 1$.
