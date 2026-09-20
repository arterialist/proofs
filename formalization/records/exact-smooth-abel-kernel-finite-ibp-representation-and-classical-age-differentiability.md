# Contribution 205: Exact Smooth Abel Kernel Finite-IBP Representation and Classical Age Differentiability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorFeedbackSmoothAgeDerivative.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackSmoothAgeDerivative.lean), [`building-blocks/successor/successor-feedback-smooth-age-derivative.md`](../../building-blocks/successor/successor-feedback-smooth-age-derivative.md)  
**Classification:** Fractional Calculus / Abel Integral Transforms / Integration by Parts / Boundary Calculus / Singular Volterra Kernels / Analytic Number Theory

---

## 1. Executive Summary and Mathematical Statement

Standard derivations of the smooth Abel kernel's regularized representation rely on Euler Beta function evaluations and meromorphic continuation across the pole at $z=1$. In constructive formal analysis of successor feedback flows, it is critical to obtain this regularized representation on finite compact intervals $[0, y-1]$ using only the fundamental theorem of calculus and integration by parts, retaining all boundary endpoints without circular appeals to special function continuations.

This contribution proves:

1. **Exact Age Differentiability of Smooth Power and Root Weight:**  
   For any $\text{Re}(z) > 0$ and $t \ge 0$:
   $$
   \frac{d}{dt} (t+1)^{-z} = -z (t+1)^{-(z+1)} = -\text{smoothPowerCharge}(z, t),
   $$
   and for $t \le y - 1$:
   $$
   \frac{d}{dt} \left( 2(\sqrt{y - t} - 1) \right) = -\frac{1}{\sqrt{y - t}}.
   $$
2. **Exact Finite-Interval IBP Representation:**  
   For all complex frequencies with $\text{Re}(z) > 0$ and all $y \ge 1$:
   $$
   K_z^{\text{smooth}}(y) = R(y) - \int_0^{y-1} \text{smoothPowerCharge}(z, t) \cdot 2(\sqrt{y - t} - 1) dt.
   $$
   Here $R(y) = 2(\sqrt{y} - 1)$ is the causal root primitive. At the upper limit $t = y - 1$, the factor $2(\sqrt{y - (y-1)} - 1) = 2(1 - 1) = 0$ vanishes identically, completely eliminating upper boundary divergence!
3. **Classical Age Differentiability:**  
   For all $y > 1$, the smooth Abel kernel is classically differentiable with derivative given by the smooth root derivative:
   $$
   \frac{d}{dy} K_z^{\text{smooth}}(y) = \text{smoothRootDerivative}(z, y).
   $$

---

## 2. Mathematical Proof

### 2.1. Integration by Parts on $[0, y-1]$
Let $u(t) = (t+1)^{-z}$ and $v(t) = 2(\sqrt{y - t} - 1)$.
Their classical derivatives are $u'(t) = -\text{smoothPowerCharge}(z, t)$ and $v'(t) = -(y - t)^{-1/2}$.
Applying integration by parts on $[0, y-1]$:
$$
\int_0^{y-1} u'(t) v(t) dt + \int_0^{y-1} u(t) v'(t) dt = [u(t) v(t)]_0^{y-1}.
$$
Evaluating the boundary terms:
- At the upper limit $t = y - 1$: $v(y - 1) = 2(\sqrt{1} - 1) = 0$, so $u(y-1) v(y-1) = 0$.
- At the lower limit $t = 0$: $u(0) = 1^{-z} = 1$, and $v(0) = 2(\sqrt{y} - 1) = R(y)$.
Therefore:
$$
[u(t) v(t)]_0^{y-1} = 0 - 1 \cdot R(y) = -R(y).
$$

### 2.2. Integral Identification
The integral $\int_0^{y-1} u(t) (-v'(t)) dt$ is precisely the smooth Abel kernel:
$$
\int_0^{y-1} (t+1)^{-z} (y - t)^{-1/2} dt = K_z^{\text{smooth}}(y).
$$
The remaining term is:
$$
-\int_0^{y-1} \text{smoothPowerCharge}(z, t) \cdot 2(\sqrt{y - t} - 1) dt = - (R * \text{smoothPowerCharge}(z))(y).
$$
Rearranging yields:
$$
K_z^{\text{smooth}}(y) = R(y) - (R * \text{smoothPowerCharge}(z))(y).
$$

### 2.3. Differentiability
Differentiating both terms with respect to $y > 1$ using `causalRootPrimitive_hasDerivAt` and `rootPrimitiveConvolution_hasDerivAt` immediately gives the classical derivative `smoothRootDerivative(z, y)`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorFeedback` in `formalization/BuildingBlocks/SuccessorFeedbackSmoothAgeDerivative.lean`):
```lean
theorem rootPrimitiveConvolution_eq_finite (f : ℝ → ℂ) (y : ℝ) :
    rootPrimitiveConvolution f y = ∫ t in Ioc (0 : ℝ) (y - 1),
      f t * ((2 * (sqrt (y - t) - 1) : ℝ) : ℂ)

theorem smoothAbelKernel_eq_rootPrimitive {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    smoothAbelKernel z y = (causalRootPrimitive y : ℂ) -
      rootPrimitiveConvolution (smoothPowerCharge z) y

theorem smoothAbelKernel_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y) :
    HasDerivAt (smoothAbelKernel z) (smoothRootDerivative z y) y
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Euler Beta integral identities for fractional Abel transforms (Erdélyi 1954, Samko-Kilbas-Marichev 1993). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Formalizes the finite-interval IBP identity $K_z^{\text{smooth}} = R(y) - R * \text{smoothPowerCharge}(z)$ and machine-verifies classical differentiability on $(1, \infty)$ in Lean 4.
- **Target Venues:** *Fractional Calculus and Applied Analysis* or *Integral Equations and Operator Theory*.
