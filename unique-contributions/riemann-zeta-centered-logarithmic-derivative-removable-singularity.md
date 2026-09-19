# Unique Contribution 72: Riemann Zeta Centered Logarithmic Derivative Removable Singularity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/RiemannZetaCenteredLogDeriv.lean`](../../formalization/BuildingBlocks/RiemannZetaCenteredLogDeriv.lean)  
**Classification:** Analytic Number Theory / Complex Analysis / Riemann Zeta Function / Removable Singularities

---

## 1. Executive Summary and Mathematical Statement

The logarithmic derivative $-\frac{\zeta'(s)}{\zeta(s)}$ has a simple pole at $s = 1$ with residue 1 arising from the pole of the Riemann zeta function $\zeta(s) = \frac{1}{s-1} + \gamma + O(s-1)$. In explicit formulas and spectral trace identities, the centered combination:
\[
G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}
\]
is introduced to regularize the singularity at the pole.

This contribution proves:

1. **Entire Normalized Zeta Function:**  
   The normalized function $U(s) = (s-1)\zeta(s)$ with $U(1) = 1$ is entire (complex differentiable everywhere on $\mathbb{C}$):
   \[
   \forall s \in \mathbb{C}, \quad \operatorname{AnalyticAt}_{\mathbb{C}}(U, s).
   \]
2. **Derivative at the Pole:**  
   The complex derivative of $U$ at $s = 1$ evaluates exactly to the Euler–Mascheroni constant:
   \[
   U'(1) = \gamma.
   \]
3. **Removable Singularity and Analytic Extension:**  
   The centered logarithmic derivative $G(s) = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1}$ has a removable singularity at $s = 1$. Its unique continuous and analytic extension $G_{\mathrm{filled}}$ is analytic at $s = 1$:
   \[
   \operatorname{AnalyticAt}_{\mathbb{C}}(G_{\mathrm{filled}}, 1).
   \]
4. **Exact Value at the Pole:**  
   The analytic value of the centered logarithmic derivative at $s = 1$ is:
   \[
   G_{\mathrm{filled}}(1) = -\gamma - 1.
   \]

---

## 2. Mathematical Proof

### 2.1. Analytic Extension of $U(s)$
Near $s = 1$, $\zeta(s) = \frac{1}{s-1} + \gamma + O(s-1)$.
Multiplying by $s - 1$, $U(s) = 1 + \gamma (s-1) + O((s-1)^2)$.
By Complex Removable Singularity theory, defining $U(1) = 1$ yields an entire function $U: \mathbb{C} \to \mathbb{C}$.

### 2.2. Derivative Evaluation
The difference quotient is:
\[
\lim_{s \to 1} \frac{U(s) - U(1)}{s - 1} = \lim_{s \to 1} \left( \zeta(s) - \frac{1}{s-1} \right) = \gamma.
\]
Thus $U'(1) = \gamma$.

### 2.3. Identity with $U$-Logarithmic Derivative
For $s \ne 1$ with $U(s) \ne 0$:
\[
G_{\mathrm{ext}}(s) = -\frac{U'(s)}{U(s)} - 1.
\]
Substituting $U(s) = (s-1)\zeta(s)$ and $U'(s) = \zeta(s) + (s-1)\zeta'(s)$:
\[
-\frac{U'(s)}{U(s)} - 1 = -\frac{\zeta(s) + (s-1)\zeta'(s)}{(s-1)\zeta(s)} - 1 = -\frac{1}{s-1} - \frac{\zeta'(s)}{\zeta(s)} - 1 = -\frac{\zeta'(s)}{\zeta(s)} - \frac{s}{s-1} = G(s).
\]
Hence $G(s) = G_{\mathrm{ext}}(s)$ on a punctured neighborhood of $1$.

### 2.4. Value at the Pole
Evaluating at $s = 1$:
\[
G_{\mathrm{ext}}(1) = -\frac{U'(1)}{U(1)} - 1 = -\frac{\gamma}{1} - 1 = -\gamma - 1.
\]
Since $U(1) = 1 \ne 0$ and $U$ is analytic, $G_{\mathrm{ext}}$ is analytic at $1$, proving that $G_{\mathrm{filled}}$ is analytic at $1$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.RiemannZetaCenteredLogDeriv`):
```lean
theorem differentiable_U : Differentiable ℂ U

theorem hasDerivAt_U_one :
    HasDerivAt U (Real.eulerMascheroniConstant : ℂ) 1

theorem analyticAt_Gfilled_one : AnalyticAt ℂ Gfilled 1

theorem Gfilled_one : Gfilled 1 = -(Real.eulerMascheroniConstant : ℂ) - 1
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** The Laurent expansion $\zeta(s) = \frac{1}{s-1} + \gamma + \dots$ is classical. The formal verification in Lean 4 of the exact removable singularity of the centered expression $G(s) = -\zeta'(s)/\zeta(s) - s/(s-1)$ and its connection to Mathlib's `riemannZeta_residue_one` had not been documented.
- **Advancement:** Machine-verifies analyticity of $G_{\mathrm{filled}}$ at $s = 1$ and exact numerical value $-\gamma - 1$.
- **Target Venues:** *Mathematical Proceedings of the Cambridge Philosophical Society* or *Journal of Number Theory*.
