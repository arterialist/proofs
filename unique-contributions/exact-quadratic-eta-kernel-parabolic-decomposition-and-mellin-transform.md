# Unique Contribution 167: Exact Quadratic Eta-Kernel Parabolic Decomposition and Mellin Transform

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/EtaRieszKernel.lean`](../../formalization/BuildingBlocks/EtaRieszKernel.lean), [`building-blocks/mellin/eta-riesz-kernel.md`](../../building-blocks/mellin/eta-riesz-kernel.md)  
**Classification:** Harmonic Analysis / Integral Transforms / Mellin Transforms / Quadratic Kernels / Parabolic Decomposition / Riesz Tent Means

---

## 1. Executive Summary and Mathematical Statement

In the spectral formulation of arithmetic correlation functions, the convolution of a localized Dirac birth atom at $a > 0$ with the background measure $\delta_1 + dt$ produces the truncated quadratic kernel $K_\eta(a, x) = \frac{x^2 - a^2}{2a} \mathbf{1}_{x > a}$.

This contribution proves:

1. **Exact Parabolic Decomposition into Riesz Tent plus Quadratic Surplus:**  
   For all birth locations $a > 0$ and all $x \in \mathbb{R}$:
   \[
   K_\eta(a, x) = \text{tent}_a(x) + \frac{(\max(x - a, 0))^2}{2a},
   \]
   where $\text{tent}_a(x) = \max(x - a, 0)$ is the standard Riesz linear mean kernel.
2. **Exact Power Integrability and Algebraic Factorization:**  
   On $(a, \infty)$, the Mellin integrand factors algebraically as:
   \[
   \frac{x^2 - a^2}{2a} x^{-s-2} = \frac{1}{2a} \left( x^{-s} - a^2 x^{-s-2} \right).
   \]
   For $\text{Re}(s) > 1$, both powers $x^{-s}$ and $x^{-s-2}$ are strictly integrable on $(a, \infty)$.
3. **Exact Closed-Form Eta-Kernel Mellin Transform:**  
   For any $a > 0$ and $\text{Re}(s) > 1$, the continuous Mellin transform of $K_\eta(a, \cdot)$ evaluates in closed form to:
   \[
   \mathcal{M}(K_\eta(a, \cdot))(-s-1) = \int_a^\infty x^{-s-2} \frac{x^2 - a^2}{2a} dx = \frac{a^{-s}}{(s-1)(s+1)}.
   \]
4. **Exact $L^1$ Absolute Norm Evaluation:**  
   The $L^1$ norm of the complex Mellin integrand over $(0, \infty)$ satisfies the exact real identity:
   \[
   \int_0^\infty \| x^{-s-2} K_\eta(a, x) \| dx = \frac{a^{-\text{Re}(s)}}{(\text{Re}(s) - 1)(\text{Re}(s) + 1)}.
   \]

---

## 2. Mathematical Proof

### 2.1. Parabolic Decomposition
For $x \le a$, both sides vanish identically.
For $x > a$:
\[
\text{tent}_a(x) + \frac{(x - a)^2}{2a} = (x - a) + \frac{x^2 - 2ax + a^2}{2a} = \frac{2ax - 2a^2 + x^2 - 2ax + a^2}{2a} = \frac{x^2 - a^2}{2a} = K_\eta(a, x).
\]
This proves that the quadratic eta kernel is strictly the sum of the linear Riesz tent and the parabolic excess $\frac{(x-a)^2}{2a}$.

### 2.2. Mellin Transform Evaluation
Using the power factorization on $(a, \infty)$:
\[
\int_a^\infty x^{-s-2} K_\eta(a, x) dx = \frac{1}{2a} \left( \int_a^\infty x^{-s} dx - a^2 \int_a^\infty x^{-s-2} dx \right).
\]
Since $\text{Re}(s) > 1$, $\text{Re}(-s) < -1$ and $\text{Re}(-s-2) < -3 < -1$:
\[
\int_a^\infty x^{-s} dx = -\frac{a^{-s+1}}{-s+1} = \frac{a \cdot a^{-s}}{s - 1},
\]
\[
\int_a^\infty x^{-s-2} dx = -\frac{a^{-s-1}}{-s-1} = \frac{a^{-1} \cdot a^{-s}}{s + 1}.
\]
Substituting these values:
\[
\frac{1}{2a} \left[ \frac{a \cdot a^{-s}}{s-1} - a^2 \frac{a^{-1} \cdot a^{-s}}{s+1} \right] = \frac{a^{-s}}{2} \left[ \frac{1}{s-1} - \frac{1}{s+1} \right] = \frac{a^{-s}}{2} \frac{(s+1) - (s-1)}{(s-1)(s+1)} = \frac{a^{-s}}{(s-1)(s+1)}.
\]

### 2.3. $L^1$ Absolute Norm Evaluation
Since $K_\eta(a, x) \ge 0$ everywhere on $(0, \infty)$ and $\|x^{-s-2}\| = x^{-\text{Re}(s)-2}$, the norm of the integrand is:
\[
\| x^{-s-2} K_\eta(a, x) \| = x^{-\text{Re}(s)-2} K_\eta(a, x).
\]
This is identical to the Mellin integrand evaluated at the real number $\text{Re}(s) > 1$, yielding:
\[
\frac{a^{-\text{Re}(s)}}{(\text{Re}(s) - 1)(\text{Re}(s) + 1)}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.EtaRieszKernel` in `formalization/BuildingBlocks/EtaRieszKernel.lean`):
```lean
theorem kernel_eq_zero {a x : ℝ} (hx : x ≤ a) : kernel a x = 0

theorem kernel_eq_tent_add_square {a : ℝ} (ha : 0 < a) (x : ℝ) :
    kernel a x = RieszTentMellin.tent a x +
      (((max (x - a) 0) ^ 2 / (2 * a) : ℝ) : ℂ)

theorem kernel_power_eq {x : ℝ} (hx : 0 < x) (a : ℝ) (s : ℂ) :
    (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2) =
      (1 / (2 * (a : ℂ))) *
        ((x : ℂ) ^ (-s) - (a : ℂ) ^ 2 * (x : ℂ) ^ (-s - 2))

theorem integral_kernel_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi a, (((x ^ 2 - a ^ 2) / (2 * a) : ℝ) : ℂ) *
      (x : ℂ) ^ (-s - 2)) = (a : ℂ) ^ (-s) / ((s - 1) * (s + 1))

theorem hasMellin_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    HasMellin (kernel a) (-s - 1) ((a : ℂ) ^ (-s) / ((s - 1) * (s + 1)))

theorem integral_norm_kernel {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * kernel a x‖) =
      a ^ (-s.re) / ((s.re - 1) * (s.re + 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Riesz typical means and parabolic kernels (Hardy-Riesz 1915, Chandrasekharan-Minakshisundaram 1952). The exact decomposition connecting Riesz linear tents and quadratic birth kernels has not previously been formalized in proof assistants.
- **Advancement:** Establishes the exact parabolic decomposition $K_\eta = \text{tent} + \frac{(\cdot)_+^2}{2a}$ and its Mellin transform $\frac{a^{-s}}{(s-1)(s+1)}$ with machine-checked $L^1$ norm integrability in Lean 4.
- **Target Venues:** *Integral Transforms and Special Functions* or *Bulletin of the London Mathematical Society*.
