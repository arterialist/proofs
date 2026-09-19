# Unique Contribution 66: Causal Successor Jacobian Defect Kernel and Charge-Conserving Compensation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SuccessorCharge.lean`](../../formalization/BuildingBlocks/SuccessorCharge.lean)  
**Classification:** Ergodic Theory / Transfer Operators / Measure-Preserving Semigroups / Functional Analysis

---

## 1. Executive Summary and Mathematical Statement

In non-commutative geometry and transfer operator models of the Riemann zeta function, shift or successor operators on the half-line $\mathbb{R}_{>0}$ represent multiplicative shifts $x \mapsto x+1$ in logarithmic coordinates $v \mapsto \sigma(v) = \log(1 + e^v)$. Because the mapping $\sigma$ compresses the half-line $(0, \infty)$ onto $(\log 2, \infty)$, the standard successor operator fails to conserve the total integrated charge $\int_0^\infty f(u) \, du$.

This contribution proves:

1. **Exact Successor Transfer Operator with Amplitude Weight:**  
   Under the logarithmic successor diffeomorphism $\sigma(v) = \log(1 + e^v)$ with Jacobian $J(v) = \frac{e^v}{1 + e^v}$ and amplitude $A(v) = \sqrt{J(v)}$, the successor operator is defined by:
   \[
   (T f)(v) = A(v) f(\sigma(v)) = \sqrt{\frac{e^v}{1 + e^v}} f(\log(1 + e^v)).
   \]
2. **Pull-Back Integral Transformation and Weight Singularities:**  
   Using the change of variables formula, for any integrable source $f \in L^1(0, \infty)$:
   \[
   \int_0^\infty (T f)(v) \, dv = \int_{\log 2}^\infty w(u) f(u) \, du, \quad \text{where } w(u) = \frac{1}{\sqrt{1 - e^{-u}}}.
   \]
3. **Exact Defect Kernel and Uniform Boundedness:**  
   The difference between the successor integral and the original integral is given by:
   \[
   \int_0^\infty (T f)(v) \, dv - \int_0^\infty f(u) \, du = \int_0^\infty K(u) f(u) \, du,
   \]
   where the exact defect kernel $K(u)$ is:
   \[
   K(u) = \begin{cases} -1 & u < \log 2 \\ \frac{1}{\sqrt{1 - e^{-u}}} - 1 & u \ge \log 2. \end{cases}
   \]
   The kernel is uniformly bounded: $|K(u)| \le 1$ for all $u > 0$.
4. **Exact Charge-Conserving Compensated Operator:**  
   Define the relative charge defect $\operatorname{defect}(f) = \frac{1}{2} \int_0^\infty K(u) f(u) \, du$. The compensated operator:
   \[
   (\widetilde{T} f)(v) = (T f)(v) - e^{-v/2} \operatorname{defect}(f)
   \]
   satisfies exact charge conservation:
   \[
   \int_0^\infty (\widetilde{T} f)(v) \, dv = \int_0^\infty f(u) \, du, \quad \text{and} \quad \operatorname{charge}(\widetilde{T} f) = \operatorname{charge}(f).
   \]
   The reference profile $e^{-v/2}$ with $\int_0^\infty e^{-v/2} \, dv = 2$ absorbs the missing charge from the discarded initial interval $(0, \log 2)$ while preserving integrability $\widetilde{T} f \in L^1(0, \infty)$.

---

## 2. Mathematical Proof

### 2.1. Diffeomorphism and Image
For $v > 0$, $e^v > 1$, so $1 + e^v > 2$ and $\sigma(v) = \log(1 + e^v) > \log 2$.
$\sigma$ is smooth and strictly increasing with $\sigma'(v) = \frac{e^v}{1 + e^v} = J(v) > 0$.
The inverse map on $(\log 2, \infty)$ is $\sigma^{-1}(u) = \log(e^u - 1)$.
The change-of-variables formula gives:
\[
\int_0^\infty A(v) f(\sigma(v)) \, dv = \int_{\log 2}^\infty A(\sigma^{-1}(u)) f(u) \frac{du}{J(\sigma^{-1}(u))}.
\]
Notice that $A(v)/J(v) = 1/\sqrt{J(v)}$.
For $u = \sigma(v)$, $J(v) = \frac{e^v}{1 + e^v} = 1 - \frac{1}{1 + e^v} = 1 - e^{-u}$.
Therefore $1/\sqrt{J(v)} = 1/\sqrt{1 - e^{-u}} = w(u)$.

### 2.2. Defect Kernel
Decomposing the domain $(0, \infty) = (0, \log 2) \cup [\log 2, \infty)$:
\[
\int_{\log 2}^\infty w(u) f(u) \, du - \int_0^\infty f(u) \, du = -\int_0^{\log 2} f(u) \, du + \int_{\log 2}^\infty (w(u) - 1) f(u) \, du.
\]
This precisely matches $\int_0^\infty K(u) f(u) \, du$.
For $u \ge \log 2$, $e^{-u} \le 1/2$, so $1/2 \le 1 - e^{-u} \le 1$.
Thus $1 \le w(u) \le \sqrt{2}$, implying $0 \le w(u) - 1 \le \sqrt{2} - 1 < 1$.
On $u < \log 2$, $K(u) = -1$. Hence $|K(u)| \le 1$ everywhere.

### 2.3. Compensation
Since $\int_0^\infty e^{-v/2} \, dv = [-2 e^{-v/2}]_0^\infty = 2$:
\[
\int_0^\infty \widetilde{T} f(v) \, dv = \int_0^\infty T f(v) \, dv - 2 \left( \frac{1}{2} \int_0^\infty K(u) f(u) \, du \right) = \int_0^\infty f(u) \, du.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SuccessorCharge`):
```lean
theorem integral_successor_sub {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor f v) - (∫ u in Ioi (0 : ℝ), f u) =
      ∫ u in Ioi (0 : ℝ), kernel u * f u

theorem kernel_abs_le (u : ℝ) : |kernel u| ≤ 1

theorem integrable_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    IntegrableOn (compensated f) (Ioi (0 : ℝ))

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

- **Prior Literature:** Transfer operators of logarithmic shifts appear in Mayer's thermodynamic formalism of the Gauss map and related transfer semigroups. A rigorous construction of a charge-compensated causal successor operator preserving $L^1$ charge with exact kernel bounds had not been formalized in Lean 4.
- **Advancement:** Establishes the exact defect kernel $K(u)$ and constructs the explicit rank-one projection compensating the discarded interval $(0, \log 2)$ with verified $L^1$ preservation.
- **Target Venues:** *Ergodic Theory and Dynamical Systems* or *Journal of Operator Theory*.
