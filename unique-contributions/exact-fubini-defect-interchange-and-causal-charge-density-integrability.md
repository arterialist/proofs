# Unique Contribution 246: Exact Fubini Defect Interchange and Causal Charge Density Integrability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeDensityFubini.lean`](../../formalization/BuildingBlocks/ChargeDensityFubini.lean), [`building-blocks/charge/charge-density-fubini.md`](../../building-blocks/charge/charge-density-fubini.md)  
**Classification:** Measure Theory / Operator Defect Theory / Fubini-Tonelli Theorems / Renewal Equations / Causal Operators / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

The total operator defect of the continuum charge density measures the failure of the continuous prime successor operator $\mathcal{T}$ to be unitary. When the source is represented as a continuous integral of step-like atom birth densities $\beta_{\mathbb{R}}(y, v) = \mathbf{1}_{y \le e^v} e^{-v/2}$, proving that the defect of the total continuum charge equals the integral of the atom defects requires justifying the interchange of the non-compact renewal integral with the infinite-dimensional defect functional:
\[
\text{defect}(f) = \frac{1}{2} \int_0^\infty \text{kernel}(v) f(v) \, dv.
\]
Because neither the raw birth density nor the continuum source is individually in $L^1(0, \infty)$, standard Lebesgue dominated convergence theorems fail, requiring a two-dimensional product measure integrability proof.

This contribution proves:

1. **Exact 1D Fiber Integral:**  
   For any coordinate $v \ge 0$, integrating the step density $\beta_{\mathbb{R}}(y, v) = \mathbf{1}_{y \le e^v} e^{-v/2}$ over $y \in (1, \infty)$ yields the continuum charge profile:
   \[
   \int_1^\infty \beta_{\mathbb{R}}(y, v) \, dy = (e^v - 1) e^{-v/2}.
   \]
2. **Grand Product Integrability of Renewal-Birth Kernel:**  
   The two-dimensional product kernel $(v, y) \mapsto \text{kernel}(v) \beta_{\mathbb{R}}(y, v)$ is unconditionally absolutely integrable on the product measure space:
   \[
   \text{kernelBirth} \in L^1\left( (0, \infty) \times (1, \infty), \text{Lebesgue}^{\otimes 2} \right).
   \]
   The proof establishes that the exponential decay of the renewal kernel $|\text{kernel}(v)| \le 2 e^{-v}$ strictly dominates the linear exponential growth of the spatial integral $(e^v - 1) e^{-v/2} \le e^{v/2}$, producing a net integrable bound $2 e^{-v/2}$.
3. **Grand Fubini Defect Interchange Theorem:**  
   The non-compact operator defect interchanges exactly with the continuous spatial integral:
   \[
   \text{defect}\left( v \mapsto \int_1^\infty \beta_{\mathbb{R}}(y, v) \, dy \right) = \int_1^\infty \text{defect}(v \mapsto \beta_{\mathbb{R}}(y, v)) \, dy.
   \]
4. **Exact Continuum Defect Evaluation:**  
   Evaluates the defect of the physical continuum profile:
   \[
   \text{defect}\left( v \mapsto (e^v - 1) e^{-v/2} \right) = \int_1^\infty \text{defect}(v \mapsto \beta_{\mathbb{R}}(y, v)) \, dy.
   \]

---

## 2. Mathematical Proof

### 2.1. Fiber Integral
For $v \ge 0$, $e^v \ge 1$. The indicator $\mathbf{1}_{y \le e^v}$ on $(1, \infty)$ has support $[1, e^v]$ of measure $e^v - 1$.
Hence $\int_1^\infty \beta_{\mathbb{R}}(y, v) dy = (e^v - 1) e^{-v/2}$.

### 2.2. Joint Integrability on Product Domain
Let $f(v, y) = \text{kernel}(v) \beta_{\mathbb{R}}(y, v)$.
Measurability follows from the indicator of the closed hypograph $\{p \in \mathbb{R}^2 \mid p_2 \le e^{p_1}\}$.
Integrating the fiber norm:
\[
\int_1^\infty |f(v, y)| \, dy = |\text{kernel}(v)| (e^v - 1) e^{-v/2}.
\]
Using the renewal kernel bound $|\text{kernel}(v)| \le 2 e^{-v}$ and $e^v - 1 \le e^v$:
\[
\int_1^\infty |f(v, y)| \, dy \le (2 e^{-v}) (e^v e^{-v/2}) = 2 e^{-v/2}.
\]
Since $v \mapsto 2 e^{-v/2}$ is in $L^1(0, \infty)$, Tonelli's theorem implies $f \in L^1((0, \infty) \times (1, \infty))$.

### 2.3. Fubini Defect Interchange
By Fubini's theorem (`integral_integral_swap`):
\[
\int_0^\infty \int_1^\infty \text{kernel}(v) \beta_{\mathbb{R}}(y, v) \, dy \, dv = \int_1^\infty \int_0^\infty \text{kernel}(v) \beta_{\mathbb{R}}(y, v) \, dv \, dy.
\]
Multiplying both sides by the scalar factor $1/2$ and applying the definition of the operator defect functional yields the claim.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeDensityFubini` in `formalization/BuildingBlocks/ChargeDensityFubini.lean`):
```lean
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

- **Prior Literature:** Product measure integration and Fubini-Tonelli interchange in infinite-dimensional operator theory (Dunford-Schwartz 1958, Reed-Simon 1980). A machine-checked proof justifying Fubini interchange for non-$L^1$ boundary distributions against exponentially decaying renewal kernels in Lean 4 is new.
- **Advancement:** Establishes the exact identity between the collective continuum charge defect and the integrated discrete birth defects, eliminating any discrepancy between continuum and discrete models.
- **Target Venues:** *Journal of Functional Analysis* or *Integral Equations and Operator Theory*.
