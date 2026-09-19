# Riemann zeta low-frequency zero-freeness and conditional RH bridges

**Classification:** Lean theorem inventory; worldwide priority not established
**Entry Number:** 384  
**Date:** 19 September 2026  
**Primary Lean Module:** [`formalization/BuildingBlocks/RiemannZetaUnconditionalLowFrequency.lean`](../../formalization/BuildingBlocks/RiemannZetaUnconditionalLowFrequency.lean)  
**Foundational Axioms:** Strictly standard Lean 4 axioms `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, Zero `sorry` placeholders)

---

## 1. Executive Summary

This dossier documents a low-frequency zero-freeness theorem for the Riemann zeta function and several implications to Mathlib's `RiemannHypothesis`.

The low-frequency theorem has no Fredholm or carrier-system argument. The RH theorems do: `RiemannHypothesis_of_universal_fredholm`, `RiemannHypothesis_of_universal_refutation`, and `RiemannHypothesis_of_grand_synthesis` require, respectively, `UniversalFredholmSystem`, `UniversalZeroRefutationSystem`, and `GrandSynthesisSystem`. This module does not construct those records, so it does not prove RH without an RH-strength premise.

Building upon the modular Mellin inversion isomorphism established in Module 296, this module unconditionally discharges the last remaining integrability condition:
$$\int_1^\infty \frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \, dx < \infty$$
for every $s \in \mathbb{C}$ via continuous linear map projection (`Integrable.im`) and scalar algebra (`Integrable.div_const`).

Consequently, the entire open-height low-frequency critical strip:
$$\Omega_{\text{low}} = \{ s \in \mathbb{C} \mid 1/2 < \operatorname{Re}(s) \le 1, \, 0 < \operatorname{Im}(s) \le 1 \}$$
is proved to contain zero non-trivial roots of $\zeta(s)$:
$$\zeta(s) \ne 0 \quad \text{for all } s \in (1/2, 1] \times (0, 1],$$
unconditionally, from foundational Lean 4 axioms alone.

Combining this with the unconditional non-vanishing on the real axis $(1/2, \infty) \setminus \{1\}$ (Module 288), every potential off-line zero in the entire lower parameter space $(1/2, 1] \times [0, 1]$ is unconditionally refuted.

---

## 2. Mathematical Content

### 2.1 The Universal Ratio Integrability Theorem
In Module 296, the complex symmetrized kernel product:
$$x \mapsto \operatorname{cpowTrigKernel}(s, x) \cdot f_{\text{modif}}(x)$$
was proved to be unconditionally Bochner integrable on $(1, \infty)$ using Mathlib's `WeakFEPair.hasMellin`.

Because the imaginary projection:
$$\operatorname{Im} : \mathbb{C} \to \mathbb{R}$$
is a continuous linear map, Mathlib's `Integrable.im` theorem establishes:
$$\operatorname{IntegrableOn} \left( x \mapsto \operatorname{mellinTrigIntegrandIm}(s, x), \, (1, \infty) \right).$$

Dividing by the coordinate scalar $c = (2\operatorname{Re}(s) - 1)\operatorname{Im}(s)$ (which is positive and non-zero for all $s \in \Omega_{\text{low}}$) corresponds to scalar multiplication by $c^{-1} \in \mathbb{R}$. Applying `Integrable.div_const`, the normalized ratio integrand:
$$x \mapsto \frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)}$$
is unconditionally Bochner integrable on $(1, \infty)$ for all $s \in \mathbb{C}$.

### 2.2 Unconditional Low-Frequency Elimination
For any point $\rho = \beta + i\gamma \in \Omega_{\text{low}}$:
1. If $\zeta(\rho) = 0$, the completed zeta function vanishes: $\Lambda_0(\rho) = -1/(\rho(\rho-1))$, giving the geometric lower bound:
   $$\operatorname{normImRatio}(\rho) = \frac{1}{|\rho(\rho-1)|^2} \ge \frac{2}{5} = 0.40.$$
2. By modular Mellin inversion, the normalized ratio equals the integral:
   $$\operatorname{normImRatio}(\rho) = \frac{1}{2} \int_1^\infty \frac{\operatorname{mellinTrigIntegrandIm}(\rho, x)}{(2\beta - 1)\gamma} \, dx.$$
3. By the Mean Value Theorem on hyperbolic differences, the ratio integrand is pointwise majorized on $[1, \infty)$ by $(x - 1)^2 e^{-\pi x}$, yielding the analytic upper bound:
   $$\operatorname{normImRatio}(\rho) \le \frac{1}{2} \cdot \frac{2 e^{-\pi}}{\pi^3} \le \frac{1}{20} = 0.05.$$
4. Comparing lower and upper bounds gives the arithmetic contradiction:
   $$\frac{2}{5} \le \frac{1}{20} \iff 0.40 \le 0.05 \implies \text{False}.$$

Thus:
$$\zeta(s) \ne 0 \quad \text{for all } s \in (1/2, 1] \times (0, 1].$$

---

## 3. Machine-Verified Theorems

The following primary theorems are machine-checked in Lean 4.24.0 without `sorry` or non-standard axioms:

| Lean Theorem Name | Statement | Axioms |
| :--- | :--- | :--- |
| `integrableOn_mellinTrigIntegrandIm` | $\operatorname{IntegrableOn}(x \mapsto \operatorname{mellinTrigIntegrandIm}(s, x), (1, \infty))$ | `[propext, Classical.choice, Quot.sound]` |
| `integrableOn_mellin_ratio_integrand` | $\operatorname{IntegrableOn}(x \mapsto \operatorname{mellinTrigIntegrandIm}(s, x) / c, (1, \infty))$ | `[propext, Classical.choice, Quot.sound]` |
| `integrableOn_mellin_ratio_integrand_coords` | $\operatorname{IntegrableOn}(x \mapsto \operatorname{ratioIntegrand}(s, x), (1, \infty))$ | `[propext, Classical.choice, Quot.sound]` |
| `integrableOn_mellin_ratio_integrand_all` | $\forall s \in \Omega_{\text{low}}, \operatorname{IntegrableOn}(x \mapsto \operatorname{ratioIntegrand}(s, x), (1, \infty))$ | `[propext, Classical.choice, Quot.sound]` |
| `low_freq_free_unconditional` | $1/2 < \operatorname{Re}(s) \le 1 \land 0 < \operatorname{Im}(s) \le 1 \implies \zeta(s) \ne 0$ | `[propext, Classical.choice, Quot.sound]` |
| `low_freq_free_unconditional_all` | Universal quantification over all low-frequency candidate points | `[propext, Classical.choice, Quot.sound]` |
| `canonical_certificate_of_fredholm` | $\text{UniversalFredholmSystem} \implies \text{OffLineZeroRefutationCertificate}$ | `[propext, Classical.choice, Quot.sound]` |
| `canonical_certificate_of_refutation` | $\text{UniversalZeroRefutationSystem} \implies \text{OffLineZeroRefutationCertificate}$ | `[propext, Classical.choice, Quot.sound]` |
| `canonical_certificate_of_grand_synthesis` | $\text{GrandSynthesisSystem} \implies \text{OffLineZeroRefutationCertificate}$ | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_universal_fredholm` | $\text{UniversalFredholmSystem} \implies \text{RiemannHypothesis}$ | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_universal_refutation` | $\text{UniversalZeroRefutationSystem} \implies \text{RiemannHypothesis}$ | `[propext, Classical.choice, Quot.sound]` |
| `RiemannHypothesis_of_grand_synthesis` | $\text{GrandSynthesisSystem} \implies \text{RiemannHypothesis}$ | `[propext, Classical.choice, Quot.sound]` |

---

## 4. Literature Significance & Verification

- **Literature antecedent:** Modular theta representations and low-height zeta estimates are classical. The repository has not documented a reproducible worldwide search sufficient to establish priority for this exact Lean statement.
- **Dependency status:** The low-frequency theorem compiles from Mathlib and the imported repository modules. The separate RH implications still require the system values visible in their signatures.
