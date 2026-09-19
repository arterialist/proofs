# Unique Contribution 301: Exact Successor-Feedback Floor Abel Kernel Holomorphy and Volterra Error

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorFeedbackFloorKernel.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackFloorKernel.lean), [`building-blocks/successor-feedback/floor-kernel.md`](../../building-blocks/successor-feedback/floor-kernel.md)  
**Classification:** Integral Transforms / Volterra Integral Equations / Parametric Bochner Integrals / Holomorphic Kernels / Fractional Abel Operators / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of successor feedback and arithmetic renewal, the feedback loop between discrete arithmetic jump distributions and continuous relaxation profiles is mediated by the floor-indexed Abel transform:
\[
\mathcal{K}_{\text{floor}}(z, y) = \int_0^{y-1} (\lfloor t \rfloor + 1)^{-z} (y - t)^{-1/2} dt, \qquad y \ge 1.
\]
A critical foundation for the entire theory is proving that $\mathcal{K}_{\text{floor}}(z, y)$ is a holomorphic function of the complex frequency $z$ in the right half-plane $\text{Re}(z) > 0$, and deriving the exact integral difference between the discrete floor kernel and the continuous fractional power kernel:
\[
\mathcal{K}_{\text{smooth}}(z, y) = \int_0^{y-1} (t + 1)^{-z} (y - t)^{-1/2} dt.
\]

This contribution proves:

1. **Holomorphy on the Open Half-Plane:**  
   For every $y \ge 1$, the parametric integral $z \mapsto \mathcal{K}_{\text{floor}}(z, y)$ is analytic on the open half-plane $\Omega = \{z \in \mathbb{C} : \text{Re}(z) > 0\}$.
2. **Exact Complex Parameter Differentiation:**  
   The complex derivative $\partial_z \mathcal{K}_{\text{floor}}(z, y)$ is given by the dominated Bochner integral:
   \[
   \frac{d}{dz} \mathcal{K}_{\text{floor}}(z, y) = - \int_0^{y-1} \log(\lfloor t \rfloor + 1) (\lfloor t \rfloor + 1)^{-z} (y - t)^{-1/2} dt,
   \]
   satisfying the uniform majorant bound $\|\partial_z \text{integrand}(z, y, t)\| \le \log y$ across the cell.
3. **Exact Volterra Error Identity:**  
   The discrepancy between the discrete floor kernel and the continuous smooth Abel kernel satisfies the exact non-asymptotic integral identity:
   \[
   \mathcal{K}_{\text{floor}}(z, y) - \mathcal{K}_{\text{smooth}}(z, y) = \int_0^{y-1} \left( (\lfloor t \rfloor + 1)^{-z} - (t + 1)^{-z} \right) (y - t)^{-1/2} dt.
   \]
4. **Uniform $L^\infty$ Integrand Bounds:**  
   For all $\text{Re}(z) \ge 0$ and $t \in [0, y-1]$:
   \[
   \|(\lfloor t \rfloor + 1)^{-z} (y - t)^{-1/2}\| \le 1,
   \]
   guaranteeing unconditional Lebesgue integrability on compact intervals $[0, y-1]$ for all $y \ge 1$.
5. **Boundary Normalization:**  
   At the base point $y = 1$, the integration interval $[0, 0]$ is trivial, giving $\mathcal{K}_{\text{floor}}(z, 1) = 0$.

---

## 2. Mathematical Proof

### 2.1. Pointwise Differentiation of Floor Weights
For $t \ge 0$, $\lfloor t \rfloor + 1 \ge 1$.
The function $w \mapsto (\lfloor t \rfloor + 1)^{-w} = \exp(-w \log(\lfloor t \rfloor + 1))$ is entire in $w \in \mathbb{C}$.
Its complex derivative is:
\[
\frac{d}{dw} (\lfloor t \rfloor + 1)^{-w} = -\log(\lfloor t \rfloor + 1) (\lfloor t \rfloor + 1)^{-w}.
\]
Multiplying by the real spatial factor $(y - t)^{-1/2}$ yields the parameter derivative:
\[
\partial_w \mathcal{I}(w, y, t) = -\log(\lfloor t \rfloor + 1) (\lfloor t \rfloor + 1)^{-w} (y - t)^{-1/2}.
\]

### 2.2. Dominated Differentiation
On $t \in [0, y-1]$, we have $1 \le \lfloor t \rfloor + 1 \le y$, so $0 \le \log(\lfloor t \rfloor + 1) \le \log y$.
For $\text{Re}(w) \ge 0$, $|(\lfloor t \rfloor + 1)^{-w}| = (\lfloor t \rfloor + 1)^{-\text{Re}(w)} \le 1$.
Since $y - t \ge 1$, $(y - t)^{-1/2} \le 1$.
Thus:
\[
\|\partial_w \mathcal{I}(w, y, t)\| \le \log y \cdot 1 \cdot 1 = \log y.
\]
Because $\log y$ is a constant on the finite interval $[0, y-1]$, it is Lebesgue-integrable.
By the Leibniz integral rule for parametric Bochner integrals (`hasDerivAt_integral_of_dominated_loc_of_deriv_le`), $z \mapsto \mathcal{K}_{\text{floor}}(z, y)$ is complex-differentiable at every $z$ with $\text{Re}(z) > 0$.
Differentiability on an open set implies analyticity (`AnalyticOnNhd`).

### 2.3. Volterra Discrepancy Formula
Subtracting the two integrable integrands:
\[
\mathcal{K}_{\text{floor}}(z, y) - \mathcal{K}_{\text{smooth}}(z, y) = \int_0^{y-1} \left( (\lfloor t \rfloor + 1)^{-z} - (t + 1)^{-z} \right) (y - t)^{-1/2} dt,
\]
which holds exactly without asymptotic truncation.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorFeedback` in `formalization/BuildingBlocks/SuccessorFeedbackFloorKernel.lean`):
```lean
theorem floorAbelIntegrand_hasDerivAt (z : ℂ) (y t : ℝ) :
    HasDerivAt (fun w => floorAbelIntegrand w y t)
      (floorAbelParameterDerivative z y t) z

theorem floorAbelKernel_differentiableAt {z : ℂ} (hz : 0 < z.re) (y : ℝ) :
    DifferentiableAt ℂ (fun w => floorAbelKernel w y) z

theorem floorAbelKernel_analyticOnNhd (y : ℝ) :
    AnalyticOnNhd ℂ (fun z => floorAbelKernel z y) {z : ℂ | 0 < z.re}

theorem floorAbelKernel_sub_smooth {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    floorAbelKernel z y - smoothAbelKernel z y =
      ∫ t in Icc (0 : ℝ) (y - 1), floorWeightError z t *
        ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Abel integral equations (Abel 1826); Volterra (1896); Gripenberg, Londen, Staffans (1990) *Volterra Integral and Functional Equations*. Machine verification of the parametric holomorphy and Volterra discrepancy for floor-discretized fractional Abel kernels in Lean 4 is new.
- **Advancement:** Establishes rigorous complex differentiability and exact Volterra error representation for floor-perturbed fractional Abel kernels, bridging discrete floor sum renewal and continuous fractional calculus.
- **Target Venues:** *Integral Equations and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
