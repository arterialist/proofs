# Contribution 232: Exact Charge Density Defect and Background Growth Annihilation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeDensityEvaluation.lean`](../../formalization/BuildingBlocks/ChargeDensityEvaluation.lean), [`building-blocks/charge/charge-density-evaluation.md`](../../building-blocks/charge/charge-density-evaluation.md)  
**Classification:** Operator Theory / Dynamical Systems / Analytic Number Theory / Nonlinear Scale Invariants / Operator Defect / Geometric Renormalization

---

## 1. Executive Summary and Mathematical Statement

In the operator dynamics of arithmetic renewal, the successor operator acting on a half-density $f$ is given by:
$$
\mathcal{T}(f)(v) = \sqrt{\frac{e^v}{1 + e^v}} f(\log(1 + e^v)).
$$
The defect functional measures the discrepancy in total mass:
$$
\text{defect}(f) = \text{charge}(\mathcal{T}(f)) - \text{charge}(f) = \int_0^\infty \mathcal{K}(v) f(v) \, dv.
$$
This contribution proves:

1. **Exact Scale-Shift Commutation on Truncated Growth:**  
   For the truncated exponential growth profile $\text{cutoff}(R, v) = \mathbf{1}_{v \le \log R} e^{v/2}$, the successor operator implements an exact unit shift in the spatial scale parameter:
   $$
   \mathcal{T}(\text{cutoff}(R)) = \text{cutoff}(R - 1) \quad \text{for all } R \ge 2.
   $$
2. **Exact Truncated Mass and Defect Evaluation:**  
   The mass of the truncated profile evaluates to $\text{charge}(\text{cutoff}(R)) = 2(\sqrt{R} - 1)$, and the defect evaluates in closed form:
   $$
   \text{defect}(\text{cutoff}(R)) = \sqrt{R - 1} - \sqrt{R}.
   $$
3. **Annihilation of Background Exponential Growth:**  
   Via dominated convergence against the exponentially decaying kernel $\mathcal{K}(v) = O(e^{-v})$, the non-integrable growing mode $v \mapsto e^{v/2}$ has identically zero defect:
   $$
   \text{defect}(v \mapsto e^{v/2}) = \lim_{R \to \infty} (\sqrt{R - 1} - \sqrt{R}) = 0.
   $$
4. **Arithmetic Density Defect Formula:**
   For the natural arithmetic background density profile $v \mapsto (e^v - 1)e^{-v/2} = e^{v/2} - e^{-v/2}$, the defect evaluates exactly to:
   $$
   \text{defect}(v \mapsto (e^v - 1)e^{-v/2}) = 1 - \frac{\pi}{4}.
   $$
   This proves that the background density generates an exact geometric residual $1 - \pi/4 > 0$ under the nonlinear renewal dynamics.

---

## 2. Mathematical Proof

### 2.1. Successor Action on Cutoff
By definition:
$$
\mathcal{T}(\text{cutoff}(R))(v) = \sqrt{\frac{e^v}{1 + e^v}} \mathbf{1}_{\log(1 + e^v) \le \log R} \sqrt{1 + e^v} = e^{v/2} \mathbf{1}_{1 + e^v \le R}.
$$
Since $1 + e^v \le R \iff e^v \le R - 1 \iff v \le \log(R - 1)$, this equals:
$$
e^{v/2} \mathbf{1}_{v \le \log(R - 1)} = \text{cutoff}(R - 1, v).
$$

### 2.2. Cutoff Mass and Defect
Integrating $e^{v/2}$:
$$
\int_0^{\log R} e^{v/2} \, dv = \left[ 2 e^{v/2} \right]_0^{\log R} = 2(\sqrt{R} - 1).
$$
By the charge difference identity:
$$
\text{defect}(\text{cutoff}(R)) = \text{charge}(\text{cutoff}(R - 1)) - \text{charge}(\text{cutoff}(R)) = (\sqrt{R - 1} - 1) - (\sqrt{R} - 1) = \sqrt{R - 1} - \sqrt{R}.
$$

### 2.3. Vanishing Defect of the Growing Mode
Since $|\mathcal{K}(v)| \le 2e^{-v}$, the integrand $|\mathcal{K}(v) \text{cutoff}(R, v)| \le 2e^{-v/2} \in L^1((0, \infty))$.
By Lebesgue's Dominated Convergence Theorem:
$$
\text{defect}(v \mapsto e^{v/2}) = \lim_{R \to \infty} \text{defect}(\text{cutoff}(R)) = \lim_{R \to \infty} (\sqrt{R - 1} - \sqrt{R}) = \lim_{R \to \infty} \frac{-1}{\sqrt{R - 1} + \sqrt{R}} = 0.
$$

### 2.4. Decomposition of the Density
Writing $(e^v - 1)e^{-v/2} = e^{v/2} - e^{-v/2}$:
By linearity of the integral:
$$
\text{defect}((e^v - 1)e^{-v/2}) = \text{defect}(e^{v/2}) - \text{defect}(e^{-v/2}).
$$
We established $\text{defect}(e^{v/2}) = 0$.
In `ChargeOriginalBirth.original_defect_reference`, the reference decay mode $e^{-v/2}$ was proved to have defect:
$$
\text{defect}(e^{-v/2}) = \frac{\pi}{4} - 1.
$$
Therefore:
$$
\text{defect}((e^v - 1)e^{-v/2}) = 0 - \left(\frac{\pi}{4} - 1\right) = 1 - \frac{\pi}{4}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeDensityEvaluation` in `formalization/BuildingBlocks/ChargeDensityEvaluation.lean`):
```lean
theorem cutoff_mass {R : ℝ} (hR : 1 ≤ R) :
    (∫ v in Ioi (0 : ℝ), cutoff R v) = 2 * (Real.sqrt R - 1)

theorem successor_cutoff {R : ℝ} (hR : 2 ≤ R) :
    successor (cutoff R) = cutoff (R - 1)

theorem cutoff_defect {R : ℝ} (hR : 2 ≤ R) :
    defect (cutoff R) = Real.sqrt (R - 1) - Real.sqrt R

theorem original_defect_growth :
    defect (fun v : ℝ => Real.exp (v / 2)) = 0

theorem original_density_defect :
    defect (fun v : ℝ => (Real.exp v - 1) * Real.exp (-v / 2)) = 1 - Real.pi / 4
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Transfer operators, Frobenius-Perron operators, and scale-invariance defects in nonlinear dynamics (Lasota-Mackey 1994, Baladi 2000). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves that the exponential growth mode is annihilated by the renewal defect, isolating the exact residual defect of arithmetic backgrounds.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Journal of Mathematical Analysis and Applications*.
