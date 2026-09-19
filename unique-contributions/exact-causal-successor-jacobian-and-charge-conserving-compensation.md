# Unique Contribution 279: Exact Causal Successor Jacobian and Charge-Conserving Compensation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCharge.lean`](../../formalization/BuildingBlocks/SuccessorCharge.lean), [`building-blocks/measure-theory/successor-charge.md`](../../building-blocks/measure-theory/successor-charge.md)  
**Classification:** Measure Theory / Operator Theory / Causal Semigroups / Transfer Operators / Charge Conservation / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral dilation framework for causal sources, the successor operator transforms an integrable real profile $f \in L^1(0, \infty)$ via the logarithmic dilation $\sigma(v) = \log(1 + e^v)$. Because $\sigma$ maps the positive half-line $(0, \infty)$ strictly onto $(\log 2, \infty)$, the initial interval $(0, \log 2)$ receives no mass, causing a net charge defect between the initial profile and its transformed successor.

This contribution proves:

1. **Exact Causal Successor Charge Conservation Theorem:**  
   For any integrable profile $f \in L^1(0, \infty)$, the compensated successor profile:
   \[
   \mathcal{T}_{\text{comp}} f(v) = \sqrt{\frac{e^v}{1 + e^v}} f(\log(1 + e^v)) - e^{-v/2} \text{defect}(f)
   \]
   unconditionally conserves total charge:
   \[
   \text{charge}(\mathcal{T}_{\text{comp}} f) = \text{charge}(f), \quad \text{where } \text{charge}(g) = \frac{1}{2} \int_0^\infty g(u) du.
   \]
2. **Explicit Formula for Successor Relative Defect:**  
   The relative defect is given by a continuous linear functional:
   \[
   \text{defect}(f) = \frac{1}{2} \int_0^\infty K(u) f(u) du,
   \]
   with the piecewise continuous kernel:
   \[
   K(u) = \begin{cases} -1 & \text{if } u < \log 2, \\ (1 - e^{-u})^{-1/2} - 1 & \text{if } u \ge \log 2. \end{cases}
   \]
3. **Exact Relative Charge Integral Formula:**  
   \[
   \int_0^\infty (\mathcal{T} f)(v) dv - \int_0^\infty f(u) du = \int_0^\infty K(u) f(u) du.
   \]
4. **Uniform Kernel and Weight Bounds:**  
   For all $u > 0$:
   \[
   |K(u)| \le 1,
   \]
   and for $u \ge \log 2$:
   \[
   0 \le (1 - e^{-u})^{-1/2} \le 2.
   \]
   Consequently, the defect functional is bounded on $L^1(0, \infty)$ with operator norm $\|\text{defect}\|_{L^1 \to \mathbb{R}} \le 1/2$.
5. **Exact Normalization of Causal Reference Probe:**  
   The causal reference probe $e^{-v/2}$ is integrable on $(0, \infty)$ with total mass:
   \[
   \int_0^\infty e^{-v/2} dv = 2,
   \]
   ensuring that subtracting $e^{-v/2} \text{defect}(f)$ removes exactly $2 \cdot \text{defect}(f) = \int_0^\infty (\mathcal{T} f - f) du$.

---

## 2. Mathematical Proof

### 2.1. Change of Variables
Let $\sigma(v) = \log(1 + e^v)$. Then $\sigma'(v) = \frac{e^v}{1 + e^v} > 0$.
The map $\sigma$ is an increasing diffeomorphism from $(0, \infty)$ onto $(\log 2, \infty)$.
Under $u = \sigma(v)$:
\[
e^u = 1 + e^v \implies e^v = e^u - 1 \implies 1 - e^{-u} = \frac{e^u - 1}{e^u} = \frac{e^v}{1 + e^v} = \sigma'(v).
\]
Therefore, the successor amplitude satisfies:
\[
\text{amplitude}(v) = \sqrt{\sigma'(v)} = \sqrt{1 - e^{-u}} = \frac{1}{W(u)}, \quad \text{where } W(u) = (1 - e^{-u})^{-1/2}.
\]
Then by the measure-theoretic change of variables:
\[
\int_0^\infty (\mathcal{T} f)(v) dv = \int_0^\infty \text{amplitude}(v) f(\sigma(v)) dv = \int_{\log 2}^\infty \frac{1}{W(u)} f(u) \frac{du}{\sigma'(v)} = \int_{\log 2}^\infty W(u) f(u) du.
\]

### 2.2. Defect Kernel Formulation
We rewrite the transformed integral as an integral over the full half-line $(0, \infty)$:
\[
\int_{\log 2}^\infty W(u) f(u) du = \int_0^\infty \left( \mathbf{1}_{u > \log 2} W(u) \right) f(u) du.
\]
Comparing with $\int_0^\infty f(u) du$:
\[
\int_0^\infty (\mathcal{T} f)(v) dv - \int_0^\infty f(u) du = \int_0^\infty \left( \mathbf{1}_{u > \log 2} W(u) - 1 \right) f(u) du = \int_0^\infty K(u) f(u) du.
\]

### 2.3. Kernel Uniform Bounds
- For $u < \log 2$, $K(u) = -1$, so $|K(u)| = 1 \le 1$.
- For $u \ge \log 2$, $e^{-u} \le 1/2$, so $1/2 \le 1 - e^{-u} < 1$.
  Taking square roots, $1/\sqrt{2} \le \sqrt{1 - e^{-u}} < 1 \implies 1 < W(u) \le \sqrt{2} < 2$.
  Hence $0 < K(u) = W(u) - 1 \le \sqrt{2} - 1 < 1$, so $|K(u)| \le 1$.

### 2.4. Compensation
Integrating the compensated profile:
\[
\int_0^\infty \mathcal{T}_{\text{comp}} f(v) dv = \int_0^\infty (\mathcal{T} f)(v) dv - \text{defect}(f) \int_0^\infty e^{-v/2} dv = \int_0^\infty (\mathcal{T} f)(v) dv - 2 \cdot \text{defect}(f).
\]
Since $2 \cdot \text{defect}(f) = \int_0^\infty (\mathcal{T} f)(v) dv - \int_0^\infty f(u) du$, this equals $\int_0^\infty f(u) du$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge` in `formalization/BuildingBlocks/SuccessorCharge.lean`):
```lean
theorem integral_successor (f : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), successor f v) =
      ∫ u in Ioi (log 2), weight u * f u

theorem kernel_abs_le (u : ℝ) : |kernel u| ≤ 1

theorem integral_successor_sub {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor f v) - (∫ u in Ioi (0 : ℝ), f u) =
      ∫ u in Ioi (0 : ℝ), kernel u * f u

theorem reference_integral : (∫ v in Ioi (0 : ℝ), exp (-v / 2)) = 2

theorem integral_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), compensated f v) = ∫ v in Ioi (0 : ℝ), f v

theorem charge_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    charge (compensated f) = charge f
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Causal semigroup generators and transfer operators on half-lines (Baladi 2000, Sarason 1965). The exact geometric compensation formula preserving $L^1$ charge across the logarithmic shift $\log(1+e^v)$ in Lean 4 is new.
- **Advancement:** Resolves the boundary gap issue on $(0, \log 2)$ by constructing a provably charge-conserving compensated transfer operator with uniform $L^1$ stability.
- **Target Venues:** *Journal of Functional Analysis* or *Ergodic Theory and Dynamical Systems*.
