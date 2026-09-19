# Unique Contribution 210: Exact Complete Core Arrival Operator Regularity and Closed-Interval L² Stability

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PhysicalContinuousArrivalMass.lean`](../../formalization/BuildingBlocks/PhysicalContinuousArrivalMass.lean), [`building-blocks/theta/physical-continuous-arrival-mass.md`](../../building-blocks/theta/physical-continuous-arrival-mass.md)  
**Classification:** Singular Integral Operators / Renewal Processes / Non-Local Boundary Value Problems / Sobolev and $L^p$ Regularity / Riemann Xi Operator Scattering

---

## 1. Executive Summary and Mathematical Statement

In the physical scattering formulation of the Riemann Xi function on a truncated core $[-R, R]$, incoming mass arrives from the exterior via two coupled non-local mechanisms: a continuous singular arrival operator $\mathcal{A}_{\text{cont}}[R, \psi]$ driven by $K(s) = e^{-s/2}/(1 - e^{-2s})$ and a discrete prime arrival operator $\mathcal{A}_{\text{prime}}[R, \psi]$ driven by von Mangoldt Dirac measures. Because the continuous kernel has a $1/s$ singularity at the boundary distance $d = R - |v|$, the resulting arrival field exhibits logarithmic singularities $\sim \log(R \pm v)$ as $v \to \pm R$. Rigorous operator theory requires proving that these boundary logarithmic singularities are square-integrable, establishing $L^2$ stability across the entire closed core $[-R, R]$.

This contribution proves:

1. **Explicit Tail Mass Majorization:**  
   For every separation distance $d > 0$:
   \[
   \int_d^\infty K(s) \, ds \le \frac{3}{2} \text{boundaryLog}(d) + \frac{2}{1 - e^{-2}}.
   \]
2. **Boundary Distance Decomposition:**  
   For any core interior point $|v| < R$:
   \[
   \text{boundaryLog}\left( \frac{R - |v|}{2} \right) \le \text{boundaryLog}(R - v) + \text{boundaryLog}(R + v) + \log 2.
   \]
3. **Core Majorant Bound for Continuous Arrival:**  
   For any bounded wave function $|\psi(w)| \le P$ almost everywhere:
   \[
   \|\mathcal{A}_{\text{cont}}[R, \psi](v)\| \le C_1 \left( \text{boundaryLog}(R - v) + \text{boundaryLog}(R + v) \right) + C_2 = \text{coreMajorant}(v).
   \]
4. **$L^2$ Regularity of Continuous Arrival:**  
   Since $\log^2(R \pm v)$ is integrable on $(-R, R)$:
   \[
   \mathcal{A}_{\text{cont}}[R, \psi] \in L^2((-R, R)) \quad \text{and} \quad \mathcal{A}_{\text{cont}}[R, \psi] \in L^2([-R, R]).
   \]
5. **Unified $L^2$ Stability of the Complete Core Arrival Operator:**  
   The complete arrival operator combining continuous and arithmetic prime influx:
   \[
   \mathcal{A}_{\text{complete}}[R, \psi](v) = \mathcal{A}_{\text{cont}}[R, \psi](v) + \mathcal{A}_{\text{prime}}[R, \psi](v)
   \]
   satisfies:
   \[
   \mathcal{A}_{\text{complete}}[R, \psi] \in L^2([-R, R]) \quad \text{and} \quad \int_{-R}^R |\mathcal{A}_{\text{complete}}[R, \psi](v)|^2 \, dv < \infty.
   \]

---

## 2. Mathematical Proof

### 2.1. Tail Mass Decomposition
Splitting $\int_d^\infty = \int_d^1 + \int_1^\infty$ for $d \le 1$:
The truncated integral is bounded by $-\frac{3}{2}\log d = \frac{3}{2} \text{boundaryLog}(d)$.
The tail integral on $[1, \infty)$ is bounded by $\int_1^\infty \frac{e^{-s/2}}{1 - e^{-2}} ds = \frac{2 e^{-1/2}}{1 - e^{-2}} \le \frac{2}{1 - e^{-2}}$.
For $d > 1$, the integral is directly bounded by $\frac{2}{1 - e^{-2}}$.
This gives the uniform bound $\frac{3}{2} \text{boundaryLog}(d) + \frac{2}{1 - e^{-2}}$ for all $d > 0$.

### 2.2. Core Logarithmic Separation
For $|v| < R$, the distance from $v$ to the exterior $\{|w| > R\}$ is at least $R - |v|$.
Setting $d = (R - |v|)/2 > 0$:
\[
\log(d/2) = \log d - \log 2 \implies \text{boundaryLog}(d/2) \le \text{boundaryLog}(d) + \log 2.
\]
Since $R - |v| = \min(R - v, R + v)$, $\text{boundaryLog}(R - |v|) \le \text{boundaryLog}(R - v) + \text{boundaryLog}(R + v)$.
Combining these gives the two-sided log boundary estimate.

### 2.3. Square Integrability and $L^2$ Core Stability
The function $\text{coreMajorant}(v)^2$ involves linear combinations of terms like $\log^2(R - v)$ and $\log^2(R + v)$.
Near $v = R$, $\int_{R-\epsilon}^R \log^2(R - v) dv = \int_0^\epsilon \log^2(t) dt < \infty$ because $\lim_{t \to 0} t \log^2 t = 0$.
Thus $\text{coreMajorant} \in L^2((-R, R))$.
By majorization, $\mathcal{A}_{\text{cont}}[R, \psi] \in L^2((-R, R))$.
Since the singletons $\{\pm R\}$ have Lebesgue measure zero, the restriction to $(-R, R)$ is isomorphic to the closed interval $[-R, R]$.
Adding the previously established prime arrival regular state $\mathcal{A}_{\text{prime}} \in L^2([-R, R])$ proves that the complete arrival operator $\mathcal{A}_{\text{complete}}[R, \psi]$ is an authentic $L^2$ element on the closed core $[-R, R]$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PhysicalContinuousArrivalMass` in `formalization/BuildingBlocks/PhysicalContinuousArrivalMass.lean`):
```lean
theorem tail_mass_bound {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in Set.Ioi d, kernel s) ≤
      (3 / 2 : ℝ) * boundaryLog d + 2 / (1 - exp (-2))

theorem continuous_arrival_mass_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤
      2 * (P * tailConstant) * ((3 / 2 : ℝ) * boundaryLog ((R - |v|) / 2) +
        2 / (1 - exp (-2)))

theorem continuous_arrival_core_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤ coreMajorant R (2 * (P * tailConstant))
      ((3 / 2 : ℝ) * log 2 + 2 / (1 - exp (-2))) v

theorem continuous_arrival_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Ioo (-R) R))

theorem continuous_arrival_closed_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R))

theorem complete_core_arrival_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (completeCoreArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R))

theorem complete_core_arrival_square_integrable {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    IntegrableOn (fun v => completeCoreArrival R ψ v ^ 2) (Set.Icc (-R) R)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Boundary regularity for non-local operators and singular boundary potentials (Caffarelli-Silvestre 2007, Ros-Oton-Serra 2014). Machine verification of $L^2$ closed-interval stability for hybrid continuous-prime arrival operators in Lean 4 is new.
- **Advancement:** Resolves the logarithmic boundary singularity of the continuous arrival kernel and proves complete $L^2$ regularity of $\mathcal{A}_{\text{complete}}[R, \psi]$ on $[-R, R]$ in Lean 4.
- **Target Venues:** *Communications in Partial Differential Equations* or *Journal of Functional Analysis*.
