# Contribution 111: Exact Successor Transfer Defect of Growing and Original Charge Densities

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeDensityEvaluation.lean`](../../formalization/BuildingBlocks/ChargeDensityEvaluation.lean), [`formalization/BuildingBlocks/ChargeOriginalBirth.lean`](../../formalization/BuildingBlocks/ChargeOriginalBirth.lean), [`formalization/BuildingBlocks/SuccessorCharge.lean`](../../formalization/BuildingBlocks/SuccessorCharge.lean)  
**Classification:** Transfer Operators / Half-Line Scattering / Successor Charge Defects / Causal Relative Densities / Exact Geometric Constants

---

## 1. Executive Summary and Mathematical Statement

In the spectral analysis of arithmetic transfer operators on the logarithmic half-line $v \in (0, \infty)$, the successor transfer operator $\mathcal{S}$ and its charge defect functional $\text{defect}(f)$ measure the obstruction to invariance under the discrete successor shift $\sigma(v) = \log(1 + e^v)$ with amplitude weight $\sqrt{\frac{1 + e^v}{e^v}}$ and Jacobian $e^v / (1 + e^v)$.

This contribution proves:

1. **Exact Successor Action on Logarithmic Cutoffs:**  
   For $R \ge 2$, under the cutoff family $f_R(v) = \mathbf{1}_{v \le \log R} e^{v/2}$, the successor operator acts as a pure downward parameter shift:
   $$
   \mathcal{S}(f_R) = f_{R-1}.
   $$
2. **Exact Asymptotic Defect Vanishing for Growing Modes:**  
   The finite-cutoff defect is given exactly by:
   $$
   \text{defect}(f_R) = \sqrt{R - 1} - \sqrt{R} = -\frac{1}{\sqrt{R-1} + \sqrt{R}}.
   $$
   As $R \to \infty$, dominated convergence confirms that the growing mode $v \mapsto e^{v/2}$ has zero defect:
   $$
   \text{defect}\left( v \mapsto e^{v/2} \right) = 0.
   $$
3. **Exact Defect Evaluation for the Causal Reference Mode:**  
   The decaying exponential reference mode $v \mapsto e^{-v/2}$ satisfies:
   $$
   \text{defect}\left( v \mapsto e^{-v/2} \right) = \frac{\pi}{4} - 1.
   $$
4. **Exact Closed Geometric Defect for the Natural Prime Density:**  
   The natural relative density $\rho_{\text{orig}}(v) = (e^v - 1) e^{-v/2} = e^{v/2} - e^{-v/2}$ on the causal half-line has the exact positive geometric defect:
   $$
   \text{defect}\left( (e^v - 1) e^{-v/2} \right) = 1 - \frac{\pi}{4} \approx 0.2146018\dots > 0.
   $$
   The growing mode $e^{v/2}$ contributes identically zero to the defect, leaving the defect entirely determined by the negative reflection of the reference mode.

---

## 2. Mathematical Proof

### 2.1. Cutoff Mass and Shift
For $R \ge 1$, the integral of $f_R(v) = \mathbf{1}_{(0, \log R]}(v) e^{v/2}$ is:
$$
\int_0^{\log R} e^{v/2} \, dv = \left[ 2 e^{v/2} \right]_0^{\log R} = 2 (\sqrt{R} - 1).
$$
Under the successor operator:
$$
\mathcal{S}(f_R)(v) = \sqrt{\frac{1 + e^v}{e^v}} \frac{e^v}{1 + e^v} f_R(\log(1 + e^v)) = \frac{\sqrt{e^v}}{\sqrt{1 + e^v}} \mathbf{1}_{\log(1 + e^v) \le \log R} \sqrt{1 + e^v} = e^{v/2} \mathbf{1}_{v \le \log(R - 1)} = f_{R-1}(v).
$$
Therefore, the defect is:
$$
\text{defect}(f_R) = \frac{1}{2} \int_0^\infty (f_{R-1}(v) - f_R(v)) \, dv = (\sqrt{R - 1} - 1) - (\sqrt{R} - 1) = \sqrt{R - 1} - \sqrt{R}.
$$

### 2.2. Limit as $R \to \infty$
Since $\sqrt{R - 1} - \sqrt{R} = \frac{-1}{\sqrt{R-1} + \sqrt{R}} \to 0$ as $R \to \infty$, and the integrands are dominated by $2 e^{-v/2}$, dominated convergence yields:
$$
\text{defect}\left( v \mapsto e^{v/2} \right) = \lim_{R \to \infty} \text{defect}(f_R) = 0.
$$

### 2.3. Original Density Defect
Expanding the natural relative density:
$$
(e^v - 1) e^{-v/2} = e^{v/2} - e^{-v/2}.
$$
By linearity of the defect functional:
$$
\text{defect}\Big( (e^v - 1) e^{-v/2} \Big) = \text{defect}\left( e^{v/2} \right) - \text{defect}\left( e^{-v/2} \right) = 0 - \left(\frac{\pi}{4} - 1\right) = 1 - \frac{\pi}{4}.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeDensityEvaluation`):
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

- **Prior Literature:** Transfer operators on half-lines and thermodynamic formalisms (Ruelle 1978, Baladi 2000). The specific successor shift $\sigma(v) = \log(1 + e^v)$ with amplitude/Jacobian weights arising from arithmetic prime birth models and the exact closed evaluation $\text{defect}((e^v - 1)e^{-v/2}) = 1 - \pi/4$ are novel.
- **Advancement:** Establishes machine-verified defect vanishing for growing exponential modes and exact closed evaluation of the natural relative density defect.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Communications in Mathematical Physics*.
