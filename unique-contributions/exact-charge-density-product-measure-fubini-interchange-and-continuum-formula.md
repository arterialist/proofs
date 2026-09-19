# Unique Contribution 215: Exact Charge Density Product Measure Fubini Interchange and Continuum Formula

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeDensityFubini.lean`](../../formalization/BuildingBlocks/ChargeDensityFubini.lean), [`building-blocks/charge/charge-density-fubini.md`](../../building-blocks/charge/charge-density-fubini.md)  
**Classification:** Measure Theory / Product Measures / Fubini-Tonelli Theorems / Renewal Defect Operators / Prime Density Scattering / Singular Integrals

---

## 1. Executive Summary and Mathematical Statement

In the dual Dirichlet formulation of the prime counting defect, evaluating the continuous density source $(e^v - 1)e^{-v/2}$ against the memory kernel $K(v)$ requires interchanging the temporal defect integral with the spatial continuum parameter $y \in (1, \infty)$. Although the underlying spatial source $e^v - 1$ is not in $L^1$, the coupled two-variable kernel $K(v) \mathbf{1}_{\{y \le e^v\}} e^{-v/2}$ admits an integrable majorant on the product space $(0, \infty) \times (1, \infty)$, allowing rigorous Fubini interchange.

This contribution proves:

1. **Exact Fiber Spatial Integral:**  
   For all $v \ge 0$, with $\beta(y, v) = \mathbf{1}_{\{y \le e^v\}} e^{-v/2}$:
   \[
   \int_1^\infty \beta(y, v) \, dy = (e^v - 1) e^{-v/2}.
   \]
2. **Product Measure Absolute Integrability:**  
   The joint product function $(v, y) \mapsto K(v) \beta(y, v)$ is globally integrable under the restricted product measure $\text{volume}|_{(0, \infty)} \otimes \text{volume}|_{(1, \infty)}$:
   \[
   \int_0^\infty \int_1^\infty |K(v)| \beta(y, v) \, dy \, dv \le \int_0^\infty 2 e^{-v/2} \, dv = 4 < \infty.
   \]
3. **Exact Defect Fubini Interchange:**  
   The memory defect operator $\text{defect}(F) = \frac{1}{2}\int_0^\infty K(v) F(v) dv$ commutes with the spatial integral:
   \[
   \text{defect}\left( v \mapsto \int_1^\infty \beta(y, v) \, dy \right) = \int_1^\infty \text{defect}(v \mapsto \beta(y, v)) \, dy.
   \]
4. **Continuum Charge Representation Formula:**  
   Evaluating the continuous background density yields the exact identity:
   \[
   \text{defect}\left( v \mapsto (e^v - 1) e^{-v/2} \right) = \int_1^\infty \text{defect}(v \mapsto \beta(y, v)) \, dy.
   \]

---

## 2. Mathematical Proof

### 2.1. Spatial Integration
For $v \ge 0$, $e^v \ge 1$. The indicator $\mathbf{1}_{\{y \le e^v\}}$ restricts the integration interval $(1, \infty)$ to $(1, e^v]$.
Since the integrand is the constant $e^{-v/2}$:
\[
\int_1^\infty \beta(y, v) \, dy = e^{-v/2} \int_1^{e^v} 1 \, dy = e^{-v/2} (e^v - 1).
\]

### 2.2. Joint Integrability on the Product Space
By Fubini-Tonelli for non-negative functions, the double integral equals:
\[
\int_0^\infty |K(v)| (e^v - 1) e^{-v/2} \, dv.
\]
Using the exponential kernel bound $|K(v)| \le 2 e^{-v}$ and $e^v - 1 \le e^v$:
\[
|K(v)| (e^v - 1) e^{-v/2} \le (2 e^{-v}) (e^v) e^{-v/2} = 2 e^{-v/2}.
\]
Since $\int_0^\infty 2 e^{-v/2} dv = 4 < \infty$, the joint function is integrable on $(0, \infty) \times (1, \infty)$.

### 2.3. Defect Interchange
By Fubini's theorem (`integral_integral_swap`), the order of integration can be exchanged:
\[
\int_0^\infty K(v) \left( \int_1^\infty \beta(y, v) dy \right) dv = \int_1^\infty \left( \int_0^\infty K(v) \beta(y, v) dv \right) dy.
\]
Multiplying by the normalization factor $1/2$ proves the defect interchange identity and the continuum formula.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeDensityFubini` in `formalization/BuildingBlocks/ChargeDensityFubini.lean`):
```lean
theorem betaReal_integral {v : ℝ} (hv : 0 ≤ v) :
    (∫ y in Ioi (1 : ℝ), betaReal y v) = (Real.exp v - 1) * Real.exp (-v / 2)

theorem original_density_joint_integrable :
    Integrable kernelBirth ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (1 : ℝ))))

theorem original_density_charge_interchange :
    defect (fun v => ∫ y in Ioi (1 : ℝ), betaReal y v) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v)

theorem original_density_charge_formula :
    defect (fun v => (Real.exp v - 1) * Real.exp (-v / 2)) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Product measure integration and Fubini-Tonelli theorems in non-integrable singular renewal equations (Feller 1971, Gripenberg-Londen-Staffans 1990). Machine formalization of Fubini operator interchange for exponentially growing spatial densities in Lean 4 is new.
- **Advancement:** Establishes the exact product measure integrability and Fubini interchange for the continuous prime background density without requiring artificial spatial compactification.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Real Analysis Exchange*.
