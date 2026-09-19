# Unique Contribution 204: Exact Floor Abel Kernel Age Derivative and Singular Boundary Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean), [`building-blocks/successor/successor-feedback-floor-age-derivative.md`](../../building-blocks/successor/successor-feedback-floor-age-derivative.md)  
**Classification:** Analytic Number Theory / Fractional Calculus / Abel Integral Equations / Singular Volterra Kernels / Distributional Derivatives / Dirichlet Series Kernels

---

## 1. Executive Summary and Mathematical Statement

In the analytic continuation and spectral analysis of Dirichlet series and successor renewal equations, the Abel fractional kernel involves the singular weight $(y - t)^{-1/2}$. Differentiating such kernels with respect to the age coordinate $y$ typically produces hypersingular boundary integrands $(y - t)^{-3/2}$ which diverge at the moving upper endpoint $t = y - 1$. Handling this requires decomposing the kernel error into an integrable moving primitive and a clipped singular convolution without discarding boundary distributions or integer jump singularities.

This contribution proves:

1. **Continuity of Weight Error Away From Integer Corners:**  
   For any complex frequency $z$ with $\text{Re}(z) > 0$, the floor weight error $E_z(t) = \lfloor t \rfloor^{-z} - (t+1)^{-z}$ is continuous at every non-integer point $t \ge 0$, $t \notin \mathbb{N}$.
2. **Exact Moving Primitive and Clipped Kernel Decomposition:**  
   For all $y \ge 1$:
   \[
   K_z^{\text{floor}}(y) - K_z^{\text{smooth}}(y) = \int_0^{y-1} E_z(t) dt + \int_0^{y-1} E_z(t) \left( (y - t)^{-1/2} - 1 \right) dt.
   \]
3. **Leibniz Differentiation of the Moving Upper Endpoint:**  
   For all non-integer offsets $y - 1 \notin \mathbb{N}$:
   \[
   \frac{d}{dy} \int_0^{y-1} E_z(t) dt = E_z(y - 1).
   \]
4. **Exact Classical Age Derivative Formula:**  
   Away from integer grid points, the Abel fractional error admits the exact classical derivative:
   \[
   \frac{d}{dy} \left( K_z^{\text{floor}}(y) - K_z^{\text{smooth}}(y) \right) = E_z(y - 1) - \frac{1}{2} \int_0^{y-1} E_z(t) (y - t)^{-3/2} dt.
   \]
   The moving boundary contributes the exact leading term $E_z(y - 1)$, and the regularized singular integral contributes with the exact factor $-1/2$.
5. **Lebesgue Almost-Everywhere Differentiability:**  
   The derivative formula holds almost everywhere on $(1, \infty)$ with respect to Lebesgue measure.

---

## 2. Mathematical Proof

### 2.1. Continuity and Integral Partition
For $t \notin \mathbb{N}$, $\lfloor u \rfloor = \lfloor t \rfloor$ in a neighborhood of $t$, making $\lfloor u \rfloor^{-z}$ locally constant. The smooth term $(u+1)^{-z}$ is analytic on $u > -1$. Thus $E_z(t)$ is continuous.
Splitting the Abel kernel factor:
\[
(y - t)^{-1/2} = 1 + ((y - t)^{-1/2} - 1).
\]
Integrating against $E_z(t)$ over $(0, y-1)$ yields the exact sum of the primitive $\int_0^{y-1} E_z(t) dt$ and the clipped convolution $\int_0^{y-1} E_z(t) ((y - t)^{-1/2} - 1) dt$.

### 2.2. Differentiation of Clipped Convolution and Moving Boundary
By the fundamental theorem of calculus for moving upper limits, $\frac{d}{dy} \int_0^{y-1} E_z(t) dt = E_z(y - 1)$ because $E_z$ is continuous at $y - 1$.
By `floorError_clippedConvolution_hasDerivAt`, the clipped convolution has derivative $-\frac{1}{2} \int_0^{y-1} E_z(t) (y - t)^{-3/2} dt$.
Adding the two derivatives yields:
\[
\frac{d}{dy} (K_z^{\text{floor}} - K_z^{\text{smooth}})(y) = E_z(y - 1) - \frac{1}{2} \int_0^{y-1} E_z(t) (y - t)^{-3/2} dt.
\]

### 2.3. Null Measure of Integer Grid
The exceptional set $\{y \in (1, \infty) : y - 1 \in \mathbb{N}\}$ is countable, hence of Lebesgue measure zero. Thus the derivative identity holds almost everywhere on $(1, \infty)$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorFeedback` in `formalization/BuildingBlocks/SuccessorFeedbackFloorAgeDerivative.lean`):
```lean
theorem floorWeightError_continuousAt {t : ℝ} (ht : 0 ≤ t)
    (hnt : ∀ n : ℕ, t ≠ n) (z : ℂ) : ContinuousAt (floorWeightError z) t

theorem floorError_intervalIntegrable {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    IntervalIntegrable (floorWeightError z) volume 0 (y - 1)

theorem floorAbelError_eq_primitive_add_clipped {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    floorAbelKernel z y - smoothAbelKernel z y =
      floorErrorPrimitive z y + clippedConvolution (floorWeightError z) y

theorem floorErrorPrimitive_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (floorErrorPrimitive z) (floorWeightError z (y - 1)) y

theorem floorAbelError_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
      (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
        ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
          ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y

theorem floorAbelError_hasDerivAt_ae {z : ℂ} (hz : 0 < z.re) :
    ∀ᵐ y : ℝ ∂volume.restrict (Ioi 1),
      HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
        (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
          ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
            ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Differentiation of Abel and weakly singular Volterra integral equations (Gorenflo-Vessella 1991, Samko-Kilbas-Marichev 1993, Brunner 2004). Machine formalization of exact age differentiation decomposing boundary terms and regularized singular integrals in Lean 4 is new.
- **Advancement:** Establishes the exact decomposition $E_z(y-1) - \frac{1}{2} \int_0^{y-1} E_z(t) (y-t)^{-3/2} dt$ and machine-verifies almost-everywhere differentiability on $(1, \infty)$ in Lean 4.
- **Target Venues:** *Fractional Calculus and Applied Analysis* or *Journal of Integral Equations and Applications*.
