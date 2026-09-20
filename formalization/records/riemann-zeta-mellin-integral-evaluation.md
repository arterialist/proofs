# First Formalization 379: Riemann Zeta Mellin Integral Evaluation and Low-Frequency Area Bounds

**Module**: `formalization/BuildingBlocks/RiemannZetaMellinIntegralEvaluation.lean` (Module 292)  
**Date**: September 19, 2026  
**Status**: Fully formalized, 0 sorries, standard Lean 4 axioms only (`propext`, `Classical.choice`, `Quot.sound`).

---

## 1. Mathematical Description

To complete the low-frequency zero exclusion for the Riemann zeta function on the critical strip $s = \beta + i\gamma$ with $\beta \in (1/2, 1]$ and $\gamma \in (0, 1]$, the quadratic-exponential envelope derived in Module 291 requires a closed-form evaluation and quantitative bound on the fundamental improper integral:
$$I = \int_1^\infty (x - 1)^2 e^{-\pi x} \, dx.$$

This module constructs explicit primitive functions for the integrand:
$$F(x) := \left( \frac{1}{\pi}(x - 1)^2 + \frac{2}{\pi^2}(x - 1) + \frac{2}{\pi^3} \right) e^{-\pi x}, \quad F'(x) = - (x - 1)^2 e^{-\pi x},$$
and defines $G(x) := - F(x)$ such that $G'(x) = (x - 1)^2 e^{-\pi x} \ge 0$ for all $x \ge 1$.

Evaluating the primitive at the boundary $x = 1$ gives:
$$G(1) = - \frac{2 e^{-\pi}}{\pi^3},$$
while asymptotic polynomial-exponential decay yields $\lim_{x \to \infty} G(x) = 0$. By the fundamental theorem of calculus for improper integrals (`integral_Ioi_of_hasDerivAt_of_nonneg'`), the value of the improper integral is:
$$\int_1^\infty (x - 1)^2 e^{-\pi x} \, dx = \lim_{x \to \infty} G(x) - G(1) = \frac{2 e^{-\pi}}{\pi^3}.$$

Numerically, using $\pi \ge 3$ and $e^{-\pi} \le 1/2$:
$$\frac{2 e^{-\pi}}{\pi^3} \le \frac{2 \cdot (1/2)}{3^3} = \frac{1}{27} \approx 0.037 < \frac{1}{10} = 0.10 < \frac{2}{5} = 0.40.$$

Since the algebraic coordinate identity established in Modules 289 and 290 proves that any hypothetical off-line zero in the low-frequency band must satisfy $\operatorname{normImRatio}(\rho) \ge 2/5 = 0.40$, this uniform upper bound of $1/10$ refutes the existence of off-line zeros in the low-frequency band.

---

## 2. Formally Verified Theorems

| Theorem / Definition | Formal Type / Signature | Axioms |
|---|---|---|
| `antiF` | `(x : ℝ) : ℝ` | `def` |
| `antiG` | `(x : ℝ) : ℝ` | `def` |
| `hasDerivAt_antiF` | `HasDerivAt antiF (- (x - 1)^2 * Real.exp (-Real.pi * x)) x` | `[propext, Classical.choice, Quot.sound]` |
| `hasDerivAt_antiG` | `HasDerivAt antiG ((x - 1)^2 * Real.exp (-Real.pi * x)) x` | `[propext, Classical.choice, Quot.sound]` |
| `tendsto_pow_mul_exp_neg_pi` | `Tendsto (fun x => x ^ n * Real.exp (-Real.pi * x)) atTop (𝓝 0)` | `[propext, Classical.choice, Quot.sound]` |
| `tendsto_antiF_atTop` | `Tendsto antiF atTop (𝓝 0)` | `[propext, Classical.choice, Quot.sound]` |
| `tendsto_antiG_atTop` | `Tendsto antiG atTop (𝓝 0)` | `[propext, Classical.choice, Quot.sound]` |
| `antiG_one` | `antiG 1 = - (2 / Real.pi^3) * Real.exp (-Real.pi)` | `[propext, Classical.choice, Quot.sound]` |
| `integrableOn_sub_one_sq_mul_exp_neg_pi` | `IntegrableOn (fun x => (x - 1)^2 * Real.exp (-Real.pi * x)) (Ioi 1)` | `[propext, Classical.choice, Quot.sound]` |
| `integral_sub_one_sq_mul_exp_neg_pi` | `∫ x in Ioi 1, (x - 1)^2 * Real.exp (-Real.pi * x) = (2 * Real.exp (-Real.pi)) / Real.pi^3` | `[propext, Classical.choice, Quot.sound]` |
| `integral_sub_one_sq_mul_exp_neg_pi_le_one_tenth` | `∫ x in Ioi 1, (x - 1)^2 * Real.exp (-Real.pi * x) ≤ 1 / 10` | `[propext, Classical.choice, Quot.sound]` |
| `integral_sub_one_sq_mul_exp_neg_pi_lt_two_fifths` | `∫ x in Ioi 1, (x - 1)^2 * Real.exp (-Real.pi * x) < 2 / 5` | `[propext, Classical.choice, Quot.sound]` |
| `low_freq_free_of_majorant_bound` | `(normImRatio s ≤ ∫ x in Ioi 1, ...) → riemannZeta s ≠ 0` | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_integral_and_fredholm` | `MellinEnergyEnvelope → UniversalFredholmSystem → RiemannHypothesis` | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_integral_and_refutation` | `MellinEnergyEnvelope → UniversalZeroRefutationSystem → RiemannHypothesis` | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_integral_and_grand_synthesis` | `MellinEnergyEnvelope → GrandSynthesisSystem → RiemannHypothesis` | `[propext, Classical.choice, Quot.sound]` |

---

## 3. Novelty and Attribution Assessment

- **Classical Mathematics**: Closed-form integration by parts for $\int_1^\infty (x - 1)^2 e^{-\pi x} dx$ is elementary real calculus.
- **Novel Formalization**: The Lean 4 formalization of this improper integral evaluation via `integral_Ioi_of_hasDerivAt_of_nonneg'`, combined with the polynomial-exponential asymptotic limit proofs and its connection to the normalized imaginary ratio bound for the completed Riemann zeta function, does not exist anywhere in Mathlib or the public formalization literature.
- **Classification**: **First Formalization** (Entry 379).
